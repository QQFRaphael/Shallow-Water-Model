!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

        module operators

        use kinds
        use geodesic_grid_utilities

        implicit none
	private

! PUBLIC MEMBER FUNCTIONS

	public ::                            &
	   curl_of_a_vector,                 &
	   div_of_a_vector,                  &
	   div_of_an_edge_flux,              &
	   laplacian_of_a_scalar,            &
	   k_cross_v,                        &
	   gradient,                         &
           gradient_at_cell_centers,         &
	   average_vector_to_centers,        &
	   average_scalar_to_centers,        &
	   average_to_cell_corners,          &
	   average_to_cell_corners_up,       &
	   calculate_corner_kinetic_energy,  &
	   calculate_center_kinetic_energy,  &
	   calculate_velocity,               &
	   average_pv_to_cell_corners,       &
           centered_mass_flux,               &
           upstream_mass_flux,               &
           centered_tracer_flux,             &
           upstream_tracer_flux,             &
           centered_vorticity_flux,          &
           centered_divergence_curl


!*************************************************************************

        contains

!*************************************************************************


!======================================================================
! BEGIN CURL_OF_A_VECTOR
!======================================================================
        subroutine curl_of_a_vector(                                  &
                npad,                                                 &
                nx,                                                   &
                ny,                                                   &
                ndata,                                                &
                nspace,                                               &
                ncorners,                                             &
                area_inv,                                             &
                v_weights,                                            &
                xin,                                                  &
                xout)

!-----------------------------------------------------------------------
! PURPOSE : given a vector defined at cell corners, find the curl
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!       npad      : width of 'ghost cell' region
!       nx        : first dimension of xin (integer)
!       ny        : second dimension of xin (integer)
!       ndata     : amount of data involved in curl operator
!       nspace    : number of spatial dimensions
!       ncorners  : number of corners
!       area_inv  : inverse of grid cell area (m^-2)
!       v_weights : weights to compute curl (m)
!       xin       : vector (x)
!       xout      : curl of xin (x*m^-1)
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
! INTENT IN
!-----------------------------------------------------------------------
        integer (kind=int_kind), intent(in) ::                         &
                        npad, nx, ny, ndata, nspace, ncorners

        real (kind=dbl_kind), intent(in) ::                            &
                        area_inv                        (nx,ny),       &
                        v_weights (ndata,nspace,ncorners,nx,ny),       &
                        xin             (nspace,ncorners,nx,ny)

!------------------------------------------------------------------------
! INTENT OUT
!------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                           &
                        xout                            (nx,ny)

!------------------------------------------------------------------------
! LOCAL
!------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j

!------------------------------------------------------------------------
! INITIALIZE parts of xout not filled by the curl operator
!------------------------------------------------------------------------
        do j = 1,npad
        do i = 1,nx
          xout(i,j) = 0.0_dbl_kind
        enddo
        enddo
        do j=ny-npad+1,ny
        do i = 1,nx
          xout(i,j) = 0.0_dbl_kind
        enddo
        enddo
        do i=1,npad
        do j=1,ny
          xout(i,j) = 0.0_dbl_kind
        enddo
        enddo
        do i=nx-npad+1,nx
        do j=1,ny
          xout(i,j) = 0.0_dbl_kind
        enddo
        enddo

!----------------------------------------------------------------------------
! COMPUTE CURL AT INTERIOR POINTS
!----------------------------------------------------------------------------
        do j=1,ny-npad
        do i=1,nx-npad

        xout(i,j) =                                                       &
                  (  + v_weights(1,2,1,i  ,j  ) * xin(1,1,i  ,j  )        &
                     - v_weights(1,1,1,i  ,j  ) * xin(2,1,i  ,j  )        &
                     + v_weights(1,2,2,i  ,j  ) * xin(1,2,i  ,j  )        &
                     - v_weights(1,1,2,i  ,j  ) * xin(2,2,i  ,j  )        &
                     + v_weights(2,2,1,i+1,j  ) * xin(1,1,i+1,j  )        &
                     - v_weights(2,1,1,i+1,j  ) * xin(2,1,i+1,j  )        &
                     + v_weights(2,2,2,i+1,j+1) * xin(1,2,i+1,j+1)        &
                     - v_weights(2,1,2,i+1,j+1) * xin(2,2,i+1,j+1)        &
                     + v_weights(3,2,1,i+1,j+1) * xin(1,1,i+1,j+1)        &
                     - v_weights(3,1,1,i+1,j+1) * xin(2,1,i+1,j+1)        &
                     + v_weights(3,2,2,i  ,j+1) * xin(1,2,i  ,j+1)        &
                     - v_weights(3,1,2,i  ,j+1) * xin(2,2,i  ,j+1) )      &
                     * area_inv(i,j)

        enddo           ! do i
        enddo           ! do j

        end subroutine curl_of_a_vector
!======================================================================
! END CURL_OF_A_VECTOR
!======================================================================


!======================================================================
! BEGIN DIV_OF_A_VECTOR
!====================================================================== 
        subroutine div_of_a_vector(                                   &
                npad,                                                 &
                nx,                                                   &
                ny,                                                   &
                ndata,                                                &
                nspace,                                               &
                ncorners,                                             &
                area_inv,                                             &
                v_weights,                                            &
                xin,                                                  &
                xout )

!-----------------------------------------------------------------------
! PURPOSE : given a vector defined at cell corners, find the divergence
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!       npad      : width of 'ghost cell' region
!       nx        : first dimension of xin (integer)
!       ny        : second dimension of xin (integer)
!       ndata     : amount of data involved in div operator
!       nspace    : number of spatial dimensions
!       ncorners  : number of corners
!       area_inv  : inverse of grid cell area (m^-2)
!       v_weights : weights to compute div (m)
!       xin       : vector(x)
!       xout      : divergence of xin (x*m^-1)
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        integer (kind=int_kind), intent(in) ::                          &
                        npad, nx, ny, ndata, nspace, ncorners

        real (kind=dbl_kind), intent(in) ::                             &
                        area_inv                        (nx,ny),        &
                        v_weights (ndata,nspace,ncorners,nx,ny),        &
                        xin             (nspace,ncorners,nx,ny)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                            &
                        xout                            (nx,ny)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j


!----------------------------------------------------------------------------
! INITIALIZE parts of xout not filled by the curl operator
!----------------------------------------------------------------------------
        do j = 1,npad
        do i = 1,nx
          xout(i,j) = 0.0_dbl_kind
        enddo
        enddo
        do j=ny-npad+1,ny
        do i = 1,nx
          xout(i,j) = 0.0_dbl_kind
        enddo
        enddo
        do i=1,npad
        do j=1,ny
          xout(i,j) = 0.0_dbl_kind
        enddo
        enddo
        do i=nx-npad+1,nx
        do j=1,ny
          xout(i,j) = 0.0_dbl_kind
        enddo
        enddo

!----------------------------------------------------------------------------
! COMPUTE DIVERGENCE AT INTERIOR POINTS
!----------------------------------------------------------------------------
        do j=1,ny-npad
        do i=1,nx-npad

        xout(i,j) =                                                        &
                   ( - v_weights(1,1,1,i  ,j  ) * xin(1,1,i  ,j  )         &
                     - v_weights(1,2,1,i  ,j  ) * xin(2,1,i  ,j  )         &
                     - v_weights(1,1,2,i  ,j  ) * xin(1,2,i  ,j  )         &
                     - v_weights(1,2,2,i  ,j  ) * xin(2,2,i  ,j  )         &
                     - v_weights(2,1,1,i+1,j  ) * xin(1,1,i+1,j  )         &
                     - v_weights(2,2,1,i+1,j  ) * xin(2,1,i+1,j  )         &
                     - v_weights(2,1,2,i+1,j+1) * xin(1,2,i+1,j+1)         &
                     - v_weights(2,2,2,i+1,j+1) * xin(2,2,i+1,j+1)         &
                     - v_weights(3,1,1,i+1,j+1) * xin(1,1,i+1,j+1)         &
                     - v_weights(3,2,1,i+1,j+1) * xin(2,1,i+1,j+1)         &
                     - v_weights(3,1,2,i  ,j+1) * xin(1,2,i  ,j+1)         &
                     - v_weights(3,2,2,i  ,j+1) * xin(2,2,i  ,j+1) )       &
                     * area_inv(i,j)

        enddo           ! do i
        enddo           ! do j

        end subroutine div_of_a_vector
!======================================================================
! END DIV_OF_A_VECTOR
!======================================================================


!======================================================================
! BEGIN DIV_OF_AN_EDGE_FLUX
!====================================================================== 
        subroutine div_of_an_edge_flux(                               &
                npad,                                                 &
                nx,                                                   &
                ny,                                                   &
                nedges,                                               &
                area_inv,                                             &
                xin,                                                  &
                xout )

!-----------------------------------------------------------------------
! PURPOSE : given a flux defined at three edges of all interior points
!       find the divergence of that flux. The divergence is defined
!       at the cell centers
! NOTE : fluxes must be wrapped before the divergence can be computed
! NOTE : for an variable with units q, the xin has units of q * length**2
!          and xout will have units of q
! NOTE : the flux is assumed positive when it points away from the cell
!          that owns it
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!       npad      : width of 'ghost cell' region
!       nx        : first dimension of xin (integer)
!       ny        : second dimension of xin (integer)
!       nedges    : number of edges per grid cell
!       area_inv  : inverse of grid cell area (m^-2)
!       xin       : a signed scalar (i.e. a flux)
!       xout      : divergence of xin (with units of xin*m^-2)
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        integer (kind=int_kind), intent(in) ::                          &
                        npad, nx, ny, nedges

        real (kind=dbl_kind), intent(in) ::                             &
                        area_inv                        (nx,ny),        &
                        xin                      (nedges,nx,ny)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                            &
                        xout                            (nx,ny)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j


!----------------------------------------------------------------------------
! INITIALIZE parts of xout not filled by the curl operator
!----------------------------------------------------------------------------
        do j = 1,npad
        do i = 1,nx
          xout(i,j) = 0.0_dbl_kind
        enddo
        enddo
        do j=ny-npad+1,ny
        do i = 1,nx
          xout(i,j) = 0.0_dbl_kind
        enddo
        enddo
        do i=1,npad
        do j=1,ny
          xout(i,j) = 0.0_dbl_kind
        enddo
        enddo
        do i=nx-npad+1,nx
        do j=1,ny
          xout(i,j) = 0.0_dbl_kind
        enddo
        enddo

!----------------------------------------------------------------------------
! COMPUTE DIVERGENCE AT INTERIOR POINTS
!----------------------------------------------------------------------------
        do j=npad+1,ny-npad
        do i=npad+1,nx-npad

        xout(i,j) =                           &
                   ( + xin(1,i  ,j  )         &
                     + xin(2,i  ,j  )         &
                     + xin(3,i  ,j  )         &
                     - xin(1,i+1,j  )         &
                     - xin(2,i+1,j+1)         &
                     - xin(3,i  ,j+1) )       &
                     * area_inv(i,j)

        enddo           ! do i
        enddo           ! do j

!----------------------------------------------------------------------------
! COMPUTE DIVERGENCE AT NORTH AND SOUTH POLE
! edge 1 does not exist for NP, edge 3 does not exist for SP
!----------------------------------------------------------------------------
        i = 1
        j = ny-1
        xout(i,j) =                           &
                   (                          &
                     - xin(2,i  ,j  )         &
                     - xin(3,i  ,j  )         &
                     - xin(1,i+1,j  )         &
                     - xin(2,i+1,j+1)         &
                     - xin(3,i  ,j+1) )       &
                     * area_inv(i,j)

        i = nx-1
        j = 1
        xout(i,j) =                           &
                   ( - xin(1,i  ,j  )         &
                     - xin(2,i  ,j  )         &
                     - xin(1,i+1,j  )         &
                     - xin(2,i+1,j+1)         &
                     - xin(3,i  ,j+1) )       &
                     * area_inv(i,j)

        end subroutine div_of_an_edge_flux
!======================================================================
! END DIV_OF_AN_EDGE_FLUX
!======================================================================



!======================================================================
! BEGINNING OF LAPLACIAN_OF_A_SCALAR
!======================================================================
        subroutine laplacian_of_a_scalar(                              &
                npad,                                                  &
                nx,                                                    &
                ny,                                                    &
                nweights,                                              &
                l_weights,                                             &
                xin,                                                   &
                xout)

!-----------------------------------------------------------------------
! PURPOSE : given a scalar defined at cell centers, computed the Laplacian
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!       npad      : width of 'ghost cell' region
!       nx        : first dimension of xin (integer)
!       ny        : second dimension of xin (integer)
!       nweights  : amount of data incorporated in Laplacian operator
!       area_inv  : inverse of grid cell area (m^-2)
!       v_weights : weights to compute Laplacian (m^-2)
!       xin       : scalar (x)
!       xout      : Laplacian of xin (x*m^-2)
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        integer (kind=int_kind), intent(in) ::                           &
                        npad, nx, ny, nweights            

        real (kind=dbl_kind), intent(in) ::                              &
                        l_weights      (nweights,nx,ny),                 &
                        xin                     (nx,ny)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                             &
                        xout                    (nx,ny)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j

!----------------------------------------------------------------------------
! INITIALIZE parts of xout that are not filled by the Laplacian operator
!----------------------------------------------------------------------------
        do j = 1,npad
        do i = 1,nx
          xout(i,j) = 0.0_dbl_kind
        enddo
        enddo
        do j=ny-npad+1,ny
        do i = 1,nx
          xout(i,j) = 0.0_dbl_kind
        enddo
        enddo
        do i=1,npad
        do j=1,ny
          xout(i,j) = 0.0_dbl_kind
        enddo
        enddo
        do i=nx-npad+1,nx
        do j=1,ny
          xout(i,j) = 0.0_dbl_kind
        enddo
        enddo

!----------------------------------------------------------------------------
! COMPUTE LAPLACIAN AT INTERIOR POINTS
!----------------------------------------------------------------------------
        do j=npad+1,ny-npad
        do i=npad+1,nx-npad

          xout(i,j) =                                                &
                         + l_weights( 7, i, j) * xin(i  ,j  )        &
                         + l_weights( 1, i, j) * xin(i-1,j  )        &
                         + l_weights( 2, i, j) * xin(i-1,j-1)        &
                         + l_weights( 3, i, j) * xin(i  ,j-1)        &
                         + l_weights( 4, i, j) * xin(i+1,j  )        &
                         + l_weights( 5, i, j) * xin(i+1,j+1)        &
                         + l_weights( 6, i, j) * xin(i  ,j+1) 

        enddo           ! do i
        enddo           ! do j

!----------------------------------------------------------------------------
! COMPUTE LAPLACIAN AT NORTH POLE (position 1 does not exist)
!----------------------------------------------------------------------------
        i = 1
        j = ny-1
        xout(i,j) =                                                  &
                         + l_weights( 7, i, j) * xin(i  ,j  )        &
                         + l_weights( 2, i, j) * xin(nx ,1  )        &
                         + l_weights( 3, i, j) * xin(i  ,j-1)        &
                         + l_weights( 4, i, j) * xin(i+1,j  )        &
                         + l_weights( 5, i, j) * xin(i+1,j+1)        &
                         + l_weights( 6, i, j) * xin(i  ,j+1)

!----------------------------------------------------------------------------
! COMPUTE LAPLACIAN AT SOUTH POLE (position 3 does not exist)
!----------------------------------------------------------------------------
        i = nx-1
        j = 1
        xout(i,j) =                                                  &
                         + l_weights( 7, i, j) * xin(i  ,j  )        &
                         + l_weights( 1, i, j) * xin(i-1,j  )        &
                         + l_weights( 2, i, j) * xin(1  ,ny )        &
                         + l_weights( 4, i, j) * xin(i+1,j  )        &
                         + l_weights( 5, i, j) * xin(i+1,j+1)        &
                         + l_weights( 6, i, j) * xin(i  ,j+1)         

        end subroutine laplacian_of_a_scalar
!======================================================================
! END OF LAPLACIAN_OF_A_SCALAR
!======================================================================



!======================================================================
! BEGIN K_CROSS_V
!======================================================================
        subroutine k_cross_v(                                        &
                nx,                                                  &
                ny,                                                  &
                nspace,                                              &
                ncorners,                                            &
                xin,                                                 &
                xout )

!-----------------------------------------------------------------------
! PURPOSE : take the k vector and cross it with xin
! NOTE : assumes an orthogonal (and right-handed) coordinate system
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!       nx        : first dimension of xin (integer)
!       ny        : second dimension of xin (integer)
!       nspace    : number of spatial dimensions (integer)
!       ncorners  : number of corners (integer)
!       xin       : a vector defined at cell corners
!       xout      : k cross xin
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        integer (kind=int_kind), intent(in) ::                       &
                        nx, ny, nspace, ncorners

        real (kind=dbl_kind),  intent(in) ::                         &
                        xin      (nspace,ncorners,nx,ny)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind),  intent(out) ::                        & 
                        xout     (nspace,ncorners,nx,ny)

        integer (kind=int_kind) :: i,j,icorner

!----------------------------------------------------------------------------
! COMPUTE the CROSS PRODUCT
!----------------------------------------------------------------------------
        do j=1,ny
        do i=1,nx
        do icorner=1,ncorners
          xout(1,icorner,i,j) = -xin(2,icorner,i,j)
          xout(2,icorner,i,j) = +xin(1,icorner,i,j)
        enddo
        enddo
        enddo

        end subroutine k_cross_v
!======================================================================
! END K_CROSS_V
!=====================================================================



!======================================================================
! BEGIN GRADIENT
!======================================================================
        subroutine gradient(                                          &
                npad,                                                 &
                nx,                                                   &
                ny,                                                   &
                ndata,                                                &
                nspace,                                               &
                ncorners,                                             &
                corner_area_inv,                                      &
                v_weights,                                            &
                xin,                                                  &
                xout)

!-----------------------------------------------------------------------
! PURPOSE : take the gradient of a scalar fields
!       gradient is defined at corners
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!       npad      : width of 'ghost cell' region
!       nx        : first dimension of xin (integer)
!       ny        : second dimension of xin (integer)
!       ndata     : amount of data involved in curl operator
!       nspace    : number of spatial dimensions
!       ncorners  : number of corners
!       area_inv  : inverse of grid cell area (m^-2)
!       v_weights : weights to compute gradient (m)
!       xin       : scalar field defined at cell center
!       xout      : gradient of scalar field defined at corners
!
! NOTE : xin is a scalar, xout is a vector
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        integer (kind=int_kind), intent(in) ::                          &
                        npad, nx, ny, ndata, nspace, ncorners

        real (kind=dbl_kind), intent(in) ::                             &
                        corner_area_inv        (ncorners,nx,ny),        &
                        v_weights (ndata,nspace,ncorners,nx,ny),        &
                        xin                             (nx,ny)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                            &
                        xout            (nspace,ncorners,nx,ny)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j,k,ispace

!----------------------------------------------------------------------------
! INITIALIZE parts of xout that are not filled by the gradient operator
!----------------------------------------------------------------------------
!       xout(:,:,:,1:npad) = 0.0_dbl_kind
!       xout(:,:,:,ny-npad+1:ny) = 0.0_dbl_kind
!       xout(:,:,1:npad,:) = 0.0_dbl_kind
!       xout(:,:,nx-npad+1:nx,:) = 0.0_dbl_kind
        xout = 0.0_dbl_kind

!----------------------------------------------------------------------------
! COMPUTE GRADIENT
!   gradient is computed for corners 1 and 2 for each interior cell
!----------------------------------------------------------------------------
        do j=npad+1,ny-npad
        do i=npad+1,nx-npad
        do ispace=1,nspace

          xout(ispace,1,i,j) =                                         &
            ( + v_weights(1,ispace,1,i,j) * xin(i  ,j  )               &
              + v_weights(2,ispace,1,i,j) * xin(i-1,j  )               &
              + v_weights(3,ispace,1,i,j) * xin(i-1,j-1) )             &
                 * corner_area_inv(1,i,j)       

          xout(ispace,2,i,j) =                                         &
            ( + v_weights(1,ispace,2,i,j) * xin(i  ,j  )               &
              + v_weights(2,ispace,2,i,j) * xin(i-1,j-1)               &
              + v_weights(3,ispace,2,i,j) * xin(i  ,j-1) )             &
                 * corner_area_inv(2,i,j)

        enddo
        enddo
        enddo

       end subroutine gradient
!======================================================================
! END GRADIENT
!======================================================================


!======================================================================
! BEGIN GRADIENT_AT_CELL_CENTERS
!======================================================================
      subroutine gradient_at_cell_centers(                            &
                npad,                                                 &
                nx,                                                   &
                ny,                                                   &
                nspace,                                               &
                nhexvert,                                             &
                garea_inv,                                            &
                gwgt,                                                 &
                xin,                                                  &
                xout,                                                 &
                yout)

!-----------------------------------------------------------------------
! PURPOSE : Take the gradient of a scalar field.
!           Gradient is defined at cell center.
!-----------------------------------------------------------------------

      implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!       npad      : width of 'ghost cell' region
!       nx        : first dimension of xin (integer)
!       ny        : second dimension of xin (integer)
!       nspace    : number of spatial dimensions
!       nhexvert  ! number of vertices (and edges) of a hexagon
!       garea_inv : inverse of area associated with line integral (m^-2)
!       gwgt      : outward normal vectors weighted by edge lengths (m)
!       xin       : scalar field defined at cell center
!       xout      : x gradient of scalar field defined at cell center
!       yout      : y gradient of scalar field defined at cell center
!
! NOTE : xin is a scalar, xout is a vector
!
! NOTE: See init_remap subroutine of remapping.F for computation of gwgt
!       and garea_inv.  Calling 'gradient_at_cell_centers' gives the same 
!       result (more efficiently) as calling 'gradient' at each of six 
!       vertices and averaging.
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
! INTENT IN
!-----------------------------------------------------------------------
      integer (kind=int_kind), intent(in) ::                          &
                        npad, nx, ny, nspace, nhexvert

      real (kind=dbl_kind), intent(in) ::                             &
                        garea_inv               (nx,ny),              &
                        gwgt  (nspace,0:nhexvert,nx,ny),              &
                        xin                     (nx,ny)

!-----------------------------------------------------------------------
! INTENT OUT
!-----------------------------------------------------------------------
      real (kind=dbl_kind), intent(out), dimension(nx,ny) ::          &
                        xout, yout

!-----------------------------------------------------------------------
! LOCAL
!-----------------------------------------------------------------------
      integer (kind=int_kind) :: i,j

!-----------------------------------------------------------------------
! COMPUTE GRADIENT
!-----------------------------------------------------------------------

      xout(:,:) = 0.0_dbl_kind
      yout(:,:) = 0.0_dbl_kind
!-----------------------------------------------------------------------
! interior cells
!-----------------------------------------------------------------------

      do j=npad+1,ny-npad
      do i=npad+1,nx-npad

         xout(i,j) = (xin(i  ,j  ) * gwgt(1,0,i,j)   &
                    + xin(i-1,j  ) * gwgt(1,1,i,j)   &
                    + xin(i-1,j-1) * gwgt(1,2,i,j)   &
                    + xin(i  ,j-1) * gwgt(1,3,i,j)   &
                    + xin(i+1,j  ) * gwgt(1,4,i,j)   &
                    + xin(i+1,j+1) * gwgt(1,5,i,j)   &
                    + xin(i  ,j+1) * gwgt(1,6,i,j) ) &
                    * garea_inv(i,j)

         yout(i,j) = (xin(i  ,j  ) * gwgt(2,0,i,j)   &
                    + xin(i-1,j  ) * gwgt(2,1,i,j)   &
                    + xin(i-1,j-1) * gwgt(2,2,i,j)   &
                    + xin(i  ,j-1) * gwgt(2,3,i,j)   &
                    + xin(i+1,j  ) * gwgt(2,4,i,j)   &
                    + xin(i+1,j+1) * gwgt(2,5,i,j)   &
                    + xin(i  ,j+1) * gwgt(2,6,i,j) ) &
                    * garea_inv(i,j)

      enddo
      enddo

!-----------------------------------------------------------------------
! North Pole
! Segment 1 is missing, and (i-1,j-1) data is stored in (nx,1) slot
!-----------------------------------------------------------------------

      i = 1
      j = ny-1

      xout(i,j)    = (xin(i  ,j  ) * gwgt(1,0,i,j)   &
                    + xin(nx ,  1) * gwgt(1,2,i,j)   &
                    + xin(i  ,j-1) * gwgt(1,3,i,j)   &
                    + xin(i+1,j  ) * gwgt(1,4,i,j)   &
                    + xin(i+1,j+1) * gwgt(1,5,i,j)   &
                    + xin(i  ,j+1) * gwgt(1,6,i,j) ) &
                    * garea_inv(i,j)

      yout(i,j)    = (xin(i  ,j  ) * gwgt(2,0,i,j)   &
                    + xin(nx ,  1) * gwgt(2,2,i,j)   &
                    + xin(i  ,j-1) * gwgt(2,3,i,j)   &
                    + xin(i+1,j  ) * gwgt(2,4,i,j)   &
                    + xin(i+1,j+1) * gwgt(2,5,i,j)   &
                    + xin(i  ,j+1) * gwgt(2,6,i,j) ) &
                    * garea_inv(i,j)

!-----------------------------------------------------------------------
! South Pole
! Segment 3 is missing, and (i-1,j-1) data is stored in (1,ny) slot
!-----------------------------------------------------------------------
     
      i = nx-1
      j = 1
                       
      xout(i,j)    = (xin(i  ,j  ) * gwgt(1,0,i,j)   &
                    + xin(i-1,j  ) * gwgt(1,1,i,j)   &
                    + xin(1  ,ny ) * gwgt(1,2,i,j)   &
                    + xin(i+1,j  ) * gwgt(1,4,i,j)   &
                    + xin(i+1,j+1) * gwgt(1,5,i,j)   &
                    + xin(i  ,j+1) * gwgt(1,6,i,j) ) &
                    * garea_inv(i,j)

      yout(i,j)    = (xin(i  ,j  ) * gwgt(2,0,i,j)   &
                    + xin(i-1,j  ) * gwgt(2,1,i,j)   &
                    + xin(1  , ny) * gwgt(2,2,i,j)   &
                    + xin(i+1,j  ) * gwgt(2,4,i,j)   &
                    + xin(i+1,j+1) * gwgt(2,5,i,j)   &
                    + xin(i  ,j+1) * gwgt(2,6,i,j) ) &
                    * garea_inv(i,j)

      end subroutine gradient_at_cell_centers
!=======================================================================
! END GRADIENT_AT_CELL_CENTERS
!=======================================================================

!======================================================================
! BEGIN AVERAGE_VECTOR_TO_CENTERS
!======================================================================
        subroutine average_vector_to_centers(                         &
                npad,                                                 &
                nx,                                                   &
                ny,                                                   &
                nspace,                                               &
                r3,                                                   &    
                ncorners,                                             &
                ndata,                                                &
                area_inv,                                             &    
                sub_area,                                             &    
                trans_to_X1,                                          &    
                xin,                                                  &    
                xout)   

!-----------------------------------------------------------------------
! PURPOSE : given vector data defined at cell corners, average that data
! to the cell centers. The averaging is sub_area weighted to make sure
! that dead corners are masked out in the averaging.
!
! NOTE: since this averaged velocity will be transformed into numerous
! coordinate systems, the xout is left in the global (x,y,z) system.
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        integer (kind=int_kind), intent(in) ::                             &
                        npad, nx, ny, ndata, nspace, ncorners,r3

        real (kind=dbl_kind), intent(in) ::                                &
                        area_inv                        (nx,ny),           &
                        sub_area        (ndata ,ncorners,nx,ny),           &
                        trans_to_X1      (r3,r3,ncorners,nx,ny),           &
                        xin             (nspace,ncorners,nx,ny)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                               &
                        xout                         (r3,nx,ny)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j
        real (kind=dbl_kind) :: h(6,r3), r(6,r3)

        xout = 0.0_dbl_kind
        do j=1,ny-1
        do i=1,nx-1
          h = 0.0_dbl_kind
          r = 0.0_dbl_kind
          h(1,1:2) = xin(1:2,1,i  ,j  )*sub_area(1,1,i  ,j  )
          h(2,1:2) = xin(1:2,2,i  ,j  )*sub_area(1,2,i  ,j  )
          h(3,1:2) = xin(1:2,1,i+1,j  )*sub_area(2,1,i+1,j  )
          h(4,1:2) = xin(1:2,2,i+1,j+1)*sub_area(2,2,i+1,j+1)
          h(5,1:2) = xin(1:2,1,i+1,j+1)*sub_area(3,1,i+1,j+1)
          h(6,1:2) = xin(1:2,2,i  ,j+1)*sub_area(3,2,i  ,j+1)
          h = h * area_inv(i,j)
          r(1,:) = matmul(trans_to_X1(:,:,1,i  ,j  ),h(1,:))
          r(2,:) = matmul(trans_to_X1(:,:,2,i  ,j  ),h(2,:))
          r(3,:) = matmul(trans_to_X1(:,:,1,i+1,j  ),h(3,:))
          r(4,:) = matmul(trans_to_X1(:,:,2,i+1,j+1),h(4,:))
          r(5,:) = matmul(trans_to_X1(:,:,1,i+1,j+1),h(5,:))
          r(6,:) = matmul(trans_to_X1(:,:,2,i  ,j+1),h(6,:))
          xout(:,i,j) = r(1,:)+r(2,:)+r(3,:)+r(4,:)+r(5,:)+r(6,:)
        enddo
        enddo

        end subroutine average_vector_to_centers
!======================================================================
! END AVERAGE_VECTOR_TO_CENTERS
!======================================================================


!======================================================================
! BEGIN AVERAGE_SCALAR_TO_CENTERS
!======================================================================
        subroutine average_scalar_to_centers(                         &
                npad,                                                 &
                nx,                                                   &
                ny,                                                   &
                ncorners,                                             &
                ndata,                                                &
                area_inv,                                             &    
                sub_area,                                             &    
                xin,                                                  &    
                xout)   

!-----------------------------------------------------------------------
! PURPOSE : given scalar data defined at cell corners, average that data
! to the cell centers. The averaging is sub_area weighted to make sure
! that dead corners are masked out in the averaging.
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        integer (kind=int_kind), intent(in) ::                             &
                        npad, nx, ny, ndata, ncorners

        real (kind=dbl_kind), intent(in) ::                                &
                        area_inv                        (nx,ny),           &
                        sub_area        (ndata ,ncorners,nx,ny),           &
                        xin             (ncorners,nx,ny)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                               &
                        xout                         (nx,ny)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j

        xout = 0.0_dbl_kind
        do j=1,ny-1
        do i=1,nx-1
          xout(i,j) = xout(i,j) + xin(1,i  ,j  )*sub_area(1,1,i  ,j  )
          xout(i,j) = xout(i,j) + xin(2,i  ,j  )*sub_area(1,2,i  ,j  )
          xout(i,j) = xout(i,j) + xin(1,i+1,j  )*sub_area(2,1,i+1,j  )
          xout(i,j) = xout(i,j) + xin(2,i+1,j+1)*sub_area(2,2,i+1,j+1)
          xout(i,j) = xout(i,j) + xin(1,i+1,j+1)*sub_area(3,1,i+1,j+1)
          xout(i,j) = xout(i,j) + xin(2,i  ,j+1)*sub_area(3,2,i  ,j+1)
          xout(i,j) = xout(i,j)*area_inv(i,j)
        enddo
        enddo

        end subroutine average_scalar_to_centers
!======================================================================
! END AVERAGE_SCALAR_TO_CENTERS
!======================================================================


!======================================================================
! BEGIN AVERAGE_TO_CELL_CORNERS
!======================================================================
        subroutine average_to_cell_corners(                           &
                npad,                                                 &
                nx,                                                   &
                ny,                                                   &
                ndata,                                                &
                ncorners,                                             &
                s_weights,                                            &
                xin,                                                  &
                xout,flag,                                            &
                min_value)

!-----------------------------------------------------------------------
! PURPOSE : average scalar quanties from cell centers to cell corners
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!       npad            : width of 'ghost cell' region
!       nx              : first dimension of xin (integer)
!       ny              : second dimension of xin (integer)
!       ndata           : amount of data involved in the averaging operator
!       ncorners        : number of corners
!       s_weights       : weights
!       xin             : scalar field defined at cell center
!       xout            : scalar field averaged to cell corners
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        integer (kind=int_kind), intent(in) ::                          &
                        npad, nx, ny, ndata, ncorners

        real (kind=dbl_kind), intent(in) ::                             &
                        s_weights  (ndata,ncorners,nx,ny),              &
                        xin                       (nx,ny)

        logical flag
        logical,optional :: min_value

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                           &
                        xout             (ncorners,nx,ny)              

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j
        real (kind=dbl_kind) :: factor=0.3333333_dbl_kind
        real (kind=dbl_kind) :: fill_value

!----------------------------------------------------------------------------
! INITIALIZE the ghost cells
!----------------------------------------------------------------------------
        fill_value = xin(npad+1,npad+1)
        do j = 1,npad
        do i = 1,nx
          xout(:,i,j) = fill_value
        enddo
        enddo
        do j=ny-npad,ny
        do i = 1,nx
          xout(:,i,j) = fill_value
        enddo
        enddo
        do i=1,npad
        do j=1,ny
          xout(:,i,j) = fill_value
        enddo
        enddo
        do i=nx-npad,nx
        do j=1,ny
          xout(:,i,j) = fill_value
        enddo
        enddo

!----------------------------------------------------------------------------
! AVERAGE TO CELL CORNERS
!----------------------------------------------------------------------------
        if (present (min_value)) then
           if (min_value) then

              do j=npad+1,ny-npad
                 do i=npad+1,nx-npad

         xout(1,i,j) = MINVAL ((/ s_weights(1,1,i,j) * xin(i  ,j  ),       &
                                  s_weights(2,1,i,j) * xin(i-1,j  ),       &
                                  s_weights(3,1,i,j) * xin(i-1,j-1) /))
         xout(2,i,j) = MINVAL ((/ s_weights(1,2,i,j) * xin(i  ,j  ),       &
                                  s_weights(2,2,i,j) * xin(i-1,j-1),       &
                                  s_weights(3,2,i,j) * xin(i  ,j-1) /))
                 enddo
              enddo
           endif
        else

        do j=npad+1,ny-npad
        do i=npad+1,nx-npad

        if(flag) then
          xout(1,i,j) =                                                 &
              + s_weights(1,1,i,j) * xin(i  ,j  )                       &
              + s_weights(2,1,i,j) * xin(i-1,j  )                       &
              + s_weights(3,1,i,j) * xin(i-1,j-1)                       

         xout(2,i,j) =                                                  &
              + s_weights(1,2,i,j) * xin(i  ,j  )                       &
              + s_weights(2,2,i,j) * xin(i-1,j-1)                       &
              + s_weights(3,2,i,j) * xin(i  ,j-1)
        else
          xout(1,i,j) =                                                 &
              + factor * xin(i  ,j  )                       &
              + factor * xin(i-1,j  )                       &
              + factor * xin(i-1,j-1)

         xout(2,i,j) =                                                  &
              + factor * xin(i  ,j  )                       &
              + factor * xin(i-1,j-1)                       &
              + factor * xin(i  ,j-1)
        endif

        enddo           ! do i
        enddo           ! do j
        endif


        end subroutine average_to_cell_corners
!======================================================================
! END AVERAGE_TO_CELL_CORNERS
!======================================================================





!======================================================================
! BEGIN AVERAGE_TO_CELL_CORNERS_UP
!======================================================================
        subroutine average_to_cell_corners_up(                        &
                npad,                                                 &
                nx,                                                   &
                ny,                                                   &
                ndata,                                                &
                nspace,                                               &
                ncorners,                                             &
                normal,                                               &
                u,                                                    &
                xin,                                                  & 
                xout,flag)

!-----------------------------------------------------------------------
! PURPOSE : average scalar quanties from cell centers to cell corners
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!       npad            : width of 'ghost cell' region
!       nx              : first dimension of xin (integer)
!       ny              : second dimension of xin (integer)
!       ndata           : amount of data involved in the averaging operator
!       ncorners        : number of corners
!       s_weights       : weights
!       xin             : scalar field defined at cell center
!       xout            : scalar field averaged to cell corners
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        integer (kind=int_kind), intent(in) ::                          &
                        npad, nx, ny, ndata, nspace, ncorners

        real (kind=dbl_kind), intent(in) ::                             &
                        u          (      nspace,ncorners,nx,ny),       &
                        normal     (ndata,nspace,ncorners,nx,ny),       &
                        xin                              (nx,ny)

        logical flag

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                           &
                        xout             (ncorners,nx,ny)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j,icorner,ispace,ii,jj
        integer (kind=int_kind), dimension(1) :: k
        real (kind=dbl_kind) :: t(3)
        real (kind=dbl_kind) :: fill_value

!----------------------------------------------------------------------------
! INITIALIZE the ghost cells
!----------------------------------------------------------------------------
        fill_value = xin(npad+1,npad+1)
        do j = 1,npad
        do i = 1,nx
          xout(:,i,j) = fill_value
        enddo
        enddo
        do j=ny-npad,ny
        do i = 1,nx
          xout(:,i,j) = fill_value
        enddo
        enddo
        do i=1,npad
        do j=1,ny
          xout(:,i,j) = fill_value
        enddo
        enddo
        do i=nx-npad,nx
        do j=1,ny
          xout(:,i,j) = fill_value
        enddo
        enddo

!----------------------------------------------------------------------------
! AVERAGE TO CELL CORNERS
!----------------------------------------------------------------------------
        do j=npad+1,ny-npad
        do i=npad+1,nx-npad
        do icorner=1,ncorners

          t = 0
          do ispace=1,nspace
          t(1) = t(1) + normal(1,ispace,icorner,i,j) * u(ispace,icorner,i,j)
          t(2) = t(2) + normal(2,ispace,icorner,i,j) * u(ispace,icorner,i,j)
          t(3) = t(3) + normal(3,ispace,icorner,i,j) * u(ispace,icorner,i,j)
	  enddo

          k(:) = minloc(t(:))
          if(k(1)==1) then
             ii=i; jj=j
          endif
	  if(k(1)==2) then
             if(icorner==1) then
               ii=i-1; jj=j
             else
               ii=i-1; jj=j-1
             endif
	  endif
          if(k(1)==3) then
             if(icorner==1) then
               ii=i-1; jj=j-1
             else
               ii=i; jj=j-1
             endif
          endif

           xout(icorner,i,j) = xin(ii,jj)

	enddo
	enddo
	enddo

        end subroutine average_to_cell_corners_up
!======================================================================
! END AVERAGE_TO_CELL_CORNERS_UP
!======================================================================



!======================================================================
! BEGIN CALCULATE_CORNER_KINETIC_ENERGY
!======================================================================
        subroutine calculate_corner_kinetic_energy(                   &
                npad,                                                 &
                nx,                                                   &
                ny,                                                   &
                ndata,                                                &
                nspace,                                               &
                ncorners,                                             &
                u,                                                    &
                ke_c  )

!-----------------------------------------------------------------------
! PURPOSE : compute kinetic energy at cell corners
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        integer (kind=int_kind), intent(in) ::                              &
                        npad, nx, ny, ndata, nspace, ncorners

        real (kind=dbl_kind), intent(in) ::                                 &
                        u                             (nspace,ncorners,nx,ny)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                                &
                        ke_c                                (ncorners,nx,ny)
!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        real (kind=dbl_kind), parameter :: factor=0.5_dbl_kind
        integer (kind=int_kind) :: i,j,k,icorner


!----------------------------------------------------------------------------
! initialize
!----------------------------------------------------------------------------
        ke_c(:,:,:) = 0.0_dbl_kind

!----------------------------------------------------------------------------
! compute kinetic energy at each interior cell center
!----------------------------------------------------------------------------
        do j=npad+1,ny-npad
        do i=npad+1,nx-npad
        do icorner=1,ncorners
          ke_c(icorner,i,j) = factor * (u(1,icorner,i,j)*u(1,icorner,i,j)   &
                                      + u(2,icorner,i,j)*u(2,icorner,i,j))
        enddo
        enddo
        enddo

        end subroutine calculate_corner_kinetic_energy
!======================================================================
! BEGIN CALCULATE_CORNER_KINETIC_ENERGY
!======================================================================


!======================================================================
! BEGIN CALCULATE_CENTER_KINETIC_ENERGY
!======================================================================
        subroutine calculate_center_kinetic_energy(                   &
                npad,                                                 &
                nx,                                                   &
                ny,                                                   &
                ndata,                                                &
                nspace,                                               &
                ncorners,                                             &
                sub_area,                                             &
                area_inv,                                             &
                ke_c,                                                 &
                ke)

!-----------------------------------------------------------------------
! PURPOSE : compute kinetic energy at cell corners and cell centers
!
! NOTE : IMPORTANT : ke_c must be wrapped before calling this subroutine
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!       nx              : first dimension of xin (integer)
!       ny              : second dimension of xin (integer)
!       ndata           : amount of data involved in the averaging operator
!       nspace          : number of spatial dimenions
!       ncorners        : number of corners
!       sub_area        : partial corner areas "owned" by cell centers
!       ke              : u dot u, averaged to cell center
!       ke_c            : u dot u, at cell corner
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        integer (kind=int_kind), intent(in) ::                              &
                        npad, nx, ny, ndata, nspace, ncorners

        real (kind=dbl_kind), intent(in) ::                                    &
                        sub_area                (ndata,       ncorners,nx,ny), &
                        area_inv                                      (nx,ny), &
                        ke_c                                 (ncorners,nx,ny)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                                   &
                        ke                                           (nx,ny)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j,k,icorner

!----------------------------------------------------------------------------
! initialize
!----------------------------------------------------------------------------
        ke(:,:) = 0.0_dbl_kind

!----------------------------------------------------------------------------
! sum over the corners to get KE at cell center
!----------------------------------------------------------------------------
        do j=1,ny-npad
        do i=1,nx-npad

          ke(i,j) =                                                        &
                    ( + sub_area(1,1,i  ,j  ) * ke_c(1,i  ,j  )            &
                      + sub_area(1,2,i  ,j  ) * ke_c(2,i  ,j  )            &
                      + sub_area(2,1,i+1,j  ) * ke_c(1,i+1,j  )            &
                      + sub_area(2,2,i+1,j+1) * ke_c(2,i+1,j+1)            &
                      + sub_area(3,1,i+1,j+1) * ke_c(1,i+1,j+1)            &
                      + sub_area(3,2,i  ,j+1) * ke_c(2,i  ,j+1) )          &
                      * area_inv(i,j)

        enddo
        enddo

        end subroutine calculate_center_kinetic_energy
!======================================================================
! END CALCULATE_CENTER_KINETIC_ENERGY
!======================================================================


!======================================================================
! BEGIN CALCULATE_VELOCITY
!======================================================================
        subroutine calculate_velocity(                                &
                npad,                                                 &
                nx,                                                   &
                ny,                                                   &
                ndata,                                                &
                nspace,                                               &
                ncorners,                                             &
                corner_area_inv,                                      &
                v_weights,                                            &
                psi,                                                  &
                chi,                                                  &
                xout )

!-----------------------------------------------------------------------
! PURPOSE : given the stream function and velocity potential, compute
!       the velocity. psi and chi are defined at cell center, u at corners
! NOTE : it is assumed that psi and chi have been wrapped before
!       calling this subroutine.
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!       nx              : first dimension of xin (integer)
!       ny              : second dimension of xin (integer)
!       ndata           : amount of data involved in curl operator
!       nspace          : number of spatial dimensions
!       ncorners        : number of corners
!       corner_area_inv : inverse of grid cell area (m^-2)
!       v_weights       : weights to compute gradient (m)
!       psi             : streamfunction (m2/s)
!       chi             : velocity potential (m2/s)
!       xout            : velocity vector (m/s)
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        integer (kind=int_kind), intent(in) ::                          &
                        npad, nx, ny, ndata, nspace, ncorners

        real (kind=dbl_kind), intent(in) ::                             &
                        corner_area_inv        (ncorners,nx,ny),        &
                        v_weights (ndata,nspace,ncorners,nx,ny),        &
                        psi                             (nx,ny),        &
                        chi                             (nx,ny)         

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(inout) ::                          &
                        xout               (nspace,ncorners,nx,ny)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        real (kind = dbl_kind) ::                                       &
                        work1           (nspace,ncorners,nx,ny),        &
                        work2           (nspace,ncorners,nx,ny)

        integer (kind=int_kind) :: i,j,k,ispace,icorner

!----------------------------------------------------------------------------
! FIND GRADIENT OF PSI AND CHI
!----------------------------------------------------------------------------
        call gradient(                  &
                npad,                   &
                nx,                     &
                ny,                     &
                ndata,                  &
                nspace,                 &
                ncorners,               &
                corner_area_inv,        &
                v_weights,              &
                chi,                    &
                xout )        

        call gradient(                  &
                npad,                   &
                nx,                     &
                ny,                     &
                ndata,                  &
                nspace,                 &
                ncorners,               &
                corner_area_inv,        &
                v_weights,              &
                psi,                    &
                work1 )

        call k_cross_v(                 &
                nx,                     &
                ny,                     &
                nspace,                 &
                ncorners,               &
                work1,                  &
                work2 )

!----------------------------------------------------------------------------
! COMPUTE VELOCITY
!----------------------------------------------------------------------------
        do j=1,ny
        do i=1,nx
        do icorner=1,ncorners
        do ispace = 1,nspace
          xout(ispace,icorner,i,j) =    xout(ispace,icorner,i,j)        &
                                     + work2(ispace,icorner,i,j)
        enddo
        enddo
        enddo
        enddo

        end subroutine calculate_velocity
!======================================================================
! END CALCULATE_VELOCITY
!======================================================================



!======================================================================
! BEGIN AVERAGE_PV_TO_CELL_CORNERS
!======================================================================
        subroutine average_pv_to_cell_corners(                        &
                npad,                                                 &
                nx,                                                   &
                ny,                                                   &
                ncorners,                                             &
                nspace,                                               &
                ndata,                                                &
                xin,                                                  &
                h,                                                    &
                inv_h,                                                &
                h_c,                                                  &
                v_weights,                                            &
                u,                                                    &
                xout )

!-----------------------------------------------------------------------
! PURPOSE : average absolute vorticity from cell centers to cell corners
!       form should conserve potential enstrophy under the process of
!       horizontal advection
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!       nx              : first dimension of xin (integer)
!       ny              : second dimension of xin (integer)
!       ncorners        : number of corners
!       h               : mass field
!       inv_h           : inverse of mass field
!       xin             : vorticity field defined at cell center
!       xout            : vorticity field averaged to cell corners
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        integer (kind=int_kind), intent(in) ::                        &
                        npad, nx, ny, ncorners, nspace, ndata

        real (kind=dbl_kind), intent(in) ::                           &
                        h                                  (nx,ny),   &
                        h_c                       (ncorners,nx,ny),   &
                        inv_h                              (nx,ny),   &
                        v_weights    (ndata,nspace,ncorners,nx,ny),   &
                        u                  (nspace,ncorners,nx,ny),   &
                        xin                                (nx,ny)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                          &
                        xout            (ncorners,nx,ny)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        real (kind=dbl_kind) ::                                       &
                        pv                       (nx,ny)

        real (kind=dbl_kind)  ::                                            &
                        t1(nspace), t2(nspace), r1, r2, t3(nspace),         &
                        w0, w1, w2, x, y, z, m, r(ndata,nspace), s(nspace), &
                        t(ndata), factor

        integer (kind=int_kind) :: i,j,icorner,ispace,idata


!----------------------------------------------------------------------------
! INITIALIZE parts of array that are not filled
!----------------------------------------------------------------------------
        xout = 0.0_dbl_kind
        factor = 1.0_dbl_kind/9.0_dbl_kind

!----------------------------------------------------------------------------
! compute potential vorticity
!----------------------------------------------------------------------------
        pv = xin*inv_h

!----------------------------------------------------------------------------
! average to cell corners for all interior points
!----------------------------------------------------------------------------
        do j=npad+1,ny-npad
        do i=npad+1,nx-npad
        xout(1,i,j) = factor *                                        &
                (  h(i  ,j  )  +  h(i-1,j  )  +  h(i-1,j-1) )         &
              * ( pv(i  ,j  )  + pv(i-1,j  )  + pv(i-1,j-1) )
        xout(2,i,j) = factor *                                        &
                (  h(i  ,j  )  +  h(i-1,j-1)  +  h(i  ,j-1) )         &
              * ( pv(i  ,j  )  + pv(i-1,j-1)  + pv(i  ,j-1) )
        enddo
        enddo

        end subroutine average_pv_to_cell_corners
!======================================================================
! END AVERAGE_PV_TO_CELL_CORNERS
!======================================================================


!======================================================================
! BEGIN CENTERED_MASS_FLUX
!======================================================================
        subroutine centered_mass_flux(                                &
                npad,                                                 &
                nx,                                                   &
                ny,                                                   &
                ndata,                                                &
                ncorners,                                             &
                nedges,                                               &
                nspace,                                               &
                r3,                                                   &
                dc,                                                   &
                normal,                                               &
                mass_c,                                               &
                u,                                                    &
                mass,                                                 &
                flux)

!-----------------------------------------------------------------------
! PURPOSE : compute mass flux based on the mass_c values
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!       npad            : width of 'ghost cell' region
!       nx              : first dimension of xin (integer)
!       ny              : second dimension of xin (integer)
!       ndata           : amount of data involved in the averaging operator
!       ncorners        : number of corners
!       mass_c          : thickness fields averaged to cell corners (must be wrapped)
!       mass            : mass field defined at cell center
!       flux            : mass flux
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        integer (kind=int_kind), intent(in) ::                          &
                        npad, nx, ny, ndata, ncorners, r3, nspace, nedges

        real (kind=dbl_kind), intent(in) ::                             &
                        mass_c     (             ncorners,nx,ny),       &
                        u          (      nspace,ncorners,nx,ny),       &
                        dc         (ndata,       ncorners,nx,ny),       &
                        normal     (ndata,r3    ,ncorners,nx,ny),       &
                        mass                             (nx,ny)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                           &
                        flux                      (nedges,nx,ny)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j,icorner,ispace,ii,jj,idata
        real (kind=dbl_kind) :: r(2,nedges)

!----------------------------------------------------------------------------
! INITIALIZE
!----------------------------------------------------------------------------
        flux = 0.0_dbl_kind

!----------------------------------------------------------------------------
! compute mass flux based on mass_c
!----------------------------------------------------------------------------
        do j=npad+1,ny-npad
        do i=npad+1,nx-npad

!----------------------------------------------------------------------------
! fill the edge flux by combining the two half edges
!----------------------------------------------------------------------------
          r(1,1) = ( u(1,2,i  ,j+1)*normal(2,1,2,i  ,j+1) + u(2,2,i  ,j+1)*normal(2,2,2,i  ,j+1) ) * mass_c(2,i  ,j+1)
          r(1,1) = r(1,1) *             dc(2,  2,i  ,j+1)
          r(2,1) = ( u(1,1,i  ,j  )*normal(1,1,1,i  ,j  ) + u(2,1,i  ,j  )*normal(1,2,1,i  ,j  ) ) * mass_c(1,i  ,j  )
          r(2,1) = r(2,1) *             dc(1,  1,i  ,j  )
          r(1,2) = ( u(1,1,i  ,j  )*normal(3,1,1,i  ,j  ) + u(2,1,i  ,j  )*normal(3,2,1,i  ,j  ) ) * mass_c(1,i  ,j  )
          r(1,2) = r(1,2) *             dc(3,  1,i  ,j  )
          r(2,2) = ( u(1,2,i  ,j  )*normal(1,1,2,i  ,j  ) + u(2,2,i  ,j  )*normal(1,2,2,i  ,j  ) ) * mass_c(2,i  ,j  )
          r(2,2) = r(2,2) *             dc(1,  2,i  ,j  )
          r(1,3) = ( u(1,2,i  ,j  )*normal(3,1,2,i  ,j  ) + u(2,2,i  ,j  )*normal(3,2,2,i  ,j  ) ) * mass_c(2,i  ,j  )
          r(1,3) = r(1,3) *             dc(3,  2,i  ,j  )
          r(2,3) = ( u(1,1,i+1,j  )*normal(2,1,1,i+1,j  ) + u(2,1,i+1,j  )*normal(2,2,1,i+1,j  ) ) * mass_c(1,i+1,j  )
          r(2,3) = r(2,3) *             dc(2,  1,i+1,j  )
          
!----------------------------------------------------------------------------
! fill in the flux
!----------------------------------------------------------------------------
          flux(1,i,j) = -r(1,1)+r(2,1)
          flux(2,i,j) = -r(1,2)+r(2,2)
          flux(3,i,j) = -r(1,3)+r(2,3)

        enddo
        enddo

        end subroutine centered_mass_flux
!======================================================================
! END CENTERED_MASS_FLUX
!======================================================================


!======================================================================
! BEGIN UPSTREAM_MASS_FLUX
!======================================================================
        subroutine upstream_mass_flux(                                &
                npad,                                                 &
                nx,                                                   &
                ny,                                                   &
                ndata,                                                &
                ncorners,                                             &
                nedges,                                               &
                nspace,                                               &
                r3,                                                   &
                dc,                                                   &
                normal,                                               &
                u,                                                    &
                mass,                                                 &
                flux)

!-----------------------------------------------------------------------
! PURPOSE : compute fluxes based on the upstream value of mass
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!       npad            : width of 'ghost cell' region
!       nx              : first dimension of xin (integer)
!       ny              : second dimension of xin (integer)
!       ndata           : amount of data involved in the averaging operator
!       ncorners        : number of corners
!       mass_c          : thickness fields averaged to cell corners (must be wrapped)
!       mass            : scalar field defined at cell center
!       flux            : upstream mass flux 
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        integer (kind=int_kind), intent(in) ::                          &
                        npad, nx, ny, ndata, ncorners, r3, nspace, nedges

        real (kind=dbl_kind), intent(in) ::                             &
                        u          (      nspace,ncorners,nx,ny),       &
                        dc         (ndata,       ncorners,nx,ny),       &
                        normal     (ndata,r3    ,ncorners,nx,ny),       &
                        mass                              (nx,ny)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                           &
                        flux                      (nedges,nx,ny)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j,icorner,ispace,ii,jj,idata
        real (kind=dbl_kind) :: r(2,nedges)

!----------------------------------------------------------------------------
! INITIALIZE
!----------------------------------------------------------------------------
        flux = 0.0_dbl_kind

!----------------------------------------------------------------------------
! compute upstream flux
!----------------------------------------------------------------------------
        do j=npad+1,ny-npad
        do i=npad+1,nx-npad

!----------------------------------------------------------------------------
! fill the edge flux by combining the two half edges
!----------------------------------------------------------------------------
          r(1,1) = ( u(1,2,i  ,j+1)*normal(2,1,2,i  ,j+1) + u(2,2,i  ,j+1)*normal(2,2,2,i  ,j+1) ) 
          r(1,1) = r(1,1) *             dc(2,  2,i  ,j+1)
          r(2,1) = ( u(1,1,i  ,j  )*normal(1,1,1,i  ,j  ) + u(2,1,i  ,j  )*normal(1,2,1,i  ,j  ) ) 
          r(2,1) = r(2,1) *             dc(1,  1,i  ,j  )
          r(1,2) = ( u(1,1,i  ,j  )*normal(3,1,1,i  ,j  ) + u(2,1,i  ,j  )*normal(3,2,1,i  ,j  ) ) 
          r(1,2) = r(1,2) *             dc(3,  1,i  ,j  )
          r(2,2) = ( u(1,2,i  ,j  )*normal(1,1,2,i  ,j  ) + u(2,2,i  ,j  )*normal(1,2,2,i  ,j  ) )
          r(2,2) = r(2,2) *             dc(1,  2,i  ,j  )
          r(1,3) = ( u(1,2,i  ,j  )*normal(3,1,2,i  ,j  ) + u(2,2,i  ,j  )*normal(3,2,2,i  ,j  ) )
          r(1,3) = r(1,3) *             dc(3,  2,i  ,j  )
          r(2,3) = ( u(1,1,i+1,j  )*normal(2,1,1,i+1,j  ) + u(2,1,i+1,j  )*normal(2,2,1,i+1,j  ) ) 
          r(2,3) = r(2,3) *             dc(2,  1,i+1,j  )

          r(1,1) = r(2,1)-r(1,1)
          r(2,1) = 0.0
          r(1,2) = r(2,2)-r(1,2)
          r(2,2) = 0.0
          r(1,3) = r(2,3)-r(1,3)
          r(2,3) = 0.0
          
!----------------------------------------------------------------------------
! based on the value of r, fill in the flux
!----------------------------------------------------------------------------
          flux(1,i,j) = maxval(r(:,1))*mass(i,j) + minval(r(:,1))*mass(i-1,j  )
          flux(2,i,j) = maxval(r(:,2))*mass(i,j) + minval(r(:,2))*mass(i-1,j-1)
          flux(3,i,j) = maxval(r(:,3))*mass(i,j) + minval(r(:,3))*mass(i  ,j-1)

        enddo
        enddo

        end subroutine upstream_mass_flux
!======================================================================
! END UPSTREAM_MASS_FLUX
!======================================================================


!======================================================================
! BEGIN UPSTREAM_TRACER_FLUX
!======================================================================
        subroutine upstream_tracer_flux(                              &
                npad,                                                 &
                nx,                                                   &
                ny,                                                   &
                nedges,                                               &
                mass_flux,                                            &
                xin,                                                  &
                xout)

!-----------------------------------------------------------------------
! PURPOSE : compute fluxes based on the upstream value of xin
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!       npad            : width of 'ghost cell' region
!       nx              : first dimension of xin (integer)
!       ny              : second dimension of xin (integer)
!       nedges          : number of edges owned by a cell
!       xin             : scalar field defined at cell center
!       xout            : upstream flux (note the dimensions of xout)
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        integer (kind=int_kind), intent(in) ::                          &
                        npad, nx, ny, nedges

        real (kind=dbl_kind), intent(in) ::                             &
                        mass_flux   (             nedges,nx,ny),       &
                        xin                             (nx,ny)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                           &
                        xout             (nedges,nx,ny)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j
        real (kind=dbl_kind) :: r(2,3)

!----------------------------------------------------------------------------
! INITIALIZE
!----------------------------------------------------------------------------
        xout = 0.0_dbl_kind

!----------------------------------------------------------------------------
! compute upstream flux
!----------------------------------------------------------------------------
        do j=npad+1,ny-npad
        do i=npad+1,nx-npad

!----------------------------------------------------------------------------
! based on the value of r, fill in the flux
!----------------------------------------------------------------------------
          r = 0
          r(1,1) = mass_flux(1,i,j)
          r(1,2) = mass_flux(2,i,j)
          r(1,3) = mass_flux(3,i,j)

          xout(1,i,j) = maxval(r(:,1))*xin(i  ,j  ) + minval(r(:,1))*xin(i-1,j  )
          xout(2,i,j) = maxval(r(:,2))*xin(i  ,j  ) + minval(r(:,2))*xin(i-1,j-1)
          xout(3,i,j) = maxval(r(:,3))*xin(i  ,j  ) + minval(r(:,3))*xin(i  ,j-1)

        enddo
        enddo

        end subroutine upstream_tracer_flux
!======================================================================
! END UPSTREAM_TRACER_FLUX
!======================================================================


!======================================================================
! BEGIN CENTERED_TRACER_FLUX
!======================================================================
        subroutine centered_tracer_flux(                              &
                npad,                                                 &
                nx,                                                   &
                ny,                                                   &
                nedges,                                               &
                mass_flux,                                            &
                xin,                                                  &
                xout)

!-----------------------------------------------------------------------
! PURPOSE : compute fluxes based on a mass flux and a centered tracer averaging
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!       npad            : width of 'ghost cell' region
!       nx              : first dimension of xin (integer)
!       ny              : second dimension of xin (integer)
!       nedges          : number of edges owned by a cell
!       mass_flux       : mass flux
!       xin             : scalar field defined at cell center
!       xout            : centered flux 
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        integer (kind=int_kind), intent(in) ::                          &
                        npad, nx, ny, nedges

        real (kind=dbl_kind), intent(in) ::                              &
                        mass_flux     (             nedges,nx,ny),       &
                        xin                               (nx,ny)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                           &
                        xout             (nedges,nx,ny)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j

!----------------------------------------------------------------------------
! INITIALIZE
!----------------------------------------------------------------------------
        xout = 0.0_dbl_kind

!----------------------------------------------------------------------------
! compute tracer flux
!----------------------------------------------------------------------------
        do j=npad+1,ny-npad
        do i=npad+1,nx-npad

!----------------------------------------------------------------------------
! based on the value of r, fill in the flux
!----------------------------------------------------------------------------
          xout(1,i,j) = 0.5_dbl_kind*(mass_flux(1,i,j))*(xin(i  ,j  )+xin(i-1,j  ))
          xout(2,i,j) = 0.5_dbl_kind*(mass_flux(2,i,j))*(xin(i  ,j  )+xin(i-1,j-1))
          xout(3,i,j) = 0.5_dbl_kind*(mass_flux(3,i,j))*(xin(i  ,j  )+xin(i  ,j-1))

        enddo
        enddo

        end subroutine centered_tracer_flux
!======================================================================
! END CENTERED_TRACER_FLUX
!======================================================================


!======================================================================
! BEGIN CENTERED_VORTICITY_FLUX
!======================================================================
        subroutine centered_vorticity_flux(                           &
                npad,                                                 &
                nx,                                                   &
                ny,                                                   &
                nedges,                                               &
                mass_flux,                                            &
                mass,                                                 &
                xin,                                                  &
                xout)

!-----------------------------------------------------------------------
! PURPOSE : compute fluxes based on a mass flux and a centered PV averaging
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!       npad            : width of 'ghost cell' region
!       nx              : first dimension of xin (integer)
!       ny              : second dimension of xin (integer)
!       nedges          : number of edges owned by a cell
!       mass_flux       : mass flux
!       xin             : scalar field defined at cell center
!       xout            : centered flux
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        integer (kind=int_kind), intent(in) ::                           &
                        npad, nx, ny, nedges

        real (kind=dbl_kind), intent(in) ::                              &
                        mass_flux     (             nedges,nx,ny),       &
                        mass                              (nx,ny),       &
                        xin                               (nx,ny)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                           &
                        xout             (nedges,nx,ny)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        real (kind=dbl_kind) :: pv(nx,ny), work(nx,ny)
        integer (kind=int_kind) :: i,j

!----------------------------------------------------------------------------
! INITIALIZE
!----------------------------------------------------------------------------
        xout = 0.0_dbl_kind
        work = 0.0_dbl_kind  
        where(mass > 0.0_dbl_kind) work = 1.0_dbl_kind / mass
        pv = xin * work

!----------------------------------------------------------------------------
! compute tracer flux
!----------------------------------------------------------------------------
        do j=npad+1,ny-npad
        do i=npad+1,nx-npad

!----------------------------------------------------------------------------
! based on the value of r, fill in the flux
!----------------------------------------------------------------------------
          xout(1,i,j) = 0.5_dbl_kind*(mass_flux(1,i,j))*(pv(i  ,j  )+  pv(i-1,j  ))
          xout(2,i,j) = 0.5_dbl_kind*(mass_flux(2,i,j))*(pv(i  ,j  )+  pv(i-1,j-1))
          xout(3,i,j) = 0.5_dbl_kind*(mass_flux(3,i,j))*(pv(i  ,j  )+  pv(i  ,j-1))

        enddo
        enddo

        end subroutine centered_vorticity_flux
!======================================================================
! END CENTERED_VORTICITY_FLUX
!======================================================================


!======================================================================
! BEGIN CENTERED_DIVERGENCE_CURL
!======================================================================
        subroutine centered_divergence_curl(                          &
                npad,                                                 &
                nx,                                                   &
                ny,                                                   &
                ndata,                                                &
                ncorners,                                             &
                nedges,                                               &
                nspace,                                               &
                r3,                                                   &
                dc,                                                   &
                tangent,                                              &
                mass_c,                                               &
                eta,                                                  &
                u,                                                    &
                mass,                                                 &
                flux)

!-----------------------------------------------------------------------
! PURPOSE : compute the curl term in the divergence equation in a manner
!	that is entirely consistent with the divergence term in the
!	vorticity equations.
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!       npad            : width of 'ghost cell' region
!       nx              : first dimension of xin (integer)
!       ny              : second dimension of xin (integer)
!       ndata           : amount of data involved in the averaging operator
!       ncorners        : number of corners
!       mass_c          : thickness fields averaged to cell corners (must be wrapped)
!       mass            : mass field defined at cell center
!       flux            : mass flux
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        integer (kind=int_kind), intent(in) ::                          &
                        npad, nx, ny, ndata, ncorners, r3, nspace, nedges

        real (kind=dbl_kind), intent(in) ::                             &
                        mass_c     (             ncorners,nx,ny),       &
                        u          (      nspace,ncorners,nx,ny),       &
                        dc         (ndata,       ncorners,nx,ny),       &
                        tangent    (ndata,r3    ,ncorners,nx,ny),       &
                        eta                              (nx,ny),       &
                        mass                             (nx,ny)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                           &
                        flux                      (nedges,nx,ny)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j,icorner,ispace,ii,jj,idata
        real (kind=dbl_kind) :: r(2,nedges), work(nx,ny), pv(nx,ny)

!----------------------------------------------------------------------------
! INITIALIZE
!----------------------------------------------------------------------------
        flux = 0.0_dbl_kind
        work = 0.0_dbl_kind  
        where(mass > 0.0_dbl_kind) work = 1.0_dbl_kind / mass
        pv = eta * work

!----------------------------------------------------------------------------
! compute mass flux based on mass_c
!----------------------------------------------------------------------------
        do j=npad+1,ny-npad
        do i=npad+1,nx-npad

!----------------------------------------------------------------------------
! fill the edge flux by combining the two half edges
!----------------------------------------------------------------------------
          r(1,1) = ( u(1,2,i  ,j+1)*tangent(2,1,2,i  ,j+1) + u(2,2,i  ,j+1)*tangent(2,2,2,i  ,j+1) ) * mass_c(2,i  ,j+1)
          r(1,1) = r(1,1) *             dc(2,  2,i  ,j+1)
          r(2,1) = ( u(1,1,i  ,j  )*tangent(1,1,1,i  ,j  ) + u(2,1,i  ,j  )*tangent(1,2,1,i  ,j  ) ) * mass_c(1,i  ,j  )
          r(2,1) = r(2,1) *             dc(1,  1,i  ,j  )
          r(1,2) = ( u(1,1,i  ,j  )*tangent(3,1,1,i  ,j  ) + u(2,1,i  ,j  )*tangent(3,2,1,i  ,j  ) ) * mass_c(1,i  ,j  )
          r(1,2) = r(1,2) *             dc(3,  1,i  ,j  )
          r(2,2) = ( u(1,2,i  ,j  )*tangent(1,1,2,i  ,j  ) + u(2,2,i  ,j  )*tangent(1,2,2,i  ,j  ) ) * mass_c(2,i  ,j  )
          r(2,2) = r(2,2) *             dc(1,  2,i  ,j  )
          r(1,3) = ( u(1,2,i  ,j  )*tangent(3,1,2,i  ,j  ) + u(2,2,i  ,j  )*tangent(3,2,2,i  ,j  ) ) * mass_c(2,i  ,j  )
          r(1,3) = r(1,3) *             dc(3,  2,i  ,j  )
          r(2,3) = ( u(1,1,i+1,j  )*tangent(2,1,1,i+1,j  ) + u(2,1,i+1,j  )*tangent(2,2,1,i+1,j  ) ) * mass_c(1,i+1,j  )
          r(2,3) = r(2,3) *             dc(2,  1,i+1,j  )

!----------------------------------------------------------------------------
! fill in the flux
!----------------------------------------------------------------------------
          flux(1,i,j) = (-r(1,1)+r(2,1)) * (pv(i-1,j  ) + pv(i,j)) * 0.5_dbl_kind
          flux(2,i,j) = (-r(1,2)+r(2,2)) * (pv(i-1,j-1) + pv(i,j)) * 0.5_dbl_kind
          flux(3,i,j) = (-r(1,3)+r(2,3)) * (pv(i  ,j-1) + pv(i,j)) * 0.5_dbl_kind

        enddo
        enddo

        end subroutine centered_divergence_curl
!======================================================================
! END CENTERED_DIVERGENCE_CURL
!======================================================================


        end module operators

!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
