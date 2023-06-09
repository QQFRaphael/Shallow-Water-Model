      SUBROUTINE FTRNVD (DT, AM, BM, DIVM, EM, ZETAM, 
     $                    VCOEF, DCOEF)
C                                                                              
C THIS SUBROUTINE PERFORMS A FORWARD TRANSFORM PROCEDURE USED           
C TO EVALUATE THE RIGHT HAND SIDE OF THE SHALLOW WATER EQUATIONS            
C FOR THE VORTICITY AND DIVERGENCE PROGNOSTIC EQUATIONS. THE ROUTINE 
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
C
C     Input & Output
C
C ARRAY OF FOURIER COEFFICIENTS (UCOS*ZETA)^M
      COMPLEX AM(NFC,NLAT)
C ARRAY OF FOURIER COEFFICIENTS (VCOS*ZETA)^M
      COMPLEX BM(NFC,NLAT)
C ARRAY OF FOURIER COEFFICIENTS (DIV^TAU-1)^M
      COMPLEX DIVM(NFC,NLAT)
C ARRAY OF FOURIER COEFFICIENTS ((UCOS**2+VCOS**2)/FAC + (PHI^TAU))^M
      COMPLEX EM(NFC,NLAT)
C ARRAY OF FOURIER COEFFICIENTS (ZETA^M)^(TAU-1)
      COMPLEX ZETAM(NFC,NLAT)
C
C     Output
C
C COMPUTED VORTICITY NEW TIMELEVEL
      COMPLEX VCOEF(NALP)                        
C COMPUTED DIVERGENCE AT NEW TIMESTEP
      COMPLEX DCOEF(NALP)
C
C------ Local Variables ------------------------------------------------
C
C     EQUIVALENCE DATA TO SAVE SPACE
C
C     ZETAM(JM,1..NLAT/2): UNDIFFERENTIATED VORT. TERM, EVEN
C     ZETAM(JM,NLAT...NLAT/2+1):  UNDIFFERENTIATED VORT. TERM, ODD
C     BM(JM,1..NLAT/2): DIFFERENTIATED VORT. TERM, EVEN
C     BM(JM,NLAT...NLAT/2+1):  DIFFERENTIATED VORT. TERM, ODD
C     EM(JM,1..NLAT/2): LAPLACIAN DIV. TERM, EVEN
C     EM(JM,NLAT...NLAT/2+1):  LAPLACIAN DIV. TERM, ODD
C     DIVM(JM,1..NLAT/2): UNDIFFERENTIATED DIV. TERM, EVEN
C     DIVM(JM,NLAT...NLAT/2+1):  UNDIFFERENTIATED DIV. TERM, ODD
C     AM(JM,1..NLAT/2): DIFFERENTIATED DIV. TERM, EVEN
C     AM(JM,NLAT...NLAT/2+1):  DIFFERENTIATED DIV. TERM, ODD
C
C     TEMPORARIES
C
      REAL FAC, FAC1, FAC2, WEIGHT
      INTEGER N, M,JM,JN,NL,IS,SL,ULB
C
C     EVEN/ ODD FOURIER COMPONENT
C
      COMPLEX TMPAE(MM+1), TMPAO(MM+1),
     $        TMPBE(MM+1), TMPBO(MM+1),
     $        TMPDE(MM+1), TMPDO(MM+1),
     $        TMPEE(MM+1), TMPEO(MM+1),
     $        TMPZE(MM+1), TMPZO(MM+1)
C
C----- Executable Statements -------------------------------------------
C
C     VARY M AND N SO THAT PROCEDURE MOVES ALONG DIAGONALS DENOTED              
C     BY INDEX JN.  M IS GIVEN BY (JM-1); N IS GIVEN BY (JN+M).                 
C     TAKE ADVANTAGE OF SYMMETRIC CHARACTER OF LEGENDRE POLYNOMIALS             
C     PROCEDURE ASSUMES EVEN NUMBER OF GAUSSIAN LATITUDES ...                   
C
      DO 80 NL=1,NLAT/2    
         SL = NLAT-NL+1
         FAC = DT*WTACSJ(NL)
         WEIGHT = WTS(NL)
         FAC1 = DT*WEIGHT
         FAC2 = FAC*WEIGHT
C
         DO 70 JM=1,MM+1
            M = JM-1                                                            
C
C           COMBINE EVEN AND ODD TERMS
C
            TMPAE(JM) = AM(JM,NL) + AM(JM,SL)
            TMPAO(JM) = AM(JM,NL) - AM(JM,SL)
            AM(JM,NL) = TMPAE(JM) * FAC2
            AM(JM,SL) = TMPAO(JM) * FAC2
C
            TMPZE(JM) = ZETAM(JM,NL) + ZETAM(JM,SL)
            TMPZO(JM) = ZETAM(JM,NL) - ZETAM(JM,SL)
            ZETAM(JM,NL) = (TMPAE(JM) * CMPLX(0.0,-REAL(M)*FAC)
     $                + TMPZE(JM)) * WEIGHT
            ZETAM(JM,SL) = (TMPAO(JM) * CMPLX(0.0,-REAL(M)*FAC)
     $                + TMPZO(JM)) * WEIGHT
C
            TMPBE(JM) = BM(JM,NL) + BM(JM,SL)
            TMPBO(JM) = BM(JM,NL) - BM(JM,SL)
            BM(JM,NL) = TMPBE(JM) * FAC2
            BM(JM,SL) = TMPBO(JM) * FAC2
C
            TMPEE(JM) = EM(JM,NL) + EM(JM,SL)
            TMPEO(JM) = EM(JM,NL) - EM(JM,SL)
            EM(JM,NL) = TMPEE(JM) * FAC1
            EM(JM,SL) = TMPEO(JM) * FAC1
C
            TMPDE(JM) = DIVM(JM,NL) + DIVM(JM,SL)
            TMPDO(JM) = DIVM(JM,NL) - DIVM(JM,SL)
            DIVM(JM,NL) = TMPBE(JM) * CMPLX(0.0,REAL(M)*FAC2)
     $                + TMPDE(JM) * WEIGHT
            DIVM(JM,SL) = TMPBO(JM) * CMPLX(0.0,REAL(M)*FAC2)
     $                + TMPDO(JM) * WEIGHT
C
   70    CONTINUE                                                               
   80 CONTINUE
C                                                                               
      DO 200 JN=0,NN
         IS = LDIAG(JN,2)
         ULB = LDIAG(JN,1)
C
C     SWITCH SYMMETRIC/ANTISYMMETRIC PART
C
         IF ( MOD(JN,2) .EQ. 0 ) THEN
C
C        EVEN WAVENUMBERS
C
         DO 150 NL=1,NLAT/2
            SL = NLAT-NL+1
C
            IF (NL .EQ. 1) THEN
               DO 90 JM=1,ULB
                  N = JM + JN - 1
                  VCOEF(IS+JM) = ALP(IS+JM,NL) * ZETAM(JM,NL) 
     $                      + DALP(IS+JM,NL) * BM(JM,SL) 
                  DCOEF(IS+JM) = ALP(IS+JM,NL) * (DIVM(JM,NL)
     $                      + EM(JM,NL)*A2NNP1(N))
     $                      + DALP(IS+JM,NL) * AM(JM,SL)
   90          CONTINUE
            ELSE
               DO 120 JM=1,ULB
                  N = JM + JN - 1
                  VCOEF(IS+JM) = ( VCOEF(IS+JM) 
     $                      + ( ALP(IS+JM,NL) * ZETAM(JM,NL) ))
     $                      + ( DALP(IS+JM,NL) * BM(JM,SL) ) 
                  DCOEF(IS+JM) = DCOEF(IS+JM)
     $                      + ALP(IS+JM,NL) * (DIVM(JM,NL)
     $                      + EM(JM,NL)*A2NNP1(N))
     $                      + DALP(IS+JM,NL) * AM(JM,SL)
  120          CONTINUE 
            ENDIF
  150    CONTINUE
C
      ELSE
C
C        ODD WAVENUMBERS
C                                                                               
         DO 160 NL=1,NLAT/2
            SL = NLAT-NL+1
C
            IF (NL .EQ. 1) THEN
               DO 125 JM=1,ULB
                  N = JM + JN - 1
                  VCOEF(IS+JM) = ALP(IS+JM,NL) * ZETAM(JM,SL) 
     $                      + DALP(IS+JM,NL) * BM(JM,NL) 
                  DCOEF(IS+JM) = ALP(IS+JM,NL) * (DIVM(JM,SL)
     $                      + EM(JM,SL)*A2NNP1(N))
     $                      + DALP(IS+JM,NL) * AM(JM,NL)
  125          CONTINUE 
            ELSE
               DO 130 JM=1,ULB
                  N = JM + JN - 1
                  VCOEF(IS+JM) = ( VCOEF(IS+JM) 
     $                      + ( ALP(IS+JM,NL) * ZETAM(JM,SL) ))
     $                      + ( DALP(IS+JM,NL) * BM(JM,NL) )
                  DCOEF(IS+JM) = DCOEF(IS+JM)
     $                      + ALP(IS+JM,NL) * (DIVM(JM,SL)
     $                      + EM(JM,SL)*A2NNP1(N))
     $                      + DALP(IS+JM,NL) * AM(JM,NL)
  130          CONTINUE   
            ENDIF
  160    CONTINUE  
C
      ENDIF
C                                                                               
  200 CONTINUE
C
      RETURN                                                                    
C                                                                               
      END                                                                       
