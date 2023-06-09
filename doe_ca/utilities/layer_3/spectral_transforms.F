!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

        module spectral_transforms_xxx


	use kinds
	use params_grid_horizontal_xxx
	use grid_metrics_variables_xxx

	implicit none

	integer (kind=int_kind), parameter ::                       &
                     neigen_z  = max_ig,                            &
                     neigen_zm = max_ig_corners
#if transforms == 1

	real (kind=dbl_kind) ::                                     &
                     evalues_z(neigen_z),                           &
                     evectors_z(neigen_z,iim,jjm,nsdm),             &
                     evalues_zm(neigen_zm),                         &
                     evectors_zm(neigen_zm,ncorners,iim,jjm,nsdm)

!*************************************************************************

        contains

!*************************************************************************


!======================================================================
! BEGIN INIT_SPECTRAL_TRANSFORMS
!======================================================================
        subroutine init_spectral_transforms

!-----------------------------------------------------------------------
! PURPOSE : read in eigenvalues and eigenvectors and scatter across
!	all processors
!-----------------------------------------------------------------------

        implicit none

!-----------------------------------------------------------------------
! VARIABLE DESCRIPTION
!-----------------------------------------------------------------------

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j,k,lrecl,ieigen,ioerr,icorner
	real (kind=dbl_kind) :: tmpz(neigen_z), tmpzm(neigen_zm)

!-------------------------------------------------------------------------
! initialize
!-------------------------------------------------------------------------
	evalues_z = 0.0_dbl_kind
	evectors_z = 0.0_dbl_kind
        evalues_zm = 0.0_dbl_kind
        evectors_zm = 0.0_dbl_kind

!-------------------------------------------------------------------------
!  get record length and do error checking
!-------------------------------------------------------------------------
	open(4,file='./data/z_eigen.data',form='unformatted',              &
                         access='DIRECT', iostat = ioerr, recl=8)
	if(ioerr /= 0) then
	  write(6,*) ' error opening z_eigen.data'
          stop
	endif
        read(4,rec=1,iostat=ioerr) ieigen,lrecl
	close(4)
        if(ioerr.ne.0) then
	  write(6,*) ' error reading eigen.data'
	  stop
        endif
	if(ieigen.ne.neigen_z) then
	  write(6,*) ' z_eigen.data does not match model resolution'
	  stop
	endif

!-------------------------------------------------------------------------
! open for full read
!-------------------------------------------------------------------------
        open(4,file='./data/z_eigen.data',form='unformatted',             &
                         access='DIRECT', recl=lrecl)

!-------------------------------------------------------------------------
! everyone gets all the eigenvalues
!-------------------------------------------------------------------------
	read(4,rec=2) tmpz
	evalues_z(:) = tmpz(:)

!-------------------------------------------------------------------------
! each domain gets its part of all the eigenvectors
!-------------------------------------------------------------------------
	do k=1,nsdm
	do j=1,jjm
	do i=1,iim
	  read(4,rec=grid_center_index(i,j,k)+2) tmpz
	  evectors_z(:,i,j,k) = tmpz(:)
	enddo
	enddo
	enddo

!-------------------------------------------------------------------------
! close
!-------------------------------------------------------------------------
	close(4)

!-------------------------------------------------------------------------
! zero ghost cell locations
!-------------------------------------------------------------------------
	do k=1,neigen_z
	  evectors_z(k,:,:,:) = grid_center_mask(:,:,:)*evectors_z(k,:,:,:)
	enddo

!-------------------------------------------------------------------------
! REPEAT FOR THE ZM GRID
!-------------------------------------------------------------------------

!-------------------------------------------------------------------------
!  get record length and do error checking
!-------------------------------------------------------------------------
        open(4,file='./data/zm_eigen.data',form='unformatted',              &
                         access='DIRECT', iostat = ioerr, recl=8)
        if(ioerr /= 0) then
          write(6,*) ' error opening zm_eigen.data'
          stop
        endif
        read(4,rec=1,iostat=ioerr) ieigen,lrecl
        close(4)
        if(ioerr.ne.0) then
          write(6,*) ' error reading eigen.data'
          stop
        endif
        if(ieigen.ne.neigen_zm) then
          write(6,*) ' zm_eigen.data does not match model resolution'
          stop
        endif

!-------------------------------------------------------------------------
! open for full read
!-------------------------------------------------------------------------
        open(4,file='./data/zm_eigen.data',form='unformatted',             &
                         access='DIRECT', recl=lrecl)

!-------------------------------------------------------------------------
! everyone gets all the eigenvalues
!-------------------------------------------------------------------------
        read(4,rec=2) tmpzm
        evalues_zm(:) = tmpzm(:)

!-------------------------------------------------------------------------
! each domain gets part of every eigenvector
!-------------------------------------------------------------------------
        do k=1,nsdm
        do j=1,jjm
        do i=1,iim
        do icorner=1,ncorners
          if(grid_corner_mask(icorner,i,j,k) == 1.0_dbl_kind) then
            read(4,rec=grid_corner_index(icorner,i,j,k)+2) tmpzm
            evectors_zm(:,icorner,i,j,k) = tmpzm(:)
          endif
        enddo
        enddo
        enddo
        enddo

!-------------------------------------------------------------------------
! close
!-------------------------------------------------------------------------
        close(4)

!-------------------------------------------------------------------------
! zero ghost cell locations
!-------------------------------------------------------------------------
        do k=1,neigen_zm
          evectors_zm(k,:,:,:,:) = grid_corner_mask(:,:,:,:)*evectors_zm(k,:,:,:,:)
        enddo

        end subroutine init_spectral_transforms
!======================================================================
! END INIT_SPECTRAL_TRANSFORMS
!======================================================================


!======================================================================
! BEGIN Z_GRID_SPECTRAL_TRANSFORM
!====================================================================== 
        subroutine z_grid_spectral_transform(                         &
                rin,                                                  &
                sout  )

!-----------------------------------------------------------------------
! PURPOSE : given a field in R-space, transform to S-space
!-----------------------------------------------------------------------

        implicit none

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(in) ::                          &
                        rin                       (iim,jjm,nsdm)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                         &
                        sout                      (neigen_z)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j,k,ieigen
	real (kind=dbl_kind) :: tmpz(neigen_z)


!----------------------------------------------------------------------------
! INITIALIZE
!----------------------------------------------------------------------------
	do ieigen=1,neigen_z
	  sout(ieigen) = 0.0_dbl_kind
	  tmpz(ieigen) = 0.0_dbl_kind
        enddo

!----------------------------------------------------------------------------
! TRANSFORM
!----------------------------------------------------------------------------
	do k=1,nsdm
	do j=1,jjm
	do i=1,iim
	do ieigen=1,neigen_z
	  tmpz(ieigen) = tmpz(ieigen) + rin(i,j,k)*evectors_z(ieigen,i,j,k)
	enddo
	enddo
	enddo
	enddo

#if mpi == 1
	call MPI_ALLREDUCE(tmpz, sout, neigen_z, mpi_float_type, MPI_SUM, MPI_COMM_ATMOS, ierr)
#else
	sout(:) = tmpz(:)
#endif

        end subroutine z_grid_spectral_transform
!======================================================================
! END Z_GRID_SPECTRAL_TRANSFORM
!======================================================================



!======================================================================
! BEGIN ZM_GRID_SPECTRAL_TRANSFORM
!====================================================================== 
        subroutine zm_grid_spectral_transform(                         &
                rin,                                                  &
                sout  )

!-----------------------------------------------------------------------
! PURPOSE : given a field in R-space, transform to S-space
!-----------------------------------------------------------------------

        implicit none

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(in) ::                          &
                        rin                       (ncorners,iim,jjm,nsdm)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                         &
                        sout                      (neigen_zm)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j,k,ieigen,icorner
        real (kind=dbl_kind) :: tmpzm(neigen_zm)


!----------------------------------------------------------------------------
! INITIALIZE
!----------------------------------------------------------------------------
        do ieigen=1,neigen_zm
          sout(ieigen) = 0.0_dbl_kind
          tmpzm(ieigen) = 0.0_dbl_kind
        enddo

!----------------------------------------------------------------------------
! TRANSFORM
!----------------------------------------------------------------------------
        do k=1,nsdm
        do j=1,jjm
        do i=1,iim
	do icorner=1,ncorners
        do ieigen=1,neigen_zm
          tmpzm(ieigen) = tmpzm(ieigen)                                   &
                + rin(icorner,i,j,k)*evectors_zm(ieigen,icorner,i,j,k)
        enddo
        enddo
        enddo
        enddo
	enddo

#if mpi == 1
        call MPI_ALLREDUCE(tmpzm, sout, neigen_zm, mpi_float_type, MPI_SUM, MPI_COMM_ATMOS, ierr)
#else
        sout(:) = tmpzm(:)
#endif

        end subroutine zm_grid_spectral_transform
!======================================================================
! END ZM_GRID_SPECTRAL_TRANSFORM
!======================================================================



!======================================================================
! BEGIN Z_GRID_SPECTRAL_LAPLACIAN
!======================================================================
	subroutine z_grid_spectral_laplacian(rin, rout)

!-----------------------------------------------------------------------
! PURPOSE :  given a field in R-space, transform to S-space,
!	compute the Laplacian in S-space, then inverse transform
!-----------------------------------------------------------------------

	implicit none

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(in) ::                          &
                        rin                       (iim,jjm,nsdm)

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                         &
                        rout                      (iim,jjm,nsdm)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
	real (kind=dbl_kind) :: s(neigen_z), factor
	real (kind=dbl_kind), parameter ::                           &
                        visc = 1.0  
	integer (kind=int_kind), parameter ::                        &
                        norder = 1

!----------------------------------------------------------------------------
! TRANSFORM
!----------------------------------------------------------------------------
	call z_grid_spectral_transform(rin,s)

!----------------------------------------------------------------------------
! MULTIPLY BY EIGENVALUES
!----------------------------------------------------------------------------
	s(:) = s(:) * (evalues_z(:)**norder)

!----------------------------------------------------------------------------
! INVERSE TRANSFORM
!----------------------------------------------------------------------------
	call z_grid_spectral_transform_inv(s, rout)

!----------------------------------------------------------------------------
! WEIGHT
!----------------------------------------------------------------------------
	factor = (-1)**(norder+1)*visc
	rout = visc * rout

	end subroutine z_grid_spectral_laplacian
!======================================================================
! END Z_GRID_SPECTRAL_LAPLACIAN
!======================================================================



!======================================================================
! BEGIN ZM_GRID_SPECTRAL_LAPLACIAN
!======================================================================
        subroutine zm_grid_spectral_laplacian(rin, rout)

!-----------------------------------------------------------------------
! PURPOSE :  given a field in R-space, transform to S-space,
!       compute the Laplacian in S-space, then inverse transform
!-----------------------------------------------------------------------

        implicit none

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(in) ::                          &
                        rin                       (ncorners,iim,jjm,nsdm)

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                         &
                        rout                      (ncorners,iim,jjm,nsdm)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        real (kind=dbl_kind) :: s(neigen_zm), factor
        real (kind=dbl_kind), parameter ::                           &
                        visc = 1.0  
        integer (kind=int_kind), parameter ::                        &
                        norder = 1

!----------------------------------------------------------------------------
! TRANSFORM
!----------------------------------------------------------------------------
        call zm_grid_spectral_transform(rin,s)

!----------------------------------------------------------------------------
! MULTIPLY BY EIGENVALUES
!----------------------------------------------------------------------------
        s(:) = s(:) * (evalues_zm(:)**norder)

!----------------------------------------------------------------------------
! INVERSE TRANSFORM
!----------------------------------------------------------------------------
        call zm_grid_spectral_transform_inv(s, rout)

!----------------------------------------------------------------------------
! WEIGHT
!----------------------------------------------------------------------------
        factor = (-1)**(norder+1)*visc
        rout = visc * rout

        end subroutine zm_grid_spectral_laplacian
!======================================================================
! END ZM_GRID_SPECTRAL_LAPLACIAN
!======================================================================



!======================================================================
! BEGIN Z_GRID_SPECTRAL_TRANSFORM_INV
!====================================================================== 
        subroutine z_grid_spectral_transform_inv(                     &
                s,                                                  &
                rout   )

!-----------------------------------------------------------------------
! PURPOSE : given the spectral weights (s), find the field in R-space
!-----------------------------------------------------------------------

        implicit none

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(in) ::                          &
                        s                       (neigen_z)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                         &
                        rout                      (iim,jjm,nsdm)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j,k,ieigen


!----------------------------------------------------------------------------
! INITIALIZE
!----------------------------------------------------------------------------
	do k=1,nsdm
	do j=1,jjm
	do i=1,iim
	  rout(i,j,k) = 0.0_dbl_kind
	enddo
	enddo
	enddo

!----------------------------------------------------------------------------
! INVERSE TRANSFORM
!----------------------------------------------------------------------------
        do k=1,nsdm
        do j=1,jjm
        do i=1,iim
        do ieigen=1,neigen_z
          rout(i,j,k) = rout(i,j,k) + s(ieigen)*evectors_z(ieigen,i,j,k)
        enddo
        enddo
        enddo
        enddo

        end subroutine z_grid_spectral_transform_inv
!======================================================================
! END Z_GRID_SPECTRAL_TRANSFORM_INV
!======================================================================


!======================================================================
! BEGIN ZM_GRID_SPECTRAL_TRANSFORM_INV
!====================================================================== 
        subroutine zm_grid_spectral_transform_inv(                     &
                s,                                                  &
                rout   )

!-----------------------------------------------------------------------
! PURPOSE : given the spectral weights (s), find the field in R-space
!-----------------------------------------------------------------------

        implicit none

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(in) ::                          &
                        s                       (neigen_zm)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                         &
                        rout                    (ncorners,iim,jjm,nsdm)

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
        integer (kind=int_kind) :: i,j,k,ieigen,icorner

!----------------------------------------------------------------------------
! INITIALIZE
!----------------------------------------------------------------------------
        do k=1,nsdm
        do j=1,jjm
        do i=1,iim
	do icorner=1,ncorners
          rout(icorner,i,j,k) = 0.0_dbl_kind
        enddo
        enddo
        enddo
	enddo

!----------------------------------------------------------------------------
! INVERSE TRANSFORM
!----------------------------------------------------------------------------
        do k=1,nsdm
        do j=1,jjm
        do i=1,iim
	do icorner=1,ncorners
        do ieigen=1,neigen_zm
          rout(icorner,i,j,k) = rout(icorner,i,j,k) +                     &
                        s(ieigen)*evectors_zm(ieigen,icorner,i,j,k)
        enddo
	enddo
        enddo
        enddo
        enddo

        end subroutine zm_grid_spectral_transform_inv
!======================================================================
! END ZM_GRID_SPECTRAL_TRANSFORM_INV
!======================================================================

#endif

	end module spectral_transforms_xxx

!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
