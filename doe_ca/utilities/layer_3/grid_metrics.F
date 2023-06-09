!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

        module grid_metrics

!-----------------------------------------------------------------------
! PURPOSE : find the weights required to average data from cell centers to
!   cell corners (s_weights), to compute gradients of scalar fields (v_weights),
!   and to compute the Laplacian of a scalar field (l_weights)
!
! NOTE : before generate_grid_metrics can be called the following routine must
!   be called :
!	specify_mpi_communicator
!	specify_mpi_precision
!	set_assign_owner
!	initialize_wrap
!	set_grid_center_mask
!	set_grid_corner_mask
!
! NOTE : the X1 coordinate system is global w/ origin at center of earth
!        the X2 coordinate system is local with the coordinate directions
!          pointing the local east, north, and vertical directions
!
! NOTE : public variables are commented when they are initialized
!	 see generate_grid_metrics
!
! HISTORY : 
!    15 JUN 2003 - this module was made component independent by taking 
!        module scope variables and creating a separate module with them
!        called grid_metrics_variables - dd
!-----------------------------------------------------------------------

	use kinds
	use params_physical
	use geodesic_grid_utilities
	use gather_scatter
	use wrap_data
	use grid_metrics_generator

	implicit none

        logical (kind=log_kind), parameter ::                  &
                 l_sphere = .false.

	public ::  generate_grid_metrics

!*************************************************************************

        contains

!*************************************************************************

!======================================================================
! BEGIN generate_grid_metrics
!======================================================================
      subroutine generate_grid_metrics (component_name,                     &
                iim, jjm, nsdm, im, jm, max_ig, max_level,                  &
                ndata, ncorners, nspace,                                    &
                p, c, w, area, area_inv, corner_area, corner_area_inv,      &
                sub_area, sub_area_inv, dc, normal, tangent,                &
                v_weights, s_weights, l_weights, trans_to_X2, trans_to_X1,  &
                grid_center_lon, grid_center_lat,                           &
                grid_corner_lon, grid_corner_lat,                           &
                grid_center_centroid, grid_corner_centroid,                 &
                tot_area, inv_tot_area, l_read_from_file )
      implicit none
      character(len=*), intent(in) :: component_name
      logical, intent(in), optional :: l_read_from_file

! arguments formerly in module
        integer (kind=int_kind), intent(in) ::                              &
                iim, jjm, nsdm, im, jm, max_ig, max_level,                  &
                ndata, ncorners, nspace

 	real (kind=dbl_kind), intent(out) ::                                &
      		p              (           r3,           iim, jjm, nsdm),   &
      		c              (           r3, ncorners, iim, jjm, nsdm),   &
                w              (ndata,     r3, ncorners, iim, jjm, nsdm),   &
      		area           (                         iim, jjm, nsdm),   &
      		area_inv       (                         iim, jjm, nsdm),   &
                corner_area    (               ncorners, iim, jjm, nsdm),   &
      		corner_area_inv(               ncorners, iim, jjm, nsdm),   &
                sub_area       (ndata,         ncorners, iim, jjm, nsdm),   &
                sub_area_inv   (ndata,         ncorners, iim, jjm, nsdm),   &
                dc             (ndata,         ncorners, iim, jjm, nsdm),   &
      		normal         (ndata,     r3, ncorners, iim, jjm, nsdm),   &
      		tangent        (ndata,     r3, ncorners, iim, jjm, nsdm)

 	real (kind=dbl_kind), intent(out) ::                                &
                v_weights      (ndata, nspace, ncorners, iim, jjm, nsdm),   &
      		s_weights      (ndata,         ncorners, iim, jjm, nsdm),   &
      	        l_weights      (nweights,                iim, jjm, nsdm)

 	real (kind=dbl_kind), intent(out) ::                                &
                trans_to_X2 (r3, r3, ncorners, iim, jjm, nsdm),             &
                trans_to_X1 (r3, r3, ncorners, iim, jjm, nsdm)

 	real (kind=dbl_kind), intent(out) ::                                &
                grid_center_lon    (           iim, jjm, nsdm),             &
                grid_center_lat    (           iim, jjm, nsdm),             &
                grid_corner_lon    ( ncorners, iim, jjm, nsdm),             &
                grid_corner_lat    ( ncorners, iim, jjm, nsdm)              

 	real (kind=dbl_kind), intent(out) ::                                &
                grid_center_centroid(r3,iim, jjm, nsdm),             &
                grid_corner_centroid(r3,ncorners,iim,jjm,nsdm)

	real (kind=dbl_kind), intent(out) :: tot_area, inv_tot_area


! local variables
      integer (kind=int_kind) ::                                             &
         ispace, i, j, ksdm, icorner
      real (kind=dbl_kind) ::                                                &
         p_list(r3,max_ig),                                                  &
         p_tmp(       r3, im    ,jm),                                        &
         work (          iim    ,jjm, 1, nsdm),                              &
         f01, s(2)
      logical :: l_local

!-----------------------------------------------------------------------
! read data from file based on l_read_from_file
!-----------------------------------------------------------------------
        l_local = .true.
        if(present(l_read_from_file)) l_local = l_read_from_file

!-----------------------------------------------------------------------
! read in grid center data
!	the (x,y,z) point is read in
!-----------------------------------------------------------------------
        p_list = 0.0_dbl_kind
  if (max_ig .ne. 1) then
	if(l_local) then

           CALL read_grid_center_fine (component_name, max_ig, p_list)
!-----------------------------------------------------------------------
! scatter the xyz grid center locations to (im,jm) data structure and wrap
! p_tmp(r3,im,jm) holds the (x,y,z) location of each grid cell center
! measured in the X1 coordinate system
!-----------------------------------------------------------------------
	  p_tmp = 0.0_dbl_kind
          do ispace=1,3
            call scatter_to_grid_global(component_name,  im, jm, max_ig,  &
                                        p_list(ispace,:),p_tmp(ispace,:,:))
          enddo

!-----------------------------------------------------------------------
! scatter p_tmp across all processes
!-----------------------------------------------------------------------
	   do ispace = 1,3
	      call scatter(component_name, im, jm, iim, jjm, 1, nsdm, &
                            p_tmp(ispace,:,:), p(ispace,:,:,:))
	   enddo

!-----------------------------------------------------------------------
! end if over l_read_from_file
!-----------------------------------------------------------------------
	endif

!-----------------------------------------------------------------------
! wrap p
!-----------------------------------------------------------------------
	do ispace = 1,3
	  work(:,:,1,:) = p(ispace,:,:,:)
	  call wrap(component_name, face=work(:,:,:,:))
	  p(ispace,:,:,:) = work(:,:,1,:)
	enddo
  endif

      CALL generate_grid_metrics_level ( component_name, l_sphere,           &
                            r2,r3,ndata,nspace,ncorners,nweights,            &
                            max_level,im,jm,max_ig,iim,jjm,nsdm,             &
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
                            grid_center_centroid, grid_corner_centroid)

    if(max_ig .ne. 1) then
!-----------------------------------------------------------------------
! wrap corners and grid_corner_centroid
!-----------------------------------------------------------------------
	call wrap(component_name, vrtx_1L=c(:,:,:,:,:))
        call wrap(component_name, vrtx_1L=grid_corner_centroid(:,:,:,:,:))

!-----------------------------------------------------------------------
! recompute grid_center_{lon,lat} and  grid_corner_{lon,lat} with wrapped corners
!-----------------------------------------------------------------------
        do ksdm=1,nsdm
        do j=1,jjm
        do i=1,iim
          call xyz_to_lonlat(p(:,i,j,ksdm),s(:))
          grid_center_lon(i,j,ksdm) = s(1)
          grid_center_lat(i,j,ksdm) = s(2)
          do icorner=1,ncorners
            call xyz_to_lonlat(c(:,icorner,i,j,ksdm),s(:))
            grid_corner_lon(icorner,i,j,ksdm) = s(1)
            grid_corner_lat(icorner,i,j,ksdm) = s(2)
          enddo
        enddo
        enddo
        enddo

!-----------------------------------------------------------------------
! wrap grid_center_centroid
!-----------------------------------------------------------------------
        do ispace = 1,3
          work(:,:,1,:) = grid_center_centroid(ispace,:,:,:)
          call wrap(component_name, face=work(:,:,:,:))
          grid_center_centroid(ispace,:,:,:) = work(:,:,1,:)
        enddo
      endif

      end subroutine generate_grid_metrics
!======================================================================
! END generate_grid_metrics
!======================================================================

        end module grid_metrics
!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
