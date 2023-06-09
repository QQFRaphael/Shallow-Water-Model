module time_manager_utilities

! PURPOSE:
! This module consists of routines that the time manager needs and ESMF does
!   not provide the functionality, so I am creating them.
! 
! AUTHOR:
! Don Dazlich (dazlich@atmos.colostate.edu_
!
! HISTORY:
! 2004-12-09
!   Created this module and subroutine timestring_to_time

use kinds
use params_time_manager
use ESMF_MOD

implicit none
private

public ::                   &
   timestring_to_time,      &
   get_restart_filename
   
contains

   subroutine timestring_to_time(                                       &
                                 timestring,                            &
                                 yy,                                    &
                                 mm,                                    &
                                 dd,                                    &
                                 h,                                     &
                                 m,                                     &
                                 s,                                     &
                                 rc )
                                 
! This routine will take an ISO 8601 standard time string (YYYY-MM-DDTHH:MM:SS)
!   and determine the 6 time components, year, month, day, hour, minuts and second.

! Argument list variables
   character(len=*), intent(in) ::                                      &
      timestring                ! ISO 8601 time string
   integer (ESMF_Kind_I4), intent(out) ::                                            &
      yy,              &  ! year (0-9999)
      mm,              &  ! month (1-12)
      dd,              &  ! day (1-31)
      h,               &  ! hour (0-23)
      m,               &  ! minute (0-59)
      s                   ! second (0-59)
   integer (ESMF_Kind_I4), intent(out), optional ::                     &
      rc              ! return code
                      !   rc = ESMF_SUCCESS (0) successful return
                      !   rc = ESMF_FAILURE (-1) unsuccessful ESMF_TimeSet call
                      !   rc = -2, invalid timestring
                      
! local variables
   integer (ESMF_Kind_I4) ::                                            &
      i,               &  ! loop indices
      ierr,            &  ! return code
      pos_dash1           ! position of first dash in timestring


! set rc default of success
   if(present(rc)) rc = ESMF_SUCCESS
   
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Test for a valid timestring
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

! Test of the positions of the dashes, T, and colons are valid

! First dash can occur in positions 2 through 5
   pos_dash1 = 1
   do i = 2,5
      if(timestring(i:i) == '-') then
         pos_dash1 = i
         exit
      endif
   enddo
   if (pos_dash1 == 1) then
      if(present(rc)) rc=-2
      print*,'time string = ', trim(timestring)
      print*,'First dash in timestring not in position 2-5'
      return
   endif
   
! Second dash is three characters past first
   if(timestring(pos_dash1+3:pos_dash1+3) .ne. '-') then
      if(present(rc)) rc=-2
      print*,'time string = ', trim(timestring)
      print*,'Second dash in timestring not 3 characters past first'
      return
   endif

! Upper case T is three characters past second dash
   if(timestring(pos_dash1+6:pos_dash1+6) .ne. 'T') then
      if(present(rc)) rc=-2
      print*,'time string = ', trim(timestring)
      print*,'Upper case T in timestring not 3 characters past second dash'
      return
   endif

! First colon is three characters past Upper Case T
   if(timestring(pos_dash1+9:pos_dash1+9) .ne. ':') then
      if(present(rc)) rc=-2
      print*,'time string = ', trim(timestring)
      print*,'First colon in timestring not 3 characters past upper case T'
      return
   endif

! Second colon is three characters past first
   if(timestring(pos_dash1+12:pos_dash1+12) .ne. ':') then
      if(present(rc)) rc=-2
      print*,'time string = ', trim(timestring)
      print*,'Second colon in timestring not 3 characters past first'
      return
   endif
   
! total number of characters is first dash position + 14
   if(len_trim(timestring) .ne. pos_dash1+14) then
      if(present(rc)) rc=-2
      print*,'time string = ', trim(timestring)
      print*,'Second colon in timestring not 3 characters past first'
      return
   endif
   
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Read the time components out of the time string
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   read(unit=timestring(pos_dash1+13:pos_dash1+14), fmt='(i2)', iostat=ierr)s
   if(ierr.ne.0 .or. s.lt.0 .or. s.ge.60) then
      if(present(rc)) rc=-2
      print*,'time string = ', trim(timestring)
      print*,'Improper value for seconds (after 2nd colon) in timestring'
      return
   endif
   read(unit=timestring(pos_dash1+10:pos_dash1+11), fmt='(i2)', iostat=ierr)m
   if(ierr.ne.0 .or. m.lt.0 .or. m.ge.60) then
      if(present(rc)) rc=-2
      print*,'time string = ', trim(timestring)
      print*,'Improper value for minutes (after 1st colon) in timestring'
      return
   endif
   read(unit=timestring(pos_dash1+7:pos_dash1+8), fmt='(i2)', iostat=ierr)h
   if(ierr.ne.0 .or. h.lt.0 .or. h.ge.24) then
      if(present(rc)) rc=-2
      print*,'time string = ', trim(timestring)
      print*,'Improper value for hours (after T) in timestring'
      return
   endif
   read(unit=timestring(pos_dash1+4:pos_dash1+5), fmt='(i2)', iostat=ierr)dd
   if(ierr.ne.0 .or. dd.lt.1 .or. dd.gt.31) then
      if(present(rc)) rc=-2
      print*,'time string = ', trim(timestring)
      print*,'Improper value for day (after 2nd dash) in timestring'
      return
   endif
   read(unit=timestring(pos_dash1+1:pos_dash1+2), fmt='(i2)', iostat=ierr)mm
   if(ierr.ne.0 .or. mm.lt.1 .or. mm.gt.12) then
      if(present(rc)) rc=-2
      print*,'time string = ', trim(timestring)
      print*,'Improper value for month (after 1st dash) in timestring'
      return
   endif
   if(pos_dash1 == 5) then
      read(unit=timestring(pos_dash1-4:pos_dash1-1), fmt='(i4)', iostat=ierr)yy
   else if(pos_dash1 == 4) then
      read(unit=timestring(pos_dash1-3:pos_dash1-1), fmt='(i3)', iostat=ierr)yy
   else if(pos_dash1 == 3) then
      read(unit=timestring(pos_dash1-2:pos_dash1-1), fmt='(i2)', iostat=ierr)yy
   else if(pos_dash1 == 2) then
      read(unit=timestring(pos_dash1-1:pos_dash1-1), fmt='(i1)', iostat=ierr)yy
   endif
   if(ierr.ne.0 .or. yy.lt.0 .or. yy.gt.9999) then
      if(present(rc)) rc=-2
      print*,'time string = ', trim(timestring)
      print*,'Improper value for year (before 1st dash) in timestring'
      return
   endif

   if(present(rc)) rc=ierr
   
   end subroutine timestring_to_time
   
   subroutine get_restart_filename(ftype, fname)
   
! this routine will return a restart file name of the form:
!     model_restart_'ftype'.'restart_timestring if it is a restart,
!     else 'fname'_restart as a default.
   
! arguments
   character (len=*), intent(in) :: ftype   ! restart type name
   character (len=*), intent(out) :: fname  ! restart file name
   
   
   if(restart_exist) then
      fname = './restarts/model_restart_'//trim(ftype)//'.'//      &
              trim(restart_timestring)
   else
      fname = './restarts/'//trim(ftype)//'_restart'
   endif
   
   end subroutine get_restart_filename

end module time_manager_utilities
