
        module dx_write_utility

!-----------------------------------------------------------------------
! PURPOSE: a set of utilities to write out data for dx visualization
!-----------------------------------------------------------------------

        use kinds

        private

        public :: write_scalar_data, write_corner_data, &
                  write_vector_center_data, write_vector_data

!**********************************************************************

        contains

!**********************************************************************

!---------------------------------------------------------------------------------
! ASSUMPTIONS
!   this module assumes a ./dx/output directory exists
!---------------------------------------------------------------------------------

!---------------------------------------------------------------------------------
! basic variable definitions
!   my_task : processor task number, used in output file tag
!   ncorners,iim,jjm,nsdm : grid dimensions
!   r3 : 3-space (must have value of "3")
!   grid_*_mask : mask with 0 at redundant points
!   trans_to_X1 : array to tranform vectors for lat/lon to xyz
!   xin : data to be written out
!   tau : a real number that will be truncated into character string for file tag
!   vtag : variable tag name
!---------------------------------------------------------------------------------


!======================================================================
! BEGINNING OF WRITE_SCALAR_DATA
!======================================================================
        subroutine write_scalar_data ( my_task, iim, jjm, nsdm, &
                                       grid_center_mask, xin, tau, vtag)
        implicit none
        integer (kind=int_kind) :: iim,jjm,nsdm
        real (kind=dbl_kind), intent(in) :: xin(iim,jjm,nsdm)
        real (kind=dbl_kind), intent(in) :: grid_center_mask(iim,jjm,nsdm)
        real (kind=dbl_kind), intent(in) :: tau
        integer (kind=int_kind), intent(in) :: my_task
        character (len=80), intent(in) :: vtag
        integer (kind=int_kind) :: itau,i,j,ksdm
        character (len=80) :: ctau, ftag, cwork, spacer

        spacer = ''
        spacer(1:1) = '.'
        spacer=trim(spacer)

        itau = 1000000+nint(tau)
        write(unit=ctau,fmt='(i7)') itau
        ctau(1:1) = 'd'
        ctau = trim(ctau)
        write(6,*) 'ctau  ',ctau

        ftag = trim('dx/output/') // trim(vtag) // trim(spacer) // trim(ctau)
        write(6,*) ' dx filename : ',ftag
        if(my_task.eq.0) then
        open(98,file=ftag,form='formatted',status='replace')
        else
        open(98,file=ftag,form='formatted',status='old',position='append')
        endif
        do ksdm=1,nsdm
        do j=1,jjm
        do i=1,iim
        if(grid_center_mask(i,j,ksdm).eq.1.0_dbl_kind) then
          write(98,fmt='(e20.10)') xin(i,j,ksdm)
        endif
        enddo
        enddo
        enddo
        close(98)
        end subroutine write_scalar_data
!======================================================================
! END OF WRITE_SCALAR_DATA
!======================================================================


!======================================================================
! BEGINNING OF WRITE_CORNER_DATA
!======================================================================
        subroutine write_corner_data ( my_task, ncorners, iim, jjm, nsdm, &
                                        grid_corner_mask, xin, tau, vtag)
        implicit none
        integer (kind=int_kind), intent(in) :: ncorners, iim, jjm, nsdm
        real (kind=dbl_kind), intent(in) :: xin(ncorners,iim,jjm,nsdm)
        real (kind=dbl_kind), intent(in) :: grid_corner_mask(ncorners,iim,jjm,nsdm)
        real (kind=dbl_kind), intent(in) :: tau
        integer (kind=int_kind), intent(in) :: my_task
        character (len=80), intent(in) :: vtag
        integer (kind=int_kind) :: itau,i,j,icorner,ksdm
        character (len=80) :: ctau, ftag
        itau = 1000000+nint(tau) 
        write(unit=ctau,fmt='(i7)') itau
        ctau(1:1) = 'd'
        ctau = trim(ctau)
        itau = my_task + 10000
        ftag = 'dx/output/' // vtag
        ftag = trim(ftag) // '.' // ctau
        if(my_task.eq.0) then
        open(98,file=ftag,form='formatted',status='replace')
        else
        open(98,file=ftag,form='formatted',status='old',position='append')
        endif
        write(6,*) my_task,ftag
        do ksdm=1,nsdm
        do j=1,jjm
        do i=1,iim
        do icorner=1,ncorners
        if(grid_corner_mask(icorner,i,j,ksdm).eq.1.0_dbl_kind) then
          write(98,fmt='(e20.10)') xin(icorner,i,j,ksdm)
        endif
        enddo
        enddo
        enddo
        enddo
        close(98)
        end subroutine write_corner_data
!======================================================================
! END OF WRITE_CORNER_DATA
!======================================================================


!======================================================================
! BEGINNING OF WRITE_VECTOR_CENTER_DATA
!======================================================================
        subroutine write_vector_center_data ( my_task, r3, iim, jjm, nsdm, &
                                               grid_center_mask, xin, tau, vtag)
        implicit none
        integer (kind=int_kind), intent(in) :: r3, iim, jjm, nsdm
        real (kind=dbl_kind), intent(in) :: xin(r3,iim,jjm,nsdm)
        real (kind=dbl_kind), intent(in) :: grid_center_mask(iim,jjm,nsdm)
        real (kind=dbl_kind), intent(in) :: tau
        integer (kind=int_kind), intent(in) :: my_task
        character (len=80), intent(in) :: vtag
        integer (kind=int_kind) :: itau,i,j,ksdm
        character (len=80) :: ctau, ftag
        real (kind=dbl_kind) :: t(3)
        itau = 1000000+nint(tau) 
        write(unit=ctau,fmt='(i7)') itau
        ctau(1:1) = 'd'
        ctau = trim(ctau)
        itau = my_task + 10000
        ftag = 'dx/output/' // vtag
        ftag = trim(ftag) // '.' // ctau
        if(my_task.eq.0) then
        open(98,file=ftag,form='formatted',status='replace')
        else
        open(98,file=ftag,form='formatted',status='old',position='append')
        endif
        write(6,*) my_task,ftag
        do ksdm=1,nsdm
        do j=1,jjm
        do i=1,iim
        if(grid_center_mask(i,j,ksdm).eq.1.0_dbl_kind) then
          t(:) = xin(:,i,j,ksdm)
          if(abs(t(1))<1.0e-15) t(1)=0.0
          if(abs(t(2))<1.0e-15) t(2)=0.0
          if(abs(t(3))<1.0e-15) t(3)=0.0
          write(98,fmt='(3e20.10)') t(1),t(2),t(3)
        endif
        enddo
        enddo
        enddo
        close(98)
        end subroutine write_vector_center_data
!======================================================================
! END OF WRITE_VECTOR_CENTER_DATA
!======================================================================


!======================================================================
! BEGINNING OF WRITE_VECTOR_DATA
!======================================================================
        subroutine write_vector_data ( my_task, nspace, r3, ncorners, iim, jjm, nsdm, &
                                       trans_to_X1, grid_corner_mask, xin, tau, vtag)
        implicit none
        integer (kind=int_kind), intent(in) :: r3, nspace, ncorners, iim, jjm, nsdm
        real (kind=dbl_kind), intent(in) ::      &
                xin(nspace,ncorners,iim,jjm,nsdm)
        real (kind=dbl_kind), intent(in) :: trans_to_X1(r3,r3,ncorners,iim,jjm,nsdm)
        real (kind=dbl_kind), intent(in) :: grid_corner_mask(ncorners,iim,jjm,nsdm)
        real (kind=dbl_kind), intent(in) :: tau
        integer (kind=int_kind), intent(in) :: my_task
        character (len=80), intent(in) :: vtag
        integer (kind=int_kind) :: itau,i,j,ksdm,icorner
        character (len=80) :: ctau, ftag
        real (kind=dbl_kind) :: t(3), s(3)
        itau = 1000000+nint(tau) 
        write(unit=ctau,fmt='(i7)') itau
        ctau(1:1) = 'd'
        ctau = trim(ctau)
        itau = my_task + 10000
        ftag = 'dx/output/' // vtag
        ftag = trim(ftag) // '.' // ctau
        if(my_task.eq.0) then
        open(98,file=ftag,form='formatted',status='replace')
        else
        open(98,file=ftag,form='formatted',status='old',position='append')
        endif
        do ksdm=1,nsdm
        do j=1,jjm
        do i=1,iim
        do icorner=1,ncorners
        if(grid_corner_mask(icorner,i,j,ksdm).eq.1.0_dbl_kind) then
          s(1) = xin(1,icorner,i,j,ksdm)
          s(2) = xin(2,icorner,i,j,ksdm)
          s(3) = 0.0_dbl_kind
          t(:) = matmul(trans_to_X1(:,:,icorner,i,j,ksdm),s(:))
          if(abs(t(1))<1.0e-15) t(1)=0.0
          if(abs(t(2))<1.0e-15) t(2)=0.0
          if(abs(t(3))<1.0e-15) t(3)=0.0
          write(98,fmt='(3e20.10)') t(1), t(2), t(3)
        endif
        enddo
        enddo
        enddo
        enddo
        close(98)
        end subroutine write_vector_data
!======================================================================
! END OF WRITE_VECTOR_DATA
!======================================================================

        end module dx_write_utility
