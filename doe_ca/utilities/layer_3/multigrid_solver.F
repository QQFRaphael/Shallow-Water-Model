      MODULE multigrid_solver_xxx

! 27 AUGUST 2000
! 07 FEB 2003:  changed code (fulton) to solve Helmholtz problem
!               (see details in calling routine elliptic_solver)

      USE kinds
      USE abort
      USE params_physical
      USE params_grid_horizontal_xxx
      USE component_intra
      USE params_parallel_xxx
      USE assign_owner
      USE gather_scatter
      USE wrap_data
      USE grid_metrics_generator
      USE timer

      IMPLICIT NONE
      SAVE

      PRIVATE

#if mpi == 1
        include 'mpif.h'
#endif

      TYPE mgdn_type
         INTEGER (KIND=int_kind) :: length
         INTEGER (KIND=int_kind), POINTER :: mgdn(:,:)
      END TYPE mgdn_type
      TYPE mgup_type
         INTEGER (KIND=int_kind) :: length
         INTEGER (KIND=int_kind), POINTER :: mgup(:,:,:)
      END TYPE mgup_type

      TYPE (mgdn_type) :: mgdn(max_level)
      TYPE (mgup_type) :: mgup(max_level)

      TYPE lap_w_type
         REAL (KIND=dbl_kind), POINTER :: lap_w(:,:,:,:)
      END TYPE lap_w_type

      TYPE (lap_w_type) ::  lap_w(max_level)
      
      CHARACTER (len=char_len) :: comp_mg(max_level)
      INTEGER (kind=int_kind), dimension(max_level) :: isdm_level, jsdm_level

      integer (kind=int_kind), parameter :: min_level=1

!-----------------------------------------------------------------------
! public variable to supply parameter for Helmholtz problem (0 for Poisson)
! (should be in argument list but this would change a lot of things...)
      REAL (kind=dbl_kind) :: helm_const_mg = 0.0_dbl_kind
!-----------------------------------------------------------------------

      PUBLIC :: initialize_multigrid, multigrid, helm_const_mg

      CONTAINS
!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
      SUBROUTINE initialize_multigrid (component_name)
! 27 AUGUST 2000
      IMPLICIT NONE
      
      character(len=*), intent(in) :: component_name
      TYPE sbdmn_type
         INTEGER (KIND=int_kind) :: im_t,jm_t
         INTEGER (KIND=int_kind), POINTER :: sd(:,:)
      END TYPE sbdmn_type
     
      INTEGER (KIND=int_kind) :: level,im_t(max_level),jm_t(max_level),      &
                     im5_t(max_level),iim_t(max_level),jjm_t(max_level),     &
                     nsbdm_t(max_level)
      TYPE (sbdmn_type) :: sbdmn(max_level)

      INTEGER (KIND=int_kind) :: count,panel,isd,jsd,i,j,sd_ratio,o2,o1,     &
                      isd2,jsd2,i2,j2,sd2,sd2_owner,i1,j1,sd1,sd1_owner,     &
                      msg_tag,nsdm1_t,nsdm2_t,nsd1,nsd2,                     &
                      mpi_int_type, mpi_float_type, my_communicator,         &
                      max_ig_t

      INTEGER (KIND=int_kind), ALLOCATABLE :: count_mgup(:)
      TYPE (component_node),POINTER :: & 
         Current,       &   ! pointer to component_node for level
         coarser           ! pointer to component_node for level-1
      
      character(len=1) :: clev
      character(len=char_len) :: char_tem

! get some common component_node values from the max_level component_node which has already
!  been initialized
      current => get_component_pointer(component_name) 
      mpi_float_type  = current%mpi_float_type
      mpi_int_type    = current%mpi_int_type
      my_communicator = current%mpi_communicator
      DO level = min_level,max_level
         IF (l_grid_even) THEN
            im_t(level) = 5*(2+2*2*2**(level-1)) 
            jm_t(level) =   (2+  2*2**(level-1)) 
            max_ig_t = 2 + 10*((2*2**(level-1))**2)
         ELSE
            im_t(level) = 5*(2+2*3*2**(level-1))
            jm_t(level) =   (2+  3*2**(level-1)) 
            max_ig_t = 2 + 10*((3*2**(level-1))**2)
         ENDIF
         im5_t(level) = im_t(level)/5
         
! build component_node for levels less than max_level
         do i = 1,char_len
            char_tem(i:i) = ' '
         enddo
         if(level < max_level) then
            comp_mg(level) = char_tem
            if(level < 10) then
               write(unit=clev,fmt='(i1)')level
            else
               call abort_code('multigrid can handle max_level-extend clev')
            endif
            comp_mg(level) = trim(component_name//clev)
            call initialize_component( comp_mg(level) )
            call set_component_horizontal (comp_mg(level),         &
               level,even_odd_factor,                                &
               max_ig_t,im_t(level),jm_t(level))
            call set_component_parallel (comp_mg(level),           &
               npe,my_task,mpi_int_type,mpi_float_type,my_communicator)

! initialize  assign_owner and wrap for levels less than max_level
            call set_assign_owner(                                   &
                         isdm,            jsdm,                      &
                         max_level,       level,                     &
                         partition_factor,trim(comp_mg(level)),      &
                         './sbdmn_assign' )

            call initialize_wrap(comp_mg(level))
            
         else
         
! this is max_level and was already done
            comp_mg(level) = char_tem
            comp_mg(level) = component_name
         endif
         
         current => get_component_pointer(trim(comp_mg(level))) 
         isdm_level(level) = current%isdm        
         jsdm_level(level) = current%jsdm        
         iim_t(level) = 2+(im5_t(level)-2)/isdm_level(level)
         jjm_t(level) = 2+( jm_t(level)-2)/jsdm_level(level)
         nsbdm_t(level) = 5*isdm_level(level)*jsdm_level(level)
       ENDDO

       DO level = min_level,max_level

         ALLOCATE (sbdmn(level)%sd(im_t(level),jm_t(level)))
         sbdmn(level)%im_t = im_t(level)
         sbdmn(level)%jm_t = jm_t(level)
         sbdmn(level)%sd(:,:) = 0
         count = 0
         DO panel = 0,4
            DO jsd = 0,jsdm_level(level)-1
               DO isd = 0,isdm_level(level)-1
                  count = count + 1
                  DO j = 2,jjm_t(level)-1
                     DO i = 2,iim_t(level)-1
                        sbdmn(level)%sd(im5_t(level)*panel+                  &
                                         (iim_t(level)-2)*isd+i,             &
                                         (jjm_t(level)-2)*jsd+j) = count
                     ENDDO
                  ENDDO
               ENDDO
            ENDDO
         ENDDO
      ENDDO

      msg_tag = 0
      DO level = min_level+1,max_level
         current => get_component_pointer(trim(comp_mg(level))) 
         sd_ratio = nsbdm_t(level)/nsbdm_t(level-1)
         coarser => get_component_pointer(trim(comp_mg(level-1)) ) 

         ALLOCATE (mgup(level-1)%mgup(9,sd_ratio,nsbdm_t(level-1)))
         mgup(level-1)%length = nsbdm_t(level-1)
         mgup(level-1)%mgup(:,:,:) = 0

         ALLOCATE (mgdn(level  )%mgdn(9,        nsbdm_t(level  )))
         mgdn(level  )%length = nsbdm_t(level  )
         mgdn(level  )%mgdn(:,:)   = 0

         ALLOCATE (count_mgup(nsbdm_t(level-1)))
         count_mgup(:) = 0

         DO panel = 0,4
            o2   = im5_t(level  )*panel
            o1   = im5_t(level-1)*panel

            DO jsd2 = 0,jsdm_level(level)-1
               DO isd2 = 0,isdm_level(level)-1
                  i2 = (iim_t(level)-2)*isd2+3
                  j2 = (jjm_t(level)-2)*jsd2+3
                  sd2 = sbdmn(level  )%sd(o2+i2,j2)

                  i1 = (i2+1)/2
                  j1 = (j2+1)/2
                  sd1 = sbdmn(level-1)%sd(o1+i1,j1)

                  count_mgup(sd1) = count_mgup(sd1)+1

                  mgup(level-1)%mgup(1,count_mgup(sd1),sd1) = sd1
                  mgup(level-1)%mgup(2,count_mgup(sd1),sd1) = sd2
                  mgdn(level  )%mgdn(1,                sd2) = sd1
                  mgdn(level  )%mgdn(2,                sd2) = sd2

                  sd1_owner = coarser%sbdmn_owner%owner(sd1)
                  sd2_owner = current%sbdmn_owner%owner(sd2)
                  IF (sd1_owner.EQ.sd2_owner) THEN
                     mgup(level-1)%mgup(3,count_mgup(sd1),sd1) = 0
                     mgdn(level  )%mgdn(3,                sd2) = 0
                  ELSE
                     msg_tag = msg_tag+1
                     mgup(level-1)%mgup(3,count_mgup(sd1),sd1) = msg_tag
                     mgdn(level  )%mgdn(3,                sd2) = msg_tag
                  ENDIF

                  mgup(level-1)%mgup(4,count_mgup(sd1),sd1) =                &
                      MOD (MOD (i1,im5_t(level-1))-2,iim_t(level-1)-2)+2
                  mgup(level-1)%mgup(5,count_mgup(sd1),sd1) =                &
                                           MOD (j1-2,jjm_t(level-1)-2)+2
                  mgdn(level  )%mgdn(4,                sd2) =                &
                      MOD (MOD (i1,im5_t(level-1))-2,iim_t(level-1)-2)+2
                  mgdn(level  )%mgdn(5,                sd2) =                &
                                           MOD (j1-2,jjm_t(level-1)-2)+2

                  nsdm1_t = coarser%sbdmn_assign%length(sd1_owner+1)
                  DO nsd1 = 1,nsdm1_t
                     IF (sd1.EQ.                                             &
                        coarser%sbdmn_assign%sd(sd1_owner+1,nsd1)) THEN
                        mgup(level-1)%mgup(6,count_mgup(sd1),sd1) = nsd1
                        mgdn(level  )%mgdn(6,                sd2) = nsd1
                     ENDIF
                  ENDDO

                  mgup(level-1)%mgup(7,count_mgup(sd1),sd1) = 3
                  mgup(level-1)%mgup(8,count_mgup(sd1),sd1) = 3
                  mgdn(level  )%mgdn(7,                sd2) = 3
                  mgdn(level  )%mgdn(8,                sd2) = 3
                  nsdm2_t = current%sbdmn_assign%length(sd2_owner+1)
                  DO nsd2 = 1,nsdm2_t
                     IF (sd2.EQ.                                             &
                        current%sbdmn_assign%sd(sd2_owner+1,nsd2)) THEN
                        mgup(level-1)%mgup(9,count_mgup(sd1),sd1) = nsd2
                        mgdn(level  )%mgdn(9,                sd2) = nsd2
                     ENDIF
                  ENDDO

               ENDDO
            ENDDO
         ENDDO
         DEALLOCATE (count_mgup)
      ENDDO

      DO level = min_level,max_level
         DEALLOCATE (sbdmn(level)%sd)
      ENDDO

!      CALL output_mgup_mgdn ()

!tdrmod
	call initialize_multigrid_metrics
!endtdrmod

      END SUBROUTINE initialize_multigrid
!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
      SUBROUTINE initialize_multigrid_metrics ()
! 17 JULY 2002

      INTEGER (KIND=int_kind) ::                                             &
         level,ispace,i,j,panel,o0,o1,ksdm,                                  &
         im_t(max_level),jm_t(max_level),im5_t(max_level),max_ig_t(max_level), &
         iim(max_level),jjm(max_level),nsdm(max_level)

      INTEGER (KIND=int_kind) ::                                             &
         iim_t,jjm_t,nsdm_t

      REAL (KIND=dbl_kind), ALLOCATABLE ::                                   &
         p_list(:,:),                                                        &
         tmp_glbl(:,:,:),p_glbl(:,:,:),p(:,:,:,:),work(:,:,:,:)

      REAL (KIND=dbl_kind),ALLOCATABLE ::                                    &
         c(:,:,:,:,:),w(:,:,:,:,:,:),                                        &
         area(:,:,:),area_inv(:,:,:),                                        &
         corner_area(:,:,:,:),corner_area_inv(:,:,:,:),                      &
         sub_area(:,:,:,:,:),sub_area_inv(:,:,:,:,:),                        &
         dc(:,:,:,:,:),normal(:,:,:,:,:,:),tangent(:,:,:,:,:,:),             &
         v_weights(:,:,:,:,:,:),s_weights(:,:,:,:,:),l_weights(:,:,:,:),     &
         trans_to_X2(:,:,:,:,:,:),trans_to_X1(:,:,:,:,:,:),                  &
         grid_center_lon(:,:,:),grid_center_lat(:,:,:),                      &
         grid_corner_lon(:,:,:,:),grid_corner_lat(:,:,:,:),                  &
         grid_center_centroid(:,:,:,:),grid_corner_centroid(:,:,:,:,:)             

      REAL (kind=dbl_kind) ::                                                &
         tot_area,inv_tot_area,f01

      TYPE (component_node),POINTER :: & 
         Current            ! pointer to component_node for level

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! compute im, jm, max_ig, iim, jjm and nsdm for each grid resolution
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      DO level = min_level,max_level
         IF (l_grid_even) THEN
            im_t(level) = 5*(2*npad+2*2*2**(level-1))
            jm_t(level) =   (2*npad+  2*2**(level-1))
         ELSE
            im_t(level) = 5*(2*npad+2*3*2**(level-1))
            jm_t(level) =   (2*npad+  3*2**(level-1)) 
         ENDIF
            im5_t(level) = im_t(level)/5
         max_ig_t(level) = 2+10*(jm_t(level)-2*npad)**2
            iim(level) = (im_t(level)/5-2*npad)/isdm_level(level) + 2*npad
            jjm(level) = (jm_t(level)  -2*npad)/jsdm_level(level) + 2*npad
            current => get_component_pointer(trim(comp_mg(level))) 
            nsdm(level) = current%sbdmn_assign%length(my_task+1)
      ENDDO

      ALLOCATE (                                                             &
         p_list(3,max_ig_t(max_level)),                                      &
         p_glbl(3,im_t(max_level),jm_t(max_level)))
      p_list(:, : ) = 0.0_dbl_kind
      p_glbl(:,:,:) = 0.0_dbl_kind

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! read cell centers (p_list) on finest grid resolution 
! and scatter to (im,jm) data structure which is called p_glbl
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      p_list = 0.0_dbl_kind
      CALL read_grid_center_fine (trim(comp_mg(max_level)), max_ig, p_list)
      DO ispace = 1,3
         call scatter_to_grid_global(trim(comp_mg(max_level)),  im, jm, max_ig,  &
                                     p_list(ispace,:),p_glbl(ispace,:,:))
      ENDDO

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! loop over all grid resolutions
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      DO level = max_level,min_level,-1
         iim_t = iim(level); jjm_t = jjm(level); nsdm_t = nsdm(level)

         ALLOCATE (p(3,iim_t,jjm_t,nsdm_t),work(iim_t,jjm_t,1,nsdm_t))
         p(:,:,:,:) = 0.0_dbl_kind; work(:,:,:,:) = 0.0_dbl_kind

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! scatter p_glbl across all processes to (iim,jjm,nsdm) data structure p
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         DO ispace = 1,3
            CALL scatter (trim(comp_mg(level)),                              &
                          im_t(level), jm_t(level), iim_t, jjm_t, 1, nsdm(level),&
                          p_glbl(ispace,:,:),p(ispace,:,:,:))
         ENDDO

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! wrap p
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         DO ispace = 1,3
            work(:,:,1,:) = p(ispace,:,:,:)
            CALL wrap (trim(comp_mg(level)),face=work(:,:,:,:))
            p(ispace,:,:,:) = work(:,:,1,:)
         ENDDO

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! allocate all work arrays
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         ALLOCATE (                                                          &
            c              (          r3,ncorners,iim_t,jjm_t,nsdm_t),       &
            w              (ndata,    r3,ncorners,iim_t,jjm_t,nsdm_t),       &
            area           (                      iim_t,jjm_t,nsdm_t),       &
            area_inv       (                      iim_t,jjm_t,nsdm_t),       &
            corner_area    (             ncorners,iim_t,jjm_t,nsdm_t),       &
            corner_area_inv(             ncorners,iim_t,jjm_t,nsdm_t),       &
            sub_area       (ndata,       ncorners,iim_t,jjm_t,nsdm_t),       &
            sub_area_inv   (ndata,       ncorners,iim_t,jjm_t,nsdm_t),       &
            dc             (ndata,       ncorners,iim_t,jjm_t,nsdm_t),       &
            normal         (ndata,    r3,ncorners,iim_t,jjm_t,nsdm_t),       &
            tangent        (ndata,    r3,ncorners,iim_t,jjm_t,nsdm_t),       &
            v_weights      (ndata,nspace,ncorners,iim_t,jjm_t,nsdm_t),       &
            s_weights      (ndata,       ncorners,iim_t,jjm_t,nsdm_t),       &
            l_weights      (   nweights,          iim_t,jjm_t,nsdm_t),       &
            trans_to_X2    (r3,r3,       ncorners,iim_t,jjm_t,nsdm_t),       &
            trans_to_X1    (r3,r3,       ncorners,iim_t,jjm_t,nsdm_t),       &
            grid_center_lon(                      iim_t,jjm_t,nsdm_t),       &
            grid_center_lat(                      iim_t,jjm_t,nsdm_t),       &
            grid_corner_lon(             ncorners,iim_t,jjm_t,nsdm_t),       &
            grid_corner_lat(             ncorners,iim_t,jjm_t,nsdm_t),       &
            grid_center_centroid(r3,              iim_t,jjm_t,nsdm_t),       &
            grid_corner_centroid(r3,     ncorners,iim_t,jjm_t,nsdm_t))     

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! compute laplacian weights
! NOTE: l_sphere (the second argument in the list) is hardwired to true
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         CALL generate_grid_metrics_level (trim(comp_mg(level)), .false.,   &
                            r2,r3,ndata,nspace,ncorners,nweights,            &
                            level,im_t(level),jm_t(level),max_ig_t(level),   &
                            iim(level),jjm(level),nsdm(level),               &
                            p,c,w,                                           &
                                   area,       area_inv,                     &
                            corner_area,corner_area_inv,                     &
                               sub_area,   sub_area_inv,                     &
                            dc,normal,tangent,                               &
                            v_weights,s_weights,l_weights,                   &
                            trans_to_X2,trans_to_X1,                         &
                            grid_center_lon,grid_center_lat,                 &
                            grid_corner_lon,grid_corner_lat,                 &
                            tot_area,inv_tot_area,f01,                       &
                            grid_center_centroid,grid_corner_centroid)
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! make sure that laplacian weights are well behaved
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         DO ksdm = 1,nsdm_t
            IF (l_weights(7,npad,jjm_t-npad,ksdm)==0.0) THEN
               l_weights(7,npad,jjm_t-npad,ksdm)=1.0_dbl_kind
            ENDIF
            IF (l_weights(7,iim_t-npad,npad,ksdm)==0.0) THEN
               l_weights(7,iim_t-npad,npad,ksdm)=1.0_dbl_kind
            ENDIF
         ENDDO
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! copy laplacian weights
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         ALLOCATE (lap_w(level)%lap_w(nweights,iim_t,jjm_t,nsdm_t))
         lap_w(level)%lap_w(:,:,:,:) = l_weights(:,:,:,:)
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! if not the coarsest resolution, select the subset of cell centers 
! which comprise the next coarser resolution
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         IF (level > min_level) THEN
            ALLOCATE (tmp_glbl(3,im_t(level-1),jm_t(level-1)))
            tmp_glbl(:,:,:) = 0.0_dbl_kind
            DO panel = 0,4
               o0 = im5_t(level-1)*panel
               o1 = im5_t(level  )*panel
               DO j = npad+1,jm_t(level-1)-npad
                  DO i = npad+1,im5_t(level-1)-npad
                     tmp_glbl(:,o0+   i           ,   j           ) =        &
                       p_glbl(:,o1+2*(i-npad)+npad,2*(j-npad)+npad)
                  ENDDO
               ENDDO
            ENDDO
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! tdr: fill North and South Pole
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            tmp_glbl(:,1,jm_t(level-1)-1) = p_glbl(:,1,jm_t(level)-1)
            tmp_glbl(:,im_t(level-1)-1,1) = p_glbl(:,im_t(level)-1,1)

            DEALLOCATE (p_glbl)
            ALLOCATE (p_glbl(3,im_t(level-1),jm_t(level-1)))

            p_glbl(:,:,:) = tmp_glbl(:,:,:)

            DEALLOCATE (tmp_glbl)
         ENDIF

         DEALLOCATE (                                                        &
            p,work,c,w,area,area_inv,corner_area,corner_area_inv,            &
            sub_area,sub_area_inv,dc,normal,tangent,                         &
            v_weights,s_weights,l_weights,                                   &
            trans_to_X2,trans_to_X1,                                         &
            grid_center_lon,grid_center_lat,                                 &
            grid_corner_lon,grid_corner_lat,                                 &
            grid_center_centroid,grid_corner_centroid)  
       
      ENDDO
     
      DEALLOCATE (p_list,p_glbl)

      END SUBROUTINE initialize_multigrid_metrics
!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
      SUBROUTINE multigrid (nvar,beta,alpha)
! 28 AUGUST 2000
      IMPLICIT NONE

      TYPE work_type
         REAL (KIND=dbl_kind), POINTER :: work(:,:,:,:)
      END TYPE work_type

      INTEGER (KIND=int_kind), intent(in) :: nvar
      INTEGER (KIND=int_kind),PARAMETER :: level_bottom = min_level
      INTEGER (KIND=int_kind) :: level,im_t(max_level),jm_t(max_level),      &
                        iim_t(max_level),jjm_t(max_level),nsdm_t,            &
                        iim1_t,jjm1_t,nsdm1_t,iim2_t,jjm2_t,nsdm2_t,ierr

      REAL (KIND=dbl_kind), intent(in) ::                                    &
                        beta(iim,jjm,nvar,nsdm)
      REAL (KIND=dbl_kind), intent(inout) ::                                 &
                        alpha(iim,jjm,nvar,nsdm)

      TYPE (work_type) :: alpha_work(max_level),beta_work(max_level)
      TYPE (component_node),POINTER :: & 
         Current            ! pointer to component_node for level
         
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  prepare to do multigrid
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      DO level = min_level,max_level
         IF (l_grid_even) THEN
            im_t(level) = 5*(2+2*2*2**(level-1)) 
            jm_t(level) =   (2+  2*2**(level-1)) 
         ELSE
            im_t(level) = 5*(2+2*3*2**(level-1))
            jm_t(level) =   (2+  3*2**(level-1)) 
         ENDIF
          iim_t(level) = 2+((im_t(level)/5)-2)/isdm_level(level)
          jjm_t(level) = 2+( jm_t(level)   -2)/jsdm_level(level)
      ENDDO
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  allocate work arrays
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      DO level = min_level,max_level
         current => get_component_pointer(trim(comp_mg(level))) 
         nsdm_t = current%sbdmn_assign%length(my_task+1)

         ALLOCATE (alpha_work(level)%                                        &
                            work(iim_t(level),jjm_t(level),nvar,nsdm_t))
         alpha_work(level)%work(:,:,:,:) = 0.0

         ALLOCATE (beta_work(level)%                                         &
                            work(iim_t(level),jjm_t(level),nvar,nsdm_t))
         beta_work(level)%work(:,:,:,:) = 0.0
      ENDDO
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  copy input to work arrays
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      alpha_work(max_level)%work(:,:,:,:) = alpha(:,:,:,:)
       beta_work(max_level)%work(:,:,:,:) =  beta(:,:,:,:)
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  down the V-cycle
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      DO level = max_level,level_bottom+1,-1
          iim2_t = iim_t(level  )
          jjm2_t = jjm_t(level  )
         nsdm2_t = current%sbdmn_assign%length(my_task+1)
          iim1_t = iim_t(level-1)
          jjm1_t = jjm_t(level-1)
         current => get_component_pointer(trim(comp_mg(level-1))) 
         nsdm1_t = current%sbdmn_assign%length(my_task+1)

         CALL relax (2,level,iim2_t,jjm2_t,nvar,nsdm2_t,                     &
                           lap_w(level)%lap_w,                               &
                           beta_work(level)%work,alpha_work(level)%work)
         CALL inject_residual (level,nvar,iim1_t,jjm1_t,nsdm1_t,             &
                                          iim2_t,jjm2_t,nsdm2_t,             &
                                          lap_w(level)%lap_w,                &
                           alpha_work(level)%work,beta_work(level)%work,     &
                           beta_work(level-1)%work)
      ENDDO
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  solve on the coarsest resolution
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      current => get_component_pointer(trim(comp_mg(level_bottom))) 
      nsdm1_t = current%sbdmn_assign%length(my_task+1)
      CALL relax (24,level_bottom,iim_t(level_bottom),jjm_t(level_bottom),   &
                  nvar,nsdm1_t,lap_w(level_bottom)%lap_w,                    &
                  beta_work(level_bottom)%work,alpha_work(level_bottom)%work)
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  up the V-cycle
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      DO level = level_bottom,max_level-1
          iim1_t = iim_t(level  )
          jjm1_t = jjm_t(level  )
         nsdm1_t = current%sbdmn_assign%length(my_task+1)
          iim2_t = iim_t(level+1)
          jjm2_t = jjm_t(level+1)
         current => get_component_pointer(trim(comp_mg(level+1))) 
         nsdm2_t = current%sbdmn_assign%length(my_task+1)

         CALL interpolate (level,nvar,iim1_t,jjm1_t,nsdm1_t,                 &
                                      iim2_t,jjm2_t,nsdm2_t,                 &
                        alpha_work(level)%work,alpha_work(level+1)%work)

         CALL relax (2,level+1,iim2_t,jjm2_t,nvar,nsdm2_t,                   &
                       lap_w(level+1)%lap_w,                                 &
                       beta_work(level+1)%work,alpha_work(level+1)%work)
      ENDDO
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  copy solution from work arrays to input arrays
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      alpha(:,:,:,:) = alpha_work(max_level)%work(:,:,:,:)

      DO level = min_level,max_level
         DEALLOCATE (alpha_work(level)%work,beta_work(level)%work)
      ENDDO 

      END SUBROUTINE multigrid
!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
      SUBROUTINE relax (iteration,level,iim_t,jjm_t,nvar,nsdm_t,             &
                                                       lap_w,beta,alpha)
! 28 AUGUST 2000
      IMPLICIT NONE

      INTEGER (KIND=int_kind) :: iteration,level,iim_t,jjm_t,nvar,nsdm_t
      INTEGER (KIND=int_kind) :: iguana,i,j,p,q,nsd,ierr

      REAL (KIND=dbl_kind), PARAMETER :: omega=0.8_dbl_kind

      REAL (KIND=dbl_kind) ::                                                &
         lap_w(7,iim_t,jjm_t,nsdm_t),                                        &
         beta(iim_t,jjm_t,nvar,nsdm_t),alpha(iim_t,jjm_t,nvar,nsdm_t)
      REAL (KIND=dbl_kind), ALLOCATABLE ::                                   & 
          lap_w_temp(:,:,:),temp_temp(:),temp(:,:,:,:)

      ALLOCATE (lap_w_temp(iim_t,jjm_t,nsdm_t),                              &
                temp_temp(nvar),temp(iim_t,jjm_t,nvar,nsdm_t))

      lap_w_temp = 0.0; temp_temp(:) = 0.0; temp(:,:,:,:) = 0.0

      p = iim_t-1; q = jjm_t-1

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! make sure laplacian weights are well behaved
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      WHERE (lap_w(7,:,:,:)/=0.0)
         lap_w_temp(:,:,:) = 1.0_dbl_kind/(lap_w(7,:,:,:) - helm_const_mg)
      ELSEWHERE
         lap_w_temp(:,:,:) = 0.0_dbl_kind
      END WHERE

      DO iguana = 1,iteration
         IF ((iim_t==2+2**level).AND.((nsdm_t==0).OR.(nsdm_t==10))) THEN
!            CALL timer_start ('simple relax '//integer_to_string (level))
             CALL wrap_simple (level,iim_t,jjm_t,nvar,nsdm_t,alpha)
!            CALL timer_stop  ('simple relax '//integer_to_string (level))
          ELSE   
!            CALL timer_start ('wrap relax '//integer_to_string (level))
            CALL wrap        (trim(comp_mg(level)),face=alpha) 
!            CALL timer_stop  ('wrap relax '//integer_to_string (level))
          ENDIF

         DO nsd = 1,nsdm_t
            DO j = 2,jjm_t-1
               DO i = 2,iim_t-1
                  temp_temp(:) = (lap_w_temp(i,j,nsd))*                      &
                                 (                  beta(i  ,j  ,:,nsd)-     &
                                  lap_w(1,i,j,nsd)*alpha(i-1,j  ,:,nsd)-     &
                                  lap_w(2,i,j,nsd)*alpha(i-1,j-1,:,nsd)-     &
                                  lap_w(3,i,j,nsd)*alpha(i  ,j-1,:,nsd)-     &
                                  lap_w(4,i,j,nsd)*alpha(i+1,j  ,:,nsd)-     &
                                  lap_w(5,i,j,nsd)*alpha(i+1,j+1,:,nsd)-     &
                                  lap_w(6,i,j,nsd)*alpha(i  ,j+1,:,nsd))
                  temp(i,j,:,nsd) = (1.0-omega)*alpha(i,j,:,nsd) +           &
                                         omega *temp_temp(:)
            ENDDO
         ENDDO
! NORTH POLE
            i=1;j=jjm_t-1
            temp_temp(:) = (lap_w_temp(i,j,nsd))*                            & 
                               (                  beta(i    ,j  ,:,nsd)-     &
                                lap_w(2,i,j,nsd)*alpha(iim_t,  1,:,nsd)-     &
                                lap_w(3,i,j,nsd)*alpha(i    ,j-1,:,nsd)-     &
                                lap_w(4,i,j,nsd)*alpha(i+1  ,j  ,:,nsd)-     &
                                lap_w(5,i,j,nsd)*alpha(i+1  ,j+1,:,nsd)-     &
                                lap_w(6,i,j,nsd)*alpha(i    ,j+1,:,nsd))      

            temp(i,j,:,nsd) = (1.0-omega)*alpha(i,j,:,nsd)+                  &
                                   omega *temp_temp(:)
! SOUTH POLE
            i=iim_t-1;j=1
            temp_temp(:) = (lap_w_temp(i,j,nsd))*                            &
                               (                  beta(i    ,j  ,:,nsd)-     &
                                lap_w(1,i,j,nsd)*alpha(i-1,j    ,:,nsd)-     &
                                lap_w(2,i,j,nsd)*alpha(  1,jjm_t,:,nsd)-     &
                                lap_w(4,i,j,nsd)*alpha(i+1,j    ,:,nsd)-     &
                                lap_w(5,i,j,nsd)*alpha(i+1,j+1  ,:,nsd)-     &
                                lap_w(6,i,j,nsd)*alpha(i  ,j+1  ,:,nsd))

            temp(i,j,:,nsd) = (1.0-omega)*alpha(i,j,:,nsd)+                  &
                                   omega *temp_temp(:)
         ENDDO

         alpha(:,:,:,:) = temp(:,:,:,:)
      ENDDO

      DEALLOCATE (lap_w_temp,temp_temp,temp)

      END SUBROUTINE relax
!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
      SUBROUTINE inject_residual (level,nvar,iim1_t,jjm1_t,nsdm1_t,          &
                                 iim2_t,jjm2_t,nsdm2_t,lap_w,xa2,xb2,x1)
! 29 AUGUST 2000
      IMPLICIT NONE
      INTEGER (KIND=int_kind) :: level,nvar,                                 &
                             iim1_t,jjm1_t,nsdm1_t,iim2_t,jjm2_t,nsdm2_t
      INTEGER (KIND=int_kind) :: sd_ratio,p2,q2,i1,j1,nsd1,i2,j2,nsd2,       &
              sbdmn_number,msg_size,count,count_send_req,count_recv_req,     &
              msg_src,msg_dest,msg_tag,nonexistent_task,                     &
              length_i1,length_j1,sd_rat,offset_i1,offset_j1,                &
              sd_np,sd_sp,ierr,my_communicator,mpi_float_type     
# if mpi==1
      INTEGER (KIND=int_kind), ALLOCATABLE :: send_req(:),recv_req(:),       &
                                       send_status(:,:),recv_status(:,:)
# endif

      REAL (KIND=dbl_kind) ::  lap_w(7,iim2_t,jjm2_t,nsdm2_t),               &
                              xa2(iim2_t,jjm2_t,nvar,nsdm2_t),               &
                              xb2(iim2_t,jjm2_t,nvar,nsdm2_t),               &
                               x1(iim1_t,jjm1_t,nvar,nsdm1_t)
      REAL (KIND=dbl_kind), ALLOCATABLE ::                                   &
                                         buffer1(:,:,:,:),buffer2(:,:,:)

      TYPE (component_node),POINTER :: & 
         Current,  &            ! pointer to component_node for level
         coarser               ! pointer to component_node for level-1

      current => get_component_pointer(trim(comp_mg(level))) 
      coarser => get_component_pointer(trim(comp_mg(level-1)))
      my_communicator = current%mpi_communicator 
      mpi_float_type = current%mpi_float_type 

      sd_ratio = (mgdn(level)%length)/(mgup(level-1)%length)
      ALLOCATE                                                               &
            (buffer1(nvar,2+((iim2_t-2)*(jjm2_t-2))/4,sd_ratio,nsdm1_t))
      buffer1(:,:,:,:) = 0.0
      ALLOCATE                                                               &
            (buffer2(nvar,2+((iim2_t-2)*(jjm2_t-2))/4,         nsdm2_t))  
      buffer2(:,:,:) = 0.0

# if mpi==1
      ALLOCATE (send_req(nsdm2_t         ))
      ALLOCATE (recv_req(nsdm1_t*sd_ratio))
      ALLOCATE (send_status(MPI_STATUS_SIZE,nsdm2_t         ))
      ALLOCATE (recv_status(MPI_STATUS_SIZE,nsdm1_t*sd_ratio))
# endif
      IF ((iim2_t==2+2**level).AND.((nsdm2_t==0).OR.(nsdm2_t==10))) THEN
         CALL wrap_simple (level,iim2_t,jjm2_t,nvar,nsdm2_t,xa2)
      ELSE   
         CALL wrap        (trim(comp_mg(level)),face=xa2) 
      ENDIF

      p2 = iim2_t-1
      q2 = jjm2_t-1

      DO nsd2 = 1,nsdm2_t
         count = 0 
         DO j2 = 3,jjm2_t-1,2
            DO i2 = 3,iim2_t-1,2
               count = count+1
               buffer2(:,count,nsd2) = xb2(i2,j2,:,nsd2) -                   &
             ((lap_w(7,i2,j2,nsd2)-helm_const_mg)*xa2(i2  ,j2  ,:,nsd2)+     &
                              lap_w(1,i2,j2,nsd2)*xa2(i2-1,j2  ,:,nsd2)+     &
                              lap_w(2,i2,j2,nsd2)*xa2(i2-1,j2-1,:,nsd2)+     & 
                              lap_w(3,i2,j2,nsd2)*xa2(i2  ,j2-1,:,nsd2)+     &
                              lap_w(4,i2,j2,nsd2)*xa2(i2+1,j2  ,:,nsd2)+     &
                              lap_w(5,i2,j2,nsd2)*xa2(i2+1,j2+1,:,nsd2)+     &
                              lap_w(6,i2,j2,nsd2)*xa2(i2  ,j2+1,:,nsd2)) 
            ENDDO
         ENDDO
! NORTH POLE
         count = count+1
         i2=1;j2=jjm2_t-1
         buffer2(:,count,nsd2) = xb2(i2,j2,:,nsd2) -                         &
          ((lap_w(7,i2,j2,nsd2)-helm_const_mg)*xa2(i2     ,j2  ,:,nsd2)+     &
                           lap_w(2,i2,j2,nsd2)*xa2(iim2_t,1    ,:,nsd2)+     &
                           lap_w(3,i2,j2,nsd2)*xa2(i2     ,j2-1,:,nsd2)+     &
                           lap_w(4,i2,j2,nsd2)*xa2(i2+1   ,j2  ,:,nsd2)+     &
                           lap_w(5,i2,j2,nsd2)*xa2(i2+1   ,j2+1,:,nsd2)+     &
                           lap_w(6,i2,j2,nsd2)*xa2(i2     ,j2+1,:,nsd2))
! SOUTH POLE
         count = count+1
         i2=iim2_t-1;j2=1
         buffer2(:,count,nsd2) = xb2(i2,j2,:,nsd2) -                         &
           ((lap_w(7,i2,j2,nsd2)-helm_const_mg)*xa2(i2  ,j2    ,:,nsd2)+     &
                            lap_w(1,i2,j2,nsd2)*xa2(i2-1,j2    ,:,nsd2)+     &
                            lap_w(2,i2,j2,nsd2)*xa2(1   ,jjm2_t,:,nsd2)+     &
                            lap_w(4,i2,j2,nsd2)*xa2(i2+1,j2    ,:,nsd2)+     &
                            lap_w(5,i2,j2,nsd2)*xa2(i2+1,j2+1  ,:,nsd2)+     &
                            lap_w(6,i2,j2,nsd2)*xa2(i2  ,j2+1  ,:,nsd2))     

      ENDDO

      msg_size = nvar*(2+((iim2_t-2)*(jjm2_t-2))/4)
      length_i1 = (iim2_t-2)/2
      length_j1 = (jjm2_t-2)/2

      sd_np = isdm_level(level)*(  jsdm_level(level)-1)+1
      sd_sp = isdm_level(level)*(4*jsdm_level(level)+1)

      nonexistent_task = -999
# if mpi==1
      nonexistent_task = MPI_PROC_NULL
# endif

# if mpi==1
! POST RECEIVES
      count_recv_req = 0
      DO nsd1 = 1,nsdm1_t
         sbdmn_number = coarser%sbdmn_assign%sd(my_task+1,nsd1)
         DO sd_rat = 1,sd_ratio
            IF (mgup(level-1)%mgup(3,sd_rat,sbdmn_number).EQ.0) THEN
               msg_src = nonexistent_task
               msg_tag = 0
            ELSE
               msg_src = current%sbdmn_owner%                                &
                        owner(mgup(level-1)%mgup(2,sd_rat,sbdmn_number))
               msg_tag =      mgup(level-1)%mgup(3,sd_rat,sbdmn_number)
            ENDIF
            count_recv_req = count_recv_req+1
            CALL MPI_IRECV (buffer1(1,1,sd_rat,nsd1),msg_size,               &
                           mpi_float_type,msg_src,msg_tag,                   &
                           my_communicator,recv_req(count_recv_req),ierr)
         ENDDO
      ENDDO ! LOOP OVER nsdm1_t SUBDOMAINS
# endif

! POST SENDS
      count_send_req = 0
      DO nsd2 = 1,nsdm2_t
         sbdmn_number = current%sbdmn_assign%sd(my_task+1,nsd2)
         IF (mgdn(level)%mgdn(3,sbdmn_number).EQ.0) THEN
            offset_i1 = mgdn(level)%mgdn(4,sbdmn_number)
            offset_j1 = mgdn(level)%mgdn(5,sbdmn_number)
            nsd1      = mgdn(level)%mgdn(6,sbdmn_number)
            count = 0
            DO j1 = 1,length_j1
               DO i1 = 1,length_i1
                  count = count+1
                  x1(offset_i1+i1-1,offset_j1+j1-1,:,nsd1) =                 &
                                                   buffer2(:,count,nsd2)
               ENDDO
            ENDDO
            IF (mgdn(level)%mgdn(2,sbdmn_number).EQ.sd_np) THEN
               x1(1,jjm1_t-1,:,nsd1) = buffer2(:,count+1,nsd2)
            ENDIF
            IF (mgdn(level)%mgdn(2,sbdmn_number).EQ.sd_sp) THEN
               x1(iim1_t-1,1,:,nsd1) = buffer2(:,count+2,nsd2)
            ENDIF
            msg_dest = nonexistent_task
            msg_tag  = 0
         ELSE
            msg_dest = coarser%sbdmn_owner%                                 &
                       owner(mgdn(level)%mgdn(1,sbdmn_number))
            msg_tag  =       mgdn(level)%mgdn(3,sbdmn_number)
         ENDIF
# if mpi==1
         count_send_req = count_send_req+1
         CALL MPI_ISEND (buffer2(1,1,nsd2),msg_size,                         &
                           mpi_float_type,msg_dest,msg_tag,                  &
                           my_communicator,send_req(count_send_req),ierr)
# endif
      ENDDO ! LOOP OVER nsdm2_t SUBDOMAINS

# if mpi==1
      CALL MPI_WAITALL (nsdm2_t,         send_req,send_status,ierr)
      CALL MPI_WAITALL (nsdm1_t*sd_ratio,recv_req,recv_status,ierr)

! UNPACK BUFFER
      DO nsd1 = 1,nsdm1_t
         sbdmn_number = coarser%sbdmn_assign%sd(my_task+1,nsd1)
         DO sd_rat = 1,sd_ratio
            IF (mgup(level-1)%mgup(3,sd_rat,sbdmn_number).NE.0) THEN

               offset_i1 = mgup(level-1)%mgup(4,sd_rat,sbdmn_number)
               offset_j1 = mgup(level-1)%mgup(5,sd_rat,sbdmn_number)
               count = 0
               DO j1 = 1,length_j1
                  DO i1 = 1,length_i1
                     count = count+1
                     x1(offset_i1+i1-1,offset_j1+j1-1,:,nsd1) =              &
                                            buffer1(:,count,sd_rat,nsd1)
                  ENDDO
               ENDDO
               IF (mgup(level-1)%mgup(2,sd_rat,sbdmn_number).EQ.             &
                                                             sd_np) THEN
                  x1(1,jjm1_t-1,:,nsd1) = buffer1(:,count+1,sd_rat,nsd1)
               ENDIF
               IF (mgup(level-1)%mgup(2,sd_rat,sbdmn_number).EQ.             &
                                                             sd_sp) THEN
                  x1(iim1_t-1,1,:,nsd1) = buffer1(:,count+2,sd_rat,nsd1)
               ENDIF
            ENDIF
         ENDDO
      ENDDO ! LOOP OVER nsdm1_t SUBDOMAINS
# endif

      DEALLOCATE (buffer1,buffer2)
# if mpi==1
      DEALLOCATE (send_req,recv_req,send_status,recv_status)
# endif

      END SUBROUTINE inject_residual
!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
      SUBROUTINE interpolate (level,nvar,iim1_t,jjm1_t,nsdm1_t,              &  
                                         iim2_t,jjm2_t,nsdm2_t,x1,x2)
! 29 AUGUST 2000
      IMPLICIT NONE
      INTEGER (KIND=int_kind) :: level,nvar,                                 &
                             iim1_t,jjm1_t,nsdm1_t,iim2_t,jjm2_t,nsdm2_t
      INTEGER (KIND=int_kind) :: sd_ratio,i1,j1,nsd1,i2,j2,nsd2,i,j,         &
              sbdmn_number,msg_size,count,count_send_req,count_recv_req,     &
              msg_src,msg_dest,msg_tag,nonexistent_task,sd_rat,              & 
              length_i1,length_j1,offset_i1,offset_j1,ierr,p2,q2,            &
              my_communicator, mpi_float_type         
       
# if mpi==1
      INTEGER (KIND=int_kind), ALLOCATABLE :: send_req(:),recv_req(:),       &
                                       send_status(:,:),recv_status(:,:)
# endif
      REAL (KIND=dbl_kind) :: x1(iim1_t,jjm1_t,nvar,nsdm1_t),                &
                              x2(iim2_t,jjm2_t,nvar,nsdm2_t)
      REAL (KIND=dbl_kind), ALLOCATABLE ::                                   &
                           buffer1(:,:,:,:),buffer2(:,:,:),temp(:,:,:,:)

      TYPE (component_node),POINTER :: & 
         Current,  &            ! pointer to component_node for level
         finer                  ! pointer to component_node for level+1

      current => get_component_pointer(trim(comp_mg(level))) 
      finer => get_component_pointer(trim(comp_mg(level+1)))
      my_communicator = current%mpi_communicator 
      mpi_float_type = current%mpi_float_type 

      sd_ratio = (mgdn(level+1)%length)/(mgup(level)%length)

      ALLOCATE (buffer1(nvar,(iim2_t*jjm2_t)/4,sd_ratio,nsdm1_t))
      buffer1(:,:,:,:) = 0.0
      ALLOCATE (buffer2(nvar,(iim2_t*jjm2_t)/4,         nsdm2_t))
      buffer2(:,:,:) = 0.0
      ALLOCATE (temp(iim2_t,jjm2_t,nvar,nsdm2_t))
      temp(:,:,:,:) = 0.0

# if mpi==1
      ALLOCATE (send_req   (                nsdm1_t*sd_ratio))
      ALLOCATE (send_status(MPI_STATUS_SIZE,nsdm1_t*sd_ratio))
      ALLOCATE (recv_req   (                nsdm2_t         ))
      ALLOCATE (recv_status(MPI_STATUS_SIZE,nsdm2_t         ))
# endif

      IF ((iim1_t==2+2**level).AND.((nsdm1_t==0).OR.(nsdm1_t==10))) THEN
         CALL wrap_simple (level,iim1_t,jjm1_t,nvar,nsdm1_t,x1)
      ELSE   
         CALL wrap        (trim(comp_mg(level)),face=x1) 
      ENDIF

      msg_size = nvar*((iim2_t*jjm2_t)/4)
      length_i1 = (iim2_t-2)/2
      length_j1 = (jjm2_t-2)/2

      nonexistent_task = -999
# if mpi==1
      nonexistent_task = MPI_PROC_NULL
# endif

# if mpi==1
! POST RECEIVES
      count_recv_req = 0
      DO nsd2 = 1,nsdm2_t
         sbdmn_number = finer%sbdmn_assign%sd(my_task+1,nsd2)
         IF (mgdn(level+1)%mgdn(3,sbdmn_number).EQ.0) THEN
            msg_src = nonexistent_task
            msg_tag = 0
         ELSE
            msg_src = current%sbdmn_owner%                                  &
                      owner(mgdn(level+1)%mgdn(1,sbdmn_number))
            msg_tag =       mgdn(level+1)%mgdn(3,sbdmn_number)
         ENDIF
         count_recv_req = count_recv_req+1
         CALL MPI_IRECV (buffer2(1,1,nsd2),msg_size,                         &
                           mpi_float_type,msg_src,msg_tag,                   &
                           my_communicator,recv_req(count_recv_req),ierr)
      ENDDO ! LOOP OVER nsdm2_t SUBDOMAINS
# endif

! POST SENDS
      count_send_req = 0
      DO nsd1 = 1,nsdm1_t
         sbdmn_number = current%sbdmn_assign%sd(my_task+1,nsd1)
         DO sd_rat = 1,sd_ratio
            offset_i1 = mgup(level)%mgup(4,sd_rat,sbdmn_number)
            offset_j1 = mgup(level)%mgup(5,sd_rat,sbdmn_number)
            IF (mgup(level)%mgup(3,sd_rat,sbdmn_number).EQ.0) THEN
               nsd2 = mgup(level)%mgup(9,sd_rat,sbdmn_number)
               DO j1 = 1,length_j1+1
                  j2 = 2*j1-1
                  DO i1 = 1,length_i1+1
                     i2 = 2*i1-1
                     temp(i2,j2,:,nsd2) =                                    &
                                x1(offset_i1+i1-2,offset_j1+j1-2,:,nsd1)
                  ENDDO
               ENDDO
               msg_dest = nonexistent_task
               msg_tag  = 0
            ELSE
               count = 0
               DO j1 = 1,length_j1+1
                  DO i1 = 1,length_i1+1
                     count = count+1
                     buffer1(:,count,sd_rat,nsd1) =                          &
                                x1(offset_i1+i1-2,offset_j1+j1-2,:,nsd1)
                  ENDDO
               ENDDO
               msg_dest = finer%sbdmn_owner%                                 &
                          owner(mgup(level)%mgup(2,sd_rat,sbdmn_number))
               msg_tag  =       mgup(level)%mgup(3,sd_rat,sbdmn_number)
            ENDIF
# if mpi==1
            count_send_req = count_send_req+1
            CALL MPI_ISEND (buffer1(1,1,sd_rat,nsd1),msg_size,               &
                           mpi_float_type,msg_dest,msg_tag,                  &
                           my_communicator,send_req(count_send_req),ierr)
# endif
         ENDDO
      ENDDO ! LOOP OVER nsdm1_t SUBDOMAINS

# if mpi==1
      CALL MPI_WAITALL (nsdm1_t*sd_ratio,send_req,send_status,ierr)
      CALL MPI_WAITALL (nsdm2_t         ,recv_req,recv_status,ierr)

! UNPACK BUFFER
      DO nsd2 = 1,nsdm2_t
         sbdmn_number = finer%sbdmn_assign%sd(my_task+1,nsd2)
         IF (mgdn(level+1)%mgdn(3,sbdmn_number).NE.0) THEN
            count = 0
            DO j2 = 1,jjm2_t-1,2
               DO i2 = 1,iim2_t-1,2
                  count = count+1
                  temp(i2,j2,:,nsd2) = buffer2(:,count,nsd2)
               ENDDO
            ENDDO
         ENDIF
      ENDDO ! LOOP OVER nsdm2_t SUBDOMAINS
# endif

      p2 = iim2_t-1
      q2 = jjm2_t-1

      DO nsd2 = 1,nsdm2_t
         DO j = 3,jjm2_t-1,2
            DO i = 3,iim2_t-1,2
               x2(i  ,j  ,:,nsd2) = x2(i  ,j  ,:,nsd2)+temp(i,j,:,nsd2)

               x2(i-1,j  ,:,nsd2) = x2(i-1,j  ,:,nsd2) +                     &
                             0.5*(temp(i,j,:,nsd2)+temp(i-2,j  ,:,nsd2)) 
               x2(i-1,j-1,:,nsd2) = x2(i-1,j-1,:,nsd2) +                     &
                             0.5*(temp(i,j,:,nsd2)+temp(i-2,j-2,:,nsd2)) 
               x2(i  ,j-1,:,nsd2) = x2(i  ,j-1,:,nsd2) +                     &
                             0.5*(temp(i,j,:,nsd2)+temp(i  ,j-2,:,nsd2))
            ENDDO
         ENDDO
         x2(1,q2,:,nsd2) = x2(1,q2,:,nsd2) + temp(1,q2,:,nsd2)
         x2(p2,1,:,nsd2) = x2(p2,1,:,nsd2) + temp(p2,1,:,nsd2)
      ENDDO

      DEALLOCATE (buffer1,buffer2,temp)
# if mpi==1
      DEALLOCATE (send_req,recv_req,send_status,recv_status)
# endif

      END SUBROUTINE interpolate
!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
      SUBROUTINE output_mgup_mgdn ()
      IMPLICIT NONE
      INTEGER (KIND=int_kind) :: level,sd_ratio,sd_rat,nsd,n
      CHARACTER*40 mgdn_file,mgup_file

      DO level = min_level,max_level-1
         IF (level.EQ.1) mgup_file='mgup_00042'
         IF (level.EQ.2) mgup_file='mgup_00162'
         IF (level.EQ.3) mgup_file='mgup_00642'
         IF (level.EQ.4) mgup_file='mgup_02562'
         IF (level.EQ.5) mgup_file='mgup_10242'
         IF (level.LE.5) THEN
            OPEN (UNIT=39,FILE=mgup_file,                                    &
                                      FORM='FORMATTED',STATUS='UNKNOWN')
            sd_ratio = (mgdn(level+1)%length)/(mgup(level)%length)

            DO nsd = 1,mgup(level)%length
               WRITE (39,*) ' '
               WRITE (39,*) ' nsd = ',nsd
               WRITE (39,*) ' '
               DO sd_rat = 1,sd_ratio
                  WRITE (39,10) (mgup(level)%mgup(n,sd_rat,nsd),n=1,9)
               ENDDO
            ENDDO
         ENDIF
      ENDDO

      DO level = 2,max_level
         IF (level.EQ.2) mgdn_file='mgdn_00162'
         IF (level.EQ.3) mgdn_file='mgdn_00642'
         IF (level.EQ.4) mgdn_file='mgdn_02562'
         IF (level.EQ.5) mgdn_file='mgdn_10242'
         IF (level.LE.5) THEN
            OPEN (UNIT=39,FILE=mgdn_file,                                    &
                                      FORM='FORMATTED',STATUS='UNKNOWN')

            DO nsd = 1,mgdn(level)%length
               WRITE (39,*) ' '
               WRITE (39,*) ' nsd = ',nsd
               WRITE (39,*) ' '
               WRITE (39,10) (mgdn(level)%mgdn(n,nsd),n=1,9)
            ENDDO
         ENDIF
      ENDDO

   10 FORMAT (9I4)

      END SUBROUTINE output_mgup_mgdn
!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
      SUBROUTINE wrap_simple (level,iim_t,jjm_t,nvar,nsdm_t,x) 
! 8 OCTOBER 2002
      INTEGER (KIND=int_kind) :: level,iim_t,jjm_t,nvar,nsdm_t
      INTEGER (KIND=int_kind) :: p,q,nsd
      REAL    (KIND=dbl_kind) :: x(iim_t,jjm_t,nvar,nsdm_t)

      p = iim_t-1; q = jjm_t-1

      IF ((iim_t/=2+2**level).OR.((nsdm_t/=0).AND.(nsdm_t/=10))) THEN
         PRINT *,' wrap_simple : wrap_simple called with what appears '
         PRINT *,'               to be not a simple grid.             '
      ENDIF

      IF (nsdm_t==10) THEN
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! NORTH POLE
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         DO nsd = 3,9,2
            x(1,q,:,nsd) = x(1,q,:, 1)
         ENDDO
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! SOUTH POLE
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         DO nsd = 2,8,2
            x(p,1,:,nsd) = x(p,1,:,10)
         ENDDO
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! NORTHERN HEMISPHERE SUBDOMAINS
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         DO nsd = 1,9,2
            x(    1,1:q-1,:,nsd) = x(p:2:-1,  q   ,:,MOD (nsd+7,10)+1)
            x(2:p  ,    1,:,nsd) = x(2:p   ,  q   ,:,MOD (nsd+8,10)+1)
            x(  p+1,2:q  ,:,nsd) = x(  2   ,2:q   ,:,MOD (nsd+0,10)+1)
            x(2:p  ,  q+1,:,nsd) = x(  2   ,q:2:-1,:,MOD (nsd+1,10)+1)
         ENDDO
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! SOUTHERN HEMISPHERE SUBDOMAINS
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         DO nsd = 2,10,2
            x(    1,2:q  ,:,nsd) = x(  p   ,2:q   ,:,MOD (nsd+8,10)+1)
            x(1:p-1,    1,:,nsd) = x(  p   ,q:2:-1,:,MOD (nsd+7,10)+1)
            x(  p+1,2:q  ,:,nsd) = x(p:2:-1,  2   ,:,MOD (nsd+1,10)+1)
            x(2:p  ,  q+1,:,nsd) = x(2:p   ,  2   ,:,MOD (nsd+0,10)+1)
         ENDDO
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! FIX-UP THE NORTH AND SOUTH POLES
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         x(  1,q+1,:, 1) = x(2,q,:,5)
         x(p+1,  1,:, 1) = x(2,q,:,7)
         x(p+1,  1,:,10) = x(p,2,:,4)
         x(  1,q+1,:,10) = x(p,2,:,6)
      ENDIF

      END SUBROUTINE wrap_simple
!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
      END MODULE multigrid_solver_xxx
!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
