!-----------------------------------------------------------------------

	MODULE netcdf_general_tools
	
!-----------------------------------------------------------------------
!  Purpose: 
!   contains parameters and procedures used by both qp and pbp 
!   procedures:
!   	module parameters: 
!	   maximum length of character variables,
!	   constant character names, 
!	   missing value
!	   return code and counter
!  	module procedures:
!	   get_units - extracts a units substring 
!	   set_time - converts time to NetCDF time, writes to file
!	   set_frac - writes frac values
!	   error_handler - deals with netcdf errors
!	   current_time - returns the current time and date as a string
!	netcdf parameters and functions - contained via use netcdf
!
!  Scope:
!	all parameters and procedures are public
!
!-----------------------------------------------------------------------

   use kinds
   use netcdf_util

   implicit none
   private
	
!   module parameters (character variable limits) also public
   integer(kind=int_kind), parameter, public ::                          &
      MAXFILE=128,   &
      MAXUNITS=40,   &
      MAXLONGN=80,   &
      MAXNAME=16,    &
      STRLEN = 10

!   missing value 
   real (kind=real_kind), parameter, public :: MISSING=1e36


!   derived type to hold metadata info:
!   ni, nj are only meaningful on rectangular (lat/lon) grid structures
   type meta_type  
      character(len=MAXFILE) :: filename
      character(len=4) :: datatype
      integer (kind=int_kind) :: ni
      integer (kind=int_kind) :: nj
      integer (kind=int_kind) :: npoints
      integer (kind=int_kind) :: timerec
      integer (kind=int_kind) :: nlevels
      character(len=MAXFILE) :: level_title
      character(len=MAXFILE) :: level_units
   end type meta_type

   public :: meta_type

! public member functions
   public ::          &
      set_meta,       &
      next_time_step, &
      get_time_step,  &
      file_name,      &
      get_units,      &
      define_time,    &
      set_time,       &
      current_time,   &
      add_global_atts


CONTAINS

!-----------------------------------------------------------------------
!
FUNCTION set_meta (fname, dtype, ncells, i, j,                       &
                   nlevels, level_title, level_units )         &
                         result(set_meta_result)
!	
!  pack information into the metadata variable
!-----------------------------------------------------------------------

   type(meta_type) :: set_meta_result
   character(len=*), intent(in) :: fname               ! netcdf file name
   character(len=4), intent(in) :: dtype               !
   integer (kind=int_kind), intent(in) :: ncells       ! number of grid cells
                                                       !  in horizontal
   integer (kind=int_kind), intent(in) :: i, j         ! zonal and meridional
                                                       !  dimensions of latlon
                                                       !  grid
   integer (kind=int_kind), intent(in), optional :: nlevels  ! number of levels
                                                             !  of 3D variable
   character(len=*), intent(in), optional :: level_title  ! vertical
                                                          ! coordinate title
   character(len=*), intent(in), optional :: level_units  ! vertical
                                                          ! coordinate units

   set_meta_result%filename = fname
   set_meta_result%datatype = dtype
   set_meta_result%npoints = ncells
   set_meta_result%ni = i
   set_meta_result%nj = j
   set_meta_result%timerec = 0

   if (present(nlevels)) then
      set_meta_result%nlevels = nlevels
      set_meta_result%level_title = level_title
      set_meta_result%level_units = level_units
   else
      set_meta_result%nlevels = 0
      set_meta_result%level_title = ' '
      set_meta_result%level_units = ' '
   end if

END FUNCTION set_meta



!-----------------------------------------------------------------------

 SUBROUTINE next_time_step (geo_meta)

! increment the time record number in the metadata variable

!-----------------------------------------------------------------------

   type(meta_type), intent(inout) :: geo_meta

   geo_meta%timerec = geo_meta%timerec + 1

END SUBROUTINE next_time_step



!-----------------------------------------------------------------------

FUNCTION get_time_step(geo_meta) result(get_time_step_result)

! Extract the time record number from the metadata

!-----------------------------------------------------------------------

   integer (kind=int_kind) :: get_time_step_result
   type(meta_type), intent(in) :: geo_meta

   get_time_step_result = geo_meta%timerec

END FUNCTION get_time_step



!-----------------------------------------------------------------------

FUNCTION file_name(geo_meta) result(file_name_result)

!-----------------------------------------------------------------------

   character(len=MAXFILE) :: file_name_result
   type(meta_type), intent(in) :: geo_meta

   file_name_result = geo_meta%filename

END FUNCTION file_name



!-----------------------------------------------------------------------

SUBROUTINE get_units(description, units, long_len, unit_len)
	
!-----------------------------------------------------------------------
!  Purpose:
!	extracts a string enclosed within parentheses - used for 
!	units which are contained in a general description string.
!	returns the units string (units) and its length (unit_len),
!	the description string with the units removed (longname),
!	and its length (long_len).
!	note: embedded parentheses are ok
!
!  Variables:
!   Module parameters used:
!	MAXUNITS, MAXLONGN
!	
!  Bugs:
!	1) if the rightmost parenthesis is unmatched, units will be 
!	   set to " " (one space) - this is to be interpreted as "none"
!	2) if a "(" is unmatched, it will be part of the returned
!	   longname string
!       3) strings of only units (i.e. entire string enclosed in 
!	   parentheses) do not work.
!-----------------------------------------------------------------------
	
   character(len=*), intent(in) :: description
   character(len=*), intent(in) :: units
   integer (kind=int_kind), intent(out) :: unit_len, long_len
	
   long_len = len_trim(description)
   unit_len = len_trim(units)

END SUBROUTINE get_units



!-----------------------------------------------------------------------

SUBROUTINE define_time (fileID, timeID, doperiod)

!-----------------------------------------------------------------------
! Purpose:
!   defines (unlimited) time dimension and various time related variables
!   and returns the netcdf id of the time dimension
!   dimension defined:
!       time
!       char_len
!   variables defined:
!       time
!       char_time
!       start_period
!       end_period
!       period_length
!
! Scope: 
!   Module variables used:
!      netcdf routines and constants
!
! FIXME - pbps do not need period_start, period_length, etc.
!-----------------------------------------------------------------------

! argument list variables
   integer (kind=int_kind), intent(in) :: fileID
   integer (kind=int_kind), intent(out) :: timeID
   logical (kind=log_kind), intent(in) :: doperiod

! local variables
   integer (kind=int_kind) :: tmpid, chardimID
   integer (kind=int_kind), dimension(1) :: tmparr
   integer (kind=int_kind), dimension(2) :: char_dims

   integer (kind=int_kind) :: status       ! netcdf return error code

! define time dimension
   status = nf_def_dim (fileID, "time", NF_UNLIMITED, timeID)
   status = nf_def_dim (fileID, "char_len", STRLEN, chardimID)

   tmparr = (/timeID/)
   char_dims = (/chardimID, timeID/)
	   
! define time variable and its attributes
   status = nf_def_var (fileID, "time", NF_DOUBLE, 1, tmparr, tmpid)
   status = nf_put_att_text (fileID, tmpid, "quantity", 4, "time")
   status = nf_put_att_text (fileID, tmpid, "units", 16,                  &
   	                     "days since 1-1-1")
   status = nf_put_att_text (fileID, tmpid, "calendar", 6, "noleap")
	
   status = nf_def_var (fileID, "char_time", NF_CHAR, 2,                  &
    		        char_dims, tmpid)
  status = nf_put_att_text (fileID, tmpid, "format", 10,                  &
 		            "mm/dd/yyyy")

! define variables describing the averaging period, if any
   if (doperiod) then
      status = nf_def_var (fileID, "start_period", NF_DOUBLE, 1, tmparr, tmpid)
      status = nf_put_att_text (fileID, tmpid, "long_name", 24,               &
                                "start of averaged period")
      status = nf_put_att_text (fileID, tmpid, "units", 16, "days since 1-1-1")

      status = nf_def_var (fileID, "end_period", NF_DOUBLE, 1, tmparr, tmpid)
      status = nf_put_att_text (fileID, tmpid, "long_name", 22,               &
                                "end of averaged period")
      status = nf_put_att_text (fileID, tmpid, "units", 16, "days since 1-1-1")
	
      status = nf_def_var (fileID, "period_length", NF_DOUBLE, 1, tmparr, tmpid)
      status = nf_put_att_text (fileID, tmpid, "long_name", 25,               &
                                "length of averaged period")
      status = nf_put_att_text (fileID, tmpid, "units", 4, "days")
   end if


END SUBROUTINE define_time




!-----------------------------------------------------------------------

SUBROUTINE set_time(qpfid, nsecond, timerec, nsec_start)
	
!-----------------------------------------------------------------------
!  Purpose: 
!	sets the time in a netcdf file as a string and an 8 byte float
!
!  Variables:
!   Module parameters used:
!	STRLEN
!
!  Assumptions:
!	1) qpfid is the id number of a netcdf file that is open in data mode
!	2) the netcdf file has time variables named "time" and "char_time"
!-----------------------------------------------------------------------
	
! argument list
   integer (kind=int_dbl_kind), intent(in) :: nsecond
   integer (kind=int_kind), intent(in) :: qpfid, timerec
   integer (kind=int_dbl_kind), intent(in), optional :: nsec_start
	
! local variables
   integer (kind=int_dbl_kind) :: nseconds_coord
   real (kind=dbl_kind) :: nctime
   character(len=STRLEN) :: character_time	
   integer (kind=int_kind) :: cstart(2), ccount(2), timevid, chartimevid
   integer (kind=int_kind) :: rcode

   cstart = (/1, timerec/)   
   ccount = (/STRLEN, 1/)

   nseconds_coord = nsecond

!   if necessary, store time start and time end, calculate average
   if (present(nsec_start)) then
      rcode = nf_inq_varid (qpfid, "start_period", timevid)
      call convert_time(nsec_start)
      rcode = nf_put_var1_double (qpfid, timevid, timerec, nctime)

      rcode = nf_inq_varid (qpfid, "end_period", timevid)
      call convert_time(nsecond)
      rcode = nf_put_var1_double (qpfid, timevid, timerec, nctime)
	
      rcode = nf_inq_varid (qpfid, "period_length", timevid)
      call convert_time(nsecond-nsec_start)
      rcode = nf_put_var1_double (qpfid, timevid, timerec, nctime)
	
      nseconds_coord = (nsec_start + nsecond)/2
   endif

!   translate time into standard netcdf time and character string date
   call convert_time(nseconds_coord) 
	
!   get time variable id's
   rcode = nf_inq_varid (qpfid, "time", timevid)
   rcode = nf_inq_varid (qpfid, "char_time", chartimevid)
	
!   store converted time in appropriate variables
   rcode = nf_put_var1_double (qpfid, timevid, timerec, nctime)
   rcode = nf_put_vara_text (qpfid, chartimevid, cstart, ccount, character_time)



CONTAINS	

!---------------------------------------------------------------

SUBROUTINE convert_time(secs)   !!! contained in set_time !!!
	
!---------------------------------------------------------------
! Purpose:
!     This subroutine converts the time stored in nsecond to standard
!   netcdf time and to a character date string of the format "mm/dd/yyyy"
!
! Scope:
!    Variables from containing subroutine scope:
!	nctime, 
!       character_time, 
!       amip
!
! Assumptions:  
!	1) nsecond is a four-byte integer number of seconds
!	2) no leap years
!----------------------------------------------------------------

! argument list
   integer (kind=int_dbl_kind), intent(in) :: secs

 
! local variables
   integer (kind=int_kind) :: day, year
   integer (kind=int_dbl_kind) :: seconds_rem
   character (len=2) :: month, cday
   character (len=4) :: cyear
   character (len=6) :: line   ! internal file 

!  nctime section 
   nctime = dble(secs)/86400.0_int_dbl_kind


!  character time section	
   seconds_rem = secs

!  calculate years
   year = seconds_rem/(365_int_dbl_kind*86400_int_dbl_kind)
	
   seconds_rem = mod(seconds_rem, 365_int_dbl_kind*86400_int_dbl_kind)   ! seconds remaining 
   day = seconds_rem/86400_int_dbl_kind + 1
	
   if (day<=31) then
      month = "01"
   elseif (day<=59) then  ! no leap years (feb. always 28 days)
      month = "02"
      day = day - 31
   elseif (day<=90) then
      month = "03"
      day = day - 59
   elseif (day<=120) then
      month = "04"
      day = day - 90
   elseif (day<=151) then
      month = "05"
      day = day - 120
   elseif (day<=181) then
      month = "06"
      day = day - 151
   elseif (day<=212) then
      month = "07"
      day = day - 181
   elseif (day<=243) then
      month = "08"
      day = day - 212
   elseif (day<=273) then
      month = "09"
      day = day - 243
   elseif (day<=304) then
      month = "10"
      day = day - 273
   elseif (day<=335) then
      month = "11"
      day = day - 304
   else
      month = "12"
      day = day - 334
   endif
	
!  internal file used to convert integer data to character string
   write (unit=line, fmt='(I2.2, I4.4)') day, year
   read (unit=line, fmt='(A2, A4)') cday, cyear
    	
   character_time = month//"/"//cday//"/"//cyear
     	

END SUBROUTINE convert_time
	
END SUBROUTINE set_time   !!! back to module scope !!!



!-----------------------------------------------------------------------

FUNCTION current_time ( ) result(current_time_result)
	
!-----------------------------------------------------------------------
!   Purpose:
!	returns a 30 character string containing the current time and date
!	in the form "mm/dd/yyyy at hh:mm zzzzz GMT"
!
!   Bugs:
!	1) date_and_time intrinsic f90 routine is not supported on
!	   all f90 compilers
!-----------------------------------------------------------------------

   character(len=30) :: current_time_result

! local variables	
   character(len=8) :: date
   character(len=10) :: time
   character(len=5) :: zone
   integer (kind=int_kind), dimension(8) :: values

   call date_and_time(date, time, zone, values)

   current_time_result = date(5:6) // "/" // date(7:8) // "/" // date(1:4)   &
        //" at "// time(1:2) // ":" // time(3:4) // " "	// zone // " GMT "

END FUNCTION current_time



!-----------------------------------------------------------------------
	
SUBROUTINE add_global_atts (fileID, runname, grid, version, max_ig)
	
!-----------------------------------------------------------------------
! Purpose:
!   sets global attributes of netcdf file
!
! Scope: 
!   Module variables used:
!
! Bugs:
!   netcdf file (fileID) must be in define mode.
!
!FIXME - geodesic specific stuff needs to go...
!-----------------------------------------------------------------------

! argument list
   integer (kind=int_kind), intent(in) :: fileID            ! netcdf file id
   integer (kind=int_kind), intent(in), optional :: max_ig  ! number of grid cells
   character(len=*), intent(in) :: runname                  ! run name
   character(len=*), intent(in) :: grid                     ! grid-type description
   character(len=*), intent(in) :: version                  ! model version tag

! local variables
   integer (kind=int_kind) :: status                   ! netcdf return status

!   add standard global attributes
   status = nf_put_att_text (fileID, NF_GLOBAL, "calendar", 6, "noleap")
   call handle_error (status, "calendar")

   status = nf_put_att_text (fileID, NF_GLOBAL, "institution", 25,           &
     	      "Colorado State University")
   call handle_error (status, "institution")

   status = nf_put_att_text (fileID, NF_GLOBAL, "history", 39,               &
              "Created: "//current_time())
   call handle_error (status, "history")

   status = nf_put_att_text(fileID, NF_GLOBAL, "run", len(runname), runname)
   call handle_error (status, "run")

   status = nf_put_att_text (fileID, NF_GLOBAL, "grid", len(grid), grid)
   call handle_error (status, "grid")

   status = nf_put_att_text(fileID, NF_GLOBAL, "version", len(version), version)
   call handle_error (status, "version")

   status = nf_put_att_text(fileID, NF_GLOBAL, "extravaratts", 3, "yes")
   call handle_error (status, "extravaratts")

   if(present(max_ig))then
      status = nf_put_att_int(fileID, NF_GLOBAL, "total_grid_size",          &
                              nf_int, 1, max_ig)
      call handle_error (status, "total_grid_size")
   endif

#ifdef scm
   status = nf_put_att_text (fileID, NF_GLOBAL, "scm", 3, "SCM")
   call handle_error (status, "scm")
#endif


END SUBROUTINE add_global_atts



END MODULE netcdf_general_tools	

