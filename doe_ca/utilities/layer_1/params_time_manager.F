module params_time_manager

! This module contains variables to be used to define time management
!    options.
! History:
!    Created  30 April 2004 Don Dazlich

use kinds
use ESMF_MOD

implicit none
save
private

! These values for variables are just defaults. They may be overridden
!   by input in subroutine init_time_manager_global in file global_time_manager.F

! options for prescribing the boundary conditions to a perpetual state
logical (kind=log_kind), public ::      &
   perpetual_day = .false.   ! if true the conditions of a particular day 
                             !     will be perpetuated through a run
integer (kind=int_kind), public ::      &
   perpetual_dayofyear = 1   ! the day of the year to be perpetuated if
                             !   perpetual_day is true

! The following variables control the restarting of the model. When the model
!    writes restarts it writes the timestamp associated with the restarts
!    to the file 'restart_timestamp' in the current working directory.
!    When starting the model, if the file restart_timestamp exists then
!    logical variable restart_exist=true and the variable restart_timestring
!    is read. Then, every component of the model reads its associated restart
!    file that bears the timestamp stored as restart_timestring. The timestamp
!    stored in restart_timestring will overwrite the run starttime values in 
!    line 2 of 'data/namelist_time_global'. If the file
!    'restart_timestamp' does not exist, then each component reads a default
!    initialization. The nature of this default is up to each component.

character (len=ESMF_MAXSTR), public ::  &
   restart_timestring        ! timestring from which to restart the model
                             !    (if exists)
logical (kind=log_kind), public ::      &
   restart_exist = .false.   ! if true, restart model from restarts with 
                             !    timestamp restart_timestring
                             
integer (kind=int_kind), public :: start_year ! starting simulation year
                                      ! should match nyear0 in ocean.dummy for consistency

logical (kind=log_kind), public ::      &
   coupler_coldstart         ! if true, restart model without saved
							 !    interfacial fluxes. True unless
							 !    model_restart_coupler exists.

end module params_time_manager
