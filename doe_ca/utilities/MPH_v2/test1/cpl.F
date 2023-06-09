
! A driver coupler code for MPH version 2
! Written by Yun (Helen) He and Chris Ding, NERSC/LBNL.

      program main
      use MPH_module
      implicit none
      include 'mpif.h'

      integer CPL_World
      integer myProc, myProc_global

      call MPH_debug (1)
      CPL_World = MPH_components (name1="coupler")
      if (MPH_global_proc_id() == 0) call MPH_help ('on')

      call MPI_COMM_RANK (CPL_World, myProc, ierr)
      call MPI_COMM_RANK (MPH_Global_World, myProc_global, ierr)
      write(*,*)'component=coupler, local_id=', myProc, 
     & ', global_id=', myProc_global

      write(*,*)
      call MPI_FINALIZE (ierr)
      end program
