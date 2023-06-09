!==============================================================================
 module eau_util
      
 use kinds
 use eau_params
      
 implicit none
 private
 save
 public :: eau_sat
!==============================================================================
 contains
!==============================================================================
 subroutine eau_sat &
                (   len ,  pl ,    tl ,  qwvl ,  qsats , &
                 dqsats , dqsatsdp , ess , dtess ,  sats ,   wght   &                         
                )
!------------------------------------------------------------------------------
!eau_sat computes the saturation mixing ratio, vapor pressure, and saturation,
!and their derivatives with respect to temperature over water, ice and mixed-
!phase clouds. the parameterization is that used in the Community Climate Com-
!munity Climate Model at NCAR.
!Laura D. Fowler /slikrock (07-01-01).

!send comments to laura@atmos.colostate.edu.

!optional argument for derivative of qsat wrt pressure (dqsatsdp) at constant
!temperature added by celal and ross

!subroutines called:
!none.

!argument list variables:
!input arguments:
!----------------
 integer (kind=int_kind), intent(in):: &
    len               !length of vector.

 real(kind=dbl_kind), intent(in), dimension(len):: &
    pl,              &!pressure                                           (Pa).
    tl                !temperature                                         (K).

 real(kind=dbl_kind), intent(in), dimension(len), optional :: &
    qwvl              !water vapor mixing ratio                        (kg/kg).

!output arguments:
!-----------------
 real (kind=dbl_kind), intent(out), dimension(len), optional :: &
    qsats,           &!saturation mixing ratio                         (kg/kg).
    dqsats,          &!derivative of qsat with respect to temperature(kg/kg/K).
    dqsatsdp,        &!derivative of qsat with respect to pressure   (kg/kg/Pa).
    ess,             &!saturation vapor pressure                          (Pa).
    dtess,           &!derivative of es with respect to temperature     (Pa/K).
    sats,            &!saturation                                          (-).
    wght              !partitioning between cloud water and cloud ice
                      !for mixed-phase clouds                              (-).      

!local variables:
 integer (kind=int_kind):: i

 real (kind=dbl_kind):: &
    twmin=173.16,    &!lowest allowed temperature boundary for water       (K).
    twmax=373.16,    &!highest allowed temperature boundary for water      (K).     
    timin=173.16,    &!lowest allowed temperature boundary for ice         (K).
    timax=273.16,    &!highest allowed temperature boundary for ice        (K).
    tnull=273.16      !freezing temperature                                (K).

 real (kind=dbl_kind) :: tstl , t0tl

 real (kind=dbl_kind), dimension(len):: &
       esw ,    dtesw ,      esi ,     dtesi ,&
       esm ,    dtesm ,    qsatw ,    dqsatw , dqsatwdp ,&
     qsati ,   dqsati , dqsatidp ,     qsatm ,   dqsatm , dqsatmdp ,&
      satw ,     sati ,     satm ,       tl0 ,&
     wghtm , qwvl_tem , qsat_tem , dqsat_tem , dqsatdp_tem ,&
    es_tem , dtes_tem ,  sat_tem ,  wght_tem

!ccm parameterization of saturation vapor pressure over water and ice:
 real (kind=dbl_kind), parameter:: &
    ps = 1013.246,   &!reference pressure                                (hPa).
    ts = 373.16,     &!reference temperature                               (K).
    t0 = 273.16       !freezing temperature                                (K)
     
 real (kind=dbl_kind):: &
        e1 ,   e2 ,     f ,    f1 ,&
        f2 ,   f3 ,    f4 ,    f5 ,&
    lphase , term , term1 , term2 ,&
    term3     

!------------------------------------------------------------------------------
!initialization of different arrays:
 tl0    = tl
 esw      = c0 ; esi      = c0 ; esm      = c0
 dtesw    = c0 ; dtesi    = c0 ; dtesm    = c0
 qsatw    = c0 ; qsati    = c0 ; qsatm    = c0
 dqsatw   = c0 ; dqsati   = c0 ; dqsatm   = c0
 dqsatwdp = c0 ; dqsatidp = c0 ; dqsatmdp = c0
 satw     = c0 ; sati     = c0 ; satm     = c0

 qsat_tem = c0 ; dqsat_tem = c0
 es_tem   = c0 ; dtes_tem  = c0
 sat_tem  = c0 ; wght_tem  = c0

 if(present(ess))      ess      = c0
 if(present(dtess))    dtess    = c0
 if(present(qsats))    qsats    = c0
 if(present(dqsats))   dqsats   = c0
 if(present(dqsatsdp)) dqsatsdp = c0
 if(present(sats))     sats     = c0
 if(present(wght))     wght     = c0

 if(present(qwvl)) then
    qwvl_tem = qwvl
 else
    qwvl_tem = c0
 endif

!saturation over water:
 do i = 1, len
    tl0(i)    = max(twmin,tl0(i))
    tl0(i)    = min(twmax,tl0(i))
    tstl      = ts / tl0(i)
    e1        = 11.344*(1.0 - tl0(i)/ts)
    e2        = -3.49149*(tstl - 1.0)
    f1        = -7.90298*(tstl - 1.0)
    f2        = 5.02808*log10(tstl)
    f3        = -1.3816*(10.0**e1-1.0)/10000000.0
    f4        = 8.1328*(10.0**e2-1.0)/1000.0
    f5        = log10(ps)
    f         = f1 + f2 + f3 + f4 + f5

    esw(i)    = (10.0**f)*1.e+02
    esw(i)    = min(esw(i),pl(i)*0.9)
    dtesw(i)  = hltm*esw(i)/(rv*tl0(i)*tl0(i))
    qsatw(i)  = 0.622*esw(i)/(pl(i)-esw(i))
    dqsatw(i) = qsatw(i)*(dtesw(i) / esw(i))*(pl(i) &
              / (pl(i)-esw(i)))

    dqsatwdp(i)  = -qsatw(i)/(pl(i)-esw(i))

    satw(i)      = qwvl_tem(i)/qsatw(i)
    es_tem(i)    = esw(i)
    dtes_tem(i)  = dtesw(i)
    qsat_tem(i)  = qsatw(i)
    dqsat_tem(i) = dqsatw(i)

    dqsatdp_tem(i) = dqsatwdp(i)

    sat_tem(i)   = satw(i)
    wght_tem(i)  = c1
 enddo

!saturation over ice:
 do i = 1, len
    if(tl0(i).lt.timax) then
       tl0(i)    = max(tl0(i),timin)
       t0tl      = t0 / tl0(i)
       term1     = 2.01889049/(t0tl)
       term2     = 3.56654*log(t0tl)
       term3     = 20.947031*(t0tl)
       term      = term1 + term2 + term3

       esi(i)    = 575.185606e10*exp(-(term1 + term2 + term3))
       esi(i)    = min(esi(i),pl(i)*0.9)
       dtesi(i)  = lsub*esi(i)/(rv*tl0(i)*tl0(i))
       qsati(i)  = 0.622*esi(i) / (pl(i)-esi(i))
       dqsati(i) = qsati(i)*(dtesi(i) / esi(i))*(pl(i) &
                 / (pl(i)-esi(i)))

       dqsatidp(i) = -qsati(i)/(pl(i)-esi(i))

       sati(i)   = qwvl_tem(i)/qsati(i)
       es_tem(i)    = esi(i)
       dtes_tem(i)  = dtesi(i)
       qsat_tem(i)  = qsati(i)
       dqsat_tem(i) = dqsati(i)

       dqsatdp_tem(i) = dqsatidp(i)

       sat_tem(i)   = sati(i)  
       wght_tem(i)  = c0
    endif
 enddo

!interpolated saturation variables:
 do i = 1, len
    if(tl0(i).lt.tbgmax .and. tl0(i).ge.tbgmin) then
       wghtm(i)  = (tl0(i)-tbgmin)/(tbgmax-tbgmin)
       lphase    = hltm*wghtm(i)+lsub*(1.-wghtm(i))
       esm(i)    = wghtm(i)*esw(i) + (1.-wghtm(i))*esi(i)
       esm(i)    = min(esm(i),pl(i)*0.9)
       dtesm(i)  = lphase*esm(i)/(rv*tl0(i)*tl0(i))
       qsatm(i)  = 0.622*esm(i) / (pl(i) - esm(i))
       dqsatm(i) = qsatm(i) * (dtesm(i)/esm(i))*(pl(i) &
                 / (pl(i)-esm(i)))

       dqsatmdp(i) = -qsatm(i)/(pl(i)-esm(i))

       satm(i)   = qwvl_tem(i) / qsatm(i)
       es_tem(i)    = esm(i)
       dtes_tem(i)  = dtesm(i)
       qsat_tem(i)  = qsatm(i)
       dqsat_tem(i) = dqsatm(i)

       dqsatdp_tem(i) = dqsatmdp(i)

       sat_tem(i)   = satm(i)  
       wght_tem(i)  = wghtm(i)
    endif
 enddo

 if (present(qsats))    qsats    = qsat_tem
 if (present(dqsats))   dqsats   = dqsat_tem
 if (present(dqsatsdp)) dqsatsdp = dqsatdp_tem
 if (present(ess))      ess      = es_tem
 if (present(dtess))    dtess    = dtes_tem
 if (present(sats))     sats     = sat_tem
 if (present(wght))     wght     = wght_tem

 end subroutine eau_sat

!==============================================================================

 end module eau_util

!==============================================================================
      
      
