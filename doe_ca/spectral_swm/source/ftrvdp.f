      SUBROUTINE FTRVDP (DT, AM, BM, CM, DM, EM, ZETAM, DIVM, PHIM, 
     $                    VCOEF, DCOEF, PCOEF)
C                                                                              
C THIS SUBROUTINE PERFORMS A FORWARD TRANSFORM PROCEDURE USED           
C TO EVALUATE THE RIGHT HAND SIDE OF THE SHALLOW WATER EQUATIONS            
C FOR THE VORTICITY, DIVERGENCE AND GEOPOTENTIAL PROGNOSTIC EQUATIONS. 
C THE ROUTINE 
C MAKES USE OF INFORMATION CONTAINED IN COMMON BLOCK TRNSFM (GUASSIAN  
C WEIGHTS ASSOCIATED LEGENDRE POLYNOMIALS AND DERIVATIVES, ETC.)            
C                                                                              
C CALLED BY:  FTRNS
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
C ARRAY OF FOURIER COEFFICIENTS (UCOS*ZETA)^M
      COMPLEX AM(NFC,NLAT)
C ARRAY OF FOURIER COEFFICIENTS (VCOS*ZETA)^M
      COMPLEX BM(NFC,NLAT)
C ARRAY OF FOURIER COEFFICIENTS (VCOS*PHI)^M
      COMPLEX DM(NFC,NLAT)
C ARRAY OF FOURIER COEFFICIENTS ((UCOS**2+VCOS**2)/FAC + (PHI^TAU))^M
      COMPLEX EM(NFC,NLAT)
C ARRAY OF FOURIER COEFFICIENTS (ZETA^M)^(TAU-1)
      COMPLEX ZETAM(NFC,NLAT)
C ARRAY OF FOURIER COEFFICIENTS (DIV^TAU-1)^M
      COMPLEX DIVM(NFC,NLAT)
C ARRAY OF FOURIER COEFFICIENTS (PHI^TAU-1)^M
      COMPLEX PHIM(NFC,NLAT)
C
C     Output
C
C COMPUTED VORTICITY NEW TIMELEVEL
      COMPLEX VCOEF(NALP)                        
C COMPUTED DIVERGENCE AT NEW TIMESTEP
      COMPLEX DCOEF(NALP)
C COMPUTED GEOPOTENTIAL NEW TIMELEVEL
      COMPLEX PCOEF(NALP)
C
C------ Local Variables ------------------------------------------------
C
C     EQUIVALENCE DATA TO SAVE SPACE
C
C     AM(JM,1..NLAT/2): DIFFERENTIATED DIV. TERM, EVEN
C     AM(JM,NLAT...NLAT/2+1):  DIFFERENTIATED DIV. TERM, ODD
C     BM(JM,1..NLAT/2): DIFFERENTIATED VORT. TERM, EVEN
C     BM(JM,NLAT...NLAT/2+1):  DIFFERENTIATED VORT. TERM, ODD
C     DM(JM,1..NLAT/2): DIFFERENTIATED GEOP. TERM, EVEN
C     DM(JM,NLAT...NLAT/2+1):  DIFFERENTIATED GEOP. TERM, ODD
C     EM(JM,1..NLAT/2): LAPLACIAN DIV. TERM, EVEN
C     EM(JM,NLAT...NLAT/2+1):  LAPLACIAN DIV. TERM, ODD
C     ZETAM(JM,1..NLAT/2): UNDIFFERENTIATED VORT. TERM, EVEN
C     ZETAM(JM,NLAT...NLAT/2+1):  UNDIFFERENTIATED VORT. TERM, ODD
C     DIVM(JM,1..NLAT/2): UNDIFFERENTIATED DIV. TERM, EVEN
C     DIVM(JM,NLAT...NLAT/2+1):  UNDIFFERENTIATED DIV. TERM, ODD
C     PHIM(JM,1..NLAT/2): UNDIFFERENTIATED GEOP. TERM, EVEN
C     PHIM(JM,NLAT...NLAT/2+1):  UNDIFFERENTIATED GEOP. TERM, ODD
C
C     TEMPORARIES
C
      REAL FAC1, FAC2, WEIGHT
      INTEGER JM,JN,NL,IS,SL,ULB
C
C     EVEN/ ODD FOURIER COMPONENT
C
      COMPLEX TMPAE(MM+1), TMPAO(MM+1),
     $        TMPZE(MM+1), TMPZO(MM+1)
       COMPLEX TMP(MM+1)
C
C----- Executable Statements -------------------------------------------
C
C     VARY M AND N SO THAT PROCEDURE MOVES ALONG DIAGONALS DENOTED              
C     BY INDEX JN.  M IS GIVEN BY (JM-1); N IS GIVEN BY (JN+M).                 
C     TAKE ADVANTAGE OF SYMMETRIC CHARACTER OF LEGENDRE POLYNOMIALS             
C     PROCEDURE ASSUMES EVEN NUMBER OF GAUSSIAN LATITUDES ...                   
C
      DO 80 NL=1,NLATB2    
         SL = NLAT-NL+1
         WEIGHT = WTS(NL)
         FAC1 = DT * WEIGHT
         FAC2 = DT * WEIGHT * WTACSJ(NL)
C
C        COMBINE EVEN AND ODD TERMS
C
         DO 70 JM=1,MM+1
C
C           UNDIFFERENTIATED AND MERIDIONAL DERIVATIVE TERMS
C
            TMPAE(JM) = (AM(JM,NL) + AM(JM,SL)) * FAC2
            TMPAO(JM) = (AM(JM,NL) - AM(JM,SL)) * FAC2
            AM(JM,NL) = TMPAE(JM) 
            AM(JM,SL) = TMPAO(JM)
C
            TMPZE(JM) = (ZETAM(JM,NL) + ZETAM(JM,SL)) * WEIGHT
            TMPZO(JM) = (ZETAM(JM,NL) - ZETAM(JM,SL)) * WEIGHT
            ZETAM(JM,NL) = TMPZE(JM) - TMPAE(JM) * CMPLX(0.0,REALM(JM)) 
            ZETAM(JM,SL) = TMPZO(JM) - TMPAO(JM) * CMPLX(0.0,REALM(JM))
C
            TMPAE(JM) = (CM(JM,NL) + CM(JM,SL)) * FAC2
            TMPAO(JM) = (CM(JM,NL) - CM(JM,SL)) * FAC2
            TMPZE(JM) = (PHIM(JM,NL) + PHIM(JM,SL)) * WEIGHT
            TMPZO(JM) = (PHIM(JM,NL) - PHIM(JM,SL)) * WEIGHT
            PHIM(JM,NL) = TMPZE(JM) - TMPAE(JM) * CMPLX(0.0,REALM(JM)) 
            PHIM(JM,SL) = TMPZO(JM) - TMPAO(JM) * CMPLX(0.0,REALM(JM))
C
            TMPAE(JM) = (BM(JM,NL) + BM(JM,SL)) * FAC2
            TMPAO(JM) = (BM(JM,NL) - BM(JM,SL)) * FAC2
            BM(JM,NL) = TMPAE(JM) 
            BM(JM,SL) = TMPAO(JM)
C
            TMPZE(JM) = (DIVM(JM,NL) + DIVM(JM,SL)) * WEIGHT
            TMPZO(JM) = (DIVM(JM,NL) - DIVM(JM,SL)) * WEIGHT
            DIVM(JM,NL) = TMPZE(JM) + TMPAE(JM) * CMPLX(0.0,REALM(JM)) 
            DIVM(JM,SL) = TMPZO(JM) + TMPAO(JM) * CMPLX(0.0,REALM(JM))
C
            TMPAE(JM) = (EM(JM,NL) + EM(JM,SL)) * FAC1
            TMPAO(JM) = (EM(JM,NL) - EM(JM,SL)) * FAC1
            EM(JM,NL) = TMPAE(JM) 
            EM(JM,SL) = TMPAO(JM)
C
            TMPAE(JM) = (DM(JM,NL) + DM(JM,SL)) * FAC2
            TMPAO(JM) = (DM(JM,NL) - DM(JM,SL)) * FAC2
            DM(JM,NL) = TMPAE(JM) 
            DM(JM,SL) = TMPAO(JM)
C
   70    CONTINUE                                                               
C
   80 CONTINUE
C                                                                               
C     EVEN WAVENUMBERS
C
      DO 110 JN=0,NN,2
         IS = LDIAG(JN,2)
         ULB = LDIAG(JN,1)
C
C        SPECIAL HANDLING TO AVOID ZEROING ARRAYS
C
         NL=1
         SL = NLAT
C
         DO 90 JM=1,ULB
            TMP(JM) = DIVM(JM,NL) + EM(JM,NL) * A2NNP1(JN+JM-1)
            DCOEF(IS+JM) = ALP(IS+JM,NL) * TMP(JM)
     $                + DALP(IS+JM,NL) * AM(JM,SL)
            VCOEF(IS+JM) = ALP(IS+JM,NL) * ZETAM(JM,NL)
     $                + DALP(IS+JM,NL) * BM(JM,SL)
            PCOEF(IS+JM) = ALP(IS+JM,NL) * PHIM(JM,NL)
     $                + DALP(IS+JM,NL) * DM(JM,SL)
   90    CONTINUE
C
C        SUM OVER LATITUDES
C
         DO 150 NL=2,NLATB2
            SL = NLAT-NL+1
C
            DO 120 JM=1,ULB
               TMP(JM) = DIVM(JM,NL) + EM(JM,NL) * A2NNP1(JN+JM-1)
               DCOEF(IS+JM) = DCOEF(IS+JM)
     $                   + ALP(IS+JM,NL) * TMP(JM)
     $                   + DALP(IS+JM,NL) * AM(JM,SL)
               VCOEF(IS+JM) = VCOEF(IS+JM)
     $                   + ALP(IS+JM,NL) * ZETAM(JM,NL)
     $                   + DALP(IS+JM,NL) * BM(JM,SL)
               PCOEF(IS+JM) = PCOEF(IS+JM)
     $                   + ALP(IS+JM,NL) * PHIM(JM,NL)
     $                   + DALP(IS+JM,NL) * DM(JM,SL)
  120       CONTINUE 
C
  150    CONTINUE
C
  110 CONTINUE
C
C     ODD WAVENUMBERS
C    
      DO 200 JN=1,NN,2
         IS = LDIAG(JN,2)
         ULB = LDIAG(JN,1)
C
C        SPECIAL HANDLING TO AVOID ZEROING ARRAYS
C 
         NL = 1
         SL = NLAT
C
         DO 125 JM=1,ULB
            TMP(JM) = DIVM(JM,SL) + EM(JM,SL) * A2NNP1(JN+JM-1)
            DCOEF(IS+JM) = ALP(IS+JM,NL) * TMP(JM)
     $                + DALP(IS+JM,NL) * AM(JM,NL)
            VCOEF(IS+JM) = ALP(IS+JM,NL) * ZETAM(JM,SL)
     $                + DALP(IS+JM,NL) * BM(JM,NL)
            PCOEF(IS+JM) = ALP(IS+JM,NL) * PHIM(JM,SL)
     $                + DALP(IS+JM,NL) * DM(JM,NL)
  125    CONTINUE 
C
C        SUM OVER LATITUDES
C
         DO 160 NL=2,NLATB2
            SL = NLAT-NL+1
C
            DO 130 JM=1,ULB
               TMP(JM) = DIVM(JM,SL) + EM(JM,SL) * A2NNP1(JN+JM-1)
               DCOEF(IS+JM) = DCOEF(IS+JM)
     $                   + ALP(IS+JM,NL) * TMP(JM)
     $                   + DALP(IS+JM,NL) * AM(JM,NL)
               VCOEF(IS+JM) = VCOEF(IS+JM)
     $                   + ALP(IS+JM,NL) * ZETAM(JM,SL)
     $                   + DALP(IS+JM,NL) * BM(JM,NL)
               PCOEF(IS+JM) = PCOEF(IS+JM)
     $                   + ALP(IS+JM,NL) * PHIM(JM,SL)
     $                   + DALP(IS+JM,NL) * DM(JM,NL)
  130       CONTINUE   
C
  160    CONTINUE  
C
  200 CONTINUE
C
      RETURN                                                                    
C                                                                               
      END                                                                       
