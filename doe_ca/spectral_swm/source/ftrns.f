      SUBROUTINE FTRNS(DTA) 
C                                                                              
C THIS IS THE MAIN COMPUTATIONAL PROCEDURE FOR ONE TIME-
C STEP. THIS TIMESTEPPING IS DONE FOR THE PROGNOSTIC VARIABLES
C GEOPOTENTIAL, DIVERGENCE AND VORTICITY (SPECTRAL TRANSFORM
C ALGORITHM), USING A LEAPFROG TIMESTEPPING ALGORITHM.
C DEPENDING ON THE FLAG SITS, SEMI-IMPLICIT OR EXPLICIT TIME-
C STEPPING IS DONE.
C THE OLD TIMELEVEL IS LNM1, THE DERIVATIVE IS EVALUATED AT
C TIMELEVEL LN, AND THE COMPUTED VALUES GO INTO TIMELEVEL LNP1.
C THE NONLINEAR PRODUCTS ARE EVALUATED AT THE GRIDPOINTS, AND
C THE FORCING TERMS ARE ADDED FOR TEST CASE 4, USING
C THE ROUTINE FORCE TO OBTAIN THE GRID FORCING.
C A FFT TRANSFORM (FFT991) IS USED FOR EACH LATITUDE. 
C THE NEW TIMELEVEL SPECTRAL COEFFICIENTS ARE COMPUTED BY THE
C ROUTINES
C VORTICITY & DIVERGENCE: FTRNVD 
C GEOPOTENTIAL: FTRNPE
C                                                                              
C CALLED BY: COMP1
C CALLS: FFT991, FORCE, FTRNVD, FTRNPE, GLAT
C
C REVISIONS:
C 7-10-92 CHANGE TO CCM CODING CONVENTIONS (R. JAKOB)
C
C---- Model Parameters -------------------------------------------------
C
      INCLUDE 'params.i'
C
C---- Common Blocks ----------------------------------------------------
C
C TRANSFORM ARRAYS
      INCLUDE 'trnsfm.i'
C TIME DEPENDENT FIELDS
      INCLUDE 'tdvars.i'
C CONSTANTS & TIMESTEPS
      INCLUDE 'consts.i'
C WORKSPACE
      INCLUDE 'wrkspc.i'
C MOUNTAIN DATA FOR CASE 5
      INCLUDE 'finit.i'
C
C------------ Arguments ------------------------------------------------
C
C     Input
C
C TIMESTEP IN SECONDS
      REAL DTA
C
C------ Local Variables ------------------------------------------------
C
C     EQUIVALENCE TO STORAGE POOL IN COMMON BLOCK WRKSPC WHERE POSSIBLE         
C                                                                               
      REAL SIDNOM(0:KK), DDNOM(0:KK)
      EQUIVALENCE (SIDNOM(0),RVEC1(1)),(DDNOM(0),RVEC2(1))
C
      REAL TRMA(NLON+2,NLAT), TRMB(NLON+2,NLAT),
     $     TRMC(NLON+2,NLAT), TRMD(NLON+2,NLAT),
     $     TRME(NLON+2,NLAT), TRMF(NLON+2,NLAT),
     $     TRMG(NLON+2,NLAT), TRMH(NLON+2,NLAT)
      COMPLEX TRMAFC(NFC,NLAT), TRMBFC(NFC,NLAT),
     $        TRMCFC(NFC,NLAT), TRMDFC(NFC,NLAT),
     $        TRMEFC(NFC,NLAT), TRMFFC(NFC,NLAT),
     $        TRMGFC(NFC,NLAT), TRMHFC(NFC,NLAT)
      EQUIVALENCE (TRMA(1,1), TRMAFC(1,1), WS1(1,1)),
     $            (TRMB(1,1), TRMBFC(1,1), WS2(1,1)),
     $            (TRMC(1,1), TRMCFC(1,1), WS3(1,1)),
     $            (TRMD(1,1), TRMDFC(1,1), WS4(1,1)),
     $            (TRME(1,1), TRMEFC(1,1), WS5(1,1)),
     $            (TRMF(1,1), TRMFFC(1,1), WS6(1,1)),
     $            (TRMG(1,1), TRMGFC(1,1), WS7(1,1)),
     $            (TRMH(1,1), TRMHFC(1,1), WS8(1,1))
C                                                                               
C     FORCING TERMS (PHYSICAL & SPECTRAL)
C                                                                               
      REAL ETAFCG(NLON+2,NLAT), DIVFCG(NLON+2,NLAT), 
     $     PHIFCG(NLON+2,NLAT)
C
C     TEMPORARIES
C
      REAL FAC,FAC1,RLAT,FSI
      INTEGER I,J,N,JN,JM,IS,ISI
      DIMENSION DIVTMP(MM+1),PHITMP(MM+1)
      COMPLEX DIVTMP,PHITMP
C
C----- External Functions ----------------------------------------------
C
C     GAUSSIAN LATITUDES
C
      REAL GLAT
      EXTERNAL GLAT
C
C----- Executable Statements -------------------------------------------
C                                                                               
C     MAIN COMPUTATIONAL ROUTINE                                                
C                                                                               
C     COMPUTE THE FORCING TERMS (TEST CASE 4)
C
      IF (FORCED) THEN
         CALL FORCE(ETAFCG,DIVFCG,PHIFCG)
      ENDIF
C
C           EXPLICIT / SEMI-IMPLICIT TIME STEPPING
C
      IF (SITS) THEN
         FSI = 0.5
         ISI = LNM1
      ELSE
         FSI = 1.0
         ISI = LN
      ENDIF 
C
C     EVALUATE NON-LINEAR PRODUCT TERMS 
C     AND OLD TIMELEVEL OF VORTICITY, DIVERGENCE, GEOPOTENTIAL
C                                                                               
      FAC1 = DTA*PHIBAR
      DO 20 J=1,NLAT 
         RLAT = GLAT(J)
C
C        LATITUDE = RLAT
C
         FAC = 1.0/(2.0*COS(RLAT)**2)
         DO 10 I=1,NLON                                                         
C
            TRME(I,J) = ( UCOS(I,J) * UCOS(I,J) 
     $                  + VCOS(I,J) * VCOS(I,J)) * FAC
     $                  + PHI(I,J,ISI) * FSI 
            TRMH(I,J) = PHI(I,J,LNM1)
     $                  - FSI * FAC1 * DIV(I,J,ISI)
C
C           SURFACE TOPOGRAPHY 
C
            IF (FTOPO) THEN
               TRME(I,J) = TRME(I,J) + GRAV*MOUNT(I,J)
            ENDIF
C
            TRMA(I,J) = UCOS(I,J) * ZETA(I,J,LN)
            TRMB(I,J) = VCOS(I,J) * ZETA(I,J,LN)
            TRMC(I,J) = UCOS(I,J) * PHI(I,J,LN)
            TRMD(I,J) = VCOS(I,J) * PHI(I,J,LN)
C
C           VORTICITY & DIVERGENCE (OLD TIME LEVEL)
C
            TRMF(I,J) = ZETA(I,J,LNM1)
            TRMG(I,J) = DIV(I,J,LNM1)
C
C           FORCING TERMS
C
            IF (FORCED) THEN
C              HEIGHT FORCING
               TRMH(I,J) = TRMH(I,J) + DTA*PHIFCG(I,J)
               IF (MOMENT) THEN
C                 MOMENTUM FORCING
                  TRMA(I,J) = TRMA(I,J) - DIVFCG(I,J)
                  TRMB(I,J) = TRMB(I,J) + ETAFCG(I,J)
               ELSE
C                 VORTICITY / DIVERGENCE FORCING
                  TRMF(I,J) = TRMF(I,J) + DTA*ETAFCG(I,J)
                  TRMG(I,J) = TRMG(I,J) + DTA*DIVFCG(I,J)
               ENDIF
            ENDIF
   10    CONTINUE                                                               
   20 CONTINUE
C                                                                               
C     FOURIER TRANSFORM NON-LINEAR TERMS IN PLACE                               
C                                                                               
      CALL FFT991(TRMA(1,1),FFTWS2,TRIGS,IFAX,1,NLON+2,
     $               NLON,NLAT,-1)
      CALL FFT991(TRMB(1,1),FFTWS2,TRIGS,IFAX,1,NLON+2,
     $               NLON,NLAT,-1)
      CALL FFT991(TRMC(1,1),FFTWS2,TRIGS,IFAX,1,NLON+2,
     $               NLON,NLAT,-1)
      CALL FFT991(TRMD(1,1),FFTWS2,TRIGS,IFAX,1,NLON+2,
     $               NLON,NLAT,-1)
      CALL FFT991(TRME(1,1),FFTWS2,TRIGS,IFAX,1,NLON+2,
     $               NLON,NLAT,-1)
      CALL FFT991(TRMF(1,1),FFTWS2,TRIGS,IFAX,1,NLON+2,
     $               NLON,NLAT,-1)
      CALL FFT991(TRMG(1,1),FFTWS2,TRIGS,IFAX,1,NLON+2,
     $               NLON,NLAT,-1)
      CALL FFT991(TRMH(1,1),FFTWS2,TRIGS,IFAX,1,NLON+2,
     $               NLON,NLAT,-1)
C
C     FWD LEGENDRE TRANSFORM & UPDATE OF VORTICITY,
C     DIVERGENCE AND GEOPOTENTIAL SPECTRAL COEFFICIENTS
C     (DESTROYS TRMA, TRMB, TRMD, TRME, TRMF, TRMG, TRMH)
C
      CALL FTRVDP (DTA, TRMAFC, TRMBFC, TRMCFC, TRMDFC, TRMEFC, 
     $            TRMFFC, TRMGFC, TRMHFC, ZETASC, DIVSC, PHISC)
C
C     UPDATE DIVERGENCE AND MASS CONTINUITY SPECTRAL COEFFICIENTS
C     FOR SEMI-IMPLICIT TIMESTEPPING (SEE H. RITCHIE'S PAPER)
C
      IF (SITS) THEN
         FAC = DTA/2.0*PHIBAR
         FAC1 = 0.25*PHIBAR*DTA**2
         DO 730 N=0,KK
            SIDNOM(N) = 1.0/(1.0 + FAC1*A2NNP1(N))
            DDNOM(N) = DTA/2.0*A2NNP1(N)
  730    CONTINUE
C
         DO 775 JN=0,NN
            IS = LDIAG(JN,2)
C
            DO 760 JM=1,LDIAG(JN,1)
               N = JM + JN - 1
               DIVTMP(JM) = DIVSC(IS+JM)
               PHITMP(JM) = SIDNOM(N) 
     $                 * (PHISC(IS+JM) - FAC * DIVTMP(JM))	
               DIVSC(IS+JM) = DDNOM(N) * PHITMP(JM)
     $                   + DIVTMP(JM)
               PHISC(IS+JM) = PHITMP(JM)
  760       CONTINUE
  775    CONTINUE
      ENDIF
C
      RETURN                                                                    
C
      END                                                                       
