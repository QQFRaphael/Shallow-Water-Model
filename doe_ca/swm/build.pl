#!/usr/bin/perl -w
#
#--- begin user setup ---#
#
# user must set the following variables

$res    = '0010242';   # atm grid resolution (0002562, 0010242, 0040962)
$cmode  = 0;           # 0 = debug mode compile, 1 = optimized
$mpi    = 1;           # 0 or 1
$subd   = '00040';     # number of atm subdomains.  only modified if mpi=1
                       # possible vals:  00010,00040,00160,00640
$npe    = 2;           # number of processors.  only modified if mpi=1
$xlf    = 2;           # on MacOSX 0 = Absoft compiler, 1 = IBM xlf compiler (lam mpi),2=intel/openmpi, 3=gfortran.
$slikrock = 0;           # on MacOSX 0 = cpp (most macs), 1 = cpp3 (slikrock specific).
$pgi    = 0;           # on Linux, 0 = Intel compiler (lam-mpi), 1 = PGI compiler (mpich), 2=pathscale compiler
$altix  = 0;           # for Linux machines, set to 1 only for SGI Altix machines
                       #  ignored if $pgi=1 or 2
$unicos = 0;           # on Linux, set to 1 only for Cray machines, ignored
                       #  unless $pgi=1
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

# also remove all libraries in /lib 
$libdir = $doedir . '/lib';
chdir $libdir;
unlink <*.a>;
#`if (-e $libdir/libutil.a) rm $libdir/libutil.a`;

#if ($xlf == 2 || $xlf == 3) {
if ($xlf == 3) {
  $thelibs = "../../lib/libutil.a ";
} else {
  $thelibs = "-lutil ";
}

# if mpi is to be used, modify the processors_map.in file appropriately
if ($mpi == 1) {
  $fil= $doedir . "/swm/processors_map.in";
  my @outlines;
  $outfil= $doedir . "/swm/run." . $res ."/processors_map.in";
  open(FIL, $fil) || die("Could not open file!");
  my $mynpe = $npe-1;
  while (<FIL>) {
    if ($_ =~ "coupler" )    {$_ = "coupler     0  $mynpe\n";}
    if ($_ =~ "swm" )        {$_ = "swm         0  $mynpe\n";}
    push(@outlines, $_);
  }
  close(FIL);
  open(FIL,">$outfil") || die("Could not open file!");
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

# swm Makefile
{ #edit block
my @outlines;
$fil = $doedir . "/swm/compile/Makefile.model";
    $filsrc = $doedir . "/swm/source/";
$outfil = $fil . ".1";
open(FIL, "$fil") || die("Could not open file!");
while (<FIL>) {
  if ($_ =~ "^RESOLUTION" ) {$_ =~ s/resval/$res/g;}
  if ($_ =~ "^DMPI" ) {$_ =~ s/-Dmpi=val/-Dmpi=$mpi/g;}
  
  if ($mpi == 1 && $_ =~ "^DNPE" ) {$_ =~ s/COMP=1/COMP=$npe/g;}
  if ($mpi == 1 && $_ =~ "^DNUMSBDMNS" ) {$_ =~ s/00010/$subd/g;}
  if ($_ =~ "^USRLIBS" ) {$_ =~ s/thelibs/$thelibs/g;}

  push(@outlines, $_);
}
close(FIL);
open(FIL,">$outfil");
print FIL @outlines;
close(FIL);

$filp1 = $doedir . "/utilities/layer_1/params_parallel.F";
$filp2 = $doedir . "/utilities/layer_1/params_grid_horizontal.F";
$filg1 = $doedir . "/utilities/layer_1/grid_metrics_variables.F";
$filg2 = $doedir . "/utilities/layer_1/grid_mask_variables.F";
$filrp = $doedir . "/utilities/layer_2/remap.F";
$files = $doedir . "/utilities/layer_3/elliptic_solver.F";
$films = $doedir . "/utilities/layer_3/multigrid_solver.F";
$filst = $doedir . "/utilities/layer_3/spectral_transforms.F";
$filoh = $doedir . "/utilities/layer_4/operators_hl.F";

  my @outlinesp1;
  $outfil = $filsrc . "params_parallel_xxx.F";
  open(FILP1, "$filp1") || die("Could not open file!");
  while (<FILP1>) {
    push(@outlinesp1, $_);
  }
  close(FILP1);
  open(FILP1,">$outfil");
  print FILP1 @outlinesp1;
  close(FILP1);
  my @outlinesp2;
  $outfil = $filsrc . "params_grid_horizontal_xxx.F";
  open(FILP2, "$filp2") || die("Could not open file!");
  while (<FILP2>) {
    push(@outlinesp2, $_);
  }
  close(FILP2);
  open(FILP2,">$outfil");
  print FILP2 @outlinesp2;
  close(FILP2);
  my @outlinesg1;
  $outfil = $filsrc . "grid_metrics_variables_xxx.F";
  open(FILG1, "$filg1") || die("Could not open file!");
  while (<FILG1>) {
    push(@outlinesg1, $_);
  }
  open(FILG1,">$outfil");
  print FILG1 @outlinesg1;
  close(FILG1);
  my @outlinesg2;
  $outfil = $filsrc . "grid_mask_variables_xxx.F";
  open(FILG2, "$filg2") || die("Could not open file!");
  while (<FILG2>) {
    push(@outlinesg2, $_);
  }
  close(FILG2);
  open(FILG2,">$outfil");
  print FILG2 @outlinesg2;
  close(FILG2);

  my @outlinesrp;
  $outfil = $filsrc . "remap_xxx.F";
  open(FILRP, "$filrp") || die("Could not open file!");
  while (<FILRP>) {
    push(@outlinesrp, $_);
  }
  close(FILRP);
  open(FILRP,">$outfil");
  print FILRP @outlinesrp;
  close(FILRP);

  my @outlineses;
  $outfil = $filsrc . "elliptic_solver_xxx.F";
  open(FILES, "$files") || die("Could not open file!");
  while (<FILES>) {
    push(@outlineses, $_);
  }
  close(FILES);
  open(FILES,">$outfil");
  print FILES @outlineses;
  close(FILES);

  my @outlinesms;
  $outfil = $filsrc . "multigrid_solver_xxx.F";
  open(FILMS, "$films") || die("Could not open file!");
  while (<FILMS>) {
    push(@outlinesms, $_);
  }
  close(FILMS);
  open(FILMS,">$outfil");
  print FILMS @outlinesms;
  close(FILMS);

  my @outlinesst;
  $outfil = $filsrc . "spectral_transforms_xxx.F";
  open(FILST, "$filst") || die("Could not open file!");
  while (<FILST>) {
    push(@outlinesst, $_);
  }
  close(FILST);
  open(FILST,">$outfil");
  print FILST @outlinesst;
  close(FILST);

  my @outlinesoh;
  $outfil = $filsrc . "operators_hl_xxx.F";
  open(FILOH, "$filoh") || die("Could not open file!");
  while (<FILOH>) {
    push(@outlinesoh, $_);
  }
  close(FILOH);
  open(FILOH,">$outfil");
  print FILOH @outlinesoh;
  close(FILOH);

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

chdir '../../swm/compile';
#if ($clobber) {`$makec clobber`;}
`$makec clobber`;
$retval = `$gmakecom`;
print "$retval\n"; 
#`rm Makefile.model`;

