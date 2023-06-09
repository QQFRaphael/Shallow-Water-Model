      program errnorms

! compute layer thickness statistical error norms from the
! shallow-water model results
! 
! in this version, the spectral-tranform shallow water model (stswm) results
! are compared to the geodesic results.  the stswm results have already 
! been interpolated to the same grid points as the geodesic model results

      implicit none

      integer, parameter :: iendday_max=30
      integer :: i,iday,gsize,ndays

      real*8, dimension(:), allocatable :: height1,height2,hgtdiff,
     +  hgtdiff2,hgtdiffsq,h1sq,area
      real*8 :: l1,l2,linf,dum
      real*8, dimension(0:iendday_max) :: l1sav,l2sav,linfsav

      character (len=50) ::
     +  fileprefix1='./', 
     +  fileprefix2='../run.0040962/' 
      character (len=80) :: filename
      character*8 :: idaystr

      write(*,*) 'Enter geodesic grid resolution'
      read(*,*) gsize
      write(*,*) 'Enter number of days in run'
      read(*,*) ndays

! skip next two lines in file
      read(*,'(a80)') filename
      read(*,'(a80)') filename

      allocate(height1(gsize),height2(gsize),hgtdiff(gsize),
     +  hgtdiff2(gsize),hgtdiffsq(gsize),h1sq(gsize),area(gsize))

!-- stswm results interpolated to the geodesic grid cell lat/lons
!      filename = trim(fileprefix1) // 'layer_thickness.out'
      write(*,*) 'Enter STSWM layer thickness file'
      read(*,'(a80)') filename
      filename = trim(filename)
      open(unit=10,file=filename,form='formatted',
     +     status='old',action='read')

!      filename = trim(fileprefix2) // 'area-ez'
      write(*,*) 'Enter CSU grid cell area file'
      read(*,'(a80)') filename
      filename = trim(filename)
      open(unit=13,file=filename,form='formatted',
     +     status='old',action='read')
      read(13,'(5e15.8)') area
      close(13)

      write(*,*) 'Enter CSU SWM layer thickness file'
      read(*,'(a80)') filename
      filename = trim(filename)
      open(unit=14,file=filename,form='formatted',
     +     status='old',action='read')

      open(unit=40,file='hdiff',form='formatted',action='write')
      do iday = 0,ndays
        write(unit=idaystr,fmt='(i8.8)') iday
        write(*,*) idaystr
     
        read(10,'(5e15.8)') height1
        write(*,*) 'min/max(stswm) = ',minval(height1),maxval(height1)

        read(14,'(5e15.8)') height2
        write(*,*) 'min/max(csu) = ',minval(height2),maxval(height2)

        do i = 1,gsize
          hgtdiff(i) = abs(height2(i)-height1(i))
          hgtdiff2(i) = height2(i)-height1(i)
        enddo
        write(40,'(5e15.8)') hgtdiff2

        hgtdiffsq = hgtdiff**2.

        l1 = sum(hgtdiff*area)/sum(height1*area)
       
        l2 = sqrt(sum(hgtdiffsq*area))
        h1sq = height1**2
        dum = sqrt(sum(h1sq*area))
        l2 = l2/dum
      
        linf = maxval(hgtdiff)
        linf = linf/maxval(height1)
      
        write(*,*) 'l1 = ',l1
        write(*,*) 'l2 = ',l2
        write(*,*) 'linf = ',linf
       
        l1sav(iday) = l1
        l2sav(iday) = l2
        linfsav(iday) = linf
      
      enddo
      close(10)      
      close(14)      
      close(40)    

      deallocate(height1,height2,hgtdiff,hgtdiff2,hgtdiffsq,h1sq,area) 

      open(unit=50,file='err.out',form='formatted',action='write')
      do iday = 0,ndays
        write(50,'(3e15.8)') l1sav(iday),l2sav(iday),linfsav(iday)
      enddo
      close(50)      

      end program errnorms
