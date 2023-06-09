      SUBROUTINE TIMING(NSTEP,TWALL,TCPU) 
C                                                                             
C RECORDS CPU AND WALL-CLOCK TIME 
C (MASCHINE-DEPENDENT CODE FOR IBM WORKSTATIONS)
C                                                                              
C CALLED BY: STSWM
C CALLS: 
C
C REVISIONS:
C 7-13-92 CHANGE TO CCM CODING CONVENTIONS (R. JAKOB)
C
C---- Model Parameters -------------------------------------------------
C
      INCLUDE 'params.i'
C
C------------ Arguments ------------------------------------------------
C
C     Input
C
C TIME STEP
      INTEGER NSTEP
C 
C     Input/Output
C
C ARRAY OF TIME MEASUREMENTS
C TWALL(0:NGRPHS): WALL CLOCK TIME [SECONDS]
      DOUBLE PRECISION TWALL(0:NGRPHS)
C TCPU(0:NGRPHS): CPU TIME FOR PROCESS [SECONDS]
      DOUBLE PRECISION TCPU(0:NGRPHS)
C
C------ Local Variables ------------------------------------------------
C
      REAL TARRAY(2)
      INTEGER TIME
C
C----- Executable Statements -------------------------------------------
C
C     CHECK FOR ARRAY OVERFLOW
C
      IF (NSTEP .GT. NGRPHS) THEN
         WRITE (0,905) NGRPHS
  905    FORMAT(/,' STSWM: FATAL ERROR IN SUBROUTINE TIMING:',
     $          /,' ARGUMENT NSTEP EXCEEDS ALLOCATED ',
     $           'STORAGE FOR VARIABLES NGRPHS = ',I4, /)
         STOP
      ENDIF
C                                                                               
C     GET ELAPSED CPU TIME PER PROCESS
C
C     IBM VERSION
      TCPU(NSTEP) = ETIME(TARRAY)
C
C     GET WALL CLOCK TIME
C
C     IBM VERSION
      TWALL(NSTEP) = TIME()
C
      RETURN                                                                    
      END                                                                       
