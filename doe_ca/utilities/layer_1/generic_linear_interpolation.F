!=============================================================================
! BEGIN GENERIC_LINEAR_INTERPOLATION
!=============================================================================
 MODULE generic_linear_interpolation

!-------------------------------------------------------------------------
! a set of routines to find data surrounding a given time and do
! linear interpolation
!-------------------------------------------------------------------------
   use kinds

   public :: find_bounding_indices, &
             linear_interpolation

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
   contains
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!=============================================================================
! BEGIN FIND_BOUNDING_INDICES
!=============================================================================
 subroutine find_bounding_indices(ntime, time_vector, time_stamp, ibeg, iend, period)
 integer (kind=int_kind), intent(in) ::  ntime
 real (kind=dbl_kind), intent(in) :: time_vector(ntime), time_stamp
 real (kind=dbl_kind), intent(in), optional :: period
 integer (kind=int_kind), intent(out) :: ibeg, iend
 logical :: periodic
 real (kind=dbl_kind) :: local_time_stamp
 integer (kind=int_kind) :: i
 logical :: found

 periodic = .false.
 local_time_stamp = time_stamp
 if(present(period)) then
    periodic = .true.
    local_time_stamp = mod(time_stamp,period)
 endif

 i = 0
 found = .false.
 do while (.not.found.and.i.lt.ntime)
  i = i+1
  if(local_time_stamp < time_vector(i)) then
     iend = i
     found = .true.
  endif
 end do

 if(.not.found) then
   if(present(period)) then
     if(periodic) then
       ibeg = ntime; iend = 1
     else
       write(6,*) ' find_bounding_indices : periodic equal false'
       stop
     endif
    else
     write(6,*) ' find_bounding_indices : data not found'
     stop
   endif
 else
   ibeg = iend - 1
   if(ibeg==0) ibeg = ntime
 endif
 end subroutine find_bounding_indices
!=============================================================================
! END FIND_BOUNDING_INDICES
!=============================================================================


!=============================================================================
! BEGIN LINEAR_INTERPOLATION
!=============================================================================
 subroutine linear_interpolation(ndata, xbeg, xend, x,  ybeg, yend, yout, period)
 integer (kind=int_kind), intent(in) :: ndata
 real (kind=dbl_kind), intent(in)  :: xbeg, xend, x, ybeg(ndata), yend(ndata)
 real (kind=dbl_kind), intent(in), optional :: period
 real (kind=dbl_kind), intent(out) :: yout(ndata)
 real (kind=dbl_kind) :: m, xbeg_local, x_local
 integer (kind=int_kind) :: i

 xbeg_local = xbeg
 if(present(period)) then
  if(xend < xbeg_local) xbeg_local = xbeg_local - period
 endif

 x_local = x
 do while (x_local > xend)
  x_local = x_local - period
 enddo
 if(x_local < xbeg_local) then
  write(6,*) ' what?',xbeg_local, x_local, xend
 endif
  
 if(xend==xbeg_local) then
   write(6,*) ' linear interpolation: xbeg_local and xend equal'
   stop
 endif

 do i=1,ndata
  m = (yend(i) - ybeg(i)) / (xend - xbeg_local)
  yout(i) = m*(x_local - xbeg_local) + ybeg(i)
 enddo

 end subroutine linear_interpolation

 END module generic_linear_interpolation
! =============================================================================
! END GENERIC_LINEAR_INTERPOLATION
!=============================================================================
