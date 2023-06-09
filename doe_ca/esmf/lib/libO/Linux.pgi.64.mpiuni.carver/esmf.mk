# ESMF application makefile fragment
#
# Use the following ESMF_ variables to compile and link
# your ESMF application against this ESMF build.
#
# !!! VERY IMPORTANT: If the location of this ESMF build is   !!!
# !!! changed, e.g. libesmf.a is copied to another directory, !!!
# !!! this file - esmf.mk - must be edited to adjust to the   !!!
# !!! correct new path                                        !!!
#
# Please see end of file for options used on this ESMF build
#

ESMF_F90COMPILER=mpif90
ESMF_F90LINKER=mpif90

ESMF_F90COMPILEOPTS=-fast
ESMF_F90COMPILEPATHS=-I/global/u2/d/dazlich/cpl40-40/doe_ca/esmf/mod/modO/Linux.pgi.64.mpiuni.carver -I/global/u2/d/dazlich/cpl40-40/doe_ca/esmf/src/include
ESMF_F90COMPILECPPFLAGS= -DSx86_64_small=1 -DESMF_OS_Linux=1 -DESMF_MPIUNI

ESMF_F90LINKOPTS=
ESMF_F90LINKPATHS=-L/global/u2/d/dazlich/cpl40-40/doe_ca/esmf/lib/libO/Linux.pgi.64.mpiuni.carver -L/global/common/carver/usg/pgi/10.8/linux86-64/10.8/lib
ESMF_F90LINKRPATHS=-Wl,-rpath,/global/u2/d/dazlich/cpl40-40/doe_ca/esmf/lib/libO/Linux.pgi.64.mpiuni.carver -Wl,-rpath,/global/common/carver/usg/pgi/10.8/linux86-64/10.8/lib
ESMF_F90LINKLIBS= -lrt -lstd -lC           -lnspgc -lpgc    -lm -lgcc -lc -lgcc
ESMF_F90ESMFLINKLIBS=-lesmf  -lrt -lstd -lC           -lnspgc -lpgc    -lm -lgcc -lc -lgcc

ESMF_CXXCOMPILER=pgCC
ESMF_CXXLINKER=pgCC

ESMF_CXXCOMPILEOPTS=-O -DNDEBUG
ESMF_CXXCOMPILEPATHS=-I/global/u2/d/dazlich/cpl40-40/doe_ca/esmf/src/include -I/global/u2/d/dazlich/cpl40-40/doe_ca/esmf/src/Infrastructure/stubs/mpiuni
ESMF_CXXCOMPILECPPFLAGS=-DSx86_64_small=1 -DESMF_OS_Linux=1 -D__SDIR__='' -DESMF_MPIUNI

ESMF_CXXLINKOPTS=
ESMF_CXXLINKPATHS=-L/global/u2/d/dazlich/cpl40-40/doe_ca/esmf/lib/libO/Linux.pgi.64.mpiuni.carver -L/global/common/carver/usg/pgi/10.8/linux86-64/10.8/lib
ESMF_CXXLINKRPATHS=-Wl,-rpath,/global/u2/d/dazlich/cpl40-40/doe_ca/esmf/lib/libO/Linux.pgi.64.mpiuni.carver -Wl,-rpath,/global/common/carver/usg/pgi/10.8/linux86-64/10.8/lib
ESMF_CXXLINKLIBS= -lrt           -lpgf90 -lpgf90_rpm1 -lpgf902 -lpgf90rtl -lpgftnrtl  -lnspgc -lpgc  -lrt -lpthread  -lm -lgcc -lc -lgcc
ESMF_CXXESMFLINKLIBS=-lesmf  -lrt           -lpgf90 -lpgf90_rpm1 -lpgf902 -lpgf90rtl -lpgftnrtl  -lnspgc -lpgc  -lrt -lpthread  -lm -lgcc -lc -lgcc

#
# !!! The following options were used on this ESMF build !!!
#
# ESMF_DIR: /global/u2/d/dazlich/cpl40-40/doe_ca/esmf
# ESMF_OS: Linux
# ESMF_MACHINE: x86_64
# ESMF_ABI: 64
# ESMF_COMPILER: pgi
# ESMF_BOPT: O
# ESMF_COMM: mpiuni
# ESMF_SITE: carver
# ESMF_PTHREADS: ON
# ESMF_ARRAY_LITE: FALSE
# ESMF_NO_INTEGER_1_BYTE: FALSE
# ESMF_NO_INTEGER_2_BYTE: FALSE
# ESMF_FORTRANSYMBOLS: default
# ESMF_TESTEXHAUSTIVE: OFF
# ESMF_TESTWITHTHREADS: OFF
# ESMF_TESTMPMD: OFF
# 
# ESMF environment variables pointing to 3rd party software:
