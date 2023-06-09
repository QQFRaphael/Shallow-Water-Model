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

ESMF_F90COMPILER=pgf90
ESMF_F90LINKER=pgf90

ESMF_F90COMPILEOPTS=-O
ESMF_F90COMPILEPATHS=-I/Users/dazlich/doe_ca/esmf/mod/modO/Linux.pgigcc.64.mpiuni.default -I/Users/dazlich/doe_ca/esmf/src/include
ESMF_F90COMPILECPPFLAGS= -DS64=1 -DESMF_OS_Linux=1 -DESMF_MPIUNI

ESMF_F90LINKOPTS=
ESMF_F90LINKPATHS=-L/Users/dazlich/doe_ca/esmf/lib/libO/Linux.pgigcc.64.mpiuni.default -L/usr/lib/gcc/x86_64-redhat-linux/4.1.2/
ESMF_F90LINKRPATHS=-Wl,-rpath,/Users/dazlich/doe_ca/esmf/lib/libO/Linux.pgigcc.64.mpiuni.default
ESMF_F90LINKLIBS= -lstdc++ -lrt -lC -lc
ESMF_F90ESMFLINKLIBS=-lesmf  -lstdc++ -lrt -lC -lc

ESMF_CXXCOMPILER=g++
ESMF_CXXLINKER=g++

ESMF_CXXCOMPILEOPTS=-O -DNDEBUG
ESMF_CXXCOMPILEPATHS=-I/Users/dazlich/doe_ca/esmf/src/include -I/Users/dazlich/doe_ca/esmf/src/Infrastructure/stubs/mpiuni
ESMF_CXXCOMPILECPPFLAGS=-DS64=1 -DESMF_OS_Linux=1 -D__SDIR__='' -DESMF_MPIUNI

ESMF_CXXLINKOPTS=
ESMF_CXXLINKPATHS=-L/Users/dazlich/doe_ca/esmf/lib/libO/Linux.pgigcc.64.mpiuni.default -L/usr/local/pgi/linux86-64/12.8/lib
ESMF_CXXLINKRPATHS=-Wl,-rpath,/Users/dazlich/doe_ca/esmf/lib/libO/Linux.pgigcc.64.mpiuni.default -Wl,-rpath,/usr/local/pgi/linux86-64/12.8/lib
ESMF_CXXLINKLIBS= -lrt           -lpgmp   -lnuma   -lpthread  -lpgf90 -lpgf90_rpm1 -lpgf902 -lpgf90rtl -lpgftnrtl  -lnspgc -lpgc  -lrt -lpthread  -lm -lgcc -lc -lgcc
ESMF_CXXESMFLINKLIBS=-lesmf  -lrt           -lpgmp   -lnuma   -lpthread  -lpgf90 -lpgf90_rpm1 -lpgf902 -lpgf90rtl -lpgftnrtl  -lnspgc -lpgc  -lrt -lpthread  -lm -lgcc -lc -lgcc

#
# !!! The following options were used on this ESMF build !!!
#
# ESMF_DIR: /Users/dazlich/doe_ca/esmf
# ESMF_OS: Linux
# ESMF_MACHINE: x86_64
# ESMF_ABI: 64
# ESMF_COMPILER: pgigcc
# ESMF_BOPT: O
# ESMF_COMM: mpiuni
# ESMF_SITE: default
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
