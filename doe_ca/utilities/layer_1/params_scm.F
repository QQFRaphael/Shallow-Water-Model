module params_scm

! This module contains variables to be used to define the grid cell  
!    location of an scm column.
! This is probably just an intermediate step to full implementation of 
!    a Single-Column Model, later on I imagine adding an scm init routine
!    that reads these in instead of recompiling for each location.
!
! History:
!    Created  17 December 2004 Don Dazlich

use kinds

implicit none
save
private

! The values here are used by grid metrics generator to set the grid cell
!   locations of an SCM grid cell.

real (kind=dbl_kind), public ::      &
   lon_scm =    0.0,  & ! Longitude (degrees E) of an scm grid cell
   lat_scm =   30.0     ! Latitude  (degrees N) of an scm grid cell

end module params_scm
