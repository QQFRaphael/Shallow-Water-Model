      SUBROUTINE FTRPE (DT, CM, DM, PHIM, PCOEF)
C                                                                              
C THIS SUBROUTINE PERFORMS A FORWARD TRANSFORM PROCEDURE USED           
C TO EVALUATE THE RIGHT HAND SIDE OF THE SHALLOW WATER EQUATIONS            
C FOR THE GEOPOTENTIAL PROGNOSTIC EQUATION. THE ROUTINE MAKES           
C USE OF INFORMATION CONTAINED IN COMMON BLOCK TRNSFM (GUASSIAN             
C WEIGHTS ASSOCIATED LEGENDRE POLYNOMIALS AND DERIVATIVES, ETC.)            
C                                                                              
C CALLED BY: ADVECT
C CALLS:
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
C
C------------ Arguments ------------------------------------------------
C
C     Input
C
C TIMESTEP
      REAL DT
C ARRAY OF FOURIER COEFFICIENTS (UCOS*PHI)^M
      COMPLEX CM(NFC,NLAT)
C
C     Input & Output
C
C ARRAY OF FOURIER COEFFICIENTS (VCOS*PHI)^M
      COMPLEX DM(NFC,NLAT)
C ARRAY OF FOURIER COEFFICIENTS (PHI^TAU-1)^M
      COMPLEX PHIM(NFC,NLAT)
C
C     Output
C
C COMPUTED GEOPOTENTIAL NEW TIMELEVEL
      COMPLEX PCOEF(NALP)
C
C------ Local Variables ------------------------------------------------
C                                                                               
C     STORAGE ASSOCIATION TO ELIMINATE NEED FOR TEMPORARY STORAGE
C     ODD TERMS ARE IN REVERSE ORDER (AS IN SHTRNS !)
C
C     UNDIFFERENTIATED + MER. DERIV. TERM, EVEN IN PHIM(JM,1..NLAT/2)
C     UNDIFFERENTIATED + MER. DERIV. TERM, ODD IN PHIM(JM,NLAT..NLAT/2-1)
C     ZONALLY DIFFERENTIATED TERM, EVEN IN DM(JM,1..NLAT/2)
C     ZONALLY DIFFERENTIATED TERM, ODD IN DM(JM,NLAT..NLAT/2-1)
C
C     TEMPORARIES
C
      REAL FAC, WEIGHT
      INTEGER M,JM,JN,NL,IS,SL,ULB
C
C     EVEN / ODD FOURIER COMPONENTS
C
      COMPLEX TMPCE(MM+1), TMPCO(MM+1),
     $        TMPPE(MM+1), TMPPO(MM+1)
C
C----- Executable Statements -------------------------------------------
C
C     VARY M AND N SO THAT PROCEDURE MOVES ALONG DIAGONALS DENOTED              
C     BY INDEX JN.  M IS GIVEN BY (JM-1); N IS GIVEN BY (JN+M).                 
C     TAKE ADVANTAGE OF SYMMETRIC CHARACTER OF LEGENDRE POLYNOMIALS             
C     PROCEDURE ASSUMES EVEN NUMBER OF GAUSSIAN LATITUDES ...                   
C                                                                               
      DO 70 NL=1,NLATB2
         SL = NLAT-NL+1
         WEIGHT = WTS(NL)
         FAC = DT*WTACSJ(NL)*WEIGHT
         DO 60 JM=1,MM+1
            M = JM-1                                                            
C
            TMPCE(JM) = (CM(JM,NL) + CM(JM,SL)) * FAC
            TMPCO(JM) = (CM(JM,NL) - CM(JM,SL)) * FAC
            TMPPE(JM) = (PHIM(JM,NL) + PHIM(JM,SL)) * WEIGHT
            TMPPO(JM) = (PHIM(JM,NL) - PHIM(JM,SL)) * WEIGHT
            PHIM(JM,NL) = TMPCE(JM) * CMPLX(0.0,-REAL(M))
     $                + TMPPE(JM) 
            PHIM(JM,SL) = TMPCO(JM) * CMPLX(0.0,-REAL(M))
     $                + TMPPO(JM)
C
            TMPCE(JM) = (DM(JM,NL) + DM(JM,SL)) * FAC
            TMPCO(JM) = (DM(JM,NL) - DM(JM,SL)) * FAC
            DM(JM,NL) = TMPCE(JM) 
            DM(JM,SL) = TMPCO(JM)
   60    CONTINUE                                                               
   70 CONTINUE
C
C     EVEN N-M COEFFICIENTS FIRST
C
      DO 150 JN=0,NN,2
         IS = LDIAG(JN,2)
         ULB = LDIAG(JN,1)
C
C        SUM OVER LATITUDE
C
         DO 120 NL=1,NLATB2
            SL = NLAT-NL+1
C
            IF (NL .EQ. 1) THEN
               DO 80 JM=1,ULB
                  PCOEF(IS+JM) = ALP(IS+JM,NL) * PHIM(JM,NL)
     $                   + DALP(IS+JM,NL) * DM(JM,SL)
   80          CONTINUE
            ELSE
               DO 110 JM=1,ULB
                  PCOEF(IS+JM) = PCOEF(IS+JM) 
     $                   + ALP(IS+JM,NL) * PHIM(JM,NL)
     $                   + DALP(IS+JM,NL) * DM(JM,SL) 
  110          CONTINUE 
            ENDIF
  120    CONTINUE
  150 CONTINUE
C                                                                               
C     ODD N-M COEFFICIENTS NEXT
C
      DO 250 JN=1,NN,2
         IS = LDIAG(JN,2)
         ULB = LDIAG(JN,1)
C
C        SUM OVER LATITUDE
C
         DO 140 NL=1,NLATB2
            SL = NLAT-NL+1
C
            IF (NL .EQ. 1) THEN
               DO 125 JM=1,ULB
                  PCOEF(IS+JM) = ALP(IS+JM,NL) * PHIM(JM,SL)
     $                   + DALP(IS+JM,NL) * DM(JM,NL)
  125          CONTINUE
            ELSE
               DO 130 JM=1,ULB
                  PCOEF(IS+JM) = PCOEF(IS+JM) 
     $                   + ALP(IS+JM,NL) * PHIM(JM,SL) 
     $                   + DALP(IS+JM,NL) * DM(JM,NL) 
  130          CONTINUE 
            ENDIF
  140    CONTINUE  
  250 CONTINUE
C
      RETURN                                                                    
C                                                                               
      END                                                                       
