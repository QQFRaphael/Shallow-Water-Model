module output_utilities

!-----------------------------------------------------------------------
! PURPOSE : provide a means to do various output functions in a 
!           parallel environment
!     output_process0 - writes a text message and one scalar( optional)
!        for local process 0
!     output_vector_form - writes a geodesic data vector of size max_ig
!        for local process 0, using formatted 5e15.8 ascii format
!     output_vector_bin - writes a geodesic data vector of size max_ig 
!        for local process 0, using unformatted real*4 binary output
!     output_all_in_order - writes a text message and one scalar (optional)
!        for all local processes, ordered from process zero through npe-1
! Modifications:
!     2004 Jan 23 - added new routine, OUTPUT_DISTRIBUTED_ARRAY, which 
!        takes a real (iim,jjm,nsdm) array and writes the max_ig
!        vector as binary. - D.D.
!-----------------------------------------------------------------------

   use kinds
   use component_intra
   use gather_scatter
   use wrap_data
   private

#if mpi == 1
      	 include 'mpif.h'
#endif

! public member functions
   public ::                                                           &
      output_process0,                                                 &
      output_vector_form,                                              &
      output_vector_bin,                                               &
      output_all_in_order,                                             &
      output_distributed_array

   contains

   subroutine output_process0(component_name, msg_text, msg_int, msg_dbl)

! argument list
   character(*), intent(in) ::                                         &
      component_name   ! handle to get necessary parallel environment variables
   character(*), intent(in) ::                                         &
      msg_text         ! text message to write
   integer (kind=int_kind), intent(in), optional ::                    &
      msg_int
   real (kind=dbl_kind), intent(in), optional ::                       &
      msg_dbl

! local variables
   integer (kind=int_kind) ::                                          &
      my_task

   my_task = get_my_task(component_name)

   if(my_task == 0) then

! write the messages
      if(present(msg_int) .or. present(msg_dbl)) then
         if(present(msg_int)) write(6,*)msg_text,msg_int
         if(present(msg_dbl)) write(6,*)msg_text,msg_dbl
      else
         write(6,*) msg_text
      endif

   endif

   end subroutine output_process0


   subroutine output_vector_form(component_name, file_name, x)

! argument list
   character(*), intent(in) ::                                         &
      component_name   ! handle to get necessary parallel environment variables
   character(*), intent(in) ::                                         &
      file_name        ! name of output file to write to
   real(kind=dbl_kind), intent(in), dimension(:) :: x  ! max_ig vector

! local variables
   integer (kind=int_kind) ::                                          &
      my_task

   my_task = get_my_task(component_name)

   if(my_task == 0) then
      open(unit=39,file=file_name,form='formatted')
      write(39,fmt='(5e15.8)')x
      close(39)
   endif

   end subroutine output_vector_form


   subroutine output_vector_bin(component_name, file_name, x)

! argument list
   character(*), intent(in) ::                                         &
      component_name   ! handle to get necessary parallel environment variables
   character(*), intent(in) ::                                         &
      file_name        ! name of output file to write to
   real(kind=dbl_kind), intent(in), dimension(:) :: x  ! max_ig vector

! local variables
   integer (kind=int_kind) ::                                          &
      my_task, max_ig 
   real (kind=real_kind), allocatable, dimension(:) :: y

   my_task = get_my_task(component_name)

   if(my_task == 0) then
      max_ig = size(x)
      allocate(y(max_ig))
      y = x
      open(unit=39,file=file_name,form='unformatted')
      write(39)y
      close(39)
      deallocate(y)
   endif

   end subroutine output_vector_bin


   subroutine output_all_in_order(component_name, msg_text, msg_int, msg_dbl)

! argument list
   character(*), intent(in) ::                                         &
      component_name   ! handle to get necessary parallel environment variables
   character(*), intent(in) ::                                         &
      msg_text         ! text message to write
   integer (kind=int_kind), intent(in), optional ::                    &
      msg_int
   real (kind=dbl_kind), intent(in), optional ::                       &
      msg_dbl

! local variables
   integer (kind=int_kind) ::                                          &
      my_task, i, npe, communicator, ierr

   my_task = get_my_task(component_name)
   communicator = get_my_communicator(component_name)
   npe = get_my_npe(component_name)

! this loop insures that the output from each process will be ordered
   do i = 0,npe-1
      if(my_task == i) then

! write the messages
         if(present(msg_int) .or. present(msg_dbl)) then
            if(present(msg_int)) write(6,*)' *** process ',my_task,msg_text,msg_int
            if(present(msg_dbl)) write(6,*)' *** process ',my_task,msg_text,msg_dbl
         else
            write(6,*) msg_text
         endif

      endif
#if mpi == 1
      CALL MPI_BARRIER (communicator,ierr)
#endif
   enddo
#if mpi == 1
   CALL MPI_BARRIER (communicator,ierr)
#endif

   end subroutine output_all_in_order


   subroutine output_distributed_array(component_name,filename,x, l_wrap)

!-----------------------------------------------------------------------
!    PURPOSE: 
!        takes a real (iim,jjm,nsdm) array and writes the max_ig
!        vector as binary. This is designed to be an easy-to-insert
!        routine for getting ezplot-readable output while debugging.
!    Note - a wrapped array is required before the gather operation.
!        Use l_wrap to perform this operation, if necessary.
!-----------------------------------------------------------------------

   character(*), intent(in) :: component_name              ! name of component
   character(*), intent(in) :: filename                    ! name of output file
   real(kind=dbl_kind), intent(in), dimension(:,:,:) :: x  ! input array,
                                                           ! distributed
   logical (kind=log_kind), intent(in), optional :: l_wrap ! if true, wrap
                                                           ! array before output

! local variables
   integer my_task, max_ig, im, jm, iim, jjm, nsdm, isdm, jsdm
   real (kind=dbl_kind), allocatable, dimension(:,:) :: xg   ! global array
   real (kind=dbl_kind), allocatable, dimension(:) :: x_vec  ! global vector
   real (kind=real_kind), allocatable, dimension(:) :: x_vec4! global real*4
                                                             !  vector
   TYPE (component_node),POINTER :: Current

! get appropriate dimension info from component data type
   my_task = get_my_task(component_name)
   current => get_component_pointer(component_name)
   max_ig = current%max_ig
   im = current%im
   jm = current%jm
   iim = current%iim
   jjm = current%jjm
   isdm = current%isdm
   jsdm = current%jsdm
   nsdm = 5 * isdm * jsdm / get_my_npe(component_name)

! allocate work variables
   allocate(x_vec(max_ig))
   allocate(x_vec4(max_ig))
   allocate(xg(im,jm))

! wrap input if desired
   if(present(l_wrap)) then
     if(l_wrap) call wrap (component_name,face_1l=x)
   endif

! get the real*4 global vector
   call gather (component_name,im,jm,iim,jjm,1,nsdm,x,xg)
   call reduce_to_vector_global(component_name,im, jm, max_ig, xg, x_vec)
   x_vec4 = x_vec

! write output
   if(my_task == 0) then
      open(unit=39,file=filename,form='unformatted',position='APPEND')
      write(39)x_vec4
      close(39)
   endif

! clean up deallocation
   deallocate(xg)
   deallocate(x_vec)
   deallocate(x_vec4)

   end subroutine output_distributed_array



end module output_utilities
