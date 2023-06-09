!-----------------------------------------------------------------------
!
	MODULE netcdf_reader
!
!-----------------------------------------------------------------------
! Purpose:
!   This module contains procedures to ease the use of netcdf functions
!  by encapsulating the calls needed to read a variable from a netcdf
!  file within (hopefully) one function call.
!
!  Calls are made using:
!
!     error = nfwrap_getvar (file, var_name, variable)
! 
!   error is a returned error code (currently unused).
!   file is the name of the file to open, 
!   var_name is the name of the variable (as the netcdf file knows it.)
!   variable is the variable the read values will be stored in.
!
! Scope: 
!   Public routines:
!      nfwrap_getvar - interface to all getvar routines
!   Private:
!      everything else
!
! Error return codes: (currently not implemented)
!   1) could not open file
!   2) could not find variable
!   3) problem getting data
!
! Bugs:
!   - Only handles 0-4 dimensional data.
!   - Halts when a netcdf error is encountered.
!     (i.e., the error return code is not used.)
!-----------------------------------------------------------------------

       implicit none
       private

       include 'netcdf.inc'

       integer :: status
       integer :: fileID
       integer :: varID


       INTERFACE nfwrap_getvar
	  MODULE PROCEDURE getvar_0d_real
	  MODULE PROCEDURE getvar_1d_real
	  MODULE PROCEDURE getvar_2d_real
	  MODULE PROCEDURE getvar_3d_real
	  MODULE PROCEDURE getvar_4d_real
	  MODULE PROCEDURE getvar_0d_double
	  MODULE PROCEDURE getvar_1d_double
	  MODULE PROCEDURE getvar_2d_double
	  MODULE PROCEDURE getvar_3d_double
	  MODULE PROCEDURE getvar_4d_double
	  MODULE PROCEDURE getvar_0d_integer
	  MODULE PROCEDURE getvar_1d_integer
	  MODULE PROCEDURE getvar_2d_integer
	  MODULE PROCEDURE getvar_3d_integer
	  MODULE PROCEDURE getvar_4d_integer
       END INTERFACE


       public :: nfwrap_getvar



       CONTAINS

!-----------------------------------------------------------------------
! 
       FUNCTION getvar_0d_real (filename, variable_name, variable)
!
!-----------------------------------------------------------------------

       character(len=*), intent(in) :: filename, variable_name
       real, intent(out) :: variable
       integer :: getvar_0d_real

       getvar_0d_real = 0

       status = nf_open(filename, NF_NOWRITE, fileID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_inq_varid(fileID, variable_name, varID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_get_var_real(fileID, varID, variable) 
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_close(fileID)


       END FUNCTION getvar_0d_real

!-----------------------------------------------------------------------
! 
       FUNCTION getvar_1d_real (filename, variable_name, variable)
!
!-----------------------------------------------------------------------

       character(len=*), intent(in) :: filename, variable_name
       real, dimension(:), intent(out) :: variable
       integer :: getvar_1d_real

       getvar_1d_real = 0

       status = nf_open(filename, NF_NOWRITE, fileID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_inq_varid(fileID, variable_name, varID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_get_var_real(fileID, varID, variable) 
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_close(fileID)


       END FUNCTION getvar_1d_real

!-----------------------------------------------------------------------
! 
       FUNCTION getvar_2d_real (filename, variable_name, variable)
!
!-----------------------------------------------------------------------

       character(len=*), intent(in) :: filename, variable_name
       real, dimension(:,:), intent(out) :: variable
       integer :: getvar_2d_real

       getvar_2d_real = 0

       status = nf_open(filename, NF_NOWRITE, fileID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_inq_varid(fileID, variable_name, varID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_get_var_real(fileID, varID, variable) 
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_close(fileID)


       END FUNCTION getvar_2d_real

!-----------------------------------------------------------------------
!
       FUNCTION getvar_3d_real (filename, variable_name, variable)
!
!-----------------------------------------------------------------------

       character(len=*), intent(in) :: filename, variable_name
       real, dimension(:,:,:), intent(out) :: variable
       integer :: getvar_3d_real

       getvar_3d_real = 0

       status = nf_open(filename, NF_NOWRITE, fileID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_inq_varid(fileID, variable_name, varID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_get_var_real(fileID, varID, variable) 
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_close(fileID)


       END FUNCTION getvar_3d_real

!-----------------------------------------------------------------------
!
       FUNCTION getvar_4d_real (filename, variable_name, variable)
!
!-----------------------------------------------------------------------

       character(len=*), intent(in) :: filename, variable_name
       real, dimension(:,:,:,:), intent(out) :: variable
       integer :: getvar_4d_real

       getvar_4d_real = 0

       status = nf_open(filename, NF_NOWRITE, fileID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_inq_varid(fileID, variable_name, varID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_get_var_real(fileID, varID, variable) 
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_close(fileID)


       END FUNCTION getvar_4d_real




!-----------------------------------------------------------------------
! 
       FUNCTION getvar_0d_double (filename, variable_name, variable)
!
!-----------------------------------------------------------------------

       character(len=*), intent(in) :: filename, variable_name
       real*8, intent(out) :: variable
       integer :: getvar_0d_double

       getvar_0d_double = 0

       status = nf_open(filename, NF_NOWRITE, fileID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_inq_varid(fileID, variable_name, varID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_get_var_double(fileID, varID, variable) 
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_close(fileID)


       END FUNCTION getvar_0d_double

!-----------------------------------------------------------------------
! 
       FUNCTION getvar_1d_double (filename, variable_name, variable)
!
!-----------------------------------------------------------------------

       character(len=*), intent(in) :: filename, variable_name
       real*8, dimension(:), intent(out) :: variable
       integer :: getvar_1d_double

       getvar_1d_double = 0

       status = nf_open(filename, NF_NOWRITE, fileID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_inq_varid(fileID, variable_name, varID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_get_var_double(fileID, varID, variable) 
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_close(fileID)


       END FUNCTION getvar_1d_double

!-----------------------------------------------------------------------
! 
       FUNCTION getvar_2d_double (filename, variable_name, variable)
!
!-----------------------------------------------------------------------

       character(len=*), intent(in) :: filename, variable_name
       real*8, dimension(:,:), intent(out) :: variable
       integer :: getvar_2d_double

       getvar_2d_double = 0

       status = nf_open(filename, NF_NOWRITE, fileID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_inq_varid(fileID, variable_name, varID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_get_var_double(fileID, varID, variable) 
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_close(fileID)


       END FUNCTION getvar_2d_double

!-----------------------------------------------------------------------
!
       FUNCTION getvar_3d_double (filename, variable_name, variable)
!
!-----------------------------------------------------------------------

       character(len=*), intent(in) :: filename, variable_name
       real*8, dimension(:,:,:), intent(out) :: variable
       integer :: getvar_3d_double

       getvar_3d_double = 0

       status = nf_open(filename, NF_NOWRITE, fileID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_inq_varid(fileID, variable_name, varID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_get_var_double(fileID, varID, variable) 
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_close(fileID)


       END FUNCTION getvar_3d_double

!-----------------------------------------------------------------------
!
       FUNCTION getvar_4d_double (filename, variable_name, variable)
!
!-----------------------------------------------------------------------

       character(len=*), intent(in) :: filename, variable_name
       real*8, dimension(:,:,:,:), intent(out) :: variable
       integer :: getvar_4d_double

       getvar_4d_double = 0

       status = nf_open(filename, NF_NOWRITE, fileID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_inq_varid(fileID, variable_name, varID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_get_var_double(fileID, varID, variable) 
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_close(fileID)


       END FUNCTION getvar_4d_double

!-----------------------------------------------------------------------
! 
       FUNCTION getvar_0d_integer (filename, variable_name, variable)
!
!-----------------------------------------------------------------------

       character(len=*), intent(in) :: filename, variable_name
       integer, intent(out) :: variable
       integer :: getvar_0d_integer

       getvar_0d_integer = 0

       status = nf_open(filename, NF_NOWRITE, fileID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_inq_varid(fileID, variable_name, varID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_get_var_int(fileID, varID, variable) 
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_close(fileID)


       END FUNCTION getvar_0d_integer

!-----------------------------------------------------------------------
! 
       FUNCTION getvar_1d_integer (filename, variable_name, variable)
!
!-----------------------------------------------------------------------

       character(len=*), intent(in) :: filename, variable_name
       integer, dimension(:), intent(out) :: variable
       integer :: getvar_1d_integer

       getvar_1d_integer = 0

       status = nf_open(filename, NF_NOWRITE, fileID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_inq_varid(fileID, variable_name, varID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_get_var_int(fileID, varID, variable) 
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_close(fileID)


       END FUNCTION getvar_1d_integer

!-----------------------------------------------------------------------
! 
       FUNCTION getvar_2d_integer (filename, variable_name, variable)
!
!-----------------------------------------------------------------------

       character(len=*), intent(in) :: filename, variable_name
       integer, dimension(:,:), intent(out) :: variable
       integer :: getvar_2d_integer

       getvar_2d_integer = 0

       status = nf_open(filename, NF_NOWRITE, fileID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_inq_varid(fileID, variable_name, varID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_get_var_int(fileID, varID, variable) 
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_close(fileID)


       END FUNCTION getvar_2d_integer

!-----------------------------------------------------------------------
!
       FUNCTION getvar_3d_integer (filename, variable_name, variable)
!
!-----------------------------------------------------------------------

       character(len=*), intent(in) :: filename, variable_name
       integer, dimension(:,:,:), intent(out) :: variable
       integer :: getvar_3d_integer

       getvar_3d_integer = 0

       status = nf_open(filename, NF_NOWRITE, fileID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_inq_varid(fileID, variable_name, varID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_get_var_int(fileID, varID, variable) 
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_close(fileID)


       END FUNCTION getvar_3d_integer

!-----------------------------------------------------------------------
!
       FUNCTION getvar_4d_integer (filename, variable_name, variable)
!
!-----------------------------------------------------------------------

       character(len=*), intent(in) :: filename, variable_name
       integer, dimension(:,:,:,:), intent(out) :: variable
       integer :: getvar_4d_integer

       getvar_4d_integer = 0

       status = nf_open(filename, NF_NOWRITE, fileID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_inq_varid(fileID, variable_name, varID)
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_get_var_int(fileID, varID, variable) 
       if (status /= NF_NOERR) call handle_error(status)

       status = nf_close(fileID)


       END FUNCTION getvar_4d_integer





!-----------------------------------------------------------------------
!
       SUBROUTINE handle_error (ncerr, message)
!
!-----------------------------------------------------------------------
!  Purpose:
!    Deals with netcdf errors.
!    Prints the type of error and halts program execution.
!-----------------------------------------------------------------------

       integer, intent(in) :: ncerr
       character(len=*), intent(in), optional :: message

       if (ncerr /= NF_NOERR) then
	  print *, "NETCDF ERROR: ", nf_strerror(ncerr)
	  if (present(message)) print *, message
	  stop
       endif

       END SUBROUTINE handle_error


       END MODULE netcdf_reader

