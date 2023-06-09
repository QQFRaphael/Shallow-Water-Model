!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

	module model_control

!-----------------------------------------------------------------
! 	this module hold variables which are specified at runtime
!	  or vary as the integration proceeds.does most of the i/o
!-----------------------------------------------------------------

	use kinds
	use params_physical
	use time_manager_module
	use swm_parameters

	implicit none
	save

!****************************************************************

	contains

!****************************************************************


!===========================================================================
! BEGINNING OF GET_POINTERS
!===========================================================================
        subroutine get_pointers

!----------------------------------------------------------------------------
! pointers hardwired for Adams Bashforth 3rd Order integration
!	n4 is the n+1 time slot for prognostics
!	n3 is the n   time slot for prognostics
!	n2 is not used in AB3
!	
!	n3_f is the n   time slot for prognostic tendencies
!       n2_f is the n-1 time slot for prognostic tendencies
!       n1_f is the n-2 time slot for prognostic tendencies
!----------------------------------------------------------------------------

        n4   = MOD (step_count+1,2) + 1 ! {2,1}
        n3   = MOD (step_count+0,2) + 1 ! {1,2}
        n2   = 0
        n3_f = MOD (step_count+2,3) + 1 ! {3,1,2}
        n2_f = MOD (step_count+1,3) + 1 ! {2,3,1}
        n1_f = MOD (step_count+0,3) + 1 ! {1,2,3}

        end subroutine get_pointers
!===========================================================================
! END OF GET_POINTERS
!===========================================================================



!===========================================================================
! BEGINNING OF GET_WEIGHTS
!===========================================================================
        subroutine get_weights

!----------------------------------------------------------------------------
! time integration weights
! for an field A:
!   A(n4) = A(n3) + w3*A_f(n3_f) + w2*A_f(n2_f) + w1*A_f(n1_f)
!----------------------------------------------------------------------------

        implicit none

        real (kind=dbl_kind), parameter ::                                 &
                        w3_ab3 = 1.916666666666666666666_dbl_kind,         &
                        w2_ab3 =-1.333333333333333333333_dbl_kind,         &
                        w1_ab3 = 0.416666666666666666666_dbl_kind

        if (step_count <= 1) then     ! Euler forward time step
          w3 =  1.0
          w2 =  0.0
          w1 =  0.0
        endif
        if (step_count == 2) then     ! AB 2nd order time step
          w3 =  1.5
          w2 = -0.5
          w1 =  0.0
        endif
        if (step_count >= 3) then     ! AB 3rd order time step
          w3 = w3_ab3
          w2 = w2_ab3
          w1 = w1_ab3
        endif

        end subroutine get_weights
!===========================================================================
! END OF GET_WEIGHTS
!===========================================================================


!===========================================================================
! BEGINNING OF INPUT
!===========================================================================
      SUBROUTINE input
 
!-----------------------------------------------------------------
! READ NAMELIST
! namelist is opened as unit 2
!-----------------------------------------------------------------
        OPEN (UNIT=2,FILE='./data/namelist',FORM='FORMATTED',STATUS='OLD')
        READ (2,02) tau_end_day
        READ (2,02) tau_end_hour
        READ (2,02) dt
        READ (2,04) l_restart
	READ (2,04) l_upwind
	READ (2,04) l_centered
	READ (2,04) l_fct
	READ (2,04) l_remap
	READ (2,*) n_restart
        READ (2,*) n_output
        READ (2,*) n_diagnostics
        CLOSE (UNIT=2)
   01   FORMAT (A40 )
   02   FORMAT (F7.2)
   03   FORMAT (I4  )
   04   FORMAT (L1  )

!----------------------------------------------------------------------
! compute time as the sum of days and hours if tau_end == 0.0
!----------------------------------------------------------------------
        tau_end = 24.*tau_end_day+tau_end_hour-0.001
 
! echo data to standard out
	if(my_task==0) then
	write(6,*)
        PRINT *, ' input : tau_end        = ',tau_end
        PRINT *, ' input : tau_end_day    = ',tau_end_day
        PRINT *, ' input : tau_end_hour   = ',tau_end_hour
        PRINT *, ' input : time step      = ',dt
	write(6,*)
	endif

	invdt = c1/dt

	end subroutine input
!===========================================================================
! END OF INPUT
!===========================================================================

	end module model_control

!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
