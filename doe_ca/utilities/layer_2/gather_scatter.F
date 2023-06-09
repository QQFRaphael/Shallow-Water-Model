      MODULE gather_scatter

!-----------------------------------------------------------------------
! PURPOSE: contains subroutines which transform data from one data
!       structure to another
!
! the "global grid" is (im,jm), the grid that each processors owns is
!       (iim,jjm,nsdm). gather goes from (iim,jjm,nsdm) to (im,jm),
!       scatter is the reverse. scatter and gather have both mpi and
!       serial versions.
!
! reduce_to_vector_global goes from (im,jm) to (max_ig), i.e. it takes
!       all of the "true" cells on the (im,jm) grid and lists them in
!       a vector format of length (max_ig). scatter_to_grid_global is
!       the reverse. both of these subroutines are serial.
!-----------------------------------------------------------------------

      USE kinds
      USE abort
      USE params_physical
      USE params_MPI
      USE component_intra
      USE wrap_data

      IMPLICIT NONE
      SAVE
      PRIVATE

# if mpi == 1
      INCLUDE 'mpif.h'
# endif


! PUBLIC MEMBER FUNCTIONS
      PUBLIC ::                      &
         scatter,                    &
         gather,                     &
         reduce_to_vector_global,    &
         scatter_to_grid_global

      CONTAINS



!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
      SUBROUTINE scatter (component_name,                          &
                          im_t,jm_t,iim_t,jjm_t,nvar,nsdm_t,       &
                          x1,x2)
! 25 SEPTEMBER 2000
      IMPLICIT NONE
      INTEGER (KIND=int_kind), intent(in) ::                  &
         im_t,jm_t,iim_t,jjm_t,nvar,nsdm_t
      CHARACTER(*), intent(in) :: component_name
      REAL (KIND=dbl_kind), intent(in) :: x1(im_t,jm_t,nvar)
      REAL (KIND=dbl_kind), intent(out) :: x2(iim_t,jjm_t,nvar,nsdm_t)

! local variables
      INTEGER (KIND=int_kind) :: i,j,panel,isd,jsd,off,      &
                                 msg_size,sbdmn_number,nsd,  &
                                 count_send, communicator,   &
                                 my_task
# if mpi == 1
      INTEGER (KIND=int_kind), ALLOCATABLE :: recv_req(:),send_req(:),   &
                                       recv_status(:,:),send_status(:,:)
      INTEGER (KIND=int_kind) :: send_total,msg_dest,msg_tag,ierr
      REAL (KIND=dbl_kind), ALLOCATABLE :: send_buffer(:,:,:,:),         &
                                           recv_buffer(:,:,:,:)
# endif

      TYPE (component_node),POINTER :: & 
         Current
         
      current => get_component_pointer(component_name)

      if(current%max_ig == 1) then
         x2(1,1,:,1) = x1(1,1,:)
      else

      msg_size = iim_t*jjm_t*nvar
      
      my_task = get_my_task(component_name)
      communicator = get_my_communicator(component_name)
     
      IF (my_task.EQ.0) THEN
# if mpi == 1
         send_total = 5*current%isdm*current%jsdm-nsdm_t
         ALLOCATE (send_req(send_total))
         send_req(:) = -999
         ALLOCATE (send_status(MPI_STATUS_SIZE,send_total))
         send_status(:,:) = -999
         ALLOCATE (send_buffer(iim_t,jjm_t,nvar,send_total))
         send_buffer(:,:,:,:) = 0.0
# endif
         sbdmn_number = 0
         nsd = 0
         count_send = 0
         DO panel = 0,4
            off = (im_t/5)*panel
            DO jsd = 0,current%jsdm-1
               DO isd = 0,current%isdm-1
                  sbdmn_number = sbdmn_number + 1
                  IF (current%sbdmn_owner%owner(sbdmn_number).EQ.0) THEN
                     nsd = nsd + 1
                     DO j = 1,jjm_t
                        DO i = 1,iim_t
                           x2(i,j,:,nsd) =                          &
                               x1(off+(iim_t-2)*isd+i,(jjm_t-2)*jsd+j,:)
                        ENDDO
                     ENDDO
                  ELSE
# if mpi == 1
                     count_send = count_send + 1
                     DO j = 1,jjm_t
                        DO i = 1,iim_t
                           send_buffer(i,j,:,count_send) =              &
                               x1(off+(iim_t-2)*isd+i,(jjm_t-2)*jsd+j,:)
                        ENDDO
                     ENDDO
                     msg_dest = current%sbdmn_owner%owner(sbdmn_number)
                     CALL MPI_ISEND (send_buffer(1,1,1,count_send),     &
                             msg_size,                                  &
                             mpi_float_type,msg_dest,sbdmn_number,      &
                             communicator,send_req(count_send),ierr)
# endif
                  ENDIF
               ENDDO
            ENDDO
         ENDDO
# if mpi == 1
         CALL MPI_WAITALL (send_total,send_req,send_status,ierr)

         DEALLOCATE (send_req,send_buffer,send_status)
# endif
      ENDIF

# if mpi == 1
      IF (my_task.NE.0) THEN
! POST RECEIVES
         ALLOCATE (recv_req(nsdm_t))
         recv_req(:) = -999
         ALLOCATE (recv_status(MPI_STATUS_SIZE,nsdm_t))
         recv_status(:,:) = -999
         ALLOCATE (recv_buffer(iim_t,jjm_t,nvar,nsdm_t))
         recv_buffer(:,:,:,:) = 0.0

         DO nsd = 1,nsdm_t
            msg_tag = current%sbdmn_assign%sd(my_task+1,nsd)
            CALL MPI_IRECV (recv_buffer(1,1,1,nsd),msg_size,    &
                            mpi_float_type,0,msg_tag,           &
                            communicator,recv_req(nsd),ierr)
         ENDDO

         CALL MPI_WAITALL (nsdm_t,recv_req,recv_status,ierr)

! UNPACK BUFFERS
         DO nsd = 1,nsdm_t
            DO j = 1,jjm_t
               DO i = 1,iim_t
                  x2(i,j,:,nsd) = recv_buffer(i,j,:,nsd)
               ENDDO
            ENDDO
         ENDDO

         DEALLOCATE (recv_req,recv_buffer,recv_status)
      ENDIF

      CALL MPI_BARRIER (communicator,ierr)
# endif

      endif
      END SUBROUTINE scatter



!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
      SUBROUTINE gather (component_name,                            &
                         im_t,jm_t,iim_t,jjm_t,nvar,nsdm_t,x2,x1)
! 26 SEPTEMBER 2000
      IMPLICIT NONE

      INTEGER (KIND=int_kind), INTENT(in) ::                        &
           im_t,jm_t,iim_t,jjm_t,nvar,nsdm_t
      CHARACTER(*), INTENT(in) :: component_name
      REAL (KIND=dbl_kind), INTENT(in) :: x2(iim_t,jjm_t,nvar,nsdm_t)
      REAL (KIND=dbl_kind), INTENT(out) :: x1(im_t,jm_t,nvar)

! local variables
      INTEGER (KIND=int_kind) :: i,j,panel,isd,jsd,off,         &
                                 msg_size,sbdmn_number,nsd,     &
                                 count_recv,communicator,my_task
# if mpi == 1
      INTEGER (KIND=int_kind), ALLOCATABLE :: recv_req(:),send_req(:),   &
                                      recv_status(:,:),send_status(:,:)
      INTEGER (KIND=int_kind) :: recv_total,msg_src,msg_tag,ierr
      REAL (KIND=dbl_kind), ALLOCATABLE :: recv_buffer(:,:,:,:)
# endif

      TYPE (component_node),POINTER :: & 
         Current

      current => get_component_pointer(component_name)

      if(current%max_ig == 1) then
         x1(1,1,:) = x2(1,1,:,1)
      else

      msg_size = iim_t*jjm_t*nvar
      my_task = get_my_task(component_name)
      communicator = get_my_communicator(component_name)

# if mpi == 1
      IF (my_task.NE.0) THEN
         ALLOCATE (send_req(nsdm_t))
         send_req(:) = -999
         ALLOCATE (send_status(MPI_STATUS_SIZE,nsdm_t))
         send_status(:,:) = -999
         DO nsd = 1,nsdm_t
            msg_tag = current%sbdmn_assign%sd(my_task+1,nsd)
            CALL MPI_ISEND (x2(1,1,1,nsd),msg_size,     &
                            mpi_float_type,0,msg_tag,   &
                            communicator,send_req(nsd),ierr)
         ENDDO
         CALL MPI_WAITALL (nsdm_t,send_req,send_status,ierr)

         DEALLOCATE (send_req,send_status)
      ENDIF
#endif

      IF (my_task.EQ.0) THEN
# if mpi == 1
         recv_total = 5*current%isdm*current%jsdm-nsdm_t
         ALLOCATE (recv_req(recv_total))
         recv_req(:) = -999
         ALLOCATE (recv_status(MPI_STATUS_SIZE,recv_total))
         recv_status(:,:) = -999
         ALLOCATE (recv_buffer(iim_t,jjm_t,nvar,recv_total))
         recv_buffer(:,:,:,:) = 0.0
# endif
         sbdmn_number = 0
         nsd = 0
         count_recv = 0

         DO panel = 0,4
            off = (im_t/5)*panel
            DO jsd = 0,current%jsdm-1
               DO isd = 0,current%isdm-1
                  sbdmn_number = sbdmn_number + 1
                  IF (current%sbdmn_owner%owner(sbdmn_number).EQ.0) THEN
                     nsd = nsd + 1
                     DO j = 1,jjm_t
                        DO i = 1,iim_t
                           x1(off+(iim_t-2)*isd+i,(jjm_t-2)*jsd+j,:) =   &
                                                           x2(i,j,:,nsd)
                        ENDDO
                     ENDDO
                  ELSE
# if mpi == 1
                     count_recv = count_recv + 1
                     msg_src = current%sbdmn_owner%owner(sbdmn_number)
                     CALL MPI_IRECV (recv_buffer(1,1,1,count_recv),   &
                              msg_size,                               &
                              mpi_float_type,msg_src,sbdmn_number,    &
                              communicator,recv_req(count_recv),ierr)
# endif
                  ENDIF
               ENDDO
            ENDDO
         ENDDO

# if mpi == 1
         CALL MPI_WAITALL (recv_total,recv_req,recv_status,ierr)

         sbdmn_number = 0
         count_recv = 0

         DO panel = 0,4
            off = (im_t/5)*panel
            DO jsd = 0,current%jsdm-1
               DO isd = 0,current%isdm-1
                  sbdmn_number = sbdmn_number + 1
                  IF (current%sbdmn_owner%owner(sbdmn_number).NE.0) THEN
                     count_recv = count_recv + 1
                     DO j = 1,jjm_t
                        DO i = 1,iim_t
                           x1(off+(iim_t-2)*isd+i,(jjm_t-2)*jsd+j,:) =     &
                                           recv_buffer(i,j,:,count_recv)
                        ENDDO
                     ENDDO
                  ENDIF
               ENDDO
            ENDDO
         ENDDO 

         DEALLOCATE (recv_req,recv_buffer,recv_status)
# endif
      ELSE
! While the output array is only meant to have meaning on process 0,
!   we initialize it on other processes so we don't have problems
!   in debug mode when it would be otherwise initialized with nan by
!   the compiler
         x1 = 0.0_dbl_kind
      ENDIF

# if mpi == 1
      CALL MPI_BARRIER (communicator,ierr)
# endif

      endif
      END SUBROUTINE gather




!======================================================================
! START OF REDUCE_TO_VECTOR_GLOBAL
!======================================================================
      SUBROUTINE reduce_to_vector_global(component_name,                &
                                         im, jm, max_ig, xin, xout)

      IMPLICIT NONE
      CHARACTER(*), INTENT(in) :: component_name
      integer (kind = int_kind), intent(in) :: im, jm, max_ig
      real (kind = dbl_kind), dimension(im,jm), intent(in) ::  xin
      real (kind = dbl_kind), dimension(max_ig), intent(out) ::  xout

! local variables
      integer (kind = int_kind) :: i,ii,j,panel,icount,im5, my_task

      if(max_ig == 1) then
         xout(1) = xin(1,1)
      else
         my_task = get_my_task(component_name)

         if(my_task == 0) then
            xout(1)=xin(1,jm-1)
            xout(2)=xin(im-1,1)
            icount=2
            im5 = im/5
            DO j = 2,jm-1
               DO panel = 0,4
                  DO i = 2,im5-1
                     icount=icount+1
                     ii = im5*panel+i
                     xout(icount)=xin(ii,j)
                  ENDDO
               ENDDO
            ENDDO
         else
! While the output array is only meant to have meaning on process 0,
!   we initialize it on other processes so we don't have problems
!   in debug mode when it would be otherwise initialized with nan by
!   the compiler
            xout = 0.0_dbl_kind
         endif
      endif

      end subroutine reduce_to_vector_global
!======================================================================
! END OF REDUCE_TO_VECTOR_GLOBAL
!======================================================================


!======================================================================
! START OF SCATTER_TO_GRID_GLOBAL
!======================================================================
      SUBROUTINE scatter_to_grid_global(component_name,      &
                                        im, jm, max_ig, xin, xout)

      IMPLICIT NONE
      CHARACTER(*), INTENT(in) :: component_name
      integer (kind = int_kind), intent(in) :: im, jm, max_ig
      real (kind = dbl_kind), dimension(max_ig), intent(in) ::  xin
      real (kind = dbl_kind), dimension(im,jm), intent(out) ::  xout

! local variables
      integer (kind = int_kind) :: i,ii,j,panel,icount,im5, my_task

      if(max_ig == 1) then
         xout(1,1) = xin(1)
      else

         my_task = get_my_task(component_name)

         if(my_task == 0) then
            xout = 0.0
            xout(1,jm-1) = xin(1)
            xout(im-1,1) = xin(2)
            icount=2
            im5 = im/5
            DO j = 2,jm-1
               DO panel = 0,4
                  DO i = 2,im5-1
                     icount=icount+1
                     ii = im5*panel+i
                     xout(ii,j)=xin(icount)
                  ENDDO
               ENDDO
            ENDDO
         ELSE
! While the output array is only meant to have meaning on process 0,
!   we initialize it on other processes so we don't have problems
!   in debug mode when it would be otherwise initialized with nan by
!   the compiler
            xout = 0.0_dbl_kind
         endif
      endif

      end subroutine scatter_to_grid_global
!======================================================================
! END OF SCATTER_TO_GRID_GLOBAL
!=====================================================================


!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
      END MODULE gather_scatter
!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
