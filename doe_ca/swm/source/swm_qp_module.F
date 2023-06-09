!=============================================================================
! BEGIN SWM_QP_MODULE
!=============================================================================
 MODULE swm_qp_module

   use types
   use component_intra
   use grid_mask_variables_xxx
   use geodesic_grid_utilities
   use netcdf_geodesic
   use qp_utilities
   use prognostics

   implicit none
   save
   private

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!
! how to use this module:
!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!------------------------------------------------------------------------------
!   meta data variables needed by low level netcdf routines
!------------------------------------------------------------------------------
   type (meta_type) ::                                &
      hswm_2d

!------------------------------------------------------------------------------
!   number of installed available qps, change these as more qps are added
!------------------------------------------------------------------------------
   integer (kind=int_kind), parameter ::                                &
      nqp  = 11

!------------------------------------------------------------------------------
!   define qp storage (includes both qp2 and qp3 data)
!------------------------------------------------------------------------------
     TYPE (qp_type) :: hqp(nqp)

!------------------------------------------------------------------------------
!   number of saved fields
!------------------------------------------------------------------------------
   integer (kind=int_kind) :: iqp = 0

!------------------------------------------------------------------------------
!   time at start of summation
!------------------------------------------------------------------------------
   integer (kind=int_dbl_kind) :: nsecondinit

!------------------------------------------------------------------------------
!   unique points in domain
!------------------------------------------------------------------------------
 ! problem here, need a qp_points for both qp2 and qp3 data
   integer (kind=int_kind) :: qp_points

!------------------------------------------------------------------------------
! public member functions
!------------------------------------------------------------------------------
   public ::                                                            &
      initialize_swm_qp,                                                &
      write_swm_qp,                                                     &
      pack_swm_qp

 CONTAINS

!============================================================================
! BEGIN SUBROUTINE INITIALIZE_SWM_QP
!============================================================================
   subroutine initialize_swm_qp(   simulation_tag,                     &
                                   nsecond,                            &
                                   grid_center_lat,                    &
                                   grid_center_lon,                    &
                                   grid_corner_lat,                    &
                                   grid_corner_lon )

!------------------------------------------------------------------------------
!  argument list 
!------------------------------------------------------------------------------
   character*40, intent(in) :: simulation_tag
   integer (kind=int_dbl_kind), intent(in) :: nsecond
   real (kind=dbl_kind), intent(in), dimension(iim,jjm,nsdm) ::        &
      grid_center_lat, &
      grid_center_lon
   real (kind=dbl_kind), intent(in), dimension(ncorners,iim,jjm,nsdm) ::   &
      grid_corner_lat, &
      grid_corner_lon

!------------------------------------------------------------------------------
! local variables
!------------------------------------------------------------------------------
   integer (kind=int_kind) :: n, my_task
   integer (kind=int_kind) :: i, j, ksdm, n_points, corners

!------------------------------------------------------------------------------
! grid coordinates for output
!------------------------------------------------------------------------------
   real (kind=selected_real_kind(13)), allocatable, dimension(:) ::     &
      qpcenterlat, qpcenterlon
   real (kind=selected_real_kind(13)), allocatable, dimension(:,:) ::   &
      qpcornerlat, qpcornerlon

!------------------------------------------------------------------------------
! file time stamp labels
!------------------------------------------------------------------------------
   character*8, time_label
   character*4, proc_label

!------------------------------------------------------------------------------
! read from file to determine what qps to save
! assume at present that all qps are saved
!------------------------------------------------------------------------------
   iqp = nqp

!------------------------------------------------------------------------------
! initialize attribute data
! NOTE: variable name (hqp(:)%name) is limited to 16 characters
!------------------------------------------------------------------------------
    call init_qp_type(hqp)

!------------------------------------------------------------------------------
! set attribute data
! NOTE: variable name (qp(:)%name) is limited to 16 characters
!------------------------------------------------------------------------------
    call set_attribute_data

!-------------------------------------------------------------------------
!  label the restart with a time stamp 
!-------------------------------------------------------------------------
    write(unit=time_label,fmt='(i7)') 1000000+nsecond/86400
    time_label(1:1) = 'd'
    time_label = trim(time_label)
    my_task = get_my_task(swm_name)
    write(unit=proc_label,fmt='(i4)')1000+my_task
    proc_label(1:1) = 'p'
    proc_label = trim(proc_label)

!-------------------------------------------------------------------------
! count the number of grid cells saved to this qp file
!-------------------------------------------------------------------------
   call get_qp_points(qp_points, var3d = grid_center_mask)

!-------------------------------------------------------------------------
! assume six corners per cell
!-------------------------------------------------------------------------
   corners = 3 * ncorners  ! assuming hexagons 
   allocate (qpcornerlat(corners,qp_points))
   allocate (qpcenterlat(qp_points))
   allocate (qpcornerlon(corners,qp_points))
   allocate (qpcenterlon(qp_points))

!-------------------------------------------------------------------------
!  gather unique data
!-------------------------------------------------------------------------
   n_points = 0
   do ksdm = 1,nsdm
   do j = 1,jjm
   do i = 1,iim
     if(grid_center_mask(i,j,ksdm).gt.0.5_dbl_kind) then
       n_points = n_points + 1
       qpcenterlat(n_points) = grid_center_lat(i,j,ksdm)
       qpcenterlon(n_points) = grid_center_lon(i,j,ksdm)
       call get_surrounding_corners(i,j,iim,jjm,ncorners,6_int_kind, &
          polygon_type(i,j,ksdm), grid_corner_lat(:,:,:,ksdm), qpcornerlat(:,n_points))
       call get_surrounding_corners(i,j,iim,jjm,ncorners,6_int_kind, &
          polygon_type(i,j,ksdm), grid_corner_lon(:,:,:,ksdm), qpcornerlon(:,n_points))
       if(qpcornerlat(6,n_points) < -1.0e30) qpcornerlat(6,n_points)=qpcornerlat(5,n_points)
       if(qpcornerlon(6,n_points) < -1.0e30) qpcornerlon(6,n_points)=qpcornerlon(5,n_points)
      endif
   enddo
   enddo
   enddo

   call ginit_nc(                                                                     &
                  simulation_tag,                                                     &
                  "qp_output/hswm_"//trim(time_label)//trim(proc_label)//".g2.nc",    &
                  hswm_2d,                                                            &
                  hqp(:)%descr,                                                       &
                  hqp(:)%name,                                                        &
                  hqp(:)%units,                                                       &
                  hqp(:)%log,                                                         &
                  hqp(:)%category,                                                    &
                  hqp(:)%multfac,                                                     &
                  hqp(:)%contmin,                                                     &
                  hqp(:)%contint,                                                     &
                  hqp(:)%altunits,                                                    &
                  qpcornerlat,                                                        &
                  qpcornerlon,                                                        &
                  qpcenterlat,                                                        &
                  qpcenterlon,                                                        &
                  corners,                                                            &
                  qp_points,                                                          &
                  max_ig )


!-------------------------------------------------------------------------
! release temporay work space
!-------------------------------------------------------------------------
   deallocate (qpcornerlat)
   deallocate (qpcenterlat)
   deallocate (qpcornerlon)
   deallocate (qpcenterlon)

!-------------------------------------------------------------------------
! initialize averaging period start time, sample size, and accumulation array
!-------------------------------------------------------------------------
   nsecondinit = nsecond

 end subroutine initialize_swm_qp
!=============================================================================
! END INITIALIZE_SWM_QP
!=============================================================================


!=============================================================================
! BEGIN WRITE_SWM_QP
!=============================================================================
 subroutine write_swm_qp(nsecond)

!-------------------------------------------------------------------------
! argument list
!-------------------------------------------------------------------------
   integer (kind=int_dbl_kind), intent(in) :: nsecond

!-------------------------------------------------------------------------
! local variables
!-------------------------------------------------------------------------
   integer (kind=int_kind) :: n
   real (kind=real_kind) :: qp_samples_inv
   logical (kind=log_kind), dimension(iim,jjm,nsdm) :: l_grid_mask

!-------------------------------------------------------------------------
! adhoc work arrays
!-------------------------------------------------------------------------
   character (len=16), dimension(nqp) :: name
   character (len=16) :: name_tmp
   logical (kind=log_kind) :: dogeo(nqp)
   integer (kind=int_kind) :: index(nqp)
   real (kind=real_kind), allocatable :: work(:,:,:,:)
   integer (kind=int_kind) :: iqp2, i

!-------------------------------------------------------------------------
! fill grid mask
!-------------------------------------------------------------------------
   l_grid_mask = .false.
   where(grid_center_mask(:,:,:).gt.0.5_dbl_kind) l_grid_mask(:,:,:) = .true.

! fill adhoc work arrays
   iqp2 = 0
   do i=1,nqp
     if(associated(hqp(i)%qp2_data)) iqp2 = iqp2 + 1
   enddo
   write(6,*) iqp2
   allocate(work(iim,jjm,iqp2,nsdm))

! now the snap shot file
   iqp2 = 0
   do i=1,nqp
     if(associated(hqp(i)%qp2_data)) then
       iqp2 = iqp2 + 1
       name_tmp(1:16) = hqp(i)%name(1:16)
       name(iqp2) = name_tmp
       write(6,*) i,iqp2,name_tmp,name(iqp2),hqp(i)%name
       dogeo(iqp2) = .true.
       index(iqp2) = hqp(i)%itag
       work(:,:,iqp2,:) = hqp(i)%qp2_data(:,:,:)
     endif
   enddo

        write(6,*) 'before write'

!-------------------------------------------------------------------------
! write the data to a netcdf file
!-------------------------------------------------------------------------
   call gwrt_nc(nsecond, nsecondinit, qp_points, l_grid_mask,    &
         name(1:iqp2), dogeo(1:iqp2), index(1:iqp2), hswm_2d,    &
         grid_center_index(:,:,:), work(:,:,:,:))
        
      write(6,*)'nsec, nsecinit ',nsecond, nsecondinit
        write(6,*) 'after write'

! deallocate adhoc work arrays
   deallocate(work)

!-------------------------------------------------------------------------
! initialize averaging period start time, sample size, and accumulation array
!   for next period of summation
!-------------------------------------------------------------------------
   nsecondinit = nsecond
   do n=1,nqp
   if(associated(hqp(n)%qp2_data)) then
     hqp(n)%qp2_data = c0
   endif
   if(associated(hqp(n)%qp3_data)) then
     hqp(n)%qp3_data = c0
   endif
   enddo
   hqp(:)%nsamples = 0

 end subroutine write_swm_qp
!=============================================================================
! END WRITE_SWM_QP
!=============================================================================


!=============================================================================
! BEGIN PACK_SWM_QP
!=============================================================================
 subroutine pack_swm_qp

 integer (kind=int_kind) :: integer_tag, ksdm

   integer_tag = get_my_qp_tag("thickness",hqp(:)%name, hqp(:)%itag)
   do ksdm=1,nsdm
    call qpsum( xin=hqp(integer_tag), ksdm=ksdm,  factor=1.0_dbl_kind,  data_2d=h(:,:,n4,ksdm), replace=.true.)
   enddo
   integer_tag = get_my_qp_tag("height",hqp(:)%name, hqp(:)%itag)
   do ksdm=1,nsdm
    call qpsum( xin=hqp(integer_tag), ksdm=ksdm,  factor=1.0_dbl_kind,  data_2d=h(:,:,n4,ksdm)+hs(:,:,ksdm), replace=.true.)
   enddo
   integer_tag = get_my_qp_tag("relative",hqp(:)%name, hqp(:)%itag)
   do ksdm=1,nsdm
    call qpsum( xin=hqp(integer_tag), ksdm=ksdm,  factor=1.0_dbl_kind,  data_2d=relative(:,:,ksdm), replace=.true.)
   enddo
   integer_tag = get_my_qp_tag("divergence",hqp(:)%name, hqp(:)%itag)
   do ksdm=1,nsdm
    call qpsum( xin=hqp(integer_tag), ksdm=ksdm,  factor=1.0_dbl_kind,  data_2d=div(:,:,n4,ksdm), replace=.true.)
   enddo
   integer_tag = get_my_qp_tag("absolute",hqp(:)%name, hqp(:)%itag)
   do ksdm=1,nsdm
    call qpsum( xin=hqp(integer_tag), ksdm=ksdm,  factor=1.0_dbl_kind,  data_2d=eta(:,:,n4,ksdm), replace=.true.)
   enddo
   integer_tag = get_my_qp_tag("kinetic_energy",hqp(:)%name, hqp(:)%itag)
   do ksdm=1,nsdm
    call qpsum( xin=hqp(integer_tag), ksdm=ksdm,  factor=1.0_dbl_kind,  data_2d=ke(:,:,ksdm), replace=.true.)
   enddo

   if(ntracer>0) then
   integer_tag = get_my_qp_tag("tracer_1",hqp(:)%name, hqp(:)%itag)
   do ksdm=1,nsdm
    call qpsum( xin=hqp(integer_tag), ksdm=ksdm,  factor=1.0_dbl_kind,  data_2d=tracer(:,:,1,n4,ksdm), replace=.true.)
   enddo
   endif
   if(ntracer>1) then
   integer_tag = get_my_qp_tag("tracer_2",hqp(:)%name, hqp(:)%itag)
   do ksdm=1,nsdm
    call qpsum( xin=hqp(integer_tag), ksdm=ksdm,  factor=1.0_dbl_kind,  data_2d=tracer(:,:,2,n4,ksdm), replace=.true.)
   enddo
   endif
   if(ntracer>2) then
   integer_tag = get_my_qp_tag("tracer_3",hqp(:)%name, hqp(:)%itag)
   do ksdm=1,nsdm
    call qpsum( xin=hqp(integer_tag), ksdm=ksdm,  factor=1.0_dbl_kind,  data_2d=tracer(:,:,3,n4,ksdm), replace=.true.)
   enddo
   endif
   if(ntracer>3) then
   integer_tag = get_my_qp_tag("tracer_4",hqp(:)%name, hqp(:)%itag)
   do ksdm=1,nsdm
    call qpsum( xin=hqp(integer_tag), ksdm=ksdm,  factor=1.0_dbl_kind,  data_2d=tracer(:,:,4,n4,ksdm), replace=.true.)
   enddo
   endif
   if(ntracer>4) then
   integer_tag = get_my_qp_tag("tracer_5",hqp(:)%name, hqp(:)%itag)
   do ksdm=1,nsdm
    call qpsum( xin=hqp(integer_tag), ksdm=ksdm,  factor=1.0_dbl_kind,  data_2d=tracer(:,:,5,n4,ksdm), replace=.true.)
   enddo
   endif


 end subroutine pack_swm_qp
!=============================================================================
! END PACK_SWM_QP
!=============================================================================


!=============================================================================
! BEGIN SET_ATTRIBUTE_DATA
!=============================================================================
  subroutine set_attribute_data

  integer (kind=int_kind) :: n

!------------------------------------------------------------------------------
!  do assignments for variable name, units and description
!------------------------------------------------------------------------------
    iqp = 1
    hqp(iqp)%itag = iqp
    hqp(iqp)%name = "thickness"
    hqp(iqp)%units = "meters"
    hqp(iqp)%descr = "thickness of fliud layer"
    hqp(iqp)%log = .true.
    allocate(hqp(iqp)%qp2_data(iim,jjm,nsdm))
    hqp(iqp)%qp2_data = c0

    iqp = 2
    hqp(iqp)%itag = iqp
    hqp(iqp)%name = "height"
    hqp(iqp)%units = "meters"
    hqp(iqp)%descr = "surface height of fliud layer"
    hqp(iqp)%log = .true.
    allocate(hqp(iqp)%qp2_data(iim,jjm,nsdm))
    hqp(iqp)%qp2_data = c0

    iqp = 3
    hqp(iqp)%itag = iqp
    hqp(iqp)%name = "relative"
    hqp(iqp)%units = "1/s"
    hqp(iqp)%descr = "relative vorticity of fluid"
    hqp(iqp)%log = .true.
    allocate(hqp(iqp)%qp2_data(iim,jjm,nsdm))
    hqp(iqp)%qp2_data = c0

    iqp = 4
    hqp(iqp)%itag = iqp
    hqp(iqp)%name = "divergence"
    hqp(iqp)%units = "1/s"
    hqp(iqp)%descr = "divergence of fluid"
    hqp(iqp)%log = .true.
    allocate(hqp(iqp)%qp2_data(iim,jjm,nsdm))
    hqp(iqp)%qp2_data = c0

    iqp = 5
    hqp(iqp)%itag = iqp
    hqp(iqp)%name = "absolute"
    hqp(iqp)%units = "1/s"
    hqp(iqp)%descr = "absolute vorticity of fliud layer"
    hqp(iqp)%log = .true.
    allocate(hqp(iqp)%qp2_data(iim,jjm,nsdm))
    hqp(iqp)%qp2_data = c0

    iqp = 6
    hqp(iqp)%itag = iqp
    hqp(iqp)%name = "kinetic_energy"
    hqp(iqp)%units = "1/s"
    hqp(iqp)%descr = "kinetic energy of fluid"
    hqp(iqp)%log = .true.
    allocate(hqp(iqp)%qp2_data(iim,jjm,nsdm))
    hqp(iqp)%qp2_data = c0

    iqp = 7
    hqp(iqp)%itag = iqp
    hqp(iqp)%name = "tracer_1"
    hqp(iqp)%units = "tracer per unit thickness"
    hqp(iqp)%descr = "tracer field #1"
    hqp(iqp)%log = .true.
    allocate(hqp(iqp)%qp2_data(iim,jjm,nsdm))
    hqp(iqp)%qp2_data = c0

    iqp = 8
    hqp(iqp)%itag = iqp
    hqp(iqp)%name = "tracer_2"
    hqp(iqp)%units = "1/s"
    hqp(iqp)%descr = "tracer field #2"
    hqp(iqp)%log = .true.
    allocate(hqp(iqp)%qp2_data(iim,jjm,nsdm))
    hqp(iqp)%qp2_data = c0

    iqp = 9
    hqp(iqp)%itag = iqp
    hqp(iqp)%name = "tracer_3"
    hqp(iqp)%units = "tracer per unit thickness"
    hqp(iqp)%descr = "tracer field #3"
    hqp(iqp)%log = .true.
    allocate(hqp(iqp)%qp2_data(iim,jjm,nsdm))
    hqp(iqp)%qp2_data = c0

    iqp = 10
    hqp(iqp)%itag = iqp
    hqp(iqp)%name = "tracer_4"
    hqp(iqp)%units = "tracer per unit thickness"
    hqp(iqp)%descr = "tracer field #4"
    hqp(iqp)%log = .true.
    allocate(hqp(iqp)%qp2_data(iim,jjm,nsdm))
    hqp(iqp)%qp2_data = c0

    iqp = 11
    hqp(iqp)%itag = iqp
    hqp(iqp)%name = "tracer_5"
    hqp(iqp)%units = "tracer per unit thickness"
    hqp(iqp)%descr = "tracer field #5"
    hqp(iqp)%log = .true.
    allocate(hqp(iqp)%qp2_data(iim,jjm,nsdm))
    hqp(iqp)%qp2_data = c0



! add others here

!------------------------------------------------------------------------------
! clean up the character strings
!------------------------------------------------------------------------------
   do n=1,nqp
      hqp(n)%name = trim(hqp(n)%name)
      hqp(n)%units = trim(hqp(n)%units)
      hqp(n)%descr = trim(hqp(n)%descr)
   enddo

!------------------------------------------------------------------------------
! dump info to screen
!------------------------------------------------------------------------------
   do n = 1,nqp
     if(hqp(n)%log) then
       write(6,11) hqp(n)%name, hqp(n)%descr,hqp(n)%itag
 11    format('Will save hqp: ',a16,a40, '  in hqp slot  ', i4)
     endif
   enddo


 end subroutine set_attribute_data
!=============================================================================
! END SET_ATTRIBUTE_DATA
!=============================================================================

 end module swm_qp_module
!=============================================================================
! END SWM_QP_MODULE
!=============================================================================
