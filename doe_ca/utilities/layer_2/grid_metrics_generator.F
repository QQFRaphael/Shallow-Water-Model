!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

        module grid_metrics_generator

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
!
! NOTE : the X1 coordinate system is global w/ origin at center of earth
!        the X2 coordinate system is local with the coordinate directions
!          pointing the local east, north, and vertical directions
!
! NOTE : public variables are commented when they are initialized
!	 see generate_grid_metrics
!-----------------------------------------------------------------------

	use kinds
 	use global_reductions
 	use component_intra
	use params_physical
	use output_utilities
	use geodesic_grid_utilities
	use gather_scatter
	use params_scm
        use wrap_data

	implicit none
        private

        integer (kind=int_kind) :: ierr

! public member functions
	public ::  generate_grid_metrics_level,                             &
                   read_grid_center_fine,                                   &
                   compute_polygon_type


!*************************************************************************

        contains

!*************************************************************************

!======================================================================
! BEGIN generate_grid_metrics_level
!======================================================================
      subroutine generate_grid_metrics_level (                               &
                            component_name,                                  &
                            l_sphere,                                        &
                            r2,r3,ndata,nspace,ncorners,nweights,            &
                            level,im,jm,max_ig,iim,jjm,nsdm,                 &
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
      implicit none

      logical (kind=log_kind), intent(in) ::                                 &
         l_sphere

      integer (kind=int_kind), intent(in) ::                                 &
         r2,r3,ndata,nspace,ncorners,nweights,                               &
         level,im,jm,max_ig,iim,jjm,nsdm

      character(*), intent(in) ::                                            &
         component_name

      integer (kind=int_kind) ::                                             & 
         i,j,k,l,                                                            &
         idata,icorner,ispace,igrid,ksdm

      real (kind=dbl_kind),intent( in) ::                                    &
         p              (           r3,           iim, jjm, nsdm)

      real (kind=dbl_kind),intent(out) ::                                    &
         c              (           r3, ncorners, iim, jjm, nsdm),           &
         w              (ndata,     r3, ncorners, iim, jjm, nsdm),           &
      	 area           (                         iim, jjm, nsdm),           &
      	 area_inv       (                         iim, jjm, nsdm),           &
         corner_area    (               ncorners, iim, jjm, nsdm),           &
      	 corner_area_inv(               ncorners, iim, jjm, nsdm),           &
         sub_area       (ndata,         ncorners, iim, jjm, nsdm),           &
         sub_area_inv   (ndata,         ncorners, iim, jjm, nsdm),           &
         dc             (ndata,         ncorners, iim, jjm, nsdm),           &
      	 normal         (ndata,     r3, ncorners, iim, jjm, nsdm),           &
      	 tangent        (ndata,     r3, ncorners, iim, jjm, nsdm),           &
         v_weights      (ndata, nspace, ncorners, iim, jjm, nsdm),           &
      	 s_weights      (ndata,         ncorners, iim, jjm, nsdm),           &
      	 l_weights      (nweights,                iim, jjm, nsdm),           &
         trans_to_X2    (       r3, r3, ncorners, iim, jjm, nsdm),           &
         trans_to_X1    (       r3, r3, ncorners, iim, jjm, nsdm),           &
         grid_center_lon(                         iim, jjm, nsdm),           &
         grid_center_lat(                         iim, jjm, nsdm),           &
         grid_corner_lon(               ncorners, iim, jjm, nsdm),           &
         grid_corner_lat(               ncorners, iim, jjm, nsdm),           &  
         tot_area,inv_tot_area,f01

      real (kind=dbl_kind),allocatable ::                                    &
         X1(:,:),X2(:,:),                                                    &
         polygon_type(:,:,:),metrics_mask(:,:,:,:),                          &
         grid_center_mask(:,:,:),                                            &
         grid_corner_mask(:,:,:,:),                                          &
         t(:,:),r(:,:),h(:,:),g(:),m(:)

      real (kind=dbl_kind) :: &
         grid_center_centroid(      r3,           iim, jjm, nsdm),           &
         grid_corner_centroid(      r3, ncorners, iim, jjm, nsdm),           &
         sub_area_centroid   (ndata,r3, ncorners, iim, jjm, nsdm),           &
         tem_c               ( r3 )

      real (kind=dbl_kind) ::                                                &
         f1,f2,s(2)

!-----------------------------------------------------------------------
! initialize output arrays
!-----------------------------------------------------------------------
	c               =  0.0_dbl_kind		! (x,y,z) of grid corners (m)
	w               =  0.0_dbl_kind		! (x,y,z) of grid wall midpoint (m)
	area            =  0.0_dbl_kind		! area of grid cells (m^2)
	area_inv        =  0.0_dbl_kind		! 1/area (m^-2)
	corner_area     =  0.0_dbl_kind		! area associated with grid corners (m^2)
	corner_area_inv =  0.0_dbl_kind		! 1/corner_area (m^-2)
	sub_area        =  0.0_dbl_kind		! corner_area separated into 3 parts (m^2)
        sub_area_inv    =  0.0_dbl_kind         ! inverse of sub_area
	dc              =  0.0_dbl_kind		! length of wall segments (m)
	normal          =  0.0_dbl_kind		! unit vectors normal to cell wall segments 
	tangent         =  0.0_dbl_kind		! unit vectors parallel to cell wall segments
	s_weights       =  0.0_dbl_kind		! weights for averaging scalars to corners
	v_weights       =  0.0_dbl_kind		! weights for computing div,curl,grad
	l_weights       =  0.0_dbl_kind		! weights for computing Laplacian at grid centers
	trans_to_X1     =  0.0_dbl_kind		! (3,3) matrix to transform into X1
	trans_to_X2     =  0.0_dbl_kind		! (3,3) matrix to transform into X2
	grid_center_lon =  0.0_dbl_kind         ! longitude (radians) of grid center
	grid_center_lat =  0.0_dbl_kind         ! latitude (radians) of grid center
	grid_corner_lon =  0.0_dbl_kind         ! longitude (radians) of grid corner
	grid_corner_lat =  0.0_dbl_kind         ! latitude (radians) of grid corner
        grid_center_centroid = 0.0_dbl_kind
        grid_corner_centroid = 0.0_dbl_kind
        sub_area_centroid    = 0.0_dbl_kind

   if(max_ig == 1) then
!SCM case
	 grid_center_lon =  lon_scm * pi / 180.
	 grid_center_lat =  lat_scm * pi / 180.
	 grid_corner_lon =  lon_scm * pi / 180.
	 grid_corner_lat =  lat_scm * pi / 180.
         grid_center_centroid = lon_scm * pi / 180.
         grid_corner_centroid = lat_scm * pi / 180.
         sub_area_centroid    = c1
  	 area            =  c1 
 	 area_inv        =  c1
 	 corner_area     =  c1
 	 corner_area_inv =  c1
 	 sub_area        =  c1
        sub_area_inv    =  0.0_dbl_kind
   else
! global model case
      allocate (                                                             &
         X1(r3,r3),                                                          &
         X2(r3,r3),                                                          &
         polygon_type(iim,jjm,nsdm),                                         &
         grid_center_mask(iim,jjm,nsdm),                                     &
         grid_corner_mask(ncorners,iim,jjm,nsdm),                            &
         metrics_mask(ncorners,iim,jjm,nsdm),                                &
         t(ndata,r3),r(ndata,r3),h(ndata,r3),                                &
         g(r3),m(ndata))

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! initialize all work arrays
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	 X1 = 0.0_dbl_kind
	 X2 = 0.0_dbl_kind
	 polygon_type = 0.0_dbl_kind
         grid_center_mask = 0.0_dbl_kind
         grid_corner_mask = 0.0_dbl_kind
	 metrics_mask = 0.0_dbl_kind
	 h  = 0.0_dbl_kind
	 r  = 0.0_dbl_kind
	 t  = 0.0_dbl_kind
	 g  = 0.0_dbl_kind
	 m  = 0.0_dbl_kind

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! define the polygon type, define grid_center_mask and grid_corner_mask
!   (the mask definitions are local)
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      call compute_polygon_type(component_name,                        &
                                im,jm,iim,jjm,nsdm,polygon_type) 
      where(polygon_type.gt.0.0_dbl_kind) grid_center_mask = 1.0_dbl_kind
      grid_corner_mask(:,2:iim-1,2:jjm-1,:) = 1.0_dbl_kind

!-----------------------------------------------------------------------
! set the metrics mask
!   assume all data in (2:iim,2:jjm) exist
!   delete corner 1 of midlatitude pentagon neighbor up and right
!   delete corner 2 at (iim,2) if (iim-1,1,1) is not the SP
!   delete corner 1 at (2,jjm) if (1,jjm-1,1) is not the NP
!   add in both corners for North Pole and South Pole
!-----------------------------------------------------------------------
	metrics_mask(:,2:iim,2:jjm,:) = 1.0_dbl_kind
	metrics_mask(2,iim,2,:) = 0.0_dbl_kind
	metrics_mask(1,2,jjm,:) = 0.0_dbl_kind
	do ksdm=1,nsdm
	do j=1,jjm
	do i=1,iim
	if(polygon_type(i,j,ksdm) == 2.0_dbl_kind) then
	  metrics_mask(1,i+1,j+1,ksdm) = 0.0_dbl_kind
	endif
        if(polygon_type(i,j,ksdm) == 3.0_dbl_kind) then
          metrics_mask(:,i,j,ksdm) = 1.0_dbl_kind
          metrics_mask(1,i+1,j+1,ksdm) = 1.0_dbl_kind
        endif
        if(polygon_type(i,j,ksdm) == 4.0_dbl_kind) then
          metrics_mask(:,i,j,ksdm) = 1.0_dbl_kind
          metrics_mask(2,i+1,j+1,ksdm) = 1.0_dbl_kind
        endif
	enddo
	enddo
	enddo

!----------------------------------------------------------------------------
! keep the user informed
!----------------------------------------------------------------------------
        call output_process0(component_name, ' ' )
        call output_process0(component_name,                           &
           '-------------------------------------------------------' )
        call output_process0(component_name,                           &
           ' generating operator weights in generate_grid_metrics' )
        call output_process0(component_name,                           &
           ' for resolution : ',msg_int=max_ig )

!-----------------------------------------------------------------------
! the X1 coordinate system has its origin defined at the center of the 
! sphere. the e1, e2, and e3 directions do not vary in space, i.e. the 
! X1 coordinate system is global
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
! define the e1 direction
!-----------------------------------------------------------------------
	X1(1,1) = 1.0_dbl_kind
	X1(1,2) = 0.0_dbl_kind
	X1(1,3) = 0.0_dbl_kind

!-----------------------------------------------------------------------
! define the e2 direction
!-----------------------------------------------------------------------
	X1(2,1) = 0.0_dbl_kind
	X1(2,2) = 1.0_dbl_kind
	X1(2,3) = 0.0_dbl_kind

!-----------------------------------------------------------------------
! define the e3 direction
!-----------------------------------------------------------------------
	X1(3,1) = 0.0_dbl_kind
	X1(3,2) = 0.0_dbl_kind
	X1(3,3) = 1.0_dbl_kind
	
!-----------------------------------------------------------------------
! loop over every corner and do the following operations
!   1) first, place the surrounding 3 cell centers into a temporary array (t)
!   2) compute the Voronoi corner for the set of 3 points held in array t
!   3) find the (x,y,z) location of the cell wall center (w)
!   4) find the local east, north, and vertical directions (measured in X1)
!   5) do a coordinate transformation into the X2 coordinate system
!		X2 is a local coordinate system which has unit vectors
!		pointing in the east, north, and vertical directions
!   6) find the vectors normal and along the cell walls (measured in X2)
!   4) compute the spherical sub_area
!   5) add these areas together to compute the corner area
!-----------------------------------------------------------------------
	do ksdm = 1,nsdm
	do j=1,jjm
	  do i=1,iim
	    do icorner = 1,ncorners
	      if(metrics_mask(icorner,i,j,ksdm) == 1.0_dbl_kind) then

!-----------------------------------------------------------------------
! get surrounding locations in xyz (measured in X1)
!-----------------------------------------------------------------------
	        do ispace = 1,r3
	          call get_surrounding_centers(      &
                           i,                        &
                           j,                        &
                           icorner,                  &
                           ndata,                    &
      			   iim,                      &
                           jjm,                      &
                           polygon_type(i,j,ksdm),   &
                           p(ispace,:,:,ksdm),       &
                           m(:) )
	          t(:,ispace) = m(:)
	        enddo

!-----------------------------------------------------------------------
! compute the Voronoi corner (measured in X1)
!   if l_sphere = .true., the voronoi corner is normalized to unit sphere
!   if l_sphere = .false., the voronoi corner lies on the plane fitting t
!-----------------------------------------------------------------------
 	      call compute_voronoi_corner(          &
                           l_sphere,                &
                           .true.,                  &
                           t(1,:),                  &
                           t(2,:),                  &
                           t(3,:),                  &
                           c(:,icorner,i,j,ksdm) )

!-----------------------------------------------------------------------
! compute the centriod of the corner triangle
!-----------------------------------------------------------------------
              call find_centroid_of_triangle(t(1,:),t(2,:),t(3,:), &
                       grid_corner_centroid(:,icorner,i,j,ksdm) )

!-----------------------------------------------------------------------
! find the vectors (measured in X1) that point in the local
!   east (h(1,:)), north (h(2,:)), and vertical (h(3,:)) direction
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
! the vector pointing from the origin of X1 (center of earth) to the
! location of the cell corner defines the local vertical direction.
! measured in X1
!-----------------------------------------------------------------------
              h(3,:) = c(:,icorner,i,j,ksdm)
	      call unit_vector_in_3space(h(3,:))

!-----------------------------------------------------------------------
! g(:) is a work array and holds the vector pointing to the North Pole.
! measured in X1
!-----------------------------------------------------------------------
              g(:) = X1(3,:) 

!-----------------------------------------------------------------------
! find the vector that is perpendicular to the local vertical vector
! and points in the direction of of the North pole, this defines the local
! north direction. measured in X1
!-----------------------------------------------------------------------
              call vector_on_tangent_plane ( h(3,:), g(:), h(2,:) )

!-----------------------------------------------------------------------
! take the cross product of the local North direction and the local vertical
! to find the local east vector. still in X1
!-----------------------------------------------------------------------
              call cross_product_in_3space ( h(2,:), h(3,:), h(1,:) )

!-----------------------------------------------------------------------
! put these 3 vectors into a matrix X2
!-----------------------------------------------------------------------
              X2(1,:) = h(1,:)              ! local east     (measured in X1)
              X2(2,:) = h(2,:)              ! local north    (measured in X1)
              X2(3,:) = h(3,:)              ! local vertical (measured in X1)

!-----------------------------------------------------------------------
! compute the transformation matrices
!    trans_to_X2 transforms vector components measured in X1 into X2
!    trans_to_X1 transforms vector components measured in X2 into X1
!-----------------------------------------------------------------------
              trans_to_X2(:,:,icorner,i,j,ksdm) = matmul(X2,transpose(X1))
	      trans_to_X1(:,:,icorner,i,j,ksdm) = matmul(X1,transpose(X2))

!-----------------------------------------------------------------------
! loop over ndata to find the cell wall center, normal vector, and tangent vector
!-----------------------------------------------------------------------
	      do k=1,ndata
	        l = k + 1
	        if(l == ndata+1) l=1

!-----------------------------------------------------------------------
! find the location of the cell wall center. measured in X1
!   if l_sphere, then w will lie on the unit sphere
!   if not l_sphere, the w lies along the line connecting t(k,:) and t(l,:)
!-----------------------------------------------------------------------
	          r(k,:) =  p5 * ( t(k,:) + t(l,:) )
                  if(l_sphere) then
	            call unit_vector_in_3space(r(k,:))
	          endif
                  w(k,:,icorner,i,j,ksdm) = r(k,:)

!-----------------------------------------------------------------------
! find the tangent vector (points from the cell wall center to the cell
! corner. this is measured in X1. the output of vector_on_tangent_plane
! is a vector pointing toward the cell wall center, flip it around so
! that is points to the cell corner
!-----------------------------------------------------------------------
                  if(l_sphere) then
 	            call vector_on_tangent_plane ( h(3,:), r(k,:), g(:) )
                    g(:) = -g(:)
                  else
                    g(:) = c(:,icorner,i,j,ksdm) - w(k,:,icorner,i,j,ksdm)
                    call unit_vector_in_3space(g(:))
                  endif

!-----------------------------------------------------------------------
! transform this vector to the X2 coordinate system
!-----------------------------------------------------------------------
 	          tangent(k,:,icorner,i,j,ksdm) =     &
      		      matmul(trans_to_X2(:,:,icorner,i,j,ksdm),g)
                  call unit_vector_in_3space(tangent(k,:,icorner,i,j,ksdm))

!-----------------------------------------------------------------------
! transform the local vertical into X2
! this is mainly a sanity check, g(1,2,3) should have values 
! of (0,0,1), respectively
!-----------------------------------------------------------------------
 	          g(:) = matmul(trans_to_X2(:,:,icorner,i,j,ksdm),h(3,:))

!-----------------------------------------------------------------------
! take the cross product of the tangent vector and the vertical to
! find the normal vector (measured in X2)
!-----------------------------------------------------------------------
 	          call cross_product_in_3space (        &
      	   	        tangent(k,:,icorner,i,j,ksdm),  &
      		        g(:),                           &
      		        normal(k,:,icorner,i,j,ksdm))
                  call unit_vector_in_3space(normal(k,:,icorner,i,j,ksdm))

	         enddo	! do k=1,ndata

!-----------------------------------------------------------------------
! loop over ndata again, this time to find the sub_areas and 
!    distance between corners and cell wall centers
!    note that the "t" and "r" arrays are re-used from above
!-----------------------------------------------------------------------
	        do k=1,ndata
	          l = k - 1
	          if(l == 0) l=ndata

                  if(l_sphere) then
	            call spherical_area (                     &
      	  	        t(k,:),                               &
      		        r(k,:),                               &
      		        c(:,icorner,i,j,ksdm),                &
      		        f1)

	            call spherical_area (                     &
      		        t(k,:),                               &
      		        c(:,icorner,i,j,ksdm),                &
      		        r(l,:),                               &
      		        f2)

	            sub_area(k,icorner,i,j,ksdm) = f1 + f2
                    sub_area_inv(k,icorner,i,j,ksdm) =        &
                            c1/sub_area(k,icorner,i,j,ksdm)

	            call distance_along_unit_sphere(          &
      		        r(k,:),                               &
      		        c(:,icorner,i,j,ksdm),                &
      		        dc(k,icorner,i,j,ksdm) )

                    sub_area_centroid(k,:,icorner,i,j,ksdm) = &
                      (f1*(t(k,:)+r(k,:)+c(:,icorner,i,j,ksdm))/3.0_dbl_kind + &
                       f2*(t(k,:)+r(l,:)+c(:,icorner,i,j,ksdm))/3.0_dbl_kind) *&
                       sub_area_inv(k,icorner,i,j,ksdm)

                  else

                    call compute_triangle_area (              &
                        t(k,:),                               &
                        r(k,:),                               &
                        c(:,icorner,i,j,ksdm),                &
                        f1)

                    call compute_triangle_area (              &
                        t(k,:),                               &
                        c(:,icorner,i,j,ksdm),                &
                        r(l,:),                               &
                        f2)
                     
                    sub_area(k,icorner,i,j,ksdm) = f1 + f2

                    sub_area_inv(k,icorner,i,j,ksdm) =        &
                            c1/sub_area(k,icorner,i,j,ksdm)

                    sub_area_centroid(k,:,icorner,i,j,ksdm) = &
                      (f1*(t(k,:)+r(k,:)+c(:,icorner,i,j,ksdm))/3.0_dbl_kind + &
                       f2*(t(k,:)+r(l,:)+c(:,icorner,i,j,ksdm))/3.0_dbl_kind) *&
                       sub_area_inv(k,icorner,i,j,ksdm)

                    call distance_along_a_line(               &
                        r(k,:),                               &
                        c(:,icorner,i,j,ksdm),                &
                        dc(k,icorner,i,j,ksdm) )
        
                  endif

	        enddo

!-----------------------------------------------------------------------
! sum the 3 sub_areas to compute the total corner area
!-----------------------------------------------------------------------
 	        corner_area(icorner,i,j,ksdm) =                         &
                             sum(sub_area(:,icorner,i,j,ksdm))

	        corner_area_inv(icorner,i,j,ksdm) =                     &
                             1.0_dbl_kind/corner_area(icorner,i,j,ksdm)

	      endif		! if(metrics_mask == 1.0)
	    enddo		! do icorner
	  enddo		! do i
	enddo		! do j
	enddo		! do ksdm

!-----------------------------------------------------------------------
! wrap the transformation matrices
!-----------------------------------------------------------------------
      do k = 1, r3 
         call wrap (component_name, vrtx_1L = trans_to_X1(:,k,:,:,:,:))
         call wrap (component_name, vrtx_1L = trans_to_X2(:,k,:,:,:,:)) 
      enddo 

!-----------------------------------------------------------------------
! sum the sub_areas to find the area associated with of the grid cells centers
!-----------------------------------------------------------------------
	call grid_center_area (polygon_type,ndata,ncorners,iim,jjm,nsdm,     &
      		sub_area,area_inv,area)

!-----------------------------------------------------------------------
! find the centroid of the grid cell
!-----------------------------------------------------------------------
	call find_grid_center_centroid(polygon_type,r3,ndata,ncorners,iim,jjm,nsdm,  &
                sub_area_centroid, sub_area, area_inv, grid_center_centroid)

!-----------------------------------------------------------------------
! convert metrics into dimensions of Earth
!-----------------------------------------------------------------------
 	dc = dc * a
 	sub_area = sub_area * a * a
	sub_area_inv = sub_area_inv / (a * a)
 	corner_area = corner_area * a * a
 	corner_area_inv = corner_area_inv / ( a * a)
 	area = area * a * a
 	area_inv = area_inv / (a * a)

!-----------------------------------------------------------------------
! compute total area
!-----------------------------------------------------------------------
	tot_area = global_real_sum(area,grid_center_mask, &
      			iim*jjm*nsdm, component_name)

	inv_tot_area = c1/tot_area
        call output_process0(component_name,                           &
           ' total area at this resolution : ',                        &
           msg_dbl= tot_area )

!-----------------------------------------------------------------------
! compute weights to average scalars from cell centers to cell corners
!-----------------------------------------------------------------------
	do ksdm=1,nsdm
	do j=1,jjm
	do i=1,iim
	  call xyz_to_lonlat(p(:,i,j,ksdm),s(:))
	  grid_center_lon(i,j,ksdm) = s(1)
	  grid_center_lat(i,j,ksdm) = s(2)
	  do icorner=1,ncorners
	    tem_c(:) = c(:,icorner,i,j,ksdm)
     	    if(grid_corner_mask(icorner,i,j,ksdm) == c1)      &
                         call unit_vector_in_3space ( tem_c(:) )
	    call xyz_to_lonlat(tem_c(:), s(:))
            grid_corner_lon(icorner,i,j,ksdm) = s(1)
            grid_corner_lat(icorner,i,j,ksdm) = s(2)
	  enddo
	enddo
	enddo
	enddo
	grid_center_lon = grid_center_lon * grid_center_mask
	grid_center_lat = grid_center_lat * grid_center_mask
	grid_corner_lon = grid_corner_lon * grid_corner_mask
	grid_corner_lat = grid_corner_lat * grid_corner_mask

!-----------------------------------------------------------------------
! compute weights to average scalars from cell centers to cell corners
!-----------------------------------------------------------------------
	call compute_scalar_weights (    component_name,                         &
                                     ndata,ncorners,iim,jjm,nsdm,            &
                                     sub_area,corner_area_inv,               &
                                     grid_corner_mask, s_weights)

!-----------------------------------------------------------------------
! compute weights to compute the gradient of scalar fields
!-----------------------------------------------------------------------
	call compute_gradient_weights (                                          &
                                  ndata,r3,nspace,ncorners,iim,jjm,nsdm,     &
                                  dc,normal,v_weights)

!-----------------------------------------------------------------------
! compute weights to compute the Laplacian of a scalar field
!-----------------------------------------------------------------------
	call compute_laplacian_weights (component_name, polygon_type,            &
                         ndata,nspace,ncorners,nweights,iim,jjm,nsdm,        &
                         area_inv,corner_area_inv,v_weights,l_weights)

!-----------------------------------------------------------------------
! compute weights to compute the Laplacian at the corners
!-----------------------------------------------------------------------
!       call compute_zm_laplacian_weights

      deallocate (X1,X2,polygon_type,metrics_mask,t,r,h,g,m)     
      deallocate (grid_center_mask,grid_corner_mask)
   endif

!----------------------------------------------------------------------------
! keep the user informed
!----------------------------------------------------------------------------
        call output_process0(component_name,                           &
           ' finished in generate_grid_metrics at this resolution' )
        call output_process0(component_name,                           &
           '-------------------------------------------------------' )
        call output_process0(component_name, ' ' )
        call output_process0(component_name, ' ' )

	end subroutine generate_grid_metrics_level
!======================================================================
! END GENERATE_GRID_METRICS_LEVEL
!======================================================================

!======================================================================
! BEGIN COMPUTE_SCALAR_WEIGHTS
!======================================================================
	subroutine compute_scalar_weights (component_name,                       &
                                     ndata,ncorners,iim,jjm,nsdm,            &
                                     sub_area,corner_area_inv,               &
                                     grid_corner_mask, s_weights)
	implicit none
    integer (kind=int_kind),intent( in) ::                                   & 
           ndata,ncorners,iim,jjm,nsdm
    character (len=*), intent(in) ::                                         &
           component_name

	integer (kind=int_kind) :: i,j,k,l,icorner,ksdm,ierr

	real (kind=dbl_kind),intent( in) ::                                  &
                 sub_area       (ndata,         ncorners, iim, jjm, nsdm),   &
                 grid_corner_mask(              ncorners, iim, jjm, nsdm),   &
      		 corner_area_inv(               ncorners, iim, jjm, nsdm)

	real (kind=dbl_kind),intent(out) ::                                  &
      		 s_weights      (ndata,         ncorners, iim, jjm, nsdm)

!-----------------------------------------------------------------------
! compute scalar averaging weights at every grid corner which will
!   prognose velocity
!-----------------------------------------------------------------------
	do ksdm = 1,nsdm
        do j=1,jjm
           do i=1,iim
	      do icorner = 1,ncorners
! ross	         if(grid_corner_mask(icorner,i,j,ksdm) == 1.0_dbl_kind) then
                    do k=1,ndata
                       l=k-1
                       if(l == 0) l=ndata
                       s_weights(k,icorner,i,j,ksdm) =                  &
                                     sub_area(k,icorner,i,j,ksdm)       &
                                   * corner_area_inv(icorner,i,j,ksdm)
                    enddo
! ross	         endif
              enddo
           enddo
        enddo
	enddo

        call output_process0(component_name, ' ' )
        call output_process0(component_name,                           &
           ' Diagnostics for scalar weights (s_weights) for each task' )
        call output_process0(component_name,                           &
           ' maxval of s_weights will be 0.333 on a perfect hexagonal grid' )
        call output_process0(component_name,                           &
           ' maxval of sum_weights should be 1.000 to round-off' )
        call output_process0(component_name,                           &
           ' minval of sum_weights should be 1.000 to round-off' )

        call output_all_in_order(component_name,                       &
           ' maxval s_weights :  ',msg_dbl=maxval(s_weights) )
        call output_all_in_order(component_name,                       &
           ' maxval sum s_weights :  ',                                &
           msg_dbl=maxval(sum(s_weights,dim=1),mask=grid_corner_mask.eq.c1) )
        call output_all_in_order(component_name,                       &
           ' minval sum s_weights :  ',                  &
           msg_dbl=minval(sum(s_weights,dim=1),mask=grid_corner_mask.eq.c1) )

! the following code was replaced by the above code
!	do i=0,npe-1
!	if(my_task.eq.i) then
!	write(6,*) '  ******  ',my_task,' maxval s_weights : ',maxval(s_weights)
!	write(6,*) '  ******  ',my_task,' maxval sum s_weights : ',              !  &
!             maxval(sum(s_weights,dim=1),mask=grid_corner_mask.eq.c1)
!    write(6,*) '  ******  ',my_task,' minval sum s_weights : ',            &
!             minval(sum(s_weights,dim=1),mask=grid_corner_mask.eq.c1)
!	endif
!#if mpi == 1
!        CALL MPI_BARRIER (communicator,ierr)
!#endif
!	enddo
!
!#if mpi == 1
!        CALL MPI_BARRIER (communicator,ierr)
!#endif


	end subroutine compute_scalar_weights
!======================================================================
! END COMPUTE_SCALAR_WEIGHTS
!======================================================================

!======================================================================
! BEGIN COMPUTE_GRADIENT_WEIGHTS
!======================================================================
	subroutine compute_gradient_weights (                                &
                                 ndata,r3,nspace,ncorners,iim,jjm,nsdm,      &
                                 dc,normal,v_weights)

	implicit none
        integer (kind=int_kind),intent( in) ::                               & 
           ndata,r3,nspace,ncorners,iim,jjm,nsdm

	integer (kind=int_kind) :: i,j,k,l,icorner,ispace,ksdm

        real (kind=dbl_kind),intent( in) ::                                  &
         dc             (ndata,         ncorners, iim, jjm, nsdm),           &
      	 normal         (ndata,     r3, ncorners, iim, jjm, nsdm)
        real (kind=dbl_kind),intent(out) ::                                  &
         v_weights      (ndata, nspace, ncorners, iim, jjm, nsdm)

!-----------------------------------------------------------------------
! compute gradient weights at every corner that will prognose velocity
!-----------------------------------------------------------------------
	do ksdm = 1,nsdm
        do j=1,jjm
         do i=1,iim
          do icorner = 1,ncorners
           do k=1,ndata
            l = k-1
            if(l == 0) l=ndata
	     do ispace = 1,nspace
	      v_weights(k,ispace,icorner,i,j,ksdm) =                          &
               ( +dc(l,icorner,i,j,ksdm) * normal(l,ispace,icorner,i,j,ksdm)  &
                 -dc(k,icorner,i,j,ksdm) * normal(k,ispace,icorner,i,j,ksdm))
             enddo
	    enddo
          enddo
         enddo
        enddo
	enddo

	end subroutine compute_gradient_weights
!======================================================================
! END COMPUTE_GRADIENT_WEIGHTS
!======================================================================

!======================================================================
! BEGIN COMPUTE_LAPLACIAN_WEIGHTS
!======================================================================
	subroutine compute_laplacian_weights (component_name, polygon_type,       &
                          ndata,nspace,ncorners,nweights,iim,jjm,nsdm,&
                          area_inv,corner_area_inv,v_weights,l_weights)

	implicit none

    character (len=*), intent(in) ::                                     &
           component_name
    integer (kind=int_kind),intent( in) ::                               & 
           ndata,nspace,ncorners,nweights,iim,jjm,nsdm

	integer (kind=int_kind) ::                                           &
           i,j,k,l,ispace,icorner,ksdm

        real (kind=dbl_kind),intent( in) ::                                  &
      	 polygon_type   (                         iim, jjm, nsdm),           &
         area_inv       (                         iim, jjm, nsdm),           &
      	 corner_area_inv(               ncorners, iim, jjm, nsdm),           &
         v_weights      (ndata, nspace, ncorners, iim, jjm, nsdm)

        real (kind=dbl_kind),intent(out) ::                                  &
      	 l_weights      (nweights,                iim, jjm, nsdm)

	real (kind=dbl_kind) :: d,e,f,ai,f1,f2
	logical, parameter :: l_eigenvalue = .false.

!-----------------------------------------------------------------------
! compute Laplacian weights
!-----------------------------------------------------------------------
	do ksdm = 1,nsdm
        do l=1,jjm
          do k=1,iim
	    if(polygon_type(k,l,ksdm) > 0.0_dbl_kind) then
              do ispace=1,nspace

!-----------------------------------------------------------------------
! fill metrics (painfully) by looking at each corner
! what we are doing here is taking the divergence of a gradient
!-----------------------------------------------------------------------
                i=k
                j=l
                icorner = 1
                ai = corner_area_inv(icorner,i,j,ksdm)
                d = v_weights(1,ispace,icorner,i,j,ksdm)
                e = v_weights(2,ispace,icorner,i,j,ksdm)
                f = v_weights(3,ispace,icorner,i,j,ksdm)
                l_weights( 7, k, l,ksdm) = l_weights( 7, k, l,ksdm) + ai*d*d
                l_weights( 1, k, l,ksdm) = l_weights( 1, k, l,ksdm) + ai*d*e
                l_weights( 2, k, l,ksdm) = l_weights( 2, k, l,ksdm) + ai*d*f

                i=k
                j=l
                icorner = 2
                ai = corner_area_inv(icorner,i,j,ksdm)
                d = v_weights(1,ispace,icorner,i,j,ksdm)
                e = v_weights(2,ispace,icorner,i,j,ksdm)
                f = v_weights(3,ispace,icorner,i,j,ksdm)
                l_weights( 7, k, l,ksdm) = l_weights( 7, k, l,ksdm) + ai*d*d
                l_weights( 2, k, l,ksdm) = l_weights( 2, k, l,ksdm) + ai*d*e
                l_weights( 3, k, l,ksdm) = l_weights( 3, k, l,ksdm) + ai*d*f
        
                i=k+1
                j=l
                icorner = 1
                ai = corner_area_inv(icorner,i,j,ksdm)
                d = v_weights(2,ispace,icorner,i,j,ksdm)
                e = v_weights(3,ispace,icorner,i,j,ksdm)
                f = v_weights(1,ispace,icorner,i,j,ksdm)
                l_weights( 7, k, l,ksdm) = l_weights( 7, k, l,ksdm) + ai*d*d
                l_weights( 3, k, l,ksdm) = l_weights( 3, k, l,ksdm) + ai*d*e
                l_weights( 4, k, l,ksdm) = l_weights( 4, k, l,ksdm) + ai*d*f
        

                i=k+1
                j=l+1
                icorner = 2
                ai = corner_area_inv(icorner,i,j,ksdm)
                d = v_weights(2,ispace,icorner,i,j,ksdm)
                e = v_weights(3,ispace,icorner,i,j,ksdm)
                f = v_weights(1,ispace,icorner,i,j,ksdm)
                l_weights( 7, k, l,ksdm) = l_weights( 7, k, l,ksdm) + ai*d*d
                l_weights( 4, k, l,ksdm) = l_weights( 4, k, l,ksdm) + ai*d*e
                l_weights( 5, k, l,ksdm) = l_weights( 5, k, l,ksdm) + ai*d*f
        
                i=k+1
                j=l+1
	        icorner = 1
                ai = corner_area_inv(icorner,i,j,ksdm)
                d = v_weights(3,ispace,icorner,i,j,ksdm)
                e = v_weights(1,ispace,icorner,i,j,ksdm)
                f = v_weights(2,ispace,icorner,i,j,ksdm)
                l_weights( 7, k, l,ksdm) = l_weights( 7, k, l,ksdm) + ai*d*d
                l_weights( 5, k, l,ksdm) = l_weights( 5, k, l,ksdm) + ai*d*e
                l_weights( 6, k, l,ksdm) = l_weights( 6, k, l,ksdm) + ai*d*f
        
        
                i=k
                j=l+1
                icorner = 2
                ai = corner_area_inv(icorner,i,j,ksdm)
                d = v_weights(3,ispace,icorner,i,j,ksdm)
                e = v_weights(1,ispace,icorner,i,j,ksdm)
                f = v_weights(2,ispace,icorner,i,j,ksdm)
                l_weights( 7, k, l,ksdm) = l_weights( 7, k, l,ksdm) + ai*d*d
                l_weights( 6, k, l,ksdm) = l_weights( 6, k, l,ksdm) + ai*d*e
                l_weights( 1, k, l,ksdm) = l_weights( 1, k, l,ksdm) + ai*d*f

              enddo
	    endif

            l_weights(:,k,l,ksdm) = -l_weights(:,k,l,ksdm)*area_inv(k,l,ksdm)

          enddo
        enddo
	enddo

!-----------------------------------------------------------------------
! at pentagons, move the l_weight on neighor 5 into neighbor 6
!-----------------------------------------------------------------------
	where(polygon_type(:,:,:) == 2.0_dbl_kind)
	  l_weights(6,:,:,:) = l_weights(6,:,:,:) + l_weights(5,:,:,:)
	  l_weights(5,:,:,:) = 0.0_dbl_kind
	endwhere

!-----------------------------------------------------------------------
! at NP, move the l_weight on neighbor 1 into neighbor 6
! at SP, move the l_weight on neighbor 3 into neighbor 4
!-----------------------------------------------------------------------
	do ksdm=1,nsdm
        do j=1,jjm
          do i=1,iim
	    if(polygon_type(i,j,ksdm) == 3.0_dbl_kind) then
              l_weights(6,i,j,ksdm) = l_weights(6,i,j,ksdm) + l_weights(1,i,j,ksdm)
              l_weights(1,i,j,ksdm) = 0.0_dbl_kind
            endif
            if(polygon_type(i,j,ksdm) == 4.0_dbl_kind) then
              l_weights(4,i,j,ksdm) = l_weights(4,i,j,ksdm) + l_weights(3,i,j,ksdm)
              l_weights(3,i,j,ksdm) = 0.0_dbl_kind
            endif
	  enddo
	enddo
	enddo

!-----------------------------------------------------------------------
! check the Laplacian weights, should sum to zero around each cell
!-----------------------------------------------------------------------
        f2 = 0.0
	do ksdm=1,nsdm
        do j=1,jjm
          do i=1,iim
            if(polygon_type(i,j,ksdm) > 0.0_dbl_kind) then
              f1 = sum(l_weights(:,i,j,ksdm))
              if(abs(f1) > f2) f2=f1
	    endif
          enddo
        enddo
	enddo

! this barrier is not needed, I think - D.D. 04/23/03
!#if mpi == 1
!        CALL MPI_BARRIER (communicator,ierr)
!#endif

        call output_process0(component_name, ' ' )
        call output_all_in_order(component_name,                       &
           ' max error in Laplacian weights  ',msg_dbl=f2 )
        call output_process0(component_name, ' ' )

!       if(l_eigenvalue) call fill_eigenvalue_matrix

	end subroutine compute_laplacian_weights
!======================================================================
! END COMPUTE_LAPLACIAN_WEIGHTS
!======================================================================

!======================================================================
! BEGINNING OF GRID_CENTER_AREA
!======================================================================
        subroutine grid_center_area(                                  &
                polygon_type,                                         &
                ndata,                                                &
                ncorners,                                             &
                iim,                                                  &
                jjm,                                                  &
                nsdm,                                                 &
      		sub_area,                                             &
      		area_inv,                                             &
      		area)
        implicit none
        integer (kind=int_kind), intent(in) ::                        &
                        ncorners,                                     &
                        ndata,                                        &
                        iim,                                          &
                        jjm,                                          &
                        nsdm
        integer (kind=int_kind) :: i,j,ksdm
 
        real (kind=dbl_kind), intent( in) ::                          &
           polygon_type(               iim,jjm,nsdm),                 &
           sub_area    (ndata,ncorners,iim,jjm,nsdm)          

        real (kind=dbl_kind), intent(out) ::                          &
           area_inv(             iim,jjm,nsdm),                       &
           area    (             iim,jjm,nsdm)

!-----------------------------------------------------------------------
! initialize
!-----------------------------------------------------------------------
        area = 0.0_dbl_kind
        area_inv = 0.0_dbl_kind
!-----------------------------------------------------------------------
! loop over all grid cells and if it is a real cell, then sum
! the sub_areas to find the total grid cell area
!-----------------------------------------------------------------------
	do ksdm = 1,nsdm
          do j=1,jjm
            do i = 1,iim
	      if(polygon_type(i,j,ksdm) > 0.0_dbl_kind) then
                area(i,j,ksdm) = + sub_area(1,1,i  ,j  ,ksdm)       &
                                 + sub_area(1,2,i  ,j  ,ksdm)       &
                                 + sub_area(2,1,i+1,j  ,ksdm)       &
                                 + sub_area(2,2,i+1,j+1,ksdm)       &
                                 + sub_area(3,1,i+1,j+1,ksdm)       &
                                 + sub_area(3,2,i  ,j+1,ksdm)
                area_inv(i,j,ksdm) = 1.0_dbl_kind / area(i,j,ksdm)
	      endif
            enddo
          enddo
	enddo

        end subroutine grid_center_area
!======================================================================
! END OF GRID_CENTER_AREA
!======================================================================


!======================================================================
! BEGINNING OF FIND_GRID_CENTER_CENTROID
!======================================================================
	subroutine find_grid_center_centroid(                         &
                polygon_type,                                         &
                r3,                                                   &
                ndata,                                                &
                ncorners,                                             &
                iim,                                                  &
                jjm,                                                  &
                nsdm,                                                 &
                sub_area_centroid,                                    &
                sub_area,                                             &
                area_inv,                                             &
                grid_center_centroid)

        implicit none
        integer (kind=int_kind), intent(in) ::                        &
                        r3,                                           &
                        ncorners,                                     &
                        ndata,                                        &
                        iim,                                          &
                        jjm,                                          &
                        nsdm
        integer (kind=int_kind) :: i,j,ksdm

        real (kind=dbl_kind), intent( in) ::                          &
           sub_area_centroid(ndata,r3,ncorners,iim,jjm,nsdm),         &
           sub_area    (ndata,ncorners,iim,jjm,nsdm),                 &
           area_inv(             iim,jjm,nsdm), &
           polygon_type(iim,jjm,nsdm)

        real (kind=dbl_kind), intent(out) ::                          &
           grid_center_centroid  (r3, iim,jjm,nsdm)

!-----------------------------------------------------------------------
! initialize
!-----------------------------------------------------------------------
	grid_center_centroid = 0.0_dbl_kind

!-----------------------------------------------------------------------
! loop over all grid cells and if it is a real cell, then sum
! the sub_areas to find the total grid cell area
!-----------------------------------------------------------------------
        do ksdm = 1,nsdm
          do j=1,jjm
            do i = 1,iim
              if(polygon_type(i,j,ksdm) > 0) then
              grid_center_centroid(:,i,j,ksdm) =  &
                    (sub_area(1,1,i  ,j  ,ksdm) * sub_area_centroid(1,:,1,i  ,j  ,ksdm)  &
                   + sub_area(1,2,i  ,j  ,ksdm) * sub_area_centroid(1,:,2,i  ,j  ,ksdm)  &
                   + sub_area(2,1,i+1,j  ,ksdm) * sub_area_centroid(2,:,1,i+1,j  ,ksdm)  &
                   + sub_area(2,2,i+1,j+1,ksdm) * sub_area_centroid(2,:,2,i+1,j+1,ksdm)  &
                   + sub_area(3,1,i+1,j+1,ksdm) * sub_area_centroid(3,:,1,i+1,j+1,ksdm)  &
                   + sub_area(3,2,i  ,j+1,ksdm) * sub_area_centroid(3,:,2,i  ,j+1,ksdm)) &
                       * area_inv(i,j,ksdm)
              call unit_vector_in_3space(grid_center_centroid(:,i,j,ksdm))
              endif
            enddo
          enddo
        enddo

	end subroutine find_grid_center_centroid
!======================================================================
! END OF FIND_GRID_CENTER_CENTROID
!======================================================================

!======================================================================
! BEGIN read_grid_center_fine
!======================================================================
      subroutine read_grid_center_fine (component_name, max_ig, p_list)
      implicit none

      character (len=*), intent(in) ::                                       &
         component_name
      integer (kind=int_kind) ::                                             &
         max_ig

      real (kind=dbl_kind),intent(out) ::                                    &
         p_list(3,max_ig)

      integer (kind=int_kind) ::                                             &
         igrid, my_task

      real (kind=dbl_kind) :: work(3,max_ig), angle

!-----------------------------------------------------------------------
! read in grid center data
!       the (x,y,z) point is read in
!-----------------------------------------------------------------------

        my_task = get_my_task(component_name)
        if (my_task == 0) then
          if(max_ig.eq.0000162) then
            open(unit=2,file='./data/grid_centers_0000162',form='formatted',status='old') 
          elseif(max_ig.eq.0000362) then
            open(unit=2,file='./data/grid_centers_0000362',form='formatted',status='old') 
          elseif(max_ig.eq.0000642) then
            open(unit=2,file='./data/grid_centers_0000642',form='formatted',status='old') 
          elseif(max_ig.eq.0001442) then
            open(unit=2,file='./data/grid_centers_0001442',form='formatted',status='old') 
          elseif(max_ig.eq.0002562) then
            open(unit=2,file='./data/grid_centers_0002562',form='formatted',status='old') 
          elseif(max_ig.eq.0005762) then
            open(unit=2,file='./data/grid_centers_0005762',form='formatted',status='old') 
          elseif(max_ig.eq.0010242) then
            open(unit=2,file='./data/grid_centers_0010242',form='formatted',status='old')
          elseif(max_ig.eq.0023042) then
            open(unit=2,file='./data/grid_centers_0023042',form='formatted',status='old')
          elseif(max_ig.eq.0040962) then
            open(unit=2,file='./data/grid_centers_0040962',form='formatted',status='old')
          elseif(max_ig.eq.0163842) then
            open(unit=2,file='./data/grid_centers_0163842',form='formatted',status='old')
          elseif(max_ig.eq.0655362) then
            open(unit=2,file='./data/grid_centers_0655362',form='formatted',status='old')
          else
            write(6,*) ' grid_center file not found'
            stop
          endif
          do igrid=1,max_ig
!           read(2,20) p_list(1,igrid),p_list(2,igrid),p_list(3,igrid)
            read(2,*) p_list(1,igrid),p_list(2,igrid),p_list(3,igrid)
          enddo
!20       format(3f24.20)
          close(2)
        endif

	work = p_list
	angle = 0.0*dtr
	p_list(2,:) = +work(2,:)
 	p_list(1,:) = cos(angle)*work(1,:) - sin(angle)*work(3,:)
 	p_list(3,:) = sin(angle)*work(1,:) + cos(angle)*work(3,:)

      end subroutine read_grid_center_fine
!======================================================================
! END read_grid_center_fine
!======================================================================

!======================================================================
! BEGIN COMPUTE_POLYGON_TYPE
!======================================================================
        subroutine compute_polygon_type(component_name,                     &
                   im,jm,iim,jjm,nsdm,polygon_type)

        integer (kind=int_kind), intent(in) :: im,jm,iim,jjm,nsdm
        character(*), intent(in) :: component_name
        real    (kind=dbl_kind), intent(out) :: polygon_type(iim,jjm,nsdm)

        integer (kind=int_kind) :: i,j,ksdm,panel,im5, my_task
        real    (kind=dbl_kind) :: work(im,jm), work_1(iim,jjm,nsdm)

!-----------------------------------------------------------------------
! set contants
!-----------------------------------------------------------------------
        im5 = im/5

!-----------------------------------------------------------------------
! initialize to zero
!-----------------------------------------------------------------------
        polygon_type = 0.0_dbl_kind

!-----------------------------------------------------------------------
! initialize interior of each panel
!-----------------------------------------------------------------------
        do ksdm = 1,nsdm
          polygon_type(2:iim-1,2:jjm-1,ksdm) = 1.0_dbl_kind
        enddo

!-----------------------------------------------------------------------
! add 1 to pentagons
!-----------------------------------------------------------------------
        my_task = get_my_task(component_name)
        if(my_task == 0) then
          work(:,:) = 0.0_dbl_kind
          do panel = 0,4
            i  = im5*panel + jm - 1
            work(i,jm-1) = 1.0_dbl_kind         ! NH pentagon
            i  = im5*(panel+1) - 1
            work(i,jm-1) = 1.0_dbl_kind         ! SH pentagon
          enddo
        endif

!-----------------------------------------------------------------------
! scatter across sub domains
!-----------------------------------------------------------------------
        call scatter(component_name,                                  &
                     im,jm,iim,jjm,1,nsdm,work(1,1),work_1(1,1,1))
        polygon_type = polygon_type + work_1

!-----------------------------------------------------------------------
! clean up edges
!-----------------------------------------------------------------------
        do ksdm = 1,nsdm
          polygon_type(1:iim,1,ksdm) = 0.0_dbl_kind
          polygon_type(1:iim,jjm,ksdm) = 0.0_dbl_kind
          polygon_type(1,1:jjm,ksdm) = 0.0_dbl_kind
          polygon_type(iim,1:jjm,ksdm) = 0.0_dbl_kind
        enddo

!-----------------------------------------------------------------------
! set poles to a value of 3 for NP and 4 for SP
!-----------------------------------------------------------------------
        if(my_task == 0) then
          work(:,:) = 0.0_dbl_kind
          work(1,jm-1) = 3.0_dbl_kind           ! north pole
          work(im-1,1) = 4.0_dbl_kind           ! south pole
        endif

!-----------------------------------------------------------------------
! scatter across sub domains
!-----------------------------------------------------------------------
        call scatter(component_name,                                  &
                     im,jm,iim,jjm,1,nsdm,work(1,1),work_1(1,1,1))
        polygon_type = polygon_type + work_1

!-----------------------------------------------------------------------
! set all wrapped grid cells to -1
!-----------------------------------------------------------------------
        where(polygon_type.lt.0.5_dbl_kind) polygon_type = -1.0_dbl_kind

        end subroutine compute_polygon_type
!======================================================================
! END COMPUTE_POLYGON_TYPE
!======================================================================


        end module grid_metrics_generator
!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
