

#----------------------------------------------------------
# set the path to the source directories
#----------------------------------------------------------
 L1 = ../../utilities/layer_1
 L2 = ../../utilities/layer_2
 L3 = ../../utilities/layer_3
 L4 = ../../utilities/layer_4
 SWM = ../source

#----------------------------------------------------------
# name the executable
#----------------------------------------------------------
 Executable = ./swm

#----------------------------------------------------------
# Mac G4 power pc, debug
#----------------------------------------------------------
#Cpp = /usr/bin/cpp
#Cppopts = -P
#cc = /usr/bin/cc -c
#Comp = f95
#Opts =  -c -O -round=nearest -N11
#Load = f95
#Fix = -f fixed -W 80
#Free = -f free
#Libs = -L/Applications/Absoft/lib -lf90math_altivec
#Suf = f

#----------------------------------------------------------
# SGI O2k series, 32bit, debug
#----------------------------------------------------------
 Cpp = /usr/lib/cpp
 Cppopts = -P
 cc = cc -c
 Comp = f90
 Opts =  -c -n32 -g 
 Load = f90 -n32 -g  
 Fix = -col80 -fixedform
 Free = -extend_source -freeform
 Libs = -lmpi
 Dp =
 Suf = f

#----------------------------------------------------------
# SGI O2k series, 32bit
#----------------------------------------------------------
#Cpp = /usr/lib/cpp
#Cppopts = -P
#cc = cc -c
#Comp = f90
#Opts =     -c -O3 -n32 -mips4 -r10000 -OPT:roundoff=3:IEEE_arithmetic=3 
#Load = f90    -O3 -n32 -mips4 -r10000 -OPT:roundoff=3:IEEE_arithmetic=3 
#Fix = -col80 -fixedform
#Free = -extend_source -freeform
#Libs = -L/usr/lib32 -lcomplib.sgimath -lfastm -lmpi 
#Dp =
#Suf = f

# Portland Group, debug, saddleback
#Cpp     = /usr/bin/cpp
#Cppopts = -P -traditional
#cc      = cc -c
#Comp    = pgf90
#Fix     = -Mextend
#Free    = -Mfreeform
#Opts    = -c -g -Mbyteswapio -Ktrap=fp
#Load    = pgf90 -g
#Dp      =
#Suf     = f
#following for local systems
#Libs    = -L/home/pgi/linux86/lib -lmpich -L/usr/local/lib -lnetcdf
#Inc     = -I/usr/local/include

# Portland Group, optimized for saddleback
#Cpp     = /usr/bin/cpp
#Cppopts = -P -traditional
#cc      = cc -c
#Comp    = pgf90
#Fix     = -Mextend
#Free    = -Mfreeform
#Opts    = -c -Mvect -Minfo -fast -Mbyteswapio -Ktrap=fp -tp athlon
#Load    = pgf90 -g
#Dp      =
#Suf     = f
#following for local systems
#Libs    = -L/home/pgi/linux86/lib -lmpich -L/usr/local/lib -lnetcdf
#Inc     = -I/usr/local/include


#----------------------------------------------------------
# SUN, debug
#----------------------------------------------------------
#Cpp = /usr/ccs/lib/cpp
#Cppopts = 
#cc = cc -c
#Comp = f90
#Opts =  -c -g -e
#Load = f90 -g -e
#Libs =
#Dp =
#Suf = f

#----------------------------------------------------------
# IBM, 32bit, debug
#----------------------------------------------------------
#Cpp = /usr/ccs/lib/cpp
#cc = cc -c
#Comp = mpxlf
#Opts = -c -q32 -g -qinitauto -qmoddir=. -qfixed=80 -bmaxstack:250000000 -bmaxdata:2000000000
#Load = mpxlf -q32 -g -qinitauto -qfixed=80 -bmaxstack:250000000 -bmaxdata:2000000000
#Libs =
#Dp =
#Suf = f
#OTHER = 

#----------------------------------------------------------
# IBM series, 32bit
#----------------------------------------------------------
#Cpp = /usr/ccs/lib/cpp
#cc = cc -c
#Comp = mpxlf
#Opts =  -c   -O3 -q32 -qarch=ppc -qfloat=fltint:hssngl:rsqrt:hsflt -qfixed=80 -bmaxstack:250000000 -bmaxdata:2000000000
#Load = mpxlf -O3 -q32 -qarch=ppc -qfloat=fltint:hssngl:rsqrt:hsflt -qfixed=80 -bmaxstack:250000000 -bmaxdata:2000000000
#Libs =
#Dp =
#Suf = f
#OTHER =

#------------------------------------------------------------------
#  precompiler options
#	RES : choose 0002562, 0010242, 0040962, or 0163842
#	MPI : set equal to 1 for MPI code, set equal to 0 for single-thread code
#	VISCOSITY : set equal to 1 to run on viscosity, 0 for "inviscid" solution
#	Choose SGI, IBM, G4_PPC, OR SUN to have a value of 1, 0 for all others
#------------------------------------------------------------------
 DRES				= -Dresolution=0040962
 DMPI				= -Dmpi=0
 DVISCOSITY			= -Dviscosity=0
 DSGI                           = -Dsgi=1
 DLINUX                         = -Dlinux=0
 DIBM				= -Dibm=0
 DG4_PPC                        = -Dg4_ppc=0
 DSUN				= -Dsun_os=0
 
 Cpp_opts = $(Cppopts)                  \
	$(DRES)				\
        $(DMPI)				\
	$(DVISCOSITY)			\
	$(DSGI)				\
	$(DG4_PPC)                      \
	$(DSUN)				\
	$(DIBM)				

#------------------------------------------------------------------
#  object list
#------------------------------------------------------------------

Objs =                               \
	kinds.o	                     \
        physical_parameters.o        \
	geodesic_grid_utilities.o    \
        model_parameters.o           \
	domain_decomposition.o       \
        connections.o                \
        timer.o                      \
	global_reductions.o          \
	assign_owner.o               \
	wrap_face_data.o             \
        wrap_vertex_data.o           \
        wrap_edge_data.o             \
	dissipation_operator.o       \
	gather_scatter.o             \
	operators.o                  \
	prognostics.o                \
	time_manager_module.o        \
	model_control.o	             \
        grid_metrics_generator.o     \
        grid_mask.o                  \
        grid_metrics.o               \
	multigrid_solver.o           \
        elliptic_solver.o            \
	spectral_transforms.o        \
	operators_hl.o               \
	budgets.o		     \
	dx_module.o                  \
	initialize.o		     \
	step.o                       \
	driver.o		     

#------------------------------------------------------------------
#  compile-link
#------------------------------------------------------------------

$(Executable): $(Objs)
	$(Load) $(Objs) -o $(Executable) $(Libs)

#------------------------------------------------------------------
#  make object files
#------------------------------------------------------------------

driver.o: $(SWM)/driver.F 
	$(Cpp) $(precision) $(Cpp_opts) $(SWM)/driver.F > driver.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) driver.$(Suf)

initialize.o: $(SWM)/initialize.F
	$(Cpp) $(precision) $(Cpp_opts) $(SWM)/initialize.F > initialize.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Fix) initialize.$(Suf)

step.o: $(SWM)/step.F
	$(Cpp) $(precision) $(Cpp_opts) $(SWM)/step.F > step.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) step.$(Suf)

model_control.o: $(L2)/model_control.F
	$(Cpp) $(precision) $(Cpp_opts) $(L2)/model_control.F > model_control.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) model_control.$(Suf)

prognostics.o: $(L2)/prognostics.F
	$(Cpp) $(precision) $(Cpp_opts) $(L2)/prognostics.F > prognostics.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) prognostics.$(Suf)

elliptic_solver.o: $(L3)/elliptic_solver.F
	$(Cpp) $(precision) $(Cpp_opts) $(L3)/elliptic_solver.F > elliptic_solver.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) elliptic_solver.$(Suf)

time_manager_module.o: $(L2)/time_manager_module.F
	$(Cpp) $(precision) $(Cpp_opts) $(L2)/time_manager_module.F > time_manager_module.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) time_manager_module.$(Suf)

connections.o: $(L2)/connections.F
	$(Cpp) $(precision) $(Cpp_opts) $(L2)/connections.F > connections.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) connections.$(Suf)

model_parameters.o: $(L1)/model_parameters.F 
	$(Cpp) $(precision) $(Cpp_opts) $(L1)/model_parameters.F > model_parameters.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) model_parameters.$(Suf)

assign_owner.o: $(L2)/assign_owner.F
	$(Cpp) $(precision) $(Cpp_opts) $(L2)/assign_owner.F > assign_owner.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Fix) assign_owner.$(Suf)

grid_mask.o: $(L2)/grid_mask.F
	$(Cpp) $(precision) $(Cpp_opts) $(L2)/grid_mask.F > grid_mask.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) grid_mask.$(Suf)

kinds.o: $(L1)/kinds.F 
	$(Cpp) $(precision) $(Cpp_opts) $(L1)/kinds.F > kinds.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) kinds.$(Suf)

physical_parameters.o: $(L1)/physical_parameters.F
	$(Cpp) $(precision) $(Cpp_opts) $(L1)/physical_parameters.F > physical_parameters.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) physical_parameters.$(Suf)

domain_decomposition.o: $(L1)/domain_decomposition.F
	$(Cpp) $(precision) $(Cpp_opts) $(L1)/domain_decomposition.F > domain_decomposition.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) domain_decomposition.$(Suf)

dx_module.o: $(SWM)/dx_module.F
	$(Cpp) $(precision) $(Cpp_opts) $(SWM)/dx_module.F > dx_module.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) dx_module.$(Suf)

timer.o: $(L1)/timer.F
	$(Cpp) $(precision) $(Cpp_opts) $(L1)/timer.F > timer.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) timer.$(Suf)

geodesic_grid_utilities.o: $(L2)/geodesic_grid_utilities.F
	$(Cpp) $(precision) $(Cpp_opts) $(L2)/geodesic_grid_utilities.F > geodesic_grid_utilities.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) geodesic_grid_utilities.$(Suf)

gather_scatter.o: $(L2)/gather_scatter.F
	$(Cpp) $(precision) $(Cpp_opts) $(L2)/gather_scatter.F > gather_scatter.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Fix) gather_scatter.$(Suf)

grid_metrics_generator.o: $(L2)/grid_metrics_generator.F
	$(Cpp) $(precision) $(Cpp_opts) $(L2)/grid_metrics_generator.F > grid_metrics_generator.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) grid_metrics_generator.$(Suf)

grid_metrics.o: $(L3)/grid_metrics.F 
	$(Cpp) $(precision) $(Cpp_opts) $(L3)/grid_metrics.F > grid_metrics.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) grid_metrics.$(Suf)

multigrid_solver.o: $(L3)/multigrid_solver.F
	$(Cpp) $(precision) $(Cpp_opts) $(L3)/multigrid_solver.F > multigrid_solver.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) multigrid_solver.$(Suf)

spectral_transforms.o: $(L3)/spectral_transforms.F
	$(Cpp) $(precision) $(Cpp_opts) $(L3)/spectral_transforms.F > spectral_transforms.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) spectral_transforms.$(Suf)

operators_hl.o: $(L4)/operators_hl.F
	$(Cpp) $(precision) $(Cpp_opts) $(L4)/operators_hl.F > operators_hl.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) operators_hl.$(Suf)

global_reductions.o: $(L2)/global_reductions.F 
	$(Cpp) $(precision) $(Cpp_opts) $(L2)/global_reductions.F > global_reductions.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) global_reductions.$(Suf)

budgets.o: $(SWM)/budgets.F
	$(Cpp) $(precision) $(Cpp_opts) $(SWM)/budgets.F > budgets.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) budgets.$(Suf)

wrap_face_data.o: $(L2)/wrap_face_data.F 
	$(Cpp) $(precision) $(Cpp_opts) $(L2)/wrap_face_data.F > wrap_face_data.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Fix) wrap_face_data.$(Suf)

wrap_vertex_data.o: $(L2)/wrap_vertex_data.F
	$(Cpp) $(precision) $(Cpp_opts) $(L2)/wrap_vertex_data.F > wrap_vertex_data.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Fix) wrap_vertex_data.$(Suf)

wrap_edge_data.o: $(L2)/wrap_edge_data.F
	$(Cpp) $(precision) $(Cpp_opts) $(L2)/wrap_edge_data.F > wrap_edge_data.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) wrap_edge_data.$(Suf)

dissipation_operator.o: $(L3)/dissipation_operator.F
	$(Cpp) $(precision) $(Cpp_opts) $(L3)/dissipation_operator.F > dissipation_operator.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Fix) dissipation_operator.$(Suf)

operators.o: $(L2)/operators.F 
	$(Cpp) $(precision) $(Cpp_opts) $(L2)/operators.F > operators.$(Suf)
	$(Comp) $(Dp) $(Opts) $(Free) operators.$(Suf)

clean :
	rm -f *.o *.f *.h *.mod swm
