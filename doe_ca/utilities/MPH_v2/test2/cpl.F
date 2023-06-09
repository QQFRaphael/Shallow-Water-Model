
! A driver coupler code for MPH version 2
! Written by Yun (Helen) He and Chris Ding, NERSC/LBNL.

      program main
      use MPH_module
      implicit none
!      include 'mpif.h'

      integer istep, nstep
      parameter (nstep=2)

      integer CPL_World, local_sum
      integer myProc, myProc_global
      integer comm, COMM_cpl_ice
      integer myProc_joined, join_sum
      integer l2c(100)
      character*10 c2i(30)

      call MPH_debug (2)
      CPL_World = MPH_components (name1="coupler")
      call MPI_COMM_RANK (MPH_Global_World, myProc_global, ierr)
      if (MPH_global_proc_id() == 0) call MPH_help ('on')

!---- to create a joined communicator for "coupler" and "ice".

      call MPH_comm_join ("coupler", "ice", COMM_cpl_ice)
      write(*,*)'I am in cpl, I joined the COMM_cpl_ice'
      call MPI_COMM_RANK (COMM_cpl_ice, myProc_joined, ierr)
      write(*,*)'myProc_joined=', myProc_joined
      call MPI_ALLREDUCE (myProc_joined, join_sum, 1, MPI_INTEGER,
     &                       MPI_SUM, COMM_cpl_ice, ierr)
      write(*,*)' sum of joined ranks in cpl_ice is ', join_sum

      call MPI_COMM_RANK (CPL_World, myProc, ierr)
      if (myProc==0) call MPH_redirect_output ('cpl')

      write(*,*) myProc, ' in sub cpl=== ', myProc_global,' in global'
      write(*,*)'my comp_id in sub cpl=', MPH_comp_id("coupler")

!---- do MPI operations as if no other components are involved -------

      call MPI_REDUCE (myProc, local_sum, 1, MPI_INTEGER, MPI_SUM,
     &                 0, CPL_World, ierr)

      if (myProc == 0) then
         write(*,*)' sum of local ranks in cpl is ', local_sum
      endif

      do istep = 1, nstep

!---- cpl 0 recv a message from land 2,
!---- cpl 1 send a message to ice 2
!---- as sepecified in components.in 
!---- Note the use of MPH_global_id() function.

      c2i = 'abcdefg'
      if (mod(istep,2)==1) then
         if (myProc == 1) then
            write(*,*)'I am cpl 1 (g=5), send to ice 2 (g=2)'
            call MPI_SEND (c2i, 300, MPI_CHARACTER,
     &                     MPH_global_id ("ice", 2), 3000,
     &                     MPH_Global_World,ierr)
            write(*,*)'cpl 0 sent to ice 2 successfully'
         endif
      else
         if (myProc == 0) then
            write(*,*)'I am cpl 0 (g=4), recv from land 2 (g=3)'
            call MPI_RECV (l2c, 100, MPI_INTEGER,
     &                     MPH_global_id ("land", 2), 1000,
     &                     MPH_Global_World, istatus, ierr)
            write(*,*)'I am cpl 0, expect l2c(1)=100'
            write(*,*)'cpl 0 gets l2c(1)=', l2c(1)
         endif
      endif

      enddo

      write(*,*)
      call MPI_FINALIZE (ierr)
      end program
