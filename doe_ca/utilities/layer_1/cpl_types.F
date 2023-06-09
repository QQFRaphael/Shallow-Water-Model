!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

 module cpl_types

!BOP
!
! !MODULE:  cpl_types
!
! !DESCRIPTION:
!  This module contains the declarations for all required coupler
!  data types and several operators for those data types. It also 
!  contains several global parameters used by various coupler operations.
!
!  This module was built from a subset of the POP io_types.F90 functions.
!  Basically, we used the io_field functions, and all that is done is to
!  replace "io" in the names with "cpl", and remove references to integer
!  and real*4 data arrays
!
! !REVISION HISTORY:
!  Created - 2002/06/20 Don Dazlich dazlich@atmos.colostate.edu
!  New  definitions - 2004/11/04 Don Dazlich dazlich@atmos.colostate.edu
!     With the addition of corner remapping certain assumptions must now be made 
!     about some of these variables. Grid_loc now has the 'corn' value in
!     addition to the 'cent' value for variables at the vertices of the
!     hexagons. field_d_3d arrays now take on additional meaning. If the grid_loc
!     is 'cent', then the 3rd dimension is the 'slice count' dimension, for 
!     example number of vertical levels. If the grid_loc is 'cent' the first 
!     dimension is the slice dimension and is the number of corners defined at
!     each hexagon (ncorners). As a result, a 'corn' variable cannot have
!     multiple vertical levels. This has an effect on the code in sendrecv.F where
!     the number of slices are counted, and in remap_a2c in cpl_coupler.F.


! !USES:

   use kinds, i4=>int_kind, r4=>real_kind, r8=>dbl_kind
   use abort

   implicit none
   private
   save

! !PUBLIC TYPES:

   ! Generic COUPLER field descriptor

   type, public :: cpl_field_desc
      character(char_len)                         :: short_name
      character(char_len)                         :: long_name
      character(char_len)                         :: units
      character(char_len)                         :: remap_processing
      character(char_len)                         :: time_processing
      character(4)                                :: grid_loc
      real(r4)                                    :: missing_value
      real(r4), dimension(2)                      :: valid_range
      integer(i4)                                 :: id
      integer(i4)                                 :: nfield_dims
      integer(i4)                                 :: remap_identical
      type (cpl_dim), dimension(:), pointer       :: field_dim
      type (cpl_dim), dimension(:), pointer       :: remap_dim
      character(char_len), dimension(:), pointer  :: add_attrib_cname
      character(char_len), dimension(:), pointer  :: add_attrib_cval
      character(char_len), dimension(:), pointer  :: add_attrib_lname
      logical  (log_kind), dimension(:), pointer  :: add_attrib_lval
      character(char_len), dimension(:), pointer  :: add_attrib_iname
      integer  (r4),       dimension(:), pointer  :: add_attrib_ival
      character(char_len), dimension(:), pointer  :: add_attrib_rname
      real     (r4),       dimension(:), pointer  :: add_attrib_rval
      character(char_len), dimension(:), pointer  :: add_attrib_dname
      real     (r8),       dimension(:), pointer  :: add_attrib_dval
      !   Only one of these next two pointers can be associated.
      !   The other must be nullified.  For convenience in
      !   initialization, these declarations are the last listed
      !   in this type.
      real(r8), dimension(:,:,:), pointer         :: field_d_2d ! for intercomp sendrecv
      real(r8), dimension(:,:,:,:), pointer       :: field_d_3d ! for intercomp sendrecv
      real(r8), dimension(:,:,:), pointer         :: remap_d_2d ! for atm-cpl remap
      real(r8), dimension(:,:,:,:), pointer       :: remap_d_3d ! for atm-cpl remap
   end type cpl_field_desc

   type, public :: cpl_dim
      integer(i4) ::  id
      integer(i4) :: length  ! 1 to n, but 0 means unlimited
      integer(i4) :: start, stop, stride  ! For slicing and dicing
      character(char_len)        :: name
   end type cpl_dim

! some constants used
   character (char_len) ::  &
      char_blank   = &       ! empty character string
'                                                                                '
   real(r8) :: undefined = 1.e20_8


! !PUBLIC MEMBER FUNCTIONS:

   public :: construct_cpl_field,      &
             destroy_cpl_field,        &
             construct_cpl_dim,        &
             add_attrib_cpl_field,     &
             extract_attrib_cpl_field

!-----------------------------------------------------------------------
!
!  generic interface definitions
!
!-----------------------------------------------------------------------

   interface add_attrib_cpl_field
      module procedure add_attrib_cpl_field_char, &
                       add_attrib_cpl_field_log,  &
                       add_attrib_cpl_field_int,  &
                       add_attrib_cpl_field_real, &
                       add_attrib_cpl_field_dbl
   end interface

   interface extract_attrib_cpl_field
      module procedure extract_attrib_cpl_field_char, &
                       extract_attrib_cpl_field_log,  &
                       extract_attrib_cpl_field_int,  &
                       extract_attrib_cpl_field_real, &
                       extract_attrib_cpl_field_dbl
   end interface

 contains

!***********************************************************************
!BOP
! !IROUTINE: construct_cpl_field
! !INTERFACE:

 function construct_cpl_field (  &
       short_name,       &
       dim1, dim2,       &
       dim3, dim4,       &
       long_name,        &
       units,            &
       remap_processing, &
       time_processing,  &
       grid_loc,         &
       missing_value,    &
       valid_range,      &
       rdim1, rdim2,     &
       rdim3, rdim4,     &
       d2d_array,        &
       d3d_array)        &
    result (descriptor)

! !DESCRIPTION:
!  Constructs a new cpl\_field descriptor for a field which will
!  be passed into/from the coupler.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   character(*), intent(in) :: &
      short_name                ! short (one word) name for field

   type (cpl_dim), intent(in) :: &
      dim1, dim2, dim3          ! dimension data types for dims 1,2 and 3

   type (cpl_dim), intent(in), optional :: &
      dim4                      ! dimension data type for 4th dim

   type (cpl_dim), intent(in), optional :: &
      rdim1, rdim2, rdim3, rdim4 ! dimension data types for dims 1,2,3 and 4
                                 !  for remapped arrays

   character(*), intent(in), optional :: &
      long_name,               &! longer descriptive name for field
      remap_processing,        &! type of remapping (none, first, second)
      time_processing,         &! type of time processing
      units                     ! units for field

   character(4), intent(in), optional :: &
      grid_loc                  ! position of field in staggered grid

   real (r4), intent(in), optional :: &
      missing_value             ! value for missing points (eg land)

   real (r4), intent(in), dimension(2), optional :: &
      valid_range               ! valid range (min,max) for field

   !***
   !*** one (and only one) of these must be present
   !*** the extra dimension on 2d,3d arrays corresponds to block index
   !***

   real    (r8), dimension(:,:,:),   intent(in), optional, target :: &
                                                           d2d_array
   real    (r8), dimension(:,:,:,:), intent(in), optional, target :: &
                                                           d3d_array

! !OUTPUT PARAMETERS:

   type (cpl_field_desc) :: descriptor ! descriptor to be created
   
   integer :: i, size_f, size_r

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  variables to describe the field
!
!-----------------------------------------------------------------------

   descriptor%short_name = char_blank
   descriptor%short_name = trim(short_name)

   descriptor%long_name = char_blank
   if (present(long_name)) then
      descriptor%long_name = trim(long_name)
   endif

   descriptor%units = char_blank
   if (present(units)) then
      descriptor%units = trim(units)
   endif

   descriptor%time_processing = 'instant'
   if (present(time_processing)) then
      descriptor%time_processing = trim(time_processing)
   endif

   descriptor%remap_processing = 'none'
   if (present(remap_processing)) then
      descriptor%remap_processing = trim(remap_processing)
   endif

   descriptor%grid_loc = '    '
   if (present(grid_loc)) then
      descriptor%grid_loc = grid_loc
   endif

   descriptor%missing_value = undefined
   if (present(missing_value)) then
      descriptor%missing_value = missing_value
   endif

! valid range limits the values in the remapping
! The first element is the valid minimum (i.e. precip >= 0 )
! The second element is the valid maximum
   descriptor%valid_range(1) = -1.e20
   descriptor%valid_range(1) =  1.e20
   if (present(valid_range)) then
      descriptor%valid_range = valid_range
   endif

!-----------------------------------------------------------------------
!
!  initialize id and dimension info (primarily for netCDF files)
!
!-----------------------------------------------------------------------

   descriptor%id = 0
   descriptor%remap_identical = 1

   nullify (descriptor%field_d_2d)
   nullify (descriptor%field_d_3d)
   nullify (descriptor%remap_d_2d)
   nullify (descriptor%remap_d_3d)

   if( trim(descriptor%remap_processing) == 'none' ) then
! This is the no remap case. there are no remap_dim or dxd_remap array
   
   if (present(d3d_array)) then
      descriptor%nfield_dims = 4
      allocate (descriptor%field_dim(1:4))
      descriptor%field_dim(1) = dim1
      descriptor%field_dim(2) = dim2
      descriptor%field_dim(3) = dim3
      if (present(dim4)) then
         descriptor%field_dim(4) = dim4
      else
         call abort_code('construct_cpl_field: must supply 4th dim')
      endif

   else if (present(d2d_array)) then
      descriptor%nfield_dims = 3
      allocate (descriptor%field_dim(1:3))
      descriptor%field_dim(1) = dim1
      descriptor%field_dim(2) = dim2
      descriptor%field_dim(3) = dim3
      if(descriptor%grid_loc == 'corn')                              &
         call abort_code('construct_cpl_field: grid_loc=corn and 2d field incompatible')
   else
      descriptor%nfield_dims = 1
      allocate (descriptor%field_dim(1))
      descriptor%field_dim(1) = dim1
   end if

   if (present(d2d_array)) then
      descriptor%field_d_2d => d2d_array
   else if (present(d3d_array)) then
      descriptor%field_d_3d => d3d_array
   else
      call abort_code('construct_cpl_field: must supply data array')
   end if
   
   else
! This is the case with remapping. Remap_dim and remap_d_xd refer to the
!   sfc resolution. Field_dim and field_d_xd refer to the atm resolution
!   and represent the arrays sent and received to/from the atmosphere.

   if (present(d3d_array)) then
      descriptor%nfield_dims = 4
      allocate (descriptor%field_dim(1:4))
      descriptor%field_dim(1) = dim1
      descriptor%field_dim(2) = dim2
      descriptor%field_dim(3) = dim3
      if( present(rdim1).and.present(rdim2).and.present(rdim3)) then
         allocate (descriptor%remap_dim(1:4))
         descriptor%remap_dim(1) = rdim1
         descriptor%remap_dim(2) = rdim2
         descriptor%remap_dim(3) = rdim3
         if (present(rdim4)) then
            descriptor%remap_dim(4) = rdim4
         else
            call abort_code('construct_cpl_field: must supply 4th remap dim')
         endif
      else
         call abort_code('construct_cpl_field: must supply remap dims')
      endif
      if (present(dim4)) then
         descriptor%field_dim(4) = dim4
      else
         call abort_code('construct_cpl_field: must supply 4th dim')
      endif

   else if (present(d2d_array)) then
      descriptor%nfield_dims = 3
      allocate (descriptor%field_dim(1:3))
      descriptor%field_dim(1) = dim1
      descriptor%field_dim(2) = dim2
      descriptor%field_dim(3) = dim3
      if( present(rdim1).and.present(rdim2).and.present(rdim3)) then
         allocate (descriptor%remap_dim(1:3))
         descriptor%remap_dim(1) = rdim1
         descriptor%remap_dim(2) = rdim2
         descriptor%remap_dim(3) = rdim3
      else
         call abort_code('construct_cpl_field: must supply remap dims')
      endif
   else
      descriptor%nfield_dims = 1
      allocate (descriptor%field_dim(1))
      descriptor%field_dim(1) = dim1
   end if
   
! find out if decompositions or resolutions identical
!   1 - both identical
!   0 - neither identical
!   2 - only resolution identical
!  -1 - only domain decomposition identical

! start with assumption that both are identical. If all dimensions equal
!   then this is so. Else we will assume that neither resolution or
!   decomposition are equal 
   do i = 1, descriptor%nfield_dims
     if(descriptor%field_dim(i)%length /= descriptor%remap_dim(i)%length)   &
        descriptor%remap_identical = 0
   enddo

! if the last dimension (subdomain dimension) is identical then the 
!    decompositions are identical
   if(descriptor%remap_identical == 0) then
      i = descriptor%nfield_dims
      if(descriptor%field_dim(i)%length == descriptor%remap_dim(i)%length)   &
           descriptor%remap_identical = -1
      if(descriptor%grid_loc == 'cent') then
         size_f = (descriptor%field_dim(1)%length-2) *             &
                  (descriptor%field_dim(2)%length-2) *             &
                  (descriptor%field_dim(i)%length)
         size_r = (descriptor%remap_dim(1)%length-2) *             &
                  (descriptor%remap_dim(2)%length-2) *             &
                  (descriptor%remap_dim(i)%length)
      elseif(descriptor%grid_loc == 'corn') then
         size_f = (descriptor%field_dim(2)%length-2) *             &
                  (descriptor%field_dim(3)%length-2) *             &
                  (descriptor%field_dim(i)%length)
         size_r = (descriptor%remap_dim(2)%length-2) *             &
                  (descriptor%remap_dim(3)%length-2) *             &
                  (descriptor%remap_dim(i)%length)
      endif
      if(size_r == size_f) descriptor%remap_identical=2
   endif

   if (present(d2d_array)) then
      descriptor%remap_d_2d => d2d_array
      if(descriptor%remap_identical == 1) then
         descriptor%field_d_2d => d2d_array
      else
         allocate(descriptor%field_d_2d(dim1%length,dim2%length,dim3%length))
      endif
   else if (present(d3d_array)) then
      descriptor%remap_d_3d => d3d_array
      if(descriptor%remap_identical == 1) then
         descriptor%field_d_3d => d3d_array
      else
         allocate(descriptor%field_d_3d(dim1%length,dim2%length,dim3%length,dim4%length))
      endif
   else
      call abort_code('construct_cpl_field: must supply data array')
   end if

   endif  ! if(trim(remap_processing...

!-----------------------------------------------------------------------
!
!  nullify additional field attributes
!
!-----------------------------------------------------------------------

   nullify (descriptor%add_attrib_cname)
   nullify (descriptor%add_attrib_cval)
   nullify (descriptor%add_attrib_lname)
   nullify (descriptor%add_attrib_lval)
   nullify (descriptor%add_attrib_iname)
   nullify (descriptor%add_attrib_ival)
   nullify (descriptor%add_attrib_rname)
   nullify (descriptor%add_attrib_rval)
   nullify (descriptor%add_attrib_dname)
   nullify (descriptor%add_attrib_dval)

!-----------------------------------------------------------------------
!EOC

 end function construct_cpl_field

!***********************************************************************
!BOP
! !IROUTINE: destroy_cpl_field
! !INTERFACE:

 subroutine destroy_cpl_field (descriptor)

! !DESCRIPTION:
!  Clears all fields of an cpl\_field structure and dereference all
!  pointers.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   type (cpl_field_desc), intent(inout) :: &
      descriptor ! descriptor to be destroyed

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  clear all fields
!
!-----------------------------------------------------------------------

   descriptor%short_name = char_blank
   descriptor%long_name  = char_blank
   descriptor%units      = char_blank
   descriptor%remap_processing = char_blank
   descriptor%time_processing  = char_blank
   descriptor%grid_loc   = '    '

   descriptor%missing_value = undefined
   descriptor%valid_range   = undefined
   descriptor%id            = 0
   descriptor%remap_identical = 1
   descriptor%nfield_dims   = 3

!-----------------------------------------------------------------------
!
!  deallocate and dereference pointers
!
!-----------------------------------------------------------------------

   deallocate(descriptor%field_dim)
   nullify(descriptor%field_dim)
   
   deallocate(descriptor%remap_dim)
   nullify(descriptor%remap_dim)

   nullify (descriptor%field_d_2d)
   nullify (descriptor%field_d_3d)

   nullify (descriptor%remap_d_2d)
   nullify (descriptor%remap_d_3d)

   if (associated(descriptor%add_attrib_cname)) then
      deallocate (descriptor%add_attrib_cname)
      deallocate (descriptor%add_attrib_cval)
   endif
   if (associated(descriptor%add_attrib_lname)) then
      deallocate (descriptor%add_attrib_lname)
      deallocate (descriptor%add_attrib_lval)
   endif
   if (associated(descriptor%add_attrib_iname)) then
      deallocate (descriptor%add_attrib_iname)
      deallocate (descriptor%add_attrib_ival)
   endif
   if (associated(descriptor%add_attrib_rname)) then
      deallocate (descriptor%add_attrib_rname)
      deallocate (descriptor%add_attrib_rval)
   endif
   if (associated(descriptor%add_attrib_dname)) then
      deallocate (descriptor%add_attrib_dname)
      deallocate (descriptor%add_attrib_dval)
   endif

   nullify (descriptor%add_attrib_cname)
   nullify (descriptor%add_attrib_cval)
   nullify (descriptor%add_attrib_iname)
   nullify (descriptor%add_attrib_ival)
   nullify (descriptor%add_attrib_rname)
   nullify (descriptor%add_attrib_rval)
   nullify (descriptor%add_attrib_dname)
   nullify (descriptor%add_attrib_dval)

!-----------------------------------------------------------------------
!EOC

 end subroutine destroy_cpl_field

!***********************************************************************
!BOP
! !IROUTINE: add_attrib_io_field_char
! !INTERFACE:

 subroutine add_attrib_cpl_field_char(cplfield, att_name, att_value)

! !DESCRIPTION:
!  This routine adds an attribute to an coupler field.  This
!  particular instantiation adds a character attribute, but is aliased
!  to the generic routine name add\_attrib\_cpl\_field.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   character (*), intent(in) :: &
      att_name,       &! name  of attribute to be added
      att_value        ! value of attribute to be added

! !INPUT/OUTPUT PARAMETERS:

   type (cpl_field_desc), intent(inout) :: &
      cplfield       ! data file descriptor

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   integer (i4) :: &
      n,           &! loop index
      num_attribs   ! current number of attributes defined

   character (char_len), dimension(:), allocatable :: &
      name_tmp,            &! temp space for resizing attrib name  array
      val_tmp               ! temp space for resizing attrib value array

   logical (log_kind) :: &
      att_exists         ! attribute already defined

!-----------------------------------------------------------------------
!
!  if this is the first attribute, allocate space and set the attribute
!
!-----------------------------------------------------------------------

   if (.not. associated(cplfield%add_attrib_cval)) then

      allocate(cplfield%add_attrib_cval(1), &
               cplfield%add_attrib_cname(1))

      cplfield%add_attrib_cval (1) = att_value
      cplfield%add_attrib_cname(1) = att_name

!-----------------------------------------------------------------------
!
!  if not the first, see if it exists and over-write value
!  if does not exist, resize the attribute array and store the 
!  attributes
!
!-----------------------------------------------------------------------

   else

      att_exists = .false.
      num_attribs = size(cplfield%add_attrib_cval(:))
      att_search: do n=1,num_attribs
         if (trim(cplfield%add_attrib_cname(n)) == trim(att_name)) then
            cplfield%add_attrib_cval(n) = char_blank
            cplfield%add_attrib_cval(n) = trim(att_value)
            att_exists = .true.
            exit att_search
         endif
      end do att_search

      if (.not. att_exists) then
         allocate(name_tmp(num_attribs), val_tmp(num_attribs))
         name_tmp(:) = cplfield%add_attrib_cname(:)
         val_tmp (:) = cplfield%add_attrib_cval (:)

         deallocate(cplfield%add_attrib_cname)
         deallocate(cplfield%add_attrib_cval )
         num_attribs = num_attribs + 1
         allocate(cplfield%add_attrib_cname(num_attribs), &
                  cplfield%add_attrib_cval (num_attribs))

         cplfield%add_attrib_cname(1:num_attribs-1) = name_tmp
         cplfield%add_attrib_cval (1:num_attribs-1) =  val_tmp
         cplfield%add_attrib_cname(num_attribs) = att_name
         cplfield%add_attrib_cval (num_attribs) = att_value

         deallocate(name_tmp,val_tmp)
      endif

   endif

!-----------------------------------------------------------------------
!EOC

 end subroutine add_attrib_cpl_field_char

!***********************************************************************
!BOP
! !IROUTINE: add_attrib_cpl_field_log
! !INTERFACE:

 subroutine add_attrib_cpl_field_log(cplfield, att_name, att_value)

! !DESCRIPTION:
!  This routine adds a field attribute to an coupler field.  This
!  particular instantiation adds a logical attribute, but is aliased
!  to the generic routine name add\_attrib\_cpl\_field.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   character (*), intent(in) :: &
      att_name         ! name  of attribute to be added

   logical (log_kind), intent(in) :: &
      att_value        ! value of attribute to be added

! !INPUT/OUTPUT PARAMETERS:

   type (cpl_field_desc), intent(inout) :: &
      cplfield       ! data file descriptor

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   integer (i4) :: &
      n,           &! loop index
      num_attribs   ! current number of attributes defined

   character (char_len), dimension(:), allocatable :: &
      name_tmp              ! temp space for resizing attrib name  array

   logical (log_kind), dimension(:), allocatable :: &
      val_tmp               ! temp space for resizing attrib value array

   logical (log_kind) :: &
      att_exists         ! attribute already defined

!-----------------------------------------------------------------------
!
!  if this is the first attribute, allocate space and set the attribute
!
!-----------------------------------------------------------------------

   if (.not. associated(cplfield%add_attrib_lval)) then

      allocate(cplfield%add_attrib_lval(1), &
               cplfield%add_attrib_lname(1))

      cplfield%add_attrib_lval (1) = att_value
      cplfield%add_attrib_lname(1) = att_name

!-----------------------------------------------------------------------
!
!  otherwise, check to see if the attribute already is defined
!  if yes, store the value
!  if no, resize the attribute array and store the attributes
!
!-----------------------------------------------------------------------

   else

      att_exists = .false.
      num_attribs = size(cplfield%add_attrib_lval(:))
      att_search: do n=1,num_attribs
         if (trim(cplfield%add_attrib_lname(n)) == trim(att_name)) then
            cplfield%add_attrib_lval(n) = att_value
            att_exists = .true.
            exit att_search
         endif
      end do att_search

      if (.not. att_exists) then

         allocate(name_tmp(num_attribs), val_tmp(num_attribs))

         name_tmp(:) = cplfield%add_attrib_lname(:)
         val_tmp (:) = cplfield%add_attrib_lval (:)

         deallocate(cplfield%add_attrib_lname, &
                    cplfield%add_attrib_lval )

         num_attribs = num_attribs + 1

         allocate(cplfield%add_attrib_lname(num_attribs), &
                  cplfield%add_attrib_lval (num_attribs))

         cplfield%add_attrib_lname(1:num_attribs-1) = name_tmp
         cplfield%add_attrib_lval (1:num_attribs-1) =  val_tmp
         cplfield%add_attrib_lname(num_attribs) = att_name
         cplfield%add_attrib_lval (num_attribs) = att_value

         deallocate(name_tmp,val_tmp)
      endif

   endif

!-----------------------------------------------------------------------
!EOC

 end subroutine add_attrib_cpl_field_log

!***********************************************************************
!BOP
! !IROUTINE: add_attrib_cpl_field_int
! !INTERFACE:

 subroutine add_attrib_cpl_field_int(cplfield, att_name, att_value)

! !DESCRIPTION:
!  This routine adds a field attribute to an coupler field.  This
!  particular instantiation adds an integer attribute, but is aliased
!  to the generic routine name add\_attrib\_cpl\_field.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   character (*), intent(in) :: &
      att_name         ! name  of attribute to be added

   integer (i4), intent(in) :: &
      att_value        ! value of attribute to be added

! !INPUT/OUTPUT PARAMETERS:

   type (cpl_field_desc), intent(inout) :: &
      cplfield       ! data file descriptor

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   integer (i4) :: &
      n,           &! loop index
      num_attribs   ! current number of attributes defined

   character (char_len), dimension(:), allocatable :: &
      name_tmp              ! temp space for resizing attrib name  array

   integer (i4), dimension(:), allocatable :: &
      val_tmp               ! temp space for resizing attrib value array

   logical (log_kind) :: &
      att_exists         ! attribute already defined

!-----------------------------------------------------------------------
!
!  if this is the first attribute, allocate space and set the attribute
!
!-----------------------------------------------------------------------

   if (.not. associated(cplfield%add_attrib_ival)) then

      allocate(cplfield%add_attrib_ival(1), &
               cplfield%add_attrib_iname(1))

      cplfield%add_attrib_ival (1) = att_value
      cplfield%add_attrib_iname(1) = att_name

!-----------------------------------------------------------------------
!
!  otherwise, check to see if the attribute already is defined
!  if yes, store the value
!  if no, resize the attribute array and store the attributes
!
!-----------------------------------------------------------------------

   else

      att_exists = .false.
      num_attribs = size(cplfield%add_attrib_ival(:))
      att_search: do n=1,num_attribs
         if (trim(cplfield%add_attrib_iname(n)) == trim(att_name)) then
            cplfield%add_attrib_ival(n) = att_value
            att_exists = .true.
            exit att_search
         endif
      end do att_search

      if (.not. att_exists) then

         allocate(name_tmp(num_attribs), val_tmp(num_attribs))

         name_tmp(:) = cplfield%add_attrib_iname(:)
         val_tmp (:) = cplfield%add_attrib_ival (:)

         deallocate(cplfield%add_attrib_iname, &
                    cplfield%add_attrib_ival )

         num_attribs = num_attribs + 1

         allocate(cplfield%add_attrib_iname(num_attribs), &
                  cplfield%add_attrib_ival (num_attribs))

         cplfield%add_attrib_iname(1:num_attribs-1) = name_tmp
         cplfield%add_attrib_ival (1:num_attribs-1) =  val_tmp
         cplfield%add_attrib_iname(num_attribs) = att_name
         cplfield%add_attrib_ival (num_attribs) = att_value

         deallocate(name_tmp,val_tmp)
      endif

   endif

!-----------------------------------------------------------------------
!EOC

 end subroutine add_attrib_cpl_field_int

!***********************************************************************
!BOP
! !IROUTINE: add_attrib_cpl_field_real
! !INTERFACE:

 subroutine add_attrib_cpl_field_real(cplfield, att_name, att_value)

! !DESCRIPTION:
!  This routine adds a field attribute to an coupler field.  This
!  particular instantiation adds a real attribute, but is aliased
!  to the generic routine name add\_attrib\_cpl\_field.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   character (*), intent(in) :: &
      att_name         ! name  of attribute to be added

   real (r4), intent(in) :: &
      att_value        ! value of attribute to be added

! !INPUT/OUTPUT PARAMETERS:

   type (cpl_field_desc), intent(inout) :: &
      cplfield       ! io field descriptor

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   integer (i4) :: &
      n,           &! loop index
      num_attribs   ! current number of attributes defined

   character (char_len), dimension(:), allocatable :: &
      name_tmp              ! temp space for resizing attrib name  array

   real (r4), dimension(:), allocatable :: &
      val_tmp               ! temp space for resizing attrib value array

   logical (log_kind) :: &
      att_exists         ! attribute already defined

!-----------------------------------------------------------------------
!
!  if this is the first attribute, allocate space and set the attribute
!
!-----------------------------------------------------------------------

   if (.not. associated(cplfield%add_attrib_rval)) then

      allocate(cplfield%add_attrib_rval(1), &
               cplfield%add_attrib_rname(1))

      cplfield%add_attrib_rval (1) = att_value
      cplfield%add_attrib_rname(1) = att_name

!-----------------------------------------------------------------------
!
!  otherwise, check to see if the attribute already is defined
!  if yes, store the value
!  if no, resize the attribute array and store the attributes
!
!-----------------------------------------------------------------------

   else

      att_exists = .false.
      num_attribs = size(cplfield%add_attrib_rval(:))
      att_search: do n=1,num_attribs
         if (trim(cplfield%add_attrib_rname(n)) == trim(att_name)) then
            cplfield%add_attrib_rval(n) = att_value
            att_exists = .true.
            exit att_search
         endif
      end do att_search

      if (.not. att_exists) then

         allocate(name_tmp(num_attribs), val_tmp(num_attribs))

         name_tmp(:) = cplfield%add_attrib_rname(:)
         val_tmp (:) = cplfield%add_attrib_rval (:)

         deallocate(cplfield%add_attrib_rname, &
                    cplfield%add_attrib_rval )

         num_attribs = num_attribs + 1

         allocate(cplfield%add_attrib_rname(num_attribs), &
                  cplfield%add_attrib_rval (num_attribs))

         cplfield%add_attrib_rname(1:num_attribs-1) = name_tmp
         cplfield%add_attrib_rval (1:num_attribs-1) =  val_tmp
         cplfield%add_attrib_rname(num_attribs) = att_name
         cplfield%add_attrib_rval (num_attribs) = att_value

         deallocate(name_tmp,val_tmp)
      endif

   endif

!-----------------------------------------------------------------------
!EOC

 end subroutine add_attrib_cpl_field_real

!***********************************************************************
!BOP
! !IROUTINE: add_attrib_cpl_field_dbl
! !INTERFACE:

 subroutine add_attrib_cpl_field_dbl(cplfield, att_name, att_value)

! !DESCRIPTION:
!  This routine adds a field attribute to an coupler field.  This
!  particular instantiation adds a double precision attribute, but is 
!  aliased to the generic routine name add\_attrib\_cpl\_field.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   character (*), intent(in) :: &
      att_name         ! name  of attribute to be added

   real (r8), intent(in) :: &
      att_value        ! value of attribute to be added

! !INPUT/OUTPUT PARAMETERS:

   type (cpl_field_desc), intent(inout) :: &
      cplfield       ! coupler field descriptor

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   integer (i4) :: &
      n,           &! loop index
      num_attribs   ! current number of attributes defined

   character (char_len), dimension(:), allocatable :: &
      name_tmp              ! temp space for resizing attrib name  array

   real (r8), dimension(:), allocatable :: &
      val_tmp               ! temp space for resizing attrib value array

   logical (log_kind) :: &
      att_exists         ! attribute already defined

!-----------------------------------------------------------------------
!
!  if this is the first attribute, allocate space and set the attribute
!
!-----------------------------------------------------------------------

   if (.not. associated(cplfield%add_attrib_dval)) then

      allocate(cplfield%add_attrib_dval(1), &
               cplfield%add_attrib_dname(1))

      cplfield%add_attrib_dval (1) = att_value
      cplfield%add_attrib_dname(1) = att_name

!-----------------------------------------------------------------------
!
!  otherwise, check to see if the attribute already is defined
!  if yes, store the value
!  if no, resize the attribute array and store the attributes
!
!-----------------------------------------------------------------------

   else

      att_exists = .false.
      num_attribs = size(cplfield%add_attrib_dval(:))
      att_search: do n=1,num_attribs
         if (trim(cplfield%add_attrib_dname(n)) == trim(att_name)) then
            cplfield%add_attrib_dval(n) = att_value
            att_exists = .true.
            exit att_search
         endif
      end do att_search

      if (.not. att_exists) then

         allocate(name_tmp(num_attribs), val_tmp(num_attribs))

         name_tmp(:) = cplfield%add_attrib_dname(:)
         val_tmp (:) = cplfield%add_attrib_dval (:)

         deallocate(cplfield%add_attrib_dname, &
                    cplfield%add_attrib_dval )

         num_attribs = num_attribs + 1

         allocate(cplfield%add_attrib_dname(num_attribs), &
                  cplfield%add_attrib_dval (num_attribs))

         cplfield%add_attrib_dname(1:num_attribs-1) = name_tmp
         cplfield%add_attrib_dval (1:num_attribs-1) =  val_tmp
         cplfield%add_attrib_dname(num_attribs) = att_name
         cplfield%add_attrib_dval (num_attribs) = att_value

         deallocate(name_tmp,val_tmp)
      endif

   endif

!-----------------------------------------------------------------------
!EOC

 end subroutine add_attrib_cpl_field_dbl

!***********************************************************************
!BOP
! !IROUTINE: extract_attrib_cpl_field_char
! !INTERFACE:

 subroutine extract_attrib_cpl_field_char(cplfield, att_name, att_value)

! !DESCRIPTION:
!  This routine extracts an attribute from an coupler field.  This
!  particular instantiation extracts a character attribute, but is 
!  aliased to the generic routine name extract\_attrib\_cpl\_field.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   character (*), intent(in) :: &
      att_name        ! name  of attribute to be extracted

   type (cpl_field_desc), intent(in) :: &
      cplfield       ! data field descriptor

! !OUTPUT PARAMETERS:

   character (*), intent(out) :: &
      att_value        ! value of attribute to be extracted

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   integer (i4) :: &
      n             ! loop index

   logical (log_kind) :: &
      att_exists         ! attribute already defined

!-----------------------------------------------------------------------
!
!  first check standard attributes
!
!-----------------------------------------------------------------------

   att_exists = .false.

   select case (trim(att_name))
   case ('short_name','SHORT_NAME')
      att_value = cplfield%short_name
      att_exists = .true.

   case ('long_name','LONG_NAME')
      att_exists = .true.
      att_value = cplfield%long_name

   case ('units','UNITS')
      att_exists = .true.
      att_value = cplfield%units

   case ('time_processing','TIME_PROCESSING')
      att_exists = .true.
      att_value = cplfield%time_processing

   case ('remap_processing','REMAP_PROCESSING')
      att_exists = .true.
      att_value = cplfield%remap_processing

   case ('grid_loc','GRID_LOC')
      att_exists = .true.
      att_value = cplfield%grid_loc

   end select

!-----------------------------------------------------------------------
!
!  if not a standard attribute, check additional attributes
!
!-----------------------------------------------------------------------

   if (.not. att_exists .and. associated(cplfield%add_attrib_cval)) then

      att_search: do n=1,size(cplfield%add_attrib_cval)
         if (trim(att_name) == trim(cplfield%add_attrib_cname(n))) then
            att_value = cplfield%add_attrib_cval(n)
            att_exists = .true.
            exit att_search
         endif
      end do att_search
   endif

!-----------------------------------------------------------------------
!
!  if attribute not found, exit with error
!
!-----------------------------------------------------------------------

   if (.not. att_exists) then
!      if (my_task == master_task) then
         write(6,*) 'Attribute name: ',trim(att_name)
!      endif
      call abort_code('Unknown cplfield attribute')
   endif

!-----------------------------------------------------------------------
!EOC

 end subroutine extract_attrib_cpl_field_char

!***********************************************************************
!BOP
! !IROUTINE: extract_attrib_cpl_field_log
! !INTERFACE:

 subroutine extract_attrib_cpl_field_log(cplfield, att_name, att_value)

! !DESCRIPTION:
!  This routine extracts an attribute from an io field.  This
!  particular instantiation extracts a logical attribute, but is 
!  aliased to the generic routine name extract\_attrib\_io\_field.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   character (*), intent(in) :: &
      att_name        ! name  of attribute to be extracted

   type (cpl_field_desc), intent(in) :: &
      cplfield       ! data field descriptor

! !OUTPUT PARAMETERS:

   logical (log_kind), intent(out) :: &
      att_value        ! value of attribute to be extracted

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   integer (i4) :: &
      n             ! loop index

   logical (log_kind) :: &
      att_exists         ! attribute already defined

!-----------------------------------------------------------------------
!
!  first check standard attributes
!
!-----------------------------------------------------------------------

   att_exists = .false.

   !*** no standard logical attributes

!-----------------------------------------------------------------------
!
!  if not a standard attribute, check additional attributes
!
!-----------------------------------------------------------------------

   if (.not. att_exists .and. associated(cplfield%add_attrib_lval)) then

      att_search: do n=1,size(cplfield%add_attrib_lval)
         if (trim(att_name) == trim(cplfield%add_attrib_lname(n))) then
            att_value = cplfield%add_attrib_lval(n)
            att_exists = .true.
            exit att_search
         endif
      end do att_search
   endif

!-----------------------------------------------------------------------
!
!  if attribute not found, exit with error
!
!-----------------------------------------------------------------------

   if (.not. att_exists) then
!      if (my_task == master_task) then
         write(6,*) 'Attribute name: ',trim(att_name)
!      endif
      call abort_code('Unknown cplfield attribute')
   endif

!-----------------------------------------------------------------------
!EOC

 end subroutine extract_attrib_cpl_field_log

!***********************************************************************
!BOP
! !IROUTINE: extract_attrib_cpl_field_int
! !INTERFACE:

 subroutine extract_attrib_cpl_field_int(cplfield, att_name, att_value)

! !DESCRIPTION:
!  This routine extracts an attribute from an coupler field.  This
!  particular instantiation extracts an integer attribute, but is 
!  aliased to the generic routine name extract\_attrib\_cpl\_field.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   character (*), intent(in) :: &
      att_name        ! name  of attribute to be extracted

   type (cpl_field_desc), intent(in) :: &
      cplfield       ! data file descriptor

! !OUTPUT PARAMETERS:

   integer (i4), intent(out) :: &
      att_value        ! value of attribute to be extracted

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   integer (i4) :: &
      n             ! loop index

   logical (log_kind) :: &
      att_exists         ! attribute already defined

!-----------------------------------------------------------------------
!
!  first check standard attributes
!
!-----------------------------------------------------------------------

   att_exists = .false.

   select case (trim(att_name))
   case ('id','ID')
      att_exists = .true.
      att_value = cplfield%id

   case ('nfield_dims','NFIELD_DIMS')
      att_exists = .true.
      att_value = cplfield%nfield_dims

   end select

!-----------------------------------------------------------------------
!
!  if not a standard attribute, check additional attributes
!
!-----------------------------------------------------------------------

   if (.not. att_exists .and. associated(cplfield%add_attrib_ival)) then

      att_search: do n=1,size(cplfield%add_attrib_ival)
         if (trim(att_name) == trim(cplfield%add_attrib_iname(n))) then
            att_value = cplfield%add_attrib_ival(n)
            att_exists = .true.
            exit att_search
         endif
      end do att_search
   endif

!-----------------------------------------------------------------------
!
!  if attribute not found, exit with error
!
!-----------------------------------------------------------------------

   if (.not. att_exists) then
!      if (my_task == master_task) then
         write(6,*) 'Attribute name: ',trim(att_name)
!      endif
      call abort_code('Unknown cplfield attribute')
   endif

!-----------------------------------------------------------------------
!EOC

 end subroutine extract_attrib_cpl_field_int

!***********************************************************************
!BOP
! !IROUTINE: extract_attrib_cpl_field_real
! !INTERFACE:

 subroutine extract_attrib_cpl_field_real(cplfield, att_name, att_value)

! !DESCRIPTION:
!  This routine extracts an attribute from an coupler field.  This
!  particular instantiation extracts a real attribute, but is 
!  aliased to the generic routine name extract\_attrib\_cpl\_field.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   character (*), intent(in) :: &
      att_name        ! name  of attribute to be extracted

   type (cpl_field_desc), intent(in) :: &
      cplfield       ! data file descriptor

! !OUTPUT PARAMETERS:

   real (r4), intent(out) :: &
      att_value        ! value of attribute to be extracted

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   integer (i4) :: &
      n             ! loop index

   logical (log_kind) :: &
      att_exists         ! attribute already defined

!-----------------------------------------------------------------------
!
!  first check standard attributes
!
!-----------------------------------------------------------------------

   att_exists = .false.

   select case (trim(att_name))
   case ('missing_value','MISSING_VALUE')
      att_value = cplfield%missing_value
      att_exists = .true.

   case ('valid_range','VALID_RANGE')
      att_exists = .true.
      !att_value = cplfield%valid_range

   end select

!-----------------------------------------------------------------------
!
!  if not a standard attribute, check additional attributes
!
!-----------------------------------------------------------------------

   if (.not. att_exists .and. associated(cplfield%add_attrib_rval)) then

      att_search: do n=1,size(cplfield%add_attrib_rval)
         if (trim(att_name) == trim(cplfield%add_attrib_rname(n))) then
            att_value = cplfield%add_attrib_rval(n)
            att_exists = .true.
            exit att_search
         endif
      end do att_search
   endif

!-----------------------------------------------------------------------
!
!  if attribute not found, exit with error
!
!-----------------------------------------------------------------------

   if (.not. att_exists) then
!      if (my_task == master_task) then
         write(6,*) 'Attribute name: ',trim(att_name)
!      endif
      call abort_code('Unknown cplfield attribute')
   endif

!-----------------------------------------------------------------------
!EOC

 end subroutine extract_attrib_cpl_field_real

!***********************************************************************
!BOP
! !IROUTINE: extract_attrib_cpl_field_dbl
! !INTERFACE:

 subroutine extract_attrib_cpl_field_dbl(cplfield, att_name, att_value)

! !DESCRIPTION:
!  This routine extracts an attribute from an coupler field.  This
!  particular instantiation extracts a double precision attribute, but
!  is aliased to the generic routine name extract\_attrib\_cpl\_field.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   character (*), intent(in) :: &
      att_name        ! name  of attribute to be extracted

   type (cpl_field_desc), intent(in) :: &
      cplfield       ! data file descriptor

! !OUTPUT PARAMETERS:

   real (r8), intent(out) :: &
      att_value        ! value of attribute to be extracted

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   integer (i4) :: &
      n             ! loop index

   logical (log_kind) :: &
      att_exists         ! attribute already defined

!-----------------------------------------------------------------------
!
!  first check standard attributes
!
!-----------------------------------------------------------------------

   att_exists = .false.

   !*** no standard dbl attributes

!-----------------------------------------------------------------------
!
!  if not a standard attribute, check additional attributes
!
!-----------------------------------------------------------------------

   if (.not. att_exists .and. associated(cplfield%add_attrib_dval)) then

      att_search: do n=1,size(cplfield%add_attrib_dval)
         if (trim(att_name) == trim(cplfield%add_attrib_dname(n))) then
            att_value = cplfield%add_attrib_dval(n)
            att_exists = .true.
            exit att_search
         endif
      end do att_search
   endif

!-----------------------------------------------------------------------
!
!  if attribute not found, exit with error
!
!-----------------------------------------------------------------------

   if (.not. att_exists) then
!      if (my_task == master_task) then
         write(6,*) 'Attribute name: ',trim(att_name)
!      endif
      call abort_code('Unknown cplfield attribute')
   endif

!-----------------------------------------------------------------------
!EOC

 end subroutine extract_attrib_cpl_field_dbl

!***********************************************************************
!BOP
! !IROUTINE: construct_cpl_dim
! !INTERFACE:

 function construct_cpl_dim(name, length, start, stop, stride)

! !DESCRIPTION:
!  Constructs a dimension for use in defining fields for the coupler.
!
! !REVISION HISTORY
!  same as module

! !INPUT PARAMETERS:

   character(*), intent(in) :: &
      name     ! name of dimension

   integer(i4), intent(in) :: &
      length   ! size of dimension (1 to n, but 0 means unlimited)

   integer(i4), intent(in), optional :: &
      start, stop, stride  ! For slicing and dicing

! !OUTPUT PARAMETERS:

   type (cpl_dim) :: construct_cpl_dim

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  build data structure using input values
!
!-----------------------------------------------------------------------

   construct_cpl_dim%name = char_blank
   construct_cpl_dim%name = trim(name)

   construct_cpl_dim%id = 0  ! will be set later using netCDF routine
   construct_cpl_dim%length = length

   if (present(start)) then
      construct_cpl_dim%start = start
   else
      construct_cpl_dim%start = 1
   endif

   if (present(stop)) then
      construct_cpl_dim%stop = stop
   else
      construct_cpl_dim%stop = length
   endif

   if (present(stride)) then
      construct_cpl_dim%stride = stride
   else
      construct_cpl_dim%stride = 1
   endif

!-----------------------------------------------------------------------
!EOC

 end function construct_cpl_dim



 end module cpl_types

!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

