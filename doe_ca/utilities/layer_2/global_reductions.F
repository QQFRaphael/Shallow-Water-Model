
!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

	module global_reductions

!---------------------------------------------------------------------
! PURPOSE: a set of function calls to compute global means, etc
!       adopted from the LANL POP model, tdr 2-2-98
!---------------------------------------------------------------------

	use kinds
	use params_MPI
	use component_intra
	use abort
	
	implicit none
	private

# if mpi == 1
      INCLUDE 'mpif.h'
# endif

        integer (kind=int_kind) :: ierr

! PUBLIC MEMBER FUNCTIONS
        public ::                     &
           global_int_sum,            &
           global_real_sum,           &
           global_count,              &
           global_int_maxval,         &
           global_real_maxval,        &
           global_real_maxval_mask,   &
           global_int_minval,         &
           global_real_minval,        &
           global_real_minval_mask,   &
           global_real_maxloc
          

!---------------------------------------------------------------------
! VARIABLES
!	X	intent(in) array
!	MASK	real (kind=dbl_kind), elements with 0 are masked out
!	size	length of array
!       communicator	an mpi communicator 
!---------------------------------------------------------------------

!*********************************************************************

      contains

!*********************************************************************

      integer function global_int_sum (X, MASK, size, component_name)

      implicit none
      integer (kind=int_kind), intent(in) :: size
      integer (kind=int_kind), intent(in) :: X(size)
      real (kind=dbl_kind), intent(in) :: MASK(size)
      character (len=*), intent(in) :: component_name

      integer (kind=int_kind) :: local_sum, communicator

      local_sum = sum(X*MASK)

#if mpi == 1
      communicator = get_my_communicator(component_name)
      call MPI_ALLREDUCE(local_sum, global_int_sum, 1,               &
                        mpi_int_type, MPI_SUM, communicator, ierr)
#else
      global_int_sum = local_sum
#endif

      end function global_int_sum

!---------------------------------------------------------------------
 
      real (kind=dbl_kind) function global_real_sum (     &
                    X, MASK, size, component_name)

      implicit none
      integer (kind=int_kind), intent(in) :: size
      character (len=*), intent(in) :: component_name
      real (kind=dbl_kind), intent(in) :: X(size), MASK(size)

      real (kind=dbl_kind) :: local_sum
      integer (kind=int_kind) ::  communicator

      local_sum = sum(X*MASK)

#if mpi == 1
      communicator = get_my_communicator(component_name)
      call MPI_ALLREDUCE(local_sum, global_real_sum, 1,      &
                         mpi_float_type, MPI_SUM, communicator, ierr)
#else
      global_real_sum = local_sum
#endif

      end function global_real_sum

!---------------------------------------------------------------------

      integer function global_count (MASK, size, component_name )

      implicit none
      integer (kind=int_kind), intent(in) :: size
      character (len=*), intent(in) :: component_name
      real (kind=dbl_kind), intent(in) :: MASK(size)

      integer (kind=int_kind) :: local_count
      integer (kind=int_kind) ::  communicator

      local_count = sum(MASK)

#if mpi == 1
      communicator = get_my_communicator(component_name)
      call MPI_ALLREDUCE(local_count, global_count, 1,      &
                         mpi_int_type, MPI_SUM, communicator, ierr)
#else
      global_count = local_count
#endif

      end function global_count

!---------------------------------------------------------------------
 
      integer function global_int_maxval(X, size, component_name)

      implicit none
      integer (kind=int_kind), intent(in) :: size
      character (len=*), intent(in) :: component_name
      integer (kind=int_kind), intent(in) :: X(size)

      integer (kind=int_kind) :: local_int_maxval
      integer (kind=int_kind) ::  communicator

      local_int_maxval = maxval(X)

#if mpi == 1
      communicator = get_my_communicator(component_name)
      call MPI_ALLREDUCE(local_int_maxval, global_int_maxval, 1,      &
                         mpi_int_type, MPI_MAX, communicator, ierr)
#else
      global_int_maxval = local_int_maxval
#endif

      end function global_int_maxval


!---------------------------------------------------------------------
 
      real (kind=dbl_kind) function global_real_maxval(X, size, component_name)

      implicit none
      integer (kind=int_kind), intent(in) :: size
      character (len=*), intent(in) :: component_name
      real (kind=dbl_kind), intent(in) :: X(size)

      real (kind=dbl_kind) ::  local_real_maxval
      integer (kind=int_kind) ::  communicator

      local_real_maxval = maxval(X)

#if mpi == 1
      communicator = get_my_communicator(component_name)
      call MPI_ALLREDUCE(local_real_maxval, global_real_maxval, 1,      &
                         mpi_float_type, MPI_MAX, communicator, ierr)
#else
      global_real_maxval = local_real_maxval
#endif

      end function global_real_maxval

!---------------------------------------------------------------------

      real (kind=dbl_kind) function global_real_maxval_mask(X, MASK,   &
                                                         size, component_name)

      implicit none
      integer (kind=int_kind), intent(in) :: size 
      character (len=*), intent(in) :: component_name
      real (kind=dbl_kind), intent(in) :: X(size), MASK(size)

      real (kind=dbl_kind) :: local_real_maxval
      integer (kind=int_kind) ::  communicator

      local_real_maxval = maxval(X,mask=MASK.ne.0.0_dbl_kind)

#if mpi == 1
      communicator = get_my_communicator(component_name)
      call MPI_ALLREDUCE(local_real_maxval, global_real_maxval_mask, 1,      &
                         mpi_float_type, MPI_MAX, communicator, ierr)
#else 
      global_real_maxval_mask = local_real_maxval
#endif

      end function global_real_maxval_mask

!--------------------------------------------------------------------- 

 
      integer function global_int_minval(X, size, component_name)

      implicit none
      integer (kind=int_kind), intent(in) :: size
      character (len=*), intent(in) :: component_name
      integer (kind=int_kind), intent(in) :: X(size)

      integer (kind=int_kind) :: local_int_minval
      integer (kind=int_kind) ::  communicator

      local_int_minval = minval(X)

#if mpi == 1
      communicator = get_my_communicator(component_name)
      call MPI_ALLREDUCE(local_int_minval, global_int_minval, 1,      &
                         mpi_int_type, MPI_MIN, communicator, ierr)
#else
      global_int_minval = local_int_minval
#endif

      end function global_int_minval

!---------------------------------------------------------------------
 
      real (kind=dbl_kind) function global_real_minval(X, size, component_name)

      implicit none

      integer (kind=int_kind), intent(in) :: size
      character (len=*), intent(in) :: component_name
      real (kind=dbl_kind), intent(in) :: X(size)

      real (kind=dbl_kind) :: local_real_minval
      integer (kind=int_kind) ::  communicator

      local_real_minval = minval(X)

#if mpi == 1
      communicator = get_my_communicator(component_name)
      call MPI_ALLREDUCE(local_real_minval, global_real_minval, 1,      &
                         mpi_float_type, MPI_MIN, communicator, ierr)
#else
      global_real_minval = local_real_minval
#endif

      end function global_real_minval

!---------------------------------------------------------------------
 
      real (kind=dbl_kind) function global_real_minval_mask(X, MASK,     &
                                                        size, component_name)

      implicit none

      integer (kind=int_kind), intent(in) :: size
      character (len=*), intent(in) :: component_name
      real (kind=dbl_kind), intent(in) :: X(size), MASK(size)

      real (kind=dbl_kind) :: local_real_minval
      integer (kind=int_kind) ::  communicator

      local_real_minval = minval(X,mask=MASK.ne.0.0_dbl_kind)

#if mpi == 1
      communicator = get_my_communicator(component_name)
      call MPI_ALLREDUCE(local_real_minval, global_real_minval_mask, 1,      &
                         mpi_float_type, MPI_MIN, communicator, ierr)
#else 
      global_real_minval_mask = local_real_minval
#endif

      end function global_real_minval_mask

!---------------------------------------------------------------------

      subroutine global_real_maxloc(WORK, idim, jdim, i, j, val)

      implicit none

      integer (kind=int_kind), intent(in) :: idim,jdim
      real (kind=dbl_kind), intent(in) :: WORK(idim,jdim)

      integer (kind=int_kind), intent(out) :: i,j
      real (kind=dbl_kind), intent(out) :: val

      real (kind=dbl_kind) :: IJ(2)

      val = maxval(WORK)
      IJ = maxloc(WORK)
      i = IJ(1)
      j = IJ(2)

#if mpi == 1
      call abort_code('real_maxloc not mpi')
#endif

      end subroutine global_real_maxloc

!---------------------------------------------------------------------

      end module global_reductions
