! compile with  
! f90 -o ~/bin/qpcat -I /usr/local/include qpcat.f -L/usr/local/lib -lnetcdf
 
      module qp_concat

      implicit none

      include "netcdf.inc"

      contains

      subroutine qpconcat(label, dimtype, comptype)

      integer status, ncidin, ncidout, unlimdimid, ngatts, n, k, l, i,
     *        ndims, nvars, atttype, attlen, max_ig, max_ig_loc,
     *        dimlen, dimid, vartype, vardims, varnatts,
     *        vardimids(nf_max_var_dims), offsetdim(2), unlimdimidout
      integer, allocatable, dimension(:) :: dimlenin, dimlenout,
     *                                      varidout, dimoffset,
     *                                      interp_indx

      real*4, allocatable, dimension(:) :: float_1din, float_1dout
     *,                                   float_1dsort
      real*4, allocatable, dimension(:,:) :: float_2din, float_2dout
     *,                                   float_2dsort
      real*4, allocatable, dimension(:,:,:) :: float_3din, float_3dout
     *,                                   float_3dsort
      integer*4, allocatable, dimension(:) :: int_1din, int_1dout
     *,                                   int_1dsort
      real*8, allocatable, dimension(:) :: double_1din, double_1dout
     *,                                   double_1dsort
      real*8, allocatable, dimension(:,:) :: double_2din, double_2dout
     *,                                   double_2dsort
      character (len=1), allocatable, dimension(:,:) :: char_2din,
     *						        char_2dout

      character*20, intent(in) :: label
      character(*), intent(in) :: comptype
      character*1, intent(in) :: dimtype
      character*4 proc
      character*16 attname, dimname, varname
      character*1, allocatable, dimension(:) :: gatt
      integer igatt


! first do the atm 2d file

! open the first input file
      status = nf_open(
     *    trim(comptype)//"_"//trim(label)//"p000.g"//dimtype//".nc", 
     *                 nf_nowrite, ncidin)
! create the output file
      status = nf_create(
     *    trim(comptype)//"_"//trim(label)//".g"//dimtype//".nc",
     *    OR(nf_clobber,nf_64bit_offset), ncidout)
! inquire about the input data set
      status = nf_inq_ndims( ncidin, ndims)
      status = nf_inq_nvars( ncidin, nvars)
      status = nf_inq_natts( ncidin, ngatts)
      status = nf_inq_unlimdim( ncidin, unlimdimid)
      allocate(dimlenin(ndims))
      allocate(dimlenout(ndims))
      allocate(dimoffset(ndims))

      status = nf_redef(ncidout)
! get the global attributes and write them to the output
      do n = 1,ngatts
        status = nf_inq_attname(ncidin, nf_global, n, attname )
        status = nf_inq_atttype(ncidin, nf_global, attname, atttype )
        status = nf_inq_attlen(ncidin, nf_global, attname, attlen )
        status = nf_copy_att(ncidin, nf_global, attname, ncidout,
     *                       nf_global)
        if(trim(attname) == 'total_grid_size') then
          status = nf_get_att_int(ncidin, nf_global, attname, max_ig )
        endif
      enddo


! get the dimensions and write them to output
      l = 0
      do n = 1,ndims
         status = nf_inq_dim(ncidin, n, dimname, dimlen)
         dimlenin(n) = dimlen
         dimlenout(n) = dimlen
         if(n.eq.unlimdimid) then
           status = nf_def_dim(ncidout, dimname, NF_UNLIMITED,
     *                         unlimdimidout )
         else if(trim(dimname).eq.'grid_cells') then
           max_ig_loc = dimlen
           status = nf_def_dim(ncidout, dimname, max_ig, dimid )
           dimlenout(n) = max_ig
           l = l + 1
           offsetdim(l) = n
         else if(trim(dimname).eq.'grid_size')then
           status = nf_def_dim(ncidout, dimname, max_ig, dimid )
           dimlenout(n) = max_ig
           l = l + 1
           offsetdim(l) = n
         else
           status = nf_def_dim(ncidout, dimname, dimlen, dimid )
         endif
      enddo

      allocate(varidout(nvars))
! get the variables  and put the attributes to output
      do n = 1,nvars
         status = nf_inq_var(ncidin, n, varname, vartype, vardims,
     *		             vardimids, varnatts )

         status = nf_def_var(ncidout, varname, vartype, vardims,
     *                       vardimids, varidout(n))
         do k = 1,varnatts
            status = nf_inq_attname(ncidin, n, k, attname)
            status = nf_copy_att(ncidin, n, attname, ncidout,
     *                           varidout(n))
         enddo
      enddo

!   close the input file
      status = nf_close(ncidin)
      status = nf_enddef(ncidout)

!  now get the variable data and concatenate over the horizontal dimension
!     and write it out.

!  first find interp_indx so we can sort
         k = 0
         dimoffset = 0
!     open the first file
         write(unit=proc,fmt='(i4)') 1000 + k
         proc(1:1) = 'p'
         status = 
     *      nf_open(
     *    trim(comptype)//"_"//trim(label)//proc//".g"//dimtype//".nc", 
     *                 nf_nowrite, ncidin)
         do n = 1,nvars  ! loop over the variables

            do l = 1,ndims
               status = nf_inq_dimlen(ncidin, l, dimlen)
               dimlenin(l) = dimlen
            enddo
            status = nf_inq_var(ncidin, n, varname, vartype, vardims,
     *                          vardimids, varnatts )
            if(trim(varname).ne.'interp_indx') then
               cycle  ! next iteration of variable loop
            else
               allocate(interp_indx(dimlenout(vardimids(1))))
               allocate(int_1din(dimlenin(vardimids(1))))
               status = nf_get_var_int(ncidin, n, int_1din )
               interp_indx(1+dimoffset(vardimids(1)):
     *                 dimlenin(vardimids(1))+dimoffset(vardimids(1))) 
     *              =  int_1din(1:dimlenin(vardimids(1)))
               deallocate(int_1din)
               status = nf_close(ncidin)
!   now open the rest of the files
               do l = 1,ndims
                  if(l.eq.offsetdim(1)) dimoffset(l) =   dimlenin(l)
                  if(l.eq.offsetdim(2)) dimoffset(l) =   dimlenin(l)
               enddo
               k = 1
               do   ! loop over the processors
                  write(unit=proc,fmt='(i4)') 1000 + k
                  proc(1:1) = 'p'
                  status = 
     *       nf_open(
     *   trim(comptype)//"_"//trim(label)//proc//".g"//dimtype//".nc", 
     *               nf_nowrite, ncidin)
                  if(status.ne.nf_noerr) exit ! exit the processors loop
                  do l = 1,ndims
                     status = nf_inq_dimlen(ncidin, l, dimlen)
                     dimlenin(l) = dimlen
                  enddo
                  allocate(int_1din(dimlenin(vardimids(1))))
                  status = nf_get_var_int(ncidin, n, int_1din )
                  interp_indx(1+dimoffset(vardimids(1)):
     *                  dimlenin(vardimids(1))+dimoffset(vardimids(1))) 
     *                  =  int_1din(1:dimlenin(vardimids(1)))
                  deallocate(int_1din)
                  do l = 1,ndims
                     if(l.eq.offsetdim(1)) dimoffset(l) = 
     *                            dimoffset(l) + dimlenin(l)
                     if(l.eq.offsetdim(2)) dimoffset(l) = 
     *                            dimoffset(l) + dimlenin(l)
                  enddo
                  k = k + 1
                  status = nf_close(ncidin)
               enddo   ! loop over the processors
               exit  ! exit the loop over variables
            endif
         enddo  ! loop over variables

! now read, concatenate and sort other variables
      do n = 1,nvars
         k = 0
         dimoffset = 0
         do   ! loop over the processors
            write(unit=proc,fmt='(i4)') 1000 + k
            proc(1:1) = 'p'
            status = 
     *         nf_open(
     * trim(comptype)//"_"//trim(label)//proc//".g"//dimtype//".nc", 
     *                 nf_nowrite, ncidin)
            if(status.ne.nf_noerr) exit 

            do l = 1,ndims
               status = nf_inq_dimlen(ncidin, l, dimlen)
               dimlenin(l) = dimlen
            enddo
            status = nf_inq_var(ncidin, n, varname, vartype, vardims,
     *		                vardimids, varnatts )
            if(vartype.eq.nf_char) then
               if(vardims.eq.2) then
                 if(k.eq.0)allocate(char_2dout(dimlenout(vardimids(1)),
     *                                        dimlenout(vardimids(2))))
                 allocate(char_2din(dimlenin(vardimids(1)),
     *                              dimlenin(vardimids(2))))
                 status = nf_get_var_text(ncidin, n, char_2din )
                 char_2dout(1+dimoffset(vardimids(1)):
     *                 dimlenin(vardimids(1))+dimoffset(vardimids(1)),
     *                 1+dimoffset(vardimids(2)):
     *                 dimlenin(vardimids(2))+dimoffset(vardimids(2))) 
     *             =  char_2din(1:dimlenin(vardimids(1)),
     *                          1:dimlenin(vardimids(2)))
                 deallocate(char_2din)
               else
                  print *,'char variable of this dimension'
                  print *,'  not accounted for'
                  stop
               endif
            else if(vartype.eq.nf_int) then
               if(vardims.eq.1) then
                 if(k.eq.0)allocate(int_1dout(dimlenout(vardimids(1))))
                 allocate(int_1din(dimlenin(vardimids(1))))
                 status = nf_get_var_int(ncidin, n, int_1din )
                 int_1dout(1+dimoffset(vardimids(1)):
     *                 dimlenin(vardimids(1))+dimoffset(vardimids(1))) 
     *             =  int_1din(1:dimlenin(vardimids(1)))
                 deallocate(int_1din)
               else
                  print *,'int variable of this dimension'
                  print *,'  not accounted for'
                  stop
               endif
            else if(vartype.eq.nf_float) then
               if(vardims.eq.1) then
                 if(k.eq.0)
     *               allocate(float_1dout(dimlenout(vardimids(1))))
                 allocate(float_1din(dimlenin(vardimids(1))))
                 status = nf_get_var_real(ncidin, n, float_1din )
                 float_1dout(1+dimoffset(vardimids(1)):
     *                 dimlenin(vardimids(1))+dimoffset(vardimids(1))) 
     *             =  float_1din(1:dimlenin(vardimids(1)))
                 deallocate(float_1din)
               elseif(vardims.eq.2) then
                 if(k.eq.0)allocate(float_2dout(dimlenout(vardimids(1)),
     *                                        dimlenout(vardimids(2))))
                 allocate(float_2din(dimlenin(vardimids(1)),
     *                              dimlenin(vardimids(2))))
                 status = nf_get_var_real(ncidin, n, float_2din )
                 float_2dout(1+dimoffset(vardimids(1)):
     *                 dimlenin(vardimids(1))+dimoffset(vardimids(1)),
     *                 1+dimoffset(vardimids(2)):
     *                 dimlenin(vardimids(2))+dimoffset(vardimids(2))) 
     *             =  float_2din(1:dimlenin(vardimids(1)),
     *                          1:dimlenin(vardimids(2)))
                 deallocate(float_2din)
               elseif(vardims.eq.3) then
                 if(k.eq.0)allocate(float_3dout(dimlenout(vardimids(1)),
     *                                        dimlenout(vardimids(2)),
     *                                        dimlenout(vardimids(3))))
                 allocate(float_3din(dimlenin(vardimids(1)),
     *                              dimlenin(vardimids(2)),
     *                              dimlenin(vardimids(3))))
                 status = nf_get_var_real(ncidin, n, float_3din )
                 float_3dout(1+dimoffset(vardimids(1)):
     *                 dimlenin(vardimids(1))+dimoffset(vardimids(1)),
     *                 1+dimoffset(vardimids(2)):
     *                 dimlenin(vardimids(2))+dimoffset(vardimids(2)), 
     *                 1+dimoffset(vardimids(3)):
     *                 dimlenin(vardimids(3))+dimoffset(vardimids(3))) 
     *             =  float_3din(1:dimlenin(vardimids(1)),
     *                          1:dimlenin(vardimids(2)),
     *                          1:dimlenin(vardimids(3)))
                 deallocate(float_3din)
               else
                  print *,'float variable of this dimension'
                  print *,'  not accounted for'
                  stop
               endif
            else if(vartype.eq.nf_double) then
               if(vardims.eq.1) then
                 if(k.eq.0)
     *                  allocate(double_1dout(dimlenout(vardimids(1))))
                 allocate(double_1din(dimlenin(vardimids(1))))
                 status = nf_get_var_double(ncidin, n, double_1din )
                 double_1dout(1+dimoffset(vardimids(1)):
     *                 dimlenin(vardimids(1))+dimoffset(vardimids(1))) 
     *             =  double_1din(1:dimlenin(vardimids(1)))
                 deallocate(double_1din)
               elseif(vardims.eq.2) then
                 if(k.eq.0)allocate(double_2dout
     *                                       (dimlenout(vardimids(1)),
     *                                        dimlenout(vardimids(2))))
                 allocate(double_2din(dimlenin(vardimids(1)),
     *                              dimlenin(vardimids(2))))
                 status = nf_get_var_double(ncidin, n, double_2din )
                 double_2dout(1+dimoffset(vardimids(1)):
     *                 dimlenin(vardimids(1))+dimoffset(vardimids(1)),
     *                 1+dimoffset(vardimids(2)):
     *                 dimlenin(vardimids(2))+dimoffset(vardimids(2))) 
     *             =  double_2din(1:dimlenin(vardimids(1)),
     *                          1:dimlenin(vardimids(2)))
                 deallocate(double_2din)
               else
                  print *,'double variable of this dimension'
                  print *,'  not accounted for'
                  stop
               endif
            else
               print *,'variable of this type not accounted for'
               stop
            endif

!  get ready for next input file
            k = k + 1
            do l = 1,ndims
               if(l.eq.offsetdim(1)) dimoffset(l) = 
     *                               dimoffset(l) + dimlenin(l)
               if(l.eq.offsetdim(2)) dimoffset(l) = 
     *                               dimoffset(l) + dimlenin(l)
            enddo
            status = nf_close(ncidin)
         enddo   ! loop over the processors
! sort and output the variable that have a spatial dimension
         if(vartype.eq.nf_char) then
            if(vardims.eq.2) then
               status = nf_put_var_text(ncidout, varidout(n),
     *                                  char_2dout)
               deallocate(char_2dout)
            endif
         else if(vartype.eq.nf_int) then
            if(vardims.eq.1) then
               if(vardimids(1).eq.offsetdim(1).or.
     *              vardimids(1).eq.offsetdim(2)) then
                  allocate(int_1dsort(dimlenout(vardimids(1))))
                  do i = 1,dimlenout(vardimids(1))
                     int_1dsort(interp_indx(i)) = int_1dout(i)
                  enddo
                  status = nf_put_var_int(ncidout, varidout(n),
     *                                    int_1dsort)
                  deallocate(int_1dsort)
                  deallocate(int_1dout)
               else
                  status = nf_put_var_int(ncidout, varidout(n),
     *                                    int_1dout)
                  deallocate(int_1dout)
               endif
            endif
         else if(vartype.eq.nf_float) then
            if(vardims.eq.1) then
               if(vardimids(1).eq.offsetdim(1).or.
     *              vardimids(1).eq.offsetdim(2)) then
                  allocate(float_1dsort(dimlenout(vardimids(1))))
                  do i = 1,dimlenout(vardimids(1))
                     float_1dsort(interp_indx(i)) = float_1dout(i)
                  enddo
                  status = nf_put_var_real(ncidout, varidout(n),
     *                                     float_1dsort)
                  deallocate(float_1dsort)
                  deallocate(float_1dout)
               else
                  status = nf_put_var_real(ncidout, varidout(n),
     *                                     float_1dout)
                  deallocate(float_1dout)
               endif
            elseif(vardims.eq.2) then
               if(vardimids(1).eq.offsetdim(1).or.
     *              vardimids(1).eq.offsetdim(2)) then
                  allocate(float_2dsort(dimlenout(vardimids(1)),
     *                                   dimlenout(vardimids(2))))
                  do i = 1,dimlenout(vardimids(1))
                     float_2dsort(interp_indx(i),:) = float_2dout(i,:)
                  enddo
                  status = nf_put_var_real(ncidout, varidout(n),
     *                                       float_2dsort)
                  deallocate(float_2dsort)
                  deallocate(float_2dout)
               elseif(vardimids(2).eq.offsetdim(1).or.
     *              vardimids(2).eq.offsetdim(2)) then
                  allocate(float_2dsort(dimlenout(vardimids(1)),
     *                                   dimlenout(vardimids(2))))
                  do i = 1,dimlenout(vardimids(2))
                     float_2dsort(:,interp_indx(i)) = float_2dout(:,i)
                  enddo
                  status = nf_put_var_real(ncidout, varidout(n),
     *                                       float_2dsort)
                  deallocate(float_2dsort)
                  deallocate(float_2dout)
               else
                  status = nf_put_var_real(ncidout, varidout(n),
     *                                       float_2dout)
                  deallocate(float_2dout)
               endif
            elseif(vardims.eq.3) then
               if(vardimids(1).eq.offsetdim(1).or.
     *              vardimids(1).eq.offsetdim(2)) then
                  allocate(float_3dsort(dimlenout(vardimids(1)),
     *                                   dimlenout(vardimids(2)),
     *                                   dimlenout(vardimids(3))))
                  do i = 1,dimlenout(vardimids(1))
                   float_3dsort(interp_indx(i),:,:) = float_3dout(i,:,:)
                  enddo
                  status = nf_put_var_real(ncidout, varidout(n),
     *                                       float_3dsort)
                  deallocate(float_3dsort)
                  deallocate(float_3dout)
               elseif(vardimids(2).eq.offsetdim(1).or.
     *              vardimids(2).eq.offsetdim(2)) then
                  allocate(float_3dsort(dimlenout(vardimids(1)),
     *                                   dimlenout(vardimids(2)),
     *                                   dimlenout(vardimids(3))))
                  do i = 1,dimlenout(vardimids(2))
                   float_3dsort(:,interp_indx(i),:) = float_3dout(:,i,:)
                  enddo
                  status = nf_put_var_real(ncidout, varidout(n),
     *                                       float_3dsort)
                  deallocate(float_3dsort)
                  deallocate(float_3dout)
               elseif(vardimids(3).eq.offsetdim(1).or.
     *              vardimids(3).eq.offsetdim(2)) then
                  allocate(float_3dsort(dimlenout(vardimids(1)),
     *                                   dimlenout(vardimids(2)),
     *                                   dimlenout(vardimids(3))))
                  do i = 1,dimlenout(vardimids(3))
                   float_3dsort(:,:,interp_indx(i)) = float_3dout(:,:,i)
                  enddo
                  status = nf_put_var_real(ncidout, varidout(n),
     *                                       float_3dsort)
                  deallocate(float_3dsort)
                  deallocate(float_3dout)
               else
                  status = nf_put_var_real(ncidout, varidout(n),
     *                                       float_3dout)
                  deallocate(float_3dout)
               endif
            endif
         else if(vartype.eq.nf_double) then
            if(vardims.eq.1) then
               if(n.ne.1) then
                  if(vardimids(1).eq.offsetdim(1).or.
     *                 vardimids(1).eq.offsetdim(2)) then
                     allocate(double_1dsort(dimlenout(vardimids(1))))
                     do i = 1,dimlenout(vardimids(1))
                        double_1dsort(interp_indx(i)) = double_1dout(i)
                     enddo
                     status = nf_put_var_double(ncidout, varidout(n),
     *                                          double_1dsort)
                     deallocate(double_1dsort)
                  else
                     status = nf_put_var_double(ncidout, varidout(n),
     *                                          double_1dout)
                  endif
               else
                 do i = 1,dimlenout(vardimids(1))
  	          status = nf_put_var1_double (ncidout, varidout(n), i,
     *		  		    double_1dout(i) )
                 enddo
               endif
               deallocate(double_1dout)
            elseif(vardims.eq.2) then
               if(vardimids(1).eq.offsetdim(1).or.
     *              vardimids(1).eq.offsetdim(2)) then
                  allocate(double_2dsort(dimlenout(vardimids(1)),
     *                                   dimlenout(vardimids(2))))
                  do i = 1,dimlenout(vardimids(1))
                     double_2dsort(interp_indx(i),:) = double_2dout(i,:)
                  enddo
                  status = nf_put_var_double(ncidout, varidout(n),
     *                                       double_2dsort)
                  deallocate(double_2dsort)
                  deallocate(double_2dout)
               elseif(vardimids(2).eq.offsetdim(1).or.
     *              vardimids(2).eq.offsetdim(2)) then
                  allocate(double_2dsort(dimlenout(vardimids(1)),
     *                                   dimlenout(vardimids(2))))
                  do i = 1,dimlenout(vardimids(2))
                     double_2dsort(:,interp_indx(i)) = double_2dout(:,i)
                  enddo
                  status = nf_put_var_double(ncidout, varidout(n),
     *                                       double_2dsort)
                  deallocate(double_2dsort)
                  deallocate(double_2dout)
               else
                  status = nf_put_var_double(ncidout, varidout(n),
     *                                       double_2dout)
                  deallocate(double_2dout)
               endif
            endif
         endif
      enddo   ! loop over the variables

!   close the output file
      status = nf_close(ncidout)

      end subroutine qpconcat

      end module qp_concat

      program main

      use qp_concat

      implicit none

      character*20 label
      character*8 type
      character*1 dim

      print *,'This program will join together into one file '
      print *,'  qp (time average) diagnostic files produced '
      print *,'  by multiple processor runs.'
      print *,''
      print *,'The output file is identical in name, but the  '
      print *,'  4 character process stamp (p***) is removed.'
      print *,''

      print *,'Enter qp file timestamp label '
      print *,'(20 characters, e.g. yyyy-mm-ddThh:mm::ss)'
      read(5,'(a20)') label


      do 

! get the component types and dimension type
         print *,'Enter the model file type (e.g. gatm, gsfc, hocean)'
         print *,' if no more files, hit "enter"'
         read(5,'(a8)')type
         if(trim(type) == '') exit
         print *,'Enter the spatial dimension of the file (2 or 3)'
         read(5,'(a1)')dim

!  arguments are time stamp, dimension type, and component type
         call qpconcat(label, dim, type )
      enddo

      end program main
