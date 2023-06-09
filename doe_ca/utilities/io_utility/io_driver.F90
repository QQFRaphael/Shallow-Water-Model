!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 
program io_driver

!-------------------------------------------------------------------------------
!
! Purpose: This program is a driver to test the io_utilities module.
!

! Author: Don Dazlich, Dept. of Atmospheric Science, Colorado State University
!
! History: 08 Apr 2002 - began creation of this program.
!

!
! Modules used
!
use kinds
use io_utilities

implicit none

! define the atmospheric restart variables

integer (kind=int_kind), parameter :: max_ig = 2562
integer (kind=int_kind), parameter :: im = 170
integer (kind=int_kind), parameter :: jm = 18
integer (kind=int_kind), parameter :: im5 = im / 5
integer (kind=int_kind), parameter :: iim = 18
integer (kind=int_kind), parameter :: jjm = 18
integer (kind=int_kind), parameter :: nsdm = 10
integer (kind=int_kind), parameter :: ntprog = 2
integer (kind=int_kind), parameter :: nlm = 17
integer (kind=int_kind), parameter :: ntracer = 5
integer (kind=int_kind), parameter :: iq = 1
integer (kind=int_kind), parameter :: icw = 2
integer (kind=int_kind), parameter :: irw = 3
integer (kind=int_kind), parameter :: ici = 4
integer (kind=int_kind), parameter :: iri = 5
real (kind=dbl_kind), parameter :: c0 = 0.0_dbl_kind

real (kind=dbl_kind), dimension(iim,jjm,ntprog,nsdm) ::  &
      ps = c0,                                           &
      pb = c0
real (kind=dbl_kind), dimension(iim,jjm,nlm,ntprog,nsdm) ::       &
      eta = c0,                                                   &
      div = c0,                                                   &
      th = c0
real (kind=dbl_kind), dimension(iim,jjm,nlm,ntracer,ntprog,nsdm) ::  &
      tracer = c0
integer (kind=int_kind) :: nsecond

integer (kind=int_kind), dimension(im,jm) :: grid_indx_glbl = 0
integer (kind=int_kind), dimension(iim,jjm,nsdm) :: grid_indx = 0

integer (kind=int_kind) :: i, j, panel, ii, icount      !! indices and counters
integer (kind=int_kind) :: off, nsd, isd, ksdm , np, l  !! indices and counters

! compute the grid_index

grid_indx_glbl(1,jm-1) = 1
grid_indx_glbl(im-1,1) = 2
icount=2
DO j = 2,jm-1
   DO panel = 0,4
      DO i = 2,im5-1
         icount=icount+1
         ii = im5*panel+i
         grid_indx_glbl(ii,j)=icount
      ENDDO
   ENDDO
ENDDO

! scatter the grid indx

nsd = 0
DO panel = 0,4
   off = im5*panel
   DO isd = 0,1
      nsd = nsd + 1
      DO j = 1,jjm
         DO i = 1,iim
            grid_indx(i,j,nsd) =                   &
               grid_indx_glbl(off+(iim-2)*isd+i,j)
         ENDDO
      ENDDO
   ENDDO
ENDDO

!-------------------------------------------------------------------------------
!
! sample code to read an atmospheric restart
!
!-------------------------------------------------------------------------------

! open the restart file (reads header records implicitly

call open_read_direct_file( 'data/ic_atm' )

! get the time stamp

call read_time_stamp( nsecond )

! get data, one grid cell at a time

do ksdm = 1,nsdm
   do j = 1,jjm
      do i = 1,iim

         if(grid_indx(i,j,ksdm) /= 0) then
            call read_record( grid_indx(i,j,ksdm) )

! note: order of unpack calls is irrelevent

            call unpack_data_record ( 'PS',    ps(i,j,:,ksdm) )
            call unpack_data_record ( 'PB',    pb(i,j,:,ksdm) )
            call unpack_data_record ( 'ETA',   eta(i,j,:,:,ksdm) )
            call unpack_data_record ( 'DIV',   div(i,j,:,:,ksdm) )
            call unpack_data_record ( 'THETA', th(i,j,:,:,ksdm) )
            call unpack_data_record ( 'Q',     tracer(i,j,:,iq,:,ksdm) )
            call unpack_data_record ( 'CW',    tracer(i,j,:,icw,:,ksdm) )
            call unpack_data_record ( 'CI',    tracer(i,j,:,ici,:,ksdm) )
            call unpack_data_record ( 'RW',    tracer(i,j,:,irw,:,ksdm) )
            call unpack_data_record ( 'RI',    tracer(i,j,:,iri,:,ksdm) )
         endif

      enddo
   enddo
enddo

! close the file

call close_direct_file


! write ezplot readable file based on input

open(unit=11,file='ezrst.2',form='unformatted')
do np = 1,ntprog
   call write_ezslice( ps(:,:,np,:), im, jm, iim, jjm, nsdm, max_ig )
   call write_ezslice( pb(:,:,np,:), im, jm, iim, jjm, nsdm, max_ig )
   do l = 1,nlm
      call write_ezslice( eta(:,:,l,np,:), im, jm, iim, jjm, nsdm, max_ig )
      call write_ezslice( div(:,:,l,np,:), im, jm, iim, jjm, nsdm, max_ig )
      call write_ezslice( th(:,:,l,np,:), im, jm, iim, jjm, nsdm, max_ig )
      call write_ezslice( tracer(:,:,l,iq,np,:), im, jm, iim, jjm, nsdm, max_ig )
      call write_ezslice( tracer(:,:,l,icw,np,:), im, jm, iim, jjm, nsdm, max_ig )
      call write_ezslice( tracer(:,:,l,irw,np,:), im, jm, iim, jjm, nsdm, max_ig )
      call write_ezslice( tracer(:,:,l,ici,np,:), im, jm, iim, jjm, nsdm, max_ig )
      call write_ezslice( tracer(:,:,l,iri,np,:), im, jm, iim, jjm, nsdm, max_ig )
   enddo
enddo
close(11)


end program io_driver

subroutine write_ezslice( x1, im, jm, iim, jjm, nsdm, max_ig )

use kinds

implicit none

integer (kind=int_kind), intent(in) :: im, jm, iim, jjm, nsdm, max_ig
real (kind=dbl_kind), intent(in), dimension(iim,jjm,nsdm) :: x1
real (kind=real_kind), dimension(im,jm) :: x2
real (kind=real_kind), dimension(max_ig) :: x3

integer (kind=int_kind) :: nsd, panel, off, isd, i, j, icount, im5, ii

im5 = im / 5

! gather to global grid

nsd = 0
DO panel = 0,4
   off = (im5)*panel
   DO isd = 0,1
      nsd = nsd + 1
      DO j = 1,jjm
         DO i = 1,iim
            x2(off+(iim-2)*isd+i,j) = x1(i,j,nsd)
         ENDDO
      ENDDO
   ENDDO
ENDDO

! reduce to vector

x3(1)=x2(1,jm-1)
x3(2)=x2(im-1,1)
icount=2
DO j = 2,jm-1
   DO panel = 0,4
      DO i = 2,im5-1
         icount=icount+1
         ii = im5*panel+i
         x3(icount)=x2(ii,j)
      ENDDO
   ENDDO
ENDDO

write(11)x3

end subroutine write_ezslice

