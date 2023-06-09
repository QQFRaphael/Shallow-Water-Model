	module abort
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  Purpose:
!
!     This module provides a graceful way for the model to exit when
!       it crashes.
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	use kinds
        implicit none
        private

! public member functions
        public ::             &
           abort_code

!*************************************************************************

        contains

!*************************************************************************

!======================================================================
! BEGINNING OF ABORT_CODE
!======================================================================
        subroutine abort_code(exit_message)

        character (*), intent(in), optional :: &
              exit_message ! message to print before stopping

#if mpi == 1
        include 'mpif.h'
        integer (kind=int_kind) :: ierrorcode=0, ierror=0

        write (6,'(a14)') '!!!!exiting...'
        if(present(exit_message)) then
           write (6,*) exit_message
        endif
        call MPI_ABORT(MPI_COMM_world, ierrorcode, ierror)

#else
        write (6,'(a14)') '!!!!exiting...'
        if(present(exit_message)) then
           write (6,*) exit_message
        endif
        stop
#endif

        end subroutine abort_code
!======================================================================
! END OF ABORT_CODE
!======================================================================

	end module abort
