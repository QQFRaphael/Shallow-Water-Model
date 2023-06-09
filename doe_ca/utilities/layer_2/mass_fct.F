   MODULE mass_fct
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  PURPOSE:  Advection of mass and tracers using flux-corrected transport.
!            See Piotr Smolarkiewicz (hereafter (PS)) "Nonoscillatory 
!            Advection Schemes"  ECMF seminar proceedings. 9-13 Sept. 1991.
!            Numerical methods in atmospheric models.  Vol 1.
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   USE kinds
   USE operators
   USE wrap_data

   IMPLICIT NONE
   PRIVATE
   SAVE

   PUBLIC :: set_mass_fct

   CONTAINS

!=======================================================================
!  BEGIN set_mass_fct
!=======================================================================
   SUBROUTINE set_mass_fct (component_name,                            &
                            iim, jjm, nlm, nsdm,                       &
                            ntprog, nttend,                            &
                            ncorners, ndata, nedges, nspace, npad, r3, &
                            n3, n4,                                    &
                            tend_index, tend_weights,                  &
                            dt, area_inv, area, dc, normal,            &
                            mss, mss_c, u,                             &
                            mss_low, mss_flux_horz, msh_f,             &
                            mss_flux_forced, mask)

!.......................................................................
!  INTENT IN
!.......................................................................

   CHARACTER (LEN=*), INTENT(IN) :: component_name

   INTEGER (KIND=int_kind), INTENT( IN) :: iim,jjm,nlm,ntprog,nttend,         &
                                           nsdm, ncorners, n3, n4,npad,       &
                                           ndata, nedges, r3, nspace,         &
                                           tend_index(nttend)

   REAL (KIND=dbl_kind),INTENT( IN) :: dt, tend_weights(nttend)


   REAL (KIND=dbl_kind),INTENT( IN),                                        &
                DIMENSION(                iim,jjm,             nsdm) ::     &
      area_inv, area

   REAL (KIND=dbl_kind),INTENT( IN),                                        &
                DIMENSION(ndata,r3, ncorners, iim,jjm,             nsdm) :: &
      normal

   REAL (KIND=dbl_kind),INTENT( IN),                                        &
                DIMENSION(ndata,    ncorners, iim,jjm,             nsdm) :: &
      dc    

   REAL (KIND=dbl_kind),INTENT( IN), optional,                              &
                DIMENSION(          nedges  , iim,jjm,  nlm,       nsdm) :: &
      mask

   REAL (KIND=dbl_kind),INTENT( IN), optional,                              &
                DIMENSION(          nedges  , iim,jjm,  nlm,       nsdm) :: &
      mss_flux_forced

   REAL (KIND=dbl_kind),INTENT( INOUT),                                     &
                DIMENSION(                iim,jjm,  nlm,ntprog,nsdm) ::     &
      mss              !  mass defined at cell centers
   REAL (KIND=dbl_kind),INTENT( IN),                                        &
                DIMENSION(       ncorners,iim,jjm,  nlm,       nsdm) ::     &
      mss_c            !  mass defined at cell corners
   REAL (KIND=dbl_kind),INTENT( IN),                                        &
                DIMENSION(nspace,ncorners,iim,jjm,  nlm,       nsdm) ::     &
      u                ! horizontal velocity
!.......................................................................
!  INTENT OUT
!.......................................................................
   REAL (KIND=dbl_kind),INTENT(OUT),                                        &
                                DIMENSION(       iim,jjm,  nlm,nsdm) ::     &
      mss_low
   REAL (KIND=dbl_kind),INTENT(OUT),                                        &
                                DIMENSION(nedges,iim,jjm,  nlm,nsdm) ::     &
      mss_flux_horz

!.......................................................................
!  INTENT INOUT
!.......................................................................
   REAL (KIND=dbl_kind),INTENT(OUT),                                         &
                          DIMENSION(nedges,iim,jjm,  nlm,nttend,nsdm) ::     &
      msh_f    !  mass flux across edges

!.......................................................................
!  LOCAL
!.......................................................................
   REAL (KIND=dbl_kind),DIMENSION(nedges,iim,jjm,  nlm,       nsdm) ::      &
      mss_flx1_horz,   &!
      mss_flx2_horz,   &!
      mss_anti_horz     !
   REAL (KIND=dbl_kind),DIMENSION(1,nedges,iim,jjm,  nlm,       nsdm) ::    &
      work_edge
   REAL (KIND=dbl_kind),DIMENSION(       iim,jjm,  nlm,       nsdm) ::      &
      beta_dn
!.:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:.
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  SET THE HORIZONTAL MASS FLUXES
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   CALL set_mass_flux_horizontal (         mss          (    :,:,:,:,:),     &
                                           mss_c        (  :,:,:,:,  :),     &
                                           u            (:,:,:,:,:,  :),     &
                                           msh_f        (  :,:,:,:,:,:),     &
                                           mss_flx1_horz(  :,:,:,:,  :),     &
                                           mss_flx2_horz(  :,:,:,:,  :),     &
                                           mss_anti_horz(  :,:,:,:,  :))
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  ADD IN THE USER SUPPLIED MASS FLUX FORCING IF PRESENT
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   if(present(mss_flux_forced)) mss_flx1_horz = mss_flx1_horz + mss_flux_forced

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  COMPUTE THE LOW ORDER SOLUTION  
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   CALL set_mass_low (                     mss          (    :,:,:,:,:),     &
                                           mss_flx1_horz(  :,:,:,:,  :),     &
                                           mss_low      (    :,:,:,  :))
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  COMPUTE THE SMOLARKIEWICZ BETA_DOWN THING  (PS (16b))
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   CALL set_beta_dn (                      mss_anti_horz(  :,:,:,:,  :),     &
                                           mss_low      (    :,:,:,  :),     &
                                           beta_dn      (    :,:,:,  :))
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  COMPUTE THE CORRECTED ANTI-DIFFUSIVE MASS FLUX (PS (15))
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   CALL set_corrected_mss_anti (           beta_dn      (    :,:,:,  :),     &
                                           mss_anti_horz(  :,:,:,:,  :))
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  COMPUTE FLUX CORRECTED MASS FLUXES
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   if(present(mask)) where(mask > 0.0) mss_anti_horz = 0.0
   mss_flux_horz = mss_flx1_horz + mss_anti_horz
   
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  COMPUTE FLUX CORRECTED MASS SOLUTION (PS (10))
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   CALL set_flux_corrected_mass (          mss_low      (    :,:,:,   :),    &
                                           mss_anti_horz(  :,:,:,:,   :),    &
                                           mss          (    :,:,:,n4,:))

!***********************************************************************

   CONTAINS

!***********************************************************************

!=======================================================================
!  BEGIN set_mass_flux_horizontal
!=======================================================================
   SUBROUTINE set_mass_flux_horizontal (mss,mss_c,u,                         &
                        msh_f,mss_flx1_horz,mss_flx2_horz,mss_anti_horz)
!.......................................................................
!  INTENT IN
!.......................................................................
   REAL (KIND=dbl_kind),INTENT( IN),                                         &
                  DIMENSION(                iim,jjm,nlm,ntprog,nsdm) ::      &
      mss       !  mass defined at cell centers
   REAL (KIND=dbl_kind),INTENT( IN),                                         &
                  DIMENSION(       ncorners,iim,jjm,nlm,       nsdm) ::      &
      mss_c     !  mass defined at cell corners
   REAL (KIND=dbl_kind),INTENT( IN),                                         &
                  DIMENSION(nspace,ncorners,iim,jjm,nlm,       nsdm) ::      &
      u         ! horizontal velocity
!.......................................................................
!  INTENT OUT
!.......................................................................
   REAL (KIND=dbl_kind),INTENT(OUT),                                         &
                           DIMENSION(nedges,iim,jjm,nlm,nttend,nsdm) ::      &
      msh_f             !
   REAL (KIND=dbl_kind),INTENT(OUT),                                         &
                           DIMENSION(nedges,iim,jjm,nlm,       nsdm) ::      &
      mss_flx1_horz,   &!
      mss_flx2_horz,   &!
      mss_anti_horz     !
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) ::                                                &
      i,j,k,nsd,ntime
   REAL (KIND=dbl_kind) ::                                                   &
      wind1,wind2,wind3
   REAL (KIND=dbl_kind),DIMENSION(      nspace,ncorners,iim,jjm) ::          &
      mssflx        !
   REAL (KIND=dbl_kind),DIMENSION(ndata,       ncorners,iim,jjm) ::          &
      flux_temp,   &!
      wind_temp
   REAL (KIND=dbl_kind),PARAMETER ::                                         &
      zero = 0.0_dbl_kind
!.:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:.

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  COMPUTE THE FIRST-ORDER HORIZONTAL MASS FLUXES
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mss_flx1_horz(:,:,:,:,:) = 0.0_dbl_kind
   DO nsd = 1,nsdm
      DO k = 1,nlm
         CALL upstream_mass_flux (npad,iim,jjm,                              &
                                        ndata,ncorners,nedges,nspace,r3,     &
                                     dc           (:,  :,:,:,      nsd),     &
                                     normal       (:,:,:,:,:,      nsd),     &
                                     u            (  :,:,:,:,k,    nsd),     &
                                     mss          (      :,:,k,n3 ,nsd),     &
                                     mss_flx1_horz(    :,:,:,k,    nsd))
      ENDDO
   ENDDO
   work_edge(1,:,:,:,:,:) = mss_flx1_horz(:,:,:,:,:)
   CALL wrap (component_name, edge=work_edge)
   mss_flx1_horz(:,:,:,:,:) = work_edge(1,:,:,:,:,:)

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  COMPUTE THE HIGH-ORDER HORIZONTAL MASS FLUXES TENDENCY
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   msh_f(:,:,:,:,tend_index(1),:) = 0.0_dbl_kind
   DO nsd = 1,nsdm
      DO k = 1,nlm
         CALL centered_mass_flux (npad,iim,jjm,                              &
                                ndata,ncorners,nedges,nspace,r3,             &
                                    dc    (:,  :,:,:,      nsd),             &
                                    normal(:,:,:,:,:,      nsd),             &
                                    mss_c (    :,:,:,k,    nsd),             &
                                    u     (  :,:,:,:,k,    nsd),             &
                                    mss   (      :,:,k,n3 ,nsd),             &
                                    msh_f (    :,:,:,k,tend_index(1),nsd))
      ENDDO
   ENDDO
   work_edge(1,:,:,:,:,:) =  msh_f(:,:,:,:,tend_index(1),:)
   CALL wrap (component_name, edge=work_edge)
   msh_f(:,:,:,:,tend_index(1),:) = work_edge(1,:,:,:,:,:)

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  COMPUTE THE HIGH-ORDER HORIZONTAL MASS FLUXES
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mss_flx2_horz(:,:,:,:,:) = 0.0_dbl_kind
   DO ntime = 1,nttend
      mss_flx2_horz(:,:,:,:,:) = mss_flx2_horz(:,:,:,:,:) +                  &
                  tend_weights(ntime)*msh_f(:,:,:,:,tend_index(ntime),:)
   ENDDO
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  COMPUTE THE ANTI-DIFFUSIVE HORIZONTAL MASS FLUXES (PS (8))
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mss_anti_horz(:,:,:,:,:) =                                                &
                       mss_flx2_horz(:,:,:,:,:)-mss_flx1_horz(:,:,:,:,:)

   END SUBROUTINE set_mass_flux_horizontal
!=======================================================================
!  END  set_mass_flux_horizontal
!=======================================================================

!=======================================================================
!  BEGIN set_mass_low
!=======================================================================
   SUBROUTINE set_mass_low (mss,mss_flx1_horz,mss_low)
!.......................................................................
!  INTENT IN
!.......................................................................
   REAL (KIND=dbl_kind),DIMENSION(       iim,jjm,  nlm,ntprog,nsdm) ::      &
      mss
   REAL (KIND=dbl_kind),DIMENSION(nedges,iim,jjm,  nlm,       nsdm) ::      &
      mss_flx1_horz
!.......................................................................
!  INTENT OUT
!.......................................................................
   REAL (KIND=dbl_kind),DIMENSION(       iim,jjm,  nlm,       nsdm) ::      &
      mss_low
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) ::                                               &
   i,j,k,nsd
!.:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:.

   mss_low(:,:,:,:) = 0.0_dbl_kind

   DO nsd = 1,nsdm
      DO k = 1,nlm
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  NORTH POLE
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         i = 1; j = jjm-1
         mss_low(i,j,k,nsd) = mss(i,j,k,n3 ,nsd) +                           &
                                             dt*area_inv(i,j,nsd)*           &
                                        (mss_flx1_horz(2,i  ,j  ,k,nsd)+     &
                                         mss_flx1_horz(3,i  ,j  ,k,nsd)+     &
                                         mss_flx1_horz(1,i+1,j  ,k,nsd)+     &
                                         mss_flx1_horz(2,i+1,j+1,k,nsd)+     &
                                         mss_flx1_horz(3,i  ,j+1,k,nsd))              
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  SOUTH POLE
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         i = iim-1; j = 1
         mss_low(i,j,k,nsd) = mss(i,j,k,n3 ,nsd) +                           &
                                             dt*area_inv(i,j,nsd)*           &
                                        (mss_flx1_horz(1,i  ,j  ,k,nsd)+     &
                                         mss_flx1_horz(2,i  ,j  ,k,nsd)+     &
                                         mss_flx1_horz(1,i+1,j  ,k,nsd)+     &
                                         mss_flx1_horz(2,i+1,j+1,k,nsd)+     &
                                         mss_flx1_horz(3,i  ,j+1,k,nsd))              
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  INTERIOR CELLS
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         DO j = 2,jjm-1
            DO i = 2,iim-1
               mss_low(i,j,k,nsd) = mss(i,j,k,n3 ,nsd) -                     &
                                             dt*area_inv(i,j,nsd)*           &
                                      ((mss_flx1_horz(1,i,  j  ,k,nsd)+      &
                                        mss_flx1_horz(2,i  ,j  ,k,nsd)+      &
                                        mss_flx1_horz(3,i  ,j  ,k,nsd))-     &
                                       (mss_flx1_horz(1,i+1,j  ,k,nsd)+      &
                                        mss_flx1_horz(2,i+1,j+1,k,nsd)+      &
                                        mss_flx1_horz(3,i  ,j+1,k,nsd)))              
            ENDDO
         ENDDO
      ENDDO
   ENDDO

   END SUBROUTINE set_mass_low
!=======================================================================
!  END set_mass_low 
!=======================================================================

!=======================================================================
!  BEGIN set_beta_dn 
!=======================================================================
   SUBROUTINE set_beta_dn (mss_anti_horz,mss_low,beta_dn)
!.......................................................................
!  INTENT IN
!.......................................................................
   REAL (KIND=dbl_kind),DIMENSION(nedges,iim,jjm,  nlm,nsdm) ::             &
      mss_anti_horz
   REAL (KIND=dbl_kind),DIMENSION(       iim,jjm,  nlm,nsdm) ::             &
      mss_low
!.......................................................................
!  INTENT OUT
!.......................................................................
   REAL (KIND=dbl_kind),DIMENSION(       iim,jjm,  nlm,nsdm) ::             &
      beta_dn
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) ::                                               &
      i,j,k,nsd
   REAL (KIND=dbl_kind) ::                                                  &
      a_out,d_prs_min,mss_min
   REAL (KIND=dbl_kind),PARAMETER ::                                        &
      zero = 0.0_dbl_kind,small_number = 1.0E-18_dbl_kind
!.:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:.
   d_prs_min = 1.0e-6_dbl_kind
   mss_min = 1.0e-6_dbl_kind

   DO nsd = 1,nsdm
      DO k = 1,nlm

!-----------------------------------------------------------------------
!  north pole
!-----------------------------------------------------------------------
         i = 1; j = jjm-1
         a_out = -(MIN (zero,mss_anti_horz(2,i  ,j  ,k  ,nsd))+              &
                   MIN (zero,mss_anti_horz(3,i  ,j  ,k  ,nsd))+              &
                   MIN (zero,mss_anti_horz(1,i+1,j  ,k  ,nsd))+              &
                   MIN (zero,mss_anti_horz(2,i+1,j+1,k  ,nsd))+              &
                   MIN (zero,mss_anti_horz(3,i  ,j+1,k  ,nsd)))
         beta_dn(i,j,k,nsd) =                                                &
                            area(i,j,nsd)*(mss_low(i,j,k,nsd)-mss_min)/      &
                                         (dt*(a_out+small_number))
!-----------------------------------------------------------------------
!  south pole
!-----------------------------------------------------------------------
         i = iim-1; j = 1
         a_out = -(MIN (zero,mss_anti_horz(1,i  ,j  ,k  ,nsd))+              &
                   MIN (zero,mss_anti_horz(2,i  ,j  ,k  ,nsd))+              &
                   MIN (zero,mss_anti_horz(1,i+1,j  ,k  ,nsd))+              &
                   MIN (zero,mss_anti_horz(2,i+1,j+1,k  ,nsd))+              &
                   MIN (zero,mss_anti_horz(3,i  ,j+1,k  ,nsd)))
         beta_dn(i,j,k,nsd) =                                                &
                            area(i,j,nsd)*(mss_low(i,j,k,nsd)-mss_min)/      &
                                         (dt*(a_out+small_number))
!-----------------------------------------------------------------------
!  interior cells
!-----------------------------------------------------------------------
         DO j = 1,jjm-1
            DO i = 1,iim-1
               a_out = (MAX (zero,mss_anti_horz(1,i  ,j  ,k  ,nsd))+         &
                        MAX (zero,mss_anti_horz(2,i  ,j  ,k  ,nsd))+         &
                        MAX (zero,mss_anti_horz(3,i  ,j  ,k  ,nsd)))-        &
                       (MIN (zero,mss_anti_horz(1,i+1,j  ,k  ,nsd))+         &
                        MIN (zero,mss_anti_horz(2,i+1,j+1,k  ,nsd))+         &
                        MIN (zero,mss_anti_horz(3,i  ,j+1,k  ,nsd)))
               beta_dn(i,j,k,nsd) =                                          &
                            area(i,j,nsd)*(mss_low(i,j,k,nsd)-mss_min)/      &
                                         (dt*(a_out+small_number))
            ENDDO
         ENDDO
      ENDDO
   ENDDO

   CALL wrap (component_name, face=beta_dn)

   END SUBROUTINE set_beta_dn
!=======================================================================
!  END set_beta_dn 
!=======================================================================

!=======================================================================
!  BEGIN set_corrected_mss_anti 
!=======================================================================
   SUBROUTINE set_corrected_mss_anti (beta_dn,mss_anti_horz)
!.......................................................................
!  INTENT IN
!.......................................................................
   REAL (KIND=dbl_kind),DIMENSION(       iim,jjm,  nlm,nsdm) ::             &
      beta_dn
!.......................................................................
!  INTENT OUT
!.......................................................................
   REAL (KIND=dbl_kind),DIMENSION(nedges,iim,jjm,  nlm,nsdm) ::             &
      mss_anti_horz
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) ::                                                &
      i,j,k,nsd
   REAL (KIND=dbl_kind),PARAMETER ::                                         &
      zero = 0.0_dbl_kind,one = 1.0_dbl_kind
!.:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:.

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! COMPUTE THE HORIZONTAL CORRECTED MASS FLUX WEIGHTS
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   DO nsd = 1,nsdm
      DO k = 1,nlm
         DO j = 2,jjm-1
            DO i = 2,iim-1
               mss_anti_horz(1,i,j,k,nsd) =                                  &
   MIN (one,beta_dn(i  ,j  ,k,nsd))*MAX (zero,mss_anti_horz(1,i,j,k,nsd))+   &
   MIN (one,beta_dn(i-1,j  ,k,nsd))*MIN (zero,mss_anti_horz(1,i,j,k,nsd))
           mss_anti_horz(2,i,j,k,nsd) =                                      &
   MIN (one,beta_dn(i  ,j  ,k,nsd))*MAX (zero,mss_anti_horz(2,i,j,k,nsd))+   &
   MIN (one,beta_dn(i-1,j-1,k,nsd))*MIN (zero,mss_anti_horz(2,i,j,k,nsd))
           mss_anti_horz(3,i,j,k,nsd) =                                      &
   MIN (one,beta_dn(i  ,j  ,k,nsd))*MAX (zero,mss_anti_horz(3,i,j,k,nsd))+   &
   MIN (one,beta_dn(i  ,j-1,k,nsd))*MIN (zero,mss_anti_horz(3,i,j,k,nsd))
            ENDDO   
         ENDDO
      ENDDO
   ENDDO

   work_edge(1,:,:,:,:,:) = mss_anti_horz(:,:,:,:,:)
   CALL wrap (component_name, edge=work_edge)
   mss_anti_horz(:,:,:,:,:) = work_edge(1,:,:,:,:,:)

   END SUBROUTINE set_corrected_mss_anti
!=======================================================================
!  END set_corrected_mss_anti 
!=======================================================================

!=======================================================================
!  BEGIN set_flux_corrected_mass
!=======================================================================
   SUBROUTINE set_flux_corrected_mass (mss_low,mss_anti_horz,mss_fct)
!.......................................................................
!  INTENT IN
!.......................................................................
   REAL (KIND=dbl_kind),DIMENSION(       iim,jjm,  nlm,nsdm) ::             &
      mss_low
   REAL (KIND=dbl_kind),DIMENSION(nedges,iim,jjm,  nlm,nsdm) ::             &
      mss_anti_horz
!.......................................................................
!  INTENT OUT
!.......................................................................
   REAL (KIND=dbl_kind),INTENT( OUT),                                       &
                        DIMENSION(       iim,jjm,  nlm,nsdm) ::             &
      mss_fct
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) ::                                               &
   i,j,k,nsd
!.:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:.

   mss_fct(:,:,:,:) = 0.0_dbl_kind

   DO nsd = 1,nsdm
      DO k = 1,nlm
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  NORTH POLE
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         i = 1; j = jjm-1
         mss_fct(i,j,k,nsd) = mss_low(i,j,k,nsd) +                           &
                                             dt*area_inv(i,j,nsd)*           &
                                        (mss_anti_horz(2,i  ,j  ,k,nsd)+     &
                                         mss_anti_horz(3,i  ,j  ,k,nsd)+     &
                                         mss_anti_horz(1,i+1,j  ,k,nsd)+     &
                                         mss_anti_horz(2,i+1,j+1,k,nsd)+     &
                                         mss_anti_horz(3,i  ,j+1,k,nsd))              
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  SOUTH POLE
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         i = iim-1; j = 1
         mss_fct(i,j,k,nsd) = mss_low(i,j,k,nsd) +                           &
                                             dt*area_inv(i,j,nsd)*           &
                                        (mss_anti_horz(1,i  ,j  ,k,nsd)+     &
                                         mss_anti_horz(2,i  ,j  ,k,nsd)+     &
                                         mss_anti_horz(1,i+1,j  ,k,nsd)+     &
                                         mss_anti_horz(2,i+1,j+1,k,nsd)+     &
                                         mss_anti_horz(3,i  ,j+1,k,nsd))              
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  INTERIOR CELLS
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         DO j = 2,jjm-1
            DO i = 2,iim-1
               mss_fct(i,j,k,nsd) = mss_low(i,j,k,nsd) -                     &
                                             dt*area_inv(i,j,nsd)*           &
                                      ((mss_anti_horz(1,i,  j  ,k,nsd)+      &
                                        mss_anti_horz(2,i  ,j  ,k,nsd)+      &
                                        mss_anti_horz(3,i  ,j  ,k,nsd))-     &
                                       (mss_anti_horz(1,i+1,j  ,k,nsd)+      &
                                        mss_anti_horz(2,i+1,j+1,k,nsd)+      &
                                        mss_anti_horz(3,i  ,j+1,k,nsd)))                
            ENDDO
         ENDDO
      ENDDO
   ENDDO

   END SUBROUTINE set_flux_corrected_mass
!=======================================================================
!  END set_flux_corrected_mass 
!=======================================================================

   END SUBROUTINE set_mass_fct
!=======================================================================
!  END set_mass_fct
!=======================================================================


   END MODULE mass_fct
!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
