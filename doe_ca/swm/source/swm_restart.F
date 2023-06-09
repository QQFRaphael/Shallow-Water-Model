module swm_restart

! this module is designed to read and write restarts for the swm using
! direct access parallel io

   use kinds
   use params_grid_horizontal_xxx
   use prognostics
   use swm_parameters
   use io_utilities
   use output_utilities
   use wrap_data
   use grid_mask_variables_xxx
   use operators_hl_xxx
   use time_manager_module
   
   implicit none
   private
   
   public ::                                                 &
      read_swm_restart,                                      &
      write_swm_restart,                                     &
      read_swm_bc
      
   contains
   
   subroutine read_swm_restart
   
   integer (kind=int_kind) :: i,j,ksdm,nt  ! loop indices

! read the initial condition
      call open_read_direct_file( swm_name, 'restarts/swm_restart' )
      call read_time_stamp( swm_name, nsecond_dyn )
      do ksdm = 1,nsdm
         do j = 1,jjm
            do i = 1,iim
               call read_record( swm_name, grid_center_index(i,j,ksdm) )
               call unpack_data_record ( swm_name, 'H',      h(i,j,1:1,ksdm) )
               call unpack_data_record ( swm_name, 'TRACER', tracer(i,j,:,1,ksdm) )
               call unpack_data_record ( swm_name, 'U',      u(:,:,i,j,1,ksdm) )
            enddo
         enddo
      enddo
      call close_direct_file( swm_name )
   
   
!-----------------------------------------------------------------------
! perform other initialization operations from the initial data
!-----------------------------------------------------------------------
     
!-----------------------------------------------------------------------
! copy the input time level to all other time levels
!-----------------------------------------------------------------------
      do nt = 2,ntprog
         h(:,:,nt,:) = h(:,:,1,:)
         u(:,:,:,:,nt,:) = u(:,:,:,:,1,:)
         tracer(:,:,:,nt,:) = tracer(:,:,:,1,:)
      enddo
     
!-----------------------------------------------------------------------
! do a boundary update for the thickness field
!-----------------------------------------------------------------------
        call wrap(swm_name,face=h(:,:,:,:))
        do i=1,ntracer
          call wrap(swm_name,face=tracer(:,:,i,:,:))
        enddo

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
! keep the user informed
!-----------------------------------------------------------------------
        call output_process0(swm_name, ' ')
        call output_process0(swm_name, ' finished reading initial conditions')
        call output_process0(swm_name, ' ')
        
        
   end subroutine read_swm_restart

   subroutine read_swm_bc

   integer (kind=int_kind) :: i,j,ksdm  ! loop indices
   real (kind=dbl_kind), dimension(1) :: hstem

! read the initial condition
      call open_read_direct_file( swm_name, 'data/swm_bc' )
      do ksdm = 1,nsdm
         do j = 1,jjm
            do i = 1,iim
               call read_record( swm_name, grid_center_index(i,j,ksdm) )
               call unpack_data_record ( swm_name, 'HS',    hstem)
               hs(i,j,ksdm) = hstem(1)
            enddo
         enddo
      enddo
      call close_direct_file( swm_name )
   
      
   end subroutine read_swm_bc

   subroutine write_swm_restart

! local variables
   integer (kind=int_kind) :: i,j,ksdm,nt  ! loop indices
   character (len=37) :: rfile = 'restarts/swm_restart.d000000.hh:mm:ss'
   character (len=7) :: day_label              
   character (len=3) :: hour_label, minute_label, second_label  
   integer (kind=int_kind) :: second_remainder, time_tem

! day
   time_tem = nsecond_dyn / 86400
   write(unit=day_label, fmt='(i7)')1000000+time_tem
   rfile(23:28) = day_label(2:7)
   second_remainder = nsecond_dyn - 86400 * time_tem  
! hour          
   time_tem = second_remainder / 3600
   write(unit=hour_label, fmt='(i3)')100+time_tem
   rfile(30:31) = hour_label(2:3)
   second_remainder = second_remainder - 3600 * time_tem  
! minute          
   time_tem = second_remainder / 60
   write(unit=minute_label, fmt='(i3)')100+time_tem
   rfile(33:34) = minute_label(2:3)
   second_remainder = second_remainder - 60 * time_tem  
! second          
   write(unit=second_label, fmt='(i3)')100+second_remainder
   rfile(36:37) = second_label(2:3)

      call pack_header( swm_name, 'H',      1, (/1/)  )
      call pack_header( swm_name, 'TRACER', 1, (/ntracer/) )
      call pack_header( swm_name, 'U',      2, (/nspace,ncorners/)  )
      call open_write_header( swm_name, trim(rfile), max_ig, .true., dbl_kind )
      call write_time_stamp( swm_name, nsecond_dyn )
      do ksdm = 1,nsdm
         do j = 1,jjm
            do i = 1,iim
               call pack_data_record ( swm_name, 'H',      h(i,j,n4:n4,ksdm) )
               call pack_data_record ( swm_name, 'TRACER', tracer(i,j,:,n4,ksdm) )
               call pack_data_record ( swm_name, 'U',      u(:,:,i,j,n4,ksdm) )
               call write_record ( swm_name,                    &
                                   grid_center_mask(i,j,ksdm),  &
                                   grid_center_index(i,j,ksdm))
            enddo
         enddo
      enddo
      call close_direct_file( swm_name )

!-----------------------------------------------------------------------
! keep the user informed
!-----------------------------------------------------------------------
        call output_process0(swm_name, ' ')
        call output_process0(swm_name,'finished writing restart file '//rfile)
        call output_process0(swm_name, ' ')

   
   end subroutine write_swm_restart

end module swm_restart
