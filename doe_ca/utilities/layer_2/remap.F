!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

      module remap_xxx

!-----------------------------------------------------------------------
! PURPOSE:   Update the mass and tracer fields using an incremental
!            remapping scheme.
!
! AUTHOR:    William H. Lipscomb, LANL
!
! REFERENCE: Lipscomb, W.H., and T.D. Ringler, 2005: An incremental remapping
!            transport scheme on a spherical geodesic grid, Mon. Wea. Rev.,
!            133, 2335-2350.
!-----------------------------------------------------------------------

      use kinds
      use params_physical
      use params_grid_horizontal_xxx
      use params_parallel_xxx
      use grid_mask_variables_xxx
      use grid_metrics_variables_xxx
      use timer                  
      use abort

      use geodesic_grid_utilities
      use operators              
      use wrap_data
      use grid_metrics_generator
      use grid_mask
      use global_reductions

      implicit none
      save
      private

!-----------------------------------------------------------------------
! Remapping parameters
!-----------------------------------------------------------------------

      integer (kind=int_kind), parameter ::                            &
           ngroups  = 4,        &! number of triangle groups that 
                                 ! contain transports across edges
           nedgedata = 4,       &! number of cells bordering each edge
           ntrivert = 3,        &! number of vertices in a triangle
           nhexvert = 6          ! number of vertices in a hexagon   

      real (kind=dbl_kind), parameter ::                               &
           eps    = 1.0e-10_dbl_kind,                                  &
           p333   = c1/c3,                                             &
           p4     = 0.4_dbl_kind,                                      &
           p6     = 0.6_dbl_kind,                                      &
           p5625m = -9._dbl_kind/16._dbl_kind,                         &
           p52083 = 25._dbl_kind/48._dbl_kind                          

      integer (kind=int_kind), dimension (nedgedata, nedges) ::        &
           ishift_p, &! relative i index of 4 cells bordering edge (ne,i,j)
           jshift_p   ! relative j index of 4 cells bordering edge (ne,i,j)

!-----------------------------------------------------------------------
! Grid quantities needed for remapping.
!-----------------------------------------------------------------------

      real (kind=dbl_kind), dimension(nspace,nhexvert,iim,jjm,nsdm) :: &
           c_x3              ! 6 cell corners in X3

      real (kind=dbl_kind), dimension(r3,r3,iim,jjm,nsdm) ::           &
           trans_X1_to_X3    ! 3x3 transformation matrix, X1 to X3

      real (kind=dbl_kind), dimension(r3,r3,nedges,iim,jjm,nsdm) ::    &
           trans_X1_to_X4    ! 3x3 transformation matrix, X1 to X4

      real (kind=dbl_kind),                                            &
         dimension(nspace,nspace,nedgedata,nedges,iim,jjm,nsdm) ::     &
           trans_X4_to_X3    ! 2x2 transformation matrix, X4 to X3

      real (kind=dbl_kind),                                            &
         dimension(nspace,ndata,ncorners,iim,jjm,nsdm) ::              &
           w_x2              ! edge midpoints in X2

      real (kind=dbl_kind),                                            &
         dimension(r3,0:nhexvert,iim,jjm,nsdm) ::                      &
           gwgt_x1,  &! cell-center gradient weights in X1 coordinates
           gwgt_x3    ! cell-center gradient weights in X3 coordinates
           
      real (kind=dbl_kind),                                            &
         dimension(ndata,r3,ncorners,iim,jjm,nsdm) ::                  &
           vwgt_x1    ! v_weights in X1 coordinates

      real (kind=dbl_kind), dimension(iim,jjm,nsdm) ::                 &
           garea_inv ! inverse area associated w/ gradient line integral

      real (kind=dbl_kind),                                            &
         dimension(ndata,ncorners,iim,jjm,nsdm) ::                     &
           theta_x2          ! angle from local east to edges

      real (kind=dbl_kind), dimension(nspace,nedges,iim,jjm,nsdm) ::   &
           cl_x4,               &! center left point in X4
           cr_x4,               &! center right point in X4
           tl_x4,               &! top left point in X4
           tr_x4,               &! top right point in X4
           bl_x4,               &! bottom left point in X4
           br_x4                 ! bottom point in X4

      real (kind=dbl_kind),                                            &
           dimension(nspace,nedgedata,nedges,iim,jjm,nsdm) ::          &
           p_x4                  ! neighboring cell centers in X4

      real (kind=dbl_kind), dimension(iim,jjm,nsdm) ::                 &
           area_x3,             &! grid cell area in X3
           area_inv_x3,         &! inverse grid cell area in X3
           xav,                 &! mean of x in X3
           yav,                 &! mean of y in X3
           xxav,                &! mean of x^2 in X3
           xyav,                &! mean of xy  in X3
           yyav,                &! mean of y^2 in X3
           xxxav,               &! mean of x^3 in X3
           xxyav,               &! mean of x^2*y in X3
           xyyav,               &! mean of x*y^2 in X3
           yyyav                 ! mean of y^3 in X3

      real (kind=dbl_kind), dimension(nhexvert,iim,jjm,nsdm) ::        &
           vertex_mask           ! 1. for real vertices, 0. for false vertices

      real (kind=dbl_kind), dimension(iim,jjm,nsdm) ::                 &
           num_vertices          ! = 6. for hexagons, = 5. for pentagons
      
! make ksdm visible to all routines in this module
      integer (kind=int_kind) ::                                       &
           ksdm

	public ::                                                      &
           init_remap,                                                 &
           remap_mass_and_tracers

! These variables are useful for bug checking:

      integer (kind=int_kind), parameter, public ::                    &
           mtest = 7,                                                  &
           itest = 16,                                                  &
           jtest = 12,                                                 &
           ktest = 1

!***********************************************************************
      contains
!***********************************************************************


!=======================================================================
! BEGINNING OF TRIANGLE_AREA
!=======================================================================
      function triangle_area (tv)

!-----------------------------------------------------------------------
! PURPOSE: Compute the area of a triangle on a plane given the x and y
!          coordinates of its vertices.
!-----------------------------------------------------------------------

      real (kind=dbl_kind) ::                                          &
           triangle_area

      real (kind=dbl_kind), intent(in), dimension(nspace,ntrivert) ::  &
           tv                   ! x and y coordinates of 3 vertices

      triangle_area = p5*abs( (tv(1,2)-tv(1,1)) * (tv(2,3)-tv(2,1)) -  &
                              (tv(2,2)-tv(2,1)) * (tv(1,3)-tv(1,1)) )

      end function triangle_area
!=======================================================================
! END OF TRIANGLE_AREA
!=======================================================================


!======================================================================
! BEGINNING OF INIT_REMAP
!======================================================================
      subroutine init_remap (component_name)

!-----------------------------------------------------------------------
! PURPOSE:  Precompute a variety of quantities needed by the remapping
!           module.  In particular:
!           (1) Define some arrays used for indexing surrounding
!               grid cells relative to a given edge.  
!           (2) Define a mask that indicates whether each vertex (1-6)
!               of each grid cell is associated with a nonzero subarea.
!               Each pentagon has one vertex masked out.
!           (3) Define a coordinate system X3 at grid cell centers whose 
!               unit vectors point in the local east, north, and vertical
!               directions.  (If X3 is used by other modules, this
!               computation could be moved to grid_metrics_generator.F)
!               Compute a matrix for transforming from X1 to X3. 
!           (4) Define a coordinate system X4 at grid cell edges whose 
!               unit vectors point in the tangent, outward normal, and
!               vertical directions.
!               Compute a matrix for transforming from X1 to X4. 
!           (5) Given the matrices from transforming between X1 and 
!               X3/X4, compute a matrix for transforming directly
!               from X4 to X3.
!           (6) For each cell edge, compute the the locations of nearby 
!               cell centers and corners in X4.
!           (7) Compute the X3 coordinates of the 6 cell corners
!               relative to each cell center.
!           (8) For each grid cell, compute grid cell areas in X3.
!               These areas are slightly different from those computed 
!               in grid_metrics by summing over corner sub-areas.
!           (9) For each grid cell, compute the mean value of x, y, x^2,
!               x*y, y^2, etc., in X3.  These are used later to compute 
!               the cell centroid and center of mass.               
!          (10) For each corner, compute the coordinates of the three
!               surrounding edge midpoints in X2 coordinates.
!               Also compute the angle between the three
!               surrounding edges and local east in X2.
!          (11) Compute weights for efficient computation of gradients
!               at cell centers.
!-----------------------------------------------------------------------

      implicit none

!-----------------------------------------------------------------------
! INTENT IN
!-----------------------------------------------------------------------
      character (len=*), intent(in) :: component_name

!-----------------------------------------------------------------------
! LOCAL
!-----------------------------------------------------------------------

      integer (kind=int_kind) ::                                       &
           i, j,            &! horizontal indices
           nc,              &! corner index
           ne,              &! edge index
           nd,              &! ndata index
           nv, nv2,         &! hexagon corner indices
           nvt,             &! triangle vertex index
           k1, k2            ! vector coordinate indices

      integer (kind=int_kind) ::                                       &
           ip, jp            ! i and j indices of 3 neighboring faces

      real (kind=dbl_kind), dimension(nspace, 0:ntrivert) ::           &
           tv                ! triangle vertices

      real (kind=dbl_kind) ::                                          &
           tarea,           &! triangle area
           cmag,            &! average magnitude of c vectors in X1 
           pcmag,           &! average magnitude of (p-c) vectors in X1
           pmag,            &! magnitude of p_x3 vector in X1
           dtheta,          &! average angle between p and c vectors in X1
           dotprod           ! dot product

      real (kind=dbl_kind), dimension (r3) ::                          &
           cl_x1,           &! center left point in X1
           cr_x1,           &! center right point in X1
           tl_x1,           &! top left point in X1
           tr_x1,           &! top right point in X1
           bl_x1,           &! bottom left point in X1
           br_x1,           &! bottom right point in X1
           utmp              ! work vector

      real (kind=dbl_kind), dimension (r3,nedgedata) ::                &
           p_x1              ! neighboring cell centers in X1

      real (kind=dbl_kind), dimension (r3,nhexvert) ::                 &
           vtmp              ! work vector

      real (kind=dbl_kind), dimension (r3, r3) ::                      &
           X1,              &! unit vectors in X1
           X3,              &! X3 unit vectors (defined in X1)
           X4,              &! X4 unit vectors (defined in X1)
           work_3x3          ! 3x3 work matrix
                  
!-----------------------------------------------------------------------
! Define ishift_p and jshift_p, which are used to find the i and j 
!     indices of neighboring grid cells relative to edge (ne,i,j). 
!     We associate nd = 1 with cell (i,j), then increase nd in 
!     counterclockwise direction.
! 
! Recall that edge 1 is the left edge of a standard hexagon, edge 2 is
! lower left, and edge 3 is lower right.  
 
!-----------------------------------------------------------------------

      ne = 1
      ishift_p(1,ne) = 0   ! i,j
      jshift_p(1,ne) = 0
      ishift_p(2,ne) = 0   ! i,j+1
      jshift_p(2,ne) = 1
      ishift_p(3,ne) = -1  ! i-1,j
      jshift_p(3,ne) = 0
      ishift_p(4,ne) = -1  ! i-1,j-1
      jshift_p(4,ne) = -1

      ne = 2
      ishift_p(1,ne) = 0   ! i,j
      jshift_p(1,ne) = 0
      ishift_p(2,ne) = -1  ! i-1,j
      jshift_p(2,ne) = 0
      ishift_p(3,ne) = -1  ! i-1,j-1
      jshift_p(3,ne) = -1
      ishift_p(4,ne) = 0   ! i,j-1
      jshift_p(4,ne) = -1

      ne = 3
      ishift_p(1,ne) = 0   ! i,j
      jshift_p(1,ne) = 0
      ishift_p(2,ne) = -1  ! i-1,j-1
      jshift_p(2,ne) = -1
      ishift_p(3,ne) = 0   ! i,j-1
      jshift_p(3,ne) = -1
      ishift_p(4,ne) = 1   ! i+1,j
      jshift_p(4,ne) = 0

!-----------------------------------------------------------------------
! Compute a mask that = 1. for real vertices and 0. for false (pentagon)
!  vertices.
!-----------------------------------------------------------------------
      vertex_mask(:,:,:,:) = c0

      do ksdm = 1, nsdm
      do j = 1, jjm-1
      do i = 1, iim-1
         vertex_mask(1,i,j,ksdm) = sub_area(1,1,i  ,j  ,ksdm)
         vertex_mask(2,i,j,ksdm) = sub_area(1,2,i  ,j  ,ksdm)
         vertex_mask(3,i,j,ksdm) = sub_area(2,1,i+1,j  ,ksdm)
         vertex_mask(4,i,j,ksdm) = sub_area(2,2,i+1,j+1,ksdm)
         vertex_mask(5,i,j,ksdm) = sub_area(3,1,i+1,j+1,ksdm)
         vertex_mask(6,i,j,ksdm) = sub_area(3,2,i  ,j+1,ksdm)
      enddo                     ! i
      enddo                     ! j
      enddo                     ! ksdm

      where (vertex_mask > eps) vertex_mask = c1

!-----------------------------------------------------------------------
! Conmpute number of vertices associated with each grid cell (5 or 6)
!-----------------------------------------------------------------------

      do ksdm = 1, nsdm
      do j = 1, jjm
      do i = 1, iim
         num_vertices(i,j,ksdm) = vertex_mask(1,i,j,ksdm)              & 
                                + vertex_mask(2,i,j,ksdm)              &
                                + vertex_mask(3,i,j,ksdm)              & 
                                + vertex_mask(4,i,j,ksdm)              &
                                + vertex_mask(5,i,j,ksdm)              &
                                + vertex_mask(6,i,j,ksdm)   
      enddo                     ! i
      enddo                     ! j
      enddo                     ! ksdm

!-----------------------------------------------------------------------
! Define unit vectors in X1
!-----------------------------------------------------------------------

      X1(1,1) = c1              ! e1
      X1(1,2) = c0
      X1(1,3) = c0

      X1(2,1) = c0              ! e2
      X1(2,2) = c1
      X1(2,3) = c0

      X1(3,1) = c0              ! e3
      X1(3,2) = c0
      X1(3,3) = c1

!-----------------------------------------------------------------------
! Compute matrix for transforming from X1 to X3.
! (Patterned after code in grid_metrics_generator.F)
!-----------------------------------------------------------------------

      do ksdm = 1, nsdm
      do j = 1, jjm-npad
      do i = 1, iim-npad

! Find the vector pointing from the origin of X1 (center of earth) to 
! the cell center.  This is the local vertical.

         X3(3,:) = p(:,i,j,ksdm)
         call unit_vector_in_3space(X3(3,:))

! Take dot product of X3(3,:) with X1(3,:), the vector pointing from the
! center of the earth toward the North Pole.  If dot product is close to +1 
! or -1, we're at North Pole or South Pole and local north is ill-defined.

         dotprod = dot_product (X3(3,:), X1(3,:))

         if (abs(dotprod) < c1-eps) then ! usual case

! Find the vector that is perpendicular to the local vertical vector
! and points toward the North Pole.  This defines local north, still in X1.

            call vector_on_tangent_plane ( X3(3,:), X1(3,:), X3(2,:) )

         else                   ! North Pole or South Pole

! Find the vector that is perpendicular to the local vertical vector
! and points out from the pole in a direction we will arbitrarily
! define as local north.

            call vector_on_tangent_plane ( X3(3,:), X1(1,:), X3(2,:) )

         endif

! Take the cross product of the local north direction and the local vertical
! to find the local east vector, still in X1.

         call cross_product_in_3space ( X3(2,:), X3(3,:), X3(1,:) )

! Compute the matrix for transforming vectors from X1 to X3

         trans_X1_to_X3(:,:,i,j,ksdm) = matmul(X3,transpose(X1))

      enddo                     ! i
      enddo                     ! j
      enddo                     ! ksdm

! Wrap

      do k2 = 1, r3
      do k1 = 1, r3
         call wrap (component_name, face_1L=trans_X1_to_X3(k1,k2,:,:,:))
      enddo
      enddo

!-----------------------------------------------------------------------
! Compute matrix for transforming vectors from X1 to X4.
! X4 is defined for each cell edge.  Its origin is the edge midpoint,
!  and its three unit vectors are the tangent to the edge, the outward
!  normal, and the local vertical.
!-----------------------------------------------------------------------

      do ksdm = 1, nsdm
      do j = 1+npad, jjm-npad
      do i = 1+npad, iim-npad
      do ne = 1, nedges

! Find the three unit vectors of the X4 coordinate system.  These are
! defined in X1.

         if (ne==1) then
            X4(1,:) = c(  :,2,i  ,j+1,ksdm) - w(1,:,1,i,j,ksdm)
            X4(3,:) = w(1,:,1,i,j    ,ksdm)
         elseif (ne==2) then
            X4(1,:) = c(  :,1,i  ,j  ,ksdm) - w(1,:,2,i,j,ksdm)
            X4(3,:) = w(1,:,2,i  ,j  ,ksdm)
         elseif (ne==3) then
            X4(1,:) = c(  :,2,i  ,j  ,ksdm) - w(3,:,2,i,j,ksdm)
            X4(3,:) = w(3,:,2,i  ,j  ,ksdm)
         endif

         call unit_vector_in_3space(X4(1,:))
         call unit_vector_in_3space(X4(3,:))

         call cross_product_in_3space (X4(3,:),X4(1,:),X4(2,:))

! Compute the matrix for transforming vectors from X1 to X4

         trans_X1_to_X4(:,:,ne,i,j,ksdm) = matmul(X4,transpose(X1))

      enddo                     ! nedges
      enddo                     ! i
      enddo                     ! j
      enddo                     ! ksdm

! Wrap

      do k2 = 1, r3
         call wrap (component_name, edge_1L=trans_X1_to_X4(:,k2,:,:,:,:))
      enddo

!-----------------------------------------------------------------------
! Compute matrices for transforming vectors from X4 to X3 via X1,
!  dropping the small z components.
! There are four such matrices associated with each cell edge,
!  corresponding to the four neighboring cells.
!-----------------------------------------------------------------------
            
      do ksdm = 1, nsdm
      do j = npad+1, jjm-npad
      do i = npad+1, iim-npad
      do ne = 1, nedges
      do nd = 1, nedgedata

         ip = i + ishift_p(nd,ne)
         jp = j + jshift_p(nd,ne)
            
         work_3x3(:,:) = transpose (trans_X1_to_X4(:,:,ne,i,j,ksdm))

         work_3x3(:,:) = matmul (trans_X1_to_X3(:,:,ip,jp,ksdm),  &
                                       work_3x3(:,:) )

         trans_X4_to_X3(:,:,nd,ne,i,j,ksdm) = work_3x3(1:2,1:2)

      enddo                     ! nedgedata
      enddo                     ! nedges
      enddo                     ! i
      enddo                     ! j
      enddo                     ! ksdm

!-----------------------------------------------------------------------
! Wrap
!-----------------------------------------------------------------------

      do nd = 1, nedgedata
         do k2 = 1, nspace
            call wrap (component_name,                                 &
                       edge_1L=trans_X4_to_X3(:,k2,nd,:,:,:,:))
         enddo                  ! k2
      enddo                     ! nedgedata

!-----------------------------------------------------------------------
! Locate points CL, CR, TL, TR, BL, and BR in X4.
! Also locate the four neighboring cell centers in X4.
! These points are used by the locate_triangles subroutine.
!-----------------------------------------------------------------------

      do ksdm = 1, nsdm
      do j = 1+npad, jjm-npad
      do i = 1+npad, iim-npad
      do ne = 1, nedges

! Locate relative to midpoint of edge (ne,i,j,ksdm) in X1

         if (ne==1) then
            cl_x1(:)  = a * (c(:,1,i  ,j  ,ksdm) - w(1,:,1,i,j,ksdm))
            cr_x1(:)  = a * (c(:,2,i  ,j+1,ksdm) - w(1,:,1,i,j,ksdm))
            tl_x1(:)  = a * (c(:,2,i-1,j  ,ksdm) - w(1,:,1,i,j,ksdm))
            tr_x1(:)  = a * (c(:,1,i  ,j+1,ksdm) - w(1,:,1,i,j,ksdm))
            bl_x1(:)  = a * (c(:,2,i  ,j  ,ksdm) - w(1,:,1,i,j,ksdm))
            br_x1(:)  = a * (c(:,1,i+1,j+1,ksdm) - w(1,:,1,i,j,ksdm))
            p_x1(:,1) = a * (p(:,  i  ,j  ,ksdm) - w(1,:,1,i,j,ksdm))
            p_x1(:,2) = a * (p(:,  i  ,j+1,ksdm) - w(1,:,1,i,j,ksdm))
            p_x1(:,3) = a * (p(:,  i-1,j  ,ksdm) - w(1,:,1,i,j,ksdm))
            p_x1(:,4) = a * (p(:,  i-1,j-1,ksdm) - w(1,:,1,i,j,ksdm))
         elseif (ne==2) then
            cl_x1(:)  = a * (c(:,2,i  ,j,  ksdm) - w(1,:,2,i,j,ksdm))
            cr_x1(:)  = a * (c(:,1,i  ,j  ,ksdm) - w(1,:,2,i,j,ksdm))
            tl_x1(:)  = a * (c(:,1,i  ,j-1,ksdm) - w(1,:,2,i,j,ksdm))
            tr_x1(:)  = a * (c(:,2,i-1,j  ,ksdm) - w(1,:,2,i,j,ksdm))
            bl_x1(:)  = a * (c(:,1,i+1,j  ,ksdm) - w(1,:,2,i,j,ksdm))
            br_x1(:)  = a * (c(:,2,i  ,j+1,ksdm) - w(1,:,2,i,j,ksdm))
            p_x1(:,1) = a * (p(:,  i  ,j  ,ksdm) - w(1,:,2,i,j,ksdm))
            p_x1(:,2) = a * (p(:,  i-1,j  ,ksdm) - w(1,:,2,i,j,ksdm))
            p_x1(:,3) = a * (p(:,  i-1,j-1,ksdm) - w(1,:,2,i,j,ksdm))
            p_x1(:,4) = a * (p(:,  i  ,j-1,ksdm) - w(1,:,2,i,j,ksdm))
         elseif (ne==3) then
            cl_x1(:)  = a * (c(:,1,i+1,j,  ksdm) - w(3,:,2,i,j,ksdm))
            cr_x1(:)  = a * (c(:,2,i  ,j  ,ksdm) - w(3,:,2,i,j,ksdm))
            tl_x1(:)  = a * (c(:,2,i+1,j  ,ksdm) - w(3,:,2,i,j,ksdm))
            tr_x1(:)  = a * (c(:,1,i  ,j-1,ksdm) - w(3,:,2,i,j,ksdm))
            bl_x1(:)  = a * (c(:,2,i+1,j+1,ksdm) - w(3,:,2,i,j,ksdm))
            br_x1(:)  = a * (c(:,1,i  ,j  ,ksdm) - w(3,:,2,i,j,ksdm))
            p_x1(:,1) = a * (p(:,  i  ,j  ,ksdm) - w(3,:,2,i,j,ksdm))
            p_x1(:,2) = a * (p(:,  i-1,j-1,ksdm) - w(3,:,2,i,j,ksdm))
            p_x1(:,3) = a * (p(:,  i  ,j-1,ksdm) - w(3,:,2,i,j,ksdm))
            p_x1(:,4) = a * (p(:,  i+1,j  ,ksdm) - w(3,:,2,i,j,ksdm))
         endif
            
! Transform to X4, dropping z component.
! Also drop tiny y component of CL and CR.

         utmp(:) = matmul (trans_X1_to_X4(:,:,ne,i,j,ksdm), cl_x1(:))
         cl_x4(1,ne,i,j,ksdm) = utmp(1)
         cl_x4(2,ne,i,j,ksdm) = c0

         utmp(:) = matmul (trans_X1_to_X4(:,:,ne,i,j,ksdm), cr_x1(:))
         cr_x4(1,ne,i,j,ksdm) = utmp(1)
         cr_x4(2,ne,i,j,ksdm) = c0

         utmp(:) = matmul (trans_X1_to_X4(:,:,ne,i,j,ksdm), tl_x1(:))
         tl_x4(:,ne,i,j,ksdm) = utmp(1:2)

         utmp(:) = matmul (trans_X1_to_X4(:,:,ne,i,j,ksdm), tr_x1(:))
         tr_x4(:,ne,i,j,ksdm) = utmp(1:2)

         utmp(:) = matmul (trans_X1_to_X4(:,:,ne,i,j,ksdm), bl_x1(:))
         bl_x4(:,ne,i,j,ksdm) = utmp(1:2)
         
         utmp(:) = matmul (trans_X1_to_X4(:,:,ne,i,j,ksdm), br_x1(:))
         br_x4(:,ne,i,j,ksdm) = utmp(1:2)

         do nd = 1, nedgedata
            utmp(:) = matmul (trans_X1_to_X4(:,:,ne,i,j,ksdm), p_x1(:,nd))
            p_x4(:,nd,ne,i,j,ksdm) = utmp(1:2)
         enddo   ! nedgedata

      enddo      ! nedges
      enddo      ! i
      enddo      ! j
      enddo      ! ksdm

!-----------------------------------------------------------------------
! Compute area-related quantities associated with X3.
! These are used in subroutine flux_integrals.
!-----------------------------------------------------------------------

      area_x3     = c0
      area_inv_x3 = c0
      xav         = c0
      yav         = c0
      xxav        = c0
      xyav        = c0
      yyav        = c0
      xxxav       = c0
      xxyav       = c0
      xyyav       = c0
      yyyav       = c0

! Note: Loops start at i = 1, j = 1 to include NP and SP

      do ksdm = 1, nsdm
      do j = 1, jjm-npad
      do i = 1, iim-npad

!-----------------------------------------------------------------------
! Locate (in X1) the cell centers of the X3 coordinate system.  
! Each cell center lies in a plane that is tangent to a vector from the 
! center of the earth.  But unlike cell centers in X1, the X3 cell centers 
! lie beneath the surface of the sphere of the earth, so that the tangent
! plane comes as close as possible to intersecting each neighboring corner.  
!-----------------------------------------------------------------------

! Compute average distance of corners from the center of the earth
! Note: p and c are unit vectors.  Multiply by radius of earth to get
!       actual distances.

         vtmp(:,1) = c(:, 1, i,   j,   ksdm) * vertex_mask(1,i,j,ksdm)
         vtmp(:,2) = c(:, 2, i,   j,   ksdm) * vertex_mask(2,i,j,ksdm)
         vtmp(:,3) = c(:, 1, i+1, j,   ksdm) * vertex_mask(3,i,j,ksdm)
         vtmp(:,4) = c(:, 2, i+1, j+1, ksdm) * vertex_mask(4,i,j,ksdm)
         vtmp(:,5) = c(:, 1, i+1, j+1, ksdm) * vertex_mask(5,i,j,ksdm)
         vtmp(:,6) = c(:, 2, i,   j+1, ksdm) * vertex_mask(6,i,j,ksdm)
         cmag = c0
         do nv = 1, nhexvert
            cmag = cmag                                                 & 
                 + sqrt(vtmp(1,nv)**2 + vtmp(2,nv)**2 + vtmp(3,nv)**2)
         enddo

         cmag = cmag / num_vertices(i,j,ksdm)       

! Compute average distance of corners from grid cell center

         vtmp(:,1) = (p(:,i,j,ksdm) - vtmp(:,1)) * vertex_mask(1,i,j,ksdm)
         vtmp(:,2) = (p(:,i,j,ksdm) - vtmp(:,2)) * vertex_mask(2,i,j,ksdm)
         vtmp(:,3) = (p(:,i,j,ksdm) - vtmp(:,3)) * vertex_mask(3,i,j,ksdm)
         vtmp(:,4) = (p(:,i,j,ksdm) - vtmp(:,4)) * vertex_mask(4,i,j,ksdm)
         vtmp(:,5) = (p(:,i,j,ksdm) - vtmp(:,5)) * vertex_mask(5,i,j,ksdm)
         vtmp(:,6) = (p(:,i,j,ksdm) - vtmp(:,6)) * vertex_mask(6,i,j,ksdm)
         pcmag = c0
         do nv = 1, nhexvert
            pcmag = pcmag                                               & 
                  + sqrt(vtmp(1,nv)**2 + vtmp(2,nv)**2 + vtmp(3,nv)**2)
         enddo
         pcmag = pcmag / num_vertices(i,j,ksdm)

! Estimate average angle between p vector and c vectors in X1.

         dtheta = atan(pcmag)    ! = atan[pcmag/mag(p)]

! Compute vector from center of earth to origin of X3 coordinates.
! (This vector is still in X1.)

         pmag = cmag * cos(dtheta)        ! slightly < 1
         utmp(:) = pmag * p(:,i,j,ksdm) 

!-----------------------------------------------------------------------
! For each face, compute coordinates of cell corners in X3.
!-----------------------------------------------------------------------

         vtmp(:,1) = matmul( trans_X1_to_X3(:,:,i,j,ksdm),             &
                             c(:,1,i,  j,  ksdm) - utmp(:) )

         vtmp(:,2) = matmul( trans_X1_to_X3(:,:,i,j,ksdm),             &
                             c(:,2,i,  j,  ksdm) - utmp(:) )

         vtmp(:,3) = matmul( trans_X1_to_X3(:,:,i,j,ksdm),             &
                             c(:,1,i+1,j,  ksdm) - utmp(:) )

         vtmp(:,4) = matmul( trans_X1_to_X3(:,:,i,j,ksdm),             &
                             c(:,2,i+1,j+1,ksdm) - utmp(:) )

         vtmp(:,5) = matmul( trans_X1_to_X3(:,:,i,j,ksdm),             &
                             c(:,1,i+1,j+1,ksdm) - utmp(:) )

         vtmp(:,6) = matmul( trans_X1_to_X3(:,:,i,j,ksdm),             &
                             c(:,2,i,  j+1,ksdm) - utmp(:) )

!-----------------------------------------------------------------------
! Project the cell corners onto the horizontal plane by dropping the 
!  z coordinates (which are small but not zero).
! Multiply by radius of earth to convert to actual distance from
!  cell center to cell corner.
! Where vertex_mask = 0 (false corner), load location of corner nv-1.
!  This means that the triangle defined by vertices nv and nv-1 and the 
!  midpoint will have zero area.
!-----------------------------------------------------------------------

         do nv = 1, nhexvert
            c_x3(:,nv,i,j,ksdm) = a * vtmp(1:2,nv)                    
            if (vertex_mask(nv,i,j,ksdm) == c0) then
               nv2 = nv - 1
               if (nv2==0) nv2 = nhexvert
               c_x3(:,nv,i,j,ksdm) = c_x3(:,nv2,i,j,ksdm)
            endif
         enddo

!-----------------------------------------------------------------------
! Compute area of each grid cell in X3.
! Also compute geometric averages that are used to locate centroids and
!  centers of mass.
!-----------------------------------------------------------------------

         do nv = 1,nhexvert     ! loop over hexagon corners

            nv2 = nv+1
            if (nv2 > nhexvert) nv2 = 1

! Compute the x and y coordinates of the vertices of the triangle 
! joining corners nv and nv+1 and the cell center.
! Also compute the triangle area and add to the cumulative area sum.

            tv(:,1) = c_x3(:,nv, i,j,ksdm)
            tv(:,2) = c_x3(:,nv2,i,j,ksdm)
            tv(:,3) = c0        ! cell center
            tarea = triangle_area (tv(:,1:3))
            area_x3(i,j,ksdm) = area_x3(i,j,ksdm) + tarea

! Compute coordinates of special points needed for cubic integrals
! (Integral = triangle area * weighted sum of midpoint value and values
!             along line segments joining triangle midpoint to vertices,
!             2/5 of the way out from the midpoint.)

            tv(:,0) = p333 * (tv(:,1) + tv(:,2) + tv(:,3))   ! midpoint
            do nvt = 1, ntrivert
               tv(:,nvt) = p6*tv(:,0) + p4*tv(:,nvt)
            enddo
 
! Using integral formula for linear functions, add to sums of xav and yav.
! (Integral = triangle area * midpoint value)

            xav(i,j,ksdm) = xav(i,j,ksdm) + tarea*tv(1,0)
            yav(i,j,ksdm) = yav(i,j,ksdm) + tarea*tv(2,0)

! Using integral formula for cubics, add to sums of xxav, xyav, yyav,
!  xxxav, xxyav, xyyav, and yyyav
! (Could use a quadratic formula for xxav, xyav, and yyav, but it's simpler
!  to use the same formula for all sums.)

            xxav(i,j,ksdm) = xxav(i,j,ksdm) + tarea *                   &
                 ( p5625m *  tv(1,0)*tv(1,0)                            &
                 + p52083 * (tv(1,1)*tv(1,1)                            &
                           + tv(1,2)*tv(1,2)                            &
                           + tv(1,3)*tv(1,3)) )                       

            xyav(i,j,ksdm) = xyav(i,j,ksdm) + tarea *                   &
                 ( p5625m *  tv(1,0)*tv(2,0)                            & 
                 + p52083 * (tv(1,1)*tv(2,1)                            &
                           + tv(1,2)*tv(2,2)                            &
                           + tv(1,3)*tv(2,3)) )

            yyav(i,j,ksdm) = yyav(i,j,ksdm) + tarea *                   &
                 ( p5625m *  tv(2,0)*tv(2,0)                            &
                 + p52083 * (tv(2,1)*tv(2,1)                            &
                           + tv(2,2)*tv(2,2)                            &
                           + tv(2,3)*tv(2,3)) )

            xxxav(i,j,ksdm) = xxxav(i,j,ksdm) + tarea *                 &
                 ( p5625m *  tv(1,0)*tv(1,0)*tv(1,0)                    &
                 + p52083 * (tv(1,1)*tv(1,1)*tv(1,1)                    &
                           + tv(1,2)*tv(1,2)*tv(1,2)                    &
                           + tv(1,3)*tv(1,3)*tv(1,3)) )

            xxyav(i,j,ksdm) = xxyav(i,j,ksdm) + tarea *                 &
                 ( p5625m *  tv(1,0)*tv(1,0)*tv(2,0)                    &
                 + p52083 * (tv(1,1)*tv(1,1)*tv(2,1)                    &
                           + tv(1,2)*tv(1,2)*tv(2,2)                    &
                           + tv(1,3)*tv(1,3)*tv(2,3)) )

            xyyav(i,j,ksdm) = xyyav(i,j,ksdm) + tarea *                 &
                 ( p5625m *  tv(1,0)*tv(2,0)*tv(2,0)                    &
                 + p52083 * (tv(1,1)*tv(2,1)*tv(2,1)                    &
                           + tv(1,2)*tv(2,2)*tv(2,2)                    &
                           + tv(1,3)*tv(2,3)*tv(2,3)) )

            yyyav(i,j,ksdm) = yyyav(i,j,ksdm) + tarea *                 &
                 ( p5625m *  tv(2,0)*tv(2,0)*tv(2,0)                    &
                 + p52083 * (tv(2,1)*tv(2,1)*tv(2,1)                    &
                           + tv(2,2)*tv(2,2)*tv(2,2)                    &
                           + tv(2,3)*tv(2,3)*tv(2,3)) )

         enddo                  ! nhexvert

! Divide by hexagon area in X3.
! NOTE: This area is not quite equal to the value obtained by summing
!       over corner areas in X2.

         area_inv_x3(i,j,ksdm) = c1 / area_x3(i,j,ksdm)

         xav(i,j,ksdm)   = xav(i,j,ksdm)   * area_inv_x3(i,j,ksdm)
         yav(i,j,ksdm)   = yav(i,j,ksdm)   * area_inv_x3(i,j,ksdm)
         xxav(i,j,ksdm)  = xxav(i,j,ksdm)  * area_inv_x3(i,j,ksdm)
         xyav(i,j,ksdm)  = xyav(i,j,ksdm)  * area_inv_x3(i,j,ksdm)
         yyav(i,j,ksdm)  = yyav(i,j,ksdm)  * area_inv_x3(i,j,ksdm)
         xxxav(i,j,ksdm) = xxxav(i,j,ksdm) * area_inv_x3(i,j,ksdm)
         xxyav(i,j,ksdm) = xxyav(i,j,ksdm) * area_inv_x3(i,j,ksdm)
         xyyav(i,j,ksdm) = xyyav(i,j,ksdm) * area_inv_x3(i,j,ksdm)
         yyyav(i,j,ksdm) = yyyav(i,j,ksdm) * area_inv_x3(i,j,ksdm)

      enddo                     ! i
      enddo                     ! j
      enddo                     ! ksdm

!-----------------------------------------------------------------------
! Wrap X3 quantities
!-----------------------------------------------------------------------

      do nv = 1, nhexvert
         do k1 = 1, nspace
            call wrap (component_name, face_1L=c_x3(k1,nv,:,:,:))
         enddo
      enddo

      call wrap(component_name, face_1L=area_x3)
      call wrap(component_name, face_1L=area_inv_x3)
      call wrap(component_name, face_1L=xav)
      call wrap(component_name, face_1L=yav)
      call wrap(component_name, face_1L=xxav)
      call wrap(component_name, face_1L=xyav)
      call wrap(component_name, face_1L=yyav)
      call wrap(component_name, face_1L=xxxav)
      call wrap(component_name, face_1L=xxyav)
      call wrap(component_name, face_1L=xyyav)
      call wrap(component_name, face_1L=yyyav)

!-----------------------------------------------------------------------
! Quantities associated with X2
!-----------------------------------------------------------------------
      do ksdm = 1, nsdm
      do j = 1, jjm
      do i = 1, iim
      do nc = 1, ncorners
         do nd = 1, ndata

!-----------------------------------------------------------------------
! Compute the X2 coordinates of the three edge midpoints associated
! with each corner in X2 coordinates.
!-----------------------------------------------------------------------

            utmp(:) = matmul( trans_to_X2(:,:,nc,i,j,ksdm),               & 
                           w(nd,:,nc,i,j,ksdm) - c(:,nc,i,j,ksdm) )
            ! z component should = 0
            w_x2(:,nd,nc,i,j,ksdm) = a * utmp(1:2)  ! Convert to real distance

!-----------------------------------------------------------------------
! Compute the angle between the three edges and local east in X2.
! Angles are in range [0, 2*pi).
!-----------------------------------------------------------------------

            if (abs(w_x2(1,nd,nc,i,j,ksdm)) > c0) then
               theta_x2(nd,nc,i,j,ksdm) = atan (w_x2(2,nd,nc,i,j,ksdm) &
                                             / (w_x2(1,nd,nc,i,j,ksdm)))
               if (w_x2(1,nd,nc,i,j,ksdm) < c0) then ! quadrant 2 or 3
                  theta_x2(nd,nc,i,j,ksdm) = theta_x2(nd,nc,i,j,ksdm) + pi
               elseif (w_x2(2,nd,nc,i,j,ksdm) < c0) then ! quadrant 4
                  theta_x2(nd,nc,i,j,ksdm) = theta_x2(nd,nc,i,j,ksdm) + pi2
               endif
            else  ! x component of w_x2 = c0
               theta_x2(nd,nc,i,j,ksdm) = p5*pi
               if (w_x2(2,nd,nc,i,j,ksdm) < c0) then  ! theta = 3*pi/2
                  theta_x2(nd,nc,i,j,ksdm) = theta_x2(nd,nc,i,j,ksdm) + pi
               endif
            endif

         enddo                  ! ndata
      enddo                     ! ncorners
      enddo                     ! i
      enddo                     ! j
      enddo                     ! ksdm

!-----------------------------------------------------------------------
! For each grid cell, compute quantities needed to find gradients at
! cell centers in X3.
!-----------------------------------------------------------------------


!-----------------------------------------------------------------------
! Transform v_weights from X2 to X1
!-----------------------------------------------------------------------

      utmp(3)   = c0
      do ksdm = 1, nsdm
      do j = 1, jjm
      do i = 1, iim
      do nc = 1, ncorners
      do nd = 1, ndata
         utmp(1:2) = v_weights(nd,:,nc,i,j,ksdm)
         vwgt_x1(nd,:,nc,i,j,ksdm) = matmul                            &
                                    (trans_to_X1(:,:,nc,i,j,ksdm), utmp)
      enddo  ! nd
      enddo  ! nc
      enddo  ! i
      enddo  ! j
      enddo  ! ksdm

!-----------------------------------------------------------------------
! Combine the various subzone v_weights to form the coefficients needed
!  for computing gradients at cell centers.
! The cell-centered gradient obtained using these weights is equal 
!  to the average of the six gradients computed at the cell corners.
!-----------------------------------------------------------------------

      do ksdm = 1, nsdm

!-----------------------------------------------------------------------
! Interior grid cells first
! Note: vwgt_x1(:,:,1,i+1,j+1,ksdm) = 0 for midlatitude pentagons
!-----------------------------------------------------------------------

       do j = 1+npad, jjm-npad
       do i = 1+npad, iim-npad

          gwgt_x1(:,0,i,j,ksdm) = vwgt_x1(1,:,1,i  ,j  ,ksdm)   &
                                + vwgt_x1(1,:,2,i  ,j  ,ksdm)   &
                                + vwgt_x1(2,:,1,i+1,j  ,ksdm)   &
                                + vwgt_x1(2,:,2,i+1,j+1,ksdm)   &
                                + vwgt_x1(3,:,1,i+1,j+1,ksdm)   &
                                + vwgt_x1(3,:,2,i  ,j+1,ksdm)

          gwgt_x1(:,1,i,j,ksdm) = vwgt_x1(2,:,1,i  ,j  ,ksdm)   &
                                + vwgt_x1(2,:,2,i  ,j+1,ksdm)

          gwgt_x1(:,2,i,j,ksdm) = vwgt_x1(3,:,1,i  ,j  ,ksdm)   &
                                + vwgt_x1(2,:,2,i  ,j  ,ksdm)

          gwgt_x1(:,3,i,j,ksdm) = vwgt_x1(3,:,2,i  ,j  ,ksdm)   &
                                + vwgt_x1(3,:,1,i+1,j  ,ksdm)

          gwgt_x1(:,4,i,j,ksdm) = vwgt_x1(1,:,1,i+1,j  ,ksdm)   &
                                + vwgt_x1(3,:,2,i+1,j+1,ksdm)

          gwgt_x1(:,5,i,j,ksdm) = vwgt_x1(1,:,2,i+1,j+1,ksdm)   &
                                + vwgt_x1(1,:,1,i+1,j+1,ksdm)

          gwgt_x1(:,6,i,j,ksdm) = vwgt_x1(2,:,1,i+1,j+1,ksdm)   &
                                + vwgt_x1(1,:,2,i  ,j+1,ksdm)
 
       enddo   ! i
       enddo   ! j

!-----------------------------------------------------------------------
! Repeat for North Pole
! Side 1 (neighbor i-1,j) and vertex 6 (corner 2,i,j+1) are missing.
!-----------------------------------------------------------------------

       i = 1          
       j = jjm - 1 

       gwgt_x1(:,0,i,j,ksdm) = vwgt_x1(1,:,1,i  ,j  ,ksdm)   &
                             + vwgt_x1(1,:,2,i  ,j  ,ksdm)   &
                             + vwgt_x1(2,:,1,i+1,j  ,ksdm)   &
                             + vwgt_x1(2,:,2,i+1,j+1,ksdm)   &
                             + vwgt_x1(3,:,1,i+1,j+1,ksdm)

       gwgt_x1(:,1,i,j,ksdm) = c0

       gwgt_x1(:,2,i,j,ksdm) = vwgt_x1(3,:,1,i  ,j  ,ksdm)   &
                             + vwgt_x1(2,:,2,i  ,j  ,ksdm)

       gwgt_x1(:,3,i,j,ksdm) = vwgt_x1(3,:,2,i  ,j  ,ksdm)   &
                             + vwgt_x1(3,:,1,i+1,j  ,ksdm)

       gwgt_x1(:,4,i,j,ksdm) = vwgt_x1(1,:,1,i+1,j  ,ksdm)   &
                             + vwgt_x1(3,:,2,i+1,j+1,ksdm)

       gwgt_x1(:,5,i,j,ksdm) = vwgt_x1(1,:,2,i+1,j+1,ksdm)   &
                             + vwgt_x1(1,:,1,i+1,j+1,ksdm)

       gwgt_x1(:,6,i,j,ksdm) = vwgt_x1(2,:,1,i+1,j+1,ksdm)   &
                             + vwgt_x1(2,:,1,i  ,j  ,ksdm)

!-----------------------------------------------------------------------
! Repeat for South Pole
! Side 3 (neighbor i,j-1) and vertex 3 (corner 1,i+1,j) are missing.
!-----------------------------------------------------------------------

       i = iim - 1          
       j = 1 

       gwgt_x1(:,0,i,j,ksdm) = vwgt_x1(1,:,1,i  ,j  ,ksdm)   &
                             + vwgt_x1(1,:,2,i  ,j  ,ksdm)   &
                             + vwgt_x1(2,:,2,i+1,j+1,ksdm)   &
                             + vwgt_x1(3,:,1,i+1,j+1,ksdm)   &
                             + vwgt_x1(3,:,2,i  ,j+1,ksdm)

       gwgt_x1(:,1,i,j,ksdm) = vwgt_x1(2,:,1,i  ,j  ,ksdm)   &
                             + vwgt_x1(2,:,2,i  ,j+1,ksdm)

       gwgt_x1(:,2,i,j,ksdm) = vwgt_x1(3,:,1,i  ,j  ,ksdm)   &
                             + vwgt_x1(2,:,2,i  ,j  ,ksdm)

       gwgt_x1(:,3,i,j,ksdm) = c0

       gwgt_x1(:,4,i,j,ksdm) = vwgt_x1(3,:,2,i  ,j  ,ksdm)   &
                             + vwgt_x1(3,:,2,i+1,j+1,ksdm)

       gwgt_x1(:,5,i,j,ksdm) = vwgt_x1(1,:,2,i+1,j+1,ksdm)   &
                             + vwgt_x1(1,:,1,i+1,j+1,ksdm)

       gwgt_x1(:,6,i,j,ksdm) = vwgt_x1(2,:,1,i+1,j+1,ksdm)   &
                             + vwgt_x1(1,:,2,i  ,j+1,ksdm)

!-----------------------------------------------------------------------
! Transform gradient weights to X3.
! Compute inverse of area enclosed by line integral.
!-----------------------------------------------------------------------
                       
       do j = 1, jjm-npad
       do i = 1, iim-npad

         do nv = 0, nhexvert

            gwgt_x3(:,nv,i,j,ksdm) = matmul(trans_X1_to_X3(:,:,i,j,ksdm), &
                                                  gwgt_x1(:,nv,i,j,ksdm))

         enddo

!-----------------------------------------------------------------------
! Make sure sum of weights is close to zero.
! Otherwise, a uniform field will have a nonzero gradient.
!-----------------------------------------------------------------------

         if (abs(sum(gwgt_x3(1,:,i,j,ksdm))) > 1.e-9) then
            print*, 'Warning: gradient weights do not sum to zero'
            print*, 'x sum of gwgt =', sum(gwgt_x3(1,:,i,j,ksdm))
            print*, 'i, j, ksdm =', i, j, ksdm
         endif

         if (abs(sum(gwgt_x3(2,:,i,j,ksdm))) > 1.e-9) then
            print*, 'Warning: gradient weights do not sum to zero'
            print*, 'y sum of gwgt =', sum(gwgt_x3(2,:,i,j,ksdm))
            print*, 'i, j, ksdm =', i, j, ksdm
         endif

!-----------------------------------------------------------------------
! Find the area enclosed by the line integral.
! Note: One of these corner areas = 0 for pentagons.
!-----------------------------------------------------------------------

         tarea = corner_area(1,i,  j,  ksdm)    &
               + corner_area(2,i,  j,  ksdm)    &
               + corner_area(1,i+1,j,  ksdm)    &
               + corner_area(2,i+1,j+1,ksdm)    &
               + corner_area(1,i+1,j+1,ksdm)    &
               + corner_area(2,i,  j+1,ksdm)

         garea_inv(i,j,ksdm) = c1 / tarea

       enddo                    ! i
       enddo                    ! j

      enddo                     ! ksdm

      end subroutine init_remap
!======================================================================
! END OF INIT_REMAP
!======================================================================


!=======================================================================
! BEGINNING OF REMAP_MASS_AND_TRACERS 
!=======================================================================
      subroutine remap_mass_and_tracers (component_name,               &
                                         nmass,  ntrace,               & 
                                         mass,   trace,                &
                                         dt,     uc,                   &
                                         pmask_in,                     &  
                                         depend_in,                    &
                                         integral_order_in,            &
                                         lin_dp2ord,                   &
                                         lin_check_conservation,       &
                                         lin_check_monotonicity,       &
                                         lin_check_divergence,         &
                                         lin_check_velocity,           &
                                         lin_mask_gradient,            &
                                         lin_limit_mass,               &
                                         lin_limit_mass_min,           &
                                         lin_limit_mass_max,           &
                                         lin_mass_pd,                  &
                                         lin_limit_tracers,            &
                                         lin_limit_tracers_min,        &
                                         lin_limit_tracers_max,        &
                                         lin_tracers_pd,               &
                                         edgeflux)              

!-----------------------------------------------------------------------
! Main subroutine for incremental remapping transport
!
! Note: Only the first seven arguments are mandatory.
!       The rest are optional and will be assigned default values if not
!         specified as input arguments.
!
! Also note: To increase efficiency, use of 'matmul' is avoided.
!-----------------------------------------------------------------------

      implicit none

!-----------------------------------------------------------------------
! INTENT IN
!-----------------------------------------------------------------------

      character (len=*), intent(in) :: component_name

      integer (kind=int_kind), intent(in) ::                           &
           nmass,        &! number of mass fields                       
           ntrace         ! number of tracer fields per mass field

      real (kind=dbl_kind), intent(in) ::                              &
           dt             ! time step

      real (kind=dbl_kind), intent(in),                                & 
         dimension(nspace,ncorners,iim,jjm,nsdm) ::                    &
           uc             ! velocity field at cell corners in X2
           
!-----------------------------------------------------------------------
! INTENT INOUT
!-----------------------------------------------------------------------

      real (kind=dbl_kind), intent(inout) ::                           &
           mass  (iim,jjm,       nmass,nsdm),      &! mass per unit area
           trace (iim,jjm,ntrace,nmass,nsdm)        ! tracer fields

!-----------------------------------------------------------------------
! INTENT IN, OPTIONAL
!-----------------------------------------------------------------------

      real (kind=dbl_kind), dimension(iim,jjm,nsdm),                   &
         intent(in), optional ::                                       &
           pmask_in           ! cell center mask; =0. for land points

      integer (kind=int_kind), dimension(ntrace),                      &
         intent(in), optional ::                                       &
           depend_in          ! dependency vector for tracers

      integer (kind=int_kind), intent(in), optional ::                 &
           integral_order_in  ! polynomial order of quadrature integrals
                              ! linear=1, quadratic=2, cubic=3

      logical (kind=log_kind), intent(in), optional ::                 &
           lin_dp2ord,                     &! 2nd order departure points
           lin_check_conservation,         &! check conservation of mass
           lin_check_monotonicity,         &! check tracer monotonicity
           lin_check_divergence,           &! check for large divergence
           lin_check_velocity,             &! check for large velocity
           lin_mask_gradient,              &! apply gradient mask
           lin_limit_mass,                 &! limit mass gradients
           lin_limit_mass_min,             &! limit mass gradients on the min side
           lin_limit_mass_max,             &! limit mass gradients on the max side
           lin_mass_pd,                    &! only impose positive definite constraints
           lin_limit_tracers,              &! limit tracer gradients
           lin_limit_tracers_min,          &! limit tracer gradients on the min side
           lin_limit_tracers_max,          &! limit tracer gradients on the max side
           lin_tracers_pd                   ! only impose positive definite constraints


!NOTE: Set lin_limit_mass = .true. if there are thin layers
!      Set lin_mask_gradient = .true. if there are land cells

!-----------------------------------------------------------------------
! INTENT OUT, OPTIONAL
!-----------------------------------------------------------------------

      real(kind=dbl_kind), dimension(1,nedges,iim,jjm,nsdm),           &
         intent(out), optional ::                                      &
           edgeflux       ! flux across edges, used for vorticity flux
                          ! units are mass * length * velocity

!-----------------------------------------------------------------------
! LOCAL
!-----------------------------------------------------------------------

      real (kind=dbl_kind), dimension(iim,jjm,nsdm) ::                 &
           pmask            ! cell center mask; pmask=0. for land points

      integer (kind=int_kind), dimension(ntrace) ::                    &
           depend           ! dependency vector for tracers

      integer (kind=int_kind) ::                                       &
           integral_order   ! polynomial order of quadrature integrals
                            ! linear=1, quadratic=2, cubic=3

      logical (kind=log_kind) ::                                       &
           l_dp2ord,                     &! 2nd order departure points
           l_check_conservation,         &! check conservation of mass
           l_check_monotonicity,         &! check tracer monotonicity
           l_check_divergence,           &! check for large divergence
           l_check_velocity,             &! check for large velocity
           l_mask_gradient,              &! apply gradient mask
           l_limit_mass,                 &! limit mass gradients
           l_limit_mass_min,             &! limit mass gradients
           l_limit_mass_max,             &! limit mass gradients
           l_mass_pd,                    &! pos def on mass
           l_limit_tracers,              &! limit tracer gradients
           l_limit_tracers_min,          &! limit tracer gradients
           l_limit_tracers_max,          &! limit tracer gradients
           l_tracers_pd                   ! pos def on tracers


      logical (kind=log_kind), dimension(ntrace) ::                    &
           has_dependents   ! true for tracers that have dependent tracers

      real (kind=dbl_kind), dimension(r3,ncorners,iim,jjm,nsdm) ::     &
           dp               ! departure points at cell corners in X1

      real (kind=dbl_kind),                                            &
          dimension(nspace,0:ntrivert,ngroups,nedges,iim,jjm)::        &
           tripoint         ! coordinates of triangle points

      real (kind=dbl_kind), dimension(ngroups,nedges,iim,jjm)::        &
           triarea          ! triangle areas

      integer (kind=int_kind),                                         &
         dimension(ngroups,nedges,iim,jjm) ::                          &
           nd_source        ! nd index of source grid cell

      real (kind=dbl_kind), dimension(iim,jjm,nmass,nsdm) ::           &
           mp,             &! mass at cell center  
           mx,             &! x gradient of mass 
           my,             &! y gradient of mass
           mmask            ! = 1. if mass > eps, else = 0.

      real (kind=dbl_kind), dimension(iim,jjm,ntrace,nmass,nsdm) ::    &
           tp,             &! tracer at cell center  
           tx,             &! x gradient of t 
           ty,             &! y gradient of t
           tmask            ! = 1. if abs(trace) > 0, else = 0.

      real (kind=dbl_kind),                                            & 
         dimension(1,nedges,iim,jjm,nmass,nsdm) ::                     &
           mflux            ! mass transport across cell edges
                            ! extra dimension '1' makes it wrappable

      real (kind=dbl_kind),                                            & 
         dimension(1,nedges,iim,jjm,ntrace,nmass,nsdm) ::              &
           mtflux           ! mass*tracer transport across cell edges
                            ! extra dimension '1' makes it wrappable

      real(kind=dbl_kind) ::                                           &
           dti              ! 1./dt

      integer (kind=int_kind) ::                                       &
           nm,             &! mass index
           nt               ! tracer index

! Remaining variables are used for optional bug checks

      real (kind=dbl_kind) ::                                          &
           msum_init,      &! initial global mass sum                  
           msum_final       ! final global mass sum

      real (kind=dbl_kind), dimension(ntrace) ::                       &
           mtsum_init,     &! initial global mass*tracer sum                  
           mtsum_final,    &! final global mass*tracer sum
           abs_mtsum        ! global abs(mass*tracer) sum      

      real (kind=dbl_kind), dimension(iim,jjm,ntrace,nmass,nsdm) ::    &
           tmin,           &! minimum local tracer value
           tmax             ! maximum local tracer value

!lipscomb - debug 
      integer (kind=int_kind) :: i, j, n, nc, it, umag
      real (kind=dbl_kind), dimension(r3) :: utmp 

!-----------------------------------------------------------------------
! Set logical variables.
! NOTE: Default values are appropriate for the shallow-water model.
!       They can be overridden by passing in optional arguments.
!-----------------------------------------------------------------------

      if (present(pmask_in)) then
         pmask(:,:,:) = pmask_in(:,:,:)
      else
         pmask(:,:,:) = c1      ! no cells masked out
      endif
         
      depend(:)            =  c0        
      integral_order       =  1         
      l_dp2ord             = .false.    
      l_check_conservation = .false.
      l_check_monotonicity = .false.
      l_check_divergence   = .false.
      l_check_velocity     = .false.
      l_mask_gradient      = .false.
      l_limit_mass         = .false.
      l_limit_mass_min     = .false.
      l_limit_mass_max     = .false.
      l_limit_tracers      = .true. 
      l_mass_pd            = .false.
      l_tracers_pd         = .false.

      if (present(depend_in))                                          &
                  depend               = depend_in
      if (present(integral_order_in))                                  &
                  integral_order       = integral_order_in
      if (present(lin_dp2ord))                                         &
                  l_dp2ord             = lin_dp2ord
      if (present(lin_check_conservation))                             &
                  l_check_conservation = lin_check_conservation
      if (present(lin_check_monotonicity))                             &
                  l_check_monotonicity = lin_check_monotonicity
      if (present(lin_check_divergence))                               &
                  l_check_divergence   = lin_check_divergence
      if (present(lin_check_velocity))                                 &
                  l_check_velocity     = lin_check_velocity
      if (present(lin_mask_gradient))                                  &
                  l_mask_gradient      = lin_mask_gradient
      if (present(lin_limit_mass))                                     &
                  l_limit_mass         = lin_limit_mass
      if (present(lin_limit_mass_min))                                 &
                  l_limit_mass_min         = lin_limit_mass_min
      if (present(lin_limit_mass_max))                                 &
                  l_limit_mass_max         = lin_limit_mass_max
      if (present(lin_mass_pd))                                        &
                  l_mass_pd         = lin_mass_pd
      if (present(lin_limit_tracers))                                  &
                  l_limit_tracers      = lin_limit_tracers
      if (present(lin_limit_tracers_min))                              &
                  l_limit_tracers_min      = lin_limit_tracers_min
      if (present(lin_limit_tracers_max))                              &
                  l_limit_tracers_max      = lin_limit_tracers_max
      if (present(lin_tracers_pd))                                     &
                  l_tracers_pd      = lin_tracers_pd



!-----------------------------------------------------------------------
! Get information from depend vector.
! Make sure mass field is positive definite.
!-----------------------------------------------------------------------

!      call timer_start('remap_fields')

      do ksdm = 1, nsdm
      do nm = 1, nmass
         call remap_prep (depend, has_dependents, ntrace,           &
                          mass (:,:,nm,ksdm), trace(:,:,:,nm,ksdm), &
                          mmask(:,:,nm,ksdm), tmask(:,:,:,nm,ksdm) )
      enddo
      enddo

!-----------------------------------------------------------------------
! Compute global sums of conserved quantities.
!-----------------------------------------------------------------------

      if (l_check_conservation) then 
         call conserved_sums (component_name,                          &
                              nmass,     ntrace,                       &
                              mass,      trace,                        &
                              msum_init, mtsum_init,                   &
                              depend)
      endif

!-----------------------------------------------------------------------
! Compute local max and min of mass and tracer fields.
!-----------------------------------------------------------------------
      
      if (l_check_monotonicity) then 
         call local_maxmin (component_name,                            &
                            nmass, ntrace, trace,                      &
                            mmask, tmask,  depend,                     &
                            tmin,  tmax )
      endif

!-----------------------------------------------------------------------
! Given the mean values of mass and tracer in each grid cell, constuct
! linear mass and tracer fields (cell-center value and limited x and y
! gradients).
!-----------------------------------------------------------------------

      do ksdm = 1, nsdm
      do nm = 1, nmass
         call construct_fields (ntrace,                                   & 
                                mass(:,:,nm,ksdm), trace(:,:,:,nm,ksdm),  &
                                pmask  (:,:,ksdm), l_mask_gradient,       &
                                l_limit_mass,                             &
                                l_limit_mass_min, l_limit_mass_max,       &
                                l_mass_pd,                                &
                                l_limit_tracers,                          &
                                l_limit_tracers_min, l_limit_tracers_max, &
                                l_tracers_pd,                             &
                                depend,            has_dependents,        &
                                mx  (:,:,nm,ksdm), my     (:,:,nm,ksdm),  &    
                                mp  (:,:,nm,ksdm), mmask  (:,:,nm,ksdm),  &
                                tx(:,:,:,nm,ksdm), ty   (:,:,:,nm,ksdm),  &  
                                tp(:,:,:,nm,ksdm), tmask(:,:,:,nm,ksdm) )

      enddo                     ! nmass
      enddo                     ! nsdm

!-----------------------------------------------------------------------
! Wrap these quantities.
!-----------------------------------------------------------------------

      call wrap (component_name, face=mx)
      call wrap (component_name, face=my)
      call wrap (component_name, face=mp)
      do nm = 1, nmass
         call wrap (component_name, face= tx(:,:,:,nm,:))
         call wrap (component_name, face= ty(:,:,:,nm,:))
         call wrap (component_name, face= tp(:,:,:,nm,:))
      enddo

!      call timer_stop('remap_fields')

!-----------------------------------------------------------------------
! Given velocities, compute departure points in X1 coordinates. 
! Velocity wrap may not be needed, but is included just to be safe. 
!----------------------------------------------------------------------- 
 
!      call timer_start('remap_geom') 
 
      call wrap (component_name, vrtx_1L=uc(:,:,:,:,:)) 

      if (l_dp2ord) then   ! 2nd order departure points
         do ksdm = 1, nsdm
            call departure_points_2order                               &
                 (dt, uc(:,:,:,:,ksdm), dp(:,:,:,:,ksdm),              & 
                  l_check_velocity)
         enddo
      else                 ! 1st order departure points
         do ksdm = 1, nsdm
            call departure_points_1order                               &
                 (dt, uc(:,:,:,:,ksdm), dp(:,:,:,:,ksdm),              &
                  l_check_velocity)
         enddo
      endif

!-----------------------------------------------------------------------
! Wrap departure points
!-----------------------------------------------------------------------

      call wrap (component_name, vrtx_1L=dp(:,:,:,:,:))

!      call timer_stop('remap_geom')

!lipscomb - debug
! This code is to diagnose a very strange bug involving a departure point
! that is wrapped to the wrong location.
!
!     do ksdm = 1, nsdm
!        do j = 1, jjm
!           do i = 1, iim
!              do nc = 1, 2
!                 utmp(:) = dp(:,nc,i,j,ksdm) / a
!
!                 if (abs(utmp(1)+2.997e-3) < 0.01 .and.   &
!                     abs(utmp(2)-0.999526) < 0.01 .and.   &
!                     abs(utmp(3)+2.156e-2) < 0.01) then
!                     write(6,*) ''
!                     write(6,*) 'dp =', utmp(:)
!                     write(6,*) 'my_task, i, j, nc, ksdm =',  &
!                                 my_task, i, j, nc, ksdm

!                     if ((i==2  .and. j==17)  .or.   &
!                         (i==2  .and. j==1)   .or.   &
!                         (i==18 .and. j==17) ) then   ! legitimate values
!                        continue
!                     else
!                        write(6,*) 'WARNING: Miswrapped departure point!'
!                        write(6,*) 'my_task, i, j, nc, ksdm =',  &
!                                    my_task, i, j, nc, ksdm
!                        write(6,*) 'c =', c(:,nc,i,j,ksdm)
!                     endif
!                  endif

!                  umag = sqrt(utmp(1)**2 + utmp(2)**2 + utmp(3)**2)
!                  if (umag < 0.1) then
!                      write(6,*) ''
!                      write(6,*) 'WARNING: Miswrapped departure point!'
!                      write(6,*) 'dp =', utmp(:)
!                      write(6,*) 'my_task, i, j, nc, ksdm =',  &
!                                  my_task, i, j, nc, ksdm
!                  endif
! 
!              enddo
!           enddo
!        enddo
!     enddo


!-----------------------------------------------------------------------
! Compute mass and tracer transports across each half-edge of each corner
!-----------------------------------------------------------------------

      do ksdm = 1, nsdm

!-----------------------------------------------------------------------
! Compute area and vertices of departure triangles for the three
! half-edges associated with each of two corners of each grid cell.
!
! Given the triangle vertices, compute coordinates of the interior 
! quadrature points. 
!-----------------------------------------------------------------------

!         call timer_start('remap_geom')

         call locate_triangles  (dp(:,:,:,:,ksdm), integral_order,     & 
                                 tripoint,         triarea,            &
                                 nd_source)  

!         call timer_stop("remap_geom")

!-----------------------------------------------------------------------
! Integrate mass and tracer transports over each departure triangle.
!-----------------------------------------------------------------------

!         call timer_start('remap_fields')

         do nm = 1, nmass
            call transport_integrals (ntrace,                          &
                mp   (    :,:,nm,ksdm), tp    (    :,:,:,nm,ksdm),     &
                mx   (    :,:,nm,ksdm), tx    (    :,:,:,nm,ksdm),     &
                my   (    :,:,nm,ksdm), ty    (    :,:,:,nm,ksdm),     &
                mmask(    :,:,nm,ksdm), tmask (    :,:,:,nm,ksdm),     &
                mflux(1,:,:,:,nm,ksdm), mtflux(1,:,:,:,:,nm,ksdm),     &
                tripoint,               triarea,                       &
                nd_source,              integral_order,                &
                depend,                 has_dependents)
         enddo                  ! nmass

!         call timer_stop('remap_fields')

      enddo                     ! nsdm

!-----------------------------------------------------------------------
! Wrap mass and tracer transports.
!-----------------------------------------------------------------------

!      call timer_start('remap_fields')

      call wrap (component_name, edge=mflux(:,:,:,:,:,:))

      do nm = 1, nmass
         call wrap (component_name, edge=mtflux(:,:,:,:,:,nm,:))
      enddo

!-----------------------------------------------------------------------
! Compute edge flux array needed for SWM.
! Assume height field is in nm = 1 slot.
!-----------------------------------------------------------------------

      if (present(edgeflux)) then
         dti = c1/dt
         edgeflux(:,:,:,:,:) = mflux(:,:,:,:,1,:)*dti
      endif

      do ksdm = 1, nsdm
      do nm = 1, nmass

!-----------------------------------------------------------------------
! Given transports across edges, compute new mass and tracer values.
!-----------------------------------------------------------------------

         call update_fields ( ntrace,                                 &
               mass      (:,:,nm,ksdm), trace     (:,:,:,nm,ksdm),    &
               mflux (1,:,:,:,nm,ksdm), mtflux(1,:,:,:,:,nm,ksdm),    & 
               depend,                  l_check_divergence )

      enddo               ! nm
      enddo               ! nsdm

!-----------------------------------------------------------------------
! Check monotonicity.  (Make sure no new extreme tracer values have
! been created.)
!-----------------------------------------------------------------------

      if (l_check_monotonicity) then
         do ksdm = 1, nsdm
         do nm = 1, nmass
            call monotonicity_check (ntrace, depend,                   &
                       mass(:,:,  nm,ksdm),  trace(:,:,:,nm,ksdm),     &
                       tmin(:,:,:,nm,ksdm),  tmax (:,:,:,nm,ksdm) )
         enddo                  ! nmass
         enddo                  ! nsdm
      endif

!-----------------------------------------------------------------------
! Compute new global sums of conserved quantities and check conservation.
!-----------------------------------------------------------------------

      if (l_check_conservation) then
         call conserved_sums (component_name,                          &
                              nmass,      ntrace,                      &
                              mass,       trace,                       &
                              msum_final, mtsum_final,                 &
                              depend,     abs_mtsum)
         call conservation_check (ntrace,                              &
                                  msum_init,  msum_final,              &
                                  mtsum_init, mtsum_final,             &
                                  abs_mtsum)
      endif

!      call timer_stop('remap_fields')

      end subroutine remap_mass_and_tracers
!=======================================================================
! END OF REMAP_MASS_AND_TRACERS
!=======================================================================


!=======================================================================
! BEGINNING OF REMAP_PREP
!=======================================================================
      subroutine remap_prep (depend, has_dependents, ntrace,  & 
                             mass,   trace,                   &
                             mmask,  tmask)

!-----------------------------------------------------------------------
! Get information from depend vector.
! Make sure mass field is positive definite.
! Set very small masses to zero.
! Zero out tracers where the mass is zero (and zero out dependent tracers
!  where the tracer they depend on is zero).
! Make mass and tracer masks.
!
! NOTE: Can reduce eps to decrease the conservation error from discarding 
!       tiny masses. 
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
! First a few words on the dependency vector:
! Typically we solve two forms of the transport equation:
! (1) dm/dt + del*(um) = 0
! (2) d(mT)/dt + del*(umT) = 0
! where m is mass per unit area or an equivalent field (such as layer 
! thickness or fractional ice area) and T is a tracer field (such as 
! concentration of heat, vapor, or salt).
! To compute the new value of T, we compute the new m and the new mT,
! then divide.
!
! Sometimes we have three forms of the transport equation.  
! For example, in a sea ice model we may have
! (1) da/dt + del*(ua) = 0
! (2) d(ah)/dt + del*(uah) = 0
! (3) d(ahq)/dt + del*(uahq) = 0
! where a = fractional ice area, h = thickness, q = enthalpy,
!       v = a*h = volume, e = a*h*q = energy
!
! To compute the new (h), we compute the new (a) and the new (ah), 
!  then divide.  Thus the new (h) depends on the new (a).
! To compute the new (q), we compute the new (ah) and the new (ahq),
!  then divide.  Thus the new (q) depends not only on the new (a),
!  a mass-type quantity, but also on the new (h), a tracer.
! To distinguish tracers like (h) from tracers like (q), we define
!  a dependency vector.  For example:
! 
!  nt        depend(nt)
! --------   ---------
! (1) hice       0
! (2) hsno       0
! (3) Tsfc       0
! (4) qice       1
! (5) qsno       2
!
! The dependency vector (0,0,0,1,2) indicates that new values of the 
! first three tracers are independent of the other tracers, whereas
! the new value of field 4 (qice) depends on the new value of field 1
! (hice), and the new value of field 5 (qsno) depends on the new value
! of field 2 (hsno).
!
! If there are no equations of the form (3), then depend(:) = 0.
!
! Note: If a tracer with dependents has a value of 0, we zero out
!       the values of its dependent tracers.
!       For instance, if hice = 0, we zero out qice.
!-----------------------------------------------------------------------

      implicit none

!-----------------------------------------------------------------------
! INTENT IN
!-----------------------------------------------------------------------
      integer (kind=int_kind), intent(in) ::                           &
           ntrace              ! number of tracer fields

      integer (kind=int_kind), dimension(ntrace), intent(in) ::        &
           depend              ! dependency vector for tracers

!-----------------------------------------------------------------------
! INTENT INOUT
!-----------------------------------------------------------------------
      real (kind=dbl_kind), intent(inout) ::                           &
           mass  (iim,jjm),          &! mass field
           trace (iim,jjm,ntrace)     ! tracer fields

!-----------------------------------------------------------------------
! INTENT OUT
!-----------------------------------------------------------------------
      logical (kind=log_kind), dimension(ntrace), intent(out) ::       &
           has_dependents      ! true for tracers with dependent tracers

      real (kind=dbl_kind), intent(out), dimension(iim,jjm) ::         &
           mmask             ! = 1. if mass > 0, else = 0.

      real (kind=dbl_kind), intent(out), dimension(iim,jjm,ntrace) ::  &
           tmask             ! = 1. if abs(trace) > 0, else = 0.

!-----------------------------------------------------------------------
! LOCAL
!-----------------------------------------------------------------------

      integer (kind=int_kind) ::                                       &
           i, j,              &! horizontal indices
           nt, nt1             ! tracer indices
           
!-----------------------------------------------------------------------
! Determine whether there are dependent tracers requiring cubic integrals.
! Identify tracer fields with other tracer fields as dependents.
! Make sure dependent fields have a higher tracer index than the fields
!  they depend on. 
!-----------------------------------------------------------------------

      has_dependents = .false.
      if (sum(depend) >= 1) then
         do nt = 1, ntrace
            nt1 = depend(nt)
            if (nt1 >= 1) then  ! nt depends on nt1
               has_dependents(nt1) = .true.
               if (nt1 > nt) then
                  write (6,*) 'Dependent tracer has index', nt
                  write (6,*) 'This tracer depends on tracer', nt1
                  write (6,*) 'Must have nt > nt1'
                  stop
               endif
            endif 
         enddo                  ! nt
      endif                     ! sum(depend) >=1

!-----------------------------------------------------------------------
! Make sure mass field is non-negative.
! Make mass mask.
!-----------------------------------------------------------------------

      do j = 1, jjm
      do i = 1, iim
         if (mass(i,j) < -eps) then
            write (6,*) 'Remapping requires non-negative mass field'
            write (6,*) 'my_task, i, j, ksdm, mass:',                   &
                         my_task, i, j, ksdm, mass(i,j)
            stop
         elseif (mass(i,j) < eps) then
            mass (i,j) = c0
            mmask(i,j) = c0
            do nt = 1, ntrace
               trace(i,j,nt) = c0
            enddo
         else   ! mass > eps
            mmask(i,j) = c1
         endif
      enddo                     ! i
      enddo                     ! j

!-----------------------------------------------------------------------
! Make tracer masks
! Note: Tracer fields without dependents are allowed to have any value.
!       However, tracer fields with dependents are treated like mass fields.
!        If such a field has a value very close to zero, it is set to zero,
!        and its dependent fields are also set to zero in that grid cell.
!-----------------------------------------------------------------------

      do nt = 1, ntrace
         if (has_dependents(nt)) then
            do j = 1, jjm
            do i = 1, iim
               if (abs(trace(i,j,nt)) < eps) then
                  trace(i,j,nt) = c0
                  tmask(i,j,nt) = c0
                  do nt1 = 1, ntrace
                     if (depend(nt1)==nt) trace(i,j,nt1) = c0
                  enddo
               else
                  tmask(i,j,nt) = c1
               endif
            enddo               ! i
            enddo               ! j                     
         else                   ! mask isn't needed, so set to zero
            do j = 1, jjm
            do i = 1, iim
               tmask(i,j,nt) = c0
            enddo               ! i
            enddo               ! j
         endif                  ! has_dependents
      enddo                     ! nt

      end subroutine remap_prep
!=======================================================================
! END OF REMAP_PREP
!=======================================================================


!=======================================================================
! BEGINNING OF CONSTRUCT_FIELDS
!=======================================================================
      subroutine construct_fields (ntrace,                             &
                                mass,         trace,                &
                                pmask,        l_mask_gradient,      &
                                l_limit_mass,                       &
                                l_limit_mass_min, l_limit_mass_max, &
                                l_mass_pd,                          &
                                l_limit_tracers,                    & 
                                l_limit_tracers_min, l_limit_tracers_max, &
                                l_tracers_pd,                        &
                                depend,       has_dependents,       &
                                mx,           my,                   &
                                mp,           mmask,                &
                                tx,           ty,                   &
                                tp,           tmask)

!-----------------------------------------------------------------------
! Given the mean values of mass and tracer in each grid cell, construct
! linear mass and tracer fields.
!-----------------------------------------------------------------------

      implicit none

!-----------------------------------------------------------------------
! INTENT IN
!-----------------------------------------------------------------------

      integer (kind=int_kind), intent(in) ::                           &
           ntrace            ! number of tracer fields

      real (kind=dbl_kind), intent(in) ::                              &
           mass  (iim,jjm       ),     &! mean mass field
           mmask (iim,jjm       ),     &! mass mask
           trace (iim,jjm,ntrace),     &! mean tracer fields
           tmask (iim,jjm,ntrace)       ! tracer mask

      real (kind=dbl_kind), dimension(iim,jjm), intent(in) ::     &
           pmask             ! cell center mask; pmask=0. for land points

      logical, intent(in) ::                                           &
           l_mask_gradient,       &! true if gradient mask is applied
           l_limit_mass,          &! true if mass gradients are limited
           l_limit_mass_min,      &! true if mass gradients are limited
           l_limit_mass_max,      &! true if mass gradients are limited
           l_mass_pd,             &! true for only pos def limit on mass
           l_limit_tracers,       &! true if tracer gradients are limited
           l_limit_tracers_min,   &! true if tracer gradients are limited
           l_limit_tracers_max,   &! true if tracer gradients are limited
           l_tracers_pd            ! true if only pos def limit on tracers


      integer (kind=int_kind), dimension(ntrace), intent(in) ::        &
           depend            ! dependency vector for tracers

      logical (kind=log_kind), dimension(ntrace), intent(in) ::        &
           has_dependents    ! true for tracers with dependent tracers

!-----------------------------------------------------------------------
! INTENT OUT
!-----------------------------------------------------------------------
      real (kind=dbl_kind), intent(out), dimension(iim,jjm) ::         &
           mx,              &! x gradient of mass 
           my,              &! y gradient of mass
           mp                ! mass at cell center  

      real (kind=dbl_kind), intent(out), dimension(iim,jjm,ntrace) ::  &
           tx,              &! x gradient of t 
           ty,              &! y gradient of t
           tp                ! tracer at cell center  

!-----------------------------------------------------------------------
! LOCAL
!-----------------------------------------------------------------------

      integer (kind=int_kind) ::                                       &
           i, j,            &! horizontal indices
           nt, nt1           ! tracer indices

      real (kind=dbl_kind), dimension(iim,jjm) ::                      &
           xmav,            &! x coordinate of center of mass
           ymav              ! y coordinate of center of mass

      real (kind=dbl_kind), dimension(iim,jjm,ntrace) ::               &
           xmtav,           &! x coordinate of center of mass*tracer
           ymtav             ! y coordinate of center of mass*tracer

      real (kind=dbl_kind) ::                                          &
           wk1,wk2,wk3,wk4,wk5,wk6,wk7  ! work variables
        
!-----------------------------------------------------------------------
! Compute X3 gradient of mass and tracer fields 
!-----------------------------------------------------------------------
      call gradient_at_cell_centers(                                  &
                npad,                                                 &
                iim,                                                  &
                jjm,                                                  &
                nspace,                                               &
                nhexvert,                                             &
                garea_inv(:,:,ksdm),                                  &
                gwgt_x3(1:2,:,:,:,ksdm),                              &
                mass(:,:),                                            &
                mx(:,:),                                              &
                my(:,:) )

      do nt = 1, ntrace
         call gradient_at_cell_centers(                               &
                npad,                                                 &
                iim,                                                  &
                jjm,                                                  &
                nspace,                                               &
                nhexvert,                                             &
                garea_inv(:,:,ksdm),                                  &
                gwgt_x3(1:2,:,:,:,ksdm),                              &
                trace(:,:,nt),                                        &
                tx(:,:,nt),                                           &
                ty(:,:,nt) )

      enddo   ! ntrace

!-----------------------------------------------------------------------
! Mask and limit the mass gradients.
! Note: pmask = 0. for land cells if doing ocean or ice transport. 
!-----------------------------------------------------------------------

      if (l_mask_gradient)                                             &
          call mask_gradient (mx(:,:), my(:,:), pmask(:,:))

      if (l_limit_mass)                                                &  
          call limit_gradient(mass(:,:),      pmask(:,:),              &
                              xav (:,:,ksdm), yav  (:,:,ksdm),         &
                              mx  (:,:),      my   (:,:),              &
                              l_limit_mass_min, l_limit_mass_max,l_mass_pd )
                       
 
!-----------------------------------------------------------------------
! Compute mass field at cell centers.
! Compute centers of mass.
!-----------------------------------------------------------------------
      do j = 1, jjm-npad    ! loop includes NP and SP
      do i = 1, iim-npad
           
         if (mass(i,j) > eps) then      
            mp(i,j) = mass(i,j)                                        &
                    - xav(i,j,ksdm) * mx(i,j)                          &   
                    - yav(i,j,ksdm) * my(i,j)
            wk1 = c1 / mass(i,j)
            xmav(i,j) = ( mx(i,j) * xxav(i,j,ksdm)                     & 
                        + my(i,j) * xyav(i,j,ksdm)                     &
                        + mp(i,j) * xav (i,j,ksdm)) * wk1
            ymav(i,j) = ( mx(i,j) * xyav(i,j,ksdm)                     & 
                        + my(i,j) * yyav(i,j,ksdm)                     &
                        + mp(i,j) * yav (i,j,ksdm)) * wk1
         else
            mp   (i,j) = c0
            xmav (i,j) = c0
            ymav (i,j) = c0
         endif
           
      enddo                     ! i
      enddo                     ! j

!-----------------------------------------------------------------------
! Mask and limit the tracer gradients.
! Compute tracer values at cell centers.
! Compute centers of mass*tracer (for tracers with dependent fields).
!-----------------------------------------------------------------------

      do nt = 1, ntrace
              
         if (depend(nt)==0) then ! independent of other tracers

            if (l_mask_gradient)                                       &
               call mask_gradient(tx(:,:,nt), ty(:,:,nt), mmask(:,:))

            if (l_limit_tracers)                                       &
               call limit_gradient                                     &
                       (trace(:,:,nt), mmask (:,:),                    &
                        xmav (:,:)   , ymav  (:,:),                    &
                        tx   (:,:,nt), ty    (:,:,nt),                 &
                        l_limit_tracers_min, l_limit_tracers_max,l_tracers_pd   )

            do j = 1, jjm-npad
            do i = 1, iim-npad
               if (mmask(i,j) > eps) then
                  tp(i,j,nt) =  trace(i,j,nt)                          & 
                              - tx(i,j,nt) * xmav(i,j)                 &
                              - ty(i,j,nt) * ymav(i,j)       
               else             ! mmask = 0
                  tp(i,j,nt) = c0
               endif
               xmtav(i,j,nt) = c0
               ymtav(i,j,nt) = c0
            enddo               ! i
            enddo               ! j

            if (has_dependents(nt)) then ! find center of mass*tracer

               do j = 1, jjm-npad
               do i = 1, iim-npad
                  if (mmask(i,j)> eps .and. abs(trace(i,j,nt)) > eps) then
                     wk1 = mp(i,j) * tp(i,j,nt)
                     wk2 = mp(i,j) * tx(i,j,nt) + mx(i,j) * tp(i,j,nt)
                     wk3 = mp(i,j) * ty(i,j,nt) + my(i,j) * tp(i,j,nt)
                     wk4 = mx(i,j) * tx(i,j,nt)
                     wk5 = mx(i,j) * ty(i,j,nt) + my(i,j) * tx(i,j,nt)
                     wk6 = my(i,j) * ty(i,j,nt)
                     wk7 = c1 / (mass(i,j) * trace(i,j,nt))
                     xmtav(i,j,nt) = ( wk1 *   xav(i,j,ksdm)        &   
                                     + wk2 *  xxav(i,j,ksdm)        &
                                     + wk3 *  xyav(i,j,ksdm)        &
                                     + wk4 * xxxav(i,j,ksdm)        &
                                     + wk5 * xxyav(i,j,ksdm)        &
                                     + wk6 * xyyav(i,j,ksdm) )      &
                                     * wk7
                     ymtav(i,j,nt) = ( wk1 *   yav(i,j,ksdm)        &
                                     + wk2 *  xyav(i,j,ksdm)        &
                                     + wk3 *  yyav(i,j,ksdm)        &
                                     + wk4 * xxyav(i,j,ksdm)        &
                                     + wk5 * xyyav(i,j,ksdm)        &
                                     + wk6 * yyyav(i,j,ksdm) )      &
                                     * wk7
                  endif         ! mmask > eps and abs(trace) > eps
               enddo            ! i
               enddo            ! j
            endif               ! tracer nt has dependents

         else                   ! tracer(nt) depends on another tracer

            nt1 = depend(nt)

            if (l_mask_gradient)                                       &
               call mask_gradient(tx(:,:,nt), ty(:,:,nt), tmask(:,:,nt1))

            if (l_limit_tracers)                                       &
               call limit_gradient                                     &
                   (trace(:,:,nt),  tmask (:,:,nt1),                   &
                    xmtav(:,:,nt1), ymtav (:,:,nt1),                   &
                    tx   (:,:,nt),  ty    (:,:,nt ),                   &
                    l_limit_tracers_min, l_limit_tracers_max, l_tracers_pd  )

            do j = 1, jjm-npad
            do i = 1, iim-npad

               if (tmask(i,j,nt1) > eps) then
                  tp(i,j,nt) = trace(i,j,nt)                           &
                                - tx(i,j,nt) * xmtav(i,j,nt1)          &
                                - ty(i,j,nt) * ymtav(i,j,nt1)
               else
                  tp(i,j,nt) = c0
               endif
               xmtav(i,j,nt) = c0
               ymtav(i,j,nt) = c0

            enddo               ! i
            enddo               ! j

         endif                  ! depend(nt) = 0
      enddo                     ! ntrace

      end subroutine construct_fields
!=======================================================================
! END OF CONSTRUCT_FIELDS
!=======================================================================


!=======================================================================
! BEGINNING OF MASK_GRADIENT 
!=======================================================================

      subroutine mask_gradient (phix, phiy, phimask)

!-----------------------------------------------------------------------
! Zero out the gradient in grid cells bordered by masked cells.
! The reason for this is that in masked cells the value of phi has
!  no physical value, so the gradient computed above may not be accurate. 
!-----------------------------------------------------------------------

      implicit none

!-----------------------------------------------------------------------
! INTENT INOUT
!-----------------------------------------------------------------------

      real (kind=dbl_kind), dimension (iim,jjm), intent(inout) ::      &
           phix,       &! x gradient of phi in X3
           phiy         ! y gradient of phi in X3

!-----------------------------------------------------------------------
! INTENT IN
!-----------------------------------------------------------------------

      real (kind=dbl_kind), dimension (iim,jjm), intent(in) ::        &
           phimask      ! = 1. if phi(i,j) has physical meaning, else = 0.

!-----------------------------------------------------------------------
! LOCAL
!-----------------------------------------------------------------------

      integer (kind=int_kind) ::                                       &
           i,j          ! horizontal indices

      real (kind=dbl_kind) ::                                          &
           gradmask     ! = 0. for cell if neighboring cell is masked

! Interior cells

      do j = 1+npad, jjm-npad
      do i = 1+npad, iim-npad

         gradmask = min (phimask(i-1,j), phimask(i-1,j-1), phimask(i,j-1), &
                         phimask(i+1,j), phimask(i+1,j+1), phimask(i,j+1) )
         phix(i,j) = phix(i,j) * gradmask
         phiy(i,j) = phiy(i,j) * gradmask

      enddo                     ! i
      enddo                     ! j

! North Pole  
! Neighbor (i-1,j) is missing, and data from (i-1,j-1) is stored in (iim,1)

      i = 1          
      j = jjm - 1 

      gradmask = min (                phimask(iim,  1), phimask(i,j-1), &
                      phimask(i+1,j), phimask(i+1,j+1), phimask(i,j+1) )
      phix(i,j) = phix(i,j) * gradmask
      phiy(i,j) = phiy(i,j) * gradmask


! South Pole
! Neighbor (i,j-1) is missing, and data from (i-1,j-1) is stored in (1,jjm)

      i = iim-1
      j = 1 

      gradmask = min (phimask(i-1,j), phimask(1  ,jjm),                 &
                      phimask(i+1,j), phimask(i+1,j+1), phimask(i,j+1) )
      phix(i,j) = phix(i,j) * gradmask
      phiy(i,j) = phiy(i,j) * gradmask

      end subroutine mask_gradient

!=======================================================================
! END OF MASK_GRADIENT
!=======================================================================

!=======================================================================
! BEGINNING OF LIMIT_GRADIENT 
!=======================================================================

      subroutine limit_gradient (phi,     phimask,                     &
                                 xshift,  yshift,                      &
                                 phix,    phiy,                        &
                                 l_limit_min, l_limit_max, l_pd )

!-----------------------------------------------------------------------
! Compute gradients of a scalar field and limit to ensure monotonicity.
! Note: Gradients computed for interior cells only; must be wrapped later.
!-----------------------------------------------------------------------

      implicit none

!-----------------------------------------------------------------------
! INTENT IN
!-----------------------------------------------------------------------

      real (kind=dbl_kind), dimension (iim,jjm), intent(in) ::         &
           phi,         &! input scalar field (mean value in each cell)
           phimask,     &! = 1. if phi(i,j) has physical meaning, else = 0.
           xshift,      &! x-coordinate of point with phi(x,y) = mean value
           yshift        ! y-coordinate of point with phi(x,y) = mean value

      logical (kind=log_kind), intent(in), optional ::                 &
           l_limit_min, &
           l_limit_max, &
           l_pd

!-----------------------------------------------------------------------
! INTENT OUT
!-----------------------------------------------------------------------

      real (kind=dbl_kind), dimension (iim,jjm), intent(inout) ::        &
           phix,       &! x gradient of phi in X3
           phiy         ! y gradient of phi in X3

!-----------------------------------------------------------------------
! LOCAL
!-----------------------------------------------------------------------

      integer (kind=int_kind) ::                                       &
           i,j,        &! horizontal indices
           nv           ! vertex index

      real (kind=dbl_kind), dimension (iim,jjm) ::                     &
           pmn, pmx     ! min and max deviation of phi among neighbor cells

      real (kind=dbl_kind) ::                                          &
           qmn, qmx,   &! min and max deviation of phi within grid cell
           wk1,wk2,wk3,wk4,wk5,wk6    ! work variables

      real (kind=dbl_kind), dimension (nhexvert) ::                    &
           wkv          ! work array


!-----------------------------------------------------------------------
! Find the maximum and minimum allowed values of the reconstructed field,
!  based on the requirement that phi(x,y) should fall within the range 
!  of the mean values phi(i,j) in the cell and in its neighbors.  This 
!  is the geodesic form of van Leer limiting.
! Note: Neighbor indexing at poles is different from interior indexing.
! At NP, neighbor 1 is missing and neighbor 2 is reindexed to (iim,1).
! At SP, neighbor 3 is missing and neighbor 2 is reindexed to (1,jjm).
!-----------------------------------------------------------------------

      pmn(:,:) = c0
      pmx(:,:) = c0

! Interior cells

      if(.not.l_pd) then

      do j = 1+npad, jjm-npad
      do i = 1+npad, iim-npad

!-----------------------------------------------------------------------
! Load values of phi(i,j) in neighboring grid cells
! If mask = 1 in neighbor cell, use the true value; else substitute 
!  the value in cell (i,j).
!-----------------------------------------------------------------------
         wk1 =     phimask(i-1,j)    * phi(i-1,j)                       &
             + (c1-phimask(i-1,j))   * phi(i,j)
         wk2 =     phimask(i-1,j-1)  * phi(i-1,j-1)                     &
             + (c1-phimask(i-1,j-1)) * phi(i,j) 
         wk3 =     phimask(i,j-1)    * phi(i,j-1)                       &
             + (c1-phimask(i,j-1))   * phi(i,j)
         wk4 =     phimask(i+1,j)    * phi(i+1,j)                       &
             + (c1-phimask(i+1,j))   * phi(i,j)
         wk5 =     phimask(i+1,j+1)  * phi(i+1,j+1)                     &
             + (c1-phimask(i+1,j+1)) * phi(i,j)
         wk6 =     phimask(i,j+1)    * phi(i,j+1)                       &
             + (c1-phimask(i,j+1))   * phi(i,j)

!-----------------------------------------------------------------------
! Compute min and max deviations in phi
!-----------------------------------------------------------------------
         pmn(i,j) = min (wk1, wk2, wk3, wk4, wk5, wk6, phi(i,j)) - phi(i,j)
         pmx(i,j) = max (wk1, wk2, wk3, wk4, wk5, wk6, phi(i,j)) - phi(i,j)

      enddo                     ! i
      enddo                     ! j

! North Pole

      i = 1
      j = jjm - 1

      wk2 =     phimask(iim,1)    * phi(iim,1)                          &
          + (c1-phimask(iim,1))   * phi(i,j)
      wk3 =     phimask(i,j-1)    * phi(i,j-1)                          &
          + (c1-phimask(i,j-1))   * phi(i,j)
      wk4 =     phimask(i+1,j)    * phi(i+1,j)                          &
          + (c1-phimask(i+1,j))   * phi(i,j)  
      wk5 =     phimask(i+1,j+1)  * phi(i+1,j+1)                        &
          + (c1-phimask(i+1,j+1)) * phi(i,j)
      wk6 =     phimask(i,j+1)    * phi(i,j+1)                          &
          + (c1-phimask(i,j+1))   * phi(i,j)

      pmn(i,j) = min (wk2, wk3, wk4, wk5, wk6, phi(i,j)) - phi(i,j)
      pmx(i,j) = max (wk2, wk3, wk4, wk5, wk6, phi(i,j)) - phi(i,j)

! South Pole

      i = iim - 1
      j = 1

      wk1 =     phimask(i-1,j)    * phi(i-1,j)                       &
          + (c1-phimask(i-1,j))   * phi(i,j)         
      wk2 =     phimask(1,jjm)    * phi(1,jjm)                       &
          + (c1-phimask(1,jjm))   * phi(i,j)
      wk4 =     phimask(i+1,j)    * phi(i+1,j)                       &
          + (c1-phimask(i+1,j))   * phi(i,j)
      wk5 =     phimask(i+1,j+1)  * phi(i+1,j+1)                     &
          + (c1-phimask(i+1,j+1)) * phi(i,j)
      wk6 =     phimask(i,j+1)    * phi(i,j+1)                       &
          + (c1-phimask(i,j+1))   * phi(i,j)

      pmn(i,j) = min (wk1, wk2, wk4, wk5, wk6, phi(i,j)) - phi(i,j)
      pmx(i,j) = max (wk1, wk2, wk4, wk5, wk6, phi(i,j)) - phi(i,j)


      else

!-----------------------------------------------------------------------
! if only positive definite limiting is requested, compute pmn against
!   a value of zero and set pmx to a very large number
!-----------------------------------------------------------------------

         pmn(:,:) = c0 - phi(:,:)
         pmx(:,:) = 1.0e20 - phi(:,:)

      endif

!-----------------------------------------------------------------------
! Limit the cell-center gradients.
! Note: Loops include poles.  
!-----------------------------------------------------------------------

      do j = 1, jjm-npad
      do i = 1, iim-npad
         if (phimask(i,j) > eps) then

!-----------------------------------------------------------------------
! Find minimum and maximum deviation of phi within the cell.
!-----------------------------------------------------------------------

            ! cell center value relative to phi(i,j)
            wk1 = -xshift(i,j)*phix(i,j) - yshift(i,j)*phiy(i,j)

            ! cell vertex values relative to phi(i,j)
            ! Note: For pentagons, c_x3 stores one vertex twice
            do nv = 1, nhexvert
               wkv(nv) = wk1 + phix(i,j) * c_x3(1,nv,i,j,ksdm)           & 
                             + phiy(i,j) * c_x3(2,nv,i,j,ksdm)
            enddo

            qmn = minval (wkv)
            qmx = maxval (wkv)

!-----------------------------------------------------------------------
! Find limiting coefficient by requiring that phi within the cell lies
! inside the range of mean values in the neighbor cells.
!-----------------------------------------------------------------------

         if (abs(qmn) > c0) then
            wk1 = max(c0, pmn(i,j)/qmn)
         else
            wk1 = c1
         endif

         if (abs(qmx) > c0) then
            wk2 = max(c0, pmx(i,j)/qmx)
         else
            wk2 = c1
         endif


!-----------------------------------------------------------------------
! Find limiting coefficient based on min and max
!-----------------------------------------------------------------------

            wk3 = min (c1, wk1, wk2)

!-----------------------------------------------------------------------
! If limiting of minimum is false, just limit on the maximum
!-----------------------------------------------------------------------

             if(.not.l_pd) then

             if(.not.l_limit_min) then
               wk3 = min (c1, wk2)
             endif

!-----------------------------------------------------------------------
! If limiting of maximum is false, just limit on the maximum
!-----------------------------------------------------------------------

             if(.not.l_limit_max) then
               wk3 = min (c1, wk1)
             endif

!-----------------------------------------------------------------------
! If both are set to false, this routine should not have been called
!   but test just in case
!-----------------------------------------------------------------------

             if(.not.l_limit_min) then
             if(.not.l_limit_max) then
               wk3 = c1
             endif
             endif

             endif

!-----------------------------------------------------------------------
! Limit gradient components.
!-----------------------------------------------------------------------

            phix(i,j) = wk3 * phix(i,j)
            phiy(i,j) = wk3 * phiy(i,j)
 
         endif                  ! phimask > eps

      enddo                     ! i
      enddo                     ! j

      end subroutine limit_gradient
!=======================================================================
! END OF LIMIT_GRADIENT
!=======================================================================


!=======================================================================
! BEGINNING OF DEPARTURE_POINTS_1ORDER
!=======================================================================
      subroutine departure_points_1order (dt, uc, dp,                  &
                                          l_check_velocity)

!-----------------------------------------------------------------------
! Given velocities, compute departure points at cell corners in X1 
!  coordinates.
! First order accuracy: Compute the departure point by projecting
!  the local velocity backward in time with no correction.
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
! INTENT IN
!-----------------------------------------------------------------------

      real (kind=dbl_kind), intent(in) ::                              &
           dt                ! time step

      real (kind=dbl_kind),                                            &
         dimension(nspace,ncorners,iim,jjm), intent(in) ::             &
           uc                ! velocity at cell corners

      logical (kind=log_kind), intent(in) ::                           &
           l_check_velocity  ! if true, check for large velocities

!-----------------------------------------------------------------------
! INTENT OUT
!-----------------------------------------------------------------------

      real (kind=dbl_kind),                                            &
         dimension(r3,ncorners,iim,jjm), intent(out) ::                &
           dp           ! departure points in X1 at cell corners

!-----------------------------------------------------------------------
! LOCAL
!-----------------------------------------------------------------------

      integer (kind=int_kind) ::                                       &       
           i, j,       &! horizontal indices
           nc           ! corner index

      real (kind=dbl_kind), dimension (r3) ::                          &
           utmp         ! temporary vector

      real (kind=dbl_kind) ::                                          &
           wk1, wk2, wk3 ! work variables

!-----------------------------------------------------------------------
! Check for excessive velocity (optional)
!-----------------------------------------------------------------------

      if (l_check_velocity) then

      do j = 1+npad, jjm-npad
      do i = 1+npad, iim-npad
      do nc = 1, ncorners

         wk1 = sqrt( w_x2(1,1,nc,i,j,ksdm)**2 +                        &
                     w_x2(2,1,nc,i,j,ksdm)**2 )
         wk2 = sqrt( w_x2(1,2,nc,i,j,ksdm)**2 +                        &
                     w_x2(2,2,nc,i,j,ksdm)**2 )
         wk3 = sqrt( w_x2(1,3,nc,i,j,ksdm)**2 +                        &
                     w_x2(2,3,nc,i,j,ksdm)**2 )
         wk1 = c2 * min (wk1, wk2, wk3)
         wk2 = dt * sqrt( uc(1,nc,i,j)**2 +                       &
                          uc(2,nc,i,j)**2 )
         if (wk2 > wk1) then
            write(6,*) ''
            write(6,*) 'Warning: excessive velocity'
            write(6,*) 'my_task, nc, i, j, ksdm =',  &
                        my_task, nc, i, j, ksdm
            write(6,*) 'speed * dt =', wk2
            write(6,*) 'maximum safe speed * dt =', wk1
!!!            stop
         endif

      enddo                     ! nc
      enddo                     ! i
      enddo                     ! j

      endif                     ! l_check_velocity

!-----------------------------------------------------------------------
! Initialize
!-----------------------------------------------------------------------

      dp(:,:,:,:) = c0

!-----------------------------------------------------------------------
! Loop over each corner of each physical grid cell.
!-----------------------------------------------------------------------

      do j = 1+npad, jjm-npad
      do i = 1+npad, iim-npad
      do nc = 1, ncorners

         wk1 = sqrt(uc(1,nc,i,j)**2 + uc(1,nc,i,j)**2)
         if (wk1 > eps) then

!-----------------------------------------------------------------------
! Transform velocity to X1
!-----------------------------------------------------------------------

            utmp(1) = trans_to_X1(1,1,nc,i,j,ksdm) * uc(1,nc,i,j)    &
                    + trans_to_X1(1,2,nc,i,j,ksdm) * uc(2,nc,i,j)   
                                 
            utmp(2) = trans_to_X1(2,1,nc,i,j,ksdm) * uc(1,nc,i,j)    &
                    + trans_to_X1(2,2,nc,i,j,ksdm) * uc(2,nc,i,j)
                         
            utmp(3) = trans_to_X1(3,1,nc,i,j,ksdm) * uc(1,nc,i,j)    &
                    + trans_to_X1(3,2,nc,i,j,ksdm) * uc(2,nc,i,j)

!-----------------------------------------------------------------------
! Find departure point in X1
!-----------------------------------------------------------------------

            dp(1,nc,i,j) = a*c(1,nc,i,j,ksdm) - utmp(1)*dt
            dp(2,nc,i,j) = a*c(2,nc,i,j,ksdm) - utmp(2)*dt
            dp(3,nc,i,j) = a*c(3,nc,i,j,ksdm) - utmp(3)*dt

         else                   ! zero velocity

            dp(1,nc,i,j) = a*c(1,nc,i,j,ksdm)
            dp(2,nc,i,j) = a*c(2,nc,i,j,ksdm)
            dp(3,nc,i,j) = a*c(3,nc,i,j,ksdm)

         endif                  ! speed > eps

      enddo                     ! nc
      enddo                     ! i
      enddo                     ! j

      end subroutine departure_points_1order
!=======================================================================
! END OF DEPARTURE_POINTS_1ORDER
!=======================================================================

!=======================================================================
! BEGINNING OF DEPARTURE_POINTS_2ORDER
!=======================================================================
      subroutine departure_points_2order (dt, uc, dp,                  &
                                          l_check_velocity)

!-----------------------------------------------------------------------
! Given velocities, compute departure points at cell corners in X1 
!  coordinates.
! Second order accuracy: Compute the departure point by estimating the
!  midpoint of the trajectory and interpolating among neighboring
!  corners to evaluate the velocity at the midpoint.
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
! INTENT IN
!-----------------------------------------------------------------------

      real (kind=dbl_kind), intent(in) ::                              &
           dt                ! time step

      real (kind=dbl_kind),                                            &
         dimension(nspace,ncorners,iim,jjm), intent(in) ::             &
           uc                ! velocity at cell corners

      logical (kind=log_kind), intent(in) ::                           &
           l_check_velocity  ! if true, check for large velocities

!-----------------------------------------------------------------------
! INTENT OUT
!-----------------------------------------------------------------------

      real (kind=dbl_kind),                                            &
         dimension(r3,ncorners,iim,jjm), intent(out) ::                &
           dp           ! departure points in X1 at cell corners

!-----------------------------------------------------------------------
! LOCAL
!-----------------------------------------------------------------------

      integer (kind=int_kind) ::                                       &       
           i, j,       &! horizontal indices
           nc,         &! corner index
           nd, ndm1,   &! ndata indices
           nd1,nd2,nd3  ! ndata indices

      real (kind=dbl_kind),                                            &
         dimension(r3,ncorners,iim,jjm) ::                             &
           work_u       ! work array for velocities and departure pts

      real (kind=dbl_kind), dimension(nspace) ::                       &
           xm,         &! midpoint of backward trajectory in X2
           um,         &! X2 velocity at midpoint
           x0, x1, x2, &! X2 position of local corner and two neighbors
           u0, u1, u2   ! X2 velocity at local corner and two neighbors
           
      real (kind=dbl_kind), dimension (r3) ::                          &
           utmp         ! temporary vector

      real (kind=dbl_kind), dimension(r3,ndata) ::                     &
           u_neighbor   ! X1 velocity at 3 neighbor corners

      real (kind=dbl_kind) ::                                          &
           theta_m,    &! angle between midpoint and local east         
           theta_min,  &! minimum of angles to 3 neighbor corners   
           wk1,wk2,wk3,wk4 ! temporary variables

!-----------------------------------------------------------------------
! Optional check for excessive velocities 
!-----------------------------------------------------------------------
      if (l_check_velocity) then

      do j = 1+npad, jjm-npad
      do i = 1+npad, iim-npad
      do nc = 1, ncorners

         wk1 = sqrt( w_x2(1,1,nc,i,j,ksdm)**2 +                        &
                     w_x2(2,1,nc,i,j,ksdm)**2 )
         wk2 = sqrt( w_x2(1,2,nc,i,j,ksdm)**2 +                        &
                     w_x2(2,2,nc,i,j,ksdm)**2 )
         wk3 = sqrt( w_x2(1,3,nc,i,j,ksdm)**2 +                        &
                     w_x2(2,3,nc,i,j,ksdm)**2 )
         wk1 = c2 * min (wk1, wk2, wk3)
         wk2 = dt * sqrt( uc(1,nc,i,j)**2 +                            &
                          uc(2,nc,i,j)**2 )
         if (wk2 > wk1) then
            write(6,*) ''
            write(6,*) 'Warning: excessive velocity'
            write(6,*) 'my_task, nc, i, j, ksdm =',  &
                        my_task, nc, i, j, ksdm
            write(6,*) 'speed * dt =', wk2
            write(6,*) 'maximum safe speed * dt =', wk1
         endif

      enddo                     ! nc
      enddo                     ! i
      enddo                     ! j

      endif                     ! l_check_velocity

!-----------------------------------------------------------------------
! Initialize departure points
!-----------------------------------------------------------------------

      dp(:,:,:,:) = c0

!-----------------------------------------------------------------------
! Transform velocities to X1 
!-----------------------------------------------------------------------

      do j = 1, jjm
      do i = 1, iim
      do nc = 1, ncorners

         work_u(1,nc,i,j) = trans_to_X1(1,1,nc,i,j,ksdm) * uc(1,nc,i,j)  &
                          + trans_to_X1(1,2,nc,i,j,ksdm) * uc(2,nc,i,j)   
                                 
         work_u(2,nc,i,j) = trans_to_X1(2,1,nc,i,j,ksdm) * uc(1,nc,i,j)  &
                          + trans_to_X1(2,2,nc,i,j,ksdm) * uc(2,nc,i,j)    
                         

         work_u(3,nc,i,j) = trans_to_X1(3,1,nc,i,j,ksdm) * uc(1,nc,i,j)  &
                          + trans_to_X1(3,2,nc,i,j,ksdm) * uc(2,nc,i,j)
                              
      enddo                     ! nc
      enddo                     ! i
      enddo                     ! j

!-----------------------------------------------------------------------
! Loop over corners of each interior grid cell
!-----------------------------------------------------------------------

      do j = 1+npad, jjm-npad
      do i = 1+npad, iim-npad
      do nc = 1, ncorners
         
!-----------------------------------------------------------------------
! Load velocity and estimate midpoint of backward trajectory.
!-----------------------------------------------------------------------

         u0(1) = uc(1,nc,i,j)  ! local velocity in X2
         u0(2) = uc(2,nc,i,j)  ! local velocity in X2

         xm(1) = -p5 * dt * uc(1,nc,i,j)
         xm(2) = -p5 * dt * uc(2,nc,i,j)

         if (sqrt(xm(1)**2 + xm(2)**2) > eps) then

!-----------------------------------------------------------------------
! Load the X1 velocities from the 3 neighbor corners.
! Note the index shift from (nc,i,j) to nd.
!-----------------------------------------------------------------------

            if (nc==1) then
               u_neighbor(1,1) = work_u(1,2,i  ,j+1)
               u_neighbor(2,1) = work_u(2,2,i  ,j+1)
               u_neighbor(3,1) = work_u(3,2,i  ,j+1)

               u_neighbor(1,2) = work_u(1,2,i-1,j  )
               u_neighbor(2,2) = work_u(2,2,i-1,j  )
               u_neighbor(3,2) = work_u(3,2,i-1,j  )

               u_neighbor(1,3) = work_u(1,2,i  ,j  )
               u_neighbor(2,3) = work_u(2,2,i  ,j  )
               u_neighbor(3,3) = work_u(3,2,i  ,j  )
            else  ! nc = 2
               u_neighbor(1,1) = work_u(1,1,i,  j  )
               u_neighbor(2,1) = work_u(2,1,i,  j  )
               u_neighbor(3,1) = work_u(3,1,i,  j  )

               u_neighbor(1,2) = work_u(1,1,i  ,j-1)
               u_neighbor(2,2) = work_u(2,1,i  ,j-1)
               u_neighbor(3,2) = work_u(3,1,i  ,j-1)

               u_neighbor(1,3) = work_u(1,1,i+1,j  )
               u_neighbor(2,3) = work_u(2,1,i+1,j  )
               u_neighbor(3,3) = work_u(3,1,i+1,j  )
            endif

!-----------------------------------------------------------------------
! Compute the angle between the midpoint and the x axis (local east).
! This angle is between 0 and 2*pi.
!-----------------------------------------------------------------------

            if (abs(xm(1)) > c0) then
               theta_m = atan (xm(2)/xm(1))  ! OK if xm is in quadrant 1
               if (xm(1) < c0) then          ! quadrant 2 or 3 
                  theta_m = theta_m + pi
               elseif (xm(2) < c0) then      ! quadrant 4
                  theta_m = theta_m + pi2
               endif
            else                             ! x coord of xm = 0
               theta_m = p5 * pi
               if (xm(2) < c0) then
                  theta_m = theta_m + pi
               endif
            endif

!-----------------------------------------------------------------------
! Compute ndata for the tetrant in which the midpoint lies.
! Recall that ndata = 1 for the tetrant lying in the cell that owns the
!  corner, then increases counterclockwise.
!-----------------------------------------------------------------------

! Compute nd1 = ndata for the edge with the smallest angle relative
! to local east.  
! This could be precomputed to save a little time.

            theta_min = theta_x2(1,nc,i,j,ksdm)
            nd1 = 1
            do nd = 2,ndata
               if (theta_x2(nd,nc,i,j,ksdm) < theta_min) then
                  theta_min = theta_x2(nd,nc,i,j,ksdm)
                  nd1 = nd
               endif
            enddo

            nd2 = nd1+1
            if (nd2 > ndata) nd2 = 1
            nd3 = nd2 + 1
            if (nd3 > ndata) nd3 = 1

! Find the tetrant nd that includes theta_m

            nd = nd1
            if (theta_m >  theta_x2(nd1,nc,i,j,ksdm) .and.            &
                theta_m <= theta_x2(nd2,nc,i,j,ksdm)) then
               nd = nd2
            elseif (theta_m >  theta_x2(nd2,nc,i,j,ksdm) .and.        &
                    theta_m <= theta_x2(nd3,nc,i,j,ksdm)) then
               nd = nd3
            endif

            ndm1 = nd-1
            if (ndm1==0) ndm1 = ndata

!-----------------------------------------------------------------------
! For the two neighbor corners that bound the tetrant (which have indices
!  nd and ndm1), transform velocities from X1 to X2, dropping z component.
!-----------------------------------------------------------------------

            u1(1) = trans_to_X2(1,1,nc,i,j,ksdm) * u_neighbor(1,nd)      &
                  + trans_to_X2(1,2,nc,i,j,ksdm) * u_neighbor(2,nd)      &
                  + trans_to_X2(1,3,nc,i,j,ksdm) * u_neighbor(3,nd)

            u1(2) = trans_to_X2(2,1,nc,i,j,ksdm) * u_neighbor(1,nd)      &
                  + trans_to_X2(2,2,nc,i,j,ksdm) * u_neighbor(2,nd)      &
                  + trans_to_X2(2,3,nc,i,j,ksdm) * u_neighbor(3,nd)

            u2(1) = trans_to_X2(1,1,nc,i,j,ksdm) * u_neighbor(1,ndm1)    &
                  + trans_to_X2(1,2,nc,i,j,ksdm) * u_neighbor(2,ndm1)    &
                  + trans_to_X2(1,3,nc,i,j,ksdm) * u_neighbor(3,ndm1)

            u2(2) = trans_to_X2(2,1,nc,i,j,ksdm) * u_neighbor(1,ndm1)    &
                  + trans_to_X2(2,2,nc,i,j,ksdm) * u_neighbor(2,ndm1)    &
                  + trans_to_X2(2,3,nc,i,j,ksdm) * u_neighbor(3,ndm1)

!-----------------------------------------------------------------------
! Load the X2 positions of the three tetrant corners.
! Note: Instead of loading positions of neighbor corners, load midpoint
!  positions, which have been precomputed in X2.  
!-----------------------------------------------------------------------

            x0(1) = c0          ! center of X2 coordinate system
            x0(2) = c0          ! center of X2 coordinate system
            x1(1) = w_x2(1,nd  ,nc,i,j,ksdm)
            x1(2) = w_x2(2,nd  ,nc,i,j,ksdm)
            x2(1) = w_x2(1,ndm1,nc,i,j,ksdm)
            x2(2) = w_x2(2,ndm1,nc,i,j,ksdm)

!-----------------------------------------------------------------------
! Interpolate linearly among 3 tetrant corners to estimate the velocity 
! at the midpoint.  That is, solve the equation
!          
!        (1)     xm = x0 + wk1*(x1-x0) + wk2*(x2-x0)
!
! for wk1 and wk2, where x0, x1, x2, and xm are 2D vectors in X2.
! Substitute wk1 and wk2 in
!
!        (2)     um = u0 + wk1*(u1-u0) + wk2*(u2-u0)
!
!-----------------------------------------------------------------------

            wk3 = (xm(2)-x0(2)) * (x2(1)-x0(1)) -                      &
                  (xm(1)-x0(1)) * (x2(2)-x0(2))
            wk4 = (x1(2)-x0(2)) * (x2(1)-x0(1)) -                      &
                  (x1(1)-x0(1)) * (x2(2)-x0(2))

! Note factor of 1/2 here because the x's are midpoint coordinates
! whereas the velocities are at corners, which are twice as far from
! x0 as the midpoints.

            if (abs(wk4) > eps) then
               wk1 = p5 * wk3/wk4
            else
               print*, ''
               print*, 'denom = 0 in velocity interpolation'
               print*, 'nc,i,j,ksdm=', nc,i,j,ksdm
               wk1 = c0
            endif

            wk3 = (xm(2)-x0(2)) * (x1(1)-x0(1)) -                      &
                  (xm(1)-x0(1)) * (x1(2)-x0(2))
            wk4 = (x2(2)-x0(2)) * (x1(1)-x0(1)) -                      &
                  (x2(1)-x0(1)) * (x1(2)-x0(2))
 
            if (abs(wk4) > eps) then
               wk2 = p5 * wk3/wk4
            else
               print*, ''
               print*, 'denom = 0 in velocity interpolation'
               print*, 'nc,i,j,ksdm=', nc,i,j,ksdm
               wk2 = c0
            endif

            um(1) = u0(1) + wk1 * (u1(1) - u0(1))                      &
                          + wk2 * (u2(1) - u0(1))
            um(2) = u0(2) + wk1 * (u1(2) - u0(2))                      &
                          + wk2 * (u2(2) - u0(2))

!-----------------------------------------------------------------------
! Using the velocity at the midpoint of the backward trajectory, find 
!  the departure point in X2 and transform to X1. 
! Note: utmp(3) terms are missing because um(3) = 0 in X2
!-----------------------------------------------------------------------

            utmp(1) = -dt * um(1)
            utmp(2) = -dt * um(2)

            dp(1,nc,i,j) = trans_to_X1(1,1,nc,i,j,ksdm) * utmp(1)  &
                         + trans_to_X1(1,2,nc,i,j,ksdm) * utmp(2)  &
                         +       a * c(  1,nc,i,j,ksdm)

            dp(2,nc,i,j) = trans_to_X1(2,1,nc,i,j,ksdm) * utmp(1)   &
                         + trans_to_X1(2,2,nc,i,j,ksdm) * utmp(2)   &
                         +       a * c(  2,nc,i,j,ksdm)

            dp(3,nc,i,j) = trans_to_X1(3,1,nc,i,j,ksdm) * utmp(1)   &
                         + trans_to_X1(3,2,nc,i,j,ksdm) * utmp(2)   &
                         +       a * c(  3,nc,i,j,ksdm)

         else   ! magnitude of velocity = 0

            dp(1,nc,i,j) = a * c(1,nc,i,j,ksdm)
            dp(2,nc,i,j) = a * c(2,nc,i,j,ksdm)
            dp(3,nc,i,j) = a * c(3,nc,i,j,ksdm)

         endif

      enddo                     ! nc
      enddo                     ! i
      enddo                     ! j

      end subroutine departure_points_2order
!=======================================================================
! END OF DEPARTURE_POINTS_2ORDER
!=======================================================================

!=======================================================================
! BEGINNING OF LOCATE_TRIANGLES
!=======================================================================
      subroutine locate_triangles (dp,       integral_order,           &
                                   tripoint, triarea,                  &
                                   nd_source)

!-----------------------------------------------------------------------
! Compute area and vertices of departure triangles for the three
!  half-edges associated with each corner.  
!-----------------------------------------------------------------------

      implicit none

!-----------------------------------------------------------------------
! INTENT IN
!-----------------------------------------------------------------------

      real (kind=dbl_kind),                                            &
         dimension(r3,ncorners,iim,jjm), intent(in) ::                 &
           dp              ! departure points in X1 at cell corners

      integer (kind=int_kind), intent(in) ::                           &
           integral_order   ! polynomial order of quadrature integrals
                            ! linear=1, quadratic=2, cubic=3

!-----------------------------------------------------------------------
! INTENT OUT
!-----------------------------------------------------------------------
      real (kind=dbl_kind), intent(out),                               &
         dimension(nspace,0:ntrivert,ngroups,nedges,iim,jjm)::         &
           tripoint      ! coordinates of triangle points

      real (kind=dbl_kind), intent(out),                               &
         dimension(ngroups,nedges,iim,jjm) ::                          &
           triarea       ! triangle areas

      integer (kind=int_kind), intent(out),                            &
         dimension(ngroups,nedges,iim,jjm) ::                          &
           nd_source     ! nd index of source grid cell

!-----------------------------------------------------------------------
! LOCAL
!-----------------------------------------------------------------------

      integer (kind=int_kind) ::                                       &       
           i, j,        &! horizontal indices
           i2, j2,      &! horizontal indices of neighbor cell
           ne,          &! edge index
           nd,          &! nedgedata index for source cell
           ng,          &! triangle group index
           nv            ! triangle vertex index

      real (kind=dbl_kind), dimension(ngroups) ::                      &
           fluxsign      ! = 1. for positive flux, -1. for negative

      real (kind=dbl_kind), dimension(nspace) ::                       &
                         ! All these  vectors are in X4
           cl,          &! left endpoint of edge 
           cr,          &! right endpoint of edge
           dl,          &! departure point associated with CL
           dr,          &! departure point associated with CR
           tl,          &! endpoint of upper left edge
           tr,          &! endpoint of upper right edge
           bl,          &! endpoint of lower left edge
           br,          &! endpoint of lower right edge
           ic,          &! intersection of line DLR w/ x-axis
           il,          &! intersection of segment DLR and TCL/BCL
           ir,          &! intersection of segment DLR and TCR/BCR
           utmp          ! temporary vector

      real (kind=dbl_kind), dimension(r3) ::                           &
           dl_x1,       &! left departure point in X1
           dr_x1         ! right departure point in X1

      real (kind=dbl_kind) ::                                          &
           mdlr, bdlr,  &! slope and y-intercept of segment DLR
           mtcl, btcl,  &! slope and y-intercept of segment TCL
           mbcl, bbcl,  &! slope and y-intercept of segment BCL
           mdcl,        &! slope of segment DCL
           mtcr, btcr,  &! slope and y-intercept of segment TCR
           mbcr, bbcr,  &! slope and y-intercept of segment BCR
           mdcr          ! slope of segment DCR

      logical (kind=log_kind) ::                                       &
           dlr_int_clr,     &! true if line segments DLR and CLR intersect 
           dl_in_left_cell, &! true if point DR is in left cell
           dr_in_right_cell  ! true if point DL is in left cell

!-----------------------------------------------------------------------
! First to explain the notation:
! 
! We work in a coordinate system X4 whose origin is the midpoint of the
!  edge across which mass is transported.
!
! Here are the naming conventions for grid cells, points, and line segments:
! (T = Top, B = Bottom, C = Center, L = Left, R = Right, D = Departure) 
!
!     Grid cells: 
!                        \                     /
!                         \                   /
!                          \        T        / 
!                           \               /
!                        L   \_____________/    R
!                            /             \
!                           /               \
!                          /        B        \
!                         /                   \
!                        /                     \
!
!
!     Points:            TL                  TR
!                         \   DL        DR  /
!                          \  |         |  /
!                           \ |         | /
!                            \|_________|/
!                            /CL       CR\  
!                           /             \  
!                          /               \  
!                         /                 \     
!                        BL                  BR
!
!
!     Line segments: 
!                                          
!                         \   ___DLR____   /
!                       TCL\  |        |  /TCR 
!                           \ |DCL  DCR| /
!                            \|________|/
!                            /   CLR    \ 
!                           /            \   
!                       BCL/              \BCR  
!                         /                \
!
! Mass is transported across edge CLR.
! Points CL, CR, TL, TR, BL, and BR are grid cell corners.  
!
!
! Here is the local data structure for edge 1 of cell (i,j):  
!
!                             (i,j+1)
!                        \                /
!                          \            /
!                            \        /
!                              \    /
!                                \/
!                                 |
!                                 |
!                     (i-1,j)     |      (i,j)
!                                 |
!                                 |
!                                / \
!                              /     \
!                            /         \ 
!                          /             \
!                        /                 \
!                             (i-1,j-1)
!
!
!     nedgedata = 1 --> cell (i,j)     --> B
!     nedgedata = 2 --> cell (i,j+1)   --> R
!     nedgedata = 3 --> cell (i-1,j)   --> T
!     nedgedate = 4 --> cell (i-1,j-1) --> L
!
!
! Here is the data structure for cell edge 2:  
!
!                             |
!                             |
!                  (i-1,j)    |      (i,j)
!                             |
!                             |
!                            / \                /
!                          /     \            /
!                        /         \        /
!                      /             \    /
!                    /                 \/
!                                       | 
!                          (i-1,j-1)    |   (i,j-1)
!                                       |
!                                       |
!                                       |
!
!     nedgedata = 1 --> cell (i,j)     --> B
!     nedgedata = 2 --> cell (i-1,j)   --> R
!     nedgedata = 3 --> cell (i-1,j-1) --> T
!     nedgedate = 4 --> cell (i,j-1)   --> L
!
!
! And here is the data structure for cell edge 3:  
!
!                                       |
!                                       |
!                                       |    
!                            (i,j)      |    (i+1,j)
!                                       |
!                      \                /\
!                        \            /    \
!                          \        /        \
!                            \    /            \
!                              \/                \
!                               |   
!                   (i-1,j-1)   |   (i,j-1)  
!                               |
!                               |
!                               |
!
!     nedgedata = 1 --> cell (i,j)     --> B
!     nedgedata = 2 --> cell (i-1,j-1) --> R
!     nedgedata = 3 --> cell (i,j-1)   --> T
!     nedgedate = 4 --> cell (i+1,j)   --> L
!
! Fluxes are defined as positive when directed out of cell (i,j).
!
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
! Initialize triangle vertices, triangle areas, and source arrays.
!-----------------------------------------------------------------------

      tripoint  (:,:,:,:,:,:) = c0
      triarea   (    :,:,:,:) = c0
      nd_source (    :,:,:,:) = 0

!-----------------------------------------------------------------------
! Loop over each of 3 edges of each interior grid cell.
!-----------------------------------------------------------------------

      do j = 1+npad, jjm-npad
      do i = 1+npad, iim-npad
      do ne = 1, nedges

!-----------------------------------------------------------------------
! Initialize
!-----------------------------------------------------------------------
         fluxsign(:) = c0
         cl(:) = cl_x4(:,ne,i,j,ksdm)
         cr(:) = cr_x4(:,ne,i,j,ksdm)
         tl(:) = tl_x4(:,ne,i,j,ksdm)
         tr(:) = tr_x4(:,ne,i,j,ksdm)
         bl(:) = bl_x4(:,ne,i,j,ksdm)
         br(:) = br_x4(:,ne,i,j,ksdm)
         il(:) = c0
         ir(:) = c0
         ic(:) = c0

!-----------------------------------------------------------------------
! Compute departure points DL and DR in X4
!-----------------------------------------------------------------------

! Locate departure point relative to midpoint of edge (ne,i,j,ksdm) in X1

         if (ne==1) then
            dl_x1(:) = dp(:,1,i,j)   - a * w(1,:,1,i,j,ksdm)
            dr_x1(:) = dp(:,2,i,j+1) - a * w(1,:,1,i,j,ksdm)
         elseif (ne==2) then
            dl_x1(:) = dp(:,2,i,j)   - a * w(1,:,2,i,j,ksdm)
            dr_x1(:) = dp(:,1,i,j)   - a * w(1,:,2,i,j,ksdm)
         else  ! ne = 3
            dl_x1(:) = dp(:,1,i+1,j) - a * w(3,:,2,i,j,ksdm)
            dr_x1(:) = dp(:,2,i,j)   - a * w(3,:,2,i,j,ksdm)
         endif

! Transform to X4, dropping z component

         dl(1) = trans_X1_to_X4(1,1,ne,i,j,ksdm) * dl_x1(1)         &
               + trans_X1_to_X4(1,2,ne,i,j,ksdm) * dl_x1(2)         &
               + trans_X1_to_X4(1,3,ne,i,j,ksdm) * dl_x1(3)

         dl(2) = trans_X1_to_X4(2,1,ne,i,j,ksdm) * dl_x1(1)         &
               + trans_X1_to_X4(2,2,ne,i,j,ksdm) * dl_x1(2)         &
               + trans_X1_to_X4(2,3,ne,i,j,ksdm) * dl_x1(3)

         dr(1) = trans_X1_to_X4(1,1,ne,i,j,ksdm) * dr_x1(1)         &
               + trans_X1_to_X4(1,2,ne,i,j,ksdm) * dr_x1(2)         &
               + trans_X1_to_X4(1,3,ne,i,j,ksdm) * dr_x1(3)

         dr(2) = trans_X1_to_X4(2,1,ne,i,j,ksdm) * dr_x1(1)         &
               + trans_X1_to_X4(2,2,ne,i,j,ksdm) * dr_x1(2)         &
               + trans_X1_to_X4(2,3,ne,i,j,ksdm) * dr_x1(3)

!-----------------------------------------------------------------------
! Perturb dl and dr if necessary to avoid division by zero below.
!-----------------------------------------------------------------------

         if (abs(dr(1) - dl(1)) < eps) then
            if (dr(1) > dl(1)) then
               dr(1) = dr(1) + eps
            else
               dr(1) = dr(1) - eps
            endif
         endif

         if (abs(dl(1) - cl(1)) < eps) then
            if (dl(1) > cl(1)) then
               dl(1) = dl(1) + eps
            else
               dl(1) = dl(1) - eps
            endif
         endif

         if (abs(dr(1) - cr(1)) < eps) then
            if (dr(1) > cr(1)) then
               dr(1) = dr(1) + eps
            else
               dr(1) = dr(1) - eps
            endif
         endif

!-----------------------------------------------------------------------
! Compute the equation (slope and y-intercept) of the line containing DLR.
!-----------------------------------------------------------------------

         mdlr = (dr(2) - dl(2)) / (dr(1) - dl(1))
         bdlr =  dl(2) - mdlr*dl(1)

!-----------------------------------------------------------------------
! Compute the point IC where DLR intersects the x-axis.
! Determine whether IC lies between CL and CR.
! Note ic(2) = 0.
!-----------------------------------------------------------------------

         dlr_int_clr = .false.

         if (abs(mdlr) > eps) then   
            ic(1) = -bdlr/mdlr
            if (ic(1) > cl(1) .and. ic(1) < cr(1)) dlr_int_clr = .true.
         endif

!-----------------------------------------------------------------------
! Compute slopes and intercepts of of segments TCL, BCL, and DCL.
!
! The full equations are commented out; replaced for efficiency by 
! equations with cl(2) = 0. omitted.
!-----------------------------------------------------------------------

!         mtcl = (tl(2) - cl(2)) / (tl(1) - cl(1)) ! < 0
!         btcl = cl(2) - mtcl*cl(1)                ! < 0
!         mbcl = (bl(2) - cl(2)) / (bl(1) - cl(1)) ! > 0
!         bbcl = cl(2) - mbcl*cl(1)                ! > 0
!         mdcl = (dl(2) - cl(2)) / (dl(1) - cl(1))

         mtcl = tl(2) / (tl(1) - cl(1))            ! < 0
         btcl = - mtcl*cl(1)                       ! < 0
         mbcl = bl(2) / (bl(1) - cl(1))            ! > 0
         bbcl = - mbcl*cl(1)                       ! > 0
         mdcl = dl(2) / (dl(1) - cl(1))
         
!-----------------------------------------------------------------------
! Given these slopes, determine whether point DL is inside the left cell.
!-----------------------------------------------------------------------

         dl_in_left_cell = .false.

         if (dl(1) < cl(1) .and. mdcl < mbcl .and. mdcl > mtcl) then
            dl_in_left_cell = .true.

!-----------------------------------------------------------------------
! Determine the point IL where line segment DLR intersects
!  either line segment TCL or line segment BCL.
! Note: mdlr cannot equal mtcl or mbcl if DL is in cell L and
!  velocities are within bounds. 
!-----------------------------------------------------------------------

            il(1) = (btcl-bdlr) / (mdlr-mtcl) 
            if (il(1) < cl(1)) then ! DLR intersects TCL
               il(2) = mtcl*il(1) + btcl
            else                    ! DLR intersects BCL
               il(1) = (bbcl-bdlr) / (mdlr-mbcl)
               il(2) = mbcl*il(1) + bbcl
            endif
            
         endif                  ! DL in left cell

!-----------------------------------------------------------------------
! Compute slopes and intercepts of of segments TCR, BCR, and DCR.
!
! The full equations are commented out; replaced for efficiency by 
! equations with cr(2) = 0. omitted.
!-----------------------------------------------------------------------

!         mtcr = (tr(2) - cr(2)) / (tr(1) - cr(1)) ! > 0
!         btcr = cr(2) - mtcr*cr(1)                ! < 0
!         mbcr = (br(2) - cr(2)) / (br(1) - cr(1)) ! < 0
!         bbcr = cr(2) - mbcr*cr(1)                ! > 0
!         mdcr = (dr(2) - cr(2)) / (dr(1) - cr(1))

         mtcr = tr(2) / (tr(1) - cr(1))            ! > 0
         btcr = -mtcr*cr(1)                        ! < 0
         mbcr = br(2) / (br(1) - cr(1))            ! < 0
         bbcr = -mbcr*cr(1)                        ! > 0
         mdcr = dr(2) / (dr(1) - cr(1))

!-----------------------------------------------------------------------
! Given these slopes, determine whether point DR is inside the right cell.
!-----------------------------------------------------------------------

         dr_in_right_cell = .false.

         if (dr(1) > cr(1) .and. mdcr > mbcr .and. mdcr < mtcr) then
            dr_in_right_cell = .true.

!-----------------------------------------------------------------------
! Determine the point IL where line segment DLR intersects
!  either line segment TCL or line segment BCL.
! Note: mdlr cannot equal mtcl or mbcl if DL is in cell L and
!  velocities are within bounds. 
!-----------------------------------------------------------------------

            ir(1) = (btcr-bdlr) / (mdlr-mtcr) 
            if (ir(1) > cr(1)) then ! DLR intersects TCR
               ir(2) = mtcr*ir(1) + btcr
            else                    ! DLR intersects BCR
               ir(1) = (bbcr-bdlr) / (mdlr-mbcr)
               ir(2) = mbcr*ir(1) + bbcr
            endif
            
         endif                  ! DR in right cell

!-----------------------------------------------------------------------
! Compute the vertices of the departure triangles.  
! There are 12 possible triangles (2 in L, 2 in R, 4 in T, and 4 in B) 
!  that can be organized into 4 mutually exclusive groups.
!
! Group 1: L1 if DLR intersects TCL
!          L2 if DLR intersects BCL
!         (vertices are CL, DL, and IL)
!
! Group 2: R1 if DLR intersects TCR
!          R2 if DLR intersects BCR
!         (vertices are CR, DR, and IR)
!
! If DLR does not intersect CLR:
!
! Group 3: T1a or B1a (vertices are CL, DR*, and DL*)
! Group 4: T2a or B2a (vertices are CL, CR, and DR*)
!
! If DLR intersects CLR:
!
! Group 3: T1b or B1b (vertices are CL, DL*, and IC)
! Group 4: T2b or B2b (vertices are CR, DR*, and IC)   
! 
! where DL* = DL if DL is in T or B
!           = IL if DL is in L
!
!       DR* = DR if DR is in T or B
!           = IR if DR is in R
!
! Given the vertices, compute the area of each triangle.
! Attach a minus sign to areas associated with fluxes into the grid cell:
!  i.e., to triangles L1, R1, T1a, T2a, T1b, and T2b.
!
! For each triangle, store nd_source, the nedgedata index (1-4) of 
!  the source grid cell, relative to edge (ne,i,j).
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
! Contribution from group 1 (L1, L2)
!-----------------------------------------------------------------------

! Compute triangle vertices and area
               
         if (dl_in_left_cell) then
            ng = 1

            tripoint (1,1,ng,ne,i,j) = cl(1)
            tripoint (2,1,ng,ne,i,j) = cl(2)

            tripoint (1,2,ng,ne,i,j) = dl(1)
            tripoint (2,2,ng,ne,i,j) = dl(2)

            tripoint (1,3,ng,ne,i,j) = il(1)
            tripoint (2,3,ng,ne,i,j) = il(2)

            nd_source(    ng,ne,i,j) = 4 ! left cell

! If il(2) > 0, change sign of area (LT ==> negative flux)

            if (il(2) > c0) then                                     
               fluxsign(ng) = -c1
            else
               fluxsign(ng) =  c1
            endif

! Redefine DL for triangle groups 3 and 4

            dl(1) = il(1)
            dl(2) = il(2)

         endif                  ! DL in left cell

!-----------------------------------------------------------------------
! Contribution from group 2 (R1, R2)
!-----------------------------------------------------------------------

! Compute triangle vertices and area
               
         if (dr_in_right_cell) then
            ng = 2

            tripoint (1,1,ng,ne,i,j) = cr(1)
            tripoint (2,1,ng,ne,i,j) = cr(2)

            tripoint (1,2,ng,ne,i,j) = dr(1)
            tripoint (2,2,ng,ne,i,j) = dr(2)

            tripoint (1,3,ng,ne,i,j) = ir(1)
            tripoint (2,3,ng,ne,i,j) = ir(2)

            nd_source(    ng,ne,i,j) = 2 ! right cell

! If il(2) > 0, change sign of area (LT ==> negative flux)

            if (ir(2) > c0) then                                     
               fluxsign(ng) = -c1
            else
               fluxsign(ng) =  c1
            endif

! Redefine DR for triangle groups 3 and 4

            dr(1) = ir(1)
            dr(2) = ir(2)

         endif                  ! DR in right cell

         if (.not. dlr_int_clr) then

!-----------------------------------------------------------------------
! Contribution from group 3 (T1a, B1a)
!-----------------------------------------------------------------------

            ng = 3

            tripoint(1,1,ng,ne,i,j) = cl(1)
            tripoint(2,1,ng,ne,i,j) = cl(2)

            tripoint(1,2,ng,ne,i,j) = dl(1)
            tripoint(2,2,ng,ne,i,j) = dl(2)

            tripoint(1,3,ng,ne,i,j) = dr(1)
            tripoint(2,3,ng,ne,i,j) = dr(2)

            if (dl(2) > c0) then        ! T1a
               nd_source(ng,ne,i,j) = 3 ! top cell
               fluxsign (ng) = -c1
            else                        ! B1a
               nd_source(ng,ne,i,j) = 1 ! bottom cell
               fluxsign (ng) = c1
            endif

!-----------------------------------------------------------------------
! Contribution from group 4 (T2a, B2a)
!-----------------------------------------------------------------------

            ng = 4

            tripoint(1,1,ng,ne,i,j) = cl(1)
            tripoint(2,1,ng,ne,i,j) = cl(2)
            
            tripoint(1,2,ng,ne,i,j) = cr(1)
            tripoint(2,2,ng,ne,i,j) = cr(2)
            
            tripoint(1,3,ng,ne,i,j) = dr(1)
            tripoint(2,3,ng,ne,i,j) = dr(2)
            
            if (dl(2) > c0) then        ! T1a
               nd_source(ng,ne,i,j) = 3 ! top cell
               fluxsign (ng) = -c1
            else                        ! B1a
               nd_source(ng,ne,i,j) = 1 ! bottom cell
               fluxsign (ng) = c1
            endif
            
         else                   ! DLR intersects CLR

!-----------------------------------------------------------------------
! Contribution from group 3 (T1b, B1b)
!-----------------------------------------------------------------------

            ng = 3
            
            tripoint(1,1,ng,ne,i,j) = cl(1)
            tripoint(2,1,ng,ne,i,j) = cl(2)
            
            tripoint(1,2,ng,ne,i,j) = dl(1)
            tripoint(2,2,ng,ne,i,j) = dl(2)
            
            tripoint(1,3,ng,ne,i,j) = ic(1)
            tripoint(2,3,ng,ne,i,j) = ic(2)
            
            if (dl(2) > c0) then        ! T1b
               nd_source(ng,ne,i,j) = 3 ! top cell
               fluxsign (ng) = -c1
            else                        ! B1b
               nd_source(ng,ne,i,j) = 1 ! bottom cell
               fluxsign (ng) = c1
            endif

!-----------------------------------------------------------------------
! Contribution from group 4 (T2b, B2b)
!-----------------------------------------------------------------------

            ng = 4
            
            tripoint(1,1,ng,ne,i,j) = cr(1)
            tripoint(2,1,ng,ne,i,j) = cr(2)
            
            tripoint(1,2,ng,ne,i,j) = dr(1)
            tripoint(2,2,ng,ne,i,j) = dr(2)
            
            tripoint(1,3,ng,ne,i,j) = ic(1)
            tripoint(2,3,ng,ne,i,j) = ic(2)
            
            if (dl(2) < c0) then        ! T2b (note sign)
               nd_source(ng,ne,i,j) = 3 ! top cell
               fluxsign (ng) = -c1
            else                        ! B2b
               nd_source(ng,ne,i,j) = 1 ! bottom cell
               fluxsign (ng) = c1
            endif
            
         endif                  ! dlr_int_clr
         
         do ng = 1, ngroups

!-----------------------------------------------------------------------
! Compute triangle area (triangle_area function inlined for efficiency)
!-----------------------------------------------------------------------

            if (fluxsign(ng) /= 0) then

               triarea (ng,ne,i,j) = fluxsign(ng) * p5 *                 &
                  abs( (tripoint(1,2,ng,ne,i,j)-tripoint(1,1,ng,ne,i,j)) & 
                      *(tripoint(2,3,ng,ne,i,j)-tripoint(2,1,ng,ne,i,j)) &
                     - (tripoint(2,2,ng,ne,i,j)-tripoint(2,1,ng,ne,i,j)) & 
                      *(tripoint(1,3,ng,ne,i,j)-tripoint(1,1,ng,ne,i,j)) )

!-----------------------------------------------------------------------
! Transform the vertices to the X3 coordinate system associated with 
! the source grid cell.
!-----------------------------------------------------------------------

               nd = nd_source(ng,ne,i,j)

               do nv = 1, ntrivert

! Shift the origin from the edge midpoint to the center of the
! source grid cell (remaining in X4).

                  utmp(:) = tripoint(:,nv,ng,ne,i,j)                   & 
                          - p_x4(:,nd,ne,i,j,ksdm)

! Transform from X4 to X3.

                  tripoint(1,nv,ng,ne,i,j) =                           &
                     trans_X4_to_X3(1,1,nd,ne,i,j,ksdm) * utmp(1) +    &
                     trans_X4_to_X3(1,2,nd,ne,i,j,ksdm) * utmp(2) 

                  tripoint(2,nv,ng,ne,i,j) =                           &
                     trans_X4_to_X3(2,1,nd,ne,i,j,ksdm) * utmp(1) +    &
                     trans_X4_to_X3(2,2,nd,ne,i,j,ksdm) * utmp(2) 

               enddo               ! ntrivert

! Compute quadrature points.

               if (integral_order==1) then ! midpoint for linear integrals

                  tripoint(1,0,ng,ne,i,j) = p333 *                     &
                                            (tripoint(1,1,ng,ne,i,j)   &
                                           + tripoint(1,2,ng,ne,i,j)   &
                                           + tripoint(1,3,ng,ne,i,j))
                  tripoint(2,0,ng,ne,i,j) = p333 *                     &
                                            (tripoint(2,1,ng,ne,i,j)   &
                                           + tripoint(2,2,ng,ne,i,j)   &
                                           + tripoint(2,3,ng,ne,i,j))

               elseif (integral_order==2) then ! 3 pts for quadratic integrals 

                  tripoint(1,0,ng,ne,i,j) = p333 *                     &
                                            (tripoint(1,1,ng,ne,i,j)   &
                                           + tripoint(1,2,ng,ne,i,j)   &
                                           + tripoint(1,3,ng,ne,i,j))
                  tripoint(2,0,ng,ne,i,j) = p333 *                     &
                                            (tripoint(2,1,ng,ne,i,j)   &
                                           + tripoint(2,2,ng,ne,i,j)   &
                                           + tripoint(2,3,ng,ne,i,j))
                  do nv = 1, ntrivert
                     tripoint(1,nv,ng,ne,i,j) = p5 *                   &
                                             (tripoint(1,0 ,ng,ne,i,j) & 
                                            + tripoint(1,nv,ng,ne,i,j))
                     tripoint(2,nv,ng,ne,i,j) = p5 *                   &
                                             (tripoint(2,0 ,ng,ne,i,j) & 
                                            + tripoint(2,nv,ng,ne,i,j))
                  enddo

               else                         ! 4 pts for cubic integrals

                  tripoint(1,0,ng,ne,i,j) = p333 *                     &
                                            (tripoint(1,1,ng,ne,i,j)   &
                                           + tripoint(1,2,ng,ne,i,j)   &
                                           + tripoint(1,3,ng,ne,i,j))
                  tripoint(2,0,ng,ne,i,j) = p333 *                     &
                                            (tripoint(2,1,ng,ne,i,j)   &
                                           + tripoint(2,2,ng,ne,i,j)   &
                                           + tripoint(2,3,ng,ne,i,j))
                  do nv = 1, ntrivert
                     tripoint(1,nv,ng,ne,i,j) =                        &
                                       p6 * tripoint(1,0 ,ng,ne,i,j)   &
                                     + p4 * tripoint(1,nv,ng,ne,i,j)
                     tripoint(2,nv,ng,ne,i,j) =                        &
                                       p6 * tripoint(2,0 ,ng,ne,i,j)   &
                                     + p4 * tripoint(2,nv,ng,ne,i,j)
                  enddo

               endif            ! integral_order

            endif               ! fluxsign
         enddo                  ! ngroups
      enddo                     ! nedges
      enddo                     ! i
      enddo                     ! j

      end subroutine locate_triangles
!=======================================================================
! END OF LOCATE_TRIANGLES
!=======================================================================


!=======================================================================
! BEGINNING OF TRANSPORT_INTEGRALS 
!=======================================================================
      subroutine transport_integrals (ntrace,                          &
                                      mp,        tp,                   &
                                      mx,        tx,                   &
                                      my,        ty,                   &
                                      mmask,     tmask,                &
                                      mflux,     mtflux,               &
                                      tripoint,  triarea,              &
                                      nd_source, integral_order,       &
                                      depend,    has_dependents)

!-----------------------------------------------------------------------
! Integrate mass and tracer transports over departure triangles using 
! a linear, quadratic, or cubic quarature formula.
!-----------------------------------------------------------------------

      implicit none

!-----------------------------------------------------------------------
! INTENT IN
!-----------------------------------------------------------------------

      integer (kind=int_kind) ::                                       &
           ntrace            ! number of tracers

      real (kind=dbl_kind), dimension(iim,jjm), intent(in) ::          &
           mp,              &! mass at cell center  
           mx,              &! x gradient of mass 
           my,              &! y gradient of mass
           mmask             ! = 1 if m > 0, else = 0

      real (kind=dbl_kind), dimension(iim,jjm,ntrace), intent(in) ::   &
           tp,              &! tracer at cell center         
           tx,              &! x gradient of t 
           ty,              &! y gradient of t
           tmask             ! = 1 if t > 0, else = 0

      real (kind=dbl_kind), intent(in),                                &
         dimension(nspace,0:ntrivert,ngroups,nedges,iim,jjm)::         &
           tripoint          ! coordinates of triangle points

      real (kind=dbl_kind), intent(in),                                & 
         dimension(ngroups,nedges,iim,jjm) ::                          &
           triarea           ! triangle areas

      integer (kind=int_kind), intent(in),                             &
         dimension(ngroups,nedges,iim,jjm) ::                          &
           nd_source         ! nd index of source grid cell

      integer (kind=int_kind), intent(in) ::                           &
           integral_order   ! polynomial order of quadrature integrals
                            ! linear=1, quadratic=2, cubic=3

      integer (kind=int_kind), dimension(ntrace), intent(in) ::        &
           depend            ! dependency vector for tracers 

      logical (kind=log_kind), dimension(ntrace), intent(in) ::        &
           has_dependents    ! true for tracers with dependent tracers

!-----------------------------------------------------------------------
! INTENT OUT
!-----------------------------------------------------------------------
      real (kind=dbl_kind), intent(out),                               &
         dimension(nedges,iim,jjm) ::                                  &
           mflux            ! mass transport across edges

      real (kind=dbl_kind), intent(out),                               &
         dimension(nedges,iim,jjm,ntrace) ::                           &
           mtflux           ! mass*tracer transport across edges

!-----------------------------------------------------------------------
! LOCAL
!-----------------------------------------------------------------------

      integer (kind=int_kind) ::                                       &
           i,j,            &! horizontal indices of cell owning the edge
           ne,             &! edge index
           ng,             &! triangle group index 
           nd,             &! edge data index (1-4) for source grid cell
           ip,jp,          &! i,j indices for source grid cell
           nt, nt1          ! tracer indices

      real (kind=dbl_kind) ::                                          &
           m0, m1, m2, m3, &! weighted mass at special triangle points
           msum,           &! sum over points of m
           mxsum,          &! sum over points of m  
           mysum,          &! sum over points of m*y
           mxxsum,         &! sum over points of m*x*x
           mxysum,         &! sum over points of m*x*y
           myysum,         &! sum over points of m*y*y
           t0,             &! tracer at triangle midpoint
           wk0,wk1,wk2,wk3  ! work variables

      real (kind=dbl_kind), dimension(ntrace) ::                      &
           mtsum,          &! sum over points of m*t
           mtxsum,         &! sum over points of m*t*x
           mtysum           ! sum over points of m*t*y

!-----------------------------------------------------------------------
! Initialize
!-----------------------------------------------------------------------

      mflux (:,:,:)   = c0
      mtflux(:,:,:,:) = c0

!-----------------------------------------------------------------------
! Integrate
!-----------------------------------------------------------------------

      if (integral_order==1) then      ! linear integrals

!-----------------------------------------------------------------------
! I1 = integral of f(r)*dA
!    = f(r0) where r0 is the triangle midpoint
!-----------------------------------------------------------------------

         do j = 1+npad, jjm-npad
         do i = 1+npad, iim-npad
         do ne = 1, nedges
         do ng = 1, ngroups

            nd = nd_source(ng,ne,i,j)

            if (nd /= 0) then

               ip = i + ishift_p(nd,ne) ! indices of source grid cell
               jp = j + jshift_p(nd,ne)
 
               m0 = mp(ip,jp)                                          &
                  + tripoint(1,0,ng,ne,i,j) * mx(ip,jp)                &
                  + tripoint(2,0,ng,ne,i,j) * my(ip,jp)  

               mflux(ne,i,j) = mflux(ne,i,j)                           & 
                             + triarea(ng,ne,i,j)*m0

               do nt = 1, ntrace

                  t0 = tp(ip,jp,nt)                                    &
                     + tripoint(1,0,ng,ne,i,j) * tx(ip,jp,nt)          &
                     + tripoint(2,0,ng,ne,i,j) * ty(ip,jp,nt)

                  mtflux(ne,i,j,nt) = mtflux(ne,i,j,nt)                &
                                    + triarea(ng,ne,i,j)*m0*t0
               enddo

            endif               ! nd /= 0

         enddo                  ! ngroups
         enddo                  ! nedges
         enddo                  ! i
         enddo                  ! j

      elseif (integral_order==2) then      ! quadratic integrals

!-----------------------------------------------------------------------
! I2 = integral of f(r)*dA
!    = (area/3) * (f(r1) + f(r2) + f(r3))
! where r1, r2, and r3 are the triangle vertices.
!-----------------------------------------------------------------------

         do j = 1+npad, jjm-npad
         do i = 1+npad, iim-npad
         do ne = 1, nedges
         do ng = 1, ngroups

            nd = nd_source(ng,ne,i,j)

            if (nd /= 0) then

               ip = i + ishift_p(nd,ne) ! indices of source grid cell
               jp = j + jshift_p(nd,ne)
                    
               m1 = p333 * (mp(ip,jp)                                  &
                          + tripoint(1,1,ng,ne,i,j) * mx(ip,jp)        &
                          + tripoint(2,1,ng,ne,i,j) * my(ip,jp) )  
                     
               m2 = p333 * (mp(ip,jp)                                  &
                          + tripoint(1,2,ng,ne,i,j) * mx(ip,jp)        &
                          + tripoint(2,2,ng,ne,i,j) * my(ip,jp) )  

               m3 = p333 * (mp(ip,jp)                                  &
                          + tripoint(1,3,ng,ne,i,j) * mx(ip,jp)        &
                          + tripoint(2,3,ng,ne,i,j) * my(ip,jp) )  
        
               msum = m1 + m2 + m3

               mflux(ne,i,j) = mflux(ne,i,j)                           & 
                             + triarea(ng,ne,i,j)*msum

               mxsum = m1 * tripoint(1,1,ng,ne,i,j)                    &
                     + m2 * tripoint(1,2,ng,ne,i,j)                    &
                     + m3 * tripoint(1,3,ng,ne,i,j)

               mysum = m1 * tripoint(2,1,ng,ne,i,j)                    &
                     + m2 * tripoint(2,2,ng,ne,i,j)                    &
                     + m3 * tripoint(2,3,ng,ne,i,j)

               do nt = 1, ntrace

                  mtsum(nt) = msum  * tp(ip,jp,nt)                     &
                            + mxsum * tx(ip,jp,nt)                     &
                            + mysum * ty(ip,jp,nt)

                  mtflux(ne,i,j,nt) = mtflux(ne,i,j,nt)                &
                                    + triarea(ng,ne,i,j)*mtsum(nt)

               enddo

            endif               ! nd /= 0

         enddo                  ! ngroups
         enddo                  ! nedges
         enddo                  ! i
         enddo                  ! j

      else                      ! cubic integrals
         
!-----------------------------------------------------------------------
! I3 = integral of f(r)*dA
!    =  -(9/16) *  f(r0)
!     + (25/48) * (f(r1) + f(r2) + f(r3))
! where r0 is the triangle midpoint, and r1, r2, and r3 are interior
! points lying 2/5 of the way from the midpoint to the three vertices.
!-----------------------------------------------------------------------

         do j = 1+npad, jjm-npad
         do i = 1+npad, iim-npad
         do ne = 1, nedges
         do ng = 1, ngroups

            nd = nd_source(ng,ne,i,j)

            if (nd /= 0) then

               ip = i + ishift_p(nd,ne) ! indices of source grid cell
               jp = j + jshift_p(nd,ne)

               m0 = p5625m * (mp(ip,jp)                                &
                            + tripoint(1,0,ng,ne,i,j) * mx(ip,jp)      &
                            + tripoint(2,0,ng,ne,i,j) * my(ip,jp) )  

               m1 = p52083 * (mp(ip,jp)                                &
                            + tripoint(1,1,ng,ne,i,j) * mx(ip,jp)      &
                            + tripoint(2,1,ng,ne,i,j) * my(ip,jp) )  

               m2 = p52083 * (mp(ip,jp)                                &
                            + tripoint(1,2,ng,ne,i,j) * mx(ip,jp)      &
                            + tripoint(2,2,ng,ne,i,j) * my(ip,jp) )  

               m3 = p52083 * (mp(ip,jp)                                &
                            + tripoint(1,3,ng,ne,i,j) * mx(ip,jp)      &
                            + tripoint(2,3,ng,ne,i,j) * my(ip,jp) )  

               msum = m0 + m1 + m2 + m3

               mflux(ne,i,j) = mflux(ne,i,j)                           &
                             + triarea(ng,ne,i,j)*msum

               wk0 = m0 * tripoint(1,0,ng,ne,i,j)
               wk1 = m1 * tripoint(1,1,ng,ne,i,j)
               wk2 = m2 * tripoint(1,2,ng,ne,i,j)
               wk3 = m3 * tripoint(1,3,ng,ne,i,j)

               mxsum = wk0 + wk1 + wk2 + wk3

               mxxsum = wk0 * tripoint(1,0,ng,ne,i,j)                  &
                      + wk1 * tripoint(1,1,ng,ne,i,j)                  &
                      + wk2 * tripoint(1,2,ng,ne,i,j)                  &
                      + wk3 * tripoint(1,3,ng,ne,i,j)  

               mxysum = wk0 * tripoint(2,0,ng,ne,i,j)                  &
                      + wk1 * tripoint(2,1,ng,ne,i,j)                  &
                      + wk2 * tripoint(2,2,ng,ne,i,j)                  &
                      + wk3 * tripoint(2,3,ng,ne,i,j)

               wk0 = m0 * tripoint(2,0,ng,ne,i,j)                    
               wk1 = m1 * tripoint(2,1,ng,ne,i,j)                    
               wk2 = m2 * tripoint(2,2,ng,ne,i,j)                    
               wk3 = m3 * tripoint(2,3,ng,ne,i,j)

               mysum = wk0 + wk1 + wk2 + wk3

               myysum = wk0 * tripoint(2,0,ng,ne,i,j)                  &
                      + wk1 * tripoint(2,1,ng,ne,i,j)                  &
                      + wk2 * tripoint(2,2,ng,ne,i,j)                  &
                      + wk3 * tripoint(2,3,ng,ne,i,j)

               do nt = 1, ntrace

                  if (depend(nt)==0) then ! doesn't depend on another tracer

                     mtsum(nt) = msum  * tp(ip,jp,nt)                  &
                               + mxsum * tx(ip,jp,nt)                  &
                               + mysum * ty(ip,jp,nt)

                     mtflux(ne,i,j,nt) = mtflux(ne,i,j,nt)             &
                                       + triarea(ng,ne,i,j) * mtsum(nt)

                     if (has_dependents(nt)) then

                        mtxsum(nt) = mxsum  * tp(ip,jp,nt)             &
                                   + mxxsum * tx(ip,jp,nt)             &
                                   + mxysum * ty(ip,jp,nt)

                        mtysum(nt) = mysum  * tp(ip,jp,nt)             &
                                   + mxysum * tx(ip,jp,nt)             &
                                   + myysum * ty(ip,jp,nt)

                     endif
                           
                  else          ! depends on another tracer

                     nt1 = depend(nt)
                     mtsum(nt) = mtsum(nt1)  * tp(ip,jp,nt)            &
                               + mtxsum(nt1) * tx(ip,jp,nt)            &
                               + mtysum(nt1) * ty(ip,jp,nt)

                     mtflux(ne,i,j,nt) = mtflux(ne,i,j,nt)             &
                                + triarea(ng,ne,i,j) * mtsum(nt)

                  endif         ! depend(nt) = 0

               enddo            ! ntrace
            endif               ! nd /= 0
         enddo                  ! ngroups
         enddo                  ! nedges
         enddo                  ! i
         enddo                  ! j

      endif                     ! sum(depend) = 0

      end subroutine transport_integrals
!=======================================================================
! END OF TRANSPORT_INTEGRALS
!=======================================================================


!=======================================================================
! BEGINNING OF UPDATE_FIELDS
!=======================================================================
      subroutine update_fields (ntrace,                                &
                                mass,   trace,                         & 
                                mflux,  mtflux,                        &
                                depend, l_check_divergence)

!-----------------------------------------------------------------------
! Given transports across half-edges, compute new mass and tracer values.
!-----------------------------------------------------------------------

      implicit none

!-----------------------------------------------------------------------
! INTENT IN
!-----------------------------------------------------------------------

      integer (kind=int_kind), intent(in) ::                           &
           ntrace         ! number of tracer fields

      real (kind=dbl_kind), intent(in) ::                              &
           mflux (nedges,iim,jjm),          &! mass transport
           mtflux(nedges,iim,jjm,ntrace)     ! mass*tracer transport

      integer (kind=int_kind), dimension(ntrace), intent(in) ::        &
           depend            ! dependency vector for tracers 

      logical (kind=log_kind), intent(in) ::                           &
           l_check_divergence  ! if true, check for large divergences

!-----------------------------------------------------------------------
! INTENT INOUT
!-----------------------------------------------------------------------

      real (kind=dbl_kind), intent(inout) ::                           &
           mass (iim,jjm),          &! mass field
           trace(iim,jjm,ntrace)     ! tracer field          

!-----------------------------------------------------------------------
! LOCAL
!-----------------------------------------------------------------------

      integer (kind=int_kind) ::                                       &
           i, j,           &! horizontal indices
           nt, nt1          ! tracer indices

      real (kind=dbl_kind) ::                                          &
           mtold (iim,jjm,ntrace), &! starting value of mass*trace 
           flxdiv(iim,jjm)          ! flux divergence (positive outward)

!-----------------------------------------------------------------------
! Save starting values of mass * tracer
!-----------------------------------------------------------------------

      do nt = 1, ntrace
         nt1 = depend(nt)
         if (nt1==0) then ! does not depend on other tracers
            do j = 1, jjm
            do i = 1, iim
               mtold(i,j,nt) =  mass(i,j) * trace(i,j,nt)
            enddo               ! i
            enddo               ! j
         else                   ! depends on another tracer
            do j = 1, jjm
            do i = 1, iim
               mtold(i,j,nt) =  mass(i,j) * trace(i,j,nt1) * trace(i,j,nt)
            enddo               ! i
            enddo               ! j
         endif
      enddo                     ! nt

!-----------------------------------------------------------------------
! Divergence of mass flux
!-----------------------------------------------------------------------

      call div_of_an_edge_flux (npad,                              &
                                iim,                               &
                                jjm,                               &
                                nedges,                            &
                                area_inv_x3(:,:,ksdm),             &
                                mflux(:,:,:),                      &
                                flxdiv(:,:) )

      if (l_check_divergence) then

         do j = 1, jjm-1
         do i = 1, iim-1
            if (i==itest .and. j==jtest .and. ksdm==ktest          &
                .or. abs(flxdiv(i,j)) > 0.1*mass(i,j)) then
               print*, ''
               print*, 'Divergence: my_task, ksdm, i, j:', my_task,ksdm,i,j
               print*, 'Starting mass:', mass(i,j)
               print*, 'Mass divergence:', flxdiv(i,j)
               print*, 'mflux(1,i,  j)   =', mflux(1,i,  j)
               print*, 'mflux(2,i,  j)   =', mflux(2,i,  j)
               print*, 'mflux(3,i,  j)   =', mflux(3,i,  j)
               print*, '-mflux(1,i+1,j)   =', -mflux(1,i+1,j)
               print*, '-mflux(2,i+1,j+1) =', -mflux(2,i+1,j+1)
               print*, '-mflux(3,i  ,j+1) =', -mflux(3,i  ,j+1)
               print*, 'sum =', mflux(1,i,j) + mflux(2,i,j) + mflux(3,i,j) &
                      - mflux(1,i+1,j) - mflux(2,i+1,j+1) - mflux(3,i,j+1)
            endif  ! test point or big divergence
         enddo  ! i
         enddo  ! j

      endif                     ! l_check_divergence

!-----------------------------------------------------------------------
! Update mass field
!-----------------------------------------------------------------------

      do j = 1, jjm
      do i = 1, iim

         mass(i,j) = mass(i,j) - flxdiv(i,j)

         if (mass(i,j) < -eps) then ! mass error, possibly a CFL violation
            write (6,*) ''
            write (6,*) 'New mass < 0, remapping transport'
            write (6,*) 'my_task, i, j, ksdm:', my_task, i, j, ksdm
            write (6,*) 'Old mass =', mass(i,j) + flxdiv(i,j)
            write (6,*) 'New mass =', mass(i,j)
            write (6,*) 'Mass divergence =', flxdiv(i,j)
!            stop
         elseif (mass(i,j) < eps) then ! set to zero
            mass(i,j) = c0
         endif

      enddo                     ! i
      enddo                     ! j

!-----------------------------------------------------------------------
! Update tracers
!-----------------------------------------------------------------------

      do nt = 1, ntrace

         call div_of_an_edge_flux (npad,                               &
                                   iim,                                &
                                   jjm,                                &
                                   nedges,                             &
                                   area_inv_x3(:,:,ksdm),              &
                                   mtflux(:,:,:,nt),                   &
                                   flxdiv(:,:) )
         nt1 = depend(nt)
                                   
         if (nt1==0) then ! does not depend on other tracers

            do j = 1, jjm
            do i = 1, iim
               if (mass(i,j) > c0) then
                  trace(i,j,nt) = (mtold(i,j,nt) - flxdiv(i,j))           &
                                 / mass(i,j)
               else
                  trace(i,j,nt) = c0
               endif
            enddo
            enddo

         else                   ! depends on another tracer

            do j = 1, jjm
            do i = 1, iim
               if (abs(trace(i,j,nt1)) > eps) then
                  trace(i,j,nt) = (mtold(i,j,nt) - flxdiv(i,j))        &
                                  / (mass(i,j) * trace(i,j,nt1))
               else
                  trace(i,j,nt) = c0
               endif
            enddo
            enddo

         endif                  ! nt1 = 0
      enddo                     ! nt

      end subroutine update_fields
!=======================================================================
! END OF UPDATE_FIELDS
!=======================================================================


!=======================================================================
! BEGINNING OF CONSERVED_SUMS
!=======================================================================
      subroutine conserved_sums (component_name,                       & 
                                 nmass,  ntrace,                       &
                                 mass,   trace,                        &
                                 msum,   mtsum,                        &
                                 depend, abs_mtsum)

!-----------------------------------------------------------------------
! Compute global sums of conserved quantities.
!-----------------------------------------------------------------------

      implicit none

!-----------------------------------------------------------------------
! INTENT IN
!-----------------------------------------------------------------------

      character (len=*), intent(in) :: component_name

      integer (kind=int_kind), intent(in) ::                           &
           nmass,               &! number of mass fields
           ntrace                ! number of tracers

      real (kind=dbl_kind), intent(in) ::                              &
           mass (iim,jjm,       nmass,nsdm),      &! mass field
           trace(iim,jjm,ntrace,nmass,nsdm)        ! tracer field

      integer (kind=int_kind), dimension(ntrace), intent(in) ::        &
           depend                ! dependency vector for tracers

!-----------------------------------------------------------------------
! INTENT OUT
!-----------------------------------------------------------------------

      real (kind=dbl_kind), intent(out) ::                             &
           msum,                &! global mass sum
           mtsum(ntrace)         ! global sum of mass*tracer

      real (kind=dbl_kind), intent(out), optional ::                   &
           abs_mtsum(ntrace)     ! global sum of abs(mass*tracer)

!-----------------------------------------------------------------------
! LOCAL
!-----------------------------------------------------------------------

      integer (kind=int_kind) ::                                       &
           nm,                  &! mass index
           nt, nt1,             &! tracer indices
           size                  ! size of work arrays

      real (kind=dbl_kind) ::                                          &
           work1(iim,jjm,nsdm), &! work array 
           work2(iim,jjm,nsdm)   ! work array 

! Initialize

      msum = c0
      mtsum(:) = c0
      if (present(abs_mtsum)) abs_mtsum(:) = c0

      size = iim*jjm*nsdm

! Global sums

      do nm = 1, nmass
         work1(:,:,:) = area_x3(:,:,:) * mass(:,:,nm,:)
         msum = msum + global_real_sum(work1,grid_center_mask,size,    &
                                       component_name)
         do nt = 1, ntrace
            if (depend(nt)==0) then  ! tracer has no dependents
               work2(:,:,:) = work1(:,:,:) * trace(:,:,nt,nm,:)
               mtsum(nt) = mtsum(nt)                                   &
                         + global_real_sum(work2,grid_center_mask,     &
                                           size, component_name)
               if (present(abs_mtsum)) then
                  work2(:,:,:) = abs( work1(:,:,:) * trace(:,:,nt,nm,:) )
                  abs_mtsum(nt) = abs_mtsum(nt)                           &
                                + global_real_sum(work2,grid_center_mask, &
                                                  size, component_name)  
               endif
            else                     ! tracer has dependents
               nt1 = depend(nt)
               work2(:,:,:) = work1(:,:,:)                             & 
                            * trace(:,:,nt1,nm,:) * trace(:,:,nt,nm,:) 
               mtsum(nt) = mtsum(nt)                                   &
                         + global_real_sum(work2,grid_center_mask,     &
                                           size, component_name)
               if (present(abs_mtsum)) then
                  work2(:,:,:) = abs( work1(:,:,:)                     & 
                               * trace(:,:,nt1,nm,:) * trace(:,:,nt,nm,:) ) 
                  abs_mtsum(nt) = abs_mtsum(nt)                            &
                                + global_real_sum(work2,grid_center_mask,  &
                                                  size, component_name)
               endif            ! present(abs_mtsum)
            endif               ! tracer dependency
         enddo                  ! ntrace
      enddo                     ! nmass

      end subroutine conserved_sums
!=======================================================================
! END OF CONSERVED_SUMS
!=======================================================================


!=======================================================================
! BEGINNING OF CONSERVATION_CHECK
!=======================================================================
      subroutine conservation_check (ntrace,                           &
                                     msum_init,  msum_final,           &
                                     mtsum_init, mtsum_final,          &
                                     abs_mtsum)

!-----------------------------------------------------------------------
! Compare initial to final global sums to make sure they have not
! changed during transport.
!-----------------------------------------------------------------------

      implicit none

!-----------------------------------------------------------------------
! INTENT IN
!-----------------------------------------------------------------------

      integer (kind=int_kind), intent(in) ::                           &
           ntrace           ! number of tracers

      real (kind=dbl_kind), intent(in) ::                              &  
           msum_init,      &! initial global mass sum
           msum_final       ! final global mass sum

      real (kind=dbl_kind), dimension(ntrace), intent(in) ::           &
           mtsum_init,     &! initial global sum of mass*tracer
           mtsum_final,    &! final global sum of mass*tracer          &
           abs_mtsum        ! global sum of abs(mass*tracer)

!-----------------------------------------------------------------------
! LOCAL
!-----------------------------------------------------------------------

      integer (kind=int_kind) ::                                       &
           nt               ! tracer index

      real (kind=dbl_kind) ::                                          &
           diff             ! difference between initial and final values

      if (msum_init > eps) then
         diff = msum_final - msum_init
         if (abs(diff/msum_init) > eps) then
            write (6,*) ''
            write (6,*) 'global mass conservation error'
            write (6,*) 'mass before remapping =', msum_init
            write (6,*) 'mass after remapping =', msum_final
            write (6,*) 'difference =', diff
            call abort_code('remapping mass conservation error')
         endif
      endif

      do nt = 1, ntrace
         if (abs(mtsum_init(nt)) > eps) then
            diff = mtsum_final(nt) - mtsum_init(nt)
            if (abs(diff/abs_mtsum(nt)) > eps) then
               write (6,*) ''
               write (6,*) 'global tracer conservation error, nt =', nt
               write (6,*) 'mass*tracer before remapping =', mtsum_init(nt)
               write (6,*) 'mass*tracer after remapping =', mtsum_final(nt)
               write (6,*) 'difference =', diff
               call abort_code('remapping tracer conservation error')
            endif
         endif
      enddo

      end subroutine conservation_check
!=======================================================================
! END OF CONSERVATION_CHECK
!=======================================================================


!=======================================================================
! BEGINNING OF LOCAL_MAXMIN
!=======================================================================
      subroutine local_maxmin (component_name,                         &
                               nmass, ntrace, trace,                   &
                               mmask, tmask,  depend,                  &
                               tmin,   tmax )

!-----------------------------------------------------------------------
! At each grid point, compute the local max and min of the tracer
! fields: the max and min values in the seven-cell region 
! consisting of the home cell and its six neighbors, plus the
! neighbors of the neighbors (19 cells in all).
!-----------------------------------------------------------------------

      implicit none

!-----------------------------------------------------------------------
! INTENT IN
!-----------------------------------------------------------------------

      character (len=*), intent(in) :: component_name

      integer (kind=int_kind), intent(in) ::                           &
           nmass,               &! number of mass fields
           ntrace                ! number of tracers

      real (kind=dbl_kind), intent(in) ::                              &
           trace (iim,jjm,ntrace,nmass,nsdm),   &! tracer fields  
           mmask (iim,jjm,       nmass,nsdm),   &! = 1. if mass > 0
           tmask (iim,jjm,ntrace,nmass,nsdm)     ! = 1. if |tracer| > 0  

      integer (kind=int_kind), dimension(ntrace), intent(in) ::        &
           depend         ! dependency vector for tracers

!-----------------------------------------------------------------------
! INTENT OUT
!-----------------------------------------------------------------------

      real (kind=dbl_kind), intent(out),                               &
         dimension(iim,jjm,ntrace,nmass,nsdm)::                        & 
           tmin,         &! local min tracer
           tmax           ! local max tracer

!-----------------------------------------------------------------------
! LOCAL
!-----------------------------------------------------------------------

      integer (kind=int_kind) ::                                       &
           ksdm,         &! subdomain index
           nm,           &! mass index
           i, j,         &! horizontal indices
           nt, nt1        ! tracer indices

      real (kind=dbl_kind) ::                                          &
           wk1,wk2,wk3,wk4,wk5,wk6  ! work variables


      do ksdm = 1, nsdm
      do nm = 1, nmass
      do nt = 1, ntrace

        if (depend(nt)==0) then  ! does not depend on another tracer

         do j = 1+npad, jjm-npad
         do i = 1+npad, iim-npad

!-----------------------------------------------------------------------
!  Load values of tm in the 6 neighbor cells.  
!  If mask = 1., use the true value; otherwise use the home cell value 
!  so that non-physical values of tm do not contribute to max and min.
!----------------------------------------------------------------------- 

            wk1 =     mmask(i-1,j,  nm,ksdm) * trace(i-1,j,  nt,nm,ksdm) &
                + (c1-mmask(i-1,j,  nm,ksdm))* trace(i,  j,  nt,nm,ksdm) 
            wk2 =     mmask(i-1,j-1,nm,ksdm) * trace(i-1,j-1,nt,nm,ksdm) &
                + (c1-mmask(i-1,j-1,nm,ksdm))* trace(i,  j,  nt,nm,ksdm) 
            wk3 =     mmask(i,j-1,  nm,ksdm) * trace(i,  j-1,nt,nm,ksdm) &
                + (c1-mmask(i,j-1,  nm,ksdm))* trace(i,  j,  nt,nm,ksdm) 
            wk4 =     mmask(i+1,j,  nm,ksdm) * trace(i+1,j,  nt,nm,ksdm) &
                + (c1-mmask(i+1,j,  nm,ksdm))* trace(i,  j,  nt,nm,ksdm) 
            wk5 =     mmask(i+1,j+1,nm,ksdm) * trace(i+1,j+1,nt,nm,ksdm) &
                + (c1-mmask(i+1,j+1,nm,ksdm))* trace(i,  j,  nt,nm,ksdm)
            wk6 =     mmask(i,  j+1,nm,ksdm) * trace(i,  j+1,nt,nm,ksdm) &
                + (c1-mmask(i,  j+1,nm,ksdm))* trace(i,  j,  nt,nm,ksdm)
!
! Find minimum and maximum among the cell and its neighbors.
!
            tmin(i,j,nt,nm,ksdm) = min( wk1,wk2,wk3,wk4,wk5,wk6,         &    
                                        trace(i,j,nt,nm,ksdm) )
            tmax(i,j,nt,nm,ksdm) = max( wk1,wk2,wk3,wk4,wk5,wk6,         &
                                        trace(i,j,nt,nm,ksdm) )

         enddo               ! i
         enddo               ! j

        else                   ! depends on another tracer

         nt1 = depend(nt)
         do j = 1+npad, jjm-npad
         do i = 1+npad, iim-npad

            wk1 =     tmask(i-1,j,  nt1,nm,ksdm) * trace(i-1,j,  nt,nm,ksdm) &
                + (c1-tmask(i-1,j,  nt1,nm,ksdm))* trace(i,  j,  nt,nm,ksdm)
            wk2 =     tmask(i-1,j-1,nt1,nm,ksdm) * trace(i-1,j-1,nt,nm,ksdm) &
                + (c1-tmask(i-1,j-1,nt1,nm,ksdm))* trace(i,  j,  nt,nm,ksdm)
            wk3 =     tmask(i,j-1,  nt1,nm,ksdm) * trace(i,  j-1,nt,nm,ksdm) &
                + (c1-tmask(i,j-1,  nt1,nm,ksdm))* trace(i,  j,  nt,nm,ksdm)
            wk4 =     tmask(i+1,j,  nt1,nm,ksdm) * trace(i+1,j,  nt,nm,ksdm) &
                + (c1-tmask(i+1,j,  nt1,nm,ksdm))* trace(i,  j,  nt,nm,ksdm)
            wk5 =     tmask(i+1,j+1,nt1,nm,ksdm) * trace(i+1,j+1,nt,nm,ksdm) &
                + (c1-tmask(i+1,j+1,nt1,nm,ksdm))* trace(i,  j,  nt,nm,ksdm)
            wk6 =     tmask(i,  j+1,nt1,nm,ksdm) * trace(i,  j+1,nt,nm,ksdm) &
                + (c1-tmask(i,  j+1,nt1,nm,ksdm))* trace(i,  j,  nt,nm,ksdm)
!
! Find minimum and maximum among the cell and its neighbors.
!
            tmin(i,j,nt,nm,ksdm) = min( wk1,wk2,wk3,wk4,wk5,wk6,     &    
                                        trace(i,j,nt,nm,ksdm) )
            tmax(i,j,nt,nm,ksdm) = max( wk1,wk2,wk3,wk4,wk5,wk6,     &
                                        trace(i,j,nt,nm,ksdm) )

         enddo               ! i
         enddo               ! j

        endif                ! depend
      enddo                  ! ntrace
      enddo                  ! nmass
      enddo                  ! nsdm
!
! Extend by one more cell, to include neighbors of the neighbors.
!
      do nm = 1, nmass
         call wrap (component_name, face=tmin(:,:,:,nm,:))
         call wrap (component_name, face=tmax(:,:,:,nm,:))
      enddo

      do ksdm = 1, nsdm
      do nm = 1, nmass
      do nt = 1, ntrace
      do j = 1+npad, jjm-npad
      do i = 1+npad, iim-npad
            
         tmax(i,j,nt,nm,ksdm) =                                        & 
             max (tmax(i,j,nt,nm,ksdm),                                &
                  tmax(i-1,j,  nt,nm,ksdm), tmax(i-1,j-1,nt,nm,ksdm),  &
                  tmax(i,  j-1,nt,nm,ksdm), tmax(i+1,j,  nt,nm,ksdm),  &
                  tmax(i+1,j+1,nt,nm,ksdm), tmax(i,  j+1,nt,nm,ksdm)) 

         tmin(i,j,nt,nm,ksdm) =                                        &
             min (tmin(i,  j,  nt,nm,ksdm),                            &
                  tmin(i-1,j,  nt,nm,ksdm), tmin(i-1,j-1,nt,nm,ksdm),  &
                  tmin(i,  j-1,nt,nm,ksdm), tmin(i+1,j,  nt,nm,ksdm),  &
                  tmin(i+1,j+1,nt,nm,ksdm), tmin(i,  j+1,nt,nm,ksdm))

      enddo                     ! i
      enddo                     ! j
      enddo                     ! ntrace
      enddo                     ! nmass
      enddo                     ! nsdm

      end subroutine local_maxmin
!=======================================================================
! END OF LOCAL_MAXMIN
!=======================================================================


!=======================================================================
! BEGINNING OF MONOTONICITY_CHECK
!=======================================================================
      subroutine monotonicity_check (ntrace, depend,                   &
                                     mass,   trace,                    &
                                     tmin,   tmax)

!---------------------------------------------------------------------
! At each grid point, make sure that the new tracer values 
! fall between the local max and min values before transport.
!---------------------------------------------------------------------

      implicit none

!-----------------------------------------------------------------------
! INTENT IN
!-----------------------------------------------------------------------

      integer (kind=int_kind), intent(in) ::                           &
           ntrace                ! number of tracers

      real (kind=dbl_kind), intent(in) ::                              &
           mass  (iim,jjm),        &! mass field  
           trace (iim,jjm,ntrace)   ! tracer fields  

      integer (kind=int_kind), dimension(ntrace), intent(in) ::        &
           depend         ! dependency vector for tracers

      real (kind=dbl_kind), intent(in),                                &
         dimension(iim,jjm,ntrace)::                                   & 
           tmin,         &! local min tracer
           tmax           ! local max tracer

!-----------------------------------------------------------------------
! LOCAL
!-----------------------------------------------------------------------

      integer (kind=int_kind) ::                                       &
           i, j,         &! horizontal indices
           nt, nt1        ! tracer indices

      do nt = 1, ntrace

         if (depend(nt)==0) then ! does not depend on another tracer

            do j = 1+npad, jjm-npad
            do i = 1+npad, iim-npad
               if (mass(i,j) > eps) then
                  if (trace(i,j,nt) < tmin(i,j,nt)-eps) then
                     write (6,*) ''
                     write (6,*) 'new tracer < tmin'
                     write (6,*) 'my_task i, j, ksdm, nt =', &
                                  my_task,i, j, ksdm, nt
                     write (6,*) 'new tracer =', trace(i,j,nt)
                     write (6,*) 'tmin ='      , tmin (i,j,nt)
                  elseif (trace(i,j,nt) > tmax(i,j,nt)+eps) then
                     write (6,*) ''
                     write (6,*) 'new tracer > tmax'
                     write (6,*) 'my_task, i, j, ksdm, nt =', &
                                  my_task, i, j, ksdm, nt
                     write (6,*) 'new tracer =', trace(i,j,nt)
                     write (6,*) 'tmax ='      , tmax (i,j,nt)
                  endif
               endif
            enddo
            enddo
               
         else                   ! depends on another tracer

            do j = 1+npad, jjm-npad
            do i = 1+npad, iim-npad
               nt1 = depend(nt)
               if (abs(trace(i,j,nt1)) > eps) then
                  if (trace(i,j,nt) < tmin(i,j,nt)-eps) then
                     write (6,*) ''
                     write (6,*) 'new tracer < tmin'
                     write (6,*) 'my_task, i, j, ksdm, nt =', &
                                  my_task, i, j, ksdm, nt
                     write (6,*) 'new tracer =', trace(i,j,nt)
                     write (6,*) 'tmin ='      , tmin (i,j,nt)
                  elseif (trace(i,j,nt) > tmax(i,j,nt)+eps) then
                     write (6,*) ''
                     write (6,*) 'new tracer > tmax'
                     write (6,*) 'my_task, i, j, ksdm, nt =', &
                                  my_task, i, j, ksdm, nt
                     write (6,*) 'new tracer =', trace(i,j,nt)
                     write (6,*) 'tmax ='      , tmax (i,j,nt)
                  endif
               endif
            enddo               ! i
            enddo               ! j

         endif                  ! depend
      enddo                     ! ntrace

      end subroutine monotonicity_check
!=======================================================================
! END OF MONOTONICITY_CHECK
!=======================================================================

      end module remap_xxx

!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
