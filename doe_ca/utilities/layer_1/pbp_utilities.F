MODULE pbp_utilities

   use kinds
   use types

   implicit none
   private

! public member functions
   public ::           &
      init_pbp_type,    &
      get_my_pbp_tag,   &
      pbp1sum,          &
      pbp2sum

CONTAINS


subroutine init_pbp_type(pbp)
  type (pbp_type) :: pbp(:)
  integer (kind=int_kind) :: i,ilength
    ilength = size(pbp)
    pbp(:)%name = "no pbp name"
    pbp(:)%units = "no pbp units"
    pbp(:)%category = "xxx"
    pbp(:)%descr = "no description"
    pbp(:)%nsamples = 0
    pbp(:)%log = .false.
    do i=1,ilength
      nullify(pbp(i)%pbp1_data)
      nullify(pbp(i)%pbp2_data)
    enddo
end subroutine init_pbp_type


!=============================================================================
! BEGIN GET_MY_PBP_TAG
!=============================================================================
 function get_my_pbp_tag (cstring,name_list,integer_list) result(integer_tag)

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
  if(string1 == name_list(k)) then
    iflag = 1
    integer_tag = integer_list(k)
  endif
 enddo

!-------------------------------------------------------------------------
! match not found
!-------------------------------------------------------------------------
 if(iflag == 0) then
  write(6,*) ' function get_my_pbp_tag failed'
  write(6,*) cstring
  write(6,*) name_list(:)
  stop
 endif

 end function get_my_pbp_tag
!=============================================================================
! END GET_MY_PBP_TAG
!=============================================================================

!=============================================================================
! BEGIN PBP1SUM
!=============================================================================
 SUBROUTINE pbp1sum(pbploc, xin, ksdm, factor, data2d, iim, jjm, ioffset)

   implicit none

!------------------------------------------------------------------------------
! intent(out) arguments
!------------------------------------------------------------------------------
   type (pbp_type), intent(inout) :: xin

!------------------------------------------------------------------------------
! intent(in) arguments
!------------------------------------------------------------------------------
   type (pbploc_type), intent(in) :: pbploc
   integer (kind=int_kind), intent(in) :: ksdm, iim, jjm
   real (kind=dbl_kind), intent(in) :: factor
   real (kind=dbl_kind), intent(in), dimension(iim,jjm) :: data2d

!------------------------------------------------------------------------------
! optional intent(in) arguments
!------------------------------------------------------------------------------
   integer (kind=int_kind), intent(in), optional :: ioffset

!------------------------------------------------------------------------------
! local
!------------------------------------------------------------------------------
   integer (kind=int_kind) :: offset, n, item

   if(ksdm == 1) xin%nsamples = xin%nsamples+1
   
!  no points to save in this subdomain
   if (pbploc%kijlen(ksdm) == 0) return 

   if (.not.associated(xin%pbp1_data)) then
      write(*,*) ' the pbp data is not associated pbp1'
      stop
   endif

   if (xin%log) then
         
!      if (present(ioffset)) then
!         offset = ioffset
!      else
!         offset = 0
!      endif
         
      do n = 1+pbploc%koffsetpbp(ksdm),                              &
                pbploc%kijlen(ksdm)+pbploc%koffsetpbp(ksdm)
!         item = pbploc%ipbploc(n) + (pbploc%jpbploc(n)-1)*iim - offset
!         if (item >= 1 .and. item <= len)                                      &
               xin%pbp1_data(n) = xin%pbp1_data(n)                             &
                        + factor * data2d(pbploc%ipbploc(n),pbploc%jpbploc(n))
      enddo

   endif 

 end subroutine pbp1sum
!=============================================================================
! END PBP1SUM
!=============================================================================


!=============================================================================
! BEGIN PBP2SUM
!=============================================================================
 SUBROUTINE pbp2sum(pbploc, xin, ksdm, factor, data3d, iim, jjm, lmp1, ioffset)

   implicit none

!------------------------------------------------------------------------------
! intent(out) arguments
!------------------------------------------------------------------------------
   type (pbp_type), intent(inout) :: xin

!------------------------------------------------------------------------------
! intent(in) arguments
!------------------------------------------------------------------------------
   type (pbploc_type), intent(in) :: pbploc
   integer (kind=int_kind), intent(in) :: ksdm, iim,jjm, lmp1
   real (kind=dbl_kind), intent(in) :: factor
   real (kind=dbl_kind), intent(in), dimension(iim, jjm ,lmp1) :: data3d

!------------------------------------------------------------------------------
! optional intent(in) arguments
!------------------------------------------------------------------------------
   integer (kind=int_kind), intent(in), optional :: ioffset

!------------------------------------------------------------------------------
! local
!------------------------------------------------------------------------------
   integer (kind=int_kind) :: offset, n, item

   if(ksdm == 1) xin%nsamples = xin%nsamples+1

!  no points to save in this subdomain
   if (pbploc%kijlen(ksdm) == 0) return 

   if (.not.associated(xin%pbp2_data)) then
      write(*,*) ' the pbp data is not associated pbp2'
      stop
   endif

   if (xin%log) then
         
!      if (present(ioffset)) then
!         offset = ioffset
!      else
!         offset = 0
!      endif
         
      do n = 1+pbploc%koffsetpbp(ksdm),                              &
                 pbploc%kijlen(ksdm)+pbploc%koffsetpbp(ksdm)
!         item = pbploc%ipbploc(n) + (pbploc%jpbploc(n)-1)*iim - offset
!         if (item >= 1 .and. item <= len)                                      &
               xin%pbp2_data(1:lmp1,n) = xin%pbp2_data(1:lmp1,n)               &
                            + factor *                                         &
                             data3d(pbploc%ipbploc(n),pbploc%jpbploc(n),1:lmp1)
      enddo

   endif 

 end subroutine pbp2sum
!=============================================================================
! END PBP2SUM
!=============================================================================



end module pbp_utilities
