
! A driver coupler code for MPH version 2
! Written by Yun (Helen) He and Chris Ding, NERSC/LBNL.

      program main
      use MPH_module
      implicit none
      include 'mpif.h'

      integer main_world, comm
      integer myProc, myproc_exe, myProc_global

      call MPH_debug (1)
      main_World = MPH_components (name1="ocean", name2="atmosphere",
     &                             name3="coupler")
      if (MPH_global_proc_id() == 0) call MPH_help ('on')

      call MPI_COMM_RANK (main_World, myProc_exe, ierr)
      call MPI_COMM_RANK (MPH_Global_World, myProc_global, ierr)
      write(*,*)'local_id=', myProc, ', global_id=', myProc_global

      if (PE_in_component("ocean", comm)) then
         call MPI_COMM_RANK (comm, myProc, ierr)
         write(*,*)'component=ocean, local_id=', myProc, ', exe_pid=',
     & myProc_exe, ', global_id=', myProc_global
      endif

      if (PE_in_component("atmosphere", comm)) then
         call MPI_COMM_RANK (comm, myProc, ierr)
         write(*,*)'component=atmosphere, local_id=', myProc,
     & ', exe_pid=', myProc_exe, ', global_id=', myProc_global
      endif

      if (PE_in_component("coupler", comm)) then
         call MPI_COMM_RANK (comm, myProc, ierr)
         write(*,*)'component=coupler, local_id=', myProc,
     & ', exe_pid=', myProc_exe, ', global_id=', myProc_global
      endif

      write(*,*)
      call MPI_FINALIZE (ierr)
      end program
