   MODULE wrap_data
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  PURPOSE:  perform boundary updates of ghost cell along edges 
!            of subdomain blocks
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   USE kinds
   USE types
   USE component_intra

   IMPLICIT NONE
   SAVE
   PRIVATE

   TYPE face_type
      INTEGER (KIND=int_kind) ::                                             &
         face_name
      INTEGER (KIND=int_kind) ::                                             &
         nghbr_total
      INTEGER (KIND=int_kind) ::                                             &
         nghbr(6)
      INTEGER (KIND=int_kind) ::                                             &
         vertex(3,2),edge(2,3)
      INTEGER (KIND=int_kind) ::                                             &
         subdomain
   END TYPE face_type

   PUBLIC ::                                                                 &
      initialize_wrap,wrap

   CONTAINS
!=======================================================================
!  BEGIN  initialize_wrap
!=======================================================================
   SUBROUTINE initialize_wrap (component_name)
!.......................................................................
!  INTENT IN
!.......................................................................
   CHARACTER (LEN=*),INTENT ( IN) ::                                         &
      component_name
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) ::                                                &
      im,jm,iim,jjm,isdm,jsdm,nsdm_glbl,                                     &
      npe_comp,nsd,tag_counter,task,nsdm, length, nn, l, lb, le, n,   &
      jsdm_init, partition_factor
   TYPE (message_instructions),POINTER ::                                    &
      msg_instr(:)
   TYPE (face_type),POINTER ::                                               &
      face(:,:),face1(:,:,:),face2(:,:,:)
   TYPE (component_node),POINTER ::                                          &
      current
!.......................................................................

   current => get_component_pointer (component_name)

! if SCM then return
   IF (current%max_ig == 1) RETURN

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  PREPARE face, face1 and face2
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   im   = current%im;   jm   = current%jm
   iim  = current%iim;  jjm  = current%jjm
   isdm = current%isdm; jsdm = current%jsdm; nsdm_glbl = 5*isdm*jsdm
   
   npe_comp = current%npe_comp_wrap
   
   if(current%my_task_wrap < 0)return
!find partition factor given jsdm
    jsdm_init = current%jsdm
    partition_factor = 1
    do while (jsdm_init .ne. 1)
      jsdm_init = jsdm_init / 2
      partition_factor = partition_factor + 1
    end do
    
!    if(current%max_level<max(3,partition_factor)) then
    if(nsdm_glbl == 10) then
               ALLOCATE (current%sbdmn_assign_wrap%length(npe_comp))
               ALLOCATE (current%sbdmn_assign_wrap%sd(npe_comp,10))
               DO task = 0,npe_comp-1
                  if(task == 0) then
                     current%sbdmn_assign_wrap%length(task+1) = 10
                     DO nsd = 1,10
                        current%sbdmn_assign_wrap%sd(task+1,nsd) = nsd
                     ENDDO
                  else
                     current%sbdmn_assign_wrap%length(task+1) = 0
                     DO nsd = 1,10
                        current%sbdmn_assign_wrap%sd(task+1,nsd) = -99
                     ENDDO
                  endif
               ENDDO
    else
      l = current%sbdmn_assign%length(1)
      length = current%sbdmn_assign%length(1) * current%npe_comp_gath
      ALLOCATE (current%sbdmn_assign_wrap%length(npe_comp) )
      ALLOCATE (current%sbdmn_assign_wrap%sd(npe_comp,length) )
      current%sbdmn_assign_wrap%length(:) = length
      do n = 1,npe_comp
        do task = 1,current%npe_comp_gath
          nn = task + (n-1) * current%npe_comp_gath
          le = task * l
          lb = (le - l) + 1
          current%sbdmn_assign_wrap%sd(n,lb:le) = current%sbdmn_assign%sd(nn,1:l)
        enddo
      enddo
    endif

   ALLOCATE (face(im,jm),face1(iim,jjm,nsdm_glbl),face2(iim,jjm,nsdm_glbl))

   CALL set_connections (im,jm,face(:,:))
   CALL set_subdomain_number (im,jm,isdm,jsdm,face(:,:))
   CALL set_face1_face2 (im,jm,isdm,jsdm,iim,jjm,nsdm_glbl,                  &
                                    face(:,:),face1(:,:,:),face2(:,:,:))
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  PREPARE msg_instr
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ALLOCATE (msg_instr(nsdm_glbl))

   DO nsd = 1,nsdm_glbl
      ALLOCATE (msg_instr(nsd)%send,msg_instr(nsd)%recv)
      NULLIFY (msg_instr(nsd)%send%next)
      NULLIFY (msg_instr(nsd)%recv%next)
      msg_instr(nsd)%send_current => msg_instr(nsd)%send
      msg_instr(nsd)%recv_current => msg_instr(nsd)%recv
   ENDDO

   tag_counter = 0
   CALL set_row_column_messages (iim,jjm,nsdm_glbl,tag_counter,              &    
                                 face1(:,:,:),face2(:,:,:),msg_instr(:))
   CALL set_diagonal_messages (isdm,jsdm,iim,jjm,nsdm_glbl,tag_counter,      &
                                 face1(:,:,:),face2(:,:,:),msg_instr(:))
   CALL set_pole_messages (isdm,jsdm,iim,jjm,nsdm_glbl,tag_counter,          &
                                                           msg_instr(:))

   CALL trim_messages (nsdm_glbl,msg_instr(:))
   CALL set_parallel_structure (npe_comp,nsdm_glbl,                          &
                                      current%sbdmn_assign_wrap,msg_instr(:))
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  PREPARE task_instr
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ALLOCATE (current%task_instr(npe_comp,npe_comp))

   CALL set_task_instr (npe_comp,nsdm_glbl,                                  &
                                   msg_instr(:),current%task_instr(:,:))

   ALLOCATE (current%total_send_length(npe_comp,npe_comp),                   &
             current%total_recv_length(npe_comp,npe_comp))
   CALL set_total_length (npe_comp,current%task_instr(:,:),                  &
                                         current%total_send_length(:,:),     &
                                         current%total_recv_length(:,:))

   DEALLOCATE (msg_instr,face,face1,face2)

   END SUBROUTINE initialize_wrap
!=======================================================================
!  END  initialize_wrap
!=======================================================================

!=======================================================================
!  BEGIN set_connections
!=======================================================================
   SUBROUTINE set_connections (im,jm,face)
!.......................................................................
!  INTENT IN
!.......................................................................
   INTEGER (KIND=int_kind),INTENT ( IN) ::                                   &
      im,jm
!.......................................................................
!  INTENT IN AND OUT
!.......................................................................
   TYPE (face_type),INTENT (INOUT) ::                                        &
      face(im,jm)
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) ::                                                & 
      i,ii,j,panel,n,im5,count_face,di5(6),dj5(6),di6(7),dj6(7)
!.......................................................................

   im5 = im/5

   di5 = (/-1,-1, 0, 1, 0,-1/)   ; dj5 = (/ 0,-1,-1, 0, 1, 0/)
   di6 = (/-1,-1, 0, 1, 1, 0,-1/); dj6 = (/ 0,-1,-1, 0, 1, 1, 0/)
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  INITIALIZE
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   DO j = 1,jm
      DO i = 1,im
         face(i,j)%face_name   = 0
         face(i,j)%nghbr_total = 0
         face(i,j)%nghbr  (:)  = 0
         face(i,j)%vertex(:,:) = 0
         face(i,j)%edge  (:,:) = 0
      ENDDO
   ENDDO
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  SET FACE NAMES
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   face(1,jm-1)%face_name = 1 ! NORTH POLE
   face(im-1,1)%face_name = 2 ! SOUTH POLE
   count_face = 3
   DO j = 2,jm-1
      DO panel = 0,4
         DO i = 2,im5-1
            face(im5*panel+i,j)%face_name = count_face
            count_face = count_face+1
         ENDDO
      ENDDO
   ENDDO
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  WRAP FACE NAMES
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   CALL wrap_cell (im,jm,face(:,:)) 
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  SET LISTS OF NEIGHBORS
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!-----------------------------------------------------------------------
!  north pole
!-----------------------------------------------------------------------
   face(1,jm-1)%nghbr_total = 5
   DO panel = 0,4
      face(1,jm-1)%nghbr(panel+1) = face(im5*panel+2,jm-1)%face_name
   ENDDO
!-----------------------------------------------------------------------
!  south pole
!-----------------------------------------------------------------------
   face(im-1,1)%nghbr_total = 5
   DO panel = 1,5
      face(im-1,1)%nghbr(panel) = face(im5*panel-1,2)%face_name
   ENDDO
!-----------------------------------------------------------------------
!  INTERIOR CELLS
!-----------------------------------------------------------------------
   DO j = 2,jm-1
      DO panel = 0,4
         DO i = 2,im5-1
            ii = im5*panel+i
!-----------------------------------------------------------------------
!  interior pentagon
!-----------------------------------------------------------------------
            IF (((i==jm-1).OR.(i==im5-1)).AND.(j==jm-1)) THEN
               face(ii,j)%nghbr_total = 5
               DO n = 1,5
                  face(ii,j)%nghbr(n) = face(ii+di5(n),j+dj5(n))%face_name
               ENDDO
!-----------------------------------------------------------------------
!  interior hexagon
!-----------------------------------------------------------------------
            ELSE
               face(ii,j)%nghbr_total = 6
               DO n = 1,6
                  face(ii,j)%nghbr(n) = face(ii+di6(n),j+dj6(n))%face_name
               ENDDO
            ENDIF
         ENDDO
      ENDDO
   ENDDO
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  WRAP NEIGHBOR LISTS
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   CALL wrap_cell (im,jm,face(:,:)) 
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  SET VERTICIES AND EDGES
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   DO j = 2,jm-1
      DO panel = 0,4
         DO i = 2,im5-1
            ii = im5*panel+i
!-----------------------------------------------------------------------
!  set verticies
!-----------------------------------------------------------------------
            DO n = 1,2
               face(ii,j)%vertex(:,n) = (/face(ii,j)%face_name,              &
                                          face(ii,j)%nghbr(n  ),             &
                                          face(ii,j)%nghbr(n+1)/)
               CALL sort (3,face(ii,j)%vertex(:,n))
            ENDDO
!-----------------------------------------------------------------------
! set edges
!-----------------------------------------------------------------------
            DO n = 1,3
               face(ii,j)%edge(:,n) = (/face(ii,j)%face_name,                &
                                        face(ii,j)%nghbr(n)/)
               CALL sort (2,face(ii,j)%edge(:,n))
            ENDDO
         ENDDO
      ENDDO
   ENDDO
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  WRAP VERTICIES AND EDGES
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   CALL wrap_cell (im,jm,face(:,:)) 

   END SUBROUTINE set_connections
!=======================================================================
!  END  set_connections
!=======================================================================

!=======================================================================
!  BEGIN  wrap_cell
!=======================================================================
   SUBROUTINE wrap_cell (im,jm,face) 
!.......................................................................
!  INTENT IN
!.......................................................................
   INTEGER (KIND=int_kind),INTENT ( IN) ::                                   &
      im,jm
!.......................................................................
!  INTENT IN AND OUT
!.......................................................................
   TYPE (face_type),INTENT (INOUT) ::                                        &
      face(im,jm)
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) ::                                                &
      ij,o1,o2,q,p,im5,panel
!.......................................................................

   p = im-1; q = jm-1; im5 = 2*jm-2

   DO panel = 0,4
      o1 = im5*(MOD (panel+0,5)); o2 = im5*(MOD (panel+1,5))

      CALL copy_cell (face(1,q),face(o1+1    ,q)) ! NORTH POLE
      CALL copy_cell (face(p,1),face(o1+im5-1,1)) ! SOUTH POLE
! OFFSET 1 : TOP LEFT
      DO ij =   2,    q
         CALL copy_cell (face(o2    +2   ,q+2-ij),face(o1+ ij,jm))
      ENDDO 
! OFFSET 1 : TOP RIGHT
      DO ij = q+1,im5-1
         CALL copy_cell (face(o2-  q+1+ij,  2   ),face(o1+ ij,jm))
      ENDDO
! OFFSET 1 : RIGHT EDGE
      DO ij =   2,    q
         CALL copy_cell (face(o2+im5+1-ij,  2   ),face(o1+im5,ij))
      ENDDO

! OFFSET 2 : LEFT EDGE
      DO ij = 1,q-1
         CALL copy_cell (face(o1+  q+1-ij, q    ),face(o2+ 1,ij))
      ENDDO
! OFFSET 2 : BOTTOM LEFT
      DO ij = 2,q
         CALL copy_cell (face(o1+  q-1+ij, q    ),face(o2+ij, 1))
      ENDDO
! OFFSET 2 : BOTTOM RIGHT
      DO ij = q+1,im5-2
         CALL copy_cell (face(o1+im5-1   ,im5-ij),face(o2+ij, 1))
      ENDDO
   ENDDO

   END SUBROUTINE wrap_cell
!=======================================================================
!  END  wrap_cell
!=======================================================================

!=======================================================================
!  BEGIN  copy_cell
!=======================================================================
   SUBROUTINE copy_cell (face1,face2)
!.......................................................................
!  INTENT IN
!.......................................................................
   TYPE (face_type),INTENT( IN) ::                                           &
      face1
!.......................................................................
!  INTENT  OUT
!.......................................................................
   TYPE (face_type),INTENT(OUT) ::                                           &
      face2
!.......................................................................

!  COPY FACE NAME
   face2%face_name = face1%face_name      
!  COPY LIST OF NEIGHBORS
   face2%nghbr_total = face1%nghbr_total
   face2%nghbr(:)    = face1%nghbr(:)
!  COPY VERTEX INFORMATION
   face2%vertex(:,:) = face1%vertex(:,:)
!  COPY EDGE INFORMATION
   face2%edge(:,:) = face1%edge(:,:)
!  COPY SUBDOMAIN NUMBER
   face2%subdomain = face1%subdomain      

   END SUBROUTINE copy_cell
!=======================================================================
!  END  copy_cell
!=======================================================================

!=======================================================================
!  BEGIN  sort
!=======================================================================
   SUBROUTINE sort (ndata,list)
!.......................................................................
!  INTENT IN
!.......................................................................
   INTEGER (KIND=int_kind),INTENT( IN) ::                                    &
      ndata
!.......................................................................
!  INTENT IN AND OUT
!.......................................................................
   INTEGER (KIND=int_kind),INTENT(INOUT) ::                                  &
      list(ndata)
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) :: n,temp,iteration
!.......................................................................

! SORT A LIST OF INTEGERS INTO ASCENDING ORDER
   DO iteration = 1,ndata-1
      DO n = 1,ndata-1
         IF (list(n+1)<list(n)) THEN
            temp = list(n); list(n) = list(n+1); list(n+1) = temp
         ENDIF
      ENDDO
   ENDDO

   END SUBROUTINE sort
!=======================================================================
!  END  sort
!=======================================================================

!=======================================================================
!  BEGIN  set_subdomain_number
!=======================================================================
   SUBROUTINE set_subdomain_number (im,jm,isdm,jsdm,face)
!.......................................................................
!  INTENT IN
!.......................................................................
   INTEGER (KIND=int_kind),INTENT ( IN) ::                                   &
      im,jm,isdm,jsdm  
!.......................................................................
!  INTENT IN AND OUT
!.......................................................................
   TYPE (face_type),INTENT (INOUT) ::                                        &
      face(im,jm)
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) ::                                                &
      im5,iim,jjm,ii,jj,panel,isd,jsd,nsd      
!.......................................................................

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! SET THE SUBDOMAIN NUMBERS
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   im5 = im/5

   iim = ((im5-2)/isdm)+2; jjm = ((jm -2)/jsdm)+2

   face(1,jm-1)%subdomain = isdm*(  jsdm-1)+1
   face(im-1,1)%subdomain = isdm*(4*jsdm+1)
   nsd = 0
   DO panel = 0,4
      DO jsd = 0,jsdm-1
         DO isd = 0,isdm-1
            nsd = nsd + 1
            ii = im5*panel+(iim-2)*isd
            jj =           (jjm-2)*jsd
            face(ii+2:ii+iim-1,jj+2:jj+jjm-1)%subdomain = nsd
         ENDDO
      ENDDO
   ENDDO
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! WRAP
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   CALL wrap_cell (im,jm,face(:,:))

   END SUBROUTINE set_subdomain_number
!=======================================================================
!  END  set_subdomain_number
!=======================================================================

!=======================================================================
!  BEGIN  set_face1_face2
!=======================================================================
   SUBROUTINE set_face1_face2 (im,jm,isdm,jsdm,iim,jjm,nsdm_glbl,            &
                                                       face,face1,face2)
!.......................................................................
!  INTENT IN
!.......................................................................
   INTEGER (KIND=int_kind),INTENT ( IN) ::                                   &
      im,jm,isdm,jsdm,iim,jjm,nsdm_glbl  
!.......................................................................
!  INTENT IN
!.......................................................................
   TYPE (face_type),INTENT (INOUT) ::                                        &
      face(im,jm),face1(iim,jjm,nsdm_glbl),face2(iim,jjm,nsdm_glbl)
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) ::                                                &
      im5,i,j,ii,jj,panel,isd,jsd,nsd
!.......................................................................

   im5 = im/5

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! COPY FACE TO THE (iim,jjm,nsdm_glbl) DATA STRUCTURE
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   nsd = 0
   DO panel = 0,4
      DO jsd = 0,jsdm-1
         DO isd = 0,isdm-1
            nsd = nsd+1
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  SET face1.  face1 shows the faces of the naively wrapped grid. 
!              verticies and edges of ghost faces are not where we want them.
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            DO jj = 1,jjm
               DO ii = 1,iim
                  i = im5*panel+(iim-2)*isd+ii
                  j =           (jjm-2)*jsd+jj
                  CALL copy_cell (face(i,j),face1(ii,jj,nsd)) 
               ENDDO
            ENDDO
! if (iim-1,jjm-1) is a pentagon, then eliminate the cell at (iim,jjm)
            IF (MOD (nsd-1,isdm*jsdm)+1==isdm*jsdm-jsdm) THEN ! north hemisphere
               face1(iim,jjm,nsd)%face_name = -999
            ENDIF
            IF (MOD (nsd-1,isdm*jsdm)+1==isdm*jsdm     ) THEN ! south hemisphere
               face1(iim,jjm,nsd)%face_name = -999
            ENDIF
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  SET face 2.  face2 shows the faces of the correctly wrapped grid. 
!               verticies and edges of ghost faces are in the right place.
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            DO jj = 1,jjm
               DO ii = 1,iim
                  CALL copy_cell (face1(ii,jj,nsd),face2(ii,jj,nsd)) 
               ENDDO
            ENDDO
! correct the left column
            DO jj = 1,jjm-1
               CALL set_correct_face                                         &
                           (face2(2,jj,nsd)%face_name,1,face2(1,jj,nsd))
            ENDDO
! correct the bottom row
            DO ii = 2,iim-1
               CALL set_correct_face                                         &
                           (face2(ii,2,nsd)%face_name,5,face2(ii,1,nsd))
            ENDDO
! correct the right edge
            DO jj = 2,jjm-1
               CALL set_correct_face                                         &
                     (face2(iim-1,jj,nsd)%face_name,4,face2(iim,jj,nsd))
            ENDDO
! correct the top row
            DO ii = 2,iim-1
               CALL set_correct_face                                         &
                     (face2(ii,jjm-1,nsd)%face_name,2,face2(ii,jjm,nsd))
            ENDDO
! if (iim-1,jjm-1) is a hexagon, then correct the hexagon at (iim,jjm) 
! for the diagonal message
            IF (face2(iim-1,jjm-1,nsd)%nghbr_total == 6) THEN
               CALL set_correct_face                                         &
                 (face2(iim-1,jjm-1,nsd)%face_name,3,face2(iim,jjm,nsd))
            ENDIF
         ENDDO
      ENDDO
   ENDDO

   END SUBROUTINE set_face1_face2
!=======================================================================
!  END  set_face1_face2
!=======================================================================

!=======================================================================
!  BEGIN  set_correct_face
!=======================================================================
   SUBROUTINE set_correct_face (reference_face_name,twist,face)
!.......................................................................
!  INTENT IN
!.......................................................................
   INTEGER (KIND=int_kind),INTENT ( IN) ::                                   &
      reference_face_name,twist
!.......................................................................
!  INTENT IN AND OUT
!.......................................................................
   TYPE (face_type),INTENT (INOUT) ::                                        &
      face
!.......................................................................
!  LOCAL
!.......................................................................
   LOGICAL (KIND=log_kind) ::                                                &
      l_found
   INTEGER (KIND=int_kind) ::                                                &
      n,n_ref
!.......................................................................

   IF (face%nghbr_total==5) THEN
      IF ((face%face_name/=1).AND.(face%face_name/=2)) THEN
         face%vertex(:,:) = -999
         face%edge  (:,:) = -999
      ENDIF
   ELSE
      l_found = .FALSE.; n = 0
      DO WHILE ((.NOT.l_found).AND.(n<face%nghbr_total))
         n=n+1
         IF (face%nghbr(n)==reference_face_name) THEN
            l_found = .TRUE.; n_ref = n
         ENDIF
      ENDDO
      IF (.NOT.l_found) THEN
         PRINT *,' set_correct_face :: cannot find reference_face_name '
         PRINT *,' face%face_name      = ',face%face_name
         PRINT *,' face%nghbr          = ',face%nghbr
         PRINT *,' reference_face_name = ',reference_face_name
         STOP
      ENDIF
!  left   column ghost face -> twist = 1
!  bottom row    ghost face -> twist = 5
!  right  column ghost face -> twist = 4
!  top    row    ghost face -> twist = 2
!  SET VERTICIES
      DO n = 1,2
         face%vertex(:,n) =                                                  &
             (/face%face_name,                                               &
               face%nghbr(MOD (n_ref+twist+n  ,face%nghbr_total)+1),         &
               face%nghbr(MOD (n_ref+twist+n+1,face%nghbr_total)+1)/) 
         CALL sort (3,face%vertex(:,n))
      ENDDO
!  SET EDGES
      DO n = 1,3
         face%edge(:,n) =                                                    &
             (/face%face_name,                                               &
               face%nghbr(MOD (n_ref+twist+n  ,face%nghbr_total)+1)/)
         CALL sort (2,face%edge(:,n))
      ENDDO
   ENDIF

   END SUBROUTINE set_correct_face
!=======================================================================
!  END  set_correct_face
!=======================================================================

!=======================================================================
!  BEGIN  set_row_column_messages
!=======================================================================
   SUBROUTINE set_row_column_messages (iim,jjm,nsdm_glbl,tag_counter,        &
                                                  face1,face2,msg_instr)
!.......................................................................
!  INTENT IN
!.......................................................................
   INTEGER (KIND=int_kind),INTENT ( IN) ::                                   &
      iim,jjm,nsdm_glbl
   TYPE (face_type),INTENT ( IN) ::                                          &
      face1(iim,jjm,nsdm_glbl),face2(iim,jjm,nsdm_glbl)
!.......................................................................
!  INTENT IN AND OUT
!.......................................................................
   INTEGER (KIND=int_kind),INTENT (INOUT) ::                                 &
      tag_counter
!.......................................................................
!  INTENT OUT
!.......................................................................
   TYPE (message_instructions),INTENT (OUT) ::                               &
      msg_instr(nsdm_glbl)
!.......................................................................
!  LOCAL
!.......................................................................
   LOGICAL (KIND=log_kind) ::                                                &
      l_found
   INTEGER (KIND=int_kind) ::                                                &
      ii,jj,nsd,nsd_nghbr,nsd_sour,                                          &
      i_nghbr(4),i_start(4),di(4),j_nghbr(4),j_start(4),dj(4),               &
      nmsg,i1,j1,i2,j2,face_find,count,n1,n2,offset(3)

   TYPE (face_type),ALLOCATABLE ::                                           &
      msg(:)
!.......................................................................

   i_nghbr=(/1,2,iim,  2/); i_start=(/2,2,iim-1,    2/); di=(/0,1,0,1/)
   j_nghbr=(/2,1,  2,jjm/); j_start=(/2,2,    2,jjm-1/); dj=(/1,0,1,0/)

   ALLOCATE (msg(iim-2))

   DO nsd = 1,nsdm_glbl
      DO nmsg = 1,4

         tag_counter = tag_counter+1
         nsd_nghbr = face1(i_nghbr(nmsg),j_nghbr(nmsg),nsd)%subdomain

         msg_instr(nsd)%send_current%msg_tag    = tag_counter
         msg_instr(nsd)%send_current%nsd_dest   = nsd_nghbr
         msg_instr(nsd)%send_current%i_start    = i_start(nmsg)
         msg_instr(nsd)%send_current%j_start    = j_start(nmsg)
         msg_instr(nsd)%send_current%di         =      di(nmsg)
         msg_instr(nsd)%send_current%dj         =      dj(nmsg)
         msg_instr(nsd)%send_current%msg_length = iim-2
         msg_instr(nsd)%send_current%instr_recv =>                           &
                                       msg_instr(nsd_nghbr)%recv_current

         DO count = 1,iim-2
            ii = i_start(nmsg)+di(nmsg)*(count-1)
            jj = j_start(nmsg)+dj(nmsg)*(count-1)
            CALL copy_cell (face1(ii,jj,nsd),msg(count))
         ENDDO
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  DETERMINE HOW GHOST ROW/COLUMN MESSAGES SHOULD BE STORED 
!  find starting position and stride on the receiving subdomain
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         l_found = .FALSE.
         DO jj = 1,jjm
            DO ii = 1,iim
               IF (face1(ii,jj,nsd_nghbr)%face_name ==                       &
                                                  msg(1)%face_name) THEN
                  i1=ii;j1=jj;l_found=.TRUE.
               ENDIF
               IF (face1(ii,jj,nsd_nghbr)%face_name ==                       &
                                                  msg(2)%face_name) THEN
                  i2=ii;j2=jj
               ENDIF
            ENDDO
         ENDDO
         IF (.NOT.l_found) THEN
            PRINT *,' initialize_wrap :: error 01 :: ',                      &
                                        'cannot find starting position '
            STOP 
         ENDIF

         msg_instr(nsd_nghbr)%recv_current%msg_tag    = tag_counter
         msg_instr(nsd_nghbr)%recv_current%nsd_sour   = nsd
         msg_instr(nsd_nghbr)%recv_current%i_start    = i1
         msg_instr(nsd_nghbr)%recv_current%j_start    = j1
         msg_instr(nsd_nghbr)%recv_current%di         = i2-i1
         msg_instr(nsd_nghbr)%recv_current%dj         = j2-j1
         msg_instr(nsd_nghbr)%recv_current%msg_length = iim-2
         msg_instr(nsd_nghbr)%recv_current%instr_send =>                     &
                                             msg_instr(nsd)%send_current

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  OFFSET FOR EDGES: IF THE SECOND FACE OF THE MESSAGE LIST IS A HEXAGON,
!  THEN THERE EXISTS A PAIR OF MATCHING CORNERS FOR THAT FACE ON THE 
!  face2 ARRAY.  IF THE SECOND FACE IS A PENTAGON THEN USE THE 
!  FIRST FACE ON THE MESSAGE LIST TO FIND A MATCH. 
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         IF (msg(2)%nghbr_total==6) THEN
            face_find = 2; offset(:) = (/i2,j2,0/)
         ELSE
            face_find = 1; offset(:) = (/i1,j1,0/)
         ENDIF
!-----------------------------------------------------------------------
!  determine how to unpack verticies
!-----------------------------------------------------------------------
         DO n1 = 1,2
            l_found = .FALSE.
            DO jj = 1,jjm
               DO ii = 1,iim
                  DO n2 = 1,2
                     IF (equal_listQ (3,face2(ii,jj,nsd_nghbr)%vertex(:,n2), &
                                      msg(face_find)%vertex(:,n1))) THEN
                        l_found = .TRUE.
                        msg_instr(nsd_nghbr)%recv_current%                   &
                              unpack_vrtx(:,n1) = (/ii,jj,n2/)-offset(:)
                     ENDIF
                  ENDDO
               ENDDO
            ENDDO
            IF (.NOT.l_found) THEN
               msg_instr(nsd_nghbr)%recv_current%                            &
                                  unpack_vrtx(:,n1) = (/-999,-999,-999/)
            ENDIF
         ENDDO ! n1 loop
!-----------------------------------------------------------------------
!  determine how to unpack edges
!-----------------------------------------------------------------------
         DO n1 = 1,3
            l_found = .FALSE.
            DO jj = 1,jjm
               DO ii = 1,iim
                  DO n2 = 1,3
                     IF (equal_listQ (2,face2(ii,jj,nsd_nghbr)%edge(:,n2),   &
                                        msg(face_find)%edge(:,n1))) THEN
                        l_found = .TRUE.
                        msg_instr(nsd_nghbr)%recv_current%                   &
                              unpack_edge(:,n1) = (/ii,jj,n2/)-offset(:)
                     ENDIF
                  ENDDO
               ENDDO
            ENDDO
            IF (.NOT.l_found) THEN
               msg_instr(nsd_nghbr)%recv_current%                            &
                                  unpack_edge(:,n1) = (/-999,-999,-999/)
            ENDIF
         ENDDO ! n1 loop
!-----------------------------------------------------------------------
!  allocate a new node at the end of the list
!-----------------------------------------------------------------------
         ALLOCATE (msg_instr(nsd      )%send_current%next,                   &
                   msg_instr(nsd_nghbr)%recv_current%next)
         msg_instr(nsd      )%send_current =>                                &
                                 msg_instr(nsd      )%send_current%next
         msg_instr(nsd_nghbr)%recv_current =>                                &
                                 msg_instr(nsd_nghbr)%recv_current%next
         NULLIFY (msg_instr(nsd      )%send_current%next)
         NULLIFY (msg_instr(nsd_nghbr)%recv_current%next)
      ENDDO ! nmsg loop
   ENDDO ! nsd loop

   DEALLOCATE (msg)

   END SUBROUTINE set_row_column_messages
!=======================================================================
!  END  set_row_column_messages
!=======================================================================

!=======================================================================
!  BEGIN  set_diagonal_messages
!=======================================================================
   SUBROUTINE set_diagonal_messages (isdm,jsdm,iim,jjm,nsdm_glbl,            &
                                      tag_counter,face1,face2,msg_instr)
!.......................................................................
!  INTENT IN
!.......................................................................
   INTEGER (KIND=int_kind),INTENT ( IN) ::                                   &
      isdm,jsdm,iim,jjm,nsdm_glbl
   TYPE (face_type) ::                                                       &
      face1(iim,jjm,nsdm_glbl),face2(iim,jjm,nsdm_glbl)
!.......................................................................
!  INTENT IN AND OUT
!.......................................................................
   INTEGER (KIND=int_kind),INTENT (INOUT) ::                                 &
      tag_counter
!.......................................................................
!  INTENT OUT
!.......................................................................
   TYPE (message_instructions) ::                                            &
      msg_instr(nsdm_glbl)
!.......................................................................
!  LOCAL
!.......................................................................
   LOGICAL (KIND=log_kind) :: l_message,l_found
   INTEGER (KIND=int_kind) ::                                                &
      nsd,isd,jsd,panel,nmsg,nsd_nghbr,block_type,                           &
      i_start,j_start,ii,jj,i1,j1,n1,n2,nsd_send,nsd_recv
!.......................................................................

   nsd = 0
   DO panel = 0,4
      DO jsd = 1,jsdm
         DO isd = 1,isdm
            nsd = nsd + 1
            DO nmsg = 1,2
               l_message = .FALSE.  !  assume a message will not be sent
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  CHECK TO SEE IF A MESSAGE SHOULD BE SENT
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
               IF (nmsg==1) THEN
!-----------------------------------------------------------------------
!  check lower-left diagonal.  determine block_type
!-----------------------------------------------------------------------
                  block_type = 3
                  IF ((isd==1).AND.(                jsd<jsdm) ) block_type = 1
                  IF ((jsd==1).AND.((jsdm<isd).AND.(isd<isdm))) block_type = 2
                  IF (((isd==1).AND.(jsd==jsdm)).OR.                         &
                                    ((isd==isdm).AND.(jsd==1))) block_type = 0
!-----------------------------------------------------------------------
!  block_type 1.  send the (2,jjm-1) position
!-----------------------------------------------------------------------
                  IF (block_type==1) THEN
                     l_message = .TRUE.
                     nsd_nghbr = face1(1,jjm-1,nsd)%subdomain
                     i_start  = 2; j_start  = jjm-1
                  ENDIF
!-----------------------------------------------------------------------
!  block_type 2.  send the (iim-1,2) position
!-----------------------------------------------------------------------
                  IF (block_type==2) THEN
                     l_message = .TRUE.
                     nsd_nghbr = face1(iim-1,1,nsd)%subdomain
                     i_start  = iim-1; j_start  = 2
                  ENDIF
!-----------------------------------------------------------------------
!  block_type 3.  send the (2,2) position
!-----------------------------------------------------------------------
                  IF (block_type==3) THEN
                     l_message = .TRUE.
                     nsd_nghbr = face1(1,1,nsd)%subdomain
                     i_start  = 2; j_start  = 2
                  ENDIF
               ENDIF
               IF (nmsg==2) THEN
!-----------------------------------------------------------------------
!  check upper-right diagonal
!-----------------------------------------------------------------------
                  IF (face1(iim-1,jjm-1,nsd)%nghbr_total == 6) THEN
!-----------------------------------------------------------------------
!  special condition 1.  send the (iim-1,jjm-1) position
!-----------------------------------------------------------------------
                     l_message = .TRUE.
                     nsd_nghbr = face1(iim,jjm,nsd)%subdomain
                     i_start  = iim-1; j_start  = jjm-1
                  ENDIF
               ENDIF
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  A MESSAGE IS TO BE SENT
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
               IF (l_message) THEN
                  tag_counter = tag_counter+1
                  msg_instr(nsd)%send_current%msg_tag    = tag_counter
                  msg_instr(nsd)%send_current%nsd_dest   = nsd_nghbr
                  msg_instr(nsd)%send_current%i_start    = i_start
                  msg_instr(nsd)%send_current%j_start    = j_start

                  msg_instr(nsd)%send_current%di         = 0
                  msg_instr(nsd)%send_current%dj         = 0
                  msg_instr(nsd)%send_current%msg_length = 1
                  msg_instr(nsd)%send_current%instr_recv =>                  &
                                       msg_instr(nsd_nghbr)%recv_current
!-----------------------------------------------------------------------
!  find the position of the diagonal message on the receiving subdomain
!-----------------------------------------------------------------------
                  DO ii = 1,iim
                     DO jj = 1,jjm
                        IF (face1(ii,jj,nsd_nghbr)%face_name ==              &
                                face1(i_start,j_start,nsd)%face_name) THEN
                           i1=ii; j1=jj
                        ENDIF
                     ENDDO
                  ENDDO

                  msg_instr(nsd_nghbr)%recv_current%msg_tag    = tag_counter
                  msg_instr(nsd_nghbr)%recv_current%nsd_sour   = nsd
                  msg_instr(nsd_nghbr)%recv_current%i_start    = i1
                  msg_instr(nsd_nghbr)%recv_current%j_start    = j1
                  msg_instr(nsd_nghbr)%recv_current%di         = 0
                  msg_instr(nsd_nghbr)%recv_current%dj         = 0
                  msg_instr(nsd_nghbr)%recv_current%msg_length = 1
                  msg_instr(nsd_nghbr)%recv_current%instr_send =>            &
                                             msg_instr(nsd)%send_current

!-----------------------------------------------------------------------
!  determine how to unpack verticies
!-----------------------------------------------------------------------
                  DO n1 = 1,2
                     l_found = .FALSE.
                     DO jj = 1,jjm
                        DO ii = 1,iim
                           DO n2 = 1,2
                              IF (equal_listQ (3,                            &
                                 face2(ii,jj,nsd_nghbr)%vertex(:,n2),        &
                                 face1(i_start,j_start,nsd)%vertex(:,n1))) THEN
                                 l_found = .TRUE.
                                 msg_instr(nsd_nghbr)%recv_current%          &
                                 unpack_vrtx(:,n1) = (/ii,jj,n2/)-(/i1,j1,0/)
                              ENDIF
                           ENDDO
                        ENDDO
                     ENDDO
                     IF (.NOT.l_found) THEN
                        msg_instr(nsd_nghbr)%recv_current%                   &
                                  unpack_vrtx(:,n1) = (/-999,-999,-999/)
                     ENDIF
                  ENDDO ! n1 loop
!-----------------------------------------------------------------------
!  determine how to unpack edges
!-----------------------------------------------------------------------
                  DO n1 = 1,3
                     l_found = .FALSE.
                     DO jj = 1,jjm
                        DO ii = 1,iim
                           DO n2 = 1,3
                              IF (equal_listQ (2,                            &
                                 face2(ii,jj,nsd_nghbr)%edge(:,n2),          &
                                 face1(i_start,j_start,nsd)%edge(:,n1))) THEN
                                 l_found = .TRUE.
                                 msg_instr(nsd_nghbr)%recv_current%          &
                                 unpack_edge(:,n1) = (/ii,jj,n2/)-(/i1,j1,0/)
                              ENDIF
                           ENDDO
                        ENDDO
                     ENDDO
                     IF (.NOT.l_found) THEN
                        msg_instr(nsd_nghbr)%recv_current%                   &
                                  unpack_edge(:,n1) = (/-999,-999,-999/)
                     ENDIF
                  ENDDO ! n1 loop

!-----------------------------------------------------------------------
!  allocate a new node at the end of the list
!-----------------------------------------------------------------------
                  ALLOCATE (msg_instr(nsd      )%send_current%next,          &
                            msg_instr(nsd_nghbr)%recv_current%next)
                  msg_instr(nsd      )%send_current =>                       &
                                   msg_instr(nsd      )%send_current%next
                  msg_instr(nsd_nghbr)%recv_current =>                       &
                                   msg_instr(nsd_nghbr)%recv_current%next
                  NULLIFY (msg_instr(nsd      )%send_current%next)
                  NULLIFY (msg_instr(nsd_nghbr)%recv_current%next)
               ENDIF  !  IF (l_message) THEN
            ENDDO  !  nmsg loop
         ENDDO  !  isd loop
      ENDDO  !  jsd loop
   ENDDO  !  panel loop

!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
!-----------------------------------------------------------------------
!  11 august 2005 : fixes to vertex wrap in the northern hemisphere
!-----------------------------------------------------------------------
   DO panel = 1,4
      nsd_send = MOD (isdm*jsdm*(panel+2)+isdm*(jsdm-1)+1,5*isdm*jsdm)
      nsd_recv = MOD (isdm*jsdm*(panel+0)+isdm*(jsdm-1)+1,5*isdm*jsdm)
      tag_counter = tag_counter+1
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  SPECIAL SEND
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      msg_instr(nsd_send)%send_current%msg_tag    = tag_counter
      msg_instr(nsd_send)%send_current%nsd_dest   = nsd_recv
      msg_instr(nsd_send)%send_current%i_start    = 2
      msg_instr(nsd_send)%send_current%j_start    = jjm-1
      msg_instr(nsd_send)%send_current%di         = 0
      msg_instr(nsd_send)%send_current%dj         = 0
      msg_instr(nsd_send)%send_current%msg_length = 1
      msg_instr(nsd_send)%send_current%instr_recv =>                         &
                                        msg_instr(nsd_recv)%recv_current
!-----------------------------------------------------------------------
!  SPECIAL RECEIVE
!-----------------------------------------------------------------------
      msg_instr(nsd_recv)%recv_current%msg_tag    = tag_counter
      msg_instr(nsd_recv)%recv_current%nsd_sour   = nsd_send
      msg_instr(nsd_recv)%recv_current%i_start    = 1
      msg_instr(nsd_recv)%recv_current%j_start    = jjm
      msg_instr(nsd_recv)%recv_current%di         = 0
      msg_instr(nsd_recv)%recv_current%dj         = 0
      msg_instr(nsd_recv)%recv_current%msg_length = 1
      msg_instr(nsd_recv)%recv_current%instr_send =>                         &
                                        msg_instr(nsd_send)%send_current

      msg_instr(nsd_recv)%recv_current%unpack_vrtx(:,1) = (/   1,   0,   1/)
      msg_instr(nsd_recv)%recv_current%unpack_vrtx(:,2) = (/-999,-999,-999/)
      msg_instr(nsd_recv)%recv_current%unpack_edge(:,:) = -999
!-----------------------------------------------------------------------
!  allocate a new node at the end of the list
!-----------------------------------------------------------------------
      ALLOCATE (msg_instr(nsd_send)%send_current%next,                       &
                msg_instr(nsd_recv)%recv_current%next)
      msg_instr(nsd_send)%send_current =>                                    &
                                   msg_instr(nsd_send)%send_current%next
      msg_instr(nsd_recv)%recv_current =>                                    &
                                   msg_instr(nsd_recv)%recv_current%next
      NULLIFY (msg_instr(nsd_send)%send_current%next)
      NULLIFY (msg_instr(nsd_recv)%recv_current%next)
   ENDDO  !  panel loop

   DO panel = 0,4
      DO nsd = 1,jsdm-1
         nsd_send =                                                          &
             MOD (isdm*jsdm*(panel+1)+isdm*(jsdm-1)+1,5*isdm*jsdm)-          &
                                                           (nsd-1)*isdm
         nsd_recv =                                                          &
             MOD (isdm*jsdm*(panel+0)+isdm*(jsdm-1)+1,5*isdm*jsdm)+nsd
         tag_counter = tag_counter+1
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  SPECIAL SEND
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         msg_instr(nsd_send)%send_current%msg_tag    = tag_counter
         msg_instr(nsd_send)%send_current%nsd_dest   = nsd_recv
         msg_instr(nsd_send)%send_current%i_start    = 2
         msg_instr(nsd_send)%send_current%j_start    = 2
         msg_instr(nsd_send)%send_current%di         = 0
         msg_instr(nsd_send)%send_current%dj         = 0
         msg_instr(nsd_send)%send_current%msg_length = 1
         msg_instr(nsd_send)%send_current%instr_recv =>                      &
                                        msg_instr(nsd_recv)%recv_current
!-----------------------------------------------------------------------
!  SPECIAL RECEIVE
!-----------------------------------------------------------------------
         msg_instr(nsd_recv)%recv_current%msg_tag    = tag_counter
         msg_instr(nsd_recv)%recv_current%nsd_sour   = nsd_send
         msg_instr(nsd_recv)%recv_current%i_start    = 1
         msg_instr(nsd_recv)%recv_current%j_start    = jjm
         msg_instr(nsd_recv)%recv_current%di         = 0
         msg_instr(nsd_recv)%recv_current%dj         = 0
         msg_instr(nsd_recv)%recv_current%msg_length = 1
         msg_instr(nsd_recv)%recv_current%instr_send =>                      &
                                        msg_instr(nsd_send)%send_current

         msg_instr(nsd_recv)%recv_current%unpack_vrtx(:,1) = (/-999,-999,-999/)
         msg_instr(nsd_recv)%recv_current%unpack_vrtx(:,2) = (/   1,   0,   1/)
         msg_instr(nsd_recv)%recv_current%unpack_edge(:,:) = -999
!-----------------------------------------------------------------------
!  allocate a new node at the end of the list
!-----------------------------------------------------------------------
         ALLOCATE (msg_instr(nsd_send)%send_current%next,                    &
                   msg_instr(nsd_recv)%recv_current%next)
         msg_instr(nsd_send)%send_current =>                                 &
                                   msg_instr(nsd_send)%send_current%next
         msg_instr(nsd_recv)%recv_current =>                                 &
                                   msg_instr(nsd_recv)%recv_current%next
         NULLIFY (msg_instr(nsd_send)%send_current%next)
         NULLIFY (msg_instr(nsd_recv)%recv_current%next)
      ENDDO  !  nsd loop
   ENDDO  !  panel loop
!-----------------------------------------------------------------------
!  12 august 2005 : fixes to vertex wrap in the southern hemisphere
!-----------------------------------------------------------------------
   DO panel = 0,3
      nsd_send = MOD (isdm*jsdm*(panel+2)+isdm-1,5*isdm*jsdm)+1
      nsd_recv = MOD (isdm*jsdm*(panel+0)+isdm-1,5*isdm*jsdm)+1
      tag_counter = tag_counter+1
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  SPECIAL SEND
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      msg_instr(nsd_send)%send_current%msg_tag    = tag_counter
      msg_instr(nsd_send)%send_current%nsd_dest   = nsd_recv
      msg_instr(nsd_send)%send_current%i_start    = iim-1
      msg_instr(nsd_send)%send_current%j_start    = 2
      msg_instr(nsd_send)%send_current%di         = 0
      msg_instr(nsd_send)%send_current%dj         = 0
      msg_instr(nsd_send)%send_current%msg_length = 1
      msg_instr(nsd_send)%send_current%instr_recv =>                         &
                                        msg_instr(nsd_recv)%recv_current
!-----------------------------------------------------------------------
!  SPECIAL RECEIVE
!-----------------------------------------------------------------------
      msg_instr(nsd_recv)%recv_current%msg_tag    = tag_counter
      msg_instr(nsd_recv)%recv_current%nsd_sour   = nsd_send
      msg_instr(nsd_recv)%recv_current%i_start    = iim
      msg_instr(nsd_recv)%recv_current%j_start    = 1
      msg_instr(nsd_recv)%recv_current%di         = 0
      msg_instr(nsd_recv)%recv_current%dj         = 0
      msg_instr(nsd_recv)%recv_current%msg_length = 1
      msg_instr(nsd_recv)%recv_current%instr_send =>                         &
                                        msg_instr(nsd_send)%send_current

      msg_instr(nsd_recv)%recv_current%unpack_vrtx(:,1) = (/-999,-999,-999/)
      msg_instr(nsd_recv)%recv_current%unpack_vrtx(:,2) = (/   0,   1,   2/)
      msg_instr(nsd_recv)%recv_current%unpack_edge(:,:) = -999
!-----------------------------------------------------------------------
!  allocate a new node at the end of the list
!-----------------------------------------------------------------------
      ALLOCATE (msg_instr(nsd_send)%send_current%next,                       &
                msg_instr(nsd_recv)%recv_current%next)
      msg_instr(nsd_send)%send_current =>                                    &
                                   msg_instr(nsd_send)%send_current%next
      msg_instr(nsd_recv)%recv_current =>                                    &
                                   msg_instr(nsd_recv)%recv_current%next
      NULLIFY (msg_instr(nsd_send)%send_current%next)
      NULLIFY (msg_instr(nsd_recv)%recv_current%next)
   ENDDO  !  panel loop

   DO panel = 0,4
      DO nsd = 1,jsdm-1
         nsd_send = MOD (isdm*jsdm*(panel+1)+isdm,5*isdm*jsdm)-nsd+1
         nsd_recv = MOD (isdm*jsdm*(panel+0)+isdm,5*isdm*jsdm)+nsd*isdm
         tag_counter = tag_counter+1
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  SPECIAL SEND
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         msg_instr(nsd_send)%send_current%msg_tag    = tag_counter
         msg_instr(nsd_send)%send_current%nsd_dest   = nsd_recv
         msg_instr(nsd_send)%send_current%i_start    = 2
         msg_instr(nsd_send)%send_current%j_start    = 2
         msg_instr(nsd_send)%send_current%di         = 0
         msg_instr(nsd_send)%send_current%dj         = 0
         msg_instr(nsd_send)%send_current%msg_length = 1
         msg_instr(nsd_send)%send_current%instr_recv =>                      &
                                        msg_instr(nsd_recv)%recv_current
!-----------------------------------------------------------------------
!  SPECIAL RECEIVE
!-----------------------------------------------------------------------
         msg_instr(nsd_recv)%recv_current%msg_tag    = tag_counter
         msg_instr(nsd_recv)%recv_current%nsd_sour   = nsd_send
         msg_instr(nsd_recv)%recv_current%i_start    = iim
         msg_instr(nsd_recv)%recv_current%j_start    = 1
         msg_instr(nsd_recv)%recv_current%di         = 0
         msg_instr(nsd_recv)%recv_current%dj         = 0
         msg_instr(nsd_recv)%recv_current%msg_length = 1
         msg_instr(nsd_recv)%recv_current%instr_send =>                      &
                                        msg_instr(nsd_send)%send_current

         msg_instr(nsd_recv)%recv_current%unpack_vrtx(:,1) = (/   0,   1,   2/)
         msg_instr(nsd_recv)%recv_current%unpack_vrtx(:,2) = (/-999,-999,-999/)
         msg_instr(nsd_recv)%recv_current%unpack_edge(:,:) = -999
!-----------------------------------------------------------------------
!  allocate a new node at the end of the list
!-----------------------------------------------------------------------
         ALLOCATE (msg_instr(nsd_send)%send_current%next,                    &
                   msg_instr(nsd_recv)%recv_current%next)
         msg_instr(nsd_send)%send_current =>                                 &
                                   msg_instr(nsd_send)%send_current%next
         msg_instr(nsd_recv)%recv_current =>                                 &
                                   msg_instr(nsd_recv)%recv_current%next
         NULLIFY (msg_instr(nsd_send)%send_current%next)
         NULLIFY (msg_instr(nsd_recv)%recv_current%next)
      ENDDO  !  nsd loop
   ENDDO  !  panel loop
!@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

   END SUBROUTINE set_diagonal_messages
!=======================================================================
!  END    set_diagonal_messages
!=======================================================================

!=======================================================================
!  BEGIN  set_pole_messages
!=======================================================================
   SUBROUTINE set_pole_messages (isdm,jsdm,iim,jjm,nsdm_glbl,tag_counter,    &
                                                              msg_instr)
!.......................................................................
!  INTENT IN
!.......................................................................
   INTEGER (KIND=int_kind) ::                                                &
      isdm,jsdm,iim,jjm,nsdm_glbl
!.......................................................................
!  INTENT IN AND OUT
!.......................................................................
   INTEGER (KIND=int_kind) ::                                                &
      tag_counter
!.......................................................................
!  INTENT OUT
!.......................................................................
   TYPE (message_instructions) ::                                            &
      msg_instr(nsdm_glbl)
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) ::                                                &
      npole,n,count,nsd,pole_sour(4),pole_dest(2),nsd_north,nsd_south,       &
      i_start_send(2),j_start_send(2),i_start_recv(4),j_start_recv(4),       &
      panel,nsd_dest
!.......................................................................

   pole_sour = (/2*isdm*jsdm+isdm*(jsdm-1)+1,   & ! north pole sour 1
                 3*isdm*jsdm+isdm*(jsdm-1)+1,   & ! north pole sour 2
                 1*isdm*jsdm+isdm           ,   & ! south pole sour 1
                 2*isdm*jsdm+isdm            /)   ! south pole sour 2

   pole_dest = (/0*isdm*jsdm+isdm*(jsdm-1)+1,   & ! north pole dest 2
                 4*isdm*jsdm+isdm            /)   ! south pole dest 2

   i_start_send = (/2,iim-1/)
   j_start_send = (/jjm-1,2/)

   i_start_recv=(/1,iim,iim,1/)
   j_start_recv=(/jjm,1,1,jjm/)

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! SPECIAL MESSAGES SEND TO THE NORTH AND SOUTH POLE
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   DO npole = 1,2
      DO n = 1,2
         tag_counter = tag_counter+1
         count = 2*(npole-1)+n

         msg_instr(pole_sour(count))%send_current%msg_tag  = tag_counter
         msg_instr(pole_sour(count))%send_current%nsd_dest =                 &
                                                        pole_dest(npole)
         msg_instr(pole_sour(count))%send_current%i_start  =                 &
                                                     i_start_send(npole)
         msg_instr(pole_sour(count))%send_current%j_start  =                 &
                                                     j_start_send(npole)
         msg_instr(pole_sour(count))%send_current%di         = 0
         msg_instr(pole_sour(count))%send_current%dj         = 0
         msg_instr(pole_sour(count))%send_current%msg_length = 1
         msg_instr(pole_sour(count))%send_current%instr_recv =>              & 
                                msg_instr(pole_dest(npole))%recv_current

         msg_instr(pole_dest(npole))%recv_current%msg_tag  = tag_counter
         msg_instr(pole_dest(npole))%recv_current%nsd_sour =                 &
                                                        pole_sour(count)
         msg_instr(pole_dest(npole))%recv_current%i_start  =                 &
                                                     i_start_recv(count)
         msg_instr(pole_dest(npole))%recv_current%j_start  =                 &
                                                     j_start_recv(count)
         msg_instr(pole_dest(npole))%recv_current%di         = 0
         msg_instr(pole_dest(npole))%recv_current%dj         = 0
         msg_instr(pole_dest(npole))%recv_current%msg_length = 1
         msg_instr(pole_dest(npole))%recv_current%instr_send =>              & 
                                msg_instr(pole_sour(count))%send_current

!-----------------------------------------------------------------------
!  determine how to unpack verticies and edges 
!-----------------------------------------------------------------------
         nsd = pole_dest(npole)

         IF (count==1) THEN ! north pole 1  (595)
            msg_instr(nsd)%recv_current%unpack_vrtx(:,1) = (/1,0,1/)
            msg_instr(nsd)%recv_current%unpack_vrtx(:,2) = (/-999,-999,-999/)

            msg_instr(nsd)%recv_current%unpack_edge(:,1) = (/0,0,3/)
            msg_instr(nsd)%recv_current%unpack_edge(:,2) = (/1,0,1/)
            msg_instr(nsd)%recv_current%unpack_edge(:,3) = (/-999,-999,-999/)
         ENDIF

         IF (count==2) THEN ! north pole 2  (611)
            msg_instr(nsd)%recv_current%unpack_vrtx(:,1) = (/1-iim,jjm-2,1/)
            msg_instr(nsd)%recv_current%unpack_vrtx(:,2) = (/-999,-999,-999/)

            msg_instr(nsd)%recv_current%unpack_edge(:,1) = (/1-iim,jjm-2,2/)
            msg_instr(nsd)%recv_current%unpack_edge(:,2) = (/1-iim,jjm-1,2/)
            msg_instr(nsd)%recv_current%unpack_edge(:,3) = (/-999,-999,-999/)
         ENDIF

         IF (count==3) THEN ! south pole 1  ( 34)
            msg_instr(nsd)%recv_current%unpack_vrtx(:,1) = (/-999,-999,-999/)
            msg_instr(nsd)%recv_current%unpack_vrtx(:,2) = (/0,1,2/)

            msg_instr(nsd)%recv_current%unpack_edge(:,1) = (/-999,-999,-999/)
            msg_instr(nsd)%recv_current%unpack_edge(:,2) = (/0,1,3/)
            msg_instr(nsd)%recv_current%unpack_edge(:,3) = (/0,0,1/)
         ENDIF

         IF (count==4) THEN ! south pole 2  ( 50)
            msg_instr(nsd)%recv_current%unpack_vrtx(:,1) = (/-999,-999,-999/)
            msg_instr(nsd)%recv_current%unpack_vrtx(:,2) = (/iim-2,1-jjm,2/)

            msg_instr(nsd)%recv_current%unpack_edge(:,1) = (/-999,-999,-999/)
            msg_instr(nsd)%recv_current%unpack_edge(:,2) = (/iim-1,1-jjm,2/)
            msg_instr(nsd)%recv_current%unpack_edge(:,3) = (/iim-2,1-jjm,2/)
         ENDIF
!-----------------------------------------------------------------------
!  allocate a new node at the end of the list
!-----------------------------------------------------------------------
         ALLOCATE (msg_instr(pole_sour(count))%send_current%next,            &
                   msg_instr(pole_dest(npole))%recv_current%next)
         msg_instr(pole_sour(count))%send_current =>                         &
                        msg_instr(pole_sour(count))%send_current%next
         msg_instr(pole_dest(npole))%recv_current =>                         &
                        msg_instr(pole_dest(npole))%recv_current%next
         NULLIFY (msg_instr(pole_sour(count))%send_current%next)
         NULLIFY (msg_instr(pole_dest(npole))%recv_current%next)
      ENDDO
   ENDDO

   nsd_north = 0*isdm*jsdm+isdm*(jsdm-1)+1 ! global subdomain number north pole
   nsd_south = 4*isdm*jsdm+isdm            ! global subdomain number south pole

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! SPECIAL MESSAGES FROM THE NORTH POLE
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   DO panel = 1,4
      tag_counter = tag_counter+1
      nsd_dest    = panel*isdm*jsdm+isdm*(jsdm-1)+1

      msg_instr(nsd_north)%send_current%msg_tag    = tag_counter
      msg_instr(nsd_north)%send_current%nsd_dest   = nsd_dest
      msg_instr(nsd_north)%send_current%i_start    = 1
      msg_instr(nsd_north)%send_current%j_start    = jjm-1
      msg_instr(nsd_north)%send_current%di         = 0
      msg_instr(nsd_north)%send_current%dj         = 0
      msg_instr(nsd_north)%send_current%msg_length = 1
      msg_instr(nsd_north)%send_current%instr_recv =>                        & 
                                        msg_instr(nsd_dest)%recv_current

      msg_instr(nsd_dest)%recv_current%msg_tag    = tag_counter
      msg_instr(nsd_dest)%recv_current%nsd_sour   = nsd_north
      msg_instr(nsd_dest)%recv_current%i_start    = 1
      msg_instr(nsd_dest)%recv_current%j_start    = jjm-1
      msg_instr(nsd_dest)%recv_current%di         = 0
      msg_instr(nsd_dest)%recv_current%dj         = 0
      msg_instr(nsd_dest)%recv_current%msg_length = 1
      msg_instr(nsd_dest)%recv_current%instr_send =>                         & 
                                       msg_instr(nsd_north)%send_current
!-----------------------------------------------------------------------
!  determine how to unpack verticies and edges 
!-----------------------------------------------------------------------
      msg_instr(nsd_dest)%recv_current%unpack_vrtx(:,:) = -999
      msg_instr(nsd_dest)%recv_current%unpack_edge(:,:) = -999
!-----------------------------------------------------------------------
!  allocate a new node at the end of the list
!-----------------------------------------------------------------------
      ALLOCATE (msg_instr(nsd_north)%send_current%next,                      &
                msg_instr(nsd_dest)%recv_current%next)
      msg_instr(nsd_north)%send_current =>                                   &
                                  msg_instr(nsd_north)%send_current%next
      msg_instr(nsd_dest)%recv_current =>                                    &
                                   msg_instr(nsd_dest)%recv_current%next
      NULLIFY (msg_instr(nsd_north)%send_current%next)
      NULLIFY (msg_instr(nsd_dest )%recv_current%next)
   ENDDO

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! SPECIAL MESSAGES FROM THE SOUTH POLE
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   DO panel = 0,3
      tag_counter = tag_counter+1
      nsd_dest    = panel*isdm*jsdm+isdm

      msg_instr(nsd_south)%send_current%msg_tag    = tag_counter
      msg_instr(nsd_south)%send_current%nsd_dest   = nsd_dest
      msg_instr(nsd_south)%send_current%i_start    = iim-1
      msg_instr(nsd_south)%send_current%j_start    = 1
      msg_instr(nsd_south)%send_current%di         = 0
      msg_instr(nsd_south)%send_current%dj         = 0
      msg_instr(nsd_south)%send_current%msg_length = 1
      msg_instr(nsd_south)%send_current%instr_recv =>                        & 
                                        msg_instr(nsd_dest)%recv_current

      msg_instr(nsd_dest)%recv_current%msg_tag    = tag_counter
      msg_instr(nsd_dest)%recv_current%nsd_sour   = nsd_south
      msg_instr(nsd_dest)%recv_current%i_start    = iim-1
      msg_instr(nsd_dest)%recv_current%j_start    = 1
      msg_instr(nsd_dest)%recv_current%di         = 0
      msg_instr(nsd_dest)%recv_current%dj         = 0
      msg_instr(nsd_dest)%recv_current%msg_length = 1
      msg_instr(nsd_dest)%recv_current%instr_send =>                         & 
                                       msg_instr(nsd_south)%send_current
!-----------------------------------------------------------------------
!  determine how to unpack verticies and edges 
!-----------------------------------------------------------------------
      msg_instr(nsd_dest)%recv_current%unpack_vrtx(:,:) = -999
      msg_instr(nsd_dest)%recv_current%unpack_edge(:,:) = -999
!-----------------------------------------------------------------------
!  allocate a new node at the end of the list
!-----------------------------------------------------------------------
      ALLOCATE (msg_instr(nsd_south)%send_current%next,                      &
                msg_instr(nsd_dest)%recv_current%next)
      msg_instr(nsd_south)%send_current =>                                   &
                                  msg_instr(nsd_south)%send_current%next
      msg_instr(nsd_dest)%recv_current =>                                    &
                                   msg_instr(nsd_dest)%recv_current%next
      NULLIFY (msg_instr(nsd_south)%send_current%next)
      NULLIFY (msg_instr(nsd_dest )%recv_current%next)
   ENDDO

   END SUBROUTINE set_pole_messages
!=======================================================================
!  END    set_pole_messages
!=======================================================================

!=======================================================================
!  BEGIN  equal_listQ
!=======================================================================
   LOGICAL FUNCTION equal_listQ (ndata,list1,list2)
!.......................................................................
!  INTENT IN
!.......................................................................
   INTEGER (KIND=int_kind),INTENT ( IN) ::                                   &
      ndata,list1(ndata),list2(ndata)
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) :: n
!.......................................................................

   equal_listQ = .TRUE.
   DO n = 1,ndata
      IF (list1(n)/=list2(n)) equal_listQ = .FALSE.
   ENDDO

   END FUNCTION equal_listQ
!=======================================================================
!  END  equal_listQ
!=======================================================================

!=======================================================================
!  BEGIN  trim_messages
!=======================================================================
   SUBROUTINE trim_messages (nsdm_glbl,msg_instr)
!.......................................................................
!  INTENT IN
!.......................................................................
   INTEGER (KIND=int_kind),INTENT ( IN) ::                                   &
      nsdm_glbl
!.......................................................................
!  INTENT OUT
!.......................................................................
   TYPE (message_instructions),INTENT (OUT) ::                               &
      msg_instr(nsdm_glbl)
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) ::                                                &
      nsd
!.......................................................................

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  THE SEND AND RECEIVE INSTRUCTION LISTS ARE ONE NODE TOO LONG
!  DEALLOCATE THE LAST NODE
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   DO nsd = 1,nsdm_glbl
      msg_instr(nsd)%send_current => msg_instr(nsd)%send
      DO WHILE (ASSOCIATED (msg_instr(nsd)%send_current%next%next))
         msg_instr(nsd)%send_current => msg_instr(nsd)%send_current%next
      ENDDO
      DEALLOCATE (msg_instr(nsd)%send_current%next)
      NULLIFY    (msg_instr(nsd)%send_current%next)

      msg_instr(nsd)%recv_current => msg_instr(nsd)%recv
      DO WHILE (ASSOCIATED (msg_instr(nsd)%recv_current%next%next))
         msg_instr(nsd)%recv_current => msg_instr(nsd)%recv_current%next
      ENDDO
      DEALLOCATE (msg_instr(nsd)%recv_current%next)
      NULLIFY    (msg_instr(nsd)%recv_current%next)
   ENDDO

   END SUBROUTINE trim_messages
!=======================================================================
!  END    trim_messages
!=======================================================================

!=======================================================================
!  BEGIN  set_parallel_structure
!=======================================================================
   SUBROUTINE set_parallel_structure (npe_comp,nsdm_glbl,                    &
                                                 sbdmn_assign,msg_instr)
!.......................................................................
!  INTENT IN
!.......................................................................
   INTEGER (KIND=int_kind),INTENT ( IN) ::                                   &
      npe_comp,nsdm_glbl
   TYPE (sbdmn_assign_type),INTENT ( IN) ::                                  &
      sbdmn_assign
!.......................................................................
!  INTENT OUT
!.......................................................................
   TYPE (message_instructions),INTENT (OUT) ::                               &
      msg_instr(nsdm_glbl)
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) ::                                                &
      nsd,task,nsdm_local,nsd_local
!.......................................................................

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  SET task AND nsd_local FOR SEND AND RECV MESSAGES
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   DO task = 0,npe_comp-1
      nsdm_local = sbdmn_assign%length(task+1)
      DO nsd_local = 1,nsdm_local
         DO nsd = 1,nsdm_glbl
            IF (nsd==sbdmn_assign%sd(task+1,nsd_local)) THEN

               msg_instr(nsd)%send_current => msg_instr(nsd)%send
               DO WHILE (ASSOCIATED (msg_instr(nsd)%send_current))
                  msg_instr(nsd)%send_current%task      = task
                  msg_instr(nsd)%send_current%nsd_local = nsd_local
                  msg_instr(nsd)%send_current =>                             &
                                        msg_instr(nsd)%send_current%next
               ENDDO

               msg_instr(nsd)%recv_current => msg_instr(nsd)%recv
               DO WHILE (ASSOCIATED (msg_instr(nsd)%recv_current))
                  msg_instr(nsd)%recv_current%task      = task
                  msg_instr(nsd)%recv_current%nsd_local = nsd_local
                  msg_instr(nsd)%recv_current =>                             &
                                        msg_instr(nsd)%recv_current%next
               ENDDO
            ENDIF
         ENDDO
      ENDDO
   ENDDO

   END SUBROUTINE set_parallel_structure
!=======================================================================
!  END  set_parallel_structure
!=======================================================================

!=======================================================================
!  BEGIN  set_task_instr
!=======================================================================
   SUBROUTINE set_task_instr (npe_comp,nsdm_glbl,msg_instr,task_instr)
!.......................................................................
!  INTENT IN
!.......................................................................
   INTEGER (KIND=int_kind),INTENT ( IN) ::                                   &
      npe_comp,nsdm_glbl
   TYPE (message_instructions) ::                                            &
      msg_instr(nsdm_glbl)
!.......................................................................
!  INTENT OUT
!.......................................................................
   TYPE (message_instructions),INTENT (OUT) ::                               &
      task_instr(npe_comp,npe_comp)
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) ::                                                &
      nsd,task1,task2
   TYPE (send_node),POINTER ::                                               &
      send_temp
   TYPE (recv_node),POINTER ::                                               &
      recv_temp
!.......................................................................

   DO task2 = 1,npe_comp
      DO task1 = 1,npe_comp
         NULLIFY (task_instr(task1,task2)%send)
         NULLIFY (task_instr(task1,task2)%recv)
      ENDDO
   ENDDO

   DO nsd = 1,nsdm_glbl

      msg_instr(nsd)%send_current => msg_instr(nsd)%send

      DO WHILE (ASSOCIATED (msg_instr(nsd)%send_current))

         send_temp => msg_instr(nsd)%send_current
         recv_temp => msg_instr(nsd)%send_current%instr_recv

         task1 =  send_temp%task;  task2 =  recv_temp%task

         IF (.NOT.ASSOCIATED(task_instr(task1+1,task2+1)%send)) THEN
            ALLOCATE (task_instr(task1+1,task2+1)%send)
            task_instr(task1+1,task2+1)%send_current =>                      &
                                        task_instr(task1+1,task2+1)%send
         ENDIF
         IF (.NOT.ASSOCIATED(task_instr(task2+1,task1+1)%recv)) THEN
            ALLOCATE (task_instr(task2+1,task1+1)%recv)
            task_instr(task2+1,task1+1)%recv_current =>                      &
                                        task_instr(task2+1,task1+1)%recv
         ENDIF

         CALL copy_send_node (send_temp,                                     &
                               task_instr(task1+1,task2+1)%send_current)
         CALL copy_recv_node (recv_temp,                                     &
                               task_instr(task2+1,task1+1)%recv_current)

         task_instr(task1+1,task2+1)%send_current%instr_recv =>              &
                                task_instr(task2+1,task1+1)%recv_current
         task_instr(task2+1,task1+1)%recv_current%instr_send =>              &
                                task_instr(task1+1,task2+1)%send_current
!-----------------------------------------------------------------------
!  allocate a new node at the end of the list
!-----------------------------------------------------------------------
         ALLOCATE (task_instr(task1+1,task2+1)%send_current%next,            &
                   task_instr(task2+1,task1+1)%recv_current%next)
         task_instr(task1+1,task2+1)%send_current =>                         &
                           task_instr(task1+1,task2+1)%send_current%next
         task_instr(task2+1,task1+1)%recv_current =>                         &
                           task_instr(task2+1,task1+1)%recv_current%next

         NULLIFY (task_instr(task1+1,task2+1)%send_current%next)
         NULLIFY (task_instr(task2+1,task1+1)%recv_current%next)

         msg_instr(nsd)%send_current => msg_instr(nsd)%send_current%next
      ENDDO
   ENDDO

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  THE SEND AND RECEIVE INSTRUCTION LISTS ARE ONE NODE TOO LONG
!  DEALLOCATE THE LAST NODE
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   DO task1 = 0,npe_comp-1
      DO task2 = 0,npe_comp-1

         IF (ASSOCIATED (task_instr(task1+1,task2+1)%send)) THEN
            task_instr(task1+1,task2+1)%send_current =>                      &
                                        task_instr(task1+1,task2+1)%send

            DO WHILE (                                                       &
               ASSOCIATED (task_instr(task1+1,task2+1)%send_current%next%next))   
               task_instr(task1+1,task2+1)%send_current =>                   &
                           task_instr(task1+1,task2+1)%send_current%next
            ENDDO

            DEALLOCATE (task_instr(task1+1,task2+1)%send_current%next)
            NULLIFY    (task_instr(task1+1,task2+1)%send_current%next)
         ENDIF

         IF (ASSOCIATED (task_instr(task1+1,task2+1)%recv)) THEN

            task_instr(task1+1,task2+1)%recv_current =>                      &
                                        task_instr(task1+1,task2+1)%recv
            DO WHILE (                                                       &
               ASSOCIATED (task_instr(task1+1,task2+1)%recv_current%next%next))
               task_instr(task1+1,task2+1)%recv_current =>                   &
                           task_instr(task1+1,task2+1)%recv_current%next
            ENDDO
            DEALLOCATE (task_instr(task1+1,task2+1)%recv_current%next)
            NULLIFY    (task_instr(task1+1,task2+1)%recv_current%next)
         ENDIF
      ENDDO
   ENDDO

   END SUBROUTINE set_task_instr
!=======================================================================
!  END  set_task_instr
!=======================================================================

!=======================================================================
!  BEGIN  copy_send_node
!=======================================================================
   SUBROUTINE copy_send_node (node_a,node_b)
   TYPE (send_node),POINTER :: node_a,node_b
!.......................................................................
   node_b%msg_tag    = node_a%msg_tag
   node_b%nsd_dest   = node_a%nsd_dest
   node_b%i_start    = node_a%i_start
   node_b%j_start    = node_a%j_start
   node_b%di         = node_a%di
   node_b%dj         = node_a%dj
   node_b%msg_length = node_a%msg_length

   node_b%task       = node_a%task
   node_b%nsd_local  = node_a%nsd_local

   END SUBROUTINE copy_send_node
!=======================================================================
!  END    copy_send_node
!=======================================================================

!=======================================================================
!  BEGIN  copy_recv_node
!=======================================================================
   SUBROUTINE copy_recv_node (node_a,node_b)
   TYPE (recv_node),POINTER :: node_a,node_b
!.......................................................................
   node_b%msg_tag          = node_a%msg_tag
   node_b%nsd_sour         = node_a%nsd_sour
   node_b%i_start          = node_a%i_start
   node_b%j_start          = node_a%j_start
   node_b%di               = node_a%di
   node_b%dj               = node_a%dj
   node_b%msg_length       = node_a%msg_length

   node_b%task             = node_a%task
   node_b%nsd_local        = node_a%nsd_local

   node_b%unpack_vrtx(:,:) = node_a%unpack_vrtx(:,:)
   node_b%unpack_edge(:,:) = node_a%unpack_edge(:,:)

   END SUBROUTINE copy_recv_node
!=======================================================================
!  END    copy_recv_node
!=======================================================================

!=======================================================================
!  BEGIN  set_total_length
!=======================================================================
   SUBROUTINE set_total_length (npe_comp,task_instr,                         &
                                    total_send_length,total_recv_length)
!.......................................................................
!  INTENT IN
!.......................................................................
   INTEGER (KIND=int_kind),INTENT ( IN) ::                                   &
      npe_comp
   TYPE (message_instructions),INTENT ( IN) ::                               &
      task_instr(npe_comp,npe_comp)
!.......................................................................
!  INTENT OUT
!.......................................................................
   INTEGER (KIND=int_kind),INTENT (OUT) ::                                   &
      total_send_length(npe_comp,npe_comp),                                  &
      total_recv_length(npe_comp,npe_comp)
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) ::                                                &
      task1,task2,sum_sum
   TYPE (send_node),POINTER ::                                               &
      send_current
   TYPE (recv_node),POINTER ::                                               &
      recv_current
!.......................................................................

   DO task1 = 1,npe_comp
      DO task2 = 1,npe_comp
         sum_sum = 0
         send_current => task_instr(task1,task2)%send
         DO WHILE (ASSOCIATED (send_current))
            sum_sum = sum_sum + send_current%msg_length
            send_current => send_current%next
         ENDDO
         total_send_length(task1,task2) = sum_sum
      ENDDO
   ENDDO

   DO task1 = 1,npe_comp
      DO task2 = 1,npe_comp
         sum_sum = 0
         recv_current => task_instr(task1,task2)%recv
         DO WHILE (ASSOCIATED (recv_current))

            sum_sum = sum_sum + recv_current%msg_length
            recv_current => recv_current%next
         ENDDO
         total_recv_length(task1,task2) = sum_sum
      ENDDO
   ENDDO

   END SUBROUTINE set_total_length
!=======================================================================
!  END set_total_length
!=======================================================================

!=======================================================================
!  BEGIN wrap
!=======================================================================
   SUBROUTINE wrap (component_name,l_HA_stencil,                             &
                      face,face_1L,                                          &
                      vrtx,vrtx_1L,vrtx_scalar,vrtx_scalar_1L,               &
                      edge,edge_1L,edge_scalar,edge_scalar_1L )
!.......................................................................
!  INTENT IN
!.......................................................................
   CHARACTER (LEN=*),INTENT ( IN) ::                                         &
      component_name
   LOGICAL (KIND=log_kind),OPTIONAL,INTENT( IN) ::                           &
      l_HA_stencil
!.......................................................................
!  INTENT IN AND OUT
!.......................................................................
   REAL (KIND=dbl_kind),OPTIONAL ::                                          &
      face       (    :,:,:,:),        face_1L(    :,:,  :),                 &
      vrtx       (:,:,:,:,:,:),        vrtx_1L(:,:,:,:,  :),                 &
      vrtx_scalar(  :,:,:,:,:), vrtx_scalar_1L(  :,:,:,  :),                 &
      edge       (:,:,:,:,:,:),        edge_1L(:,:,:,:,  :),                 &
      edge_scalar(  :,:,:,:,:), edge_scalar_1L(  :,:,:,  :)
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) ::                                                &
      nspace,nvrtx,nedge,nlayer,nsdm,i3(3),i4(4),i5(5)
   INTEGER (KIND=int_kind) ::                                                &
      isdm,jsdm,iim,jjm,my_task,nsd,nsd_glbl,nsd_offset
   REAL (KIND=dbl_kind),ALLOCATABLE ::                                       &
      temp_rnk4(:,:,:,:),temp_rnk6(:,:,:,:,:,:)
   TYPE (component_node),POINTER ::                                          &
      current
!.......................................................................
   current => get_component_pointer (component_name)

! if SCM then return
   IF (current%max_ig == 1) RETURN

#if NPE_COMP > 4
   IF (PRESENT (face)) CALL wrap_all (current,x1in=face)
   IF (PRESENT (vrtx)) CALL wrap_all (current,x2in=vrtx)
   IF (PRESENT (edge)) CALL wrap_all (current,x2in=edge)

   IF (PRESENT (face_1L)) THEN
      i3(:) = SHAPE (face_1L)
      ALLOCATE (temp_rnk4(i3(1),i3(2),1,i3(3)))
      temp_rnk4(:,:,1,:) = face_1L(:,:,:)
      CALL wrap_all (current,x1in=temp_rnk4)
      face_1L(:,:,:) = temp_rnk4(:,:,1,:)
   ENDIF

   IF (PRESENT (vrtx_1L)) THEN
      i5(:) = SHAPE (vrtx_1L)
      ALLOCATE (temp_rnk6(i5(1),i5(2),i5(3),i5(4),1,i5(5)))
      temp_rnk6(:,:,:,:,1,:) = vrtx_1L(:,:,:,:,:)
      CALL wrap_all (current,x2in=temp_rnk6)
      vrtx_1L(:,:,:,:,:) = temp_rnk6(:,:,:,:,1,:)
   ENDIF

   IF (PRESENT (edge_1L)) THEN
      i5(:) = SHAPE (edge_1L)
      ALLOCATE (temp_rnk6(i5(1),i5(2),i5(3),i5(4),1,i5(5)))
      temp_rnk6(:,:,:,:,1,:) = edge_1L(:,:,:,:,:)
      CALL wrap_all (current,x2in=temp_rnk6)
      edge_1L(:,:,:,:,:) = temp_rnk6(:,:,:,:,1,:)
   ENDIF

   IF (PRESENT (vrtx_scalar)) THEN
      i5(:) = SHAPE (vrtx_scalar)
      ALLOCATE (temp_rnk6(1,i5(1),i5(2),i5(3),i5(4),i5(5)))
      temp_rnk6(1,:,:,:,:,:) = vrtx_scalar(:,:,:,:,:)
      CALL wrap_all (current,x2in=temp_rnk6)
      vrtx_scalar(:,:,:,:,:) = temp_rnk6(1,:,:,:,:,:)
   ENDIF
   
   IF (PRESENT (edge_scalar)) THEN
      i5(:) = SHAPE (edge_scalar)
      ALLOCATE (temp_rnk6(1,i5(1),i5(2),i5(3),i5(4),i5(5)))
      temp_rnk6(1,:,:,:,:,:) = edge_scalar(:,:,:,:,:)
      CALL wrap_all (current,x2in=temp_rnk6)
      edge_scalar(:,:,:,:,:) = temp_rnk6(1,:,:,:,:,:)
   ENDIF

   IF (PRESENT (vrtx_scalar_1L)) THEN
      i4(:) = SHAPE (vrtx_scalar_1L)
      ALLOCATE (temp_rnk6(1,i4(1),i4(2),i4(3),1,i4(4)))
      temp_rnk6(1,:,:,:,1,:) = vrtx_scalar_1L(:,:,:,:)
      CALL wrap_all (current,x2in=temp_rnk6)
      vrtx_scalar_1L(:,:,:,:) = temp_rnk6(1,:,:,:,1,:)
   ENDIF
   
   IF (PRESENT (edge_scalar_1L)) THEN
      i4(:) = SHAPE (edge_scalar_1L)
      ALLOCATE (temp_rnk6(1,i4(1),i4(2),i4(3),1,i4(4)))
      temp_rnk6(1,:,:,:,1,:) = edge_scalar_1L(:,:,:,:)
      CALL wrap_all (current,x2in=temp_rnk6)
      edge_scalar_1L(:,:,:,:) = temp_rnk6(1,:,:,:,1,:)
   ENDIF
#else
   IF (PRESENT (face)) CALL wrap_all (current,x1=face)
   IF (PRESENT (vrtx)) CALL wrap_all (current,x2=vrtx)
   IF (PRESENT (edge)) CALL wrap_all (current,x2=edge)

   IF (PRESENT (face_1L)) THEN
      i3(:) = SHAPE (face_1L)
      ALLOCATE (temp_rnk4(i3(1),i3(2),1,i3(3)))
      temp_rnk4(:,:,1,:) = face_1L(:,:,:)
      CALL wrap_all (current,x1=temp_rnk4)
      face_1L(:,:,:) = temp_rnk4(:,:,1,:)
   ENDIF

   IF (PRESENT (vrtx_1L)) THEN
      i5(:) = SHAPE (vrtx_1L)
      ALLOCATE (temp_rnk6(i5(1),i5(2),i5(3),i5(4),1,i5(5)))
      temp_rnk6(:,:,:,:,1,:) = vrtx_1L(:,:,:,:,:)
      CALL wrap_all (current,x2=temp_rnk6)
      vrtx_1L(:,:,:,:,:) = temp_rnk6(:,:,:,:,1,:)
   ENDIF

   IF (PRESENT (edge_1L)) THEN
      i5(:) = SHAPE (edge_1L)
      ALLOCATE (temp_rnk6(i5(1),i5(2),i5(3),i5(4),1,i5(5)))
      temp_rnk6(:,:,:,:,1,:) = edge_1L(:,:,:,:,:)
      CALL wrap_all (current,x2=temp_rnk6)
      edge_1L(:,:,:,:,:) = temp_rnk6(:,:,:,:,1,:)
   ENDIF

   IF (PRESENT (vrtx_scalar)) THEN
      i5(:) = SHAPE (vrtx_scalar)
      ALLOCATE (temp_rnk6(1,i5(1),i5(2),i5(3),i5(4),i5(5)))
      temp_rnk6(1,:,:,:,:,:) = vrtx_scalar(:,:,:,:,:)
      CALL wrap_all (current,x2=temp_rnk6)
      vrtx_scalar(:,:,:,:,:) = temp_rnk6(1,:,:,:,:,:)
   ENDIF
   
   IF (PRESENT (edge_scalar)) THEN
      i5(:) = SHAPE (edge_scalar)
      ALLOCATE (temp_rnk6(1,i5(1),i5(2),i5(3),i5(4),i5(5)))
      temp_rnk6(1,:,:,:,:,:) = edge_scalar(:,:,:,:,:)
      CALL wrap_all (current,x2=temp_rnk6)
      edge_scalar(:,:,:,:,:) = temp_rnk6(1,:,:,:,:,:)
   ENDIF

   IF (PRESENT (vrtx_scalar_1L)) THEN
      i4(:) = SHAPE (vrtx_scalar_1L)
      ALLOCATE (temp_rnk6(1,i4(1),i4(2),i4(3),1,i4(4)))
      temp_rnk6(1,:,:,:,1,:) = vrtx_scalar_1L(:,:,:,:)
      CALL wrap_all (current,x2=temp_rnk6)
      vrtx_scalar_1L(:,:,:,:) = temp_rnk6(1,:,:,:,1,:)
   ENDIF
   
   IF (PRESENT (edge_scalar_1L)) THEN
      i4(:) = SHAPE (edge_scalar_1L)
      ALLOCATE (temp_rnk6(1,i4(1),i4(2),i4(3),1,i4(4)))
      temp_rnk6(1,:,:,:,1,:) = edge_scalar_1L(:,:,:,:)
      CALL wrap_all (current,x2=temp_rnk6)
      edge_scalar_1L(:,:,:,:) = temp_rnk6(1,:,:,:,1,:)
   ENDIF
#endif
   IF (ALLOCATED  (temp_rnk4)) DEALLOCATE (temp_rnk4)
   IF (ALLOCATED  (temp_rnk6)) DEALLOCATE (temp_rnk6)

!-----------------------------------------------------------------------
!  if Hsu-Arakawa advection stencil is true and (iim-1,jjm-1) is a pentagon,
!  then set (1,iim  ,jjm-1) and (3,iim-1,jjm  ) to zero
!-----------------------------------------------------------------------
   IF (PRESENT (edge_scalar)) THEN
      IF (PRESENT (l_HA_stencil)) THEN
         IF (l_HA_stencil) THEN
            isdm = current%isdm; jsdm = current%jsdm
            iim  = current%iim;  jjm  = current%jjm
            my_task = current%my_task
            DO nsd = 1,current%sbdmn_assign%length(my_task+1)
               nsd_glbl   = current%sbdmn_assign%sd(my_task+1,nsd)
               nsd_offset = MOD (nsd_glbl-1,isdm*jsdm)+1
               IF ((nsd_offset == (isdm-1)*jsdm).OR.                         &
                                         (nsd_offset == isdm*jsdm)) THEN
                  edge_scalar(1,iim  ,jjm-1,:,nsd) = 0.0_dbl_kind
                  edge_scalar(3,iim-1,jjm  ,:,nsd) = 0.0_dbl_kind
               ENDIF
            ENDDO
         ENDIF
      ENDIF
   ENDIF

   END SUBROUTINE wrap
!=======================================================================
!  END wrap
!=======================================================================

!=======================================================================
!  BEGIN  wrap_all
!=======================================================================
#if NPE_COMP > 4
   SUBROUTINE wrap_all (wrap_instr,x1in,x2in)
#else
   SUBROUTINE wrap_all (wrap_instr,x1,x2)
#endif

#if mpi == 1
   INCLUDE 'mpif.h'
#endif
!.......................................................................
!  INTENT IN
!.......................................................................
   TYPE (component_node),POINTER ::                                          &
      wrap_instr
!.......................................................................
!  INTENT IN AND OUT
!.......................................................................
#if NPE_COMP > 4
   REAL (KIND=dbl_kind),OPTIONAL ::                                          &
      x1in(:,:,:,:),x2in(:,:,:,:,:,:)
#else
   REAL (KIND=dbl_kind),OPTIONAL ::                                          &
      x1(:,:,:,:),x2(:,:,:,:,:,:)
#endif
!.......................................................................
!  LOCAL
!.......................................................................
   LOGICAL (KIND=log_kind) ::                                                &
      l_face,l_vrtx,l_edge
   INTEGER (KIND=int_kind) ::                                                &
      nspace,nthing,iim,jjm,nlayer,nsdm,nsd_glbl,nsd_offset,                 &
      isdm,jsdm,nsd,nsd_np,nsd_sp

   INTEGER (KIND=int_kind) ::                                                &
      npe_comp,my_task,count_recv_req,task_sour,count_send_req,task_dest,    &
      msg_length,total_length,count,n,m,MPI_FLOAT_TYPE,ierr, nsdm_loc, task, &
      ccount, ttag, dest, cont, src, offset,comm
   INTEGER (KIND=int_kind) ::                                                &
      i1,j1,i1_start,j1_start,di1,dj1,nsd1,                                  &
      i2,j2,i2_start,j2_start,di2,dj2,nsd2

   INTEGER (KIND=int_kind),ALLOCATABLE ::                                    &
      up(:,:)  
   INTEGER (KIND=int_kind),ALLOCATABLE ::                                    &
      send_req(:),recv_req(:),send_status(:,:),recv_status(:,:), bstatus(:)

   TYPE (send_node),POINTER ::                                               &
      instr_send
   TYPE (recv_node),POINTER ::                                               &
      instr_recv

   TYPE buffer_node
      INTEGER (KIND=int_kind) ::                                             &
         msg_tag,task_sour,task_dest,total_size
      REAL (KIND=dbl_kind),POINTER :: data_rnk2(:,:),data_rnk4(:,:,:,:)
      TYPE (buffer_node),POINTER :: next
   END TYPE buffer_node

   TYPE (buffer_node),POINTER ::                                             &
      buffer_recv,buffer_send,buffer_temp,current1,current2

#if NPE_COMP > 4
   REAL (KIND=dbl_kind),allocatable, dimension(:,:,:,:)   :: x1
   REAL (KIND=dbl_kind),allocatable, dimension(:,:,:,:,:,:) :: x2
#endif

!.......................................................................
#if NPE_COMP > 4
   npe_comp       = wrap_instr%npe_comp_wrap
   my_task        = wrap_instr%my_task_wrap
   comm           = wrap_instr%MPI_communicator_wrap 
#else
   npe_comp       = wrap_instr%npe_comp
   my_task        = wrap_instr%my_task
   comm           = wrap_instr%MPI_communicator
#endif
   MPI_FLOAT_TYPE = wrap_instr%MPI_FLOAT_TYPE

   l_face = .FALSE.; l_vrtx = .FALSE.; l_edge = .FALSE.
#if NPE_COMP > 4
   IF (PRESENT (x1in)) THEN
      iim    = SIZE (x1in,DIM=1)
      jjm    = SIZE (x1in,DIM=2)
      nlayer = SIZE (x1in,DIM=3)
      nsdm   = SIZE (x1in,DIM=4)
      l_face = .TRUE.
   ENDIF
   IF (PRESENT (x2in)) THEN
      nspace = SIZE (x2in,DIM=1)
      nthing = SIZE (x2in,DIM=2)
      iim    = SIZE (x2in,DIM=3)
      jjm    = SIZE (x2in,DIM=4)
      nlayer = SIZE (x2in,DIM=5)
      nsdm   = SIZE (x2in,DIM=6)
      IF (nthing==2) l_vrtx = .TRUE.
      IF (nthing==3) l_edge = .TRUE.
   ENDIF
#else
   IF (PRESENT (x1)) THEN
      iim    = SIZE (x1,DIM=1)
      jjm    = SIZE (x1,DIM=2)
      nlayer = SIZE (x1,DIM=3)
      nsdm   = SIZE (x1,DIM=4)
      l_face = .TRUE.
   ENDIF
   IF (PRESENT (x2)) THEN
      nspace = SIZE (x2,DIM=1)
      nthing = SIZE (x2,DIM=2)
      iim    = SIZE (x2,DIM=3)
      jjm    = SIZE (x2,DIM=4)
      nlayer = SIZE (x2,DIM=5)
      nsdm   = SIZE (x2,DIM=6)
      IF (nthing==2) l_vrtx = .TRUE.
      IF (nthing==3) l_edge = .TRUE.
   ENDIF
#endif
   IF (l_vrtx.OR.l_edge) THEN
      ALLOCATE (up(3,nthing))
   ENDIF

#if NPE_COMP > 4
if(wrap_instr%jsdm > 1) then

if(my_task >=0) then
     if(present(x1in)) then
       allocate(x1(iim,jjm,nlayer,nsdm* wrap_instr%npe_comp_gath))
       x1(:,:,:,1:nsdm) = x1in(:,:,:,1:nsdm)
       ccount = iim*jjm*nlayer*nsdm
     endif
     if(present(x2in)) then
       allocate(x2(nspace,nthing,iim,jjm,nlayer,nsdm* wrap_instr%npe_comp_gath))
       x2(:,:,:,:,:,1:nsdm) = x2in(:,:,:,:,:,1:nsdm)
       ccount = iim*jjm*nlayer*nsdm*nspace*nthing
     endif
#if mpi == 1
     allocate(bstatus(mpi_status_size))
     do task = 1,wrap_instr%npe_comp_gath-1
     
     ! receive here
       ttag = wrap_instr%my_task + task
       src = ttag
       offset = task*nsdm + 1
       if(present(x1in))                 &
          call mpi_recv(x1(1,1,1,offset),ccount,MPI_FLOAT_TYPE,src,ttag,wrap_instr%MPI_communicator,bstatus,ierr)
       if(present(x2in))                 &
          call mpi_recv(x2(1,1,1,1,1,offset),ccount,MPI_FLOAT_TYPE,src,ttag,wrap_instr%MPI_communicator,bstatus,ierr)
     enddo
   else
     ! send here
     allocate(bstatus(mpi_status_size))
     ttag = wrap_instr%my_task
     dest = (wrap_instr%my_task / wrap_instr%npe_comp_gath) * wrap_instr%npe_comp_gath
     if(present(x1in)) then             
       ccount = iim*jjm*nlayer*nsdm
       call mpi_send(x1in,ccount,MPI_FLOAT_TYPE,dest,ttag,wrap_instr%MPI_communicator,ierr)
     endif
     if(present(x2in)) then
       ccount = iim*jjm*nlayer*nsdm*nspace*nthing
       call mpi_send(x2in,ccount,MPI_FLOAT_TYPE,dest,ttag,wrap_instr%MPI_communicator,ierr)
     endif
#endif
endif
   nsdm = nsdm * wrap_instr%npe_comp_gath

else ! if (jsdm =1)

!  if(wrap_instr%sbdmn_assign%length(wrap_instr%my_task) > 0 ) then
     if(present(x1in)) then
       allocate(x1(iim,jjm,nlayer,nsdm))
       x1(:,:,:,1:nsdm) = x1in(:,:,:,1:nsdm)
       ccount = iim*jjm*nlayer*nsdm
     endif
     if(present(x2in)) then
       allocate(x2(nspace,nthing,iim,jjm,nlayer,nsdm))
       x2(:,:,:,:,:,1:nsdm) = x2in(:,:,:,:,:,1:nsdm)
       ccount = iim*jjm*nlayer*nsdm*nspace*nthing
     endif
!  endif
endif
#endif
   
   

   if(my_task >= 0) then
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  RECEIVES
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ALLOCATE (buffer_recv)
   buffer_temp => buffer_recv
   NULLIFY (buffer_temp%data_rnk2); NULLIFY (buffer_temp%data_rnk4)
   NULLIFY (buffer_temp%next)
   count_recv_req = 0
!-----------------------------------------------------------------------
!  loop over tasks.  allocate recv buffers.
!-----------------------------------------------------------------------
   DO task_sour = 0,npe_comp-1
      IF (task_sour/=my_task) THEN
         instr_recv => wrap_instr%task_instr(my_task+1,task_sour+1)%recv
         IF (ASSOCIATED (instr_recv)) THEN
            count_recv_req = count_recv_req+1
            buffer_temp%msg_tag   = task_sour + npe_comp*my_task + 1
            buffer_temp%task_sour = task_sour
            total_length = wrap_instr%total_recv_length(my_task+1,task_sour+1)
            IF (l_face) THEN
               buffer_temp%total_size =               total_length*nlayer
               ALLOCATE (buffer_temp%data_rnk2(total_length,nlayer))
            ELSE
               buffer_temp%total_size = nspace*nthing*total_length*nlayer
               ALLOCATE (buffer_temp%                                        &
                           data_rnk4(nspace,nthing,total_length,nlayer))
            ENDIF

            ALLOCATE (buffer_temp%next)
            buffer_temp => buffer_temp%next
            NULLIFY (buffer_temp%data_rnk2); NULLIFY (buffer_temp%data_rnk4)
            NULLIFY (buffer_temp%next)
         ENDIF
      ENDIF
   ENDDO
!-----------------------------------------------------------------------
!  trim buff_recv list is one node too long.  trim buff_recv list
!-----------------------------------------------------------------------
   buffer_temp => buffer_recv
   IF (ASSOCIATED (buffer_temp%next)) THEN
      DO WHILE (ASSOCIATED (buffer_temp%next%next))
         buffer_temp => buffer_temp%next
      ENDDO
      DEALLOCATE (buffer_temp%next)
      NULLIFY    (buffer_temp%next)
   ENDIF
!-----------------------------------------------------------------------
!  post receives
!-----------------------------------------------------------------------
#if mpi == 1
   ALLOCATE (recv_req(count_recv_req)); recv_req(:) = -999
   buffer_temp => buffer_recv
   DO count = 1,count_recv_req
      IF (l_face) THEN
         CALL MPI_IRECV (                                                    &
            buffer_temp%data_rnk2(1,1),                                      &
            buffer_temp%total_size,MPI_FLOAT_TYPE,                           &
            buffer_temp%task_sour,buffer_temp%msg_tag,                       &
            comm,recv_req(count),ierr)
      ELSE
         CALL MPI_IRECV (                                                    &
            buffer_temp%data_rnk4(1,1,1,1),                                  &
            buffer_temp%total_size,MPI_FLOAT_TYPE,                           &
            buffer_temp%task_sour,buffer_temp%msg_tag,                       &       
            comm,recv_req(count),ierr)
      ENDIF
      IF (ASSOCIATED (buffer_temp%next)) buffer_temp => buffer_temp%next
   ENDDO
#endif

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  SENDS
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ALLOCATE (buffer_send)
   buffer_temp => buffer_send
   NULLIFY (buffer_temp%data_rnk2); NULLIFY (buffer_temp%data_rnk4)
   NULLIFY (buffer_temp%next)
   count_send_req = 0
!-----------------------------------------------------------------------
!  loop over tasks.  allocate and load send buffers
!-----------------------------------------------------------------------
   DO task_dest = 0,npe_comp-1
      IF (task_dest/=my_task) THEN
         instr_send => wrap_instr%task_instr(my_task+1,task_dest+1)%send
         IF (ASSOCIATED (instr_send)) THEN
            count_send_req = count_send_req+1
            buffer_temp%msg_tag   = my_task + npe_comp*task_dest + 1
            buffer_temp%task_dest = task_dest
            total_length = wrap_instr%total_send_length(my_task+1,task_dest+1)
            IF (l_face) THEN
               buffer_temp%total_size =               total_length*nlayer
               ALLOCATE (buffer_temp%data_rnk2(total_length,nlayer))
            ELSE
               buffer_temp%total_size = nspace*nthing*total_length*nlayer
               ALLOCATE (buffer_temp%                                        &
                           data_rnk4(nspace,nthing,total_length,nlayer))
            ENDIF

            count = 0
            DO WHILE (ASSOCIATED (instr_send))
               i1_start   = instr_send%i_start; j1_start   = instr_send%j_start
               di1        = instr_send%di;      dj1        = instr_send%dj
               nsd1       = instr_send%nsd_local
               msg_length = instr_send%msg_length
               DO n = 1,msg_length
                  count = count + 1
                  i1 = i1_start+di1*(n-1); j1 = j1_start+dj1*(n-1)
                  IF (l_face) THEN
                     buffer_temp%data_rnk2(    count,:) = x1(    i1,j1,:,nsd1)
                  ELSE
                     buffer_temp%data_rnk4(:,:,count,:) = x2(:,:,i1,j1,:,nsd1)
                  ENDIF
               ENDDO
               instr_send => instr_send%next
            ENDDO

            ALLOCATE (buffer_temp%next)
            buffer_temp => buffer_temp%next
            NULLIFY (buffer_temp%data_rnk2); NULLIFY (buffer_temp%data_rnk4)
            NULLIFY (buffer_temp%next)
         ENDIF
      ENDIF
   ENDDO
!-----------------------------------------------------------------------
!  trim buff_send list is one node too long.  trim buff_send list
!-----------------------------------------------------------------------
   buffer_temp => buffer_send
   IF (ASSOCIATED (buffer_temp%next)) THEN
      DO WHILE (ASSOCIATED (buffer_temp%next%next))
         buffer_temp => buffer_temp%next
      ENDDO
      DEALLOCATE (buffer_temp%next)
      NULLIFY    (buffer_temp%next)
   ENDIF
!-----------------------------------------------------------------------
!  post sends
!-----------------------------------------------------------------------
#if mpi == 1
   ALLOCATE (send_req(count_send_req))
   send_req(:) = -999
   buffer_temp => buffer_send
   DO count = 1,count_send_req
      IF (l_face) THEN
         CALL MPI_ISEND (                                                    &
            buffer_temp%data_rnk2(1,1),                                      &
            buffer_temp%total_size,MPI_FLOAT_TYPE,                           &
            buffer_temp%task_dest,buffer_temp%msg_tag,                       &
            comm,send_req(count),ierr)
      ELSE
         CALL MPI_ISEND (                                                    &
            buffer_temp%data_rnk4(1,1,1,1),                                  &
            buffer_temp%total_size,MPI_FLOAT_TYPE,                           &
            buffer_temp%task_dest,buffer_temp%msg_tag,                       &
            comm,send_req(count),ierr)
      ENDIF
      IF (ASSOCIATED (buffer_temp%next)) buffer_temp => buffer_temp%next
   ENDDO
#endif
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  WHILE INTER-PROCESS MESSAGES ARE IN TRANSIT, 
!  APPLY MESSAGES WITHIN THE my_task PROCESS
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   instr_send => wrap_instr%task_instr(my_task+1,my_task+1)%send
   instr_recv => wrap_instr%task_instr(my_task+1,my_task+1)%recv

   DO WHILE (ASSOCIATED (instr_send))
      i1_start   = instr_send%i_start; j1_start   = instr_send%j_start
      di1        = instr_send%di;      dj1        = instr_send%dj
      nsd1       = instr_send%nsd_local
      msg_length = instr_send%msg_length

      i2_start   = instr_recv%i_start; j2_start   = instr_recv%j_start
      di2        = instr_recv%di;      dj2        = instr_recv%dj
      nsd2       = instr_recv%nsd_local

      IF (l_face) THEN
         DO n = 1,msg_length
            i1 = i1_start+di1*(n-1); j1 = j1_start+dj1*(n-1)
            i2 = i2_start+di2*(n-1); j2 = j2_start+dj2*(n-1)
            x1(i2,j2,:,nsd2) = x1(i1,j1,:,nsd1)
         ENDDO
      ELSE
         IF (l_vrtx) up(:,:) = instr_recv%unpack_vrtx(:,:)
         IF (l_edge) up(:,:) = instr_recv%unpack_edge(:,:)
         DO n = 1,msg_length
            i1 = i1_start+di1*(n-1); j1 = j1_start+dj1*(n-1)
            i2 = i2_start+di2*(n-1); j2 = j2_start+dj2*(n-1)
            DO m = 1,nthing
               IF (up(3,m)/=-999) THEN
                  x2(:,up(3,m),i2+up(1,m),j2+up(2,m),:,nsd2) =               &
                                                    x2(:,m,i1,j1,:,nsd1)
               ENDIF
            ENDDO
         ENDDO
      ENDIF

      instr_send => instr_send%next
      instr_recv => instr_recv%next
   ENDDO

#if mpi == 1
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  WAIT FOR MESSAGES TO BE SENT AND TO BE RECEIVED
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ALLOCATE (send_status(MPI_STATUS_SIZE,count_send_req))
   ALLOCATE (recv_status(MPI_STATUS_SIZE,count_recv_req))

   send_status(:,:) = 0; recv_status(:,:) = 0

   CALL MPI_WAITALL (count_send_req,send_req,send_status,ierr)
   CALL MPI_WAITALL (count_recv_req,recv_req,recv_status,ierr)
#endif
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  UNPACK BUFFERS
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   buffer_temp => buffer_recv
   DO task_sour = 0,npe_comp-1
      IF (task_sour/=my_task) THEN
         instr_recv => wrap_instr%task_instr(my_task+1,task_sour+1)%recv
         IF (ASSOCIATED (instr_recv)) THEN
            count = 0
            DO WHILE (ASSOCIATED (instr_recv))
               i2_start   = instr_recv%i_start; j2_start   = instr_recv%j_start
               di2        = instr_recv%di;      dj2        = instr_recv%dj
               nsd2       = instr_recv%nsd_local
               msg_length = instr_recv%msg_length
               IF (l_face) THEN
                  DO n = 1,msg_length
                     count = count + 1
                     i2 = i2_start+di2*(n-1); j2 = j2_start+dj2*(n-1)
                     x1(i2,j2,:,nsd2) = buffer_temp%data_rnk2(count,:)
                  ENDDO
               ELSE
                  IF (l_vrtx) up(:,:) = instr_recv%unpack_vrtx(:,:)
                  IF (l_edge) up(:,:) = instr_recv%unpack_edge(:,:)

                  DO n = 1,msg_length
                     count = count + 1
                     i2 = i2_start+di2*(n-1); j2 = j2_start+dj2*(n-1)
                     DO m = 1,nthing
                        IF (up(3,m)/=-999) THEN
                           x2(:,up(3,m),i2+up(1,m),j2+up(2,m),:,nsd2) =       &
                                      buffer_temp%data_rnk4(:,m,count,:)
                        ENDIF
                     ENDDO
                  ENDDO
               ENDIF
               instr_recv => instr_recv%next
            ENDDO
            buffer_temp => buffer_temp%next
         ENDIF
      ENDIF
   ENDDO

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  FACE WRAP
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   IF (l_face) THEN
      isdm = wrap_instr%isdm; jsdm = wrap_instr%jsdm
      nsd_np = isdm*(  jsdm-1)+1; nsd_sp = isdm*(4*jsdm+1)
      DO nsd = 1,wrap_instr%sbdmn_assign_wrap%length(my_task+1)
         nsd_glbl = wrap_instr%sbdmn_assign_wrap%sd(my_task+1,nsd)
!-----------------------------------------------------------------------
!  if not north or south pole, set dead cells to a representative value
!-----------------------------------------------------------------------
         IF ((nsd_glbl/=nsd_np).AND.(nsd_glbl/=nsd_sp)) THEN
            x1(iim,1,:,nsd) = x1(2,2,:,nsd)
            x1(1,jjm,:,nsd) = x1(2,2,:,nsd)
         ENDIF
!-----------------------------------------------------------------------
!  if (iim-1,jjm-1) is a pentagon, set the cell at (iim,jjm)
!  equal to the cell at (iim-1,jjm)
!-----------------------------------------------------------------------
         IF (MOD (nsd_glbl-1,isdm*jsdm)+1 == isdm*jsdm-jsdm) THEN
            x1(iim,jjm,:,nsd) = x1(iim-1,jjm,:,nsd)
         ENDIF
         IF (MOD (nsd_glbl-1,isdm*jsdm)+1 == isdm*jsdm     ) THEN
            x1(iim,jjm,:,nsd) = x1(iim-1,jjm,:,nsd)
         ENDIF
      ENDDO
   ENDIF

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  VERTEX WRAP
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   IF (l_vrtx) THEN
      isdm = wrap_instr%isdm; jsdm = wrap_instr%jsdm
      nsd_np = isdm*(  jsdm-1)+1; nsd_sp = isdm*(4*jsdm+1)
      DO nsd = 1,wrap_instr%sbdmn_assign_wrap%length(my_task+1)
         nsd_glbl = wrap_instr%sbdmn_assign_wrap%sd(my_task+1,nsd)
!-----------------------------------------------------------------------
!  fix-up the north and south poles
!-----------------------------------------------------------------------
         IF (nsd_glbl==nsd_np) THEN
            x2(:,2,1,jjm,:,nsd) = 0.0_dbl_kind
         ENDIF
         IF (nsd_glbl==nsd_sp) THEN
            x2(:,1,iim,1,:,nsd) = 0.0_dbl_kind
         ENDIF
!-----------------------------------------------------------------------
!  if (iim-1,jjm-1) is a pentagon, set both corners at (iim,jjm)
!  equal to each other
!-----------------------------------------------------------------------
         IF (MOD (nsd_glbl-1,isdm*jsdm)+1 == isdm*jsdm-jsdm) THEN
            x2(:,2,iim,jjm,:,nsd) = x2(:,1,iim,jjm,:,nsd)
         ENDIF
         IF (MOD (nsd_glbl-1,isdm*jsdm)+1 == isdm*jsdm     ) THEN
            x2(:,1,iim,jjm,:,nsd) = x2(:,2,iim,jjm,:,nsd)
         ENDIF
      ENDDO
   ENDIF

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  EDGE WRAP
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   IF (l_edge) THEN
      isdm = wrap_instr%isdm; jsdm = wrap_instr%jsdm
      DO nsd = 1,wrap_instr%sbdmn_assign_wrap%length(my_task+1)
         nsd_glbl   = wrap_instr%sbdmn_assign_wrap%sd(my_task+1,nsd)
         nsd_offset = MOD (nsd_glbl-1,isdm*jsdm)+1
!-----------------------------------------------------------------------
!  if (    1,    1) is a pentagon, set (:,2,    1,    1,:,:) to zero
!-----------------------------------------------------------------------
         IF ((nsd_offset ==    1).OR.(nsd_offset == jsdm+1)) THEN
            x2(:,2,    1,    1,:,nsd) = 0.0_dbl_kind
         ENDIF
!-----------------------------------------------------------------------
!  if (iim-1,    1) is a pentagon, set (:,3,iim-1,    1,:,:) to zero
!-----------------------------------------------------------------------
         IF ((nsd_offset == jsdm).OR.(nsd_offset == isdm  )) THEN
            x2(:,3,iim-1,    1,:,nsd) = 0.0_dbl_kind
         ENDIF
!-----------------------------------------------------------------------
!  if (    1,jjm-1) is a pentagon, set (:,1,    1,jjm-1,:,:) to zero
!-----------------------------------------------------------------------
         IF ((nsd_offset == isdm*(jsdm-1)+1).OR.                             &
                                   (nsd_offset == (isdm-1)*jsdm+1)) THEN
            x2(:,1,    1,jjm-1,:,nsd) = 0.0_dbl_kind
         ENDIF
!-----------------------------------------------------------------------
!  if (iim-1,jjm-1) is a pentagon, set (:,2,iim  ,jjm  ,:,:) to zero
!-----------------------------------------------------------------------
         IF ((nsd_offset == (isdm-1)*jsdm).OR.                               &
                                         (nsd_offset == isdm*jsdm)) THEN
            x2(:,2,iim  ,jjm  ,:,nsd) = 0.0_dbl_kind
         ENDIF
      ENDDO
   ENDIF

   IF (ALLOCATED  (up         )) DEALLOCATE (up         )
   IF (ALLOCATED  (send_req   )) DEALLOCATE (send_req   )
   IF (ALLOCATED  (recv_req   )) DEALLOCATE (recv_req   )
   IF (ALLOCATED  (send_status)) DEALLOCATE (send_status)
   IF (ALLOCATED  (recv_status)) DEALLOCATE (recv_status)

   current1 => buffer_send
   DO WHILE (ASSOCIATED (current1%next))
      current2 => current1%next
      IF (ASSOCIATED  (current1%data_rnk2)) DEALLOCATE (current1%data_rnk2)
      IF (ASSOCIATED  (current1%data_rnk4)) DEALLOCATE (current1%data_rnk4)
      DEALLOCATE (current1)
      current1 => current2
   ENDDO
   IF (ASSOCIATED  (current1%data_rnk2)) DEALLOCATE (current1%data_rnk2)
   IF (ASSOCIATED  (current1%data_rnk4)) DEALLOCATE (current1%data_rnk4)
   DEALLOCATE (current1)

   current1 => buffer_recv
   DO WHILE (ASSOCIATED (current1%next))
      current2 => current1%next
      IF (ASSOCIATED  (current1%data_rnk2)) DEALLOCATE (current1%data_rnk2)
      IF (ASSOCIATED  (current1%data_rnk4)) DEALLOCATE (current1%data_rnk4)
      DEALLOCATE (current1)
      current1 => current2
   ENDDO
   IF (ASSOCIATED  (current1%data_rnk2)) DEALLOCATE (current1%data_rnk2)
   IF (ASSOCIATED  (current1%data_rnk4)) DEALLOCATE (current1%data_rnk4)
   DEALLOCATE (current1)
   
   endif ! if (my_task >= 0)

#if NPE_COMP > 4
if(wrap_instr%jsdm > 1) then

   nsdm = nsdm / wrap_instr%npe_comp_gath
   
   if(my_task >=0) then

#if mpi == 1
! send here  
     do task = 1,wrap_instr%npe_comp_gath-1
     
       dest = wrap_instr%my_task + task
       ttag = dest
       offset = task*nsdm + 1
       if(present(x1in))                 &
          call mpi_send(x1(1,1,1,offset),ccount,MPI_FLOAT_TYPE,dest,ttag,wrap_instr%MPI_communicator,ierr)
       if(present(x2in))                 &
          call mpi_send(x2(1,1,1,1,1,offset),ccount,MPI_FLOAT_TYPE,dest,ttag,wrap_instr%MPI_communicator,ierr)
     enddo
#endif

     if(present(x1in)) then
       x1in(:,:,:,1:nsdm) = x1(:,:,:,1:nsdm)
       deallocate(x1)
     endif
     if(present(x2in)) then
       x2in(:,:,:,:,:,1:nsdm) = x2(:,:,:,:,:,1:nsdm)
       deallocate(x2)
     endif

#if mpi == 1
   else
   
!receive here
     src = (wrap_instr%my_task / wrap_instr%npe_comp_gath) * wrap_instr%npe_comp_gath
     ttag = wrap_instr%my_task
     offset = (ttag-src)*nsdm + 1
       if(present(x1in))                 &
          call mpi_recv(x1in,ccount,MPI_FLOAT_TYPE,src,ttag,wrap_instr%MPI_communicator,bstatus, ierr)
       if(present(x2in))                 &
          call mpi_recv(x2in,ccount,MPI_FLOAT_TYPE,src,ttag,wrap_instr%MPI_communicator,bstatus,ierr)
#endif
endif

else ! if(jsdm = 1)
!  if(wrap_instr%sbdmn_assign%length(wrap_instr%my_task) > 0 ) then
     if(present(x1in)) then
       x1in(:,:,:,1:nsdm) = x1(:,:,:,1:nsdm)
       deallocate(x1)
     endif
     if(present(x2in)) then
       x2in(:,:,:,:,:,1:nsdm) = x2(:,:,:,:,:,1:nsdm)
       deallocate(x2)
     endif
!  endif
endif
#endif
   
   if(allocated(bstatus)) deallocate(bstatus)
   
   END SUBROUTINE wrap_all
!=======================================================================
!  END   wrap_all
!=======================================================================

!=======================================================================
!  BEGIN wrap_fc
!=======================================================================
   SUBROUTINE wrap_fc (component_name,                                       &
                                 face,face_1L,vrtx,vrtx_1L,edge,edge_1L)
!.......................................................................
!  INTENT IN
!.......................................................................
   CHARACTER (LEN=*),INTENT ( IN) ::                                         &
      component_name
!.......................................................................
!  INTENT IN AND OUT
!.......................................................................
   REAL (KIND=dbl_kind),OPTIONAL ::                                          &
      face(    :,:,:,:),face_1L(    :,:,  :),                                &
      vrtx(:,:,:,:,:,:),vrtx_1L(:,:,:,:,  :),                                &
      edge(:,:,:,:,:,:),edge_1L(:,:,:,:,  :)
!.......................................................................
!  LOCAL
!.......................................................................
   LOGICAL (KIND=log_kind) ::                                                &
      l_name_found
   INTEGER (KIND=int_kind) ::                                                &
      nspace,nvrtx,nedge,iim,jjm,nlayer,nsdm,i3(3),i5(5)
   REAL (KIND=dbl_kind),ALLOCATABLE ::                                       &
      temp_rnk4(:,:,:,:)
   TYPE (component_node),POINTER ::                                          &
      current
!.......................................................................
   current => get_component_pointer (component_name)

   IF (PRESENT (face)) CALL wrap_all_fc (current,x1=face)

   IF (PRESENT (face_1L)) THEN
      i3(:) = SHAPE (face_1L)
      ALLOCATE (temp_rnk4(i3(1),i3(2),1,i3(3)))
      temp_rnk4(:,:,1,:) = face_1L(:,:,:)
      CALL wrap_all_fc (current,x1=temp_rnk4)
      face_1L(:,:,:) = temp_rnk4(:,:,1,:)
      deallocate (temp_rnk4)
   ENDIF


   END SUBROUTINE wrap_fc
!=======================================================================
!  END wrap_fc
!=======================================================================

!=======================================================================
!  BEGIN  wrap_all_fc
!=======================================================================
   SUBROUTINE wrap_all_fc (wrap_instr,x1,x2)
#if mpi == 1
   INCLUDE 'mpif.h'
#endif
!.......................................................................
!  INTENT IN
!.......................................................................
   TYPE (component_node),POINTER ::                                          &
      wrap_instr
!.......................................................................
!  INTENT IN AND OUT
!.......................................................................
   REAL (KIND=dbl_kind),OPTIONAL ::                                          &
      x1(:,:,:,:),x2(:,:,:,:,:,:)
!.......................................................................
!  LOCAL
!.......................................................................
   REAL (KIND=dbl_kind), allocatable ::                                      &
      xtem1(:,:,:,:)
   LOGICAL (KIND=log_kind) ::                                                &
      l_face,l_vrtx,l_edge
   INTEGER (KIND=int_kind) ::                                                &
      nspace,nthing,iim,jjm,nlayer,nsdm,nsd_glbl,isdm,jsdm,nsd,nsd_np,nsd_sp

   INTEGER (KIND=int_kind) ::                                                &
      npe_comp,my_task,count_recv_req,task_sour,count_send_req,task_dest,    &
      msg_length,total_length,count,n,m,MPI_FLOAT_TYPE,ierr
   INTEGER (KIND=int_kind) ::                                                &
      i1,j1,i1_start,j1_start,di1,dj1,nsd1,                                  &
      i2,j2,i2_start,j2_start,di2,dj2,nsd2

   INTEGER (KIND=int_kind),ALLOCATABLE ::                                    &
      up(:,:)  
   INTEGER (KIND=int_kind),ALLOCATABLE ::                                    &
      send_req(:),recv_req(:),send_status(:,:),recv_status(:,:)

   TYPE (send_node),POINTER ::                                               &
      instr_send
   TYPE (recv_node),POINTER ::                                               &
      instr_recv

   TYPE buffer_node
      INTEGER (KIND=int_kind) ::                                             &
         msg_tag,task_sour,task_dest,total_size
      REAL (KIND=dbl_kind),POINTER :: data_rnk2(:,:),data_rnk4(:,:,:,:)
      TYPE (buffer_node),POINTER :: next
   END TYPE buffer_node

   TYPE (buffer_node),POINTER ::                                             &
      buffer_recv,buffer_send,buffer_temp,current1,current2
!.......................................................................
   npe_comp       = wrap_instr%npe_comp
   my_task        = wrap_instr%my_task
   MPI_FLOAT_TYPE = wrap_instr%MPI_FLOAT_TYPE

   l_face = .FALSE.; l_vrtx = .FALSE.; l_edge = .FALSE.
   IF (PRESENT (x1)) THEN
      iim    = SIZE (x1,DIM=1)
      jjm    = SIZE (x1,DIM=2)
      nlayer = SIZE (x1,DIM=3)
      nsdm   = SIZE (x1,DIM=4)
      l_face = .TRUE.
      allocate(xtem1(iim,jjm,nlayer,nsdm))
      xtem1 = x1
   ENDIF

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  RECEIVES
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ALLOCATE (buffer_recv)
   buffer_temp => buffer_recv
   NULLIFY (buffer_temp%data_rnk2); NULLIFY (buffer_temp%data_rnk4)
   NULLIFY (buffer_temp%next)
   count_recv_req = 0
!-----------------------------------------------------------------------
!  loop over tasks.  allocate recv buffers.
!-----------------------------------------------------------------------
   DO task_sour = 0,npe_comp-1
      IF (task_sour/=my_task) THEN
!fc next 2 lines mod
         instr_send => wrap_instr%task_instr(my_task+1,task_sour+1)%send
         IF (ASSOCIATED (instr_send)) THEN
            count_recv_req = count_recv_req+1
            buffer_temp%msg_tag   = task_sour + npe_comp*my_task + 1
            buffer_temp%task_sour = task_sour
            total_length = wrap_instr%total_recv_length(my_task+1,task_sour+1)
            IF (l_face) THEN
               buffer_temp%total_size =               total_length*nlayer
               ALLOCATE (buffer_temp%data_rnk2(total_length,nlayer))
            ENDIF

            ALLOCATE (buffer_temp%next)
            buffer_temp => buffer_temp%next
            NULLIFY (buffer_temp%data_rnk2); NULLIFY (buffer_temp%data_rnk4)
            NULLIFY (buffer_temp%next)
         ENDIF
      ENDIF
   ENDDO
!-----------------------------------------------------------------------
!  trim buff_recv list is one node too long.  trim buff_recv list
!-----------------------------------------------------------------------
   buffer_temp => buffer_recv
   IF (ASSOCIATED (buffer_temp%next)) THEN
      DO WHILE (ASSOCIATED (buffer_temp%next%next))
         buffer_temp => buffer_temp%next
      ENDDO
      DEALLOCATE (buffer_temp%next)
      NULLIFY    (buffer_temp%next)
   ENDIF
!-----------------------------------------------------------------------
!  post receives
!-----------------------------------------------------------------------
#if mpi == 1
   ALLOCATE (recv_req(count_recv_req)); recv_req(:) = -999
   buffer_temp => buffer_recv
   DO count = 1,count_recv_req
      IF (l_face) THEN
         CALL MPI_IRECV (                                                    &
            buffer_temp%data_rnk2(1,1),                                      &
            buffer_temp%total_size,MPI_FLOAT_TYPE,                           &
            buffer_temp%task_sour,buffer_temp%msg_tag,                       &
            wrap_instr%MPI_communicator,recv_req(count),ierr)
      ENDIF
      IF (ASSOCIATED (buffer_temp%next)) buffer_temp => buffer_temp%next
   ENDDO
#endif

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  SENDS
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ALLOCATE (buffer_send)
   buffer_temp => buffer_send
   NULLIFY (buffer_temp%data_rnk2); NULLIFY (buffer_temp%data_rnk4)
   NULLIFY (buffer_temp%next)
   count_send_req = 0
!-----------------------------------------------------------------------
!  loop over tasks.  allocate and load send buffers
!-----------------------------------------------------------------------
   DO task_dest = 0,npe_comp-1
      IF (task_dest/=my_task) THEN
!fc next 2 lines mod
         instr_recv => wrap_instr%task_instr(my_task+1,task_dest+1)%recv
         IF (ASSOCIATED (instr_recv)) THEN
            count_send_req = count_send_req+1
            buffer_temp%msg_tag   = my_task + npe_comp*task_dest + 1
            buffer_temp%task_dest = task_dest
            total_length = wrap_instr%total_send_length(my_task+1,task_dest+1)
            IF (l_face) THEN
               buffer_temp%total_size =               total_length*nlayer
               ALLOCATE (buffer_temp%data_rnk2(total_length,nlayer))
            ENDIF

            count = 0
!fc next 4 lines mod
            DO WHILE (ASSOCIATED (instr_recv))
               i1_start   = instr_recv%i_start; j1_start   = instr_recv%j_start
               di1        = instr_recv%di;      dj1        = instr_recv%dj
               nsd1       = instr_recv%nsd_local
               msg_length = instr_recv%msg_length
               DO n = 1,msg_length
                  count = count + 1
                  i1 = i1_start+di1*(n-1); j1 = j1_start+dj1*(n-1)
                  IF (l_face) THEN
                     buffer_temp%data_rnk2(    count,:) = x1(    i1,j1,:,nsd1)
                  ENDIF
               ENDDO
!fc next 1 line mod
               instr_recv => instr_recv%next
            ENDDO

            ALLOCATE (buffer_temp%next)
            buffer_temp => buffer_temp%next
            NULLIFY (buffer_temp%data_rnk2); NULLIFY (buffer_temp%data_rnk4)
            NULLIFY (buffer_temp%next)
         ENDIF
      ENDIF
   ENDDO
!-----------------------------------------------------------------------
!  trim buff_send list is one node too long.  trim buff_send list
!-----------------------------------------------------------------------
   buffer_temp => buffer_send
   IF (ASSOCIATED (buffer_temp%next)) THEN
      DO WHILE (ASSOCIATED (buffer_temp%next%next))
         buffer_temp => buffer_temp%next
      ENDDO
      DEALLOCATE (buffer_temp%next)
      NULLIFY    (buffer_temp%next)
   ENDIF
!-----------------------------------------------------------------------
!  post sends
!-----------------------------------------------------------------------
#if mpi == 1
   ALLOCATE (send_req(count_send_req))
   send_req(:) = -999
   buffer_temp => buffer_send
   DO count = 1,count_send_req
      IF (l_face) THEN
         CALL MPI_ISEND (                                                    &
            buffer_temp%data_rnk2(1,1),                                      &
            buffer_temp%total_size,MPI_FLOAT_TYPE,                           &
            buffer_temp%task_dest,buffer_temp%msg_tag,                       &
            wrap_instr%MPI_communicator,send_req(count),ierr)
      ENDIF
      IF (ASSOCIATED (buffer_temp%next)) buffer_temp => buffer_temp%next
   ENDDO
#endif
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  WHILE INTER-PROCESS MESSAGES ARE IN TRANSIT, 
!  APPLY MESSAGES WITHIN THE my_task PROCESS
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   instr_send => wrap_instr%task_instr(my_task+1,my_task+1)%send
   instr_recv => wrap_instr%task_instr(my_task+1,my_task+1)%recv

!fc next 5 lines mod
   DO WHILE (ASSOCIATED (instr_recv))
      i1_start   = instr_recv%i_start; j1_start   = instr_recv%j_start
      di1        = instr_recv%di;      dj1        = instr_recv%dj
      nsd1       = instr_recv%nsd_local
      msg_length = instr_recv%msg_length

!fc next 3 lines mod
      i2_start   = instr_send%i_start; j2_start   = instr_send%j_start
      di2        = instr_send%di;      dj2        = instr_send%dj
      nsd2       = instr_send%nsd_local

      IF (l_face) THEN
         DO n = 1,msg_length
            i1 = i1_start+di1*(n-1); j1 = j1_start+dj1*(n-1)
            i2 = i2_start+di2*(n-1); j2 = j2_start+dj2*(n-1)
!fc next 1 line mod
           xtem1(i2,j2,:,nsd2) = xtem1(i2,j2,:,nsd2) + x1(i1,j1,:,nsd1)
         ENDDO
      ENDIF

      instr_send => instr_send%next
      instr_recv => instr_recv%next
   ENDDO

#if mpi == 1
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  WAIT FOR MESSAGES TO BE SENT AND TO BE RECEIVED
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ALLOCATE (send_status(MPI_STATUS_SIZE,count_send_req))
   ALLOCATE (recv_status(MPI_STATUS_SIZE,count_recv_req))

   send_status(:,:) = 0; recv_status(:,:) = 0

   CALL MPI_WAITALL (count_send_req,send_req,send_status,ierr)
   CALL MPI_WAITALL (count_recv_req,recv_req,recv_status,ierr)
#endif
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  UNPACK BUFFERS
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   buffer_temp => buffer_recv
   DO task_sour = 0,npe_comp-1
      IF (task_sour/=my_task) THEN
!fc next 2 lines mod
         instr_send => wrap_instr%task_instr(my_task+1,task_sour+1)%send
         IF (ASSOCIATED (instr_send)) THEN

            count = 0
!fc next 5 lines mod
            DO WHILE (ASSOCIATED (instr_send))
               i2_start   = instr_send%i_start; j2_start   = instr_send%j_start
               di2        = instr_send%di;      dj2        = instr_send%dj
               nsd2       = instr_send%nsd_local
               msg_length = instr_send%msg_length
               IF (l_face) THEN
                  DO n = 1,msg_length
                     count = count + 1
                     i2 = i2_start+di2*(n-1); j2 = j2_start+dj2*(n-1)
!fc next 1 line mod
                     xtem1(i2,j2,:,nsd2) = xtem1(i2,j2,:,nsd2) +               &
                                          buffer_temp%data_rnk2(count,:)
                  ENDDO
               ENDIF
               instr_send => instr_send%next
            ENDDO
            buffer_temp => buffer_temp%next
         ENDIF
      ENDIF
   ENDDO
   
!fc next 1 line new
   x1 = xtem1

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  FACE WRAP
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   IF (l_face) THEN
      isdm = wrap_instr%isdm; jsdm = wrap_instr%jsdm
      nsd_np = isdm*(  jsdm-1)+1; nsd_sp = isdm*(4*jsdm+1)
      DO nsd = 1,wrap_instr%sbdmn_assign_wrap%length(my_task+1)
         nsd_glbl = wrap_instr%sbdmn_assign_wrap%sd(my_task+1,nsd)
!-----------------------------------------------------------------------
!  if not north or south pole, set dead cells to a representative value
!-----------------------------------------------------------------------
         IF ((nsd_glbl/=nsd_np).AND.(nsd_glbl/=nsd_sp)) THEN
            x1(iim,1,:,nsd) = x1(2,2,:,nsd)
            x1(1,jjm,:,nsd) = x1(2,2,:,nsd)
         ENDIF
!-----------------------------------------------------------------------
!  if (iim-1,jjm-1) is a pentagon, set the cell at (iim,jjm)
!  equal to the cell at (iim-1,jjm)
!-----------------------------------------------------------------------
         IF (MOD (nsd_glbl-1,isdm*jsdm)+1 == isdm*jsdm-jsdm) THEN
            x1(iim,jjm,:,nsd) = x1(iim-1,jjm,:,nsd)
         ENDIF
         IF (MOD (nsd_glbl-1,isdm*jsdm)+1 == isdm*jsdm     ) THEN
            x1(iim,jjm,:,nsd) = x1(iim-1,jjm,:,nsd)
         ENDIF
      ENDDO
   ENDIF

   IF (ALLOCATED  (xtem1      )) DEALLOCATE (xtem1      )
   IF (ALLOCATED  (up         )) DEALLOCATE (up         )
   IF (ALLOCATED  (send_req   )) DEALLOCATE (send_req   )
   IF (ALLOCATED  (recv_req   )) DEALLOCATE (recv_req   )
   IF (ALLOCATED  (send_status)) DEALLOCATE (send_status)
   IF (ALLOCATED  (recv_status)) DEALLOCATE (recv_status)

   current1 => buffer_send
   DO WHILE (ASSOCIATED (current1%next))
      current2 => current1%next
      IF (ASSOCIATED  (current1%data_rnk2)) DEALLOCATE (current1%data_rnk2)
      IF (ASSOCIATED  (current1%data_rnk4)) DEALLOCATE (current1%data_rnk4)
      DEALLOCATE (current1)
      current1 => current2
   ENDDO
   IF (ASSOCIATED  (current1%data_rnk2)) DEALLOCATE (current1%data_rnk2)
   IF (ASSOCIATED  (current1%data_rnk4)) DEALLOCATE (current1%data_rnk4)
   DEALLOCATE (current1)

   current1 => buffer_recv
   DO WHILE (ASSOCIATED (current1%next))
      current2 => current1%next
      IF (ASSOCIATED  (current1%data_rnk2)) DEALLOCATE (current1%data_rnk2)
      IF (ASSOCIATED  (current1%data_rnk4)) DEALLOCATE (current1%data_rnk4)
      DEALLOCATE (current1)
      current1 => current2
   ENDDO
   IF (ASSOCIATED  (current1%data_rnk2)) DEALLOCATE (current1%data_rnk2)
   IF (ASSOCIATED  (current1%data_rnk4)) DEALLOCATE (current1%data_rnk4)
   DEALLOCATE (current1)

   END SUBROUTINE wrap_all_fc
!=======================================================================
!  END   wrap_all_fc
!=======================================================================

   END MODULE wrap_data
!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
