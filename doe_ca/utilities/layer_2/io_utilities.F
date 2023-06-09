!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 
  module io_utilities
!-------------------------------------------------------------------------------
!
! Purpose: This module consists of routines to perform parallel direct 
!          access I/O in CSU climate model components. These routines
!          are created from source code gathered from BUGS5, the CSU  
!          atmospheric model for purposed of creating a library of I/O
!          utilities. This code is intended to be available to the 
!          community for use in any model component proposed to be part
!          of the Geodesic Climate Model.
!
! CSU parallel direct access I/O is designed to write all data for one
!    grid column to one record. The records are ordered according to the
!    standard geodesic vector ordering. In addition, these files have one
!    or more header records describing the data as well as other information
!    for error checking.
!
! Author: Don Dazlich, Dept. of Atmospheric Science, Colorado State University
!
! History: 03 Apr 2002 - began creation of this module.
!          22 May 2002 - module tested and committed to cvs.
!          15 May 2003 - extended routines to 4 dimensions for use
!                        for vector data and edges and vertices.
!          16 May 2003 - built in single process output for architectures
!                        that can't do parallel direct access output (linux = 0
!                        preprocessor directive, uses mpi);
!                        Added component_name to all public member
!                        argument lists
!          04 Jun 2003 - added pack_data_record and unpack_data_record
!                        routines for scalars.
!
!          FUTURE -  update read_time_stamp and write_time_stamp
!                    to have a time_stamp of the type specified by the
!                    ESMF time manager


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
! Guide to using these routines:
!  NOTE: THE COMPONENT REGISTRATION OF COMPONENT_INTRA MUST BE FIRST
!    INITIALIZED BEFORE USING THESE ROUTINES ON MORE THAN ONE PROCESSOR.
!
! To write a direct access file -
!   1. define a file header records using a pack_header call for each variable
!      that will be put into a file.
!     EXAMPLE:
! call pack_header( 'test', 'PS',    1, (/ntprog/)  )
! call pack_header( 'test', 'PB',    1, (/ntprog/)  )
! call pack_header( 'test', 'ETA',   2, (/nlm, ntprog/)  )
! call pack_header( 'test', 'DIV',   2, (/nlm, ntprog/)  )
!                     ^        ^     ^     ^
!                     |        |     |     |
!               component name |     |     |
!                      variable name |     |
!                                    |   variable dimensions (at one grid cell)
!                          number of dimension at one grid cell
! This program currently supports variables up to four dimensions, consider
!   a vector variable at grid corners - 
! call pack_header( 'test', 'U', 4, (/nspace,ncorners,nlm,ntprog/) )
!
! NOTE: the number of dimensions can be 0 (scalar), in which case
!   the array of variable dimensions can be skipped - 
! call pack_header( 'test', 'PHIS', 0 )
!
!   2. Once the header is defined, open an output file and write a header.
!     EXAMPLE
! call open_write_header( 'test', 'data/ic_atm', max_ig, .true., dbl_kind )
!                            ^         ^            ^       ^        ^
!                    component name    |            |       |   precision of
!                                 output file name  |       |   data in file
!                                              number of    |
!                                              grid cells   |
!                                                     if true, this is a
!                                                     restart file (bears a
!                                                     time stamp)
!
!   3. If this is a restart file, write a time stamp
!     EXAMPLE
!                       
! call write_time_stamp( 'test', nsecond )
!
!   4. At each grid cell, pack the data record and write the record
!     EXAMPLE
!                       
! do ksdm = 1,nsdm
!    do j = 1,jjm
!       do i = 1,iim
!
! note: order of pack calls is irrelevent
!            call pack_data_record ( 'test', 'PS',    ps(i,j,:,ksdm) )
!            call pack_data_record ( 'test', 'PB',    pb(i,j,:,ksdm) )
!            call pack_data_record ( 'test', 'ETA',   eta(i,j,:,:,ksdm) )
!            call pack_data_record ( 'test', 'DIV',   div(i,j,:,:,ksdm) )
!                                      ^       ^       ^
!                               component name |       |
!                                      variable name   |
!                                               data at 1 grid cell
!            call write_record( 'test', grid_center_mask(i,j,ksdm),  *
!                                           ^  grid_center_index(i,j,ksdm) )
!                                  ^        |        ^
!                           component name  |        |
!                                  grid cell mask    |
!                               grid cell number (unique, 1 through max_ig)
!       enddo
!    enddo
! enddo
!
!   5. Close the file
! call close_direct_file( 'test' )

!
! To read a direct access file -
!   1. open the direct access file
!  EXAMPLE
! call open_read_direct_file( 'test', 'data/ic_atm' )
!                                ^          ^
!                      component name    input file name
!
!   2. (optional) read the time stamp - can only do this for a restart file
!  EXAMPLE
! call read_time_stamp( 'test', nsecond )
!
!   3. At each grid cell, read a data record and unpack the data from it.
!  EXAMPLE
! do ksdm = 1,nsdm
!    do j = 1,jjm
!       do i = 1,iim
!          call read_record( 'test', grid_indx(i,j,ksdm) )
!                              ^          ^
!                     component name   grid cell number
!   note: order of unpack calls is irrelevent
!          call unpack_data_record ( 'test', 'PS',    ps(i,j,:,ksdm) )
!          call unpack_data_record ( 'test', 'PB',    pb(i,j,:,ksdm) )
!          call unpack_data_record ( 'test', 'ETA',   eta(i,j,:,:,ksdm) )
!          call unpack_data_record ( 'test', 'DIV',   div(i,j,:,:,ksdm) )
!                                      ^       ^       ^
!                               component name |       |
!                                      variable name   |
!                                               data at 1 grid cell
!       enddo
!    enddo
! enddo
!
! NOTE: If vertex data is read in this way, it will need wrapping;
!       Face data ghost cells are automatically filled on input.
!
!   4. Close the file
! call close_direct_file( 'test' )

! ONE FINAL NOTE !!!
! The logical unit numbers for the direct access files starts sequentially
!   from 40. On the SGI/IRIX, assign statements must be used for direct access
!   files:
! env FILENV=afile assign -F global u:40
! env FILENV=afile assign -F global u:41
! env FILENV=afile mpirun -np 2 bugs5 
!
! The user must keep track of how many files he expects to open and adjust
!   the above script accordingly. The alternative is to use the (slower)
!   gathered single process IO intended for the linux cluster, saddleback.
!   That is accomplished by setting the linux preprocessor definition to 1.




!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!
! Modules used
!
   use kinds
   use abort
   use component_intra

   implicit none
   private  
   save

#if mpi == 1 && parallel_io == 0
   INCLUDE 'mpif.h'
   integer (kind=int_kind) :: ierr   ! mpi error codes
# endif

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!             
! Public Member Functions
!
   public :: open_read_direct_file,  &
             close_direct_file,      &
             read_time_stamp,        &
             write_time_stamp,       &
             pack_header,            &
             open_write_header,      &
             read_record,            &
             write_record,           &
             pack_data_record,       &
             unpack_data_record

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!             
! define some parameters             
   integer (kind=int_kind),parameter ::                   &
         max_var_dims = 4 ! maximum dimensions at a grid cell
   integer (kind=int_kind),parameter ::                   &
         head_clen = 40    ! size of io_var_type%short_name
   integer (kind=int_kind),parameter ::                   &
         lunit_init = 40  ! logical unit number of first file to be opened
   
! define some types
   type :: io_var_type
      character(head_clen)                             :: short_name
      integer (kind=int_kind)                          :: nvar_dims
      integer (kind=int_kind), dimension(max_var_dims) :: var_dims
      integer (kind=int_kind)                          :: start_index
   end type io_var_type
             
! define a type for the io process that will be owned by the component
   type :: io_util_type

! variables defining the header record
      character (len=72) :: component_name
      integer (kind=int_kind) :: nhead          ! number of header records (includes any time stamp)
      integer (kind=int_kind) :: nvar           ! number of variables in data records
      integer (kind=int_kind) :: real_bytes     ! number of bytes in real data 
      integer (kind=int_kind) :: lrecl          ! file record length 
      integer (kind=int_kind) :: ncells         ! number of grid cells in file 
      integer (kind=int_kind) :: s_index        ! starting index in data record 
      logical (kind=log_kind) :: restart_file   ! if true, this file is a restart file
      character (char_len) :: open_filename     ! name of the open file

      type(io_var_type), dimension(:), pointer :: header

      logical (kind=log_kind) ::                                          &
         l_open_file     ! true if direct access file is open
      integer (kind=int_kind) :: lunit
      real (kind=selected_real_kind(6)), dimension(:), pointer ::     &
         xrec4  ! real*4 data record buffer
      real (kind=selected_real_kind(13)), dimension(:), pointer ::    &
         xrec8  ! real*8 data record buffer
         
!~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
!  pointer to next node
!~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
      type (io_util_type), pointer :: next
   end type io_util_type

  
! declare a variable with io_util_type
   type (io_util_type), pointer ::                                        &
      io_util_list      

!-----------------------------------------------------------------------
!
!  generic interface definitions
!
!-----------------------------------------------------------------------
   interface pack_data_record
      module procedure pack_data_record_scalar, &
                       pack_data_record_1d,     &
                       pack_data_record_2d,     &
                       pack_data_record_3d,     &
                       pack_data_record_4d
   end interface

   interface unpack_data_record
      module procedure unpack_data_record_scalar, &
                       unpack_data_record_1d,     &
                       unpack_data_record_2d,     &
                       unpack_data_record_3d,     &
                       unpack_data_record_4d
   end interface

   contains

!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 
      subroutine open_read_direct_file(component_name, file_name, ncells_test )
!-------------------------------------------------------------------------------
!
! Purpose: This subroutine opens a direct access file for read-only access.
!          This routine also reads the header records.
!     USED FOR INPUT
!
! Author: Don Dazlich, Department of Atmospheric Science, CSU
!
! History: 15 Apr 2002 - created this routine
!
      implicit none

! Argument list

      character (*), intent(in) ::                               &
            component_name  ! component name
      character (*), intent(in) ::                               &
            file_name       ! input file name
      integer (kind=int_kind), intent(in), optional ::           &
            ncells_test ! model number of cells - the user can pass this
                        ! variable into this routine for error checking purposes

! local variables

      TYPE (io_util_type),POINTER ::                             &
         current
      integer (kind=int_kind) :: n       !loop index
      integer (kind=int_kind) :: ioerr   ! io error code

! check if this is the first io call for this component, and if so initialize
!    the io registration
      call initialize_component_io (component_name)

! point to the element of the io data type for this component
      current => get_component_pointer_io(component_name)

! store the file name
      do n = 1,char_len
         current%open_filename(n:n) = ' '
      enddo
      current%open_filename = trim(file_name)

! This first open is to get file record length from record 1
      open(unit=current%lunit,        &
           file=trim(file_name),      &
           form='unformatted',        &
           access='DIRECT',           &
           recl=8,                    &
           status='OLD',              &
           action='READ',             &
           iostat=ioerr )

! error checking 
      if(ioerr /= 0) then
         print *,'error opening file ',trim(file_name),' in component ',   &
                  component_name
         print *,'iostat = ',ioerr
         call abort_code('error in open_read_direct_file')
      endif

      read(current%lunit, rec=1)current%nhead, current%lrecl

! close file and reopen with proper record length

      close(current%lunit)

      open(unit=current%lunit,        &
           file=trim(file_name),      &
           form='unformatted',        &
           access='DIRECT',           &
           recl=current%lrecl,        &
           status='OLD',              &
           action='READ',             &
           iostat=ioerr )

! read record 2 and get number of data variables, precision, number
!   of grid cells, and is this a restart file.
      read(current%lunit,rec=2)current%nvar, current%real_bytes,    &
                       current%ncells, current%restart_file

! error checking - does the input file have the same number of grid cells
!                  as the calling program
      if(present(ncells_test)) then
         if(ncells_test /= current%ncells) then
            print *,'input file ',trim(file_name),' in component ',  &
                     component_name
            print *,'ncells does not match between input file and model:'
            print *,' model ncells = ',ncells_test
            print *,' file ncells = ',current%ncells
            call abort_code('error in open_read_direct_file')
         endif
      endif

! read the variable descriptors
      allocate (current%header(current%nvar))

! read the header record for each variable
      do n = 1, current%nvar
         read(current%lunit,rec=n+2) current%header(n)%short_name,        &
                                     current%header(n)%nvar_dims,         &
                                     current%header(n)%var_dims,          &
                                     current%header(n)%start_index
      enddo

! error check the data precision
      if(current%real_bytes == 4) then
         allocate(current%xrec4(current%lrecl/current%real_bytes))
      elseif(current%real_bytes == 8) then
         allocate(current%xrec8(current%lrecl/current%real_bytes))
      else
         print *,'I/O warning for file ',trim(current%open_filename),    &
                 ' in component ',component_name
         print *,'real_bytes = ',current%real_bytes,' : not a valid value'
         call abort_code('error in open_read_direct_file')
      endif

! set flag signifying file is open
      current%l_open_file = .true.

! end of routine
      end subroutine open_read_direct_file
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 



!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 
      subroutine pack_header( component_name, var_name, nvar_dims, var_dims )
!-------------------------------------------------------------------------------
!
! Purpose: This subroutine packs one header record with variable description
!          data.
!     USED FOR OUTPUT
!
! Calls to this routine should be in the order the variables are in the
!    data record:
!   e.g
!     call pack_header('atm','ps',1,ntprog)
!     call pack_header('atm','pb',1,ntprog)
!   correspond to the data record
!     write(...)ps(i,j,:,ksdm),pb(i,j,:,ksdm)
!
! Author: Don Dazlich, Department of Atmospheric Science, CSU
!
! History: 15 Apr 2002 - created this routine
!          16 May 2003 - added component name
!          04 Jun 2003 - modified for a scalar (nvar_dims=0) variable
!
      implicit none

! Argument list
      character (*), intent(in) ::                            &
           component_name  ! component model name
      character (*), intent(in) ::                            &
           var_name  ! component model name
      integer (kind=int_kind), intent(in)  ::                 &
           nvar_dims  ! number of dimensions written at one grid cell
      integer (kind=int_kind), dimension(*), intent(in), optional ::    &
           var_dims    ! dimension values

! local variables
      TYPE (io_util_type),POINTER ::                          &
         current
      type (io_var_type), allocatable, dimension(:) :: tem_header
      integer (kind=int_kind) :: n    ! loop index
      integer (kind=int_kind) :: len  ! array size

! check if this is the first io call for this component, and if so initialize
!    the io registration
      call initialize_component_io (component_name)

! test that var_dims is present if nvar_dims > 0
      if(nvar_dims > 0 .and. .not.present(var_dims)) then
         print *,'I/O warning for file ',trim(current%open_filename),    &
                 ' in component ',component_name
         print *,'argument var_dims missing for variable' ,var_name,     &
                 ' with nvar_dims > 0'
         call abort_code('error in pack_header')
      endif

! point to the element of the io data type for this component
      current => get_component_pointer_io(component_name)

! Allocate a header
! if header is already allocated, copy to tem_header, deallocate,
!   then reallocate larger
      if(current%nvar /= 0) then
         allocate(tem_header(current%nvar))
         tem_header = current%header
         deallocate(current%header)
      endif

      current%nvar = current%nvar + 1
      allocate (current%header(current%nvar))
      if(current%nvar > 1) then
         current%header(1:current%nvar-1) = tem_header(1:current%nvar-1)
         deallocate(tem_header)
      endif

! assign argument list to proper place in header
      do n = 1,head_clen
         current%header(current%nvar)%short_name(n:n) = ' '
      enddo
      current%header(current%nvar)%short_name = trim(var_name)
      current%header(current%nvar)%nvar_dims = nvar_dims
      len = 1
      current%header(current%nvar)%var_dims(1) = -99
      do n = 1,nvar_dims
         current%header(current%nvar)%var_dims(n) = var_dims(n)
         len = len * var_dims(n)
      enddo
      current%header(current%nvar)%start_index = current%s_index
      current%s_index = current%s_index + len   ! index for next variable

! end of routine
      end subroutine pack_header
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 



!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 
      subroutine open_write_header(component_name, file_name, ncells_out,  &
                    restart_out,  real_bytes_out )
!-------------------------------------------------------------------------------
!
! Purpose: This subroutine opens a direct access file for write access.
!          It uses a flag to distinguish restart and other file types.
!          This routine also writes the header records that have been packed by
!          pack_header calls.
!    USED FOR OUTPUT
!
! Author: Don Dazlich, Department of Atmospheric Science, CSU
!
! History: 15 Apr 2002 - created this routine
!          16 May 2003 - added linux=0 preprocessor 
!                        directive for single process output
!
      implicit none

! Argument list

      character (*), intent(in) ::                                     &
         component_name  ! component model name
      character (*), intent(in) ::                                     &
         file_name         ! input file name
      integer (kind=int_kind), intent(in) ::                           &
         ncells_out     ! model number of cells
      integer (kind=int_kind), intent(in) ::                           &
         real_bytes_out ! output data precision
      logical (kind=log_kind), intent(in) ::                           &
         restart_out      ! if true, this is a restart file

! local variables
      TYPE (io_util_type),POINTER ::                                   &
         current
      integer (kind=int_kind) :: n       ! loop index
      integer (kind=int_kind) :: ioerr   ! io error code
      integer (kind=int_kind) :: my_task ! local process id
      integer (kind=int_kind) :: my_communicator ! local component communicator

! point to the element of the io data type for this component
      current => get_component_pointer_io(component_name)
      do n = 1,char_len
         current%open_filename(n:n) = ' '
      enddo

! put the arglist variables into the io structure for this component
      current%open_filename = trim(file_name)
      current%nhead = current%nvar + 2
      if (restart_out) current%nhead = current%nhead + 1
      current%ncells = ncells_out
      current%restart_file = restart_out
      current%real_bytes = real_bytes_out
      current%lrecl = (current%s_index - 1) * current%real_bytes   ! size of
                                                                   ! data record

! make sure record length is at least as long as the header record
      current%lrecl = max(current%lrecl, (2+max_var_dims)*int_kind+head_clen ) 

! open file and write header

#if mpi == 1 && parallel_io == 0
      my_task = get_my_task(component_name)
      my_communicator = get_my_communicator(component_name)
      if(my_task == 0) then
#endif
      open(unit=current%lunit,        &
           file=trim(file_name),      &
           form='unformatted',        &
           access='DIRECT',           &
           recl=current%lrecl,        &
           status='REPLACE',          &
           action='WRITE',            &
           iostat=ioerr )

      write(current%lunit,rec=1)current%nhead, current%lrecl
      write(current%lunit,rec=2)current%nvar, current%real_bytes,          &
                                current%ncells, current%restart_file
      do n = 1,current%nvar
         write(current%lunit, rec=2+n)current%header(n)%short_name,       &
                                      current%header(n)%nvar_dims,        &
                                      current%header(n)%var_dims,         &
                                      current%header(n)%start_index
      enddo
#if mpi == 1 && parallel_io == 0
      endif
      CALL MPI_BARRIER (my_communicator,ierr)
#endif

! set flag signifying file is open
      current%l_open_file = .true.

! allocate buffer array storing all data for one grid cell

      if(current%real_bytes == 4) then
         allocate(current%xrec4(current%lrecl/current%real_bytes))
      elseif(current%real_bytes == 8) then
         allocate(current%xrec8(current%lrecl/current%real_bytes))
      else
         print *,'I/O warning for file ',trim(current%open_filename),         &
                 ' in component ',component_name
         print *,'real_bytes = ',current%real_bytes,' : not a valid value'
         call abort_code('error in open_write_header')
      endif

! end of routine
      end subroutine open_write_header
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 



!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 
      subroutine read_time_stamp(component_name, time_stamp)
!-------------------------------------------------------------------------------
!
! Purpose: This subroutine reads the time stamp record of a restart file
!     USED FOR INPUT
!
! Author: Don Dazlich, Department of Atmospheric Science, CSU
!
! History: 15 Apr 2002 - created this routine
!
      implicit none

! Argument list declarations
      character (*), intent(in) ::                               &
         component_name  ! component model name
      integer (kind=int_dbl_kind), intent(out) ::                &
         time_stamp

      TYPE (io_util_type),POINTER ::                             &
         current

! point to the element of the io data type for this component
      current => get_component_pointer_io(component_name)
      if(current%restart_file) then
         read(current%lunit,rec=current%nhead)time_stamp
      else
         print *,'I/O warning for file ',trim(current%open_filename),          &
                 ' in component ',component_name
         print *,'This is not a restart file - cannot read time stamp'
      endif

! end of routine
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 
      end subroutine read_time_stamp



!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 
      subroutine write_time_stamp(component_name, time_stamp)
!-------------------------------------------------------------------------------
!
! Purpose: This subroutine writes the time stamp record of a restart file
!      USED FOR OUTPUT
!
! Author: Don Dazlich, Department of Atmospheric Science, CSU
!
! History: 15 Apr 2002 - created this routine
!          16 May 2003 - added linux=0 preprocessor 
!                        directive for single process output
!
      implicit none

! Argument list declarations
      character (*), intent(in) :: component_name  ! component model name
      integer (kind=int_dbl_kind), intent(in) :: time_stamp
      
! local variables
      TYPE (io_util_type),POINTER ::                                            &
         current
      integer (kind=int_kind) :: my_task


! point to the element of the io data type for this component
      current => get_component_pointer_io(component_name)
      if(current%restart_file) then
#if mpi == 1 && parallel_io == 0
         my_task = get_my_task(component_name)
         if(my_task == 0) write(current%lunit,rec=current%nhead)time_stamp
#else
         write(current%lunit,rec=current%nhead)time_stamp
#endif
      else
         print *,'I/O warning for file ',trim(current%open_filename),          &
                 ' in component ',component_name
         print *,'This is not a restart file - cannot write time stamp'
      endif

! end of routine
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 
      end subroutine write_time_stamp



!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 
      subroutine read_record(component_name, npt)
!-------------------------------------------------------------------------------
!
! Purpose: This subroutine reads one record of data from the direct access
!          input file into the buffer array of appropriate type.
!
! Author: Don Dazlich, Department of Atmospheric Science, CSU
!
! History: 04 Apr 2002 - created this routine
!
      implicit none

! Argument list declarations

      character (*), intent(in) :: component_name  ! component model name
      integer (kind=int_kind), intent(in) :: npt ! location in geodesic grid vector

      TYPE (io_util_type),POINTER ::                                 &
         current

      if(npt /= 0) then

! point to the element of the io data type for this component
         current => get_component_pointer_io(component_name)
         if ( current%real_bytes == 4 ) then
            read( current%lunit, rec=npt+current%nhead)current%xrec4
         else if ( current%real_bytes == 8 ) then
            read( current%lunit, rec=npt+current%nhead)current%xrec8
         endif
      endif

! end of routine
      end subroutine read_record
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 


!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 
      subroutine write_record(component_name, mask, npt)
!-------------------------------------------------------------------------------
!
! Purpose: This subroutine writes one record of data into the direct access
!          input file from the buffer array of appropriate type.
!
! Author: Don Dazlich, Department of Atmospheric Science, CSU
!
! History: 04 Apr 2002 - created this routine
!
      implicit none

! Argument list declarations

      character (*), intent(in) ::                               &
          component_name  ! component model name
      integer (kind=int_kind), intent(in) ::                     &
          npt             ! grid cell location in geodesic grid vector
      real (kind=dbl_kind), intent(in) ::                        &
          mask            ! mask for ghost cells (0 if ghost cell)

      TYPE (io_util_type),POINTER ::                             &
         current
      integer (kind=int_kind) ::                                       &
         mask_npt              ! product of mask and npt

#if mpi == 1 && parallel_io == 0

! for single process output on multiprocessor environments;
!   process zero gathers the data from all processes and does all output
      integer (kind=int_kind) ::                                       &
         task,            & ! task loop index
         lenx               ! length of xrec
      integer (kind=int_kind) ::                                       &
         npe,                & ! number of processes in component
         my_task,            & ! local process id
         my_communicator       ! component communicator id

! message passing receive buffers
      integer (kind=int_kind), allocatable, dimension(:) :: nptr
      real (kind=dbl_kind), allocatable, dimension(:,:) :: buffer8
      real (kind=real_kind), allocatable, dimension(:,:) :: buffer4
      integer (kind=int_kind) :: send_req(2), send_status(mpi_status_size,2)
      integer (kind=int_kind), allocatable :: recv_req(:), recv_status(:,:)
         
! point to the element of the io data type for this component
      current => get_component_pointer_io(component_name)

! get the message passing environment
      my_task = get_my_task(component_name)
      my_communicator = get_my_communicator(component_name)
      npe = get_my_npe(component_name)

! word length of data record
      lenx = current%lrecl / current%real_bytes

      mask_npt = mask * npt

      allocate(nptr(npe))
      allocate(recv_req(2*(npe-1)))
      allocate(recv_status(mpi_status_size, 2*(npe-1) ))
      if(current%real_bytes == 4) allocate(buffer4(lenx,npe))
      if(current%real_bytes == 8) allocate(buffer8(lenx,npe))

! process 0 receives data from other processes, plus writes out its own
      if(my_task == 0) then

! process 0 writing its own data
         if (mask_npt /= 0) then
            if ( current%real_bytes == 4 ) then
               write( current%lunit, rec=npt+current%nhead)current%xrec4
            else if ( current%real_bytes == 8 ) then
               write( current%lunit, rec=npt+current%nhead)current%xrec8
            endif
         endif

! receive data from processes 1 through npe -1
         do task = 1,npe-1

! receive nptr - the grid cell index
            call mpi_irecv(nptr(task), 1, MPI_INTEGER,                     &
                          task, 0, my_communicator,                       &
                          recv_req(1+2*(task-1)), ierr)

! receive the appropriate data record
            if ( current%real_bytes == 4 ) then
               call mpi_irecv(buffer4(1,task), lenx, MPI_REAL,             &
                             task, 1, my_communicator,                     &
                          recv_req(2+2*(task-1)), ierr)
            else if ( current%real_bytes == 8 ) then
               call mpi_irecv(buffer8(1,task), lenx, MPI_DOUBLE_PRECISION, &
                             task, 1, my_communicator,                     &
                          recv_req(2+2*(task-1)), ierr)
            endif
         enddo
         CALL MPI_WAITALL (2*(npe-1),recv_req,recv_status,ierr)


! write the data gathered from each process if the grid cell index is not zero
         do task = 1,npe-1
            if(nptr(task) /= 0) then
               if ( current%real_bytes == 4 ) then
                  write( current%lunit, rec=nptr(task)+current%nhead)        &
                                                          buffer4(:,task)
               else if ( current%real_bytes == 8 ) then
                  write( current%lunit, rec=nptr(task)+current%nhead)        &
                                                          buffer8(:,task)
               endif
            endif
         enddo

      else

! we are not on process zero, we will send data there
! send npt
         call mpi_isend(mask_npt, 1, MPI_INTEGER,                       &
                       0, 0, my_communicator, send_req(1), ierr)

! send data
         if ( current%real_bytes == 4 ) then
            call mpi_isend(current%xrec4, lenx, MPI_REAL,               &
                          0, 1, my_communicator, send_req(2),  ierr)
         else if ( current%real_bytes == 8 ) then
            call mpi_isend(current%xrec8, lenx, MPI_DOUBLE_PRECISION,   &
                          0, 1, my_communicator, send_req(2), ierr)
         endif
         CALL MPI_WAITALL (2,send_req,send_status,ierr)
      endif    ! if(my_task == 0)
! end task dependent code

! synchronize before going to the next point
      CALL MPI_BARRIER (my_communicator,ierr)

      deallocate(nptr)
      deallocate(recv_req)
      deallocate(recv_status)
      if(current%real_bytes == 4) deallocate(buffer4)
      if(current%real_bytes == 8) deallocate(buffer8)
#else

! this is the typical case when each process can write its own data
      mask_npt = mask * npt
      if (mask_npt /= 0) then
         current => get_component_pointer_io(component_name)
         if ( current%real_bytes == 4 ) then
            write( current%lunit, rec=npt+current%nhead)current%xrec4
         else if ( current%real_bytes == 8 ) then
            write( current%lunit, rec=npt+current%nhead)current%xrec8
         endif
      endif
#endif

! end of routine
      end subroutine write_record
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 


!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 
      subroutine pack_data_record_scalar(component_name, x_char, x0)
!-------------------------------------------------------------------------------
!
! Purpose: This subroutine packs the data from one variable at one grid cell
!          into the buffer array of appropriate type.
!     USED FOR OUTPUT
!
! Author: Don Dazlich, Department of Atmospheric Science, CSU
!
! History: 04 Jun 2003 - created this routine
!
      implicit none

! Argument list declarations
      character (*), intent(in) ::                                  &
         component_name  ! component model name
      real (kind=dbl_kind), intent(in) ::                           &
         x0 ! variable to pack in buffer
      character(*), intent(in) ::                                   &
         x_char           ! variable short name

! local variables
      TYPE (io_util_type),POINTER ::                                &
         current
      integer (kind=int_kind) ::                                    &
         n, icount   ! loop indices
      logical (kind=log_kind) ::                                    &
         found_var       ! true if variable is found in header

! point to the element of the io data type for this component
      current => get_component_pointer_io(component_name)


! test for variable in header
      found_var = .false.
      var_search : do n = 1,current%nvar

! test for number of dimensions
         if(trim(x_char) == trim( current%header(n)%short_name ) ) then
            found_var = .true.
            if( current%header(n)%nvar_dims == 0 ) then

! copy argument x0 into buffer
               icount = current%header(n)%start_index
               if ( current%real_bytes == 4 ) then
                  current%xrec4(icount) = x0
               else if ( current%real_bytes == 8 ) then
                  current%xrec8(icount) = x0
               endif
               exit var_search
            else

! wrong number of dimensions for this variable
               print *,'I/O warning for file ',trim(current%open_filename),   &
                       ' in component ',component_name
               print *,'variable ',x_char,                                    &
                       ' is not a scalar variable at one grid cell'
               call abort_code('error in pack_data_record_scalar')
            endif
         endif
      enddo var_search

      if(.not.found_var) then

! variable doesn't exist
         print *,'I/O warning for file ',trim(current%open_filename),       &
                 ' in component ',component_name
         print *,'pack_data_record_scalar - variable ',x_char,' does not exist'
         call abort_code('error in pack_data_record_scalar')
      endif

! end of routine
      end subroutine pack_data_record_scalar
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 



!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 
      subroutine pack_data_record_1d(component_name, x_char, x1)
!-------------------------------------------------------------------------------
!
! Purpose: This subroutine packs the data from one variable at one grid cell
!          into the buffer array of appropriate type.
!     USED FOR OUTPUT
!
! Author: Don Dazlich, Department of Atmospheric Science, CSU
!
! History: 08 Apr 2002 - created this routine
!
      implicit none

! Argument list declarations
      character (*), intent(in) ::                                  &
         component_name  ! component model name
      real (kind=dbl_kind), intent(in), dimension(:) ::             &
         x1 ! variable to pack in buffer
      character(*), intent(in) ::                                   &
         x_char           ! variable short name

! local variables
      TYPE (io_util_type),POINTER ::                                &
         current
      integer (kind=int_kind) ::                                    &
         n, i1, icount   ! loop indices
      logical (kind=log_kind) ::                                    &
         found_var       ! true if variable is found in header

! point to the element of the io data type for this component
      current => get_component_pointer_io(component_name)


! test for variable in header
      found_var = .false.
      var_search : do n = 1,current%nvar

! test for number of dimensions
         if(trim(x_char) == trim( current%header(n)%short_name ) ) then
            found_var = .true.
            if( current%header(n)%nvar_dims == 1 ) then

! copy argument x1 into buffer
               icount = current%header(n)%start_index - 1
               if ( current%real_bytes == 4 ) then
                  do i1 = 1, current%header(n)%var_dims(1)
                     icount = icount + 1
                     current%xrec4(icount) = x1(i1)
                  enddo
               else if ( current%real_bytes == 8 ) then
                  do i1 = 1, current%header(n)%var_dims(1)
                     icount = icount + 1
                     current%xrec8(icount) = x1(i1)
                  enddo
               endif
               exit var_search
            else

! wrong number of dimensions for this variable
               print *,'I/O warning for file ',trim(current%open_filename),   &
                       ' in component ',component_name
               print *,'variable ',x_char,                                    &
                       ' is not a 1-d variable at one grid cell'
               call abort_code('error in pack_data_record_1d')
            endif
         endif
      enddo var_search

      if(.not.found_var) then

! variable doesn't exist
         print *,'I/O warning for file ',trim(current%open_filename),       &
                 ' in component ',component_name
         print *,'pack_data_record_1d - variable ',x_char,' does not exist'
         call abort_code('error in pack_data_record_1d')
      endif

! end of routine
      end subroutine pack_data_record_1d
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 



!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 
      subroutine pack_data_record_2d(component_name, x_char, x2)
!-------------------------------------------------------------------------------
!
! Purpose: This subroutine packs the data from one variable at one grid cell 
!          into the buffer array of appropriate type.
!     USED FOR OUTPUT
!
! Author: Don Dazlich, Department of Atmospheric Science, CSU
!
! History: 08 Apr 2002 - created this routine
!
      implicit none

! Argument list declarations
      character (*), intent(in) ::                               &
         component_name  ! component model name
      real (kind=dbl_kind), intent(in), dimension(:,:) ::        &
         x2 ! variable to pack in buffer
      character(*), intent(in) ::                                &
         x_char             ! variable short name

! local variables
      TYPE (io_util_type),POINTER ::                             &
         current
      integer (kind=int_kind) ::                                 &
         n, i1, i2, icount   ! loop indices
      logical (kind=log_kind) ::                                 &
         found_var       ! true if variable is found in header

! point to the element of the io data type for this component
      current => get_component_pointer_io(component_name)


! test for variable in header
      found_var = .false.
      var_search : do n = 1,current%nvar

! test for number of dimensions
         if(trim(x_char) == trim( current%header(n)%short_name ) ) then
            found_var = .true.
            if( current%header(n)%nvar_dims == 2 ) then

! copy argument x2 into buffer
               icount = current%header(n)%start_index - 1
               if ( current%real_bytes == 4 ) then
                  do i2 = 1, current%header(n)%var_dims(2)
                     do i1 = 1, current%header(n)%var_dims(1)
                        icount = icount + 1
                        current%xrec4(icount) = x2(i1,i2)
                     enddo
                  enddo
               else if ( current%real_bytes == 8 ) then
                  do i2 = 1, current%header(n)%var_dims(2)
                     do i1 = 1, current%header(n)%var_dims(1)
                        icount = icount + 1
                        current%xrec8(icount) = x2(i1,i2)
                     enddo
                  enddo
               endif
               exit var_search
            else

! wrong number of dimensions for this variable
               print *,'I/O warning for file ',trim(current%open_filename),   &
                       ' in component ',component_name
               print *,'variable ',x_char,                                    &
                       ' is not a 2-d variable at one grid cell'
               call abort_code('error in pack_data_record_2d')
            endif
         endif
      enddo var_search

      if(.not.found_var) then

! variable doesn't exist
         print *,'I/O warning for file ',trim(current%open_filename),         &
                 ' in component ',component_name
         print *,'pack_data_record_2d - variable ',x_char,' does not exist'
         call abort_code('error in pack_data_record_2d')
      endif

! end of routine
      end subroutine pack_data_record_2d
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 



!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 
      subroutine pack_data_record_3d(component_name, x_char, x3)
!-------------------------------------------------------------------------------
!
! Purpose: This subroutine packs the data from one variable at one grid cell 
!          into the buffer array of appropriate type.
!     USED FOR OUTPUT
!
! Author: Don Dazlich, Department of Atmospheric Science, CSU
!
! History: 15 May 2003 - created this routine
!
      implicit none

! Argument list declarations
      character (*), intent(in) ::                                &
         component_name  ! component model name
      real (kind=dbl_kind), intent(in), dimension(:,:,:) ::       &
         x3 ! variable to pack in buffer
      character(*), intent(in) ::                                 &
         x_char             ! variable short name

! local variables
      TYPE (io_util_type),POINTER ::                              &
         current
      integer (kind=int_kind) ::                                  &
         n, i1, i2, i3, icount   ! loop indices
      logical (kind=log_kind) ::                                  &
         found_var       ! true if variable is found in header

! point to the element of the io data type for this component
      current => get_component_pointer_io(component_name)


! test for variable in header
      found_var = .false.
      var_search : do n = 1,current%nvar

! test for number of dimensions
         if(trim(x_char) == trim( current%header(n)%short_name ) ) then
            found_var = .true.
            if( current%header(n)%nvar_dims == 3 ) then

! copy argument x3 into buffer
               icount = current%header(n)%start_index - 1
               if ( current%real_bytes == 4 ) then
                  do i3 = 1, current%header(n)%var_dims(3)
                     do i2 = 1, current%header(n)%var_dims(2)
                        do i1 = 1, current%header(n)%var_dims(1)
                           icount = icount + 1
                           current%xrec4(icount) = x3(i1,i2,i3)
                        enddo
                     enddo
                  enddo
               else if ( current%real_bytes == 8 ) then
                  do i3 = 1, current%header(n)%var_dims(3)
                     do i2 = 1, current%header(n)%var_dims(2)
                        do i1 = 1, current%header(n)%var_dims(1)
                           icount = icount + 1
                           current%xrec8(icount) = x3(i1,i2,i3)
                        enddo
                     enddo
                  enddo
               endif
               exit var_search
            else

! wrong number of dimensions for this variable
               print *,'I/O warning for file ',trim(current%open_filename),  &
                       ' in component ',component_name
               print *,'variable ',x_char,                                   &
                       ' is not a 3-d variable at one grid cell'
               call abort_code('error in pack_data_record_3d')
            endif
         endif
      enddo var_search

      if(.not.found_var) then

! variable doesn't exist
         print *,'I/O warning for file ',trim(current%open_filename),          &
                 ' in component ',component_name
         print *,'pack_data_record_3d - variable ',x_char,' does not exist'
         call abort_code('error in pack_data_record_3d')
      endif

! end of routine
      end subroutine pack_data_record_3d
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 



!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 
      subroutine pack_data_record_4d(component_name, x_char, x4)
!-------------------------------------------------------------------------------
!
! Purpose: This subroutine packs the data from one variable at one grid cell 
!          into the buffer array of appropriate type.
!     USED FOR OUTPUT
!
! Author: Don Dazlich, Department of Atmospheric Science, CSU
!
! History: 15 May 2003 - created this routine
!
      implicit none

! Argument list declarations
      character (*), intent(in) ::                                &
         component_name  ! component model name
      real (kind=dbl_kind), intent(in), dimension(:,:,:,:) ::     &
         x4 ! variable to pack in buffer
      character(*), intent(in) ::                                 &
         x_char             ! variable short name

! local variables
      TYPE (io_util_type),POINTER ::                              &
         current
      integer (kind=int_kind) ::                                  &
         n, i1, i2, i3, i4, icount   ! loop indices
      logical (kind=log_kind) ::                                  &
         found_var       ! true if variable is found in header

! point to the element of the io data type for this component
      current => get_component_pointer_io(component_name)

! test for variable in header
      found_var = .false.
      var_search : do n = 1,current%nvar

! test for number of dimensions
         if(trim(x_char) == trim( current%header(n)%short_name ) ) then
            found_var = .true.
            if( current%header(n)%nvar_dims == 4 ) then

! copy argument x4 into buffer
               icount = current%header(n)%start_index - 1
               if ( current%real_bytes == 4 ) then
                  do i4 = 1, current%header(n)%var_dims(4)
                     do i3 = 1,current% header(n)%var_dims(3)
                        do i2 = 1, current%header(n)%var_dims(2)
                           do i1 = 1, current%header(n)%var_dims(1)
                              icount = icount + 1
                              current%xrec4(icount) = x4(i1,i2,i3,i4)
                           enddo
                        enddo
                     enddo
                  enddo
               else if ( current%real_bytes == 8 ) then
                  do i4 = 1, current%header(n)%var_dims(4)
                     do i3 = 1, current%header(n)%var_dims(3)
                        do i2 = 1, current%header(n)%var_dims(2)
                           do i1 = 1, current%header(n)%var_dims(1)
                              icount = icount + 1
                              current%xrec8(icount) = x4(i1,i2,i3,i4)
                           enddo
                        enddo
                     enddo
                  enddo
               endif
               exit var_search
            else

! wrong number of dimensions for this variable
               print *,'I/O warning for file ',trim(current%open_filename), &
                       ' in component ',component_name
               print *,'variable ',x_char,                                  &
                       ' is not a 4-d variable at one grid cell'
               call abort_code('error in pack_data_record_4d')
            endif
         endif
      enddo var_search

      if(.not.found_var) then

! variable doesn't exist
         print *,'I/O warning for file ',trim(current%open_filename),         &
                 ' in component ',component_name
         print *,'pack_data_record_4d - variable ',x_char,' does not exist'
         call abort_code('error in pack_data_record_4d')
      endif

! end of routine
      end subroutine pack_data_record_4d
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 



!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 
      subroutine unpack_data_record_scalar(component_name,                  &
                                       x_char, x0, fill_switch, fill_const)
!-------------------------------------------------------------------------------
!
! Purpose: This subroutine unpacks the data from the buffer array and fills a 
!          1-d variable for one grid cell.
!     USED FOR INPUT
!
! Author: Don Dazlich, Department of Atmospheric Science, CSU
!
! History: 04 Jun 2003 - created this routine
!
      implicit none

! Argument list declarations
      character (*), intent(in) ::                                   &
         component_name  ! component model name
      real (kind=dbl_kind), intent(out) ::                           &
         x0 ! variable to pack in buffer
      character(*), intent(in) ::                                    &
         x_char            ! variable short name

! Additional optional arguments
      logical (kind=log_kind), optional, intent(in) ::               &
         fill_switch  ! if true, use fill_const for a variable not 
                      ! present in input data
      real (kind=dbl_kind), optional, intent(in) ::                  &
         fill_const   ! if fill_switch true, fill missing data with this value

! local variables
      TYPE (io_util_type),POINTER ::                                 &
         current
      integer (kind=int_kind) ::                                     &
         n, icount   ! loop indices
      logical (kind=log_kind) ::                                     &
         found_var       ! true if variable is found in header

! point to the element of the io data type for this component
      current => get_component_pointer_io(component_name)

! test for variable in header
      found_var = .false.
      var_search : do n = 1,current%nvar

! test for number of dimensions

         if(trim(x_char) == trim( current%header(n)%short_name ) ) then
            found_var = .true.
            if( current%header(n)%nvar_dims == 0 ) then

! copy from buffer
               icount = current%header(n)%start_index
               if ( current%real_bytes == 4 ) then
                  x0 = current%xrec4(icount)
               else if ( current%real_bytes == 8 ) then
                  x0 = current%xrec8(icount)
               endif
               exit var_search
            else

! wrong number of dimensions for this variable
               print *,'I/O warning for file ',trim(current%open_filename),   &
                       ' in component ',component_name
               print *,'variable ',x_char,                                    &
                       ' is not a scalar variable at one grid cell'
               call abort_code('error in unpack_data_record_1d')
            endif
         else if(present(fill_switch) .and. present(fill_const) ) then

            if(fill_switch) then

! variable missing, but initialize with constant
               x0 = fill_const 
               exit var_search              

            else

! don't fill variable - abort
               print *,'I/O warning for file ',trim(current%open_filename), &
                       ' in component ',component_name
               print *,'unpack_data_record_scalar - variable ',x_char,      &
                       ' does not exist'
               call abort_code('error in unpack_data_record_scalar')
            endif

         endif
      enddo var_search

      if(.not.found_var) then

! variable doesn't exist
         print *,'I/O warning for file ',trim(current%open_filename),        &
                 ' in component ',component_name
         print *,'unpack_data_record_scalar - variable ',x_char,             &
                 ' does not exist'
         call abort_code('error in unpack_data_record_scalar')
      endif

! end of routine
      end subroutine unpack_data_record_scalar
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 



!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 
      subroutine unpack_data_record_1d(component_name,                      &
                                       x_char, x1, fill_switch, fill_const)
!-------------------------------------------------------------------------------
!
! Purpose: This subroutine unpacks the data from the buffer array and fills a 
!          1-d variable for one grid cell.
!     USED FOR INPUT
!
! Author: Don Dazlich, Department of Atmospheric Science, CSU
!
! History: 09 Apr 2002 - created this routine
!
      implicit none

! Argument list declarations
      character (*), intent(in) ::                                   &
         component_name  ! component model name
      real (kind=dbl_kind), intent(out), dimension(:) ::             &
         x1 ! variable to pack in buffer
      character(*), intent(in) ::                                    &
         x_char            ! variable short name

! Additional optional arguments
      logical (kind=log_kind), optional, intent(in) ::               &
         fill_switch  ! if true, use fill_const for a variable not 
                      ! present in input data
      real (kind=dbl_kind), optional, intent(in) ::                  &
         fill_const   ! if fill_switch true, fill missing data with this value

! local variables
      TYPE (io_util_type),POINTER ::                                 &
         current
      integer (kind=int_kind) ::                                     &
         n, i1, icount   ! loop indices
      logical (kind=log_kind) ::                                     &
         found_var       ! true if variable is found in header

! point to the element of the io data type for this component
      current => get_component_pointer_io(component_name)

! test for variable in header
      found_var = .false.
      var_search : do n = 1,current%nvar

! test for number of dimensions

         if(trim(x_char) == trim( current%header(n)%short_name ) ) then
            found_var = .true.
            if( current%header(n)%nvar_dims == 1 ) then

! copy from buffer
               icount = current%header(n)%start_index - 1
               if ( current%real_bytes == 4 ) then
                  do i1 = 1, current%header(n)%var_dims(1)
                     icount = icount + 1
                     x1(i1) = current%xrec4(icount)
                  enddo
               else if ( current%real_bytes == 8 ) then
                  do i1 = 1, current%header(n)%var_dims(1)
                     icount = icount + 1
                     x1(i1) = current%xrec8(icount)
                  enddo
               endif
               exit var_search
            else

! wrong number of dimensions for this variable
               print *,'I/O warning for file ',trim(current%open_filename),   &
                       ' in component ',component_name
               print *,'variable ',x_char,                                    &
                       ' is not a 1-d variable at one grid cell'
               call abort_code('error in unpack_data_record_1d')
            endif
         else if(present(fill_switch) .and. present(fill_const) ) then

            if(fill_switch) then

! variable missing, but initialize with constant
               x1(1:current%header(n)%var_dims(1)) = fill_const 
               exit var_search              

            else

! don't fill variable - abort
               print *,'I/O warning for file ',trim(current%open_filename), &
                       ' in component ',component_name
               print *,'unpack_data_record_1d - variable ',x_char,          &
                       ' does not exist'
               call abort_code('error in unpack_data_record_1d')
            endif

         endif
      enddo var_search

      if(.not.found_var) then

! variable doesn't exist
         print *,'I/O warning for file ',trim(current%open_filename),        &
                 ' in component ',component_name
         print *,'unpack_data_record_1d - variable ',x_char,' does not exist'
         call abort_code('error in unpack_data_record_1d')
      endif

! end of routine
      end subroutine unpack_data_record_1d
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 



!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 
      subroutine unpack_data_record_2d(component_name,                        &
                                       x_char, x2, fill_switch, fill_const)
!-------------------------------------------------------------------------------
!
! Purpose: This subroutine unpacks the data from the buffer array and fills a 
!          2-d variable for one grid cell.
!     USED FOR INPUT
!
! Author: Don Dazlich, Department of Atmospheric Science, CSU
!
! History: 09 Apr 2002 - created this routine
!
      implicit none

! Argument list declarations
      character (*), intent(in) ::                                   &
         component_name  ! component model name
      real (kind=dbl_kind), intent(out), dimension(:,:) ::           &
         x2 ! variable to pack in buffer
      character(*), intent(in) ::                                    &
         x_char            ! variable short name

! Additional optional arguments
      logical (kind=log_kind), optional, intent(in) ::               &
         fill_switch  ! if true, use fill_const for a variable not 
                      ! present in input data
      real (kind=dbl_kind), optional, intent(in) ::                  &
         fill_const   ! if fill_switch true, fill missing data with this value

! local variables
      TYPE (io_util_type),POINTER ::                                 &
         current
      integer (kind=int_kind) ::                                     &
         n, i1, i2, icount   ! loop indices
      logical (kind=log_kind) ::                                     &
         found_var       ! true if variable is found in header

! point to the element of the io data type for this component
      current => get_component_pointer_io(component_name)

! test for variable in header
      found_var = .false.
      var_search : do n = 1,current%nvar

! test for number of dimensions

         if(trim(x_char) == trim( current%header(n)%short_name ) ) then
            found_var = .true.
            if( current%header(n)%nvar_dims == 2 ) then

! copy from buffer
               icount = current%header(n)%start_index - 1
               if ( current%real_bytes == 4 ) then
                  do i2 = 1, current%header(n)%var_dims(2)
                     do i1 = 1, current%header(n)%var_dims(1)
                        icount = icount + 1
                        x2(i1,i2) = current%xrec4(icount)
                     enddo
                  enddo
               else if ( current%real_bytes == 8 ) then
                  do i2 = 1, current%header(n)%var_dims(2)
                     do i1 = 1, current%header(n)%var_dims(1)
                        icount = icount + 1
                        x2(i1,i2) = current%xrec8(icount)
                     enddo
                  enddo
               endif
               exit var_search
            else

! wrong number of dimensions for this variable
               print *,'I/O warning for file ',trim(current%open_filename),  &
                       ' in component ',component_name
               print *,'variable ',x_char,                                   &
                       ' is not a 2-d variable at one grid cell'
               call abort_code('error in unpack_data_record_2d')
            endif
         else if(present(fill_switch) .and. present(fill_const) ) then

            if(fill_switch) then

! variable missing, but initialize with constant
               x2(1:current%header(n)%var_dims(1),    &
                  1:current%header(n)%var_dims(2)) =   fill_const               
               exit var_search

            else

! don't fill variable - abort
               print *,'I/O warning for file ',trim(current%open_filename),  &
                       ' in component ',component_name
               print *,'unpack_data_record_2d - variable ',x_char,           &
                       ' does not exist'
               call abort_code('error in unpack_data_record_2d')
            endif

         endif
      enddo var_search

      if(.not.found_var) then

! variable doesn't exist
         print *,'I/O warning for file ',trim(current%open_filename),        &
                 ' in component ',component_name
         print *,'unpack_data_record_2d - variable ',x_char,' does not exist'
         call abort_code('error in unpack_data_record_2d')
      endif

! end of routine
      end subroutine unpack_data_record_2d
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 



!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 
      subroutine unpack_data_record_3d(component_name,                        &
                                       x_char, x3, fill_switch, fill_const)
!-------------------------------------------------------------------------------
!
! Purpose: This subroutine unpacks the data from the buffer array and fills a 
!          3-d variable for one grid cell.
!     USED FOR INPUT
!
! Author: Don Dazlich, Department of Atmospheric Science, CSU
!
! History: 15 May 2003 - created this routine
!
      implicit none

! Argument list declarations
      character (*), intent(in) ::                                   &
         component_name  ! component model name
      real (kind=dbl_kind), intent(out), dimension(:,:,:) ::         &
         x3 ! variable to pack in buffer
      character(*), intent(in) ::                                    &
         x_char            ! variable short name

! Additional optional arguments
      logical (kind=log_kind), optional, intent(in) ::               &
         fill_switch  ! if true, use fill_const for a variable not 
                      ! present in input data
      real (kind=dbl_kind), optional, intent(in) ::                  &
         fill_const   ! if fill_switch true, fill missing data with this value

! local variables
      TYPE (io_util_type),POINTER ::                                 &
         current
      integer (kind=int_kind) ::                                     &
         n, i1, i2, i3, icount   ! loop indices
      logical (kind=log_kind) ::                                     &
         found_var       ! true if variable is found in header

! point to the element of the io data type for this component
      current => get_component_pointer_io(component_name)

! test for variable in header
      found_var = .false.
      var_search : do n = 1,current%nvar

! test for number of dimensions

         if(trim(x_char) == trim( current%header(n)%short_name ) ) then
            found_var = .true.
            if( current%header(n)%nvar_dims == 3 ) then

! copy from buffer
               icount = current%header(n)%start_index - 1
               if ( current%real_bytes == 4 ) then
                  do i3 = 1, current%header(n)%var_dims(3)
                     do i2 = 1, current%header(n)%var_dims(2)
                        do i1 = 1, current%header(n)%var_dims(1)
                           icount = icount + 1
                           x3(i1,i2,i3) = current%xrec4(icount)
                        enddo
                     enddo
                  enddo
               else if ( current%real_bytes == 8 ) then
                  do i3 = 1, current%header(n)%var_dims(3)
                     do i2 = 1, current%header(n)%var_dims(2)
                        do i1 = 1, current%header(n)%var_dims(1)
                           icount = icount + 1
                           x3(i1,i2,i3) = current%xrec8(icount)
                        enddo
                     enddo
                  enddo
               endif
               exit var_search
            else

! wrong number of dimensions for this variable
               print *,'I/O warning for file ',trim(current%open_filename),   &
                       ' in component ',component_name
               print *,'variable ',x_char,                                    &
                       ' is not a 3-d variable at one grid cell'
               call abort_code('error in unpack_data_record_3d')
            endif
         else if(present(fill_switch) .and. present(fill_const) ) then

            if(fill_switch) then

! variable missing, but initialize with constant
               x3(1:current%header(n)%var_dims(1),                    &
                  1:current%header(n)%var_dims(2),                    &
                  1:current%header(n)%var_dims(3)) = fill_const               
               exit var_search

            else

! don't fill variable - abort
               print *,'I/O warning for file ',trim(current%open_filename),   &
                       ' in component ',component_name
               print *,'unpack_data_record_3d - variable ',x_char,            &
                       ' does not exist'
               call abort_code('error in unpack_data_record_3d')
            endif

         endif
      enddo var_search

      if(.not.found_var) then

! variable doesn't exist
         print *,'I/O warning for file ',trim(current%open_filename),         &
                 ' in component ',component_name
         print *,'unpack_data_record_3d - variable ',x_char,' does not exist'
         call abort_code('error in unpack_data_record_3d')
      endif

! end of routine
      end subroutine unpack_data_record_3d
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 



!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 
      subroutine unpack_data_record_4d(component_name,                       &
                                       x_char, x4, fill_switch, fill_const)
!-------------------------------------------------------------------------------
!
! Purpose: This subroutine unpacks the data from the buffer array and fills a 
!          4-d variable for one grid cell.
!     USED FOR INPUT
!
! Author: Don Dazlich, Department of Atmospheric Science, CSU
!
! History: 15 May 2003 - created this routine
!
      implicit none

! Argument list declarations
      character (*), intent(in) ::                                   &
         component_name  ! component model name
      real (kind=dbl_kind), intent(out), dimension(:,:,:,:) ::       &
         x4 ! variable to pack in buffer
      character(*), intent(in) ::                                    &
         x_char            ! variable short name

! Additional optional arguments
      logical (kind=log_kind), optional, intent(in) ::               &
         fill_switch  ! if true, use fill_const for a variable not 
                      ! present in input data
      real (kind=dbl_kind), optional, intent(in) ::                  &
         fill_const   ! if fill_switch true, fill missing data with this value

! local variables
      TYPE (io_util_type),POINTER ::                                 &
         current
      integer (kind=int_kind) ::                                     &
         n, i1, i2, i3, i4, icount   ! loop indices
      logical (kind=log_kind) ::                                     &
         found_var       ! true if variable is found in header

! point to the element of the io data type for this component
      current => get_component_pointer_io(component_name)

! test for variable in header
      found_var = .false.
      var_search : do n = 1,current%nvar

! test for number of dimensions

         if(trim(x_char) == trim( current%header(n)%short_name ) ) then
            found_var = .true.
            if( current%header(n)%nvar_dims == 4 ) then

! copy from buffer
               icount = current%header(n)%start_index - 1
               if ( current%real_bytes == 4 ) then
                  do i4 = 1, current%header(n)%var_dims(4)
                     do i3 = 1, current%header(n)%var_dims(3)
                        do i2 = 1, current%header(n)%var_dims(2)
                           do i1 = 1, current%header(n)%var_dims(1)
                              icount = icount + 1
                              x4(i1,i2,i3,i4) = current%xrec4(icount)
                           enddo
                        enddo
                     enddo
                  enddo
               else if ( current%real_bytes == 8 ) then
                  do i4 = 1,current% header(n)%var_dims(4)
                     do i3 = 1, current%header(n)%var_dims(3)
                        do i2 = 1, current%header(n)%var_dims(2)
                           do i1 = 1, current%header(n)%var_dims(1)
                              icount = icount + 1
                              x4(i1,i2,i3,i4) = current%xrec8(icount)
                           enddo
                        enddo
                     enddo
                  enddo
               endif
               exit var_search
            else

! wrong number of dimensions for this variable
               print *,'I/O warning for file ',trim(current%open_filename),   &
                       ' in component ',component_name
               print *,'variable ',x_char,                                    &
                       ' is not a 4-d variable at one grid cell'
               call abort_code('error in unpack_data_record_4d')
            endif
         else if(present(fill_switch) .and. present(fill_const) ) then

            if(fill_switch) then

! variable missing, but initialize with constant
               x4(1:current%header(n)%var_dims(1),                    &
                  1:current%header(n)%var_dims(2),                    &
                  1:current%header(n)%var_dims(3),                    &
                  1:current%header(n)%var_dims(4)) = fill_const               
               exit var_search

            else

! don't fill variable - abort
               print *,'I/O warning for file ',trim(current%open_filename),   &
                       ' in component ',component_name
               print *,'unpack_data_record_4d - variable ',x_char,            &
                       ' does not exist'
               call abort_code('error in unpack_data_record_4d')
            endif

         endif
      enddo var_search

      if(.not.found_var) then

! variable doesn't exist

         print *,'I/O warning for file ',trim(current%open_filename),        &
                 ' in component ',component_name
         print *,'unpack_data_record_4d - variable ',x_char,' does not exist'
         call abort_code('error in unpack_data_record_4d')
      endif

! end of routine
      end subroutine unpack_data_record_4d
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 



!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 
      subroutine close_direct_file(component_name)
!-------------------------------------------------------------------------------
!
! Purpose: This subroutine closes a direct access file used for I/O and
!          resets certain variables to the default, no-files-open values.
!    USED FOR INPUT AND OUTPUT
!
! Author: Don Dazlich, Department of Atmospheric Science, CSU
!
! History: 04 Apr 2002 - created this routine
!          16 May 2003 - added linux=0 preprocessor 
!                        directive for single process output
!
      implicit none

! Argument list declarations 
      character (*), intent(in) :: component_name  ! component model name
      
! local variables
      TYPE (io_util_type),POINTER ::                                     &
         current
      integer (kind=int_kind) :: my_task

! point to the element of the io data type for this component
      current => get_component_pointer_io(component_name)

! deallocate the buffer and header
      if ( current%real_bytes == 4 ) then
         deallocate(current%xrec4)
      else if ( current%real_bytes == 8 ) then
         deallocate(current%xrec8)
      endif
      deallocate(current%header)

! close the unit

#if mpi == 1 && parallel_io == 0
      my_task = get_my_task(component_name)
      if(my_task == 0) close(current%lunit)
#else
      close(current%lunit)
#endif

! reset variables to default, no-file-open values
      current%l_open_file = .false.
      current%real_bytes = 0
      current%nhead = 0
      current%nvar = 0
      current%ncells = 0
      current%lrecl = 0
      current%s_index = 1
      current%restart_file = .false.

! end of routine
      end subroutine close_direct_file
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 

!=======================================================================
!  BEGIN  initialize_component
!=======================================================================
   SUBROUTINE initialize_component_io (component_name)
!.......................................................................
!  INTENT IN
!.......................................................................
   CHARACTER (LEN=*), intent(in) ::                                        &
      component_name
!.......................................................................
!  LOCAL
!.......................................................................
   TYPE (io_util_type),POINTER ::                                          &
      current
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! THE FIRST TIME initialize_component IS CALLED, INITIALIZE component_list
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   IF (.NOT.ASSOCIATED (io_util_list)) THEN
      ALLOCATE (io_util_list); NULLIFY (io_util_list%next)
      current => io_util_list
      current%lunit = lunit_init
   ELSE
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! LOOK THROUGH THE LIST TO FIND DUPLICATE component_name
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      current => io_util_list
      DO WHILE (ASSOCIATED (current))
         IF (TRIM (current%component_name)==TRIM (component_name)) return
         current => current%next
      ENDDO
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  ADD A NEW NODE TO THE END OF THE LIST
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      current => io_util_list
      DO WHILE (ASSOCIATED (current%next))
         current => current%next
      ENDDO
      ALLOCATE (current%next)
      current%next%lunit = current%lunit+1
      current => current%next
      NULLIFY  (current%next)
   ENDIF
   current%component_name = component_name
   current%nhead = 0        ! number of header records (includes any time stamp)
   current%nvar = 0         ! number of variables in data records
   current%real_bytes = 0   ! number of bytes in real data 
   current%lrecl = 0        ! file record length 
   current%ncells = 0       ! number of grid cells in file 
   current%s_index = 1      ! starting index in data record 
   current%l_open_file = .false.   ! true if direct access file is open

   END SUBROUTINE initialize_component_io
!=======================================================================
!  END  initialize_component_io
!=======================================================================


      
!=======================================================================
!  BEGIN  get_component_pointer_io
!=======================================================================
   FUNCTION get_component_pointer_io (component_name) RESULT (current)
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  PURPOSE: returns a pointer to the componet coorresponding to component_name
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!.......................................................................
!  INTENT IN
!.......................................................................
   CHARACTER (LEN=*), intent(in) ::                                          &
      component_name
!.......................................................................
!  INTENT OUT
!.......................................................................
   TYPE (io_util_type),POINTER ::                                            &
      current
!.......................................................................
!  LOCAL
!.......................................................................
   LOGICAL (KIND=log_kind) ::                                                &
      l_name_found
!.......................................................................
   IF (.NOT.ASSOCIATED (io_util_list)) THEN
      call abort_code(                                                       &
       'get_component_pointer_io : no model components have been initialized ')
   ELSE
      current => io_util_list
      l_name_found = .FALSE.
      DO WHILE ((ASSOCIATED (current)).AND.(.NOT.l_name_found))
         IF (TRIM (current%component_name)==TRIM (component_name)) THEN
            l_name_found = .TRUE.
         ENDIF
         IF (.NOT.l_name_found) THEN
            current => current%next
         ENDIF
      ENDDO
      IF (.NOT.l_name_found) THEN
         call abort_code(' get_component_pointer_io : the component named = "' &
                      //TRIM (component_name)//'" has not been initialized.')
      ENDIF
   ENDIF

   END FUNCTION get_component_pointer_io
!=======================================================================
!  END  get_component_pointer
!=======================================================================



   end module io_utilities
