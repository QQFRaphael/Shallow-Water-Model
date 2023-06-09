!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||!!!!!!! 
program build_restart

!-------------------------------------------------------------------------------
!
! Purpose: This program builds a new format restart using the io_utility.
!

! Author: Don Dazlich, Dept. of Atmospheric Science, Colorado State University
!
! History: 17 Apr 2002 - began creation of this program.
!

!
! Modules used
!
use kinds
use io_utilities

implicit none

! define the atmospheric restart variables

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

integer (kind=int_kind) :: i, j, panel, ii, icount !! indices and counters
integer (kind=int_kind) :: off, nsd, isd, ksdm     !! indices and counters

! old restart variables
integer (kind=int_kind) :: step_count, nlm_tem, ntracer_tem, ntprog_tem,  &
                           max_ig, lrecl, nt, np, ibeg, iend, ioerr, l
real (kind=dbl_kind) :: tau
real (kind=dbl_kind), allocatable, dimension(:) :: xrec

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

! read an old style restart

open(4,file='./model_restart_atm.d000425',form='unformatted', action='read', &
         access='DIRECT', recl=36, status='old', iostat=ioerr )
read(4,rec=1)nsecond,step_count,tau,max_ig, nlm_tem, &    
         ntracer_tem,ntprog_tem,lrecl
close(4)
allocate( xrec( lrecl/kind(xrec) ) )
open(4,file='./model_restart_atm.d000425',form='unformatted', &
         access='DIRECT', recl=lrecl)
do ksdm = 1,nsdm
   do j = 1,jjm
      do i = 1,iim

         if(grid_indx(i,j,ksdm) /= 0) then
            read(4,rec=1+grid_indx(i,j,ksdm)) xrec
              ibeg=1
              iend=1+ntprog-1
              ps(i,j,1:ntprog,ksdm) = xrec(ibeg:iend)
                ibeg=iend+1
                iend = ibeg+ntprog-1
                pb(i,j,1:ntprog,ksdm) = xrec(ibeg:iend)
              do np = 1,ntprog
                ibeg=iend+1
                iend = ibeg+nlm-1
                eta(i,j,1:nlm,np,ksdm) = xrec(ibeg:iend)
              enddo
              do np = 1,ntprog
                ibeg=iend+1
                iend = ibeg+nlm-1
                div(i,j,1:nlm,np,ksdm) = xrec(ibeg:iend)
              enddo
              do np = 1,ntprog
                ibeg=iend+1
                iend = ibeg+nlm-1
                th(i,j,1:nlm,np,ksdm) = xrec(ibeg:iend)
              enddo
              do nt = 1,5
                do np=1,ntprog
                  ibeg=iend+1
                  iend = ibeg+nlm-1
                  tracer(i,j,1:nlm,nt,np,ksdm) = xrec(ibeg:iend)
                enddo
              enddo

         endif
      enddo
   enddo
enddo
deallocate(xrec)
close(4)


!-------------------------------------------------------------------------------
!
! sample code to write an atmospheric restart
!
!-------------------------------------------------------------------------------

! start packing the header - order is important

call pack_header( 'PS',    1, (/ntprog/)  )
call pack_header( 'PB',    1, (/ntprog/)  )
call pack_header( 'ETA',   2, (/nlm, ntprog/)  )
call pack_header( 'DIV',   2, (/nlm, ntprog/)  )
call pack_header( 'THETA', 2, (/nlm, ntprog/)  )
call pack_header( 'Q',     2, (/nlm, ntprog/)  )
call pack_header( 'CW',    2, (/nlm, ntprog/)  )
call pack_header( 'RW',    2, (/nlm, ntprog/)  )
call pack_header( 'CI',    2, (/nlm, ntprog/)  )
call pack_header( 'RI',    2, (/nlm, ntprog/)  )

! open the restart file (write header records implicitly

call open_write_header( 'data/ic_atm', max_ig, .true., dbl_kind )

! write the time stamp

call write_time_stamp( nsecond )

! write data, one grid cell at a time

do ksdm = 1,nsdm
   do j = 1,jjm
      do i = 1,iim

         if(grid_indx(i,j,ksdm) /= 0) then

! note: order of pack calls is irrelevent

            call pack_data_record ( 'PS',    ps(i,j,:,ksdm) )
            call pack_data_record ( 'PB',    pb(i,j,:,ksdm) )
            call pack_data_record ( 'ETA',   eta(i,j,:,:,ksdm) )
            call pack_data_record ( 'DIV',   div(i,j,:,:,ksdm) )
            call pack_data_record ( 'THETA', th(i,j,:,:,ksdm) )
            call pack_data_record ( 'Q',     tracer(i,j,:,iq,:,ksdm) )
            call pack_data_record ( 'CW',    tracer(i,j,:,icw,:,ksdm) )
            call pack_data_record ( 'CI',    tracer(i,j,:,ici,:,ksdm) )
            call pack_data_record ( 'RW',    tracer(i,j,:,irw,:,ksdm) )
            call pack_data_record ( 'RI',    tracer(i,j,:,iri,:,ksdm) )
            call write_record( grid_indx(i,j,ksdm) )

         endif

      enddo
   enddo
enddo

! close the file

call close_direct_file

! write ezplot readable file based on input

open(unit=11,file='ezrst.1',form='unformatted')
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


end program build_restart

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

