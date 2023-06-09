!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

        module time_manager_module

!-----------------------------------------------------------------
!       PURPOSE : keeps track of current time and logicals based
!	   on time
!-----------------------------------------------------------------

        use kinds
        use params_parallel_xxx
        use params_physical
	use swm_parameters

	implicit none
        save

        logical (kind=log_kind) ::          &
                        l_restart,	    &! write a restart on T
                        l_halt,		    &! halt on T
                        l_output,	    &! write output on T
                        l_diagnostics,	    &! compute diagnostcs on T
                        l_timer		     ! write out timing stats on T

	integer (kind=int_kind) ::          &
                        n_restart,	    &! write restart every n_restart steps
                        n_output,	    &! write output every n_output steps
                        n_diagnostics	     ! do diagnostics every n_diagnostics steps

        real (kind=dbl_kind) ::             &
                        tau,		    &! time measured in hours
                        tofday,		    &! time of day
                        tau_end,	    &! end time == tua_end_days*24 + tau_end_hours
                        tau_end_day,	    &! end time in days
                        tau_end_hour	     ! end time in hours

        real (kind=dbl_kind) ::             &
                        restart_freq,       &
                        restart_count

        integer (kind=int_dbl_kind) ::          &
                        nsecond_dyn 	     ! time measured in integer seconds

        integer (kind=int_kind) ::          &
                        step_count	     ! step count (starts at zero at beginning of run)


!****************************************************************

        contains

!****************************************************************


!=================================================================
! BEGINNING OF INIT_TIME_MANAGER
!=================================================================
	subroutine init_time_manager

        l_restart =.false.
        l_halt  = .false.
        l_output = .false.
        l_diagnostics =.false.
        nsecond_dyn = 0
        step_count = 0
        tau = c0
        tau_end = c0
        tau_end_day = c0
        tau_end_hour = c0
        restart_freq = 0
        restart_count = 0

	end subroutine init_time_manager
!======================================================================
! END OF INIT_TIME_MANAGER
!======================================================================


!======================================================================
! BEGINNING OF TIME_MANAGER
!======================================================================
        subroutine time_manager

!-------------------------------------------------------------------------
! reset logicals
!-------------------------------------------------------------------------
        l_halt = .false.
        l_restart = .false.
        l_output = .false.
        l_diagnostics = .false.

!-------------------------------------------------------------------------
! increment the step counter (integer) and time (integer  seconds)
!-------------------------------------------------------------------------
        step_count = step_count + 1
        nsecond_dyn = nsecond_dyn + dt

!-------------------------------------------------------------------------
! find time in hours
!-------------------------------------------------------------------------
        tau = nsecond_dyn/3600.0
        tofday = mod(tau-dt/3600.0_dbl_kind, 24.0_dbl_kind)
	if(my_task==0) write(6,*) step_count,nsecond_dyn,tau

!-------------------------------------------------------------------------
! based on tau or step_count, set logicals
!-------------------------------------------------------------------------
        if(tau > tau_end) l_halt=.true.
        if(mod(step_count,n_restart     ) == 0) l_restart = .true.
        if(mod(step_count,n_output      ) == 0) l_output = .true.
        if(mod(step_count,n_diagnostics ) == 0) l_diagnostics = .true.

        end subroutine time_manager
!======================================================================
! END OF TIME_MANAGER
!======================================================================

	end module time_manager_module
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
