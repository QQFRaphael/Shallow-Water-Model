
	module dx_module

!-----------------------------------------------------------------------
! PURPOSE: write out data needed for visualization via the OpenDX
!	software package
!-----------------------------------------------------------------------

	use kinds
	use params_parallel_xxx
	use params_grid_horizontal_xxx
	use component_intra
        use swm_parameters
	use grid_mask_variables_xxx
 	use gather_scatter
	use geodesic_grid_utilities
	use grid_metrics_variables_xxx
	
	implicit none
	private

        logical, parameter:: l_full_write = .false.

	real (kind=dbl_kind), dimension(im,jm) :: work
        real (kind=dbl_kind), dimension(max_ig) ::   igvec
        integer (kind = int_kind), parameter :: &
          h_file = 47, lat_file = 48, lon_file = 49, area_file = 50
    integer (kind=int_kind) :: ierr

    public ::      &
       write_dx_coordinate_data,     &
       write_dx_data,                &
       write_dx_init,                &
       open_files

!**********************************************************************

        contains

!**********************************************************************


!======================================================================
! BEGINNING OF WRITE_DX_COORDINATE_DATA
!======================================================================
	subroutine write_dx_coordinate_data 

	implicit none

	integer (kind=int_kind) ::                                   &
      		i,j,k,l,ic,iface,iloop,iedge,ksdm,ip

        real (kind = dbl_kind) ::                                    &
      		t           (ndata, r3),                             &
      		nl          (r3),                                    &
      		tg          (r3),                                    &
                vw          (r3),                                    &
      		g           (r3)

!----------------------------------------------------------------------------
! keep the user informed
!----------------------------------------------------------------------------
       if(my_task.eq.0) then
          write(6,*) 
          write(6,*) ' writing coordinate data for OpenDX visualization'
	endif

!----------------------------------------------------------------------------
!----------------------------------------------------------------------------
!
! DESCRIPTION OF FACE DATA IS WRITTEN OUT FIRST
!
!----------------------------------------------------------------------------
!----------------------------------------------------------------------------

!----------------------------------------------------------------------------
! initialize the edge, face, and loop counter
!----------------------------------------------------------------------------
        iedge = 0
        iface = 0
        iloop = 0
	if(my_task.eq.0) then
	  open(61,file='fort.61',form='formatted',status='replace')
          write(61,*) iedge,iface,iloop
	  close(61)
	endif

!----------------------------------------------------------------------------
! loop over each process. listing of output is process dependent
!    note, running on a different number of processors will give a different
!    ordering of the data. this is not a problem, just something to keep in mind
!----------------------------------------------------------------------------
	do ip = 0,npe-1

!----------------------------------------------------------------------------
! everyone wait
!----------------------------------------------------------------------------
#if mpi == 1
	CALL MPI_BARRIER (MPI_COMM_swm,ierr)
#endif

!----------------------------------------------------------------------------
! pick one process to write out its data
!----------------------------------------------------------------------------
	if(my_task.eq.ip) then

!----------------------------------------------------------------------------
! get counter from scratch file
!----------------------------------------------------------------------------
	open(61,file='fort.61',form='formatted',status='old')
        read(61,*) iedge,iface,iloop
	close(61)

!----------------------------------------------------------------------------
! open files
!   if it is the first process, open as "replace", else open as "append"
!----------------------------------------------------------------------------
	if(my_task.eq.0) then
          open(9,file='dx/cellcenters.data',form='formatted',status='replace')
          open(10,file='dx/position.data',form='formatted',status='replace')
          open(11,file='dx/edge.data',form='formatted',status='replace')
          open(12,file='dx/loop.data',form='formatted',status='replace')
          open(13,file='dx/face.data',form='formatted',status='replace')
          open(14,file='dx/area.data',form='formatted',status='replace')
	else
          open(9,file='dx/cellcenters.data',form='formatted',position='append')
          open(10,file='dx/position.data',form='formatted',position='append')
          open(11,file='dx/edge.data',form='formatted',position='append')
          open(12,file='dx/loop.data',form='formatted',position='append')
          open(13,file='dx/face.data',form='formatted',position='append')
          open(14,file='dx/area.data',form='formatted',position='append')
	endif

!----------------------------------------------------------------------------
! loop over each point in the domain
!----------------------------------------------------------------------------
	do k=1,nsdm
        do j=1,jjm
        do i=1,iim

!----------------------------------------------------------------------------
! if it is a hexagon
!----------------------------------------------------------------------------
	if(polygon_type(i,j,k) == 1.0_dbl_kind) then
	  write( 9,10) p(1,  i  ,j  ,k), p(2,  i  ,j  ,k), p(3,  i  ,j  ,k)
          write(10,10) c(1,1,i  ,j  ,k), c(2,1,i  ,j  ,k), c(3,1,i  ,j  ,k)
          write(10,10) c(1,2,i  ,j  ,k), c(2,2,i  ,j  ,k), c(3,2,i  ,j  ,k)
          write(10,10) c(1,1,i+1,j  ,k), c(2,1,i+1,j  ,k), c(3,1,i+1,j  ,k)
          write(10,10) c(1,2,i+1,j+1,k), c(2,2,i+1,j+1,k), c(3,2,i+1,j+1,k)
          write(10,10) c(1,1,i+1,j+1,k), c(2,1,i+1,j+1,k), c(3,1,i+1,j+1,k)
          write(10,10) c(1,2,i  ,j+1,k), c(2,2,i  ,j+1,k), c(3,2,i  ,j+1,k)
        endif

!----------------------------------------------------------------------------
! if it is a pentagon
!----------------------------------------------------------------------------
        if(polygon_type(i,j,k) == 2.0_dbl_kind) then
          write( 9,10) p(1,  i  ,j  ,k), p(2,  i  ,j  ,k), p(3,  i  ,j  ,k)
          write(10,10) c(1,1,i  ,j  ,k), c(2,1,i  ,j  ,k), c(3,1,i  ,j  ,k)
          write(10,10) c(1,2,i  ,j  ,k), c(2,2,i  ,j  ,k), c(3,2,i  ,j  ,k)
          write(10,10) c(1,1,i+1,j  ,k), c(2,1,i+1,j  ,k), c(3,1,i+1,j  ,k)
          write(10,10) c(1,2,i+1,j+1,k), c(2,2,i+1,j+1,k), c(3,2,i+1,j+1,k)
          write(10,10) c(1,2,i+1,j+1,k), c(2,2,i+1,j+1,k), c(3,2,i+1,j+1,k)
          write(10,10) c(1,2,i  ,j+1,k), c(2,2,i  ,j+1,k), c(3,2,i  ,j+1,k)
        endif

!----------------------------------------------------------------------------
! if it is the north pole
!----------------------------------------------------------------------------
        if(polygon_type(i,j,k) == 3.0_dbl_kind) then
          write( 9,10) p(1,  i  ,j  ,k), p(2,  i  ,j  ,k), p(3,  i  ,j  ,k)
          write(10,10) c(1,1,i  ,j  ,k), c(2,1,i  ,j  ,k), c(3,1,i  ,j  ,k)
          write(10,10) c(1,2,i  ,j  ,k), c(2,2,i  ,j  ,k), c(3,2,i  ,j  ,k)
          write(10,10) c(1,1,i+1,j  ,k), c(2,1,i+1,j  ,k), c(3,1,i+1,j  ,k)
          write(10,10) c(1,2,i+1,j+1,k), c(2,2,i+1,j+1,k), c(3,2,i+1,j+1,k)
          write(10,10) c(1,1,i+1,j+1,k), c(2,1,i+1,j+1,k), c(3,1,i+1,j+1,k)
          write(10,10) c(1,1,i+1,j+1,k), c(2,1,i+1,j+1,k), c(3,1,i+1,j+1,k)
        endif

!----------------------------------------------------------------------------
! if it is the south pole
!----------------------------------------------------------------------------
        if(polygon_type(i,j,k) == 4.0_dbl_kind) then
          write( 9,10) p(1,  i  ,j  ,k), p(2,  i  ,j  ,k), p(3,  i  ,j  ,k)
          write(10,10) c(1,1,i  ,j  ,k), c(2,1,i  ,j  ,k), c(3,1,i  ,j  ,k)
          write(10,10) c(1,2,i  ,j  ,k), c(2,2,i  ,j  ,k), c(3,2,i  ,j  ,k)
          write(10,10) c(1,2,i  ,j  ,k), c(2,2,i  ,j  ,k), c(3,2,i  ,j  ,k)
          write(10,10) c(1,2,i+1,j+1,k), c(2,2,i+1,j+1,k), c(3,2,i+1,j+1,k)
          write(10,10) c(1,1,i+1,j+1,k), c(2,1,i+1,j+1,k), c(3,1,i+1,j+1,k)
          write(10,10) c(1,2,i  ,j+1,k), c(2,2,i  ,j+1,k), c(3,2,i  ,j+1,k)
        endif

!----------------------------------------------------------------------------
! if it is a "real" point
!----------------------------------------------------------------------------
	if(polygon_type(i,j,k) > 0.0_dbl_kind) then
          write(11,11) iedge,iedge+1,iedge+2,iedge+3,iedge+4,iedge+5
          write(12,12) iloop
          write(13,12) iface
          write(14,14) area(i,j,k)
          iedge = iedge + 6
          iloop = iloop + 6
          iface = iface + 1
	endif

	enddo
	enddo
	enddo

!----------------------------------------------------------------------------
! dump counter to scatch file for next process
!----------------------------------------------------------------------------
        open(61,file='fort.61',form='formatted',status='replace')
        write(61,*) iedge,iface,iloop
        close(61)

!----------------------------------------------------------------------------
! close all the files
!----------------------------------------------------------------------------
        close(9)
        close(10)
        close(11)
        close(12)
        close(13)
        close(14)

	endif

	enddo

!----------------------------------------------------------------------------
! everyone wait
!----------------------------------------------------------------------------
#if mpi == 1
        CALL MPI_BARRIER (MPI_COMM_swm,ierr)
#endif

	if(my_task==0) then
	  write(6,*)
	  write(6,*) ' finished writing coordinate data describing faces'
	endif

!----------------------------------------------------------------------------
!----------------------------------------------------------------------------
!
! DESCRIPTION OF CORNER DATA IS WRITTEN OUT NEXT
!
!----------------------------------------------------------------------------
!----------------------------------------------------------------------------


!----------------------------------------------------------------------------
! initialize the edge, face, and loop counter
!----------------------------------------------------------------------------
        iedge = 0
        iface = 0
        iloop = 0
        if(my_task.eq.0) then
          open(61,file='fort.61',form='formatted',status='replace')
          write(61,*) iedge,iface,iloop
          close(61)
        endif

!----------------------------------------------------------------------------
! loop over each process. listing of output is process dependent
!    note, running on a different number of processors will give a different
!    ordering of the data. this is not a problem, just something to keep in mind
!----------------------------------------------------------------------------
	do ip = 0,npe-1

!----------------------------------------------------------------------------
! everyone wait
!----------------------------------------------------------------------------
#if mpi == 1
        CALL MPI_BARRIER (MPI_COMM_swm,ierr)
#endif

!----------------------------------------------------------------------------
! pick one process to write out its data
!----------------------------------------------------------------------------
        if(my_task.eq.ip) then

!----------------------------------------------------------------------------
! get counter from scratch file
!----------------------------------------------------------------------------
	open(61,file='fort.61',form='formatted',status='old')
        read(61,*) iedge,iface,iloop
        close(61)

!----------------------------------------------------------------------------
! open files
!   if it is the first process, open as "replace", else open as "append"
!----------------------------------------------------------------------------
        if(my_task.eq.0) then
          open(10,file='dx/tri.position.data',form='formatted',status='replace')
          open(11,file='dx/tri.edge.data',form='formatted',status='replace')
          open(12,file='dx/tri.loop.data',form='formatted',status='replace')
          open(13,file='dx/tri.face.data',form='formatted',status='replace')
          open(14,file='dx/tri.area.data',form='formatted',status='replace')
        else
          open(10,file='dx/tri.position.data',form='formatted',position='append')
          open(11,file='dx/tri.edge.data',form='formatted',position='append')
          open(12,file='dx/tri.loop.data',form='formatted',position='append')
          open(13,file='dx/tri.face.data',form='formatted',position='append')
          open(14,file='dx/tri.area.data',form='formatted',position='append')
        endif

!----------------------------------------------------------------------------
! loop over each point in the domain
!----------------------------------------------------------------------------
	do ksdm=1,nsdm
        do j=1,jjm
        do i=1,iim
        do ic=1,ncorners

!----------------------------------------------------------------------------
! if it is a "real" corner, then gather up the surrounding grid cell center points
!----------------------------------------------------------------------------
        if(grid_corner_mask(ic,i,j,ksdm).eq.1.0_dbl_kind) then
        do k=1,3
        call get_surrounding_centers(                                       &
                        i,                                                  &
                        j,                                                  &
                        ic,                                                 &
                        ndata,                                              &
                        iim,                                                &
                        jjm,                                                &
                        polygon_type(i,j,ksdm),                             &
                        p(k,:,:,ksdm),                                      &
                        t(:,k))
        enddo

!----------------------------------------------------------------------------
! dump to file
!----------------------------------------------------------------------------
	write(10,10) t(1,1), t(1,2), t(1,3)
        write(10,10) t(2,1), t(2,2), t(2,3)
        write(10,10) t(3,1), t(3,2), t(3,3)
        write(11,16) iedge,iedge+1,iedge+2
        write(12,12) iloop
        write(13,12) iface
        write(14,14) corner_area(ic,i,j,ksdm)
        iedge = iedge + 3
        iloop = iloop + 3
        iface = iface + 1
        endif

        enddo
        enddo
	enddo
        enddo

!----------------------------------------------------------------------------
! dump counter to scatch file for next process
!----------------------------------------------------------------------------
        open(61,file='fort.61',form='formatted',status='replace')
        write(61,*) iedge,iface,iloop
        close(61)

!----------------------------------------------------------------------------
! close all the files
!----------------------------------------------------------------------------
        close(10)
        close(11)
        close(12)
        close(13)
        close(14)

	endif
	enddo

!----------------------------------------------------------------------------
! everyone wait
!----------------------------------------------------------------------------
#if mpi == 1
        CALL MPI_BARRIER (MPI_COMM_swm,ierr)
#endif

        if(my_task==0) then
          write(6,*) ' finished writing coordinate data describing vertices'
        endif


!----------------------------------------------------------------------------
!----------------------------------------------------------------------------
!
! AND FINALLY, DESCRIPTION OF VECTOR DATA IS WRITTEN OUT
!
!----------------------------------------------------------------------------
!---------------------------------------------------------------------------

!----------------------------------------------------------------------------
! loop over each process. listing of output is process dependent
!    note, running on a different number of processors will give a different
!    ordering of the data. this is not a problem, just something to keep in mind
!----------------------------------------------------------------------------
        do ip = 0,npe-1

!----------------------------------------------------------------------------
! everyone wait
!----------------------------------------------------------------------------
#if mpi == 1
        CALL MPI_BARRIER (MPI_COMM_swm,ierr)
#endif

!----------------------------------------------------------------------------
! pick one process 
!----------------------------------------------------------------------------
        if(my_task.eq.ip) then

!----------------------------------------------------------------------------
! open file
!----------------------------------------------------------------------------
	if(my_task.eq.0) then
          open(10,file='dx/vector.position.data',form='formatted',status='replace')
	else
	  open(10,file='dx/vector.position.data',form='formatted',status='old',position='append')
	endif

!----------------------------------------------------------------------------
! loop over each point in the domain
!----------------------------------------------------------------------------
	do k=1,nsdm
        do j=1,jjm
        do i=1,iim
        do ic=1,ncorners
          if(grid_corner_mask(ic,i,j,k).eq.1.0_dbl_kind) then
          write(10,10) c(1,ic,i,j,k),c(2,ic,i,j,k),c(3,ic,i,j,k)
        endif
        enddo
        enddo
        enddo
	enddo

!----------------------------------------------------------------------------
! close all the file
!----------------------------------------------------------------------------
        close(10)

	endif

	enddo

!----------------------------------------------------------------------------
! everyone wait
!----------------------------------------------------------------------------
#if mpi == 1
        CALL MPI_BARRIER (MPI_COMM_swm,ierr)
#endif

        if(my_task==0) then
          write(6,*) ' finished writing coordinate data describing vector positions'
          write(6,*)
        endif


!-----------------------------------------------------------------------
! text formatting statements
!-----------------------------------------------------------------------
 10     format(3e13.5)
 11     format(6i8)
 12     format(i8)
 14     format(e13.5)
 16     format(3i8)

!----------------------------------------------------------------------------
! keep the user informed
!----------------------------------------------------------------------------
       if(my_task.eq.0) then
          write(6,*) ' writing coordinate data complete'
          write(6,*)
        endif

	end subroutine write_dx_coordinate_data
!======================================================================
! END OF WRITE_DX_COORDINATE_DATA
!======================================================================


!======================================================================
! BEGINNING OF WRITE_DX_DATA
!======================================================================
	subroutine write_dx_data(h,psi,chi,relative,eta,   &
      		div,ke,hf,u,viscous,stress,tracer1,tracer2,tau)

	implicit none

	real (kind=dbl_kind), intent(in), dimension(iim,jjm,nsdm) ::  &
      		h,psi,chi,relative,eta,div,ke,hf,tracer1,tracer2

        real (kind=dbl_kind), intent(in) ::  &
      		u(nspace,ncorners,iim,jjm,nsdm),  &
                viscous(nspace,ncorners,iim,jjm,nsdm), &
                stress(r3,r3,iim,jjm,nsdm)
	real (kind=dbl_kind), intent(in) :: tau
	real (kind=dbl_kind):: hwork(iim,jjm,nsdm)
	integer (kind=int_kind) :: i,j,ksdm
	character (len=80) :: vtag(15)

	integer (kind = int_kind), parameter :: interp_file = 47

        vtag(1) = 'height'
        vtag(2) = 'psi'
        vtag(3) = 'chi'
        vtag(4) = 'relative'
        vtag(5) = 'divergence'
        vtag(6) = 'ke'
	vtag(7) = 'velocity'
        vtag(8) = 'dhdt'
        vtag(9) = 'eta'
	vtag(10) = 'viscous'
        vtag(11) = 'stressx'
        vtag(12) = 'stressy'
        vtag(13) = 'stressz'
	vtag(14) = 'tracer1'
	vtag(15) = 'tracer2'

	hwork = h

#if thin_fluid == 1
	where(hwork.le.1.0e-10) hwork = -1000.0_dbl_kind
#endif

        do i = 1,15
          vtag(i) = trim(vtag(i))
        enddo

	if(my_task==0) then
	  write(6,*)
	  write(6,*) ' WRITING OUTPUT to ./dx/output'
	endif
	do i=0,npe-1
	if(my_task==i) then
	  write(6,*) ' ******** writing data from process ',my_task
          call write_scalar_data(my_task,hwork(:,:,:),tau,vtag(1))
          if(l_full_write) call write_scalar_data(my_task,psi(:,:,:),tau,vtag(2))
          if(l_full_write) call write_scalar_data(my_task,chi(:,:,:),tau,vtag(3))
          call write_scalar_data(my_task,relative(:,:,:),tau,vtag(4))
          call write_scalar_data(my_task,div(:,:,:),tau,vtag(5))
          if(l_full_write) call write_scalar_data(my_task,ke(:,:,:),tau,vtag(6))
	  call write_vector_data(my_task,u(:,:,:,:,:),tau,vtag(7))
	  if(l_full_write) call write_vector_data(my_task,viscous(:,:,:,:,:),tau,vtag(10))
	  if(l_full_write) call write_scalar_data(my_task,hf(:,:,:),tau,vtag(8))
	  if(l_full_write) call write_scalar_data(my_task,eta(:,:,:),tau,vtag(9))
          if(l_full_write) call write_tensor_data(my_task,1,stress(:,:,:,:,:),tau,vtag(11))
          if(l_full_write) call write_tensor_data(my_task,2,stress(:,:,:,:,:),tau,vtag(12))
          if(l_full_write) call write_tensor_data(my_task,3,stress(:,:,:,:,:),tau,vtag(13))
          call write_scalar_data(my_task,tracer1(:,:,:),tau,vtag(14))
          call write_scalar_data(my_task,tracer2(:,:,:),tau,vtag(15))
	endif
#if mpi == 1
	CALL MPI_BARRIER (MPI_COMM_swm,ierr)
#endif
	enddo
	if(my_task==0) write(6,*)

!-- added by mb
	if(l_full_write) call gather(swm_name, im, jm, iim, jjm, 1, nsdm, h, work)
        if(l_full_write) call reduce_to_vector_global(swm_name, im, jm, max_ig, work,igvec)
        if(l_full_write) then
           if (my_task==0) write(h_file,'(5e15.8)') igvec
        endif

	end subroutine write_dx_data

!======================================================================
! BEGINNING OF WRITE_DX_INIT
!======================================================================
	subroutine write_dx_init(hs,lat,lon,tau)

	implicit none

	real (kind=dbl_kind), intent(in), dimension(iim,jjm,nsdm) ::  &
      		hs,lat,lon
        real (kind=dbl_kind) :: tau
	real (kind=dbl_kind), dimension(im,jm) :: work
	integer (kind=int_kind) :: i
	character (len=80) :: vtag(3)

        vtag(1) = 'hs'
	vtag(2) = 'lat'
	vtag(3) = 'lon'

        do i = 1,3
          vtag(i) = trim(vtag(i))
        enddo

	if(my_task==0) then
	  write(6,*)
	  write(6,*) ' WRITING OUTPUT to ./dx/output'
	endif
	do i=0,npe-1
	if(my_task==i) then
	  write(6,*) ' ******** writing data from process ',my_task
          call write_scalar_data(my_task,hs(:,:,:),tau,vtag(1))
	  call write_scalar_data(my_task,grid_center_lat(:,:,:),tau,vtag(2))
	  call write_scalar_data(my_task,grid_center_lon(:,:,:),tau,vtag(3))
	endif
#if mpi == 1
	CALL MPI_BARRIER (MPI_COMM_swm,ierr)
#endif
	enddo
	if(my_task==0) write(6,*)

!-- added by mb
	if(l_full_write) call gather(swm_name, im, jm, iim, jjm, 1, nsdm, grid_center_lat,work)
        if(l_full_write) call reduce_to_vector_global(swm_name, im, jm, max_ig, work,igvec)
        if (l_full_write) then
          if (my_task==0) write(lat_file,'(5e15.8)') igvec
        endif
	if(l_full_write) call gather(swm_name, im, jm, iim, jjm, 1, nsdm, grid_center_lon,work)
        if(l_full_write) call reduce_to_vector_global(swm_name, im, jm, max_ig,work,igvec)
        if (l_full_write) then
          if (my_task==0) write(lon_file,'(5e15.8)') igvec
        endif
	if(l_full_write) call gather(swm_name, im, jm, iim, jjm, 1, nsdm, area,work)
        if(l_full_write) call reduce_to_vector_global(swm_name, im, jm, max_ig,work,igvec)
        if (l_full_write) then
          if (my_task==0) write(area_file,'(5e15.8)') igvec
        endif

	end subroutine write_dx_init


	subroutine write_scalar_data ( my_task, xin, tau, vtag)
	implicit none
	real (kind=dbl_kind), intent(in) :: xin(iim,jjm,nsdm)
	real (kind=dbl_kind), intent(in) :: tau
        real (kind=dbl_kind) :: work_xin(iim,jjm,nsdm)
	integer (kind=int_kind), intent(in) :: my_task
	character (len=80), intent(in) :: vtag
	integer (kind=int_kind) :: itau,i,j,ksdm
	character (len=80) :: ctau, ftag
	itau = nint(tau) + 10000000
	close(99)
	write(99,fmt='(i8)') itau
	close(99)
	read(99,fmt='(a80)') ctau
	ctau(1:1) = '0'
	close(99)
	ftag = 'dx/output/' // trim(vtag) // '.' // trim(ctau)
	if(my_task==0) then
 	open(98,file=ftag,form='formatted',status='replace')
	else
 	open(98,file=ftag,form='formatted',status='old',position='append')
	endif
	work_xin = xin
	where(abs(work_xin).le.1.0e-10) work_xin = 0
        do ksdm=1,nsdm
        do j=1,jjm
        do i=1,iim
	if(grid_center_mask(i,j,ksdm).eq.1.0_dbl_kind) then
 	  write(98,fmt='(e13.5)') work_xin(i,j,ksdm)
	endif
	enddo
	enddo
	enddo
	close(98)
	end subroutine write_scalar_data


        subroutine write_tensor_data ( my_task, idir, xin, tau, vtag)
        implicit none
        real (kind=dbl_kind), intent(in) :: xin(r3,r3,iim,jjm,nsdm)
        real (kind=dbl_kind), intent(in) :: tau
        integer (kind=int_kind), intent(in) :: my_task, idir
        character (len=80), intent(in) :: vtag
        integer (kind=int_kind) :: itau,i,j,ksdm,k
        real (kind=dbl_kind) :: tx1(3), tx2(3), s(3)
        character (len=80) :: ctau, ftag
        tx2(:) = c0
        if(idir==1) tx2(1) = c1
        if(idir==2) tx2(2) = c1
        if(idir==3) tx2(3) = c1
        itau = nint(tau) + 10000000
        close(99)
        write(99,fmt='(i8)') itau
        close(99)
        read(99,fmt='(a80)') ctau
        ctau(1:1) = '0'
        close(99)
        ftag = 'dx/output/' // trim(vtag) // '.' // trim(ctau)
        if(my_task==0) then
        open(98,file=ftag,form='formatted',status='replace')
        else
        open(98,file=ftag,form='formatted',status='old',position='append')
        endif
        do ksdm=1,nsdm
        do j=1,jjm
        do i=1,iim
        tx1(:) = matmul(trans_to_X1(:,:,1,i,j,ksdm),tx2(:))
        s(1) = xin(1,1,i,j,ksdm)*tx1(1) + xin(1,2,i,j,ksdm)*tx1(2) + xin(1,3,i,j,ksdm)*tx1(3)
        s(2) = xin(2,1,i,j,ksdm)*tx1(1) + xin(2,2,i,j,ksdm)*tx1(2) + xin(2,3,i,j,ksdm)*tx1(3)
        s(3) = xin(3,1,i,j,ksdm)*tx1(1) + xin(3,2,i,j,ksdm)*tx1(2) + xin(3,3,i,j,ksdm)*tx1(3)
        if(grid_center_mask(i,j,ksdm).eq.1.0_dbl_kind) then
         write(98,fmt='(3e13.5)') s(1), s(2), s(3)
        endif
        enddo
        enddo
        enddo
        close(98)
        end subroutine write_tensor_data


        subroutine write_vector_data ( my_task,xin, tau, vtag)
	implicit none
        real (kind=dbl_kind), intent(in) ::      &
      		xin(nspace,ncorners,iim,jjm,nsdm)
        real (kind=dbl_kind), intent(in) :: tau
	integer (kind=int_kind), intent(in) :: my_task
        character (len=80), intent(in) :: vtag
        integer (kind=int_kind) :: itau,i,j,ksdm,icorner
        character (len=80) :: ctau, ftag
	real (kind=dbl_kind) :: t(3), s(3)
        itau = nint(tau) + 10000000
        close(99)
        write(99,fmt='(i8)') itau
        close(99)
        read(99,fmt='(a80)') ctau
        ctau(1:1) = '0'
        close(99)
        ftag = 'dx/output/' // trim(vtag) // '.' // trim(ctau)
        if(my_task==0) then
        open(98,file=ftag,form='formatted',status='replace')
        else
        open(98,file=ftag,form='formatted',status='old',position='append')
        endif
        do ksdm=1,nsdm
        do j=1,jjm
        do i=1,iim
	do icorner=1,ncorners
        if(grid_corner_mask(icorner,i,j,ksdm).eq.1.0_dbl_kind) then
	  s(1) = xin(1,icorner,i,j,ksdm)
	  s(2) = xin(2,icorner,i,j,ksdm)
	  s(3) = 0.0_dbl_kind
	  t(:) = matmul(trans_to_X1(:,:,icorner,i,j,ksdm),s(:))
          write(98,fmt='(3e13.5)') t(1), t(2), t(3)
        endif
        enddo
        enddo
        enddo
	enddo
        close(98)
        end subroutine write_vector_data

!===========================================================================
! BEGINNING OF OPEN_FILES
!===========================================================================
        subroutine open_files

        if(my_task.eq.0) then
          OPEN (UNIT= h_file, FILE='h-ez',  &
               FORM='FORMATTED',STATUS='UNKNOWN')
          OPEN (UNIT= lat_file, FILE='lat-ez',  &
               FORM='FORMATTED',STATUS='UNKNOWN')
          OPEN (UNIT= lon_file, FILE='lon-ez',  &
               FORM='FORMATTED',STATUS='UNKNOWN')
          OPEN (UNIT= area_file, FILE='area-ez',  &
               FORM='FORMATTED',STATUS='UNKNOWN')
        endif

        end subroutine open_files
!===========================================================================
! END OF OPEN_FILES
!===========================================================================

	end module dx_module
