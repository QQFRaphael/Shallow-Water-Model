!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

        module operators_hl_xxx

	use kinds
 	use params_grid_horizontal_xxx
	use grid_metrics_variables_xxx
	use operators
	use wrap_data
	use grid_mask_variables_xxx

!======================================================================
! PURPOSE : this module is a collection of HIGHER LEVEL operators.
! these operators are built off of the "operators" module. They are 
! distinguished from the "operators" modules by the use of wrap_face_data
! and wrap_vertex_data, i.e. the need to do boundary updates in the process
! of computing the necessary quanities.
!
! NOTE : calls to wrap and wrap_vertices lead to message passing. These
! are effectively syncronization points.
!
! NOTE : since calls to wrap* are allowed, no subroutine in this module
! can be called inside a "do ksdm=1,nsdm" loop
!
! NOTE : the convention here is to wrap all intent(out) variables when
! wrapping is applicable.
!======================================================================

	implicit none

! ad hoc
 	integer (kind=int_kind), parameter :: kkm=1

!*************************************************************************

        contains

!*************************************************************************


!======================================================================
! BEGIN CALCULATE_U_AND_KE
!======================================================================
        subroutine calculate_u_and_ke(                          &
                    component_name,                             &
                    kkm,                                        &
                    psi,                                        &
                    chi,                                        &
                    u,                                          &
                    ke   )

!-----------------------------------------------------------------------
! PURPOSE :  given psi and chi, find the velocity (at corners)
!  can kinetic energy (at cell centers)
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!                 : 
!                 : 
!                 : 
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
      character (len=*), intent(in) :: component_name
      integer (kind=int_kind), intent(in) :: kkm

        real (kind=dbl_kind), intent(in) ::                                &
                        psi             (iim,jjm,kkm,nsdm),                &
                        chi             (iim,jjm,kkm,nsdm)
!                        psi             (iim,jjm,    nsdm),                &
!                        chi             (iim,jjm,    nsdm)


!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                                  &
                        u               (nspace,ncorners,iim,jjm,kkm,nsdm),   &
                        ke              (                iim,jjm,kkm,nsdm)  
 !                       u               (nspace,ncorners,iim,jjm,    nsdm),   &
 !                       ke              (                iim,jjm,    nsdm)


!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j,k,ksdm
!	real (kind=dbl_kind) :: work_c(ncorners,iim,jjm,kkm,nsdm)
        real (kind=dbl_kind) :: work_c(ncorners,iim,jjm)

!----------------------------------------------------------------------------
! loop over subdomains and over vertical levels
!----------------------------------------------------------------------------
	do ksdm = 1,nsdm
 	do k=1,kkm
	  call calculate_velocity(                                &
                npad,                                             &
                iim,                                              &
                jjm,                                              &
                ndata,                                            &
                nspace,                                           &
                ncorners,                                         &
                corner_area_inv(:,:,:,ksdm),                      &
                v_weights(:,:,:,:,:,ksdm),                        &
                psi(:,:,k,ksdm),                                  &
                chi(:,:,k,ksdm),                                  &
                u(:,:,:,:,k,ksdm) )
	enddo
	enddo

	call wrap(component_name,vrtx=u(:,:,:,:,:,:))

	do ksdm=1,nsdm
 	do k=1,kkm
	work_c(:,:,:) = p5 * (   u(1,:,:,:,k,ksdm) * u(1,:,:,:,k,ksdm)     &
                                 + u(2,:,:,:,k,ksdm) * u(2,:,:,:,k,ksdm)  )

	  call calculate_center_kinetic_energy(                   &
                npad,                                             &
                iim,                                              &
                iim,                                              &
                ndata,                                            &
                nspace,                                           &
                ncorners,                                         &
                sub_area(:,:,:,:,ksdm),                           &
                area_inv(:,:,ksdm),                               &
                work_c(:,:,:),                                    &
                ke(:,:,k,ksdm)       )

 	enddo
	enddo

!----------------------------------------------------------------------------
! wrap ke
!----------------------------------------------------------------------------
!        call wrap (component_name, face_1L=ke(:,:,:))
        call wrap (component_name, face=ke(:,:,:,:))

        end subroutine calculate_u_and_ke
!======================================================================
! END CALCULATE_U_AND_KE
!======================================================================


!======================================================================
! BEGIN CALCULATE_REL_DIV_AND_KE
!======================================================================
        subroutine calculate_rel_div_and_ke(                      &
                 component_name,                                  &
                 u,                                               &
                 relative,                                        &
                 divergence,                                      &
                 ke         )
                                                                
!-----------------------------------------------------------------------
! PURPOSE : given an unwrapped velocity field, compute the relative
!  vorticity, divergence, and kinetic energy
!
! NOTE : this routine is generalized, u can be an arbitrary vector field
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!                 : 
!                 : 
!                 : 
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
      character (len=*), intent(in) :: component_name

        real (kind=dbl_kind), intent(in) ::                                &
!                       u             (nspace,ncorners,iim,jjm,kkm,nsdm)
                        u             (nspace,ncorners,iim,jjm,    nsdm)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                               &
!                       relative                      (iim,jjm,kkm,nsdm),  &
!                       divergence                    (iim,jjm,kkm,nsdm),  &
!                       ke                            (iim,jjm,kkm,nsdm)  
                        relative                      (iim,jjm,    nsdm),  &
                        divergence                    (iim,jjm,    nsdm),  &
                        ke                            (iim,jjm,    nsdm)
                        
!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j,k,ksdm
!	real (kind=dbl_kind) :: work_c(ncorners,iim,jjm,kkm,nsdm)
	real (kind=dbl_kind) :: work_c(ncorners,iim,jjm,    nsdm)

!----------------------------------------------------------------------------
! wrap the vector field
!----------------------------------------------------------------------------
	call wrap(component_name,vrtx_1L=u(:,:,:,:,:))

!----------------------------------------------------------------------------
! compute ke at each corner
!----------------------------------------------------------------------------
	work_c(:,:,:,:) = p5 * (   u(1,:,:,:,:) * u(1,:,:,:,:)     &
                                 + u(2,:,:,:,:) * u(2,:,:,:,:)  )

!----------------------------------------------------------------------------
! loop over subdomains and over vertical levels
!----------------------------------------------------------------------------
        do ksdm = 1,nsdm
!       do k=1,kkm

	  call curl_of_a_vector(                                        &
                  npad,                                                 &
                  iim,                                                  &
                  jjm,                                                  &
                  ndata,                                                &
                  nspace,                                               &
                  ncorners,                                             &
                  area_inv(:,:,ksdm),                                   &
                  v_weights(:,:,:,:,:,ksdm),                            &
                  u(:,:,:,:,ksdm),                                    &
                  relative(:,:,ksdm)  )

          call div_of_a_vector(                                         &
                  npad,                                                 &
                  iim,                                                  &
                  jjm,                                                  &
                  ndata,                                                &
                  nspace,                                               &
                  ncorners,                                             &
                  area_inv(:,:,ksdm),                                   &
                  v_weights(:,:,:,:,:,ksdm),                            &
                  u(:,:,:,:,ksdm),                                    &
                  divergence(:,:,ksdm)  )

	  call calculate_center_kinetic_energy(                         &
                  npad,                                                 &
                  iim,                                                  &
                  jjm,                                                  &
                  ndata,                                                &
                  nspace,                                               &
                  ncorners,                                             &
                  sub_area(:,:,:,:,ksdm),                               &
                  area_inv(:,:,ksdm),                                   &
                  work_c(:,:,:,ksdm),                                 &
                  ke(:,:,ksdm)       )

!	enddo
	enddo

!----------------------------------------------------------------------------
! wrap relative, divergence, and ke
!----------------------------------------------------------------------------
        call wrap (component_name, face_1L=relative(:,:,:))
        call wrap (component_name, face_1L=divergence(:,:,:))
        call wrap (component_name, face_1L=ke(:,:,:))

        end subroutine calculate_rel_div_and_ke
!======================================================================
! END CALCULATE_REL_DIV_AND_KE
!======================================================================


!======================================================================
! BEGIN SCALAR_LAPLACIAN_TO_THE_N
!======================================================================
        subroutine scalar_laplacian_to_the_n(                        &
                          component_name,                            &
                          kkm,                                    &
                          norder,                                    &
                          xin,                                       &
                          xout   ) 

!-----------------------------------------------------------------------
! PURPOSE : given a scalar field (xin), compute del squre n time
!   i.e. if n = 3, then xout is del sixth of xin
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!                 : 
!                 : 
!                 : 
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
      character (len=*), intent(in) :: component_name

	integer (kind=int_kind), intent(in) ::                             &
                        norder, kkm

        real (kind=dbl_kind), intent(in) ::                                &
                        xin             (iim,jjm,kkm,nsdm)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                               &
                        xout            (iim,jjm,kkm,nsdm)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j,k,ksdm,n
	real (kind=dbl_kind) :: work(iim,jjm,kkm,nsdm)

!----------------------------------------------------------------------------
! copy xin into work
!----------------------------------------------------------------------------
	work = xin

!----------------------------------------------------------------------------
! loop over norder
!----------------------------------------------------------------------------
	do n = 1,norder

!----------------------------------------------------------------------------
! loop over nsdm and kkm
!----------------------------------------------------------------------------
	do ksdm = 1,nsdm
	do k=1,kkm

        call laplacian_of_a_scalar(                                    &
                npad,                                                  &
                iim,                                                   &
                jjm,                                                   &
                nweights,                                              &
                l_weights(:,:,:,ksdm),                                 &
                work(:,:,k,ksdm),                                      &
                xout(:,:,k,ksdm)   )
	enddo
	enddo

!----------------------------------------------------------------------------
! wrap xout
!----------------------------------------------------------------------------
 	call wrap (component_name, face=xout(:,:,:,:))

!----------------------------------------------------------------------------
! copy xout into work
!----------------------------------------------------------------------------
        work = xout

	enddo

        end subroutine scalar_laplacian_to_the_n
!======================================================================
! END SCALAR_LAPLACIAN_TO_THE_N
!======================================================================


!======================================================================
! BEGIN VECTOR_LAPLACIAN_TO_THE_N
!======================================================================
        subroutine vector_laplacian_to_the_n(                         &
                      norder,                                         &
                      u,                                              &
                      xout)

!-----------------------------------------------------------------------
! PURPOSE : given a vector field, take the Laplican N times
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!                 : 
!                 : 
!                 : 
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
	integer (kind=int_kind), intent(in) ::                             &
                        norder

        real (kind=dbl_kind), intent(in) ::                                &
                        u           (nspace,ncorners,iim,jjm,kkm,nsdm)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                                &
                        xout         (nspace,ncorners,iim,jjm,kkm,nsdm)


!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j,k,ksdm


        end subroutine vector_laplacian_to_the_n
!======================================================================
! END VECTOR_LAPLACIAN_TO_THE_N
!======================================================================




!======================================================================
! BEGIN LAPLACIAN_OF_A_VECTOR
!======================================================================
        subroutine laplacian_of_a_vector(      &
                      component_name,                                 &
                kkm,      &
                norder,      &
                xin,      &
                xout)

!-----------------------------------------------------------------------
! PURPOSE : given a vector defined at cell corners, find the Laplacian.
!       this formulation uses the vector identity
!       del dot del (V) = grad (del dot V) - curl (curl (V) )
!----------------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!       xin             : vector (x)
!       xout            : Laplacian of xin (x*m^-1)
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
      character (len=*), intent(in) :: component_name
        integer (kind=int_kind), intent(in) ::                                   &
                        norder, kkm

        real (kind=dbl_kind), intent(in) ::                                      &
                        xin                   (nspace,ncorners,iim,jjm,kkm,nsdm)

        real (kind=dbl_kind), intent(inout)::                                    &
                        xout                  (nspace,ncorners,iim,jjm,kkm,nsdm)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        real (kind=dbl_kind) ::      &
                        work                                  (iim,jjm,nsdm),      &
                        work1_c               (nspace,ncorners,iim,jjm,nsdm),      &
                        work2_c               (nspace,ncorners,iim,jjm,nsdm)

        integer (kind=int_kind) :: i,j,k,ispace,icorner,iorder,ksdm

!----------------------------------------------------------------------------
! initialize, use xout as workspace
!----------------------------------------------------------------------------
	do ksdm=1,nsdm
        do k=1,kkm
        do j=1,jjm
        do i=1,iim
        do icorner=1,ncorners
        do ispace=1,nspace
          xout(ispace,icorner,i,j,k,ksdm) = xin(ispace,icorner,i,j,k,ksdm)
        enddo
        enddo
        enddo
        enddo
        enddo
	enddo

!----------------------------------------------------------------------------
! loop over del2 operator norder times
!----------------------------------------------------------------------------
        do iorder = 1,norder

!----------------------------------------------------------------------------
! wrap data
!----------------------------------------------------------------------------
         call wrap (component_name, vrtx=xout)

!----------------------------------------------------------------------------
! loop over k
!----------------------------------------------------------------------------
        do k = 1,kkm

!----------------------------------------------------------------------------
! compute grad (del dot V) and put in intent(out)
!----------------------------------------------------------------------------
	do ksdm = 1,nsdm
        call div_of_a_vector(      &
                npad,      &
                iim,      &
                jjm,      &
                ndata,      &
                nspace,      &
                ncorners,      &
                area_inv(:,:,ksdm),      &
                v_weights(:,:,:,:,:,ksdm),      &
                xout(:,:,:,:,k,ksdm),      &
                work(:,:,ksdm) )
	enddo

        call wrap (component_name, face_1L=work)

	do ksdm =1,nsdm
        call gradient(      &
                npad,      &
                iim,      &
                jjm,      &
                ndata,      &
                nspace,      &
                ncorners,      &
                corner_area_inv(:,:,:,ksdm),      &
                v_weights(:,:,:,:,:,ksdm),      &
                work(:,:,ksdm),      &
                work1_c(:,:,:,:,ksdm) )
	enddo

!----------------------------------------------------------------------------
! take the gradient of the curl of the velocity
!----------------------------------------------------------------------------
	do ksdm = 1,nsdm
        call curl_of_a_vector(      &
                npad,      &
                iim,      &
                jjm,      &
                ndata,      &
                nspace,      &
                ncorners,      &
                area_inv(:,:,ksdm),      &
                v_weights(:,:,:,:,:,ksdm),      &
                xout(:,:,:,:,k,ksdm),      &
                work(:,:,ksdm) )
	enddo

	call wrap (component_name, face_1L=work)

	do ksdm = 1,nsdm
        call gradient(      &
                npad,      &
                iim,      &
                jjm,      &
                ndata,      &
                nspace,      &
                ncorners,      &
                corner_area_inv(:,:,:,ksdm),      &
                v_weights(:,:,:,:,:,ksdm),      &
                work(:,:,ksdm),      &
                work2_c(:,:,:,:,ksdm) )       
	enddo

!----------------------------------------------------------------------------
! take cross product of this vector with k
!----------------------------------------------------------------------------
	do ksdm = 1,nsdm
        call k_cross_v(      &
                iim,      &
                jjm,      &
                nspace,      &
                ncorners,      &
                work2_c(:,:,:,:,ksdm),      &
                xout(:,:,:,:,k,ksdm))
	enddo


!----------------------------------------------------------------------------
! add this term to the intent(out) array
!----------------------------------------------------------------------------
	do ksdm=1,nsdm
        do j=1,jjm
        do i=1,iim
        do icorner=1,ncorners
        do ispace = 1,nspace
          xout(ispace,icorner,i,j,k,ksdm) = +    xout(ispace,icorner,i,j,k,ksdm)      &
                                            + work1_c(ispace,icorner,i,j,  ksdm)
        enddo
        enddo
        enddo
        enddo
	enddo

        enddo           ! do k = 1,kkm

        enddo           ! do iorder=1,norder

        end subroutine laplacian_of_a_vector
!======================================================================
! END LAPLACIAN_OF_A_VECTOR
!======================================================================



!======================================================================
! BEGIN CALCULATE_REL_AND_DIV
!======================================================================
        subroutine calculate_rel_and_div(                         &
                      component_name,                                 &
                 kkm,                                             &
                 u,                                               &
                 relative,                                        &
                 divergence )
                                                                
!-----------------------------------------------------------------------
! PURPOSE : given an unwrapped velocity field, compute the relative
!  vorticity, divergence, and kinetic energy
!
! NOTE : this routine is generalized, u can be an arbitrary vector field
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!                 : 
!                 : 
!                 : 
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
      character (len=*), intent(in) :: component_name
        integer (kind=int_kind), intent(in) ::                             &
                        kkm

        real (kind=dbl_kind), intent(in) ::                                &
                        u             (nspace,ncorners,iim,jjm,kkm,nsdm)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                               &
                        relative                      (iim,jjm,kkm,nsdm),  &
                        divergence                    (iim,jjm,kkm,nsdm)
                        
!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: k,ksdm

!----------------------------------------------------------------------------
! initialize intent(out)
!----------------------------------------------------------------------------
	relative = 0.0_dbl_kind
	divergence = 0.0_dbl_kind

!----------------------------------------------------------------------------
! wrap the vector field
!----------------------------------------------------------------------------
	call wrap (component_name, vrtx=u)

!----------------------------------------------------------------------------
! loop over subdomains and over vertical levels
!----------------------------------------------------------------------------
        do ksdm = 1,nsdm
        do k=1,kkm

	  call curl_of_a_vector(                                        &
                  npad,                                                 &
                  iim,                                                  &
                  jjm,                                                  &
                  ndata,                                                &
                  nspace,                                               &
                  ncorners,                                             &
                  area_inv(:,:,ksdm),                               &
                  v_weights(:,:,:,:,:,ksdm),                            &
                  u(:,:,:,:,k,ksdm),                                    &
                  relative(:,:,k,ksdm)  )

          call div_of_a_vector(                                         &
                  npad,                                                 &
                  iim,                                                  &
                  jjm,                                                  &
                  ndata,                                                &
                  nspace,                                               &
                  ncorners,                                             &
                  area_inv(:,:,ksdm),                               &
                  v_weights(:,:,:,:,:,ksdm),                            &
                  u(:,:,:,:,k,ksdm),                                    &
                  divergence(:,:,k,ksdm)  )
 	enddo
	enddo

!----------------------------------------------------------------------------
! wrap relative, divergence, and ke
!----------------------------------------------------------------------------
	call wrap (component_name, face=relative)
        call wrap (component_name, face=divergence)

        end subroutine calculate_rel_and_div
!======================================================================
! END CALCULATE_REL_AND_DIV
!======================================================================


!======================================================================
! BEGIN CALCULATE_KE
!======================================================================
        subroutine calculate_ke(                                &
                      component_name,                                 &
                    kkm,                                        &
                    u,                                          &
                    ke   )

!-----------------------------------------------------------------------
! PURPOSE :  given psi and chi, find the velocity (at corners)
!  can kinetic energy (at cell centers)
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!                 :
!                 :
!                 :
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
      character (len=*), intent(in) :: component_name
        integer (kind=int_kind), intent(in) ::                             &
                        kkm

        real (kind=dbl_kind), intent(inout) ::                             &
                        u               (nspace,ncorners,iim,jjm,kkm,nsdm)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                                  &
                        ke              (                iim,jjm,kkm,nsdm)


!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: k,ksdm
        real (kind=dbl_kind) :: work_c(ncorners,iim,jjm,kkm,nsdm)

        call wrap (component_name, vrtx=u)
        work_c(:,:,:,:,:) = p5 * (   u(1,:,:,:,:,:) * u(1,:,:,:,:,:)     &
                                   + u(2,:,:,:,:,:) * u(2,:,:,:,:,:)  )

        do ksdm=1,nsdm
        do k=1,kkm

          call calculate_center_kinetic_energy(                   &
                npad,                                             &
                iim,                                              &
                jjm,                                              &
                ndata,                                            &
                nspace,                                           &
                ncorners,                                         &
                sub_area(:,:,:,:,ksdm),                           &
                area_inv(:,:,ksdm),                           &
                work_c(:,:,:,k,ksdm),                             &
                ke(:,:,k,ksdm)       )

        enddo
        enddo

!----------------------------------------------------------------------------
! wrap ke
!----------------------------------------------------------------------------
        call wrap (component_name, face=ke)

        end subroutine calculate_ke
!======================================================================
! END CALCULATE_KE
!======================================================================


	subroutine average_to_cell_corners_hl(kkm, xin, xout, u, flag)

! this subroutine averages scalar data to corners in an upwind for centered fashion
! for upwinding, the u and flag fields must be present and flag must be true
! the upwinding will use the u field to determine the upwind direction

        integer (kind=int_kind), intent(in) :: kkm
	real (kind=dbl_kind), intent(in) :: xin(iim,jjm,kkm,nsdm)
         real (kind=dbl_kind), intent(in), optional :: u(nspace,ncorners,iim,jjm,kkm,nsdm)
        logical, intent(in), optional :: flag
	real (kind=dbl_kind), intent(out) :: xout(ncorners,iim,jjm,kkm,nsdm)
	integer (kind=int_kind) :: ksdm,k
        logical :: flag1

 	flag1=.false.
        if(present(u)) flag1=flag

	do ksdm=1,nsdm
	do k=1,kkm
        if(flag1) then
        call average_to_cell_corners_up(                                   &
                npad,                                                      &
                iim,                                                       &
                jjm,                                                       &
                ndata,                                                     &
                nspace,                                                    &
                ncorners,                                                  &
                v_weights(:,:,:,:,:,ksdm),                                 &
                u(:,:,:,:,k,ksdm),                                           &
                xin(:,:,k,ksdm),                                             &
                xout(:,:,:,k,ksdm ), .true. )
        else
	call average_to_cell_corners(                                      &
                npad,                                                      &
                iim,                                                       &
                jjm,                                                       &
                ndata,                                                     &
                ncorners,                                                  &
                s_weights(:,:,:,:,ksdm),                                   &
                xin(:,:,k,ksdm),                                             &
                xout(:,:,:,k,ksdm ), .true. )
        endif
	enddo
	enddo

	end subroutine average_to_cell_corners_hl


        end module operators_hl_xxx

!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
