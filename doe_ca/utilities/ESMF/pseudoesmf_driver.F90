! What follows is a program to test the pseudo-ESMF time management module

program esmf_test

use ESMF_TimeMgmtMod

implicit none

! declarations for input data to set run start, run stop, and time increment
integer(8) :: startDay, startTOD, execDay, execTOD, incDay, incTOD, baseyear

integer(8) :: nstep, ndate, nsec

! declarations of time manager variables
type(ESMF_Time) :: startTime, endTime, stepSize, daily_period, daily_offset
type(ESMF_Date) :: baseDate, startdate, enddate, currdate
type(ESMF_TimeMgr) :: timeMgr
type(ESMF_Alarm) :: month_alarm, day_alarm


! read in the execution control
open(unit=2,file='exec.cntl',form='formatted')
read(2,*)startDay
read(2,*)startTOD
read(2,*)execDay
read(2,*)execTOD
read(2,*)incDay
read(2,*)incTOD
read(2,*)baseYear

! compute the start time
startTime = ESMF_TimeInit(startDay, startTOD)

! compute the end time - increment the start time by the exec time
endTime = ESMF_TimeIncrement(startTime, execDay, execTOD)

! compute the time step size
stepSize = ESMF_TimeInit(incDay, incTOD)

! get the basedate, use it to get start and stop dates
basedate = ESMF_DateInit( ESMF_NO_LEAP, baseyear*10000_8+101_8, 0_8 )
startdate = ESMF_DateIncrement( basedate, startTime )
enddate   = ESMF_DateIncrement( basedate, endTime )

! initialize the time manager
timeMgr = ESMF_TimeMgrInit(stepSize, startdate, enddate)

nstep = ESMF_TimeMgrGetNStep( timeMgr )
currdate = ESMF_TimeMgrGetCurrDate ( timeMgr )
call ESMF_DateGetIS(currdate, ndate, nsec)
print*,'initial nstep, ndate, nsec ',nstep, ndate, nsec

! initialize some alarms
month_alarm = ESMF_AlarmInitMonthly()
daily_period = ESMF_TimeInit(1_8, 0_8)
daily_offset = ESMF_TimeInit(0_8, 0_8)
day_alarm = ESMF_AlarmInitPeriodic(daily_period, daily_offset)

do while (.not.ESMF_TimeMgrLastStep(timeMgr))
   call ESMF_TimeMgrAdvance(timeMgr)

! get some time and date diagnostics and print
   nstep = ESMF_TimeMgrGetNStep( timeMgr )
   currdate = ESMF_TimeMgrGetCurrDate ( timeMgr )
   call ESMF_DateGetIS(currdate, ndate, nsec)
   print*,'advanced nstep, ndate, nsec ',nstep, ndate, nsec

! test alarms
   if(ESMF_AlarmIsOn(month_alarm, timeMgr)) print *,'MONTHLY ALARM'
   call ESMF_AlarmSet(month_alarm, .false.)
   if(ESMF_AlarmIsOn(day_alarm, timeMgr)) print *,'DAILY ALARM'
   call ESMF_AlarmSet(day_alarm, .false.)
enddo

end program esmf_test
