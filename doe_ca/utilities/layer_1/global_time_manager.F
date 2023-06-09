!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

        module global_time_manager

!-----------------------------------------------------------------
!       PURPOSE : This module provides the user interface to the
!          time management of the coupled climate model. The routines labelled global
!          here are intended to be called only from the coupled
!          system driver, coupler_driver/source/driver.F. All ESMF
!          time management routines are accessed through the routines
!          here. Other routines are intended as utilities for 
!          use by component time managers.
!       HISTORY :
!          Created - 2004 Apr 14 Don Dazlich (dazlich@atmos.colostate.edu)
!          	   Public routines init_time_manager_global and step_time_manager_global
!              are written for use by the coupled model driver. They can also be
!              used by the off-line component drivers meant to emulate the
!              coupled driver in standalone mode.
!-----------------------------------------------------------------

        use kinds
        use params_time_manager
        use time_manager_utilities
        use params_physical
        use params_global_MPH
        use params_MPI
        use ESMF_Mod

	    implicit none
        save
        private

#if mpi == 1
   include 'mpif.h'
#endif
        
!  ESMF variables
        type (ESMF_Time)  ::            &
           current_time,         & ! the time at the end of the current timestep
           previous_time,        & ! the time at the start of the current timestep
           start_time,           & ! the time at the start of the current integration
           stop_time               ! the time to terminate the current integration
        type (ESMF_TimeInterval)  ::    &
           basic_timestep,       & ! the basic timestep of the coupled system;
                                   ! all components are called once every basic timestep
           restart_interval        ! the interval restarts for all components are written
        type (ESMF_Calendar)  ::        &
           global_calendar         ! the calendar of the coupled driver
        type (ESMF_Clock), public ::    &
           global_clock            ! the clock of the coupled driver
        type (ESMF_Alarm)  ::           &
           restart_alarm,        & ! the alarm for writing restarts
           newday_alarm,         & ! the alarm for the start of a new day
           newmonth_alarm,       & ! the alarm for the start of a new month
           newyear_alarm           ! the alarm for the start of a new year
        character (len=ESMF_MAXSTR) ::  &
           tstring                 ! string for storing time for output
        character (len=ESMF_MAXSTR) ::  &
           stoptstring             ! string for storing time for output
	    integer (kind=int_kind) :: rc   ! ESMF return code
        integer (kind=int_kind) ::                &
           secondofday      !work variable
        integer (kind=ESMF_KIND_I8), public ::      &
           step_count8 
	      
! public time manager variables

! the restart timestamp - two components, year and secondofyear, dayofyear is for other things
        integer (kind=int_kind), public ::      &
           glbl_timestamp_year,       &   ! year in timestamp read or written to restarts
           glbl_timestamp_dayofyear,  &   ! dayofyear
           glbl_timestamp_second_of_year  ! second of year in timestamp read or written to restarts
           
! current time information
        character (len=ESMF_MAXSTR), public ::  &
           glbl_current_tstring           ! string for current time
        integer (kind=int_kind), public ::      &
           glbl_step_count  
        integer (kind=int_kind), public ::      &
           glbl_current_year,         &   
           glbl_current_month,        &   
           glbl_current_day,          &   
           glbl_current_hour,         &   
           glbl_current_minute,       &   
           glbl_current_second,       &
           glbl_dt_s                   ! basic timestep, seconds  
        real (kind=dbl_kind), public ::         &
           glbl_time_of_day            ! fractional time of day (00Z midnight=0.0, 12Z noon=0.5)

! public alarms        
        logical (kind=log_kind), public ::      &
           l_halt,               &   ! if true, model integration is to be halted
           glbl_l_init,          &   ! if true, the clock is at the start_time
           glbl_l_newyear,       &   ! if true, time is 00Z of a new year
           glbl_l_newmonth,      &   ! if true, time is 00Z of a new month
           glbl_l_newday,        &   ! if true, time is 00Z of a new day
           l_restart_global          ! if true, write restarts for all components
           
        public ::                  &
           init_time_manager_global,    &
           step_time_manager_global
!****************************************************************

        contains

!****************************************************************


!=================================================================
! BEGINNING OF INIT_TIME_MANAGER
!=================================================================
	subroutine init_time_manager_global
	
! This routine will initialize the coupled model time manager. 

      logical (kind=log_kind) ::    &
	     l_tem,               & ! temporary logical
         reinit_start_time,   & ! if true, set the run start time to the value
                                ! read in from the namelist, else use value in restart
         stop_time_abs,       & ! if true, the stop time is read in as an absolute date
                                ! and time, else as an interval
         set_restart_reftime    ! if true, an independent reference time for the restart
                                ! interval is set, else the start_time is used
     integer (kind=int_kind) ::    &
         start_yy=0,          & ! the starting year
         start_mm=0,          & ! the starting month of year
         start_d=0,           & ! the starting day of month
         start_h=0,           & ! the starting hour
         start_m=0,           & ! the starting minute
         start_s=0,           & ! the starting second
         restart_yy=0,        & ! the restart interval year
         restart_mm=0,        & ! the restart interval month
         restart_d=0,         & ! the restart interval day
         restart_h=0,         & ! the restart interval hour
         restart_m=0,         & ! the restart interval minute
         restart_s=0,         & ! the restart interval second
         stop_yy=0,           & ! the stopping year (or interval)
         stop_mm=0,           & ! the stopping month (or interval)
         stop_d=0,            & ! the stopping day of month (or interval)
         stop_h=0,            & ! the stopping hour (or interval)
         stop_m=0,            & ! the stopping minute (or interval)
         stop_s=0,            & ! the stopping second (or interval)
         ref_yy=0,            & ! the restart reference year
         ref_mm=0,            & ! the restart reference month
         ref_d=0,             & ! the restart reference day of month
         ref_h=0,             & ! the restart reference hour
         ref_m=0,             & ! the restart reference minute
         ref_s=0                ! the restart reference second

      integer (kind=int_kind) :: ierr ! mpi return code
        type (ESMF_TimeInterval)  ::    &
           run_interval       ! length of run, needed if stop_time_abs is false
        type (ESMF_TimeInterval)  ::    &
           tem_interval       ! workspace time interval
        type (ESMF_TimeInterval)  ::    &
           rst_interval       ! restart time interval
        type (ESMF_Time)  ::    &
           ref_time           ! the reference time for the restart clock

! Test for the existence of file 'restart_timestamp'. If it exists, read
!   the timestring inside.
         coupler_coldstart = .true.
		 
         INQUIRE (FILE='restart_timestamp',EXIST=restart_exist)
         if(restart_exist) then
            open(unit=2,file='restart_timestamp',form='formatted')
            read(2,*,iostat=ierr)restart_timestring
            if(ierr.ne.0) then
               restart_exist = .false.
               print *,'problem reading restart timestamp ',ierr
            endif
            close(2)
			
			if(restart_exist) then
! Test for existence of coupler restart file for coldstarting model
		  	  INQUIRE (FILE='restarts/model_restart_coupler.'//trim(restart_timestring), &
			           EXIST=l_tem)
			  coupler_coldstart = .not.l_tem
            endif

         endif
         
! Get the necessary input parameters needed to initialize the time manager.
! These will be read in on from process 0 and broadcast to all processes.

      if(my_proc_global == 0) then

         open(unit=2,file='data/namelist_time_global',form='formatted')
            read(2,*) reinit_start_time
            read(2,*) start_yy, start_mm, start_d, start_h, start_m, start_s
            read(2,*) stop_time_abs
            read(2,*) stop_yy, stop_mm, stop_d, stop_h, stop_m, stop_s
            read(2,*) glbl_dt_s
            read(2,*) restart_yy, restart_mm, restart_d, restart_h, restart_m, restart_s
            read(2,*) set_restart_reftime
            read(2,*) ref_yy, ref_mm, ref_d, ref_h, ref_m, ref_s
            read(2,*,iostat=rc)perpetual_day, perpetual_dayofyear
            if(rc /= 0) perpetual_day = .false.
         close(2)
         
! if the restart exists, overwrite the start time variables
         if(restart_exist) then
            call timestring_to_time(                                    &
                                 restart_timestring,                    &
                                 start_yy,                              &
                                 start_mm,                              &
                                 start_d,                               &
                                 start_h,                               &
                                 start_m,                               &
                                 start_s,                               &
                                 ierr )
            if(ierr .ne. ESMF_SUCCESS)                                  &
                 print *,' failed extracting restart time, rc = ',ierr
         endif
         
      endif
      
! broadcast these input times to all processes
#if mpi == 1
      call MPI_BCAST (  start_yy, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (  start_mm, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (   start_d, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (   start_h, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (   start_m, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (   start_s, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (restart_yy, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (restart_mm, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST ( restart_d, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST ( restart_h, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST ( restart_m, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST ( restart_s, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (   stop_yy, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (   stop_mm, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (    stop_d, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (    stop_h, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (    stop_m, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (    stop_s, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (    ref_yy, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (    ref_mm, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (     ref_d, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (     ref_h, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (     ref_m, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (     ref_s, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST ( glbl_dt_s, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (  reinit_start_time, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (      stop_time_abs, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (set_restart_reftime, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (      perpetual_day, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
      call MPI_BCAST (perpetual_dayofyear, 1, mpi_int_type, 0,  MPI_COMM_WORLD, ierr)
#endif

! initialize the logicals
      l_halt = .false.
      glbl_l_newday = .false.
      l_restart_global = .false.
      glbl_l_init = .true.
	


! initialize the ESMF time manager functions to create a clock  

! our  calendar is prescribe to be a 365 day, no leap year calendar
      global_calendar = ESMF_CalendarCreate(name="NoLeap 365 Day",  &
                                           calendartype=ESMF_Cal_Noleap, rc=rc )

! Set the basic coupler time step for prognosing components
      call ESMF_TimeIntervalSet( basic_timestep, s=glbl_dt_s,   rc=rc )
                                                     
      start_year = start_yy
! Set the time at the start of the integration
      call ESMF_TimeSet( time=start_time,                         &
                         yy=start_yy,                             &
                         mm=start_mm,                             &
                         dd=start_d,                              &
                         h =start_h,                              &
                         m =start_m,                              &
                         s =start_s,                              &
                         calendar=global_calendar, rc=rc )

! Set the time of the end of the integration                         
      if(stop_time_abs) then
      
! The stop time was specified in the namelist, set stop_time directly
         call ESMF_TimeSet( time=stop_time,                       &
                            yy=stop_yy,                           &
                            mm=stop_mm,                           &
                            dd=stop_d,                            &
                            h =stop_h,                            &
                            m =stop_m,                            &
                            s =stop_s,                            &
                            calendar=global_calendar, rc=rc )
      else
      
! The run length was specified in the namelist. Use this to define
!   a time interval and add that interval to start_time to get stop_time
         call ESMF_TimeIntervalSet( run_interval,                 &
                                    yy=stop_yy,                   &
                                    mm=stop_mm,                   &
                                    d =stop_d,                    &
                                    h =stop_h,                    &
                                    m =stop_m,                    &
                                    s =stop_s,                    &
                                    calendar=global_calendar, rc=rc )
         stop_time = start_time + run_interval
      endif

! All the elements are in place - create the clock                            
      global_clock = ESMF_ClockCreate("Global Clock", basic_timestep,   &
                                      start_time, stop_time, rc=rc )

! Set the time interval for writing restarts for all components
      call ESMF_TimeIntervalSet( rst_interval,                    &
                                 yy=restart_yy,                   &
                                 mm=restart_mm,                   &
                                 d =restart_d,                    &
                                 h =restart_h,                    &
                                 m =restart_m,                    &
                                 s =restart_s,                    &
                                 calendar=global_calendar, rc=rc )
                                 
! set a clock for restart intervals
      if(set_restart_reftime) then
     
! the restart clock has its own reference time
         call ESMF_TimeSet( time=ref_time,                        &
                            yy=ref_yy,                            &
                            mm=ref_mm,                            &
                            dd=ref_d,                             &
                            h =ref_h,                             &
                            m =ref_m,                             &
                            s =ref_s,                             &
                            calendar=global_calendar, rc=rc )
                            
         if(ref_time < start_time) ref_time = start_time
      else
      
! the restart clock is identical to the global clock
         ref_time = start_time
      endif

! set the current time, initialize the previous time
      current_time = start_time
      previous_time = start_time

! get the public elements of the current time
      call ESMF_TimeGet(current_time,                            &
                        yy=glbl_current_year,                    &
                        mm=glbl_current_month,                   &
                        dd=glbl_current_day,                     &
                        h =glbl_current_hour,                    &
                        m =glbl_current_minute,                  &
                        s =glbl_current_second,                  &
                        rc=rc )
      glbl_time_of_day = ((float(glbl_current_second)/60. +      &
                           float(glbl_current_minute) )/60. +    &
                           float(glbl_current_hour) )/24.
      call ESMF_TimeGet(current_time,                            &
                        yy=glbl_timestamp_year,                  &
                        dayofyear=glbl_timestamp_dayofyear,      &
                        rc=rc )
      secondofday = glbl_current_second +                        &
                    60*(glbl_current_minute +                    &
                    60*(glbl_current_hour))
      glbl_timestamp_second_of_year = secondofday +              &
                   86400*(glbl_timestamp_dayofyear-1)

! alarm for restarts
      restart_alarm = ESMF_AlarmCreate('Global Restart',          &
                                       clock=global_clock,        &
                                       ringtime=ref_time,         &
                                       ringInterval=rst_interval, &
                                       ringtimestepcount=1,       &
                                       sticky=.true.,            &
                                       rc=rc )
                                 
! alarm for start of each day
      call ESMF_TimeIntervalSet( tem_interval, d=1, rc=rc )
      call ESMF_TimeSet(ref_time,                                &
                        yy=glbl_current_year,                    &
                        mm=glbl_current_month,                   &
                        dd=glbl_current_day,                     &
                        calendar=global_calendar, rc=rc )
      if(ref_time < current_time) ref_time = ref_time + tem_interval
      newday_alarm = ESMF_AlarmCreate('New Day',                 &
                                      clock=global_clock,        &
                                      ringtime=ref_time,         &
                                      ringInterval=tem_interval, &
                                      ringtimestepcount=1,       &
                                      sticky=.true.,            &
                                      rc=rc )

! alarm for start of each month
      call ESMF_TimeIntervalSet( tem_interval, mm=1, rc=rc )
      call ESMF_TimeSet(ref_time,                                &
                        yy=glbl_current_year,                    &
                        mm=glbl_current_month,                   &
                        calendar=global_calendar, rc=rc )
      if(ref_time < current_time) ref_time = ref_time + tem_interval
      newmonth_alarm = ESMF_AlarmCreate('New Month',               &
                                        clock=global_clock,        &
                                        ringtime=ref_time,         &
                                        ringInterval=tem_interval, &
                                        ringtimestepcount=1,       &
                                        sticky=.true.,            &
                                        rc=rc )

! alarm for start of each year
      call ESMF_TimeIntervalSet( tem_interval, yy=1, rc=rc )
      call ESMF_TimeSet(ref_time,                                &
                        yy=glbl_current_year,                    &
                        calendar=global_calendar, rc=rc )
      if(ref_time < current_time) ref_time = ref_time + tem_interval
      newyear_alarm = ESMF_AlarmCreate('New Year',                &
                                       clock=global_clock,        &
                                       ringtime=ref_time,         &
                                       ringInterval=tem_interval, &
                                       ringtimestepcount=1,       &
                                       sticky=.true.,            &
                                       rc=rc )
                                             
      
! some diagnostic prints
! I am not using ESMF_timeprint because its output gets out of sync of the
!   print statements
      call ESMF_Timeget(start_time, timestring=tstring, rc=rc)
      if(my_proc_global == 0) print *,'starting time = ',trim(tstring)
      call ESMF_Timeget(stop_time, timestring=stoptstring, rc=rc)
      if(my_proc_global == 0) print *,'stopping time = ',trim(stoptstring)
      call ESMF_ClockGet(global_clock, advanceCount=step_count8, rc=rc)
      call ESMF_Timeget(current_time, timestring=glbl_current_tstring, rc=rc)
      if(my_proc_global == 0) print *,'Time step ',glbl_step_count,    &
                                ' current time = ',trim(glbl_current_tstring)
      glbl_step_count = step_count8
      

! initialize all logical alarms false
    glbl_l_newday = .false.
    glbl_l_newmonth = .false.
    glbl_l_newyear = .false.
    l_restart_global = .false.

	end subroutine init_time_manager_global
!======================================================================
! END OF INIT_TIME_MANAGER
!======================================================================


!======================================================================
! BEGINNING OF TIME_MANAGER
!======================================================================
    subroutine step_time_manager_global
! This routine advances the clock one time step and tests alarms
!   and for termination as specified in the initialization.
    
    glbl_l_init = .false.

! reset all logical alarms false
    glbl_l_newday = .false.
    glbl_l_newmonth = .false.
    glbl_l_newyear = .false.
    l_restart_global = .false.
    
!   Advance the clocks one time step, update previous and current times
       previous_time = current_time
       call ESMF_ClockAdvance(global_clock, rc=rc)
       call ESMF_ClockGet(global_clock, currTime=current_time, rc=rc)
       
! get the public elements of the current time
      call ESMF_TimeGet(current_time,                            &
                        yy=glbl_current_year,                    &
                        mm=glbl_current_month,                   &
                        dd=glbl_current_day,                     &
                        h =glbl_current_hour,                    &
                        m =glbl_current_minute,                  &
                        s =glbl_current_second,                  &
                        rc=rc )
      glbl_time_of_day = ((float(glbl_current_second)/60. +      &
                           float(glbl_current_minute) )/60. +    &
                           float(glbl_current_hour) )/24.
 
       call ESMF_TimeGet(current_time,                            &
                        yy=glbl_timestamp_year,                   &
                        dayofyear=glbl_timestamp_dayofyear,       &
                        rc=rc )
      secondofday = glbl_current_second +                        &
                    60*(glbl_current_minute +                    &
                    60*(glbl_current_hour))
      glbl_timestamp_second_of_year = secondofday +               &
                       86400*(glbl_timestamp_dayofyear-1)

      call ESMF_ClockGet(global_clock, advanceCount=step_count8, rc=rc)
      call ESMF_Timeget(previous_time, timestring=tstring, rc=rc)
      call ESMF_Timeget(current_time, timestring=glbl_current_tstring, rc=rc)
      if(my_proc_global == 0) then
         print *,'Coupler Driver: Time step ',glbl_step_count
         print *,'   Time at beginning of step = ', trim(tstring)
         print *,'   Time at end of step = ', trim(glbl_current_tstring)
      endif
      glbl_step_count = step_count8
       
! Have we reached the stop time? If so, set l_halt true
       l_halt = ESMF_ClockIsStopTime(global_clock, rc)
       
! Test the newday, restart alarms
       l_restart_global = ESMF_AlarmIsRinging(restart_alarm,rc)
       call ESMF_AlarmRingerOff(restart_alarm, rc)
       glbl_l_newday         = ESMF_AlarmIsRinging(newday_alarm,rc)
       call ESMF_AlarmRingerOff(newday_alarm, rc)
       glbl_l_newmonth       = ESMF_AlarmIsRinging(newmonth_alarm,rc)
       call ESMF_AlarmRingerOff(newmonth_alarm, rc)
       glbl_l_newyear        = ESMF_AlarmIsRinging(newyear_alarm,rc)
       call ESMF_AlarmRingerOff(newyear_alarm, rc)
      if(my_proc_global == 0) then
       print *,'GLOBAL ALARMS:'
       if(l_restart_global) then
          print *,'   global restart '
          open(unit=3,file='restart_timestamp',form='formatted')
            write(3,*)trim(glbl_current_tstring)
          close(3)
       endif
       if(glbl_l_newday)        print *,'   global newday '
       if(glbl_l_newmonth)      print *,'   global newmonth '
       if(glbl_l_newyear)       print *,'   global newyear '
      endif
    end subroutine step_time_manager_global
!======================================================================
! END OF TIME_MANAGER
!======================================================================

	end module global_time_manager
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
