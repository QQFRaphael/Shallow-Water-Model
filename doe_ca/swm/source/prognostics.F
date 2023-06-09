!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

	module prognostics

!-----------------------------------------------------------------
!   contains arrays related to the prognostic variables, and
!       those diagnostic variables derived from the prognostic
!       variables
!-----------------------------------------------------------------

	use kinds
	use params_grid_horizontal_xxx
	use swm_parameters

	implicit none
	save

!-----------------------------------------------------------------
!   prognostics ntprog time levels
!-----------------------------------------------------------------
	real (kind=dbl_kind) ::                              &
              h      ( iim, jjm,          ntprog, nsdm),     &! fluid layer thickness (m)
              eta    ( iim, jjm,          ntprog, nsdm),     &! absolute vorticity (1/s)
              div    ( iim, jjm,          ntprog, nsdm),     &! divergence (1/s)
              tracer ( iim, jjm, ntracer, ntprog, nsdm)       ! tracer mixing ratio (kg/kg)

!-----------------------------------------------------------------
!   time tendency of prognostics at nttend time levels
!-----------------------------------------------------------------
        real (kind=dbl_kind) ::                              &
              h_f      ( iim, jjm,          nttend, nsdm),   &! layer thickness tendency (m/s)
              eta_f    ( iim, jjm,          nttend, nsdm),   &! absolute vorticity tendency (1/s**2)
              div_f    ( iim, jjm,          nttend, nsdm),   &! divergence tendency (1/s**2)
              tracer_f ( iim, jjm, ntracer, nttend, nsdm)     !  mixing ratio tendency (kg/kg/s)

!-----------------------------------------------------------------
!   diagnostically determined variables at layer centers
!-----------------------------------------------------------------
	real (kind=dbl_kind) ::                              &
              relative ( iim, jjm, nsdm),                    &! relative vorticity (1/s)
              ke       ( iim, jjm, nsdm),                    &! kinetic energy (m**2/s**2)
              psi      ( iim, jjm, nsdm),                    &! stream function (m**2/s)
              chi      ( iim, jjm, nsdm),                    &! velocity potential (m**2/s)
              inv_h    ( iim, jjm, nsdm)                      ! 1/h(:,:,n4)

!-----------------------------------------------------------------
!   fluxes across grid cell edges
!-----------------------------------------------------------------
	real (kind=dbl_kind) ::                              &
              mass_flux   (1,nedges,iim,jjm,        nsdm),   &! mass   flux at time level n
              tracer_flux (1,nedges,iim,jjm,ntracer,nsdm)     ! tracer flux at time level n

!-----------------------------------------------------------------
!   variables at grid corners
!-----------------------------------------------------------------
	real (kind=dbl_kind) ::                                       &
              u         ( nspace, ncorners, iim, jjm, ntprog, nsdm),  &! velocity vector (m/s)
              u_f       ( nspace, ncorners, iim, jjm, nttend, nsdm),  &! velocity vector tendency (m/s**2)
              ke_c      (         ncorners, iim, jjm,         nsdm),  &! 1/2 (u dot u)
              u_viscous ( nspace, ncorners, iim, jjm,         nsdm),  &! the viscous term (m/s**2)
              rayleigh  ( nspace, ncorners, iim, jjm,         nsdm)

!-----------------------------------------------------------------
!    tensors
!-----------------------------------------------------------------
        real (kind=dbl_kind) ::                                       &
              stress_tensor (r3, r3, iim, jjm, nsdm)
 
!-----------------------------------------------------------------
!   boundary conditions
!-----------------------------------------------------------------
	real (kind=dbl_kind) ::                              &
              hs   ( iim, jjm, nsdm),                        &! surface height (m)
              f    ( iim, jjm, nsdm)                          ! Coriolis parameter (1/s)


!*****************************************************************

	contains

!*****************************************************************


!======================================================================
! BEGINNING OF INIT_PROGNOSTICS
!======================================================================

	subroutine init_prognostics

	implicit none

        h = 1000.0
        eta = 0.0
        div = 0.0
        tracer = 1.0_dbl_kind
        h_f = 0.0
        eta_f = 0.0
        div_f = 0.0
        tracer_f = 0.0
        relative = 0.0
        ke = 0.0
        psi = 0.0
        chi = 0.0
	inv_h=0.0
        u = 0.0
	u_f = 0.0
	ke_c = 0.0
	u_viscous = 0.0
	rayleigh = 0.0
        hs = 0.0
        f = 0.0
        mass_flux = c0
        tracer_flux = c0
        stress_tensor = 0.0

	end subroutine init_prognostics

!======================================================================
! END OF INIT_PROGNOSTICS
!======================================================================

	end module prognostics

!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
