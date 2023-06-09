   module params_MPI

   use kinds
   use abort
   implicit none
   private
   save

#if mpi == 1
      	 include 'mpif.h'
#endif

   integer (kind=int_kind), public ::                         &
      mpi_float_type = 0,                                     &
      mpi_int_type = 0,                                       &
      mpi_character_type = 0

      integer (kind=int_kind) :: errorcode=0, ierror=0

! public member functions
   public ::                                                  &
      specify_mpi_precision
   contains

!======================================================================
! BEGINNING OF SPECIFY_MPI_PRECISION
!======================================================================

	subroutine specify_mpi_precision

!-------------------------------------------------------------------------
!     
!     Purpose:
!     Specify the type of messages. single precision
!     or double precision for floating. also type of integer
!
!     Author: Atul Nulkar
!     Modified original code on 03/25/2002 to conform to CCM4 standard
!     
!-------------------------------------------------------------------------
      
        implicit none

        integer (kind=int_kind) :: errorcode=0

#if mpi == 1
        
	    if(dbl_kind == selected_real_kind(6)) then
           mpi_float_type = MPI_REAL
        else
	       if(dbl_kind == selected_real_kind(13)) then
           	  mpi_float_type = MPI_DOUBLE_PRECISiON
       	   else
              call abort_code('stop in specify_mpi_precision: no mpi_float_type')
	       endif
        endif

 	    if(int_kind == kind(1)) then
 	       mpi_int_type = MPI_INTEGER
 	    else
               call abort_code('stop in specify_mpi_precision: no mpi_int_type')
 	    endif

            mpi_character_type = MPI_CHARACTER

#endif  ! end of #if mpi == 1
	
	end subroutine specify_mpi_precision

!======================================================================
! END OF SPECIFY_MPI_PRECISION
!======================================================================


   end module params_MPI
