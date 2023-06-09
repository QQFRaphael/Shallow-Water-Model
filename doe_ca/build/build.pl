#!/usr/bin/perl -w
#
#--- begin user setup ---#
#
# user must set the following variables

$atm    = 1;           # 0 = dummy atm, 1 = bugs5 atm, 2 = bugs6 atm
$ocean  = 1;           # 0 = dummy ocean, 1 = geodesic ocean model 
$ice    = 1;           # 0 = passive sea ice, 1 = active sea ice 
$sib    = 2;           # SiB version (2 or 3) 
$atmres = '0040962';   # atm grid resolution (0002562, 0010242, 0040962)
$sfcres = '0040962';   # sfc grid resolution (applies to ocn/ice/sib/etc.) 
$cmode  = 0;           # 0 = debug mode compile, 1 = optimized
$mpi    = 1;           # 0 or 1
$atm_subd = '00160';   # number of atm subdomains.  only modified if mpi=1
                       # possible vals:  00010,00040,00160,00640
$sfc_subd = '00160';   # number of sfc subdomains.  only modified if mpi=1
$npe    = 16;           # number of processors.  only modified if mpi=1
$xlf    = 2;           # on MacOSX 0 = Absoft compiler, 1 = IBM xlf compiler (lam mpi),2=intel/openmpi, 3=gfortran.
$slikrock = 0;           # on MacOSX 0 = cpp (most macs), 1 = cpp3 (slikrock specific).
$pgi    = 0;           # on Linux, 0 = Intel compiler (lam-mpi), 1 = PGI compiler (mpich), 2=pathscale compiler, 3=gfortran
$altix  = 0;           # for Linux machines, set to 1 only for SGI Altix machines
                       #  ignored if $pgi=1 or 2
$unicos = 0;           # on Linux, set to 1 only for Cray machines, ignored
                       #  unless $pgi=1
$rad    = 4;           # atmospheric radiation option, 1=bugsrad,2=harshrad,3=camrad,4=rrtm
$pnetcdf = 0;          # if 1, use parallel netcdf to read/write restarts, qp_output files (not implemented yet)
$spmd = 0;             # if 1, the user asserts that processors in all components have the same subdomains      

#--- end user setup ---#
# >>>>>>> DON'T TOUCH ANYTHING BELOW HERE!!!! <<<<<<<<

use Cwd;
chdir '../';
$doedir = getcwd();

# check for command line options
$modmake = 0;
$clobber = 0;
foreach (@ARGV) {
   if ($_ eq '-C') {
     $modmake = 1;
     $clobber = 1;
   } 
}

if ($modmake) {

print "modifying makefiles!!!\n";

# also restore the cvs version of domain_decomposition.F
if ($atm == 1) {
  $curdir = $doedir . "/atm.BUGS5/source.BUGS5";
  chdir "$curdir";
  if (!(-e 'domain_decomposition.F.orig')) {
    `cp domain_decomposition.F domain_decomposition.F.orig`;
  } else {
    `cp domain_decomposition.F.orig domain_decomposition.F`;
  }
}

# also remove all libraries in /lib 
$libdir = $doedir . '/lib';
chdir $libdir;
unlink <*.a>;
#`if (-e $libdir/libutil.a) rm $libdir/libutil.a`;

if ($xlf == 2 || $xlf == 3) {
  $thelibs = "../../lib/libcpl.a ../../lib/libsib.a ../../lib/libatm.a ../../lib/libocean.a ../../lib/libutil.a ";
} else {
  $thelibs = "-lcpl -latm -locean -lutil -lsib ";
}

# if mpi is to be used, modify the processors_map.in file appropriately
if ($mpi == 1) {
  my $fil= $doedir . "/coupler_driver/run_coupler/processors_map.in";
  my @outlines;
  open(FIL, $fil) || die("Could not open file!");
  my $mynpe = $npe-1;
  while (<FIL>) {
    if ($_ =~ "coupler" )    {$_ = "coupler     0  $mynpe\n";}
    if ($_ =~ "atmosphere" ) {$_ = "atmosphere  0  $mynpe\n";}
    if ($_ =~ "ocean" )      {$_ = "ocean       0  $mynpe\n";}
    if ($_ =~ "ice" )        {$_ = "ice         0  $mynpe\n";}
    push(@outlines, $_);
  }
  close(FIL);
  open(FIL,">$fil") || die("Could not open file!");
  print FIL @outlines;
  close(FIL);
}

{ # utilities Makefile
$fil = $doedir . "/utilities/compile/Makefile.library";
$outfil = $fil . ".1";
my @outlines;
open(FIL, "$fil") || die("Could not open file!");
while (<FIL>) {
  if ($_ =~ "^DMPI" ) {$_ =~ s/-Dmpi=val/-Dmpi=$mpi/g;}
  if ($_ =~ "^DSPMD" ) {$_ =~ s/-Dspmd_mode=val/-Dspmd_mode=$spmd/g;}
  if ($_ =~ "^DNPE" ) {$_ =~ s/COMP=1/COMP=$npe/g;}
  push(@outlines, $_);
}
close(FIL);
open(FIL,">$outfil");
print FIL @outlines;
close(FIL);
}

{ # SiB Makefile
if ($sib == 2) {  # SiB2 Makefile
    $fil = $doedir . "/SiB2/compile/Makefile.model";
  } elsif ($sib == 3) {  # SiB3 Makefile
    $fil = $doedir . "/SiB3/compile/Makefile.model";
  }
$outfil = $fil . ".1";
my @outlines;
open(FIL, "$fil") || die("Could not open file!");
while (<FIL>) {
  if ($_ =~ "^MODSIB" ) {$_ =~ s/SiBval/SiB$sib/g;}
  push(@outlines, $_);
}
close(FIL);
open(FIL,">$outfil");
print FIL @outlines;
close(FIL);
}

$filp1 = $doedir . "/utilities/layer_1/params_parallel.F";
$filp2 = $doedir . "/utilities/layer_1/params_grid_horizontal.F";
$filg1 = $doedir . "/utilities/layer_1/grid_metrics_variables.F";
$filg2 = $doedir . "/utilities/layer_1/grid_mask_variables.F";
$filrp = $doedir . "/utilities/layer_2/remap.F";
$films = $doedir . "/utilities/layer_3/multigrid_solver.F";
$files = $doedir . "/utilities/layer_3/elliptic_solver.F";
$filhl = $doedir . "/utilities/layer_4/operators_hl.F";

if (($atm == 0) || ($atm == 2)) {  # same edits for atm.dummy and atmos.BUGS6

  if ($atm == 0) {  # atm.dummy Makefile
    $fil = $doedir . "/atm.dummy/compile/Makefile.model";
    $filsrc = $doedir . "/atm.dummy/source/";
  } elsif ($atm == 2) {  # BUGS6 Makefile
    $fil = $doedir . "/atmos.BUGS6/compile/Makefile.model";
    $filsrc = $doedir . "/atmos.BUGS6/dyn_core/source/";

  }
  { #edit block
  $outfil = $fil . ".1";
  my @outlines;
  open(FIL, "$fil") || die("Could not open file!");
  while (<FIL>) {
    if ($_ =~ "^RESOLUTION" ) {$_ =~ s/resval/$atmres/g;}
    if ($_ =~ "^DMPI" ) {$_ =~ s/-Dmpi=val/-Dmpi=$mpi/g;}
    if ($mpi == 1 && $_ =~ "^DNUMSBDMNS" ) {$_ =~ s/00010/$atm_subd/g;}
    if ($mpi == 1 && $_ =~ "^DNPE" ) {$_ =~ s/COMP=1/COMP=$npe/g;}
#    if ($_ =~ "^DBUGS" ) {$_ =~ s/-Dbugs6=0/-Dbugs6=1/g;}
#    if ($_ =~ "^#DLINK" ) {$_ =~ s/#DLINK/DLINK/g;}
    push(@outlines, $_);
  }
  close(FIL);
  open(FIL,">$outfil");
  print FIL @outlines;
  close(FIL);

  my @outlinesp1;
  $outfil = $filsrc . "params_parallel_atm.F";
  open(FILP1, "$filp1") || die("Could not open file!");
  while (<FILP1>) {
    if ($_ =~ "xxx" ) {$_ =~ s/xxx/atm/g;}
    push(@outlinesp1, $_);
  }
  close(FILP1);
  open(FILP1,">$outfil");
  print FILP1 @outlinesp1;
  close(FILP1);
  my @outlinesp2;
  $outfil = $filsrc . "params_grid_horizontal_atm.F";
  open(FILP2, "$filp2") || die("Could not open file!");
  while (<FILP2>) {
    if ($_ =~ "xxx" ) {$_ =~ s/xxx/atm/g;}
    push(@outlinesp2, $_);
  }
  close(FILP2);
  open(FILP2,">$outfil");
  print FILP2 @outlinesp2;
  close(FILP2);
  my @outlinesg1;
  $outfil = $filsrc . "grid_metrics_variables_atm.F";
  open(FILG1, "$filg1") || die("Could not open file!");
  while (<FILG1>) {
    if ($_ =~ "xxx" ) {$_ =~ s/xxx/atm/g;}
    push(@outlinesg1, $_);
  }
  close(FILG1);
  open(FILG1,">$outfil");
  print FILG1 @outlinesg1;
  close(FILG1);
  my @outlinesms;
  $outfil = $filsrc . "multigrid_solver_atm.F";
  open(FILMS, "$films") || die("Could not open file!");
  while (<FILMS>) {
    if ($_ =~ "xxx" ) {$_ =~ s/xxx/atm/g;}
    push(@outlinesms, $_);
  }
  close(FILMS);
  open(FILMS,">$outfil");
  print FILMS @outlinesms;
  close(FILMS);
  my @outlineses;
  $outfil = $filsrc . "elliptic_solver_atm.F";
  open(FILES, "$files") || die("Could not open file!");
  while (<FILES>) {
    if ($_ =~ "xxx" ) {$_ =~ s/xxx/atm/g;}
    push(@outlineses, $_);
  }
  close(FILES);
  open(FILES,">$outfil");
  print FILES @outlineses;
  close(FILES);
  my @outlinesg2;
  $outfil = $filsrc . "grid_mask_variables_atm.F";
  open(FILG2, "$filg2") || die("Could not open file!");
  while (<FILG2>) {
    if ($_ =~ "xxx" ) {$_ =~ s/xxx/atm/g;}
    push(@outlinesg2, $_);
  }
  close(FILG2);
  open(FILG2,">$outfil");
  print FILG2 @outlinesg2;
  close(FILG2);
  if ($atm == 2) {  # atmos.BUGS6 file
    my @outlineshl;
    $outfil = $filsrc . "operators_hl_atm.F";
    open(FILHL, "$filhl") || die("Could not open file!");
    while (<FILHL>) {
      if ($_ =~ "xxx" ) {$_ =~ s/xxx/atm/g;}
      push(@outlineshl, $_);
    }
    close(FILHL);
    open(FILHL,">$outfil");
    print FILHL @outlineshl;
  }

  }

# special case for BUGS6 and IRIX machines:  multigrid_solver
  if (($atm == 2) && ($^O eq 'irix')) {
    $curdir = $doedir . "/atmos.BUGS6/dyn_core/source";  
    chdir "$curdir";   
    `cp multigrid_solver.F.IRIX multigrid_solver.F`;
  }
  
} else {  # atm.BUGS5 

# must modify Makefile.model in compile.BUGS5 and compile
# also for no. procs, we need to modify domain_decompostion.F
  { #edit block
  my @outlines;
  $fil = $doedir . "/atm.BUGS5/compile.BUGS5/Makefile.model";
  $filsrc = $doedir . "/atm.BUGS5/source/";
  $outfil = $fil . ".1";
  open(FIL, "$fil") || die("Could not open file!");
  while (<FIL>) {
    if ($_ =~ "^RESOLUTION" ) {$_ =~ s/resval/$atmres/g;}
    if ($mpi == 1 && $_ =~ "^#DMPI" ) {$_ =~ s/#DMPI/ DMPI/g;}
    if ($mpi == 1 && $_ =~ "^DNUMSBDMNS" ) {$_ =~ s/00010/$atm_subd/g;}
    if ($mpi == 1 && $_ =~ "^DNPE" ) {$_ =~ s/COMP=1/COMP=$npe/g;}
    if ($rad == 1  ) {$_ =~ s/RADOPTION/bugsrad/g;}
    if ($rad == 2  ) {$_ =~ s/RADOPTION/harshrad/g;}
    if ($rad == 3  ) {$_ =~ s/RADOPTION/cam_rad/g;}
    if ($rad == 4  ) {$_ =~ s/RADOPTION/rrtm/g;}
    push(@outlines, $_);
  }
  close(FIL);
  open(FIL,">$outfil");
  print FIL @outlines;
  close(FIL);
  
  my @outlinesp1;
  $outfil = $filsrc . "params_parallel_atm.F";
  open(FILP1, "$filp1") || die("Could not open file!");
  while (<FILP1>) {
    if ($_ =~ "xxx" ) {$_ =~ s/xxx/atm/g;}
    push(@outlinesp1, $_);
  }
  close(FILP1);
  open(FILP1,">$outfil");
  print FILP1 @outlinesp1;
  close(FILP1);
  my @outlinesp2;
  $outfil = $filsrc . "params_grid_horizontal_atm.F";
  open(FILP2, "$filp2") || die("Could not open file!");
  while (<FILP2>) {
    if ($_ =~ "xxx" ) {$_ =~ s/xxx/atm/g;}
    push(@outlinesp2, $_);
  }
  close(FILP2);
  open(FILP2,">$outfil");
  print FILP2 @outlinesp2;
  close(FILP2);
  my @outlinesg1;
  $outfil = $filsrc . "grid_metrics_variables_atm.F";
  open(FILG1, "$filg1") || die("Could not open file!");
  while (<FILG1>) {
    if ($_ =~ "xxx" ) {$_ =~ s/xxx/atm/g;}
    push(@outlinesg1, $_);
  }
  close(FILG1);
  open(FILG1,">$outfil");
  print FILG1 @outlinesg1;
  close(FILG1);
  my @outlinesg2;
  $outfil = $filsrc . "grid_mask_variables_atm.F";
  open(FILG2, "$filg2") || die("Could not open file!");
  while (<FILG2>) {
    if ($_ =~ "xxx" ) {$_ =~ s/xxx/atm/g;}
    push(@outlinesg2, $_);
  }
  close(FILG2);
  open(FILG2,">$outfil");
  print FILG2 @outlinesg2;
  close(FILG2);
  
  }

  { #edit block
  my @outlinesdd;
  $fil = $doedir . "/atm.BUGS5/source.BUGS5/domain_decomposition.F";
  open(FIL, "$fil") || die("Could not open file!");
  while (<FIL>) {
    if ($mpi == 1 && $_ =~ "npe_atmos = 002" ) {$_ =~ s/npe_atmos = 002/npe_atmos = $npe/g;}
    push(@outlinesdd, $_);
  }
  close(FIL);
  open(FIL,">$fil");
  print FIL @outlinesdd;
  close(FIL);
  }

  { #edit block
  my @outlines;
  if ($xlf == 2) {
    $thelibs .= "../../lib/libBUGS5.a ";
  } else {
    $thelibs .= "-lBUGS5 ";
  }
  $fil = $doedir . "/atm.BUGS5/compile/Makefile.model";
  $outfil = $fil . ".1";
  open(FIL, "$fil") || die("Could not open file!");
  while (<FIL>) {
    if ($_ =~ "^RESOLUTION" ) {$_ =~ s/resval/$atmres/g;}
    if ($_ =~ "^DMPI" ) {$_ =~ s/-Dmpi=val/-Dmpi=$mpi/g;}
    if ($mpi == 1 && $_ =~ "^DNUMSBDMNS" ) {$_ =~ s/00010/$atm_subd/g;}
    if ($mpi == 1 && $_ =~ "^DNPE" ) {$_ =~ s/COMP=1/COMP=$npe/g;}
    push(@outlines, $_);
  }
  close(FIL);
  open(FIL,">$outfil");
  print FIL @outlines;
  close(FIL);
  }
  
}

if ($ocean == 0) { # ocean.dummy Makefile
  $fil = $doedir . "/ocean.dummy/compile/Makefile.model";
  $filsrc = $doedir . "/ocean.dummy/source/";
} else {           # real ocean Makefile
  $fil = $doedir . "/ocean/compile/Makefile.model";
  $filsrc = $doedir . "/ocean/source/";
  if ($xlf == 2) {
    $thelibs .= "../../lib/libice.a ";
  } else {
    $thelibs .= "-lice ";
  }
}
{ #edit block
my @outlines;
$outfil = $fil . ".1";
open(FIL, "$fil") || die("Could not open file!");
while (<FIL>) {
  if ($_ =~ "^RESOLUTION" ) {$_ =~ s/resval/$sfcres/g;}
  if ($_ =~ "^DMPI" ) {$_ =~ s/-Dmpi=val/-Dmpi=$mpi/g;}
  if ($mpi == 1 && $_ =~ "^DNUMSBDMNS" ) {$_ =~ s/00010/$sfc_subd/g;}
  if ($mpi == 1 && $_ =~ "^DNPE" ) {$_ =~ s/COMP=1/COMP=$npe/g;}
  push(@outlines, $_);
}
close(FIL);
open(FIL,">$outfil");
print FIL @outlines;
close(FIL);

  my @outlinesp1;
  $outfil = $filsrc . "params_parallel_ocn.F";
  open(FILP1, "$filp1") || die("Could not open file!");
  while (<FILP1>) {
    if ($_ =~ "xxx" ) {$_ =~ s/xxx/ocn/g;}
    push(@outlinesp1, $_);
  }
  close(FILP1);
  open(FILP1,">$outfil");
  print FILP1 @outlinesp1;
  close(FILP1);
  my @outlinep2s;
  $outfil = $filsrc . "params_grid_horizontal_ocn.F";
  open(FILP2, "$filp2") || die("Could not open file!");
  while (<FILP2>) {
    if ($_ =~ "xxx" ) {$_ =~ s/xxx/ocn/g;}
    push(@outlinep2s, $_);
  }
  close(FILP2);
  open(FILP2,">$outfil");
  print FILP2 @outlinep2s;
  close(FILP2);
  my @outlinesg1;
  $outfil = $filsrc . "grid_metrics_variables_ocn.F";
  open(FILG1, "$filg1") || die("Could not open file!");
  while (<FILG1>) {
    if ($_ =~ "xxx" ) {$_ =~ s/xxx/ocn/g;}
    push(@outlinesg1, $_);
  }
  close(FILG1);
  open(FILG1,">$outfil");
  print FILG1 @outlinesg1;
  close(FILG1);
  my @outlinesg2;
  $outfil = $filsrc . "grid_mask_variables_ocn.F";
  open(FILG2, "$filg2") || die("Could not open file!");
  while (<FILG2>) {
    if ($_ =~ "xxx" ) {$_ =~ s/xxx/ocn/g;}
    push(@outlinesg2, $_);
  }
  close(FILG2);
  open(FILG2,">$outfil");
  print FILG2 @outlinesg2;
  close(FILG2);
  if ($ocean == 1) {  # ocean file
    my @outlineshl;
    $outfil = $filsrc . "operators_hl_ocn.F";
    open(FILHL, "$filhl") || die("Could not open file!");
    while (<FILHL>) {
      if ($_ =~ "xxx" ) {$_ =~ s/xxx/ocn/g;}
      push(@outlineshl, $_);
    }
    close(FILHL);
    open(FILHL,">$outfil");
    print FILHL @outlineshl;
  }

}

#if ($ocean == 1) {  # if ocean selected, do ice also
# if ocean selected, do ice also
if (($ocean == 1) || ($ocean == 0 && $ice == 1)) {  

  { #edit block
  my @outlines;
  $fil = $doedir . "/ice/compile/Makefile.model";
    $filsrc = $doedir . "/ice/source/";
  $outfil = $fil . ".1";
  open(FIL, "$fil") || die("Could not open file!");
  while (<FIL>) {
    if ($_ =~ "^RESOLUTION" ) {$_ =~ s/resval/$sfcres/g;}
    if ($_ =~ "^DMPI" ) {$_ =~ s/-Dmpi=val/-Dmpi=$mpi/g;}
    if ($mpi == 1 && $_ =~ "^DNUMSBDMNS" ) {$_ =~ s/00010/$sfc_subd/g;}
    if ($mpi == 1 && $_ =~ "^DNPE" ) {$_ =~ s/COMP=1/COMP=$npe/g;}
    push(@outlines, $_);
  }
  close(FIL);
  open(FIL,">$outfil");
  print FIL @outlines;
  close(FIL);

  my @outlinesp1;
  $outfil = $filsrc . "params_parallel_ice.F";
  open(FILP1, "$filp1") || die("Could not open file!");
  while (<FILP1>) {
    if ($_ =~ "xxx" ) {$_ =~ s/xxx/ice/g;}
    push(@outlinesp1, $_);
  }
  close(FILP1);
  open(FILP1,">$outfil");
  print FILP1 @outlinesp1;
  close(FILP1);
  my @outlinesp2;
  $outfil = $filsrc . "params_grid_horizontal_ice.F";
  open(FILP2, "$filp2") || die("Could not open file!");
  while (<FILP2>) {
    if ($_ =~ "xxx" ) {$_ =~ s/xxx/ice/g;}
    push(@outlinesp2, $_);
  }
  close(FILP2);
  open(FILP2,">$outfil");
  print FILP2 @outlinesp2;
  close(FILP2);
  my @outlinesg1;
  $outfil = $filsrc . "grid_metrics_variables_ice.F";
  open(FILG1, "$filg1") || die("Could not open file!");
  while (<FILG1>) {
    if ($_ =~ "xxx" ) {$_ =~ s/xxx/ice/g;}
    push(@outlinesg1, $_);
  }
  close(FILG1);
  open(FILG1,">$outfil");
  print FILG1 @outlinesg1;
  close(FILG1);
  my @outlinesg2;
  $outfil = $filsrc . "grid_mask_variables_ice.F";
  open(FILG2, "$filg2") || die("Could not open file!");
  while (<FILG2>) {
    if ($_ =~ "xxx" ) {$_ =~ s/xxx/ice/g;}
    push(@outlinesg2, $_);
  }
  close(FILG2);
  open(FILG2,">$outfil");
  print FILG2 @outlinesg2;
  close(FILG2);
  my @outlinesrp;
  $outfil = $filsrc . "remap_ice.F";
  open(FILRP, "$filrp") || die("Could not open file!");
  while (<FILRP>) {
    if ($_ =~ "xxx" ) {$_ =~ s/xxx/ice/g;}
    push(@outlinesrp, $_);
  }
  close(FILRP);
  open(FILRP,">$outfil");
  print FILRP @outlinesrp;
  close(FILRP);

  }
}

# coupler Makefile
$oldatmtype = 'atm.BUGS5/compile.BUGS5';
if ($atm == 0) {
  $atmtype = 'atm.dummy/compile';
  $atmval = 0;
} elsif ($atm == 1) {
  $atmtype = 'atm.BUGS5/compile.BUGS5';
  $atmval = 0;
} elsif ($atm == 2) {
  $atmtype = 'atmos.BUGS6/compile';
  $atmval = 1;
}
if ($atm == 0) {
  $atmd = 1;
} else {
  $atmd = 0;
} 
if ($ocean == 1) {
  $ocn = 0;
} else {
  $ocn = 1;
} 
{ #edit block
my @outlines;
$fil = $doedir . "/coupler/compile/Makefile.model";
    $filsrc = $doedir . "/coupler/source/";
$outfil = $fil . ".1";
open(FIL, "$fil") || die("Could not open file!");
while (<FIL>) {
  if ($_ =~ "^ATM_RESOLUTION" ) {$_ =~ s/resval/$atmres/g;}
  if ($_ =~ "^SFC_RESOLUTION" ) {$_ =~ s/resval/$sfcres/g;}
  if ($_ =~ "^DBUGS" ) {$_ =~ s/-Dbugs6=val/-Dbugs6=$atmval/g;}
  if ($_ =~ "^DMPI" ) {$_ =~ s/-Dmpi=val/-Dmpi=$mpi/g;}
  if ($_ =~ "^DOCEANDUMMY" ) {$_ =~ s/dummy=val/dummy=$ocn/g;}
  if ($_ =~ "^DATMDUMMY" ) {$_ =~ s/-Datm_dummy=val/-Datm_dummy=$atmd/g;}
  if ($_ =~ "^DACTIVESEAICE" ) {$_ =~ s/seaice=val/seaice=$ice/g;}
  if ($_ =~ "^DSIBVERSION" ) {$_ =~ s/sibversion=val/sibversion=$sib/g;}
  if ($_ =~ "^MODBUGS" ) {$_ =~ s/$oldatmtype/$atmtype/g;}
  if ($_ =~ "^MODSIB" ) {$_ =~ s/SiBval/SiB$sib/g;}
  
  if ($mpi == 1 && $_ =~ "^DNPE" ) {$_ =~ s/COMP=1/COMP=$npe/g;}
  if ($mpi == 1 && $_ =~ "^DATM_NUMSBDMNS" ) {$_ =~ s/00010/$atm_subd/g;}
  if ($mpi == 1 && $_ =~ "^DSFC_NUMSBDMNS" ) {$_ =~ s/00010/$sfc_subd/g;}

  push(@outlines, $_);
}
close(FIL);
open(FIL,">$outfil");
print FIL @outlines;
close(FIL);

  my @outlinesp1;
  $outfil = $filsrc . "params_parallel_cpl.F";
  open(FILP1, "$filp1") || die("Could not open file!");
  while (<FILP1>) {
    if ($_ =~ "xxx" ) {$_ =~ s/xxx/cpl/g;}
    push(@outlinesp1, $_);
  }
  close(FILP1);
  open(FILP1,">$outfil");
  print FILP1 @outlinesp1;
  close(FILP1);

}

# coupler_driver Makefile
if ($ocean == 0) {
  $ocntype = 'ocean.dummy';
} else {
  $ocntype = 'ocean';
}
if ($atm == 0) {
  $atmtype = 'atm.dummy';
} elsif ($atm == 1) {
  $atmtype = 'atm.BUGS5';
} else {
  $atmtype = 'atmos.BUGS6';
}
{ #edit block
my @outlines;
$fil = $doedir . "/coupler_driver/compile/Makefile.model";
$outfil = $fil . ".1";
open(FIL, "$fil") || die("Could not open file!");
  while (<FIL>) {
    if ($_ =~ "^DMPI" ) {$_ =~ s/-Dmpi=val/-Dmpi=$mpi/g;}
    if ($_ =~ "^DOCEANDUMMY" ) {$_ =~ s/-Docean_dummy=val/-Docean_dummy=$ocn/g;}
    if ($_ =~ "^MODATM" ) {$_ =~ s/atmtype/$atmtype/g;}
    if ($_ =~ "^MODBUGS" ) {$_ =~ s/atmtype/$atmtype/g;}
    if ($_ =~ "^MODOCN" ) {$_ =~ s/ocntype/$ocntype/g;}
    if ($_ =~ "^MODSIB" ) {$_ =~ s/sibversion/SiB$sib/g;}
    if ($_ =~ "^USRLIBS" ) {$_ =~ s/thelibs/$thelibs/g;}
    push(@outlines, $_);
  }
close(FIL);
open(FIL,">$outfil");
print FIL @outlines;
close(FIL);
}

}   # modmake if block


#---> makefile mods done -- now compile the model

# first set compile mode (debug or fully optimized)
# >>> currently using gmake for SGI compilation NEED TO GENERALIZE
if ($^O eq 'irix') {
  $makec = 'gmake';
  $gmakecom = 'gmake';
  if ($cmode == 0) {
    $gmakecom = $gmakecom .= ' DEBUG=true';
  }
}elsif ($^O eq 'linux') {
  $makec = 'gmake';
  $gmakecom = 'gmake';
  if ($cmode == 0) {
    $gmakecom = $gmakecom .= ' DEBUG=true';
  }
  if ($pgi == 0) {
    if ($altix == 1) {
      $gmakecom = $gmakecom .= ' ALTIX=true';
    }
  }
  if ($pgi == 1) {
    $gmakecom = $gmakecom .= ' PGI_COMP=true';
    if ($unicos == 1) {
      $gmakecom = $gmakecom .= ' UNICOS=true';
    }
  }
  if ($pgi == 2) {
    $gmakecom = $gmakecom .= ' PATHSCALE_COMP=true';
  }
  if ($pgi == 3) {
    $gmakecom = $gmakecom .= ' GFORTRAN_COMP=true';
  }
}elsif ($^O eq 'aix') {
  $makec = 'gmake';
  $gmakecom = 'gmake';
  if ($cmode == 0) {
    $gmakecom = $gmakecom .= ' DEBUG=true';
  }
} elsif ($^O eq 'darwin') {
  $makec = 'make';
  $gmakecom = 'make';
  if ($cmode == 0) {
    $gmakecom = $gmakecom .= ' DEBUG=true';
  }
  if ($xlf == 0) {
    $gmakecom = $gmakecom .= ' ABSOFT_COMP=true';
  } 
  if ($xlf == 2)  {
    $gmakecom = $gmakecom .= ' INTEL_COMP=true';
  } 
  if ($xlf == 3)  {
    $gmakecom = $gmakecom .= ' GFORTRAN_COMP=true';
  }
  if ($slikrock == 1) {
    $gmakecom = $gmakecom .= ' SLIKROCK_CPP=true';
  }
}

# now compile the code in each model component compile subdir
$curdir = $doedir . '/utilities/compile';
chdir "$curdir";
if ($clobber) {`$makec clobber`;}
$retval = `$gmakecom`;
print "$retval\n"; 

$libfile = $doedir . "/lib/libutil.a";
if (-e $libfile) {
  print "*** utilities successfully compiled *** \n";
} else {
  print "*** Error compiling utilities -- stopping\n";
  exit 1;
}

if ($sib == 2) { 

  chdir '../../SiB2/compile'; 
  if ($clobber) {`$makec clobber`;}
  $retval = `$gmakecom`;
  print "$retval\n"; 
  $libfile = $doedir . "/lib/libsib.a";
  if (-e $libfile) {
    print "*** sib successfully compiled *** \n";
  } else {
    print "*** Error compiling atm -- stopping\n";
    exit 1;
  }
  
} else {

  chdir '../../SiB3/compile';
  if ($clobber) {`$makec clobber`;}
  $retval = `$gmakecom`;
  print "$retval\n"; 

  $libfile = $doedir . "/lib/libsib.a";
  if (-e $libfile) {
    print "*** sib successfully compiled *** \n";
  } else {
    print "*** Error compiling atm -- stopping\n";
    exit 1;
  }

}

if ($atm == 0) { 

  chdir '../../atm.dummy/compile'; 
  if ($clobber) {`$makec clobber`;}
  $retval = `$gmakecom`;
  print "$retval\n"; 
  $libfile = $doedir . "/lib/libatm.a";
  if (-e $libfile) {
    print "*** atm successfully compiled *** \n";
  } else {
    print "*** Error compiling atm -- stopping\n";
    exit 1;
  }
  
} elsif ($atm == 1) {

  chdir '../../atm.BUGS5/compile.BUGS5';   
  if ($clobber) {`$makec clobber`;}
  $retval = `$gmakecom`;
  print "$retval\n"; 

  $libfile = $doedir . "/lib/libBUGS5.a";
  if (-e $libfile) {
    print "*** BUGS5 successfully compiled *** \n";
  } else {
    print "*** Error compiling BUGS5 -- stopping\n";
    exit 1;
  }

  chdir '../compile'; 
  if ($clobber) {`$makec clobber`;}
  $retval = `$gmakecom`;
  print "$retval\n"; 

  $libfile = $doedir . "/lib/libatm.a";
  if (-e $libfile) {
    print "*** atm successfully compiled *** \n";
  } else {
    print "*** Error compiling atm -- stopping\n";
    exit 1;
  }

} else {

  chdir '../../atmos.BUGS6/compile';
  if ($clobber) {`$makec clobber`;}
  $retval = `$gmakecom`;
  print "$retval\n"; 

  $libfile = $doedir . "/lib/libatm.a";
  if (-e $libfile) {
    print "*** atm successfully compiled *** \n";
  } else {
    print "*** Error compiling atm -- stopping\n";
    exit 1;
  }

}

# ice: if ocean selected, do ice also
if (($ocean == 1) || ($ocean == 0 && $ice == 1)) {
  chdir '../../ice/compile';
  if ($clobber) {`$makec clobber`;}
  $retval = `$gmakecom`;
  print "$retval\n";
 
  $libfile = $doedir . "/lib/libice.a";
  if (-e $libfile) {
    print "*** ice successfully compiled *** \n";
  } else {
    print "*** Error compiling ice -- stopping\n";
    exit 1;
  }
}

# ocean
if ($ocean == 0) {
  chdir '../../ocean.dummy/compile';

  if ($clobber) {`$makec clobber`;}
  $retval = `$gmakecom`;
  print "$retval\n"; 
} else {
  chdir '../../ocean/compile';
  if ($clobber) {`$makec clobber`;}
  $retval = `$gmakecom`;
  print "$retval\n"; 
}

$libfile = $doedir . "/lib/libocean.a";
if (-e $libfile) {
  print "*** ocean successfully compiled *** \n";
} else {
  print "*** Error compiling ocean -- stopping\n";
  exit 1;
}

chdir '../../coupler/compile';
if ($clobber) {`$makec clobber`;}
$retval = `$gmakecom`;
print "$retval\n"; 

$libfile = $doedir . "/lib/libcpl.a";
if (-e $libfile) {
  print "*** coupler successfully compiled *** \n";
} else {
  print "*** Error compiling coupler -- stopping\n";
  exit 1;
}

chdir '../../coupler_driver/compile';
#if ($clobber) {`$makec clobber`;}
`$makec clobber`;
$retval = `$gmakecom`;
print "$retval\n"; 
#`rm Makefile.model`;

