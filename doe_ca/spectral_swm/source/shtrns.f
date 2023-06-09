      SUBROUTINE SHTRNS(L3D,LV,ITYPE,X,SCOEF)                
C                                                                              
C THIS SUBROUTINE PERFORMS SPHERICAL HARMONIC TRANSFORMS AND INVERSE  
C TRANFORMS OF ARBITRARY SCALAR DATA USING THE GAUSSIAN GRID (SEE           
C THE GUASSIAN LATITUDES AND WEIGHTS) AND THE ASSOCIATED LEGENDRE           
C POLYNOMIALS AND DERIVATIVES SPECIFIED IN COMMON BLOCK TRNSFM.             
C IT USES THE LIBRARY ROUTINE FFT991 FOR IN-PLACE FAST FOURIER
C TRANSFORMS.
C                                                                              
C CALLED BY: COMP1, INIT, STSWM
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
C SPECIFIES TYPE OF TRANSFORM DESIRED 
C          -1 => FORWARD TRANSFORM X -> SCOEF
C          +1 => INVERSE TRANSFORM SCOEF -> X
      INTEGER ITYPE
C
C     Input/Output
C
C SCALAR DATA (ON GAUSSIAN GRID)
      REAL X(NLON+2,NLAT,L3D)
C SPHERICAL HARMONIC COEFFICIENT ARRAY
      COMPLEX SCOEF(NALP)
C                                                                               
C------ Local Variables ------------------------------------------------
C
C     EQUIVALENCE TO WORKSPACE IN STORAGE POOL /WRKSPC/, ETC.                   
C                                                                               
      COMPLEX   CEVEN(NFC,NLATB2), CODD(NFC,NLATB2)            
      REAL      REVEN(NLON+2,NLATB2), RODD(NLON+2,NLATB2)
      EQUIVALENCE (CEVEN(1,1),REVEN(1,1),WS4(1,1)), 
     $            (CODD(1,1),RODD(1,1),WS4(1,NLATB2+1))            
C
C     TEMPORARIES
C
      INTEGER JM, JN, IS, ULB
      REAL WEIGHT
C
C     LATITUDE INDICES
C
      INTEGER NL, SL
C
C----- Executable Statements -------------------------------------------
C
C     FIRST CHECK FOR VALID ARGUMENTS; INVALID ARGUMENTS=>FATAL ERROR           
C                                                                               
      IF ((ITYPE .NE. +1) .AND. (ITYPE .NE. -1)) THEN                           
         WRITE (0,900) ITYPE                                                    
  900    FORMAT(/,' STSWM: FATAL ERROR IN SUBROUTINE SHTRNS:',/,
     $            ' UNKNOWN TYPE OF TRANSFORM SPECIFIED',/, 
     $          ' ITYPE = ',I3)                                              
         STOP                                                                   
      ENDIF                                                                     
C                                                                               
      IF (ITYPE .EQ. -1) THEN                                                   
C                                                                               
C        FORWARD TRANSFORM FROM PHYSICAL TO WAVENUMBER SPACE (ITYPE=-1)         
C                                                                               
C        IN PLACE FFT FOR ALL LATITUDES OF TIMELEVEL LV
C
         CALL FFT991(X(1,1,LV),FFTWS2,TRIGS,IFAX,1,NLON+2,
     $                  NLON,NLAT,-1)              
C
C        PROCEDURE FOR FORWARD GAUSS-LEGENDRE TRANSFORM.                        
C        VARY M AND N SO THAT PROCEDURE MOVES ALONG DIAGONALS DENOTED           
C        BY INDEX JN.  M IS GIVEN BY (JM-1) WHILE N IS GIVEN BY (JN+M).         
C        SINCE NUMBER OF GAUSSIAN LATITUDES IS EVEN, TAKE ADVANTAGE OF          
C        THE SYMMETRIC CHARACTER OF THE ASSOCIATED LEGENDRE POLYNOMIALS         
C      
C        TO SAVE MEMORY, THE SYMMETRIC (N-M EVEN) COEFFICIENTS ARE
C        STORED OVER THE FOURIER COEFFICIENTS JM=1,NLAT/2, AND THE
C        ANTISYMMETRIC (N-M ODD) COEFFICIENTS ARE STORED IN REVERSE
C        ORDER JM=NLAT,NLAT/2
C
         DO 40 NL=1,NLATB2   
            SL = NLAT-NL+1
            WEIGHT = WTS(NL)
C
C           COMBINE SYMMETRIC AND ANTISYMMETRIC COEFFICIENTS
C
            DO 30 JM=1,2*(MM+1)
               REVEN(JM,NL) = (X(JM,NL,LV)+X(JM,SL,LV))*WEIGHT
               RODD(JM,NL)  = (X(JM,NL,LV)-X(JM,SL,LV))*WEIGHT
   30       CONTINUE
   40    CONTINUE
C
C        EVEN N-M WAVES FIRST
C
         DO 100 JN=0,NN,2
            IS = LDIAG(JN,2)
            ULB = LDIAG(JN,1)
C
            DO 90 NL=1,NLATB2
C
C           EVEN WAVENUMBERS
C           FIRST ITERATION (TO SAVE INITIALIZATION WITH 0)
C
            IF (NL .EQ. 1) THEN
               DO 45 JM=1,ULB
                  SCOEF(IS+JM) = ALP(IS+JM,NL) * CEVEN(JM,NL)
   45          CONTINUE
C
C           REMAINING LATITUDES CONTRIBUTING TO SUM
C
            ELSE
C
               DO 70 JM=1,ULB
                  SCOEF(IS+JM) =  SCOEF(IS+JM)
     $                         + ALP(IS+JM,NL) * CEVEN(JM,NL)
   70          CONTINUE
C
            ENDIF
   90       CONTINUE
  100    CONTINUE
C
C        ODD N-M WAVENUMBERS NEXT
C
         DO 200 JN=1,NN,2
            IS = LDIAG(JN,2)
            ULB = LDIAG(JN,1)
C
            DO 95 NL=1,NLATB2
C
C           FIRST ITERATION (TO SAVE INITIALIZATION WITH 0)
C
            IF (NL .EQ. 1) THEN
C                                                                               
               DO 55 JM=1,ULB
                  SCOEF(IS+JM) = ALP(IS+JM,NL) * CODD(JM,NL)
   55          CONTINUE                                                      
C
C           REMAINING LATITUDES CONTRIBUTING TO SUM
C
            ELSE
C
               DO 85 JM=1,ULB
                  SCOEF(IS+JM) = SCOEF(IS+JM) 
     $                        + ALP(IS+JM,NL) * CODD(JM,NL)
   85          CONTINUE                                                         
            ENDIF
C 
   95       CONTINUE
  200    CONTINUE
C
C        TRANSFORMATION TO WAVENUMBER SPACE (FORWARD TRANSFORM) COMPLETE        
C
      ELSE                                                                      
C                                                                               
C        INVERSE TRANSFORM FROM WAVENUMBER TO PHYSICAL SPACE (ITYPE=+1)         
C        DETERMINE FOURIER COEFFICIENTS BY INVERSE LEGENDRE TRANSFORM.          
C        VARY M AND N SO PROCEDURE MOVES ALONG DIAGONALS DENOTED BY             
C        INDEX JN.  M IS GIVEN BY (JM-1) WHILE N IS GIVEN BY (JN+M).            
C        FIRST ACCUMULATE EVEN WAVENUMBER CONTRIBUTION                          
C                                                                               
         DO 215 JM=1,MM+1
C
C           FIRST ACCUMULATE EVEN WAVENUMBER CONTRIBUTION
C
            DO 180 JN=0,NN,2   
               IS = LDIAG(JN,2)   
               ULB = LDIAG(JN,1)
C                                                                               
C           THIS DETOUR HELPS AVOID THE NEED TO SEPARATELY ZERO CEVEN           
C                                                                               
            IF (JN .EQ. 0) THEN 
               DO 140 NL=1,NLATB2                                            
                  CEVEN(JM,NL) = SCOEF(IS+JM)*ALP(IS+JM,NL)               
  140          CONTINUE                                                      
C                                                                               
            ELSE                                                               
C                                                                               
               IF (JM .LE. ULB) THEN
                  DO 160 NL=1,NLATB2 
                     CEVEN(JM,NL) = CEVEN(JM,NL) +  
     $                             SCOEF(IS+JM)*ALP(IS+JM,NL)                
  160             CONTINUE 
               ENDIF
            ENDIF
  180       CONTINUE
C                                                                               
C           NEXT ACCUMULATE ODD WAVENUMBER CONTRIBUTION 
C                                                                               
            DO 210 JN=1,NN,2  
               IS = LDIAG(JN,2)  
               ULB = LDIAG(JN,1)
C                                                                               
C           THIS DETOUR HELPS AVOID THE NEED TO SEPARATELY ZERO CODD            
C                                                                               
            IF (JN .EQ. 1) THEN    
               IF (JM .LE. ULB) THEN
                  DO 185 NL=1,NLATB2                                            
                     CODD(JM,NL) = SCOEF(IS+JM)*ALP(IS+JM,NL)               
  185             CONTINUE                                                      
C                                                                               
C              ACCOUNT FOR THE FACT THAT THE FIRST ODD DIAGONAL MAY BE    
C              SHORTER THAN THE FIRST EVEN DIAGONAL (PART OF THE GAME  
C              TO AVOID EXPLICITLY ZEROING THE ENTIRE CODD ARRAY) 
C                                                                               
               ELSE
                  DO 195 NL=1,NLATB2                                         
                     CODD(JM,NL) =  CMPLX(0.0,0.0)  
  195             CONTINUE                                                   
C                                                                               
               ENDIF                                                            
            ELSE                                                               
C                                                                               
               IF (JM .LE. ULB) THEN
                  DO 205 NL=1,NLATB2 
                     CODD(JM,NL) = CODD(JM,NL) +  
     $                             SCOEF(IS+JM)*ALP(IS+JM,NL)                
  205             CONTINUE  
               ENDIF
C
            ENDIF
  210       CONTINUE
C
  215    CONTINUE
C
C        COMBINE CONTRIBUTIONS OF EVEN AND ODD WAVENUMBERS TO OBTAIN            
C        COMPLEX FOURIER COEFFICIENTS, FOLLOWED BY INVERSE FFT                  
C                                                                               
         DO 250 NL=1,NLATB2
            SL = NLAT-NL+1
            DO 220 JM=1,2*(MM+1)
               X(JM,NL,LV) = REVEN(JM,NL) + RODD(JM,NL) 
               X(JM,SL,LV) = REVEN(JM,NL) - RODD(JM,NL)
  220       CONTINUE                                                         
C                                                                               
C           ZERO THE TAIL OF THE COMPLEX COEFFICIENT SPECTRUM                   
C                                                                               
            DO 235 JM=2*(MM+1)+1,NLON+2
               X(JM,NL,LV) = 0.0
               X(JM,SL,LV) = 0.0
  235       CONTINUE                                                         
  250    CONTINUE
C
C        INVERSE FAST FOURIER TRANSFORM FOR EACH LATITUDE 
C        AND TIMELEVEL LV
C
         CALL FFT991(X(1,1,LV),FFTWS2,TRIGS,IFAX,1,NLON+2,
     $                  NLON,NLAT,+1)              
C
C        TRANSFORMATION TO PHYSICAL SPACE (INVERSE TRANSFORM) COMPLETE          
C                                                                               
      ENDIF                                                                     
C                                                                               
      RETURN
      END                                                                       
