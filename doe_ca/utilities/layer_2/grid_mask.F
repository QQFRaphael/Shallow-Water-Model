!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

        module grid_mask

!-----------------------------------------------------------------------
! PURPOSE : specify the mask for the scalar data and for the vector data
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
! PUBLIC VARIABLES :
!       grid_center_mask  : (0,1) for (ghost,real) scalar points
!       grid_corner_mask  : (0,1) for (ghost,real) vector points
!       polygon_type      : -1 == all ghost cells
!                            1 == real hexagons
!                            2 == Northern and Southern Hemisphere pentagons
!                            3 == North Pole pentagon
!                            4 == South Pole pentagon
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
! COMMON USAGE :
!       the grid_center_mask and grid_corner_mask arrays are commonly
!       multiplied with scalar and vector data, respectively. This
!       effectively eliminates all ghost data
!
!       polygon_type is used to figure out what kind of cell is being   
!       dealt with. This is useful when trying to find the neighbors to
!       that cell.
!-----------------------------------------------------------------------

        use kinds
        use params_physical
        use output_utilities
        use gather_scatter
        use wrap_data
	use grid_metrics_generator

        implicit none
        private

        integer (kind=int_kind) :: ierr

! public member functions
        public ::                                                       &
	   set_grid_center_mask,                                        &
           set_grid_corner_mask,                                        &
           set_center_ordering,                                         &
           block_mask

!*************************************************************************

        contains

!*************************************************************************


!======================================================================
! BEGIN SET_GRID_CENTER_MASK
!======================================================================
        subroutine set_grid_center_mask(component_name,    &
                                   im, jm, iim, jjm, nsdm, &
                                   grid_center_mask, grid_center_index,  &
                                   polygon_type )

!-----------------------------------------------------------------------
! PURPOSE : seperate the real grid cells from the wrapped grid cells
!
!       polygon_type =  1.0_dbl_kind is a hexagon
!       polygon_type =  2.0_dbl_kind is a Northern or Southern Hemisphere pentagon
!       polygon_type =  3.0_dbl_kind is the north pole
!       polygon_type =  4.0_dbl_kind is the south pole
!       polygon_type = -1.0_dbl_kind is a wrapped grid cell
!
!       grid_center_mask = 1.0_dbl_kind is a real grid cell
!       grid_center_mask = 0.0_dbl_kind is a wrapped grid cell
!
! NOTE : the following routines must be called before this routine
!       specify_mpi_communicator
!       specify_mpi_precision
!       set_assign_owner
!       initialize_wrap
!-----------------------------------------------------------------------

        implicit none

        integer (kind=int_kind), intent(in) ::                        &
           im, jm, iim, jjm, nsdm
        character(*), intent(in) :: component_name
        real (kind=dbl_kind), intent(out) ::                            &
                grid_center_mask      (          iim, jjm, nsdm),       &
                polygon_type          (          iim, jjm, nsdm)          

        integer (kind=int_kind), intent(out) ::                         &
                grid_center_index  (          iim, jjm, nsdm)

        integer (kind = int_kind) :: i, j, kdsm, panel, ii, ksdm, icount    

        real (kind = dbl_kind) ::                                     &
                        work(im,jm), work_1(iim,jjm,nsdm),            &
                        grid_index_tmp(iim,jjm,1,nsdm)

        real (kind = dbl_kind), allocatable ::                        &
                        grid_index_glbl(:,:)

!----------------------------------------------------------------------------
! keep the user informed
!----------------------------------------------------------------------------
        call output_process0(component_name, ' ' )
        call output_process0(component_name,                           &
           ' generating grid_center_mask' )

     if(im == 1) then
!-----------------------------------------------------------------------
! SCM initialization     
!-----------------------------------------------------------------------
        polygon_type(:,:,:) = 1.0_dbl_kind
        grid_center_mask(:,:,:) = 1.0_dbl_kind
        grid_center_index(:,:,:) = 1
     else 
!-----------------------------------------------------------------------
! initialize to zero
!-----------------------------------------------------------------------
        polygon_type(:,:,:) = 0.0_dbl_kind
        grid_center_mask(:,:,:) = 0.0_dbl_kind
        grid_center_index(:,:,:) = 0

!-----------------------------------------------------------------------
! generate an index listing
!-----------------------------------------------------------------------
          allocate(grid_index_glbl(im,jm))
          grid_index_glbl = 0.0_dbl_kind
          grid_index_glbl(1,jm-1) = 1.0_dbl_kind
          grid_index_glbl(im-1,1) = 2.0_dbl_kind
          icount=2
          DO j = 2,jm-1
            DO panel = 0,4
              DO i = 2,im/5-1
                 icount=icount+1
                 ii = im/5*panel+i
                 grid_index_glbl(ii,j)=icount
              ENDDO
            ENDDO
          ENDDO

!-----------------------------------------------------------------------
! scatter the global index across all processors
!-----------------------------------------------------------------------
        call scatter(component_name,                   &
                    im, jm, iim, jjm, 1, nsdm,         &
                    grid_index_glbl, grid_index_tmp)
        deallocate(grid_index_glbl)
        call wrap( component_name, face=grid_index_tmp(:,:,:,:))
        grid_center_index(:,:,:) = nint(grid_index_tmp(:,:,1,:))

!-----------------------------------------------------------------------
! compute the "polygon_type" array
!-----------------------------------------------------------------------
 	call compute_polygon_type(component_name,          &
                         im,jm,iim,jjm,nsdm,polygon_type(:,:,:))

!-----------------------------------------------------------------------
! set grid mask
!-----------------------------------------------------------------------
        where(polygon_type.gt.0.0_dbl_kind) grid_center_mask = 1.0_dbl_kind

!-----------------------------------------------------------------------
! diagnostics
!-----------------------------------------------------------------------
        call output_process0(component_name, ' ' )
        call output_process0(component_name,                           &
           ' diagnostics for grid_center_mask' )
        call output_process0(component_name,                           &
           ' each process writes out the number of "real" cells owned' )

        call output_all_in_order(component_name,                       &
           ' sum of centers  ',msg_dbl=sum(grid_center_mask) )
        call output_all_in_order(component_name,                       &
           ' sum polygon_type  ',msg_dbl=sum(polygon_type) )
        call output_all_in_order(component_name,                       &
           ' maxval polygon_type  ',msg_dbl=maxval(polygon_type) )


! the following code was replaced by the above code
!        if(my_task.eq.0) then
!        write(6,*)
!        write(6,*) ' diagnostics for grid_center_mask'
!       write(6,*) ' each process writes out the number of "real" cells owned' 
!       endif
!       do i=0,npe-1
!       if(my_task.eq.i) then
!       write(6,*) ' ****  ',my_task, 'sum of centers ', sum(grid_center_mask)
!       write(6,*) ' ****  ',my_task, 'polygon_type   ', sum(polygon_type),    &
!                                                        maxval(polygon_type)
!
!       endif
!#if mpi == 1
!       CALL MPI_BARRIER (communicator, ierr)
!#endif
!       enddo
!#if mpi == 1
!       CALL MPI_BARRIER (communicator,ierr)
!#endif

     endif
!----------------------------------------------------------------------------
! keep the user informed
!----------------------------------------------------------------------------
        call output_process0(component_name,                           &
           ' finished in set_grid_center_mask' )
        call output_process0(component_name, ' ' )

        end subroutine set_grid_center_mask
!======================================================================
! END SET_GRID_CENTER_MASK
!======================================================================


!======================================================================
! BEGIN SET_GRID_CORNER_MASK
!======================================================================
        subroutine set_grid_corner_mask(component_name,                      &
                                    ncorners, iim, jjm, nsdm,  &
                                    grid_center_index,                       &
                                    grid_corner_mask, grid_corner_index )

!-----------------------------------------------------------------------
! PURPOSE : all values of grid_corner_mask = 1.0_dbl_kind imply
!       that velocity will be prognosted at that corner
!
! NOTE : a grid cell center may be of the wrapped variety and it can
!       have corners that prognose velocity
!-----------------------------------------------------------------------

        implicit none

        integer (kind=int_kind), intent(in) ::                        &
           iim, jjm, ncorners, nsdm

        integer (kind=int_kind), intent(in) ::                         &
                grid_center_index  ( iim, jjm, nsdm) 

        character(*), intent(in) :: component_name

        real (kind=dbl_kind), intent(out) ::                            &
                grid_corner_mask      (ncorners, iim, jjm, nsdm)

        integer (kind=int_kind), intent(out) ::                         &
                grid_corner_index  (ncorners, iim, jjm, nsdm) 

        real (kind=dbl_kind) :: tmp(1,ncorners,iim,jjm,1,nsdm)
        integer (kind=int_kind) :: i,j

!----------------------------------------------------------------------------
! keep the user informed
!----------------------------------------------------------------------------
        call output_process0(component_name, ' ' )
        call output_process0(component_name,                           &
           ' generating mask in set_grid_corner_mask' )


     if(nsdm == 1) then
!-----------------------------------------------------------------------
! SCM initialization     
!-----------------------------------------------------------------------
        grid_corner_mask(:,:,:,:) = 1.0_dbl_kind
        grid_corner_index(1,:,:,:) = 1
        grid_corner_index(2,:,:,:) = 2
     else 

!-----------------------------------------------------------------------
! init to zero
!-----------------------------------------------------------------------
        grid_corner_mask(:,:,:,:) = 0.0_dbl_kind
        grid_corner_index(:,:,:,:) = 0

!-----------------------------------------------------------------------
! all cells not on the boundary of the panel own 2 corners
!-----------------------------------------------------------------------
        grid_corner_mask(:,2:iim-1,2:jjm-1,:) = 1.0_dbl_kind

!-----------------------------------------------------------------------
! diagnostics
!-----------------------------------------------------------------------
        call output_process0(component_name, ' ' )
        call output_process0(component_name,                           &
           ' diagnostics for grid_corner_mask' )
        call output_process0(component_name,                           &
           ' each process writes out the number of "real" cells owned' )

        call output_all_in_order(component_name,                       &
           ' sum of corners  ',msg_dbl=sum(grid_corner_mask) )

! the following code was replaced by the above code
!        if(my_task.eq.0) then
!        write(6,*)
!        write(6,*) ' diagnostics for grid_corner_mask'
!       write(6,*) ' each process writes out the number of "real" corners owned' !       endif
!        do i=0,npe-1
!        if(my_task.eq.i) then
!        write(6,*) ' ****  ',my_task, 'sum of corners ', sum(grid_corner_mask)
!        endif
!#if mpi == 1
!        CALL MPI_BARRIER (communicator,ierr)
!#endif
!        enddo
!#if mpi == 1
!        CALL MPI_BARRIER (communicator,ierr)
!#endif



!-----------------------------------------------------------------------
! set the grid_corner_index
!-----------------------------------------------------------------------
        where(grid_center_index(:,:,:) > 2) 
          grid_corner_index(1,:,:,:) = ((grid_center_index(:,:,:)-3)*2) + 1
          grid_corner_index(2,:,:,:) = ((grid_center_index(:,:,:)-3)*2) + 2
        endwhere
        tmp(1,:,:,:,1,:) = grid_corner_index(:,:,:,:)
        call wrap(component_name, vrtx=tmp(:,:,:,:,:,:))
        grid_corner_index(:,:,:,:) = nint(tmp(1,:,:,:,1,:))


endif

!----------------------------------------------------------------------------
! keep the user informed
!----------------------------------------------------------------------------
        call output_process0(component_name,                           &
           ' finished in set_grid_corner_mask' )
        call output_process0(component_name, ' ' )

        end subroutine set_grid_corner_mask
!======================================================================
! END SET_GRID_CORNER_MASK
!======================================================================


!======================================================================
! BEGIN SET_CENTER_ORDERING
!======================================================================
        subroutine set_center_ordering(component_name,                 &
                           ndata, ncorners, iim, jjm, nsdm,            &
                           subzone_shift, grid_center_mask,            &
                           grid_center_index, grid_corner_mask,        &
                           grid_corner_index )

!-----------------------------------------------------------------------
! PURPOSE : find the ordering of cell centers surrounding the corners
!
! This data info is used to wrap subzone data structures
!-----------------------------------------------------------------------

        implicit none

        integer (kind=int_kind), intent(in) ::                        &
           iim, jjm, nsdm, ncorners, ndata
        character(*), intent(in) :: component_name

        real (kind=dbl_kind), intent(in) ::                             &
                grid_center_mask      (          iim, jjm, nsdm),       &
                grid_corner_mask      (ncorners, iim, jjm, nsdm)

        integer (kind=int_kind), intent(in) ::                          &
                grid_center_index  (          iim, jjm, nsdm),          &
                grid_corner_index  (ncorners, iim, jjm, nsdm)
        integer (kind=int_kind), intent(out) ::                         &
                subzone_shift      (ncorners, iim, jjm, nsdm)
        
        integer (kind=int_kind) :: i,j,icorner, ksdm
        real (kind=dbl_kind) :: local_ordering (ndata,ncorners,iim,jjm,nsdm)
        real (kind=dbl_kind) :: center_ordering(ndata,ncorners,iim,jjm,nsdm)
        real (kind=dbl_kind) :: t(ndata)
        logical (kind=log_kind) :: test

!----------------------------------------------------------------------------
! keep the user informed
!----------------------------------------------------------------------------
        call output_process0(component_name, ' ' )
        call output_process0(component_name,                           &
           ' generating center ordering info' )

!-----------------------------------------------------------------------
! init to zero
!-----------------------------------------------------------------------
        center_ordering = 0.0_dbl_kind
        local_ordering  = 0.0_dbl_kind
        subzone_shift   = 0

!-----------------------------------------------------------------------
! set the ordering for real corners
!-----------------------------------------------------------------------
         do ksdm=1,nsdm
           do j=2,jjm
             do i=2,iim
               do icorner=1,ncorners
                 if(grid_corner_mask(icorner,i,j,ksdm)==1.0_dbl_kind) then
                   if(icorner==1) then
                     center_ordering(1,icorner,i,j,ksdm) =                  &
                        grid_center_index(i,j,ksdm)
                     center_ordering(2,icorner,i,j,ksdm) =                  &
                        grid_center_index(i-1,j,ksdm)
                     center_ordering(3,icorner,i,j,ksdm) =                  &
                        grid_center_index(i-1,j-1,ksdm) 
                   else
                     center_ordering(1,icorner,i,j,ksdm) =                  &
                        grid_center_index(i,j,ksdm)
                     center_ordering(2,icorner,i,j,ksdm) =                  &
                        grid_center_index(i-1,j-1,ksdm)
                     center_ordering(3,icorner,i,j,ksdm) =                  &
                        grid_center_index(i,j-1,ksdm) 
                   endif
                 endif
               enddo
             enddo
           enddo
         enddo
         
         
!-----------------------------------------------------------------------
! wrap this data structure
!-----------------------------------------------------------------------            
         call wrap(component_name, vrtx_1L=center_ordering(:,:,:,:,:))
         
!-----------------------------------------------------------------------
! look at local grid center ordering
!-----------------------------------------------------------------------
         do ksdm=1,nsdm
         do j=2,jjm
         do i=2,iim
            do icorner=1,ncorners
              if(icorner==1) then
                 local_ordering(1,icorner,i,j,ksdm) =                  &
                   grid_center_index(i,j,ksdm)
                 local_ordering(2,icorner,i,j,ksdm) =                  &
                   grid_center_index(i-1,j,ksdm)
                 local_ordering(3,icorner,i,j,ksdm) =                  &
                   grid_center_index(i-1,j-1,ksdm) 
               else
                 local_ordering(1,icorner,i,j,ksdm) =                  &
                   grid_center_index(i,j,ksdm)
                 local_ordering(2,icorner,i,j,ksdm) =                  &
                   grid_center_index(i-1,j-1,ksdm)
                 local_ordering(3,icorner,i,j,ksdm) =                  &
                   grid_center_index(i,j-1,ksdm) 
               endif
             enddo
         enddo
         enddo
         enddo
      
!-----------------------------------------------------------------------
! add poles to local ordering
!-----------------------------------------------------------------------

         do ksdm = 1, nsdm
            i = 1
            j = jjm-1
         
            if(grid_center_mask(i,j,ksdm)==c1) then
               icorner=1
               local_ordering(1,icorner,i,j,ksdm) =                  &
                  grid_center_index(i,j,ksdm)
               local_ordering(2,icorner,i,j,ksdm) =                  &
                  grid_center_index(i,j+1,ksdm)
               local_ordering(3,icorner,i,j,ksdm) =                  &
                  grid_center_index(iim,1,ksdm)
               icorner=2
               local_ordering(1,icorner,i,j,ksdm) =                  &
                  grid_center_index(i,j,ksdm)
               local_ordering(2,icorner,i,j,ksdm) =                  &
                  grid_center_index(iim,1,ksdm)
               local_ordering(3,icorner,i,j,ksdm) =                  &
                  grid_center_index(i,j-1,ksdm)
            endif

            i = iim-1
            j = 1

            if(grid_center_mask(i,j,ksdm)==c1) then
               icorner=1
               local_ordering(1,icorner,i,j,ksdm) =                  &
                  grid_center_index(i,j,ksdm)
               local_ordering(2,icorner,i,j,ksdm) =                  &
                  grid_center_index(i-1,j,ksdm)
               local_ordering(3,icorner,i,j,ksdm) =                  &
                  grid_center_index(1,jjm,ksdm)
               icorner=2
               local_ordering(1,icorner,i,j,ksdm) =                  &
                  grid_center_index(i,j,ksdm)
               local_ordering(2,icorner,i,j,ksdm) =                  &
                  grid_center_index(1,jjm,ksdm)
               local_ordering(3,icorner,i,j,ksdm) =                  &
                  grid_center_index(i+1,j,ksdm)
            endif

         enddo                  ! ksdm

!-----------------------------------------------------------------------
! see where the structures are different
!-----------------------------------------------------------------------
         do ksdm=1,nsdm
         do j=2,jjm
         do i=2,iim
         do icorner=1,ncorners

!-----------------------------------------------------------------------
! filter out those points we do not need to do
!-----------------------------------------------------------------------
           if(i==1   .and. j==1) cycle
           if(i==iim .and. j==2  .and. icorner==2 .and. grid_center_mask(i-1,j-1,ksdm)==0) cycle
           if(i==2   .and. j==jjm.and. icorner==1 .and. grid_center_mask(i-1,j-1,ksdm)==0) cycle
           if(i==1   .and. grid_center_mask(i  ,j  ,ksdm)==0 &
                     .and. grid_center_mask(i,j-1,  ksdm)==0   )  cycle
           if(j==1   .and. grid_center_mask(i  ,j  ,ksdm)==0 &
                     .and. grid_center_mask(i-1,j  ,ksdm)==0   ) cycle

            test=.false.
            do while (.not.test)
               t(:) = local_ordering(:,icorner,i,j,ksdm)               &
                   - center_ordering(:,icorner,i,j,ksdm)
               if(maxval(t) > 1.0e-13) then
                  center_ordering(:,icorner,i,j,ksdm) =   &
                  cshift(center_ordering(:,icorner,i,j,ksdm),shift=1)
                  subzone_shift(icorner,i,j,ksdm) =                    &
                                 subzone_shift(icorner,i,j,ksdm) + 1
                  if(subzone_shift(icorner,i,j,ksdm)==ndata) then
                     test=.true.
                     subzone_shift(icorner,i,j,ksdm)=0
                     write(6,*) ' punting on',icorner,i,j,ksdm,iim,jjm,nsdm
                     write(6,*) local_ordering(:,icorner,i,j,ksdm)
                     write(6,*) center_ordering(:,icorner,i,j,ksdm)
                     write(6,*)
                     stop
                  endif
               else
                  test=.true.
               endif
            enddo
         enddo
         enddo
         enddo
         enddo

         call wrap(component_name, vrtx_1L=center_ordering(:,:,:,:,:))

!-----------------------------------------------------------------------
! diagnostics
!-----------------------------------------------------------------------
 
!----------------------------------------------------------------------------
! keep the user informed
!----------------------------------------------------------------------------
        call output_process0(component_name,                           &
           ' finished in set_center_ordering' )
        call output_process0(component_name, ' ' )

        end subroutine set_center_ordering
!======================================================================
! END SET_CENTER_ORDERING
!======================================================================


!======================================================================
! BEGINNING OF BLOCK_MASK
!======================================================================
	subroutine block_mask(iim, jjm, nsdm,                           &
                          nsdm_empty, nsdm_not_empty, block_number, &
                          mask_array)

	implicit none

        integer (kind=int_kind), intent(in) ::                 &
           iim, jjm, nsdm
        integer (kind=int_kind), intent(out) ::                &
           nsdm_empty, nsdm_not_empty
        integer (kind=int_kind), intent(out), dimension(nsdm) ::   &
           block_number

	integer (kind=int_kind), intent(in), optional ::       &
            mask_array(iim,jjm,nsdm)


	integer (kind=int_kind) :: ksdm

 	if(present(mask_array)) then

	   write(6,*) ' mask present'
	   nsdm_empty = 0
	   nsdm_not_empty = 0
	   do ksdm = 1,nsdm
	      if(maxval(mask_array(:,:,ksdm)) == 0) then
                 nsdm_empty = nsdm_empty + 1
	      else
                 nsdm_not_empty = nsdm_not_empty + 1
                 block_number(nsdm_not_empty) = ksdm
	      endif
	   enddo

 	else

 	   write(6,*) ' mask not present'
 	   nsdm_empty = 0
 	   nsdm_not_empty = nsdm
 	   do ksdm = 1,nsdm
 	      block_number(ksdm) = ksdm
 	   enddo

 	endif

	end subroutine block_mask

        end module grid_mask
!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
