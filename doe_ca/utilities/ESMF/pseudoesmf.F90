module ESMF_TimeMgmtMod

! This module is a poor man's implementation of some ESMF time management
!   functionality.

! History:
!   Created - 2002/06/18 - Don Dazlich, dazlich@atmos.colostate.edu
!     includes following public routines:
!           ESMF_TimeInit,           &
!           ESMF_TimeIncrement,      &
!           ESMF_DateInit,           &
!           ESMF_DateIncrement,      &
!           ESMF_TimeMgrInit,        &
!           ESMF_TimeMgrLastStep,    &
!           ESMF_TimeMgrAdvance,     &
!           ESMF_TimeMgrGetNStep,    &
!           ESMF_TimeMgrGetCurrDate, &
!           ESMF_DateGetIS,          &
!           ESMF_AlarmInitMonthly,   &
!           ESMF_AlarmInitPeriodic,  &
!           ESMF_AlarmIsOn,          &
!           ESMF_AlarmSet
!     Currently supports only the No_leap calendar, integer second discretization

implicit none

private

! define ESMF class types
type ESMF_TOD
   private
   sequence
   integer(8) sec
   integer(8) msec
end type ESMF_TOD

type ESMF_Calendar
   private
   sequence
   integer(8) type
   integer(8), dimension(0:12) :: dim
   integer(8), dimension(0:12) :: dimRunningSum
   integer(8) diy
end type ESMF_Calendar

! calendar public data members
integer(8), public, parameter :: ESMF_NO_LEAP = 0,  &
                                 ESMF_GREGORIAN=1,  &
                                 ESMF_360_DAY=2
! warning message flag
integer(8), parameter :: ESMF_WARNING_MSG = 0,  &
                         ESMF_NOWARNING_MSG=1

type ESMF_Time
   private
   sequence
   integer(8) day
   type(ESMF_TOD) tod
end type ESMF_Time

type ESMF_Date
   private
   sequence
   type(ESMF_Calendar) calendar
   integer(8) year
   integer(8) month
   integer(8) day
   type(ESMF_TOD) tod
   integer(8) julianDay
   integer(8) dayOfYear
end type ESMF_Date

type ESMF_TimeMgr
   private
   sequence
   integer(8) nstep
   type(ESMF_Time) stepSize
   type(ESMF_Date) startDate
   type(ESMF_Date) stopDate
   type(ESMF_Date) baseDate
   type(ESMF_Date) currDate
   type(ESMF_Date) prevDate
end type ESMF_TimeMgr

type ESMF_Alarm
   private
   sequence
   integer(8) type
   integer(8) offset
   integer(8) period
   integer(8) alarmOn
end type ESMF_Alarm

! Alarm public data members
   integer(8), public, parameter :: ESMF_ALARM_PERIODIC=0,    &
                                    ESMF_ALARM_MONTHLY=1,     &
                                    ESMF_ALARM_YEARLY=2

! Publid member types
public :: ESMF_Alarm,      &
          ESMF_Date,       &
          ESMF_Time,       &
          ESMF_TimeMgr

! Public member functions
public ::  ESMF_TimeInit,           &
           ESMF_TimeIncrement,      &
           ESMF_DateInit,           &
           ESMF_DateIncrement,      &
           ESMF_TimeMgrInit,        &
           ESMF_TimeMgrLastStep,    &
           ESMF_TimeMgrAdvance,     &
           ESMF_TimeMgrGetNStep,    &
           ESMF_TimeMgrGetCurrDate, &
           ESMF_DateGetIS,          &
           ESMF_AlarmInitMonthly,   &
           ESMF_AlarmInitPeriodic,  &
           ESMF_AlarmIsOn,          &
           ESMF_AlarmSet

contains


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


   function ESMF_TimeInit( day, tod ) result(ESMF_TimeInit_result)
! This function sets a time class variable with day and TimeOfDay

! argument list declarations
   integer(8), intent(in) :: day,   & ! day
                             tod      ! time of day (seconds)
   type(ESMF_Time) :: ESMF_TimeInit_result

   ESMF_TimeInit_result%day = day
   ESMF_TimeInit_result%tod%sec = tod
   ESMF_TimeInit_result%tod%msec = 0

   end function ESMF_TimeInit


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



   function ESMF_TimeIncrement( starttime, day, tod )    &
                        result(ESMF_TimeIncrement_result)
! This function increments a time class variable, starttime, by day and TimeofDay

! argument list
   type(ESMF_Time), intent(in) :: starttime
   integer(8), intent(in) :: day,   & ! day
                             tod      ! time of day (seconds)
   type(ESMF_Time) :: ESMF_TimeIncrement_result

   ESMF_TimeIncrement_result%day = starttime%day + day
   ESMF_TimeIncrement_result%tod%sec = starttime%tod%sec + tod
   ESMF_TimeIncrement_result%tod%msec = starttime%tod%msec

   end function ESMF_TimeIncrement


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



   function ESMF_DateInit( cal_type, date, tod ) result(ESMF_DateInit_result)
! This function sets a Date class variable with day and TimeOfDay and calendar type

! argument list declarations
   integer(8), intent(in) :: cal_type, & ! calendar type
                             date,     & ! date (yyyymmdd)
                             tod         ! time of day (seconds)
   type(ESMF_Date) :: ESMF_DateInit_result

   if(cal_type /= ESMF_NO_LEAP) stop 'unsupported calendar type'
   ESMF_DateInit_result%calendar = ESMF_calendar_init( cal_type )
   ESMF_DateInit_result%year = date / 10000_8
   ESMF_DateInit_result%month = (date-10000*ESMF_DateInit_result%year) / 100_8
   ESMF_DateInit_result%day =   &
          (date-(10000*ESMF_DateInit_result%year+100*ESMF_DateInit_result%month)) 
   ESMF_DateInit_result%tod%sec = tod
   ESMF_DateInit_result%tod%msec = 0

   call ESMF_date_overflow_check( ESMF_DateInit_result, ESMF_WARNING_MSG )

! this code copied to ESMF_DateIncrement
   ESMF_DateInit_result%dayofyear = ESMF_DateInit_result%day     &
            + ESMF_DateInit_result%calendar%dimRunningSum(ESMF_DateInit_result%month-1)
   ESMF_DateInit_result%julianday = 365*(ESMF_DateInit_result%year)  &
            + ESMF_DateInit_result%dayofyear


   end function ESMF_DateInit


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



   function ESMF_DateIncrement( startdate, inctime ) result(ESMF_DateIncrement_result)
! This function increments a time class variable, starttime, by day and TimeofDay

! argument list
   type(ESMF_Date), intent(in) :: startdate
   type(ESMF_Time), intent(in) :: incTime
   type(ESMF_Date) :: ESMF_DateIncrement_result

   ESMF_DateIncrement_result = startdate
   ESMF_DateIncrement_result%day = startdate%day + inctime%day
   ESMF_DateIncrement_result%tod%sec = startdate%tod%sec + inctime%tod%sec
   ESMF_DateIncrement_result%tod%msec = startdate%tod%msec + inctime%tod%msec

   call ESMF_date_overflow_check( ESMF_DateIncrement_result, ESMF_NOWARNING_MSG )

! this code copied from ESMF_DateInit
   ESMF_DateIncrement_result%dayofyear = ESMF_DateIncrement_result%day     &
         + ESMF_DateIncrement_result%calendar%dimRunningSum(ESMF_DateIncrement_result%month-1)
   ESMF_DateIncrement_result%julianday = 365*(ESMF_DateIncrement_result%year)  &
         + ESMF_DateIncrement_result%dayofyear


   end function ESMF_DateIncrement


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



   function ESMF_TimeMgrInit( stepSize, startdate, enddate) result (ESMF_TimeMgrInit_result)
! This function initialized the time manager variable

! argument list
   type (ESMF_Time), intent(in) :: stepSize
   type (ESMF_Date), intent(in) :: startDate, enddate
   type (ESMF_TimeMgr) :: ESMF_TimeMgrInit_result

   ESMF_TimeMgrInit_result%nstep = 0
   ESMF_TimeMgrInit_result%stepsize = stepsize
   ESMF_TimeMgrInit_result%startdate = startdate
   ESMF_TimeMgrInit_result%stopdate = enddate
   ESMF_TimeMgrInit_result%currdate = startdate
   ESMF_TimeMgrInit_result%basedate = startdate
   ESMF_TimeMgrInit_result%prevdate = startdate

   end function ESMF_TimeMgrInit


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



   function ESMF_TimeMgrLastStep( timeMgr, rc ) result (ESMF_TimeMgrLastStep_result)
! This function tests if the next time step will advance the time manager past
!   the stop date

! argument list
   type (ESMF_TimeMgr), intent(in) :: timeMgr
   integer, intent(out), optional :: rc
   logical :: ESMF_TimeMgrLastStep_result

! local variables
   type (ESMF_date) :: nextdate

   nextdate = ESMF_DateIncrement(timeMgr%currdate, timeMgr%stepsize)

   ESMF_TimeMgrLastStep_result = .false.

   if(nextdate%julianday > timeMgr%stopdate%julianday) then
      ESMF_TimeMgrLastStep_result = .true.
   else if (nextdate%julianday == timeMgr%stopdate%julianday) then
      if(nextdate%tod%sec > timeMgr%stopdate%tod%sec) then
         ESMF_TimeMgrLastStep_result = .true.
      endif
   endif

   end function ESMF_TimeMgrLastStep


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



   subroutine ESMF_TimeMgrAdvance( timeMgr, rc )
! This function advances the time manager by one time step

! argument list
   type (ESMF_TimeMgr), intent(inout) :: timeMgr
   integer, intent(out), optional :: rc

   timeMgr%prevdate = timeMgr%currdate
   timeMgr%currdate = ESMF_DateIncrement(timeMgr%currdate, timeMgr%stepsize)
   timeMgr%nstep = timeMgr%nstep + 1

   end subroutine ESMF_TimeMgrAdvance


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



   function ESMF_TimeMgrGetNStep( timeMgr, rc ) result(ESMF_TimeMgrGetNStep_result)
! This function returns the time step number (nstep) from the time manager

! argument list
   type (ESMF_TimeMgr), intent(inout) :: timeMgr
   integer, intent(out), optional :: rc
   integer(8) ESMF_TimeMgrGetNStep_result

   ESMF_TimeMgrGetNStep_result = timeMgr%nstep

   end function ESMF_TimeMgrGetNStep


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



   function ESMF_TimeMgrGetCurrDate ( timeMgr, rc ) result(ESMF_TimeMgrGetCurrDate_result)
! This function returns the current date from the time manager

! argument list
   type (ESMF_TimeMgr), intent(inout) :: timeMgr
   integer, intent(out), optional :: rc
   type (ESMF_Date) :: ESMF_TimeMgrGetCurrDate_result

   ESMF_TimeMgrGetCurrDate_result = timeMgr%currdate

   end function ESMF_TimeMgrGetCurrDate


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



   subroutine ESMF_DateGetIS(date, yyyymmdd, tod, rc )
! This function returns the yyyymmdd date and time of day from the date

! argument list
   type (ESMF_Date), intent(in) :: date
   integer(8), intent(out) :: yyyymmdd
   integer(8), intent(out) :: tod 
   integer, intent(out), optional :: rc

   tod = date%tod%sec
   yyyymmdd = date%day + 100*date%month + 10000*date%year

   end subroutine ESMF_DateGetIS


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



   function ESMF_calendar_init( cal_type ) result( ESMF_calendar_init_result)
! This function initializes the calendar class variable
! WARNING! This function only works for the NO_Leap calendar 

! argument list
   integer(8), intent(in) :: cal_type
   type(ESMF_calendar) :: ESMF_calendar_init_result

! local variables
   integer m  ! do loop index

   ESMF_calendar_init_result%type = cal_type

! initialize the no leap year calendar
   if(cal_type == ESMF_NO_LEAP) then
      ESMF_calendar_init_result%diy = 365
      ESMF_calendar_init_result%dim(1) = 31
      ESMF_calendar_init_result%dim(2) = 28
      ESMF_calendar_init_result%dim(3) = 31
      ESMF_calendar_init_result%dim(4) = 30
      ESMF_calendar_init_result%dim(5) = 31
      ESMF_calendar_init_result%dim(6) = 30
      ESMF_calendar_init_result%dim(7) = 31
      ESMF_calendar_init_result%dim(8) = 31
      ESMF_calendar_init_result%dim(9) = 30
      ESMF_calendar_init_result%dim(10) = 31
      ESMF_calendar_init_result%dim(11) = 30
      ESMF_calendar_init_result%dim(12) = 31
      ESMF_calendar_init_result%dimRunningSum(0) = 0

! stop execution for an unsupported calendar type
   else
      stop 'unsupported calendar type'
   endif

! get the day in month running sum
   do m = 1,12
      ESMF_calendar_init_result%dimRunningSum(m) =     &
         ESMF_calendar_init_result%dimRunningSum(m-1) + ESMF_calendar_init_result%dim(m)
   enddo

   end function ESMF_calendar_init


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


   subroutine ESMF_date_overflow_check( date, msg_flag )
! this subroutine checks for date overflow in the date variable of the form yyyymmdd

! argument list
   type (ESMF_Date), intent(inout) :: date
   integer(8), intent(in) :: msg_flag

! local variables
   logical overflow
   integer sec_overflow, day_overflow, month_overflow

   overflow = .false.

   sec_overflow = date%tod%sec / 86400
   date%tod%sec = mod(date%tod%sec,86400_8)
   date%day = date%day + sec_overflow
      
   do while ( date%day > date%calendar%dim(date%month) ) 
      date%day = date%day - date%calendar%dim(date%month)
      date%month = date%month + 1
      if(date%month > 12) then
         date%month = date%month - 12
         date%year = date%year + 1
      endif
      overflow = .true.
   enddo     
   if(msg_flag == ESMF_WARNING_MSG.and.overflow) print*,'date overflow adjustment done'
   
   end subroutine ESMF_date_overflow_check


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


   function ESMF_AlarmInitMonthly(rc) result(ESMF_AlarmInitMonthly_result)
! this function initializes a monthly alarm

! argument list
   integer, intent(out), optional :: rc
   type (ESMF_Alarm) :: ESMF_AlarmInitMonthly_result

   ESMF_AlarmInitMonthly_result%type = ESMF_ALARM_MONTHLY
   ESMF_AlarmInitMonthly_result%offset = 0
   ESMF_AlarmInitMonthly_result%period = 0
   ESMF_AlarmInitMonthly_result%alarmOn = 0

   end function ESMF_AlarmInitMonthly



!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


   function ESMF_AlarmInitPeriodic(period, offset, rc) result(ESMF_AlarmInitPeriodic_result)
! this function initializes a periodic alarm

! argument list
   type (ESMF_Time), intent(in) :: period  ! alarm period
   type (ESMF_Time), intent(in) :: offset  ! alarm time offset to basedate to first alarm
   integer, intent(out), optional :: rc
   type (ESMF_Alarm) :: ESMF_AlarmInitPeriodic_result

   ESMF_AlarmInitPeriodic_result%type = ESMF_ALARM_Periodic
   ESMF_AlarmInitPeriodic_result%offset = 86400_8*offset%day+offset%tod%sec
   ESMF_AlarmInitPeriodic_result%period = 86400_8*period%day+period%tod%sec
   ESMF_AlarmInitPeriodic_result%alarmOn = 0

   end function ESMF_AlarmInitPeriodic



!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


   function ESMF_AlarmIsOn( alarm, timeMgr, rc) result(ESMF_AlarmIsOn_result)
! this function turns on an alarm at the appropriate time

! argument list
   type (ESMF_Alarm), intent(in) :: alarm  
   type (ESMF_TimeMgr), intent(in) :: timeMgr
   integer, intent(out), optional :: rc
   logical :: ESMF_AlarmIsOn_result

! local variables
   integer(8) :: date_sec

   ESMF_AlarmIsOn_result = .false.

   if(alarm%type == ESMF_ALARM_PERIODIC) then
      date_sec = 86400_8*timeMgr%currdate%julianday + timeMgr%currdate%tod%sec
      if( date_sec >= alarm%offset ) then
         if( mod(date_sec-alarm%offset, alarm%period) == 0_8) ESMF_AlarmIsOn_result = .true.
      endif
   else if (alarm%type == ESMF_ALARM_MONTHLY) then
      if(timeMgr%prevdate%month /= timeMgr%currdate%month) ESMF_AlarmIsOn_result = .true.
   endif
   end function ESMF_AlarmIsOn


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


   subroutine ESMF_AlarmSet(alarm, alarmOn, rc )
! this routine sets whether the alarm is on

! argument list
   type (ESMF_Alarm), intent(inout) :: alarm
   logical, intent(in) :: alarmOn
   integer, intent(out), optional :: rc

   if(alarmon) then
      alarm%alarmOn = 1
   else
      alarm%alarmOn = 0
   endif

   end subroutine ESMF_AlarmSet


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



end module ESMF_TimeMgmtMod
