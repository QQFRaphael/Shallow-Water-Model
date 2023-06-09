!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

        module initialize

!-------------------------------------------------------------------------
! PURPOSE: do initialize for various utility as follows:
!	init of distibution of subdomains across processes
!	init of boundary updates of face (cell center) data
!	init of boundary updates of vertex (corner) data
!	definition of grid_center_mask and grid_corner_mask
!	generation of weights for computing div, curl, grad, Laplacian
!	init for visualization (OpenDx)
!	init for spectral transforms (if "transform" option turned on)
!	init of viscous dissipation operator
!	init of prognostic variables
!	defintion of coriolis parameter
!	init of time manager
!	generation of initial conditions	
!-------------------------------------------------------------------------

	use kinds
	use abort
        use params_physical
        use params_grid_horizontal_xxx
        use params_MPI
	use swm_parameters
	use assign_owner
        use comm_setup
        use component_intra
        use params_global_MPH
	use wrap_data
	use grid_metrics_variables_xxx
	use grid_metrics
	use grid_mask_variables_xxx
	use grid_mask
	use prognostics
	use operators
	use operators_hl_xxx
	use elliptic_solver_xxx
 	use multigrid_solver_xxx
	use time_manager_module
	use model_control
	use dx_module
	use budgets
 	use spectral_transforms_xxx
        use swm_qp_module
        use swm_restart
        use io_utilities
	use remap_xxx
     
#if viscosity == 1
 	use swm_dissipation_operator
#endif

	implicit none
	save

!*************************************************************************

        contains

!*************************************************************************

!======================================================================
! BEGINNING OF INITIALIZE_MODEL
!======================================================================
        subroutine initialize_model
	implicit none
	
	logical (kind=log_kind) :: l_error
        logical (kind=log_kind), parameter :: l_dump_grid = .true.
	integer (kind=int_kind) :: ksdm

        real(kind=dbl_kind), dimension(im,jm) :: xglbl
        real(kind=dbl_kind), dimension(max_ig) :: xvec
        real(kind=real_kind), dimension(max_ig) :: rvec
        character (len=80) :: run_name

	
        call init_swm_parameters()
        call initialize_component(swm_name)
        call comm_init(swm_name, MPI_COMM_swm, my_task, my_comp_id)
        call initialize_params_horizontal_xxx()
        call set_component_horizontal(swm_name,                           &
                                      max_level, even_odd_factor, max_ig, &
	                              im, jm, iim, jjm, isdm, jsdm )
        call set_component_parallel(swm_name,                          &
                                    npe, my_task, MPI_int_type,        &
	                            MPI_float_type, MPI_COMM_swm )

         write(6,*) swm_name
         write(6,*) MPI_COMM_swm
         write(6,*) my_task
         write(6,*) my_comp_id


!-----------------------------------------------------------------------
! assign subdomains to each process
!  (when message passing is turned off, all subdomains are owned by one process)
!-----------------------------------------------------------------------
        call set_assign_owner (isdm, jsdm, max_level, max_level,        &
                               partition_factor, swm_name, './assign_file' )

!-----------------------------------------------------------------------
! initialize the utility that updates the face data along subdomain boundary
!-----------------------------------------------------------------------
        call initialize_wrap(swm_name)

!-----------------------------------------------------------------------
! determine which grid cells are "real," and which are "ghost" cell
!-----------------------------------------------------------------------
        call set_grid_center_mask(swm_name,                             &
                                  im, jm, iim, jjm, nsdm,               &
                                  grid_center_mask, grid_center_index,  &
                                  polygon_type  )

!-----------------------------------------------------------------------
! based on the grid_center_mask, compute mask for the grid corners
!-----------------------------------------------------------------------
        call set_grid_corner_mask(swm_name,                             &
                                  ncorners, iim, jjm, nsdm,             &
                                  grid_center_index,                    &
                                  grid_corner_mask, grid_corner_index )

!-----------------------------------------------------------------------
! generate weights to compute divergence, curl, gradient, and Laplacian
!-----------------------------------------------------------------------
        call generate_grid_metrics(swm_name,                                &
                iim, jjm, nsdm, im, jm, max_ig, max_level,                  &
                ndata, ncorners, nspace,                                    &
                p, c, w, area, area_inv, corner_area, corner_area_inv,      &
                sub_area, sub_area_inv, dc, normal, tangent,                &
                v_weights, s_weights, l_weights, trans_to_X2, trans_to_X1,  &
                grid_center_lon, grid_center_lat,                           &
                grid_corner_lon, grid_corner_lat,                           &
                grid_center_centroid, grid_corner_centroid,                 &
                tot_area, inv_tot_area )

!-----------------------------------------------------------------------
! initialize the multigrid solver
!-----------------------------------------------------------------------
        call initialize_multigrid (swm_name)

!-----------------------------------------------------------------------
! write out grid center and grid corner coordinates
! this is used by OpenDX for visualization, it is not necessary for
! the integration of the model
!-----------------------------------------------------------------------
        if(l_dx) call write_dx_coordinate_data

! init netcdf files
        run_name = trim("SWTC#5")
        call initialize_swm_qp( &
           run_name, &
           nsecond_dyn,  &
           grid_center_lat(:,:,:), &
           grid_center_lon(:,:,:), &
           grid_corner_lat(:,:,:,:), &
           grid_corner_lon(:,:,:,:))

!-- added by mb
        call open_files

!-----------------------------------------------------------------------
! if data is present to compute "spectral" transforms directly from
! the geodesic grid, then init_spectral_transforms will read in that
! data and set up the mechanism to do the transforms.
!
! NOTE: this is an order N squared calculation. At resolutions above
! 10242, computing and memory requirements may be difficult to meet.
!
! to run on this utility, turn on the "transforms" option in the makefile
!-----------------------------------------------------------------------
#if transforms == 1
 	call init_spectral_transforms
#endif

!-----------------------------------------------------------------------
! initialize another set of operators that will be used in the 
! computation of the viscous dissipation
! this routine is initialize only when viscosity is turned on in makefile
!-----------------------------------------------------------------------
#if viscosity == 1
          call init_diss_op(swm_name)
#endif

!-----------------------------------------------------------------------
! initialize the data defined in prognostics.F
!-----------------------------------------------------------------------
	call init_prognostics

!-----------------------------------------------------------------------
! define the coriolis parameter at each grid cell center
!-----------------------------------------------------------------------
	call set_coriolis_parameter

!-----------------------------------------------------------------------
! initialize the time manager .... it keeps track of time
!-----------------------------------------------------------------------
	call init_time_manager

!-----------------------------------------------------------------------
! read in run time parameters from the "namelist" file
!-----------------------------------------------------------------------
	call input

!-----------------------------------------------------------------------
! based on the step_count parameter, get pointers (scalar integers)
! that point to the time index of n and n+1
!-----------------------------------------------------------------------
	call get_pointers

!-----------------------------------------------------------------------
! compute data used by incremental remapping scheme
!-----------------------------------------------------------------------
        if(l_remap) call init_remap (swm_name)

!-----------------------------------------------------------------------
! generate initial conditions for shallow water test case
!-----------------------------------------------------------------------

        if (l_swtc2) then
           call initial_conditions_swtc2
        else
           call initial_conditions_swtc5
        endif

        if(l_restart) then
! reads the file restarts/swm_restart
           call read_swm_restart
 	endif

 	
!-----------------------------------------------------------------------
! compute the amount of energy, enstrophy, ect at t=0
!-----------------------------------------------------------------------
	call compute_budgets

!-----------------------------------------------------------------------
! dump initial data to the output directory
!-----------------------------------------------------------------------
        if(l_dx) then
	call write_dx_data(                 &
!     *		h(:,:,n4,:)+hs(:,:,:),
      		h(:,:,n4,:),                &
      		psi(:,:,:),                 &
      		chi(:,:,:),                 &
      		relative(:,:,:),            &
      		eta(:,:,n4,:),              &
                div(:,:,n4,:),          &
      		ke(:,:,:),                  &
      		h_f(:,:,n3_f,:),            &
      		u(:,:,:,:,1,:),             &
                u_viscous(:,:,:,:,:),   &
                stress_tensor(:,:,:,:,:),                &
                tracer(:,:,1,n4,:),         &
                tracer(:,:,2,n4,:),         &
      		tau)

	call write_dx_init(                   &
      		hs(:,:,:),                    &
      		grid_center_lat(:,:,:),       &
      		grid_center_lon(:,:,:),       &
      		tau)
	endif

!-----------------------------------------------------------------------
! dump grid information in standard i/o format
!-----------------------------------------------------------------------
        if(l_dump_grid) call dump_grid

!-----------------------------------------------------------------------
! write initial conditions to qp output
!-----------------------------------------------------------------------
         call pack_swm_qp
         call write_swm_qp(nsecond_dyn)

	end subroutine initialize_model
!======================================================================
! END OF INITIALIZE_MODEL
!======================================================================

!======================================================================
! BEGINNING OF SET_CORIOLIS_PARAMETER
!======================================================================
        subroutine set_coriolis_parameter
        implicit none
	integer (kind=int_kind) :: i,j,ksdm
	real (kind=dbl_kind) :: s(2)
	
!-----------------------------------------------------------------------
! convert the grid center location (measured in (x,y,z)) to lat and lon
! then take 2*omega*sin(lat) to find f
! do this only at "real" grid cells
!-----------------------------------------------------------------------
	do ksdm=1,nsdm
	  do j=1,jjm
	    do i=1,iim
	      if(grid_center_mask(i,j,ksdm).eq.1.0_dbl_kind) then
	        call xyz_to_lonlat(p(:,i,j,ksdm),s(:))
	        f(i,j,ksdm)=c2*sin(s(2))*omega
	      endif
	    enddo
	  enddo
	enddo

!-----------------------------------------------------------------------
! wrap f (i.e. do a boundary update so all cells have a value of f
!-----------------------------------------------------------------------
	call wrap(swm_name,face_1L=f(:,:,:))

!-----------------------------------------------------------------------
! sanity check dumped to the screen
!-----------------------------------------------------------------------
	if(my_task==0) then
	write(6,*)
        write(6,*) 'min/max of Coriolis parameter  ',minval(f),maxval(f)
	write(6,*)
	endif

	end subroutine set_coriolis_parameter
!======================================================================
! END OF SET_CORIOLIS_PARAMETER
!======================================================================


!======================================================================
! BEGINNING OF INITIAL_CONDITIONS_SWTC5
!======================================================================
        subroutine initial_conditions_swtc5

        implicit none

        integer (kind=int_kind) :: i,j,ksdm,icorner
        real (kind=dbl_kind) :: s(2), t(3), f1, f2, f3, f4
        real (kind=dbl_kind) :: tmp(max_ig),tmp1(im,jm)
        real (kind=dbl_kind) :: work(iim,jjm,nsdm),work1(iim,jjm,nsdm)

        real (kind=dbl_kind) :: rlat,rlon,dist

        integer (kind=int_kind) :: nt

!-----------------------------------------------------------------------
! keep the user informed
!-----------------------------------------------------------------------
	if(my_task==0) then
	  write(6,*)
	  write(6,*) ' generating initial conditions for SW Test Case 5'
	  write(6,*)
	endif

!-----------------------------------------------------------------------
! zero topography (hs) and thickness field (h)
!-----------------------------------------------------------------------
        hs = c0
        h = 0.0

!-----------------------------------------------------------------------
! set some parameters
!-----------------------------------------------------------------------
        f1 = 20.0_dbl_kind
        f2 = 5960.0_dbl_kind
        f3 = pi/9.0_dbl_kind
        t(1) =  0.0
        t(2) = -cos(30.0*dtr)
        t(3) =  sin(30.0*dtr)

#if thin_fluid == 1
	f2 = 1000.0_dbl_kind
#endif

!-----------------------------------------------------------------------
! for each real cell, compute thickness
! for each real corner, compute velocity
!-----------------------------------------------------------------------
        do ksdm=1,nsdm
          do j=1,jjm
            do i=1,iim
              if(grid_center_mask(i,j,ksdm).eq.1.0_dbl_kind) then

!                call distance_along_unit_sphere(p(:,i,j,ksdm),t(:),f4)
! 	         hs(i,j,ksdm) = 2000.0_dbl_kind*(c1-min(f3,f4)/f3)

!-- alternate method for computing surface height
                rlat = grid_center_lat(i,j,ksdm)
                rlon = grid_center_lon(i,j,ksdm)
                if (rlon .lt. c0) rlon = rlon+2.0_dbl_kind*pi
                dist = sqrt((rlon -  1.5_dbl_kind*pi)**2 +               &
                            (rlat - pi/6.0_dbl_kind)**2)
                if (dist .lt. f3) then
                  hs(i,j,ksdm) = 2000.0_dbl_kind*(c1-dist/f3)
                else
                  hs(i,j,ksdm) = c0
                endif

	        call xyz_to_lonlat(p(:,i,j,ksdm),s(:))
                h(i,j,:,ksdm) = f2-(a*omega*f1+p5*f1**2)*(sin(s(2)))**2/grav
	        h(i,j,:,ksdm) = h(i,j,:,ksdm) - hs(i,j,ksdm)
              endif
              do icorner=1,ncorners
                if(grid_corner_mask(icorner,i,j,ksdm).eq.1.0_dbl_kind) then
                  call xyz_to_lonlat(c(:,icorner,i,j,ksdm),s(:))
                  u(1,icorner,i,j,:,ksdm) = f1*cos(s(2))
                  u(2,icorner,i,j,:,ksdm) = c0
                endif
              enddo
            enddo
          enddo
	enddo

!-----------------------------------------------------------------------
! insure positive definite thickness field
!-----------------------------------------------------------------------
#if thin_fluid == 1
	where(h.le.c0) h=c0
        do ksdm=1,nsdm
        do j=2,jjm
        do i=2,iim
          icorner = 1
          rlat = max(h(i,j,1,ksdm),h(i-1,j,1,ksdm),h(i-1,j-1,1,ksdm))
          if(rlat.le.1.0e-10) u(:,icorner,i,j,:,ksdm) = c0
          icorner = 2
          rlat = max(h(i,j,1,ksdm),h(i-1,j-1,1,ksdm),h(i,j-1,1,ksdm))
          if(rlat.le.1.0e-10) u(:,icorner,i,j,:,ksdm) = c0
        enddo
        enddo
        enddo
#endif


!-----------------------------------------------------------------------
! do a boundary update for the topography and thickness field
!-----------------------------------------------------------------------
        call wrap(swm_name,face=h(:,:,:,:))
        call wrap(swm_name,face_1L=hs(:,:,:))

!-----------------------------------------------------------------------
! do a boundary update for the velocity field
!-----------------------------------------------------------------------
	call wrap(swm_name,vrtx=u(:,:,:,:,:,:))

!-----------------------------------------------------------------------
! compute the relative vorticty and the divergence field
!-----------------------------------------------------------------------
	call calculate_rel_div_and_ke('swm',      &
                u(:,:,:,:,1,:),               &
                relative(:,:,:),              &
      		div(:,:,1,:),                     &
                ke(:,:,:)            )

!-----------------------------------------------------------------------
! copy information into the other time slot
!-----------------------------------------------------------------------
        div(:,:,2,:) = div(:,:,1,:)
        eta(:,:,1,:) = f(:,:,:) + relative(:,:,:)
	eta(:,:,2,:) = eta(:,:,1,:)

!-----------------------------------------------------------------------
! fill the tracers
!-----------------------------------------------------------------------

        if (ntracer < 2) then
           print*, 'ntracer =', ntracer
           print*, 'Please set ntracer to 2 or more'
           stop
        endif

! Set tracer 1 to have the same shape as the surface height field

        tracer(:,:,1,1,:) = hs(:,:,:)

! Set tracer 2 to a plateau with a sharp edge.

        do ksdm = 1, nsdm
           do j = 1, jjm
              do i = 1, iim
                 if (hs(i,j,ksdm) > c0) then
                    tracer(i,j,2,1,ksdm) = 1000._dbl_kind
                 else
                    tracer(i,j,2,1,ksdm) = c0
                 endif
              enddo
           enddo
        enddo

! Fill the remaining tracers with the Coriolis term.

        if (ntracer > 2) then
           do nt = 3, ntracer
              tracer(:,:,nt,1,:) = f(:,:,:)
           enddo
        endif

        tracer(:,:,:,2,:) = tracer(:,:,:,1,:)

#if thin_fluid == 1
	do nt=1,ntracer
	where(h(:,:,:,:).le.c0)
	  tracer(:,:,nt,:,:) = c0
	endwhere
	enddo
#endif

!-----------------------------------------------------------------------
! keep the user informed
!-----------------------------------------------------------------------
        if(my_task==0) then
          write(6,*)
          write(6,*) ' finished generating initial conditions'
          write(6,*)
        endif
   
	end subroutine initial_conditions_swtc5
!======================================================================
! END OF INITIAL_CONDITIONS_SWTC5
!======================================================================

!======================================================================
! BEGINNING OF INITIAL_CONDITIONS_SWTC2
!======================================================================
        subroutine initial_conditions_swtc2

!-----------------------------------------------------------------------
! These are the same as for SWTC5 except for two things:
! (1) The magnitude f1 of the initial velocity is chosen so that the
!     fluid will circle the earth in exactly 15 days.
! (2) There is no mountain in the surface height field. 
!-----------------------------------------------------------------------

        implicit none

        integer (kind=int_kind) :: i,j,ksdm,icorner
        real (kind=dbl_kind) :: s(2), t(3), f1, f2, f3, f4
        real (kind=dbl_kind) :: tmp(max_ig),tmp1(im,jm)
        real (kind=dbl_kind) :: work(iim,jjm,nsdm),work1(iim,jjm,nsdm)

        real (kind=dbl_kind) :: rlat,rlon,dist

        integer (kind=int_kind) :: nt

!-----------------------------------------------------------------------
! keep the user informed
!-----------------------------------------------------------------------
	if(my_task==0) then
	  write(6,*)
	  write(6,*) ' generating initial conditions for SW Test Case 2'
	  write(6,*)
	endif

!-----------------------------------------------------------------------
! zero topography (hs) and thickness field (h)
!-----------------------------------------------------------------------
        hs = c0
        h = 0.0

!-----------------------------------------------------------------------
! set some parameters
!-----------------------------------------------------------------------

        f1 = c2*pi*a / (15._dbl_kind*86400._dbl_kind)  ! 15-day period
        f2 = 5960.0_dbl_kind
        f3 = pi/9.0_dbl_kind

        t(1) =  0.0
        t(2) = -cos(30.0*dtr)
        t(3) =  sin(30.0*dtr)

!-----------------------------------------------------------------------
! for each real cell, compute thickness 
!   (computed initially for SWTC5, then recomputed later)
! for each real corner, compute velocity
!-----------------------------------------------------------------------
        do ksdm=1,nsdm
          do j=1,jjm
            do i=1,iim
              if(grid_center_mask(i,j,ksdm).eq.1.0_dbl_kind) then

!                call distance_along_unit_sphere(p(:,i,j,ksdm),t(:),f4)
! 	         hs(i,j,ksdm) = 2000.0_dbl_kind*(c1-min(f3,f4)/f3)

!-- alternate method for computing surface height
                rlat = grid_center_lat(i,j,ksdm)
                rlon = grid_center_lon(i,j,ksdm)
                if (rlon .lt. c0) rlon = rlon+2.0_dbl_kind*pi
!                write(*,*) 'rlat = ',rlat,' rlon = ',rlon
!                read(*,*)
                dist = sqrt((rlon -  1.5_dbl_kind*pi)**2 +               &
                            (rlat - pi/6.0_dbl_kind)**2)
                if (dist .lt. f3) then
                  hs(i,j,ksdm) = 2000.0_dbl_kind*(c1-dist/f3)
                else
                  hs(i,j,ksdm) = c0
                endif

	        call xyz_to_lonlat(p(:,i,j,ksdm),s(:))
                h(i,j,:,ksdm) = f2-(a*omega*f1+p5*f1**2)*(sin(s(2)))**2/grav
	        h(i,j,:,ksdm) = h(i,j,:,ksdm) - hs(i,j,ksdm)
              endif
              do icorner=1,ncorners
                if(grid_corner_mask(icorner,i,j,ksdm).eq.1.0_dbl_kind) then
                  call xyz_to_lonlat(c(:,icorner,i,j,ksdm),s(:))
                  u(1,icorner,i,j,:,ksdm) = f1*cos(s(2))
                  u(2,icorner,i,j,:,ksdm) = c0
                endif
              enddo
            enddo
          enddo
	enddo

!-----------------------------------------------------------------------
! do a boundary update for the topography and thickness field
!-----------------------------------------------------------------------
        call wrap(swm_name,face=h(:,:,:,:))
        call wrap(swm_name,face_1L=hs(:,:,:))

!-----------------------------------------------------------------------
! do a boundary update for the velocity field
!-----------------------------------------------------------------------
	call wrap(swm_name,vrtx=u(:,:,:,:,:,:))

!-----------------------------------------------------------------------
! compute the relative vorticty and the divergence field
!-----------------------------------------------------------------------
	call calculate_rel_div_and_ke('swm',      &
                u(:,:,:,:,1,:),               &
                relative(:,:,:),              &
      		div(:,:,1,:),                     &
                ke(:,:,:)            )

!-----------------------------------------------------------------------
! copy information into the other time slot
!-----------------------------------------------------------------------
        div(:,:,2,:) = div(:,:,1,:)
        eta(:,:,1,:) = f(:,:,:) + relative(:,:,:)
	eta(:,:,2,:) = eta(:,:,1,:)

!-----------------------------------------------------------------------
! fill the tracers
!-----------------------------------------------------------------------

        if (ntracer < 2) then
           print*, 'ntracer =', ntracer
           print*, 'Please set ntracer to 2 or more'
           stop
        endif

! Set tracer 1 to have the same shape as the SWTC5 surface height field

        tracer(:,:,1,1,:) = hs(:,:,:)

! Set tracer 2 to a plateau with a sharp edge.

        do ksdm = 1, nsdm
           do j = 1, jjm
              do i = 1, iim
                 if (hs(i,j,ksdm) > c0) then
                    tracer(i,j,2,1,ksdm) = 1000._dbl_kind
                 else
                    tracer(i,j,2,1,ksdm) = c0
                 endif
              enddo
           enddo
        enddo

! Fill the remaining tracers with the Coriolis term.

        if (ntracer > 2) then
           do nt = 3, ntracer
              tracer(:,:,nt,1,:) = f(:,:,:)
           enddo
        endif

        tracer(:,:,:,2,:) = tracer(:,:,:,1,:)

!-----------------------------------------------------------------------
! Remove the mountain and reset the height field for SWTC2. 
!-----------------------------------------------------------------------
        do ksdm=1,nsdm
           do j=1,jjm
              do i=1,iim
                 h(i,j,:,ksdm) = h(i,j,:,ksdm) + hs(i,j,ksdm)
                 hs(i,j,ksdm) = c0
              enddo
           enddo
        enddo

!-----------------------------------------------------------------------
! keep the user informed
!-----------------------------------------------------------------------
        if(my_task==0) then
          write(6,*)
          write(6,*) ' finished generating initial conditions'
          write(6,*)
        endif
   
	end subroutine initial_conditions_swtc2
!======================================================================
! END OF INITIAL_CONDITIONS_SWTC2
!======================================================================


!======================================================================
! BEGIN dump_grid
!======================================================================
        subroutine dump_grid
        character (len=80) :: grid_name, cwork
        real (kind=dbl_kind) :: work_lon(6,iim,jjm,nsdm), work_lat(6,iim,jjm,nsdm)
        real (kind=dbl_kind) :: work(1)
        integer (kind=int_kind) :: i,j,ksdm

!-----------------------------------------------------------------------
! fill corner lat/lon in format necessary for output
!-----------------------------------------------------------------------
        work_lon = c0; work_lat = c0
        do ksdm=1,nsdm; do j=1,jjm; do i=1,iim
          if(grid_center_mask(i,j,ksdm) == 1.0_dbl_kind) then
            call get_surrounding_corners(i,j,iim,jjm,ncorners,6_int_kind, &
               polygon_type(i,j,ksdm),                              &
               grid_corner_lon(:,:,:,ksdm), work_lon(:,i,j,ksdm))
            call get_surrounding_corners(i,j,iim,jjm,ncorners,6_int_kind, &
               polygon_type(i,j,ksdm),                              &
               grid_corner_lat(:,:,:,ksdm), work_lat(:,i,j,ksdm))
          endif
         enddo; enddo; enddo
         where(polygon_type >= 2.0_dbl_kind)
           work_lon(6,:,:,:) = work_lon(5,:,:,:)
           work_lat(6,:,:,:) = work_lat(5,:,:,:)
         endwhere

!-----------------------------------------------------------------------
! dump to file using standar io utility
!-----------------------------------------------------------------------
        grid_name = ''
        grid_name(1:10) = "grid_file_"
        write(unit=cwork, fmt='(i7)') 1000000 + max_ig
        cwork(1:1) = '0'
        grid_name(11:17) = cwork(1:7)
        grid_name = trim(grid_name)
        call pack_header( swm_name, 'grid_center_lat',      1, (/1/)  )
        call pack_header( swm_name, 'grid_center_lon',      1, (/1/)  )
        call pack_header( swm_name, 'grid_corner_lat',      1, (/6/)  )
        call pack_header( swm_name, 'grid_corner_lon',      1, (/6/)  )
        call pack_header( swm_name, 'grid_center_area',     1, (/1/)  )
        call pack_header( swm_name, 'grid_corner_area',     1, (/2/)  )
        call pack_header( swm_name, 'grid_center_centroid', 1, (/3/)  )
        call open_write_header( swm_name, grid_name, max_ig, .false., dbl_kind )
        do ksdm=1,nsdm; do j=1,jjm; do i=1,iim
         work(1) = grid_center_lat(i,j,ksdm)
         call pack_data_record ( swm_name, 'grid_center_lat', work(1:1))
         work(1) = grid_center_lon(i,j,ksdm)
         call pack_data_record ( swm_name, 'grid_center_lon', work(1:1))
         work(1) = area(i,j,ksdm)
         call pack_data_record ( swm_name, 'grid_center_area',work(1:))
         call pack_data_record ( swm_name, 'grid_corner_lat', work_lat(:,i,j,ksdm))
         call pack_data_record ( swm_name, 'grid_corner_lon', work_lon(:,i,j,ksdm))
         call pack_data_record ( swm_name, 'grid_corner_area', corner_area(:,i,j,ksdm))
         call pack_data_record ( swm_name, 'grid_center_centroid',grid_center_centroid(:,i,j,ksdm))
         call write_record ( swm_name, grid_center_mask(i,j,ksdm), grid_center_index(i,j,ksdm))
        enddo; enddo; enddo
        call close_direct_file( swm_name )

        end subroutine dump_grid
!======================================================================
! END DUMP_GRID
!======================================================================

        end module initialize

!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
