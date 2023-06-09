Module params_global_MPH

!***********************************************************************
!
!     Purpose:
!     This module contains parameters describing the global coupled environment
!       that will be used throughout the entire coupler model
!     These variables are extracted from local variables common to all
!       components.
!
!     History:
!       2003 Jun 04 - Created by Don Dazlich (dazlich@atmos.colostate.edu)
!
!***********************************************************************

   use kinds
   use params_MPI
   use MPH_module

   implicit none
   private

   integer, public ::                                                  &
      num_comp,       & ! number of components in the coupled system
      ntotprocs,      & ! total number of processes used by the coupled system
      cpl_comp_id,    & ! total number of processes used by the coupled system
      my_proc_global    ! process id in the global (coupled) world
      
   logical (kind=log_kind), public, allocatable, dimension(:) ::       &
      do_component            ! if true, do this component on this process
   integer (kind=int_kind), public, allocatable, dimension(:) ::       &
      comp_communicator       ! array of component communicators
   character (len=32), public, allocatable, dimension(:) ::            &
      component_name          ! array of component names

   public :: init_params_global_MPH

   contains

   subroutine init_params_global_MPH
   
      integer (kind=int_kind) :: nc     ! loop index

#if mpi == 1
      num_comp = MPH_total_components ()
      ntotprocs = MPH_global_totProcs()

      call MPI_COMM_RANK (MPH_Global_World, my_proc_global, ierr)

! Find the coupler component id
      cpl_comp_id = MPH_comp_id('coupler')  
      
! what components do we do on this process? What communicators is it
!   part of? What are the component names
! Allocate and store these variables so we don't call mph all over the place
      allocate(do_component(num_comp))
      allocate(comp_communicator(num_comp))
      allocate(component_name(num_comp))
      do  nc = 1,num_comp
         component_name(nc) = MPH_comp_name(nc)
         do_component(nc) = pe_in_component(trim(component_name(nc)),comp_communicator(nc))
      enddo
#else
      num_comp = 4
      ntotprocs = 1

      my_proc_global = 0

! Find the coupler component id
      cpl_comp_id = 1 
      
! what components do we do on this process? What communicators is it
!   part of? What are the component names
! Allocate and store these variables so we don't call mph all over the place
      allocate(do_component(num_comp))
      allocate(comp_communicator(num_comp))
      allocate(component_name(num_comp))
      component_name(1) = 'coupler'
      component_name(2) = 'atmosphere'
      component_name(3) = 'ocean'
      component_name(4) = 'ice'
      do  nc = 1,num_comp
         comp_communicator(nc) = 1
         do_component(nc) = .true.
      enddo
#endif
 
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
!
! Specifies MPI Precision
!
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

      call specify_mpi_precision

   end subroutine init_params_global_MPH

End Module params_global_MPH
