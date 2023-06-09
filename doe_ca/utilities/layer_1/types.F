   MODULE types
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  PURPOSE:  define types used by more than one module
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   USE kinds

   IMPLICIT NONE
   SAVE
   PRIVATE
   
!~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
!  types used in assign_owner
!~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
   TYPE, public :: sbdmn_assign_type
      INTEGER (KIND=int_kind), POINTER :: length(:)
      INTEGER (KIND=int_kind), POINTER :: sd(:,:)
   END TYPE sbdmn_assign_type
   TYPE, public :: sbdmn_owner_type
      INTEGER (KIND=int_kind) :: length
      INTEGER (KIND=int_kind), POINTER :: owner(:)
      INTEGER (KIND=int_kind), POINTER :: local_sd(:)
   END TYPE sbdmn_owner_type

!~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
!  types used in wrap_data
!~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
   TYPE, public :: send_node
      INTEGER (KIND=int_kind) ::                                             &
         msg_tag,nsd_dest,i_start,j_start,di,dj,msg_length
      INTEGER (KIND=int_kind) ::                                             &
         task,nsd_local
      TYPE (recv_node),POINTER ::                                            &
         instr_recv
      TYPE (send_node),POINTER ::                                            &
          next
   END TYPE send_node
   
   TYPE, public :: recv_node
      INTEGER (KIND=int_kind) ::                                             &
         msg_tag,nsd_sour,i_start,j_start,di,dj,msg_length
      INTEGER (KIND=int_kind) ::                                             &
         task,nsd_local
      TYPE (send_node),POINTER ::                                            &
         instr_send
      INTEGER (KIND=int_kind) ::                                             &
         unpack_vrtx(3,2),unpack_edge(3,3)
      TYPE (recv_node),POINTER ::                                            &
         next
   END TYPE recv_node

   TYPE, public :: message_instructions
      TYPE (send_node), POINTER :: send
      TYPE (send_node), POINTER :: send_current

      TYPE (recv_node), POINTER :: recv
      TYPE (recv_node), POINTER :: recv_current
   END TYPE message_instructions

!------------------------------------------------------------------------------
!   define qp type (probably move to types.F when we finalize the structure)
!------------------------------------------------------------------------------
    type, public :: qp_type
       integer (kind=int_kind) :: itag
       character (len=30) :: name
       character (len=30) :: units, altunits
       character (len=80) :: descr
       character (len=3) :: category
       integer (kind=int_kind) :: nsamples
       logical (kind=log_kind) :: log
       logical (kind=log_kind) :: amip_sampling
       real (kind=real_kind) :: multfac, contmin, contint
       real (kind=real_kind), pointer :: qp2_data(:,:,:)
       real (kind=real_kind), pointer :: qp3_data(:,:,:,:)
     end type

!------------------------------------------------------------------------------
!   define pbp type 
!------------------------------------------------------------------------------
    type, public :: pbp_type
       integer (kind=int_kind) :: itag
       character (len=30) :: name
       character (len=30) :: units
       character (len=80) :: descr
       character (len=3) :: category
       integer (kind=int_kind) :: nsamples
       logical (kind=log_kind) :: log
       real (kind=real_kind), pointer :: pbp1_data(:)
       real (kind=real_kind), pointer :: pbp2_data(:,:)
     end type

     type, public :: pbploc_type
       integer (kind=int_kind), pointer, dimension(:) ::   &
          kijlen,     &  ! number of pbp cells each subdomain
          koffsetpbp, &  ! tot number of pbp cells prior to this subdomain
          ipbploc,    &  ! i index of pbp cell
          jpbploc,    &  ! j index of pbp cell
          ksdmpbploc     ! ksdm index of pbp cell
     end type


   END MODULE types
!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
