      SUBROUTINE TPRINT(NSTEP,TWALLA,TWALLB,TCPUA,TCPUB)
C
C WRITES SUMMARY REPORT OF TIMINGS
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
C TWALLA(0:NGRPHS): INITIAL WALL CLOCK TIME [SECONDS]
      DOUBLE PRECISION TWALLA(0:NGRPHS)
C TWALLB(0:NGRPHS): FINAL WALL CLOCK TIME [SECONDS]
      DOUBLE PRECISION TWALLB(0:NGRPHS)
C TCPUA(0:NGRPHS): INITIAL CPU TIME FOR PROCESS [SECONDS]
      DOUBLE PRECISION TCPUA(0:NGRPHS)
C TCPUB(0:NGRPHS): INITIAL CPU TIME FOR PROCESS [SECONDS]
      DOUBLE PRECISION TCPUB(0:NGRPHS)
C
C------ Local Variables ------------------------------------------------
C
      DOUBLE PRECISION TWALL, TCPU, TWALLJ, TCPUJ
      DOUBLE PRECISION TWALLM, TCPUM, TMAX, TMIN
      INTEGER I
C
C----- Executable Statements -------------------------------------------
C
      WRITE(6,50)
   50 FORMAT(/,' EXECUTION TIMES')
C
C     NUMBER OF TIME STEPS
C
      WRITE(6,700) NSTEP+1
  700 FORMAT(/,' NUMBER OF TIME STEPS: ',I3,/
     $      ' (COUNTING INITIALIZATION TIME STEP 1 TWICE)')
C
      TWALLJ = 0.0
      TCPUJ = 0.0
      TMAX = 0.0
      TMIN = TCPUB(2) - TCPUA(2)
C
      DO 400 I = 2, NSTEP
C
C        WALL CLOCK TIME
C
         TWALL = TWALLB(I) - TWALLA(I)
         TWALLJ = TWALLJ + TWALL
C
C        CPU TIMES 
C
         TCPU = TCPUB(I) - TCPUA(I)
         TCPUJ = TCPUJ + TCPU
C
         IF (TCPU .GT. TMAX) THEN
            TMAX = TCPU
         ENDIF
         IF (TCPU .LT. TMIN) THEN
            TMIN = TCPU
         ENDIF
         WRITE(6,200) I,TCPU,TWALL
  200    FORMAT(' TIME STEP ',I4,' CPU TIME: ',F10.3,' SEC',
     $        ' WALL CLOCK TIME: ',F10.3,' SEC')
C
  400 CONTINUE
C
C     OUTPUT MAX/MIN CPU TIME
C
      WRITE(6,550) TMAX,TMIN
  550 FORMAT(/,' MAXIMUM & MINIMUM CPU TIME PER TIME STEP: ',
     $       F10.3,' & ',F10.3,' SECONDS')
C
C     OUTPUT MEAN WALL CLOCK TIME
C
      TWALLM = TWALLJ/(NSTEP-1)
      WRITE(6,500) TWALLM
  500 FORMAT(/,' MEAN WALL CLOCK TIME PER TIME STEP: ',
     $         F10.3,' SECONDS')
C
C     OUTPUT MEAN CUMULATIVE CPU TIME
C
      TCPUM = TCPUJ/(NSTEP-1)
      WRITE(6,600) TCPUM
  600 FORMAT(/,' MEAN CPU TIME PER TIME STEP: ',
     $       F10.3,' SECONDS')
C
C     TOTAL WALL CLOCK TIME
C
      TWALL = TWALLB(0) - TWALLA(0)
      WRITE(6,800) TWALL
  800 FORMAT(/,' TOTAL WALL CLOCK TIME: ',F10.3,' SECONDS')
C
C     TOTAL CPU TIMES
C
      TCPU = TCPUB(0) - TCPUA(0)
      WRITE(6,1000) TCPU
 1000 FORMAT(/,' TOTAL CPU TIME: ',F10.3,' SECONDS')
C
      RETURN
      END
