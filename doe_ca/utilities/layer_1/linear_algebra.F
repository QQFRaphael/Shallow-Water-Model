
      module linear_algebra 

      use kinds

      contains

      subroutine dgtsl(n,c,d,e,b,info)
      integer n,info
      real (kind=dbl_kind) :: c(n),d(n),e(n),b(n)
 
!     dgtsl given a general tridiagonal matrix and a right hand
!     side will find the solution.
!
!     on entry
!
!        n       integer
!                is the order of the tridiagonal matrix.
!
!        c       double precision(n)
!                is the subdiagonal of the tridiagonal matrix.
!                c(2) through c(n) should contain the subdiagonal.
!                on output c is destroyed.
!
!        d       double precision(n)
!                is the diagonal of the tridiagonal matrix.
!                on output d is destroyed.
!
!        e       double precision(n)
!                is the superdiagonal of the tridiagonal matrix.
!                e(1) through e(n-1) should contain the superdiagonal.
!                on output e is destroyed.
!
!        b       double precision(n)
!                is the right hand side vector.
!
!     on return
!
!        b       is the solution vector.
!
!        info    integer
!                = 0 normal value.
!                = k if the k-th element of the diagonal becomes
!                    exactly zero.  the subroutine returns when
!                    this is detected.
!
!     linpack. this version dated 08/14/78 .
!     jack dongarra, argonne national laboratory.
!
!     no externals
!     fortran dabs
!
!     internal variables
!
      integer (kind=int_kind) :: k,kb,kp1,nm1,nm2
      real (kind=dbl_kind) :: t
!     begin block permitting ...exits to 100
!
         info = 0
         c(1) = d(1)
         nm1 = n - 1
         if (nm1 .lt. 1) go to 40
            d(1) = e(1)
            e(1) = 0.0d0
            e(n) = 0.0d0
!
            do 30 k = 1, nm1
               kp1 = k + 1
!
!              find the largest of the two rows
!
!              if (dabs(c(kp1)) .lt. dabs(c(k))) go to 10
               if (abs(c(kp1)) .lt. abs(c(k))) go to 10
!
!                 interchange row
!
                  t = c(kp1)
                  c(kp1) = c(k)
                  c(k) = t
                  t = d(kp1)
                  d(kp1) = d(k)
                  d(k) = t
                  t = e(kp1)
                  e(kp1) = e(k)
                  e(k) = t
                  t = b(kp1)
                  b(kp1) = b(k)
                  b(k) = t
   10          continue
!
!              zero elements
!
               if (c(k) .ne. 0.0d0) go to 20
                  info = k
!     ............exit
                  go to 100
   20          continue
               t = -c(kp1)/c(k)
               c(kp1) = d(kp1) + t*d(k)
               d(kp1) = e(kp1) + t*e(k)
               e(kp1) = 0.0d0
               b(kp1) = b(kp1) + t*b(k)
   30       continue
   40    continue
         if (c(n) .ne. 0.0d0) go to 50
            info = n
         go to 90
   50    continue
!
!           back solve
!
            nm2 = n - 2
            b(n) = b(n)/c(n)
            if (n .eq. 1) go to 80
               b(nm1) = (b(nm1) - d(nm1)*b(n))/c(nm1)
               if (nm2 .lt. 1) go to 70
               do 60 kb = 1, nm2
                  k = nm2 - kb + 1
                  b(k) = (b(k) - d(k)*b(k+1) - e(k)*b(k+2))/c(k)
   60          continue
   70          continue
   80       continue
   90    continue
  100 continue
 
      end subroutine dgtsl

      end module linear_algebra
