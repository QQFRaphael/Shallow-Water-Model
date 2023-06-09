
! A driver ice+land code for MPH version 2
! Written by Yun (Helen) He and Chris Ding, NERSC/LBNL.

      program main
      use MPH_module
      implicit none
      include 'mpif.h'

      integer ICE_LAND_World, comm
      integer myProc, myproc_exe, myProc_global

      call MPH_debug (1)
      ICE_LAND_World = MPH_components (name1="ice", name2="land")
      if (MPH_global_proc_id() == 0) call MPH_help ('on')

      call MPI_COMM_RANK (ICE_LAND_World, myProc_exe, ierr)
      call MPI_COMM_RANK (MPH_Global_World, myProc_global, ierr)
      if (PE_in_component("ice", comm)) then
         call MPI_COMM_RANK (comm, myProc, ierr)
         write(*,*)'component=ice, local_id=', myProc, ', exe_pid=',
     & myProc_exe, ', global_id=', myProc_global
      endif

      if (PE_in_component("land", comm)) then
         call MPI_COMM_RANK (comm, myProc, ierr)
         write(*,*)'component=land, local_id=', myProc, ', exe_pid=',
     & myProc_exe, ', global_id=', myProc_global
      endif

      write(*,*)
      call MPI_FINALIZE (ierr)
      end program
