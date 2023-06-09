   MODULE params_physical
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  PURPOSE:
!
!     Define various physical parameters and their units (MKS is standard)
!
!  DEFINE:
!
!     pi           -> the ratio of a circle's circumference to its diameter
!                     see http://mathworld.wolfram.com/Pi.html
!     a            -> the radius of the earth.                       [m]
!                     see http://ssd.jpl.nasa.gov/phys_props_earth.html
!     grav         -> gravitational acceleration of the earth.  [m s^-2]
!     omega        -> angular speed of rotation of the earth [rad. s^-1]
!     earth_area   -> surface area of earth                        [m^2]
!     gas_const_R  -> gas constant for dry air            [J kg^-1 K^-1]
!     spec_heat_cp -> specific heat at constant pressure  [J kg^-1 K^-1]
!     kappa        -> gas_const_R/spec_heat_cp
!     p0_sfc       -> standard pressure used in Poisson's eq.       [Pa]
!     tice         -> freezing temperature of water at 1 atmosphere  [K]
!     hltm         -> latent heat of vaporization                 [J/kg]
!     gamfac       -> a moist thermodynamic variable
!     delta        -> molecular_weight_air/molecular_weight_water - 1
!     stefan       -> stefan boltzmann constant            [W m^-2 K^-4]
!                     see http://scienceworld.wolfram.com/physics/
!                                          Stefan-BoltzmannConstant.html
!     rv           -> gas constant for water vapor
!
!     c0           -> zero
!     c1           -> one
!     c2           -> two
!     p5           -> 0.5
!     p25          -> 0.25
!     pi2          -> 2*pi
!     pih          -> 0.5*pi
!     dtr          -> Degrees To Radians conversion constant
!     rtd          -> Radians To Degrees conversion constant
!
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   USE kinds
   IMPLICIT NONE
   SAVE
   PRIVATE

   REAL (KIND=dbl_kind), public, PARAMETER ::                                &
      pi           = 3.14159265358979323846_dbl_kind,                        &
      a            = 6.37122E+06_dbl_kind,                                   &  
!     grav         = 9.8100_dbl_kind,                                        &
      grav         = 9.80616_dbl_kind,                                       &  ! grav for SWTC5
      gravi        = 1._dbl_kind/grav,                                       &  ! grav for SWTC5
!     omega        = 7.292115E-05_dbl_kind,                                  &
      omega        = 7.292E-5_dbl_kind,                                      &  ! omega for SWTC5
      earth_area   = 5.100996990707616E+14_dbl_kind,                         &
      gas_const_R  = 287.000_dbl_kind,                                       &
      spec_heat_cp = 1005.000_dbl_kind,                                      &
      spec_heat_cp_water = 4187.0_dbl_kind,                                  &
      kappa        = gas_const_R/spec_heat_cp,                               &
      inv_kappa    = 1.0_dbl_kind / kappa,                                   &
      p0_sfc       = 1.0E+05_dbl_kind,                                       &
      inv_p0_sfc   = 1.0_dbl_kind/p0_sfc,                                    &
      tice         = 273.15_dbl_kind,                                        &
      hltm         = 2.52E+06_dbl_kind,                                      &
      gamfac       = hltm*5417.9827_dbl_kind/spec_heat_cp,                   &
      delta        = 0.608_dbl_kind,                                         &
      stefan       = 5.67e-08_dbl_kind,                                      &
               mwco2        = 44._dbl_kind,                            &
               mwdry        = 28.991_dbl_kind,                         &
               mwch4        = 16._dbl_kind,                            &
               mwn2o        = 44._dbl_kind,                             &
               mwf11        = 136.0_dbl_kind,                           &
               mwf12        = 120._dbl_kind,                            &
               r_universal  = 8314.467_dbl_kind,                        &
               rv           = 4.61e+02_dbl_kind,                         &
               zvir         = rv/gas_const_R -1._dbl_kind

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! parameters related to sea ice water and K to C conversions
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   REAL (KIND=dbl_kind), public, PARAMETER ::                                &
      CtoK = 273.15_dbl_kind,                                                &
      KtoC = -CtoK,                                                          &
      Tfreeze = -1.9_dbl_kind                             

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! numbers
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   REAL (KIND=dbl_kind), public, PARAMETER ::                                &
      c0     = 0.00000_dbl_kind,                                             &
      c1     = 1.00000_dbl_kind,                                             &
      c2     = 2.00000_dbl_kind,                                             &
      c3     = 3.00000_dbl_kind,                                             &
      p5     = 0.50000_dbl_kind,                                             &
      p25    = 0.25000_dbl_kind,                                             &
      pi2    = c2*pi,                                                        &
      pih    = p5*pi,                                                        &
      dtr    = pi/180.0_dbl_kind,                                            &
      rtd    = 180.0_dbl_kind/pi,                                            &
      alpha2 = 0.0

   INTEGER (KIND=int_kind), public, parameter ::                             & 
      r3 = 3,                        & ! 3-space
      r2 = 2,                        & ! 2-space
      nweights = 7                     ! amount of data incorp

   END MODULE params_physical
!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
