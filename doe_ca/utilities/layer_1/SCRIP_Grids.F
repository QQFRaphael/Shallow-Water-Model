!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

 module SCRIP_Grids

!BOP
! !MODULE: SCRIP_Grids
!
! !DESCRIPTION:
!  This module defines grid quantities and provides functions for 
!  creating grid data types.  In this version of the module, assumptions
!  are made that the grids are geodesic, cover the entire sphere, and
!  that the x-direction is longitude.
!
! !REVISION HISTORY:
!  CVS:$Id: SCRIP_Grids.F,v 1.9 2003/12/10 13:01:50 pwjones Exp $
!  CVS:$Name:  $
!  Copyright (c) 1997, 1998 the Regents of the University of California.
!  (see full copyright at end of file)

! !USES:

   use kinds               ! defines data types
   use abort               ! exit module
   use params_physical     ! common constants

   implicit none
   private
   save

! !PUBLIC MEMBER FUNCTIONS:

   public :: SCRIP_Grid_Create,      &
             SCRIP_Grid_Destroy,     &
             SCRIP_Grid_Set,         &
             SCRIP_Grid_Search,      &
             SCRIP_Grid_Intersect,   &
             SCRIP_Grid_RemovePoints

! !PUBLIC TYPES:

   type, public :: SCRIPgrid
      character (char_len) :: &
         name           ! name for this grid

      !*** the values for num_cells, dim_size, phys_domain
      !***   could be part of a data type which describes
      !***   the logical configuration of local subdomain

      integer (int_kind) ::  &
         num_cells,    &! number of local cells in this grid
         num_corners    ! number of corners in each grid cell

      integer (int_kind), dimension(:), pointer :: &
         dim_size      ! length of each dimension

      integer (int_kind), dimension(:,:), pointer :: &
         phys_domain   ! start, end of physical domain on
                       ! each subdomain

      real (dbl_kind), dimension(:), pointer :: &! local subdomain limits
         ldomain_min_x, &! lower bound on subdomain in 1st coord dir
         ldomain_max_x, &! upper bound on subdomain in 1st coord dir
         ldomain_min_y, &! lower bound on subdomain in 2nd coord dir
         ldomain_max_y   ! upper bound on subdomain in 2nd coord dir

      logical (log_kind), dimension(:,:,:), pointer :: &
         mask          ! flag which cells participate

      real (dbl_kind), dimension(:,:,:), pointer :: &
         center_x,    &! location in first  coordinate direction
         center_y,    &! location in second coordinate direction
         area          ! area of each grid cell

      !*** the corner dimension or min/max dimension will be the
      !*** first index in these arrays
      real (dbl_kind), dimension(:,:,:,:), pointer :: &
         corner_x,  &! location of corners in first  coord direction
         corner_y,  &! location of corners in second coord direction
         bound_box   ! bounding box (min,max) of each cell

   end type !SCRIPgrid

! !PUBLIC DATA MEMBERS:

   integer (int_kind), public, parameter :: &
      grid_rank = 3  ! hard-wired to 3 for i,j,subdomain

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  module parameters and interfaces
!
!-----------------------------------------------------------------------

   real (dbl_kind), parameter ::     &
      north_thresh =  1.5_dbl_kind, &! threshold above which to use
      south_thresh = -1.5_dbl_kind   ! polar coord tx for search

   interface SCRIP_Grid_Create  ! generic interface
      module procedure SCRIP_Grid_Create_FromFile,   &
                       SCRIP_Grid_Create_FromInputs
                       !SCRIP_Grid_Create_Internal
   end interface


!EOC
!***********************************************************************

 contains

!***********************************************************************
!BOP
! !IROUTINE: SCRIP_Grid_Create_FromInputs
! !INTERFACE:

 subroutine SCRIP_Grid_Create_FromInputs(newgrid, name, units, &
                                         phys_domain,          &
                                         center_x, center_y,   &
                                         corner_x, corner_y,   &
                                         mask, area)

! !DESCRIPTION:
!  This subroutine creates a SCRIP grid structure from grid metric
!  quantities passed as arguments.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   character (*), intent(in) :: &
      name,                     &! name for grid
      units                      ! coordinate units (degrees,radians)

   integer (int_kind), dimension(:,:), intent(in) ::&
      phys_domain                ! beg,end indices for physical domain
                                 !  in each subdomain

   real (dbl_kind), dimension(:,:,:), intent(in) :: &
      center_x, center_y         ! coordinates of cell centers

   real (dbl_kind), dimension(:,:,:,:), intent(in) :: &
      corner_x, corner_y         ! coordinates of cell corners

   logical (log_kind), dimension(:,:,:), intent(in), optional :: &
      mask

   real (dbl_kind), dimension(:,:,:), intent(in), optional :: &
      area                       ! area of each grid cell

! !OUTPUT PARAMETERS:

   type (SCRIPgrid), intent(out) :: &
      newgrid                   ! grid data in SCRIP grid format

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   integer (int_kind) ::   &
      i,j,k,n,nextn,       &! loop indices
      nx,ny,nsbdm,ncorners  ! useful size limits

   real (dbl_kind) :: &
      ref_x, tmp_x1, tmp_x2     ! reference, temp longitudes

!-----------------------------------------------------------------------
!
!  assign name to grid
!
!-----------------------------------------------------------------------

   newgrid%name = ' '
   newgrid%name = name

!-----------------------------------------------------------------------
!
!  deduce size of subdomain, number of local cells, subdomains
!
!-----------------------------------------------------------------------

   allocate(newgrid%dim_size(grid_rank))
   nx       = size(center_x, dim=1)
   ny       = size(center_x, dim=2)
   nsbdm    = size(center_x, dim=3)
   ncorners = size(corner_x, dim=1)
   newgrid%dim_size(1) = nx
   newgrid%dim_size(2) = ny
   newgrid%dim_size(3) = nsbdm
   newgrid%num_cells   = nx*ny*nsbdm
   newgrid%num_corners = ncorners

   allocate(newgrid%phys_domain(4,nsbdm))
   newgrid%phys_domain = phys_domain

!-----------------------------------------------------------------------
!
!  allocate space for grid quantities
!  if mask or area are present, fill the arrays
!
!-----------------------------------------------------------------------

   allocate( newgrid%center_x(nx,ny,nsbdm),            &
             newgrid%center_y(nx,ny,nsbdm),            &
             newgrid%corner_x(ncorners,nx,ny,nsbdm),   &
             newgrid%corner_y(ncorners,nx,ny,nsbdm) )

   if (present(mask)) then
      allocate(newgrid%mask(nx,ny,nsbdm))
      newgrid%mask = mask
   else
      nullify(newgrid%mask)
   endif
   if (present(area)) then
      allocate(newgrid%area(nx,ny,nsbdm))
      newgrid%area = area
   else
      nullify(newgrid%area)
   endif

!-----------------------------------------------------------------------
!
!  convert coordinates to radians if necessary and deal with any
!  longitude range problems
!
!-----------------------------------------------------------------------

   select case(trim(units))
   case ('degrees','deg','degree')
      !*** convert to radians
      newgrid%center_x = center_x*dtr
      newgrid%center_y = center_y*dtr
      newgrid%corner_x = corner_x*dtr
      newgrid%corner_y = corner_y*dtr
  case ('radians','radian')
      !*** no conversion necessary
      newgrid%center_x = center_x
      newgrid%center_y = center_y
      newgrid%corner_x = corner_x
      newgrid%corner_y = corner_y
   case default
      call abort_code('Unknown units in SCRIP_Grid_Create_FromInputs')
   end select

   !*** make sure center longitudes are in 0,2pi interval
   
   where(newgrid%center_x < c0)  newgrid%center_x = &
                                 newgrid%center_x + pi2
   where(newgrid%center_x > pi2) newgrid%center_x = &
                                 newgrid%center_x - pi2
                                 
   !*** now make sure corner longitudes are in same interval
   !*** as centers 
   
   do n=1,ncorners
      where((newgrid%corner_x(n,:,:,:) - newgrid%center_x) > pi) &
         newgrid%corner_x(n,:,:,:) = newgrid%corner_x(n,:,:,:) - pi2
      where((newgrid%corner_x(n,:,:,:) - newgrid%center_x) < -pi) &
         newgrid%corner_x(n,:,:,:) = newgrid%corner_x(n,:,:,:) + pi2
   end do

!-----------------------------------------------------------------------
!
!  compute bounding boxes and domain limits
!
!-----------------------------------------------------------------------

   allocate(newgrid%bound_box(4,nx,ny,nsbdm), &
            newgrid%ldomain_min_x(nsbdm),     &
            newgrid%ldomain_max_x(nsbdm),     &
            newgrid%ldomain_min_y(nsbdm),     &
            newgrid%ldomain_max_y(nsbdm) )

   do k=1,nsbdm

      !*** define a reference lon to aid in 0,pi2 crossings
      ref_x = newgrid%center_x(nx/2,ny/2,k)

      newgrid%ldomain_min_x(k) =  1000.
      newgrid%ldomain_max_x(k) = -1000.
      newgrid%ldomain_min_y(k) =  1000.
      newgrid%ldomain_max_y(k) = -1000.

      do j=1,ny
      do i=1,nx
         newgrid%bound_box(1,i,j,k) = minval(newgrid%corner_x(:,i,j,k))
         newgrid%bound_box(2,i,j,k) = maxval(newgrid%corner_x(:,i,j,k))
         newgrid%bound_box(3,i,j,k) = minval(newgrid%corner_y(:,i,j,k))
         newgrid%bound_box(4,i,j,k) = maxval(newgrid%corner_y(:,i,j,k))

         tmp_x1 = newgrid%bound_box(1,i,j,k)
         tmp_x2 = newgrid%bound_box(2,i,j,k)

         !*** if lons outside range of reference lon, make sure
         !***   the bound box is in the same interval as ref lon
         !***   before computing domain limits

         if (tmp_x1 - ref_x >  pi) tmp_x1 = tmp_x1 - pi2
         if (tmp_x1 - ref_x < -pi) tmp_x1 = tmp_x1 + pi2
         if (tmp_x2 - ref_x >  pi) tmp_x2 = tmp_x2 - pi2
         if (tmp_x2 - ref_x < -pi) tmp_x2 = tmp_x2 + pi2
       
         !*** if lons span a large range, likely cell is near pole
         !***   so make the bound box cover all lons and all lats
         !***   up to the pole point
         !*** set limits larger than necessary just to be sure

         do n=1,ncorners
            nextn = MOD(n,ncorners) + 1

            if (abs(newgrid%corner_x(nextn,i,j,k) - &
                    newgrid%corner_x(n,i,j,k)    ) > 0.5*pi) then

               tmp_x1 = -1000.0
               tmp_x2 =  1000.0
               newgrid%bound_box(1,i,j,k) = tmp_x1
               newgrid%bound_box(2,i,j,k) = tmp_x2

               if (newgrid%bound_box(3,i,j,k) < -0.25*pi) &
                   newgrid%bound_box(3,i,j,k) = -pi
               if (newgrid%bound_box(4,i,j,k) >  0.25*pi) &
                   newgrid%bound_box(4,i,j,k) =  pi

            endif
         end do

         newgrid%ldomain_min_x(k) = min(tmp_x1, &
                                        newgrid%ldomain_min_x(k))
         newgrid%ldomain_max_x(k) = max(tmp_x2, &
                                        newgrid%ldomain_max_x(k))
         newgrid%ldomain_min_y(k) = min(newgrid%bound_box(3,i,j,k), &
                                        newgrid%ldomain_min_y(k))
         newgrid%ldomain_max_y(k) = max(newgrid%bound_box(4,i,j,k), &
                                        newgrid%ldomain_max_y(k))

      end do
      end do
      
   end do

!-----------------------------------------------------------------------
!EOC

   end subroutine SCRIP_Grid_Create_FromInputs

!***********************************************************************
!BOP
! !IROUTINE: SCRIP_Grid_Create_FromFile
! !INTERFACE:

 subroutine SCRIP_Grid_Create_FromFile(newgrid, filename)

! !DESCRIPTION:
!  This subroutine creates a SCRIP grid.  Currently it creates grids
!  by reading grid data from an input netCDF file and putting the
!  data into the SCRIPgrid data type.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   character (*), intent(in) :: &
      filename                  ! name of file containing grid data

! !OUTPUT PARAMETERS:

   type (SCRIPgrid), intent(out) :: &
      newgrid                   ! grid data in SCRIP grid format

!EOP
!BOC
!-----------------------------------------------------------------------

   call abort_code( &
        'SCRIP_Grid: generation from input file not yet supported.')

!-----------------------------------------------------------------------
!EOC

 end subroutine SCRIP_Grid_Create_FromFile

!***********************************************************************
!BOP
! !IROUTINE: SCRIP_Grid_Create_Internal
! !INTERFACE:

 subroutine SCRIP_Grid_Create_Internal(newgrid)

! !DESCRIPTION:
!  This subroutine creates a SCRIP grid.  It computes all necessary
!  information internally and fills the SCRIPgrid data type.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

! !OUTPUT PARAMETERS:

   type (SCRIPgrid), intent(out) :: &
      newgrid                   ! grid data in SCRIP grid format

!EOP
!BOC
!-----------------------------------------------------------------------

   call abort_code('SCRIP_Grid: internal generation not yet supported.')
   
!-----------------------------------------------------------------------
!EOC

 end subroutine SCRIP_Grid_Create_Internal

!***********************************************************************
!BOP
! !IROUTINE: SCRIP_Grid_Destroy
! !INTERFACE:

 subroutine SCRIP_Grid_Destroy(oldgrid)

! !DESCRIPTION:
!  This subroutine destroys a SCRIP grid structure by resetting
!  all scalars and deallocating arrays (pointers) to free up memory.
!
! !REVISION HISTORY:
!  same as module

! !INPUT/OUTPUT PARAMETERS:

   type (SCRIPgrid), intent(inout) :: &
      oldgrid                   ! grid structure to destroy

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  reset scalars to null values
!
!-----------------------------------------------------------------------

   oldgrid%name = ' '
   oldgrid%num_cells    = 0
   oldgrid%num_corners  = 0

!-----------------------------------------------------------------------
!
!  deallocate all arrays/pointers
!
!-----------------------------------------------------------------------

    deallocate(oldgrid%dim_size,      &
               oldgrid%phys_domain,   &
               oldgrid%ldomain_min_x, &
               oldgrid%ldomain_max_x, &
               oldgrid%ldomain_min_y, &
               oldgrid%ldomain_max_y, &
               oldgrid%center_x,      &
               oldgrid%center_y,      &
               oldgrid%corner_x,      &
               oldgrid%corner_y,      &
               oldgrid%bound_box )

    nullify(oldgrid%dim_size,      &
            oldgrid%phys_domain,   &
            oldgrid%ldomain_min_x, &
            oldgrid%ldomain_max_x, &
            oldgrid%ldomain_min_y, &
            oldgrid%ldomain_max_y, &
            oldgrid%center_x,      &
            oldgrid%center_y,      &
            oldgrid%corner_x,      &
            oldgrid%corner_y,      &
            oldgrid%bound_box )

   if (associated(oldgrid%mask)) deallocate(oldgrid%mask)
   nullify(oldgrid%mask)
   
   if (associated(oldgrid%area)) deallocate(oldgrid%area)
   nullify(oldgrid%area)

!-----------------------------------------------------------------------
!EOC

 end subroutine SCRIP_Grid_Destroy

!***********************************************************************
!BOP
! !IROUTINE: SCRIP_Grid_Set
! !INTERFACE:

 subroutine SCRIP_Grid_Set(in_grid, name, units, phys_domain,  &
                                    center_x, center_y,        &
                                    corner_x, corner_y,        &
                                    mask, area)

! !DESCRIPTION:
!  This subroutine sets or resets individual components of a SCRIP grid 
!  structure.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   character (*), intent(in), optional :: &
      name,                     &! name for grid
      units                      ! coordinate units (degrees,radians)

   integer (int_kind), dimension(:,:), intent(in), optional ::&
      phys_domain                ! beg,end indices for physical domain
                                 !  in each subdomain

   real (dbl_kind), dimension(:,:,:), intent(in), optional :: &
      center_x, center_y         ! coordinates of cell centers

   real (dbl_kind), dimension(:,:,:,:), intent(in), optional :: &
      corner_x, corner_y         ! coordinates of cell corners

   logical (log_kind), dimension(:,:,:), intent(in), optional :: &
      mask

   real (dbl_kind), dimension(:,:,:), intent(in), optional :: &
      area                       ! area of each grid cell

! !INPUT/OUTPUT PARAMETERS:

   type (SCRIPgrid), intent(out) :: &
      in_grid                    ! grid structure to which component
                                 ! is added or reset

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   integer (int_kind) ::   &
      i,j,k,n,nextn,       &! loop indices
      nx,ny,nsbdm           ! useful size limits

!-----------------------------------------------------------------------
!
!  determine which component is being set and set that piece accordingly
!
!-----------------------------------------------------------------------

   if (present(name)) then
      in_grid%name = ' '
      in_grid%name = name
   endif

   if (present(phys_domain)) then
      in_grid%phys_domain = phys_domain
   endif

   !***
   !*** WARNING: none of these checks units!
   !***

   if (present(units)) then
      if (units /= 'radians') call abort_code( &
         'Error in SCRIP_Grid_Set: units other than radians not yet supported')
   endif

   if (present(center_x)) then
      in_grid%center_x = center_x
   endif

   if (present(center_y)) then
      in_grid%center_y = center_y
   endif

   if (present(corner_x)) then
      in_grid%corner_x = corner_x
   endif

   if (present(corner_y)) then
      in_grid%corner_y = corner_y
   endif

   !*** these were optional in the create method, so
   !*** must check whether already allocated or not

   if (present(mask)) then
      if (associated(in_grid%mask)) then
         in_grid%mask = mask
      else
         nx    = size(in_grid%center_x, dim=1)
         ny    = size(in_grid%center_x, dim=2)
         nsbdm = size(in_grid%center_x, dim=3)
         allocate(in_grid%mask(nx,ny,nsbdm))
         in_grid%mask = mask
      endif
   endif

   if (present(area)) then
      if (associated(in_grid%area)) then
         in_grid%area = area
      else
         nx    = size(in_grid%center_x, dim=1)
         ny    = size(in_grid%center_x, dim=2)
         nsbdm = size(in_grid%center_x, dim=3)
         allocate(in_grid%area(nx,ny,nsbdm))
         in_grid%area = area
      endif
   endif

!-----------------------------------------------------------------------
!EOC

   end subroutine SCRIP_Grid_Set

!***********************************************************************
!BOP
! !IROUTINE: SCRIP_Grid_RemovePoints
! !INTERFACE:

 subroutine SCRIP_Grid_RemovePoints(in_grid)

! !DESCRIPTION:
!  Given a grid structure with an existing mask, this subroutine 
!  examines all the local subdomains and replaces the existing mask
!  with a mask that is false for duplicate points.  Note that this
!  new mask will be true on all unique ghost cells so no longer masks
!  ghost cell domains.  It is used primarily in regrid routines where
!  ghost cell information is needed for local regridding.
!
! !REVISION HISTORY:
!  same as module

! !INPUT/OUTPUT PARAMETERS:

   type (SCRIPgrid), intent(out) :: &
      in_grid                    ! grid structure to which component
                                 ! is added or reset

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   integer (int_kind) ::   &
      i,j,k,ii,jj,kk,      &! loop indices
      nx,ny,nsbdm           ! useful size limits

   logical (log_kind), dimension(:,:,:), allocatable :: &
      new_mask

   real (dbl_kind) :: &
      xref, yref       ! coordinate temps for comparison

!-----------------------------------------------------------------------
!
!  determine size parameters and allocate temporary for new grid
!
!-----------------------------------------------------------------------

   nx    = size(in_grid%center_x, dim=1)
   ny    = size(in_grid%center_x, dim=2)
   nsbdm = size(in_grid%center_x, dim=3)

   allocate(new_mask(nx,ny,nsbdm))
   new_mask = .true.

!-----------------------------------------------------------------------
!
!  first set mask false for ghost cells duplicating physical cells
!
!-----------------------------------------------------------------------

   do k=1,nsbdm
   do j=1,ny
   do i=1,nx
      if (in_grid%mask(i,j,k)) then
         xref = in_grid%center_x(i,j,k)
         yref = in_grid%center_y(i,j,k)

         do kk=1,nsbdm
         do jj=1,ny
         do ii=1,nx
            if (.not. in_grid%mask(ii,jj,kk) .and. &
                new_mask(ii,jj,kk)) then ! ghost cell not already tagged
               if (xref == in_grid%center_x(ii,jj,kk) .and. &
                   yref == in_grid%center_y(ii,jj,kk)) then
                  new_mask(ii,jj,kk) = .false.
               endif
            endif
         enddo
         enddo
         enddo
      endif
   enddo
   enddo
   enddo

!-----------------------------------------------------------------------
!
!  now set mask false for cells that duplicate other ghost cells
!
!-----------------------------------------------------------------------

   do k=1,nsbdm
   do j=1,ny
   do i=1,nx
      if (.not. in_grid%mask(i,j,k) .and. new_mask(i,j,k)) then
         xref = in_grid%center_x(i,j,k)
         yref = in_grid%center_y(i,j,k)

         kk = k
         jj = j
         do ii=i+1,nx
            if (new_mask(ii,jj,kk)) then ! not already tagged
               if (xref == in_grid%center_x(ii,jj,kk) .and. &
                   yref == in_grid%center_y(ii,jj,kk)) then
                  new_mask(ii,jj,kk) = .false.
               endif
            endif
         enddo
         do jj=j+1,ny
         do ii=1,nx
            if (new_mask(ii,jj,kk)) then ! not already tagged
               if (xref == in_grid%center_x(ii,jj,kk) .and. &
                   yref == in_grid%center_y(ii,jj,kk)) then
                  new_mask(ii,jj,kk) = .false.
               endif
            endif
         enddo
         enddo
         do kk=k+1,nsbdm
         do jj=1,ny
         do ii=1,nx
            if (new_mask(ii,jj,kk)) then ! not already tagged
               if (xref == in_grid%center_x(ii,jj,kk) .and. &
                   yref == in_grid%center_y(ii,jj,kk)) then
                  new_mask(ii,jj,kk) = .false.
               endif
            endif
         enddo
         enddo
         enddo
      endif
   enddo
   enddo
   enddo

!-----------------------------------------------------------------------
!
!  set new mask and deallocate temporary mask array
!
!-----------------------------------------------------------------------

   in_grid%mask = new_mask
   deallocate(new_mask)

!-----------------------------------------------------------------------
!EOC

   end subroutine SCRIP_Grid_RemovePoints

!***********************************************************************
!BOP
! !IROUTINE: SCRIP_Grid_Search
! !INTERFACE:

 subroutine SCRIP_grid_search(location, grid, xsrch, ysrch)

! !DESCRIPTION:
!  This routine searches a grid for the cell containing an
!  input search point.  Note that this routine only searches local
!  cells - it will not search off node on distributed memory machines.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   real (dbl_kind), intent(in) :: &
      xsrch, ysrch           ! coordinates of search point

   type (SCRIPgrid), intent(in) :: &
      grid                ! grid to search for location of above point

! !INPUT/OUTPUT PARAMETERS:

   integer (int_kind), dimension(grid_rank), intent(inout) :: &
      location      ! on  input: initial guess for location in grid
                    ! on output: address of cell in grid containing
                    !            the search point

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   integer (int_kind) :: &
      i,j,n,             &! loop counters
      ib,ie,jb,je,       &! beg,end index of physical domain 
      pass,              &! search pass index
      nx,ny,nsbdm         ! grid array limits

   real (dbl_kind) :: &
      xtmp, refx          ! temps for correcting longitude 0,2pi probs
      
   real (dbl_kind), dimension(:), allocatable :: &
      xcorner, ycorner    ! x,y corner coordinates for a given cell

   logical (log_kind) :: &
      found               ! true if search successful

!-----------------------------------------------------------------------
!
!  if a valid initial guess has been provided, check this cell now
!
!-----------------------------------------------------------------------

   found = .false.
   allocate(xcorner(grid%num_corners), &
            ycorner(grid%num_corners))

   if (all(location > 0) .and. all(location < grid%dim_size)) then
      i = location(1)
      j = location(2)
      n = location(3)
      xcorner = grid%corner_x(:,i,j,n)
      ycorner = grid%corner_y(:,i,j,n)
      found = SCRIP_cross_product_test(xsrch, ysrch, xcorner, ycorner)
      if (found) then
         deallocate(xcorner, ycorner)
         return
      endif
   endif

!-----------------------------------------------------------------------
!
!  loop through grid to find cell containing search point
!
!-----------------------------------------------------------------------

   nx    = grid%dim_size(1)
   ny    = grid%dim_size(2)
   nsbdm = grid%dim_size(3)

   location = 0 ! default is zero if no cell location found

   srch_loop: do pass=1,1 ! first check phys domain, then expand to 
                          ! ghost cells
   subdomain_loop: do n=1,nsbdm

      !***
      !*** first check domain limits to see if point lies in this
      !*** subdomain.  if not, skip rest.
      !***

      !*** correct for proper 0,2pi interval
      
      refx = grid%center_x(nx/2,ny/2,n)
      xtmp = xsrch
      if ((xtmp - refx) >  pi) xtmp = xtmp - pi2
      if ((xtmp - refx) < -pi) xtmp = xtmp + pi2

      if (xtmp  < grid%ldomain_min_x(n) .or. &
          xtmp  > grid%ldomain_max_x(n) .or. &
          ysrch < grid%ldomain_min_y(n) .or. &
          ysrch > grid%ldomain_max_y(n) ) cycle subdomain_loop
          
      !*** point lies in subdomain bounding box so
      !*** continue search by checking each cell in
      !*** this subdomain

      if (pass == 1) then
         ib = grid%phys_domain(1,n)
         ie = grid%phys_domain(2,n)
         jb = grid%phys_domain(3,n)
         je = grid%phys_domain(4,n)
      else
         ib = 1
         ie = nx
         jb = 1
         je = ny
      endif

      cell_loopj: do j=jb,je
      cell_loopi: do i=ib,ie

         !*** first check cell bounding box before doing
         !*** more thorough search.  if point does not lie
         !*** in cell bound box, skip to next cell.
            
         refx = grid%center_x(i,j,n)
         if ((xtmp - refx) >  pi) xtmp = xtmp - pi2
         if ((xtmp - refx) < -pi) xtmp = xtmp + pi2

         if (xtmp  < grid%bound_box(1,i,j,n) .or. &
             xtmp  > grid%bound_box(2,i,j,n) .or. &
             ysrch < grid%bound_box(3,i,j,n) .or. &
             ysrch > grid%bound_box(4,i,j,n) ) cycle cell_loopi

         !*** congratulations.  you have jumped through
         !*** another hoop successfully.  now do a full
         !*** search
               
         location(1) = i
         location(2) = j
         location(3) = n
         xcorner = grid%corner_x(:,i,j,n)
         ycorner = grid%corner_y(:,i,j,n)
         found = SCRIP_cross_product_test(xtmp, ysrch, xcorner, ycorner)

         if (found) exit srch_loop  ! Success.  Shut down and go home.

      end do cell_loopi
      end do cell_loopj
   end do subdomain_loop
   end do srch_loop

   deallocate(xcorner, ycorner)

!-----------------------------------------------------------------------
!EOC

 end subroutine SCRIP_Grid_Search

!***********************************************************************
!BOP
! !IROUTINE: SCRIP_cross_product_test
! !INTERFACE:

 function SCRIP_cross_product_test(xsrch, ysrch, xcorners, ycorners)

! !DESCRIPTION:
!  This function determines whether the point xsrch,ysrch is located
!  within the grid cell (identified by the location) using a cross
!  product test.  The cross product of the vector formed by a cell
!  side and the vector pointing from the vertex to the search point
!  must be the same sign for all sides if the point is contained
!  in the cell.
!
!  NOTE: This search will fail for grid cells which are non convex.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   real (dbl_kind), intent(in) :: &
      xsrch, ysrch           ! input point to check for location in
                             ! in grid cell

   real (dbl_kind), dimension(:), intent(in) :: &
      xcorners, ycorners     ! x,y coordinates of corners of grid
                             ! cell to test

! !OUTPUT

   logical (log_kind) :: &
      SCRIP_cross_product_test  ! true if cell contains search point

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   integer (int_kind) ::     &
      ncorn, next_n,   &! corner index
      num_corners,     &! number of corners in each grid cell
      i,j,k             ! address of test cell in grid

   real (dbl_kind) ::        &
      vec1_x, vec1_y,  &! components of the cell side vector
      vec2_x, vec2_y,  &! components of the vector from vertex to point
      cross_product,   &! cross product of two vectors
      ref_product,     &! the cross product for first non-zero value
      test_product      ! test to see if cross products are same sign

!-----------------------------------------------------------------------
!
!  perform the cross product for each cell side
!
!-----------------------------------------------------------------------

   num_corners = size(xcorners,dim=1)

   corner_loop: do ncorn=1,num_corners
      next_n = MOD(ncorn,num_corners) + 1

      !***
      !*** here we take the cross product of the vector making
      !*** up each cell side with the vector formed by the vertex
      !*** and search point.  if all the cross products are
      !*** the same sign, the point is contained in the cell.
      !***

      vec1_x = xcorners(next_n) - xcorners(ncorn)
      vec1_y = ycorners(next_n) - ycorners(ncorn)
      vec2_x = xsrch            - xcorners(ncorn)
      vec2_y = ysrch            - ycorners(ncorn)

      !***
      !*** if search point coincident with vertex
      !*** then cell contains the point
      !***

      if (vec2_x == c0 .and. vec2_y == c0) then
         SCRIP_cross_product_test = .true.
         exit corner_loop
      endif

      !***
      !*** if cell side has zero length (degenerate vertices)
      !*** then skip the side and move on to the next
      !***

      if (vec1_x == c0 .and. vec1_y == c0) cycle corner_loop

      !***
      !*** check for 0,2pi crossings in longitude
      !*** Note that this assumes that if the coordinates have
      !*** been changed to a polar projection for pole points,
      !*** that x,y are small and differences won't exceed pi.
      !***

      if (vec1_x >  pi) then
         vec1_x = vec1_x - pi2
      else if (vec1_x < -pi) then
         vec1_x = vec1_x + pi2
      endif
      if (vec2_x >  pi) then
         vec2_x = vec2_x - pi2
      else if (vec2_x < -pi) then
         vec2_x = vec2_x + pi2
      endif

      !*** compute cross product of two vectors
      
      cross_product = vec1_x*vec2_y - vec2_x*vec1_y

      !***
      !*** if the cross product is zero, the point
      !*** lies exactly on the side and is contained in the cell
      !***

      if (cross_product == c0) then
         SCRIP_cross_product_test = .true.
         exit corner_loop
      endif

      !***
      !*** if this is the first side, set a reference cross product
      !*** to the current value
      !*** otherwise, if this product is a different sign than
      !*** previous (reference) cross products, exit the loop
      !***

      if (ref_product == c0) then
         ref_product = cross_product
         test_product = c1
      else
         test_product = cross_product*ref_product
      endif
      if (test_product < c0) exit corner_loop

   end do corner_loop

   !***
   !*** if cross products all same sign this location contains the pt
   !***

   if (test_product > c0) then
      SCRIP_cross_product_test = .true.
   else
      SCRIP_cross_product_test = .false.
   endif

!-----------------------------------------------------------------------
!EOC

 end function SCRIP_cross_product_test

!***********************************************************************
!BOP
! !IROUTINE: SCRIP_Grid_Intersect
! !INTERFACE:

 subroutine SCRIP_Grid_Intersect(location, x_intersect, y_intersect, &
                                 xoff, yoff, lcoinc, grid,           &
                                 xbeg, ybeg, xend, yend, full_line,  &
                                 subdomain)

! !DESCRIPTION:
!  Given the endpoints of a line segment, this routine finds the next 
!  intersection of that line segment with a grid line of an input grid. 
!  The location of the beginning point in the grid is returned together
!  with the intersection point.  A coincidence flag is returned if the 
!  segment is entirely coincident with a grid line.  If the segment
!  lies entirely within a grid cell (no intersection), the endpoints
!  of the segment are returned as the intersection point.  If the
!  beginning point lies outside the grid, a location of zero is 
!  returned but an intersection may still be returned if the segment
!  enters the grid from outside the grid domain.  If the current segment
!  is a sub-segment of a longer line segment, an optional argument with
!  the coordinates of the longer segment endpoints can be supplied
!  to provide consistent intersections along the longer segment.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   real (dbl_kind), intent(in) :: &
      xbeg, ybeg,  &! coordinates of beginning endpoint for segment
      xend, yend    ! coordinates of ending    endpoint for segment

   type (SCRIPGrid), intent(in) :: &
      grid          ! grid to search for intersections

   real (dbl_kind), dimension(4), intent(in) :: & 
      full_line ! coordinates of beginning and end of full
                ! line segment of which the above coordinates are part

   integer (int_kind), intent(in), optional :: &
      subdomain     ! index of subdomain to search, 
                    ! 0 or absent value implies search entire local grid

! !INPUT/OUTPUT PARAMETERS:

   integer (int_kind), dimension(3), intent(inout) :: &
      location  ! address of grid cell containing beginning of segment
                ! on input may contain initial guess for location

! !OUTPUT PARAMETERS:

   real (dbl_kind), intent(out) :: &
      x_intersect,  &! coordinates of next intersection with grid
      y_intersect,  &!
      xoff, yoff     ! amount to offset each coordinate for next subsegment

   logical (log_kind), intent(out) :: &
      lcoinc    ! true if segment is entirely coincident with grid line

!EOP
!BOC
!-----------------------------------------------------------------------
!
!     local variables
!
!-----------------------------------------------------------------------

   integer (int_kind) :: &
      i,j,k,       &! dummies for addresses
      ib,ie,jb,je, &! beg,end index for physical domain
      kb,ke,       &! beg,end index for subdomains to search
      pass,        &! index for search pass
      n, next_n,   &! loop index, next index
      nx, ny,      &! grid axis sizes
      sbdm          ! subdomain id

   logical (log_kind) :: & 
      lreverse,          &! segment in opposite direction of full segment
      lthresh,           &! flags segments crossing threshold bndy
      loutside,          &! true if beg point outside grid
      found               ! true if grid cell found

   real (dbl_kind), parameter :: &
      offset = 1.d-10

   real (dbl_kind) ::         &
      xtmp, refx,             &! temporaries for manipulating longitudes
      xb, yb, xe, ye,         &! local coordinates for segment endpoints
      x1, y1, x2, y2,         &! coordinates for grid side endpoints
      dx, dy,                 &! difference in x,y for stepping along seg
      s1, s2, determ,         &! variables used for linear solve to
      mat1, mat2, mat3, mat4, &! matrix entries for intersect linear system
      rhs1, rhs2,             &! rhs for linear system to find intersect
      vec1_x, vec1_y,         &! vectors for cross product tests
      vec2_x, vec2_y,         &!
      cross_product            ! cross product to use in various tests 

   real (dbl_kind), dimension(:), allocatable :: &
      xcorner, ycorner    ! x,y corner coordinates for a given cell

!-----------------------------------------------------------------------
!
!  initialize defaults, flags, etc.
!
!-----------------------------------------------------------------------

   lreverse = .false.
   lcoinc   = .false.
   lthresh  = .false.
   loutside = .false.
   if (present(subdomain)) then
      sbdm = subdomain
   else
      sbdm = 0
   endif
   x_intersect = xend
   y_intersect = yend
   xoff = c0
   yoff = c0
   s1   = 0.01d0
   s2   = c0
   xb = xbeg
   yb = ybeg
   xe = xend
   ye = yend
   if ((xe-xb) > 1.5*pi) then
      xe = xe - pi2
   else if ((xe-xb) < -1.5*pi) then
      xe = xe + pi2
   endif
   dx = xe - xb
   dy = ye - yb
   if (xend == full_line(1) .and. &
       yend == full_line(2)) lreverse = .true.

!-----------------------------------------------------------------------
!
!  search for location of the beginning of the segment in input grid
!
!-----------------------------------------------------------------------

   !***
   !*** if a valid initial guess has been provided, check this cell now
   !***

   i = location(1)
   j = location(2)
   k = location(3)
   found = .false.
   !if (k > 0 .and. k < grid%dim_size(3)) then
   !   if (i >= grid%phys_domain(1,k) .and. &
   !       i <= grid%phys_domain(2,k) .and. &
   !       j >= grid%phys_domain(3,k) .and. &
   !       j <= grid%phys_domain(4,k)) then
!
!         allocate(xcorner(grid%num_corners), &
!                  ycorner(grid%num_corners))
!         xcorner = grid%corner_x(:,i,j,k)
!         ycorner = grid%corner_y(:,i,j,k)
!         found = SCRIP_cross_product_test(xb, yb, xcorner, ycorner)
!         deallocate(xcorner, ycorner)
!      endif
!   endif

   if (yb > north_thresh .or. yb < south_thresh) then
      call SCRIP_Grid_PoleIntersect( &
                                 location, x_intersect, y_intersect, &
                                 xoff, yoff, lcoinc, grid,           &
                                 xbeg, ybeg, xend, yend, full_line, sbdm)
      return
   endif

   !***
   !*** if no initial guess or guess is wrong, perform search
   !*** loop through grid to find cell containing search point
   !***

   nx    = grid%dim_size(1)
   ny    = grid%dim_size(2)
   if (sbdm /= 0) then
      kb = sbdm
      ke = sbdm
   else
      kb = 1
      ke = grid%dim_size(3)
   endif

   if (.not. found) then

   location = 0 ! default is zero if no cell location found

   srch_loop: do
   pass_loop: do pass=1,2  ! on first pass, check physical domain
                           ! on second pass, expand to ghost cells
   subdomain_loop: do k=kb,ke

      !***
      !*** first check domain limits to see if point lies in this
      !*** subdomain.  if not, skip rest.
      !***

      !*** correct for proper 0,2pi interval
      
      refx = grid%center_x(nx/2,ny/2,k)

      if ((xb - refx) > pi) then
         xb = xb - pi2
         xe = xe - pi2
      endif
      if ((xb - refx) < -pi) then
         xb = xb + pi2
         xe = xe + pi2
      endif

      if (xb < grid%ldomain_min_x(k) .or. &
          xb > grid%ldomain_max_x(k) .or. &
          yb < grid%ldomain_min_y(k) .or. &
          yb > grid%ldomain_max_y(k) ) cycle subdomain_loop
          

      !*** point lies in subdomain bounding box so
      !*** continue search by checking each cell in
      !*** this subdomain

      !if (pass == 1) then
      !   ib = grid%phys_domain(1,k)
      !   ie = grid%phys_domain(2,k)
      !   jb = grid%phys_domain(3,k)
      !   je = grid%phys_domain(4,k)
      !else
         ib = 1
         ie = nx
         jb = 1
         je = ny
      !endif

      cell_loopj: do j=jb,je
      cell_loopi: do i=ib,ie

         !*** first check cell bounding box before doing
         !*** more thorough search.  if point does not lie
         !*** in cell bound box, skip to next cell.
            
         if (pass == 1 .and. .not. grid%mask(i,j,k)) cycle cell_loopi
         refx = grid%center_x(i,j,k)
         if ((xb - refx) >  pi) then
            xb = xb - pi2
            xe = xe - pi2
         endif
         if ((xb - refx) < -pi) then
            xb = xb + pi2
            xe = xe + pi2
         endif

         if (xb < grid%bound_box(1,i,j,k) .or. &
             xb > grid%bound_box(2,i,j,k) .or. &
             yb < grid%bound_box(3,i,j,k) .or. &
             yb > grid%bound_box(4,i,j,k) ) cycle cell_loopi

         !*** congratulations.  you have jumped through
         !*** another hoop successfully.  now do a full
         !*** search

         corner_loop: do n=1,grid%num_corners
            next_n = MOD(n,grid%num_corners) + 1

            !***
            !*** here we take the cross product of the vector making 
            !*** up each cell side with the vector formed by the vertex
            !*** and search point.  if all the cross products are 
            !*** the same sign, the point is contained in the cell.
            !***

            x1 = grid%corner_x(     n,i,j,k)
            x2 = grid%corner_x(next_n,i,j,k)
            y1 = grid%corner_y(     n,i,j,k)
            y2 = grid%corner_y(next_n,i,j,k)

            vec1_x = x2 - x1
            vec1_y = y2 - y1
            vec2_x = xb - x1
            vec2_y = yb - y1

            !***
            !*** if this side has zero length, skip the side
            !***
               
            if (vec1_x == c0 .and. vec1_y == c0) cycle corner_loop

            !***
            !*** if endpoint coincident with vertex, offset
            !*** the endpoint before computing cross product
            !***

            if (vec2_x == 0 .and. vec2_y == 0) then
               vec2_x = (xb + offset*(xe-xb)) - x1
               vec2_y = (yb + offset*(ye-yb)) - y1
            endif

            cross_product = vec1_x*vec2_y - vec2_x*vec1_y

            if (cross_product == c0) then
               !***
               !*** if the cross product for a side is zero, the point 
               !***   lies exactly on the side. perform another cross
               !***   product between the side and the segment itself. 
               !*** if this cross product is also zero, the line is 
               !***   coincident with the cell boundary - perform the 
               !***   dot product and only choose the cell if the dot 
               !***   product is positive (parallel vs anti-parallel).
               !***

               vec2_x = xe - xb
               vec2_y = ye - yb

               cross_product = vec1_x*vec2_y - vec2_x*vec1_y

               if (cross_product == c0) then
                  lcoinc = .true.
                  cross_product = vec1_x*vec2_x + vec1_y*vec2_y
                  if (lreverse) cross_product = -cross_product
               endif
            endif

            !***
            !*** if cross product is less than zero, this cell
            !*** doesn't work
            !***

            if (cross_product < c0) exit corner_loop

         end do corner_loop

         !***
         !*** if cross products all positive, we found the location
         !***

         if (n > grid%num_corners) then
            found = .true.
            location(1) = i
            location(2) = j
            location(3) = k
            exit srch_loop
         endif

         !***
         !*** otherwise move on to next cell
         !***

      end do cell_loopi
      end do cell_loopj
   end do subdomain_loop
   end do pass_loop

   !***
   !*** cell not found - assume beg point outside grid
   !*** take baby steps along segment to find a point inside
   !*** the grid
   !***

   s2 = s2 + s1
   if (s2 > c1) exit srch_loop
   loutside = .true.
   xb = xb + s1*dx
   yb = yb + s1*dy
   
   end do srch_loop
   endif ! not found

   !***
   !*** if the first part of the segment was outside the grid
   !*** the found point corresponds to the first point inside the
   !*** grid. invert the segment to find first intersection with
   !*** grid boundary
   !*** 

   if (loutside) then
      xe = xbeg
      ye = ybeg
      location = 0
   endif

!-----------------------------------------------------------------------
!
!     now that a cell is found, search for the next intersection.
!     loop over sides of the cell to find intersection with side
!     must check all sides for coincidences or intersections
!
!-----------------------------------------------------------------------

   if (found) then

      intrsct_loop: do n=1,grid%num_corners
         next_n = mod(n,grid%num_corners) + 1

         x1 = grid%corner_x(n     ,i,j,k)
         x2 = grid%corner_x(next_n,i,j,k)
         y1 = grid%corner_y(n     ,i,j,k)
         y2 = grid%corner_y(next_n,i,j,k)

         !***
         !*** set up linear system to solve for intersection
         !***

         mat1 = xe - xb
         mat2 = x1 - x2
         mat3 = ye - yb
         mat4 = y1 - y2
         rhs1 = x1 - xb
         rhs2 = y1 - yb

         if (mat1 >  pi) then
            mat1 = mat1 - pi2
         else if (mat1 < -pi) then
            mat1 = mat1 + pi2
         endif
         if (mat2 >  pi) then
            mat2 = mat2 - pi2
         else if (mat2 < -pi) then
            mat2 = mat2 + pi2
         endif
         if (rhs1 >  pi) then
            rhs1 = rhs1 - pi2
         else if (rhs1 < -pi) then
            rhs1 = rhs1 + pi2
         endif

         determ = mat1*mat4 - mat2*mat3

         !***
         !*** if the determinant is zero, the segments are either 
         !***   parallel or coincident.  coincidences were detected 
         !***   above so do nothing.
         !*** if the determinant is non-zero, solve for the linear 
         !***   parameters s for the intersection point on each line 
         !***   segment.
         !*** if 0<s1,s2<1 then the segment intersects with this side.
         !***   return the point of intersection (adding a small
         !***   number so the intersection is off the grid line).
         !***

         if (abs(determ) > 1.e-30) then

            s1 = (rhs1*mat4 - mat2*rhs2)/determ
            s2 = (mat1*rhs2 - rhs1*mat3)/determ

            if (s2 >= c0 .and. s2 <= c1 .and. &
                s1 >  c0 .and. s1 <= c1) then

               !***
               !*** recompute intersection based on full 
               !*** segment so intersections are consistent in cases
               !*** where computing intersections between two grids
               !***

               if (.not. lreverse) then
                  mat1 = full_line(3) - full_line(1)
                  mat3 = full_line(4) - full_line(2)
                  rhs1 = x1 - full_line(1)
                  rhs2 = y1 - full_line(2)
               else
                  mat1 = full_line(1) - full_line(3)
                  mat3 = full_line(2) - full_line(4)
                  rhs1 = x1 - full_line(3)
                  rhs2 = y1 - full_line(4)
               endif

               if (mat1 >  pi) then
                  mat1 = mat1 - pi2
               else if (mat1 < -pi) then
                  mat1 = mat1 + pi2
               endif
               if (rhs1 >  pi) then
                  rhs1 = rhs1 - pi2
               else if (rhs1 < -pi) then
                  rhs1 = rhs1 + pi2
               endif

               determ = mat1*mat4 - mat2*mat3

               !***
               !*** sometimes due to roundoff, the previous 
               !*** determinant is non-zero, but the lines
               !*** are actually coincident.  if this is the
               !*** case, skip the rest.
               !***

               if (determ /= c0) then
                  s1 = (rhs1*mat4 - mat2*rhs2)/determ
                  s2 = (mat1*rhs2 - rhs1*mat3)/determ

                  xoff = abs(offset/determ)
                  if (s1 + xoff > c1) xoff = c1 - s1
                  yoff = mat3*xoff
                  xoff = mat1*xoff

                  if (.not. lreverse) then
                     x_intersect = full_line(1) + mat1*s1
                     y_intersect = full_line(2) + mat3*s1
                  else
                     x_intersect = full_line(3) + mat1*s1
                     y_intersect = full_line(4) + mat3*s1
                  endif
                  exit intrsct_loop
               endif
            endif
         endif

         !***
         !*** no intersection this side, move on to next side
         !***

      end do intrsct_loop

      !***  if intersection crosses pole threshold, reset intersection to
      !***  threshold lat

      if (y_intersect > north_thresh .or. &
          y_intersect < south_thresh) then
         if (y_intersect > c0) then
            y_intersect = north_thresh
         else
            y_intersect = south_thresh
         endif
         if (.not. lreverse) then
            s1 = (y_intersect - full_line(2))/mat3
            x_intersect = full_line(1) + mat1*s1
         else
            s1 = (y_intersect - full_line(4))/mat3
            x_intersect = full_line(3) + mat1*s1
         endif
         if (xoff == c0) then  ! no intersection from above
            yoff = mat3*offset
            xoff = mat1*offset
         endif
      endif

   endif ! found cell

!-----------------------------------------------------------------------
!EOC

   end subroutine SCRIP_Grid_Intersect

!***********************************************************************
!BOP
! !IROUTINE: SCRIP_Grid_PoleIntersect
! !INTERFACE:

 subroutine SCRIP_Grid_PoleIntersect( &
                                 location, x_intersect, y_intersect, &
                                 xoff, yoff, lcoinc, grid,           &
                                 xbeg, ybeg, xend, yend, full_line,  &
                                 subdomain)

! !DESCRIPTION:
!  Performs the same function as SCRIP\_Grid\_Intersect except that
!  it performs a coordinate transformation to a cartesian projection
!  to avoid polar singularity in lat/lon space.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   real (dbl_kind), intent(in) :: &
      xbeg, ybeg,  &! coordinates of beginning endpoint for segment
      xend, yend    ! coordinates of ending    endpoint for segment

   type (SCRIPGrid), intent(in) :: &
      grid          ! grid to search for intersections

   real (dbl_kind), dimension(4), intent(in) :: & 
      full_line ! coordinates of beginning and end of full
                ! line segment of which the above coordinates are part

   integer (int_kind), intent(in) :: &
      subdomain     ! index of subdomain to search, 
                    ! 0 implies search entire local grid

! !INPUT/OUTPUT PARAMETERS:

   integer (int_kind), dimension(3), intent(inout) :: &
      location  ! address of grid cell containing beginning of segment
                ! on input may contain initial guess for location

! !OUTPUT PARAMETERS:

   real (dbl_kind), intent(out) :: &
      x_intersect,  &! coordinates of next intersection with grid
      y_intersect,  &!
      xoff, yoff     ! amount to offset each coordinate for next subsegment

   logical (log_kind), intent(out) :: &
      lcoinc    ! true if segment is entirely coincident with grid line

!EOP
!BOC
!-----------------------------------------------------------------------
!
!     local variables
!
!-----------------------------------------------------------------------

   integer (int_kind) :: &
      i,j,k,       &! dummies for addresses
      ib,ie,jb,je, &! beg,end index of physical domain
      kb,ke,       &! beg,end index of subdomain search
      pass,        &! index for pass of search loop
      n, next_n,   &! loop index, next index
      nx, ny, nsbdm ! grid axis sizes

   logical (log_kind) :: & 
      lreverse,          &! segment opposite direction of full segment
      loutside,          &! point outside of search grid
      found               ! true if grid cell found

   real (dbl_kind), parameter :: &
      offset = 1.d-8

   real (dbl_kind) ::         &
      xtmp, refx,             &! temporaries for manipulating longitudes
      xb, yb, xe, ye,         &! local coordinates for segment endpoints
      x1, y1, x2, y2,         &! coordinates for grid side endpoints
      dx, dy,                 &! difference in x,y for stepping along seg
      s1, s2, determ,         &! variables used for linear solve to
      mat1, mat2, mat3, mat4, &! matrix entries for intersect linear system
      rhs1, rhs2,             &! rhs for linear system to find intersect
      vec1_x, vec1_y,         &! vectors for cross product tests
      vec2_x, vec2_y,         &!
      cross_product            ! cross product to use in various tests 

   real (dbl_kind), dimension(4) :: &
      bbox, bbox_x, bbox_y,   &! bound box in transformed coords
      full_line_xy             ! xy coords of full line

   real (dbl_kind), dimension(:), allocatable :: &
      xcorner, ycorner    ! x,y corner coordinates for a given cell

!-----------------------------------------------------------------------
!
!  initialize defaults, flags, etc.
!
!-----------------------------------------------------------------------

   lcoinc   = .false.
   loutside = .false.

   if (xend == full_line(1) .and. yend == full_line(2)) then
      lreverse = .true.
   else
      lreverse = .false.
   endif

   x_intersect = xend
   y_intersect = yend

   xoff = c0
   yoff = c0

   call SCRIP_LatLon_to_PoleXY(xb, yb, xbeg, ybeg)
   call SCRIP_LatLon_to_PoleXY(xe, ye, xend, yend)

   allocate(xcorner(grid%num_corners), &
            ycorner(grid%num_corners))

   dx = xe - xb
   dy = ye - yb
   s1 = 0.01d0
   s2 = c0

!-----------------------------------------------------------------------
!
!  search for location of the beginning of the segment in input grid
!
!-----------------------------------------------------------------------

   !***
   !*** if a valid initial guess has been provided, check this cell now
   !***

   found = .false.
   !if (all(location > 0) .and. all(location < grid%dim_size)) then
   !   i = location(1)
   !   j = location(2)
   !   k = location(3)
   !   do n=1,grid%num_corners
   !      call SCRIP_LatLon_to_PoleXY(xcorner(n), ycorner(n), &
   !                                  grid%corner_x(n,i,j,k), &
   !                                  grid%corner_y(n,i,j,k))
   !   end do
   !   found = SCRIP_cross_product_test(xb, yb, xcorner, ycorner)
   !endif

   !***
   !*** if no initial guess or guess is wrong, perform search
   !*** loop through grid to find cell containing search point
   !***

   nx    = grid%dim_size(1)
   ny    = grid%dim_size(2)
   if (subdomain /= 0) then
      kb = subdomain
      ke = subdomain
   else
      kb = 1
      ke = grid%dim_size(3)
   endif

   if (.not. found) then

   location = 0 ! default is zero if no cell location found

   srch_loop: do 
   pass_loop: do pass=1,2  ! on first pass, check only physical domain
                           ! on second pass, expand to ghost cells
   subdomain_loop: do k=kb,ke

      !***
      !*** first check domain limits to see if point lies in this
      !*** subdomain.  if not, skip rest.
      !*** do this check in lat/lon space to avoid transformation
      !*** cost and avoid being in the wrong hemisphere
      !***

      !*** correct for proper 0,2pi interval
      
      refx = grid%center_x(nx/2,ny/2,k)

      xtmp = xbeg
      if ((xtmp - refx) > pi) then
         xtmp = xtmp - pi2
      endif
      if ((xtmp - refx) < -pi) then
         xtmp = xtmp + pi2
      endif

      if (xtmp < grid%ldomain_min_x(k) .or. &
          xtmp > grid%ldomain_max_x(k) .or. &
          ybeg < grid%ldomain_min_y(k) .or. &
          ybeg > grid%ldomain_max_y(k) ) cycle subdomain_loop

      !*** point lies in subdomain bounding box so
      !*** continue search by checking each cell in
      !*** this subdomain

      !if (pass == 1) then
      !   ib = grid%phys_domain(1,k)
      !   ie = grid%phys_domain(2,k)
      !   jb = grid%phys_domain(3,k)
      !   je = grid%phys_domain(4,k)
      !else
         ib = 1
         ie = nx
         jb = 1
         je = ny
      !endif

      cell_loopj: do j=jb,je
      cell_loopi: do i=ib,ie

         if (pass == 1 .and. .not. grid%mask(i,j,k)) cycle cell_loopi

         !*** first check cell bounding box before doing
         !*** more thorough search.  if point does not lie
         !*** in cell bound box, skip to next cell.
            
         !call SCRIP_LatLon_to_PoleXY(bbox_x(1), bbox_y(1),    &
         !                            grid%bound_box(1,i,j,k), &
         !                            grid%bound_box(3,i,j,k))
         !call SCRIP_LatLon_to_PoleXY(bbox_x(2), bbox_y(2),  &
         !                            grid%bound_box(2,i,j,k), &
         !                            grid%bound_box(3,i,j,k))
         !call SCRIP_LatLon_to_PoleXY(bbox_x(3), bbox_y(3),  &
         !                            grid%bound_box(1,i,j,k), &
         !                            grid%bound_box(4,i,j,k))
         !call SCRIP_LatLon_to_PoleXY(bbox_x(4), bbox_y(4),  &
         !                            grid%bound_box(2,i,j,k), &
         !                            grid%bound_box(4,i,j,k))

         !bbox(1) = minval(bbox_x)
         !bbox(2) = maxval(bbox_x)
         !bbox(3) = minval(bbox_y)
         !bbox(4) = maxval(bbox_y)
         !if (grid%bound_box(1,i,j,k) < -100.) then
         !   bbox(1) = -c1
         !   bbox(2) =  c1
         !   bbox(3) = -c1
         !   bbox(4) =  c1
         !endif

         !if (xb < bbox(1) .or. xb > bbox(2) .or. &
         !    yb < bbox(3) .or. yb > bbox(4) ) cycle cell_loopi
          
         !*** congratulations.  you have jumped through
         !*** another hoop successfully.  now do a full
         !*** search

         do n=1,grid%num_corners
            call SCRIP_LatLon_to_PoleXY(xcorner(n), ycorner(n), &
                                        grid%corner_x(n,i,j,k), &
                                        grid%corner_y(n,i,j,k))
         end do

         corner_loop: do n=1,grid%num_corners
            next_n = MOD(n,grid%num_corners) + 1

            !***
            !*** here we take the cross product of the vector making 
            !*** up each cell side with the vector formed by the vertex
            !*** and search point.  if all the cross products are 
            !*** the same sign, the point is contained in the cell.
            !***

            x1 = xcorner(     n)
            x2 = xcorner(next_n)
            y1 = ycorner(     n)
            y2 = ycorner(next_n)

            vec1_x = x2 - x1
            vec1_y = y2 - y1
            vec2_x = xb - x1
            vec2_y = yb - y1

            !***
            !*** if this side has zero length, skip the side
            !***
               
            if (vec1_x == c0 .and. vec1_y == c0) cycle corner_loop

            !***
            !*** if endpoint coincident with vertex, offset
            !*** the endpoint before computing cross product
            !***

            if (vec2_x == 0 .and. vec2_y == 0) then
               vec2_x = (xb + offset*(xe-xb)) - x1
               vec2_y = (yb + offset*(ye-yb)) - y1
            endif

            cross_product = vec1_x*vec2_y - vec2_x*vec1_y

            if (cross_product == c0) then
               !***
               !*** if the cross product for a side is zero, the point 
               !***   lies exactly on the side. perform another cross
               !***   product between the side and the segment itself. 
               !*** if this cross product is also zero, the line is 
               !***   coincident with the cell boundary - perform the 
               !***   dot product and only choose the cell if the dot 
               !***   product is positive (parallel vs anti-parallel).
               !***

               vec2_x = xe - xb
               vec2_y = ye - yb

               cross_product = vec1_x*vec2_y - vec2_x*vec1_y

               if (cross_product == c0) then
                  lcoinc = .true.
                  cross_product = vec1_x*vec2_x + vec1_y*vec2_y
                  if (lreverse) cross_product = -cross_product
               endif
            endif

            !***
            !*** if cross product is less than zero, this cell
            !*** doesn't work
            !***

            if (cross_product < c0) exit corner_loop

         end do corner_loop

         !***
         !*** if cross products all positive, we found the location
         !***

         if (n > grid%num_corners) then
            found = .true.
            location(1) = i
            location(2) = j
            location(3) = k
            exit srch_loop
         endif

         !***
         !*** otherwise move on to next cell
         !***

      end do cell_loopi
      end do cell_loopj
   end do subdomain_loop
   end do pass_loop

   !***
   !*** cell not found - assume beg point outside grid
   !*** take baby steps along segment to find a point inside
   !*** the grid
   !***

   s2 = s2 + s1
   if (s2 > c1) exit srch_loop
   loutside = .true.
   xb = xb + s1*dx
   yb = yb + s1*dy
   

   end do srch_loop

   endif ! not found

   !***
   !*** if the first part of the segment was outside the grid
   !*** the found point corresponds to the first point inside the
   !*** grid. invert the segment to find first intersection with
   !*** grid boundary
   !*** 

   if (loutside) then
      call SCRIP_LatLon_to_PoleXY(xe, ye, xbeg, ybeg)
      location = 0
   endif

!-----------------------------------------------------------------------
!
!     now that a cell is found, search for the next intersection.
!     loop over sides of the cell to find intersection with side
!     must check all sides for coincidences or intersections
!
!-----------------------------------------------------------------------

   if (found) then 

      intrsct_loop: do n=1,grid%num_corners
         next_n = mod(n,grid%num_corners) + 1

         x1 = xcorner(n     )
         x2 = xcorner(next_n)
         y1 = ycorner(n     )
         y2 = ycorner(next_n)

         !***
         !*** set up linear system to solve for intersection
         !***

         mat1 = xe - xb
         mat2 = x1 - x2
         mat3 = ye - yb
         mat4 = y1 - y2
         rhs1 = x1 - xb
         rhs2 = y1 - yb

         determ = mat1*mat4 - mat2*mat3

         !***
         !*** if the determinant is zero, the segments are either 
         !***   parallel or coincident.  coincidences were detected 
         !***   above so do nothing.
         !*** if the determinant is non-zero, solve for the linear 
         !***   parameters s for the intersection point on each line 
         !***   segment.
         !*** if 0<s1,s2<1 then the segment intersects with this side.
         !***   return the point of intersection (adding a small
         !***   number so the intersection is off the grid line).
         !***

         if (abs(determ) > 1.e-30) then

            s1 = (rhs1*mat4 - mat2*rhs2)/determ
            s2 = (mat1*rhs2 - rhs1*mat3)/determ

            if (s2 >= c0 .and. s2 <= c1 .and. &
                s1 >  c0 .and. s1 <= c1) then

               !***
               !*** recompute intersection based on full 
               !*** segment so intersections are consistent in cases
               !*** where computing intersections between two grids
               !***

               call SCRIP_LatLon_to_PoleXY(full_line_xy(1), &
                                           full_line_xy(2), &
                                           full_line(1),    &
                                           full_line(2))
               call SCRIP_LatLon_to_PoleXY(full_line_xy(3), &
                                           full_line_xy(4), &
                                           full_line(3),    &
                                           full_line(4))

               if (.not. lreverse) then
                  mat1 = full_line_xy(3) - full_line_xy(1)
                  mat3 = full_line_xy(4) - full_line_xy(2)
                  rhs1 = x1 - full_line_xy(1)
                  rhs2 = y1 - full_line_xy(2)
               else
                  mat1 = full_line_xy(1) - full_line_xy(3)
                  mat3 = full_line_xy(2) - full_line_xy(4)
                  rhs1 = x1 - full_line_xy(3)
                  rhs2 = y1 - full_line_xy(4)
               endif

               determ = mat1*mat4 - mat2*mat3

               !***
               !*** sometimes due to roundoff, the previous 
               !*** determinant is non-zero, but the lines
               !*** are actually coincident.  if this is the
               !*** case, skip the rest.
               !***

               if (determ /= c0) then
                  s1 = (rhs1*mat4 - mat2*rhs2)/determ
                  s2 = (mat1*rhs2 - rhs1*mat3)/determ

                  xoff = abs(offset/determ)
                  if (s1 + xoff > c1) xoff = c1 - s1
                  yoff = mat3*xoff
                  xoff = mat1*xoff

                  if (.not. lreverse) then
                     x_intersect = full_line_xy(1) + mat1*s1
                     y_intersect = full_line_xy(2) + mat3*s1
                  else
                     x_intersect = full_line_xy(3) + mat1*s1
                     y_intersect = full_line_xy(4) + mat3*s1
                  endif

                  !*** convert back to lat/lon and
                  !*** set ref lat/lon to xbeg,xend
                  !*** use rhs1,2 for intersect lat/lon and
                  !*** mat1,2 for offsets

                  rhs1 = xbeg
                  rhs2 = ybeg
                  mat1 = xbeg
                  mat2 = ybeg
                  call SCRIP_PoleXY_to_LatLon(rhs1, rhs2, &
                                              x_intersect, y_intersect)
                  call SCRIP_PoleXY_to_LatLon(mat1, mat2, &
                                              x_intersect + xoff, &
                                              y_intersect + yoff)
                  x_intersect = rhs1
                  y_intersect = rhs2
                  xoff = mat1 - rhs1
                  yoff = mat2 - rhs2

                  exit intrsct_loop
               endif
            endif
         endif

         !***
         !*** no intersection this side, move on to next side
         !***

      end do intrsct_loop

      !***  if intersection crosses pole threshold, reset intersection to
      !***  threshold lat

      if ((y_intersect > c0 .and. y_intersect < north_thresh) .or. &
          (y_intersect < c0 .and. y_intersect > south_thresh)) then

         if (y_intersect > c0) then
            y_intersect = north_thresh
         else
            y_intersect = south_thresh
         endif
         if (.not. lreverse) then
            mat1 = full_line(3) - full_line(1)
            if (mat1 >  pi) then
               mat1 = mat1 - pi2
            else if (mat1 < -pi) then
               mat1 = mat1 + pi2
            endif
            mat3 = full_line(4) - full_line(2)
            s1 = (y_intersect - full_line(2))/mat3
            x_intersect = full_line(1) + mat1*s1
         else
            mat1 = full_line(1) - full_line(3)
            if (mat1 >  pi) then
               mat1 = mat1 - pi2
            else if (mat1 < -pi) then
               mat1 = mat1 + pi2
            endif
            mat3 = full_line(2) - full_line(4)
            s1 = (y_intersect - full_line(4))/mat3
            x_intersect = full_line(3) + mat1*s1
         endif
         if (xoff == c0) then  ! no intersection from above
            yoff = mat3*offset
            xoff = mat1*offset
         endif
      endif

   endif ! found cell

   deallocate(xcorner, ycorner)

!-----------------------------------------------------------------------
!EOC

   end subroutine SCRIP_Grid_PoleIntersect

!***********************************************************************
!BOP
! !IROUTINE: SCRIP_LatLon_to_PoleXY
! !INTERFACE:

 subroutine SCRIP_LatLon_to_PoleXY(x, y, lon, lat)

! !DESCRIPTION:
!  Converts latitude and longitude to a Cartesian coordinate system
!  of a plane tangent to the pole.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   real (dbl_kind), intent(in) :: &
      lat, lon      ! latitude and longitude coordinates of point 
                    !   to transform to x,y coordinates

! !OUTPUT PARAMETERS:

   real (dbl_kind), intent(out) :: &
      x, y          ! x,y coordinates of point in tangent plane

!EOP
!BOC

   real (dbl_kind) :: &
      rns,            &! sign factor for transformation
      pi4              ! rns*pi/4    for transformation

!-----------------------------------------------------------------------
!
!  transformation to x,y coordinates of plane tangent to pole
!  correct for opposite longitude angle for proper x,y orientation at
!  south pole
!
!-----------------------------------------------------------------------

   !x = cos(lat)*cos(lon)
   !y = cos(lat)*sin(lon)
   !if (lat < c0) y = -y

   if (lat > c0) then
      rns = c1
   else
      rns = -c1
   endif
   pi4 = rns*p25*pi

   x = rns*c2*sin(pi4 - p5*lat)*cos(lon)
   y =     c2*sin(pi4 - p5*lat)*sin(lon)
 
!-----------------------------------------------------------------------
!EOC

 end subroutine SCRIP_LatLon_to_PoleXY

!***********************************************************************
!BOP
! !IROUTINE: SCRIP_PoleXY_to_LatLon
! !INTERFACE:

 subroutine SCRIP_PoleXY_to_LatLon(lon, lat, x, y)

! !DESCRIPTION:
!  Converts latitude and longitude to a Cartesian coordinate system
!  of a plane tangent to the pole.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   real (dbl_kind), intent(in) :: &
      x, y          ! x,y coordinates of point in tangent plane

! !INPUT/OUTPUT PARAMETERS:

   real (dbl_kind), intent(inout) :: &
      lat, lon      ! on output: latitude and longitude coordinates 
                    !            transformed from x,y coordinates
                    ! on input: reference lat/lon to determine both
                    !           north/south transform and to define
                    !           default longitude for degenerate pole

!EOP
!BOC

   real (dbl_kind) :: &
      rns,            &! sign factor for transformation
      pi4,            &! rns*pi/4    for transformation
      lon_tmp          ! temporary placeholder for input lon

!-----------------------------------------------------------------------
!
!  north pole transformation
!
!-----------------------------------------------------------------------

!   if (lat > c0) then
!      lat = acos(sqrt(x**2+y**2))
!
!      if (x == c0 .and. y == c0) then
!         lat = pih
!         lon = lon
!      else if (x == c0) then  ! special case
!         if (y > c0) then
!            lon = pih
!         else
!            lon = c3*pih
!         endif
!      else if (y == c0) then  ! another special case
!         if (x > c0) then
!            lon = c0
!         else
!            lon = pi
!         endif
!      else
!         lon = atan2(y,x)  ! returns -pi,pi interval
!         if (lon < c0) lon = lon + pi2 ! return to 0,2pi interval
!      endif

!-----------------------------------------------------------------------
!
!  south pole transformation
!
!-----------------------------------------------------------------------

!   else
!
!      lat = -acos(sqrt(x**2+y**2))
!
!      if (x == c0 .and. y == c0) then
!         lat = -pih
!         lon = lon
!      else if (x == c0) then  ! special case
!         if (y > c0) then
!            lon = c3*pih
!         else
!            lon = pih
!         endif
!      else if (y == c0) then  ! another special case
!         if (x > c0) then
!            lon = c0
!         else
!            lon = pi
!         endif
!      else
!         lon = atan2(-y,x)  ! returns -pi,pi interval
!         if (lon < c0) lon = lon + pi2 ! return to 0,2pi interval
!      endif
!   endif
    
   if (lat > c0) then
      rns = c1
   else
      rns = -c1
   endif
   pi4 = rns*p25*pi
   lon_tmp = lon  ! store input reference lon for later use

   lon = rns*atan2(y,x)

   if (lon < c0) lon = lon + pi2
 
   if (abs(x) > 1.d-10) then
      lat = (pi4 - asin(rns*p5*x/cos(lon)))*c2
   else if (abs(y) > 1.d-10) then
      lat = (pi4 - asin(    p5*y/sin(lon)))*c2
   else ! both x,y nearly zero so make this the pole point
      lat = c2*pi4
      lon = lon_tmp
   endif
 
!-----------------------------------------------------------------------
!EOC

 end subroutine SCRIP_PoleXY_to_LatLon

!***********************************************************************

 end module SCRIP_Grids

!***********************************************************************
!
!  Copyright (c) 1997, 1998 the Regents of the University of
!       California.  (See full copyright at end of code).
!
!  This software and ancillary information (herein called software)
!  called SCRIP is made available under the terms described here.
!  The software has been approved for release with associated
!  LA-CC Number 98-45.
!
!  Unless otherwise indicated, this software has been authored
!  by an employee or employees of the University of California,
!  operator of the Los Alamos National Laboratory under Contract
!  No. W-7405-ENG-36 with the U.S. Department of Energy.  The U.S.
!  Government has rights to use, reproduce, and distribute this
!  software.  The public may copy and use this software without
!  charge, provided that this Notice and any statement of authorship
!  are reproduced on all copies.  Neither the Government nor the
!  University makes any warranty, express or implied, or assumes
!  any liability or responsibility for the use of this software.
!
!  If software is modified to produce derivative works, such modified
!  software should be clearly marked, so as not to confuse it with
!  the version available from Los Alamos National Laboratory.
!
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
