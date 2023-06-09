!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

      module comm_setup   

!***********************************************************************
!
!     Purpose: 
!     This module sets up the MPI/MPH related communication. It 
!     initializes the local and global process numbers for communication 
!     setup, for each component. Also finds the component ids for each 
!     component and the total number of components.         
!  
!     Author: Atul Nulkar
!
!     Updated: March 25, 2002
!
!***********************************************************************

#if mpi == 1
      use MPH_module
#endif
      use kinds   
      use abort   
      use component_intra   
      use params_global_MPH   
	 
      implicit none

      private

! public member routines
      public:: comm_init,                                           &
               comm_test

!***********************************************************************

      contains

!***********************************************************************
 
!======================================================================
! BEGINNING OF COMM_INIT
!======================================================================

!-------------------------------------------------------------------------
!     
!     Purpose:
!     Given the component name, finds the local and global process numbers
!     using MPI, and the component ids using MPH calls.
!
!     Author: Atul Nulkar
!     
!-------------------------------------------------------------------------

      subroutine comm_init(comp_name, MPI_COMM_comp, myProc, my_comp_id)

      character (len=*), intent(in)  :: comp_name
      
      integer (kind=int_kind), intent(out)  :: MPI_COMM_comp
      integer (kind=int_kind), intent(out)  :: myProc
      integer (kind=int_kind), intent(out)  :: my_comp_id
      
      integer (kind=int_kind) :: nc

#if mpi == 1      
! Find the component ids
      my_comp_id = MPH_comp_id(trim(comp_name))   

! Find local  process numbers
      myProc = MPH_local_proc_id(my_comp_id)
      MPI_COMM_comp = comp_communicator(my_comp_id)
#else
      my_comp_id = 0
      do nc = 1,num_comp
         if(trim(component_name(nc)) == trim(comp_name)) my_comp_id = nc
      enddo
      if(my_comp_id == 0) call abort_code('comm_init: improper comp id')
      myProc = 0
#endif

      end subroutine comm_init

!======================================================================
! END OF COMM_INIT
!======================================================================

!======================================================================
! BEGINNING OF COMM_TEST
!======================================================================

!-------------------------------------------------------------------------
!     
!     Purpose:
!     Given the component name, error tests the number of processes
!
!     Author: Don Dazlich
!     
!-------------------------------------------------------------------------

      subroutine comm_test(comp_name, MPI_COMM_comp, myProc, my_comp_id)

      character (len=*), intent(in)  :: comp_name
      
      integer (kind=int_kind), intent(out)  :: MPI_COMM_comp
      integer (kind=int_kind), intent(in)  :: myProc
      integer (kind=int_kind), intent(in)  :: my_comp_id
      
      integer (kind=int_kind) :: ierr, npe, nprocs

!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
!
! Check is number of processes in the component (npe) and the value
! specfied in the processors_map input file is the same
!
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

      MPI_COMM_comp = comp_communicator(my_comp_id)
      npe = get_my_npe(comp_name)
#if mpi == 1
      nprocs = MPH_local_totProcs(MPH_comp_id(comp_name))
      if (nprocs /= npe) then
          print *, 'ERROR for component', comp_name
	  print *, 'Number of processes in the component(npe) and the value ', &
		   'specfied in the input file  should be the same'
          print *,' npe = ',npe,';   file has ',nprocs
          call abort_code('comm_setup failure for component '//comp_name)	
      endif
#else
      if(npe /= 1) then
         print *,'npe /= 1 in serial case'
         call abort_code('comm_setup failure for component '//comp_name)
      endif
#endif

      end subroutine comm_test

!======================================================================
! END OF COMM_TEST
!======================================================================

      end module comm_setup

!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
