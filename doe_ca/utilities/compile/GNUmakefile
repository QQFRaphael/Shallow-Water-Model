#-----------------------------------------------------------------------------
# Generic Makefile for libraries with Fortran source
#
# Requires:
#
#    GNU make		(works with version 3.79 or greater)
#    Makefile.host	(processor-dependent information)
#    Makefile.library	(library-dependent information)
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Using this makefile:
#
# To make the library, type "make"
#
# To override a makefile variable, specify it on the command line, e.g.,
# make FFLAGS='-fpic -i8'
#
# To make a debug version of the library, type "make DEBUG=true"
# What a debug version is depends on the options set in Makefile.host; this 
# might include compiler options for profiling, array bounds checking, etc.
#
# To remove files generated by make, use:
#    "make clean"    to remove preprocessed source files [.$(SUF)]
#    "make cleaner"  to also remove object files [.o]
#    "make cleanest" to also remove module files [.mod]
#    "make clobber"  to also remove library file [remove all except source]
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Comments on the construction of this Makefile:
#
# It is named "GNUmakefile" so that it is read first by GNU make.  This will 
# be ignored by other versions of make, so you can write a different makefile 
# (or Makefile) if you're not using GNU make, and still keep this one around.
# To get GNU make to use "makefile" instead, use "make -f makefile".
#
# GNU make is used since it is widely available (probably for any Unix system 
# and possibly for others).  It's the closest thing to a standard for "make" 
# as is available, and is standard for Linux.  Most variable names, etc. are 
# close to GNU standards.  Some features used here which might not work with 
# other versions of make include:
#
#	VPATH (allows easy access to source in multiple directories)
#	target-specific variable values (allows free/fixed source)
#
# Two other (partial) makefiles are read in:
#
#	MAKEFILE.HOST		for processor-dependent information
#	MAKEFILE.LIBRARY	for library-dependent information
#
# Their default names are Makefile.host and Makefile.library (in the current
# directory), but you can change these definitions below if you want to.
#
# It is assumed here that all source files are .F files (Fortran source
# with possibly some directives for the C preprocessor).  They will be
# passed through the C preprocessor to turn them into pure Fortran files;
# the suffix used (SUF) is defined in MAKEFILE_HOST since it depends on
# the Fortran compiler being used (some use .f, others use .f90, etc.).
#
# A much cleaner and robust approach would be to distinguish between flavors
# of source (preprocess or not, free or fixed form) based on suffixes
# (.f, .f90, .F, .F90).  Until this is done, this file is awkward at best...
#
# Future improvements (someday?):
#
#	support for C source
#	use automake/autoconfig to generate processor-dependent info?
#	improve by using GNU make's support for library (archive) files?
#	add support to save .o and/or .mod files in other directories
# ----> replace free/fixed source baggage with suffixes .f, .f90, .F, .F90
#
# Author:  Scott R. Fulton (originally for swm)
#          Adapted by Don Dazlich to build a library instead
#          Cleaned up and documented by Scott Fulton
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Initializations
#-----------------------------------------------------------------------------
# specify the shell to avoid surprises in weird environments
SHELL	= /bin/sh

#-----------------------------------------------------------------------------
# Read the universal makefile to define the processor-dependent information
#-----------------------------------------------------------------------------
MAKEFILE_HOST = ../../build/Makefile.host
include $(MAKEFILE_HOST)

#-----------------------------------------------------------------------------
# Read a component-specific makefile to define the processor-dependent information
#-----------------------------------------------------------------------------
MAKEFILE_HOST_LOC	= ./Makefile.host
include $(MAKEFILE_HOST)

#-----------------------------------------------------------------------------
# Read the makefile to define the library-dependent information.
# Must define SRC_FREE and SRC_FIXED as lists of Fortran source (.F) files
# (free source and fixed source, respectively; either may be empty).
# Also must define the default target "all" depending on $(MAIN),
# and should list all nontrivial dependencies (e.g., on modules).
#-----------------------------------------------------------------------------
MAKEFILE_LIBRARY	= ./Makefile.library.1
include $(MAKEFILE_LIBRARY)

#-----------------------------------------------------------------------------
# Create the corresponding lists of preprocessed source files
#-----------------------------------------------------------------------------
SRC_FREE_f	= $(SRC_FREE:.F=.$(SUF))
SRC_FIXED_f	= $(SRC_FIXED:.F=.$(SUF))

#-----------------------------------------------------------------------------
# Create the corresponding lists of objects
#-----------------------------------------------------------------------------
OBJ_FREE	= $(SRC_FREE:.F=.o)
OBJ_FIXED	= $(SRC_FIXED:.F=.o)
OBJS		= $(OBJ_FREE) $(OBJ_FIXED)

#-----------------------------------------------------------------------------
# Target-specific variables:  flags for free source and fixed source
#-----------------------------------------------------------------------------

$(OBJ_FREE)	: FORM = $(FREE)
$(OBJ_FIXED)	: FORM = $(FIXED)

#-----------------------------------------------------------------------------
# Replace the built-in implicit rules with GNU-make "static pattern rules".
# This allows us to treat free source and fixed source separately,
# and to save the preprocessed files with suffix $(SUF) for debugging.
# It also overcomes pgf90's apparent refusal to invoke cpp.
#-----------------------------------------------------------------------------
.SUFFIXES:	# delete the default list of suffixes for safety

$(SRC_f) : %.$(SUF): %.F
	$(CPP) $(CPPFLAGS) $(CPP_OS) $(CPP_OPTS) $< > $@

$(OBJS) : %.o: %.F
	$(CPP) $(CPPFLAGS) $(CPP_OS) $(CPP_OPTS) $< > $*.$(SUF)
	$(FC) -c $(FFLAGS) $(FORM) $(PRECISION) $(TARGET_ARCH) $*.$(SUF) -o $@

#-----------------------------------------------------------------------------
# Define the rule(s) for building the executable code
#-----------------------------------------------------------------------------
$(MAIN): $(OBJS)
	$(AR) $(MAIN) $(OBJS)
	$(RANLIB) $(MAIN)

#-----------------------------------------------------------------------------
# standard targets for miscellaneous chores
#-----------------------------------------------------------------------------

clean :
	rm -f *.$(SUF) 

cleaner :
	rm -f *.$(SUF) *.o

cleanest :
	rm -f *.$(SUF) *.o *.mod

clobber :
	rm -f *.o *.$(SUF) *.mod $(MAIN)
