!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

        module grid_metrics_variables_xxx
        
!-----------------------------------------------------------------------
! PURPOSE : provide a component independent place to store the
!           variables computed by grid_metrics. One of these will
!           be compiled by each component. This file was created
!           by taking a part of grid_metrics.F
!
! HISTORY : 
!    15 Jun 2003 - created - dd
!-----------------------------------------------------------------------

	use kinds
	use params_physical
	use params_grid_horizontal_xxx
	
	implicit none
        
 	real (kind=dbl_kind) ::                                             &
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

        real (kind=dbl_kind) ::                                             &
                v_weights      (ndata, nspace, ncorners, iim, jjm, nsdm),   &
      		s_weights      (ndata,         ncorners, iim, jjm, nsdm),   &
      	        l_weights      (nweights,                iim, jjm, nsdm)

	real (kind=dbl_kind) ::                                             &
                trans_to_X2 (r3, r3, ncorners, iim, jjm, nsdm),             &
                trans_to_X1 (r3, r3, ncorners, iim, jjm, nsdm)

        real (kind=dbl_kind) ::                                             &
                grid_center_lon    (           iim, jjm, nsdm),             &
                grid_center_lat    (           iim, jjm, nsdm),             &
                grid_corner_lon    ( ncorners, iim, jjm, nsdm),             &
                grid_corner_lat    ( ncorners, iim, jjm, nsdm)              

        real (kind=dbl_kind) ::                                             &
                grid_center_centroid(r3,iim, jjm, nsdm),             &
                grid_corner_centroid(r3,ncorners,iim,jjm,nsdm)

	real (kind=dbl_kind) :: tot_area, inv_tot_area

        public :: init_grid_metrics_variables_xxx
        contains
        subroutine init_grid_metrics_variables_xxx
        end subroutine init_grid_metrics_variables_xxx
       
        end module grid_metrics_variables_xxx
