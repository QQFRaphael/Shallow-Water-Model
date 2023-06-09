 !-----------------------------------------------------------------------

MODULE netcdf_geodesic

!-----------------------------------------------------------------------
!
! Purpose:
!    These routines are geodesic grid specific routines for writing
!          netcdf output for time-averaged global (QP) diagnostics.
!
! History:
!    Note: These version numbers are intended to reflect changes to the
!          actual output, not logic or input changes.  When output is
!          changed, also increment module parameter "VERSION" below.
!
!    version 0.4: 
!       12/14/99: added land,sea,icefrac definition routines, 
!                 define_fracs and set_fracs.   
!                 fracs written for atm and co2 files. - brian
!
!    version 0.5: 
!       12/10/00: atmosphere routines for BUGS5 (mpi) model 
!                 3d fields are interpolated to isobaric (or isentropic) levels 
!                 - don
!
!    version 0.6: 
!       02/11/03: component independent routines are pulled from ncgeowrt.F
!                 to create this module. The component specific routines
!                 are generalized into component independent routines 
!                 - Don Dazlich
!
!-----------------------------------------------------------------------

   use kinds
   use types
   use netcdf_util
   use netcdf_general_tools

   implicit none
   private

   character(len=8), parameter :: GRIDTYPE = "geodesic"
   character(len=3), parameter :: VERSION = "0.6"

   public :: meta_type   ! from netcdf_general_tools

   integer (kind=int_kind) :: status, n

! public member functions
   public :: ginit_nc, gwrt_nc


CONTAINS


!-----------------------------------------------------------------------

SUBROUTINE ginit_nc (run, outfile, gmeta,                                 &
                     listqp, nameqp, unitsqp, doqp,                       &
                     category, multfac, contmin, contint, altunits,       &
                     qpcornerlat, qpcornerlon, qpcenterlat, qpcenterlon,  &
                     corners,                                             &
                     points, max_ig,                                      &
                     levels, level_title, level_units, pm, qpgridarea )

!-----------------------------------------------------------------------
! Purpose:
!    Public interface to geodesic grid initialization routine.
!    A call to this routine will open a netcdf file for qp diagnostics.
!-----------------------------------------------------------------------

! argument list
   character(len=*), intent(in) :: run        ! run description
   character(len=*), intent(in) :: outfile    ! netcdf output filename
   type (meta_type), intent(out) :: gmeta     ! component dependent meta data

! qp variables names and attributes
   character(len=*), dimension(:), intent(in) :: listqp  ! list of qp variable
                                                         !  short names
   character(len=*), dimension(:), intent(in) :: nameqp  ! list of qp variable
                                                         !  long names
   character(len=*), dimension(:), intent(in) :: unitsqp ! list of qp units
   character(len=*), dimension(:), intent(in) :: category ! list of qp category name
   character(len=*), dimension(:), intent(in) :: altunits ! list of qp alternate units
   logical (kind=log_kind), dimension(:), intent(in) :: doqp ! list of saved qps
   real (kind=real_kind), dimension(:), intent(in) :: multfac, contmin, contint
   
! dimensions
   integer (kind=int_kind), intent(in) :: points   ! number of grid cells saved
                                                   !  saved to this file
   integer (kind=int_kind), intent(in) :: corners  ! maximum number of corners
                                                   !  in a grid cell polygon
   integer (kind=int_kind), intent(in) :: max_ig   ! global number of grid cells

! grid variables
   real (kind=selected_real_kind(13)), dimension(corners,points),   &
      intent(in) :: qpcornerlat, qpcornerlon
   real (kind=selected_real_kind(13)), dimension(points),           &
      intent(in) :: qpcenterlat, qpcenterlon
   real (kind=selected_real_kind(13)), dimension(points),           &
      intent(in), optional ::  qpgridarea
      

! optional arguments - used for 3d variables
   integer (kind=int_kind), intent(in), optional :: levels  ! number of levels
                                                            !  in vertical
   character(len=*), intent(in), optional :: level_title    ! level name
   character(len=*), intent(in), optional :: level_units    ! level units
! pm is an array of vertical surfaces (e.g. isentropic, isobaric)
   real (kind=dbl_kind), dimension(:), intent(in), optional :: pm


! local variables
   logical (kind=log_kind), dimension(points) :: dumhr
   logical (kind=log_kind) :: dogridarea
   integer (kind=int_kind) :: ncfid
   real (kind=real_kind), dimension(:), allocatable :: levelvals
   integer (kind=int_kind), dimension(1) :: sizedim
   integer (kind=int_kind) :: dumid


   dumhr = .true.
   dogridarea = present(qpgridarea)

! open the netcdf file and define the metadata
   if(present(levels)) then
      allocate(levelvals(levels))
      levelvals(1:levels) = pm(1:levels)
      gmeta = set_meta (outfile, "gatm", points, 0, 0,           &
                        levels, level_title, level_units )
   else
      gmeta = set_meta (outfile, "gatm", points, 0, 0)
   endif
   status = nf_create (outfile, NF_CLOBBER, ncfid)
   call nc_init_geo (ncfid, trim(run), gmeta, corners, max_ig,         &
                    listqp, nameqp, unitsqp, doqp, dogridarea,         &
                    category, multfac, contmin, contint, altunits)
!  call define_fracs (ncfid)
! interp
   status = nf_inq_dimid (ncfid, "grid_size", sizedim(1))
   call handle_error(status, "couldn't get grid_size")
   status = nf_def_var (ncfid, "interp_indx", NF_INT, 1, sizedim, dumid)
   call handle_error(status, "couldn't define interp_indx")
   status = nf_enddef (ncfid)
! end interp

   if(dogridarea) then
      if(present(levels)) then
         call init_geo_coord (ncfid, gmeta, points,                         &
                        qpcornerlat, qpcornerlon, qpcenterlat, qpcenterlon, &
                        corners, levelvals, qpgridarea=qpgridarea)
      else
         call init_geo_coord (ncfid, gmeta, points,                         &
                        qpcornerlat, qpcornerlon, qpcenterlat, qpcenterlon, &
                        corners, qpgridarea=qpgridarea)
      endif
   else
      if(present(levels)) then
         call init_geo_coord (ncfid, gmeta, points,                         &
                        qpcornerlat, qpcornerlon, qpcenterlat, qpcenterlon, &
                        corners, levelvals)
      else
         call init_geo_coord (ncfid, gmeta, points,                         &
                        qpcornerlat, qpcornerlon, qpcenterlat, qpcenterlon, &
                        corners)
      endif
   endif
   if(allocated(levelvals)) deallocate(levelvals)
   status = nf_close (ncfid)

END SUBROUTINE ginit_nc





SUBROUTINE gwrt_nc (nsecond, nsecinit, n_points, l_grid_mask,    &
                    namegeo, dogeo, indxgeo, gmeta,                      &
    		    interp_indx,             &
                    geo2, geo3 )

!-----------------------------------------------------------------------
! Purpose: To write a qp diagnostic array, geo, into a netcdf file
!
! Bugs:
!    * setting fracs here is somewhat hackish (it only needs to be done 
!      once - this should ideally happen in the init routines)
!----------------------------------------------------------------------

! argument list
   integer (kind=int_dbl_kind), intent(in) :: nsecond  ! current time (s)
   integer (kind=int_dbl_kind), intent(in) :: nsecinit ! time at start of averaging (s)
   integer (kind=int_kind), intent(in) :: n_points ! number of grid cells to write
!tdr
!  integer (kind=int_kind), intent(in) :: nyear0   ! reference year for time=0
!  real (kind=real_kind), dimension(:,:,:), intent(in) ::                &
!     landfrac, seafrac, icefrac     ! fraction of various surface types in cell
!endtdr
   logical (kind=log_kind), dimension(:,:,:), intent(in) ::              &
      l_grid_mask                    ! grid cell mask
   integer (kind=int_kind), dimension(:,:,:), intent(in) ::              &
      interp_indx                    ! index within global geodesic vector
   real (kind=real_kind), dimension(:,:,:,:), intent(in), optional :: geo2 
   real (kind=real_kind), dimension(:,:,:,:,:), intent(in), optional :: geo3 
   character(len=*), dimension(:), intent(in) :: namegeo
   logical (kind=log_kind), dimension(:), intent(in) :: dogeo
   integer (kind=int_kind), dimension(:), intent(in) :: indxgeo
   type (meta_type), intent(inout) :: gmeta

! local variables
   integer (kind=int_kind) :: fileID

! tdr hardwired stuff
   integer (kind=int_kind) :: isize(3)
! endtdr
   

   print *, "gwrt_nc: writing geodesic data for ",gmeta%datatype

   call next_time_step(gmeta)
   status = nf_open(file_name(gmeta), NF_WRITE, fileID)
   if (get_time_step(gmeta) == 1) then   ! first time called
      call set_interp_indx(fileID, interp_indx, l_grid_mask, n_points)
   end if
   call set_time(fileID, nsecond, get_time_step(gmeta), nsecinit)

   if(gmeta%nlevels == 0 ) then
      call write_geo_2d(fileID, gmeta, geo2, namegeo, dogeo, indxgeo,    &
                        l_grid_mask, n_points)
   else
      call write_geo_3d(fileID, gmeta, geo3, namegeo, dogeo, indxgeo,    &
                        l_grid_mask, n_points )
   endif
   status = nf_close(fileID)


END SUBROUTINE gwrt_nc



!-----------------------------------------------------------------------

SUBROUTINE nc_init_geo (qpfid, run_name, geo_meta, corners,            &
     			max_ig, listgeo, namegeo, unitsgeo, dogeo, dogridarea, &
     			category, multfac, contmin, contint, altunits)	
     
!-----------------------------------------------------------------------
!  Purpose:
!	initialize netcdf files
!       defines all standard geodesic dimensions and variables.
!
!  Scope:
!    Module parameters used:
!   	   STRLEN, MAXNAME, MAXUNITS, MAXLONGN, 
!	   time, char_time
!    Module variables used:
!
!    Module procedures called:
!      define_geo_grid - adds variables that need to be defined for
!                        the geodesic output grid.
!    netcdf_general_tools procedures:
!      define_time - defines the time variables (time, char_time, 
!                    period_start, period_end, period_length)
!      get_units(list, longname, units) - subroutine - removes the units from 
!  	      string list, returns longname(len=MAXLONGN) (string without units)
!  	      and units(len=MAXUNITS)
!
!  Assumptions:
!	- qpfid is connected to an open netcdf file in define mode
!	- namegeo is an array of unique variable names 
!	  only of letters, numbers and underscore (technically,
!	  the variables actually used need unique names.)
!	- listgeo is an array of variable descriptions  
!	   with units optionally included in parentheses.
!-----------------------------------------------------------------------
! argument declarations
   integer (kind=int_kind), intent(in) :: qpfid
   character(len=*), intent(in) :: run_name
   type(meta_type), intent(in) :: geo_meta
   integer (kind=int_kind), intent(in) :: corners
   integer (kind=int_kind), intent(in) :: max_ig
   character(len=*), dimension(:), intent(in) :: unitsgeo
   character(len=*), dimension(:), intent(in) :: namegeo
   character(len=*), dimension(:), intent(in) :: listgeo
   character(len=*), dimension(:), intent(in) :: category
   character(len=*), dimension(:), intent(in) :: altunits
   logical (kind=log_kind), dimension(:), intent(in) :: dogeo
   logical (kind=log_kind), intent(in) :: dogridarea
   real (kind=real_kind), dimension(:), intent(in) :: multfac
   real (kind=real_kind), dimension(:), intent(in) :: contmin
   real (kind=real_kind), dimension(:), intent(in) :: contint
     	
!  local variables to hold longname and units 
   integer (kind=int_kind) :: l_len, u_len
   character(len=MAXUNITS) :: units
   character(len=MAXLONGN) :: longname

!  local geo2 dimension id numbers
   integer (kind=int_kind) :: celldim, leveldim, numdim
   integer (kind=int_kind) :: leveldims(1)
   integer (kind=int_kind) :: timedim
	   
! array to hold dimension ids
   integer (kind=int_kind), allocatable, dimension(:) :: qpdims

! general variable id - used to define variables
   integer (kind=int_kind) :: qpvid

! add standard global attributes
   call add_global_atts (qpfid, trim(run_name), GRIDTYPE, VERSION, max_ig)

! define dimensions 
   call define_time (qpfid, timedim, .true.)
   call define_geo_grid (qpfid, geo_meta%npoints, corners, celldim, dogridarea)


!   If data is three dimensional, add level dimension and coordinate variable.
!   Define dimensionality of coordinate variables.
   if (geo_meta%nlevels < 1) then 
      numdim = 2
      allocate (qpdims(numdim))
      qpdims = (/celldim, timedim/)
   else
      status = nf_def_dim (qpfid,"level",geo_meta%nlevels,leveldim)	
      leveldims = (/leveldim/)
      status = nf_def_var (qpfid,"level",NF_FLOAT,1,leveldims,qpvid)
      call get_units (geo_meta%level_title, geo_meta%level_units, l_len, u_len)
      status = nf_put_att_text (qpfid, qpvid, "title", l_len,     &
                                geo_meta%level_title)
      status = nf_put_att_text (qpfid, qpvid, "units", u_len,     &
                                geo_meta%level_units)
      numdim = 3
      allocate (qpdims(numdim))
      qpdims = (/celldim, leveldim, timedim/)
   endif

!   loop to define variables and add attributes
   do n = 1, size(dogeo)
      if (dogeo(n)) then   
!	 print *, n, " Netcdf Geodesic Define: ", namegeo(n)
         status = nf_def_var (qpfid, namegeo(n), NF_FLOAT, numdim, qpdims,   &
                              qpvid)
	 call get_units (listgeo(n), unitsgeo(n), l_len, u_len)
         status = nf_put_att_text (qpfid, qpvid, 'long_name', l_len, listgeo(n))
         status = nf_put_att_text (qpfid, qpvid, 'title', l_len, listgeo(n))
	 status = nf_put_att_text (qpfid, qpvid, 'units', u_len, unitsgeo(n))
	 status = nf_put_att_text (qpfid, qpvid, 'alt_units', len_trim(altunits(n)), &
	                           altunits(n))
	 status = nf_put_att_text (qpfid, qpvid, 'type', 3, category(n))

! FIXME - positions may not be needed
	 status = nf_put_att_text (qpfid, qpvid, 'positions', 6, "center")
	 status = nf_put_att_real (qpfid, qpvid, 'missing_value',            &
                                   NF_FLOAT, 1, MISSING)
                                   
!-- add multiplicative factor, minimum contour and contour interval attributes
     status = nf_put_att_real (qpfid, qpvid, 'mult_factor', NF_FLOAT, 1, multfac(n))
     status = nf_put_att_real (qpfid, qpvid, 'contour_min', NF_FLOAT, 1, contmin(n))
     status = nf_put_att_real (qpfid, qpvid, 'contour_int', NF_FLOAT, 1, contint(n))
     
      end if
   end do
      	
   deallocate (qpdims)

END SUBROUTINE nc_init_geo   


!-----------------------------------------------------------------------

SUBROUTINE define_geo_grid (fileID, ncells, corners, cell_dim, dogridarea )
	
!-----------------------------------------------------------------------
! Purpose:
!     Defines the geodesic grid - copies data from appropriate grid file
!
! Scope: private subroutine
!   Module variables used:
!       status
!   Parameters:
!     In:
!       fileID - netcdf file ID 
!       ncells - number of cells used on grid (length of variable arrays)
!       nhr - grid size
!     Out:
!       cell_dim - netcdf dimension ID (number of grid cells - returned
!                  for easy use by calling routine.)
!   Local variables:
!       gridcellsID - netcdf dimension ID (number of grid cells)
!       gridsizeID - netcdf dim. ID (grid size - this is the size of
!                    the whole grid, of which a certain subset of cells
!                    may be written (this subset is gridcellsID))
!       gridcornID - netcdf dim. ID (number of corners per grid cell -
!                    note that this is 6 even though)
!       gridrankID - netcdf dim. ID (dimensionality of grid)
!
! Bugs:
!   * hardcoded file name for grid definition (C*.global.nc)
!-----------------------------------------------------------------------

! argument list
   integer (kind=int_kind), intent(in) :: fileID
   integer (kind=int_kind), intent(in) :: ncells
   integer (kind=int_kind), intent(in) :: corners
   integer (kind=int_kind), intent(out) :: cell_dim
   logical (kind=log_kind), intent(in) :: dogridarea

! local variables
   integer (kind=int_kind) :: gridcellsID, gridsizeID, gridcornID, gridrankID
   integer (kind=int_kind) :: dim_len

   integer (kind=int_kind) :: varid

   integer (kind=int_kind), dimension(:), allocatable :: tmpdim



! define grid dimension on destination grid
   status = nf_def_dim (fileID, "grid_cells", ncells, gridcellsID)

   status = nf_def_dim (fileID, "grid_size", ncells, gridsizeID)

   status = nf_def_dim(fileID, "grid_corners", corners, gridcornID)

   status = nf_def_dim (fileID, "grid_rank", 1, gridrankID)

! define grid variables on destination grid
   allocate (tmpdim(1))
   tmpdim = (/gridcellsID/)

   status = nf_def_var (fileID, "grid_center_lat", NF_DOUBLE,             &
                        size(tmpdim), tmpdim, varid)
   status = nf_put_att_text (fileID, varid, "units", 7, "radians")
   status = nf_def_var (fileID, "grid_center_lon", NF_DOUBLE,             &
                        size(tmpdim), tmpdim, varid)
   status = nf_put_att_text (fileID, varid, "units", 7, "radians")
        
   if(dogridarea) then
      status = nf_def_var (fileID, "grid_area", NF_DOUBLE,                &
                           size(tmpdim), tmpdim, varid)
      status = nf_put_att_text (fileID, varid, "units", 14, "square radians")
   endif

   tmpdim = (/gridrankID/)

   status = nf_def_var (fileID, "grid_dims", NF_INT, size(tmpdim),        &
                        tmpdim, varid)

   deallocate (tmpdim)
   allocate (tmpdim(2))
   tmpdim = (/gridcornID, gridcellsID/)

   status = nf_def_var (fileID, "grid_corner_lat", NF_DOUBLE,             &
                        size(tmpdim), tmpdim, varid)
   status = nf_put_att_text (fileID, varid, "units", 7, "radians")
   status = nf_def_var (fileID, "grid_corner_lon", NF_DOUBLE,             &
                        size(tmpdim), tmpdim, varid)
   status = nf_put_att_text (fileID, varid, "units", 7, "radians")

   deallocate (tmpdim)

   cell_dim = gridcellsID

END SUBROUTINE define_geo_grid


!-----------------------------------------------------------------------

SUBROUTINE init_geo_coord (qpfid, geo_meta, points,                            &
                           qpcornerlat, qpcornerlon, qpcenterlat, qpcenterlon, & 
                           corners, levelvals, qpgridarea)
	
!-----------------------------------------------------------------------
!  Purpose:
!   sets values of coordinate variables (center_lat, center_lon, etc.)
! 
!  Scope:
!   Module variables used:
!       status
!   Module routines called:
!       copy_geo_grid
!
!  Assumptions: 
!	1) qpfid is the file id of a netcdf file that is open and in data mode
!	2) levelvals (if present) is a real array with geo_meta%nlevels elements
!	3) dimensions have already been defined
!
!  Bugs:
!       1) A good method for finding position data files is needed.
!-----------------------------------------------------------------------

! argument list
   integer (kind=int_kind), intent(in) :: qpfid
   integer (kind=int_kind), intent(in) :: corners
   integer (kind=int_kind), intent(in) :: points
   type(meta_type), intent(in) :: geo_meta
   real (kind=real_kind), dimension(:), intent(in), optional :: levelvals
   real (kind=selected_real_kind(13)), dimension(corners,points), intent(in) :: &
      qpcornerlat, qpcornerlon
   real (kind=selected_real_kind(13)), dimension(points), intent(in) ::      &
      qpcenterlat, qpcenterlon
   real (kind=selected_real_kind(13)), dimension(points), intent(in), optional :: &
      qpgridarea

! local variables
   integer (kind=int_kind) :: temp_id


   if(present(qpgridarea)) then
      call copy_geo_grid (qpfid, geo_meta%npoints,                            &
                          qpcornerlat, qpcornerlon, qpcenterlat, qpcenterlon, &
                          corners, qpgridarea)
   else
      call copy_geo_grid (qpfid, geo_meta%npoints,                            &
                          qpcornerlat, qpcornerlon, qpcenterlat, qpcenterlon, &
                          corners )
   endif

   if (present(levelvals)) then
      status = nf_inq_varid (qpfid, "level", temp_id)
      status = nf_put_var_real (qpfid, temp_id, levelvals) 
   endif


END SUBROUTINE init_geo_coord 



!-----------------------------------------------------------------------

SUBROUTINE copy_geo_grid (fileID, points,                                      &
                   cornerlatvals, cornerlonvals, centerlatvals, centerlonvals, & 
                   corners, areavals)

!-----------------------------------------------------------------------
!  Purpose:
!     Copies coordinate variable information to the netcdf output file
!
!  Scope:
!    Module variables used:
!       status
! 
!-----------------------------------------------------------------------

! argument list
   integer (kind=int_kind), intent(in) :: fileID
   integer (kind=int_kind), intent(in) :: points
   integer (kind=int_kind), intent(in) :: corners
   real (kind=selected_real_kind(13)), intent(in), dimension(points) ::           &
      centerlatvals, centerlonvals
   real (kind=selected_real_kind(13)), intent(in), dimension(points), optional :: &
      areavals
   real (kind=selected_real_kind(13)), intent(in),            dimension(corners,points) :: &
      cornerlatvals, cornerlonvals

! local variables
   integer (kind=int_kind) :: latID, lonID, cornlatID, cornlonID, areaID



   status = nf_inq_varid (fileID, "grid_center_lat", latID)
   status = nf_inq_varid (fileID, "grid_center_lon", lonID)
   status = nf_inq_varid (fileID, "grid_corner_lat", cornlatID)
   status = nf_inq_varid (fileID, "grid_corner_lon", cornlonID)
   if(present(areavals)) status = nf_inq_varid (fileID, "grid_area", areaID)

   status = nf_put_var_double (fileID, latID, centerlatvals)
   status = nf_put_var_double (fileID, lonID, centerlonvals)
   status = nf_put_var_double (fileID, cornlatID, cornerlatvals)
   status = nf_put_var_double (fileID, cornlonID, cornerlonvals)
   if(present(areavals)) status = nf_put_var_double (fileID, areaID, areavals)

END SUBROUTINE copy_geo_grid 
        


SUBROUTINE define_indx (fileID)

!-----------------------------------------------------------------------
!  Purpose:
!    Define the interpolation index variable
!
!  Scope: private subroutine
!    Module variables used:
!      status
!    Parameters:
!     In:
!      fileID: netcdf file ID, open and in define mode.
!    Local variables:
!      sizedim - netcdf dimension ID (grid size - stored in a 
!                single valued array for type consistency)
!      dumid - netcdf variable ID (dummy parameter for function call)
!
!  Bugs:
!-----------------------------------------------------------------------

   integer (kind=int_kind), intent(in) :: fileID

   integer (kind=int_kind), dimension(1) :: sizedim
   integer (kind=int_kind) :: dumid

!  get the dimension id needed (the grid size dimension)
   status = nf_inq_dimid (fileID, "grid_size", sizedim(1))
   call handle_error(status, "couldn't get grid_size")

!  define index variables
   status = nf_def_var (fileID, "interp_indx", NF_INT, 1, sizedim, dumid)
   call handle_error(status, "couldn't define interp_indx")


END SUBROUTINE define_indx



!-----------------------------------------------------------------------

SUBROUTINE set_interp_indx (fid, interp_indx, l_grid_mask, n_points)  
	
!-----------------------------------------------------------------------
!  Purpose: writes array of values representing the sequential index 
!           of each point of the grid for the purpose of interpolation
!           to a latlon grid consistent with indices in interp_sgg_*
!           Modeled on set_fracs
!
!  Scope: private subroutine
!   Module variables used:
!	status
!   Parameters:
!     In:
!       fid - netcdf file ID, open and in data mode.
!       interp_indx - interpolation indices to be written
!       l_grid_mask - logical mask to pack the input indices
!       n_points - number of unique data points in the indx array
!                  (number of true points in l_grid_mask)
!   Local variables:
!       terpvid - netcdf variable id (current terp variable)
!       tem_indx - packed vector of unique data points
!   Intrinsics - fortran 90 function PACK
!
!  Bugs:
!     * no error checking
!-----------------------------------------------------------------------
	
! argument list	
   integer (kind=int_kind), intent(in) :: fid
   integer (kind=int_kind), dimension(:,:,:), intent(in) :: interp_indx
   integer (kind=int_kind), intent(in) :: n_points
   logical (kind=log_kind), dimension(:,:,:), intent(in) :: l_grid_mask
	
! local variables
   integer (kind=int_kind) :: terpvid
   integer (kind=int_kind), dimension(n_points) :: tem_indx

   tem_indx = pack(interp_indx, l_grid_mask)
   status = nf_inq_varid (fid, "interp_indx", terpvid)
   status = nf_put_var_int (fid, terpvid, tem_indx)


END SUBROUTINE set_interp_indx



!-----------------------------------------------------------------------

SUBROUTINE write_geo_2d(fid, geo_meta, geo2, namegeo2, dogeo2,            &
                       indxgeo2, l_grid_mask, n_points )
	
!-----------------------------------------------------------------------
!  Purpose:
!	writes an entire time record worth of two dimensional data 
!	to the netcdf file connected to fid
!
!  Scope:
!   Module parameters used:
!   Module variables used:
!   Intrinsics used: PACK
!
!  Assumptions:
!	-  netcdf file has the 2 dimensional variables with names 
!          in the array namegeo2 already defined
!-----------------------------------------------------------------------

! argument list
   integer (kind=int_kind), intent(in) :: n_points
   logical (kind=log_kind), dimension(:,:,:), intent(in) :: l_grid_mask
   integer (kind=int_kind), intent(in) :: fid
   type(meta_type), intent(in) :: geo_meta
   real (kind=real_kind), dimension(:,:,:,:), intent(in) :: geo2
   character(len=*), dimension(:), intent(in) :: namegeo2
   logical (kind=log_kind), dimension(:), intent(in) :: dogeo2
   integer (kind=int_kind), dimension(:), intent(in) :: indxgeo2

! local variables
   integer (kind=int_kind) :: ivar
   integer (kind=int_kind) :: qpvid
   integer (kind=int_kind), dimension(2) :: start, count
   real (kind=real_kind), dimension(n_points) :: tem_geo2

   start = (/1, geo_meta%timerec/)
   count = (/geo_meta%npoints, 1/)

!  Expand variables and write them.
!    - ivar keeps track of which variable (name) is being used
   ivar = 0
   do n = 1, size(dogeo2)
      if (dogeo2(n)) then
!        print *, "Writing geodesic data to variable ", namegeo2(n) 
	 ivar = ivar + 1
         status = nf_inq_varid (fid, namegeo2(n), qpvid)
         call handle_error(status, namegeo2(n))
         tem_geo2 = pack(geo2(:,:,ivar,:),l_grid_mask )
         status = nf_put_vara_real (fid, qpvid, start, count, tem_geo2)
         call handle_error(status, namegeo2(n))
      end if
   end do

	
END SUBROUTINE write_geo_2d	


!-----------------------------------------------------------------------

SUBROUTINE write_geo_3d(fid3, geo_meta, geo3, namegeo3,                &
                       dogeo3, indxgeo3, l_grid_mask, n_points)
	
!-----------------------------------------------------------------------
!  Purpose:
!	writes an entire time record worth of three dimensional data 
!	to the netcdf file connected to fid3
!
!  Scope:
!   Module variables used:
!   Intrinsics used: PACK
!
!  Assumptions:
!	- fid3 is connected to a netcdf file that is open and in data mode
!	  and has the 3 dimensional variables with names in the array namegeo2
!	  already defined
!-----------------------------------------------------------------------

! argument list
   integer (kind=int_kind), intent(in) :: n_points
   logical (kind=log_kind), dimension(:,:,:), intent(in) :: l_grid_mask
   integer (kind=int_kind), intent(in) :: fid3
   type(meta_type), intent(in) :: geo_meta
   logical (kind=log_kind), dimension(:), intent(in) :: dogeo3
   real (kind=real_kind), dimension(:,:,:,:,:), intent(in) :: geo3
   character(len=*), dimension(:), intent(in) :: namegeo3
   integer (kind=int_kind), dimension(:), intent(in) :: indxgeo3

! local variables
   integer (kind=int_kind) :: ivar, k, i, m
   integer (kind=int_kind) :: qpvid
   integer (kind=int_kind), dimension(3) :: start, count
   real (kind=real_kind) :: qp3vals(n_points*size(geo3,3))
   real (kind=real_kind), dimension(n_points) :: tem_geo3

   start = (/1, 1, geo_meta%timerec/)
   count = (/geo_meta%npoints, geo_meta%nlevels, 1/)

!  Expand variables and write
!    - ivar keeps track of which variable (name) is being used
   ivar = 0

   do n = 1, size(dogeo3)
      if (dogeo3(n)) then
!        print *, "Writing geodesic data to variable ", namegeo3(n) 
	   ivar = ivar + 1
         k = 0
!        do m = size(geo3,3),1,-1
         do m = 1,size(geo3,3)
             tem_geo3(:) = pack(geo3(:,:,m,ivar,:), l_grid_mask)
             do i = 1,size(tem_geo3,1)
                k = k + 1
                qp3vals(k) = tem_geo3(i)
             enddo
          enddo
          status = nf_inq_varid (fid3, namegeo3(n), qpvid)
          status = nf_put_vara_real (fid3, qpvid, start, count, qp3vals)
       end if
    end do

END SUBROUTINE write_geo_3d



END MODULE netcdf_geodesic

