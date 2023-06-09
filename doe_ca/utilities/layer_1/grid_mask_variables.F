!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

        module grid_mask_variables_xxx

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
        use params_grid_horizontal_xxx

        implicit none
        private

! mask variables for grid cells
        real (kind=dbl_kind), public ::                                 &
                grid_center_mask      (          iim, jjm, nsdm),       &
                grid_corner_mask      (ncorners, iim, jjm, nsdm),       &
                polygon_type          (          iim, jjm, nsdm)          

        integer (kind=int_kind), public ::                              &
                grid_center_index  (          iim, jjm, nsdm),          &
                grid_corner_index  (ncorners, iim, jjm, nsdm),          &
                subzone_shift      (ncorners, iim, jjm, nsdm)

! mask variables for subdomain blocks
        integer (kind=int_kind) ::                                      &
                nsdm_empty = 0,                                         &
                nsdm_not_empty = nsdm,                                  &
                block_number(nsdm)

        public :: init_grid_mask_variables_xxx
        contains
        subroutine init_grid_mask_variables_xxx
        end subroutine init_grid_mask_variables_xxx

        end module grid_mask_variables_xxx
!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
