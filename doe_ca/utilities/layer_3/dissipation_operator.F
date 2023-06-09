!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

        module dissipation_operator

!-----------------------------------------------------------------------
! PURPOSE : an approximation of vector Laplacian
!-----------------------------------------------------------------------

#if viscosity == 1

	use kinds
        use params_physical
	use params_grid_horizontal
        use params_MPI
	use geodesic_grid_utilities
	use wrap_data
        use grid_metrics_variables

	implicit none
	save

	private

	integer (kind=int_kind) ::                   &
                i,                                   &
                j,                                   &
      		idata,                               &
      		icorner,                             &
                ocorner,                             &
      		itriangle,                           &
      		ispace,                              &
      		i,j,k,kp1,kp2,km1

        real (kind = dbl_kind) ::                         &
                t(2,ndata,nspace,ncorners,iim,jjm,nsdm),  &
                magt(2,ndata,ncorners,iim,jjm,nsdm),      &
                magn(  ndata,ncorners,iim,jjm,nsdm)

	public ::  init_diss_op, dissipation


!*************************************************************************

        contains

!*************************************************************************

!======================================================================
! BEGINNING OF INIT_DISS_OP
!======================================================================

        subroutine init_diss_op(component_name)
	implicit none
        character (len=*), intent(in) :: component_name
        integer (kind=int_kind) :: ksdm
        real (kind=dbl_kind) :: work(r3,ncorners,iim,jjm,nsdm), rmag
        real (kind=dbl_kind) :: tmp1(r3), tmp2(r3), tmp3(r3), tmp4(r3), tmp5(r3)

! init
	t = c0
	magt = c0
	magn = c0

! wrap trans
        do i=1,r3
         work(:,:,:,:,:) = trans_to_X1(i,:,:,:,:,:)
         call wrap(component_name, vrtx_1L = work)
         trans_to_X1(i,:,:,:,:,:) = work(:,:,:,:,:)
         work(:,:,:,:,:) = trans_to_X2(i,:,:,:,:,:)
         call wrap(component_name, vrtx_1L = work)
         trans_to_X2(i,:,:,:,:,:) = work(:,:,:,:,:)
       enddo

! fill magn
! magn is simply the distance between grid cell centers
	do ksdm=1,nsdm
	do j=2,jjm-1
	do i=2,iim-1
   	 icorner = 1
           idata=1
	   tmp1(:) = p(:,i-1,j  ,ksdm) - p(:,i  ,j  ,ksdm)
           magn(idata,icorner,i,j,ksdm) = sqrt(tmp1(1)**2+tmp1(2)**2+tmp1(3)**2)
           idata=2
           tmp1(:) = p(:,i-1,j-1,ksdm) - p(:,i-1,j  ,ksdm)
           magn(idata,icorner,i,j,ksdm) = sqrt(tmp1(1)**2+tmp1(2)**2+tmp1(3)**2)
           idata=3
           tmp1(:) = p(:,i  ,j  ,ksdm) - p(:,i-1,j-1,ksdm)
           magn(idata,icorner,i,j,ksdm) = sqrt(tmp1(1)**2+tmp1(2)**2+tmp1(3)**2)
         icorner = 2
           idata=1
           tmp1(:) = p(:,i-1,j-1,ksdm) - p(:,i  ,j  ,ksdm)
           magn(idata,icorner,i,j,ksdm) = sqrt(tmp1(1)**2+tmp1(2)**2+tmp1(3)**2)
           idata=2
           tmp1(:) = p(:,i  ,j-1,ksdm) - p(:,i-1,j-1,ksdm)
           magn(idata,icorner,i,j,ksdm) = sqrt(tmp1(1)**2+tmp1(2)**2+tmp1(3)**2)
           idata=3
           tmp1(:) = p(:,i  ,j  ,ksdm) - p(:,i  ,j-1,ksdm)
           magn(idata,icorner,i,j,ksdm) = sqrt(tmp1(1)**2+tmp1(2)**2+tmp1(3)**2)
	enddo
	enddo
	enddo

! fill t and magt
! t is the unit vector pointing from the corner to the cell wall center
! magt is this distance
! the code below is repeated for each subzone, that is why it is long
	do ksdm = 1,nsdm
	do j=2,jjm-1
	do i=2,iim-1
	  icorner = 1
          ocorner = 2
	    idata = 1
	      tmp1(:) = c(:,icorner,i,j,ksdm)
              tmp2(:) = w(idata,:,icorner,i,j,ksdm)
              tmp3(:) = c(:,ocorner,i,j+1,ksdm)
              tmp4(:) = tmp1(:) - tmp2(:)
              tmp5(:)= matmul(trans_to_X2(:,:,icorner,i,j,ksdm),tmp4)
              rmag = sqrt( tmp5(1)**2 + tmp5(2)**2 + tmp5(3)**2 )
              t(1,idata,1:2,icorner,i,j,ksdm) = tmp5(1:2) / rmag
              magt(1,idata,icorner,i,j,ksdm) = rmag
              tmp4(:) = tmp3(:) - tmp2(:)
              tmp5(:)= matmul(trans_to_X2(:,:,ocorner,i,j+1,ksdm),tmp4)
              rmag = sqrt( tmp5(1)**2 + tmp5(2)**2 + tmp5(3)**2 )
              t(2,idata,1:2,icorner,i,j,ksdm) = tmp5(1:2) / rmag
              magt(2,idata,icorner,i,j,ksdm) = rmag
            idata = 2
              tmp1(:) = c(:,icorner,i,j,ksdm)
              tmp2(:) = w(idata,:,icorner,i,j,ksdm)
              tmp3(:) = c(:,ocorner,i-1,j,ksdm)
              tmp4(:) = tmp1(:) - tmp2(:)
              tmp5(:)= matmul(trans_to_X2(:,:,icorner,i,j,ksdm),tmp4)
              rmag = sqrt( tmp5(1)**2 + tmp5(2)**2 + tmp5(3)**2 )
              t(1,idata,1:2,icorner,i,j,ksdm) = tmp5(1:2) / rmag
              magt(1,idata,icorner,i,j,ksdm) = rmag
              tmp4(:) = tmp3(:) - tmp2(:)
              tmp5(:)= matmul(trans_to_X2(:,:,ocorner,i-1,j,ksdm),tmp4)
              rmag = sqrt( tmp5(1)**2 + tmp5(2)**2 + tmp5(3)**2 )
              t(2,idata,1:2,icorner,i,j,ksdm) = tmp5(1:2) / rmag
              magt(2,idata,icorner,i,j,ksdm) = rmag
            idata = 3
              tmp1(:) = c(:,icorner,i,j,ksdm)
              tmp2(:) = w(idata,:,icorner,i,j,ksdm)
              tmp3(:) = c(:,ocorner,i,j,ksdm)
              tmp4(:) = tmp1(:) - tmp2(:)
              tmp5(:)= matmul(trans_to_X2(:,:,icorner,i,j,ksdm),tmp4)
              rmag = sqrt( tmp5(1)**2 + tmp5(2)**2 + tmp5(3)**2 )
              t(1,idata,1:2,icorner,i,j,ksdm) = tmp5(1:2) / rmag
              magt(1,idata,icorner,i,j,ksdm) = rmag
              tmp4(:) = tmp3(:) - tmp2(:)
              tmp5(:)= matmul(trans_to_X2(:,:,ocorner,i,j,ksdm),tmp4)
              rmag = sqrt( tmp5(1)**2 + tmp5(2)**2 + tmp5(3)**2 )
              t(2,idata,1:2,icorner,i,j,ksdm) = tmp5(1:2) / rmag
              magt(2,idata,icorner,i,j,ksdm) = rmag
          icorner = 2
          ocorner = 1
            idata = 1
              tmp1(:) = c(:,icorner,i,j,ksdm)
              tmp2(:) = w(idata,:,icorner,i,j,ksdm)
              tmp3(:) = c(:,ocorner,i,j,ksdm)
              tmp4(:) = tmp1(:) - tmp2(:)
              tmp5(:)= matmul(trans_to_X2(:,:,icorner,i,j,ksdm),tmp4)
              rmag = sqrt( tmp5(1)**2 + tmp5(2)**2 + tmp5(3)**2 )
              t(1,idata,1:2,icorner,i,j,ksdm) = tmp5(1:2) / rmag
              magt(1,idata,icorner,i,j,ksdm) = rmag
              tmp4(:) = tmp3(:) - tmp2(:)
              tmp5(:)= matmul(trans_to_X2(:,:,ocorner,i,j,ksdm),tmp4)
              rmag = sqrt( tmp5(1)**2 + tmp5(2)**2 + tmp5(3)**2 )
              t(2,idata,1:2,icorner,i,j,ksdm) = tmp5(1:2) / rmag
              magt(2,idata,icorner,i,j,ksdm) = rmag
            idata = 2
              tmp1(:) = c(:,icorner,i,j,ksdm)
              tmp2(:) = w(idata,:,icorner,i,j,ksdm)
              tmp3(:) = c(:,ocorner,i,j-1,ksdm)
              tmp4(:) = tmp1(:) - tmp2(:)
              tmp5(:)= matmul(trans_to_X2(:,:,icorner,i,j,ksdm),tmp4)
              rmag = sqrt( tmp5(1)**2 + tmp5(2)**2 + tmp5(3)**2 )
              t(1,idata,1:2,icorner,i,j,ksdm) = tmp5(1:2) / rmag
              magt(1,idata,icorner,i,j,ksdm) = rmag
              tmp4(:) = tmp3(:) - tmp2(:)
              tmp5(:)= matmul(trans_to_X2(:,:,ocorner,i,j-1,ksdm),tmp4)
              rmag = sqrt( tmp5(1)**2 + tmp5(2)**2 + tmp5(3)**2 )
              t(2,idata,1:2,icorner,i,j,ksdm) = tmp5(1:2) / rmag
              magt(2,idata,icorner,i,j,ksdm) = rmag
            idata = 3
              tmp1(:) = c(:,icorner,i,j,ksdm)
              tmp2(:) = w(idata,:,icorner,i,j,ksdm)
              tmp3(:) = c(:,ocorner,i+1,j,ksdm)
              tmp4(:) = tmp1(:) - tmp2(:)
              tmp5(:)= matmul(trans_to_X2(:,:,icorner,i,j,ksdm),tmp4)
              rmag = sqrt( tmp5(1)**2 + tmp5(2)**2 + tmp5(3)**2 )
              t(1,idata,1:2,icorner,i,j,ksdm) = tmp5(1:2) / rmag
              magt(1,idata,icorner,i,j,ksdm) = rmag
              tmp4(:) = tmp3(:) - tmp2(:)
              tmp5(:)= matmul(trans_to_X2(:,:,ocorner,i+1,j,ksdm),tmp4)
              rmag = sqrt( tmp5(1)**2 + tmp5(2)**2 + tmp5(3)**2 )
              t(2,idata,1:2,icorner,i,j,ksdm) = tmp5(1:2) / rmag
              magt(2,idata,icorner,i,j,ksdm) = rmag
	enddo
	enddo
	enddo

	magn = a * magn
  	magt = a * magt

	end subroutine init_diss_op
!======================================================================
! END OF INIT_DISS_OP
!======================================================================


!======================================================================
! BEGINNING OF DISSIPATION
!======================================================================
	subroutine dissipation(component_name,norder,visc,km,xin,xout)

	implicit none

!-----------------------------------------------------------------------
! INTENT (IN)
!-----------------------------------------------------------------------
        character (len=*), intent(in) :: component_name
        integer (kind=int_kind) :: norder, km
        real (kind = dbl_kind), intent(in) ::                     &
                visc,                                             & 
      		xin     (nspace, ncorners, iim, jjm, km, nsdm)

!-----------------------------------------------------------------------
! INTENT (OUT)
!-----------------------------------------------------------------------
        real (kind = dbl_kind), intent(out) ::                    &
                xout (nspace, ncorners, iim, jjm, km, nsdm)

!-----------------------------------------------------------------------
! LOCAL
!-----------------------------------------------------------------------
	integer (kind=int_kind) ::                                &
      		ksdm, icorner, i, j, k, idata, iorder

	real (kind = dbl_kind) ::                                 &
                tmp(2),                                           &
                div_edge(ndata,ncorners,iim,jjm) = 0,             &
                rel_edge(ndata,ncorners,iim,jjm) = 0,             &
                grad_div(nspace,ncorners,iim,jjm) = 0,            &
                grad_rel(nspace,ncorners,iim,jjm) = 0

!----------------------------------------------------------------------------
! initialize, use xout as workspace
!----------------------------------------------------------------------------
	do ksdm=1,nsdm
	do k=1,km
        do j=1,jjm
        do i=1,iim
        do icorner=1,ncorners
        do ispace=1,nspace
          xout(ispace,icorner,i,j,k,ksdm) = xin(ispace,icorner,i,j,k,ksdm)
        enddo
        enddo
        enddo
        enddo
	enddo
	enddo

!----------------------------------------------------------------------------
! loop over del2 operator norder times
!----------------------------------------------------------------------------
        do iorder=1,norder

!----------------------------------------------------------------------------
! wrap data
!----------------------------------------------------------------------------
	call wrap(component_name, vrtx = xout(:,:,:,:,:,:))

!----------------------------------------------------------------------------
! loop over subdomains and levels
!----------------------------------------------------------------------------
        do ksdm=1,nsdm
	do k=1,km

!-----------------------------------------------------------------------
! compute edge divergence and edge relative vorticity
!-----------------------------------------------------------------------
        do j=2,jjm-1
        do i=2,iim-1
           
         icorner = 1
         ocorner = 2
         idata = 1
         div_edge(idata,icorner,i,j) =                                           &
         ( + xout(1,icorner,i  ,j  ,k,ksdm) * t(1,idata,1,icorner,i,j,ksdm)      &
           + xout(2,icorner,i  ,j  ,k,ksdm) * t(1,idata,2,icorner,i,j,ksdm)      &
           + xout(1,ocorner,i  ,j+1,k,ksdm) * t(2,idata,1,icorner,i,j,ksdm)      &
           + xout(2,ocorner,i  ,j+1,k,ksdm) * t(2,idata,2,icorner,i,j,ksdm) ) /  &
             (magt(1,idata,icorner,i,j,ksdm)+magt(2,idata,icorner,i,j,ksdm))
         rel_edge(idata,icorner,i,j) =                                            &
         ( - xout(1,icorner,i  ,j  ,k,ksdm) * t(1,idata,2,icorner,i,j,ksdm)       &
           + xout(2,icorner,i  ,j  ,k,ksdm) * t(1,idata,1,icorner,i,j,ksdm)       &
           - xout(1,ocorner,i  ,j+1,k,ksdm) * t(2,idata,2,icorner,i,j,ksdm)       &
           + xout(2,ocorner,i  ,j+1,k,ksdm) * t(2,idata,1,icorner,i,j,ksdm) ) /   &
             (magt(1,idata,icorner,i,j,ksdm)+magt(2,idata,icorner,i,j,ksdm))


         icorner = 1
	 ocorner = 2
         idata = 2
         div_edge(idata,icorner,i,j) =       &
         ( + xout(1,icorner,i  ,j  ,k,ksdm) * t(1,idata,1,icorner,i,j,ksdm)       &
           + xout(2,icorner,i  ,j  ,k,ksdm) * t(1,idata,2,icorner,i,j,ksdm)       &
           + xout(1,ocorner,i-1,j  ,k,ksdm) * t(2,idata,1,icorner,i,j,ksdm)       &
           + xout(2,ocorner,i-1,j  ,k,ksdm) * t(2,idata,2,icorner,i,j,ksdm) ) /   &
             (magt(1,idata,icorner,i,j,ksdm)+magt(2,idata,icorner,i,j,ksdm))
         rel_edge(idata,icorner,i,j) =       &
         ( - xout(1,icorner,i  ,j  ,k,ksdm) * t(1,idata,2,icorner,i,j,ksdm)       &
           + xout(2,icorner,i  ,j  ,k,ksdm) * t(1,idata,1,icorner,i,j,ksdm)       &
           - xout(1,ocorner,i-1,j  ,k,ksdm) * t(2,idata,2,icorner,i,j,ksdm)       &
           + xout(2,ocorner,i-1,j  ,k,ksdm) * t(2,idata,1,icorner,i,j,ksdm) ) /   &
             (magt(1,idata,icorner,i,j,ksdm)+magt(2,idata,icorner,i,j,ksdm))

         icorner = 1
         ocorner = 2
         idata = 3
         div_edge(idata,icorner,i,j) =       &
         ( + xout(1,icorner,i  ,j  ,k,ksdm) * t(1,idata,1,icorner,i,j,ksdm)       &
           + xout(2,icorner,i  ,j  ,k,ksdm) * t(1,idata,2,icorner,i,j,ksdm)       &
           + xout(1,ocorner,i  ,j  ,k,ksdm) * t(2,idata,1,icorner,i,j,ksdm)       &
           + xout(2,ocorner,i  ,j  ,k,ksdm) * t(2,idata,2,icorner,i,j,ksdm) ) /   &
             (magt(1,idata,icorner,i,j,ksdm)+magt(2,idata,icorner,i,j,ksdm))
         rel_edge(idata,icorner,i,j) =       &
         ( - xout(1,icorner,i  ,j  ,k,ksdm) * t(1,idata,2,icorner,i,j,ksdm)       &
           + xout(2,icorner,i  ,j  ,k,ksdm) * t(1,idata,1,icorner,i,j,ksdm)       &
           - xout(1,ocorner,i  ,j  ,k,ksdm) * t(2,idata,2,icorner,i,j,ksdm)       &
           + xout(2,ocorner,i  ,j  ,k,ksdm) * t(2,idata,1,icorner,i,j,ksdm) ) /   &
               (magt(1,idata,icorner,i,j,ksdm)+magt(2,idata,icorner,i,j,ksdm))

         icorner = 2
         ocorner = 1
         idata = 1
         div_edge(idata,icorner,i,j) =       &
         ( + xout(1,icorner,i  ,j  ,k,ksdm) * t(1,idata,1,icorner,i,j,ksdm)       &
           + xout(2,icorner,i  ,j  ,k,ksdm) * t(1,idata,2,icorner,i,j,ksdm)       &
           + xout(1,ocorner,i  ,j  ,k,ksdm) * t(2,idata,1,icorner,i,j,ksdm)       &
           + xout(2,ocorner,i  ,j  ,k,ksdm) * t(2,idata,2,icorner,i,j,ksdm) ) /   &
             (magt(1,idata,icorner,i,j,ksdm)+magt(2,idata,icorner,i,j,ksdm))
         rel_edge(idata,icorner,i,j) =       &
         ( - xout(1,icorner,i  ,j  ,k,ksdm) * t(1,idata,2,icorner,i,j,ksdm)       &
           + xout(2,icorner,i  ,j  ,k,ksdm) * t(1,idata,1,icorner,i,j,ksdm)       &
           - xout(1,ocorner,i  ,j  ,k,ksdm) * t(2,idata,2,icorner,i,j,ksdm)       &
           + xout(2,ocorner,i  ,j  ,k,ksdm) * t(2,idata,1,icorner,i,j,ksdm) ) /   &
             (magt(1,idata,icorner,i,j,ksdm)+magt(2,idata,icorner,i,j,ksdm))

         icorner = 2
         ocorner = 1
         idata = 2
         div_edge(idata,icorner,i,j) =       &
         ( + xout(1,icorner,i  ,j  ,k,ksdm) * t(1,idata,1,icorner,i,j,ksdm)       &
           + xout(2,icorner,i  ,j  ,k,ksdm) * t(1,idata,2,icorner,i,j,ksdm)       &
           + xout(1,ocorner,i  ,j-1,k,ksdm) * t(2,idata,1,icorner,i,j,ksdm)       &
           + xout(2,ocorner,i  ,j-1,k,ksdm) * t(2,idata,2,icorner,i,j,ksdm) ) /   &
             (magt(1,idata,icorner,i,j,ksdm)+magt(2,idata,icorner,i,j,ksdm))
         rel_edge(idata,icorner,i,j) =       &
         ( - xout(1,icorner,i  ,j  ,k,ksdm) * t(1,idata,2,icorner,i,j,ksdm)       &
           + xout(2,icorner,i  ,j  ,k,ksdm) * t(1,idata,1,icorner,i,j,ksdm)       &
           - xout(1,ocorner,i  ,j-1,k,ksdm) * t(2,idata,2,icorner,i,j,ksdm)       &
           + xout(2,ocorner,i  ,j-1,k,ksdm) * t(2,idata,1,icorner,i,j,ksdm) ) /   &
             (magt(1,idata,icorner,i,j,ksdm)+magt(2,idata,icorner,i,j,ksdm))

         icorner = 2
         ocorner = 1
         idata = 3
         div_edge(idata,icorner,i,j) =       &
         ( + xout(1,icorner,i  ,j  ,k,ksdm) * t(1,idata,1,icorner,i,j,ksdm)       &
           + xout(2,icorner,i  ,j  ,k,ksdm) * t(1,idata,2,icorner,i,j,ksdm)       &
           + xout(1,ocorner,i+1,j  ,k,ksdm) * t(2,idata,1,icorner,i,j,ksdm)       &
           + xout(2,ocorner,i+1,j  ,k,ksdm) * t(2,idata,2,icorner,i,j,ksdm) ) /   &
             (magt(1,idata,icorner,i,j,ksdm)+magt(2,idata,icorner,i,j,ksdm))
         rel_edge(idata,icorner,i,j) =       &
         ( - xout(1,icorner,i  ,j  ,k,ksdm) * t(1,idata,2,icorner,i,j,ksdm)       &
           + xout(2,icorner,i  ,j  ,k,ksdm) * t(1,idata,1,icorner,i,j,ksdm)       &
           - xout(1,ocorner,i+1,j  ,k,ksdm) * t(2,idata,2,icorner,i,j,ksdm)       &
           + xout(2,ocorner,i+1,j  ,k,ksdm) * t(2,idata,1,icorner,i,j,ksdm) ) /   &
             (magt(1,idata,icorner,i,j,ksdm)+magt(2,idata,icorner,i,j,ksdm))

	enddo
	enddo

!-----------------------------------------------------------------------
! compute gradient of div_edge and rel_edge
!-----------------------------------------------------------------------
        grad_div = c0
	grad_rel = c0
	do j=2,jjm-1
	do i=2,iim-1
        do icorner=1,ncorners
        do idata=1,ndata
         grad_div(:,icorner,i,j) = grad_div(:,icorner,i,j) -                 &
             div_edge(idata,icorner,i,j) * magn(idata,icorner,i,j,ksdm) *    &
              t(1,idata,:,icorner,i,j,ksdm) *                                &
             corner_area_inv(icorner,i,j,ksdm)
         grad_rel(:,icorner,i,j) = grad_rel(:,icorner,i,j) -                 &
             rel_edge(idata,icorner,i,j) * magn(idata,icorner,i,j,ksdm) *    &
             t(1,idata,:,icorner,i,j,ksdm) *                                 &
             corner_area_inv(icorner,i,j,ksdm)
	enddo
	enddo
	enddo
	enddo
               
!-----------------------------------------------------------------------
! find k cross grad of the curl
!-----------------------------------------------------------------------
	do j=1,jjm
        do i=1,iim
        do icorner=1,ncorners
        tmp(:) = grad_rel(:,icorner,i,j)
        grad_rel(1,icorner,i,j) = -tmp(2)
        grad_rel(2,icorner,i,j) = +tmp(1)
        enddo
        enddo
        enddo

!----------------------------------------------------------------------------
! compute the intent(out) array
!----------------------------------------------------------------------------
        do j=1,jjm
        do i=1,iim
        do icorner=1,ncorners
        do ispace = 1,nspace
        xout(ispace,icorner,i,j,k,ksdm) = + grad_div(ispace,icorner,i,j)      &
                                          + grad_rel(ispace,icorner,i,j)
        enddo
        enddo
        enddo
	enddo

	enddo		! do ksdm=1,nsdm
	enddo		! do k=1,km
        enddo           ! do iorder=1,norder

!----------------------------------------------------------------------------
! multiply by the viscosity
!   NOTE: based on the order of the Laplacian, the dissipation is given either
!   as positive or negative sign
!----------------------------------------------------------------------------
	if(mod(norder,2) == 0) then
	  xout = -visc * xout
	else
	  xout = +visc * xout
	endif

!	write(6,*) minval(xout)*86400, maxval(xout)*86400

	end subroutine dissipation
!======================================================================
! END OF DISSIPATION
!======================================================================

#endif

        end module dissipation_operator
!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
