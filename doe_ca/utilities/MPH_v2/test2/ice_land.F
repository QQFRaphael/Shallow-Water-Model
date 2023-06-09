
! A driver ice+land code for MPH version 2
! Written by Yun (Helen) He and Chris Ding, NERSC/LBNL.

      program main
      use MPH_module
      implicit none
      include 'mpif.h'

      integer istep, nstep
      parameter (nstep=2)

      integer ICE_LAND_World, comm
      integer COMM_cpl_ice, myProc_joined, join_sum

      call MPH_debug (2)
      ICE_LAND_World = MPH_components (name1="ice", name2="land")
      if (MPH_global_proc_id() == 0) call MPH_help ('on')

!---- to create a joined communicator for "coupler" and "ice"

      call MPH_comm_join ("coupler", "ice", COMM_cpl_ice)
      if (PE_in_component("ice", comm)) then
         write(*,*)'I am in ice, I joined COMM_cpl_ice'
         call MPI_COMM_RANK (COMM_cpl_ice, myProc_joined, ierr)
         write(*,*)'myProc_joined=', myProc_joined
         call MPI_ALLREDUCE (myProc_joined, join_sum, 1, MPI_INTEGER,
     &                       MPI_SUM, COMM_cpl_ice, ierr)
         write(*,*)' sum of joined ranks in cpl_ice is ', join_sum
      endif

      do istep = 1, nstep
         if (mod(istep,2)==1) then
            if(PE_in_component("ice", comm))call ice(comm)
         else
            if(PE_in_component("land", comm))call land(comm)
         endif
      enddo

      write(*,*)
      call MPI_FINALIZE (ierr)

      end program

C-----------------------------------------------------------
C-----------------------------------------------------------

      subroutine ice (ICE_World)
      use MPH_module
      implicit none
      include 'mpif.h'

      integer myProc, myProc_global
      character*10 c2i(30)

      integer ICE_World
      integer local_sum

      call MPI_COMM_RANK (MPH_Global_World, myProc_global, ierr)
      call MPI_COMM_RANK (ICE_World, myProc, ierr)
      if (myProc==0) call MPH_redirect_output ('ice')

      write(*,*) myProc, ' in sub ice === ', myProc_global, ' in global'
      write(*,*)'my comp_id in sub ice=', MPH_comp_id("ice")

!---- do MPI operations as if no other components are involved -------

      call MPI_REDUCE (myProc, local_sum, 1, MPI_INTEGER, MPI_SUM,
     &                 0, ICE_World, ierr)
      if (myProc == 0) then
         write(*,*)' sum of local ranks in ice is ', local_sum
      endif

!---- ice 2 recv a message from cpl 1 as specified in components.in 
!--- Note the use of MPH_global_id() function.

      if (myProc == 2) then
         write(*,*) 'I am ice 2 (g=2), recv from cpl 1 (g=5)'
         call MPI_RECV (c2i, 300, MPI_CHARACTER,
     &                  MPH_global_id("coupler", 1), 3000,
     &                  MPH_Global_World, istatus, ierr)
         write(*,*)'I am ice 2, expect c2i=abcdefg'
         write(*,*)'ice 2 gets c2i(1)=', c2i(1)
      endif

      end subroutine


C-----------------------------------------------------------
C-----------------------------------------------------------

      subroutine land (LAND_World)
      use MPH_module
      implicit none
      include 'mpif.h'

      integer myProc, myProc_global
      integer l2c(100)

      integer LAND_World
      integer local_sum

      call MPI_COMM_RANK (MPH_Global_World, myProc_global, ierr)
      call MPI_COMM_RANK (LAND_World, myProc, ierr)
      if (myProc==0) call MPH_redirect_output ('land')

      write(*,*) myProc, ' in sub land=== ', myProc_global,' in global'
      write(*,*)'my comp_id in sub land=', MPH_comp_id("land")

!---- do MPI operations as if no other components are involved -------

      call MPI_REDUCE (myProc, local_sum, 1, MPI_INTEGER, MPI_SUM,
     &                 0, LAND_World, ierr)
      if (myProc == 0) then
         write(*,*)' sum of local ranks in land is ', local_sum
      endif

!---- land 2 send a message to cpl 0 as sepecified in components.in 
!---- Note the use of MPH_global_id() function.

      l2c= 100
      if (myProc == 2) then
         write(*,*)'I am land 2 (g=3), send to cpl 0 (g=4)'
         call MPI_SEND (l2c, 100, MPI_INTEGER,
     &                  MPH_global_id("coupler", 0), 
     &                  1000, MPH_Global_World, ierr)
      endif

      end subroutine
