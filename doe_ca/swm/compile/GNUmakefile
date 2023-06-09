#-----------------------------------------------------------------------------
# Generic Makefile for models with Fortran source
#
# Requires:
#
#    GNU make		(works with version 3.79 or greater)
#    Makefile.host	(processor-dependent information)
#    Makefile.model	(model-dependent information)
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Using this makefile:
#
# To make the model, type "make"
#
# To override a makefile variable, specify it on the command line, e.g.,
# make FFLAGS='-fpic -i8'
#
# To make a debug version of the model, type "make DEBUG=true"
# What a debug version is depends on the options set in Makefile.host; this 
# might include compiler options for profiling, array bounds checking, etc.
#
# To remove all generated files except the executable code, type "make clean"
#
# To remove all generated files, type "make clobber"
#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Comments on the construction of this Makefile:
#
# It is named "GNUmakefile" so that it is read first by GNU make.  This will 
# be ignored by other versions of make, so you can write a different makefile 
# (or Makefile) if you're not using GNU make, # and still keep this one around.
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
#	MAKEFILE.HOST	for processor-dependent information
#	MAKEFILE.MODEL	for model-dependent information
#
# Their default names are Makefile.host and Makefile.model (in the current
# directory), but you can change these definitions below if you want to.
#
# It is assumed here that all source files are .F files (Fortran source
# with possibly some directives for the C preprocessor).  They will be
# passed through the C preprocessor to turn them into pure Fortran files;
# the suffix used (SUF) is defined in MAKEFILE_HOST since it depends on
# the Fortran compiler being used (some use .f, others use .f90, etc.).
#
# Future improvements (someday?):
#
#	support for C source
#	use automake/autoconfig to generate processor-dependent info?
#
# Author:  Scott R. Fulton
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
include $(MAKEFILE_HOST_LOC)


#-----------------------------------------------------------------------------
# Read the makefile to define the model-dependent information.
# Must define SRC_FREE and SRC_FIXED as lists of Fortran source (.F) files
# (free source and fixed source, respectively; either may be empty).
# Also must define the default target "all" depending on $(MAIN),
# and should list all nontrivial dependencies (e.g., on modules).
#-----------------------------------------------------------------------------
MAKEFILE_MODEL	= ./Makefile.model.1
include $(MAKEFILE_MODEL)

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
#.SUFFIXES:	.o .f .F

$(SRC_f) : %.$(SUF): %.F
	$(CPP) $(CPPFLAGS) $(CPP_OS) $(CPP_OPTS) $< > $@

$(OBJS) : %.o: %.F
	$(CPP) $(CPPFLAGS) $(CPP_OS) $(CPP_OPTS) $< > $*.$(SUF)
	$(FC) -c $(FFLAGS) $(FORM) $(PRECISION) $(TARGET_ARCH) $*.$(SUF) -o $@

#-----------------------------------------------------------------------------
# Define the rule(s) for building the executable code
#-----------------------------------------------------------------------------
$(MAIN): $(OBJS) 
	$(LD) $(LDFLAGS) $^ -o $@ -L$(USRLIBPATH) $(USRLIBS) $(LDLIBS) 

#-----------------------------------------------------------------------------
# Target to check that the code still produces the same results.
# Results from standard test are stored in the file $(CHECK_OUTPUT)
#-----------------------------------------------------------------------------

# rule to create the check output
$(CHECK_OUTPUT):
	cd $(CHECK_DIR); $(MAIN) > $(CHECK_OUTPUT)

# rule to check the code
.PHONY: check
check : $(MAIN) $(CHECK_OUTPUT)
	@echo Running the compiled code and diffing the output:
	cd $(CHECK_DIR); rm $(CHECK_OUTPUT)_new; \
		$(MAIN) > $(CHECK_OUTPUT)_new; \
		diff $(CHECK_OUTPUT) $(CHECK_OUTPUT)_new | more; \
		rm $(CHECK_OUTPUT)_new

#-----------------------------------------------------------------------------
# standard targets for miscellaneous chores
#-----------------------------------------------------------------------------

clean :
	rm -f *.o *.$(SUF) *.h *.mod

clobber :
	rm -f *.o *.$(SUF) *.h *.mod $(MAIN)
