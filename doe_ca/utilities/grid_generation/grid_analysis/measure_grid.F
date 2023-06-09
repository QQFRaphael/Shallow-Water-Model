program measure_grid

!------------------------------------------------------------------------
! purpose: given a description of the grid in terms of the total
! number of cell, the location of the cell centers, and the grid
! connectivity, this program computes some metrics that measure the
! global and local uniformity of the grid. todd ringler.
!
! all of the input data required for this program is generated in the
! program "grid_generator" located in the .. directory
!
! this program links to utilities in the layer_1 and layer_2 directory
!------------------------------------------------------------------------

use kinds
use geodesic_grid_utilities

implicit none


!------------------------------------------------------------------------
! declarations
!------------------------------------------------------------------------
integer(int_kind) :: ngrid
integer(int_kind) :: i,j,ii,jj,gcounter, lcounter, k
integer(int_kind), parameter :: nspace=3, nneighbor=6
integer(int_kind), allocatable, dimension(:) :: grid_index
integer(int_kind), allocatable, dimension(:,:) :: center_connectivity
real(dbl_kind), allocatable, dimension(:,:) :: p, sub_area, corner_area, wall_ratio
real(dbl_kind), allocatable, dimension(:,:,:) :: c, w
real(dbl_kind), allocatable, dimension(:) :: ave_sub_area_l, var_sub_area_l
real(dbl_kind), allocatable, dimension(:,:) :: var_corner_area_l
real(dbl_kind), allocatable, dimension(:) :: cell_area
real(dbl_kind) :: d, t(nspace,nneighbor)
real(dbl_kind) :: ave_dist_g, min_dist_g, max_dist_g, ave_wall_ratio
real(dbl_kind) :: dist1, dist2, dist3
real(dbl_kind), allocatable, dimension(:) ::  ave_dist_l, var_dist_l
real(dbl_kind), allocatable, dimension(:) :: min_dist_l, max_dist_l
real(dbl_kind), allocatable, dimension(:) :: min_area_l, max_area_l
character*80 grid_center_file, grid_connectivity_file


!------------------------------------------------------------------------
!get grid info
!------------------------------------------------------------------------
write(6,*) ' enter number of cell centers'
read(5,*) ngrid
write(6,*) ' enter grid centers file'
read(5,*) grid_center_file
write(6,*) ' enter connectivity file'
read(5,*) grid_connectivity_file

!------------------------------------------------------------------------
! allocate space
!------------------------------------------------------------------------
allocate(p(nspace,ngrid))
allocate(c(nspace,nneighbor,ngrid))
allocate(w(nspace,nneighbor,ngrid))
allocate(wall_ratio(nneighbor,ngrid))
allocate(sub_area(nneighbor,ngrid))
allocate(corner_area(2,ngrid),var_corner_area_l(2,ngrid))
allocate(grid_index(ngrid))
allocate(center_connectivity(nneighbor,ngrid))
allocate(ave_dist_l(ngrid),var_dist_l(ngrid))
allocate(ave_sub_area_l(ngrid),var_sub_area_l(ngrid))
allocate(cell_area(ngrid))
allocate(min_dist_l(ngrid),max_dist_l(ngrid))
allocate(min_area_l(ngrid),max_area_l(ngrid))

!------------------------------------------------------------------------
! initialize
!------------------------------------------------------------------------
p              = 0.0_dbl_kind
c              = 0.0_dbl_kind
w              = 0.0_dbl_kind
sub_area       = 0.0_dbl_kind
grid_index     = 0
center_connectivity   = 0
ave_dist_l     = 0
var_dist_l     = 0
ave_sub_area_l = 0
cell_area      = 0
var_sub_area_l = 0
min_dist_l     = 1e30
max_dist_l     = -1e30
min_area_l     = 1e30
max_area_l     = -1e30

!------------------------------------------------------------------------
!open files
!------------------------------------------------------------------------
open(unit=1,file=grid_center_file,form='formatted',status='old')
open(unit=2,file=grid_connectivity_file,form='formatted',status='old')

!------------------------------------------------------------------------
!loop over ngrid and read in data
!------------------------------------------------------------------------
do i=1,ngrid
read(1,10) p(1,i),p(2,i),p(3,i)
read(2,11) ii,jj,grid_index(i),     &
                 center_connectivity(1,i), &
                 center_connectivity(2,i), &
                 center_connectivity(3,i), &
                 center_connectivity(4,i), &
                 center_connectivity(5,i), &
                 center_connectivity(6,i) 
enddo
10 FORMAT (3F24.20)
11 format (9i10)


!------------------------------------------------------------------------
!close files
!------------------------------------------------------------------------
close(1)
close(2)

!------------------------------------------------------------------------
! dump info to screen
!------------------------------------------------------------------------
write(6,100) '   GRID ANALYSIS PROGRAM '
write(6,81) ' total number of grid cells : ',maxval(grid_index)+1
write(6,82) ' input grid centers file : ', grid_center_file
write(6,82) ' input center_connectivity file : ', grid_connectivity_file

!------------------------------------------------------------------------
! compute distance metrics: averages, min, max
!------------------------------------------------------------------------
gcounter = 0
ave_dist_g = 0
min_dist_g = +1.0e10
max_dist_g = -1.0e10
ave_dist_l = 0
do i=1,ngrid
  lcounter = 0
  do j=1,nneighbor
    if(center_connectivity(j,i).gt.0) then
      call distance_along_unit_sphere(p(:,i),p(:,center_connectivity(j,i)),d)
      gcounter = gcounter + 1
      ave_dist_g = ave_dist_g + d
      if(d.gt.max_dist_g) max_dist_g=d
      if(d.lt.min_dist_g) min_dist_g=d
      lcounter = lcounter + 1
      ave_dist_l(i) = ave_dist_l(i) + d
    endif
  enddo
  ave_dist_l(i) = ave_dist_l(i) / lcounter
enddo
ave_dist_g = ave_dist_g / gcounter
d = max(abs(min_dist_g-ave_dist_g),abs(max_dist_g-ave_dist_g))

write(6,100) 'GLOBAL DISTANCE NORMS'
write(6,80) ' min distance : ', min_dist_g
write(6,80) ' max distance : ', max_dist_g
write(6,80) ' avg distance : ', ave_dist_g
write(6,80) ' max(abs((d-avg))/ave_dist_g : ', d/ave_dist_g
write(6,80) ' ratio of min to max : ', min_dist_g/max_dist_g
80 format(a30,e20.10)
81 format(a30,i20)
82 format(a30,a30)
100 format(//,'-------------------------------------------',/,a30,/,  &
              '-------------------------------------------')

!------------------------------------------------------------------------
! loop again to compute variations
!------------------------------------------------------------------------
do i=1,ngrid
  lcounter = 0
  do j=1,nneighbor
    if(center_connectivity(j,i).gt.0) then
      call distance_along_unit_sphere(p(:,i),p(:,center_connectivity(j,i)),d)
      lcounter = lcounter + 1
      var_dist_l(i) = var_dist_l(i) + abs(d-ave_dist_l(i))
      if(d.gt.max_dist_l(i)) max_dist_l(i) = d
      if(d.lt.min_dist_l(i)) min_dist_l(i) = d
    endif
  enddo
  var_dist_l(i) = var_dist_l(i) / lcounter
enddo
write(6,100) 'STENCIL DISTANCE NORMS'
write(6,*)  ' D(i) = sum over neigbhors of |p(i) - p(neigbhor)|/ nneighbor'
write(6,*)  ' A(i) = average |p(i) - p(neigbhor)|/neigbhor'
write(6,80) ' maxval(D(:)/A(:)) : ', maxval(var_dist_l(:)/ave_dist_l(:))
write(6,80) ' avg(D(:)/A(:)) : ',sum(var_dist_l(:)/ave_dist_l(:))/ngrid
write(6,80) ' avg(min/max) : ',sum(min_dist_l(:)/max_dist_l(:))/ngrid


!------------------------------------------------------------------------
! find corners
!------------------------------------------------------------------------
gcounter = 0
do i=1,ngrid
  lcounter = 0
  do j=1,nneighbor
     k=j+1
     if(k.gt.nneighbor) k=1
     if(center_connectivity(j,i).gt.0) then
       if(center_connectivity(k,i).lt.0) then
         k=k+1
         if(k.gt.nneighbor) k=1
       endif
       t(:,1) = p(:,i)
       t(:,2) = p(:,center_connectivity(j,i))
       t(:,3) = p(:,center_connectivity(k,i))
       call compute_voronoi_corner(.true.,.true.,t(:,1),t(:,2),t(:,3),c(:,j,i))
       w(:,j,i) =  0.5_dbl_kind*(t(:,1)+t(:,2))
       w(:,k,i) =  0.5_dbl_kind*(t(:,1)+t(:,3))
       call unit_vector_in_3space(w(:,j,i))
       call unit_vector_in_3space(w(:,k,i))
       call spherical_area(t(:,1),w(:,j,i),c(:,j,i),t(2,3))
       call spherical_area(t(:,1),c(:,j,i),w(:,k,i),t(3,3))
       sub_area(j,i) = t(2,3) + t(3,3)
       gcounter = gcounter+1
       lcounter = lcounter+1
       ave_sub_area_l(i) = ave_sub_area_l(i) + sub_area(j,i)
     endif
  enddo
  cell_area(i) = ave_sub_area_l(i)
  ave_sub_area_l(i) = ave_sub_area_l(i) / lcounter
enddo

!------------------------------------------------------------------------
! find ratio
!------------------------------------------------------------------------
wall_ratio = -999
gcounter = 0
do i=1,ngrid
  do j=1,nneighbor
     k=j+1
     if(k.gt.nneighbor) k=1
     if(center_connectivity(j,i).gt.0.and.center_connectivity(k,i).gt.0) then
       gcounter = gcounter + 1
       call distance_along_unit_sphere(c(:,j,i),c(:,k,i),dist1)
       call distance_along_unit_sphere(w(:,k,i),c(:,j,i),dist2)
       wall_ratio(i,j) = (abs(0.5*dist1 - dist2))/dist1
       ave_wall_ratio = ave_wall_ratio + wall_ratio(i,j)
     endif
  enddo
enddo
ave_wall_ratio = ave_wall_ratio / gcounter
write(6,100) ' WALL RATIO NORMS'
write(6,*) minval(wall_ratio,wall_ratio>0)
write(6,*) maxval(wall_ratio,wall_ratio>0)
write(6,*) ave_wall_ratio
write(6,*)

!------------------------------------------------------------------------
! area norms
!------------------------------------------------------------------------
t(1,1) = minval(cell_area)
t(1,2) = maxval(cell_area)
t(1,3) = sum(cell_area)/ngrid
t(2,3) = max(abs(t(1,1)-t(1,3)),abs(t(1,2)-t(1,3)))
write(6,100) ' GLOBAL CELL AREA NORMS'
write(6,81) 'total number of cells : ',ngrid
write(6,80) ' sum of cell area : ',sum(cell_area)
write(6,80) ' area of unit sphere : ',4.0_dbl_kind*(4.0_dbl_kind*atan(1.0_dbl_kind))
write(6,80) ' min of cell area : ',t(1,1)
write(6,80) ' max of cell area : ',t(1,2)
write(6,80) ' average cell area : ',t(1,3)
write(6,80) ' max variation : ',t(2,3)/t(1,3)
write(6,80) ' ratio of min to max : ',t(1,1)/t(1,2)

!------------------------------------------------------------------------
! area norms
!------------------------------------------------------------------------
t(1,1) = minval(sub_area(:,:),mask=center_connectivity.gt.0)
t(1,2) = maxval(sub_area(:,:),mask=center_connectivity.gt.0)
t(1,3) = sum(sub_area)/gcounter
t(2,3) = max(abs(t(1,1)-t(1,3)),abs(t(1,2)-t(1,3)))
write(6,100) ' GLOBAL SUB AREA NORMS'
write(6,81) ' total number of sub_areas : ',gcounter
write(6,80) ' sum of sub_area : ',sum(sub_area)
write(6,80) ' area of unit sphere : ',4.0_dbl_kind*(4.0_dbl_kind*atan(1.0_dbl_kind))
write(6,80) ' min of sub_area : ',t(1,1)
write(6,80) ' max of sub_area : ',t(1,2)
write(6,80) ' average sub_area : ',t(1,3)
write(6,80) ' max variation : ',t(2,3)/t(1,3)
write(6,80) ' ratio of min to max : ',t(1,1)/t(1,2)

!------------------------------------------------------------------------
! stencil area norms
!------------------------------------------------------------------------
gcounter = 0
do i=1,ngrid
  lcounter = 0
  do j=1,nneighbor
     if(center_connectivity(j,i).gt.0) then
       lcounter = lcounter+1
       var_sub_area_l(i) = var_sub_area_l(i) + abs(sub_area(j,i)-ave_sub_area_l(i))
     endif
  enddo
  var_sub_area_l(i) = var_sub_area_l(i) / lcounter
enddo
write(6,100) 'CELL CENTER STENCIL AREA NORMS '
write(6,*)  ' D(i) = sum over ncorners of |sub_area(c,i) - A(i)| / ncorner'
write(6,*)  ' A(i) = average sub_area(c,i)'
write(6,80) ' maxval(D(:)/A(:)) : ', maxval(var_sub_area_l(:)/ave_sub_area_l(:))
write(6,80) ' avg(D(:)/A(:)) : ',sum(var_sub_area_l(:)/ave_sub_area_l(:))/ngrid

!------------------------------------------------------------------------
! corner areas
!------------------------------------------------------------------------
gcounter = 0
corner_area = 0
var_corner_area_l = 0
do i=3,ngrid
  lcounter = 0
  do j=1,2
    gcounter = gcounter + 1
    if(j.eq.1) then

    t(1,1) = sub_area(1,i)
    t(2,1) = sub_area(3,center_connectivity(1,i))
    t(3,1) = sub_area(5,center_connectivity(2,i))
    if(t(3,1).eq.0) t(3,1) = sub_area(4,center_connectivity(2,i))
   
    else
 
    t(1,1) = sub_area(2,i)
    t(2,1) = sub_area(4,center_connectivity(2,i))
    t(3,1) = sub_area(6,center_connectivity(3,i))
    if(t(3,1).eq.0) t(3,1) = sub_area(5,center_connectivity(3,i))

    endif

    corner_area(j,i) = t(1,1) + t(2,1) + t(3,1)

    var_corner_area_l(j,i) = abs(t(1,1)-corner_area(j,i)/3.0) + &
                             abs(t(2,1)-corner_area(j,i)/3.0) + &
                             abs(t(3,1)-corner_area(j,i)/3.0) 

  enddo
enddo
t(1,1) = minval(corner_area(:,3:ngrid),mask=center_connectivity(1:2,3:ngrid).gt.0)
t(1,2) = maxval(corner_area(:,3:ngrid),mask=center_connectivity(1:2,3:ngrid).gt.0)
t(1,3) = sum(corner_area)/gcounter
t(2,3) = max(abs(t(1,1)-t(1,3)),abs(t(1,2)-t(1,3)))

!------------------------------------------------------------------------
! area norms
!------------------------------------------------------------------------
write(6,100) ' GLOBAL CORNER AREA NORMS'
write(6,81) ' total number of corners : ',gcounter
write(6,80) ' sum of sub_area : ',sum(corner_area)
write(6,80) ' area of unit sphere : ',4.0_dbl_kind*(4.0_dbl_kind*atan(1.0_dbl_kind))
write(6,80) ' min of corner_area : ',t(1,1)
write(6,80) ' max of corner_area : ',t(1,2)
write(6,80) ' average corner_area : ',t(1,3)
write(6,80) ' max variation : ',t(2,3)/t(1,3)
write(6,80) ' ratio of min to max : ',t(1,1)/t(1,2)


t(1,1) = maxval(var_corner_area_l(1:2,3:ngrid)/corner_area(1:2,3:ngrid))
t(2,1) = sum(var_corner_area_l(1:2,3:ngrid)/corner_area(1:2,3:ngrid))/gcounter
write(6,100) 'CELL CORNER STENCIL AREA NORMS '
write(6,*)  ' D(c) = sum over cell centers of |sub_area(c,i) - avg| / 3'
write(6,*)  ' A(c) = average sub_area(c,i)/3'
write(6,80) ' maxval(D(:)/A(:)) : ', t(1,1)
write(6,80) ' avg(D(:)/A(:)) : ',t(2,1)

  
!------------------------------------------------------------------------
! all done
!------------------------------------------------------------------------
end program measure_grid
