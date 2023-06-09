!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

module sendrecv

!***********************************************************************
!
!     Purpose:
!     This module demonstrates the message passing between all 
!     components. Currently the module has routines to send and receive
!     subdomain assign and owner types, as well as the actual real data 
!     fields. The module also has routines to build taglists and process 
!     id lists used in the message passing.
!
!     Authors: Don Dazlich and Atul Nulkar
!
!     Updated: December 12, 2002
!     History:
!        04 Jun 2003 - simplified the argument lists by using
!           component registration utility
!        20 Jun 2003 - introduced packing of messages so that only one
!           message is sent between are pair of processes. Have modifed
!           the message tag format to accomodate this. The message tag 
!           now drops the global subdomain number, but supports up to 
!           1000 processes per component. Additionally, multiple component
!           fields are packed into the same message
!     
!***********************************************************************
	
#if mpi == 1
   use MPH_module
#endif
   use kinds 
   use types
   use cpl_types
   use abort
   use component_intra
   use params_global_MPH
   use params_MPI 

   implicit none
   private

#if mpi == 1
   include 'mpif.h'
#endif

! integer parameters that identify the message type
   integer(kind=int_kind), parameter, public :: send = 1, recv = 2

   integer(kind=int_kind) :: &

! mpi message tag format: 8 digit number 'abbbcddd' where 
! a: source component ID (src_comp_id)
! b: source component process (sender's process# - src_proc_id)
! c: target component ID (target_comp_id)
! d: target component process (target's process# - target_proc_id)

!DD 20090923 Above definition of tag superceded to allow proc count > 1000
! Tag = target_procid + ntotprocs*( (target_compid-1) + num_comp*( src_procid + ntotprocs*(src_comp_id-1) )))
! Assuming 4 components this will allow up to 10000 procs in a signed 4-byte integer
! This computation is done in generate_message_tag, and the inverse in subintegerstring.
      tag

   integer(kind=int_kind), allocatable :: &

! 4-d taglist for storing the unique message passing tags for mpi.
! The four dimensions of the taglist are used to index the following:
! Dimension 1 = nsdm (maximum number of subdomains), i.e the global subdomain number.
! Dimension 2 = ncomp, (number of components), represents the sender component.
! Dimension 3 = ncomp, (number of components), represents the receiever component.xaz
! Dimension 4 = flag, 1 indicates the tag is for a mpi 'send', 2 for mpi 'receive'.

      taglist(:,:,:,:), &  

! 3-d process id lists for storing process ids used in mpi sends/receives by each process
! to locate the target process id (in case of a send) and the source process id
! (in case of a receive).
! Dimension 1 = nsdm (maximum number of subdomains), i.e the global subdomain number.
! Dimension 2 = ncomp, (number of components), represents the sender component.
! Dimension 3 = ncomp, (number of components), represents the receiver component.

      send_target_procid_list(:,:,:), &
      recv_src_procid_list(:,:,:)

! flag used in the driver module to test for an SPMD case.
   logical(kind=log_kind), public :: l_spmd

! variables to define intercomponent communications, These will be allocated and defined in the driver
! the dimension is component number
   integer (kind=int_kind), public, allocatable, dimension(:) ::   &
        MPI_COMM_joined,   &    ! joined coupler-component communicators
        numprocs_comp           ! number of processes for components

! process ids in joined communicators
! first dimension is component local process id
! second dimension is component number
   integer (kind=int_kind), public, allocatable, dimension(:,:) :: &

! coupler process ids in joined communicators as function
! of coupler local process id and component id
        procid_cpl_joined, &     

! component process ids in joined communicators as function
! of component local process id and component id
        procid_comp_joined       

! array of process ids within own communicator
! procid_self(i) = i-1
   integer (kind=int_kind), public, allocatable, dimension(:) :: procid_self	
   
   type (sbdmn_assign_type), allocatable, dimension(:) ::          &
        sbdmn_assign_cpl
   type (sbdmn_owner_type), allocatable, dimension(:) ::           &
        sbdmn_owner_cpl	 
        
! maximum number of subdomains owned by any component.
	   integer (kind=int_kind) :: nsdm_max = 0

! buffer to use when there is no message passing - good for the serial case
!   and when send and receive processes are the same (accessible to all 
!   components)
   type sendrecv_buf
      real(kind=dbl_kind), pointer, dimension(:,:,:,:) :: buffer
   end type sendrecv_buf
   
   type (sendrecv_buf), allocatable, dimension(:) :: sr_buf
   
! Here, we build a data type for storing the send and recv subdomains
!   for communications between a pair of processes for a pair of components
! The subscripts are : 1 - source component id (1 - num_comps)
!                      2 - target component id (1 - num_comps)
!                      3 - source process id (0 - num_procs(source component id))
!                      4 - target process id (0 - num_procs(target component id))
!                      5 - send/recv flag
! For many process id pairs there will in fact be no send and recv subdomains.
! init_sendrecv will allocate the array, and initialize the count; 
! generate_taglists will actually compute it.
! send_data and recv_data will use this array.
   type sendrecv_packing_type
      integer (kind=int_kind) ::                                       &
         nsbdmns             ! number of subdomains send in message for
                             !   process id pair
      integer (kind=int_kind), pointer, dimension(:) ::                &
         send_sbdmn,      &  ! indices of send decomposition subdomains and
         recv_sbdmn          ! indices of subdomains on recv decomposition
                             !    for this process id pair
   end type sendrecv_packing_type
   
#if spmd_mode == 0
   type (sendrecv_packing_type), allocatable, dimension(:,:,:,:,:) ::  &
      sendrecv_packing
#endif
  
! public member routines
   public :: send_data,      &
             recv_data,      &	  		
             init_sendrecv,  &	  		
             sbdmn_assign_global,  &	  		
             generate_taglists

!***********************************************************************

      contains

!***********************************************************************


!======================================================================
! BEGINNING OF INIT_SENDRECV
!======================================================================

!-------------------------------------------------------------------------
!     
!     Purpose:
!     To initialize the sendrecv communication environment. 
!     This routine forms all joined communicators and the procids
!     of the components within those communicators
!
!     Author: Don Dazlich (dazlich@atmos.colostate.edu)
!     History
!       2003 Jun 04 - Created; extracted from driver.F
!     
!-------------------------------------------------------------------------
	
	subroutine init_sendrecv

! component name
   character (len=32) :: comp_name, coupler_name
! loop indices and counters
   integer (kind=int_kind) :: n, m, nn, mm
! mph and mpi return status
   integer (kind=int_kind) :: ierr
! dummy communicator
   integer (kind=int_kind) :: comm

!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
!
! form joined communicators,
! There is a joined communicator involving the coupler and every other component
!
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
      allocate(MPI_COMM_joined(num_comp))
      allocate(numprocs_comp(num_comp))

#if mpi == 1
      do n = 2, num_comp
         comp_name = MPH_comp_name (n)
         call MPH_comm_join ("coupler", trim(comp_name), MPI_COMM_joined(n))
      enddo
#else
      mpi_comm_joined(:) = 1
#endif

!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
!
! Find process ids within joined communicators for coupler processes,
!   component processes
! This means going through the components and identifying the rank for that
!   that component's process in the joined communicator. This information must
!   be made known to all processes so we broadcast it. We do this so we can 
!   construct message tags that incorporate the source and destination
!   processors within the joined communicator, and so that it can be done
!   from any component, any process.
! The subscripts are the local process id (+1) and the component number.
! The component number refers to the joined communicator of the coupler with
!   component n, for n=2,...,num_comp.
! For procid_cpl_joined, the local process id is that of the coupler.
! For procic_comp_joined, the local process id is that of the component.
!
! Example: coupler is on global processes 0, 1, 2 and 3
!          ocean is on global processes 2, 3, 4, and 5
!          The joined communicator consists of processes 0 through 5
!          procid_cpl_joined(1:4,3) = 0, 1, 2, 3
!          procid_comp_joined(1:4,3) = 2, 3, 4, 5
! Thus, a message from local coupler process id 0 to local ocean process id, 1
!   is sent from joined communicator process id 0=procid_cpl_joined(1,3)
!   to joined communicator process id 3=proc_comp_joined(2,3)
! (Remember, the local process id subscript value is the local process id + 1;
!  local process ids run from 0,...,numprocs_comp-1)
!
!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
      
      allocate(procid_cpl_joined(ntotprocs,num_comp))
      allocate(procid_comp_joined(ntotprocs,num_comp))
#if mpi == 1
      procid_cpl_joined = -1
      procid_comp_joined = -1
      coupler_name = MPH_comp_name (1)
      do n = 2,num_comp
         comp_name = MPH_comp_name (n)
         nn = 0
         mm = 0
         do m = 1,ntotprocs
            if(my_proc_global == m-1) then
               if(PE_in_component (trim(coupler_name),comm) ) then
                  mm = mm + 1
                  call MPI_COMM_RANK (    &
                     mpi_comm_joined(n), procid_cpl_joined(mm,n), ierr)
               endif
               if(PE_in_component (trim(comp_name),comm) ) then
                  nn = nn + 1
                  call MPI_COMM_RANK (    &
                     mpi_comm_joined(n), procid_comp_joined(nn,n), ierr)
               endif
            endif
            call MPI_BCAST (mm, 1, mpi_int_type, m-1, &
                            MPI_COMM_WORLD, ierr)
            call MPI_BCAST (procid_cpl_joined(mm,n), 1, mpi_int_type, m-1, &
                            MPI_COMM_WORLD, ierr)
            call MPI_BCAST (nn, 1, mpi_int_type, m-1, &
                            MPI_COMM_WORLD, ierr)
            call MPI_BCAST (procid_comp_joined(nn,n), 1, mpi_int_type, m-1, &
                            MPI_COMM_WORLD, ierr)
         enddo
         numprocs_comp(n) = nn
      enddo

! number of coupler processes = number of atmosphere processes
      numprocs_comp(1) = numprocs_comp(2)	  

!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
!
! test for spmd mode
#if spmd_mode == 1
      l_spmd = .true.
#else
      l_spmd = .true.
      do n = 1,num_comp
         m = MPH_local_totprocs(n)
         if(m /= ntotprocs) l_spmd = .false.
      enddo
#endif
      
#else
      procid_cpl_joined = 0
      procid_comp_joined = 0
      numprocs_comp = 1
      l_spmd = .true.
#endif

#if spmd_mode == 0
! allocate the variable with message packing subdomain info
      allocate(sendrecv_packing(num_comp, num_comp, ntotprocs, ntotprocs, 2))

! initialize the subdomain count for every pair to zero - the count will
!   actually be determined in generate taglists
      sendrecv_packing(:,:,:,:,:)%nsbdmns = 0 
#endif

! this is the copy buffer for when communications are on the same process
      allocate(sr_buf(num_comp))

! compute array of process ids within own communicator as function of
! local process id
      allocate(procid_self(ntotprocs))
      do n = 1,ntotprocs
	 procid_self(n) = n-1
      enddo		
	
      end subroutine init_sendrecv


!======================================================================
! END OF INIT_SENDRECV
!======================================================================
!======================================================================
! BEGINNING OF SBDMN_ASSIGN_GLOBAL
!======================================================================

!-------------------------------------------------------------------------
!     
!     Purpose:
!     Store the sbdmn_assign and sbdmn_owner arrays for each component
!     and make them available on all processes
!
!     Author: Don Dazlich (dazlich@atmos.colostate.edu)
!     History:
!        13 Jun 2003 - created this routine, incorporated some of the 
!                      former send_sbdmn and recv_sbdmn routines
!     
!-------------------------------------------------------------------------
	
   subroutine sbdmn_assign_global( nc )

! argument list
   integer (kind=int_kind), intent(in) ::                                  &
      nc     ! component id
   
! local variables
   integer (kind=int_kind) :: local_0   ! first process id in component communicator
   integer (kind=int_kind) :: lengtha   ! length element in sbdmn_assign
   integer (kind=int_kind) :: lengtho   ! length element in sbdmn_owner
   integer (kind=int_kind) :: npe       ! number of processes in the component
   character (len=72) :: comp_name
   TYPE (component_node),POINTER ::                                          &
      current   ! pointer to intra-component communications registration variables
   
   if(.not.allocated(sbdmn_assign_cpl)) allocate(sbdmn_assign_cpl(num_comp))
   if(.not.allocated(sbdmn_owner_cpl))  allocate(sbdmn_owner_cpl(num_comp))
   
      local_0 = -99
#if mpi == 1
      comp_name = MPH_comp_name(nc)
      local_0 = mph_exe_low_proc_limit(nc)
      if(my_proc_global == local_0) then
         current => get_component_pointer( trim(comp_name) )
         lengtha = current%sbdmn_assign%length(1)
         lengtho = current%sbdmn_owner%length
         npe     = current%npe_comp
      endif
      call MPI_BCAST (lengtha, 1, mpi_int_type, local_0,     &
                      MPI_COMM_WORLD, ierr)
      call MPI_BCAST (npe, 1, mpi_int_type, local_0,         &
                      MPI_COMM_WORLD, ierr)
      call MPI_BCAST (lengtho, 1, mpi_int_type, local_0,     &
                      MPI_COMM_WORLD, ierr)
      allocate(sbdmn_assign_cpl(nc)%length(npe))
      allocate(sbdmn_assign_cpl(nc)%sd(npe,lengtha))
      sbdmn_owner_cpl%length = lengtho
      allocate(sbdmn_owner_cpl(nc)%owner(lengtho))
      allocate(sbdmn_owner_cpl(nc)%local_sd(lengtho))
      if(my_proc_global == local_0) then
         sbdmn_assign_cpl(nc)%length = current%sbdmn_assign%length
         sbdmn_assign_cpl(nc)%sd = current%sbdmn_assign%sd
         sbdmn_owner_cpl(nc)%owner = current%sbdmn_owner%owner
         sbdmn_owner_cpl(nc)%local_sd = current%sbdmn_owner%local_sd
      endif
      call MPI_BCAST (sbdmn_assign_cpl(nc)%length(1), npe,            &
                      mpi_int_type, local_0, MPI_COMM_WORLD, ierr)
      call MPI_BCAST (sbdmn_assign_cpl(nc)%sd(1,1), lengtha*npe,      &
                      mpi_int_type, local_0, MPI_COMM_WORLD, ierr)
      call MPI_BCAST (sbdmn_owner_cpl(nc)%owner(1), lengtho,          &
                      mpi_int_type, local_0, MPI_COMM_WORLD, ierr)
      call MPI_BCAST (sbdmn_owner_cpl(nc)%local_sd(1), lengtho,       &
                      mpi_int_type, local_0, MPI_COMM_WORLD, ierr)
      call MPI_barrier ( MPI_COMM_WORLD, ierr)

#else
      current => get_component_pointer( trim(component_name(nc)) )
      lengtha = current%sbdmn_assign%length(1)
      lengtho = current%sbdmn_owner%length
      npe     = current%npe_comp
      allocate(sbdmn_assign_cpl(nc)%length(npe))
      allocate(sbdmn_assign_cpl(nc)%sd(npe,lengtha))
      sbdmn_assign_cpl(nc)%length = current%sbdmn_assign%length
      sbdmn_assign_cpl(nc)%sd = current%sbdmn_assign%sd
      sbdmn_owner_cpl%length = lengtho
      allocate(sbdmn_owner_cpl(nc)%owner(lengtho))
      allocate(sbdmn_owner_cpl(nc)%local_sd(lengtho))
      sbdmn_owner_cpl(nc)%owner = current%sbdmn_owner%owner
      sbdmn_owner_cpl(nc)%local_sd = current%sbdmn_owner%local_sd
#endif

! find the maximum number of subdomains owned by any component
           nsdm_max = max(nsdm_max,sbdmn_owner_cpl(nc)%length) 

   end subroutine sbdmn_assign_global


!======================================================================
! END OF SBDMN_ASSIGN_GLOBAL
!======================================================================

!======================================================================
! BEGINNING OF SEND_DATA
!======================================================================

!-------------------------------------------------------------------------
!     
!     Purpose:
!     Send the actual real floating point data fields 
!     to coupler and components.
!
!     Author: Atul Nulkar
!     History:
!        04 Jun 2003 - simplified the argument list by using
!           component registration utility
!        20 Jun 2003 - pack all subdomains going from one process 
!           to another into one message - dd
!     
!-------------------------------------------------------------------------
	
	subroutine send_data(descr_send, nfields, src_compid, target_compid )

! component ids for sender (source) and receiver (target) component 
           integer (kind=int_kind), intent(in) :: src_compid, target_compid
! number of members in the data descriptor 
           integer (kind=int_kind), intent(in) :: nfields
! the actual data (3-d array) fields being sent
	   type	(cpl_field_desc), intent(in), dimension(nfields) :: descr_send

! local variables 

! pointer to source component registration
           type (component_node), pointer :: comp_node
! process id in the coupler joined communicator (sender's process id)
           integer (kind=int_kind) :: myproc
! joined communicator
           integer (kind=int_kind) :: comm
! number of subdomains owned by the component process
           integer (kind=int_kind) :: nsdm
! total number of horizontal slices in the send data
           integer (kind=int_kind) :: nslices
! slices in each descriptor field
           integer (kind=int_kind) :: nlev(nfields)
! iim, jjm, nsdm, corresponding to the 3 dimensions of the data field.
! 'iim*jjm data' elements are sent to each subdomain represented by nsdm index.
	   integer (kind=int_kind) :: iim, jjm

! non-coupler component component id, modified source componnent id
!     (modified for atmos receiver case)
           integer (kind=int_kind) :: comp_compid, src_sbdmn_id
! component name used to get grid parameters via component registration
           character(len=32) :: comp_name
           integer (kind=int_kind) :: nsdm_count, n, i, k, m, j

#if mpi == 1
! joined commununicator target procid obtained from the proc_{cpl,comp}_joined array.
! send count is equal to the number of messages being sent.
! global subdomain is obtained from the sd field within src_sbdmn_assign and is
! used to locate the tag in the taglist.
	   integer (kind=int_kind) :: joinedcomm_target_procid, send_count, gbl_sdnum
! request and status are MPI associated variables
           integer (kind=int_kind), allocatable :: req(:)
 	   integer (kind=int_kind), allocatable :: status(:,:)

           real (kind=dbl_kind), dimension(:,:,:,:), allocatable ::     &
              buffer    ! the buffer we pack messages into
           logical (kind=log_kind) :: not_same_global_process
#endif

           comp_compid = max(src_compid,target_compid)
	   
! if target is atm, want to use atmos grid values so we get
!    a modified src_comp_id that takes advantage of atm-cpl spmd 
           if(comp_compid == 2) then
              src_sbdmn_id = 2
           else
              src_sbdmn_id = src_compid
           endif
           
! find number of slices in each field, and the total number
           nslices = 0
           do n = 1,nfields
              if(descr_send(n)%nfield_dims == 3) then
                 nlev(n) = 1
              else
                 if(descr_send(n)%grid_loc == 'cent') then
                    nlev(n) = descr_send(n)%field_dim(3)%length
                 elseif(descr_send(n)%grid_loc == 'corn') then
                    nlev(n) = descr_send(n)%field_dim(1)%length
                 endif
              endif
              nslices = nslices + nlev(n)
           enddo

#if (mpi && !spmd_mode)
	   comm = MPI_COMM_joined(comp_compid)
           comp_name = MPH_comp_name(src_sbdmn_id)
           
! initalizations that were formerly arguments
           comp_node => get_component_pointer(trim(comp_name))
           myproc = get_my_task(trim(comp_name))
           iim = comp_node%iim
           jjm = comp_node%jjm

	   allocate(req(numprocs_comp(target_compid)))
	   allocate(status(MPI_STATUS_SIZE, numprocs_comp(target_compid)))
	   req = -1
	   status = -1		
	   send_count = 0

! loop through all target processes and see which ones are receiving data
! Those would be the ones with non-zero nsdm_count
           do n = 1,numprocs_comp(target_compid)
             nsdm_count = sendrecv_packing(src_compid, target_compid, &
                                           myproc+1, n, send)%nsbdmns
                                           
             if(nsdm_count /= 0) then

! put all the subdomains goint to the same target process in one buffer
                allocate(buffer(iim, jjm, nslices, nsdm_count))
                do i = 1,nsdm_count
                   j = 0
                   do m = 1,nfields
                      if(descr_send(m)%nfield_dims == 3) then
                         j = j + 1
                         buffer(:,:,j,i) = descr_send(m)%field_d_2d(:,:,    &
                            sendrecv_packing(src_compid, target_compid,     &
                                             myproc+1, n, send)% send_sbdmn(i) )
                      else
                         if(descr_send(m)%grid_loc == 'cent') then
                            do k = 1,descr_send(m)%field_dim(3)%length
                               j = j + 1
                               buffer(:,:,j,i) = descr_send(m)%field_d_3d(:,:,k,    &
                                  sendrecv_packing(src_compid, target_compid,       &
                                                   myproc+1, n, send)% send_sbdmn(i) )
                            enddo
                         elseif(descr_send(m)%grid_loc == 'corn') then
                            do k = 1,descr_send(m)%field_dim(1)%length
                               j = j + 1
                               buffer(:,:,j,i) = descr_send(m)%field_d_3d(k,:,:,    &
                                  sendrecv_packing(src_compid, target_compid,       &
                                                   myproc+1, n, send)% send_sbdmn(i) )
                            enddo
                         endif
                      endif
                   enddo
                enddo
!                not_same_global_process = .true.
                if(src_compid == 1) then
                   not_same_global_process =                                &
                                procid_cpl_joined(myproc+1,comp_compid)    &
                                  /= procid_comp_joined(n,comp_compid)
                else
                   not_same_global_process =                                &
                                procid_comp_joined(myproc+1,comp_compid)   &
                                   /= procid_cpl_joined(n,comp_compid)
                endif
                
! Send the data field in an mpi message if it is not going to the 
!     same global process
                if(not_same_global_process) then

! Find the global sdnumber of the first subdomain packed - tag and
!   send_target_procid_list for any sbdmn packed into this message.
	           gbl_sdnum = sbdmn_assign_cpl(src_sbdmn_id)%sd(myproc+1, &
                       sendrecv_packing(src_compid, target_compid,         &
                                        myproc+1, n, send)%send_sbdmn(1) )

! locate the tag using the global subdomain number, and source/target component ids.
                   tag = taglist(gbl_sdnum, src_compid, target_compid, send)
 
! locate the joined communicator target process id from 
!    the send proc id list to use with MPI_Isend
	           joinedcomm_target_procid =                        &
	              send_target_procid_list(gbl_sdnum,src_compid,target_compid) 	

                   send_count = send_count + 1 
	           call MPI_Isend( buffer,               &
                 	           iim*jjm*nslices*nsdm_count, 	 &
                                   mpi_float_type,       &
                                   joinedcomm_target_procid,     &
                                   tag, 	         &
                                   comm,                 &
                                   req(send_count),      &
                                   ierr )
                else
! this is going to the same global process, copy data to the
!   a globally available buffer
                   allocate(sr_buf(comp_compid)%buffer(iim,jjm,nslices,nsdm_count))
                   sr_buf(comp_compid)%buffer = buffer
                endif
                deallocate(buffer)
             endif 
           enddo
	   CALL MPI_WAITALL (send_count,req,status,ierr)

           deallocate(req)
	   deallocate(status)
           
#else
! This is the serial (spmd implied) case - no message passing, we use
!   a buffer

! we reference the sendrecv buffer by the non-coupler component id
           comp_name = component_name(src_sbdmn_id)
           
! find some grid parameters and copy the send data into the global buffer
           comp_node => get_component_pointer(trim(comp_name))
           iim = comp_node%iim
           jjm = comp_node%jjm
           nsdm = sbdmn_assign_cpl(comp_compid)%length(1)
           allocate(sr_buf(comp_compid)%buffer(iim,jjm,nslices,nsdm))
           j = 0
           do m = 1,nfields
              if(descr_send(m)%nfield_dims == 3) then
                 j = j + 1
                 sr_buf(comp_compid)%buffer(:,:,j,:) =               &
                        descr_send(m)%field_d_2d(:,:,: )
              else
                 if(descr_send(m)%grid_loc == 'cent') then
                    do k = 1,descr_send(m)%field_dim(3)%length
                       j = j + 1
                       sr_buf(comp_compid)%buffer(:,:,j,:) =            &
                           descr_send(m)%field_d_3d(:,:,k,: )
                    enddo
                 elseif(descr_send(m)%grid_loc == 'corn') then
                    do k = 1,descr_send(m)%field_dim(1)%length
                       j = j + 1
                       sr_buf(comp_compid)%buffer(:,:,j,:) =            &
                           descr_send(m)%field_d_3d(k,:,:,: )
                    enddo
                 endif
              endif
           enddo
#endif
		    
	end subroutine send_data


!======================================================================
! END OF SEND_DATA
!======================================================================
	   	

!======================================================================
! BEGINNING OF RECV_DATA
!======================================================================

!-------------------------------------------------------------------------
!     
!     Purpose:
!     Coupler and Components receive the actual real floating point 
!     data fields from each other.
!
!     Author: Atul Nulkar
!     History:
!        04 Jun 2003 - simplified the argument list by using
!           component registration utility
!        20 Jun 2003 - pack all subdomains going from one process 
!           to another into one message - dd
!     
!-------------------------------------------------------------------------


	subroutine recv_data(descr_recv, nfields, src_compid, target_compid )

! component ids for sender (source) and receiver (target) component 
           integer (kind=int_kind), intent(in) :: src_compid, target_compid
! number of members in the data descriptor 
           integer (kind=int_kind), intent(in) :: nfields
! the actual data (3-d array) fields being received
	   type	(cpl_field_desc), intent(inout), dimension(nfields) :: descr_recv

! local variables 

! pointer to source component registration
           type (component_node), pointer :: comp_node
! process id in the coupler joined communicator (sender's process id)
           integer (kind=int_kind) :: myproc
! joined communicator
           integer (kind=int_kind) :: comm
! number of subdomains owned by the component process
           integer (kind=int_kind) :: nsdm
! total number of horizontal slices in the received data descriptor
           integer (kind=int_kind) :: nslices
! slices in each descriptor field
           integer (kind=int_kind) :: nlev(nfields)
! iim, jjm, nsdm, corresponding to the 3 dimensions of the data field.
! 'iim*jjm data' elements are sent to each subdomain represented by nsdm index.
	   integer (kind=int_kind) :: iim, jjm

! non-coupler component component id, modified target componnent id
!     (modified for atmos receiver case)
           integer (kind=int_kind) :: comp_compid, targ_sbdmn_id
! component name used to get grid parameters via component registration
           character(len=32) :: comp_name
           integer (kind=int_kind) :: nsdm_count, n, i, k, m, j

#if mpi == 1
! joined commununicator source procid obtained from the proc_{cpl,comp}_joined array.
! send count is equal to the number of messages being sent.
! global subdomain is obtained from the sd field within src_sbdmn_assign and is
! used to locate the tag in the taglist.
	   integer (kind=int_kind) :: joinedcomm_source_procid, recv_count, gbl_sdnum
! request and status are MPI associated variables
           integer (kind=int_kind), allocatable :: req(:)
 	   integer (kind=int_kind), allocatable :: status(:,:)

           real (kind=dbl_kind), dimension(:,:,:,:), allocatable ::     &
              buffer    ! the buffer we pack messages into
           logical (kind=log_kind) :: not_same_global_process
           integer (kind=int_kind) :: nsdm_beg, nsdm_end
#endif

           comp_compid = max(src_compid,target_compid)
! if target is atm, want to use atmos grid values so we get
!    a modified src_comp_id that takes advantage of atm-cpl spmd 
           if(comp_compid == 2) then
              targ_sbdmn_id = 2
           else
              targ_sbdmn_id = target_compid
           endif

! find number of slices in each field, and the total number
           nslices = 0
           do n = 1,nfields
              if(descr_recv(n)%nfield_dims == 3) then
                 nlev(n) = 1
              else
                 if(descr_recv(n)%grid_loc == 'cent') then
                    nlev(n) = descr_recv(n)%field_dim(3)%length
                 elseif(descr_recv(n)%grid_loc == 'corn') then
                    nlev(n) = descr_recv(n)%field_dim(1)%length
                 endif
              endif
              nslices = nslices + nlev(n)
           enddo

#if (mpi && !spmd_mode)
	   comm = MPI_COMM_joined(comp_compid)
           comp_name = MPH_comp_name(targ_sbdmn_id)
           
! initalizations that were formerly arguments
           comp_node => get_component_pointer(trim(comp_name))
           myproc = get_my_task(trim(comp_name))
           iim = comp_node%iim
           jjm = comp_node%jjm
           nsdm = 5*comp_node%isdm*comp_node%jsdm/comp_node%npe_comp

	   allocate(req(numprocs_comp(src_compid)))
	   allocate(status(MPI_STATUS_SIZE, numprocs_comp(src_compid)))
	   req = -1
	   status = -1		
	   recv_count = 0

! loop through all target processes and see which ones are receiving data
! Those would be the ones with non-zero nsdm_count
           allocate(buffer(iim, jjm, nslices,nsdm))
           nsdm_end = 0
           do n = 1,numprocs_comp(src_compid)
             nsdm_count = sendrecv_packing(src_compid, target_compid, &
                                           n, myproc+1, recv)%nsbdmns
                                           
             if(nsdm_count /= 0) then
                nsdm_end = nsdm_end + nsdm_count
                nsdm_beg = nsdm_end - nsdm_count + 1

! put all the subdomains going to the same target process in one buffer
!                not_same_global_process = .true.
                if(src_compid == 1) then
                   not_same_global_process =                                &
                                procid_comp_joined(myproc+1,comp_compid)   &
                                   /= procid_cpl_joined(n,comp_compid)
                else
                   not_same_global_process =                                &
                                procid_cpl_joined(myproc+1,comp_compid)    &
                                  /= procid_comp_joined(n,comp_compid)
                endif
                
!recv the data field in an mpi message if it is not coming from the 
!     same global process
                if(not_same_global_process) then

! Find the global sdnumber of the first subdomain packed - tag and
!   send_target_procid_list for any sbdmn packed into this message.
	           gbl_sdnum = sbdmn_assign_cpl(targ_sbdmn_id)%sd(myproc+1, &
                       sendrecv_packing(src_compid, target_compid,          &
                                        n, myproc+1, recv)%recv_sbdmn(1) )

! locate the tag using the global subdomain number, and source/target component ids.
                   tag = taglist(gbl_sdnum, src_compid, target_compid, recv)
 
! locate the joined communicator target process id from 
!    the send proc id list to use with MPI_Isend
	           joinedcomm_source_procid =                        &
	              recv_src_procid_list(gbl_sdnum,src_compid,target_compid) 	

                   recv_count = recv_count + 1 
	           call MPI_Irecv( buffer(1,1,1,nsdm_beg),               &
                 	           iim*jjm*nslices*nsdm_count, 	 &
                                   mpi_float_type,       &
                                   joinedcomm_source_procid,     &
                                   tag, 	         &
                                   comm,                 &
                                   req(recv_count),      &
                                   ierr )
                else
! this is going to the same global process, copy data from the
!   a globally available buffer
                   buffer(:,:,:,nsdm_beg:nsdm_end) =              &
                            sr_buf(comp_compid)%buffer(:,:,:,1:nsdm_count)
                   deallocate (sr_buf(comp_compid)%buffer)
                endif
             endif 
           enddo
	   CALL MPI_WAITALL (recv_count,req,status,ierr)
	   nsdm_end = 0
           do n = 1,numprocs_comp(src_compid)
             nsdm_count = sendrecv_packing(src_compid, target_compid, &
                                           n, myproc+1, recv)%nsbdmns
                                           
             if(nsdm_count /= 0) then
                nsdm_end = nsdm_end + nsdm_count
                nsdm_beg = nsdm_end - nsdm_count + 1
                do i = 1,nsdm_count      
                   j = 0
                   do m = 1,nfields
                      if(descr_recv(m)%nfield_dims == 3) then
                         j = j + 1  
                         descr_recv(m)%field_d_2d(:,:,                      &
                            sendrecv_packing(src_compid, target_compid,     &
                                       n, myproc+1, recv)% recv_sbdmn(i) )  &
                                       =  buffer(:,:,j,i+nsdm_beg-1)
                      else
                         if(descr_recv(m)%grid_loc == 'cent') then
                            do k = 1,descr_recv(m)%field_dim(3)%length
                               j = j + 1
                               descr_recv(m)%field_d_3d(:,:,k,                      &
                                  sendrecv_packing(src_compid, target_compid,       &
                                             n, myproc+1, recv)% recv_sbdmn(i) )    &
                                          =  buffer(:,:,j,i+nsdm_beg-1)
                            enddo
                         elseif(descr_recv(m)%grid_loc == 'corn') then
                            do k = 1,descr_recv(m)%field_dim(1)%length
                               j = j + 1
                               descr_recv(m)%field_d_3d(k,:,:,                      &
                                  sendrecv_packing(src_compid, target_compid,       &
                                             n, myproc+1, recv)% recv_sbdmn(i) )    &
                                          =  buffer(:,:,j,i+nsdm_beg-1)
                            enddo
                         endif
                      endif
                   enddo
                enddo
             endif
           enddo
           deallocate(buffer)

           deallocate(req)
	   deallocate(status)
           
#else
! This is the serial (spmd implied) case - no message passing, we use
!   a buffer

! we reference the sendrecv buffer by the non-coupler component id

           comp_name = component_name(targ_sbdmn_id)
           
! find some grid parameters and copy the send data into the global buffer
           comp_node => get_component_pointer(trim(comp_name))
           iim = comp_node%iim
           jjm = comp_node%jjm
           j = 0
           do m = 1,nfields
              if(descr_recv(m)%nfield_dims == 3) then
                 j = j + 1
                 descr_recv(m)%field_d_2d(:,:,: ) =                  &
                       sr_buf(comp_compid)%buffer(:,:,j,:)
              else
                 if(descr_recv(m)%grid_loc == 'cent') then
                    do k = 1,descr_recv(m)%field_dim(3)%length
                       j = j + 1
                       descr_recv(m)%field_d_3d(:,:,k,: ) =             &
                             sr_buf(comp_compid)%buffer(:,:,j,:)
                    enddo
                 elseif(descr_recv(m)%grid_loc == 'corn') then
                    do k = 1,descr_recv(m)%field_dim(1)%length
                       j = j + 1
                       descr_recv(m)%field_d_3d(k,:,:,: ) =             &
                             sr_buf(comp_compid)%buffer(:,:,j,:)
                    enddo
                 endif
              endif
           enddo
           deallocate (sr_buf(comp_compid)%buffer)
#endif
            
	end subroutine recv_data


!======================================================================
! END OF RECV_DATA
!======================================================================
	   	

!======================================================================
! BEGINNING OF GENERATE_TAGLISTS
!======================================================================

!-------------------------------------------------------------------------
!     
!     Purpose:
!     This routine contains code to generate taglists and send/recv
!     process id lists that store unique tags and process ids used for 
!     message passing.
!
!     Author: Atul Nulkar and Don Dazlich
!     History:
!        04 Jun 2003 - simplified the argument list by using
!           component registration utility
!   
!-------------------------------------------------------------------------


	subroutine generate_taglists(msgtype, src_compid, target_compid, &
				     src_comp_name, target_comp_name )

! component ids for sender (source) and receiver (target) component 
           integer (kind=int_kind), intent(in) :: src_compid, target_compid
! message type is either a 'send' or a 'recv' to store the tags in the taglist. 
	   integer (kind=int_kind), intent(in) :: msgtype
! source and target component names
           character(*), intent(in) :: src_comp_name, target_comp_name


! local variables
! array of process ids within own communicator (sender's)
           integer (kind=int_kind), dimension(:), allocatable :: lcl_src_procs
! array of process ids within own communicator (receiver's)
           integer (kind=int_kind), dimension(:), allocatable :: lcl_target_procs
! loop indices
           integer (kind=int_kind) :: ii, jj, ksdm,isrc_proc, itarg_proc, n 
! temporary variables:
! global subdomain number, local target process id, number of components,
! and number of subdomains owned by the source component on a process
	   integer (kind=int_kind) :: global_sdnum, lcl_target_procid, nsdm
! component name
           character(len=32) :: comp_name
! pointer to source and target component registrations
           type (component_node), pointer :: comp_node
! number of source (sender) processes, number of target (receiver) processes.
           integer (kind=int_kind) :: nsrc_procs, ntarget_procs
! the local process id and component id
           integer (kind=int_kind) :: myproc, my_compid, comp_compid
! adjusted source and target component ids for atm-cpl case
           integer (kind=int_kind) :: src_compid_tem, target_compid_tem
! coupler process ids in joined communicators component process ids in joined communicators
! passed in, according to whether the tag is a send or a receive tag.
	   integer (kind=int_kind), allocatable :: src_procid_list(:), target_procid_list(:)

! variables to be used to determine the subdomain packing for messates
           integer (int_kind) :: tem_count, tem_tag, i
           integer (int_kind), allocatable, dimension(:) ::           &
              tem_send_sbdmn, tem_recv_sbdmn


! identify the component id of the non-coupler component
           comp_compid = max(src_compid, target_compid)  ! the non-coupler component id

! if the non-coupler component is the atmos (atmos-cpl are spdm) then assign
!   atmos value of compid and component name to both source and target because
!   atmos-coupler communications are on identical grids and resolutions and the 
!   'coupler' values are for the coupler version of the sfc grid
           if(comp_compid == 2) then
              comp_name = component_name(2)
              src_compid_tem = 2
              target_compid_tem = 2
              comp_node => get_component_pointer(comp_name)
           else
              src_compid_tem = src_compid
              target_compid_tem = target_compid
              if(msgtype == send) then
                 comp_node => get_component_pointer(src_comp_name)
              else
                 comp_node => get_component_pointer(target_comp_name)
              endif
           endif

! this code associated source and target variables with local and remote components
! it also identifies the local and remote coupler component cases
           if(msgtype == send) then
              my_compid = src_compid_tem
              myproc = comp_node%my_task
              nsrc_procs = 1
#if mpi == 1
              ntarget_procs = MPH_local_totProcs(target_compid_tem)
#else
              ntarget_procs = 1
#endif
           else
              my_compid = target_compid_tem
              myproc = comp_node%my_task
#if mpi == 1
              nsrc_procs = MPH_local_totProcs(src_compid_tem)
#else
              nsrc_procs = 1
#endif
              ntarget_procs = 1
           endif
           allocate(lcl_src_procs(nsrc_procs))
           allocate(lcl_target_procs(ntarget_procs))
           allocate(src_procid_list(ntotprocs))
           allocate(target_procid_list(ntotprocs))
           if(msgtype == send) then
              lcl_src_procs(1) = procid_self(myproc+1)
              lcl_target_procs(1:ntarget_procs) = procid_self(1:ntarget_procs)
              if(my_compid == 1) then   ! local coupler
                 src_procid_list = procid_cpl_joined(:,comp_compid)
                 target_procid_list = procid_comp_joined(:,comp_compid)
              else                      ! remote coupler
                 src_procid_list = procid_comp_joined(:,comp_compid)
                 target_procid_list = procid_cpl_joined(:,comp_compid)
              endif
           else
              lcl_src_procs(1:nsrc_procs) = procid_self(1:nsrc_procs)
              lcl_target_procs(1) = procid_self(myproc+1)
              if(my_compid == 1) then   ! local coupler
                 src_procid_list = procid_comp_joined(:,comp_compid)
                 target_procid_list = procid_cpl_joined(:,comp_compid)
              else                      ! remote coupler
                 src_procid_list = procid_cpl_joined(:,comp_compid)
                 target_procid_list = procid_comp_joined(:,comp_compid)
              endif
           endif

! original initializations
	   nsdm = sbdmn_assign_cpl(src_compid_tem)%length(1)

! allocate space for all lists
  
	      if (.NOT. ALLOCATED(taglist)) then
		 allocate (taglist(nsdm_max, num_comp, num_comp, 2))
		 taglist = -1
	      endif
	      if (.NOT. ALLOCATED(send_target_procid_list)) then
		 allocate (send_target_procid_list(nsdm_max, num_comp, num_comp))
		 send_target_procid_list = -1
	      endif 

	      if (.NOT. ALLOCATED(recv_src_procid_list)) then
		 allocate (recv_src_procid_list(nsdm_max, num_comp, num_comp))
 		 recv_src_procid_list = -1
	      endif

! Algorithm to build the taglists and send/recv process if lists.
           
	      do isrc_proc = 1, nsrc_procs	
                 do ksdm=1, nsdm
	            global_sdnum = sbdmn_assign_cpl(src_compid_tem)%sd(lcl_src_procs(isrc_proc)+1,ksdm)
		    lcl_target_procid = sbdmn_owner_cpl(target_compid_tem)%owner(global_sdnum)
		    do itarg_proc = 1, ntarget_procs
		       if(lcl_target_procid == lcl_target_procs(itarg_proc)) then
  	 		  call generate_message_tag(src_compid, lcl_src_procs(isrc_proc), target_compid, &
						    lcl_target_procid)
			  if (msgtype == send) then
		 	       send_target_procid_list(global_sdnum, src_compid, target_compid) &
						       = target_procid_list(lcl_target_procid+1)
			       recv_src_procid_list(global_sdnum, src_compid, target_compid) &
						       = src_procid_list(lcl_src_procs(isrc_proc)+1)
			  else
 		 	       send_target_procid_list(global_sdnum, src_compid, target_compid) &
						       = target_procid_list(lcl_target_procid+1)
			       recv_src_procid_list(global_sdnum, src_compid, target_compid) &
						       = src_procid_list(lcl_src_procs(isrc_proc)+1) 
			  endif	  	      			
		 	  taglist(global_sdnum, src_compid, target_compid, msgtype) = tag
		       endif
		    enddo	
	         enddo
	      enddo	    

#if spmd_mode == 0
! using the information encoded in the tags find the number of subdomains
!    that will be in one message, and their subscrips
        do isrc_proc = 1,nsrc_procs
           do itarg_proc = 1,ntarget_procs
              if( sendrecv_packing(src_compid, target_compid,               &
                                   lcl_src_procs(isrc_proc)+1,              &
                                   lcl_target_procs(itarg_proc)+1,          &
                                   msgtype)%nsbdmns == 0 ) then
                 allocate(tem_send_sbdmn(nsdm_max))
                 allocate(tem_recv_sbdmn(nsdm_max))
                 tem_count = 0
                 do i = 1, nsdm_max
                    tem_tag = taglist(i, src_compid, target_compid, msgtype)
                    if(src_compid == subintegerstring(tem_tag,4)    .and. &
                       target_compid == subintegerstring(tem_tag,2) .and. &
                       lcl_src_procs(isrc_proc) ==                          &
                                        subintegerstring(tem_tag,3) .and. &
                       lcl_target_procs(itarg_proc) ==                      &
                                        subintegerstring(tem_tag,1) ) then
                       tem_count = tem_count + 1
                       tem_send_sbdmn(tem_count) =                          &
                          sbdmn_owner_cpl(src_compid_tem)%local_sd(i)
                       tem_recv_sbdmn(tem_count) =                          &
                          sbdmn_owner_cpl(target_compid_tem)%local_sd(i)
                    endif
                 enddo
                 allocate(sendrecv_packing(src_compid, target_compid,       &
                          lcl_src_procs(isrc_proc)+1,                       &
                          lcl_target_procs(itarg_proc)+1,                   &
                          msgtype)%send_sbdmn(tem_count) )
                 allocate(sendrecv_packing(src_compid, target_compid,       &
                          lcl_src_procs(isrc_proc)+1,                       &
                          lcl_target_procs(itarg_proc)+1,                   &
                          msgtype)%recv_sbdmn(tem_count) )
                 sendrecv_packing(src_compid, target_compid,                &
                          lcl_src_procs(isrc_proc)+1,                       &
                          lcl_target_procs(itarg_proc)+1,                   &
                          msgtype)%nsbdmns = tem_count
                 sendrecv_packing(src_compid, target_compid,                &
                          lcl_src_procs(isrc_proc)+1,                       &
                          lcl_target_procs(itarg_proc)+1,                   &
                          msgtype)%send_sbdmn(1:tem_count) =                &
                                       tem_send_sbdmn(1:tem_count)
                 sendrecv_packing(src_compid, target_compid,                &
                          lcl_src_procs(isrc_proc)+1,                       &
                          lcl_target_procs(itarg_proc)+1,                   &
                          msgtype)%recv_sbdmn(1:tem_count) =                &
                                       tem_recv_sbdmn(1:tem_count)
                 deallocate(tem_send_sbdmn)
                 deallocate(tem_recv_sbdmn)
              endif
           enddo
        enddo
#endif

        deallocate(lcl_src_procs)        
        deallocate(lcl_target_procs)        
        deallocate(src_procid_list)        
        deallocate(target_procid_list)        

	end subroutine generate_taglists


!======================================================================
! END OF GENERATE_TAGLISTS
!======================================================================
	   	

!======================================================================
! BEGINNING OF GENERATE_MESSAGE_TAG
!======================================================================

!-------------------------------------------------------------------------
!     
!     Purpose:
!     This routine is responsible for generating a unique message tag
!     using information passed by the generate_taglists routine.
!
!     Author: Atul Nulkar
!
!     Modified for message packing - 20 Jun 2003 - dd
!     
!-------------------------------------------------------------------------


	subroutine generate_message_tag(src_comp_id, src_proc_id, target_comp_id, &
					target_proc_id)

! source component ID (sender)
	    integer (kind=int_kind), intent(in) :: src_comp_id
! source component process (sender's process#)
	    integer (kind=int_kind), intent(in) :: src_proc_id
! target component ID (receiver)
 	    integer (kind=int_kind), intent(in) :: target_comp_id
! target component process (receiver's process#)
	    integer (kind=int_kind), intent(in) :: target_proc_id

! Tag = target_procid + ntotprocs*( (target_compid-1) + num_comp*( src_procid + ntotprocs*(src_comp_id-1) )))

! message tag generation... 

    tag = target_proc_id + ntotprocs*( (target_comp_id-1) +     &
                      num_comp*( src_proc_id + ntotprocs*(src_comp_id-1) ) ) 
	
	end subroutine generate_message_tag


!======================================================================
! END OF GENERATE_MESSAGE_TAG
!======================================================================

!======================================================================
! BEGINNING OF SUBINTEGERSTRING
!======================================================================

!-------------------------------------------------------------------------
!     
!     Purpose:
!     This function returns an integer extracte from specified digits\
!        from specified digits of an input integer
!
!     HISTORY
!        20 Jun 2003 - Created this function
!            Author - Don Dazlich (dazlich@atmos.colostate.edu)
!        23 Sep 2009 - modified this routine do to the inverse of the new
!                      tag formula used by generate_message_tag. Argument list
!                      is changed.
!     
!-------------------------------------------------------------------------


	function subintegerstring(orig_int, flag)   &
                                  result (new_int)

! input integer (tag) from which we wish to extract a sub-integer
	    integer (kind=int_kind), intent(in) :: orig_int
! flag to determine which part of tag string we want
!    1 - target_proc_id
!    2 - target_comp_id
!    3 - src_proc_id
!    4 - src_comp_id
	    integer (kind=int_kind), intent(in) :: flag

! This function does the inverse of generate_message_tag generated
! Tag = target_procid + ntotprocs*( (target_compid-1) + num_comp*( src_procid + ntotprocs*(src_comp_id-1) )))

! output result	    
 	    integer (kind=int_kind) :: new_int

! local variables
        integer (kind=int_kind) :: tem_int1, tem_int2
            
! get src_comp_id
        tem_int1 = orig_int
        tem_int2 = tem_int1/(ntotprocs*ntotprocs*num_comp)
        new_int = tem_int2 + 1

        if(flag < 4) then
! get src_proc_id
           tem_int1 = tem_int1 - tem_int2 * ntotprocs*ntotprocs*num_comp
           tem_int2 = tem_int1/( ntotprocs*num_comp)
           new_int = tem_int2
        endif

        if(flag < 3) then
! get targ_comp_id
           tem_int1 = tem_int1 - tem_int2 * ntotprocs*num_comp
           tem_int2 = tem_int1/( ntotprocs)
           new_int = tem_int2 + 1
        endif

        if(flag < 2) then
! get targ_proc_id
           tem_int1 = tem_int1 - tem_int2 * ntotprocs
           new_int = tem_int1
        endif
            
	end function SUBINTEGERSTRING


!======================================================================
! END OF SUBINTEGERSTRING
!======================================================================

end module sendrecv
