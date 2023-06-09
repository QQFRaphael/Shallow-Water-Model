      PROGRAM REFSOLN
C
C     EXAMPLE MAIN PROGRAM FOR OBTAINING REFERENCE SOLUTION ON
C     ARBITRARY GRID FROM NETCDF FILES.
C
C     RELATED DOCUMENTATION:
C
C     (1) DESCRIPTION OF SOFTWARE FOR THE SPECTRAL TRANSFORM
C         SHALLOW WATER MODEL
C     (2) DESCRIPTION OF A GLOBAL SHALLOW WATER MODEL BASED ON
C         THE SPECTRAL TRANSFORM METHOD
C
C     AUTHOR: RUEDIGER JAKOB
C     DATE: MARCH 1993
C
C----------------------------------------------------------------
C
C     REFERENCE SOLUTION PARAMETERS AND COMMON BLOCKS FOR 
C     SPECTRAL COEFFICIENTS
C
         INCLUDE 'params.i'
         INCLUDE 'refsol.i'
C
C-----------------------------------------------------------------
C
C     USER VARIABLES
C
C        NETCDF FILENAME
C
         CHARACTER*80 FNIN
C
C        MODEL TIME IN SECONDS FOR WHICH COEFFICIENTS ARE REQUESTED
C
         REAL TIME
C
C        GEOPOTENTIAL IN METER^2/SECOND^2
C
         REAL PHI
C
C        VORTICITY AND DIVERGENCE IN 1/SECOND
C
         REAL ZETA, DIV
C
C        EASTWARD AND NORTHWARD WIND IN METER/SECOND
C
         REAL U, V
C
C        LATITUDE AND LONGITUDE IN RADIANS
C
         REAL RLAT, RLON
C
C        LOOP INDICES
C
         INTEGER I, K
C
C        ERROR FLAG (IF NONZERO)
C
         INTEGER IRET
         
         integer ngeo, ndays
         character (len=80) :: file_lat, file_lon
	 real dtr

!!mod, set resolution
!        parameter (ngeo=2562)
!        real lat(ngeo),lon(ngeo),phisav(ngeo)
	 real, allocatable :: lat(:), lon(:), phisav(:)
C
C-------------------------------------------------------------------
	dtr = 4.0*atan(1.0) / 180.0
C
C     EXECUTABLE CODE
C
C
C     SET FILE NAME - SEE TABLE IN APPENDIX D OF (1)
C
c      FNIN = 'REF0077.cdf'
c      FNIN = 'REF0114.cdf'
       FNIN = '../../spectral_swm/refsol/test5/REF213-213.cdf'
C
C     SET ERROR CONDITION (NO ERROR = 0)
C

	read(*,*) ngeo
	write(6,*) ' number of geodesic grid points : ',ngeo
        read(*,*) ndays
        write(6,*) ' number of samples-1 in h-ez file :',ndays
	write(6,*)

	allocate(lat(ngeo),lon(ngeo),phisav(ngeo))
	lat = 0
	lon = 0
	phisav =0

      IRET = 0

      
c...option #3:  read lat/lon values of grid cell centers from geodesic grid
c...these are already in radians
      read(*,'(a80)') file_lat
      read(*,'(a80)') file_lon
      write(6,*) ' opening lat file', file_lat
      write(6,*) ' opening lon file', file_lon
      open(unit=18,form='formatted',status='old',file=file_lat)
      open(unit=19,form='formatted',status='old',file=file_lon)

c read for "standard" ascii files
      read(18,'(5e15.8)') lat
      read(19,'(5e15.8)') lon
c
      close(18)
      close(19)
      write(6,*) 'lat/lon files closed'

      open(unit=10,file='layer_thickness.out',form='formatted')

C
C     LOOP OVER DAYS (REFERENCE SOLUTION PROVIDED EVERY 24 h)
C
      DO 100 K = 0, ndays
C
C        COMPUTE MODEL TIME IN SECONDS
C
         TIME = 24.0 * 3600.0 * K
C
C        READ SPECTRAL COEFFICIENTS FROM FILE
C
         CALL INPTP(FNIN,TIME,IRET)
         IF (IRET .NE. 0) THEN
            WRITE(STDERR,10) IRET
   10       FORMAT(/,' REFSOL: COULD NOT READ SPECTRAL COEFFICIENTS',
     $            /,' FROM NETCDF FILE, ERROR CODE ',I4)
            STOP
         ENDIF
C

         do i = 1,ngeo
         if(mod(i,100) == 0) then
            write(6,*) 'working on geodesic grid point number: ',i
         endif
C
C              SET LATITUDE AND LONGITUDE AT WHICH TO EVALUATE
C
               if (lon(i) .lt. 0.) lon(i) = lon(i)+2.*pi
               rlat = lat(i)
               rlon = lon(i)

C
C              COMPUTE VALUES AT LOCATION
C
               CALL EVAL(RLON,RLAT,DIV,ZETA,PHI,U,V,IRET)
               IF (IRET .NE. 0) THEN
                  WRITE(STDERR,20) IRET
   20             FORMAT(/,' REFSOL: COULD NOT EVALUATE FIELDS',
     $            /,' FROM SPECTRAL COEFFICIENTS, ERROR CODE ',I4)
                  STOP
               ENDIF
               phisav(i) = phi/grav
C
C              PRINT VALUES OUT FOR REFERENCE
C
C               PRINT *,'LAT = ',RLAT/dtr,' LON = ',RLON/dtr
C               PRINT *,'   PHI = ',PHI,' VOR = ',ZETA,' DIV = ',DIV
C               PRINT *,'   U = ',U,' V = ',V
C

         enddo
C

         write(10,'(5e15.8)') phisav
  100 CONTINUE
C
      close(10)
      
      END

      SUBROUTINE INPTP(FNAME,TIME,IRET) 
C                                                                              
C THIS IS THE INPUT ROUTINE FOR PROGNOSTIC FIELDS; IT OPENS
C THE NETCDF FILE, READS THE COEFFICIENTS CORRESPONDING TO THE TIME,
C AND STORES THEM IN THE COMMON BLOCK /REFSOL/ IN 'refsol.i'.
C
C CALLED BY: REFSOL
C CALLS: INFLD
C
C---- Model Parameters and Internal Variables --------------------------
C
C      NETCDF DECLARATIONS
C
      INCLUDE 'netcdf.inc'
C
C     ARRAY SIZES, GLOBAL CONSTANTS, AND SPECTRAL COEFFICIENT ARRAYS
C
      INCLUDE 'params.i'
      INCLUDE 'refsol.i'
C
C------------ Arguments ------------------------------------------------
C
C     Input
C
C FILENAME FOR SPECTRAL COEFFICIENTS
      CHARACTER*80 FNAME
C TIME OF REFERENCE SOLUTION (SECONDS)
      REAL TIME
C
C     Output
C
C ERROR CONDITION  (IF DIFFERENT FROM 0)
      INTEGER IRET
C
C------ Local Variables ------------------------------------------------
C                                                                               
C     NETCDF VARIABLES
C
C     NETCDF ID
      INTEGER CDFID
C     VARIABLE IDS
      INTEGER ROTID, TIMEID, MMID,NNID, KKID,
     $        ZETAID, DIVID, PHIID
C     DIMENSION ID
      INTEGER TDIM
C     TIME DIMENSION NAME, MAX SIZE, CURRENT VALUE
      INTEGER DIMSIZ
      CHARACTER*(MAXNCNAM) DIMNAM
      REAL CTIME
C     VARIABLE SHAPES
      INTEGER DIMS(4)
      INTEGER STEP
C
      INTEGER N,I
C
C----- Executable Statements -------------------------------------------
C
C     SET ERROR HANDLING FOR NETCDF
C     (PRINT MESSAGES, BUT DO NOT TERMINATE)
C
      CALL NCPOPT(NCVERBOS)
C
C     OPEN EXISTING NETCDF FILE
C
      CDFID = NCOPN(FNAME,NCNOWRIT,IRET)
      IF (IRET .NE. 0) THEN
         WRITE(STDERR,330) FNAME
  330    FORMAT(/,' REFSOL: FATAL ERROR IN ROUTINE INPTP:',/,
     $         ' CANNOT OPEN NETCDF FILE: ',A80,/,
     $         ' CHECK FOR CORRECT ARGUMENT FNAME !')
         RETURN
      ENDIF
C
C     GET VARIABLE IDS
C
      ROTID  = NCVID(CDFID,'rot_angle',IRET)
      IF (IRET .NE. 0) THEN
         WRITE(STDERR,350) 
  350    FORMAT(/,' REFSOL: FATAL ERROR IN ROUTINE INPTP:',/,
     $         ' CANNOT FIND ROTATION ANGLE VARIABLE IN NETCDF FILE')
         RETURN
      ENDIF
      TIMEID = NCVID(CDFID,'time',IRET)
      IF (IRET .NE. 0) THEN
         WRITE(STDERR,360) 
  360    FORMAT(/,' REFSOL: FATAL ERROR IN ROUTINE INPTP:',/,
     $         ' CANNOT FIND TIMESTEP VARIABLE IN NETCDF FILE')
         RETURN
      ENDIF
      MMID   = NCVID(CDFID,'mm',IRET)
      IF (IRET .NE. 0) THEN
         WRITE(STDERR,370) 
  370    FORMAT(/,' REFSOL: FATAL ERROR IN ROUTINE INPTP:',/,
     $         ' CANNOT FIND M-TRUNCATION VARIABLE IN NETCDF FILE')
         RETURN
      ENDIF
      NNID   = NCVID(CDFID,'nn',IRET)
      IF (IRET .NE. 0) THEN
         WRITE(STDERR,380) 
  380    FORMAT(/,' REFSOL: FATAL ERROR IN ROUTINE INPTP:',/,
     $         ' CANNOT FIND N-TRUNCATION VARIABLE IN NETCDF FILE')
         RETURN
      ENDIF
      KKID   = NCVID(CDFID,'kk',IRET)
      IF (IRET .NE. 0) THEN
         WRITE(STDERR,390) 
  390    FORMAT(/,' REFSOL: FATAL ERROR IN ROUTINE INPTP:',/,
     $         ' CANNOT FIND K-TRUNCATION VARIABLE IN NETCDF FILE')
         RETURN
      ENDIF
      ZETAID = NCVID(CDFID,'vorticity',IRET)
      IF (IRET .NE. 0) THEN
         WRITE(STDERR,400) 
  400    FORMAT(/,' REFSOL: FATAL ERROR IN ROUTINE INPTP:',/,
     $         ' CANNOT FIND VORTICITY ARRAY IN NETCDF FILE')
         RETURN
      ENDIF
      DIVID  = NCVID(CDFID,'divergence',IRET)
      IF (IRET .NE. 0) THEN
         WRITE(STDERR,410) 
  410    FORMAT(/,' REFSOL: FATAL ERROR IN ROUTINE INPTP:',/,
     $         ' CANNOT FIND DIVERGENCE ARRAY IN NETCDF FILE')
         RETURN
      ENDIF
      PHIID  = NCVID(CDFID,'geopotential',IRET)
      IF (IRET .NE. 0) THEN
         WRITE(STDERR,420) 
  420    FORMAT(/,' REFSOL: FATAL ERROR IN ROUTINE INPTP:',/,
     $         ' CANNOT FIND GEOPOTENTIAL ARRAY IN NETCDF FILE')
         RETURN
      ENDIF
C
C     GET HIGH-RESOLUTION RUN PARAMETERS
C
      CALL NCVGT1(CDFID,MMID,DIMS,MMH,IRET)
      IF (IRET .NE. 0) THEN
         WRITE(STDERR,440) 
  440    FORMAT(/,' REFSOL: FATAL ERROR IN ROUTINE INPTP:',/,
     $         ' CANNOT READ M-TRUNCATION VARIABLE FROM NETCDF FILE')
         RETURN
      ENDIF
      CALL NCVGT1(CDFID,NNID,DIMS,NNH,IRET)
      IF (IRET .NE. 0) THEN
         WRITE(STDERR,450) 
  450    FORMAT(/,' REFSOL: FATAL ERROR IN ROUTINE INPTP:',/,
     $         ' CANNOT READ N-TRUNCATION VARIABLE FROM NETCDF FILE')
         RETURN
      ENDIF
      CALL NCVGT1(CDFID,KKID,DIMS,KKH,IRET)
      IF (IRET .NE. 0) THEN
         WRITE(STDERR,460) 
  460    FORMAT(/,' REFSOL: FATAL ERROR IN ROUTINE INPTP:',/,
     $         ' CANNOT READ K-TRUNCATION VARIABLE FROM NETCDF FILE')
         RETURN
      ENDIF
C
C     TEST FOR ARRAY OVERFLOW
C
      IF ((MMH .LT. MAXH) .OR. (NNH .LT. MAXH)) THEN
         WRITE (STDERR,520) MAXH
  520    FORMAT(/,' REFSOL: WARNING IN ROUTINE INPTP:',/,
     $      ' SPECTRAL COEFFICIENTS IN REFERENCE SOLUTION',/,
     $      ' ARE UNDEFINED (ASSUMING = 0.0) ',/,
     $      ' ADJUST PARAMETER MAXH IN FILE ''PARAMS.i'':',/,
     $      ' MAXH = ',I4)
      ELSEIF ((MAXH .LT. MMH) .OR. (MAXH .LT. NNH)) THEN
         WRITE(STDERR,530) MAXH
  530    FORMAT(/,' REFSOL: WARNING IN ROUTINE INPTP:',/,
     $         ' SPECTRAL COEFFICIENTS FROM REFERENCE SOLUTION',/,
     $         ' HAVE BEEN TRUNCATED (PARAMETER MAXH) TO T-',I4)
      ENDIF
C
      CALL NCVGT1(CDFID,ROTID,DIMS,ALPHA,IRET)
      IF (IRET .NE. 0) THEN
         WRITE(STDERR,470) 
  470    FORMAT(/,' REFSOL: FATAL ERROR IN ROUTINE INPTP:',/,
     $         ' CANNOT READ ROTATION ANGLE VARIABLE FROM NETCDF FILE')
         RETURN
      ENDIF
C
C     FIGURE OUT INDEX OF DESIRED TIME
C
      TDIM = NCDID(CDFID,'timestep',IRET)
      CALL NCDINQ(CDFID,TDIM,DIMNAM,DIMSIZ,IRET)
C
      DO 100 I = 1,DIMSIZ
         DIMS(1) = I
         CALL NCVGT1(CDFID,TIMEID,DIMS,CTIME,IRET)
C
C        COMPARE MODEL TIME AND REFERENCE SOLUTION TIME
C
         IF (ABS(3600.0*CTIME-TIME) .LE. 0.01) THEN
            STEP = I
            GOTO 110
         ENDIF
  100 CONTINUE
C
C     COULD NOT FIND REFERENCE SOLUTION AT TIME
C
      WRITE(STDERR,490) CTIME,TIME/3600.0
  490 FORMAT(/,' REFSOL: FATAL ERROR IN ROUTINE INPTP:',/,
     $      ' TIMEMARK OF REFERENCE SOLUTION INCONSISTENT',/,
     $      ' WITH EXPECTED TIME FOR ANALYTIC SOLUTION',/,
     $      ' CHECK TIME !',/,
     $      ' FILE TIME = ',0PF6.2,' EXPECTED TIME = ',0PF6.2)
      IRET = -1
      RETURN
C
C     FOUND DESIRED TIME IN NETCDF FILE
C
  110 CONTINUE
      WRITE(STDERR,500) CTIME
  500 FORMAT(/,' INFORMATIONAL NOTE FROM ROUTINE INPTP:',/,
     $      ' READING REFERENCE SOLUTION AT TIME = ',0PF6.2,' HRS')
C
C     DETERMINE LDIAG(0:NN,1:2), DIAGONAL LENGTHS AND CUMULATIVE
C     DISPLACEMENTS 
C
      LDIAG(0,1) = MAXH+1
      LDIAG(0,2) = 0
C
      DO 10 N=1,MAXH
         LDIAG(N,1) = MAXH+1-N
         LDIAG(N,2) = LDIAG(N-1,1) + LDIAG(N-1,2)
   10 CONTINUE
C                                                                               
C     READ VORTICITY
C
      CALL INFLD(CDFID,ZETAID,STEP,STDERR,MAXH,LDIAG,MMH,NNH,KKH,
     $         ZETASC,IRET)                             
      IF (IRET .NE. 0) THEN
         RETURN
      ENDIF
C                                                                               
C     READ DIVERGENCE
C                                                                               
      CALL INFLD(CDFID,DIVID,STEP,STDERR,MAXH,LDIAG,MMH,NNH,KKH,
     $          DIVSC,IRET)                             
      IF (IRET .NE. 0) THEN
         RETURN
      ENDIF
C                                                                               
C     READ GEOPOTENTIAL
C                                                                               
      CALL INFLD(CDFID,PHIID,STEP,STDERR,MAXH,LDIAG,MMH,NNH,KKH,
     $          PHISC,IRET)                             
      IF (IRET .NE. 0) THEN
         RETURN
      ENDIF
C
C     CLOSE FILE
C
      CALL NCCLOS(CDFID,IRET)
      IF (IRET .NE. 0) THEN
         WRITE(STDERR,540)
  540    FORMAT(/,' REFSOL: FATAL ERROR IN ROUTINE INPTP:',/,
     $         ' CANNOT CLOSE NETCDF FILE')
         RETURN
      ENDIF
C
C     SET TRUNCATION PARAMETERS
C
      MMH = MAXH
      NNH = MAXH
      KKH = MAXH
C
C     COEFFICIENT AND INDEX ARRAYS FOR LEGENDRE TRANSFORM
C
C     CHECK FOR SUFFICIENT STORAGE (PARAMETER MAX CORRECTLY SPECIFIED)
C
      IF (NALPH .LT. (MMH+1)*(KKH+1)-(MMH*MMH+MMH)/2-1) THEN
         WRITE (STDERR,2) MAXH
    2    FORMAT(/,' REFSOL: FATAL ERROR IN SUBROUTINE INPTP:',/,
     $          ' PARAMETER MAXH TOO SMALL SPECIFIED FOR BELOUSOV',
     $          ' RECURRENCE; MAXH = ', I10)
         IRET = -1
         RETURN
      ELSE
C
C        TRUNCATION-DEPENDENT COEFFICIENTS
C
         CALL DCEPS(MAXH,MMH,NNH,KKH,CMN,DMN,EMN,EPSIL,LROW,LDIAG)
C
C        FACTOR FOR ROUTINE UV
C
         DO 20 N = 1,KKH
            ANNP1(N) = A/REAL(N*(N+1))
   20    CONTINUE
      ENDIF
C
C     ROTATED CORIOLIS TERMS
C
C     WAVE M=0, N=1
C
      CORSC1 = SQRT(8.0/3.0)*OMEGA*COS(ALPHA)
C
C     WAVE M=1, N=1
C
      CORSC2 = - SQRT(4.0/3.0)*OMEGA*SIN(ALPHA)
C
      RETURN                                                                    
      END                                                                       
      SUBROUTINE INFLD(CDFID,VARID,STEP,STDERR,MAXH,LDIAG,MM,NN,KK,
     $         VAR,IRET) 
C                                                                              
C READS A SPECTRAL COEFFICIENT FIELD
C IN NETCDF FORMAT
C
C CALLED BY: INPTP
C CALLS:
C
C---- Model Parameters -------------------------------------------------
C
C NETCDF DECLARATIONS
      INCLUDE 'netcdf.inc'
C
C------------ Arguments ------------------------------------------------
C
C     Input
C
C NETCDF FILE ID
      INTEGER CDFID
C NETCDF VARIABLE ID
      INTEGER VARID
C TIMESTEP
      INTEGER STEP
C ERROR UNIT
      INTEGER STDERR
C DIMENSION OF LDIAG
      INTEGER MAXH
C STRUCTURE INFORMATION FOR ARRAY VAR
      INTEGER LDIAG(0:MAXH,2)                                      
C SPECTRAL TRUNCATION PARAMETERS
      INTEGER MM,NN,KK
C   
C     Output
C
C SPECTRAL ARRAY TO BE READ
      COMPLEX VAR(*)
C POSSIBLE ERROR CONDITION
      INTEGER IRET
C
C------ Local Variables ------------------------------------------------
C
      INTEGER M,N
      REAL DREAL,DIMAG
C
C     NETCDF VARIABLES
C
      INTEGER DIMS(4)
C
C----- Statement Function ----------------------------------------------
C
C     ADDRESS COMPUTATION OF ALP, DALP, EPSIL            
C                                                                               
      INTEGER IDSP
      IDSP(MDUM,NDUM) = 1 + LDIAG(NDUM-MDUM,2)+MDUM                             
C                                                                               
C----- Executable Statements -------------------------------------------
C
      DIMS(4) = STEP
      DO 1060 N=0,MAXH                                                   
         DIMS(3) = N+1
         DO 1040 M=0,N                                                      
C                                                                               
            IF ((M .LE. MM) .AND. (N .LE. MIN0(KK,M+NN)))
     $         THEN
C                                                                               
               DIMS(2) = M+1
C
C              READ REAL AND IMAGINARY PARTS
C
               DIMS(1) = 1
               CALL NCVGT1(CDFID,VARID,DIMS,DREAL,IRET)
               IF (IRET .NE. 0) THEN
                  WRITE(STDERR,500) M,N
  500             FORMAT(/,' STSWM: FATAL ERROR IN ROUTINE INFLD:',/,
     $                 ' CANNOT READ FIELD VARIABLE (M=',I4,
     $                 ',N=',I4,')')
                  RETURN
               ENDIF
               DIMS(1) = 2
               CALL NCVGT1(CDFID,VARID,DIMS,DIMAG,IRET)
               IF (IRET .NE. 0) THEN
                  WRITE(STDERR,510) M,N
  510             FORMAT(/,' STSWM: FATAL ERROR IN ROUTINE INFLD:',/,
     $                 ' CANNOT READ FIELD VARIABLE (M=',I4,
     $                 ',N=',I4,')')
                  RETURN
               ENDIF
               VAR(IDSP(M,N)) = CMPLX(DREAL,DIMAG)
            ELSE
C
C              UNDEFINED COEFFICIENT (ASSUMING 0.0)
C
               VAR(IDSP(M,N)) = CMPLX(0.0,0.0)
            ENDIF
C                                                                               
 1040    CONTINUE                                                               
 1060 CONTINUE                                                                  
C                                                                               
      RETURN                                                                    
      END                                                                       
      SUBROUTINE EVAL(LAMBDA,THETA,DIV,ZETA,PHI,U,V,IRET)
C
C ENCAPSULATED CODE FOR RECOVERING HIGH RESOLUTION SOLUTION
C AT POINT (LAMBDA,THETA) ON SPHERE.
C                   
C CALLED BY: REFSOL
C CALLS: DCEPS,DCALP,DFTFAX,DTRNS,DUV
C
C---- Model Parameters -------------------------------------------------
C
      INCLUDE 'params.i'
      INCLUDE 'refsol.i'
C
C------------ Arguments ------------------------------------------------
C
C     Input
C
C POSITION ON SPHERE (LONGITUDE,LATITUDE)
      REAL LAMBDA,THETA
C
C     Output
C
C DIVERGENCE
      REAL DIV
C VORTICITY
      REAL ZETA
C HEIGHT
      REAL PHI
C EASTWARD WIND
      REAL U
C NORTHWARD WIND
      REAL V
C ERROR FLAG (IF NONZERO)
      INTEGER IRET
C
C----- Local Parameters ------------------------------------------------
C
C     KEEP OLD ARGUMENT VALUES TO SAVE RECOMPUTATION IF THEY
C     HAVEN'T CHANGED SINCE LAST CALL
C
C     POSITION (REMEMBER PREVIOUS VALUE)
C
      REAL LAMOLD,THEOLD
      SAVE LAMOLD,THEOLD
C
C     LOCAL VARIABLES
C
C     ARRAY DIMENSIONS
C
      INTEGER NFCH
C
C     INVERSE FOURIER TRANSFORM
C
      REAL TRIGS(MAXH+1,2)
      SAVE TRIGS
C
C     VALUE OF POLYNOMIALS AND DERIVATIVES
C
      REAL ALP(NALPH),DALP(NALPH)
      SAVE ALP,DALP
C
C----- Initialized Variables -------------------------------------------
C
C     INITIAL (UNDEFINED) VALUES FOR MODEL PARAMETERS
C
      DATA LAMOLD,THEOLD /99.9,99.9/
C
C----- Executable Statements -------------------------------------------
C
C     CHECK RANGE OF LATITUDE (NO EVALUATION AT POLES !)
C
c      IF ((THETA .GE. PI/2.0) .OR. (THETA .LE. -PI/2.0)) THEN
      IF ((THETA .GT. PI/2.0) .OR. (THETA .LT. -PI/2.0)) THEN
         WRITE(STDERR,10) THETA
   10    FORMAT(/,' REFSOL: FATAL ERROR IN ROUTINE EVAL:',/,
     $         ' LATITUDE OUT OF VALID RANGE = ',F15.5)
         IRET = -1
         RETURN
      ENDIF
C
C     CHECK RANGE OF LONGITUDE
C
      IF ((LAMBDA .GT. 2.0*PI) .OR. (LAMBDA .LT. 0.0)) THEN
         WRITE(STDERR,20) LAMBDA
   20    FORMAT(/,' REFSOL: FATAL ERROR IN ROUTINE EVAL:',/,
     $         ' LONGITUDE OUT OF VALID RANGE = ',F15.5)
         IRET = -1
         RETURN
      ENDIF
C
C     NUMBER OF FOURIER COEFFICIENTS
C
      NFCH=(MMH+1) - AMAX0(MMH-KKH, 0)
C
C     COMPUTE DISCRETE FOURIER COEFFICIENTS
C     FOR LONGITUDE LAMBDA
C
      IF (LAMBDA .NE. LAMOLD) THEN
         CALL DFTFAX(MAXH,NFCH,LAMBDA,TRIGS)
         LAMOLD = LAMBDA
      ENDIF
C
C     COMPUTE ASSOCIATED LEGENDRE POLYNOMIALS FOR LATITUTE THETA
C
      IF (THETA .NE. THEOLD) THEN
         CALL DCALP(MMH,NNH,KKH,CMN,DMN,EMN,EPSIL,LROW,LDIAG,ABS(THETA),
     $              ALP,DALP)
         THEOLD = THETA
      ENDIF
C
C     EVALUATE FIELD AT CHOSEN POINT BY 
C     INVERSE LEGENDRE TRANSFORM FOLLOWED BY INVERSE FOURIER TRANSFORM
C
      CALL DTRNS(NNH,PHISC,LDIAG,TRIGS,ALP,THETA,PHI)
      CALL DTRNS(NNH,ZETASC,LDIAG,TRIGS,ALP,THETA,ZETA)
      CALL DTRNS(NNH,DIVSC,LDIAG,TRIGS,ALP,THETA,DIV)
      CALL DUV(NNH,DIVSC,ZETASC,LDIAG,TRIGS,ALP,DALP,ANNP1,
     $         CORSC1,CORSC2,THETA,U,V)
C
      RETURN
C
      END
      SUBROUTINE DFTFAX(MAXH,NFC,LAMBDA,TRIGS)
C
C COMPUTE COEFFICIENTS FOR INVERSE DISCRETE FOURIER TRANSFORM
C
C CALLED BY: EVAL
C CALLS:
C
C REVISIONS:
C 7-10-92 CHANGE TO CCM CODING CONVENTIONS (R. JAKOB)
C
C------------ Arguments ------------------------------------------------
C
C     Input
C
C ARRAY DIMENSION OF TRIGS
      INTEGER MAXH
C NUMBER OF FOURIER COEFFICIENTS
      INTEGER NFC
C LONGITUDE
      REAL LAMBDA
C
C     Output
C
C SINE AND COSINE COEFFICIENTS
      REAL TRIGS(MAXH+1,2)
C
C------ Local Variables ------------------------------------------------
C
      INTEGER I
C
C----- Executable Statements -------------------------------------------
C
      DO 100 I = 1,NFC
         TRIGS(I,1) = SIN((I-1)*LAMBDA)
         TRIGS(I,2) = COS((I-1)*LAMBDA)
  100 CONTINUE
C
      RETURN
      END
      SUBROUTINE DCEPS(MAXH,MM,NN,KK,CMN,DMN,EMN,EPSIL,LROW,LDIAG)
C                                                                              
C CALCULATES THE STRUCTURE OF THE RECURRENCE COEFFICIENT MATRICES           
C USED IN THE BELOUSOV PROCEDURE, STORES THIS INFORMATION IN                
C LROW(0:KK,2), AND EVALUATES THE COEFFICIENT MATRICES                    
C THE SPECTRAL TRUNCATION PARAMETERS ARE DEFINED BY 3 PARAMETERS:           
C MM, THE LARGEST FOURIER WAVENUMBER; KK, THE HIGHEST DEGREE OF THE         
C ASSOCIATED LEGENDRE POLYNOMIALS, AND NN THE HIGHEST DEGREE OF THE         
C ASSOCIATED LEGENDRE POLYNOMIALS FOR M=0.  THE LENGTH OF THE EPSIL         
C RECURRENCE ARRAY (AS WITH THE ASSOC. LEGENDRE POLYNOMIAL ARRAY)           
C IS GIVEN BY THE RELATION LEN = ((MM+1)*(NN+1) - (LMN**2 + LMN)/2)         
C WHERE LMN = MM + NN - KK.  VARIABLES ARE STORED ALONG DIAGONALS           
C STARTING WITH THE DIAGONAL DEFINED BY M=N.  THE LENGTH OF EACH            
C DIAGONAL IS STORED IN THE ARRAY LDIAG(0:NN,1) AND IS EVALUATED            
C USING THE EXPRESSION (MM+1) - MAX(MM + N - KK, 0) WHERE 0>N>NN.          
C CUMULATIVE DIAGONAL LENGTHS (CUMULATIVE DISPLACEMENTS) ARE STORED         
C IN LDIAG(0:NN,2) SO THAT EPSIL OF ORDER M AND DEGREE N IS                 
C ADDRESSED AS EPSIL(1 + LDIAG(N-M,2)+M)).                                  
C
C CALLED BY: EVAL
C CALLS:
C
C REVISIONS:
C 7-10-92 CHANGE TO CCM CODING CONVENTIONS (R. JAKOB)
C
C------------ Arguments ------------------------------------------------
C
C     Input
C
C DIMENSION OF LROW,LDIAG
      INTEGER MAXH
C SPECTRAL TRUNCATION PARAMETERS
      INTEGER MM,NN,KK
C
C     Output
C
C RECURRENCE COEFFICIENTS FOR ALP
      REAL CMN(*), DMN(*), EMN(*)
C RECURRENCE COEFFICIENTS FOR DALP
      REAL EPSIL(*)
C INDEX FOR ROWS
      INTEGER LROW(0:MAXH,2)
C INDEX FOR DIAGONALS
      INTEGER LDIAG(0:MAXH,2)
C
C------ Local Variables ------------------------------------------------
C
      INTEGER M,N,K,JM,JN,IS,NSQD,MSQD
C
C----- Executable Statements -------------------------------------------
C
C     FIRST DETERMINE LDIAG(0:NN,1:2), DIAGONAL LENGTHS AND CUMULATIVE          
C     DISPLACEMENTS FOR ALP, DALP, AND EPSIL ARRAYS                             
C                                                                               
      LDIAG(0,1) = MM+1
      LDIAG(0,2) = 0                                                            
C                                                                               
      DO 10 N=1,NN                                                              
         LDIAG(N,1) = (MM+1) - MAX0(MM+N-KK, 0)                                
         LDIAG(N,2) = LDIAG(N-1,1) + LDIAG(N-1,2)                               
   10 CONTINUE                                                                  
C                                                                               
C     OTHER STRUCTURE INFORMATION (ROWS)                            
C     BEGIN BY CALCULATING ROW LENGTHS AND CUMULATIVE DISPLACEMENTS             
C     AND STORE THE INFORMATION IN LROW(0:KK,1:2)                               
C     ROW INFO IS FROM M=0 TO M=MM FOR EACH 0 <= N <= KK (I.E., IT DOES        
C     NOT EXCLUDE THE EMPTY AREA BETWEEN (NN+M) AND KK WHEN KK > NN)            
C                                                                               
      LROW(0,1) = 1                                                             
      LROW(0,2) = 0                                                             
C                                                                               
      DO 15 K=1,KK                                                              
         LROW(K,1) = MIN0(K+1,MM+1)                                             
         LROW(K,2) = LROW(K-1,1) + LROW(K-1,2)                                  
   15 CONTINUE                                                                  
C                                                                               
C     COMPUTE EPSIL MATRIX                                                      
C     BEGIN WITH FIRST TWO DIAGONALS                                            
C                                                                               
      DO 25 M=0,MM                                                              
         JM = M+1                                                               
         IS = LDIAG(1,2)                                                        
         EPSIL(JM)    = 0.0                                                     
         EPSIL(IS+JM) = 1.0/SQRT(REAL(2*M+3))                                  
   25 CONTINUE                                                                  
C                                                                               
C     REMAINING DIAGONALS (JN = 2 THROUGH NN)                                   
C                                                                               
      DO 40 JN = 2,NN                                                           
         IS   = LDIAG(JN,2)                                                     
         DO 30 M=0,LDIAG(JN,1)-1                                                
            JM   = M+1                                                          
            N    = JN+M                                                         
            NSQD = N*N                                                          
            MSQD = M*M                                                          
            EPSIL(IS+JM) = SQRT(REAL(NSQD-MSQD)/REAL(4*NSQD-1))               
   30    CONTINUE                                                               
   40 CONTINUE                                                                  
C                                                                               
C     COMPUTE RECURRENCE COEFFICIENT MATRICES CMN, DMN, EMN                     
C     REASON FOR STORING BY ROW IS TO AVOID BANK CONFLICTS WHEN                 
C     EVALUATING THE POLYNOMIALS IN SUBROUTINE DCALP 
C                                                                               
      DO 130 N = 2,KK                                                           
         IS   = LROW(N,2)                                                       
         DO 120 M=2,LROW(N,1)-1                                                 
            JM = M+1                                                            
            CMN(IS+JM) = SQRT(REAL((2*N+1)*(M+N-1)*(M+N-3))                    
     $                      /(REAL((2*N-3)*(M+N)*(M+N-2))))                    
            DMN(IS+JM) = SQRT(REAL((2*N+1)*(M+N-1)*(N-M+1))                    
     $                      /(REAL((2*N-1)*(M+N)*(M+N-2))))                    
            EMN(IS+JM) = SQRT(REAL((2*N+1)*(N-M))                              
     $                      /(REAL((2*N-1)*(M+N))))                            
  120    CONTINUE                                                               
  130 CONTINUE                                                                  
C                                                                               
      RETURN                                                                    
      END                                                                       
      SUBROUTINE DCALP(MMH,NNH,KKH,CMN,DMN,EMN,EPSIL,LROW,LDIAG,RLAT,
     $                 ALP,DALP)
C                                                                              
C CALCULATES THE ASSOCIATED LEGENDRE POLYNOMIALS USING A HIGHLY        
C STABLE FOUR TERM RECURRENCE RELATION GIVEN BY BELOUSOV (1962).            
C THE SPECTRAL TRUNCATION PARAMETERS ARE DEFINED BY 3 PARAMETERS:           
C MMH, THE LARGEST FOURIER WAVENUMBER; KKH, THE HIGHEST DEGREE OF THE 
C ASSOCIATED LEGENDRE POLYNOMIALS, AND NNH THE HIGHEST DEGREE OF THE 
C ASSOCIATED LEGENDRE POLYNOMIALS FOR M=0.  THE LENGTH OF THE               
C ASSOCIATED LEGENDRE POLYNOMIAL ARRAY ALP IS GIVEN BY THE RELATION         
C LEN = ((MMH+1)*(NNH+1) - (LMN**2 + LMN)/2)  WHERE LMN = MMH + NNH - KKH 
C VARIABLES ARE STORED ALONG DIAGONALS STARTING WITH DIAGONAL M=N.          
C THE LENGTH OF EACH ROW IS STORED IN THE ARRAY LROW(0:MAXH,2).
C THE LENGTH OF EACH DIAGONAL IS STORED IN THE ARRAY LDIAG(0:MAXH,1)
C AND IS EVALUATED IN SUBROUTINE CEPS AS (MMH+1)-AMAX(MMH+N-KKH,0)  
C WHERE 0>N>NNH.  CUMULATIVE DIAGONAL LENGTHS (CUMULATIVE  
C DISPLACEMENTS) ARE ALSO STORED IN LDIAG(0:MAXH,2) SO THAT THE  
C ASSOCIATED LEGENDRE POLYNOMIAL OF ORDER M, DEGREE N, AND ARGUMENT         
C SNJ IS ADDRESSED AS ALP(1 + LDIAG(N-M,2)+M)), OR USING THE         
C STATEMENT FUNCTION IDSP AS ALP(IDSP(M,N)).  THE SAME FORM              
C APPLIES FOR ADDRESSING THE DERIVATIVES (DALP) AND RECURRENCE              
C COEFFICIENTS DEFINED IN THE EPSIL MATRIX.                                 
C
C CALLED BY: EVAL
C CALLS: 
C
C REVISIONS:
C 7-10-92 CHANGE TO CCM CODING CONVENTIONS (R. JAKOB)
C
C---- Model Parameters -------------------------------------------------
C
      INCLUDE 'params.i'
C
C------------ Arguments ------------------------------------------------
C
C     Input
C
C TRUNCATION PARAMETERS
      INTEGER MMH,NNH,KKH
C RECURRENCE COEFFICIENTS FOR ALP
      REAL CMN(NALPH), DMN(NALPH), EMN(NALPH)
C RECURRENCE COEFFICIENTS FOR DALP
      REAL EPSIL(NALPH)
C ROW LENGTH AND INDEX
      INTEGER LROW(0:MAXH,2)
C DIAGONAL LENGTH AND INDEX
      INTEGER LDIAG(0:MAXH,2)
C LATITUDE FOR EVALUATION OF BASISFUNCTIONS
      REAL RLAT
C
C     Output
C
C ASSOC. LEGENDRE POLYNOMIALS
      REAL ALP(NALPH)
C DERIV. ASSOC. LEGENDRE POLYNOMIALS
      REAL DALP(NALPH)
C
C------ Local Variables ------------------------------------------------
C
      REAL CN2N1N(MAXH+1,3)
      REAL COL1(MAXH), COL2(MAXH), SNPSUM(MAXH), CSPSUM(MAXH), 
     $     SQNP(MAXH), AN(MAXH), CSFAC(MAXH), SNFAC(MAXH), 
     $     COSTBL(MAXH), SINTBL(MAXH)            
C
C     TEMPORARIES
C
      REAL RNORM,COS2P,SNJ,THTA
      INTEGER N,M,JK,JM,JN,MSTART,NSTART
      INTEGER MLIM,IS,ISM1
C
C----- Statement Function ----------------------------------------------
C
C     ADDRESS COMPUTATION OF ALP, DALP, EPSIL            
C     E.G., EPSIL(M,N) = EPSIL(IDSP(M,N))                                       
C                                                                               
      INTEGER MDUM,NDUM,IDSP,IDSPR
      IDSP(MDUM,NDUM) = 1 + LDIAG(NDUM-MDUM,2)+MDUM                             
C                                                                               
C     STATEMENT FUNCTION FOR ADDRESS COMPUTATION OF BELOUSOV RECURRENCE         
C     COEFFICIENT MATRICES.  E.G., CMN(M,N) = CMN(IDSPR(M,N))                   
C                                                                               
      IDSPR(MDUM,NDUM) = 1 + LROW(NDUM,2)+MDUM                                  
C                                                                               
C----- Executable Statements -------------------------------------------
C                                                                               
C     COMPUTE ASSOCIATED LEGENDRE POLYNOMIALS AND THEIR DERIVATIVES FOR         
C     THE TRUNCATED WAVENUMBER SPACE DEFINED IN LDIAG(0:MAXH,2) WITH            
C     ARGUMENTS GIVEN BY PARAMETER RLAT USING BELOUSOV'S ALGORITHM.         
C     THE PROCEDURE INVOLVES EXTRA WORK FOR ANY TRUNCATION OTHER THAN           
C     TRIANGULAR BECAUSE BELOUSOV'S RECURRENCE REQUIRES POLYNOMIAL              
C     INFORMATION IN PART OF THE REGION BETWEEN KKH AND NNH.  MORE  
C     ELABORATE BOOKKEEPING COULD REDUCE THIS EXTRA COMPUTATION, BUT BY         
C     LESS THAN A FACTOR OF TWO (PROBABLY LESS THAN 10% OF TOTAL WORK).         
C
C     LATITUDE = RLAT
C                                                                               
C     BEGIN BY COMPUTING 1ST TWO ELEMENTS IN EACH ROW (M=0:1;N=0:KKH)
C     EVALUATE THE SERIES EXPANSIONS (19) AND (21) IN BELOUSOV (1962)        
C     FINAL RESULTS ARE STORED IN WORK ARRAYS COL1 AND COL2                  
C                                                                               
      COS2P = COS(RLAT)
      SNJ   = SIN(RLAT)
      THTA  = PI/2.0 - RLAT
      CN2N1N(1,1)  = SQRT(0.50)                                              
      ALP(1)  = CN2N1N(1,1)                                               
      DALP(1) = 0.0                                                       
C                                                                               
C        INITIALIZE WORKING SPACE                                               
C                                                                               
      DO 205 N=1,KKH 
         SNPSUM(N) = 0.0                                                     
         CSPSUM(N) = 0.0                                                     
         SQNP(N)   = 1.0/SQRT(REAL(N*N + N))                                
         CSFAC(N)  = 1.0                                                     
         SNFAC(N)  = REAL(N)*SQNP(N)                                        
         COSTBL(N) = COS(REAL(N)*THTA)                                 
         SINTBL(N) = SIN(REAL(N)*THTA)                                 
  205 CONTINUE                                                               
C                                                                               
      AN(1) = SQRT(0.75)                                                     
      DO 210 N=2,KKH 
         AN(N) = AN(N-1)*SQRT(1.0-(1.0/REAL(4*N*N)))                        
  210 CONTINUE                                                               
C                                                                               
C     EACH INCREMENT IN JK EVALUATES AN ADDITIONAL TERM IN EXPANSIONS        
C                                                                               
      JK=1                                                                   
      DO 215 N=1,KKH 
         CSPSUM(N) = CSPSUM(N)+COSTBL(N-JK+1)*CSFAC(N)                       
         SNPSUM(N) = SNPSUM(N)+SINTBL(N-JK+1)*SNFAC(N)                       
  215 CONTINUE                                                               
C                                                                               
      DO 225 JK=3,KKH+1,2  
C                                                                               
         NSTART = MAX0(JK-1,1)                                               
         N = NSTART                                                          
         CSFAC(N)  = REAL(JK-2)/REAL(JK-1)*REAL(2*N-JK+3)                 
     $               /REAL(2*N-JK+2)*CSFAC(N)                               
         CSPSUM(N) = CSPSUM(N) + CSFAC(N)*0.50                               
C                                                                               
         DO 220 N=NSTART+1,KKH 
            CSFAC(N)  = REAL(JK-2)/REAL(JK-1)*REAL(2*N-JK+3)              
     $                  /REAL(2*N-JK+2)*CSFAC(N)                            
            SNFAC(N)  = CSFAC(N)*REAL(N-JK+1)*SQNP(N)                       
            CSPSUM(N) = CSPSUM(N)+COSTBL(N-JK+1)*CSFAC(N)                    
            SNPSUM(N) = SNPSUM(N)+SINTBL(N-JK+1)*SNFAC(N)                    
  220    CONTINUE                                                            
  225 CONTINUE                                                               
C                                                                               
      RNORM = 1.0/ALP(1)                                                  
      DO 230 N=1,KKH 
         COL1(N) = AN(N)*CSPSUM(N)*RNORM                                     
         COL2(N) = AN(N)*SNPSUM(N)*RNORM                                     
  230 CONTINUE                                                               
C                                                                               
      DO 260 N=1,KKH 
C                                                                            
C        EVALUATE REMAINING POLYNOMIALS BY SWEEPING THROUGH ROWS N=1:KKH 
C        FIRST TWO ELEMENTS OBTAINED FROM THE ABOVE SERIES EXPANSIONS           
C                                                                               
         CN2N1N(1,3) = COL1(N)                                               
         CN2N1N(2,3) = COL2(N)                                               
C                                                                               
C        NECESSARY DETOUR TO "PRIME THE PIPELINE" (FIRST PASS)               
C                                                                               
         IF (N .EQ. 1) THEN                                                     
            CN2N1N(1,2)   = CN2N1N(1,3)                                      
            CN2N1N(2,2)   = CN2N1N(2,3)                                      
            ALP(MMH+2)  = CN2N1N(1,2)                                      
            DALP(MMH+2) = SQRT(3.0)*CN2N1N(1,1)-SNJ*CN2N1N(1,2) 
            ALP(2)     = CN2N1N(2,2)                                      
            DALP(2)    = -SNJ*CN2N1N(2,2)                            
         ELSE                                                               
C                                                                               
C        EVALUATE THE REMAINDER OF THIS ROW (M = 2, 3, 4, ...)               
C        USING BELOUSOV'S RECURRENCE RELATION                                
C                                                                               
         MLIM = MIN0(MMH,N-1) 
         DO 235 M=2,MLIM                                                     
            JM = M+1                                                         
            CN2N1N(JM,3) = CMN(IDSPR(M,N))*CN2N1N(JM-2,1)                    
     $                     -SNJ*(DMN(IDSPR(M,N))                        
     $                     *CN2N1N(JM-2,2) - EMN(IDSPR(M,N))                 
     $                     *CN2N1N(JM,2))                                    
  235    CONTINUE                                                            
C                                                                               
C        PUT VALUES OF THE POLYNOMIALS CONTAINED IN CN2N1N(0:MLIM,3)         
C        INTO THE ASSOCIATED LEGENDRE POLYNOMIAL ARRAY ALP                   
C                                                                               
         MSTART = MAX0(N-NNH,0) 
         DO 240 M=MSTART,MLIM                                                
            JM = M+1                                                         
            ALP(IDSP(M,N)) = CN2N1N(JM,3)                                 
  240    CONTINUE                                                            
C                                                                               
C        SPECIAL EVALUATION REQUIRED FOR DIAGONAL ELEMENT M=N                
C                                                                               
         IF (N .LE. MMH) THEN
            CN2N1N(N+1,3)      = SQRT(1.0 + (1.0/REAL(2*N)))*COS2P          
     $                             *CN2N1N(N,2)                              
            ALP(IDSP(N,N))  = CN2N1N(N+1,3)                               
            DALP(IDSP(N,N)) = -REAL(N)*SNJ*CN2N1N(N+1,3)            
         ENDIF
C                                                                               
C        MAKE ROOM FOR NEW POLYNOMIAL EVALUATION IN CN2N1N(0:MLIM,3)         
C                                                                               
         DO 250 JM=1,N+1                                                     
            CN2N1N(JM,1) = CN2N1N(JM,2)                                      
            CN2N1N(JM,2) = CN2N1N(JM,3)                                      
  250    CONTINUE                                                            
         ENDIF
C                                                                               
  260 CONTINUE                                                               
C                                                                               
C     EFFICIENTLY EVALUATE DERIVATIVES SEPARATELY (ALONG DIAGONALS)          
C                                                                               
      DO 280 JN = 1,NNH 
         IS   = LDIAG(JN,2)                                                  
         ISM1 = LDIAG(JN-1,2)                                                
         DO 270 M=0,LDIAG(JN,1)-1                                            
            JM = M+1                                                         
            N  = JN+M                                                        
            DALP(IS+JM) = REAL(2*N+1)*EPSIL(IS+JM)*
     $                  ALP(ISM1+JM)-REAL(N)*SNJ*ALP(IS+JM)
  270    CONTINUE                                                            
  280 CONTINUE                                                               
C                                                                               
      RETURN                                                                    
      END                                                                       
      SUBROUTINE DTRNS (NNH,SCOEF,LDIAG,TRIGS,ALP,RLAT,PHI)                
C                                                                              
C THIS SUBROUTINE PERFORMS INVERSE SPHERICAL HARMONIC TRANSFORMS   
C INTO FOURIER SPACE USING THE ASSOCIATED LEGENDRE POLYNOMIALS.
C IT IS A REDUCED VERSION OF THE SHTRNS ROUTINE 
C                                                                              
C CALLED BY: EVAL
C CALLS: DFT991
C
C REVISIONS:
C 7-10-92 CHANGE TO CCM CODING CONVENTIONS (R. JAKOB)
C
C---- Model Parameters -------------------------------------------------
C
      INCLUDE 'params.i'
C
C
C------------ Arguments ------------------------------------------------
C
C     Input
C
C SPECTRAL TRUNCATION PARAMETER
      INTEGER NNH
C SPHERICAL HARMONIC COEFFICIENT ARRAY
      COMPLEX SCOEF(NALPH)
C INDEX INTO SPECTRAL ARRAY
      INTEGER LDIAG(0:MAXH,2)
C COEFFICIENTS FOR DISCRETE FOURIER TRANSFORM
      REAL TRIGS(MAXH+1,2)
C ASSOC. LEGENDRE POLYNOMIALS
      REAL ALP(NALPH)
C LATITUDE
      REAL RLAT
C
C     Output
C
C COMPUTED FUNCTION VALUE AT GRIDPOINT
      REAL PHI
C
C------ Local Variables ------------------------------------------------
C
      COMPLEX   CEVEN(MAXH+1), CODD(MAXH+1)            
C
C     TEMPORARIES
C
      INTEGER JM,JN,IS
C
C     FOURIER COEFFICIENTS
C
      COMPLEX X(MAXH+1)
C                                                                               
C----- Executable Statements -------------------------------------------
C                                                                               
C     DETERMINE FOURIER COEFFICIENTS BY INVERSE LEGENDRE TRANSFORM.          
C     VARY M AND N SO PROCEDURE MOVES ALONG DIAGONALS DENOTED BY             
C     INDEX JN.  M IS GIVEN BY (JM-1) WHILE N IS GIVEN BY (JN+M).            
C     FIRST ACCUMULATE EVEN WAVENUMBER CONTRIBUTION                          
C                                                                               
      DO 180 JN=0,NNH,2 
         IS = LDIAG(JN,2)                                                    
C                                                                               
C        THIS DETOUR HELPS AVOID THE NEED TO SEPARATELY ZERO CEVEN           
C                                                                               
         IF (JN .EQ. 0) THEN  
            DO 150 JM=1,LDIAG(0,1)                                           
               CEVEN(JM) = SCOEF(IS+JM)*ALP(IS+JM)               
  150       CONTINUE                                                         
C                                                                               
         ELSE                                                               
C                                                                               
            DO 170 JM=1,LDIAG(JN,1)
               CEVEN(JM) = CEVEN(JM) + SCOEF(IS+JM)*ALP(IS+JM) 
  170       CONTINUE 
C
         ENDIF
  180 CONTINUE                                                               
C                                                                               
C     NEXT ACCUMULATE ODD WAVENUMBER CONTRIBUTION                            
C                                                                               
      DO 215 JN=1,NNH,2 
         IS = LDIAG(JN,2)                                                    
C                                                                               
C        THIS DETOUR HELPS AVOID THE NEED TO SEPARATELY ZERO CODD            
C                                                                               
         IF (JN .EQ. 1) THEN
            DO 190 JM=1,LDIAG(1,1)                                           
                  CODD (JM) = SCOEF(IS+JM)*ALP(IS+JM)               
  190       CONTINUE                                                         
C                                                                               
C        ACCOUNT FOR THE FACT THAT THE FIRST ODD DIAGONAL MAY BE             
C        SHORTER THAN THE FIRST EVEN DIAGONAL (PART OF THE GAME              
C        TO AVOID EXPLICITLY ZEROING THE ENTIRE CODD ARRAY)                  
C                                                                               
            IF (LDIAG(1,1) .LT. LDIAG(0,1)) THEN                             
               DO 200 JM=LDIAG(1,1)+1, LDIAG(0,1)                            
                     CODD (JM) =  (0.0,0.0)                               
  200          CONTINUE                                                      
C                                                                               
            ENDIF                                                            
         ELSE
C                                                                               
            DO 210 JM=1,LDIAG(JN,1) 
               CODD (JM) = CODD (JM) + SCOEF(IS+JM)*ALP(IS+JM) 
  210       CONTINUE  
C
         ENDIF
  215 CONTINUE                                                               
C                                                                               
C     COMBINE CONTRIBUTIONS OF EVEN AND ODD WAVENUMBERS TO OBTAIN            
C     COMPLEX FOURIER COEFFICIENTS, FOLLOWED BY INVERSE FFT                  
C                                                                               
      DO 225 JM=1,LDIAG(0,1)                                              
         IF (RLAT .GE. 0.0) THEN
            X(JM) = CEVEN(JM) + CODD(JM) 
         ELSE
            X(JM) = CEVEN(JM) - CODD(JM)
         ENDIF
  225 CONTINUE                                                            
C                                                                               
C     INVERSE FOURIER TRANSFORMATION 
C                                                                               
      CALL DFT991(X,TRIGS,MAXH,LDIAG(0,1),PHI)
C
      RETURN                                                                 
C                                                                               
      END                                                                       
      SUBROUTINE DUV(NNH,DIVSC,ZETASC,LDIAG,TRIGS,ALP,DALP,ANNP1,
     $              CORSC1,CORSC2,RLAT,U,V)  
C                                                                               
C THIS SUBROUTINE OBTAINS CAPITAL U AND V MOMENTUM COMPONENTS FROM THE  
C VORTICITY AND DIVERGENCE SPECTRAL COEFFICIENTS
C IT IS A REDUCED VERSION OF ROUTINE UV FOR A SINGLE POINT
C                                                                              
C CALLED BY: EVAL
C CALLS: DFT991
C
C REVISIONS:
C 7-10-92 CHANGE TO CCM CODING CONVENTIONS (R. JAKOB)
C
C---- Model Parameters -------------------------------------------------
C
      INCLUDE 'params.i'
C
C------------ Arguments ------------------------------------------------
C
C     Input
C
C SPECTRAL TRUNCATION COEFFICIENT
      INTEGER NNH
C DIVERGENCE SPECTRAL COEFFICIENTS
      COMPLEX DIVSC(NALPH)
C VORTICITY SPECTRAL COEFFICIENTS
      COMPLEX ZETASC(NALPH)
C SPECTRAL ARRAY INDEX
      INTEGER LDIAG(0:MAXH,2)
C FOURIER COEFFICIENTS
      REAL TRIGS(MAXH+1,2)
C ASSOC. LEGENDRE POLYNOMIALS
      REAL ALP(NALPH)
C DERIV. ASSOC. LEGENDRE POLYNOMIALS
      REAL DALP(NALPH)
C LAPLACIAN SCALING FACTORS FOR U,V
      REAL ANNP1(MAXH)
C CORIOLIS COEFFICIENTS
      REAL CORSC1,CORSC2
C LATITUDE OF POINT
      REAL RLAT
C
C     Output
C
C COMPUTED EASTWARD WIND
      REAL U
C COMPUTED NORTHWARD WIND
      REAL V
C
C------ Local Variables ------------------------------------------------
C                                                                               
C                                                                               
      COMPLEX CMAT1(NALPH), CMAT2(NALPH), 
     $        CMAT3(NALPH), CMAT4(NALPH) 
      COMPLEX UTMP1(MAXH+1), UTMP2(MAXH+1),             
     $        VTMP1(MAXH+1), VTMP2(MAXH+1)              
      COMPLEX UCOSFC(MAXH+1),VCOSFC(MAXH+1)
C
C     TEMPORARIES
C
      INTEGER M,N,JM,JN,IS,INDEX
      REAL UCOS,VCOS,DIV
C
C----- Executable Statements -------------------------------------------
C                                                                               
C     COMPUTE U AND V MOMENTUM COMPONENTS FROM VORTICITY AND DIVERGENCE         
C                                                                               
C     COMPUTE INTERMEDIATE QUANTITIES FOR COMPUTATIONAL EFFICIENCY           
C                                                                               
      DO 230 JN=0,NNH 
         IS = LDIAG(JN,2)                                                    
C
         DO 220 JM=1,LDIAG(JN,1)                                             
            M = JM-1                                                         
            N = M + JN                                                       
C
C           TERMS N=0 UNDEFINED
C
            IF (N .GT. 0) THEN
               CMAT1(IS+JM)  = ANNP1(N)*REAL(M)*CMPLX(
     $                 -AIMAG(DIVSC(IS+JM)),REAL(DIVSC(IS+JM)))        
               CMAT2(IS+JM)  = ANNP1(N)*ZETASC(IS+JM)
               CMAT3(IS+JM)  = ANNP1(N)*REAL(M)*CMPLX( 
     $               -AIMAG(ZETASC(IS+JM)),REAL(ZETASC(IS+JM)))        
               CMAT4(IS+JM)  = ANNP1(N)*DIVSC(IS+JM)                         
            ENDIF
  220    CONTINUE                                                            
  230 CONTINUE                                                               
C
C     ADD CORIOLIS TERM FOR ROTATED COORDINATES
C
C     WAVE M=0, N=1
      INDEX = LDIAG(1,2)+1
      CMAT2(INDEX) = CMAT2(INDEX)-CMPLX(ANNP1(1)*CORSC1,0.0)
C     WAVE M=1, N=1
      INDEX = LDIAG(0,2)+2
      CMAT2(INDEX) = CMAT2(INDEX)-CMPLX(ANNP1(1)*CORSC2,0.0)
      CMAT3(INDEX) = CMAT3(INDEX)-CMPLX(0.0,ANNP1(1)*CORSC2)
C                                                                               
C     EVEN DIAGONALS FIRST                                                      
C                                                                               
      DO 280 JN=0,NNH,2 
         IS = LDIAG(JN,2)                                                       
C                                                                               
C     THIS DETOUR ELIMINATES NEED TO EXPLICITLY ZERO UTMP1, UTMP2, ETC.         
C                                                                               
         IF (JN .EQ. 0) THEN                                                   
C
C           SPECIAL HANDLING FOR N=M=0
C
            UTMP1(1) = CMPLX(0.0,0.0)
            UTMP2(1) = CMPLX(0.0,0.0)
            VTMP1(1) = CMPLX(0.0,0.0)
            VTMP2(1) = CMPLX(0.0,0.0)
            DO 250 JM=2,LDIAG(0,1)                                           
               UTMP1(JM) = - CMAT1(JM)*ALP(JM)                
               UTMP2(JM) =   CMAT2(JM)*DALP(JM)               
               VTMP1(JM) = - CMAT3(JM)*ALP(JM)                
               VTMP2(JM) = - CMAT4(JM)*DALP(JM)               
  250       CONTINUE                                                         
         ELSE
C                                                                               
C           ALL OTHER EVEN DIAGONALS
C
            DO 270 JM=1,LDIAG(JN,1)  
               UTMP1(JM) = UTMP1(JM) - CMAT1(IS+JM)*ALP(IS+JM)         
               UTMP2(JM) = UTMP2(JM) + CMAT2(IS+JM)*DALP(IS+JM)        
               VTMP1(JM) = VTMP1(JM) - CMAT3(IS+JM)*ALP(IS+JM)         
               VTMP2(JM) = VTMP2(JM) - CMAT4(IS+JM)*DALP(IS+JM)        
  270       CONTINUE 
         ENDIF
  280 CONTINUE                                                                  
C                                                                               
C     ODD DIAGONALS NEXT                                                        
C                                                                               
      DO 310 JN=1,NNH,2 
         IS = LDIAG(JN,2)                                                       
         DO 300 JM=1,LDIAG(JN,1)                                                
            UTMP2(JM) = UTMP2(JM) - CMAT1(IS+JM)*ALP(IS+JM)         
            UTMP1(JM) = UTMP1(JM) + CMAT2(IS+JM)*DALP(IS+JM)        
            VTMP2(JM) = VTMP2(JM) - CMAT3(IS+JM)*ALP(IS+JM)         
            VTMP1(JM) = VTMP1(JM) - CMAT4(IS+JM)*DALP(IS+JM)        
  300    CONTINUE                                                               
  310 CONTINUE                                                                  
C                                                                               
C     COMBINE CONTRIBUTIONS OF EVEN AND ODD WAVENUMBERS TO OBTAIN            
C     FOURIER COEFFICIENTS                                                   
C                                                                               
      DO 330 JM=1,LDIAG(0,1)                                                 
         IF (RLAT .GE. 0.0) THEN
            UCOSFC(JM) = UTMP1(JM) + UTMP2(JM)               
            VCOSFC(JM) = VTMP1(JM) + VTMP2(JM)
         ELSE
            UCOSFC(JM) = UTMP1(JM) - UTMP2(JM)               
            VCOSFC(JM) = VTMP1(JM) - VTMP2(JM)
         ENDIF
  330 CONTINUE                                                               
C                                                                               
C     CALL DFT ROUTINE FOR INVERSE TRANSFORM OF UCOS AND VCOS                   
C                                                                               
      CALL DFT991(UCOSFC,TRIGS,MAXH,LDIAG(0,1),UCOS)
      CALL DFT991(VCOSFC,TRIGS,MAXH,LDIAG(0,1),VCOS)
C
C     RENORMALIZE WIND FIELD
C
      DIV = COS(RLAT)
      U = UCOS/DIV
      V = VCOS/DIV
C                                                                               
      RETURN                                                                    
C                                                                               
      END                                                                       
      SUBROUTINE DFT991(X,TRIGS,MAXH,NFC,SUM)
C
C INVERSE DISCRETE FOURIER TRANSFORM 
C
C CALLED BY: DTRNS, DUV
C CALLS:
C
C REVISIONS:
C 7-10-92 CHANGE TO CCM CODING CONVENTIONS (R. JAKOB)
C
C------------ Arguments ------------------------------------------------
C
C     Input
C
C COMPLEX FOURIER COEFFICIENTS
      COMPLEX X(MAXH+1)
C SINE AND COSINE COEFFICIENTS
      REAL TRIGS(MAXH+1,2)
C DIMENSION OF TRIGS
      INTEGER MAXH
C NUMBER OF VALID COEFFICIENTS
      INTEGER NFC
C
C     Output
C
      REAL SUM
C
C------ Local Variables ------------------------------------------------
C
      INTEGER I
C
C----- Executable Statements -------------------------------------------
C
      SUM = REAL(X(1))
      DO 100 I = 2, NFC
         SUM = SUM + 2.0*(REAL(X(I))*TRIGS(I,2) -
     $                    AIMAG(X(I))*TRIGS(I,1))
  100 CONTINUE
C
      RETURN
C
      END
