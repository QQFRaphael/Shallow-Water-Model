      module coszen_module

      use kinds
  
      implicit none
      private

      public :: coszen

      contains

      subroutine coszen( nagrid, lamod, ndiurn, cosd, sind,       &
                 tofday, pi, lat, lon, cosz, sfac, c3day)

!     this subroutine calculates the cosine of the solar zenith angle (cosz)

      integer (kind=int_kind) ::                    &
             nagrid,    &! number of unique atmospheric gridpoints
             c3day
      REAL (kind=dbl_kind) ::                       &
           cosz(nagrid), sfac(nagrid), lat(nagrid), pi, &
           lon(nagrid), cosd, sind, tofday, temday
! tofday is between 0 and 1
      logical (kind=log_kind) :: ndiurn, lamod

!     local veriables
      REAL (kind=dbl_kind) :: temp(nagrid), czcon, coszm, tss, tsr, pi2
      integer (kind=int_kind) :: i, m, nday
      
      pi2 = 2. * pi

      if(.not.ndiurn) then
         DO I=1,nagrid
            TEMP(I) = (TOFDAY * PI2) + (lon(i)+pi)
            temp(i) = cos(temp(i))
            CZCON      = SIN(lat(i))*SIND                                         
            COSZ(I)  = COSD*temp(i)
            COSZ(I) = CZCON + COS(lat(i))*COSZ(I)                             
            sfac(i) = 1.0
         enddo
      else
!                                                                       
!     NO DIURNAL CYCLE                                                 
!                                                                     
         if(lamod) then
            CZCON      = SIN(lat(1))*SIND                                         
            coszm = -czcon/(cosd*cos(lat(1)))
            if(coszm.ge.1.0 ) then
               sfac(1) = 0.0
            else
               if(coszm.le.-1.0) then
                  tsr = 0.0
                  tss = 1.0
               else
                  tsr = acos(coszm)*.5/pi - .5
                  if(tsr.lt.0.0) tsr = tsr + 1.0
                  if(tsr.gt.0.5) tsr = 1.0 - tsr
                  tss = 1.0 - tsr
               end if
               sfac(1) = tss-tsr
               coszm=czcon+cosd*cos(lat(1))*sin(2.*pi*(tss+.5))    &
                            /(pi*sfac(1)*pi/180.)
               cosz(1) = coszm
            end if
            do i = 2,nagrid
               sfac(i) = sfac(1)
               cosz(i) = cosz(1)
            enddo
         else
            do i = 1,nagrid
               coszm = 0.0
               nday = 0
               do m = 1,c3day
                  temday = tofday + float(m) / float(c3day)
                  TEMP(I) = (temDAY  * PI2) + (lon(i)+pi)
                  temp(i) = cos(temp(i))
                  CZCON      = SIN(lat(i))*SIND                                         
                  COSZ(I)  = COSD*temp(i)
                  COSZ(I) = CZCON + COS(lat(i))*COSZ(I)
                  IF(COSZ(I).GE.0.01) THEN                                
                     NDAY = NDAY+1                                              
                     COSZM = COSZM+COSZ(I)                                   
                  END IF                                                   
               enddo
               IF(NDAY.NE.0) THEN                                     
                  COSZ(i) = COSZM / NDAY                                  
               ELSE                                                 
                  COSZ(i) = 0.0                                         
               END IF                                             
               SFAC(i) = FLOAT(NDAY)/FLOAT(c3day)                   
            enddo                                                        
         end if
      end if

      end subroutine coszen

      end module coszen_module
