   MODULE params_parallel_xxx
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!  PURPOSE :
!     this module contains information about the parallel aspects
!     of a model component, but nothing about a specific
!     message passing library.
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   USE kinds

! variable npe is assigned by the preprocessor
   INTEGER (KIND=int_kind),PARAMETER ::                                      &
      npe =  NPE_COMP       !  the number of processes assigned 
                            !  to the component

   INTEGER (KIND=int_kind) ::                                                &
      my_task = 0    !  an identifier for the local process

   END MODULE params_parallel_xxx
!cccccccc1ccccccccc2ccccccccc3ccccccccc4ccccccccc5cccgtgccc6ccccccccc7cc
