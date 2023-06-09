!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

	module budgets

!-----------------------------------------------------------------
! 	this module hold variables which are specified at runtime
!	  or vary as the integration proceeds.does most of the i/o
!-----------------------------------------------------------------

	use kinds
	use params_parallel_xxx
	use params_physical
	use swm_parameters
	use prognostics
	use grid_mask_variables_xxx
	use grid_metrics_variables_xxx
	use global_reductions

	implicit none
	save

!****************************************************************

	contains

!****************************************************************

!===========================================================================
! BEGINNING OF COMPUTE_BUGDETS
!===========================================================================
        subroutine compute_budgets

!-----------------------------------------------------------------
! PURPOSE : compute basic globally averaged budgets
!
! NOTE : coded to accomodated distributed processing, but not yet
!	 tested for distributed processing.
!
! FUNCTIONALITY : by calling "compute_budgets" with no arguments
!	this subroutine globally averages mass, pv, kinetic energy,
!	potential energy, total energy, and enstrophy. Also, the
!	differences in these terms from their initial values are
!	computed. The global averages are dumped to a binary file.
!	Hooks for computing linear are present, but not implemented.
!-----------------------------------------------------------------

        implicit none

	real (kind=dbl_kind) ::        &
      		work (iim,jjm,nsdm)	! work array

	real (kind=dbl_kind) ::        &
      		mass_ga,	       &! globally averaged mass
      		ke_ga,		       &! globally averaged kinetic energy
      		pe_ga,		       &! globally averaged potential energy
      		tf_ga,		       &! globally averaged "topographic" energy term
      		te_ga,		       &! globally averaged total energy
      		te_diff,	       &! fractional change in total energy from t=0 value
      		lte_diff, 	       &! log10 of te_diff
      		lm1_ga, 	       &! globally averaged linear momentum in east-direction
      		lm2_ga, 	       &! globally averaged linear momentum in north-direction
      		div_ga, 	       &! globally averaged divergence
      		eta_ga,		       &! globally averaged absolute vorticity
      		penst_ga, 	       &! globally averaged potential enstrophy
      		penst_diff, 	       &! fractional change in potential enstrophy
      		lpenst_diff,           &! log10 of penst_diff
                mtr1sq_ga,             &! globally averaged tracer 1 variance
                mtr2sq_ga,             &! globally averaged tracer 2 variance
                mtr1sq_diff,           &! fraction of initial tracer 1 variance
                mtr2sq_diff             ! fraction of initial tracer 1 variance

	real (kind=dbl_kind), save ::          &
      		te_ga0 = 0.0_dbl_kind, 	       &! t=0 value of te_ga
      		penst_ga0 = 0.0_dbl_kind,      &! t=0 value of penst_ga
      		lm1_ga0 = 0.0_dbl_kind,	       &! t=0 value of lm1_ga
      		lm2_ga0 = 0.0_dbl_kind,        &! t=0 value of lm2_ga
		mtr1sq_ga0 = 0.0_dbl_kind,     &! t=0 value of mtr1sq_ga
		mtr2sq_ga0 = 0.0_dbl_kind       ! t=0 value of mtr2sq_ga

	real (kind=real_kind), dimension(14) ::               &
      		r4			        ! a real*4 scalar used for output

	real (kind=real_kind), parameter ::    &
      		epsilon = 1.0e-15_dbl_kind      ! a small number

	integer (kind=int_kind) ::             &
      		size				! iim*jjm*nsdm

	logical, save :: init = .true.		! a flag to define init

!-----------------------------------------------------------------
! initialize
!-----------------------------------------------------------------
        mass_ga = c0
        ke_ga = c0
        pe_ga = c0
        tf_ga = c0 
	te_ga = c0
	penst_ga = c0
	mtr1sq_ga = c0
	mtr2sq_ga = c0
        size = iim*jjm*nsdm
	work = c0

!-----------------------------------------------------------------
! mass
!-----------------------------------------------------------------
	work = h(:,:,n4,:)*area(:,:,:)
        mass_ga = global_real_sum(work, grid_center_mask, size, swm_name)

!-----------------------------------------------------------------
! ke
!-----------------------------------------------------------------
	work = h(:,:,n4,:)*ke(:,:,:)*area(:,:,:)
        ke_ga = global_real_sum(work, grid_center_mask, size, swm_name)

!-----------------------------------------------------------------
! pe
!-----------------------------------------------------------------
	work = p5*grav*h(:,:,n4,:)*h(:,:,n4,:)*area(:,:,:)
        pe_ga = global_real_sum(work, grid_center_mask, size, swm_name)

!-----------------------------------------------------------------
! h*hs
!-----------------------------------------------------------------
	work = grav*h(:,:,n4,:)*hs(:,:,:)*area(:,:,:)
        tf_ga = global_real_sum(work, grid_center_mask, size, swm_name)

!-----------------------------------------------------------------
! potential enstrophy
!-----------------------------------------------------------------
	work = c0
	where(grid_center_mask.gt.c0) 
	   work = (eta(:,:,n4,:)**2/h(:,:,n4,:))*area(:,:,:)
	endwhere
	penst_ga = global_real_sum(work, grid_center_mask, size, swm_name)

!-----------------------------------------------------------------
! pv and div
!-----------------------------------------------------------------
	work = eta(:,:,n4,:)*area(:,:,:)
	eta_ga = global_real_sum(work, grid_center_mask, size, swm_name)
	work = div(:,:,n4,:)*area(:,:,:)
	div_ga = global_real_sum(work, grid_center_mask, size, swm_name)

!-----------------------------------------------------------------
! linear momentum
!-----------------------------------------------------------------
	lm1_ga = c0
	lm2_ga = c0

!-----------------------------------------------------------------
! mass-weighted tracer 1 and tracer 2 variance
!-----------------------------------------------------------------
	work = tracer(:,:,1,n4,:)*tracer(:,:,1,n4,:)             & 
             * h(:,:,n4,:)*area(:,:,:)
	mtr1sq_ga = global_real_sum(work, grid_center_mask, size, swm_name)

	work = tracer(:,:,2,n4,:)*tracer(:,:,2,n4,:)             & 
             * h(:,:,n4,:)*area(:,:,:)
	mtr2sq_ga = global_real_sum(work, grid_center_mask, size, swm_name)

!-----------------------------------------------------------------
! normalized by inv_tot_area and sum to find total energy
!-----------------------------------------------------------------
        mass_ga = mass_ga * inv_tot_area
        ke_ga = ke_ga * inv_tot_area
        pe_ga = pe_ga * inv_tot_area
        tf_ga = tf_ga * inv_tot_area
        te_ga = ke_ga + pe_ga + tf_ga
	penst_ga = penst_ga * inv_tot_area
	div_ga = div_ga * inv_tot_area
	eta_ga = eta_ga * inv_tot_area
	lm1_ga = lm1_ga * inv_tot_area
	lm2_ga = lm2_ga * inv_tot_area
        mtr1sq_ga = mtr1sq_ga * inv_tot_area
        mtr2sq_ga = mtr2sq_ga * inv_tot_area

!-----------------------------------------------------------------
! if it is the first time here, save values
! if not, compute differences from the initial values
!-----------------------------------------------------------------
        if(init) then
          te_ga0 = te_ga
          penst_ga0 = penst_ga
          lm1_ga0 = lm1_ga
          lm2_ga0 = lm2_ga
	  mtr1sq_ga0 = mtr1sq_ga
	  mtr2sq_ga0 = mtr2sq_ga
	  te_diff = c0
	  lte_diff = c0
	  lpenst_diff = c0
	  penst_diff = c0
	  mtr1sq_diff = c1
	  mtr2sq_diff = c1
	  init = .false.
        else
          te_diff = abs(te_ga - te_ga0) / (te_ga0 + epsilon)
	  lte_diff = log10(te_diff + epsilon)
	  penst_diff = abs(penst_ga-penst_ga0) /       &
      			  (penst_ga0+epsilon)
	  lpenst_diff = log10(penst_diff+epsilon)
	  mtr1sq_diff = mtr1sq_ga / mtr1sq_ga0
 	  mtr2sq_diff = mtr2sq_ga / mtr2sq_ga0
        endif

!-----------------------------------------------------------------
! dump to fort.31
!-----------------------------------------------------------------
	if(my_task==0) then
	r4(1) = mass_ga
	r4(2) = ke_ga
	r4(3) = pe_ga
	r4(4) = tf_ga
	r4(5) = te_ga
	r4(6) = te_diff
	r4(7) = lte_diff
	r4(8) = penst_ga
	r4(9) = penst_diff
	r4(10) = lpenst_diff
	r4(11) = eta_ga
	r4(12) = div_ga
	r4(13) = abs(lm1_ga)/(lm1_ga0 + epsilon)
	r4(14) = abs(lm2_ga)/(lm2_ga0 + epsilon)
	write(31) r4
#if sgi == 1
 	call flush(31)
#endif

!-----------------------------------------------------------------
! dump to stdout
!-----------------------------------------------------------------
	write(6,10)  mass_ga
	write(6,11)  lte_diff
	write(6,12)  lpenst_diff
	write(6,13)  mtr1sq_diff
	write(6,14)  mtr2sq_diff

 10	format(//,' Total Mass : ',e17.8)
 11     format(   ' Log10 of Frac Energy Change : ',e17.8)
 12     format(   ' Log10 of Frac Pot. Enstrophy Change : ',e17.8,//)
 13	format(   ' Fractional mass-weighted (tracer 1)^2  : ',e17.8)
 14	format(   ' Fractional mass-weighted (tracer 2)^2  : ',e17.8,//)

	endif

        end subroutine compute_budgets
!===========================================================================
! END OF COMPUTE_BUDGETS
!===========================================================================

!======================================================================
! BEGINNING OF TRACER_ERROR_NORMS
!======================================================================
      subroutine tracer_error_norms (ntrace, xprog, l_init)

      implicit none
!-------------------------------------------------------------------------
! PURPOSE: Compute tracer error norms for shallow-water test case 2 and
!          write to an ASCII file.
!
! NOTE: This routine is designed to be run only for SWTC2.
!       The routine is called once at initialization, then can be called 
!       again after an integral number of revolutions, at which point the 
!       tracer distribution would be the same as the initial condition if 
!       the model were perfect.
!-------------------------------------------------------------------------

!-------------------------------------------------------------------------
! INTENT IN
!-------------------------------------------------------------------------
      integer (kind=int_kind) ::                                         &
         ntrace                       ! number of tracer fields

      real (kind=dbl_kind) ::                                            &
         xprog(iim,jjm,ntrace,nsdm)   ! height*tracer fields

      logical (kind=log_kind) ::                                         &
         l_init                       ! true at initialization, then false

!-------------------------------------------------------------------------
! LOCAL
!-------------------------------------------------------------------------

      integer (kind=int_kind), parameter ::                              &
         ntracemax = 5       ! max number of fields passed to this routine

      real (kind=dbl_kind), save ::                                      &
         xinit(iim,jjm,ntracemax,nsdm)   ! initial height*tracer fields

      real (kind=dbl_kind), dimension(iim,jjm,nsdm) ::                &
         absdiff,   &! abs (trace_init - trace)
         diffsq,    &! (trace_init - trace) ^ 2
         truesq      ! trace_init ^ 2

      real (kind=dbl_kind) ::                                         &
	 diff,             &! trace_init - trace
         sumtruesq,        &! global sum of area*trace_init*trace_init
         sumdiffsq,        &! sum of area*diff*diff
         L2,               &! L2 norm 
         Linf,             &! L infinity norm 
         maxdiff,          &! max difference for Linf norm
         maxval             ! max field value for Linf norm

      integer (kind=int_kind) ::                                      &
         i, j, ksdm, nt

      if (l_init) then      ! initialize

! Store initial tracer fields

	 xinit(:,:,:,:) = c0
	 do nt = 1, ntrace
	    xinit(:,:,nt,:) = xprog(:,:,nt,:)
         enddo
      else                  ! compute error norms

	 if (my_task==0) then
	    open  (50, file='tracer_error_norms', status='replace')
	    write (50,*) 'Tracer #, L2 norm, Linf norm:'
	 endif

	 do nt = 1, ntrace

! Initialize

	    diffsq = c0
	    absdiff = c0
	    truesq = c0

! Compute differences between prognosed and initial field

	    do ksdm = 1, nsdm
	       do j = 1, jjm
	       do i = 1, iim
		  diff = xprog(i,j,nt,ksdm) - xinit(i,j,nt,ksdm)

                  ! Compute diffsq for L2 norm
		  diffsq(i,j,ksdm) = area(i,j,ksdm) * diff*diff
            
	          ! Compute abs(diff) for Linf norm
		  absdiff(i,j,ksdm) = abs(diff)

                  ! Compute term in denominator for L2 norm
		  truesq(i,j,ksdm) = area(i,j,ksdm)*xinit(i,j,nt,ksdm)  &
                                                   *xinit(i,j,nt,ksdm)
	       enddo
	       enddo
	    enddo

! Compute L2 norm

	    sumdiffsq = global_real_sum(diffsq, grid_center_mask,      &
                                        iim*jjm*nsdm, swm_name)
	    sumtruesq = global_real_sum(truesq, grid_center_mask,      &
                                        iim*jjm*nsdm, swm_name) 
            L2 = sqrt (sumdiffsq/sumtruesq)


! Compute Linf norm

	    maxdiff = global_real_maxval(absdiff*grid_center_mask,    &
                                         iim*jjm*nsdm, swm_name) 
            maxval  = global_real_maxval(xinit(:,:,nt,:)*grid_center_mask,&
                                         iim*jjm*nsdm, swm_name)
	    Linf = maxdiff / maxval

	    if (my_task==0) then
	       write (50,'(i3, 2e15.8)') nt, L2, Linf
	    endif
	   
	 enddo                  ! ntrace

	 close(50)

      endif                     ! l_init

      end subroutine tracer_error_norms
!======================================================================
! END OF TRACER_ERROR_NORMS
!======================================================================

	end module budgets

!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
