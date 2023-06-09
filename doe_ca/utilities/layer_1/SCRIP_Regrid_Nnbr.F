!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

 module SCRIP_Regrid_Nnbr

!BOP
! !MODULE: SCRIP_Regrid_Nnbr
!
! !DESCRIPTION:
!  This module contains routines necessary for creating a Regrid object
!  using a distance-weight nearest-neighbor average method.
!
! !REVISION HISTORY:
!  CVS:$Id: SCRIP_Regrid_Nnbr.F,v 1.2 2003/05/19 12:07:27 pwjones Exp $
!  CVS:$Name:  $
!  Copyright (c) 1997, 1998 the Regents of the University of California.
!    Full copyright text at end of routine.
!
! !USES:

   use kinds
   use params_physical
   use SCRIP_Grids
   use SCRIP_Regrid_Types

   implicit none
   private
   save

! !PUBLIC MEMBER FUNCTIONS:

   public :: SCRIP_Regrid_Create_Nnbr

!EOP
!BOC
!EOC
!***********************************************************************

 contains

!***********************************************************************
!BOP
! !IROUTINE: SCRIP_Regrid_Create_Nnbr
! !INTERFACE:

 subroutine SCRIP_Regrid_Create_Nnbr(regrid, in_num_neighbors)

! !DESCRIPTION:
!  This routine creates a regrid object for use in interpolating fields
!  from one grid to another using a distance-weighted nearest-neighbor 
!  average.  Note that this particular implementation assumes that the
!  source and destination grid domains that overlap each other are
!  allocated on the same processor and that the number of neighbors
!  are small enough to ensure that all neighbors are local.
!
! !REVISION HISTORY:
!  same as module

! !INPUT/OUTPUT PARAMETERS:

   type (SCRIPRegrid), intent(inout) :: &
      regrid           ! a data structure containing all necessary
                       ! info for performing a regridding.  on input
                       ! this is an empty structure.  on output will
                       ! be filled with newly-created regridding.
 
! !INPUT PARAMETERS:

   integer (int_kind), intent(in), optional :: &
      in_num_neighbors ! number of nearest neighbors to average from
                       ! source grid to get value on destination grid

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   integer (int_kind) :: &
      i,j,k,ii,jj,kk,n,  &! dummy loop indices
      nchk,              &! counter for searches
      num_nbrs,          &! num neighbors to use to avg from src to dst
      nx_src, ny_src, nsbdm_src, &! source grid size
      nx_dst, ny_dst, nsbdm_dst   ! dest   grid size

   real (dbl_kind), dimension(:,:,:), allocatable :: &
      coslat, sinlat,    &! cosine, sine of grid lats (for distance)
      coslon, sinlon      ! cosine, sine of grid lons (for distance)

   integer (int_kind), dimension(3) :: &
      dst_add             ! destination address

   integer (int_kind), dimension(:,:), allocatable :: &
      nbr_add             ! source address at nearest neighbors

   real (dbl_kind), dimension(:), allocatable :: &
      nbr_dist            ! angular distance at nearest neighbors

   logical (log_kind), dimension(:), allocatable :: &
      nbr_mask            ! mask at nearest neighbors

   real (dbl_kind), dimension(:), allocatable :: &
      wgtstmp         ! an array to hold the link weight

   real (dbl_kind) :: &
      dst_x, dst_y,   &! coordinates for a destination grid point
      coslat_dst,     &! cos(lat) of destination grid point
      coslon_dst,     &! cos(lon) of destination grid point
      sinlat_dst,     &! sin(lat) of destination grid point
      sinlon_dst,     &! sin(lon) of destination grid point
      distance,       &! distance between two points
      dist_tot         ! sum of neighbor distances (for normalizing)

!-----------------------------------------------------------------------
!
!  initialize some parameters and grid info
!
!-----------------------------------------------------------------------

   if (present(in_num_neighbors)) then
      num_nbrs = in_num_neighbors
   else
      num_nbrs = 3  ! set 3 as default for geodesic grids
   endif

   !***
   !*** compute cos, sin of lat/lon on source grid for distance
   !*** calculations
   !***

   nx_src    = regrid%src_grid%dim_size(1)
   ny_src    = regrid%src_grid%dim_size(2)
   nsbdm_src = regrid%src_grid%dim_size(3)
   
   allocate (nbr_add (3,num_nbrs), &
             nbr_dist(  num_nbrs), &
             nbr_mask(  num_nbrs))

   allocate (coslat(nx_src,ny_src,nsbdm_src), &
             coslon(nx_src,ny_src,nsbdm_src), &
             sinlat(nx_src,ny_src,nsbdm_src), &
             sinlon(nx_src,ny_src,nsbdm_src))

   coslat = cos(regrid%src_grid%center_y)
   coslon = cos(regrid%src_grid%center_x)
   sinlat = sin(regrid%src_grid%center_y)
   sinlon = sin(regrid%src_grid%center_x)

   !***
   !*** allocate wgtstmp to be consistent with store_link interface
   !***

   allocate (wgtstmp(regrid%num_wts))

!-----------------------------------------------------------------------
!
!  loop over all cells on the destination grid and find nearest
!  neighbors on the source grid
!
!-----------------------------------------------------------------------

   nx_dst    = regrid%dst_grid%dim_size(1)
   ny_dst    = regrid%dst_grid%dim_size(2)
   nsbdm_dst = regrid%dst_grid%dim_size(3)

   do k=1,nsbdm_dst
   do j=1,ny_dst
   grid_loop: do i=1,nx_dst
   
      !*** skip this grid point if the mask is false
      if (.not. regrid%dst_grid%mask(i,j,k)) cycle grid_loop

      !*** compute cos,sin of dest grid coords for use in distance
      dst_x = regrid%dst_grid%center_x(i,j,k)
      dst_y = regrid%dst_grid%center_y(i,j,k)
      coslat_dst = cos(dst_y)
      coslon_dst = cos(dst_x)
      sinlat_dst = sin(dst_y)
      sinlon_dst = sin(dst_x)

      !*** initialize address, weight arrays
      nbr_add = 0
      nbr_dist = 1.e+12
      nbr_mask = .false.

      !***
      !*** check each subdomain on source grid
      !***
      
      sbdm_src_loop: do kk=1,nsbdm_src
      
         !***
         !*** check bounding box for this subdomain and skip
         !*** if point not in subdomain
         !***   
         
         if (dst_x - regrid%src_grid%ldomain_min_x(kk) >  1.5*pi) &
            dst_x = dst_x - pi2
         if (dst_x - regrid%src_grid%ldomain_min_x(kk) < -1.5*pi) &
            dst_x = dst_x + pi2

         if (dst_x < regrid%src_grid%ldomain_min_x(kk) .or. &
             dst_x > regrid%src_grid%ldomain_max_x(kk) .or. &
             dst_y < regrid%src_grid%ldomain_min_y(kk) .or. &
             dst_y > regrid%src_grid%ldomain_max_y(kk)) cycle sbdm_src_loop
         
         !***
         !*** if dest point is in the subdomain, compute distances and
         !*** find the nearest neighbors
         !***

         do jj=1,ny_src
         do ii=1,nx_src
         
            !***
            !*** find distance to this point
            !***

            distance = acos(sinlat_dst*sinlat(ii,jj,kk) + &
                            coslat_dst*coslat(ii,jj,kk)*  &
                           (coslon_dst*coslon(ii,jj,kk) + &
                            sinlon_dst*sinlon(ii,jj,kk)) )

            !***
            !*** store the address and distance if this is one of the
            !*** smallest four so far
            !***

            check_loop: do nchk=1,num_nbrs
               if (distance < nbr_dist(nchk)) then
                  !*** bump current numbers to make room for new
                  do n=num_nbrs,nchk+1,-1
                     nbr_add(:,n) = nbr_add(:,n-1)
                     nbr_dist(n) = nbr_dist(n-1)
                     nbr_mask(n) = nbr_mask(n-1)
                  end do
                  !*** store new address, distance, mask
                  nbr_add(1,nchk) = ii
                  nbr_add(2,nchk) = jj
                  nbr_add(3,nchk) = kk
                  nbr_dist (nchk) = distance
                  nbr_mask (nchk) = regrid%src_grid%mask(ii,jj,kk)
                  exit check_loop
               endif
            end do check_loop
         end do ! ii src loop
         end do ! jj src loop
      end do sbdm_src_loop

      !***
      !*** compute weights based on inverse distance
      !*** if mask is false, eliminate those points
      !***

      dist_tot = c0
      do n=1,num_nbrs
         if (nbr_mask(n)) then
            nbr_dist(n) = c1/nbr_dist(n)
            dist_tot = dist_tot + nbr_dist(n)
         endif
      end do

      !***
      !*** normalize weights and store the link
      !***

      do n=1,num_nbrs
         if (nbr_mask(n)) then
            wgtstmp(1) = nbr_dist(n)/dist_tot
            dst_add(1) = i
            dst_add(2) = j
            dst_add(3) = k
            call SCRIP_Regrid_AddLink(regrid, nbr_add(:,n), dst_add, wgtstmp)
         endif
      end do

   end do grid_loop ! i dst grid loop
   end do ! j dst grid loop
   end do ! sbdm dst grid loop

!-----------------------------------------------------------------------
!
!  all done - deallocate arrays and exit
!
!-----------------------------------------------------------------------

   deallocate (nbr_add, nbr_dist, nbr_mask, &
               coslat, coslon, sinlat, sinlon, wgtstmp)

!-----------------------------------------------------------------------
!EOC

 end subroutine SCRIP_Regrid_Create_Nnbr

!***********************************************************************

 end module SCRIP_Regrid_Nnbr

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
