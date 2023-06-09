module cpl_vmfcal_module

! this module is a collection of various vmfcal routines, used for
!  the colculation of the ventilation mass flux

use kinds

implicit none
private

! public member functions
public ::                                                           &
      cpl_vmfcal,                                                   &
      cpl_vmfcal1D,                                                 &
      cpl_vmfcal2,                                                  &
      cpl_vmfcalz,                                                  &
      cpl_vmfcalz1D,                                                &
      cpl_vmfcalo,                                                  &
      cpl_vmfcalz2,                                                 &
      cpl_vmfcalzo

contains

      sUBROUTINE cpl_VMFCAL(PR0,RIBC,VKRMN,DELTA,GRAV,            &
                       SH,PS,z0,                                  &
                       SPDM,SHA,ZB,ROS,CU,THVGM,RIB,              &
                       USTAR,VENTMF,THM, tha,                     &
                       cni, cuni, ctni, ctni3, cti, cui,          &
                       len, thgeff, shgeff, tke, ct, dotkef )                               

!                                                                       
!***  VENTILATION MASS FLUX, BASED ON DEARDORFF, MWR, 1972              
!                                                                       
      integer (kind=int_kind), intent(in) ::                      &
           len
      logical (kind=log_kind), intent(in) ::                      &
           dotkef
      REAL (kind=dbl_kind), intent(in) ::                         &
           pr0, ribc, vkrmn, delta, grav   
 
      REAL (kind=dbl_kind), intent(in), dimension(len) ::         &           
           z0, ZB, ROS, SH, PS,                                   &
           THM, SHA, SPDM,                                        &
           tha, thgeff, shgeff, tke

      REAL (kind=dbl_kind), intent(out), dimension(len) ::        &          
           CU, THVGM, RIB, CNI,                                   &
           CUNI, USTAR, CTNI,                                     &
           CUI, CTI, CT,                                          &
           VENTMF, CTNI3

!     local variables
      REAL (kind=dbl_kind), dimension(len) ::                     &         
           TEMV, ZDRDRF, CHOKE, wgm, THGM 
      REAL (kind=dbl_kind) ::                                     &
           ribmax, vkrinv, athird, sqrtke
      integer (kind=int_kind) ::     i          
                                                                     
         RIBMAX = 0.9*RIBC                                              
         VKRINV = 1.0/VKRMN                                             
         ATHIRD = 1.0_dbl_kind/3.0_dbl_kind             
                                                                      
      DO  I=1,len                                                    
         WGM(i)  = SHA(i) - SH(i)                                      
!                                                                       
!        SFC-AIR DEFICITS OF MOISTURE AND POTENTIAL TEMPERATURE         
!        WGM IS THE EFFECTIVE SFC-AIR TOTAL MIXING RATIO DIFFERENCE.    
!                                                                       
         THGM(i)  = THA(i)  - THM(i)                                   
      enddo  
                                                              
      if (dotkef) then
         do i = 1,len
            thvgm(i) = (thgeff(i)-thm(i)) + thgeff(i) * delta *  &
                        ((shgeff(i)-sh(i)))
         enddo
      else
         do i = 1,len
            THVGM(i) = THGM(i) + THA(i) * DELTA * WGM(i)                  
         enddo
      endif
!                                                                       
!        CUNI AND CTN1 ARE INVERSES OF THE NEUTRAL TRANSFER COEFFICIENTS
!        DEARDORFF EQS(33) AND (34).                                    
!        PR0 IS THE TURBULENT PRANDTL NUMBER AT NEUTRAL STABILITY.      
!                                                                       
!                                                                       
       DO I=1,len
         CNI(i) = 0.025*ZB(i)/z0(i)                          
	 cni(i) = log(cni(i))                                                 
         CNI(i)  = CNI(i)  * VKRINV                                     
         CUNI(i) = CNI(i)  + 8.4_dbl_kind             
         CTNI(i) = CNI(i)  * PR0 + 7.3_dbl_kind
         CTNI3(i)= 0.3_dbl_kind     * CTNI(i)          
         CNI(i)  = GRAV    * ZB(i)                          
!                                                                       
!        SURFACE TO AIR DIFFERENCE OF POTENTIAL TEMPERATURE.            
!        RIB IS THE BULK RICHARDSON NUMBER, DEARDORFF EQ (25)           
!                                                                       
         TEMV(i) = THA(i) * SPDM(i) * SPDM(i)                          
         temv(i) = max(0.000001_dbl_kind,temv(i))
      enddo                                                       
      if (dotkef) then
         DO I=1,len                                                    
            rib(i) = -thvgm(i)*grav*zb(i)/(thgeff(i)*tke(i)) 
         enddo
      else
         DO I=1,len                                                    
            RIB(I) = -THVGM(I) * CNI(I) / TEMV(i) 
         enddo
      endif                            
!   
!                                                                       
      if (dotkef) then
         DO I=1,len 
            if(rib(i).ge.0.0_dbl_kind) then  
               cu(i) = ((-0.0307*rib(i)**2)/(61.5+rib(i)**2))+0.044
               ct(i) = ((-0.0152*rib(i)**2)/(190.4+rib(i)**2))+0.025
            else
               cu(i) = ((-0.016*rib(i)**2)/(4.2e4+rib(i)**2))+0.044
               ct(i) = ((-0.0195*rib(i)**2)/(2.1e4+rib(i)**2))+0.025
            endif
         enddo
         DO I=1,len 
            sqrtke = sqrt(tke(i))
            USTAR(I) = sqrt(sqrtke*spdm(I)*CU(I))                                          
            VENTMF(I)=ROS(I)*CT(I)*sqrtke                                   
         enddo
      else
         DO  I=1,len 
            if(rib(i).ge.0.0_dbl_kind) then          
!                                                                       
!        THE STABLE CASE. RIB IS USED WITH AN UPPER LIMIT               
!                                                                       
               CHOKE(i)=1.0-MIN(RIB(I),RIBMAX)/RIBC                           
               CU(I)=CHOKE(i)/CUNI(I)                                         
               CT(I)=CHOKE(i)/CTNI(I)   
            else                                  
!                                                                       
!        FIRST, THE UNSTABLE CASE. DEARDORFF EQS(28), (29), AND (30)    
!                                                                       
               ZDRDRF(i) = LOG10(-RIB(I)) - 3.5                             
               CUI(I)    = CUNI(I) - 25.0 * EXP(0.26 * ZDRDRF(i)  &         
                      - 0.03 * ZDRDRF(i) * ZDRDRF(i))                    
               CTI(I)    = CUI(I) + CTNI(I) - CUNI(I)                         
               CU(I)     = 1.0 / MAX(CUI(I),0.5 * CUNI(I))                   
               CT(I)     = 1.0 / MAX(CTI(I),CTNI3(I))                        
            END IF    
         enddo 
         DO I=1,len                                                   
            USTAR(i) =SPDM(i)*CU(i)                                          
            VENTMF(i)=ROS(i)*CT(i)*USTAR(i)                                   
         enddo                                                         
      endif
                                                      
!                                                                       
!     CHECK THAT VENTFC EXCEEDS TOWNSENDS(1962) FREE CONVECTION VALUE, 
!     DEARDORFF EQ(40B)                                                 
!  
      if (.not.dotkef) then
         DO I=1,len 
            if( rib(i).lt.0.0_dbl_kind) then
               if( cti(i).lt.ctni3(i) )                           &                                          
                  VENTMF(I)=MAX(VENTMF(I),                        &              
                            ROS(I)*0.00186*(THVGM(I))**ATHIRD) 
            endif                
         enddo             
      endif                                          

      END subroutine cpl_vmfcal                                     
      
!**********************************************************************
                          
      SUBROUTINE cpl_VMFCAL1D(PR0,RIBC,VKRMN,DELTA,GRAV,            &
                    SH_D,PS_D,z0_D,                                 &
                    SPDM_D,SHA_D,ZB_D,ROS_D,CU_D,THVGM_D,RIB_D,     &
                    USTAR_D,VENTMF_D,THM_D, tha_D,                  &
                    cni_D, cuni_D, ctni_D, ctni3_D, cti_D, cui_D,   &
                    len, thgeff_D, shgeff_D, tke_D, ct_D, dotkef )


! takes scalars and matches with len=1 variables
!***  VENTILATION MASS FLUX, BASED ON DEARDORFF, MWR, 1972
!
      integer (kind=int_kind), intent(in) ::                      &
           len
      logical (kind=log_kind), intent(in) ::                      &
           dotkef
      REAL (kind=dbl_kind), intent(in) ::                         &
           pr0, ribc, vkrmn, delta, grav

! input variables as scalars
      REAL (kind=dbl_kind), intent(in) ::         &
           z0_D, ZB_D, ROS_D, SH_D, PS_D,                         &
           THM_D, SHA_D, SPDM_D,                                  &
           tha_D, thgeff_D, shgeff_D, tke_D

      REAL (kind=dbl_kind), intent(out) ::        &
           CU_D, THVGM_D, RIB_D, CNI_D,                           &
           CUNI_D, USTAR_D, CTNI_D,                               &
           CUI_D, CTI_D, CT_D,                                    &
           VENTMF_D, CTNI3_D
! replacement variables of length len
      REAL (kind=dbl_kind), dimension(len) ::         &
           z0, ZB, ROS, SH, PS,                                   &
           THM, SHA, SPDM,                                        &
           tha, thgeff, shgeff, tke

      REAL (kind=dbl_kind), dimension(len) ::        &
           CU, THVGM, RIB, CNI,                                   &
           CUNI, USTAR, CTNI,                                     &
           CUI, CTI, CT,                                          &
           VENTMF, CTNI3
	z0(1) = z0_D
	ZB(1) = ZB_D
	ROS(1) = ROS_D
	SH(1) = SH_D
	PS(1) = PS_D
	THM(1) =THM_D
	SHA(1) = SHA_D
	SPDM(1)  = SPDM_D
	tha(1) =tha_D
	thgeff(1) = thgeff_D
	shgeff(1) = shgeff_D
	tke(1) = tke_D

      call cpl_VMFCAL(PR0,RIBC,VKRMN,DELTA,GRAV,                  &
                       SH,PS,z0,                                  &
                       SPDM,SHA,ZB,ROS,CU,THVGM,RIB,              &
                       USTAR,VENTMF,THM, tha,                     &
                       cni, cuni, ctni, ctni3, cti, cui,          &
                       len, thgeff, shgeff, tke, ct, dotkef )

	CU_D = cu(1)
	THVGM_D = thvgm(1)
	RIB_D = rib(1)
	CNI_D = cni(1)
	CUNI_D = cuni(1)
	USTAR_D = ustar(1)
    CTNI_D = ctni(1)
	CUI_D =  cui(1)
	CTI_D = cti(1)
	CT_D = ct(1)
	VENTMF_D =  ventmf(1)
	CTNI3_D = ctni3(1)

      END subroutine cpl_vmfcal1D
      
!**********************************************************************
                          
      SUBROUTINE cpl_VMFCAL2(PR0,RIBC,VKRMN,DELTA,GRAV,           &
                       SH,PS,z0,                                  &
                       SPDM,SHA,ZB,ROS,CU,RA,THVGM,RIB,           &
                       USTAR,VENTMF,THM, tha,                     &
                       cni, cuni, ctni, ctni3,cti, cui,           &
                       len, thgeff, shgeff, tke, ct, dotkef )                               
!                                                                       
!***  VENTILATION MASS FLUX, BASED ON DEARDORFF, MWR, 1972              
!                          
      integer (kind=int_kind), intent(in) ::                      &
           len
      logical (kind=log_kind), intent(in) ::                      &
            dotkef
      REAL (kind=dbl_kind), intent(in) ::                         &
           pr0, ribc, vkrmn, delta, grav   

      REAL (kind=dbl_kind), intent(in), dimension(len) ::         &
           z0, ZB, ROS, SH, PS,                                   &
           THM, SHA, SPDM,                                        &
           tha, thgeff, shgeff, tke

      REAL (kind=dbl_kind), intent(out), dimension(len) ::        &
           CU, THVGM, RIB,                                        &
           USTAR,                                                 &
           CUI, CTI, CT,                                          &
           VENTMF, ra
      REAL (kind=dbl_kind), intent(inout), dimension(len) ::      &    
          cni, cuni, ctni, ctni3


!     local variables
      REAL (kind=dbl_kind), dimension(len) ::                     &
           TEMV, ZDRDRF, CHOKE, wgm, thgm 
      REAL (kind=dbl_kind) ::                                     &
           ribmax, vkrinv, athird, sqrtke
      integer (kind=int_kind) ::     i          

         RIBMAX = 0.9*RIBC                                              
         VKRINV = 1.0/VKRMN                                             
         ATHIRD = 1.0/3.0                                               
      DO I=1,len                                                    
         WGM(i)  = SHA(i) - SH(i)                                      
!                                                                       
!        SFC-AIR DEFICITS OF MOISTURE AND POTENTIAL TEMPERATURE         
!        WGM IS THE EFFECTIVE SFC-AIR TOTAL MIXING RATIO DIFFERENCE.    
!                                                                       
         THGM(i)  = THA(i)  - THM(i)                                   
      enddo                                                          
      if (dotkef) then
         do i = 1,len
            thvgm(i) = (thgeff(i)-thm(i)) + thgeff(i) * delta *   &
                       ((shgeff(i)-sh(i)))
         enddo
      else
         do i = 1,len
            THVGM(i) = THGM(i) + THA(i) * DELTA * WGM(i)                  
         enddo
      endif
!                                                                       
!        CUNI AND CTN1 ARE INVERSES OF THE NEUTRAL TRANSFER COEFFICIENTS
!        DEARDORFF EQS(33) AND (34).                                    
!        PR0 IS THE TURBULENT PRANDTL NUMBER AT NEUTRAL STABILITY.      
!                                                                       
!                                                                       
!                                                                       
!        SURFACE TO AIR DIFFERENCE OF POTENTIAL TEMPERATURE.            
!        RIB IS THE BULK RICHARDSON NUMBER, DEARDORFF EQ (25)           
!                                                                       
      DO I=1,len                                                    
         TEMV(I) = THA(i) * SPDM(i) * SPDM(i)                          
         temv(i) = max(0.000001_dbl_kind,temv(i))
      enddo   
                         
      if (dotkef) then
         DO I=1,len                                                    
            rib(i) = -thvgm(i)*grav*zb(i)/(thgeff(i)*tke(i)) 
         enddo
      else
         DO I=1,len                                                    
            RIB(I) = -THVGM(I) * CNI(I) / TEMV(i) 
         enddo
      endif                            
!                                                                       
!        THE STABLE CASE. RIB IS USED WITH AN UPPER LIMIT               
!                                                                       
      if (dotkef) then
         DO I=1,len 
            if(rib(i).ge.0.0_dbl_kind) then                                           
               cu(i) = ((-0.0307*rib(i)**2)/(61.5+rib(i)**2))+0.044
               ct(i) = ((-0.0152*rib(i)**2)/(190.4+rib(i)**2))+0.025
            else
               cu(i) = ((-0.016*rib(i)**2)/(4.2e4+rib(i)**2))+0.044
               ct(i) = ((-0.0195*rib(i)**2)/(2.1e4+rib(i)**2))+0.025
            endif
         enddo
         DO I=1,len 
            sqrtke = sqrt(tke(i))
            USTAR(I) = sqrt(sqrtke*spdm(I)*CU(I))                                          
            VENTMF(I)=ROS(I)*CT(I)*sqrtke                                   
            RA(I)    = ROS(i) / VENTMF(i)                              
         enddo
      else
         DO I=1,len 
            if(rib(i).ge.0.0_dbl_kind) then                                           
!                                                                       
!        THE STABLE CASE. RIB IS USED WITH AN UPPER LIMIT               
!                                                                       
               CHOKE(i)=1.0-MIN(RIB(I),RIBMAX)/RIBC                           
               CU(I)=CHOKE(i)/CUNI(I)                                         
               CT(I)=CHOKE(i)/CTNI(I)   
            else                                  
!                                                                       
!        FIRST, THE UNSTABLE CASE. DEARDORFF EQS(28), (29), AND (30)    
!                                                                       
               ZDRDRF(i) = LOG10(-RIB(I)) - 3.5                             
               CUI(I)    = CUNI(I) - 25.0 * EXP(0.26 * ZDRDRF(i)      &          
                      - 0.03 * ZDRDRF(i) * ZDRDRF(i))                    
               CTI(I)    = CUI(I) + CTNI(I) - CUNI(I)                         
               CU(I)     = 1.0 / MAX(CUI(I),0.5 * CUNI(I))                   
               CT(I)     = 1.0 / MAX(CTI(I),CTNI3(I))                        
            END IF    
         enddo 
         DO I=1,len                                                   
            USTAR(i) =SPDM(i)*CU(i)                                          
            VENTMF(i)=ROS(i)*CT(i)*USTAR(i)                                   
         enddo                                                          
!                                                                       
!     CHECK THAT VENTFC EXCEEDS TOWNSENDS(1962) FREE CONVECTION VALUE, 
!     DEARDORFF EQ(40B)                                                 
!  
      DO I=1,len 
         if( rib(i).lt.0.0_dbl_kind ) then
            if( cti(i).lt.ctni3(i) )                                &                                  
               VENTMF(i)=MAX(VENTMF(i),                             &         
                  ROS(i)*0.00186*(THVGM(i))**ATHIRD)  
         endif               
      Enddo                                                       
!                                                                       
!     AERODYNAMIC RESISTANCE                                            
!                                                                       
         DO I=1,len                                              
            RA(I)    = ROS(i) / VENTMF(i)                              
         enddo                                                       
      endif

      END subroutine cpl_vmfcal2                                                          
      
!**********************************************************************
                          
      SUBROUTINE cpl_VMFCALo(PR0,RIBC,VKRMN,GRAV,                   &
                       SPDM,ZB,ROS,CU,THVGM,                        &
                       USTAR, tha,                                  &
                       len, thgeff, tke, dotkef )                               

! subroutine is stripped from vmfcal.F and is used only to calculate
!   ustart and cu for oceanic values of the surface roughness length
!                                                                       
!***  VENTILATION MASS FLUX, BASED ON DEARDORFF, MWR, 1972              
                                                                       
      integer (kind=int_kind), intent(in) ::                         &
           len
      logical (kind=log_kind), intent(in) ::                         &
            dotkef
      REAL (kind=dbl_kind), intent(in) ::                            &
           pr0, ribc, vkrmn, grav   
 
      REAL (kind=dbl_kind), dimension(len), intent(in) ::            &
           ZB,ROS,                                                   &
           THVGM,                                                    &
           SPDM,                                                     &
           tha, thgeff,tke
      REAL (kind=dbl_kind), dimension(len), intent(out) ::           &
           CU, USTAR

!     local variables
      REAL (kind=dbl_kind), dimension(len) ::                        &
           TEMV, ZDRDRF, CHOKE, cui, cuni, cni, rib 
      REAL (kind=dbl_kind) ::                                        &
           ribmax, vkrinv, sqrtke
      integer (kind=int_kind) ::  i          
                                                                       
      RIBMAX = 0.9*RIBC                                              
      VKRINV = 1.0/VKRMN                                             
!                                                                       
!        CUNI AND CTN1 ARE INVERSES OF THE NEUTRAL TRANSFER COEFFICIENTS
!        DEARDORFF EQS(33) AND (34).                                    
!        PR0 IS THE TURBULENT PRANDTL NUMBER AT NEUTRAL STABILITY.      
!                                                                    
      DO I=1,len
         CNI(i) = 0.025*ZB(i)/0.0002    ! oceanic surface roughness length                          
	 cni(i) = log(cni(i))                                                 
         CNI(i)  = CNI(i)  * VKRINV                                     
         CUNI(i) = CNI(i)  + 8.4                                        
         CNI(i)  = GRAV    * ZB(i)                          
!                                                                       
!        SURFACE TO AIR DIFFERENCE OF POTENTIAL TEMPERATURE.            
!        RIB IS THE BULK RICHARDSON NUMBER, DEARDORFF EQ (25)           
!                                                                       
      enddo                                                       
      if (dotkef) then
         DO I=1,len                                                    
            rib(i) = -thvgm(i)*grav*zb(i)/(thgeff(i)*tke(i)) 
         enddo
         DO I=1,len 
            if(rib(i).ge.0.0_dbl_kind) then                
               cu(i) = ((-0.0307*rib(i)**2)/(61.5+rib(i)**2))+0.044
            else
               cu(i) = ((-0.016*rib(i)**2)/(4.2e4+rib(i)**2))+0.044
            endif
         enddo
         DO I=1,len 
            sqrtke = sqrt(tke(i))
            USTAR(I) = sqrt(sqrtke*spdm(I)*CU(I))                                          
         enddo
      else
         DO I=1,len                                                    
            TEMV(i) = THA(i) * SPDM(i) * SPDM(i)                          
            temv(i) = max(0.000001_dbl_kind,temv(i))
            RIB(I) = -THVGM(I) * CNI(I) / TEMV(i) 
         enddo
         DO I=1,len 
            if(rib(i).ge.0.0_dbl_kind) then                                           
!                                                                       
!        THE STABLE CASE. RIB IS USED WITH AN UPPER LIMIT               
!                                                                       
               CHOKE(i)=1.0-MIN(RIB(I),RIBMAX)/RIBC                           
               CU(I)=CHOKE(i)/CUNI(I)                                         
            else                                  
!                                                                       
!        FIRST, THE UNSTABLE CASE. DEARDORFF EQS(28), (29), AND (30)    
!                                                                       
               ZDRDRF(i) = LOG10(-RIB(I)) - 3.5                             
               CUI(I)    = CUNI(I) - 25.0 * EXP(0.26 * ZDRDRF(i)     &          
                     - 0.03 * ZDRDRF(i) * ZDRDRF(i))                    
               CU(I)     = 1.0 / MAX(CUI(I),0.5 * CUNI(I))                   
            END IF    
         enddo 
         DO I=1,len                                                   
            USTAR(i) =SPDM(i)*CU(i)                                          
         enddo                                                          
      endif                            

      END subroutine cpl_vmfcalo                                                          
      
!**********************************************************************
                          
      SUBROUTINE cpl_VMFCALZ(PR0,RIBC,VKRMN,DELTA,GRAV,              &
                       SH,PS,z0,                                     &
                       SPDM,SHA,ROS,CU,ct,THVGM,RIB,                 &
                       USTAR,VENTMF,THM, tha, zzwind, zztemp,        &
                       cuni, cun, ctn, z1z0Urt, z1z0Trt, len ) 

!*****************************************************************************                                                                       
!     VENTILATION MASS FLUX,Ustar, and transfer coefficients for momentum 
!     and heat fluxes, based on by Louis (1979, 1982), and revised by Holtslag
!     and Boville(1993), and by Beljaars and Holtslag (1991).              
!  
!     Rerences:
!       Beljars and Holtslag (1991): Flux parameterization over land surfaces
!              for atmospheric models. J. Appl. Meteo., 30, 327-341.
!       Holtslag and Boville (1993): Local versus nonlocal boundary-layer 
!              diffusion in a global climate model. J. of Climate, 6, 1825-
!              1842.
!       Louis, J. F., (1979):A parametric model of vertical eddy fluxes in
!              atmosphere. Boundary-Layer Meteo., 17, 187-202.
!       Louis, Tiedke, and Geleyn, (1982): A short history of the PBL
!              parameterization at ECMWF. Proc. ECMWF Workshop on Boundary-
!              Layer parameterization, ECMWF, 59-79.
!
!     General formulation:
!        surface_flux = transfer_coef.*U1*(mean_in_regerence - mean_at_sfc.) 
!     Transfer coefficients for mommentum and heat fluxes are:
!        CU = CUN*Fm, and
!        CT = CTN*Fh
!        where  CUN and CTN are nutral values of momentum and heat transfers,
!           and Fm and Fh are stability functions derived from surface
!           similarity relationships.     
!*****************************************************************************
                                                                           
      integer (kind=int_kind), intent(in) ::                         &
          len
      REAL (kind=dbl_kind), intent(in) ::                            &
          pr0, ribc, vkrmn, delta, grav                                                           
      REAL (kind=dbl_kind), intent(in), dimension(len) ::            &
         z0, ROS, SH, PS, THM, SHA, SPDM, tha 

      REAL (kind=dbl_kind), intent(out), dimension(len) ::           &
           CU, THVGM, RIB, USTAR, CT, VENTMF, cuni
!     local variables
      REAL (kind=dbl_kind), dimension(len) ::                        &
             TEMV, wgm, THGM,                                        &
             zzwind, zztemp, zrib, cun, ctn,                         &
             z1z0U, z1z0Urt, z1z0T, z1z0Trt,                         &
             fmomn, fheat, CUI, CTI     
      REAL (kind=dbl_kind) ::                                        &
            ribtemp,dm,dh,                                           &
            bunstablM, bunstablT, cunstablM, cunstablT, bstabl, cstabl
      integer (kind=int_kind) :: i
!      
!  constants for surface flux functions, according to Holtslag and
!      Boville (1993, J. Climate)

      bunstablM = 10.       ! constants for unstable function
      bunstablT = 15
      cunstablM = 75.
      cunstablT = 75.
      bstabl = 8.           ! constants for stable function
      cstabl = 10.
                                                                  
      DO I=1,len                                                    
         zrib(i) = zzwind(i) **2 / zztemp(i)                                                    
         WGM(i)  = SHA(i) - SH(i)                                      
!                                                                       
!        SFC-AIR DEFICITS OF MOISTURE AND POTENTIAL TEMPERATURE         
!        WGM IS THE EFFECTIVE SFC-AIR TOTAL MIXING RATIO DIFFERENCE.    
!                                                                       
         THGM(i)  = THA(i)  - THM(i)                                   
         THVGM(i) = THGM(i) + THA(i) * DELTA * WGM(i)                                                                                       
      enddo 

!   Ratio of reference height (zwind/ztemp) and roughness length:
      do i = 1, len                !for all grid points
         z1z0U(i) = zzwind(i)/ z0(i)
         z1z0Urt(i) = sqrt( z1z0U(i) )
         z1z0U(i) = log( z1z0U(i) )
         z1z0T(i) = zzwind(i)/ z0(i)
         z1z0Trt(i) = sqrt( z1z0T(i) )
         z1z0T(i) = log( z1z0T(i) )
      enddo

!   Neutral surface transfers for momentum CUN and for heat/moisture CTN:

      do i = 1, len       
         cun(i) = VKRMN*VKRMN / (z1z0U(i)*z1z0U(i) )   !neutral Cm & Ct
         ctn(i) = VKRMN*VKRMN / (z1z0T(i)*z1z0T(i) )
         cuni(i) = z1z0u(i) / vkrmn
      enddo                                                                                                               
!                                                                       
!   SURFACE TO AIR DIFFERENCE OF POTENTIAL TEMPERATURE.            
!   RIB IS THE BULK RICHARDSON NUMBER, between reference height and surface.           
!                                                                       
      DO I=1,len                                                    
         TEMV(i) = THA(i) * SPDM(i) * SPDM(i)                          
         temv(i) = max(0.000001_dbl_kind,temv(i))
         RIB(I) = -THVGM(I) * GRAV * zrib(i) / TEMV(i) 
      enddo                            
   
!   The stability functions for momentum and heat/moisture fluxes as
!   derived from the surface-similarity theory by Luis (1079, 1982), and
!   revised by Holtslag and Boville(1993), and by Beljaars and Holtslag 
!   (1991).
                                                                    
      DO I=1,len 
         if(rib(i).ge.0.0) then                                           
!                                                                       
!        THE STABLE CASE. RIB IS USED WITH AN UPPER LIMIT              
!
            rib(i) = min( rib(i), 0.5_dbl_kind)                   
            fmomn(i) = (1. + cstabl * rib(i) * (1.+ bstabl * rib(i)))
            fmomn(i) = 1. / fmomn(i)
            fmomn(i) = max(0.0001_dbl_kind,fmomn(i))
            fheat(i) = fmomn(i)
                                         
         else                                  
!                                                                       
!        THE UNSTABLE CASE.    
!            
            ribtemp = abs(rib(i))
            ribtemp = sqrt( ribtemp )
            dm = 1. + cunstablM * cun(i) * z1z0Urt(i) * ribtemp
            dh = 1. + cunstablT * ctn(i) * z1z0Trt(i) * ribtemp
            fmomn(i) = 1. - (bunstablM * rib(i) ) / dm
            fheat(i) = 1. - (bunstablT * rib(i) ) / dh
                                                                                   
         END IF    
      enddo 

!   surface-air transfer coefficients for momentum CU, for heat and 
!   moisture CT. The CUI and CTI are inversion of CU and CT respectively.

      do i = 1, len
         CU(i) = CUN(i) * fmomn(i) 
         CT(i) = CTN(i) * fheat(i)
         CUI(i) = 1. / CU(i)
         CTI(i) = 1. / CT(i)
      enddo

!   Ustar and ventlation mass flux: note that the ustar and ventlation 
!   are calculated differently from the Deardoff's methods due to their
!   differences in define the CU and CT.
                                                      
      DO I=1,len 
         USTAR(i) = SPDM(i)*SPDM(i)*CU(i) 
         USTAR(i) = sqrt( USTAR(i) ) 
         VENTMF(i)= ROS(i)*CT(i)* SPDM(i)                                        
      enddo                                                          
!                                                                       
!   Note there is no CHECK FOR VENTMF EXCEEDS TOWNSENDS(1962) FREE CONVECTION  
!   VALUE, like DEARDORFF EQ(40B), because the above CU and CT included
!   free convection conditions.                                                 
!  
                                                                                                          
      END subroutine cpl_vmfcalz                                                        
!**********************************************************************

      SUBROUTINE cpl_VMFCALZ1D(PR0,RIBC,VKRMN,DELTA,GRAV,            &
                    SH_D,PS_D,z0_D,SPDM_D,                           &
                    SHA_D,ROS_D,CU_D,CT_D,                           &
                    THVGM_D,RIB_D,USTAR_D,                           &
                    VENTMF_D,THM_D, tha_D,                           &
                    zwind_D, ztemp_D,                                &
                    cuni_D, cun_D, ctn_D,                            &
                    z1z0Urt_D, z1z0Trt_D,len)


! takes scalars and matches with len=1 variables
!***  VENTILATION MASS FLUX, BASED ON DEARDORFF, MWR, 1972
!
      integer (kind=int_kind), intent(in) ::                      &
           len
      REAL (kind=dbl_kind), intent(in) ::                         &
           pr0, ribc, vkrmn, delta, grav

! input variables as scalars
      REAL (kind=dbl_kind), intent(in) ::                         &
           z0_D, ROS_D, SH_D, PS_D,                               &
           THM_D, SHA_D, SPDM_D, tha_D  

      REAL (kind=dbl_kind), intent(in) ::                         &
           zwind_D, ztemp_D

      REAL (kind=dbl_kind), intent(out) ::                        &
           CU_D, THVGM_D, RIB_D,                                  &
           CUNI_D, USTAR_D, CT_D, VENTMF_D,                       &
           cun_D, ctn_D,                                          &
           z1z0Urt_D, z1z0Trt_D

! replacement variables of length len
      REAL (kind=dbl_kind), dimension(len) ::                     &
           z0, ROS, SH, PS,                                       &
           THM, SHA, SPDM, tha,                                   &
           zwind, ztemp 

      REAL (kind=dbl_kind), dimension(len) ::                     &
           CU, THVGM, RIB,                                        &
           CUNI, USTAR, CT, VENTMF,                               &
           cun, ctn,                                              &
           z1z0Urt, z1z0Trt

        z0(1) = z0_D
        ROS(1) = ROS_D
        SH(1) = SH_D
        PS(1) = PS_D
        THM(1) =THM_D
        SHA(1) = SHA_D
        SPDM(1) = SPDM_D
        tha(1) = tha_D
        ztemp(1) = ztemp_D
        zwind(1) = zwind_D

      call cpl_VMFCALZ(PR0,RIBC,VKRMN,DELTA,GRAV,                &
                       SH,PS,z0,                                 &
                       SPDM,SHA,ROS,cu,ct,THVGM,RIB,             &
                       USTAR,VENTMF,THM, tha, zwind, ztemp,      &
                       cuni, cun, ctn, z1z0Urt, z1z0Trt, len )

        CT_D = ct(1)
        CU_D = cu(1)
        THVGM_D = thvgm(1)
        RIB_D = rib(1)
        USTAR_D = ustar(1)
        VENTMF_D =  ventmf(1)
        CUNI_D = cuni(1)
        cun_D = cun(1)
        ctn_D = ctn(1)
        z1z0Urt_D = z1z0Urt(1)
        z1z0Trt_D = z1z0Trt(1)
        

      END subroutine cpl_vmfcalz1D

      
!**********************************************************************
                          
      SUBROUTINE cpl_VMFCALZ2(PR0,RIBC,VKRMN,DELTA,GRAV,              &
                       SH,PS,                                         &
                       SPDM,SHA,ROS,CU,ct,RA,THVGM,RIB,               &
                       USTAR,VENTMF,THM, tha,                         &
                       cun, ctn, zzwind, zztemp,                      &
                       z1z0Urt, z1z0Trt,                              &
                       len )                               

!*****************************************************************************                                                                       
!     VENTILATION MASS FLUX,Ustar, and transfer coefficients for momentum 
!     and heat fluxes, based on by Louis (1979, 1982), and revised by Holtslag
!     and Boville(1993), and by Beljaars and Holtslag (1991).              
!  
!     Rerences:
!       Beljars and Holtslag (1991): Flux parameterization over land surfaces
!              for atmospheric models. J. Appl. Meteo., 30, 327-341.
!       Holtslag and Boville (1993): Local versus nonlocal boundary-layer 
!              diffusion in a global climate model. J. of Climate, 6, 1825-
!              1842.
!       Louis, J. F., (1979):A parametric model of vertical eddy fluxes in
!              atmosphere. Boundary-Layer Meteo., 17, 187-202.
!       Louis, Tiedke, and Geleyn, (1982): A short history of the PBL
!              parameterization at ECMWF. Proc. ECMWF Workshop on Boundary-
!              Layer parameterization, ECMWF, 59-79.
!
!     General formulation:
!        surface_flux = transfer_coef.*U1*(mean_in_regerence - mean_at_sfc.) 
!     Transfer coefficients for mommentum and heat fluxes are:
!        CU = CUN*Fm, and
!        CT = CTN*Fh
!        where  CUN and CTN are nutral values of momentum and heat transfers,
!           and Fm and Fh are stability functions derived from surface
!           similarity relationships.     
!*****************************************************************************
                   
      integer (kind=int_kind), intent(in) ::                           &
           len
      REAL (kind=dbl_kind), intent(in) ::                              &
           pr0, ribc, vkrmn, delta, grav                                                           
      REAL (kind=dbl_kind), intent(in), dimension(len) ::              &
           SH, PS, SPDM, zzwind, zztemp, ros, sha, thm, tha,           &
            z1z0Urt,  z1z0Trt
      REAL (kind=dbl_kind), intent(out), dimension(len) ::             &
           thvgm, ventmf, ra, ustar, cu, rib, ct
      REAL (kind=dbl_kind), intent(inout), dimension(len) ::           &
           cun, ctn


      REAL (kind=dbl_kind), dimension(len) ::                          &
              CUI, CTI, TEMV, wgm, thgm,                               &
             fmomn, fheat, z1z0U, z1z0T, zrib
      REAL (kind=dbl_kind) ::                                          &
           bunstablM, bunstablT, cunstablM, cunstablT, bstabl, cstabl, &
           ribtemp,dm,dh

      integer (kind=int_kind) ::  i          
!      
!  constants for surface flux functions, according to Holtslag and
!      Boville (1993, J. Climate)

      bunstablM = 10.       ! constants for unstable function
      bunstablT = 15
      cunstablM = 75.
      cunstablT = 75.
      bstabl = 8.           ! constants for stable function
      cstabl = 10.

      DO I=1,len                                                    
         zrib(i) = zzwind(i) **2 / zztemp(i)                                                    
         WGM(i)  = SHA(i) - SH(i)                                      
!                                                                       
!        SFC-AIR DEFICITS OF MOISTURE AND POTENTIAL TEMPERATURE         
!        WGM IS THE EFFECTIVE SFC-AIR TOTAL MIXING RATIO DIFFERENCE.    
!                                                                       
         THGM(i)  = THA(i)  - THM(i)                                   
         THVGM(i) = THGM(i) + THA(i) * DELTA * WGM(i)                  
                                                                            
!                                                                                                                                              
!        SURFACE TO AIR DIFFERENCE OF POTENTIAL TEMPERATURE.            
!        RIB IS THE BULK RICHARDSON NUMBER, DEARDORFF EQ (25)           
!                                                                       
         TEMV(I) = THA(i) * SPDM(i) * SPDM(i)                          
         temv(i) = max(0.000001_dbl_kind,temv(i))
         RIB(i) = -THVGM(i) * grav * zrib(i) / TEMV(i) 
      enddo 
                           
!   The stability functions for momentum and heat/moisture fluxes as
!   derived from the surface-similarity theory by Luis (1079, 1982), and
!   revised by Holtslag and Boville(1993), and by Beljaars and Holtslag 
!   (1991).              
                                                                       
      DO I=1,len 
         if(rib(i).ge.0.0_dbl_kind) then                                           
!                                                                       
!        THE STABLE CASE. RIB IS USED WITH AN UPPER LIMIT              
!
            rib(i) = min( rib(i), 0.5_dbl_kind)                   
            fmomn(i) = 1. + cstabl * rib(i) *                        &
                              ( 1.+ bstabl * rib(i) )
            fmomn(i) = 1. / fmomn(i)
            fmomn(i) = max(0.0001_dbl_kind,fmomn(i))
            fheat(i) = fmomn(i)
                                         
         else                                  
!                                                                       
!        THE UNSTABLE CASE.    
!            
            ribtemp = abs(rib(i))
            ribtemp = sqrt( ribtemp )
            dm = 1. + cunstablM*cun(i)*z1z0Urt(i)*ribtemp
            dh = 1. + cunstablT*ctn(i)*z1z0Trt(i)*ribtemp
            fmomn(i) = 1. - (bunstablM * rib(i) ) / dm
            fheat(i) = 1. - (bunstablT * rib(i) ) / dh
                                                                                                    
         END IF    
      enddo 
              
!   surface-air transfer coefficients for momentum CU, for heat and 
!   moisture CT. The CUI and CTI are inversion of CU and CT respectively.

      do i = 1, len
         CU(i) = CUN(i) * fmomn(i) 
         CT(i) = CTN(i) * fheat(i)
         CUI(i) = 1. / CU(i)
         CTI(i) = 1. / CT(i)
      enddo
                                        
      DO I=1,len                                                    
         USTAR(i) =SPDM(i)*SPDM(i)*CU(i)
         USTAR(i) = sqrt( USTAR(i) )                                         
         VENTMF(i)=ROS(i)*CT(i)*SPDM(i)                                   
      enddo                                                          
!                                                                       
!   Note there is no CHECK FOR VENTMF EXCEEDS TOWNSENDS(1962) FREE CONVECTION  
!   VALUE, like DEARDORFF EQ(40B), because the above CU and CT included
!   free convection conditions.                                                 
!   
        
!                                                                       
!     AERODYNAMIC RESISTANCE                                            
!                                                                       
         DO I=1,len                                              
            RA(I)    = ROS(i) / VENTMF(i)                              
         enddo                                                       

      END subroutine cpl_vmfcalz2                                            
      
!**********************************************************************
                          
      SUBROUTINE cpl_VMFCALZO(PR0,RIBC,VKRMN,DELTA,GRAV,             &
                       PS,tha,                                       &
                       SPDM,ROS,CU,THVGM,RIB,                        &
                       USTAR,zzwind,zztemp,                          &
                       len ) 
                              
!*****************************************************************************                                                                       
!     VENTILATION MASS FLUX,Ustar, and transfer coefficients for momentum 
!     and heat fluxes, based on by Louis (1979, 1982), and revised by Holtslag
!     and Boville(1993), and by Beljaars and Holtslag (1991).              
!  
!     Rerences:
!       Beljars and Holtslag (1991): Flux parameterization over land surfaces
!              for atmospheric models. J. Appl. Meteo., 30, 327-341.
!       Holtslag and Boville (1993): Local versus nonlocal boundary-layer 
!              diffusion in a global climate model. J. of Climate, 6, 1825-
!              1842.
!       Louis, J. F., (1979):A parametric model of vertical eddy fluxes in
!              atmosphere. Boundary-Layer Meteo., 17, 187-202.
!       Louis, Tiedke, and Geleyn, (1982): A short history of the PBL
!              parameterization at ECMWF. Proc. ECMWF Workshop on Boundary-
!              Layer parameterization, ECMWF, 59-79.
!
!     General formulation:
!        surface_flux = transfer_coef.*U1*(mean_in_regerence - mean_at_sfc.) 
!     Transfer coefficients for mommentum and heat fluxes are:
!        CU = CUN*Fm, and
!        CT = CTN*Fh
!        where  CUN and CTN are nutral values of momentum and heat transfers,
!           and Fm and Fh are stability functions derived from surface
!           similarity relationships.     
!*****************************************************************************
                                                                           
      integer (kind=int_kind), intent(in) ::                         &
           len
      REAL (kind=dbl_kind), intent(in) ::                            &
           pr0, ribc, vkrmn, delta, grav                                                           

      REAL (kind=dbl_kind), intent(in), dimension(len) ::            &
           ROS, PS, THa, THVGM, SPDM
      REAL (kind=dbl_kind), intent(out), dimension(len) ::           &           
           CU, RIB, USTAR

!     local variables
      REAL (kind=dbl_kind) ::                                       &
            bunstablM, cunstablM, bstabl, cstabl, ribtemp, dm
                  

      REAL (kind=dbl_kind), dimension(len) ::                       &       
             TEMV, wgm,                                             &
             zzwind, zztemp, zrib, cun,                             &
             z1z0U, z1z0Urt,                                        &
             fmomn, cui
 
      integer (kind=int_kind) :: i          
!
!  constants for surface flux functions, according to Holtslag and
!      Boville (1993, J. Climate)

      bunstablM = 10.       ! constants for unstable function
      cunstablM = 75.
      bstabl = 8.           ! constants for stable function
      cstabl = 10.
                                                                       
      DO I=1,len                                                    

         zrib(i) = zzwind(i) **2 / zztemp(i)                                                   

!   Ratio of reference height (zwind/ztemp) and roughness length:
         z1z0U(i) = zzwind(i)/ 0.0002   ! oceanic roughness length
         z1z0Urt(i) = sqrt( z1z0U(i) )
         z1z0U(i) = log( z1z0U(i) )

!   Neutral surface transfers for momentum CUN and for heat/moisture CTN:

         cun(i) = VKRMN*VKRMN / (z1z0U(i)*z1z0U(i) )   !neutral Cm & Ct
!                                                                       
!   SURFACE TO AIR DIFFERENCE OF POTENTIAL TEMPERATURE.            
!   RIB IS THE BULK RICHARDSON NUMBER, between reference height and surface.           
!                                                                       
         TEMV(i) = THA(i) * SPDM(i) * SPDM(i)                          
         temv(i) = max(0.000001_dbl_kind, temv(i))
         RIB(I) = -THVGM(I) * GRAV * zrib(i) / TEMV(i) 
      enddo                            
   
!   The stability functions for momentum and heat/moisture fluxes as
!   derived from the surface-similarity theory by Luis (1079, 1982), and
!   revised by Holtslag and Boville(1993), and by Beljaars and Holtslag 
!   (1991).
                                                                    
      DO I=1,len 
         if(rib(i).ge.0.0_dbl_kind) then                                           
!                                                                       
!        THE STABLE CASE. RIB IS USED WITH AN UPPER LIMIT              
!
            rib(i) = min( rib(i), 0.5_dbl_kind)                   
            fmomn(i) = (1. + cstabl * rib(i) * (1.+ bstabl * rib(i)))
            fmomn(i) = 1. / fmomn(i)
            fmomn(i) = max(0.0001_dbl_kind,fmomn(i))
                                         
         else                                  
!                                                                       
!        THE UNSTABLE CASE.    
!            
            ribtemp = abs(rib(i))
            ribtemp = sqrt( ribtemp )
            dm = 1. + cunstablM * cun(i) * z1z0Urt(i) * ribtemp
            fmomn(i) = 1. - (bunstablM * rib(i) ) / dm
                                                                                   
         END IF    
      enddo 

!   surface-air transfer coefficients for momentum CU, for heat and 
!   moisture CT. The CUI and CTI are inversion of CU and CT respectively.

      do i = 1, len
         CU(i) = CUN(i) * fmomn(i) 
         CUI(i) = 1. / CU(i)

!   Ustar and ventlation mass flux: note that the ustar and ventlation 
!   are calculated differently from the Deardoff's methods due to their
!   differences in define the CU and CT.
                                                      
         USTAR(i) = SPDM(i)*SPDM(i)*CU(i) 
         USTAR(i) = sqrt( USTAR(i) ) 
      enddo                                                          
!                                                                       
!   Note there is no CHECK FOR VENTMF EXCEEDS TOWNSENDS(1962) FREE CONVECTION  
!   VALUE, like DEARDORFF EQ(40B), because the above CU and CT included
!   free convection conditions.                                                   
                                                                                                          
      END subroutine cpl_vmfcalzo                       
      
end module cpl_vmfcal_module                                        
