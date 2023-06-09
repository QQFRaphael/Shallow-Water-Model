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

ESMF_F90COMPILER=ifort
ESMF_F90LINKER=ifort

ESMF_F90COMPILEOPTS=-O -m64 -threads
ESMF_F90COMPILEPATHS=-I/Users/dazlich/esmf_build/esmf/mod/modO/Darwin.intelgcc.64.mpiuni.default -I/Users/dazlich/esmf_build/esmf/src/include
ESMF_F90COMPILECPPFLAGS= -DS64=1 -DESMF_OS_Darwin=1 -DESMF_MPIUNI

ESMF_F90LINKOPTS= -m64 -threads
ESMF_F90LINKPATHS=-L/Users/dazlich/esmf_build/esmf/lib/libO/Darwin.intelgcc.64.mpiuni.default -L/usr/lib/gcc/i686-apple-darwin9/4.0.1/
ESMF_F90LINKRPATHS=
ESMF_F90LINKLIBS= -lstdc++ -lgcc_eh -lm 
ESMF_F90ESMFLINKLIBS=-lesmf  -lstdc++ -lgcc_eh -lm 

ESMF_CXXCOMPILER=g++
ESMF_CXXLINKER=g++

ESMF_CXXCOMPILEOPTS=-m64 -O -DNDEBUG -m64
ESMF_CXXCOMPILEPATHS=-I/Users/dazlich/esmf_build/esmf/src/include -I/Users/dazlich/esmf_build/esmf/src/Infrastructure/stubs/mpiuni
ESMF_CXXCOMPILECPPFLAGS=-DS64=1 -DESMF_OS_Darwin=1 -D__SDIR__='' -DESMF_MPIUNI

ESMF_CXXLINKOPTS=
ESMF_CXXLINKPATHS=-L/Users/dazlich/esmf_build/esmf/lib/libO/Darwin.intelgcc.64.mpiuni.default -L/opt/intel/fce/10.1.017/lib/
ESMF_CXXLINKRPATHS=
ESMF_CXXLINKLIBS= -lifcoremt -lunwind -lipr
ESMF_CXXESMFLINKLIBS=-lesmf  -lifcoremt -lunwind -lipr

#
# !!! The following options were used on this ESMF build !!!
#
# ESMF_DIR: /Users/dazlich/esmf_build/esmf
# ESMF_OS: Darwin
# ESMF_MACHINE: x86_64
# ESMF_ABI: 64
# ESMF_COMPILER: intelgcc
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
