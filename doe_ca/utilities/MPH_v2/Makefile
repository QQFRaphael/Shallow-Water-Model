SYSTEM=$(shell uname -s)

##################
# for IBM

ifeq ($(SYSTEM),AIX)
   F90 = mpxlf90_r 
   CPPOPTS = -WF,-DMPH,-DAIX

   LD = mpxlf90_r
   LFLAGS =
   #LIBS = -lmpi
   LIBS = 
   CFOPTS =
   FFLAGS = -qfixed -qarch=pwr3 -O3 -qstrict
endif

##################
# for CRAY T3E
# for CRAY machines, the "uname" command returns "sn6711" (which is the machine
# serial number) instead of "CRAY" or "T3E" or "SV1", etc.

ifeq ($(SYSTEM),sn6711)
#ifeq ($(SYSTEM),CRAY)
   F90 = f90
   CPPOPTS = -DMPH -Dsn6711
   LD = f90
   CFOPTS =
   FFLAGS = -O3
endif

##################
# for SGI
ifeq ($(SYSTEM),IRIX64)
   F90 = f90
   CPPOPTS = -DMPH -DIRIX64
   LD = f90
   LFLAGS = 
   LIBS = -lmpi
   FFLAGS = -r8const -r8 -i4 -O2 -r10000 -n32 -I/usr/local/include -I$(MPT_SGI)/usr/include
endif

##################
# for Compaq
ifeq ($(SYSTEM),OSF1)
   F90 = f90
   CPPOPTS = -DMPH -DOSF1
   LD = f90
   LFLAGS =
   LIBS = -lmpi -lelan -lelan3
   CFOPTS =
   FFLAGS = -O4 -fast -arch ev6 -real_size 64 -fpe1 -convert big_endian 
endif

########################
# for test1
SRC1 = mph.F test1/ice_land.F test1/cpl.F test1/pop_atm.F

.F.o:
	$(F90) $(CPPOPTS) $(FFLAGS) -c $(CFOPTS) $<

test1:	test1/ice_land test1/cpl test1/pop_atm

test1/ice_land: mph.o test1/ice_land.o
	$(LD) $(LFLAGS) -o test1/ice_land mph.o ice_land.o $(LIBS)

test1/cpl:mph.o test1/cpl.o
	$(LD) $(LFLAGS) -o test1/cpl mph.o cpl.o $(LIBS)

test1/pop_atm: mph.o test1/pop_atm.o
	$(LD) $(LFLAGS) -o test1/pop_atm mph.o pop_atm.o $(LIBS)

##################
# for test2

SRC2 = mph.F test2/ice_land.F test2/cpl.F

test2:  test2/ice_land test2/cpl

test2/ice_land: mph.o test2/ice_land.o
	$(LD) $(LFLAGS) -o test2/ice_land mph.o ice_land.o $(LIBS)

test2/cpl:mph.o test2/cpl.o
	$(LD) $(LFLAGS) -o test2/cpl mph.o cpl.o $(LIBS)

###############
# for test3

SRC3 = mph.F test3/main.F

test3:  test3/main

test3/main: mph.o test3/main.o
	$(LD) $(LFLAGS) -o test3/main mph.o main.o $(LIBS)

###############

miniclean: rm *.o *.mod 

clean:
	rm *.o *.mod test1/ice_land test1/cpl test1/pop_atm  \
        test2/ice_land test2/cpl test3/main
