!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
      module elliptic_solver_xxx

!-----------------------------------------------------------------------
! PURPOSE : solve the (modified) Helmholtz problem
!
!    del^2(xout) - helm_const*xout = rhs
!
! via multigrid solver or Jacobi iteration (helm_const=0 for Poisson).
! Here  helm_const  is a public variable (>=0) to be set in the calling 
! routine and passed to the multigrid solver via  helm_const_mg.
!-----------------------------------------------------------------------
      use kinds
      use abort
      use params_physical
      use params_parallel_xxx
      use params_grid_horizontal_xxx, nx=>iim, ny=>jjm
      use wrap_data
      use operators
      use global_reductions
      use multigrid_solver_xxx
      use grid_metrics_variables_xxx
      use grid_mask_variables_xxx
      use timer

      implicit none
      save
!-----------------------------------------------------------------------
! public variable to supply parameter for Helmholtz problem (0 for Poisson)
        real (kind=dbl_kind), public :: helm_const = 0.0_dbl_kind
!-----------------------------------------------------------------------

!*************************************************************************
      contains
!*************************************************************************

!======================================================================
! BEGINNING OF ELLIPTIC
!======================================================================
      subroutine elliptic (component_name,nvar,rhs,xout)
!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
      character (len=*), intent(in) :: component_name
      integer (kind=int_kind),intent(in) :: nvar

      real (kind=dbl_kind),intent(inout) ::                                     &
         rhs                   (nx,ny,nvar,nsdm)
!----------------------------------------------------------------------------
! INTENT IN AND OUT
!----------------------------------------------------------------------------
      real (kind=dbl_kind),intent(inout) ::                                  &
         xout                  (nx,ny,nvar,nsdm)
!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
      logical (kind=log_kind),parameter   :: l_multigrid = .true.

      logical (kind=log_kind)             :: additional_work
      logical (kind=log_kind),allocatable :: not_converged(:)

      integer (kind=int_kind) :: bad_apples,iter,iter_max,n1,n2,size_2d
      integer (kind=int_kind),allocatable :: index(:)

      real (kind=dbl_kind), parameter :: rconverge = 1.0E-20_dbl_kind
      real(kind=dbl_kind), dimension(nx,ny,nsdm) :: area_mask, one
      real (kind=dbl_kind) :: xmean, total_area

      real (kind=dbl_kind),allocatable ::                                    &
         norm_l2(:),norm_inf(:),work_ba(:,:,:,:),rhs_ba(:,:,:,:)
!-----------------------------------------------------------------------
! initialize
!-----------------------------------------------------------------------
      additional_work = .false.

      call wrap (component_name,face=xout)
      call wrap (component_name,face=rhs)

! zero the global means
   size_2d = nx*ny*nsdm
   area_mask(:,:,:) = area(:,:,:)*grid_center_mask(:,:,:)
   one(:,:,:) = 1.0_dbl_kind     
   total_area = global_real_sum (area_mask(:,:,:),one(:,:,:),                &
                                 size_2d,component_name)
!-----------------------------------------------------------------------
!  subtract the global mean
!-----------------------------------------------------------------------
   do n1 = 1,nvar
     xmean = global_real_sum (rhs(:,:,n1,:),area_mask(:,:,:),              &
                              size_2d,component_name)/total_area
     rhs(:,:,n1,:) = rhs(:,:,n1,:) - xmean
   enddo
!-----------------------------------------------------------------------
! sanity check
!-----------------------------------------------------------------------
      if (helm_const<0.0_dbl_kind) then
         print *, "elliptic_solver warning:  helm_const<0"
      end if
!-----------------------------------------------------------------------
! allocate stuff
!-----------------------------------------------------------------------
      allocate (norm_l2(nvar),norm_inf(nvar),not_converged(nvar))
      norm_l2(:)=0.0_dbl_kind;norm_inf=0.0_dbl_kind;not_converged(:)=.true.

      if (l_multigrid) then
!-----------------------------------------------------------------------
! do a few V-cycles without checking convergence
!-----------------------------------------------------------------------
         helm_const_mg = helm_const
         call timer_start ('multigrid')
         do iter = 1,2
            call multigrid (nvar,rhs,xout)
         enddo
         call timer_stop  ('multigrid')
!-----------------------------------------------------------------------
! wrap
!-----------------------------------------------------------------------
         call wrap (component_name,face=xout)
!-----------------------------------------------------------------------
! check for convergence
!-----------------------------------------------------------------------
         call check_convergence (component_name,npad,nx,ny,nvar,nsdm,nweights,   &
                          rconverge,l_weights,grid_center_mask,rhs,xout,         &
                          norm_l2,norm_inf,not_converged)
      endif
!-----------------------------------------------------------------------
! if first V-cycles failed to result in convergence then more work is required
!-----------------------------------------------------------------------
      if (ANY (not_converged).or.(.not.l_multigrid)) then
         additional_work = .true.

         bad_apples = COUNT (not_converged)
         allocate (index(bad_apples),work_ba(nx,ny,bad_apples,nsdm),         &
                                      rhs_ba(nx,ny,bad_apples,nsdm))
         n2 = 0
         do n1 = 1,nvar
            if (not_converged(n1)) then
               n2 = n2+1
               index(n2) = n1
               work_ba(:,:,n2,:) = xout(:,:,n1,:)
                rhs_ba(:,:,n2,:) =  rhs(:,:,n1,:)
            endif
         enddo

         deallocate (norm_l2,norm_inf,not_converged)
           allocate (norm_l2(bad_apples),norm_inf(bad_apples),              &
                      not_converged(bad_apples))
         norm_l2(:)=0.0_dbl_kind;norm_inf=0.0_dbl_kind;not_converged(:)=.true.

         if (l_multigrid) then
            iter_max =  10
         else
            iter_max = 200
         endif

         iter = 0
         do while (ANY (not_converged).and.(iter < iter_max))
            iter = iter+1
            if (l_multigrid) then
               call timer_start ('multigrid')
               call multigrid (bad_apples,rhs_ba,work_ba)
               call timer_stop  ('multigrid')
            else
!print *, 'starting Jacobi iteration ', iter
               call jacobi (npad,nx,ny,bad_apples,nsdm,nweights,             &
                                               l_weights,rhs_ba,work_ba)
            endif

            call wrap (component_name,face=work_ba(:,:,1:bad_apples,:))

            call check_convergence (component_name,npad,nx,ny,bad_apples,nsdm,nweights,     &
                    rconverge,l_weights,grid_center_mask,rhs_ba,work_ba,     &
                    norm_l2,norm_inf,not_converged)
         end do
      endif

      if (ANY (not_converged)) then
         call abort_code( "FORTRAN STOP (elliptic_solver):  failed to converge")
      else
         if (additional_work) then
            do n2 = 1,bad_apples
               xout(:,:,index(n2),:) = work_ba(:,:,n2,:)
            enddo
         endif
      endif

      if (my_task==0) then
         print *,' iterations/resid  : ',iter,additional_work,               &
                                                  norm_l2(:),norm_inf(:)
      endif

      deallocate (norm_l2,norm_inf,not_converged)
      if (additional_work) deallocate (index,work_ba,rhs_ba)

      end subroutine elliptic
!======================================================================
! END OF ELLIPTIC
!======================================================================

!======================================================================
! BEGINNING OF check_convergence
!======================================================================
     subroutine check_convergence (component_name,npad,nx,ny,nm,nsdm,nweights,             &
                          rconverge,l_weights,grid_center_mask,rhs,xout,    &
                          norm_l2,norm_inf,not_converged)

      character (len=*), intent(in) :: component_name
      logical (kind=log_kind) :: not_converged(nm)
      integer (kind=int_kind) :: npad,nx,ny,nm,nsdm,nweights
      real    (kind=dbl_kind) :: rconverge,                                  &
         l_weights(nweights,nx,ny,nsdm),grid_center_mask(nx,ny,nsdm),        & 
         rhs(nx,ny,nm,nsdm),xout(nx,ny,nm,nsdm),                             &
         norm_l2(nm),norm_inf(nm)

      integer (kind=int_kind) :: n,nsd

      real (kind=dbl_kind),allocatable :: work(:,:,:),resid(:,:,:)

      allocate (work(nx,ny,nsdm),resid(nx,ny,nsdm))
                          
      do n = 1,nm
         do nsd = 1,nsdm
            call laplacian_of_a_scalar (                                     &
                               npad,nx,ny,nweights,l_weights(:,:,:,nsd),     &
                               xout(:,:,n,nsd),work(:,:,nsd))
         enddo
         resid(:,:,:) = (work(:,:,:)-helm_const*xout(:,:,n,:)) - rhs(:,:,n,:)
         call  l2_norm (component_name,npad,nx,ny,nsdm,grid_center_mask,resid,norm_l2 (n))
         call inf_norm (component_name,npad,nx,ny,nsdm,grid_center_mask,resid,norm_inf(n))
         if (norm_l2(n) > rconverge) then
            not_converged(n) = .true.
         else
            not_converged(n) = .false.
         endif
      enddo

      deallocate (work,resid)

      end subroutine check_convergence
!======================================================================
! END OF check_convergence
!======================================================================

!======================================================================
! BEGINNING OF JACOBI
!======================================================================
      subroutine jacobi(npad,nx,ny,nvar,nsdm,nweights,l_weights,rhs,xout)

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
      integer (kind=int_kind), intent(in) :: npad,nx,ny,nvar,nsdm,nweights

      real (kind=dbl_kind),intent(in) ::                                     &
         rhs                     (nx,ny,nvar,nsdm),                          &
         l_weights      (nweights,nx,ny,     nsdm)
!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
      real (kind=dbl_kind),intent(inout) ::                                  &
         xout                    (nx,ny,nvar,nsdm)
!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
      integer (kind=int_kind) :: i,j,ksdm
      real (kind=dbl_kind) ::                                                &
         work                    (nx,ny,nvar)
!----------------------------------------------------------------------------
! LOCAL--allocatable
!----------------------------------------------------------------------------
      real (kind=dbl_kind), allocatable ::                                   &
          rw7(:,:,:) ! reciprocal of the central weight

      allocate (rw7(nx,ny,nsdm))
      rw7 = 0.0
!----------------------------------------------------------------------------
! compute the reciprocal of the central weight
!----------------------------------------------------------------------------
      where (l_weights(7,:,:,:)/=0.0_dbl_kind)
         rw7(:,:,:) = 1.0_dbl_kind/(l_weights(7,:,:,:) - helm_const)
      elsewhere
         rw7(:,:,:) = 0.0_dbl_kind ! for non-existent points
      end where
!--------------------------------------------------------------------------
! do a Jacobi iteration at all interior points
!--------------------------------------------------------------------------
      work = 0
      do ksdm=1,nsdm
         do j=npad+1,ny-npad
            do i=npad+1,nx-npad
               work(i,j,:) =                                                 &
               rw7(i, j, ksdm) * ( + rhs( i, j, :, ksdm)                     &
                  - l_weights( 1, i, j, ksdm) * xout(i-1, j  , :, ksdm)      &
                  - l_weights( 2, i, j, ksdm) * xout(i-1, j-1, :, ksdm)      &
                  - l_weights( 3, i, j, ksdm) * xout(i  , j-1, :, ksdm)      &
                  - l_weights( 4, i, j, ksdm) * xout(i+1, j  , :, ksdm)      &
                  - l_weights( 5, i, j, ksdm) * xout(i+1, j+1, :, ksdm)      &
                  - l_weights( 6, i, j, ksdm) * xout(i  , j+1, :, ksdm))
            enddo
         enddo
!--------------------------------------------------------------------------
! do a Jacobi iteration at North Pole
!--------------------------------------------------------------------------
         i=1; j=ny-1
         work(i,j,:) =                                                       &
               rw7(i, j, ksdm) * ( + rhs( i, j, :, ksdm)                     &
                  - l_weights( 2, i, j, ksdm) * xout(nx , 1  , :, ksdm)      &
                  - l_weights( 3, i, j, ksdm) * xout(i  , j-1, :, ksdm)      &
                  - l_weights( 4, i, j, ksdm) * xout(i+1, j  , :, ksdm)      &
                  - l_weights( 5, i, j, ksdm) * xout(i+1, j+1, :, ksdm)      &
                  - l_weights( 6, i, j, ksdm) * xout(i  , j+1, :, ksdm))
!--------------------------------------------------------------------------
! do a Jacobi iteration at South Pole
!--------------------------------------------------------------------------
         i=nx-1; j=1
         work(i,j,:) =                                                       &
               rw7(i, j, ksdm) * ( + rhs( i, j, :, ksdm)                     &
                  - l_weights( 1, i, j, ksdm) * xout(i-1,   j, :, ksdm)      &
                  - l_weights( 2, i, j, ksdm) * xout(1  ,  ny, :, ksdm)      &
                  - l_weights( 4, i, j, ksdm) * xout(i+1, j  , :, ksdm)      &
                  - l_weights( 5, i, j, ksdm) * xout(i+1, j+1, :, ksdm)      &
                  - l_weights( 6, i, j, ksdm) * xout(i  , j+1, :, ksdm))
!--------------------------------------------------------------------------
! copy work array into intent(out)
!--------------------------------------------------------------------------
         xout(:,:,:,ksdm) = work(:,:,:)
!--------------------------------------------------------------------------
! close loop over nsdm
!--------------------------------------------------------------------------
      enddo

      deallocate (rw7)
      end subroutine jacobi
!======================================================================
! END OF JACOBI
!======================================================================

!======================================================================
! BEGINNING OF L2_NORM
!======================================================================
      subroutine l2_norm(component_name,npad,nx,ny,nsdm,grid_center_mask,resid,norm)
      character (len=*), intent(in) :: component_name
      integer (kind=int_kind) :: nx,ny,npad,nsdm
      real (kind=dbl_kind), intent(in) ::                                    &
         resid            (nx,ny,nsdm),                                      &
         grid_center_mask (nx,ny,nsdm)         

      real (kind=dbl_kind), intent(out) :: norm 
      real (kind=dbl_kind) :: work(nx,ny,nsdm)
      integer (kind=int_kind) :: i,j,k,isize,isum

      isize = iim*jjm*nsdm
      work = resid*resid
      norm = global_real_sum(work,grid_center_mask,isize,component_name)
      isum = global_real_sum(grid_center_mask,grid_center_mask,isize,component_name)
      norm = norm/isum

      end subroutine l2_norm
!======================================================================
! END OF L2_NORM
!======================================================================

!======================================================================
! BEGINNING OF INF_NORM
!======================================================================
      subroutine inf_norm(component_name,npad,nx,ny,nsdm,grid_center_mask,resid,norm)
      character (len=*), intent(in) :: component_name
      integer (kind=int_kind) :: nx,ny,npad,nsdm

      real (kind=dbl_kind), intent(in) ::                                    &
        resid            (nx,ny,nsdm),                                       &
        grid_center_mask (nx,ny,nsdm)          

      real (kind=dbl_kind), dimension(nx,ny,nsdm) :: work
      real (kind=dbl_kind), intent(out) :: norm
      integer (kind=int_kind) :: isize

      isize = iim*jjm*nsdm
      work = abs(resid) * grid_center_mask
      norm = global_real_maxval(work,isize,component_name)
        
      end subroutine inf_norm
!======================================================================
! END OF INF_NORM
!======================================================================

        end module elliptic_solver_xxx

!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
