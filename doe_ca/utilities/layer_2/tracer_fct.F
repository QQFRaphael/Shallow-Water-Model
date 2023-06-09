   MODULE tracer_fct
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  PURPOSE:  Advection of mass and tracers using flux-corrected transport.
!            See Piotr Smolarkiewicz (hereafter (PS)) "Nonoscillatory 
!            Advection Schemes"  ECMF seminar proceedings. 9-13 Sept. 1991.
!            Numerical methods in atmospheric models.  Vol 1.
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   USE kinds
   USE wrap_data

   IMPLICIT NONE
   PRIVATE
   SAVE

   PUBLIC :: set_tracer_fct

   CONTAINS

!=======================================================================
!  BEGIN set_tracer_fct
!=======================================================================
   SUBROUTINE set_tracer_fct (                                         &
                            component_name,                            &
                            iim, jjm, nlm, nsdm,nedges,                &
                            dt, area_inv, area,                        &
                            trc,trc_high,                              &
                            mss, mss_low, mss_horz,                    &
                            mss_flux_horz,                             &
                            trc_fct, trc_flux_horz,                    &
                            msstrc_low_order, mask)

!.......................................................................
!  INTENT IN
!.......................................................................
   CHARACTER (LEN=*), INTENT(IN) :: component_name

   INTEGER (KIND=int_kind), INTENT( IN) :: iim,jjm,nlm,       &
                                           nsdm,nedges

   REAL (KIND=dbl_kind),INTENT( IN) :: dt

   REAL (KIND=dbl_kind),INTENT( IN),                                        &
                DIMENSION(                iim,jjm,             nsdm) ::     &
      area_inv, area

   REAL (KIND=dbl_kind),INTENT( IN   ),                                     &
                DIMENSION(                iim,jjm,  nlm,       nsdm) ::     &
      trc,            &!  tracer defined at time level n
      trc_high,       &!  AB3 weighted tracer field
      mss,            &!  mass defined at time level n
      mss_low,        &!  mass defined at time level n+1 via upwind
      mss_horz         !  mass defined at time level n+1 via fct

   REAL (KIND=dbl_kind),INTENT(IN),                                         &
                                DIMENSION(nedges,iim,jjm,  nlm,nsdm) ::     &
      mss_flux_horz

   REAL (KIND=dbl_kind),INTENT( IN), optional,                              &
                DIMENSION(          nedges  , iim,jjm,  nlm,       nsdm) :: &
      mask

   REAL (KIND=dbl_kind),INTENT(OUT), optional,                              &
                DIMENSION(          nedges  , iim,jjm,  nlm,       nsdm) :: &
      trc_flux_horz

   REAL (KIND=dbl_kind),INTENT(OUT), optional,                              &
                DIMENSION(                    iim,jjm,  nlm,       nsdm) :: &
      msstrc_low_order


!.......................................................................
!  INTENT OUT
!.......................................................................
   REAL (KIND=dbl_kind),INTENT(OUT),                                         &
                                DIMENSION(       iim,jjm,nlm,nsdm) ::        &
      trc_fct

!.......................................................................
!  LOCAL
!.......................................................................
   REAL (KIND=dbl_kind) :: thing
   REAL (KIND=dbl_kind),DIMENSION(1,nedges,iim,jjm,  nlm,       nsdm) ::    &
      work_edge
   REAL (KIND=dbl_kind),DIMENSION(nedges,iim,jjm,nlm,nsdm) ::             &
      trc_flx1_horz,   &!
      trc_flx2_horz,   &!
      trc_anti_horz     !
   REAL (KIND=dbl_kind),DIMENSION(       iim,jjm,nlm,nsdm) ::             &
      msstrc_low,      &!
      msstrc_fct,      &!
      trc_min,         &!
      trc_max
   REAL (KIND=dbl_kind),DIMENSION(       iim,jjm,nlm,nsdm) ::             &
      beta_dn,         &!
      beta_up
!.:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:.   
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  SET THE HORIZONTAL TRACER FLUXES
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   CALL set_tracer_flux_horizontal (         trc          (  :,:,:,  :),     &
                                             trc_high     (  :,:,:,  :),     &
                                             mss_flux_horz(:,:,:,:,  :),     &
                                             trc_flx1_horz(:,:,:,:,  :),     &
                                             trc_flx2_horz(:,:,:,:,  :),     &
                                             trc_anti_horz(:,:,:,:,  :))
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  COMPUTE THE LOW ORDER SOLUTION
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   CALL set_msstrc_low (                     mss          (  :,:,:,  :),     &
                                             trc          (  :,:,:,  :),     &
                                             trc_flx1_horz(:,:,:,:,  :),     &
                                             msstrc_low   (  :,:,:,  :))
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  SET LIMITER.  FIND LOCAL EXTREMA trc_min AND trc_max (PS (17ab))
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   CALL set_limiter (                        trc          (  :,:,:,  :),     &
                                             msstrc_low   (  :,:,:,  :),     &
                                             mss_horz     (  :,:,:,  :),     &
                                             trc_min      (  :,:,:,  :),     &
                                             trc_max      (  :,:,:,  :))
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  SET BETA WEIGHTS -- beta_dn AND beta_up (PS (16ab))
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   CALL set_beta_weights_trc (               trc_anti_horz(:,:,:,:,  :),     &
                                             msstrc_low   (  :,:,:,  :),     &
                                             mss_low      (  :,:,:,  :),     &
                                             trc_min      (  :,:,:,  :),     &
                                             trc_max      (  :,:,:,  :),     &
                                             beta_dn      (  :,:,:,  :),     &
                                             beta_up      (  :,:,:,  :))
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  COMPUTE THE CORRECTED ANTI-DIFFUSIVE TRACER FLUX (PS (15))
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   CALL set_corrected_trc_anti (             beta_dn      (  :,:,:,  :),     &
                                             beta_up      (  :,:,:,  :),     &
                                             trc_anti_horz(:,:,:,:,  :))
  
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  COMPUTE FLUX CORRECTED TRACER FLUXES
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   if(present(mask)) where(mask > 0.0) trc_anti_horz = 0.0
   if(present(trc_flux_horz)) trc_flux_horz = trc_flx1_horz + trc_anti_horz
   if(present(msstrc_low_order)) msstrc_low_order=msstrc_low

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  COMPUTE FLUX CORRECTED MASS SOLUTION
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   CALL set_msstrc_fct (                     msstrc_low   (  :,:,:,  :),     &
                                             trc_anti_horz(:,:,:,:,  :),     &
                                             msstrc_fct   (  :,:,:,  :))

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! PUT TRACER BACK INTO UNITS of TRACER per UNIT MASS (kg/kg)
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   WHERE (mss_horz     (:,:,:,:) /= 0.0_dbl_kind)
      trc_fct(:,:,:,:) = msstrc_fct(:,:,:,:)/mss_horz     (:,:,:,:)
   ELSEWHERE
      trc_fct(:,:,:,:) = 0.0_dbl_kind
   END WHERE

   CONTAINS

!=======================================================================
!  BEGIN  set_tracer_flux_horizontal
!=======================================================================
   SUBROUTINE set_tracer_flux_horizontal (trc,trc_high,mss_flux_horz,        &
                              trc_flx1_horz,trc_flx2_horz,trc_anti_horz)
!.......................................................................
!  INTENT IN
!.......................................................................
   REAL (KIND=dbl_kind),DIMENSION(       iim,jjm,nlm,nsdm) ::             &
      trc,             &!
      trc_high
   REAL (KIND=dbl_kind),DIMENSION(nedges,iim,jjm,nlm,nsdm) ::             &
      mss_flux_horz     ! 
!.......................................................................
!  INTENT OUT
!.......................................................................
   REAL (KIND=dbl_kind),DIMENSION(nedges,iim,jjm,nlm,nsdm) ::             &
      trc_flx1_horz,   &!
      trc_flx2_horz,   &!
      trc_anti_horz     !
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) ::                                                &
      i,j,k,nsd
   REAL (KIND=dbl_kind),PARAMETER ::                                         &
      zero = 0.0_dbl_kind,half = 0.5_dbl_kind
!.:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:.
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  COMPUTE THE FIRST-ORDER HORIZONTAL TRACER FLUXES
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   trc_flx1_horz(:,:,:,:,:) = 0.0_dbl_kind
   DO nsd = 1,nsdm
      DO k = 1,nlm
         DO j = 2,jjm-1
            DO i = 2,iim-1
               trc_flx1_horz(1,i,j,k,nsd) =                                  &
                trc(i  ,j  ,k,nsd)*MAX (zero,mss_flux_horz(1,i,j,k,nsd))+    &
                trc(i-1,j  ,k,nsd)*MIN (zero,mss_flux_horz(1,i,j,k,nsd))
               trc_flx1_horz(2,i,j,k,nsd) =                                  &
                trc(i  ,j  ,k,nsd)*MAX (zero,mss_flux_horz(2,i,j,k,nsd))+    &
                trc(i-1,j-1,k,nsd)*MIN (zero,mss_flux_horz(2,i,j,k,nsd))
               trc_flx1_horz(3,i,j,k,nsd) =                                  &
                trc(i  ,j  ,k,nsd)*MAX (zero,mss_flux_horz(3,i,j,k,nsd))+    &
                trc(i  ,j-1,k,nsd)*MIN (zero,mss_flux_horz(3,i,j,k,nsd))
            ENDDO
         ENDDO
      ENDDO
   ENDDO
   work_edge(1,:,:,:,:,:) = trc_flx1_horz(:,:,:,:,:)
   CALL wrap (component_name,edge=work_edge)
   trc_flx1_horz(:,:,:,:,:) = work_edge(1,:,:,:,:,:)
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  COMPUTE THE HIGHER-ORDER HORIZONTAL TRACER FLUXES
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   trc_flx2_horz(:,:,:,:,:) = 0.0_dbl_kind
   DO nsd = 1,nsdm
      DO k = 1,nlm
         DO j = 2,jjm-1
            DO i = 2,iim-1
               trc_flx2_horz(1,i,j,k,nsd) =                                  &
                     half*(trc_high(i,j,k,nsd)+trc_high(i-1,j  ,k,nsd))*     &
                                               mss_flux_horz(1,i,j,k,nsd)
               trc_flx2_horz(2,i,j,k,nsd) =                                  &
                     half*(trc_high(i,j,k,nsd)+trc_high(i-1,j-1,k,nsd))*     &
                                               mss_flux_horz(2,i,j,k,nsd)
               trc_flx2_horz(3,i,j,k,nsd) =                                  &
                     half*(trc_high(i,j,k,nsd)+trc_high(i  ,j-1,k,nsd))*     &
                                               mss_flux_horz(3,i,j,k,nsd)
            ENDDO
         ENDDO
      ENDDO
   ENDDO
    work_edge(1,:,:,:,:,:) = trc_flx2_horz(:,:,:,:,:)
   CALL wrap (component_name,edge=work_edge)
   trc_flx2_horz(:,:,:,:,:) = work_edge(1,:,:,:,:,:)

   trc_anti_horz(:,:,:,:,:) =                                                &
                       trc_flx2_horz(:,:,:,:,:)-trc_flx1_horz(:,:,:,:,:)

   END SUBROUTINE set_tracer_flux_horizontal
!=======================================================================
!  END  set_tracer_flux_horizontal
!=======================================================================

!=======================================================================
!  BEGIN set_msstrc_low
!=======================================================================
   SUBROUTINE set_msstrc_low (mss     ,trc,trc_flx1_horz,msstrc_low)
!.......................................................................
!  INTENT IN
!.......................................................................
   REAL (KIND=dbl_kind),INTENT( IN),                                         &
                                DIMENSION(       iim,jjm,nlm,nsdm) ::     &
      mss         !  mass defined at layer edges
   REAL (KIND=dbl_kind),INTENT( IN),                                         &
                                DIMENSION(       iim,jjm,nlm,nsdm) ::     &
      trc
   REAL (KIND=dbl_kind),INTENT( IN),                                         &
                                DIMENSION(nedges,iim,jjm,nlm,nsdm) ::     &
      trc_flx1_horz
!.......................................................................
!  INTENT OUT
!.......................................................................
   REAL (KIND=dbl_kind),INTENT(OUT),                                         &
                                DIMENSION(       iim,jjm,nlm,nsdm) ::     &
      msstrc_low
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) ::                                                &
      i,j,k,nsd
!.:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:.

   msstrc_low(:,:,:,:) = 0.0_dbl_kind

   DO nsd = 1,nsdm
      DO k = 1,nlm
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  NORTH POLE
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         i = 1; j = jjm-1
         msstrc_low(i,j,k,nsd) = mss     (i,j,k,nsd)*trc(i,j,k,nsd) +        &
                                             dt      *area_inv(i,j,nsd)*     &
                                        (trc_flx1_horz(2,i  ,j  ,k,nsd)+     &
                                         trc_flx1_horz(3,i  ,j  ,k,nsd)+     &
                                         trc_flx1_horz(1,i+1,j  ,k,nsd)+     &
                                         trc_flx1_horz(2,i+1,j+1,k,nsd)+     &
                                         trc_flx1_horz(3,i  ,j+1,k,nsd))              
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  SOUTH POLE
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         i = iim-1; j = 1
         msstrc_low(i,j,k,nsd) = mss     (i,j,k,nsd)*trc(i,j,k,nsd) +        &
                                             dt      *area_inv(i,j,nsd)*     &
                                        (trc_flx1_horz(1,i  ,j  ,k,nsd)+     &
                                         trc_flx1_horz(2,i  ,j  ,k,nsd)+     &
                                         trc_flx1_horz(1,i+1,j  ,k,nsd)+     &
                                         trc_flx1_horz(2,i+1,j+1,k,nsd)+     &
                                         trc_flx1_horz(3,i  ,j+1,k,nsd))              
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  INTERIOR CELLS
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         DO j = 2,jjm-1
            DO i = 2,iim-1 
               msstrc_low(i,j,k,nsd) = mss     (i,j,k,nsd)*trc(i,j,k,nsd)-   &
                                             dt      *area_inv(i,j,nsd)*     &
                                      ((trc_flx1_horz(1,i,  j  ,k,nsd)+      &
                                        trc_flx1_horz(2,i  ,j  ,k,nsd)+      &
                                        trc_flx1_horz(3,i  ,j  ,k,nsd))-     &
                                       (trc_flx1_horz(1,i+1,j  ,k,nsd)+      &
                                        trc_flx1_horz(2,i+1,j+1,k,nsd)+      &
                                        trc_flx1_horz(3,i  ,j+1,k,nsd)))              
            ENDDO
         ENDDO
      ENDDO
   ENDDO

   END SUBROUTINE set_msstrc_low
!=======================================================================
!  END set_msstrc_low 
!=======================================================================

!=======================================================================
!  BEGIN set_limiter 
!=======================================================================
   SUBROUTINE set_limiter (trc,msstrc_low,mss_low     ,trc_min,trc_max)
!.......................................................................
!  INTENT IN
!.......................................................................
   REAL (KIND=dbl_kind),INTENT( IN),DIMENSION(iim,jjm,nlm,nsdm) ::        &
      trc,         &!
      msstrc_low,  &!
      mss_low       !
!.......................................................................
!  INTENT OUT
!.......................................................................
   REAL (KIND=dbl_kind),INTENT(OUT),DIMENSION(iim,jjm,nlm,nsdm) ::        &
      trc_min,     &!
      trc_max       !
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) ::                                                &
      i,j,k,nsd,p,q
   REAL (KIND=dbl_kind),DIMENSION(iim,jjm,nlm) ::                         &
      trc_low
   REAL (KIND=dbl_kind) ::                                                   &
      temp12(12),temp14(14)
!.:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:.
   p = iim-1; q = jjm-1
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  FIND THE STANDARD LIMITER (see Smolarkiewicz,  (17ab))
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   CALL wrap (component_name,face =    trc         )
   CALL wrap (component_name,face =    mss_low     )
   CALL wrap (component_name,face = msstrc_low     )

   trc_min(:,:,:,:) = 0.0_dbl_kind; trc_max(:,:,:,:) = 0.0_dbl_kind
!-----------------------------------------------------------------------
!  find local minimum and maximum in the horizontal direction
!-----------------------------------------------------------------------
   DO nsd = 1,nsdm

      where(mss_low(:,:,:,nsd) > 0.0_dbl_kind)
        trc_low(:,:,:) = msstrc_low(:,:,:,nsd)/mss_low     (:,:,:,nsd)
      elsewhere
        trc_low(:,:,:) = 0.0_dbl_kind
      endwhere

      DO k = 1,nlm
!  north pole
         temp12(:) = (/ trc(1,q,k,nsd),trc_low(1,q,k    ),                   &
                            trc    (p,  1,k,nsd),trc    (1,q-1,k,nsd),       &
         trc    (2,q,k,nsd),trc    (2,q+1,k,nsd),trc    (1,q+1,k,nsd),       &
                            trc_low(p,  1,k    ),trc_low(1,q-1,k    ),       &
         trc_low(2,q,k    ),trc_low(2,q+1,k    ),trc_low(1,q+1,k    ) /) 

         trc_min(1,q,k,nsd) = MINVAL (temp12)
         trc_max(1,q,k,nsd) = MAXVAL (temp12)

!  south pole
         temp12(:) = (/ trc(p,1,k,nsd),trc_low(p,1,k    ),                   &
           trc    (p-1,1,k,nsd),trc    (  1,q,k,nsd),                        &
           trc    (p+1,1,k,nsd),trc    (p+1,2,k,nsd),trc    (p,2,k,nsd),     &
           trc_low(p-1,1,k    ),trc_low(  1,q,k    ),                        &
           trc_low(p+1,1,k    ),trc_low(p+1,2,k    ),trc_low(p,2,k    ) /)

         trc_min(p,1,k,nsd) = MINVAL (temp12)
         trc_max(p,1,k,nsd) = MAXVAL (temp12)

!  interior cells
         DO j = 2,jjm-1
            DO i = 2,iim-1

               temp14(:) = (/ trc(i,j,k,nsd),trc_low(i,j,k    ),             &
       trc    (i-1,j,k,nsd),trc    (i-1,j-1,k,nsd),trc    (i,j-1,k,nsd),     &
       trc    (i+1,j,k,nsd),trc    (i+1,j+1,k,nsd),trc    (i,j+1,k,nsd),     &
       trc_low(i-1,j,k    ),trc_low(i-1,j-1,k    ),trc_low(i,j-1,k    ),     &
       trc_low(i+1,j,k    ),trc_low(i+1,j+1,k    ),trc_low(i,j+1,k    ) /)

               trc_min(i,j,k,nsd) = MINVAL  (temp14)
               trc_max(i,j,k,nsd) = MAXVAL  (temp14)

            ENDDO
         ENDDO
      ENDDO
   ENDDO

   END SUBROUTINE set_limiter
!=======================================================================
!  END set_limiter 
!=======================================================================

!=======================================================================
!  BEGIN set_beta_weights_trc 
!=======================================================================
   SUBROUTINE set_beta_weights_trc (trc_anti_horz,msstrc_low,mss_low     ,   &
                                        trc_min,trc_max,beta_dn,beta_up)
!.......................................................................
!  INTENT IN
!.......................................................................
   REAL (KIND=dbl_kind),DIMENSION(nedges,iim,jjm,nlm,nsdm) ::             &
      trc_anti_horz
   REAL (KIND=dbl_kind),DIMENSION(       iim,jjm,nlm,nsdm) ::             &
      msstrc_low,  &!
      mss_low       !
   REAL (KIND=dbl_kind),DIMENSION(       iim,jjm,nlm,nsdm) ::             &
      trc_min,     &!
      trc_max
!.......................................................................
!  INTENT OUT
!.......................................................................
   REAL (KIND=dbl_kind),DIMENSION(       iim,jjm,nlm,nsdm) ::             &
      beta_dn,     &!
      beta_up
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) ::                                                &
      i,j,k,nsd
   REAL (KIND=dbl_kind) ::                                                   &
      a_out,a_in
   REAL (KIND=dbl_kind),PARAMETER ::                                         &
      zero = 0.0_dbl_kind,small_number = 1.0E-18_dbl_kind
!.:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:.
   DO nsd = 1,nsdm
      DO k = 1,nlm
!-----------------------------------------------------------------------
!  north pole
!-----------------------------------------------------------------------
         i = 1; j = jjm-1
         a_out = -(MIN (zero,trc_anti_horz(2,i  ,j  ,k  ,nsd))+              &
                   MIN (zero,trc_anti_horz(3,i  ,j  ,k  ,nsd))+              &
                   MIN (zero,trc_anti_horz(1,i+1,j  ,k  ,nsd))+              &
                   MIN (zero,trc_anti_horz(2,i+1,j+1,k  ,nsd))+              &
                   MIN (zero,trc_anti_horz(3,i  ,j+1,k  ,nsd)))

         a_in  =  (MAX (zero,trc_anti_horz(2,i  ,j  ,k  ,nsd))+              &
                   MAX (zero,trc_anti_horz(3,i  ,j  ,k  ,nsd))+              &
                   MAX (zero,trc_anti_horz(1,i+1,j  ,k  ,nsd))+              &
                   MAX (zero,trc_anti_horz(2,i+1,j+1,k  ,nsd))+              &
                   MAX (zero,trc_anti_horz(3,i  ,j+1,k  ,nsd)))

         beta_dn(i,j,k,nsd) = (area(i,j,nsd)/dt      )*                      &
     (msstrc_low(i,j,k,nsd)-mss_low     (i,j,k,nsd)*trc_min(i,j,k,nsd))/     &
                                                    (a_out+small_number)

         beta_up(i,j,k,nsd) = (area(i,j,nsd)/dt      )*                      &
     (mss_low     (i,j,k,nsd)*trc_max(i,j,k,nsd)-msstrc_low(i,j,k,nsd))/     &
                                                    (a_in +small_number)
!-----------------------------------------------------------------------
!  south pole
!-----------------------------------------------------------------------
         i = iim-1; j = 1
         a_out = -(MIN (zero,trc_anti_horz(1,i  ,j  ,k  ,nsd))+              &
                   MIN (zero,trc_anti_horz(2,i  ,j  ,k  ,nsd))+              &
                   MIN (zero,trc_anti_horz(1,i+1,j  ,k  ,nsd))+              &
                   MIN (zero,trc_anti_horz(2,i+1,j+1,k  ,nsd))+              &
                   MIN (zero,trc_anti_horz(3,i  ,j+1,k  ,nsd)))

         a_in  =  (MAX (zero,trc_anti_horz(1,i  ,j  ,k  ,nsd))+              &
                   MAX (zero,trc_anti_horz(2,i  ,j  ,k  ,nsd))+              &
                   MAX (zero,trc_anti_horz(1,i+1,j  ,k  ,nsd))+              &
                   MAX (zero,trc_anti_horz(2,i+1,j+1,k  ,nsd))+              &
                   MAX (zero,trc_anti_horz(3,i  ,j+1,k  ,nsd)))

         beta_dn(i,j,k,nsd) = (area(i,j,nsd)/dt      )*                      &
     (msstrc_low(i,j,k,nsd)-mss_low     (i,j,k,nsd)*trc_min(i,j,k,nsd))/     &
                                                    (a_out+small_number)

         beta_up(i,j,k,nsd) = (area(i,j,nsd)/dt      )*                      &
     (mss_low     (i,j,k,nsd)*trc_max(i,j,k,nsd)-msstrc_low(i,j,k,nsd))/     &
                                                    (a_in +small_number)
!-----------------------------------------------------------------------
!  interior cells
!-----------------------------------------------------------------------
         DO j = 2,jjm-1
            DO i = 2,iim-1
               a_out =  ((MAX (zero,trc_anti_horz(1,i  ,j  ,k  ,nsd))+       &
                          MAX (zero,trc_anti_horz(2,i  ,j  ,k  ,nsd))+       &
                          MAX (zero,trc_anti_horz(3,i  ,j  ,k  ,nsd)))-      &
                         (MIN (zero,trc_anti_horz(1,i+1,j  ,k  ,nsd))+       &
                          MIN (zero,trc_anti_horz(2,i+1,j+1,k  ,nsd))+       &
                          MIN (zero,trc_anti_horz(3,i  ,j+1,k  ,nsd))))
               a_in  = -((MIN (zero,trc_anti_horz(1,i  ,j  ,k  ,nsd))+       &
                          MIN (zero,trc_anti_horz(2,i  ,j  ,k  ,nsd))+       &
                          MIN (zero,trc_anti_horz(3,i  ,j  ,k  ,nsd)))-      &
                         (MAX (zero,trc_anti_horz(1,i+1,j  ,k  ,nsd))+       &
                          MAX (zero,trc_anti_horz(2,i+1,j+1,k  ,nsd))+       &
                          MAX (zero,trc_anti_horz(3,i  ,j+1,k  ,nsd))))

               beta_dn(i,j,k,nsd) = (area(i,j,nsd)/dt      )*                &
     (msstrc_low(i,j,k,nsd)-mss_low     (i,j,k,nsd)*trc_min(i,j,k,nsd))/     &
                                                    (a_out+small_number)

               beta_up(i,j,k,nsd) = (area(i,j,nsd)/dt      )*                &
     (mss_low     (i,j,k,nsd)*trc_max(i,j,k,nsd)-msstrc_low(i,j,k,nsd))/     &
                                                    (a_in +small_number)

            ENDDO
         ENDDO
      ENDDO
   ENDDO

   CALL wrap (component_name, face=beta_dn)
   CALL wrap (component_name, face=beta_up)

   END SUBROUTINE set_beta_weights_trc
!=======================================================================
!  END  set_beta_weights_trc 
!=======================================================================

!=======================================================================
!  BEGIN set_corrected_trc_anti 
!=======================================================================
   SUBROUTINE set_corrected_trc_anti (beta_dn,beta_up,trc_anti_horz)
!.......................................................................
!  INTENT IN
!.......................................................................
   REAL (KIND=dbl_kind),DIMENSION(       iim,jjm,nlm,nsdm) ::             &
      beta_dn,  &!
      beta_up
!.......................................................................
!  INTENT OUT
!.......................................................................
   REAL (KIND=dbl_kind),DIMENSION(nedges,iim,jjm,nlm,nsdm) ::             &
      trc_anti_horz
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) ::                                                &
      i,j,k,nsd
   REAL (KIND=dbl_kind),PARAMETER ::                                         &
      zero = 0.0_dbl_kind,one = 1.0_dbl_kind
!.:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:.
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! COMPUTE THE HORIZONTAL CORRECTED ANTI-DIFFUSIVE TRACER  
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   DO nsd = 1,nsdm
      DO k = 1,nlm
         DO j = 2,jjm-1
            DO i = 2,iim-1

               trc_anti_horz(1,i,j,k,nsd) =                                  &
                   MIN (one,beta_dn(i,j,k,nsd),beta_up(i-1,j  ,k,nsd))*      &
                                  MAX (zero,trc_anti_horz(1,i,j,k,nsd))+     &
                   MIN (one,beta_up(i,j,k,nsd),beta_dn(i-1,j  ,k,nsd))*      &
                                  MIN (zero,trc_anti_horz(1,i,j,k,nsd))

               trc_anti_horz(2,i,j,k,nsd) =                                  &
                   MIN (one,beta_dn(i,j,k,nsd),beta_up(i-1,j-1,k,nsd))*      &
                                  MAX (zero,trc_anti_horz(2,i,j,k,nsd))+     &
                   MIN (one,beta_up(i,j,k,nsd),beta_dn(i-1,j-1,k,nsd))*      &
                                  MIN (zero,trc_anti_horz(2,i,j,k,nsd))

               trc_anti_horz(3,i,j,k,nsd) =                                  &
                   MIN (one,beta_dn(i,j,k,nsd),beta_up(i  ,j-1,k,nsd))*      &
                                  MAX (zero,trc_anti_horz(3,i,j,k,nsd))+     &
                   MIN (one,beta_up(i,j,k,nsd),beta_dn(i  ,j-1,k,nsd))*      &
                                  MIN (zero,trc_anti_horz(3,i,j,k,nsd))
            ENDDO   
         ENDDO
      ENDDO
   ENDDO

   work_edge(1,:,:,:,:,:) = trc_anti_horz(:,:,:,:,:)
   CALL wrap (component_name, edge=work_edge)
   trc_anti_horz(:,:,:,:,:) = work_edge(1,:,:,:,:,:)

   END SUBROUTINE set_corrected_trc_anti
!=======================================================================
!  END set_corrected_trc_anti 
!=======================================================================

!=======================================================================
!  BEGIN set_msstrc_fct
!=======================================================================
   SUBROUTINE set_msstrc_fct (msstrc_low,trc_anti_horz,msstrc_fct)
!.......................................................................
!  INTENT IN
!.......................................................................
   REAL (KIND=dbl_kind),DIMENSION(       iim,jjm,nlm,       nsdm) ::      &
      msstrc_low
   REAL (KIND=dbl_kind),DIMENSION(nedges,iim,jjm,nlm,       nsdm) ::      &
      trc_anti_horz
!.......................................................................
!  INTENT OUT
!.......................................................................
   REAL (KIND=dbl_kind),DIMENSION(       iim,jjm,nlm,       nsdm) ::      &
      msstrc_fct
!.......................................................................
!  LOCAL
!.......................................................................
   INTEGER (KIND=int_kind) ::                                                &
   i,j,k,nsd
!.:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:. .:.

   msstrc_fct(:,:,:,:) = 0.0_dbl_kind

   DO nsd = 1,nsdm
      DO k = 1,nlm
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  NORTH POLE
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         i = 1; j = jjm-1
         msstrc_fct(i,j,k,nsd) =  msstrc_low(i,j,k,nsd) +                    &
                                             dt      *area_inv(i,j,nsd)*     &
                                      (trc_anti_horz(2,i  ,j  ,k  ,nsd)+     &
                                       trc_anti_horz(3,i  ,j  ,k  ,nsd)+     &
                                       trc_anti_horz(1,i+1,j  ,k  ,nsd)+     &
                                       trc_anti_horz(2,i+1,j+1,k  ,nsd)+     &
                                       trc_anti_horz(3,i  ,j+1,k  ,nsd))              
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  SOUTH POLE
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         i = iim-1; j = 1
         msstrc_fct(i,j,k,nsd) =  msstrc_low(i,j,k,nsd) +                    &
                                             dt      *area_inv(i,j,nsd)*     &
                                      (trc_anti_horz(1,i  ,j  ,k  ,nsd)+     &
                                       trc_anti_horz(2,i  ,j  ,k  ,nsd)+     &
                                       trc_anti_horz(1,i+1,j  ,k  ,nsd)+     &
                                       trc_anti_horz(2,i+1,j+1,k  ,nsd)+     &
                                       trc_anti_horz(3,i  ,j+1,k  ,nsd))              
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  INTERIOR CELLS
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         DO j = 2,jjm-1
            DO i = 2,iim-1
               msstrc_fct(i,j,k,nsd) = msstrc_low(i,j,k,nsd) -               &
                                             dt      *area_inv(i,j,nsd)*     &
                                    ((trc_anti_horz(1,i,  j  ,k  ,nsd)+      &
                                      trc_anti_horz(2,i  ,j  ,k  ,nsd)+      &
                                      trc_anti_horz(3,i  ,j  ,k  ,nsd))-     &
                                     (trc_anti_horz(1,i+1,j  ,k  ,nsd)+      &
                                      trc_anti_horz(2,i+1,j+1,k  ,nsd)+      &
                                      trc_anti_horz(3,i  ,j+1,k  ,nsd)))              
            ENDDO
         ENDDO
      ENDDO
   ENDDO

   END SUBROUTINE set_msstrc_fct
!=======================================================================
!  END set_msstrc_fct 
!=======================================================================

   END SUBROUTINE set_tracer_fct
!=======================================================================
!  END  set_tracer_fct
!=======================================================================

   END MODULE tracer_fct
!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
