MODULE qp_utilities

   use kinds
   use types

   implicit none
   private

! public member functions
   public ::           &
      qpsum,           &
      init_qp_type,    &
      get_qp_points,   &
      get_my_qp_tag

CONTAINS

SUBROUTINE qpsum( xin, ksdm, factor, data_2d, data_3d, replace)

   implicit none

!------------------------------------------------------------------------------
! intent(out) arguments
!------------------------------------------------------------------------------
   type (qp_type), intent(out) :: xin

!------------------------------------------------------------------------------
! intent(in) arguments
!------------------------------------------------------------------------------
   integer (kind=int_kind), intent(in) :: ksdm
   real (kind=dbl_kind), intent(in) :: factor

!------------------------------------------------------------------------------
! optional intent(in) arguments
!------------------------------------------------------------------------------
   real (kind=dbl_kind), intent(in), optional :: data_2d(:,:), data_3d(:,:,:)
   logical, intent(in), optional :: replace

!------------------------------------------------------------------------------
! local
!------------------------------------------------------------------------------
   logical :: flag

   flag = .false.
   if(present(replace)) flag = replace

   if(present(data_2d)) then
      if(.not.associated(xin%qp2_data)) then
        write(6,*) ' the qp data is not associated qp2'
        stop
      endif
      if(.not.flag) then
        xin%qp2_data(:,:,ksdm) = xin%qp2_data(:,:,ksdm) + factor * data_2d
        if(ksdm==1) xin%nsamples = xin%nsamples + 1
      else
        xin%qp2_data(:,:,ksdm) = factor * data_2d
        if(ksdm==1) xin%nsamples =  1
      endif
    endif

   if(present(data_3d)) then
      if(.not.associated(xin%qp3_data)) then
        write(6,*) ' the qp data is not associated qp3'
        stop
      endif
      if(.not.flag) then
        xin%qp3_data(:,:,:,ksdm) = xin%qp3_data(:,:,:,ksdm) + factor * data_3d
        if(ksdm==1) xin%nsamples = xin%nsamples + 1
      else
        xin%qp3_data(:,:,:,ksdm) = factor * data_3d
        if(ksdm==1) xin%nsamples =  1
      endif
    endif

end subroutine qpsum



subroutine init_qp_type(qp)
  type (qp_type) :: qp(:)
  integer (kind=int_kind) :: i,ilength
    ilength = size(qp)
    qp(:)%name = "no qp name"
    qp(:)%units = "no qp units"
    qp(:)%altunits = "no qp alternate units"
    qp(:)%descr = "no description"
    qp(:)%category = "xxx"
    qp(:)%nsamples = 0
    qp(:)%amip_sampling = .false.
    qp(:)%log = .false.
    qp(:)%multfac = 1.
    qp(:)%contmin = 1.e36
    qp(:)%contint = 1.e36
    do i=1,ilength
      nullify(qp(i)%qp2_data)
      nullify(qp(i)%qp3_data)
    enddo
end subroutine init_qp_type


subroutine get_qp_points(qp_points,var3d,var4d)
  real (kind=dbl_kind), intent(in), optional :: var3d(:,:,:), var4d(:,:,:,:)
  integer (kind=int_kind), intent(out) :: qp_points
  integer (kind=int_kind) :: ishape3(3), ishape4(4), ksdm, i, j, icorner
    if(present(var3d).and.present(var4d)) then
       write(6,*) ' get_qp_points : pick one'
       stop
    endif
       if(present(var3d)) then
      ishape3(:) = shape(var3d)
      qp_points = 0
      do ksdm = 1,ishape3(3)
         do j = 1,ishape3(2)
            do i = 1,ishape3(1)
               if(var3d(i,j,ksdm).gt.0.5_dbl_kind) qp_points = qp_points + 1
            enddo
         enddo
      enddo
    endif
    if(present(var4d)) then
      ishape4(:) = shape(var4d)
      qp_points = 0
      do ksdm = 1,ishape4(4)
         do j = 1,ishape4(3)
            do i = 1,ishape4(2)
              do icorner=1,ishape4(1)
               if(var4d(icorner,i,j,ksdm).gt.0.5_dbl_kind) qp_points = qp_points + 1
              enddo
            enddo
         enddo
      enddo
    endif
   
end subroutine get_qp_points

!=============================================================================
! BEGIN GET_MY_QP_TAG
!=============================================================================
 function get_my_qp_tag (cstring,name_list,integer_list) result(integer_tag)

!-------------------------------------------------------------------------
! intent(in)
!-------------------------------------------------------------------------
 character (len=*), intent(in) :: cstring, name_list(:)
 integer (kind=int_kind), intent(in) :: integer_list(:)

!-------------------------------------------------------------------------
! function result
!-------------------------------------------------------------------------
 integer (kind=int_kind) :: integer_tag

!-------------------------------------------------------------------------
! local
!-------------------------------------------------------------------------
 integer (kind=int_kind) :: i(1), k, iflag, l
 character(len=30) :: string1
 string1 = '                              '
 l = len_trim(cstring)
 string1(1:l) = cstring(1:l)
!-------------------------------------------------------------------------
! set flag to assume there is no match
!-------------------------------------------------------------------------
 iflag = 0

!-------------------------------------------------------------------------
! get size of lists
!-------------------------------------------------------------------------
 i(:) = shape(integer_list)

!-------------------------------------------------------------------------
! loop over list and try to find a match
!-------------------------------------------------------------------------
 do k=1,i(1)
  if(string1 == name_list(k) ) then
    iflag = 1
    integer_tag = integer_list(k)
  endif
 enddo

!-------------------------------------------------------------------------
! match not found
!-------------------------------------------------------------------------
 if(iflag == 0) then
  write(6,*) ' function get_my_qp_tag failed'
  write(6,*) cstring
  write(6,*) name_list(:)
  stop
 endif

 end function get_my_qp_tag
!=============================================================================
! END GET_MY_QP_TAG
!=============================================================================



end module qp_utilities
