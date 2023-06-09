!-----------------------------------------------------------------------
!
MODULE netcdf_util
!
!-----------------------------------------------------------------------
!  Purpose: 
!     Provides a module interface for netcdf include file and error 
!     handling function.
!
!  Scope: all variables and routines are public
!
!  Bugs:
!-----------------------------------------------------------------------

   use kinds
   implicit none

   public

   include 'netcdf.inc'


CONTAINS

!-----------------------------------------------------------------------
!
   SUBROUTINE handle_error (ncerr, message)
!
!-----------------------------------------------------------------------
!  Purpose:
!    Deals with netcdf errors.
!    Prints the type of error and exits.
!
!  Scope: public subroutine 
!    Module variables used:
!       netcdf error codes (from netcdf.inc)
!
!-----------------------------------------------------------------------

   integer (kind=int_kind), intent(in) :: ncerr       ! netcdf return status
   character(len=*), intent(in), optional :: message  ! user specified error message 

! If the netcdf return status is not the normal return then print the status
!   code and user message, if any.
   if (ncerr /= NF_NOERR) then

      print *, "NETCDF ERROR (", ncerr, "):  ",  nf_strerror(ncerr)
      if (present(message)) print *, message

         if (critical(ncerr)) then
            print *
            print *, "CRITICAL NETCDF ERROR: STOP"
            stop
         end if

      endif


   END SUBROUTINE handle_error



!-----------------------------------------------------------------------
!
   FUNCTION critical (code) result(critical_result)
!
!-----------------------------------------------------------------------
! Purpose:
!    Used to determine whether a netcdf error is critical (i.e., warrants
!    program termination.)
!    Currently, all errors are treated as critical.
!
!  Scope: public
!    Module variables used:
!       various netcdf error codes
!    Variables from containing scope:
!       ncerr (someday...)
!
!-----------------------------------------------------------------------

   integer (kind=int_kind), intent(in) :: code   ! netcdf return status
   logical (kind=log_kind) :: critical_result    ! if true, error is critical

! FIXME - determine whether error is critical here...
!         for testing purposes, all errors are critical.
   critical_result = .true.

   END FUNCTION critical


END MODULE netcdf_util

