   MODULE component_intra
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  PURPOSE:  store information necessary for communication within
!            a model component.   includes utilities to store and 
!            access that information.
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   USE kinds
   USE types
   USE abort

   IMPLICIT NONE
   SAVE
   PRIVATE

   TYPE, public :: component_node
      CHARACTER (LEN=72) ::                                                  &
         component_name
!~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
!  parameters pertaining to horizontal grid structure
!~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
      INTEGER (KIND=int_kind) ::                                             &
         max_level,even_odd_factor,max_ig,im,jm,iim,jjm,isdm,jsdm
!~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
!  parameters pertaining to parallel structure and message passing
!~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
      INTEGER (KIND=int_kind) ::                                             &
         npe_comp,my_task                              !  parallel structure
      INTEGER (KIND=int_kind) ::                                             &
         MPI_int_type,MPI_float_type,MPI_communicator  !  message passing
!~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
!  parameters pertaining to parallel structure and message passing for wrap
!~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
      INTEGER (KIND=int_kind) ::                                             &
         npe_comp_wrap,my_task_wrap, npe_comp_gath  !  parallel structure
      INTEGER (KIND=int_kind) ::                                             &
         MPI_communicator_wrap  !  message passing
!~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
!  subdomain assign and subdomain owner information
!~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
      TYPE (sbdmn_assign_type) ::                                            &
         sbdmn_assign
      TYPE (sbdmn_owner_type) ::                                             &
         sbdmn_owner
!~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
!  subdomain assign information for wrap
!~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
      TYPE (sbdmn_assign_type) ::                                            &
         sbdmn_assign_wrap
!~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
!  wrapping information
!~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
      TYPE (message_instructions),POINTER ::                                 &
         task_instr(:,:)
      INTEGER (KIND=int_kind),POINTER ::                                     &
         total_send_length(:,:),total_recv_length(:,:)
!~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
!  pointer to next node
!~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
      TYPE (component_node),POINTER ::                                       &
         next
   END TYPE component_node

   TYPE (component_node),POINTER ::                                          &
      component_list
      
! public member functions
      PUBLIC ::                                                              &
         initialize_component,                                               &
         get_component_pointer,                                              &
         set_component_horizontal,                                           &
         set_component_parallel,                                             &
         get_my_task,                                                        &
         get_my_communicator,                                                &
         get_my_npe

   CONTAINS
!=======================================================================
!  BEGIN  initialize_component
!=======================================================================
   SUBROUTINE initialize_component (component_name)
!.......................................................................
!  INTENT IN
!.......................................................................
   CHARACTER (LEN=*), intent(in) ::                                          &
      component_name
!.......................................................................
!  LOCAL
!.......................................................................
   TYPE (component_node),POINTER ::                                          &
      current
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! THE FIRST TIME initialize_component IS CALLED, INITIALIZE component_list
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   IF (.NOT.ASSOCIATED (component_list)) THEN
      ALLOCATE (component_list); NULLIFY (component_list%next)
      current => component_list
   ELSE
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! LOOK THROUGH THE LIST TO FIND DUPLICATE component_name
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      current => component_list
      DO WHILE (ASSOCIATED (current))
         IF (TRIM (current%component_name)==TRIM (component_name)) THEN
            call abort_code(' initialize_component : component = "'//        &
                             TRIM (component_name)//'" ALREADY EXISTS.')
         ENDIF
         current => current%next
      ENDDO
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  ADD A NEW NODE TO THE END OF THE LIST
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      current => component_list
      DO WHILE (ASSOCIATED (current%next))
         current => current%next
      ENDDO
      ALLOCATE (current%next)
      current => current%next
      NULLIFY  (current%next)
   ENDIF

   current%component_name = component_name
   
 !!!!!!!!!!!!!!!!!!!!!
 !  initialize wrap related quantities
   current%my_task_wrap = -999
   current%npe_comp_wrap = -999
   current%MPI_communicator_wrap = -999

   END SUBROUTINE initialize_component
!=======================================================================
!  END  initialize_component
!=======================================================================

!=======================================================================
!  BEGIN  get_component_pointer
!=======================================================================
   FUNCTION get_component_pointer (component_name) RESULT (current)
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  PURPOSE: returns a pointer to the componet coorresponding to component_name
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!.......................................................................
!  INTENT IN
!.......................................................................
   CHARACTER (LEN=*), intent(in) ::                                          &
      component_name
!.......................................................................
!  INTENT OUT
!.......................................................................
   TYPE (component_node),POINTER ::                                          &
      current
!.......................................................................
!  LOCAL
!.......................................................................
   LOGICAL (KIND=log_kind) ::                                                &
      l_name_found
!.......................................................................
   IF (.NOT.ASSOCIATED (component_list)) THEN
      call abort_code(                                                       &
         ' get_component_pointer : no model components have been initialized ')
   ELSE
      current => component_list
      l_name_found = .FALSE.
      DO WHILE ((ASSOCIATED (current)).AND.(.NOT.l_name_found))
         IF (TRIM (current%component_name)==TRIM (component_name)) THEN
            l_name_found = .TRUE.
         ENDIF
         IF (.NOT.l_name_found) THEN
            current => current%next
         ENDIF
      ENDDO
      IF (.NOT.l_name_found) THEN
         call abort_code(' get_component_pointer : the component named = "'  &
                      //TRIM (component_name)//'" has not been initialized.')
      ENDIF
   ENDIF

   END FUNCTION get_component_pointer
!=======================================================================
!  END  get_component_pointer
!=======================================================================

!=======================================================================
!  BEGIN  set_component_horizontal
!=======================================================================
   SUBROUTINE set_component_horizontal (component_name,                      &
               max_level,even_odd_factor,max_ig,im,jm,iim,jjm,isdm,jsdm)
!.......................................................................
!  INTENT IN
!.......................................................................
   CHARACTER (LEN=*), intent(in) ::                                          &
      component_name
   INTEGER (KIND=int_kind), intent(in) ::                                    &
      max_level,even_odd_factor,max_ig,im,jm
   INTEGER (KIND=int_kind), intent(in), optional ::                          &
      iim,jjm,isdm,jsdm
!.......................................................................
!  LOCAL
!.......................................................................
   TYPE (component_node),POINTER ::                                          &
      current
!.......................................................................

   current => get_component_pointer (component_name)

   current%max_level       = max_level
   current%even_odd_factor = even_odd_factor
   current%max_ig          = max_ig
   current%im              = im
   current%jm              = jm
   if(present(iim)) current%iim    = iim
   if(present(jjm)) current%jjm    = jjm
   if(present(isdm)) current%isdm  = isdm
   if(present(jsdm)) current%jsdm  = jsdm

   END SUBROUTINE set_component_horizontal
!=======================================================================
!  END  set_component_horizontal
!=======================================================================

!=======================================================================
!  BEGIN  set_component_parallel
!=======================================================================
   SUBROUTINE set_component_parallel (component_name,                        &
          npe_comp,my_task,MPI_int_type,MPI_float_type,MPI_communicator)
#if mpi == 1
   INCLUDE 'mpif.h'
#endif
!.......................................................................
!  INTENT IN
!.......................................................................
   CHARACTER (LEN=*), intent(in) ::                                          &
      component_name
   INTEGER (KIND=int_kind), intent(in) ::                                    &
      npe_comp,my_task,MPI_communicator,MPI_float_type,MPI_int_type
!.......................................................................
!  LOCAL
!.......................................................................
   TYPE (component_node),POINTER ::                                          &
      current
   integer n, mpi_group_comp, mpi_group_local, ierr
   integer, dimension(:), allocatable :: p_ranks
!.......................................................................

   current => get_component_pointer (component_name)

   current%npe_comp         = npe_comp
   current%my_task          = my_task
   current%MPI_int_type     = MPI_int_type
   current%MPI_float_type   = MPI_float_type
   current%MPI_communicator = MPI_communicator
   
   current%npe_comp_wrap = min(320,npe_comp)
   current%npe_comp_gath = npe_comp / current%npe_comp_wrap
   if(current%npe_comp_gath*current%npe_comp_wrap .ne. npe_comp )             &
      call abort_code('wrap parallelization not properly set')
      
#if mpi == 0
   current%my_task_wrap = my_task
   current%mpi_communicator_wrap = MPI_communicator
#else
   allocate(p_ranks(current%npe_comp_wrap))
   
   do n = 1, current%npe_comp_wrap
     p_ranks(n) = (n-1)*current%npe_comp_gath
   enddo
        call MPI_COMM_GROUP(                &
             MPI_communicator,                &
             MPI_GROUP_comp,               &
             ierr)

        call MPI_GROUP_INCL(                &
             MPI_GROUP_comp,               &
             current%npe_comp_wrap,                     &
             p_ranks,                  &
             mpi_group_local,                   &
             ierr)

        call MPI_COMM_CREATE(               &
             MPI_communicator,                &
             mpi_group_local,                   &
             current%MPI_communicator_wrap,                &
             ierr)
   if(mod(my_task, current%npe_comp_gath) == 0)       &
           call MPI_COMM_RANK (current%MPI_communicator_wrap, current%my_task_wrap,ierr)
   deallocate(p_ranks)
#endif

   END SUBROUTINE set_component_parallel
!=======================================================================
!  END  set_component_parallel
!=======================================================================

!=======================================================================
!  BEGIN  get_my_task
!=======================================================================
   FUNCTION get_my_task (component_name) RESULT (my_task)
!.......................................................................
!  INTENT IN
!.......................................................................
   CHARACTER (LEN=*), intent(in) ::                                          &
      component_name
!.......................................................................
!  INTENT OUT
!.......................................................................
   INTEGER (int_kind) ::                                                     &
      my_task
!.......................................................................
!  LOCAL
!.......................................................................
   TYPE (component_node),POINTER ::                                          &
      current
!.......................................................................

   current => get_component_pointer (component_name)
   my_task = current%my_task

   END FUNCTION get_my_task
!=======================================================================
!  END  get_my_task
!=======================================================================

!=======================================================================
!  BEGIN  get_my_communicator
!=======================================================================
   FUNCTION get_my_communicator (component_name) RESULT (MPI_communicator)
!.......................................................................
!  INTENT IN
!.......................................................................
   CHARACTER (LEN=*), intent(in) ::                                          &
      component_name
!.......................................................................
!  INTENT OUT
!.......................................................................
   INTEGER (int_kind) ::                                                     &
      MPI_communicator
!.......................................................................
!  LOCAL
!.......................................................................
   TYPE (component_node),POINTER ::                                          &
      current
!.......................................................................

   current => get_component_pointer (component_name)
   MPI_communicator = current%MPI_communicator

   END FUNCTION get_my_communicator
!=======================================================================
!  END  get_my_communicator
!=======================================================================

!=======================================================================
!  BEGIN  get_my_npe
!=======================================================================
   FUNCTION get_my_npe (component_name) RESULT (npe_comp)
!.......................................................................
!  INTENT IN
!.......................................................................
   CHARACTER (LEN=*), intent(in) ::                                          &
      component_name
!.......................................................................
!  INTENT OUT
!.......................................................................
   INTEGER (int_kind) ::                                                     &
      npe_comp
!.......................................................................
!  LOCAL
!.......................................................................
   TYPE (component_node),POINTER ::                                          &
      current
!.......................................................................

   current => get_component_pointer (component_name)
   npe_comp = current%npe_comp

   END FUNCTION get_my_npe
!=======================================================================
!  END  get_my_npe
!=======================================================================

   END MODULE component_intra
!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc

