      SUBROUTINE COMP1(DTA) 
C                                                                              
C THIS ROUTINE CALLS THE ADVECTION SUBROUTINE FOR TEST CASE 1,
C OR THE ROUTINE FOR THE FULL SHALLOW WATER EQUATIONS OTHERWISE.
C AFTER THE NEW TIMELEVEL OF GEOPOTENTIAL, DIVERGENCE AND 
C VORTICITY ARE COMPUTED, A DIFFUSION OPERATOR IS APPLIED IN
C SPECTRAL SPACE.
C FINALLY, ROUTINE INVTR COMPUTES THE GRID U,V WIND FIELDS
C FROM DIVERGENCE AND VORTICITY SPECTRAL COEFFICIENTS AND
C TRANSFORMS THE PROGNOSTIC VARIABLES TO GRIDPOINT SPACE.
C                                                                              
C CALLED BY: STEP
C CALLS: ADVECT, FTRNS, INVTR
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
      REAL DDNOM1(0:KK), DDNOM2(0:KK), DDNOM3(0:KK) 
      EQUIVALENCE (DDNOM1(0),RVEC1(1)), (DDNOM2(0),RVEC2(1)),
     $            (DDNOM3(0),RVEC3(1))
C
C     TEMPORARIES
C
      REAL FAC1,FAC2,A2NNSQ
      INTEGER N,JN,JM,IS,I,J,ULB
C
C----- Executable Statements -------------------------------------------
C
C     CALL TIME STEPPING ROUTINE                                                
C                                                                               
      IF (ICOND .EQ. 1) THEN
C
C        ADVECTION EQUATION
C
         CALL ADVECT(DTA,FORCED)
C
C        TRANSFORM ADVECTED GEOPOTENTIAL BACK TO GRID SPACE
C
         CALL SHTRNS(LVLS,LNP1,+1,PHI,PHISC)
C
C        COPY VORTICITY & DIVERGENCE FIELD
C        (SO THERE AREN'T MORE CHANGES TO PROGRAM STRUCTURE)
C
         DO 20 J=1,NLAT
            DO 10 I=1,NLON
               DIV(I,J,LNP1) = DIV(I,J,LNM1)
               ZETA(I,J,LNP1) = ZETA(I,J,LNM1)
   10       CONTINUE
   20    CONTINUE
C
      ELSE
C
C        FULL EQUATIONS 
C
         CALL FTRNS(DTA)
C
C        A LITTLE LINEAR DIFFUSION (TIME LAGGED AS IN CCM)  
C                                                                               
         IF (HDC .NE. 0.0) THEN 
            FAC1 = 4.0/(A**4) 
            FAC2 = DTA*HDC   
C
C           SPECIAL HANDLING FOR N=0 (UNDOCUMENTED IN CCM TN !)
C
            DDNOM1(0) = 1.0
            DDNOM2(0) = 1.0
            DDNOM3(0) = 0.0
            DO 780 N=1,KK 
               A2NNSQ    = A2NNP1(N)*A2NNP1(N) 
               DDNOM1(N) = 1.0/(1.0 + FAC2*(A2NNSQ - FAC1)) 
               DDNOM2(N) = 1.0/(1.0 + FAC2*A2NNSQ) 
               DDNOM3(N) = FAC2*A2NNSQ  
  780       CONTINUE 
C                                                                               
            DO 795 JN=0,NN   
               IS = LDIAG(JN,2)  
               ULB = LDIAG(JN,1)
C
               DO 785 JM=1,ULB
                  N = JM + JN - 1   
                  ZETASC(IS+JM) = ZETASC(IS+JM) * DDNOM1(N)                
                  DIVSC (IS+JM) = DIVSC (IS+JM) * DDNOM1(N)                
                  IF (FTOPO) THEN
                     PHISC (IS+JM) = (PHISC(IS+JM) - DDNOM3(N)
     $                            * TOPOSC(IS+JM)) * DDNOM2(N)                
                  ELSE
                     PHISC (IS+JM) = PHISC(IS+JM)* DDNOM2(N)
                  ENDIF
  785          CONTINUE 
  795       CONTINUE
C
         ENDIF
C
C        TRANSFORM BACK TO GRIDPOINT SPACE
C                                                                               
         CALL INVTR(LVLS,LNP1,ZETASC,DIVSC,PHISC,
     $              ZETA,DIV,PHI,UCOS,VCOS)
C
      ENDIF
C
      RETURN                                                                    
      END                                                                       
