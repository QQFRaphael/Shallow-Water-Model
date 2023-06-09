!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||


	module swm_parameters
	
!----------------------------------------------------------------------
!     Purpose:		
!     This module specifies parameters related to the model
!     some of these parameters are specifed at compile time,
!     while others specified at run time.
!
!     Author: Atul Nulkar
!     Modified original code on 03/16/2002 to conform to CCM4 standard
!
!----------------------------------------------------------------------

	use kinds
	use params_physical
	
	implicit none
	save

        integer (kind=int_kind), public :: MPI_COMM_swm, my_comp_id, errorCode

        logical, parameter ::                           &
                        l_sphere      = .false.,        & ! assume spherical distances/surfaces     
                        l_dx          = .true.          


	real (kind=dbl_kind) ::                        &
      			dt,                            & ! dt  	      : time step (seconds)
      			invdt,                         &
      			dtphy,                         & ! dtphy      : physics time step 
      							 !	        (seconds)
      							       							 
      			relaxation,                    & ! relaxation : relaxation used in 
      							 !	        semi_implicit scheme [0,1]
      							 
      			weight,                        & ! weight     : weights used in 
      							 !	   	semi_implicit scheme [0,1]
      							 
      			mu,                            & ! mu	      : del4 viscosity (m4/s)
      			total_area,		       & ! total_area : sum of area_mask	
      			w3,                            &
      			w2,                            &
      			w1

	integer (kind=int_kind) ::                     &
      			n4,                            &
      			n3,                            &
      			n2,                            & ! n{4,3,2}   : pointers to time level 
      							 !		{n+1,n,n-1} for prognostics
      							 
      			n3_f,                          &
      			n2_f,                          &
      			n1_f,                          & ! n{3,2,1}_f : pointers to time level 
      							 !		{n,n-1,n-2} for time 
      							 !		tendency arrays
      							 
      			nvcycle,                       & ! nvcycle    : number of V cycles to do 
      							 !	        each time step
      							 
      			naverage			 ! naverage   : average every naverage 
      							 !              time steps when doing leap frog 

	integer (kind=int_kind), parameter ::          &
      			ntracer = 5,                   & ! ntracer should be >= 2
      			ntprog = 2,                    &
      			nttend = 3   

        logical (kind=log_kind), parameter ::           &
           l_swtc2 = .false.    ! if true, use SWTC2 initial conditions
                                ! if false, use SWTC5

!-----------------------------------------------------------------------
! pick an advection scheme in the namelist file, the default is false
!-----------------------------------------------------------------------
        logical :: l_upwind = .false.,                       &
                   l_centered = .false.,                     &
                   l_fct = .false.,                          &
                   l_remap = .false.

        character(len=3) :: swm_name

!**********************************************************************

	contains

!**********************************************************************


!======================================================================
! BEGINNING OF INIT_swm_parameters
!======================================================================

	subroutine init_swm_parameters

!----------------------------------------------------------------------
!
!     Purpose:		
!     This subroutine initializes some of the swm parameters 
!     at compile time.
!
!     Author: Atul Nulkar
!     Modified original code on 03/16/2002 to conform to CCM4 standard
!
!----------------------------------------------------------------------

	implicit none

	dt = c0
	dtphy = c0
	invdt = c0
	relaxation = c0
	weight = c0
	mu = c0
	total_area = c0
	w3 = c0
	w2 = c0
	w1 = c0
	n4 = 0
	n3 = 0
	n2 = 0
	n3_f = 0
	n2_f = 0
	n1_f = 0
	nvcycle = 0
	naverage = 0
	swm_name = 'swm'

	end subroutine init_swm_parameters

!======================================================================
! END OF INIT_swm_PARAMETERS
!======================================================================

	end module swm_parameters

!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
