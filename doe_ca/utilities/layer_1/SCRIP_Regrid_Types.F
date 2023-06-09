!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

 module SCRIP_Regrid_Types

!BOP
! !MODULE: SCRIP_Regrid_Types
!
! !DESCRIPTION:
!  This module contains the main regrid data type with the necessary
!  variables for regridding between two grids.  Routines for
!  constructing, destructing and modifying the data type are also
!  included.
!
! !REVISION HISTORY:
!  CVS:$Id: SCRIP_Regrid_Types.F,v 1.8 2004/03/05 16:36:19 dazlich Exp $
!  CVS:$Name:  $
!  Copyright (c) 1997, 1998 the Regents of the University of
!    California.  Complete copyright text at end of routine.
!
! !USES:

   use kinds
   use params_physical
   use abort
   use SCRIP_grids, only: SCRIPGrid, grid_rank

   implicit none
   private
   save

! !PUBLIC MEMBER FUNCTIONS:

   public :: SCRIP_Regrid_Construct, &
             SCRIP_Regrid_Destroy,   &
             SCRIP_Regrid_Resize,    &
             SCRIP_Regrid_AddLink,   &
             SCRIP_Regrid_Normalize

! !PUBLIC TYPES:

   type, public :: SCRIPRegrid

      character (char_len) :: &
         name              ! name for this regridding

      integer (int_kind) ::     &
         max_links,       &! current size of regrid arrays
         num_links,       &! actual number of links
         num_wts,         &! num of weights used in regridding
         method,          &! identifier for remapping method
         dst_subdomain,   &! index for specific destination subdomain
         norm_opt          ! option for normalization (conserv only)

      integer (int_kind), dimension(:,:), pointer :: &
         src_add,         &! source address for each link in regridding
         dst_add           ! destination add for each link in regridding

      real (dbl_kind), dimension(:,:), pointer :: &
         weights           ! regridding weights for each link

      type (SCRIPGrid), pointer :: &
         src_grid,        &! pointer to source grid for this regrid
         dst_grid          ! pointer to destination grid

      integer (int_kind), dimension(:,:,:,:), pointer :: &
         link_add_src,    &! arrays for restricting link search
         link_add_dst

   end type ! SCRIPRegrid

! !PUBLIC DATA MEMBERS:

   integer (int_kind), parameter, public :: &! supported regrid methods
      SCRIP_RegridMethodUnknown  = 0, &! unknown or undefined
      SCRIP_RegridMethodConserv  = 1, &! conservative
      SCRIP_RegridMethodBilinear = 2, &! bilinear
      SCRIP_RegridMethodBicubic  = 3, &! bicubic
      SCRIP_RegridMethodNnbr     = 4   ! nearest-neighbor dist-weighted avg

   integer (int_kind), parameter, public :: &! normalization options
      SCRIP_RegridNormOptNone    = 0, &! no or unknown normalization
      SCRIP_RegridNormOptDstarea = 1, &! normalize weights by dest area
      SCRIP_RegridNormOptFrcarea = 2   ! normalize weights by frac area

!EOP
!BOC

   interface SCRIP_Regrid_Normalize
      module procedure SCRIP_Regrid_Normalize_OneDmn
   end interface
!EOC
!***********************************************************************

 contains

!***********************************************************************
!BOP
! !IROUTINE: SCRIP_Regrid_Construct
! !INTERFACE:

 subroutine SCRIP_Regrid_Construct(newregrid, name, method, &
                                   src_grid, dst_grid,      &
                                   norm_opt, dst_subdomain)

! !DESCRIPTION:
!  This subroutine constructs a nearly-empty regrid structure and
!  allocates some initial space for regrid arrays.
!
! !REVISION HISTORY:
!  same as module

! !OUTPUT PARAMETERS:

   type (SCRIPRegrid), intent(out) :: &
      newregrid        ! a new regrid structure for this regrid

! !INPUT PARAMETERS:

   character (*), intent(in) :: &
      name             ! name to assign this regrid

   integer (int_kind), intent(in) :: &
      method,         &! id for regrid method to be used
      norm_opt,       &! normalization option for conservative regrid
      dst_subdomain    ! subdomain index for destination - if zero
                       !   compute for all destination subdomains

   type (SCRIPGrid), intent(in), target :: &
      src_grid, dst_grid  ! source and destination grids for this
                          ! regridding

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   integer (int_kind) :: &
      dst_grid_size  ! size of destination grid

!-----------------------------------------------------------------------
!
!  set name and assign pointers to grids
!
!-----------------------------------------------------------------------

   newregrid%name = ' '
   newregrid%name = name

   newregrid%src_grid => src_grid
   newregrid%dst_grid => dst_grid

   newregrid%dst_subdomain = dst_subdomain

!-----------------------------------------------------------------------
!
!  determine and set the number of weights
!
!-----------------------------------------------------------------------

   select case (method)
   case(SCRIP_RegridMethodConserv)
      newregrid%num_wts = 3
   case(SCRIP_RegridMethodBilinear)
      stop 'Bilinear regridding not supported for geodesic grids'
      !newregrid%num_wts = 1
   case(SCRIP_RegridMethodBicubic)
      stop 'Bicubic regridding not supported for geodesic grids'
      !newregrid%num_wts = 4
   case(SCRIP_RegridMethodNnbr)
      newregrid%num_wts = 1
   case default
      stop 'Unknown regrid method in SCRIP_Regrid_Construct'
   end select

   newregrid%method = method

!-----------------------------------------------------------------------
!
!  Make an initial guess for the size of the regrid arrays.  The size
!  can be changed later, but should be set high enough initially
!  to prevent frequent (costly) resizing.  We choose the initial size
!  as four times the size of the destination grid.
!
!-----------------------------------------------------------------------

   dst_grid_size = dst_grid%num_cells

   newregrid%max_links = 4*max(src_grid%num_cells,dst_grid_size)

   allocate(newregrid%src_add(grid_rank,newregrid%max_links), &
            newregrid%dst_add(grid_rank,newregrid%max_links), &
            newregrid%weights(newregrid%num_wts,newregrid%max_links))

!-----------------------------------------------------------------------
!
!  initialize various regrid quantities
!
!-----------------------------------------------------------------------

   newregrid%num_links = 0
   newregrid%norm_opt  = norm_opt

   newregrid%src_add = 0
   newregrid%dst_add = 0
   newregrid%weights = c0

!-----------------------------------------------------------------------
!
!  initialize link search arrays
!
!-----------------------------------------------------------------------

   allocate(newregrid%link_add_src(2,size(src_grid%center_x,dim=1), &
                                     size(src_grid%center_x,dim=2), &
                                     size(src_grid%center_x,dim=3)), &
            newregrid%link_add_dst(2,size(dst_grid%center_x,dim=1), &
                                     size(dst_grid%center_x,dim=2), &
                                     size(dst_grid%center_x,dim=3)))

   newregrid%link_add_src = 0
   newregrid%link_add_dst = 0

!-----------------------------------------------------------------------
!EOC

 end subroutine SCRIP_Regrid_Construct

!***********************************************************************
!BOP
! !IROUTINE: SCRIP_Regrid_Destroy
! !INTERFACE:

 subroutine SCRIP_Regrid_Destroy(regrid)

! !DESCRIPTION:
!  This subroutine destroys a regrid structure and frees up memory
!  associated with the regrid structure.
!
! !REVISION HISTORY:
!  same as module

! !OUTPUT PARAMETERS:

   type (SCRIPRegrid), intent(out) :: &
      regrid        ! the regrid structure to destroy

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  erase name, re-initialize scalars and de-reference pointers to grids
!
!-----------------------------------------------------------------------

   regrid%name          = ' '
   regrid%max_links     = 0
   regrid%num_links     = 0
   regrid%num_wts       = 0
   regrid%dst_subdomain = 0

   regrid%method   = SCRIP_RegridMethodUnknown
   regrid%norm_opt = SCRIP_RegridNormOptNone

   nullify(regrid%src_grid)
   nullify(regrid%dst_grid)

!-----------------------------------------------------------------------
!
!  deallocate space for regrid arrays
!
!-----------------------------------------------------------------------

   deallocate(regrid%src_add, regrid%dst_add, regrid%weights)

!-----------------------------------------------------------------------
!EOC

 end subroutine SCRIP_Regrid_Destroy

!***********************************************************************
!BOP
! !IROUTINE: SCRIP_Regrid_Resize
! !INTERFACE:

 subroutine SCRIP_Regrid_Resize(regrid, increment)

! !DESCRIPTION:
!  This routine resizes regridding arrays by increasing(decreasing)
!  the number of links in the current regrid structure by the input
!  increment.
!
! !REVISION HISTORY:
!  same as module

! !INPUT/OUTPUT PARAMETERS:

   type (SCRIPRegrid), intent(inout) :: &
      regrid             ! regridding structure to resize

! !INPUT PARAMETERS:

   integer (int_kind), intent(in) :: &
      increment  ! the number of links to add(subtract) to arrays

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   integer (int_kind) :: &
      ierr,        &! error flag
      mxlinks       ! size of link arrays

   integer (int_kind), dimension(:,:), allocatable :: &
      add1_tmp,    &! temp array for resizing address arrays
      add2_tmp      ! temp array for resizing address arrays

   real (dbl_kind), dimension(:,:), allocatable :: &
      wts_tmp       ! temp array for resizing weight arrays

!-----------------------------------------------------------------------
!
!  allocate temporaries to hold original values
!
!-----------------------------------------------------------------------

   mxlinks = regrid%max_links

   allocate (add1_tmp(grid_rank,mxlinks), add2_tmp(grid_rank,mxlinks), &
             wts_tmp(regrid%num_wts,mxlinks))

   add1_tmp = regrid%src_add
   add2_tmp = regrid%dst_add
   wts_tmp  = regrid%weights

!-----------------------------------------------------------------------
!
!  deallocate originals and increment max_links then
!  reallocate arrays at new size
!
!-----------------------------------------------------------------------

   deallocate (regrid%src_add)
   deallocate (regrid%dst_add)
   deallocate (regrid%weights)
   regrid%max_links = mxlinks + increment

   allocate (regrid%src_add(grid_rank,regrid%max_links), &
             regrid%dst_add(grid_rank,regrid%max_links), &
             regrid%weights(regrid%num_wts,regrid%max_links))

!-----------------------------------------------------------------------
!
!  restore original values from temp arrays and
!  deallocate temps
!
!-----------------------------------------------------------------------

   mxlinks = min(mxlinks, regrid%max_links)
   regrid%src_add(:,1:mxlinks) = add1_tmp(:,1:mxlinks)
   regrid%dst_add(:,1:mxlinks) = add2_tmp(:,1:mxlinks)
   regrid%weights(:,1:mxlinks) = wts_tmp (:,1:mxlinks)

   deallocate(add1_tmp, add2_tmp, wts_tmp)

!-----------------------------------------------------------------------
!EOC

 end subroutine SCRIP_Regrid_Resize

!***********************************************************************
!BOP
! !IROUTINE: SCRIP_Regrid_AddLink
! !INTERFACE:

 subroutine SCRIP_Regrid_AddLink(regrid, src_add, dst_add, weights)

! !DESCRIPTION:
!  This routine adds a new link to an existing regrid structure.
!
! !REVISION HISTORY:
!  same as module

! !INPUT/OUTPUT PARAMETERS:

   type (SCRIPRegrid), intent(inout) :: &
      regrid             ! regridding structure to which link is added

! !INPUT PARAMETERS:

   integer (int_kind), dimension(:), intent(in) :: &
      src_add,  &! source and destination address pair
      dst_add    !   defining new link

   real (dbl_kind), dimension(:), intent(in) :: &
      weights    ! regridding weights associated with new link

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   integer (int_kind) :: &
      n,                 &! dummy index
      i,j,k,ii,jj,kk,    &! address indices
      minlink, maxlink,  &! restrict search for existing links
      num_links,         &! current number of links
      increment           ! how much to resize a regrid if necessary

   logical (log_kind) :: found  ! flag to signal existing link found

!-----------------------------------------------------------------------
!
!  search existing links.  if identical link found, add weights to
!  existing link.
!
!-----------------------------------------------------------------------

   !*** restrict the range of links to search for existing links

   i  = src_add(1)
   j  = src_add(2)
   k  = src_add(3)
   ii = dst_add(1)
   jj = dst_add(2)
   kk = dst_add(3)

   minlink = min(regrid%link_add_src(1,i ,j ,k ), &
                 regrid%link_add_dst(1,ii,jj,kk))
   maxlink = max(regrid%link_add_src(2,i ,j ,k ), &
                 regrid%link_add_dst(2,ii,jj,kk))

   if (minlink == 0) then
      num_links = regrid%num_links + 1
      minlink = num_links
      maxlink = 0

      if (regrid%link_add_src(1,i ,j ,k ) == 0) &
          regrid%link_add_src(1,i ,j ,k ) = num_links
      if (regrid%link_add_dst(1,ii,jj,kk) == 0) &
          regrid%link_add_dst(1,ii,jj,kk) = num_links
   endif

   !*** now do the search

   found = .false.

   srch_links: do n=maxlink,minlink,-1  ! search in reverse order
      if (k  == regrid%src_add(3,n)) then
      if (j  == regrid%src_add(2,n)) then
      if (i  == regrid%src_add(1,n)) then
      if (kk == regrid%dst_add(3,n)) then
      if (jj == regrid%dst_add(2,n)) then
      if (ii == regrid%dst_add(1,n)) then

         regrid%weights(:,n) = regrid%weights(:,n) + weights
         found = .true.
         exit srch_links

      endif
      endif
      endif
      endif
      endif
      endif
   end do srch_links

!-----------------------------------------------------------------------
!
!  if an existing link is not found, 
!  increment number of links and resize if necessary
!
!-----------------------------------------------------------------------

   if (.not. found) then
      num_links = regrid%num_links + 1
   
      if (num_links > regrid%max_links) then
         increment = max(regrid%src_grid%num_cells, &
                         regrid%dst_grid%num_cells)
         call SCRIP_Regrid_Resize(regrid, increment)
      endif
   
      regrid%num_links = num_links

      regrid%link_add_src(2,i ,j ,k ) = num_links
      regrid%link_add_dst(2,ii,jj,kk) = num_links

!-----------------------------------------------------------------------
!
!     add new link
!
!-----------------------------------------------------------------------

      regrid%src_add(:,num_links) = src_add
      regrid%dst_add(:,num_links) = dst_add
      regrid%weights(:,num_links) = weights

   endif ! not found

!-----------------------------------------------------------------------
!EOC

 end subroutine SCRIP_Regrid_AddLink

!***********************************************************************
!BOP
! !IROUTINE: SCRIP_Regrid_Normalize_OneDmn
! !INTERFACE:

 subroutine SCRIP_Regrid_Normalize_OneDmn(regrid, dst_area)

! !DESCRIPTION:
!  Renormalizes regridding weights based on a new destination array.
!  This routine is used for some remappings in which the destination
!  grid cells are split across domain so the consistent destination
!  area is not available at Regrid Create.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   type (SCRIPRegrid), intent(inout) :: &
      regrid           ! a data structure containing all necessary
                       ! info for performing a regridding

   real (dbl_kind), dimension(:,:), intent(in) :: &
      dst_area        ! new destination area to use for normalization

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   integer (int_kind) :: &
      n,                 &! loop index
      i,j                 ! dest addresses

!-----------------------------------------------------------------------
!
!  check that this regridding was computed for only one subdomain
!
!-----------------------------------------------------------------------

   if (regrid%dst_subdomain == 0) then
      call abort_code( &
         'ERROR: SCRIP_Regrid_Normalize_OneDmn - incompatible regrid')
   endif

!-----------------------------------------------------------------------
!
!  renormalize weights by dividing by new area
!
!-----------------------------------------------------------------------

   if (regrid%num_wts == 1) then
   
      do n=1,regrid%num_links
         i = regrid%dst_add(1,n)
         j = regrid%dst_add(2,n)
         
         if (dst_area(i,j) /= c0) then
            regrid%weights(1,n) = regrid%weights(1,n)/dst_area(i,j)
         else
            regrid%weights(1,n) = c0
         endif
      end do

   else if (regrid%num_wts == 3) then

      do n=1,regrid%num_links
         i = regrid%dst_add(1,n)
         j = regrid%dst_add(2,n)
         
         if (dst_area(i,j) /= c0) then
            regrid%weights(:,n) = regrid%weights(:,n)/dst_area(i,j)
         else
            regrid%weights(:,n) = c0
         endif
      end do

   else
      call abort_code( &
         'ERROR: SCRIP_Regrid_Normalize_OneDmn - bad num_wts')
   endif

!-----------------------------------------------------------------------
!EOC

 end subroutine SCRIP_Regrid_Normalize_OneDmn

!***********************************************************************

 end module SCRIP_Regrid_Types

!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
!-----------------------------------------------------------------------
!
!     Copyright (c) 1997, 1998 the Regents of the University of
!       California.
!
!     This software and ancillary information (herein called software)
!     called SCRIP is made available under the terms described here.
!     The software has been approved for release with associated
!     LA-CC Number 98-45.
!
!     Unless otherwise indicated, this software has been authored
!     by an employee or employees of the University of California,
!     operator of the Los Alamos National Laboratory under Contract
!     No. W-7405-ENG-36 with the U.S. Department of Energy.  The U.S.
!     Government has rights to use, reproduce, and distribute this
!     software.  The public may copy and use this software without
!     charge, provided that this Notice and any statement of authorship
!     are reproduced on all copies.  Neither the Government nor the
!     University makes any warranty, express or implied, or assumes
!     any liability or responsibility for the use of this software.
!
!     If software is modified to produce derivative works, such modified
!     software should be clearly marked, so as not to confuse it with
!     the version available from Los Alamos National Laboratory.
!
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
