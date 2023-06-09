!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

 module SCRIP_Regrid_Conserv

!BOP
! !MODULE: SCRIP_Regrid_Conserv
!
! !DESCRIPTION:
!  This module contains necessary routines for computing addresses
!  and weights for a conservative interpolation  between any two 
!  grids on a sphere.  the weights are computed by performing line 
!  integrals around all overlap regions of the two grids.  see 
!  Dukowicz and Kodis, SIAM J. Sci. Stat. Comput. 8, 305 (1987) and
!  Jones, P.W. Monthly Weather Review 127, 2204 (1999).
!
! !REVISION HISTORY:
!  CVS:$Id: SCRIP_Regrid_Conserv.F,v 1.10 2004/11/16 23:02:15 dazlich Exp $
!  CVS:$Name:  $
!  Copyright (c) 1997, 1998 the Regents of the University of California.
!  (see full copyright at end of file)
!
! !USES:

   use kinds                  ! defines common data types
   use abort                  ! exit module
   use params_physical        ! defines common constants
   use SCRIP_grids            ! module containing grid data types, methods
   use SCRIP_Regrid_Types     ! module containing regrid data types, methods

   implicit none
   private
   save

! !PUBLIC MEMBER FUNCTIONS:

   public :: &
      SCRIP_Regrid_Create_Conserv

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  module variables
!
!-----------------------------------------------------------------------
! include 'mpif.h'  ! FOR DEBUGGING ONLY

!EOC
!***********************************************************************

 contains

!***********************************************************************
!BOP
! !IROUTINE: SCRIP_Regrid_Create_Conserv
! !INTERFACE:

 subroutine SCRIP_Regrid_Create_Conserv(regrid)

! !DESCRIPTION:
!  This routine creates a regrid data structure containing all the
!  information necessary to do a 1st-order or 2nd-order conservative
!  regridding.  This routine is meant to be called from the main
!  SCRIP regrid create routine and assumes some parts of the regrid
!  data type have already been initialized.  In particular, the
!  source grid, destination grid and order must have been initialized.
!
! !REVISION HISTORY:
!  same as module

! !INPUT/OUTPUT PARAMETERS:

   type (SCRIPRegrid), intent(inout) :: &
      regrid               ! regridding data type to hold regrid data

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   integer (int_kind), parameter :: &
      max_subseg = 10000       ! max number of subsegments per segment
                               ! to prevent infinite loop

   integer (int_kind) :: &
      i,j,k,ii,jj,kk,    &! dummy loop indices
      ib,ie,jb,je,       &! begin,end of physical domain
      kb,ke,             &! index for restricting dst subdomain range
      n, nwgt,           &! generic counters
      corner,            &! corner of cell that segment starts from
      next_corn,         &! corner of cell that segment ends on
      num_subseg,        &! number of subsegments 
      my_task=0,           &! mpi task !DELETE THIS AFTER DEBUGGING
      nx_src, ny_src, nsbdm_src, &! source grid size
      nx_dst, ny_dst, nsbdm_dst   ! dest   grid size

   integer (int_kind), dimension(3) :: &
      src_add,           &! current address for source      grid cell
      dst_add             ! current address for destination grid cell

   logical (log_kind) :: &
      lcoinc,            &! flag for coincident segments
      lreverse            ! flag for reversing direction of segment

   real (dbl_kind) ::            &
      x_intersect, y_intersect,  &! coordinates of intersection
      x_intersect_last,          &! coordinates of last intersection
      y_intersect_last,          &!
      xbeg, xend, ybeg, yend,    &! endpoints of current segment
      xref, yref,                &! reference x,y for current grid cell
      xoff, yoff,                &! offsets to nudge past intersection
      norm_factor                 ! factor for normalizing wts

   real (dbl_kind), dimension(:,:,:), allocatable :: &
      src_frac, dst_frac,  &! fraction of unmasked area on either grid
      src_area, dst_area,  &! complete area on either grid
      dst_centroid_x, dst_centroid_y,  &! centroid coordinates
      src_centroid_x, src_centroid_y    ! for each grid cell

   real (dbl_kind), dimension(4) :: &
      full_line        ! coordinates for full cell side line segment

   real (dbl_kind), dimension(3) :: &
      weights          ! local regridding weight array

!-----------------------------------------------------------------------
!
!  allocate and initialize parts of the regrid structure not already
!  set on input
!
!-----------------------------------------------------------------------

!  call MPI_COMM_RANK(MPI_COMM_WORLD, my_task, i)

   nx_src    = regrid%src_grid%dim_size(1)
   ny_src    = regrid%src_grid%dim_size(2)
   nsbdm_src = regrid%src_grid%dim_size(3)
   
   nx_dst    = regrid%dst_grid%dim_size(1)
   ny_dst    = regrid%dst_grid%dim_size(2)

   if (regrid%dst_subdomain /= 0) then
      nsbdm_dst = 1
      kb        = regrid%dst_subdomain
      ke        = regrid%dst_subdomain
      kk        = regrid%dst_subdomain
   else
      nsbdm_dst = regrid%dst_grid%dim_size(3)
      kb        = 1
      ke        = nsbdm_dst
   endif

   !***
   !*** allocate and initialize area fraction arrays, centroid arrays
   !***
      
   allocate(src_frac(nx_src, ny_src, nsbdm_src), &
            src_area(nx_src, ny_src, nsbdm_src), &
            dst_frac(nx_dst, ny_dst, kb:ke), &
            dst_area(nx_dst, ny_dst, kb:ke))

   src_frac = c0
   src_area = c0
   dst_frac = c0
   dst_area = c0

   allocate(src_centroid_x(nx_src, ny_src, nsbdm_src), &
            src_centroid_y(nx_src, ny_src, nsbdm_src), &
            dst_centroid_x(nx_dst, ny_dst, kb:ke), &
            dst_centroid_y(nx_dst, ny_dst, kb:ke))

   src_centroid_x = c0
   src_centroid_y = c0
   dst_centroid_x = c0
   dst_centroid_y = c0

   !***
   !*** initialize address, weight arrays
   !***

   nwgt = regrid%num_wts

   regrid%src_add = 0
   regrid%dst_add = 0
   regrid%weights = c0

!-----------------------------------------------------------------------
!
!  loop through each cell on source grid and
!  perform line integrals around each cell
!
!-----------------------------------------------------------------------

   dst_add = 0

   do k=1,nsbdm_src
   do j=1,ny_src
   src_loopi: do i=1,nx_src

      if (.not. regrid%src_grid%mask(i,j,k)) cycle src_loopi
      src_add(1) = i
      src_add(2) = j
      src_add(3) = k

      xref = regrid%src_grid%center_x(i,j,k)
      yref = regrid%src_grid%center_y(i,j,k)
      
      !***
      !*** integrate around this cell
      !***

      corner_loop1: do corner = 1,regrid%src_grid%num_corners
         next_corn = mod(corner,regrid%src_grid%num_corners) + 1

         !***
         !*** define endpoints of the current segment
         !***

         xbeg = regrid%src_grid%corner_x(corner   ,i,j,k)
         ybeg = regrid%src_grid%corner_y(corner   ,i,j,k)
         xend = regrid%src_grid%corner_x(next_corn,i,j,k)
         yend = regrid%src_grid%corner_y(next_corn,i,j,k)
         if(abs(yend-pih) < 0.0001_dbl_kind) xend = xbeg
         if(abs(ybeg+pih) < 0.0001_dbl_kind) xbeg = xend


         full_line(1) = xbeg
         full_line(2) = ybeg
         full_line(3) = xend
         full_line(4) = yend

         !***
         !*** to ensure exact path taken during both
         !*** sweeps, always integrate segments in the same 
         !*** direction (south to north or west to east).
         !***

         lreverse = .false.
         if ((yend < ybeg) .or. &
             (yend == ybeg .and. xend < xbeg)) then 
            xbeg = regrid%src_grid%corner_x(next_corn,i,j,k)
            ybeg = regrid%src_grid%corner_y(next_corn,i,j,k)
            xend = regrid%src_grid%corner_x(corner   ,i,j,k)
            yend = regrid%src_grid%corner_y(corner   ,i,j,k)
         if(abs(yend-pih) < 0.0001_dbl_kind) xend = xbeg
         if(abs(ybeg+pih) < 0.0001_dbl_kind) xbeg = xend
            lreverse = .true.
         endif

         !***
         !*** save the beginning coordinates for later use and
         !*** initialize sub-segment counter
         !***
         
         x_intersect = xbeg
         y_intersect = ybeg
         x_intersect_last = xbeg
         y_intersect_last = ybeg
         xoff = c0
         yoff = c0
         num_subseg = 0

         !***
         !*** if this is a constant-x segment, skip the rest 
         !*** since the line integral contribution will be zero.
         !***

         if (xend == xbeg) cycle corner_loop1

         !***
         !*** integrate along this segment, detecting intersections 
         !*** and computing the line integral for each sub-segment
         !***

!        do while (ybeg /= yend .or. xbeg /= xend)
         do while ( abs(yend-ybeg) > 1.e-11 .or. abs(xend-xbeg) > 1.e-11)

            !***
            !*** prevent infinite loops if integration gets stuck
            !*** near cell or threshold boundary
            !***
            num_subseg = num_subseg + 1
            if (num_subseg > max_subseg) then
               print *,i,j,k,xbeg,xend,ybeg,yend
               call abort_code(  &
                  'integration stalled: num_subseg exceeded limit')
            endif

            !***
            !*** find next intersection of this segment with a grid
            !*** line on the destination grid.  Offset from last
            !*** intersection to nudge into next grid cell.
            !***

            call SCRIP_Grid_Intersect(dst_add, x_intersect, y_intersect,   &
                                      xoff, yoff, lcoinc, regrid%dst_grid, &
                                      xbeg, ybeg, xend, yend, full_line,   &
                                      subdomain = regrid%dst_subdomain)
            ii = dst_add(1)
            jj = dst_add(2)
            kk = dst_add(3)

            !***
            !*** compute line integral for this subsegment.
            !***

            call line_integral(weights,                       &
                               x_intersect_last, x_intersect, &
                               y_intersect_last, y_intersect, &
                               xref, yref)

            !***
            !*** if integrating in reverse order, change
            !*** sign of weights
            !***

            if (lreverse) then
               weights = -weights
            endif

            !***
            !*** store the appropriate addresses and weights. 
            !*** also add contributions to cell areas and centroids.
            !***

            if (dst_add(1) /= 0) then
               if (regrid%dst_grid%mask(ii,jj,kk)) then
                  call SCRIP_Regrid_AddLink(regrid, &
                                            src_add, dst_add, weights)
                  src_frac( i, j, k) = src_frac( i, j, k) + weights(1)
                  dst_frac(ii,jj,kk) = dst_frac(ii,jj,kk) + weights(1)
               endif
            endif

            src_area(i,j,k) = src_area(i,j,k) + weights(1)
            src_centroid_x(i,j,k) = &
            src_centroid_x(i,j,k) + weights(2)
            src_centroid_y(i,j,k) = &
            src_centroid_y(i,j,k) + weights(3)

            !***
            !*** reset ybeg and xbeg for next subsegment.
            !***

            x_intersect_last = x_intersect
            y_intersect_last = y_intersect
            xbeg = x_intersect + xoff
            ybeg = y_intersect + yoff
         end do

         !***
         !*** end of segment
         !***

      end do corner_loop1

      !***
      !*** finished with this cell - start on next cell
      !***

   end do src_loopi
   end do
   end do

!-----------------------------------------------------------------------
!
!  integrate around each cell on destination grid
!
!-----------------------------------------------------------------------

   src_add = 0
   do kk=kb,ke
   do jj=1,ny_dst
   dst_loopi: do ii=1,nx_dst

      if (.not. regrid%dst_grid%mask(ii,jj,kk)) cycle dst_loopi

      dst_add(1) = ii
      dst_add(2) = jj
      dst_add(3) = kk

      xref = regrid%src_grid%center_x(ii,jj,kk)
      yref = regrid%src_grid%center_y(ii,jj,kk)
      
      !***
      !*** integrate around this cell
      !***

      corner_loop2: do corner = 1,regrid%dst_grid%num_corners
         next_corn = mod(corner,regrid%dst_grid%num_corners) + 1

         !***
         !*** define endpoints of the current segment
         !***

         xbeg = regrid%dst_grid%corner_x(corner   ,ii,jj,kk)
         ybeg = regrid%dst_grid%corner_y(corner   ,ii,jj,kk)
         xend = regrid%dst_grid%corner_x(next_corn,ii,jj,kk)
         yend = regrid%dst_grid%corner_y(next_corn,ii,jj,kk)
         if(abs(yend-pih) < 0.0001_dbl_kind) xend = xbeg
         if(abs(ybeg+pih) < 0.0001_dbl_kind) xbeg = xend
         full_line(1) = xbeg
         full_line(2) = ybeg
         full_line(3) = xend
         full_line(4) = yend

         !***
         !*** to ensure exact path taken during both
         !*** sweeps, always integrate segments in the same 
         !*** direction (south to north or west to east).
         !***

         lreverse = .false.
         if ((yend < ybeg) .or. &
             (yend == ybeg .and. xend < xbeg)) then 
            xbeg = regrid%dst_grid%corner_x(next_corn,ii,jj,kk)
            ybeg = regrid%dst_grid%corner_y(next_corn,ii,jj,kk)
            xend = regrid%dst_grid%corner_x(corner   ,ii,jj,kk)
            yend = regrid%dst_grid%corner_y(corner   ,ii,jj,kk)
         if(abs(yend-pih) < 0.0001_dbl_kind) xend = xbeg
         if(abs(ybeg+pih) < 0.0001_dbl_kind) xbeg = xend
            lreverse = .true.
         endif

         !***
         !*** initialize sub-segment counter and initial endpoint
         !***
         
         x_intersect = xbeg
         y_intersect = ybeg
         x_intersect_last = xbeg
         y_intersect_last = ybeg
         xoff = c0
         yoff = c0
         num_subseg = 0

         !***
         !*** if this is a constant-x segment, skip the rest 
         !*** since the line integral contribution will be c0.
         !***

         if (xend == xbeg) cycle corner_loop2

         !***
         !*** integrate along this segment, detecting intersections 
         !*** and computing the line integral for each sub-segment
         !***

!        do while (ybeg /= yend .or. xbeg /= xend)
         do while ( abs(yend-ybeg) > 1.e-11 .or. abs(xend-xbeg) > 1.e-11)

            !***
            !*** prevent infinite loops if integration gets stuck
            !*** near cell or threshold boundary
            !***

            num_subseg = num_subseg + 1
            if (num_subseg > max_subseg) then
               print *,i,j,k,xbeg,xend,ybeg,yend
               call abort_code(  &
                  'integration stalled: num_subseg exceeded limit')
            endif

            !***
            !*** find next intersection of this segment with a grid
            !*** line on the destination grid.  Offset from last
            !*** intersection to nudge into next grid cell.
            !***

            call SCRIP_Grid_Intersect(src_add, x_intersect, y_intersect,   &
                                      xoff, yoff, lcoinc, regrid%src_grid, &
                                      xbeg, ybeg, xend, yend, full_line)
            i = src_add(1)
            j = src_add(2)
            k = src_add(3)

            !***
            !*** compute line integral for this subsegment.
            !***

            call line_integral(weights,                       &
                               x_intersect_last, x_intersect, &
                               y_intersect_last, y_intersect, &
                               xref, yref)

            !***
            !*** if integrating in reverse order, change
            !*** sign of weights
            !***

            if (lreverse) then
               weights = -weights
            endif

            !***
            !*** store the appropriate addresses and weights. 
            !*** also add contributions to cell areas and centroids.
            !***

            if (src_add(1) /= 0) then
               if (regrid%src_grid%mask(i,j,k)) then
                  call SCRIP_Regrid_AddLink(regrid, &
                                            src_add, dst_add, weights)
                  src_frac( i, j, k) = src_frac( i, j, k) + weights(1)
                  dst_frac(ii,jj,kk) = dst_frac(ii,jj,kk) + weights(1)
               endif
            endif

            dst_area(ii,jj,kk) = dst_area(ii,jj,kk) + weights(1)
            dst_centroid_x(ii,jj,kk) = &
            dst_centroid_x(ii,jj,kk) + weights(2)
            dst_centroid_y(ii,jj,kk) = &
            dst_centroid_y(ii,jj,kk) + weights(3)

            !***
            !*** reset ybeg and xbeg for next subsegment.
            !***

            x_intersect_last = x_intersect
            y_intersect_last = y_intersect
            xbeg = x_intersect + xoff
            ybeg = y_intersect + yoff
         end do

         !***
         !*** end of segment
         !***

      end do corner_loop2

      !***
      !*** finished with this cell - start on next cell
      !***

   end do dst_loopi
   end do
   end do

!-----------------------------------------------------------------------
!
!  correct for situations where N/S pole not explicitly included in
!  grid (i.e. as a grid corner point). if pole is missing from only
!  one grid, need to correct only the area and centroid of that 
!  grid.  if missing from both, do complete weight calculation.
!
!-----------------------------------------------------------------------

   !*** North Pole
   weights(1) =  pi2
   weights(2) =  pi*pi
   weights(3) =  c0

   src_add = 0
   pole_loop1: do k=1,nsbdm_src
   do j=1,ny_src
   do i=1,nx_src
      if (src_area(i,j,k) < -1.5*pi .and. &
          regrid%src_grid%center_y(i,j,k) > c0) then
         src_area(i,j,k) = src_area(i,j,k) + weights(1)
         src_centroid_x(i,j,k) = &
         src_centroid_x(i,j,k) + weights(2)
         src_centroid_y(i,j,k) = &
         src_centroid_y(i,j,k) + weights(3)
         if (regrid%src_grid%mask(i,j,k)) then
            src_frac(i,j,k) = src_frac(i,j,k) + weights(1)
            src_add(1) = i  ! store at least one address 
            src_add(2) = j  ! for making a link
            src_add(3) = k
         endif

      endif
   end do
   end do
   end do pole_loop1

   pole_loop2: do kk=kb,ke
   do jj=1,ny_dst
   do ii=1,nx_dst
      if (dst_area(ii,jj,kk) < -1.5*pi .and. &
          regrid%dst_grid%center_y(ii,jj,kk) > c0) then
         dst_area(ii,jj,kk) = dst_area(ii,jj,kk) + weights(1)
         dst_centroid_x(ii,jj,kk) = &
         dst_centroid_x(ii,jj,kk) + weights(2)
         dst_centroid_y(ii,jj,kk) = &
         dst_centroid_y(ii,jj,kk) + weights(3)
         if (regrid%dst_grid%mask(ii,jj,kk)) then
            dst_frac(ii,jj,kk) = dst_frac(ii,jj,kk) + weights(1)
            dst_add(1) = ii
            dst_add(2) = jj
            dst_add(3) = kk
            if (src_add(1) /= 0 .and. dst_add(1) /=0) &
            call SCRIP_Regrid_AddLink(regrid, src_add, dst_add, weights)

         endif

      endif
   end do
   end do
   end do pole_loop2


   !*** South Pole
   weights(1) =  pi2
   weights(2) = -pi*pi
   weights(3) =  c0

   src_add = 0
   pole_loop3: do k=1,nsbdm_src
   do j=1,ny_src
   do i=1,nx_src
      if (src_area(i,j,k) < -1.5*pi .and. &
          regrid%src_grid%center_y(i,j,k) < c0) then
         src_area(i,j,k) = src_area(i,j,k) + weights(1)
         src_centroid_x(i,j,k) = &
         src_centroid_x(i,j,k) + weights(2)
         src_centroid_y(i,j,k) = &
         src_centroid_y(i,j,k) + weights(3)
         src_add(1) = i  ! store at least one address 
         src_add(2) = j  ! for making a link
         src_add(3) = k
         if (regrid%src_grid%mask(i,j,k)) then
            src_frac(i,j,k) = src_frac(i,j,k) + weights(1)
         endif
      endif
   end do
   end do
   end do pole_loop3

   dst_add = 0
   pole_loop4: do kk=kb,ke
   do jj=1,ny_dst
   do ii=1,nx_dst
      if (dst_area(ii,jj,kk) < -1.5*pi .and. &
          regrid%dst_grid%center_y(ii,jj,kk) < c0) then
         dst_area(ii,jj,kk) = dst_area(ii,jj,kk) + weights(1)
         dst_centroid_x(ii,jj,kk) = &
         dst_centroid_x(ii,jj,kk) + weights(2)
         dst_centroid_y(ii,jj,kk) = &
         dst_centroid_y(ii,jj,kk) + weights(3)

         if (regrid%dst_grid%mask(ii,jj,kk)) then
            dst_frac(ii,jj,kk) = dst_frac(ii,jj,kk) + weights(1)
            dst_add(1) = ii
            dst_add(2) = jj
            dst_add(3) = kk
            if (src_add(1) /= 0) &
            call SCRIP_Regrid_AddLink(regrid, src_add, dst_add, weights)

         endif
      endif
   end do
   end do
   end do pole_loop4

!-----------------------------------------------------------------------
!
!  finish centroid computation
!
!-----------------------------------------------------------------------

   where (src_area /= c0)
      src_centroid_x = src_centroid_x/src_area
      src_centroid_y = src_centroid_y/src_area
   end where

   where (dst_area /= c0)
      dst_centroid_x = dst_centroid_x/dst_area
      dst_centroid_y = dst_centroid_y/dst_area
   end where

!-----------------------------------------------------------------------
!
!  include centroids in weights and normalize using destination
!  area if requested
!
!-----------------------------------------------------------------------

   do n=1,regrid%num_links
      i  = regrid%src_add(1,n)
      j  = regrid%src_add(2,n)
      k  = regrid%src_add(3,n)
      ii = regrid%dst_add(1,n)
      jj = regrid%dst_add(2,n)
      kk = regrid%dst_add(3,n)
      weights = regrid%weights(:,n)

      !*** normalize weights to make consistent with
      !*** user-computed cell areas (rather than SCRIP-computed
      !*** areas

      select case(regrid%norm_opt)
      case(SCRIP_RegridNormOptNone)
         norm_factor = c1

      case (SCRIP_RegridNormOptDstarea)
         if (dst_area(ii,jj,kk) /= c0) then
            norm_factor = c1/dst_area(ii,jj,kk)
         else
            norm_factor = c0
         endif

      case (SCRIP_RegridNormOptfrcarea)
         if (dst_frac(ii,jj,kk) /= c0) then
            norm_factor = c1/dst_frac(ii,jj,kk)
         else
            norm_factor = c0
         endif

      end select

      regrid%weights(1,n) =  weights(1)*norm_factor
      regrid%weights(2,n) = (weights(2) -                       &
                             weights(1)*src_centroid_x(i,j,k))* &
                            norm_factor
      regrid%weights(3,n) = (weights(3) -                       &
                             weights(1)*src_centroid_y(i,j,k))* &
                            norm_factor

   end do

   where (src_area /= c0) src_frac = src_frac/src_area
   where (dst_area /= c0) dst_frac = dst_frac/dst_area

!-----------------------------------------------------------------------
!
!  perform some error checking on final weights
!
!-----------------------------------------------------------------------

   do k=1,nsbdm_src
   do j=1,ny_src
   do i=1,nx_src
      if (src_area(i,j,k) < -.01) then
         print *,'Source grid area error: ', &
                 my_task,i,j,k,src_area(i,j,k)
      endif
      src_centroid_x(i,j,k) = c0
      src_centroid_y(i,j,k) = c0
   end do
   end do
   end do

   do kk=kb,ke
   do jj=1,ny_dst
   do ii=1,nx_dst
      if (dst_area(ii,jj,kk) < -.01) then
         print *,'Destination grid area error: ', &
                 my_task,ii,jj,kk,dst_area(ii,jj,kk)
      endif
      dst_centroid_x(ii,jj,kk) = c0
      dst_centroid_y(ii,jj,kk) = c0
   end do
   end do
   end do

   do n=1,regrid%num_links
      src_add = regrid%src_add(:,n)
      dst_add = regrid%dst_add(:,n)
        
      if (regrid%weights(1,n) < -.05) then
         print *,'Regrid weight < 0 ', src_add, dst_add, &
                                       my_task,regrid%weights(1,n)
      endif
      !if (norm_opt /= norm_opt_none .and. wts_map1(1,n) > 1.01) then
      if (regrid%weights(1,n) > 1.05) then
         print *,'Regrid weight > 1 ', src_add, dst_add, &
                                       my_task,regrid%weights(1,n)
      endif
      !*** sum the 1st weight for each dest grid point
      dst_centroid_y(dst_add(1),dst_add(2),dst_add(3)) = & 
      dst_centroid_y(dst_add(1),dst_add(2),dst_add(3)) + regrid%weights(1,n)
   end do

   !*** check whether weights sum to the correct values
   do kk=kb,ke
   do jj=1,ny_dst
   do ii=1,nx_dst
      select case(regrid%norm_opt)
      case (SCRIP_RegridNormOptDstarea)
         norm_factor = dst_frac(ii,jj,kk)
      case (SCRIP_RegridNormOptFrcarea)
         norm_factor = c1
      case (SCRIP_RegridNormOptNone)
         norm_factor = dst_area(ii,jj,kk)*dst_frac(ii,jj,kk)
      end select
      if (abs(dst_centroid_y(ii,jj,kk)) > 1.d-12 .and. &
          abs(dst_centroid_y(ii,jj,kk)-norm_factor) > .05) then
         print *,'Error: sum of weights for regrid ',ii,jj,kk, &
                  dst_centroid_y(ii,jj,kk),norm_factor
      endif
   end do
   end do
   end do

!-----------------------------------------------------------------------
!
!  clean up and exit
!
!-----------------------------------------------------------------------

   deallocate(src_frac, dst_frac, src_area, dst_area, &
              src_centroid_x, src_centroid_y,         &
              dst_centroid_x, dst_centroid_y)

!-----------------------------------------------------------------------
!EOC

 end subroutine SCRIP_Regrid_Create_Conserv

!***********************************************************************
!BOP
! !IROUTINE: line_integral
! !INTERFACE:

 subroutine line_integral(weights,                              &
                          xbeg, xend, ybeg, yend, xref, yref)


! !DESCRIPTION:
!  This routine computes the line integral of the functions that
!  result in the area overlaps and second-order weights (mean
!  distance from centroid).  The line is defined by the input 
!  lat/lon of the endpoints and the path is assumed to be linear in
!  lat/lon space.  x is assumed to be longitude; y is latitude, both
!  in radians.
!
! !REVISION HISTORY:
!  same as module

! !OUTPUT PARAMETERS:

   real (dbl_kind), dimension(3), intent(out) :: &
      weights    ! the line-integral contribution to each weight

! !INPUT PARAMETERS:

   real (dbl_kind), intent(in) :: &
      xbeg, ybeg,     &! x,y coordinates of beginning endpoint
      xend, yend,     &! x,y coordinates of end       endpoint
      xref, yref       ! reference x,y to insure consistency in longitude

!EOP
!BOC
!-----------------------------------------------------------------------
!
!  local variables
!
!-----------------------------------------------------------------------

   real (dbl_kind) :: &
      dphi,           &! longitude difference for integral
      sinth1, sinth2, &! sines of latitude endpoints
      costh1, costh2, &! cosines of latitude endpoint
      f1, f2,         &! longitude weight function evaluated at endpoints
      phi1, phi2,     &! longitude differences
      fac, fint        ! for use in longitude integrals

!-----------------------------------------------------------------------
!
!  weights for the general case based on a trapezoidal approx to
!  the integrals.
!
!-----------------------------------------------------------------------

   sinth1 = SIN(ybeg)
   sinth2 = SIN(yend)
   costh1 = COS(ybeg)
   costh2 = COS(yend)

   dphi = xbeg - xend
   if (dphi >  pi) then
      dphi = dphi - pi2
   else if (dphi < -pi) then
      dphi = dphi + pi2
   endif
   dphi = p5*dphi

!-----------------------------------------------------------------------
!
!  the first weight is the area overlap integral. the third is
!  the second-order latitude gradient weights.
!
!-----------------------------------------------------------------------

   weights(1) = dphi*(sinth1 + sinth2)
   weights(3) = dphi*(costh1 + costh2 + (ybeg*sinth1 + yend*sinth2))

!-----------------------------------------------------------------------
!
!  the second weight is the second-order longitude gradient
!  component.  must be careful of longitude range.
!
!-----------------------------------------------------------------------

   f1 = p5*(costh1*sinth1 + ybeg)
   f2 = p5*(costh2*sinth2 + yend)

   phi1 = xbeg - xref
   if (phi1 >  pi) then
      phi1 = phi1 - pi2
   else if (phi1 < -pi) then
      phi1 = phi1 + pi2
   endif

   phi2 = xend - xref
   if (phi2 >  pi) then
      phi2 = phi2 - pi2
   else if (phi2 < -pi) then
      phi2 = phi2 + pi2
   endif

   if ((phi2-phi1) <  pi .and. (phi2-phi1) > -pi) then
      weights(2) = dphi*(phi1*f1 + phi2*f2)
   else
      if (phi1 > c0) then
         fac = pi
      else
         fac = -pi
      endif
      fint = f1 + (f2-f1)*(fac-phi1)/abs(dphi)
      weights(2) = p5*phi1*(phi1-fac)*f1 - &
                   p5*phi2*(phi2+fac)*f2 + &
                   p5*fac*(phi1+phi2)*fint
   endif

!-----------------------------------------------------------------------
!EOC

 end subroutine line_integral

!***********************************************************************

 end module SCRIP_Regrid_Conserv

!***********************************************************************
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
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
