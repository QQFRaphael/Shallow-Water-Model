V23 esmf_regridmod
67 /raid/don/doe_ca/esmf/src/Infrastructure/Regrid/src/ESMF_Regrid.F90 S527
05/10/2004  11:00:25
use esmf_routemod private
use esmf_basemod private
use esmf_rhandlemod private
use esmf_delayoutmod private
use esmf_datamapmod private
use esmf_gridtypesmod private
use esmf_arraymod private
use esmf_regridtypesmod private
enduse
D 114 24 649 4 648 3
D 241 24 1150 120 1149 3
D 411 24 1667 8 1666 3
D 417 24 1672 8 1671 3
D 3088 24 6063 4 6062 3
D 3097 24 6068 8 6067 3
D 4540 24 8087 4 8086 3
D 4820 18 8929
D 4884 24 8981 8 8980 3
D 5120 24 9259 8 9258 3
D 5653 24 10471 308 10470 3
D 6034 24 11058 4 11057 3
D 6040 21 6 1 0 3 0 0 0 0 0
 0 3 0 3 3 0
S 527 24 0 0 0 8 1 0 3942 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 14 0 0 0 0 0 0 esmf_regridmod
R 648 25 85 esmf_basemod esmf_blockingflag
R 649 5 86 esmf_basemod value
R 1149 25 37 esmf_datamapmod esmf_datamap
R 1150 5 38 esmf_datamapmod status
R 1151 5 39 esmf_datamapmod datarank
R 1152 5 40 esmf_datamapmod isscalar
R 1153 5 41 esmf_datamapmod datadimorder
R 1154 5 42 esmf_datamapmod datanongridcounts
R 1155 5 43 esmf_datamapmod ranklength
R 1156 5 44 esmf_datamapmod interleave
R 1157 5 45 esmf_datamapmod horzrelloc
R 1158 5 46 esmf_datamapmod vertrelloc
R 1666 25 1 esmf_delayoutmod esmf_commhandle
R 1667 5 2 esmf_delayoutmod mpi_handle
R 1668 5 3 esmf_delayoutmod wait
R 1671 25 6 esmf_delayoutmod esmf_delayout
R 1672 5 7 esmf_delayoutmod this
R 6062 25 3 esmf_arraymod esmf_mask
R 6063 5 4 esmf_arraymod maskvals
R 6065 5 6 esmf_arraymod maskvals$p
R 6067 25 8 esmf_arraymod esmf_array
R 6068 5 9 esmf_arraymod this
R 8086 25 69 esmf_gridtypesmod esmf_grid
R 8087 5 70 esmf_gridtypesmod ptr
R 8089 5 72 esmf_gridtypesmod ptr$p
S 8360 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 60 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 8980 25 1 esmf_routemod esmf_route
R 8981 5 2 esmf_routemod this
R 9258 25 20 esmf_rhandlemod esmf_routehandle
R 9259 5 21 esmf_rhandlemod this
R 10470 25 1 esmf_regridtypesmod esmf_regridtype
R 10471 5 2 esmf_regridtypesmod base
R 10472 5 3 esmf_regridtypesmod srcarray
R 10473 5 4 esmf_regridtypesmod dstarray
R 10474 5 5 esmf_regridtypesmod srcgrid
R 10475 5 6 esmf_regridtypesmod dstgrid
R 10476 5 7 esmf_regridtypesmod srcdatamap
R 10477 5 8 esmf_regridtypesmod dstdatamap
R 10478 5 9 esmf_regridtypesmod method
R 10479 5 10 esmf_regridtypesmod numlinks
R 10480 5 11 esmf_regridtypesmod srcadd
R 10482 5 13 esmf_regridtypesmod srcadd$p
R 10484 5 15 esmf_regridtypesmod dstadd
R 10486 5 17 esmf_regridtypesmod dstadd$p
R 10488 5 19 esmf_regridtypesmod weights
R 10490 5 21 esmf_regridtypesmod weights$p
R 10492 5 23 esmf_regridtypesmod redistrboption
R 10493 5 24 esmf_regridtypesmod gather
R 10495 5 26 esmf_regridtypesmod gather$p
R 10497 5 28 esmf_regridtypesmod srcroute
R 10499 5 30 esmf_regridtypesmod srcroute$p
R 10501 5 32 esmf_regridtypesmod dstroute
R 10503 5 34 esmf_regridtypesmod dstroute$p
S 11057 25 0 0 0 6034 1 527 84655 800004 800000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 esmf_regrid
S 11058 5 6 0 0 5653 11060 527 4661 800014 14 0 0 11060 0 6034 0 0 0 0 0 0 0 0 0 0 11059 1 11058 11061 527 0 0 0 0 ptr
S 11059 8 1 0 0 6040 1 527 84667 40822004 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 ptr$sd3
S 11060 5 0 0 0 6 1 527 84675 40802001 1020 0 0 0 0 6034 0 0 0 0 0 0 0 0 0 0 0 11058 11060 0 527 0 0 0 0 ptr$p
S 11061 6 1 0 0 6 1 527 84681 40802011 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 ptr$o
S 11062 27 0 0 0 8 11122 527 84687 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 esmf_arrayregridstore
S 11063 27 0 0 0 8 11135 527 84709 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 esmf_arrayregrid
S 11064 27 0 0 0 8 11147 527 84726 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 esmf_arrayregridrelease
S 11065 27 0 0 0 8 11094 527 84750 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 esmf_regridget
S 11066 27 0 0 0 8 11108 527 84765 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 esmf_regriddestroy
S 11067 27 0 0 0 8 11112 527 84784 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 esmf_regridvalidate
S 11068 27 0 0 0 8 11117 527 84804 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 esmf_regridprint
S 11069 3 0 0 0 4820 0 1 0 0 0 0 0 0 0 84821 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 60 24 49 64 3a 20 45 53 4d 46 5f 52 65 67 72 69 64 2e 46 39 30 2c 76 20 31 2e 37 32 20 32 30 30 34 2f 30 34 2f 33 30 20 32 31 3a 34 32 3a 34 32 20 6a 77 6f 6c 66 65 20 45 78 70 20 24
S 11070 16 0 0 0 4820 1 527 6035 14 40000 0 0 0 0 11069 10162 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 version
S 11071 23 5 0 0 0 11085 527 84882 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_regridcreate
S 11072 1 3 1 0 417 1 11071 84900 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 parentdelayout
S 11073 1 3 0 0 5120 1 11071 84915 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 routehandle
S 11074 1 3 1 0 6 1 11071 84927 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 regridmethod
S 11075 1 3 1 0 6 1 11071 84940 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 normopt
S 11076 1 3 1 0 3088 1 11071 84948 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcmask
S 11077 1 3 1 0 3088 1 11071 84956 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstmask
S 11078 1 3 2 0 6 1 11071 84964 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 11079 1 3 1 0 3097 1 11071 79515 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcarray
S 11080 1 3 0 0 4540 1 11071 79533 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcgrid
S 11081 1 3 1 0 241 1 11071 79549 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcdatamap
S 11082 1 3 0 0 3097 1 11071 79524 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstarray
S 11083 1 3 0 0 4540 1 11071 79541 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstgrid
S 11084 1 3 1 0 241 1 11071 79560 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstdatamap
S 11085 14 5 0 0 0 1 11071 84882 10 400000 0 0 0 4027 13 0 0 0 0 0 0 0 0 0 0 0 0 123 0 527 0 0 0 0 esmf_regridcreate
F 11085 13 11079 11080 11081 11082 11083 11084 11072 11073 11074 11075 11076 11077 11078
S 11086 23 5 0 0 0 11093 527 84967 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_regridrun
S 11087 1 3 1 0 5120 1 11086 84982 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 routehandle
S 11088 1 3 2 0 6 1 11086 84994 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 11089 1 3 1 0 3097 1 11086 79515 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcarray
S 11090 1 3 0 0 3097 1 11086 79524 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstarray
S 11091 1 3 1 0 241 1 11086 79549 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcdatamap
S 11092 1 3 1 0 241 1 11086 79560 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstdatamap
S 11093 14 5 0 0 0 1 11086 84967 10 400000 0 0 0 4041 6 0 0 0 0 0 0 0 0 0 0 0 0 334 0 527 0 0 0 0 esmf_regridrun
F 11093 6 11089 11090 11091 11092 11087 11088
S 11094 23 5 0 0 0 11107 527 84750 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_regridget
S 11095 1 3 0 0 6034 1 11094 84997 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 regrid
S 11096 1 3 2 0 28 1 11094 85004 80000014 43000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 name
S 11097 1 3 2 0 6 1 11094 85009 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 11098 1 3 2 0 3097 1 11094 79515 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcarray
S 11099 1 3 2 0 3097 1 11094 79524 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstarray
S 11100 1 3 2 0 4540 1 11094 79533 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcgrid
S 11101 1 3 2 0 4540 1 11094 79541 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstgrid
S 11102 1 3 2 0 241 1 11094 79549 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcdatamap
S 11103 1 3 2 0 241 1 11094 79560 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstdatamap
S 11104 1 3 2 0 6 1 11094 79571 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 method
S 11105 1 3 2 0 6 1 11094 79578 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 numlinks
S 11106 1 3 2 0 4884 1 11094 79712 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 gather
S 11107 14 5 0 0 0 1 11094 84750 0 400000 0 0 0 4048 12 0 0 0 0 0 0 0 0 0 0 0 0 592 0 527 0 0 0 0 esmf_regridget
F 11107 12 11095 11096 11098 11099 11100 11101 11102 11103 11104 11105 11106 11097
S 11108 23 5 0 0 0 11111 527 84765 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_regriddestroy
S 11109 1 3 0 0 5120 1 11108 85012 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 routehandle
S 11110 1 3 2 0 6 1 11108 85024 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 11111 14 5 0 0 0 1 11108 84765 0 400000 0 0 0 4061 2 0 0 0 0 0 0 0 0 0 0 0 0 736 0 527 0 0 0 0 esmf_regriddestroy
F 11111 2 11109 11110
S 11112 23 5 0 0 0 11116 527 84784 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_regridvalidate
S 11113 1 3 1 0 5120 1 11112 85027 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 routehandle
S 11114 1 3 1 0 28 1 11112 85039 80000014 43000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 opt
S 11115 1 3 2 0 6 1 11112 85043 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 11116 14 5 0 0 0 1 11112 84784 0 400000 0 0 0 4064 3 0 0 0 0 0 0 0 0 0 0 0 0 792 0 527 0 0 0 0 esmf_regridvalidate
F 11116 3 11113 11114 11115
S 11117 23 5 0 0 0 11121 527 84804 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_regridprint
S 11118 1 3 1 0 5120 1 11117 85046 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 routehandle
S 11119 1 3 1 0 28 1 11117 85058 14 43000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 opt
S 11120 1 3 2 0 6 1 11117 85062 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 11121 14 5 0 0 0 1 11117 84804 0 400000 0 0 0 4068 3 0 0 0 0 0 0 0 0 0 0 0 0 827 0 527 0 0 0 0 esmf_regridprint
F 11121 3 11118 11119 11120
S 11122 23 5 0 0 0 11134 527 84687 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_arrayregridstore
S 11123 1 3 0 0 417 1 11122 85065 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 parentdelayout
S 11124 1 3 0 0 5120 1 11122 85080 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 routehandle
S 11125 1 3 1 0 6 1 11122 85092 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 regridtype
S 11126 1 3 1 0 3088 1 11122 85103 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcmask
S 11127 1 3 1 0 3088 1 11122 85111 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstmask
S 11128 1 3 2 0 6 1 11122 85119 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 11129 1 3 1 0 3097 1 11122 79515 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcarray
S 11130 1 3 0 0 4540 1 11122 79533 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcgrid
S 11131 1 3 1 0 241 1 11122 79549 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcdatamap
S 11132 1 3 0 0 4540 1 11122 79541 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstgrid
S 11133 1 3 1 0 241 1 11122 79560 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstdatamap
S 11134 14 5 0 0 0 1 11122 84687 0 400000 0 0 0 4072 11 0 0 0 0 0 0 0 0 0 0 0 0 868 0 527 0 0 0 0 esmf_arrayregridstore
F 11134 11 11129 11130 11131 11132 11133 11123 11124 11125 11126 11127 11128
S 11135 23 5 0 0 0 11146 527 84709 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_arrayregrid
S 11136 1 3 1 0 5120 1 11135 85122 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 routehandle
S 11137 1 3 1 0 3088 1 11135 85134 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcmask
S 11138 1 3 1 0 3088 1 11135 85142 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstmask
S 11139 1 3 1 0 114 1 11135 85150 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 blocking
S 11140 1 3 0 0 411 1 11135 85159 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 commhandle
S 11141 1 3 2 0 6 1 11135 85170 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 11142 1 3 0 0 3097 1 11135 79515 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcarray
S 11143 1 3 0 0 3097 1 11135 79524 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstarray
S 11144 1 3 0 0 241 1 11135 79549 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcdatamap
S 11145 1 3 0 0 241 1 11135 79560 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstdatamap
S 11146 14 5 0 0 0 1 11135 84709 0 400000 0 0 0 4084 10 0 0 0 0 0 0 0 0 0 0 0 0 964 0 527 0 0 0 0 esmf_arrayregrid
F 11146 10 11142 11143 11144 11145 11136 11137 11138 11139 11140 11141
S 11147 23 5 0 0 0 11150 527 84726 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_arrayregridrelease
S 11148 1 3 0 0 5120 1 11147 85173 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 routehandle
S 11149 1 3 2 0 6 1 11147 85185 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 11150 14 5 0 0 0 1 11147 84726 0 400000 0 0 0 4095 2 0 0 0 0 0 0 0 0 0 0 0 0 1042 0 527 0 0 0 0 esmf_arrayregridrelease
F 11150 2 11148 11149
A 8929 2 0 0 0 6 8360 0 0 0 8929 0 0 0 0 0 0 0 0 0
A 10162 2 0 0 6901 4820 11069 0 0 0 10162 0 0 0 0 0 0 0 0 0
Z
