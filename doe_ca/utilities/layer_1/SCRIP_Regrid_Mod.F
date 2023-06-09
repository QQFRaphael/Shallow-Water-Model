!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

 module SCRIP_Regrid_Mod

!BOP
! !MODULE: SCRIP_Regrid_Mod
!
! !DESCRIPTION:
!  This module is the main driver for SCRIP regridding routines.  It
!  contains the routine to perform a regridding as well as a driver
!  routine for regrid creation.
!
! !REVISION HISTORY:
!  CVS:$Id: SCRIP_Regrid_Mod.F,v 1.6 2004/03/04 00:23:51 pwjones Exp $
!  CVS:$Name:  $
!  Copyright (c) 1997, 1998 the Regents of the University of California.
!    Full copyright text at end of routine.
!
! !USES:

   use kinds
   use params_physical
   use abort
   use SCRIP_Grids, only : SCRIPGrid, grid_rank
   use SCRIP_Regrid_Types
   use SCRIP_Regrid_Conserv, only : SCRIP_Regrid_Create_Conserv
   use SCRIP_Regrid_Nnbr,    only : SCRIP_Regrid_Create_Nnbr

   implicit none
   private
   save

! !PUBLIC MEMBER FUNCTIONS:

   public :: SCRIP_Regrid,         &
             SCRIP_Regrid_Create

!EOP

   interface SCRIP_Regrid
      module procedure SCRIP_Regrid_AllDomains, &
                       SCRIP_Regrid_OneDomain
   end interface

!BOC
!EOC
!***********************************************************************

 contains

!***********************************************************************
!BOP
! !IROUTINE: SCRIP_Regrid_AllDomains
! !INTERFACE:

 subroutine SCRIP_Regrid_AllDomains(regrid, dst_array, src_array, &
                                            src_grad_x, src_grad_y)

! !DESCRIPTION:
!  Performs a regridding or interpolation of a field on the source
!  grid to a field on the destination grid based on weights computed 
!  in a separate regrid create routine.  This routine assumes that
!  all data necessary for the regridding is local and that the
!  regridding is performed for all local subdomains.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   type (SCRIPRegrid), intent(in) :: &
      regrid           ! a data structure containing all necessary
                       ! info for performing a regridding

   real (dbl_kind), dimension(:,:,:), intent(in) :: &
      src_array        ! array containing field on source grid
   
   !*** for higher-order regrid methods   
   real (dbl_kind), dimension(:,:,:), intent(in), optional :: & 
      src_grad_x,    & ! gradient of source field in longitude direction
      src_grad_y       ! gradient of source field in latitude  direction

! !OUTPUT PARAMETERS:

   real (dbl_kind), dimension(:,:,:), intent(out) :: &
      dst_array        ! interpolated field on destination grid

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   integer (int_kind) :: &
      n,                 &! loop index
      i,j,k,             &! dest addresses
      ii,jj,kk,          &! source addresses
      iorder              ! order of regridding

!-----------------------------------------------------------------------
!
!  if gradients present in argument list, assume higher-order regridding
!
!-----------------------------------------------------------------------

   if (present(src_grad_x)) then
      iorder = 2
   else
      iorder = 1
   endif

!-----------------------------------------------------------------------
!
!  check that this regridding was computed for all subdomains
!
!-----------------------------------------------------------------------

!  if (regrid%dst_subdomain /= 0) then
!     call abort_code( &
!        'ERROR: SCRIP_Regrid_AllDomain - incompatible regrid')
!  endif

!-----------------------------------------------------------------------
!
!  fill ghost cells on source array?
!
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
!
!  generic regridding
!
!-----------------------------------------------------------------------

   dst_array = c0

   select case (iorder)
   case(1)

      do n=1,regrid%num_links
         i = regrid%dst_add(1,n)
         j = regrid%dst_add(2,n)
         k = regrid%dst_add(3,n)
         
         ii = regrid%src_add(1,n)
         jj = regrid%src_add(2,n)
         kk = regrid%src_add(3,n)
         
         dst_array(i,j,k) = dst_array(i,j,k) + &
                            src_array(ii,jj,kk)*regrid%weights(1,n)
      end do

!-----------------------------------------------------------------------
!
!  second order remapping
!
!-----------------------------------------------------------------------

   case(2)

      if (regrid%num_wts /= 3) &
        stop 'SCRIP_Regrid: Computed regrid not created for second order'

      do n=1,regrid%num_links
         i = regrid%dst_add(1,n)
         j = regrid%dst_add(2,n)
         k = regrid%dst_add(3,n)
         
         ii = regrid%src_add(1,n)
         jj = regrid%src_add(2,n)
         kk = regrid%src_add(3,n)
         
         dst_array(i,j,k) = dst_array(i,j,k) + &
                            src_array(ii,jj,kk)*regrid%weights(1,n) + &
                           src_grad_x(ii,jj,kk)*regrid%weights(2,n) + &
                           src_grad_y(ii,jj,kk)*regrid%weights(3,n)
      end do

   end select

!-----------------------------------------------------------------------
!EOC

 end subroutine SCRIP_Regrid_AllDomains

!***********************************************************************
!BOP
! !IROUTINE: SCRIP_Regrid_OneDomain
! !INTERFACE:

 subroutine SCRIP_Regrid_OneDomain(regrid, dst_array, src_array, &
                                           src_grad_x, src_grad_y)

! !DESCRIPTION:
!  Performs a regridding or interpolation of a field on the source
!  grid to a field on the destination grid based on weights computed 
!  in a separate regrid create routine.  This routine assumes that
!  all data necessary for the regridding is local and that the
!  regridding is performed for all local subdomains.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   type (SCRIPRegrid), intent(in) :: &
      regrid           ! a data structure containing all necessary
                       ! info for performing a regridding

   real (dbl_kind), dimension(:,:,:), intent(in) :: &
      src_array        ! array containing field on source grid
   
   !*** for higher-order regrid methods   
   real (dbl_kind), dimension(:,:,:), intent(in), optional :: & 
      src_grad_x,    & ! gradient of source field in longitude direction
      src_grad_y       ! gradient of source field in latitude  direction

! !OUTPUT PARAMETERS:

   real (dbl_kind), dimension(:,:), intent(out) :: &
      dst_array        ! interpolated field on destination grid

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   integer (int_kind) :: &
      n,                 &! loop index
      i,j,               &! dest addresses
      ii,jj,kk,          &! source addresses
      iorder              ! order of regridding

!-----------------------------------------------------------------------
!
!  if gradients present in argument list, assume higher-order regridding
!
!-----------------------------------------------------------------------

   if (present(src_grad_x)) then
      iorder = 2
   else
      iorder = 1
   endif

!-----------------------------------------------------------------------
!
!  check that this regridding was computed for only one subdomain
!
!-----------------------------------------------------------------------

   if (regrid%dst_subdomain == 0) then
      call abort_code( &
         'ERROR: SCRIP_Regrid_OneDomain - incompatible regrid')
   endif

!-----------------------------------------------------------------------
!
!  fill ghost cells on source array?
!
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
!
!  generic regridding
!
!-----------------------------------------------------------------------

   dst_array = c0

   select case (iorder)
   case(1)

      do n=1,regrid%num_links
         i = regrid%dst_add(1,n)
         j = regrid%dst_add(2,n)
         
         ii = regrid%src_add(1,n)
         jj = regrid%src_add(2,n)
         kk = regrid%src_add(3,n)
         
         dst_array(i,j) = dst_array(i,j) + &
                          src_array(ii,jj,kk)*regrid%weights(1,n)
      end do

!-----------------------------------------------------------------------
!
!  second order remapping
!
!-----------------------------------------------------------------------

   case(2)

      if (regrid%num_wts /= 3) &
        stop 'SCRIP_Regrid: Computed regrid not created for second order'

      do n=1,regrid%num_links
         i = regrid%dst_add(1,n)
         j = regrid%dst_add(2,n)
         
         ii = regrid%src_add(1,n)
         jj = regrid%src_add(2,n)
         kk = regrid%src_add(3,n)
         
         dst_array(i,j) = dst_array(i,j) + &
                          src_array(ii,jj,kk)*regrid%weights(1,n) + &
                         src_grad_x(ii,jj,kk)*regrid%weights(2,n) + &
                         src_grad_y(ii,jj,kk)*regrid%weights(3,n)
      end do

   end select

!-----------------------------------------------------------------------
!EOC

 end subroutine SCRIP_Regrid_OneDomain

!***********************************************************************
!BOP
! !IROUTINE: SCRIP_Regrid_Create
! !INTERFACE:

 subroutine SCRIP_Regrid_Create(newregrid, name, method, &
                                src_grid, dst_grid,      &
                                normalize_opt, dst_subdomain)

! !DESCRIPTION:
!  This routine is a driver which creates a regrid by calling
!  the appropriate create routine based on requested regrid method.
!
! !REVISION HISTORY:
!  same as module

! !INPUT PARAMETERS:

   character (*), intent(in) :: &
      name                       ! name to assign to this regridding
   
   integer (int_kind), intent(in) :: &
      method                     ! id of method to use for regridding

   type (SCRIPGrid), intent(in) :: &
      src_grid,                 &! grid info for source grid
      dst_grid                   ! grid info for destination grid

   integer (int_kind), intent(in), optional :: &
      normalize_opt,            &! option for normalizing conserv regrid
      dst_subdomain              ! subdomain index for which regridding
                                 ! is requested

! !OUTPUT PARAMETERS:

   type (SCRIPRegrid), intent(out) :: &
      newregrid        ! a data structure containing all necessary
                       ! info for performing a regridding

!EOP
!BOC

   integer (int_kind) :: dst_sbdm_indx, norm_opt  ! local temps

!-----------------------------------------------------------------------
!
!  if requesting a regrid for a specific subdomain, set that index
!  here.  otherwise, set to zero.
!
!-----------------------------------------------------------------------

   if (present(dst_subdomain)) then
      dst_sbdm_indx = dst_subdomain
   else
      dst_sbdm_indx = 0
   endif

   if (present(normalize_opt)) then
      norm_opt = normalize_opt
   else
      norm_opt = SCRIP_RegridNormOptNone
   endif

!-----------------------------------------------------------------------
!
!  first construct and allocate space for a regrid structure to be
!  used by individual create routines
!
!-----------------------------------------------------------------------

   call SCRIP_Regrid_Construct(newregrid, name, method, &
                               src_grid, dst_grid,      &
                               norm_opt, dst_sbdm_indx)

!-----------------------------------------------------------------------
!
!  Now call appropriate regrid create routine based on method choice
!
!-----------------------------------------------------------------------

   select case(newregrid%method)
   case (SCRIP_RegridMethodConserv)
      call SCRIP_Regrid_Create_Conserv(newregrid)
   case (SCRIP_RegridMethodNnbr)
      call SCRIP_Regrid_Create_Nnbr(newregrid)
   case default
      stop 'SCRIP_Regrid_Create: unknown method'
   end select

!-----------------------------------------------------------------------
!EOC

 end subroutine SCRIP_Regrid_Create

!***********************************************************************

 end module SCRIP_Regrid_Mod

!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
!-----------------------------------------------------------------------
!
!  Copyright (c) 1997, 1998 the Regents of the University of California.
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
!-----------------------------------------------------------------------
