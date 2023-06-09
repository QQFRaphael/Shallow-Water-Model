!-----------------------------------------------------------------------

MODULE netcdf_pbp

!-----------------------------------------------------------------------
!  Purpose:
!	This is a collection of subroutines that initialize and write
!   BUGS pbp data in netcdf form.
!
! History:
!    Note: These version numbers are intended to reflect changes to the
!          actual output, not logic or input changes.  When output is
!          changed, also increment module parameter "VERSION" below.
!
!    version 0.1: 
!       10/29/04: copied from ncpbpwrt.F from bugs5.  will put into f90 format 
!                 and consolidate some routines.  - mark
!                 
!  Bugs:
!    - filenames must be shorter than (MAXFILE) characters
!    - assigned units attribute cannot be longer than MAXUNITS characters
!    - assigned longname attribute cannot be longer than MAXLONGN characters
!  * see module netcdf_pbp_tools
!	
!-----------------------------------------------------------------------
   use kinds
   use types
   use netcdf_util
   use netcdf_general_tools

   implicit none
   private

   character(len=14), parameter :: GRIDTYPE = "point-by-point"
   character(len=3), parameter :: VERSION = "0.1"

   public :: meta_type   ! from netcdf_general_tools

   integer :: status, n

! public member functions
   public :: pinit_nc, pwrt_nc


   CONTAINS


!-----------------------------------------------------------------------

SUBROUTINE pinit_nc(runname, outfile, pmeta,                              & 
                        listpbp, namepbp, unitpbp, typepbp, dopbp,        &
                        max_ig, lons, lats,                               &
                        nlm, ptop,                                        &
                        nlev_scm, plev_scminit)
	
!-----------------------------------------------------------------------
!  Purpose:
!    create netcdf files (separate files for pbp1 and pbp2)
!    set module variables used by write_atm_nc (filenames, dimensions, maximums)
!    initialize netcdf files and set special attributes and coordinate values
!    close files 
!
!  Scope:
!    Parameters:
!	runname - char - arbitrary name for model run
!	outfile - char - name of output files
!	listpbp - string - description for each variable
!		units can be included in parentheses.
!	namepbp - string - unique variable names
!	unitpbp - string - unique variable names
!	dopbp - logical - true for variables used
!	ijtlen - int - number of points used
!	nlm - int - number of levels
! 	ptop - REALX8 - pressure at model top
!       lons - REALX4 - longitude of each point
!       lats - REALX4 - latitude of each point
!    Modules used:
!	netcdf_general_tools :
!	   Variables used:
!	      patm2, patm3 - data structures for pbp file information
!          Subroutines used:
!	      nc_init_pbp - initializes netcdf files
!             init_pbp_coord - sets coordinate variable values
!          Functions used:
!             set_pbp - sets values of pbp data structures
!            *nf_create
!            *nf_enddef
!            *nf_close
!		
!  * - indirectly inherited (from netcdf_general_tools)
!
!  Bugs:
!	1) overwrites any data contained in outfile
!	2) limits the length of the "units" attribute to (MAXUNITS) characters
!	3) limits the length of the "long_name" attribute to (MAXLONGN) characters
!   Also see called procedures
!
!-----------------------------------------------------------------------

! argument list
   character(len=*), intent(in) :: runname
   character(len=*), intent(in) :: outfile
   type (meta_type), intent(out) :: pmeta     ! component dependent meta data
   character(len=*), dimension(:), intent(in) :: namepbp 
   character(len=*), dimension(:), intent(in) :: listpbp 
   character(len=*), dimension(:), intent(in) :: unitpbp 
   character(len=*), dimension(:), intent(in) :: typepbp 
   logical (kind=log_kind), dimension(:), intent(in) :: dopbp 
   integer (kind=int_kind), intent(in) :: max_ig
   real (kind=real_kind), dimension(:), intent(in) :: lons, lats

! 3d file optional arguments
   integer (kind=int_kind), intent(in), optional :: nlm
   real (kind=dbl_kind), intent(in), optional :: ptop

! scm optional arguments
   integer (kind=int_kind), intent(in), optional :: nlev_scm
   real (kind=dbl_kind), dimension(:), intent(in), optional :: plev_scminit

! values at each level
   real (kind=real_kind), dimension(:), allocatable :: levelvals, levelvals_scm

   integer (kind=int_kind) :: ncfid
   integer (kind=int_kind) :: ijtlen, pbpvid, pbpvid2
   integer (kind=int_kind) :: n

   ijtlen = size(lons)
			
   if (present(nlm)) then
      allocate(levelvals(nlm))
      do n = 1, nlm
         levelvals(n) = float(n)
      enddo
      pmeta = set_meta (outfile, "patm", ijtlen, 0, 0,                     &
                        nlm, 'Model level', '-' )
   else
      pmeta = set_meta (outfile, "patm", ijtlen, 0, 0)
   endif

! create netcdf files	
   status = nf_create (outfile, NF_CLOBBER, ncfid)

! initialize files
   if (present(nlev_scm)) then
      call nc_init_pbp(ncfid, runname, pmeta, listpbp,                     &
                       namepbp, unitpbp, typepbp, dopbp,                   &
                       nlev_scm=nlev_scm)
   else
      call nc_init_pbp(ncfid, runname, pmeta, listpbp,                     &
                       namepbp, unitpbp, typepbp, dopbp)
   endif
     
! set special attributes
   if (present(nlm)) then

      status = nf_def_var (ncfid, "ptop", NF_FLOAT, 0, 0, pbpvid)
      status = nf_put_att_text (ncfid, pbpvid, "long_name", 18,            &
                                "model top pressure")
      status = nf_put_att_text (ncfid, pbpvid, "title", 18,                &
                                "model top pressure")
      status = nf_put_att_text (ncfid, pbpvid, "units", 3, "hPa")
   endif
!-- commenting out max_ig var def for now -- it is never filled 
!   status = nf_def_var (fid2, "max_ig", NF_INT, 0, 0, pbpvid2)
!   status = nf_put_att_text (ncfid, pbpvid2, "long_name", 20,              &
!                             "number of grid cells")
	     
! end define mode (variables and dimensions all defined)
   status = nf_enddef (ncfid)

! set coordinates
   if (present(nlm)) then
      if (present(nlev_scm)) then
         allocate(levelvals_scm(nlev_scm))
         do n = 1, nlev_scm
            levelvals_scm(n) = float(n)
         enddo
         call init_pbp_coord (ncfid, pmeta, lons, lats, max_ig,             &
                              levelvals, ptop,                              &
                              nlev_scm, levelvals_scm, plev_scminit)
         deallocate(levelvals_scm)
      else
         call init_pbp_coord (ncfid, pmeta, lons, lats, max_ig,             &
                              levelvals, ptop)
      endif
      deallocate(levelvals)
   else
      call init_pbp_coord (ncfid, pmeta, lons, lats, max_ig)
   endif
	
! close files
   status = nf_close (ncfid)

END SUBROUTINE pinit_nc   !!! back to module scope !!!


!-----------------------------------------------------------------------

SUBROUTINE pwrt_nc (nsecond, pmeta,                                       &
                    namepbp, dopbp, indxpbp,                              &
                    pbp1, pbp2)

!-----------------------------------------------------------------------
!  Purpose:
!	opens netcdf files pbp1file and pbp2file (set when pinit_atm 
!   was called,)
!   writes a full time record of data for both pbp2 and pbp1 variables, 
!   then closes both files
!
!  Scope:
!   Parameters:
!       nsecond -int- time of writing (in seconds)
!	namepbp(npbp1mx) -string- unique 2-d variable names
!	dopbp(npbp1mx) -logical- true if variable is "active"
!	pbp1(npbp1,nijlen) -REALX4- data values for all 2-d variables
!	pbp2(nlm,npbp2,nijlen) -REALX4- data values for 3-d variables
!   Modules used:
!	netcdf_pbp_tools:
!	   Variables used:
!	      patm2, patm3 - data structures for general file information
!	   Subroutines called:
!	      write_pbp_2d - writes 2 dimensional data to netcdf file
!	      write_pbp_3d - writes 3 dimensional data to netcdf file
!	     *set_time - converts the time to netcdf time (double precision
!			 number of days since 1-1-1)
!	   Functions called:
!	     *nf_open
!	     *nf_close
!
!  * - indirectly inherited (from netcdf_general_tools)
!
!  Bugs:
!-----------------------------------------------------------------------

   integer (kind=int_dbl_kind), intent(in) :: nsecond
   character(len=*), dimension(:), intent(in) :: namepbp
   logical (kind=log_kind), dimension(:), intent(in) :: dopbp
   integer (kind=int_kind), dimension(:), intent(in) :: indxpbp
   real (kind=real_kind), dimension(:,:), intent(inout), optional :: pbp1
   real (kind=real_kind), dimension(:,:,:), intent(inout), optional :: pbp2
   type (meta_type), intent(inout) :: pmeta

   integer (kind=int_kind) :: ncfid

   call next_time_step(pmeta)
   status = nf_open (file_name(pmeta), NF_WRITE, ncfid)
   call set_time(ncfid, nsecond, get_time_step(pmeta))
   if (pmeta%nlevels == 0) then
      call write_pbp_2d(ncfid, pmeta, pbp1, namepbp, dopbp, indxpbp)
   else 
      call write_pbp_3d(ncfid, pmeta, pbp2, namepbp, dopbp, indxpbp)	
   endif
   status = nf_close (ncfid)
		
END SUBROUTINE pwrt_nc


!-----------------------------------------------------------------------

SUBROUTINE nc_init_pbp(pbpfid, run_name, pbpinfo, listpbp,                &
                       namepbp, unitpbp, typepbp, dopbp,                  &
                       nlev_scm, sfctype, surface_type )
    
!-----------------------------------------------------------------------
!  Purpose:
!       create and initialize netcdf files
!          defines the "latitude", "longitude", "time", and "char_time"
!        dimensions in the pbp file.  Defines the coordinate variables
!        "longitude", "latitude", and "time", as well as all pbp variables.
!        Adds standard COARDS attributes to coordinate variables.
!
!  Scope:
!    Parameters:
!       pbpfid -int- id number attached to open netcdf file in define mode
!       run_name -string- arbitrary name of model run
!       pbpinfo -meta_type- data structure with file information
!       listpbp(:) -string- array of variable descriptions 
!       namepbp(:) -string- array of unique variable names
!       listpbp(:) -string- array of variable units 
!       dopbp(:) -logical- true for variables with data to be written
!       sfctype(:) - variable attribute denoting which surface a variable exists on
!       surface_type - variable denoting which surface a grid point is
!    Module parameters used:
!         * STRLEN, MAXUNITS, MAXLONGN, npoints, latitude, longitude,
!         * time, char_time
!    Module variables used:
!    Module subroutines called:
!         * get_units(list, longname, units) - removes the units from
!                     string list, returns longname(len=MAXLONGN)
!                     (string without units), units(len=MAXUNITS)
!    Module functions called:
!         * various netcdf functions
!
!  * - indirectly inherited (from netcdf_general_tools)
!
!  Assumptions:
!       1) pbpfid is connected to an open netcdf file
!          in define mode
!       2) namepbp is an array of unique variable names
!          consisting only of letters, numbers and underscore (technically,
!          only the variables actually used need unique names.)
!       2) listpbp is an array of variable descriptions
!          with units optionally included in parentheses.
!-----------------------------------------------------------------------
! argument declarations
   integer (kind=int_kind), intent(in) :: pbpfid
   character(len=*), intent(in) :: run_name
   type(meta_type), intent(in) :: pbpinfo
   character(len=*), dimension(:), intent(in) :: listpbp
   character(len=*), dimension(:), intent(in) :: unitpbp
   character(len=*), dimension(:), intent(in) :: typepbp
   character(len=*), dimension(:), intent(in) :: namepbp
   character(len=*), dimension(:), intent(in), optional :: sfctype
   character(len=*), dimension(:), intent(in), optional :: surface_type
   logical (kind=log_kind), dimension(:), intent(in) :: dopbp
   integer (kind=int_kind), intent(in), optional :: nlev_scm

! variables to hold longname and units
   integer (kind=int_kind) :: u_len, l_len, t_len=3

! pbp1 dimension id numbers
   integer (kind=int_kind) :: npntsdim, timedim, leveldim, numdim,        &
                              level_scmdim, chardimid

!-----------------------------------------------------------------------
! arrays to hold dimension ids
   integer, allocatable, dimension(:) :: pbpdims

! general variable id - used to define variables
   integer :: pbpvid

! temporary array to hold a single integer - used for type consistency
   integer, dimension(1) :: tempdim
   integer, dimension(2) :: tempdim2

! standard global attributes
   call add_global_atts (pbpfid, run_name, GRIDTYPE, VERSION)
   call define_time (pbpfid, timedim, .false.)

! define dimensions
   status = nf_def_dim (pbpfid,"npoints", pbpinfo%npoints, npntsdim)

   tempdim = (/npntsdim/)
   status = nf_def_var (pbpfid,"npoints",NF_INT,1,tempdim,pbpvid)

   status = nf_def_var (pbpfid, "max_ig", NF_INT, 0, 0, pbpvid)

   status = nf_def_var (pbpfid,"latitude",NF_FLOAT,1,tempdim,pbpvid)
   status = nf_put_att_text (pbpfid, pbpvid, "units", 13, "degrees_north")
   status = nf_put_att_text (pbpfid, pbpvid, "quantity", 8, "latitude")

   status = nf_def_var(pbpfid,"longitude",NF_FLOAT,1,tempdim,pbpvid)
   status = nf_put_att_text (pbpfid, pbpvid, "units", 12, "degrees_east")
   status = nf_put_att_text (pbpfid, pbpvid, "quantity", 9, "longitude")

   if (present(surface_type)) then
      status = nf_inq_dimid(pbpfid, "char_len", chardimID) 
      tempdim2 = (/chardimID, npntsdim/)
      status = nf_def_var(pbpfid,"surface_type",NF_CHAR,2,tempdim2,pbpvid)
      status = nf_put_att_text (pbpfid, pbpvid, "quantity", 12,"surface type")
   endif

! add level dimension and coordinate variables if data is 3-d
   if (pbpinfo%nlevels < 1) then
      numdim = 2
      allocate (pbpdims(numdim))
      pbpdims = (/npntsdim, timedim/)
   else
      if (present(nlev_scm)) then
         status = nf_def_dim (pbpfid,"level",pbpinfo%nlevels, leveldim)
         tempdim = (/leveldim/)
         status = nf_def_var (pbpfid,"level",NF_FLOAT,1,tempdim,pbpvid)
         status = nf_def_dim (pbpfid,"level_scm",nlev_scm,level_scmdim)
         tempdim = (/level_scmdim/)
         status = nf_def_var (pbpfid,"level_scm",NF_FLOAT,1,tempdim,pbpvid)

         status = nf_def_var(pbpfid,"p_scm",NF_FLOAT,1,tempdim,pbpvid)
         status = nf_put_att_text (pbpfid, pbpvid, "units", 2, "Pa")
         status = nf_put_att_text (pbpfid, pbpvid, "quantity", 18,        &
                                   "Scm pressure level")

      else
         status = nf_def_dim (pbpfid,"level",pbpinfo%nlevels, leveldim)
         tempdim = (/leveldim/)
         status = nf_def_var (pbpfid,"level",NF_FLOAT,1,tempdim,pbpvid)
      endif
      numdim = 3
      allocate (pbpdims(numdim))
      pbpdims = (/npntsdim, leveldim, timedim/)
   endif

! loop to define pbp1 variables and add attributes
   do n = 1, size(dopbp)
      if (dopbp(n)) then
!       print *, n, "Define: ", namepbp(n)
	                                                                  
         status = nf_def_var (pbpfid, namepbp(n), NF_FLOAT, numdim,       &
                              pbpdims, pbpvid)
         call get_units(listpbp(n), unitpbp(n), l_len, u_len)
         status = nf_put_att_text (pbpfid, pbpvid, 'long_name',           &
                                   l_len, listpbp(n))
         status = nf_put_att_text (pbpfid, pbpvid, 'title',               &
                                   l_len, listpbp(n))
         status = nf_put_att_text (pbpfid, pbpvid, 'units',               &
                                   u_len, unitpbp(n))
         status = nf_put_att_text (pbpfid, pbpvid, 'type',                &
                                   t_len, typepbp(n))
         status = nf_put_att_real (pbpfid, pbpvid, 'missing_value',       &
                                   NF_FLOAT, 1, MISSING)
         if (present(sfctype))                                            &
            status = nf_put_att_text (pbpfid, pbpvid, 'sfc_type',         &
                                      3, sfctype(n) )
      endif
   enddo

   deallocate (pbpdims)

   END SUBROUTINE nc_init_pbp


!-----------------------------------------------------------------------

SUBROUTINE init_pbp_coord (pbpfid, pbpinfo, lons, lats, max_ig,           &
                           levelvals, ptop,                               &
                           nlev_scm, levelvals_scm, plev_scminit,         &
                           surface_type)
	
!-----------------------------------------------------------------------
!  Purpose:
!   sets values of coordinate variables
! 
!  Variables:
!   Module parameters used:
!   Module variables used:
!     status, n
!
!  Assumptions: 
!	1) pbp1fid is the file id of a netcdf file that is open and in data mode
!	2) dimensions have already been defined
! 
!-----------------------------------------------------------------------

   integer (kind=int_kind), intent(in) :: pbpfid
   type(meta_type), intent(in) :: pbpinfo
   real (kind=real_kind), dimension(:), intent(in) :: lons, lats
   integer (kind=int_kind), intent(in) :: max_ig
   real (kind=real_kind), dimension(:), intent(in), optional :: levelvals
   real (kind=real_kind), dimension(:), intent(in), optional :: levelvals_scm
   real (kind=dbl_kind), intent(in), optional :: ptop
   integer (kind=int_kind), intent(in), optional :: nlev_scm
   real (kind=dbl_kind), intent(in), dimension(:), optional :: plev_scminit
   character(len=*), dimension(:), intent(in), optional :: surface_type 
	
! coordinate variable id's	
   integer (kind=int_kind) :: lonvid, latvid, npntsvid, levelvid, i, j,   &
                              levelscmvid, plevscmvid, sfctypevid,        &
                              maxigvid
	
! variables necessary to set up dimensions as coordinate variables
   real (kind=real_kind) :: lonvals(pbpinfo%npoints), latvals(pbpinfo%npoints)
   real (kind=real_kind), dimension(:), allocatable :: pvals
   integer (kind=int_kind) :: nvals(pbpinfo%npoints), cstart(2), ccount(2)
   character (len=STRLEN) :: typevals(pbpinfo%npoints)

! temporary array to hold one REALX8 - used for type consistency
   real (kind=real_kind), dimension(1) :: temprval, ptem
	
   do n = 1, pbpinfo%npoints
      lonvals(n) = lons(n)
      latvals(n) = lats(n)
      nvals(n) = n
      if (present(surface_type)) typevals(n) = surface_type(n)
   enddo

! get 2-d coordinate variable id's
   status = nf_inq_varid (pbpfid, "longitude", lonvid)
   status = nf_inq_varid (pbpfid, "latitude", latvid)
   status = nf_inq_varid (pbpfid, "npoints", npntsvid)
   status = nf_inq_varid (pbpfid, "max_ig", maxigvid)
   if (present(surface_type))                                             &
      status = nf_inq_varid (pbpfid, "surface_type", sfctypevid)
	
! put coordinate values in coordinate variables
   status = nf_put_var_real (pbpfid, lonvid, lonvals)
   status = nf_put_var_real (pbpfid, latvid, latvals)
   status = nf_put_var_int (pbpfid, npntsvid, nvals)
   status = nf_put_var_int (pbpfid, maxigvid, max_ig)
   if (present(surface_type)) then
      cstart = (/1, 1 /)   
      ccount = (/STRLEN, pbpinfo%npoints/)
      status = nf_put_vara_text (pbpfid, sfctypevid, cstart, ccount,      &
                                 typevals)
   endif
	
! put level values in coordinate variable if present
   if (present(levelvals)) then
      status = nf_inq_varid (pbpfid, "level", levelvid)
      status = nf_put_var_real (pbpfid, levelvid, levelvals)
      if (present(levelvals_scm)) then
	 status = nf_inq_varid (pbpfid, "level_scm", levelscmvid)
	 status = nf_put_var_real (pbpfid, levelscmvid, levelvals_scm)

         allocate(pvals(nlev_scm))
         do n = 1,nlev_scm
            pvals(n) = plev_scminit(n) * 0.01
         enddo
	 status = nf_inq_varid (pbpfid, "p_scm", plevscmvid)
	 status = nf_put_var_real (pbpfid, plevscmvid, pvals)
         deallocate(pvals)
      endif

      if (present(ptop)) then
         ptem     = ptop * 0.01
         temprval = (/ptem/)
	 status = nf_inq_varid (pbpfid, "ptop", levelvid)
	 status = nf_put_var_real (pbpfid, levelvid, temprval)
      endif
   endif

END SUBROUTINE init_pbp_coord

	
!-----------------------------------------------------------------------

SUBROUTINE write_pbp_2d(pbp1fid, pbp1info, pbp1,                          &
                        namepbp1, dopbp1, indxpbp1)
     
!-----------------------------------------------------------------------
!  Purpose:
!	writes an entire time record worth of two dimensional data 
!	to the netcdf file connected to pbp1fid
!
!  Variables:
!   Module variables used:
!
!  Assumptions:
!	1) data is compressed in the manner of pbp data
!	2) pbp1fid is connected to a netcdf file that is open and in data mode
!	   and has the 2 dimensional variables with names in the array namepbp1
!	   already defined
!-----------------------------------------------------------------------

   integer (kind=int_kind), intent(in) :: pbp1fid
   type (meta_type), intent(in) :: pbp1info
   real (kind=real_kind), dimension(:,:), intent(in) :: pbp1
   character(len=*), dimension(:), intent(in) :: namepbp1
   logical (kind=log_kind), dimension(:), intent(in) :: dopbp1
   integer (kind=int_kind), dimension(:), intent(in) :: indxpbp1
	
   integer (kind=int_kind) :: point
   integer (kind=int_kind) :: pbpvid
   integer (kind=int_kind), dimension(2) :: pbp1start, pbp1count
   real (kind=real_kind) :: pbp1vals(pbp1info%npoints)
	
   pbp1start = (/1, get_time_step(pbp1info)/)
   pbp1count = (/pbp1info%npoints, 1/)
         	
   do n = 1, size(dopbp1)
      if (dopbp1(n)) then
	 pbp1vals(:) = pbp1(indxpbp1(n), :)
	 status = nf_inq_varid (pbp1fid, namepbp1(n), pbpvid)
	 status = nf_put_vara_real (pbp1fid, pbpvid, pbp1start,           &
                                    pbp1count, pbp1vals)
      endif
   enddo
     	
END SUBROUTINE write_pbp_2d
	   		   	
!-----------------------------------------------------------------------

SUBROUTINE write_pbp_3d(pbp2fid, pbp2info, pbp2,                          &
                        namepbp2, dopbp2, indxpbp2)
     
!-----------------------------------------------------------------------
!  Purpose:
!	writes an entire time record worth of three dimensional data 
!	to the netcdf file connected to pbp2fid
!
!  Variables:
!   Module variables used:
!
!  Assumptions:
!	1) data is compressed in the manner of pbp data
!	2) pbp2fid is connected to a netcdf file that is open and in data mode
!	   and has the 3 dimensional variables with names in the array namepbp1
!	   already defined
!-----------------------------------------------------------------------

   integer (kind=int_kind), intent(in) :: pbp2fid
   type(meta_type), intent(in) :: pbp2info
   real (kind=real_kind), dimension(:,:,:), intent(in) :: pbp2
   character(len=*), dimension(:), intent(in) :: namepbp2
   logical (kind=log_kind), dimension(:), intent(in) :: dopbp2
   integer (kind=int_kind), dimension(:), intent(in) :: indxpbp2
	
   integer (kind=int_kind) :: k, point, level
   integer (kind=int_kind) :: pbpvid
   integer (kind=int_kind), dimension(3) :: pbp2start, pbp2count
   real (kind=real_kind) :: pbp2vals(pbp2info%npoints*pbp2info%nlevels)

   pbp2start = (/1, 1, get_time_step(pbp2info)/)
   pbp2count = (/pbp2info%npoints, pbp2info%nlevels, 1/)


   do n = 1, size(dopbp2)
      if (dopbp2(n)) then

!        print *, "PBP2 write variable ", namepbp2(n) 
         k = 1
         do level = 1, pbp2info%nlevels
            do point = 1, pbp2info%npoints
               pbp2vals(k) = pbp2(level, indxpbp2(n), point)
	       k = k+1
	    enddo
	 enddo

	 status = nf_inq_varid (pbp2fid, namepbp2(n), pbpvid)
	 status = nf_put_vara_real (pbp2fid, pbpvid, pbp2start,           &
                                    pbp2count, pbp2vals)
      endif
   enddo
     	
END SUBROUTINE write_pbp_3d


END MODULE netcdf_pbp

