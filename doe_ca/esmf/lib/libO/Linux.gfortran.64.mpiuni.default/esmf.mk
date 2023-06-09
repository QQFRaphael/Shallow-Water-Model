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

ESMF_F90COMPILEOPTS=-O -fno-second-underscore -m64 -mcmodel=small
ESMF_F90COMPILEPATHS=-I/Users/dazlich/doe_ca/esmf/mod/modO/Linux.gfortran.64.mpiuni.default -I/Users/dazlich/doe_ca/esmf/src/include
ESMF_F90COMPILECPPFLAGS= -DSx86_64_small=1 -DESMF_OS_Linux=1 -DESMF_MPIUNI

ESMF_F90LINKOPTS= -fno-second-underscore -m64 -mcmodel=small
ESMF_F90LINKPATHS=-L/Users/dazlich/doe_ca/esmf/lib/libO/Linux.gfortran.64.mpiuni.default -L/usr/lib/gcc/x86_64-redhat-linux/4.1.2/
ESMF_F90LINKRPATHS=-Wl,-rpath,/Users/dazlich/doe_ca/esmf/lib/libO/Linux.gfortran.64.mpiuni.default -Wl,-rpath,/usr/lib/gcc/x86_64-redhat-linux/4.1.2/
ESMF_F90LINKLIBS= -lrt -lstdc++
ESMF_F90ESMFLINKLIBS=-lesmf  -lrt -lstdc++

ESMF_CXXCOMPILER=g++
ESMF_CXXLINKER=g++

ESMF_CXXCOMPILEOPTS=-O -DNDEBUG -DESMF_LOWERCASE_SINGLEUNDERSCORE -m64 -mcmodel=small
ESMF_CXXCOMPILEPATHS=-I/Users/dazlich/doe_ca/esmf/src/include -I/Users/dazlich/doe_ca/esmf/src/Infrastructure/stubs/mpiuni
ESMF_CXXCOMPILECPPFLAGS=-DSx86_64_small=1 -DESMF_OS_Linux=1 -D__SDIR__='' -DESMF_MPIUNI

ESMF_CXXLINKOPTS= -m64 -mcmodel=small
ESMF_CXXLINKPATHS=-L/Users/dazlich/doe_ca/esmf/lib/libO/Linux.gfortran.64.mpiuni.default -L/usr/lib/gcc/x86_64-redhat-linux/4.1.2/
ESMF_CXXLINKRPATHS=-Wl,-rpath,/Users/dazlich/doe_ca/esmf/lib/libO/Linux.gfortran.64.mpiuni.default -Wl,-rpath,/usr/lib/gcc/x86_64-redhat-linux/4.1.2/
ESMF_CXXLINKLIBS= -lrt -lgfortran
ESMF_CXXESMFLINKLIBS=-lesmf  -lrt -lgfortran

#
# !!! The following options were used on this ESMF build !!!
#
# ESMF_DIR: /Users/dazlich/doe_ca/esmf
# ESMF_OS: Linux
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
