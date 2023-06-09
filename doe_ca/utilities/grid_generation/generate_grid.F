      PROGRAM generate_grid
      USE kinds
      IMPLICIT NONE

!------------------------------------------------------------------------------------
! USERS: grep for "!!!" to see where to make changes
!------------------------------------------------------------------------------------

!------------------------------------------------------------------------------------
! variable definition
!	l_grid_even : the first recursion of the icosahedron can be done by
!		bisection (even grids), or trisection (odd grids)
!	max_level : level of recursion 
!               (example, l_grid_even=T and max_level = 2 gives a grid of 162 points)
!       im : number of grid points in the i-direction
!	jm : number of grid points in the j-direction
!	nspace : number of spatial directions == 3
!	transform_matrix : grid will be rotated based on info in the matrix
!               (default grid has a pentagon at North Pole and South Pole)
!       p1 : grid center locations on a single diamond
!       p2 : grid center locations for ALL grid cells
!------------------------------------------------------------------------------------


!------------------------------------------------------------------------------------
!  variables
!------------------------------------------------------------------------------------
      LOGICAL (KIND=log_kind) :: l_grid_even,l_exist
      INTEGER (KIND=int_kind) :: max_level,im,jm,i,ii,j,panel,n,ierr,icount
      integer (kind=int_kind), parameter :: nspace = 3, ncorners = 2
      integer (kind=int_kind), parameter :: nneighbor_center = 6, nneighbor_corner = 3
      integer (kind=int_kind), allocatable :: grid_center_index(:,:)
      integer (kind=int_kind), allocatable :: grid_corner_index(:,:,:)
      integer (kind=int_kind), allocatable :: center_neighbor_index(:,:,:)
      integer (kind=int_kind), allocatable :: corner_neighbor_index(:,:,:,:)
      REAL (KIND=dbl_kind), ALLOCATABLE :: p1(:,:,:),p2(:,:,:), corner_area(:,:,:)
      REAL (KIND=dbl_kind), ALLOCATABLE :: tmp(:,:)
      REAL (KIND=dbl_kind) :: transform_matrix(nspace,nspace), t(nneighbor_corner,nspace)
      REAL (KIND=dbl_kind) :: rmin, rmax
      CHARACTER*07 resolution(9)

!------------------------------------------------------------------------------------
!!! pick an even or odd grid (for even grids, set l_grid_even = .true.)
!------------------------------------------------------------------------------------
      l_grid_even = .TRUE.

!------------------------------------------------------------------------------------
!!! pick the level or recursion (between 1 and 10)
!------------------------------------------------------------------------------------
      max_level = 5

!------------------------------------------------------------------------------------
! dump info to screen
!------------------------------------------------------------------------------------
      PRINT *,' l_grid_even = ',l_grid_even
      PRINT *,' max_level = ',max_level

!------------------------------------------------------------------------------------
! check range of input
!------------------------------------------------------------------------------------
      IF (max_level.GE.10) THEN
         PRINT *,' max_level IS TOO BIG.  max_level = ',max_level
         STOP
      ENDIF

!------------------------------------------------------------------------------------
! based on l_grid_even and max_level, find the resolution
!------------------------------------------------------------------------------------
      IF (l_grid_even) THEN
         im = 5*(2+2*2*2**(max_level-1)) 
         jm =   (2+  2*2**(max_level-1)) 
         resolution = (/  &
                         '0000042',		&! max_level == 1   
                         '0000162',		&! max_level == 2   
                         '0000642',		&! max_level == 3   
                         '0002562',		&! max_level == 4   
                         '0010242',		&! max_level == 5   
                         '0040962',		&! max_level == 6   
                         '0163842',		&! max_level == 7   
                         '0655362',		&! max_level == 8   
                         '2621442'/)		 ! max_level == 9

      ELSE
         im = 5*(2+2*3*2**(max_level-1)) 
         jm =   (2+  3*2**(max_level-1)) 
         resolution = (/  &
                         '0000092',		&! max_level == 1   
                         '0000362',		&! max_level == 2   
                         '0001442',		&! max_level == 3   
                         '0005762',		&! max_level == 4   
                         '0023042',		&! max_level == 5   
                         '0092162',		&! max_level == 6   
                         '0368642',		&! max_level == 7   
                         '1474562',		&! max_level == 8   
                         '5898242'/)		 ! max_level == 9
      ENDIF

!------------------------------------------------------------------------------------
! dump to screen
!------------------------------------------------------------------------------------
      PRINT *,' im = ',im,' jm = ',jm,' cells = ',2+10*(jm-2)**2

!------------------------------------------------------------------------------------
! allocate space for location arrays (p1,p2) and indexing/connectivity arrays
!------------------------------------------------------------------------------------
      ALLOCATE (p1(nspace,jm,jm),p2(nspace,im,jm))
      ALLOCATE (grid_center_index(im,jm),center_neighbor_index(nneighbor_center,im,jm))
      ALLOCATE (grid_corner_index(ncorners,im,jm),corner_neighbor_index(3,ncorners,im,jm))
      ALLOCATE (tmp(im,jm))
      ALLOCATE (corner_area(ncorners,im,jm))
      grid_center_index = 0
      center_neighbor_index = 0
      grid_corner_index = 0
      corner_neighbor_index = 0
      p1 = 0.0_dbl_kind
      p2 = 0.0_dbl_kind
      tmp = 0
      corner_area = 0

!------------------------------------------------------------------------------------
! find p1 and p2
!------------------------------------------------------------------------------------
      CALL set_p1_p2 (l_grid_even,max_level,im,jm,p1,p2)

!------------------------------------------------------------------------------------
! clean up NP and SP
!------------------------------------------------------------------------------------
      p2(:,1,jm-1) = (/0.0,0.0, 1.0/) ! MAKE NORTH POLE PRETTY
      p2(:,im-1,1) = (/0.0,0.0,-1.0/) ! MAKE SOUTH POLE PRETTY

!------------------------------------------------------------------------------------
! IF THE FILE transform_matrix EXISTS THEN READ POINT TRANSFORM MATRIX
!------------------------------------------------------------------------------------
      INQUIRE (FILE='./transform_matrix',EXIST=l_exist)
      IF (l_exist) THEN
         PRINT *,' transform matrix file found'
         OPEN (UNIT=17,FILE='./transform_matrix',  &
                                           FORM='FORMATTED',IOSTAT=ierr)
         DO n = 1,nspace
            READ (17,*)   &
                  transform_matrix(n,1),  &
                  transform_matrix(n,2),  &
                  transform_matrix(n,3)
            PRINT 20,  &
                  transform_matrix(n,1),  &
                  transform_matrix(n,2),  &
                  transform_matrix(n,3)
         ENDDO

!------------------------------------------------------------------------------------
! do rotation via matrix multiply
!------------------------------------------------------------------------------------
         DO j = 1,jm
            DO i = 1,im
               p2(:,i,j) = MATMUL (transform_matrix(:,:),p2(:,i,j))
            ENDDO
         ENDDO
      ELSE
         PRINT *, ' transform matrix file not found'
      ENDIF

!------------------------------------------------------------------------------------
! setup the grid index
!------------------------------------------------------------------------------------
      grid_center_index = -999
      grid_corner_index = -999
      grid_center_index(1,jm-1) = 1
      grid_center_index(im-1,1) = 2
      icount = 2
      DO j = 2,jm-1
         DO panel = 0,4
            DO i = 2,(im/5)-1
               ii = (im/5)*panel+i
               icount = icount + 1
               grid_center_index(ii,j) = icount
               grid_corner_index(1,ii,j) = (grid_center_index(ii,j)-3)*2 + 1
               grid_corner_index(2,ii,j) = grid_corner_index(1,ii,j) + 1
            ENDDO
         ENDDO
      ENDDO
      write(6,*)
      write(6,*) ' grid center index ',minval(grid_center_index),maxval(grid_center_index)
      write(6,*) ' grid corner index ',minval(grid_corner_index),maxval(grid_corner_index)
      write(6,*)
      tmp = grid_center_index
      call wrap(im,jm,tmp)
      grid_center_index = nint(tmp)
      deallocate(tmp)

!------------------------------------------------------------------------------------
! setup the neighbor index
!------------------------------------------------------------------------------------
      center_neighbor_index = -999
      corner_neighbor_index = -999
      do panel=1,5
       center_neighbor_index(panel,1,   jm-1) = grid_center_index(im/5*(panel-1)+2,jm-1)
       center_neighbor_index(panel,im-1,1   ) = grid_center_index(im/5*(6-panel)-1,2   )
      enddo

      do j=2,jm-1
      do i=2,im-1
	if(grid_center_index(i,j).gt.0) then

          center_neighbor_index(1,i,j) = grid_center_index(i-1,j)
          center_neighbor_index(2,i,j) = grid_center_index(i-1,j-1)
          center_neighbor_index(3,i,j) = grid_center_index(i,j-1)
          center_neighbor_index(4,i,j) = grid_center_index(i+1,j)
          center_neighbor_index(5,i,j) = grid_center_index(i+1,j+1)
          center_neighbor_index(6,i,j) = grid_center_index(i,j+1)

          corner_neighbor_index(1,1,i,j) = grid_center_index(i  ,j  )
          corner_neighbor_index(2,1,i,j) = grid_center_index(i-1,j  )
          corner_neighbor_index(3,1,i,j) = grid_center_index(i-1,j-1)

          corner_neighbor_index(1,2,i,j) = grid_center_index(i  ,j  )
          corner_neighbor_index(2,2,i,j) = grid_center_index(i-1,j-1)
          corner_neighbor_index(3,2,i,j) = grid_center_index(i  ,j-1)

        endif
      enddo
      enddo
      do panel=0,4
      center_neighbor_index(5,im/5*panel+jm-1,jm-1) = -999
      enddo

      write(6,*)
      write(6,*) ' center neighbor index ',minval(center_neighbor_index),  &
                                           maxval(center_neighbor_index)
      write(6,*) ' corner neighbor index ',minval(corner_neighbor_index),  &
                                           maxval(corner_neighbor_index)
      write(6,*)


	corner_neighbor_index = corner_neighbor_index - 1
	grid_corner_index = grid_corner_index - 1
	grid_center_index = grid_center_index - 1

!------------------------------------------------------------------------------------
! OPEN A grid file to dump p2
!------------------------------------------------------------------------------------
      OPEN (    &
               UNIT=17,    &
               FILE='grid_centers_'//resolution(max_level),    &
               FORM='FORMATTED')
      OPEN (    &
               UNIT=18,    &
               FILE='center_connectivity_'//resolution(max_level),    &
               FORM='FORMATTED')
      OPEN (    &
               UNIT=19,    &
               FILE='corner_connectivity_'//resolution(max_level),    &
               FORM='FORMATTED')
      OPEN (    &
               UNIT=20,    &
               FILE='corner_loop_list_'//resolution(max_level),    &
               FORM='FORMATTED')
      OPEN (    &
               UNIT=21,    &
               FILE='corner_face_list_'//resolution(max_level),    &
               FORM='FORMATTED')
      OPEN (    &
               UNIT=22,    &
               FILE='special_points_'//resolution(max_level),    &
               FORM='FORMATTED')

      OPEN (    &
               UNIT=23,    &
               FILE='grid_center_tag_'//resolution(max_level),    &
               FORM='FORMATTED')


      write(22,13) grid_center_index(1,jm-1)
      write(22,13) grid_center_index(im-1,1)
      write(23,13) grid_center_index(1,jm-1)
      write(23,13) grid_center_index(im-1,1)
      do panel=0,4
        write(22,13) grid_center_index(panel*im/5+jm-1,jm-1)
        write(22,13) grid_center_index((panel+1)*im/5-1,jm-1)
      enddo

      i=1
      j=jm-1
      WRITE (17,10) p2(1,i,j),p2(2,i,j),p2(3,i,j)
      WRITE (18,11) i,j,grid_center_index(i,j),center_neighbor_index(:,i,j)
      i=im-1
      j=1
      WRITE (17,10) p2(1,i,j),p2(2,i,j),p2(3,i,j)
      WRITE (18,11) i,j,grid_center_index(i,j),center_neighbor_index(:,i,j)
      DO j = 2,jm-1 
         DO panel = 0,4
            DO i = 2,(im/5)-1
               ii = (im/5)*panel+i
               WRITE (17,10) p2(1,ii,j),p2(2,ii,j),p2(3,ii,j)
               WRITE (18,11) ii,j,grid_center_index(ii,j),center_neighbor_index(:,ii,j)

               WRITE (19,12) corner_neighbor_index(:,1,ii,j)
               WRITE (19,12) corner_neighbor_index(:,2,ii,j)
               WRITE (20,13) grid_corner_index(1,ii,j)*3
               WRITE (20,13) grid_corner_index(2,ii,j)*3
               WRITE (21,13) grid_corner_index(1,ii,j)
               WRITE (21,13) grid_corner_index(2,ii,j)
               write (23,13) grid_center_index(ii,j)

            ENDDO
         ENDDO
      ENDDO
      CLOSE (UNIT=17)
      CLOSE (UNIT=18)

   10 FORMAT (3F24.20)
   11 format (9i10)
   12 format (3i10)
   13 format (i10)
   20 FORMAT (3F08.04)

      DEALLOCATE (p1,p2)

      end program generate_grid
!=======================================================================
! END PROGRAM GENERATE_GRID
!=======================================================================


!=======================================================================
! BEGIN PROGRAM SET_P1_P2
!=======================================================================
      SUBROUTINE set_p1_p2 (l_grid_even,max_level,im,jm,p1,p2)
      USE kinds
      IMPLICIT NONE
      LOGICAL (KIND=log_kind) :: l_grid_even
      INTEGER (KIND=int_kind) :: max_level,im,jm
      INTEGER (KIND=int_kind) :: p,q,level,o1,o2,i,ii,j,panel,t1,t2

      REAL (KIND=dbl_kind), PARAMETER ::   &
       const_zero = 0.0,const_one  = 1.0,   &
       alpha = 1.25663706143591729538_dbl_kind,   &
       pentagon_latitude = 0.463647609_dbl_kind,   &
       beta = 0.55357435889704525150853_dbl_kind    

      REAL (KIND=dbl_kind) :: p1(3,jm,jm),p2(3,im,jm),p_temp(3)

      p = im-1; q = jm-1

      p1(:,:,:) = const_zero; p2(:,:,:) = const_zero

      p1(:,   1,   1) = (/COS (-0.5*alpha)*COS (pentagon_latitude),  &
                          SIN (-0.5*alpha)*COS (pentagon_latitude),  &
                                           SIN (pentagon_latitude)/)
      p1(:,jm-1,   1) =   &
         (/COS (pentagon_latitude),const_zero,SIN (-pentagon_latitude)/)
      p1(:,   1,jm-1) = (/const_zero,const_zero,const_one/)
      p1(:,jm-1,jm-1) = (/COS (0.5*alpha)*COS (pentagon_latitude),  &
                          SIN (0.5*alpha)*COS (pentagon_latitude),  &
                                          SIN (pentagon_latitude)/)

      IF (l_grid_even) THEN
         DO level = 1,max_level
            o1 = (jm-2)/(2**(level  )); o2 = (jm-2)/(2**(level-1))
            DO j = o2+1,jm-1,o2
               DO i = 1,jm-1,o2
                 CALL bisect (p1(1,i,j),p1(1,i   ,j-o2),p1(1,i   ,j-o1))
               ENDDO
            ENDDO
            DO j = o2+1,jm-1,o2
               DO i = o2+1,jm-1,o2
                 CALL bisect (p1(1,i,j),p1(1,i-o2,j-o2),p1(1,i-o1,j-o1))
               ENDDO
            ENDDO
            DO j = 1,jm-1,o2
               DO i = o2+1,jm-1,o2
                 CALL bisect (p1(1,i,j),p1(1,i-o2,j   ),p1(1,i-o1,j   ))
               ENDDO
            ENDDO
         ENDDO
      ELSE
         t1 = 1+1*((jm-2)/3); t2 = 1+2*((jm-2)/3)

         CALL center (p1(1,1,1),p1(1,1,q),p1(1,q,q),p1(1,t1,t2))
         CALL center (p1(1,1,1),p1(1,q,q),p1(1,q,1),p1(1,t2,t1))

         CALL trisect (p1(1,1,1),p1(1,q,1),p1(1,t1, 1),p1(1,t2, 1))
         CALL trisect (p1(1,1,1),p1(1,1,q),p1(1, 1,t1),p1(1, 1,t2))
         CALL trisect (p1(1,1,1),p1(1,q,q),p1(1,t1,t1),p1(1,t2,t2))
         CALL trisect (p1(1,q,1),p1(1,q,q),p1(1, q,t1),p1(1, q,t2))
         CALL trisect (p1(1,1,q),p1(1,q,q),p1(1,t1, q),p1(1,t2, q))

         DO level = 2,max_level
            o1 = 2*((jm-2)/3)/(2**(level  ))
            o2 = 2*((jm-2)/3)/(2**(level-1))
            DO j = o2+1,q,o2
               DO i = 1,q,o2
                 CALL bisect (p1(1,i,j),p1(1,i   ,j-o2),p1(1,i   ,j-o1))
               ENDDO
            ENDDO
            DO j = o2+1,q,o2
               DO i = o2+1,q,o2
                 CALL bisect (p1(1,i,j),p1(1,i-o2,j-o2),p1(1,i-o1,j-o1))
            ENDDO
            ENDDO
            DO j = 1,q,o2
               DO i = o2+1,q,o2
                 CALL bisect (p1(1,i,j),p1(1,i-o2,j   ),p1(1,i-o1,j   ))
               ENDDO
            ENDDO
         ENDDO
      ENDIF

! MOVE SQUARE BLOCK DOWN TO EQUATOR
      DO j = 1,jm
         DO i = 1,jm
            p1(:,i,j) = (/COS (-beta)*p1(1,i,j) - SIN(-beta)*p1(3,i,j),  &
                                      p1(2,i,j),  &
                          SIN (-beta)*p1(1,i,j) + COS(-beta)*p1(3,i,j)/)
         ENDDO
      ENDDO

! ROTATE UPPER HALF OF FIRST PANEL TOWARDS POLE
      DO j = 1,jm-1
         DO i = 1,jm-1
            p2(:,i,j) = (/COS ( beta)*p1(1,i,j)-SIN ( beta)*p1(3,i,j),  &
                                      p1(2,i,j),  &
                          SIN ( beta)*p1(1,i,j)+COS ( beta)*p1(3,i,j)/)
         ENDDO
      ENDDO

! TRANSFORM AND FILL TO LOWER HALF OF FIRST PANEL
      DO j = 1,jm-1
         DO i = 1,jm-1
            p_temp(:) = (/COS (-beta)*p1(1,i,j)-SIN (-beta)*p1(3,i,j),  &
                                      p1(2,i,j),  &
                          SIN (-beta)*p1(1,i,j)+COS (-beta)*p1(3,i,j)/)
            p2(:,(jm-2)+i,j) =   &
                  (/COS (0.5*alpha)*p_temp(1)-SIN (0.5*alpha)*p_temp(2),  &
                    SIN (0.5*alpha)*p_temp(1)+COS (0.5*alpha)*p_temp(2),  &
                                    p_temp(3)/)
         ENDDO
      ENDDO

! ROTATE ABOUT Z-AXES TO FILL REMAINING FOUR PANELS
      DO panel = 1,4
         DO j = 1,jm-1
            DO i = 1,(im/5)-1
               p2(:,(im/5)*panel+i,j) =   &
                                  (/COS (alpha*FLOAT (panel))*p2(1,i,j)-  &
                                    SIN (alpha*FLOAT (panel))*p2(2,i,j),  &
                                    SIN (alpha*FLOAT (panel))*p2(1,i,j)+  &
                                    COS (alpha*FLOAT (panel))*p2(2,i,j),  &
                                                             p2(3,i,j)/)
            ENDDO
         ENDDO
      ENDDO

      END SUBROUTINE set_p1_p2
!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
      SUBROUTINE bisect (p1,p2,p3)
      USE kinds
      IMPLICIT NONE
      REAL (KIND=dbl_kind) :: p1(3),p2(3),p3(3)

      p3(:) = 0.5*(p1(:)+p2(:))
      p3(:) = p3(:)/SQRT (SUM (p3(:)*p3(:)))

      END SUBROUTINE bisect 
!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
      SUBROUTINE center (p1,p2,p3,p4)
      USE kinds
      IMPLICIT NONE
      REAL (KIND=dbl_kind) :: p1(3),p2(3),p3(3),p4(3)
      p4(:) = (p1(:)+p2(:)+p3(:))/3.0_dbl_kind
      p4(:) = p4(:)/SQRT (SUM (p4(:)*p4(:)))
 
      END SUBROUTINE center
!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
      SUBROUTINE trisect (p1,p2,p3,p4)
      USE kinds
      IMPLICIT NONE
      REAL (KIND=dbl_kind) :: p1(3),p2(3),p3(3),p4(3)
      REAL (KIND=dbl_kind), PARAMETER :: gamma = 1.0_dbl_kind/3.0_dbl_kind

      p3(:) = (1.-gamma)*p1(:)+    gamma *p2(:)
      p3(:) = p3(:)/SQRT (SUM (p3(:)*p3(:)))

      p4(:) =     gamma *p1(:)+(1.-gamma)*p2(:)
      p4(:) = p4(:)/SQRT (SUM (p4(:)*p4(:)))

      END SUBROUTINE trisect
!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
!
      SUBROUTINE wrap (im_t,jm_t,x) 
! 24 JUNE 1999
! SINGLE WRAP
      use kinds
      IMPLICIT NONE
      INTEGER im_t,jm_t
      INTEGER k,o1,o2,q_t,p_t,im5_t,panel
      real (kind=dbl_kind) x(im_t,jm_t)

      p_t   =   im_t-1
      q_t   =   jm_t-1
      im5_t = 2*jm_t-2

      DO panel = 0,4
         o1 = im5_t*(MOD (panel+0,5))
         o2 = im5_t*(MOD (panel+1,5))

         x(o1+1      ,q_t) = x(  1,q_t) ! NORTH POLE
         x(o1+im5_t-1,  1) = x(p_t,  1) ! SOUTH POLE

! OFFSET 1 : TOP LEFT
         DO k = 2,q_t 
            x(o1+k,jm_t) = x(o2+2,q_t+2-k)
         ENDDO                                                                
! OFFSET 1 : TOP RIGHT
         DO k = q_t+1,im5_t-1
            x(o1+k,jm_t) = x(o2-q_t+1+k,2) 
         ENDDO
! OFFSET 1 : RIGHT EDGE
         DO k = 2,q_t
            x(o1+im5_t,k) = x(o2+im5_t+1-k,2)  
         ENDDO

! OFFSET 2 : LEFT EDGE
         DO k = 1,q_t-1
            x(o2+1,k) = x(o1+q_t+1-k,q_t)                       
         ENDDO
! OFFSET 2 : BOTTOM LEFT
         DO k = 2,q_t
            x(o2+k,1) = x(o1+q_t-1+k,q_t)                
         ENDDO
! OFFSET 2 : BOTTOM RIGHT
         DO k = q_t+1,im5_t-2
            x(o2+k,1) = x(o1+im5_t-1,im5_t-k)      
         ENDDO
      ENDDO

      RETURN
      END
!cccccccccccccccccccccccccccccccccccccccccccccc
