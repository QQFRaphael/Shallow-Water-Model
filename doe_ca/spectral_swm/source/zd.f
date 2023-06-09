      SUBROUTINE ZD(UIC,VIC,DIVSC,ZETASC) 
C                                                                              
C THIS SUBROUTINE OBTAINS VORTICITY AND DIVERGENCE SPECTRAL 
C COEFFICIENTS FROM THE GRIDPOINT VELOCITIES (UNSCALED BY COS(THETA)) 
C THE SUBROUTINE MAKES USE OF INFORMATION           
C CONTAINED IN COMMON BLOCKS (POLYNOMIALS, COEFFICIENTS, ETC.)              
C
C CALLED BY: INIT, STSWM
C CALLS: FFT991, GLAT
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
C EASTWARD WIND FIELD
      REAL UIC(NLON+2,NLAT)
C NORTHWARD WIND FIELD
      REAL VIC(NLON+2,NLAT)
C
C     Output
C
C COMPUTED DIVERGENCE COEFFICIENTS
      COMPLEX DIVSC(NALP)
C COMPUTED VORTICITY COEFFICIENTS
      COMPLEX ZETASC(NALP)
C
C------ Local Variables ------------------------------------------------
C                                                                               
C     EQUIVALENCE TO WORKSPACE STORAGE POOL /WRKSPC/                            
C                                                                               
      REAL UTMP(NLON+2,NLAT),VTMP(NLON+2,NLAT)
      COMPLEX UTMPFC(NFC,NLAT),VTMPFC(NFC,NLAT)
      EQUIVALENCE (UTMP(1,1),UTMPFC(1,1),WS1(1,1)),
     $            (VTMP(1,1),VTMPFC(1,1),WS2(1,1))
C
      COMPLEX CTDP(MM+1,NLATB2), CTDH(MM+1,NLATB2)
      COMPLEX CTZP(MM+1,NLATB2), CTZH(MM+1,NLATB2)              
C
C     TEMPORARIES
C
      REAL RLAT, FAC
      INTEGER I,J,JM,JN,NL,IS,INDEX,SL,ULB
C
C----- Statement Function ----------------------------------------------
C
C     GRID LATITUDE
C
      EXTERNAL GLAT
      REAL GLAT
C
C----- Executable Statements -------------------------------------------
C
C     COMPUTE VORTICITY AND DIVERGENCE SPECTRAL COEFFICIENTS                    
C     FROM U AND V MOMENTUM COEFFICIENTS                                        
C                                                                               
C     SCALE FIELDS BY COS(THETA)
C                                                                               
      DO 20 J=1,NLAT
         RLAT = COS(GLAT(J))
C
C        LATITUDE = RLAT = GLAT(J)
C
         DO 10 I=1,NLON
            UTMP(I,J)=UIC(I,J) * RLAT
            VTMP(I,J)=VIC(I,J) * RLAT
   10    CONTINUE
   20 CONTINUE
C
C     FOURIER TRANSFORM U*COS(PHI) AND V*COS(PHI) FIELDS
C
      CALL FFT991(UTMP(1,1),FFTWS2,TRIGS,IFAX,1,NLON+2,
     $               NLON,NLAT,-1)                 
      CALL FFT991(VTMP(1,1),FFTWS2,TRIGS,IFAX,1,NLON+2,
     $               NLON,NLAT,-1)                 
C
C     COMPUTE VORTICITY AND DIVERGENCE COEFFICIENTS FROM U AND V FOURIER        
C     COEFFICIENTS. VARY M AND N SO THAT PROCEDURE MOVES ALONG DIAGONALS        
C     DENOTED BY INDEX JN.  M IS GIVEN BY (JM-1); N IS GIVEN BY (JN+M).         
C     TAKE ADVANTAGE OF SYMMETRIC CHARACTER OF LEGENDRE POLYNOMIALS             
C                                                                               
C     PROCEDURE FOR EVEN NUMBER OF GAUSSIAN LATITUDES ...                       
C                                                                               
      DO 105 NL=1,NLATB2  
         SL = NLAT-NL+1
         FAC = WTS(NL)*WTACSJ(NL)
C                                                                               
C        CALCULATE INTERMEDIATE QUANTITIES FOR COMPUTATIONL EFFICIENCY          
C
         DO 100 JM=1,MM+1
C                                                                               
            CTDP(JM,NL) = (UTMPFC(JM,NL) + UTMPFC(JM,SL)) * 
     $                  CMPLX(0.0,REALM(JM)*FAC)        
            CTDH(JM,NL) = (VTMPFC(JM,NL) - VTMPFC(JM,SL))*FAC              
C                                                                               
            CTZP(JM,NL) = (VTMPFC(JM,NL) + VTMPFC(JM,SL)) * 
     $                  CMPLX(0.0,REALM(JM)*FAC)        
            CTZH(JM,NL) = (UTMPFC(JM,NL) - UTMPFC(JM,SL))*FAC              
  100    CONTINUE                                                               
  105 CONTINUE
C
      DO 150 JN=0,NN,2
         IS = LDIAG(JN,2)
         ULB = LDIAG(JN,1)
C                                                                               
C        SPECIAL HANDLING OF THE FIRST LATITUDE IN THE ACCUMULATIONS            
C        DETOUR ELIMINATES THE NEED TO SEPARATELY ZERO DIVSC AND ZETASC         
C                                                                               
         DO 120 NL=1,NLATB2
C
            IF (NL .EQ. 1) THEN  
C                                                                               
C              EVEN DIAGONALS FIRST LATITUDE 
C                                                                               
               DO 110 JM=1,ULB
                  DIVSC(IS+JM) = CTDP(JM,NL)*ALP(IS+JM,NL)                     
     $                         - CTDH(JM,NL)*DALP(IS+JM,NL)
C                                                                               
                  ZETASC(IS+JM) = CTZP(JM,NL)*ALP(IS+JM,NL)                    
     $                          + CTZH(JM,NL)*DALP(IS+JM,NL)                 
  110          CONTINUE                                                         
C
            ELSE 
C                                                                               
C              EVEN DIAGONALS OTHER LATITUDES 
C                                                                               
               DO 130 JM=1,ULB
                  DIVSC(IS+JM) = DIVSC(IS+JM)                                
     $                         + CTDP(JM,NL)*ALP(IS+JM,NL)                     
     $                         - CTDH(JM,NL)*DALP(IS+JM,NL)                    
C                                                                               
                  ZETASC(IS+JM) = ZETASC(IS+JM)                              
     $                          + CTZP(JM,NL)*ALP(IS+JM,NL)                    
     $                          + CTZH(JM,NL)*DALP(IS+JM,NL)                   
  130          CONTINUE  
            ENDIF
  120    CONTINUE  
C
  150 CONTINUE
C
C        CALCULATE INTERMEDIATE QUANTITIES FOR COMPUTATIONAL EFFICIENCY
C                                                                               
      DO 165 NL=1,NLATB2
         SL = NLAT-NL+1
         FAC = WTS(NL)*WTACSJ(NL)
C
         DO 160 JM=1,MM+1
C                                                                               
            CTDP(JM,NL) = (UTMPFC(JM,NL) - UTMPFC(JM,SL)) * 
     $                  CMPLX(0.0,REALM(JM)*FAC)        
            CTDH(JM,NL) = (VTMPFC(JM,NL) + VTMPFC(JM,SL))*FAC              
C                                                                               
            CTZP(JM,NL) = (VTMPFC(JM,NL) - VTMPFC(JM,SL)) * 
     $                  CMPLX(0.0,REALM(JM)*FAC)        
            CTZH(JM,NL) = (UTMPFC(JM,NL) + UTMPFC(JM,SL))*FAC              
  160    CONTINUE                                                               
  165 CONTINUE
C
      DO 210 JN=1,NN,2
         IS = LDIAG(JN,2)
         ULB = LDIAG(JN,1)
C
C        SPECIAL HANDLING OF THE FIRST LATITUDE IN THE ACCUMULATIONS            
C        DETOUR ELIMINATES THE NEED TO SEPARATELY ZERO DIVSC AND ZETASC         
C                                                                               
         DO 180 NL=1,NLATB2
C
            IF (NL .EQ. 1) THEN 
C                                                                               
C              ODD DIAGONALS FIRST LATITUDE  
C                                                                               
               DO 170 JM=1,ULB
                  DIVSC(IS+JM) = CTDP(JM,NL)*ALP(IS+JM,NL)                     
     $                         - CTDH(JM,NL)*DALP(IS+JM,NL)                  
C                                                                               
                  ZETASC(IS+JM) = CTZP(JM,NL)*ALP(IS+JM,NL)                    
     $                          + CTZH(JM,NL)*DALP(IS+JM,NL)                 
  170          CONTINUE                                                         
C
            ELSE 
C                                                                               
C              ODD DIAGONALS REMAING LATITUDES  
C
               DO 190 JM=1,ULB
                  DIVSC(IS+JM) = DIVSC(IS+JM)                                
     $                         + CTDP(JM,NL)*ALP(IS+JM,NL)                     
     $                         - CTDH(JM,NL)*DALP(IS+JM,NL)                    
C                                                                               
                  ZETASC(IS+JM) = ZETASC(IS+JM)                              
     $                          + CTZP(JM,NL)*ALP(IS+JM,NL)                    
     $                          + CTZH(JM,NL)*DALP(IS+JM,NL)                   
  190          CONTINUE   
            ENDIF
  180    CONTINUE 
C
  210 CONTINUE
C                                                                               
C     ADD CORIOLIS TERM FOR ROTATED COORDINATE SYSTEM
C
C     WAVE M=0, N=1
      INDEX = LDIAG(1,2)+1
      ZETASC(INDEX) = ZETASC(INDEX) + CORSC1
C     WAVE M=1, N=1
      INDEX = LDIAG(0,2)+2
      ZETASC(INDEX) = ZETASC(INDEX) + CORSC2
C
      RETURN                                                                    
      END
