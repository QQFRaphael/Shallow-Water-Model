module time_manager

! This file is the beginnings of a pseudo-ESMF style time manager

   implicit none
   private

   integer :: step_count
   logical, public :: halt

! public member functions

   public :: time_manager_init,      &
             update_time_alarms,     &
             increment_time

   contains

!-------------------------------------------------------------------------------

   subroutine time_manager_init

   halt = .false.
   step_count = 0

   end subroutine time_manager_init

!-------------------------------------------------------------------------------

   subroutine update_time_alarms

   if(step_count.eq.1) halt = .true.

   end subroutine update_time_alarms

!-------------------------------------------------------------------------------

   subroutine increment_time

   step_count = step_count + 1

   end subroutine increment_time

end module time_manager

