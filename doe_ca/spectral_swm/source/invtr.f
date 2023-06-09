      SUBROUTINE INVTR(L3D,LV,SCOEF1,SCOEF2,SCOEF3,
     $                  X1,X2,X3,UCOS,VCOS)                
C                                                                              
C THIS SUBROUTINE PERFORMS THREE INVERSE SPHERICAL HARMONIC TRANSFORMS 
C OF VORTICITY, DIVERGENCE AND GEOPOTENTIAL SPECTRAL COEFFICIENTS
C TO SCALAR DATA USING THE GAUSSIAN GRID (SEE           
C THE GUASSIAN LATITUDES AND WEIGHTS) AND THE ASSOCIATED LEGENDRE           
C POLYNOMIALS SPECIFIED IN COMMON BLOCK TRNSFM.             
C THIS SUBROUTINE OBTAINS CAPITAL U AND V MOMENTUM COMPONENTS FROM THE
C VORTICITY AND DIVERGENCE SPECTRAL COEFFICIENTS.
C IT USES THE LIBRARY ROUTINE FFT991 FOR IN-PLACE FAST FOURIER
C TRANSFORMS.
C                                                                              
C CALLED BY: COMP1
C CALLS: FFT991
C
C REVISIONS:
C 7-13-92 CHANGE TO CCM CODING CONVENTIONS (R. JAKOB)
C
C---- Model Parameters -------------------------------------------------
C
      INCLUDE 'params.i'
C
C---- Common Blocks ----------------------------------------------------
C
C TRANSFORM ARRAYS
      INCLUDE 'trnsfm.i'
C WORKSPACE
      INCLUDE 'wrkspc.i'
C
C------------ Arguments ------------------------------------------------
C
C     Input
C
C NUMBER OF TIME LEVELS OF X
      INTEGER L3D
C CURRENT TIME LEVEL FOR FIELD X
      INTEGER LV
C SPHERICAL HARMONIC COEFFICIENT ARRAY ZETASC (IS COMPLEX)
      COMPLEX SCOEF1(NALP)
C SPHERICAL HARMONIC COEFFICIENT ARRAY DIVSC (IS COMPLEX)
      COMPLEX SCOEF2(NALP)
C SPHERICAL HARMONIC COEFFICIENT ARRAY PHISC (IS COMPLEX)
      COMPLEX SCOEF3(NALP)
C
C     Output
C
C SCALAR DATA (ON GAUSSIAN GRID) ZETA
      REAL X1(NLON+2,NLAT,L3D)
C SCALAR DATA (ON GAUSSIAN GRID) DIV
      REAL X2(NLON+2,NLAT,L3D)
C SCALAR DATA (ON GAUSSIAN GRID) PHI
      REAL X3(NLON+2,NLAT,L3D)
C COMPUTED EASTWARD WIND FIELD
      REAL UCOS(NLON+2,NLAT)
C COMPUTED NORTHWARD WIND FIELD
      REAL VCOS(NLON+2,NLAT)
C                                                                               
C------ Local Variables ------------------------------------------------
C
C     STREAMFUNCTION AND VELOCITY POTENTIAL COEFFICIENTS
C     ARE IN WORKSPACE CMAT4 AND CMAT2, MERIDIONAL DERIVATIVES
C     IN WORKSPACE CMAT3 AND CMAT1 !
C
      COMPLEX CMAT1(NALP),CMAT2(NALP),
     $        CMAT3(NALP),CMAT4(NALP)
      EQUIVALENCE (CMAT1(1),RMAT1(1)),
     $            (CMAT2(1),RMAT2(1)),
     $            (CMAT3(1),RMAT3(1)),
     $            (CMAT4(1),RMAT4(1))
C
C     EVEN AND ODD PART OF FOURIER COEFFICIENTS
C                                                                               
      COMPLEX   CEVEN1(NFC,NLATB2), CODD1(NFC,NLATB2),
     $          CEVEN2(NFC,NLATB2), CODD2(NFC,NLATB2),
     $          CEVEN3(NFC,NLATB2), CODD3(NFC,NLATB2),
     $          UEVEN(NFC,NLATB2),  UODD(NFC,NLATB2),
     $          VEVEN(NFC,NLATB2),  VODD(NFC,NLATB2)
      REAL   REVEN1(NLON+2,NLATB2), RODD1(NLON+2,NLATB2),
     $       REVEN2(NLON+2,NLATB2), RODD2(NLON+2,NLATB2),
     $       REVEN3(NLON+2,NLATB2), RODD3(NLON+2,NLATB2),
     $       UEVENR(NLON+2,NLATB2), UODDR(NLON+2,NLATB2),
     $       VEVENR(NLON+2,NLATB2),  VODDR(NLON+2,NLATB2)
      EQUIVALENCE (CEVEN1(1,1),REVEN1(1,1),WS1(1,1)),
     $            (CODD1(1,1),RODD1(1,1),WS1(1,NLATB2+1)),
     $            (CEVEN2(1,1),REVEN2(1,1),WS2(1,1)),
     $            (CODD2(1,1),RODD2(1,1),WS2(1,NLATB2+1)),
     $            (CEVEN3(1,1),REVEN3(1,1),WS3(1,1)),
     $            (CODD3(1,1),RODD3(1,1),WS3(1,NLATB2+1))
      EQUIVALENCE (UEVEN(1,1),UEVENR(1,1),WS4(1,1)),
     $            (UODD(1,1),UODDR(1,1),WS4(1,NLATB2+1)),
     $            (VEVEN(1,1),VEVENR(1,1),WS5(1,1)),
     $            (VODD(1,1),VODDR(1,1),WS5(1,NLATB2+1))
C
C     TEMPORARIES
C
      INTEGER JM, JN, IS, ULB, LLB
C
C     LATITUDE INDICES
C
      INTEGER NL, SL
C
C----- Executable Statements -------------------------------------------
C
C     COMPUTE STREAMFUNCTION AND VELOCITY POTENTIAL FOR COMPUTATIONAL 
C     EFFICIENCY; INCLUDE CORIOLIS TERM HERE
C
      DO 40 JN=0,NN
         IS = LDIAG(JN,2)
C
C        SPECIAL HANDLING (M=0,N=0) AND (M=1,N=1)
C
         IF (JN .EQ. 0) THEN
C
C           SET GLOBAL MEAN TO ZERO
C
            CMAT1(IS+1) = CMPLX(0.0,0.0)
            CMAT2(IS+1) = CMPLX(0.0,0.0)
            CMAT3(IS+1) = CMPLX(0.0,0.0)
            CMAT4(IS+1) = CMPLX(0.0,0.0)
            LLB = 2
         ELSE
            LLB = 1
         ENDIF
C
C        COMPUTE INVERSE LAPLACIAN
C        (SPECIAL HANDLING OF N=0 WITH INDEX LLB !)
C
         ULB = LDIAG(JN,1)
         DO 20 JM=LLB,ULB
            CMAT4(IS+JM)  = -ANNP1(JN+JM-1) * SCOEF2(IS+JM)
            CMAT2(IS+JM)  = -ANNP1(JN+JM-1) * SCOEF1(IS+JM)
   20    CONTINUE
C
C        SUBTRACT CORIOLIS COEFFICIENTS
C
         IF (JN .EQ. 0) THEN
C           SUBTRACT CORIOLIS COEFFICIENT (M=1,N=1)
            CMAT2(IS+2)  =  CMAT2(IS+2) 
     $               + CMPLX(ANNP1(1) * CORSC2,0.0)
         ELSEIF (JN .EQ. 1) THEN
C           SUBTRACT CORIOLIS COEFFICIENT (M=0,N=1)
            CMAT2(IS+1) = CMAT2(IS+1) 
     $               + CMPLX(ANNP1(1) * CORSC1,0.0)
         ENDIF
C
C        COMPUTE MERIDIONAL DERIVATIVES (MULTIPLY BY I*M)
C
         DO 30 JM=LLB,ULB
            CMAT1(IS+JM) = CMPLX(0.0,REALM(JM)) * CMAT4(IS+JM)
            CMAT3(IS+JM) = CMPLX(0.0,REALM(JM)) * CMAT2(IS+JM)
   30    CONTINUE
C
   40 CONTINUE
C
C     INVERSE TRANSFORM FROM WAVENUMBER TO PHYSICAL SPACE 
C     DETERMINE FOURIER COEFFICIENTS BY INVERSE LEGENDRE TRANSFORM.          
C     VARY M AND N SO PROCEDURE MOVES ALONG DIAGONALS DENOTED BY             
C     INDEX JN.  M IS GIVEN BY (JM-1) WHILE N IS GIVEN BY (JN+M).            
C     FIRST ACCUMULATE EVEN WAVENUMBER CONTRIBUTION                          
C                                                                               
      DO 250 JM=1,MM+1
C
C        DO N-M EVEN COEFFICIENTS FIRST
C
C        FIRST EVEN DIAGONAL
C        THIS DETOUR HELPS AVOID THE NEED TO SEPARATELY ZERO ARRAYS  
C                                                                               
         JN = 0
         IS = LDIAG(JN,2)
C
         DO 140 NL=1,NLATB2
            CEVEN1(JM,NL) = SCOEF1(IS+JM)*ALP(IS+JM,NL)
            CEVEN2(JM,NL) = SCOEF2(IS+JM)*ALP(IS+JM,NL)
            CEVEN3(JM,NL) = SCOEF3(IS+JM)*ALP(IS+JM,NL)
            UEVEN(JM,NL)  = CMAT1(IS+JM)*ALP(IS+JM,NL)
            VEVEN(JM,NL)  = CMAT3(IS+JM)*ALP(IS+JM,NL)
            UODD(JM,NL)   =-CMAT2(IS+JM)*DALP(IS+JM,NL)
            VODD(JM,NL)   = CMAT4(IS+JM)*DALP(IS+JM,NL)
  140    CONTINUE                                                      
C                                                                               
C        NOW OTHER EVEN DIAGONALS 
C
         DO 170 JN=2,NN,2
            IS = LDIAG(JN,2)
            ULB = LDIAG(JN,1)
            IF (JM .LE. ULB) THEN
C
            DO 160 NL=1,NLATB2
               CEVEN1(JM,NL) = CEVEN1(JM,NL) 
     $                       + SCOEF1(IS+JM)*ALP(IS+JM,NL)
               CEVEN2(JM,NL) = CEVEN2(JM,NL) 
     $                       +  SCOEF2(IS+JM)*ALP(IS+JM,NL)
               CEVEN3(JM,NL) = CEVEN3(JM,NL) 
     $                       +  SCOEF3(IS+JM)*ALP(IS+JM,NL)
               UEVEN(JM,NL)  = UEVEN(JM,NL)  
     $                       + CMAT1(IS+JM)*ALP(IS+JM,NL)
               VEVEN(JM,NL)  = VEVEN(JM,NL)  
     $                       + CMAT3(IS+JM)*ALP(IS+JM,NL)
               UODD(JM,NL)   = UODD(JM,NL)   
     $                       - CMAT2(IS+JM)*DALP(IS+JM,NL)
               VODD(JM,NL)   = VODD(JM,NL)   
     $                       + CMAT4(IS+JM)*DALP(IS+JM,NL)
  160       CONTINUE 
            ENDIF
C
  170    CONTINUE
C                                                                               
C        NEXT ACCUMULATE N-M ODD WAVENUMBER CONTRIBUTION 
C                                                                               
C        FIRST ODD DIAGONAL
C        THIS DETOUR HELPS AVOID THE NEED TO SEPARATELY ZERO ARRAYS 
C                                                                               
         JN = 1
         IS = LDIAG(JN,2)
         ULB = LDIAG(JN,1)
         IF (JM .LE. ULB) THEN
C
         DO 185 NL=1,NLATB2
            CODD1(JM,NL) = SCOEF1(IS+JM)*ALP(IS+JM,NL)
            CODD2(JM,NL) = SCOEF2(IS+JM)*ALP(IS+JM,NL)
            CODD3(JM,NL) = SCOEF3(IS+JM)*ALP(IS+JM,NL)
            UODD(JM,NL)  = UODD(JM,NL)  + CMAT1(IS+JM)*ALP(IS+JM,NL)
            VODD(JM,NL)  = VODD(JM,NL)  + CMAT3(IS+JM)*ALP(IS+JM,NL)
            UEVEN(JM,NL) = UEVEN(JM,NL) - CMAT2(IS+JM)*DALP(IS+JM,NL)
            VEVEN(JM,NL) = VEVEN(JM,NL) + CMAT4(IS+JM)*DALP(IS+JM,NL)
  185    CONTINUE                                                      
C                                                                               
C        ACCOUNT FOR THE FACT THAT THE FIRST ODD DIAGONAL MAY BE    
C        SHORTER THAN THE FIRST EVEN DIAGONAL (PART OF THE GAME  
C        TO AVOID EXPLICITLY ZEROING THE ENTIRE RODD ARRAY) 
C                                                                               
         ELSE
         DO 195 NL=1,NLATB2
            CODD1(JM,NL) =  CMPLX(0.0,0.0)
            CODD2(JM,NL) =  CMPLX(0.0,0.0)
            CODD3(JM,NL) =  CMPLX(0.0,0.0)
  195    CONTINUE                                                   
         ENDIF
C                                                                               
C        NOW OTHER ODD DIAGONALS
C
         DO 210 JN=3,NN,2
            IS = LDIAG(JN,2)
            ULB = LDIAG(JN,1)
            IF (JM .LE. ULB) THEN
C
            DO 205 NL=1,NLATB2
               CODD1(JM,NL) = CODD1(JM,NL) + SCOEF1(IS+JM)*ALP(IS+JM,NL)
               CODD2(JM,NL) = CODD2(JM,NL) + SCOEF2(IS+JM)*ALP(IS+JM,NL)
               CODD3(JM,NL) = CODD3(JM,NL) + SCOEF3(IS+JM)*ALP(IS+JM,NL)
               UODD(JM,NL)  = UODD(JM,NL)  + CMAT1(IS+JM)*ALP(IS+JM,NL)
               VODD(JM,NL)  = VODD(JM,NL)  + CMAT3(IS+JM)*ALP(IS+JM,NL)
               UEVEN(JM,NL) = UEVEN(JM,NL) - CMAT2(IS+JM)*DALP(IS+JM,NL)
               VEVEN(JM,NL) = VEVEN(JM,NL) + CMAT4(IS+JM)*DALP(IS+JM,NL)
  205       CONTINUE  
            ENDIF
C
  210    CONTINUE
C
  250 CONTINUE
C
C     COMBINE CONTRIBUTIONS OF EVEN AND ODD WAVENUMBERS TO OBTAIN            
C     COMPLEX FOURIER COEFFICIENTS OF EACH HEMISPHERE
C                                                                               
      DO 240 NL=1,NLATB2
         SL = NLAT-NL+1
         DO 220 JM=1,2*(MM+1)
            X1(JM,NL,LV) = REVEN1(JM,NL) + RODD1(JM,NL) 
            X1(JM,SL,LV) = REVEN1(JM,NL) - RODD1(JM,NL)
            X2(JM,NL,LV) = REVEN2(JM,NL) + RODD2(JM,NL)
            X2(JM,SL,LV) = REVEN2(JM,NL) - RODD2(JM,NL)
            X3(JM,NL,LV) = REVEN3(JM,NL) + RODD3(JM,NL)
            X3(JM,SL,LV) = REVEN3(JM,NL) - RODD3(JM,NL)
            UCOS(JM,NL)  = UEVENR(JM,NL)  + UODDR(JM,NL)
            UCOS(JM,SL)  = UEVENR(JM,NL)  - UODDR(JM,NL)
            VCOS(JM,NL)  = VEVENR(JM,NL)  + VODDR(JM,NL)
            VCOS(JM,SL)  = VEVENR(JM,NL)  - VODDR(JM,NL)
  220    CONTINUE                                                         
C
  240 CONTINUE
C                                                                               
C     ZERO THE TAIL OF THE COMPLEX COEFFICIENT SPECTRUM                   
C                                                                               
      DO 300 NL=1,NLAT
         DO 235 JM=2*MM+3,2*NFC
            X1(JM,NL,LV) = 0.0
            X2(JM,NL,LV) = 0.0
            X3(JM,NL,LV) = 0.0
            UCOS(JM,NL)  = 0.0
            VCOS(JM,NL)  = 0.0
  235    CONTINUE                                                         
C
  300 CONTINUE
C
C     INVERSE FAST FOURIER TRANSFORM FOR EACH LATITUDE 
C     AT TIMELEVEL LV
C
      CALL FFT991(X1(1,1,LV),FFTWS2,TRIGS,IFAX,1,NLON+2,
     $              NLON,NLAT,+1)              
      CALL FFT991(X2(1,1,LV),FFTWS2,TRIGS,IFAX,1,NLON+2,
     $              NLON,NLAT,+1)
      CALL FFT991(X3(1,1,LV),FFTWS2,TRIGS,IFAX,1,NLON+2,
     $              NLON,NLAT,+1)
      CALL FFT991(UCOS(1,1),FFTWS2,TRIGS,IFAX,1,NLON+2,
     $              NLON,NLAT,+1)
      CALL FFT991(VCOS(1,1),FFTWS2,TRIGS,IFAX,1,NLON+2,
     $              NLON,NLAT,+1)
C
C     TRANSFORMATION TO PHYSICAL SPACE (INVERSE TRANSFORM) COMPLETE          
C                                                                               
      RETURN
      END                                                                       
