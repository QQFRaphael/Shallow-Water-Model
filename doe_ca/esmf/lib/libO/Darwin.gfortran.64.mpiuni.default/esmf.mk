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

ESMF_F90COMPILER=gfortran
ESMF_F90LINKER=gfortran

ESMF_F90COMPILEOPTS=-O -fno-second-underscore -march=k8 -m64 -mcmodel=medium
ESMF_F90COMPILEPATHS=-I/Users/dazlich/gfortran/esmf//mod/modO/Darwin.gfortran.64.mpiuni.default -I/Users/dazlich/gfortran/esmf//src/include
ESMF_F90COMPILECPPFLAGS= -DS64=1 -DESMF_OS_Darwin=1 -DESMF_MPIUNI

ESMF_F90LINKOPTS= -fno-second-underscore -march=k8 -m64 -mcmodel=medium
ESMF_F90LINKPATHS=-L/Users/dazlich/gfortran/esmf//lib/libO/Darwin.gfortran.64.mpiuni.default -L/usr/lib/gcc/i686-apple-darwin10/4.2.1/
ESMF_F90LINKRPATHS=
ESMF_F90LINKLIBS= -lstdc++
ESMF_F90ESMFLINKLIBS=-lesmf  -lstdc++

ESMF_CXXCOMPILER=g++
ESMF_CXXLINKER=g++

ESMF_CXXCOMPILEOPTS=-O -DNDEBUG -DESMF_LOWERCASE_SINGLEUNDERSCORE -march=k8 -m64 -mcmodel=medium
ESMF_CXXCOMPILEPATHS=-I/Users/dazlich/gfortran/esmf//src/include -I/Users/dazlich/gfortran/esmf//src/Infrastructure/stubs/mpiuni
ESMF_CXXCOMPILECPPFLAGS=-DS64=1 -DESMF_OS_Darwin=1 -D__SDIR__='' -DESMF_MPIUNI

ESMF_CXXLINKOPTS= -march=k8 -m64 -mcmodel=medium
ESMF_CXXLINKPATHS=-L/Users/dazlich/gfortran/esmf//lib/libO/Darwin.gfortran.64.mpiuni.default -L/usr/local/lib/gcc/x86_64-apple-darwin10/4.5.0/../../../
ESMF_CXXLINKRPATHS=
ESMF_CXXLINKLIBS= -lgfortran
ESMF_CXXESMFLINKLIBS=-lesmf  -lgfortran

#
# !!! The following options were used on this ESMF build !!!
#
# ESMF_DIR: /Users/dazlich/gfortran/esmf/
# ESMF_OS: Darwin
# ESMF_MACHINE: x86_64
# ESMF_ABI: 64
# ESMF_COMPILER: gfortran
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
