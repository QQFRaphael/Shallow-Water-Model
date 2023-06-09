!======================================================================
! PROGRAM SWM
!======================================================================

	program swm

!-----------------------------------------------------------------------
! PURPOSE : driver for the swm
!-----------------------------------------------------------------------

	use kinds
	use params_parallel_xxx
	use params_physical
        use timer
        use swm_parameters
	use prognostics
	use wrap_data
  	use initialize
	use model_control
	use time_manager_module
 	use step
	use dx_module
	use budgets
        use swm_qp_module
        use swm_restart
        use params_global_MPH
!	use swm_dissipation_operator

#if mpi == 1
   use MPH_module
#endif

        implicit none

! MPI Communicator of local executable world
        integer (kind=int_kind) :: driver_world

! MPI Communicator - dummy
        integer (kind=int_kind) :: communicator

! error handler returns the error code
! 0 = OK, -1 = ERROR
        integer (kind=int_kind) :: errcode, n

        integer (kind=int_kind) :: k, i, j
        real (kind=dbl_kind) :: riter=0.0_dbl_kind, rlat, rlon
        real (kind=dbl_kind) :: rsecond
        integer (kind=int_kind) :: ierror
        real (kind=dbl_kind), dimension(iim,jjm,2,nsdm) :: workht

!-------------------------------------------------------------------------
! start the model timings
!-------------------------------------------------------------------------
        call timer_start('total time')

!-------------------------------------------------------------------------
! init the stand-alone version as if it were a coupled model run
!-------------------------------------------------------------------------
#if mpi == 1
      call MPH_debug (1)
      call MPI_init(errcode)
      driver_world =  MPH_components( name1="coupler",name2="swm")           ! "swm"  is present
#endif

      call init_params_global_MPH

! register this component for intra-component communications
!           call initialize_component('swm')
!           call set_component_parallel('swm',                      &
!                                        ntotprocs, my_proc_global, 0,       &
!                                        0, driver_world )
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

!-------------------------------------------------------------------------
! INITIALIZATION MODEL STATE
!-------------------------------------------------------------------------
        call timer_start('initialization')
 	call initialize_model
	call wrap_prognostics
	if (l_swtc2) then                                                     
	   workht(:,:,1,:) = h(:,:,n3,:) * tracer(:,:,1,n3,:)
	   workht(:,:,2,:) = h(:,:,n3,:) * tracer(:,:,2,n3,:)
           call tracer_error_norms (2, workht, .true.)
	endif
        call timer_stop('initialization')

!-------------------------------------------------------------------------
! INTEGRATION : stop model based on logical halt
!-------------------------------------------------------------------------
        do while(.not.l_halt)

!-------------------------------------------------------------------------
! update time
!-------------------------------------------------------------------------
	  call timer_start('time manager')
          call time_manager
	  call timer_stop('time manager')

!------------------------------------------------------------------
! based on the time step, get pointers and weights
!------------------------------------------------------------------
          call get_pointers
 	  call get_weights

!------------------------------------------------------------------
! get sources
!------------------------------------------------------------------
#if viscosity == 1
            call dissipation(             &
                component_name = swm_name,                 &
                norder = 2_int_kind,      &
                visc = 2.5e12_dbl_kind,      &
                xin = u(:,:,:,:,n3,:),          &
                xout = u_viscous(:,:,:,:,:))
#endif

!-------------------------------------------------------------------------
! move forward a time step
!-------------------------------------------------------------------------
 	  call step_dt

!-----------------------------------------------------------------
! wrap the data
!-----------------------------------------------------------------
	call timer_start('wrapping')
        call wrap_prognostics
	call timer_stop('wrapping')

!-------------------------------------------------------------------------
! output results based on logicals
!-------------------------------------------------------------------------
          if(l_restart) call write_swm_restart
          if(l_output) then
              call pack_swm_qp
              call write_swm_qp(nsecond_dyn)
              call timer_start('output')
	      riter = riter + c1
	      rsecond = float(nsecond_dyn)
              if(l_dx) then
	      call write_dx_data(                                &
!      			h(:,:,n4,:)+hs(:,:,:),                   &
      			h(:,:,n4,:),                             &
      			psi(:,:,:),                              &
      			chi(:,:,:),                              &
      			relative(:,:,:),                         &
      		        eta(:,:,n4,:),                           &
      			div(:,:,n4,:),                           &
      			ke(:,:,:),                               &
      			h_f(:,:,n3_f,:),                         &
      			u(:,:,:,:,n4,:),                         &
                        u_viscous(:,:,:,:,:),                    &
                        stress_tensor(:,:,:,:,:),                &
			tracer(:,:,1,n4,:),                      &
			tracer(:,:,2,n4,:),                      &
      			riter)
	       endif
              call timer_stop('output')
	  endif

          if(l_diagnostics) then
            call timer_start('diagnostics')
            call compute_budgets
            call timer_stop('diagnostics')
	  endif

        enddo   ! do while(.not.l_halt)

!-------------------------------------------------------------------------
! dump timings
!-------------------------------------------------------------------------
        call timer_stop('total time')
	call timer_write(swm_name)

!-------------------------------------------------------------------------
! compute SWTC2 tracer error norms
!-------------------------------------------------------------------------
	if (l_swtc2) then                                                     
	   workht(:,:,1,:) = h(:,:,n4,:) * tracer(:,:,1,n4,:)
	   workht(:,:,2,:) = h(:,:,n4,:) * tracer(:,:,2,n4,:)
           call tracer_error_norms (2, workht, .false.)
	endif

!-------------------------------------------------------------------------
! CLOSE MPI
!-------------------------------------------------------------------------
#if mpi == 1
        call MPI_FINALIZE(ierror )
#endif

	end program swm
!======================================================================
! END OF PROGRAM SWM
!======================================================================
