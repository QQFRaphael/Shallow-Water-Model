

        module dx_grid_utility

        use kinds
        use component_intra
        use geodesic_grid_utilities

        implicit none
        private

        public :: write_dx_coordinate_data

        contains

!======================================================================
! BEGINNING OF WRITE_DX_COORDINATE_DATA
!======================================================================
        subroutine write_dx_coordinate_data(           &
                      my_communicator,                 &
                      comp_name,                       &
                      r3,ndata,ncorners,iim,jjm,nsdm,  &
                      polygon_type,                    &
                      grid_center_mask,                &
                      grid_corner_mask,                &
                      corner_area,area,                &
                      p,c,w,                           &
                      ztopo,                           &
                      ztopo_c)

        implicit none

        integer (kind=int_kind), intent(in) :: my_communicator
        character(len=*), intent(in) :: comp_name
        integer (kind=int_kind), intent(in) :: r3,ndata,ncorners,iim,jjm,nsdm

        real (kind=dbl_kind), intent(in) ::  &
                polygon_type(iim,jjm,nsdm),  &
                grid_center_mask(iim,jjm,nsdm), &
                grid_corner_mask(ncorners,iim,jjm,nsdm)

        real (kind=dbl_kind), intent(in) ::  &
                corner_area(ncorners,iim,jjm,nsdm),   &
                area(iim,jjm,nsdm),          &
                p(r3,iim,jjm,nsdm),          &
                c(r3,ncorners,iim,jjm,nsdm), &
                w(ndata,r3,ncorners,iim,jjm,nsdm)

        real (kind=dbl_kind), intent(in), optional :: &
                ztopo(iim,jjm,nsdm),&
                ztopo_c(ncorners,iim,jjm,nsdm)

        integer (kind=int_kind) ::                                   &
                i,j,k,l,ic,iface,iloop,iedge,ksdm,ip,my_task,npe_comp,ierr

        real (kind = dbl_kind) ::                                    &
                t           (ndata, r3),                             &
                nl          (r3),                                    &
                tg          (r3),                                    &
                vw          (r3),                                    &
                g           (r3)

        character (len=80) :: ctask, cfilename(10)

!----------------------------------------------------------------------------
! keep the user informed
!----------------------------------------------------------------------------
       my_task = get_my_task(comp_name)
       npe_comp = get_my_npe(comp_name)
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
        do ip = 0,npe_comp-1

!----------------------------------------------------------------------------
! everyone wait
!----------------------------------------------------------------------------
#if mpi == 1
        CALL MPI_BARRIER (my_communicator,ierr)
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
! get task as a character string
!----------------------------------------------------------------------------
        open(61,file='fort.61',form='formatted',status='replace')
        write(61,*) my_task + 100000
        close(61)
        open(61,file='fort.61',form='formatted',status='old')
        read(61,*) ctask
        close(61)
        ctask = ctask(2:80)
        ctask = trim(ctask)

!----------------------------------------------------------------------------
! open files, every process writes to a seperate file
!----------------------------------------------------------------------------
        cfilename(1) = 'dx/data/cellcenters.data.'//ctask
        cfilename(2) = 'dx/data/position.data.'//ctask
        cfilename(3) = 'dx/data/edge.data.'//ctask
        cfilename(4) = 'dx/data/loop.data.'//ctask
        cfilename(5) = 'dx/data/face.data.'//ctask
        cfilename(6) = 'dx/output/area.data.'//ctask
        cfilename(7) = 'dx/output/ztopo.data.'//ctask

        open( 9,file=cfilename(1),form='formatted',status='replace')
        open(10,file=cfilename(2),form='formatted',status='replace')
        open(11,file=cfilename(3),form='formatted',status='replace')
        open(12,file=cfilename(4),form='formatted',status='replace')
        open(13,file=cfilename(5),form='formatted',status='replace')
        open(14,file=cfilename(6),form='formatted',status='replace')
        open(15,file=cfilename(7),form='formatted',status='replace')

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
          if(present(ztopo)) write(15,14) ztopo(i,j,k)
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
        close(15)

        endif

        enddo

!----------------------------------------------------------------------------
! everyone wait
!----------------------------------------------------------------------------
#if mpi == 1
        CALL MPI_BARRIER (my_communicator,ierr)
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
        do ip = 0,npe_comp-1

!----------------------------------------------------------------------------
! everyone wait
!----------------------------------------------------------------------------
#if mpi == 1
        CALL MPI_BARRIER (my_communicator,ierr)
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
! get task as a character string
!----------------------------------------------------------------------------
        open(61,file='fort.61',form='formatted',status='replace')
        write(61,*) my_task + 100000
        close(61)
        open(61,file='fort.61',form='formatted',status='old')
        read(61,*) ctask
        close(61)
        ctask = ctask(2:80)
        ctask = trim(ctask)

!----------------------------------------------------------------------------
! open files, every process writes to a seperate file
!----------------------------------------------------------------------------
        cfilename(1) = 'dx/data/tri.position.data.'//ctask
        cfilename(2) = 'dx/data/tri.edge.data.'//ctask
        cfilename(3) = 'dx/data/tri.loop.data.'//ctask
        cfilename(4) = 'dx/data/tri.face.data.'//ctask
        cfilename(5) = 'dx/output/tri.area.data.'//ctask
        cfilename(6) = 'dx/output/tri.ztopou.data.'//ctask

        open(10,file=cfilename(1),form='formatted',status='replace')
        open(11,file=cfilename(2),form='formatted',status='replace')
        open(12,file=cfilename(3),form='formatted',status='replace')
        open(13,file=cfilename(4),form='formatted',status='replace')
        open(14,file=cfilename(5),form='formatted',status='replace')
        open(15,file=cfilename(6),form='formatted',status='replace')


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
        if(present(ztopo_c)) write(15,14) ztopo_c(ic,i,j,ksdm)
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
        close(15)

        endif
        enddo

!----------------------------------------------------------------------------
! everyone wait
!----------------------------------------------------------------------------
#if mpi == 1
        CALL MPI_BARRIER (my_communicator,ierr)
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
        do ip = 0,npe_comp-1

!----------------------------------------------------------------------------
! everyone wait
!----------------------------------------------------------------------------
#if mpi == 1
        CALL MPI_BARRIER (my_communicator,ierr)
#endif

!----------------------------------------------------------------------------
! pick one process 
!----------------------------------------------------------------------------
        if(my_task.eq.ip) then


!----------------------------------------------------------------------------
! get task as a character string
!----------------------------------------------------------------------------
        open(61,file='fort.61',form='formatted',status='replace')
        write(61,*) my_task + 100000
        close(61)
        open(61,file='fort.61',form='formatted',status='old')
        read(61,*) ctask
        close(61)
        ctask = ctask(2:80)
        ctask = trim(ctask)

!----------------------------------------------------------------------------
! open files, every process writes to a seperate file
!----------------------------------------------------------------------------
        cfilename(1) = 'dx/data/vector.position.data.'//trim(ctask)
        write(6,*) cfilename(1)
        open(10,file=cfilename(1),form='formatted',status='replace')

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
        CALL MPI_BARRIER (my_communicator,ierr)
#endif

!----------------------------------------------------------------------------
!----------------------------------------------------------------------------
!
! AND FINALLY (well, almost), DESCRIPTION OF VECTOR DATA IS WRITTEN OUT
!
!----------------------------------------------------------------------------
!---------------------------------------------------------------------------

!----------------------------------------------------------------------------
! loop over each process. listing of output is process dependent
!    note, running on a different number of processors will give a different
!    ordering of the data. this is not a problem, just something to keep in mind
!----------------------------------------------------------------------------
        do ip = 0,npe_comp-1

!----------------------------------------------------------------------------
! everyone wait
!----------------------------------------------------------------------------
#if mpi == 1
        CALL MPI_BARRIER (my_communicator,ierr)
#endif

!----------------------------------------------------------------------------
! pick one process
!----------------------------------------------------------------------------
        if(my_task.eq.ip) then

!----------------------------------------------------------------------------
! get task as a character string
!----------------------------------------------------------------------------
        open(61,file='fort.61',form='formatted',status='replace')
        write(61,*) my_task + 100000
        close(61)
        open(61,file='fort.61',form='formatted',status='old')
        read(61,*) ctask
        close(61)
        ctask = ctask(2:80)
        ctask = trim(ctask)

!----------------------------------------------------------------------------
! open files, every process writes to a seperate file
!----------------------------------------------------------------------------
        cfilename(1) = 'dx/data/vector_center.position.data.'//ctask
        open(10,file=cfilename(1),form='formatted',status='replace')

!----------------------------------------------------------------------------
! loop over each point in the domain
!----------------------------------------------------------------------------
        do k=1,nsdm
        do j=1,jjm
        do i=1,iim
          if(grid_center_mask(i,j,k).eq.1.0_dbl_kind) then
          write(10,10) p(1,i,j,k),p(2,i,j,k),p(3,i,j,k)
        endif
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
        CALL MPI_BARRIER (my_communicator,ierr)
#endif


!----------------------------------------------------------------------------
!----------------------------------------------------------------------------
!
! AND REALLY FINALLY, DESCRIPTION OF SUB AREAS
!
!----------------------------------------------------------------------------
!---------------------------------------------------------------------------

!----------------------------------------------------------------------------
! initialize the edge, face, and loop counter
!----------------------------------------------------------------------------
        iedge = 0
        iface = 0
        iloop = 0
        if(my_task.eq.0) then
          write(6,*) my_task
          open(61,file='fort.61',form='formatted',status='replace')
          write(61,*) iedge,iface,iloop
          close(61)
        endif

!----------------------------------------------------------------------------
! loop over each process. listing of output is process dependent
!    note, running on a different number of processors will give a different
!    ordering of the data. this is not a problem, just something to keep in mind
!----------------------------------------------------------------------------
        do ip = 0,npe_comp-1

!----------------------------------------------------------------------------
! everyone wait
!----------------------------------------------------------------------------
#if mpi == 1
        CALL MPI_BARRIER (my_communicator,ierr)
#endif

!----------------------------------------------------------------------------
! pick one process
!----------------------------------------------------------------------------
        if(my_task.eq.ip) then

!----------------------------------------------------------------------------
! get counter from scratch file
!----------------------------------------------------------------------------
        write(6,*) my_task
        open(61,file='fort.61',form='formatted',status='old')
        read(61,*) iedge,iface,iloop
        close(61)

!----------------------------------------------------------------------------
! get task as a character string
!----------------------------------------------------------------------------
        open(61,file='fort.61',form='formatted',status='replace')
        write(61,*) my_task + 100000
        close(61)
        open(61,file='fort.61',form='formatted',status='old')
        read(61,*) ctask
        close(61)
        ctask = ctask(2:80)
        ctask = trim(ctask)

!----------------------------------------------------------------------------
! open files, every process writes to a seperate file
!----------------------------------------------------------------------------
        cfilename(1) = 'dx/data/wall.position.data.'//ctask
        cfilename(2) = 'dx/data/wall.edge.data.'//ctask
        cfilename(3) = 'dx/data/wall.loop.data.'//ctask
        cfilename(4) = 'dx/data/wall.face.data.'//ctask
        cfilename(5) = 'dx/output/wall.area.data.'//ctask

        open(10,file=cfilename(1),form='formatted',status='replace')
        open(11,file=cfilename(2),form='formatted',status='replace')
        open(12,file=cfilename(3),form='formatted',status='replace')
        open(13,file=cfilename(4),form='formatted',status='replace')
        open(14,file=cfilename(5),form='formatted',status='replace')

        do ksdm=1,nsdm
        do j=1,jjm
        do i=1,iim
        do ic=1,ncorners
        if(grid_corner_mask(ic,i,j,ksdm).eq.1.0_dbl_kind) then
        do k=1,3
          call get_surrounding_centers(i,j,ic,ndata,iim,jjm,polygon_type(i,j,ksdm),p(k,:,:,ksdm),t(:,k))
        enddo
        do k=1,ndata
        l = k-1
        if(l.eq.0) l=ndata
        write(10,10) t(k,1            ), t(k,2            ), t(k,3            )
        write(10,10) w(k,1,ic,i,j,ksdm), w(k,2,ic,i,j,ksdm), w(k,3,ic,i,j,ksdm)
        write(10,10) c(  1,ic,i,j,ksdm), c(  2,ic,i,j,ksdm), c(  3,ic,i,j,ksdm)
        write(10,10) w(l,1,ic,i,j,ksdm), w(l,2,ic,i,j,ksdm), w(l,3,ic,i,j,ksdm)
        write(11,17) iedge, iedge+1,iedge+2, iedge+3
        write(12,12) iloop
        write(13,12) iface
        iedge = iedge + 4
        iloop = iloop + 4
        iface = iface + 1
        enddo
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
! close all the file
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
        CALL MPI_BARRIER (my_communicator,ierr)
#endif

        if(my_task==0) then
          write(6,*) ' finished writing coordinate data describing vector positions'
          write(6,*)
        endif


!-----------------------------------------------------------------------
! text formatting statements
!-----------------------------------------------------------------------
 10     format(3e20.10)
 11     format(6i8)
 12     format(i8)
 14     format(e20.10)
 16     format(3i8)
 17     format(4i8)

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

        end module dx_grid_utility
