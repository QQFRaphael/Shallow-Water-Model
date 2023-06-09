!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

module cslp_module

!-----------------------------------------------------------------------
! PURPOSE: These are routines to convert from surface pressure to 
!          mean sea level pressure (CSLP) and the inverse function
!          converting from mean sea level pressure to surface pressure
!          (INVCSLP). These are based on the ECMWF algorithm
!-----------------------------------------------------------------------

   use kinds
   use params_physical

   implicit none
   private

   public ::                 &
        cslp, invcslp


!**********************************************************************

   contains

!**********************************************************************


!--------------------

   SUBROUTINE CSLP(psl, ps, theta, phis, nx, ny)

!    this subroutine uses the ecmwf algorithm that corrects for warm and
!       cold locations. It converts from surface pressure to sea level pressure.
!--------------------

!    argument list
   integer (kind=int_kind), intent(in) :: nx, ny  ! size of domain

   real (kind=dbl_kind), dimension(nx, ny), intent(in) ::         &
       ps,    &! surface pressure (Pa)
       theta, &! surface air potential temperature (K)
       phis    ! surface geopotential (m2/s2)
       
   real (kind=dbl_kind), dimension(nx,ny), intent(out) ::         &
       psl  ! sea level pressure (Pa)

!    local variables
   integer (kind=int_kind) :: i, j
   real (kind=dbl_kind) :: tem1, tem2, alpha, tstar, t0, tas

   do j = 1,ny
      do i = 1,nx
         psl(i,j) = ps(i,j)
         tas = theta(i,j) * ( ps(i,j)/ p0_sfc)**kappa
!   adjust lapse rate and temperatures for extremely warm and cold locations
         if( abs(phis(i,j)).ge.0.1) then
            alpha = 0.0065 * gas_const_R/grav
            t0 = tas + 0.0065 * phis(i,j) / grav
            tstar = tas
            if(tstar.le.290.5.and.t0.gt.290.5) then
               alpha = gas_const_R / phis(i,j) * (290.5 - tstar)
            elseif(tstar.gt.290.5.and.t0.gt.290.5) then
               alpha = 0.0
               tstar = 0.5 * (290.5+tstar)
            elseif(tstar.lt.255.0) then
               tstar = 0.5 * (255.0 + tstar)
            endif
            tem1 = 1./(gas_const_R*tstar)
            tem2 = alpha*phis(i,j)*tem1
            psl(i,j) = ps(i,j)*exp( phis(i,j)*tem1*           &
                  (1.-0.5*tem2 +0.33333333*tem2**2) )
         endif
      enddo
   enddo


   end subroutine cslp

!--------------------

   SUBROUTINE invCSLP(psl, ps, theta, phis, nx, ny, mask)

!    this subroutine inverts the ecmwf algorithm for sea level pressure

   integer (kind=int_kind), intent(in) :: nx, ny  ! size of domain

   real (kind=dbl_kind), dimension(nx, ny), intent(in) ::     &
       psl,   &! sea level pressure (Pa)
       theta, &! surface air potential temperature (K)
       phis    ! surface geopotential (m2/s2)

   real (kind=dbl_kind), dimension(nx, ny), intent(in), optional :: &
       mask   ! optional gridcell mask

   real (kind=dbl_kind), dimension(nx, ny), intent(out) :: &
       ps   ! surface pressure (Pa)

!    local variables
   integer (kind=int_kind) :: i, j, n
   real (kind=dbl_kind) :: tem1, tem2, t0
   real (kind=dbl_kind), dimension(nx, ny) :: alpha, tstar

! initialize tstar
   do j = 1,ny
      do i = 1,nx
         alpha(i,j) = 0.0065*gas_const_R/grav
         tstar(i,j) = (inv_p0_sfc*psl(i,j))**kappa * theta(i,j) -  &
                    0.0065_dbl_kind*phis(i,j)/ grav
      enddo
   enddo

!  iterate to get tstar
   if(present(mask)) then
      do n = 1,4
         do j = 1,ny
            do i = 1,nx
               if(mask(i,j) == c1)  then
                  tem1 = 1./(gas_const_R*tstar(i,j))
                  tem2 = alpha(i,j)*phis(i,j)*tem1
                  ps(i,j) = psl(i,j)*exp( - phis(i,j)*tem1*                 &
                      (1.-0.5_dbl_kind*tem2 +0.33333333_dbl_kind*tem2**2) )
                  tstar(i,j) = (inv_p0_sfc*ps(i,j))**kappa * theta(i,j)
               endif
            enddo
         enddo
      enddo
   else
      do n = 1,4
         do j = 1,ny
            do i = 1,nx
               tem1 = 1./(gas_const_R*tstar(i,j))
               tem2 = alpha(i,j)*phis(i,j)*tem1
               ps(i,j) = psl(i,j)*exp( - phis(i,j)*tem1*                    &
                   (1.-0.5_dbl_kind*tem2 +0.33333333_dbl_kind*tem2**2) )
               tstar(i,j) = (inv_p0_sfc*ps(i,j))**kappa * theta(i,j)
            enddo
         enddo
      enddo
   endif

! I don't think this block of code needs to be masked.
      do n = 1,2
         do j = 1,ny
            do i = 1,nx
               if(tstar(i,j).lt.255.0_dbl_kind) then
                  tstar(i,j) = 0.5_dbl_kind * (255.0_dbl_kind + tstar(i,j))
               else if(tstar(i,j).gt.290.5_dbl_kind) then
                  alpha(i,j) = 0.0_dbl_kind
                  tstar(i,j) = 0.5_dbl_kind * (290.5_dbl_kind + tstar(i,j))
               else
                  t0 = tstar(i,j) + 0.0065_dbl_kind * phis(i,j) / grav
                  if(t0.gt.290.5_dbl_kind) alpha(i,j) = gas_const_R / phis(i,j) *   &
                                      (290.5_dbl_kind - tstar(i,j))
               endif
               tem1 = 1._dbl_kind/(gas_const_R*tstar(i,j))
               tem2 = alpha(i,j)*phis(i,j)*tem1
               ps(i,j) = psl(i,j)*exp( - phis(i,j)*tem1*                          &
                     (1.-0.5_dbl_kind*tem2 +0.33333333_dbl_kind*tem2**2) )
               tstar(i,j) = (inv_p0_sfc*ps(i,j))**kappa * theta(i,j)
            enddo
         enddo
      enddo

   end subroutine invcslp

   end module cslp_module

!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
