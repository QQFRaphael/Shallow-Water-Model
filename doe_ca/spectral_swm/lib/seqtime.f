      SUBROUTINE TIMING(NSTEP,TWALL,TCPU)
C
C RECORDS CPU AND WALL-CLOCK TIME
C (MASCHINE-DEPENDENT CODE FOR SEQUENT MULTIPROCESSORS)
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
      REAL TIMER
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
C     SEQUENT VERSION
      TCPU(NSTEP) = ETIME(TARRAY)
C
C     GET WALL CLOCK TIME
C
C     SEQUENT VERSION
      TWALL(NSTEP) = TIMER()
C
      RETURN
      END

        REAL FUNCTION timer()
        COMMON /TIMM/ ITSEC0,IUSEC0,INIT
        INTEGER tsec,usec
        LOGICAL INIT
        DATA INIT /.TRUE./
C
        IF (INIT) THEN
           CALL timer_get(ITSEC0,IUSEC0)
           INIT = .FALSE.
        ENDIF

        CALL timer_get(tsec,usec)

        tsec = tsec - itsec0
        usec = usec - iusec0

        if (usec .le. iusec0) then
           usec = 10**6 + usec
           tsec = tsec - 1
        endif

        timer = float(tsec) + float(usec)/10**6
        RETURN
        END

