V23 esmf_regridnearnbrmod
74 /raid/don/doe_ca/esmf/src/Infrastructure/Regrid/src/ESMF_RegridNearNbr.F90 S527
05/10/2004  11:00:22
use esmf_basemod public 0
use esmf_arraymod public 0
use esmf_distgridmod public 0
use esmf_physgridmod public 0
use esmf_gridmod public 0
use esmf_fieldmod public 0
use esmf_bundlemod public 0
use esmf_basemod public 0
use esmf_delayoutmod public 0
use esmf_localarraymod public 0
use esmf_datamapmod public 0
use esmf_arraymod public 0
use esmf_distgridmod public 0
use esmf_physgridmod public 0
use esmf_gridtypesmod public 0
use esmf_gridmod public 0
use esmf_rhandlemod public 0
use esmf_routemod public 0
use esmf_arraycommmod public 0
use esmf_regridtypesmod public 0
enduse
D 4165 24 8187 4 8186 3
D 4318 24 8654 4 8653 3
D 4877 24 9696 308 9695 3
D 4904 18 8303
S 527 24 0 0 0 8 1 0 3942 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 14 0 0 0 0 0 0 esmf_regridnearnbrmod
R 8186 25 33 esmf_fieldmod esmf_field
R 8187 5 34 esmf_fieldmod ftypep
R 8189 5 36 esmf_fieldmod ftypep$p
R 8653 25 44 esmf_bundlemod esmf_bundle
R 8654 5 45 esmf_bundlemod btypep
R 8656 5 47 esmf_bundlemod btypep$p
R 9695 25 1 esmf_regridtypesmod esmf_regridtype
R 9696 5 2 esmf_regridtypesmod base
R 9697 5 3 esmf_regridtypesmod srcarray
R 9698 5 4 esmf_regridtypesmod dstarray
R 9699 5 5 esmf_regridtypesmod srcgrid
R 9700 5 6 esmf_regridtypesmod dstgrid
R 9701 5 7 esmf_regridtypesmod srcdatamap
R 9702 5 8 esmf_regridtypesmod dstdatamap
R 9703 5 9 esmf_regridtypesmod method
R 9704 5 10 esmf_regridtypesmod numlinks
R 9705 5 11 esmf_regridtypesmod srcadd
R 9707 5 13 esmf_regridtypesmod srcadd$p
R 9709 5 15 esmf_regridtypesmod dstadd
R 9711 5 17 esmf_regridtypesmod dstadd$p
R 9713 5 19 esmf_regridtypesmod weights
R 9715 5 21 esmf_regridtypesmod weights$p
R 9717 5 23 esmf_regridtypesmod redistrboption
R 9718 5 24 esmf_regridtypesmod gather
R 9720 5 26 esmf_regridtypesmod gather$p
R 9722 5 28 esmf_regridtypesmod srcroute
R 9724 5 30 esmf_regridtypesmod srcroute$p
R 9726 5 32 esmf_regridtypesmod dstroute
R 9728 5 34 esmf_regridtypesmod dstroute$p
S 9833 19 0 0 0 8 1 527 74353 4000 0 0 0 0 0 0 0 0 0 0 0 0 0 616 2 0 0 0 0 0 527 0 0 0 0 esmf_regridconstructnearnbr
O 9833 2 9838 9837
S 9834 3 0 0 0 6 0 1 0 0 0 0 0 0 0 0 67 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 9835 3 0 0 0 4904 0 1 0 0 0 0 0 0 0 74381 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 67 24 49 64 3a 20 45 53 4d 46 5f 52 65 67 72 69 64 4e 65 61 72 4e 62 72 2e 46 39 30 2c 76 20 31 2e 31 33 20 32 30 30 34 2f 30 34 2f 30 39 20 31 37 3a 30 30 3a 35 33 20 6a 77 6f 6c 66 65 20 45 78 70 20 24
S 9836 16 0 0 0 4904 1 527 5856 14 40000 0 0 0 0 9835 8304 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 version
S 9837 27 0 0 0 8 9839 527 74449 10000 0 0 0 617 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 esmf_regridconsbyfieldnearnbr
Q 9837 9833 0
S 9838 27 0 0 0 8 9847 527 74479 10000 0 0 0 618 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 esmf_regridconsbybundlenearnbr
Q 9838 9833 0
S 9839 23 5 0 0 8 9845 527 74449 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_regridconsbyfieldnearnbr
S 9840 1 3 1 0 4165 1 9839 74510 4 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 src_field
S 9841 1 3 1 0 4165 1 9839 74520 4 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dst_field
S 9842 1 3 1 0 28 1 9839 74530 4 43000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 name
S 9843 1 3 1 0 6 1 9839 74535 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 num_nbrs
S 9844 1 3 2 0 6 1 9839 74544 4 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 9845 14 5 0 0 4877 1 9839 74449 4 400000 0 0 0 3631 5 0 0 9846 0 0 0 0 0 0 0 0 0 95 0 527 0 0 0 0 esmf_regridconsbyfieldnearnbr
F 9845 5 9840 9841 9842 9843 9844
S 9846 1 3 0 0 4877 1 9839 74449 4 1003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_regridconsbyfieldnearnbr
S 9847 23 5 0 0 8 9852 527 74479 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_regridconsbybundlenearnbr
S 9848 1 3 1 0 4318 1 9847 74547 4 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 src_bundle
S 9849 1 3 1 0 4318 1 9847 74558 4 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dst_bundle
S 9850 1 3 1 0 28 1 9847 74569 4 43000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 name
S 9851 1 3 2 0 6 1 9847 74574 4 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 9852 14 5 0 0 4877 1 9847 74479 4 400000 0 0 0 3637 4 0 0 9853 0 0 0 0 0 0 0 0 0 376 0 527 0 0 0 0 esmf_regridconsbybundlenearnbr
F 9852 4 9848 9849 9850 9851
S 9853 1 3 0 0 4877 1 9847 74479 4 1003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_regridconsbybundlenearnbr
A 8303 2 0 0 4289 6 9834 0 0 0 8303 0 0 0 0 0 0 0 0 0
A 8304 2 0 0 8063 4904 9835 0 0 0 8304 0 0 0 0 0 0 0 0 0
Z
