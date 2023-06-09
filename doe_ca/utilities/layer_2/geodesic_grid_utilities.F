!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

        module geodesic_grid_utilities

!-----------------------------------------------------------------------
! PURPOSE: this module contains a set of utilities related to both
!	the spherical geodesic grid and to the various coordinate
!	systems used to describe the data.
!-----------------------------------------------------------------------

        use kinds
        use params_physical

        implicit none

	private

	public ::                                                     &
      		get_surrounding_centers,                              &
                get_surrounding_corners,                              &
      		compute_voronoi_corner,                               &
      		check_voronoi_corner,                                 &
      		cross_product_in_3space,                              &
      		unit_vector_in_3space,                                &
      		distance_along_unit_sphere,                           &
      		vector_on_tangent_plane,                              &
      		spherical_area,                                       &
      		xyz_to_lonlat,                                        &
                distance_along_a_line,                                &
                compute_triangle_area,                                &
      		lonlat_to_xyz,                                        &
                find_a_point_in_a_plane,                              &
                find_centroid_of_triangle
    

!**********************************************************************

        contains

!**********************************************************************



!======================================================================
! BEGIN GET_SURROUNDING_CENTERS
!======================================================================
        subroutine get_surrounding_centers(                           &
      		i,                                                    &
      		j,                                                    &
      		icorner,                                              &
      		idata,                                                &
      		iim,                                                  &
      		jjm,                                                  &
                polygon_type,                                         &
      		xin,                                                  &
      		xout)                                                 

!-----------------------------------------------------------------------
! PURPOSE : given an corner location (icorner,i,j), find the
!	surrounding grid cell centers. Take the data for these three
!	cell centers and list it sequentially in xout.
!
! NOTE : routine currently hardwired to find the surrounding three
!	cell centers (idata must equal 3).
!
! NOTE : the data is always listed in a counter-clockwise direction when
!	looking down on the data.
!-----------------------------------------------------------------------

        implicit none

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        integer (kind=int_kind), intent(in) ::                              &
                        i,                                                  &
                        j,                                                  &
                        icorner,                                            &
      			idata,                                              &
      			iim,                                                &
      			jjm

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(in) ::                                 &
                        polygon_type,                                       &
                        xin(iim,jjm)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                                &
                        xout(idata)

!-----------------------------------------------------------------------
! check to see if idata is the correct value
!-----------------------------------------------------------------------
	if(idata /= 3) then
	  write(6,*) ' not coded for idata other than 3'
	endif

!-----------------------------------------------------------------------
! check to see if it a regular polygon
!-----------------------------------------------------------------------
	if(polygon_type <= 2.0_dbl_kind ) then

!-----------------------------------------------------------------------
! all of these corners look the same
!-----------------------------------------------------------------------
          if(icorner == 1) then
            xout(1) = xin(i  ,j  )
            xout(2) = xin(i-1,j  )
            xout(3) = xin(i-1,j-1)
          else
            xout(1) = xin(i  ,j  )
            xout(2) = xin(i-1,j-1)
            xout(3) = xin(i  ,j-1)
          endif

	elseif(polygon_type == 3.0_dbl_kind) then

          if(icorner == 1) then
            xout(1) = xin(i  ,j  )
            xout(2) = xin(i  ,j+1)
            xout(3) = xin(iim,1  )
          else
            xout(1) = xin(i  ,j  )
            xout(2) = xin(iim,1  )
            xout(3) = xin(i  ,j-1)
          endif

	elseif(polygon_type == 4.0_dbl_kind) then
  
          if(icorner == 1) then
            xout(1) = xin(i  ,j  )
            xout(2) = xin(i-1,j  )
            xout(3) = xin(1  ,jjm)
          else
            xout(1) = xin(i  ,j  )
            xout(2) = xin(1  ,jjm)
            xout(3) = xin(i+1,j  )
          endif

	endif

        end subroutine get_surrounding_centers
!======================================================================
! END GET_SURROUNDING_CENTERS
!======================================================================


!======================================================================
! BEGIN GET_SURROUNDING_CORNERS
!======================================================================
        subroutine get_surrounding_corners(                           &
                i,                                                    &
                j,                                                    &
                iim,                                                  &
                jjm,                                                  & 
                ncorners,                                             &
                nhex,                                                 &
                polygon_type,                                         &
                xin,                                                  &
                xout)

!-----------------------------------------------------------------------
! PURPOSE : given an center location (i,j), find the
!       surrounding grid cell corners. Take the data for these five or six
!       cell corners and list it sequentially in xout.
!
! NOTE : the data is always listed in a counter-clockwise direction when
!       looking down on the data.
!-----------------------------------------------------------------------

        implicit none

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        integer (kind=int_kind), intent(in) ::                              &
                        i,                                                  &
                        j,                                                  &
                        ncorners,                                           &
                        nhex,                                               &
                        iim,                                                &
                        jjm

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(in) ::                                 &
                        polygon_type,                                       &
                        xin(ncorners,iim,jjm)

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                                &
                        xout(nhex)

!-----------------------------------------------------------------------
! check to see if idata is the correct value
!-----------------------------------------------------------------------
        if(nhex /= 6) then
          write(6,*) ' not coded for nhex other than 6'
        endif

!-----------------------------------------------------------------------
! check to see if it a regular polygon
!-----------------------------------------------------------------------
        if(polygon_type == 1.0_dbl_kind ) then

          xout(1) = xin(1,i  ,j  )
          xout(2) = xin(2,i  ,j  )
          xout(3) = xin(1,i+1,j  )
          xout(4) = xin(2,i+1,j+1)
          xout(5) = xin(1,i+1,j+1)
          xout(6) = xin(2,i  ,j+1)

!-----------------------------------------------------------------------
! check to see if it a NH or SH pentagon
!-----------------------------------------------------------------------
        elseif(polygon_type == 2.0_dbl_kind) then

          xout(1) = xin(1,i  ,j  )
          xout(2) = xin(2,i  ,j  )
          xout(3) = xin(1,i+1,j  )
          xout(4) = xin(2,i+1,j+1)
          xout(5) = xin(2,i  ,j+1)
          xout(6) = -9.99e30_dbl_kind

!-----------------------------------------------------------------------
! check to see if it is the NP
!-----------------------------------------------------------------------
        elseif(polygon_type == 3.0_dbl_kind) then

          xout(1) = xin(1,i  ,j  )
          xout(2) = xin(2,i  ,j  )
          xout(3) = xin(1,i+1,j  )
          xout(4) = xin(2,i+1,j+1)
          xout(5) = xin(1,i+1,j+1)
          xout(6) = -9.99e30_dbl_kind


!-----------------------------------------------------------------------
! check to see if it is the SP
!-----------------------------------------------------------------------
        elseif(polygon_type == 4.0_dbl_kind) then

          xout(1) = xin(1,i  ,j  )
          xout(2) = xin(2,i  ,j  )
          xout(3) = xin(2,i+1,j+1)
          xout(4) = xin(1,i+1,j+1)
          xout(5) = xin(2,i  ,j+1)
          xout(6) = -9.99e30_dbl_kind

        endif

        end subroutine get_surrounding_corners
!======================================================================
! END GET_SURROUNDING_CORNERS
!======================================================================


!======================================================================
! BEGINNING OF COMPUTE_VORONOI_CORNER
!======================================================================
	subroutine compute_voronoi_corner(l_sphere,l_check,p_1,p_2,p_3,p_out)

!-----------------------------------------------------------------------
! PURPOSE: given three points (p_1,p_2,p_3) measured in (x,y,z), find
!	the Voronoi corner. The definition of the Voronoi corner is that
!	it is the point that is equi-distance from p_1, p_2, and p_3. There
!	is no guarentee the p_out will lie inside the triangle formed by
!	p_1, p_2, and p_3. the utility check_voronoi_corner is used to
!	determine if the corner is located inside the (p_1,p_2,p_3) 
!	triangle (if l_check == .true.)
!
! NOTE : it is assumed that p_1, p_2, p_3 are listed in a counter-clockwise
!	direction (when looking down at the unit sphere from above).
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
! intent(in)
!-----------------------------------------------------------------------
	real (kind=dbl_kind), intent(in) ::                           &
      			p_1 (r3),                                     &
                        p_2 (r3),                                     &
                        p_3 (r3) 

	logical, intent(in) :: l_sphere, l_check

!-----------------------------------------------------------------------
! intent(out)
!-----------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                           &
      			p_out (r3) 

!-----------------------------------------------------------------------
! local
!-----------------------------------------------------------------------
        real (kind=dbl_kind) ::                                        &
      			temp_1 (r3),                                   &
      			temp_2 (r3),                                   &
      			temp_3 (r3),                                   &
                        factor_u, factor_l, factor, resid, d

	integer (kind = int_kind) ::                                   &
      			ierr, iter

!-----------------------------------------------------------------------
! fill work arrays
!-----------------------------------------------------------------------
	temp_1(1) = p_2(1) - p_1(1)
	temp_1(2) = p_2(2) - p_1(2)
	temp_1(3) = p_2(3) - p_1(3)
	temp_2(1) = p_3(1) - p_1(1)
	temp_2(2) = p_3(2) - p_1(2)
	temp_2(3) = p_3(3) - p_1(3)

!-----------------------------------------------------------------------
! compute temp_1 cross temp_2
!-----------------------------------------------------------------------
	call cross_product_in_3space (temp_1,temp_2,temp_3)

!-----------------------------------------------------------------------
! normalize to a unit vector and place in intent(out)
!-----------------------------------------------------------------------
	call unit_vector_in_3space (temp_3)
	p_out = temp_3

!-----------------------------------------------------------------------
! if(l_sphere.eq.false), then move the point onto the plane defined by p_1,p_2,p_3
! solution is found via bisection search
!-----------------------------------------------------------------------
	if(.not.l_sphere) then
          d = -(temp_3(1)*p_1(1)+temp_3(2)*p_1(2)+temp_3(3)*p_1(3))
	  factor_u = 1.0_dbl_kind
          factor_l = 0.0_dbl_kind
          resid = 1.0_dbl_kind
          iter=0
          do while (abs(resid).gt.1.0e-14_dbl_kind)
           iter=iter+1
           if(iter.eq.1000) then
              write(6,*) ' stop in compute_voronio corner'
              write(6,*) ' bisection algorithm not converging'
              stop
           endif
           factor =  (factor_l+factor_u)/2.0
           resid = factor*(temp_3(1)**2+temp_3(2)**2+temp_3(3)**2) + d
           if(resid.gt.0.0)then
            factor_u=factor
           else
            factor_l=factor
           endif
          enddo
          p_out = factor * temp_3
	endif

!-----------------------------------------------------------------------
! check to see if p_out is inside the (p_1,p_2,p_3) triangle
!-----------------------------------------------------------------------
	if(l_check) then
	call check_voronoi_corner(p_1,p_2,p_3,p_out,ierr)
	if(ierr /= 0) then
	  write(6,*) ' voronoi corner is outside the triangle'
	  write(6,*) ' aborting'
	  write(6,*) p_1
	  write(6,*) p_2
	  write(6,*) p_3
	  write(6,*) p_out
	  stop
	endif
	endif

	end subroutine compute_voronoi_corner
!======================================================================
! END OF COMPUTE_VORONOI_CORNER
!======================================================================



!======================================================================
! BEGINNING OF CHECK_VORONOI_CORNER
!======================================================================
        subroutine check_voronoi_corner(p_1,p_2,p_3,p_4,ierr)

!-----------------------------------------------------------------------
! PURPOSE: check to see if p_4 lies inside (p_1,p_2,p_3)
!   this is done by testing the cross product of the unit vectors
!   point between the grid corners and the unit vectors pointing from
!   grid corners to the Voronoi corner
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
! intent(in)
!-----------------------------------------------------------------------
        real (kind=dbl_kind), intent(in) ::                           &
                        p_1 (r3),                                     &
                        p_2 (r3),                                     &
                        p_3 (r3),                                     &
      			p_4 (r3)

!-----------------------------------------------------------------------
! intent(out)
!-----------------------------------------------------------------------
        integer (kind=int_kind), intent(out) ::                       &
                        ierr

!-----------------------------------------------------------------------
! local
!-----------------------------------------------------------------------
        real (kind=dbl_kind) ::                                        &
                        temp_1 (r3),                                   &
                        temp_2 (r3),                                   &
      			temp_3 (r3),                                   &
      			dot

!-----------------------------------------------------------------------
! initialize output assuming there is no error
!-----------------------------------------------------------------------
	ierr = 0

!-----------------------------------------------------------------------
! check against p_1
!-----------------------------------------------------------------------
	call vector_on_tangent_plane(p_1, p_2, temp_1)
	call vector_on_tangent_plane(p_1, p_4, temp_2)
        call cross_product_in_3space (temp_1,temp_2,temp_3)
	dot = sum( p_1 * temp_3)
	if(dot < 0.0_dbl_kind) ierr = 1

!-----------------------------------------------------------------------
! check against p_2
!-----------------------------------------------------------------------
        call vector_on_tangent_plane(p_2, p_3, temp_1)
        call vector_on_tangent_plane(p_2, p_4, temp_2)
        call cross_product_in_3space (temp_1,temp_2,temp_3)
        dot = sum( p_2 * temp_3)
        if(dot < 0.0_dbl_kind) ierr = 1

!-----------------------------------------------------------------------
! check against p_3
!-----------------------------------------------------------------------
        call vector_on_tangent_plane(p_3, p_1, temp_1)
        call vector_on_tangent_plane(p_3, p_4, temp_2)
        call cross_product_in_3space (temp_1,temp_2,temp_3)
        dot = sum( p_3 * temp_3)
        if(dot < 0.0_dbl_kind) ierr = 1

        end subroutine check_voronoi_corner
!======================================================================
! END OF CHECK_VORONOI_CORNER
!======================================================================


!======================================================================
! BEGINNING OF CROSS_PRODUCT_IN_3SPACE
!======================================================================
        subroutine cross_product_in_3space(p_1,p_2,p_out)

!-----------------------------------------------------------------------
! PURPOSE: compute p_1 cross p_2 and place in p_out
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
! intent(in)
!-----------------------------------------------------------------------
        real (kind=dbl_kind), intent(in) ::                            &
                        p_1 (r3),                                      &
                        p_2 (r3) 

!-----------------------------------------------------------------------
! intent(out)
!-----------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                           &
                        p_out (r3)

	p_out(1) = p_1(2)*p_2(3)-p_1(3)*p_2(2)
	p_out(2) = p_1(3)*p_2(1)-p_1(1)*p_2(3)
	p_out(3) = p_1(1)*p_2(2)-p_1(2)*p_2(1)

        end subroutine cross_product_in_3space
!======================================================================
! END OF CROSS_PRODUCT_IN_3SPACE
!======================================================================


!======================================================================
! BEGINNING OF UNIT_VECTOR_IN_3SPACE
!======================================================================
        subroutine unit_vector_in_3space (p_1)

!-----------------------------------------------------------------------
! PURPOSE : normalize p_1 to unit length and overwrite p_1
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
! intent(inout)
!-----------------------------------------------------------------------
        real (kind=dbl_kind), intent(inout) ::                         &
                        p_1 (r3)

!-----------------------------------------------------------------------
! local
!-----------------------------------------------------------------------
	real (kind=dbl_kind) :: length

	length = SQRT (p_1(1)**2 + p_1(2)**2 + p_1(3)**2 )
	length = 1.0_dbl_kind/length
	p_1(1) = p_1(1)*length
	p_1(2) = p_1(2)*length
	p_1(3) = p_1(3)*length

        end subroutine unit_vector_in_3space
!======================================================================
! END OF UNIT_VECTOR_IN_3SPACE
!======================================================================



!======================================================================
! BEGINNING OF DISTANCE_ALONG_UNIT_SPHERE
!======================================================================
        subroutine distance_along_unit_sphere(p_1, p_2, distance)

!-----------------------------------------------------------------------
! PURPOSE : given two grid points measured in (x,y,z), find the
!	distance between them along the surface of the sphere
!
! NOTE : p_1 and p_2 are assumed to be of unit length
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
! intent(in)
!-----------------------------------------------------------------------
        real (kind=dbl_kind), intent(in) ::                            &
                        p_1 (r3),                                      &
      			p_2 (r3) 

!-----------------------------------------------------------------------
! intent(out)
!-----------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                           &
      			distance

	distance = acos (p_1(1)*p_2(1) + p_1(2)*p_2(2) + p_1(3)*p_2(3) )

        end subroutine distance_along_unit_sphere
!======================================================================
! END OF DISTANCE_ALONG_UNIT_SPHERE
!======================================================================



!======================================================================
! BEGINNING OF VECTOR_ON_TANGENT_PLANE
!======================================================================
        subroutine vector_on_tangent_plane(p_1, p_2, p_out)

!-----------------------------------------------------------------------
! PURPOSE : given two points measured in (x,y,z) and lying on
!	the unit sphere, find the vector (p_out) that lies on the plane
!	perpendicular to the p_1 vector and points in the direction of
!	the projection of p_2 onto the tangent plane.
!
! NOTE : p_1 and p_2 are assumed to be of unit length
! NOTE : p_out is normalized to unit length
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
! intent(in)
!-----------------------------------------------------------------------
        real (kind=dbl_kind), intent(in) ::                            &
                        p_1 (r3),                                      &
                        p_2 (r3)

!-----------------------------------------------------------------------
! intent(out)
!-----------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                           &
                        p_out (r3)                      

!-----------------------------------------------------------------------
! local
!-----------------------------------------------------------------------
	real (kind=dbl_kind) ::                                        &
      			work (r3)                                       

	work (1) = - p_1(2) * ( -p_1(2) * p_2(1) + p_1(1) * p_2(2) )   &
                   + p_1(3) * (  p_1(3) * p_2(1) - p_1(1) * p_2(3) )

 	work (2) = + p_1(1) * ( -p_1(2) * p_2(1) + p_1(1) * p_2(2) )   &
                   - p_1(3) * ( -p_1(3) * p_2(2) + p_1(2) * p_2(3) )

	work (3) = - p_1(1) * (  p_1(3) * p_2(1) - p_1(1) * p_2(3) )   &
                   + p_1(2) * ( -p_1(3) * p_2(2) + p_1(2) * p_2(3) )

	call unit_vector_in_3space (work)

	p_out = work

        end subroutine vector_on_tangent_plane
!======================================================================
! END OF VECTOR_ON_TANGENT_PLANE
!======================================================================



!======================================================================
! BEGINNING OF SPHERICAL_AREA
!======================================================================
        subroutine spherical_area(p_1, p_2, p_3, area)

!-----------------------------------------------------------------------
! PURPOSE : given three points measured in (x,y,z) lying on the unit
!	sphere, find the spherical area of the triangle formed by
!	connecting these three points
!
! NOTE : p_1, p_2, p_3 are assumed to be of unit length
! NOTE : p_out has units of radians^2
!
! NOTE : see Mathematical CRC Tables for formula
!	area = angle1 + angle2 + angle3 - pi
!	where angle? are the vertex angles
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
! intent(in)
!-----------------------------------------------------------------------
        real (kind=dbl_kind), intent(in) ::                            &
                        p_1 (r3),                                      &
                        p_2 (r3),                                      &
      			p_3 (r3)

!-----------------------------------------------------------------------
! intent(out)
!-----------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                           &
                        area

!-----------------------------------------------------------------------
! local
!-----------------------------------------------------------------------
        real (kind=dbl_kind) ::                                        &
                        t1 (r3),                                       &
      			t2 (r3)

!-----------------------------------------------------------------------
! initialize area to -pi
!-----------------------------------------------------------------------
	area = - pi

!-----------------------------------------------------------------------
! find angle formed by p_3, p_1, p_2
!-----------------------------------------------------------------------
	call vector_on_tangent_plane (p_1, p_2, t1)
	call vector_on_tangent_plane (p_1, p_3, t2)
	area = area + acos( t1(1)*t2(1) + t1(2)*t2(2) + t1(3)*t2(3) )

!-----------------------------------------------------------------------
! find angle formed by p_1, p_2, p_3
!-----------------------------------------------------------------------
        call vector_on_tangent_plane (p_2, p_3, t1)
        call vector_on_tangent_plane (p_2, p_1, t2)
        area = area + acos( t1(1)*t2(1) + t1(2)*t2(2) + t1(3)*t2(3) )

!-----------------------------------------------------------------------
! find angle formed by p_2, p_3, p_1
!-----------------------------------------------------------------------
        call vector_on_tangent_plane (p_3, p_1, t1)
        call vector_on_tangent_plane (p_3, p_2, t2)
        area = area + acos( t1(1)*t2(1) + t1(2)*t2(2) + t1(3)*t2(3) )

        end subroutine spherical_area
!======================================================================
! END OF SPHERICAL_AREA
!======================================================================



!======================================================================
! BEGINNING OF XYZ_to_LONLAT
!======================================================================
        subroutine xyz_to_lonlat(p_1, s_out)

!-----------------------------------------------------------------------
! PURPOSE : given a point measured in (x,y,z), find the longitude
!	and latitude.
!
! NOTE : the two coordinate systems are related in the following manner:
!	        (1, 0, 0) transforms to (0   , 0    )  (grenich)
!		(0, 1, 0) transforms to (pi/2, 0    ) 
!               (0, 0, 1) transforms to (0   , pi/2 )  (north pole)
!
! NOTE : p_1 is assumed to be of unit length
! NOTE : s_out is measured in radians with
!		s_out(1) ranging from -pi to pi (longitude)
!		s_out(2) ranging from -pi/2 to pi/2 (latitude)
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
! intent(in)
!-----------------------------------------------------------------------
        real (kind=dbl_kind), intent(in) ::                            &
                        p_1 (r3)

!-----------------------------------------------------------------------
! intent(out)
!-----------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                           &
                        s_out (r2)

!-----------------------------------------------------------------------
! the latitude is the arcsin of the z component
!-----------------------------------------------------------------------
	s_out(2) = asin (p_1(3))

!-----------------------------------------------------------------------
! check to see if either of the x and y values are non zero
! if so, the longitude is the arctan of y/x
! if both x and y are zero, then the location is the North Pole
! or the South Pole and just set the longitude to zero
!-----------------------------------------------------------------------
	if(p_1(1) /= 0.0_dbl_kind .or. p_1(2) /= 0.0_dbl_kind) then
	  s_out(1) = atan2(p_1(2),p_1(1))
	else
	  s_out(1) = 0.0_dbl_kind
	endif

        end subroutine xyz_to_lonlat
!======================================================================
! END OF XYZ_TO_LONLAT
!======================================================================


!======================================================================
! BEGINNING OF LONLAT_TO_XYZ
!======================================================================
        subroutine lonlat_to_xyz(s_1, p_out)

!-----------------------------------------------------------------------
! PURPOSE : given a point measured in (x,y,z), find the longitude
!       and latitude.
!
! NOTE : the two coordinate systems are related in the following manner:
!               (0   , 0    ) transforms to (1, 0, 0)  (grenich)
!               (pi/2, 0    ) transforms to (0, 1, 0)
!               (0   , pi/2 ) transforms to (0, 0, 1) (north pole)
!
! NOTE : the radius is assumed to be of unit length
! NOTE : p_out is of unit length
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
! intent(in)
!-----------------------------------------------------------------------
        real (kind=dbl_kind), intent(in) ::                            &
                        s_1 (r2)

!-----------------------------------------------------------------------
! intent(out)
!-----------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                           &
                        p_out (r3)

!-----------------------------------------------------------------------
! this is the transformation from (lon,lat) to (x,y,z)
!-----------------------------------------------------------------------
	p_out (3) = sin (s_1(2))
	p_out (1) = cos (s_1(2)) * cos ( s_1(1))
        p_out (2) = cos (s_1(2)) * sin ( s_1(1))

        end subroutine lonlat_to_xyz
!======================================================================
! END OF LONLAT_TO_XYZ
!======================================================================


!======================================================================
! BEGINNING OF COMPUTE_TRIANGLE_AREA
!======================================================================
        subroutine compute_triangle_area(p1,p2,p3,area)

!----------------------------------------------------------------------------
! compute the area of the linear surface (i.e. the area of the plane) that
!  connects p1(:), p2(:), and p3(:)
!----------------------------------------------------------------------------

        implicit none

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        real (kind = dbl_kind), dimension(r3), intent(in) ::       &
                        p1, p2, p3

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind = dbl_kind), intent(out) ::                       &
                        area

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
	integer (kind = int_kind) ::                                &
                        i,j

        real (kind = dbl_kind) ::                                   &
                        r(3)


	r(:) = 0.0

	do i=1,3
         j=i+1 
         if(j.eq.4) j=1
         r(i) =  + p2(i)*p3(j) - p2(j)*p3(i)   &
                 - p1(i)*p3(j) + p1(j)*p3(i)   &
                 + p1(i)*p2(j) - p1(j)*p2(i)
	enddo

        area = p5 * sqrt( r(1)**2 + r(2)**2 + r(3)**2 )

        end subroutine compute_triangle_area
!======================================================================
! END OF COMPUTE_TRIANGLE_AREA
!======================================================================



!======================================================================
! BEGINNING OF DISTANCE_ALONG_A_LINE
!======================================================================
        subroutine distance_along_a_line(p1,p2,d)

!----------------------------------------------------------------------------
! compute the length of the line connecting p1 and p2
!----------------------------------------------------------------------------

        implicit none

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        real (kind = dbl_kind), dimension(r3), intent(in) ::       &
                        p1, p2

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind = dbl_kind), intent(out) ::                       &
                        d

	d = sqrt( (p1(1)-p2(1))**2 + (p1(2)-p2(2))**2 + (p1(3)-p2(3))**2 )

        end subroutine distance_along_a_line
!======================================================================
! END OF DISTANCE_ALONG_A_LINE
!======================================================================



!======================================================================
! BEGINNING OF DISTANCE_FROM_ORIGIN
!======================================================================
        subroutine distance_from_origin(p1,p2,p3,d)

!----------------------------------------------------------------------------
! given three points, find the minimum distance from the plane formed by
!   these three points from the origin
!----------------------------------------------------------------------------

        implicit none

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        real (kind = dbl_kind), dimension(r3), intent(in) ::      &
                        p1, p2, p3

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind = dbl_kind), intent(out) ::                    &
                        d

!----------------------------------------------------------------------------
! LOCAL
!----------------------------------------------------------------------------
	real (kind = dbl_kind), dimension(r3) :: f,g,h

	f(:) = p2(:) - p1(:)
	g(:) = p3(:) - p1(:)
	call cross_product_in_3space(f,g,h)
	g(1) = sqrt(h(1)*h(1)+h(2)*h(2)+h(3)*h(3))
	g(1) = 1.0_dbl_kind / g(1)

	f(1) = p1(1)*(p2(2)*p3(3) - p2(3)*p3(2))
	f(2) = p2(1)*(p1(2)*p3(3) - p1(3)*p3(2))
	f(3) = p3(1)*(p1(2)*p2(3) - p1(3)*p2(2))

	d = (f(1) - f(2) + f(3)) * g(1)

        end subroutine distance_from_origin
!======================================================================
! END OF DISTANCE_FROM_ORIGIN
!======================================================================


!======================================================================
! BEGINNING OF FIND_CENTROID_OF_TRIANGLE
!======================================================================
        subroutine find_centroid_of_triangle(p1,p2,p3,c)

!----------------------------------------------------------------------------
! given three points in 3-space, find the center of mass of the planar triangle
!   connecting these three points
!----------------------------------------------------------------------------

        implicit none

!----------------------------------------------------------------------------
! INTENT IN
!----------------------------------------------------------------------------
        real (kind = dbl_kind), dimension(r3), intent(in) ::      &
                        p1, p2, p3

!----------------------------------------------------------------------------
! INTENT OUT
!----------------------------------------------------------------------------
        real (kind = dbl_kind), dimension(r3), intent(out) ::     &
                        c

	c(:) = (p1(:) + p2(:) + p3(:)) / 3.0_dbl_kind

        end subroutine find_centroid_of_triangle
!======================================================================
! END OF FIND_CENTROID_OF_TRIANGLE
!======================================================================


!======================================================================
! START OF FIND_A_POINT_IN_A_PLANE
!======================================================================
        subroutine find_a_point_in_a_plane(x_perp, x_line, xout)

!-----------------------------------------------------------------------
! PURPOSE: given x_perp as a point (x,y,z), we find the equation for the plane
!       that is perpendicular to the line going through (0,0,0) and x_perp.
!	call this plane P.
!       given that plane P, we then find the point that is along the line 
!       defined by the points (0,0,0) and x_line that lies on the plane P
! NOTE : we assume everything is defined in X1
! NOTE : we assume that x_perp lies in the plane P
! NOTE : we check to make sure that x_perp and x_line form a small angle
!-----------------------------------------------------------------------

!-----------------------------------------------------------------------
! intent(in)
!-----------------------------------------------------------------------
        real (kind=dbl_kind), intent(in) ::                           &
                        x_perp (r3),                                  &
                        x_line (r3)

!-----------------------------------------------------------------------
! intent(out)
!-----------------------------------------------------------------------
        real (kind=dbl_kind), intent(out) ::                           &
                        xout (r3) 

!-----------------------------------------------------------------------
! local
!-----------------------------------------------------------------------
        real (kind=dbl_kind) :: d, factor_l, factor_u, factor, dot, resid
        integer (kind=int_kind) :: iter

!-----------------------------------------------------------------------
! make sure the two lines form a small angle
!-----------------------------------------------------------------------
	dot = x_perp(1)*x_line(1) + x_perp(2)*x_line(2) + x_perp(3)*x_line(3)
        factor_l = sqrt(x_perp(1)**2+x_perp(2)**2+x_perp(3)**2)
        factor_u = sqrt(x_line(1)**2+x_line(2)**2+x_line(3)**2)
	if(factor_l.eq.0.0.or.factor_u.eq.0.0) then
	   write(6,*) 'find_a_point_in_a_plane : x{perp or x_line eq 0'
           stop
        endif
	dot = dot / (factor_l * factor_u)
	if(dot.lt.0.8) then
           write(6,*) 'find_a_point_in_a_plane : '
           write(6,*) ' x_perp and x_line form too large an angle'
           write(6,*) ' the search alorithm might fail, stopping'
           stop
         endif

!-----------------------------------------------------------------------
! find the constant for the plane
! note : the equation of a plane is ax+by+cz+d=0
!        where (a,b,c) define the local normal (this is x_perp)
!-----------------------------------------------------------------------
        d = -(x_perp(1)**2 + x_perp(2)**2+x_perp(3)**2)

!-----------------------------------------------------------------------
! set the upper and lower bounds for the search
!-----------------------------------------------------------------------
        factor_u = 2.0_dbl_kind
        factor_l = 0.0_dbl_kind
        resid = 1.0_dbl_kind
        iter=0

!-----------------------------------------------------------------------
! find the intersection of x_line and the plane P via bisection search
!-----------------------------------------------------------------------
        do while (abs(resid).gt.1.0e-18_dbl_kind)
          iter=iter+1
          if(iter.eq.1000) then
               write(6,*) ' stop in find_a_point_in_a_plane'
               write(6,*) ' bisection algorithm not converging'
               stop
          endif
          factor =  (factor_l+factor_u)/2.0
          resid = factor*( x_perp(1)*x_line(1) +      &
                           x_perp(2)*x_line(2) +      &
                           x_perp(3)*x_line(3)) + d
          if(resid.gt.0.0)then
           factor_u=factor
          else
           factor_l=factor
          endif
        enddo
        xout = factor * x_line

	end subroutine find_a_point_in_a_plane 
!======================================================================
! START OF FIND_A_POINT_IN_A_PLANE
!======================================================================


	end module geodesic_grid_utilities

!||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
