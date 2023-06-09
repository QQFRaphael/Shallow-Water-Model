!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

   module assign_owner
        
!***********************************************************************
!
!     Purpose: For the Flux Coupler
!     This module determines how the subdomains will be distributed 
!     across all processes.
!     
!     Author: Atul Nulkar, June 2002
!     Cleaned up original code to conform to CCM4 standard
!
!***********************************************************************
      
   use kinds
   use abort
   use types
   use component_intra
   use output_utilities
    
   implicit none
   save
   private

! public member functions
   public ::                                &
      set_assign_owner
            
   contains

!======================================================================
! BEGINNING OF SET_ASSIGN_OWNER
!======================================================================

   subroutine set_assign_owner(                                            &
                         isdm,            jsdm,                            &
                         max_level,       level,                           &
                         partition_factor,component_name, assign_file,     &
                         sbdmn_assign,    sbdmn_owner     ) 

! declare argument list
   integer (kind=int_kind), intent(in) ::                                  &
      isdm,                                                                &
      jsdm,                                                                &
      max_level,                                                           &
      level,                                                               &
      partition_factor

   character(len=*), intent(in) :: component_name
   character(len=*), intent(in) :: assign_file

! optional arguments for imposing an external arrangment on the 
!   sbdmn_assign and sbdmn_owner variables
   type(sbdmn_assign_type), intent(in), optional ::                        &
      sbdmn_assign
   type(sbdmn_owner_type), intent(in), optional ::                         &
      sbdmn_owner

! local variables
   integer (kind=int_kind) ::                                              &
      ierr,        &  ! i/o error return code
      npe,         &
      task,        &
      panel_factor,&
      length
   logical (kind=log_kind) ::                                              &
      l_exist,     &  ! if true, the assign_file exists
      l_reorder,   &  ! if true, the subdomains have been reordered
      l_error         ! if true, there is a fatal error in this subroutine

   TYPE (component_node),POINTER :: & 
      Current

                   
   l_error = .FALSE.
   l_reorder = .FALSE.

   if(isdm == 1) then    
      panel_factor = 1   ! single column model
   else
      panel_factor = 5   ! global model
   endif

   current => get_component_pointer(component_name)
   npe = get_my_npe(component_name)

!----------------------------------------------------------------------
! CHECK TO MAKE SURE THAT THE NUMBER OF SUBDOMAINS IS EVENLY DIVISIBLE
! BY THE NUMBER OF PROCESSES, I.E. EACH PROCESS OWNS EQUAL NUMBER OF 
! SUBDOMAINS.
!----------------------------------------------------------------------
      
   if (mod (panel_factor*isdm*jsdm,npe)/=0) then
      call output_process0( component_name,                               &
         ' set_assign_owner : ERROR : subdomain total is',                &
         msg_int=panel_factor*isdm*jsdm )
      call output_process0( component_name,                               &
         ' this number is not evenly divisible npe = ',                   &
         msg_int=npe )
      l_error = .TRUE.
   endif

   
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! Test if we are externally forcing the assignment of the assign_owner
!    data structure by testing for their presence in the argument list;
!  else we will compute them or read them in.
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

   IF (present(sbdmn_assign) .and. present(sbdmn_owner) ) then

      length = sbdmn_assign%length(1)
      ALLOCATE (current%sbdmn_assign%length(npe) )
      ALLOCATE (current%sbdmn_assign%sd(npe,length) )
      current%sbdmn_assign = sbdmn_assign
      length = sbdmn_owner%length
      allocate (current%sbdmn_owner%owner(length))
      allocate (current%sbdmn_owner%local_sd(length))
      current%sbdmn_owner = sbdmn_owner

   Else

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! IF THE FILE sbdmn_assign EXISTS THEN READ sbdmn_assign FROM FILE
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      INQUIRE (FILE=assign_file,EXIST=l_exist)
      IF (l_exist) THEN
         call output_process0( component_name,                                &
            '  set_assign_owner : NOTE : sbdmn_assign FILE FOUND' )

         OPEN (UNIT=17,FILE=assign_file,                                      &
               FORM='FORMATTED',STATUS='OLD',IOSTAT=ierr)
      Else
         call output_process0( component_name, ' ' )
         call output_process0( component_name,                                &
            ' set_assign_owner : NOTE : sbdmn_assign FILE NOT FOUND' )
         call output_process0( component_name,                                &
            '    internally generating mechanism to distribute domains' )
         call output_process0( component_name, ' ' )
      endif

! get the subdomain assignments for this component and resolution
   call set_assign_owner_basic

      if (l_exist) close(17)

      if (l_reorder) then
         call output_process0( component_name,                                &
            ' set_assign_owner : NOTE : sbdmn_assign LIST FOUND IN' )
         call output_process0( component_name,                                &
            '       NOT STRICTLY ASCENDING ORDER AND WAS RE-ORDERED' )
      endif

   ENDIF

   IF (l_error) CALL abort_code ("set_assign_owner error")

   contains

!======================================================================
! BEGINNING OF SET_ASSIGN_OWNER_BASIC
!======================================================================

      subroutine set_assign_owner_basic 
                   
      implicit none

      integer (kind=int_kind) ::      &
         count,              & !
         read_level,         & !
         task,               & ! task loop index
         nsdm_sum,           & !
         nsdm_temp,          & !
         task_temp,          & !
         n,                  & !
         iteration,          & !
         partition_factor_level, & !
         nsd_tmp,            & !
         nsd                   ! subdomain loop index

!----------------------------------------------------------------------
! IF THE FILE sbdmn_assign EXISTS THEN READ sbdmn_assign FROM FILE
!----------------------------------------------------------------------

!     allocate (current%sbdmn_assign(npe,length))
     if (l_exist) then
         count = 0
         read (17,10,ADVANCE='YES')                                 &
             read_level,current%isdm,current%jsdm
      
         if (level/=read_level) then
            call output_process0( component_name,                   &
         ' set_assign_owner : ERROR : isdm/=read_level at level = ',&
               msg_int=level )
             l_error = .TRUE.
         endif
         
         read (17,'()',ADVANCE='YES')
         nsdm_sum = 0
      
!----------------------------------------------------------------------
! For each task (process), allocate/assign a subdomain. Distributes 
! subdomains across each process.
!----------------------------------------------------------------------

         allocate (current%sbdmn_assign%length(npe))
         do task = 0,npe-1
            read (17,20,ADVANCE='NO') task_temp,nsdm_temp
            if(task == 0) allocate (current%sbdmn_assign%sd(npe,nsdm_temp))
            nsdm_sum = nsdm_sum + nsdm_temp
            current%sbdmn_assign%length(task+1) = nsdm_temp
            do nsd = 1,nsdm_temp
               count = count + 1
               read (17,30,ADVANCE='NO',IOSTAT=ierr)                  &
                                   current%sbdmn_assign%sd(task+1,nsd)
               if (ierr/=0) then
                  call output_process0( component_name,               &
                    ' set_assign_owner : ERROR : short   at level = ',&
                     msg_int=level )
                  call output_process0( component_name,               &
                     ' task = ',msg_int=task )
                  l_error = .TRUE.
               endif
            enddo
            read (17,'()',ADVANCE='YES')
         enddo
         read (17,'()',ADVANCE='YES')
         
         if (nsdm_sum/=panel_factor*current%isdm*current%jsdm) then
            call output_process0( component_name,                     &
               ' set_assign_owner : ERROR : ' )
            call output_process0( component_name,                     &
               'sbdm_sum/=panel_factor*current%isdm*current%jsdm at level = ',   &
               msg_int=level )
             l_error = .TRUE.
         endif

         if (count>panel_factor*current%isdm*current%jsdm) then
            call output_process0( component_name,                     &
               ' set_assign_owner : ERROR : long list at level = ',   &
               msg_int=level )
            l_error = .TRUE.
         endif

!----------------------------------------------------------------------
! OTHERWISE GENERATE sbdmn_assign internally to distribute
! subdomains (i.e. If Input File not found).
! Process -> Subdomains
!----------------------------------------------------------------------      
      else ! else for if(l_exist)

         if(isdm == 1)then

! Single column model
            partition_factor_level = 1
            Current%isdm = 1
            Current%jsdm = 1
            ALLOCATE (current%sbdmn_assign%length(npe))
            ALLOCATE (current%sbdmn_assign%sd(npe,1))
            DO task = 0,npe-1
               if(task == 0) then
                  Current%sbdmn_assign%length(task+1) = 1
                  DO nsd = 1,1
                     Current%sbdmn_assign%sd(task+1,nsd) = nsd
                  ENDDO
               else
                  Current%sbdmn_assign%length(task+1) = 0
                  DO nsd = 1,1
                     Current%sbdmn_assign%sd(task+1,nsd) = -99
                  ENDDO
               endif
            ENDDO

         else

! global model
      
            IF (level<max(3,partition_factor)) then
               partition_factor_level = 1
               Current%isdm = 2
               Current%jsdm = 1
               ALLOCATE (current%sbdmn_assign%length(npe))
               ALLOCATE (current%sbdmn_assign%sd(npe,10))
               DO task = 0,npe-1
                  if(task == 0) then
                     Current%sbdmn_assign%length(task+1) = 10
                     DO nsd = 1,10
                        Current%sbdmn_assign%sd(task+1,nsd) = nsd
                     ENDDO
                  else
                     Current%sbdmn_assign%length(task+1) = 0
                     DO nsd = 1,10
                        Current%sbdmn_assign%sd(task+1,nsd) = -99
                     ENDDO
                  endif
               ENDDO
            ELSE
               partition_factor_level = min( partition_factor, max_level)
! these next two lines need to be consistent with the corresponding lines
!   in params_grid_horizontal
               Current%isdm = 2*2**(partition_factor_level-1)
               Current%jsdm =   2**(partition_factor_level-1)
               nsdm_temp = (panel_factor*current%isdm*current%jsdm)/npe
               count = 0
               ALLOCATE (current%sbdmn_assign%length(npe))
               ALLOCATE (current%sbdmn_assign%sd(npe,nsdm_temp))
               DO task = 0,npe-1
                  Current%sbdmn_assign%length(task+1) = nsdm_temp
                  DO nsd = 1,nsdm_temp
                     count = count + 1
                     current%sbdmn_assign%sd(task+1,nsd) = count
                  ENDDO
               ENDDO
            ENDIF
         endif
      endif ! end of if(l_exist)

!----------------------------------------------------------------------
! update iim, jjm for level < max_level (assumes npad = 1)
!----------------------------------------------------------------------
      if(level /= max_level) then
        current%iim  =                                                &
           2 + current%even_odd_factor*2**(level-partition_factor_level)
        current%jjm  =                                                &
           2 + current%even_odd_factor*2**(level-partition_factor_level)
      endif

      
!----------------------------------------------------------------------
! SORT sbdmn_assign LISTS INTO ASCENDING ORDER
!----------------------------------------------------------------------
      
      do task = 0,npe-1
         do iteration = 1,current%sbdmn_assign%length(task+1)
            do nsd = 1,current%sbdmn_assign%length(task+1)-1
               if (current%sbdmn_assign%sd(task+1,nsd) >           &
                   current%sbdmn_assign%sd(task+1,nsd+1)) then
                   
                  l_reorder = .TRUE.
                  nsd_tmp = current%sbdmn_assign%sd(task+1,nsd)
                  current%sbdmn_assign%sd(task+1,nsd) =            & 
                     current%sbdmn_assign%sd(task+1,nsd+1)
                  current%sbdmn_assign%sd(task+1,nsd+1) = nsd_tmp
                 
               endif
            enddo
         enddo
      enddo
      
!----------------------------------------------------------------------
! INITIALIZE sbdmn_owner, to assign a process/task to each subdomain.
! Subdomain points to a Process
!----------------------------------------------------------------------      
      
      allocate (current%sbdmn_owner%                                &
                   owner(panel_factor*current%isdm * current%jsdm))
      allocate (current%sbdmn_owner%                                &
                   local_sd(panel_factor* current%isdm* current%jsdm))
      current%sbdmn_owner%owner(:) = -999
      current%sbdmn_owner%local_sd(:) = -999
      current%sbdmn_owner%length = panel_factor*current%isdm*current%jsdm
      do task = 0,npe-1
         do nsd = 1, current%sbdmn_assign%length(task+1)
            current%sbdmn_owner%                                    &
               owner(current%sbdmn_assign%sd(task+1,nsd)) = task
            current%sbdmn_owner%                                    &
               local_sd(current%sbdmn_assign%sd(task+1,nsd)) = nsd
         enddo
      enddo
      do n = 1, current%sbdmn_owner%length
         if (current%sbdmn_owner%owner(n)==-999) then
            call output_process0( component_name,                     &
               ' set_assign_owner : ERROR : ' )
            call output_process0( component_name,                     &
               'sbdmn_owner is monkeyed up at level = ',msg_int=level )
            call output_process0( component_name,                     &
               '   no process was assigned to subdomain = ',msg_int=n )
            l_error = .TRUE.
         endif
      enddo
      
      10 format (8X,I2,2X,I3,1X,I3)
      20 format (2I5)
      30 format ( I5)

      end subroutine set_assign_owner_basic
    
!======================================================================
! END OF SUBROUTINE SET_ASSIGN_OWNER_BASIC
!======================================================================
    
   end subroutine set_assign_owner
    
!======================================================================
! END OF SUBROUTINE SET_ASSIGN_OWNER
!======================================================================
    
   end module assign_owner

!======================================================================
! END OF MODULE ASSIGN_OWNER
!======================================================================
