   MODULE params_grid_horizontal_xxx
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  Purpose:
!
!     This module specifies parameters related to the horizontal grid
!     of the model and the horizontal decomposition into subdomains.
!
!  Define:
!
!    max_level -> resolution of the grid.  this parameter coupled with
!                 l_grid_even control the global horizontal grid resoultion.
!                 
!    EVEN GRIDS                       |  ODD GRIDS
!                number   resolution  |              number   resolution
!    max_level  of cells   (degrees)  |  max_level  of cells   (degrees)
!    ---------------------------------|---------------------------------
!        4          2562   4.5        |      4          5762   3.0      
!        5         10242   2.25       |      5         23042   1.5
!        6         40962   1.125      |      6         92162   0.75
!        7        163842   0.5625     |      7        368642   0.375
!        8        655362   0.28125    |      8       1474562   0.1875
!        9       2621442   0.140625   |      9       5898242   0.09375
!       10      10485762   0.0703125  |     10      23592962   0.046875
!
!     l_grid_even     -> a logical to toggle between even and odd grids
!
!     even_odd_factor -> used to compute im and jm.   set as follows:
!                        
!                         l_grid_even = .TRUE.  <=>  even_odd_factor = 2
!                         l_grid_even = .FALSE. <=>  even_odd_factor = 3
!
!     max_ig          -> the number of cells.  (see table above.)
!
!     npad            -> the number of "ghost" rows and columns needed 
!                        for the finite-difference operators.
!
!     im, jm         -> the extent of global arrays in the i-direction
!                        and j-direction, respectively
!
!     partition_factor  -> determines the global number of subdomain blocks.
!                          the user will change this number to set the
!                          global number of subdomain blocks.
!
!                                               global number    iim and jjm
!                                               of subdomains      for the
!                          partition_factor     (=sbdmn_max)   40962 cell grid
!                          ---------------------------------------------------
!                                  1                  10             66
!                                  2                  40             34
!                                  3                 160             18
!                                  4                 640             10
!                                  5                2560              6
!                                  6               10240              4
!
!     isdm,jsdm         -> number of subdomain blocks on a panel in the
!                          i-direction and j-direction, respectively
!
!     sbdmn_max         -> the number of subdomains blocks which comprise
!                          the global grid.
!
!     nsdm              -> the number of subdomains blocks assigned
!                          to each process in the parallel model
!     iim,jjm         -> the extent of each subdomain block in the 
!                         i-direction and j-direction, respectively
!
!     nspace          -> the number of dimensions spanned by a 2D vector
!     ncorners        -> the number of  corners  owned by each grid cell
!     ndata           -> the number cells which define a cell corner, 
!                        and the number of walls owned by each grid cell
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   USE kinds
   USE abort
   USE params_parallel_xxx

   IMPLICIT NONE
   SAVE
   PRIVATE

#ifdef resolution0000001    ! this is the single-column model
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      max_level =  1
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      even_odd_factor = 2
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      partition_factor=1
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      npad = 0

   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      max_ig = 1

   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      im = 1,                                                                &
      im5= 1,                                                                &
      jm = 1,                                                                &
      iim = 1,                                                               &
      jjm = 1,                                                               &
      isdm = 1,                                                              &
      jsdm = 1,                                                              &
      sbdmn_max = 1,                                                         &
      nsdm = 1
     

#else

! here, the preprocessor sets the resolution of the geodesic grid.
#ifdef resolution0000042
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      max_level =  1
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      even_odd_factor = 2
#endif

#ifdef resolution0000092
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      max_level =  1
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      even_odd_factor = 3
#endif

#ifdef resolution0000162
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      max_level =  2
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      even_odd_factor = 2
#endif

#ifdef resolution0000362
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      max_level =  2
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      even_odd_factor = 3
#endif

#ifdef resolution0000642
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      max_level =  3
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      even_odd_factor = 2
#endif

#ifdef resolution0001442
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      max_level =  3
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      even_odd_factor = 3
#endif

#ifdef resolution0002562
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      max_level =  4
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      even_odd_factor = 2
#endif

#ifdef resolution0005762
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      max_level =  4
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      even_odd_factor = 3
#endif

#ifdef resolution0010242
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      max_level =  5
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      even_odd_factor = 2
#endif

#ifdef resolution0023042
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      max_level =  5
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      even_odd_factor = 3
#endif

#ifdef resolution0040962
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      max_level =  6
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      even_odd_factor = 2
#endif

#ifdef resolution0092162
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      max_level =  6
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      even_odd_factor = 3
#endif

#ifdef resolution0163842
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      max_level =  7
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      even_odd_factor = 2
#endif

#ifdef resolution0368642
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      max_level =  7
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      even_odd_factor = 3
#endif

#ifdef resolution0655362
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      max_level =  8
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      even_odd_factor = 2
#endif

#ifdef resolution1474562
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      max_level =  8
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      even_odd_factor = 3
#endif

#ifdef resolution2621442
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      max_level =  9
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      even_odd_factor = 2
#endif

#ifdef resolution5898242
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      max_level =  9
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      even_odd_factor = 3
#endif

#ifdef resolution10485762
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      max_level =  10
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      even_odd_factor = 2
#endif

#ifdef resolution23592962
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      max_level =  10
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      even_odd_factor = 3
#endif

! here, the preprocessor sets the number of subdomains in the decomposition.
#ifdef numsbdmns00010
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      partition_factor=1
#endif

#ifdef numsbdmns00040
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      partition_factor=2
#endif

#ifdef numsbdmns00160
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      partition_factor=3
#endif

#ifdef numsbdmns00640
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      partition_factor=4
#endif

#ifdef numsbdmns02560
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      partition_factor=5
#endif

#ifdef numsbdmns10240
   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      partition_factor=6
#endif

   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      npad = 1

   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      max_ig = 2 + 10*((even_odd_factor*2**(max_level-1))**2)

   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      im = 5*(2*npad + 2*even_odd_factor*2**(max_level-1)),                  &
      im5 =im/5,                                                             &
      jm =   (2*npad +   even_odd_factor*2**(max_level-1)) 

   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      iim  =  2*npad +   even_odd_factor*2**(max_level-partition_factor),    &
      jjm  =  2*npad +   even_odd_factor*2**(max_level-partition_factor)

   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      isdm = 2*2**(partition_factor-1),                                      &
      jsdm =   2**(partition_factor-1)

   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      sbdmn_max = 5*isdm*jsdm ! the number of subdomains blocks which comprise
                              ! the global grid.

   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      nsdm = sbdmn_max/npe    ! the number of subdomains blocks assigned

#endif

   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      iimjjm = iim*jjm

   LOGICAL (KIND=log_kind),PARAMETER, PUBLIC ::                              &
      l_grid_even = even_odd_factor == 2 
   !    l_grid_even = .TRUE.  <=>  even_odd_factor = 2   
   !    l_grid_even = .FALSE. <=>  even_odd_factor = 3

   INTEGER (KIND=int_kind),PARAMETER, PUBLIC ::                              &
      nspace   = 2, &!  number of dimensions spanned by a 2D vector
      ncorners = 2, &!  number of  corners  owned by each grid cell
      nedges   = 3, &!  number of  edges    owned by each grid cell
      ndata    = 3, &!  the number cells which define a corner and the
                     !  number of    walls  owned by each grid cell
      max_ig_corners = 2*(max_ig-2)    ! number of real corner

! public member functions
   PUBLIC ::                                                                 &
      initialize_params_horizontal_xxx

   CONTAINS
!=======================================================================
!  BEGIN initialize_params_horizontal
!=======================================================================
   SUBROUTINE initialize_params_horizontal_xxx ()

   IF (partition_factor > max_level) THEN
      PRINT *,' partition_factor must be less than or equal to max_level '
      CALL abort_code ("params_horizontal:initialize_params_horizontal")
   ENDIF

   IF (MOD (sbdmn_max,npe) /= 0) THEN
      PRINT *,' the global number of subdomains (sbdmn_max = ',sbdmn_max,')'
      PRINT *,' is not evenly divisible by the number of processes',         &
              ' (npe = ',npe,')'
      CALL abort_code ("params_horizontal:initialize_params_horizontal")
   ENDIF

   END SUBROUTINE initialize_params_horizontal_xxx
!=======================================================================
!  END   initialize_params_horizontal
!=======================================================================

   END MODULE params_grid_horizontal_xxx
!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc

