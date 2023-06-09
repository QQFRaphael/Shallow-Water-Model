!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

      module kinds

!-----------------------------------------------------------------------
!     
!     Purpose:		
!     This module defines variable precision for all common data types.
!
!     variables should be defined in the following manner
!     
!     real (kind = dbl_kind)	      float default size
!     integer (kind = int_kind)       integer default size
!     logical (kind = log_kind)       default logical size
!     real (kind = real_kind)	      always real*4
!     character(char_len)	      character length
!
!     Author: Atul Nulkar
!     Modified original code on 03/16/2002 to conform to CCM4 standard
!
!-----------------------------------------------------------------------

      implicit none
      save

      integer, parameter :: char_len     = 128,                     &
                            int_kind     = kind(1),                 &
                            int_dbl_kind = selected_int_kind(16),   &
                            long_kind    = selected_int_kind(16),   &
                            log_kind     = kind(.true.),            &
                            real_kind    = selected_real_kind(6),   &
                            dbl_kind     = selected_real_kind(13)

      end module kinds

!|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
