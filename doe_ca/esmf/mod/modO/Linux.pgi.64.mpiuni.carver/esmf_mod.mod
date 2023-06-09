V24 esmf_mod
81 /global/u2/d/dazlich/cpl40-40/doe_ca/esmf/src/Superstructure/ESMFMod/src/ESMF.F90 S582 0
11/22/2010  10:54:54
use esmf_utilmod public 0 direct
use esmf_initmacrosmod public 0 direct
use esmf_f90interfacemod public 0 direct
use esmf_fortranwordsizemod public 0 direct
use esmf_typekindgetmod public 0 direct
use esmf_fractionmod public 0 direct
use esmf_basetimemod public 0 direct
use esmf_timeintervalmod public 0 direct
use esmf_timemod public 0 direct
use esmf_alarmmod public 0 direct
use esmf_clockmod public 0 direct
use esmf_arrayspecmod public 0 direct
use esmf_localarraycreatemod public 0 indirect
use esmf_localarraygetmod public 0 indirect
use esmf_localarraymod public 0 direct
use esmf_internarraydatamapmod public 0 direct
use esmf_distgridmod public 0 direct
use esmf_arraymod public 0 direct
use esmf_arraybundlemod public 0 direct
use esmf_internarraymod public 0 direct
use esmf_internarraycreatemod public 0 direct
use esmf_internarraygetmod public 0 direct
use esmf_interndgmod public 0 direct
use esmf_gridmod public 0 direct
use esmf_staggerlocmod public 0 direct
use esmf_xpacketmod public 0 direct
use esmf_commtablemod public 0 direct
use esmf_rtablemod public 0 direct
use esmf_routemod public 0 direct
use esmf_rhandlemod public 0 direct
use esmf_fieldmod public 0 direct
use esmf_fieldprmod public 0 direct
use esmf_fieldgetmod public 0 direct
use esmf_fieldsetmod public 0 direct
use esmf_fieldcreatemod public 0 direct
use esmf_fieldbundlemod public 0 direct
use esmf_attributemod public 0 direct
use esmf_statetypesmod public 0 direct
use esmf_statemod public 0 direct
use esmf_statereconcilemod public 0 direct
use esmf_compmod public 0 direct
use esmf_gridcompmod public 0 direct
use esmf_cplcompmod public 0 direct
use esmf_basemod public 0 direct
use esmf_iospecmod public 0 direct
use esmf_utiltypesmod public 0 direct
use esmf_logerrmod public 0 direct
use esmf_configmod public 0 direct
use esmf_vmmod public 0 direct
use esmf_delayoutmod public 0 direct
use esmf_calendarmod public 0 direct
use esmf_initmod public 0 direct
use esmf_alarmtypemod private
use esmf_alarmtypemod private
enduse
D 46 24 751 4 750 3
D 52 24 767 8 766 7
D 58 24 773 4 772 3
D 70 24 815 36 814 3
D 78 18 13
D 80 18 14
D 82 18 15
D 84 18 16
D 86 18 17
D 88 18 18
D 90 18 19
D 92 18 20
D 94 18 21
D 96 18 22
D 98 18 23
D 127 24 905 4 904 3
D 133 24 911 4 910 3
D 139 24 927 4 926 3
D 145 24 933 4 932 3
D 151 24 941 4 940 3
D 157 24 949 4 948 3
D 163 24 955 4 954 3
D 169 24 963 4 962 3
D 175 24 969 4 968 3
D 181 24 975 4 974 3
D 187 24 981 4 980 3
D 390 24 1231 4 1230 3
D 396 24 1239 4 1238 3
D 402 24 1247 4 1246 3
D 1632 24 1928 4 1927 3
D 1638 24 1936 4 1935 3
D 2168 24 2061 4 2060 3
D 3280 24 2940 4 2939 3
D 3880 24 3336 4 3335 3
D 4082 24 3418 4 3417 3
D 4088 24 3430 4 3429 3
D 8001 24 8808 4 8807 3
D 8013 24 8819 4 8818 3
D 8019 24 8849 4 8848 3
D 8782 24 10362 4 10361 3
D 9061 24 10661 4 10660 3
D 9723 24 11429 4 11428 3
D 14599 24 19129 4 19128 3
D 18525 24 23635 4 23634 3
D 18776 24 23753 4 23752 3
D 18782 24 23763 4 23762 3
D 20069 24 25363 4 25362 3
D 20075 24 25369 4 25368 3
D 24795 24 32802 4 32801 3
D 25213 24 33347 4 33346 3
D 25219 24 33357 4 33356 3
D 25225 24 33379 4 33378 3
D 25231 24 33385 4 33384 3
D 25237 24 33393 4 33392 3
D 25243 24 33399 4 33398 3
D 26852 24 34517 4 34516 3
D 26858 24 34523 4 34522 3
D 27799 18 13
D 27801 18 14
D 27803 18 15
D 27805 18 16
D 27807 18 17
D 27809 18 18
D 27811 18 19
D 27813 18 20
D 27815 18 21
D 27817 18 22
D 27819 18 23
S 582 24 0 0 0 8 1 0 4659 10005 0 0 0 0 0 0 0 0 0 93 0 0 0 0 0 0 0 0 15 0 0 0 0 0 0 esmf_mod
S 633 3 0 0 0 6 1 1 0 0 0 0 0 0 0 -1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 635 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 7 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 636 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 637 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 8 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 640 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 641 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 642 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 5 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 643 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 6 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 645 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 9 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 646 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 647 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 90 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 648 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 91 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 649 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 99 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 650 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 18 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 651 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 25 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 652 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 32 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 653 3 0 0 0 27799 1 1 0 0 0 0 0 0 0 5612 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 42 61 73 65
S 654 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 11 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 655 3 0 0 0 27801 1 1 0 0 0 0 0 0 0 5622 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 49 4f 53 70 65 63
S 656 3 0 0 0 27801 1 1 0 0 0 0 0 0 0 5634 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 4c 6f 67 45 72 72
S 657 3 0 0 0 27799 1 1 0 0 0 0 0 0 0 5646 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 54 69 6d 65
S 658 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 13 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 659 3 0 0 0 27803 1 1 0 0 0 0 0 0 0 5656 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 43 61 6c 65 6e 64 61 72
S 660 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 17 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 661 3 0 0 0 27805 1 1 0 0 0 0 0 0 0 5670 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 54 69 6d 65 49 6e 74 65 72 76 61 6c
S 662 3 0 0 0 27807 1 1 0 0 0 0 0 0 0 5688 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 41 6c 61 72 6d
S 663 3 0 0 0 27807 1 1 0 0 0 0 0 0 0 5699 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 43 6c 6f 63 6b
S 664 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 665 3 0 0 0 27809 1 1 0 0 0 0 0 0 0 5710 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 41 72 72 61 79 53 70 65 63
S 666 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 667 3 0 0 0 27811 1 1 0 0 0 0 0 0 0 5725 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 15 45 53 4d 46 5f 4c 6f 63 61 6c 41 72 72 61 79
S 668 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 669 3 0 0 0 27813 1 1 0 0 0 0 0 0 0 5741 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 41 72 72 61 79 42 75 6e 64 6c 65
S 670 3 0 0 0 27815 1 1 0 0 0 0 0 0 0 5758 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 7 45 53 4d 46 5f 56 4d
S 671 3 0 0 0 27803 1 1 0 0 0 0 0 0 0 5766 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 44 45 4c 61 79 6f 75 74
S 672 3 0 0 0 27801 1 1 0 0 0 0 0 0 0 5780 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 43 6f 6e 66 69 67
S 673 3 0 0 0 27807 1 1 0 0 0 0 0 0 0 5792 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 41 72 72 61 79
S 674 3 0 0 0 27803 1 1 0 0 0 0 0 0 0 5803 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 49 6e 74 65 72 6e 44 47
S 675 3 0 0 0 27809 1 1 0 0 0 0 0 0 0 5817 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 43 6f 6d 6d 54 61 62 6c 65
S 676 3 0 0 0 27811 1 1 0 0 0 0 0 0 0 5832 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 15 45 53 4d 46 5f 52 6f 75 74 65 54 61 62 6c 65
S 677 3 0 0 0 27807 1 1 0 0 0 0 0 0 0 5848 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 52 6f 75 74 65
S 678 3 0 0 0 27813 1 1 0 0 0 0 0 0 0 5859 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 52 6f 75 74 65 48 61 6e 64 6c 65
S 679 3 0 0 0 27805 1 1 0 0 0 0 0 0 0 5876 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 46 69 65 6c 64 44 61 74 61 4d 61 70
S 680 3 0 0 0 27807 1 1 0 0 0 0 0 0 0 5894 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 46 69 65 6c 64
S 681 3 0 0 0 27813 1 1 0 0 0 0 0 0 0 5905 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 46 69 65 6c 64 42 75 6e 64 6c 65
S 682 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 20 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 683 3 0 0 0 27817 1 1 0 0 0 0 0 0 0 5922 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 20 45 53 4d 46 5f 54 72 61 6e 73 66 6f 72 6d 56 61 6c 75 65 73
S 684 3 0 0 0 27801 1 1 0 0 0 0 0 0 0 5943 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 52 65 67 72 69 64
S 685 3 0 0 0 27809 1 1 0 0 0 0 0 0 0 5955 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 54 72 61 6e 73 66 6f 72 6d
S 686 3 0 0 0 27807 1 1 0 0 0 0 0 0 0 5970 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 53 74 61 74 65
S 687 3 0 0 0 27819 1 1 0 0 0 0 0 0 0 5981 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 18 45 53 4d 46 5f 47 72 69 64 43 6f 6d 70 6f 6e 65 6e 74
S 688 3 0 0 0 27805 1 1 0 0 0 0 0 0 0 6000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 43 70 6c 43 6f 6d 70 6f 6e 65 6e 74
S 689 3 0 0 0 27809 1 1 0 0 0 0 0 0 0 6018 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 43 6f 6d 70 6f 6e 65 6e 74
S 690 3 0 0 0 27813 1 1 0 0 0 0 0 0 0 6033 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 49 6e 74 65 72 6e 41 72 72 61 79
S 691 3 0 0 0 27799 1 1 0 0 0 0 0 0 0 6050 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 4e 6f 6e 65
S 703 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 12 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 709 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 21 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 711 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 22 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 713 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 23 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 715 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 24 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 718 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 26 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 720 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 28 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 722 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 29 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 724 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 30 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 726 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 31 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 729 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 33 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 731 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 34 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 733 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 35 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 735 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 36 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 750 25 13 esmf_utiltypesmod esmf_status
R 751 5 14 esmf_utiltypesmod status esmf_status
R 753 6 16 esmf_utiltypesmod esmf_status_uninit$ac
R 755 6 18 esmf_utiltypesmod esmf_status_ready$ac
R 757 6 20 esmf_utiltypesmod esmf_status_unallocated$ac
R 759 6 22 esmf_utiltypesmod esmf_status_allocated$ac
R 761 6 24 esmf_utiltypesmod esmf_status_busy$ac
R 763 6 26 esmf_utiltypesmod esmf_status_invalid$ac
R 765 6 28 esmf_utiltypesmod esmf_status_not_ready$ac
R 766 25 29 esmf_utiltypesmod esmf_pointer
R 767 5 30 esmf_utiltypesmod ptr esmf_pointer
R 769 6 32 esmf_utiltypesmod esmf_null_pointer$ac
R 771 6 34 esmf_utiltypesmod esmf_bad_pointer$ac
R 772 25 35 esmf_utiltypesmod esmf_typekind
R 773 5 36 esmf_utiltypesmod dkind esmf_typekind
R 775 6 38 esmf_utiltypesmod esmf_typekind_i1$ac
R 777 6 40 esmf_utiltypesmod esmf_typekind_i2$ac
R 779 6 42 esmf_utiltypesmod esmf_typekind_i4$ac
R 781 6 44 esmf_utiltypesmod esmf_typekind_i8$ac
R 783 6 46 esmf_utiltypesmod esmf_typekind_r4$ac
R 785 6 48 esmf_utiltypesmod esmf_typekind_r8$ac
R 787 6 50 esmf_utiltypesmod esmf_c8$ac
R 789 6 52 esmf_utiltypesmod esmf_c16$ac
R 791 6 54 esmf_utiltypesmod esmf_typekind_logical$ac
R 793 6 56 esmf_utiltypesmod esmf_typekind_character$ac
R 795 6 58 esmf_utiltypesmod esmf_typekind_i$ac
R 797 6 60 esmf_utiltypesmod esmf_typekind_r$ac
R 799 6 62 esmf_utiltypesmod esmf_nokind$ac
R 814 25 77 esmf_utiltypesmod esmf_objectid
R 815 5 78 esmf_utiltypesmod objectid esmf_objectid
R 816 5 79 esmf_utiltypesmod objectname esmf_objectid
R 818 6 81 esmf_utiltypesmod esmf_id_base$ac
R 820 6 83 esmf_utiltypesmod esmf_id_iospec$ac
R 822 6 85 esmf_utiltypesmod esmf_id_logerr$ac
R 824 6 87 esmf_utiltypesmod esmf_id_time$ac
R 826 6 89 esmf_utiltypesmod esmf_id_calendar$ac
R 828 6 91 esmf_utiltypesmod esmf_id_timeinterval$ac
R 830 6 93 esmf_utiltypesmod esmf_id_alarm$ac
R 832 6 95 esmf_utiltypesmod esmf_id_clock$ac
R 834 6 97 esmf_utiltypesmod esmf_id_arrayspec$ac
R 836 6 99 esmf_utiltypesmod esmf_id_localarray$ac
R 838 6 101 esmf_utiltypesmod esmf_id_arraybundle$ac
R 840 6 103 esmf_utiltypesmod esmf_id_vm$ac
R 842 6 105 esmf_utiltypesmod esmf_id_delayout$ac
R 844 6 107 esmf_utiltypesmod esmf_id_config$ac
R 846 6 109 esmf_utiltypesmod esmf_id_array$ac
R 848 6 111 esmf_utiltypesmod esmf_id_interndg$ac
R 850 6 113 esmf_utiltypesmod esmf_id_commtable$ac
R 852 6 115 esmf_utiltypesmod esmf_id_routetable$ac
R 854 6 117 esmf_utiltypesmod esmf_id_route$ac
R 856 6 119 esmf_utiltypesmod esmf_id_routehandle$ac
R 858 6 121 esmf_utiltypesmod esmf_id_fielddatamap$ac
R 860 6 123 esmf_utiltypesmod esmf_id_field$ac
R 862 6 125 esmf_utiltypesmod esmf_id_fieldbundle$ac
R 864 6 127 esmf_utiltypesmod esmf_id_transformvalues$ac
R 866 6 129 esmf_utiltypesmod esmf_id_regrid$ac
R 868 6 131 esmf_utiltypesmod esmf_id_transform$ac
R 870 6 133 esmf_utiltypesmod esmf_id_state$ac
R 872 6 135 esmf_utiltypesmod esmf_id_gridcomponent$ac
R 874 6 137 esmf_utiltypesmod esmf_id_cplcomponent$ac
R 876 6 139 esmf_utiltypesmod esmf_id_component$ac
R 878 6 141 esmf_utiltypesmod esmf_id_internarray$ac
R 880 6 143 esmf_utiltypesmod esmf_id_none$ac
R 904 25 167 esmf_utiltypesmod esmf_localglobalflag
R 905 5 168 esmf_utiltypesmod value esmf_localglobalflag
R 907 6 170 esmf_utiltypesmod esmf_local$ac
R 909 6 172 esmf_utiltypesmod esmf_global$ac
R 910 25 173 esmf_utiltypesmod esmf_domaintypeflag
R 911 5 174 esmf_utiltypesmod value esmf_domaintypeflag
R 913 6 176 esmf_utiltypesmod esmf_domain_exclusive$ac
R 915 6 178 esmf_utiltypesmod esmf_domain_computational$ac
R 917 6 180 esmf_utiltypesmod esmf_domain_total$ac
R 919 6 182 esmf_utiltypesmod esmf_domain_allocated$ac
R 921 6 184 esmf_utiltypesmod esmf_domain_oldexclusive$ac
R 923 6 186 esmf_utiltypesmod esmf_domain_oldcomputational$ac
R 925 6 188 esmf_utiltypesmod esmf_domain_oldtotal$ac
R 926 25 189 esmf_utiltypesmod esmf_logical
R 927 5 190 esmf_utiltypesmod value esmf_logical
R 929 6 192 esmf_utiltypesmod esmf_true$ac
R 931 6 194 esmf_utiltypesmod esmf_false$ac
R 932 25 195 esmf_utiltypesmod esmf_reduceflag
R 933 5 196 esmf_utiltypesmod value esmf_reduceflag
R 935 6 198 esmf_utiltypesmod esmf_sum$ac
R 937 6 200 esmf_utiltypesmod esmf_min$ac
R 939 6 202 esmf_utiltypesmod esmf_max$ac
R 940 25 203 esmf_utiltypesmod esmf_blockingflag
R 941 5 204 esmf_utiltypesmod value esmf_blockingflag
R 943 6 206 esmf_utiltypesmod esmf_blocking$ac
R 945 6 208 esmf_utiltypesmod esmf_vasblocking$ac
R 947 6 210 esmf_utiltypesmod esmf_nonblocking$ac
R 948 25 211 esmf_utiltypesmod esmf_contextflag
R 949 5 212 esmf_utiltypesmod value esmf_contextflag
R 951 6 214 esmf_utiltypesmod esmf_child_in_new_vm$ac
R 953 6 216 esmf_utiltypesmod esmf_child_in_parent_vm$ac
R 954 25 217 esmf_utiltypesmod esmf_terminationflag
R 955 5 218 esmf_utiltypesmod value esmf_terminationflag
R 957 6 220 esmf_utiltypesmod esmf_final$ac
R 959 6 222 esmf_utiltypesmod esmf_keepmpi$ac
R 961 6 224 esmf_utiltypesmod esmf_abort$ac
R 962 25 225 esmf_utiltypesmod esmf_depinflag
R 963 5 226 esmf_utiltypesmod value esmf_depinflag
R 965 6 228 esmf_utiltypesmod esmf_de_pin_pet$ac
R 967 6 230 esmf_utiltypesmod esmf_de_pin_vas$ac
R 968 25 231 esmf_utiltypesmod esmf_direction
R 969 5 232 esmf_utiltypesmod value esmf_direction
R 971 6 234 esmf_utiltypesmod esmf_mode_forward$ac
R 973 6 236 esmf_utiltypesmod esmf_mode_reverse$ac
R 974 25 237 esmf_utiltypesmod esmf_indexflag
R 975 5 238 esmf_utiltypesmod i_type esmf_indexflag
R 977 6 240 esmf_utiltypesmod esmf_index_delocal$ac
R 979 6 242 esmf_utiltypesmod esmf_index_global$ac
R 980 25 243 esmf_utiltypesmod esmf_regionflag
R 981 5 244 esmf_utiltypesmod i_type esmf_regionflag
R 983 6 246 esmf_utiltypesmod esmf_region_total$ac
R 985 6 248 esmf_utiltypesmod esmf_region_select$ac
R 987 6 250 esmf_utiltypesmod esmf_region_empty$ac
R 1230 25 1 esmf_logerrmod esmf_msgtype
R 1231 5 2 esmf_logerrmod mtype esmf_msgtype
R 1233 6 4 esmf_logerrmod esmf_log_info$ac
R 1235 6 6 esmf_logerrmod esmf_log_warning$ac
R 1237 6 8 esmf_logerrmod esmf_log_error$ac
R 1238 25 9 esmf_logerrmod esmf_halttype
R 1239 5 10 esmf_logerrmod htype esmf_halttype
R 1241 6 12 esmf_logerrmod esmf_log_haltnever$ac
R 1243 6 14 esmf_logerrmod esmf_log_haltwarning$ac
R 1245 6 16 esmf_logerrmod esmf_log_halterror$ac
R 1246 25 17 esmf_logerrmod esmf_logtype
R 1247 5 18 esmf_logerrmod ftype esmf_logtype
R 1249 6 20 esmf_logerrmod esmf_log_single$ac
R 1251 6 22 esmf_logerrmod esmf_log_multi$ac
R 1253 6 24 esmf_logerrmod esmf_log_none$ac
S 1761 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 64 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 1927 25 1 esmf_iospecmod esmf_iofileformat
R 1928 5 2 esmf_iospecmod iofileformat esmf_iofileformat
R 1930 6 4 esmf_iospecmod esmf_io_fileformat_unspecified$ac
R 1932 6 6 esmf_iospecmod esmf_io_fileformat_netcdf$ac
R 1934 6 8 esmf_iospecmod esmf_io_fileformat_hdf$ac
R 1935 25 9 esmf_iospecmod esmf_iorwtype
R 1936 5 10 esmf_iospecmod iorwtype esmf_iorwtype
R 1938 6 12 esmf_iospecmod esmf_io_rwtype_unspecified$ac
R 1940 6 14 esmf_iospecmod esmf_io_rwtype_readonly$ac
R 1942 6 16 esmf_iospecmod esmf_io_rwtype_writeonly$ac
R 1944 6 18 esmf_iospecmod esmf_io_rwtype_readwrite$ac
R 1946 6 20 esmf_iospecmod esmf_io_rwtype_append$ac
R 1948 6 22 esmf_iospecmod esmf_io_rwtype_truncate$ac
R 2060 25 2 esmf_calendarmod esmf_calendartype
R 2061 5 3 esmf_calendarmod calendartype esmf_calendartype
R 2063 6 5 esmf_calendarmod esmf_cal_gregorian$ac
R 2065 6 7 esmf_calendarmod esmf_cal_julian$ac
R 2067 6 9 esmf_calendarmod esmf_cal_julianday$ac
R 2069 6 11 esmf_calendarmod esmf_cal_noleap$ac
R 2071 6 13 esmf_calendarmod esmf_cal_360day$ac
R 2073 6 15 esmf_calendarmod esmf_cal_custom$ac
R 2075 6 17 esmf_calendarmod esmf_cal_nocalendar$ac
R 2939 25 1 esmf_alarmtypemod esmf_alarmlisttype
R 2940 5 2 esmf_alarmtypemod alarmlisttype esmf_alarmlisttype
R 2942 6 4 esmf_alarmtypemod esmf_alarmlist_all$ac
R 2944 6 6 esmf_alarmtypemod esmf_alarmlist_ringing$ac
R 2946 6 8 esmf_alarmtypemod esmf_alarmlist_nextringing$ac
R 2948 6 10 esmf_alarmtypemod esmf_alarmlist_prevringing$ac
R 3335 25 1 esmf_arrayspecmod esmf_arrayspecstatus
R 3336 5 2 esmf_arrayspecmod status esmf_arrayspecstatus
R 3338 6 4 esmf_arrayspecmod esmf_arrayspec_status_unknown$ac
R 3340 6 6 esmf_arrayspecmod esmf_arrayspec_status_notset$ac
R 3342 6 8 esmf_arrayspecmod esmf_arrayspec_status_set$ac
R 3417 25 1 esmf_localarraycreatemod esmf_copyflag
R 3418 5 2 esmf_localarraycreatemod docopy esmf_copyflag
R 3420 6 4 esmf_localarraycreatemod esmf_data_copy$ac
R 3422 6 6 esmf_localarraycreatemod esmf_data_ref$ac
R 3424 6 8 esmf_localarraycreatemod esmf_data_defer$ac
R 3426 6 10 esmf_localarraycreatemod esmf_data_space$ac
R 3428 6 12 esmf_localarraycreatemod esmf_data_none$ac
R 3429 25 13 esmf_localarraycreatemod esmf_localarrayorigin
R 3430 5 14 esmf_localarraycreatemod origin esmf_localarrayorigin
R 3432 6 16 esmf_localarraycreatemod esmf_from_fortran$ac
R 3434 6 18 esmf_localarraycreatemod esmf_from_cplusplus$ac
R 8807 25 1 esmf_internarraydatamapmod esmf_interleaveflag
R 8808 5 2 esmf_internarraydatamapmod il esmf_interleaveflag
R 8810 6 4 esmf_internarraydatamapmod esmf_interleave_by_block$ac
R 8812 6 6 esmf_internarraydatamapmod esmf_interleave_by_item$ac
R 8818 25 12 esmf_internarraydatamapmod esmf_relloc
R 8819 5 13 esmf_internarraydatamapmod relloc esmf_relloc
R 8821 6 15 esmf_internarraydatamapmod esmf_cell_undefined$ac
R 8823 6 17 esmf_internarraydatamapmod esmf_cell_center$ac
R 8825 6 19 esmf_internarraydatamapmod esmf_cell_nface$ac
R 8827 6 21 esmf_internarraydatamapmod esmf_cell_sface$ac
R 8829 6 23 esmf_internarraydatamapmod esmf_cell_eface$ac
R 8831 6 25 esmf_internarraydatamapmod esmf_cell_wface$ac
R 8833 6 27 esmf_internarraydatamapmod esmf_cell_necorner$ac
R 8835 6 29 esmf_internarraydatamapmod esmf_cell_nwcorner$ac
R 8837 6 31 esmf_internarraydatamapmod esmf_cell_secorner$ac
R 8839 6 33 esmf_internarraydatamapmod esmf_cell_swcorner$ac
R 8841 6 35 esmf_internarraydatamapmod esmf_cell_topface$ac
R 8843 6 37 esmf_internarraydatamapmod esmf_cell_botface$ac
R 8845 6 39 esmf_internarraydatamapmod esmf_cell_cell$ac
R 8847 6 41 esmf_internarraydatamapmod esmf_cell_vertex$ac
R 8848 25 42 esmf_internarraydatamapmod esmf_indexorder
R 8849 5 43 esmf_internarraydatamapmod iorder esmf_indexorder
R 8851 6 45 esmf_internarraydatamapmod esmf_index_i$ac
R 8853 6 47 esmf_internarraydatamapmod esmf_index_ij$ac
R 8855 6 49 esmf_internarraydatamapmod esmf_index_ji$ac
R 8857 6 51 esmf_internarraydatamapmod esmf_index_ijk$ac
R 8859 6 53 esmf_internarraydatamapmod esmf_index_jik$ac
R 8861 6 55 esmf_internarraydatamapmod esmf_index_kji$ac
R 8863 6 57 esmf_internarraydatamapmod esmf_index_ikj$ac
R 8865 6 59 esmf_internarraydatamapmod esmf_index_jki$ac
R 8867 6 61 esmf_internarraydatamapmod esmf_index_kij$ac
R 10361 25 4 esmf_delayoutmod esmf_delayoutservicereply
R 10362 5 5 esmf_delayoutmod value esmf_delayoutservicereply
R 10364 6 7 esmf_delayoutmod esmf_delayout_service_accept$ac
R 10366 6 9 esmf_delayoutmod esmf_delayout_service_deny$ac
R 10660 25 4 esmf_distgridmod esmf_decompflag
R 10661 5 5 esmf_distgridmod value esmf_decompflag
R 10663 6 7 esmf_distgridmod esmf_decomp_default$ac
R 10665 6 9 esmf_distgridmod esmf_decomp_homogen$ac
R 10667 6 11 esmf_distgridmod esmf_decomp_restfirst$ac
R 10669 6 13 esmf_distgridmod esmf_decomp_restlast$ac
R 10671 6 15 esmf_distgridmod esmf_decomp_cyclic$ac
S 11423 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 69 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 11428 25 4 esmf_routemod esmf_routeoptions
R 11429 5 5 esmf_routemod option esmf_routeoptions
R 11431 6 7 esmf_routemod esmf_route_option_async$ac
R 11433 6 9 esmf_routemod esmf_route_option_sync$ac
R 11435 6 11 esmf_routemod esmf_route_option_pack_pet$ac
R 11437 6 13 esmf_routemod esmf_route_option_pack_xp$ac
R 11439 6 15 esmf_routemod esmf_route_option_pack_nopack$ac
R 11441 6 17 esmf_routemod esmf_route_option_pack_vector$ac
R 11443 6 19 esmf_routemod esmf_route_option_pack_buffer$ac
R 11445 6 21 esmf_routemod esmf_route_option_default$ac
R 19128 25 1 esmf_internarraycreatemod esmf_arrayorigin
R 19129 5 2 esmf_internarraycreatemod origin esmf_arrayorigin
R 19131 6 4 esmf_internarraycreatemod esmf_from_fortran$ac1
R 19133 6 6 esmf_internarraycreatemod esmf_from_cplusplus$ac2
S 23632 3 0 0 0 6 1 1 0 0 0 0 0 0 0 -1 -2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 23634 25 1 esmf_staggerlocmod esmf_staggerloc
R 23635 5 2 esmf_staggerlocmod staggerloc esmf_staggerloc
R 23643 6 10 esmf_staggerlocmod esmf_staggerloc_invalid$ac
R 23645 6 12 esmf_staggerlocmod esmf_staggerloc_uninit$ac
R 23647 6 14 esmf_staggerlocmod esmf_staggerloc_center$ac
R 23649 6 16 esmf_staggerlocmod esmf_staggerloc_edge1$ac
R 23651 6 18 esmf_staggerlocmod esmf_staggerloc_edge2$ac
R 23653 6 20 esmf_staggerlocmod esmf_staggerloc_corner$ac
R 23655 6 22 esmf_staggerlocmod esmf_staggerloc_center_vcenter$ac
R 23657 6 24 esmf_staggerlocmod esmf_staggerloc_edge1_vcenter$ac
R 23659 6 26 esmf_staggerlocmod esmf_staggerloc_edge2_vcenter$ac
R 23661 6 28 esmf_staggerlocmod esmf_staggerloc_corner_vcenter$ac
R 23663 6 30 esmf_staggerlocmod esmf_staggerloc_center_vface$ac
R 23665 6 32 esmf_staggerlocmod esmf_staggerloc_edge1_vface$ac
R 23667 6 34 esmf_staggerlocmod esmf_staggerloc_edge2_vface$ac
R 23669 6 36 esmf_staggerlocmod esmf_staggerloc_corner_vface$ac
R 23752 25 4 esmf_gridmod esmf_gridstatus
R 23753 5 5 esmf_gridmod gridstatus esmf_gridstatus
R 23755 6 7 esmf_gridmod esmf_gridstatus_invalid$ac
R 23757 6 9 esmf_gridmod esmf_gridstatus_uninit$ac
R 23759 6 11 esmf_gridmod esmf_gridstatus_not_ready$ac
R 23761 6 13 esmf_gridmod esmf_gridstatus_shape_ready$ac
R 23762 25 14 esmf_gridmod esmf_gridconn
R 23763 5 15 esmf_gridmod gridconn esmf_gridconn
R 23765 6 17 esmf_gridmod esmf_gridconn_none$ac
R 23767 6 19 esmf_gridmod esmf_gridconn_periodic$ac
R 23769 6 21 esmf_gridmod esmf_gridconn_pole$ac
R 23771 6 23 esmf_gridmod esmf_gridconn_bipole$ac
R 25362 25 1 esmf_fieldmod esmf_access
R 25363 5 2 esmf_fieldmod a_type esmf_access
R 25365 6 4 esmf_fieldmod esmf_readwrite$ac
R 25367 6 6 esmf_fieldmod esmf_readonly$ac
R 25368 25 7 esmf_fieldmod esmf_allocflag
R 25369 5 8 esmf_fieldmod a_type esmf_allocflag
R 25371 6 10 esmf_fieldmod esmf_alloc$ac
R 25373 6 12 esmf_fieldmod esmf_no_alloc$ac
R 32801 25 1 esmf_fieldbundlemod esmf_packflag
R 32802 5 2 esmf_fieldbundlemod packflag esmf_packflag
R 32804 6 4 esmf_fieldbundlemod esmf_packed_data$ac
R 32806 6 6 esmf_fieldbundlemod esmf_no_packed_data$ac
S 33335 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 101 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 33336 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 102 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 33337 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 103 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 33338 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 104 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 33339 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 105 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 33340 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 106 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 33341 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 107 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 33342 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 108 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 33343 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 109 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 33344 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 110 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 33346 25 1 esmf_statetypesmod esmf_statetype
R 33347 5 2 esmf_statetypesmod state esmf_statetype
R 33349 6 4 esmf_statetypesmod esmf_state_import$ac
R 33351 6 6 esmf_statetypesmod esmf_state_export$ac
R 33353 6 8 esmf_statetypesmod esmf_state_unspecified$ac
R 33355 6 10 esmf_statetypesmod esmf_state_invalid$ac
R 33356 25 11 esmf_statetypesmod esmf_stateitemtype
R 33357 5 12 esmf_statetypesmod ot esmf_stateitemtype
R 33359 6 14 esmf_statetypesmod esmf_stateitem_field$ac
R 33361 6 16 esmf_statetypesmod esmf_stateitem_fieldbundle$ac
R 33363 6 18 esmf_statetypesmod esmf_stateitem_array$ac
R 33365 6 20 esmf_statetypesmod esmf_stateitem_arraybundle$ac
R 33367 6 22 esmf_statetypesmod esmf_stateitem_routehandle$ac
R 33369 6 24 esmf_statetypesmod esmf_stateitem_state$ac
R 33371 6 26 esmf_statetypesmod esmf_stateitem_name$ac
R 33373 6 28 esmf_statetypesmod esmf_stateitem_indirect$ac
R 33375 6 30 esmf_statetypesmod esmf_stateitem_unknown$ac
R 33377 6 32 esmf_statetypesmod esmf_stateitem_notfound$ac
R 33378 25 33 esmf_statetypesmod esmf_neededflag
R 33379 5 34 esmf_statetypesmod needed esmf_neededflag
R 33381 6 36 esmf_statetypesmod esmf_needed$ac
R 33383 6 38 esmf_statetypesmod esmf_notneeded$ac
R 33384 25 39 esmf_statetypesmod esmf_readyflag
R 33385 5 40 esmf_statetypesmod ready esmf_readyflag
R 33387 6 42 esmf_statetypesmod esmf_readytowrite$ac
R 33389 6 44 esmf_statetypesmod esmf_readytoread$ac
R 33391 6 46 esmf_statetypesmod esmf_notready$ac
R 33392 25 47 esmf_statetypesmod esmf_reqforrestartflag
R 33393 5 48 esmf_statetypesmod required4restart esmf_reqforrestartflag
R 33395 6 50 esmf_statetypesmod esmf_required_for_restart$ac
R 33397 6 52 esmf_statetypesmod esmf_notrequired_for_restart$ac
R 33398 25 53 esmf_statetypesmod esmf_validflag
R 33399 5 54 esmf_statetypesmod valid esmf_validflag
R 33401 6 56 esmf_statetypesmod esmf_valid$ac
R 33403 6 58 esmf_statetypesmod esmf_invalid$ac
R 33405 6 60 esmf_statetypesmod esmf_validityunknown$ac
R 34516 25 1 esmf_compmod esmf_comptype
R 34517 5 2 esmf_compmod ctype esmf_comptype
R 34519 6 4 esmf_compmod esmf_comptype_grid$ac
R 34521 6 6 esmf_compmod esmf_comptype_cpl$ac
R 34522 25 7 esmf_compmod esmf_gridcomptype
R 34523 5 8 esmf_compmod gridcomptype esmf_gridcomptype
R 34525 6 10 esmf_compmod esmf_atm$ac
R 34527 6 12 esmf_compmod esmf_land$ac
R 34529 6 14 esmf_compmod esmf_ocean$ac
R 34531 6 16 esmf_compmod esmf_seaice$ac
R 34533 6 18 esmf_compmod esmf_river$ac
R 34535 6 20 esmf_compmod esmf_other$ac
A 13 2 0 0 0 6 645 0 0 0 13 0 0 0 0 0 0 0 0 0
A 14 2 0 0 0 6 654 0 0 0 14 0 0 0 0 0 0 0 0 0
A 15 2 0 0 0 6 658 0 0 0 15 0 0 0 0 0 0 0 0 0
A 16 2 0 0 0 6 660 0 0 0 16 0 0 0 0 0 0 0 0 0
A 17 2 0 0 0 6 646 0 0 0 17 0 0 0 0 0 0 0 0 0
A 18 2 0 0 0 6 664 0 0 0 18 0 0 0 0 0 0 0 0 0
A 19 2 0 0 0 6 666 0 0 0 19 0 0 0 0 0 0 0 0 0
A 20 2 0 0 0 6 668 0 0 0 20 0 0 0 0 0 0 0 0 0
A 21 2 0 0 0 6 635 0 0 0 21 0 0 0 0 0 0 0 0 0
A 22 2 0 0 0 6 682 0 0 0 22 0 0 0 0 0 0 0 0 0
A 23 2 0 0 0 6 650 0 0 0 23 0 0 0 0 0 0 0 0 0
A 24 2 0 0 0 6 652 0 0 0 24 0 0 0 0 0 0 0 0 0
A 27 2 0 0 0 6 633 0 0 0 27 0 0 0 0 0 0 0 0 0
A 32 2 0 0 0 6 636 0 0 0 32 0 0 0 0 0 0 0 0 0
A 45 2 0 0 0 6 640 0 0 0 45 0 0 0 0 0 0 0 0 0
A 52 2 0 0 0 6 641 0 0 0 52 0 0 0 0 0 0 0 0 0
A 56 2 0 0 0 6 642 0 0 0 56 0 0 0 0 0 0 0 0 0
A 60 2 0 0 0 6 643 0 0 0 60 0 0 0 0 0 0 0 0 0
A 95 2 0 0 0 6 637 0 0 0 95 0 0 0 0 0 0 0 0 0
A 105 2 0 0 0 6 647 0 0 0 105 0 0 0 0 0 0 0 0 0
A 109 2 0 0 0 6 648 0 0 0 109 0 0 0 0 0 0 0 0 0
A 113 2 0 0 0 6 649 0 0 0 113 0 0 0 0 0 0 0 0 0
A 182 2 0 0 0 6 703 0 0 0 182 0 0 0 0 0 0 0 0 0
A 208 2 0 0 0 6 709 0 0 0 208 0 0 0 0 0 0 0 0 0
A 214 2 0 0 0 6 711 0 0 0 214 0 0 0 0 0 0 0 0 0
A 220 2 0 0 0 6 713 0 0 0 220 0 0 0 0 0 0 0 0 0
A 226 2 0 0 0 6 715 0 0 0 226 0 0 0 0 0 0 0 0 0
A 232 2 0 0 193 6 651 0 0 0 232 0 0 0 0 0 0 0 0 0
A 238 2 0 0 0 6 718 0 0 0 238 0 0 0 0 0 0 0 0 0
A 244 2 0 0 0 6 720 0 0 0 244 0 0 0 0 0 0 0 0 0
A 250 2 0 0 0 6 722 0 0 0 250 0 0 0 0 0 0 0 0 0
A 256 2 0 0 0 6 724 0 0 0 256 0 0 0 0 0 0 0 0 0
A 262 2 0 0 0 6 726 0 0 0 262 0 0 0 0 0 0 0 0 0
A 273 2 0 0 0 6 729 0 0 0 273 0 0 0 0 0 0 0 0 0
A 279 2 0 0 0 6 731 0 0 0 279 0 0 0 0 0 0 0 0 0
A 285 2 0 0 0 6 733 0 0 0 285 0 0 0 0 0 0 0 0 0
A 291 2 0 0 9 6 735 0 0 0 291 0 0 0 0 0 0 0 0 0
A 404 1 0 0 0 46 753 0 0 0 0 0 0 0 0 0 0 0 0 0
A 407 1 0 0 0 46 755 0 0 0 0 0 0 0 0 0 0 0 0 0
A 410 1 0 0 0 46 757 0 0 0 0 0 0 0 0 0 0 0 0 0
A 413 1 0 0 0 46 759 0 0 0 0 0 0 0 0 0 0 0 0 0
A 416 1 0 0 0 46 761 0 0 0 0 0 0 0 0 0 0 0 0 0
A 419 1 0 0 0 46 763 0 0 0 0 0 0 0 0 0 0 0 0 0
A 422 1 0 0 398 46 765 0 0 0 0 0 0 0 0 0 0 0 0 0
A 425 1 0 0 0 52 769 0 0 0 0 0 0 0 0 0 0 0 0 0
A 428 1 0 0 0 52 771 0 0 0 0 0 0 0 0 0 0 0 0 0
A 431 1 0 0 0 58 775 0 0 0 0 0 0 0 0 0 0 0 0 0
A 434 1 0 0 0 58 777 0 0 0 0 0 0 0 0 0 0 0 0 0
A 437 1 0 0 0 58 779 0 0 0 0 0 0 0 0 0 0 0 0 0
A 440 1 0 0 0 58 781 0 0 0 0 0 0 0 0 0 0 0 0 0
A 443 1 0 0 0 58 783 0 0 0 0 0 0 0 0 0 0 0 0 0
A 446 1 0 0 0 58 785 0 0 0 0 0 0 0 0 0 0 0 0 0
A 449 1 0 0 401 58 787 0 0 0 0 0 0 0 0 0 0 0 0 0
A 452 1 0 0 0 58 789 0 0 0 0 0 0 0 0 0 0 0 0 0
A 455 1 0 0 0 58 791 0 0 0 0 0 0 0 0 0 0 0 0 0
A 458 1 0 0 0 58 793 0 0 0 0 0 0 0 0 0 0 0 0 0
A 461 1 0 0 0 58 795 0 0 0 0 0 0 0 0 0 0 0 0 0
A 464 1 0 0 0 58 797 0 0 0 0 0 0 0 0 0 0 0 0 0
A 467 1 0 0 0 58 799 0 0 0 0 0 0 0 0 0 0 0 0 0
A 468 2 0 0 0 78 653 0 0 0 468 0 0 0 0 0 0 0 0 0
A 472 1 0 0 232 70 818 0 0 0 0 0 0 0 0 0 0 0 0 0
A 473 2 0 0 296 80 655 0 0 0 473 0 0 0 0 0 0 0 0 0
A 477 1 0 0 203 70 820 0 0 0 0 0 0 0 0 0 0 0 0 0
A 478 2 0 0 220 80 656 0 0 0 478 0 0 0 0 0 0 0 0 0
A 482 1 0 0 209 70 822 0 0 0 0 0 0 0 0 0 0 0 0 0
A 483 2 0 0 337 78 657 0 0 0 483 0 0 0 0 0 0 0 0 0
A 487 1 0 0 215 70 824 0 0 0 0 0 0 0 0 0 0 0 0 0
A 488 2 0 0 0 82 659 0 0 0 488 0 0 0 0 0 0 0 0 0
A 492 1 0 0 221 70 826 0 0 0 0 0 0 0 0 0 0 0 0 0
A 493 2 0 0 238 84 661 0 0 0 493 0 0 0 0 0 0 0 0 0
A 497 1 0 0 227 70 828 0 0 0 0 0 0 0 0 0 0 0 0 0
A 498 2 0 0 0 86 662 0 0 0 498 0 0 0 0 0 0 0 0 0
A 502 1 0 0 0 70 830 0 0 0 0 0 0 0 0 0 0 0 0 0
A 503 2 0 0 244 86 663 0 0 0 503 0 0 0 0 0 0 0 0 0
A 507 1 0 0 0 70 832 0 0 0 0 0 0 0 0 0 0 0 0 0
A 508 2 0 0 250 88 665 0 0 0 508 0 0 0 0 0 0 0 0 0
A 512 1 0 0 0 70 834 0 0 0 0 0 0 0 0 0 0 0 0 0
A 513 2 0 0 256 90 667 0 0 0 513 0 0 0 0 0 0 0 0 0
A 517 1 0 0 0 70 836 0 0 0 0 0 0 0 0 0 0 0 0 0
A 518 2 0 0 262 92 669 0 0 0 518 0 0 0 0 0 0 0 0 0
A 522 1 0 0 0 70 838 0 0 0 0 0 0 0 0 0 0 0 0 0
A 523 2 0 0 0 94 670 0 0 0 523 0 0 0 0 0 0 0 0 0
A 527 1 0 0 268 70 840 0 0 0 0 0 0 0 0 0 0 0 0 0
A 528 2 0 0 0 82 671 0 0 0 528 0 0 0 0 0 0 0 0 0
A 532 1 0 0 274 70 842 0 0 0 0 0 0 0 0 0 0 0 0 0
A 533 2 0 0 273 80 672 0 0 0 533 0 0 0 0 0 0 0 0 0
A 537 1 0 0 280 70 844 0 0 0 0 0 0 0 0 0 0 0 0 0
A 538 2 0 0 0 86 673 0 0 0 538 0 0 0 0 0 0 0 0 0
A 542 1 0 0 286 70 846 0 0 0 0 0 0 0 0 0 0 0 0 0
A 543 2 0 0 279 82 674 0 0 0 543 0 0 0 0 0 0 0 0 0
A 547 1 0 0 292 70 848 0 0 0 0 0 0 0 0 0 0 0 0 0
A 548 2 0 0 0 88 675 0 0 0 548 0 0 0 0 0 0 0 0 0
A 552 1 0 0 0 70 850 0 0 0 0 0 0 0 0 0 0 0 0 0
A 553 2 0 0 285 90 676 0 0 0 553 0 0 0 0 0 0 0 0 0
A 557 1 0 0 0 70 852 0 0 0 0 0 0 0 0 0 0 0 0 0
A 558 2 0 0 0 86 677 0 0 0 558 0 0 0 0 0 0 0 0 0
A 562 1 0 0 0 70 854 0 0 0 0 0 0 0 0 0 0 0 0 0
A 563 2 0 0 291 92 678 0 0 0 563 0 0 0 0 0 0 0 0 0
A 567 1 0 0 117 70 856 0 0 0 0 0 0 0 0 0 0 0 0 0
A 568 2 0 0 0 84 679 0 0 0 568 0 0 0 0 0 0 0 0 0
A 572 1 0 0 119 70 858 0 0 0 0 0 0 0 0 0 0 0 0 0
A 573 2 0 0 0 86 680 0 0 0 573 0 0 0 0 0 0 0 0 0
A 577 1 0 0 121 70 860 0 0 0 0 0 0 0 0 0 0 0 0 0
A 578 2 0 0 0 92 681 0 0 0 578 0 0 0 0 0 0 0 0 0
A 582 1 0 0 123 70 862 0 0 0 0 0 0 0 0 0 0 0 0 0
A 583 2 0 0 0 96 683 0 0 0 583 0 0 0 0 0 0 0 0 0
A 587 1 0 0 0 70 864 0 0 0 0 0 0 0 0 0 0 0 0 0
A 588 2 0 0 0 80 684 0 0 0 588 0 0 0 0 0 0 0 0 0
A 592 1 0 0 125 70 866 0 0 0 0 0 0 0 0 0 0 0 0 0
A 593 2 0 0 0 88 685 0 0 0 593 0 0 0 0 0 0 0 0 0
A 597 1 0 0 0 70 868 0 0 0 0 0 0 0 0 0 0 0 0 0
A 598 2 0 0 0 86 686 0 0 0 598 0 0 0 0 0 0 0 0 0
A 602 1 0 0 182 70 870 0 0 0 0 0 0 0 0 0 0 0 0 0
A 603 2 0 0 0 98 687 0 0 0 603 0 0 0 0 0 0 0 0 0
A 607 1 0 0 0 70 872 0 0 0 0 0 0 0 0 0 0 0 0 0
A 608 2 0 0 0 84 688 0 0 0 608 0 0 0 0 0 0 0 0 0
A 612 1 0 0 0 70 874 0 0 0 0 0 0 0 0 0 0 0 0 0
A 613 2 0 0 0 88 689 0 0 0 613 0 0 0 0 0 0 0 0 0
A 617 1 0 0 208 70 876 0 0 0 0 0 0 0 0 0 0 0 0 0
A 618 2 0 0 0 92 690 0 0 0 618 0 0 0 0 0 0 0 0 0
A 622 1 0 0 214 70 878 0 0 0 0 0 0 0 0 0 0 0 0 0
A 623 2 0 0 38 78 691 0 0 0 623 0 0 0 0 0 0 0 0 0
A 627 1 0 0 478 70 880 0 0 0 0 0 0 0 0 0 0 0 0 0
A 630 1 0 0 0 127 907 0 0 0 0 0 0 0 0 0 0 0 0 0
A 633 1 0 0 0 127 909 0 0 0 0 0 0 0 0 0 0 0 0 0
A 636 1 0 0 572 133 913 0 0 0 0 0 0 0 0 0 0 0 0 0
A 639 1 0 0 577 133 915 0 0 0 0 0 0 0 0 0 0 0 0 0
A 642 1 0 0 582 133 917 0 0 0 0 0 0 0 0 0 0 0 0 0
A 645 1 0 0 587 133 919 0 0 0 0 0 0 0 0 0 0 0 0 0
A 648 1 0 0 592 133 921 0 0 0 0 0 0 0 0 0 0 0 0 0
A 651 1 0 0 597 133 923 0 0 0 0 0 0 0 0 0 0 0 0 0
A 654 1 0 0 602 133 925 0 0 0 0 0 0 0 0 0 0 0 0 0
A 657 1 0 0 612 139 929 0 0 0 0 0 0 0 0 0 0 0 0 0
A 660 1 0 0 617 139 931 0 0 0 0 0 0 0 0 0 0 0 0 0
A 663 1 0 0 0 145 935 0 0 0 0 0 0 0 0 0 0 0 0 0
A 666 1 0 0 0 145 937 0 0 0 0 0 0 0 0 0 0 0 0 0
A 669 1 0 0 0 145 939 0 0 0 0 0 0 0 0 0 0 0 0 0
A 672 1 0 0 0 151 943 0 0 0 0 0 0 0 0 0 0 0 0 0
A 675 1 0 0 0 151 945 0 0 0 0 0 0 0 0 0 0 0 0 0
A 678 1 0 0 0 151 947 0 0 0 0 0 0 0 0 0 0 0 0 0
A 681 1 0 0 0 157 951 0 0 0 0 0 0 0 0 0 0 0 0 0
A 684 1 0 0 0 157 953 0 0 0 0 0 0 0 0 0 0 0 0 0
A 687 1 0 0 0 163 957 0 0 0 0 0 0 0 0 0 0 0 0 0
A 690 1 0 0 0 163 959 0 0 0 0 0 0 0 0 0 0 0 0 0
A 693 1 0 0 0 163 961 0 0 0 0 0 0 0 0 0 0 0 0 0
A 696 1 0 0 0 169 965 0 0 0 0 0 0 0 0 0 0 0 0 0
A 699 1 0 0 0 169 967 0 0 0 0 0 0 0 0 0 0 0 0 0
A 702 1 0 0 0 175 971 0 0 0 0 0 0 0 0 0 0 0 0 0
A 705 1 0 0 0 175 973 0 0 0 0 0 0 0 0 0 0 0 0 0
A 708 1 0 0 407 181 977 0 0 0 0 0 0 0 0 0 0 0 0 0
A 711 1 0 0 410 181 979 0 0 0 0 0 0 0 0 0 0 0 0 0
A 714 1 0 0 416 187 983 0 0 0 0 0 0 0 0 0 0 0 0 0
A 717 1 0 0 419 187 985 0 0 0 0 0 0 0 0 0 0 0 0 0
A 720 1 0 0 422 187 987 0 0 0 0 0 0 0 0 0 0 0 0 0
A 805 1 0 0 455 390 1233 0 0 0 0 0 0 0 0 0 0 0 0 0
A 808 1 0 0 458 390 1235 0 0 0 0 0 0 0 0 0 0 0 0 0
A 811 1 0 0 461 390 1237 0 0 0 0 0 0 0 0 0 0 0 0 0
A 814 1 0 0 467 396 1241 0 0 0 0 0 0 0 0 0 0 0 0 0
A 817 1 0 0 0 396 1243 0 0 0 0 0 0 0 0 0 0 0 0 0
A 820 1 0 0 0 396 1245 0 0 0 0 0 0 0 0 0 0 0 0 0
A 823 1 0 0 642 402 1249 0 0 0 0 0 0 0 0 0 0 0 0 0
A 826 1 0 0 645 402 1251 0 0 0 0 0 0 0 0 0 0 0 0 0
A 829 1 0 0 648 402 1253 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1018 2 0 0 0 6 1761 0 0 0 1018 0 0 0 0 0 0 0 0 0
A 1150 1 0 0 954 1632 1930 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1153 1 0 0 955 1632 1932 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1156 1 0 0 957 1632 1934 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1159 1 0 0 959 1638 1938 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1162 1 0 0 961 1638 1940 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1165 1 0 0 542 1638 1942 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1168 1 0 0 547 1638 1944 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1171 1 0 0 552 1638 1946 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1174 1 0 0 966 1638 1948 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1314 1 0 0 1189 2168 2063 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1317 1 0 0 1041 2168 2065 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1320 1 0 0 1291 2168 2067 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1323 1 0 0 1195 2168 2069 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1326 1 0 0 1197 2168 2071 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1329 1 0 0 1199 2168 2073 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1332 1 0 0 1299 2168 2075 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1555 1 0 0 1222 3280 2942 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1558 1 0 0 1224 3280 2944 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1561 1 0 0 1226 3280 2946 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1564 1 0 0 1228 3280 2948 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1686 1 0 0 1301 3880 3338 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1689 1 0 0 1451 3880 3340 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1692 1 0 0 1304 3880 3342 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7350 1 0 0 6903 4082 3420 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7353 1 0 0 6902 4082 3422 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7356 1 0 0 6911 4082 3424 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7359 1 0 0 7149 4082 3426 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7362 1 0 0 7150 4082 3428 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7365 1 0 0 6923 4088 3432 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7368 1 0 0 6927 4088 3434 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9519 1 0 0 9473 8001 8810 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9522 1 0 0 9478 8001 8812 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9525 1 0 0 8848 8013 8821 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9528 1 0 0 6253 8013 8823 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9531 1 0 0 9484 8013 8825 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9534 1 0 0 9483 8013 8827 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9537 1 0 0 8709 8013 8829 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9540 1 0 0 7416 8013 8831 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9543 1 0 0 8945 8013 8833 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9546 1 0 0 8996 8013 8835 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9549 1 0 0 7331 8013 8837 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9552 1 0 0 8341 8013 8839 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9555 1 0 0 9031 8013 8841 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9558 1 0 0 8929 8013 8843 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9561 1 0 0 9313 8013 8845 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9564 1 0 0 8349 8013 8847 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9567 1 0 0 8304 8019 8851 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9570 1 0 0 9312 8019 8853 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9573 1 0 0 9004 8019 8855 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9576 1 0 0 7247 8019 8857 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9579 1 0 0 9207 8019 8859 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9582 1 0 0 8381 8019 8861 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9585 1 0 0 8837 8019 8863 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9588 1 0 0 7259 8019 8865 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9591 1 0 0 8565 8019 8867 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10265 1 0 0 9916 8782 10364 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10268 1 0 0 9917 8782 10366 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10776 1 0 0 9361 9061 10663 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10779 1 0 0 9603 9061 10665 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10782 1 0 0 8577 9061 10667 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10785 1 0 0 9855 9061 10669 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10788 1 0 0 9602 9061 10671 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10853 2 0 0 10533 6 11423 0 0 0 10853 0 0 0 0 0 0 0 0 0
A 11280 1 0 0 10703 9723 11431 0 0 0 0 0 0 0 0 0 0 0 0 0
A 11283 1 0 0 10707 9723 11433 0 0 0 0 0 0 0 0 0 0 0 0 0
A 11286 1 0 0 11216 9723 11435 0 0 0 0 0 0 0 0 0 0 0 0 0
A 11289 1 0 0 10349 9723 11437 0 0 0 0 0 0 0 0 0 0 0 0 0
A 11292 1 0 0 10712 9723 11439 0 0 0 0 0 0 0 0 0 0 0 0 0
A 11295 1 0 0 10354 9723 11441 0 0 0 0 0 0 0 0 0 0 0 0 0
A 11298 1 0 0 11178 9723 11443 0 0 0 0 0 0 0 0 0 0 0 0 0
A 11301 1 0 0 11238 9723 11445 0 0 0 0 0 0 0 0 0 0 0 0 0
A 21387 1 0 0 19566 14599 19131 0 0 0 0 0 0 0 0 0 0 0 0 0
A 21390 1 0 0 21030 14599 19133 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23808 2 0 0 23162 6 23632 0 0 0 23808 0 0 0 0 0 0 0 0 0
A 23894 1 0 0 23635 18525 23643 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23897 1 0 0 23144 18525 23645 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23900 1 0 0 23366 18525 23647 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23903 1 0 0 22150 18525 23649 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23906 1 0 0 22783 18525 23651 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23909 1 0 0 23409 18525 23653 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23912 1 0 0 21626 18525 23655 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23915 1 0 0 22477 18525 23657 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23918 1 0 0 22160 18525 23659 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23921 1 0 0 22896 18525 23661 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23924 1 0 0 23808 18525 23663 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23927 1 0 0 23513 18525 23665 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23930 1 0 0 23512 18525 23667 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23933 1 0 0 23509 18525 23669 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24861 1 0 0 24513 18776 23755 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24864 1 0 0 24123 18776 23757 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24867 1 0 0 24556 18776 23759 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24870 1 0 0 24516 18776 23761 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24873 1 0 0 24512 18782 23765 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24876 1 0 0 24517 18782 23767 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24879 1 0 0 24524 18782 23769 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24882 1 0 0 24529 18782 23771 0 0 0 0 0 0 0 0 0 0 0 0 0
A 25055 1 0 0 24895 20069 25365 0 0 0 0 0 0 0 0 0 0 0 0 0
A 25058 1 0 0 24754 20069 25367 0 0 0 0 0 0 0 0 0 0 0 0 0
A 25061 1 0 0 24901 20075 25371 0 0 0 0 0 0 0 0 0 0 0 0 0
A 25064 1 0 0 24972 20075 25373 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31751 1 0 0 31069 24795 32804 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31754 1 0 0 31657 24795 32806 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31768 2 0 0 31370 6 33335 0 0 0 31768 0 0 0 0 0 0 0 0 0
A 31772 2 0 0 31642 6 33336 0 0 0 31772 0 0 0 0 0 0 0 0 0
A 31776 2 0 0 31644 6 33337 0 0 0 31776 0 0 0 0 0 0 0 0 0
A 31780 2 0 0 31641 6 33338 0 0 0 31780 0 0 0 0 0 0 0 0 0
A 31784 2 0 0 31643 6 33339 0 0 0 31784 0 0 0 0 0 0 0 0 0
A 31788 2 0 0 31376 6 33340 0 0 0 31788 0 0 0 0 0 0 0 0 0
A 31792 2 0 0 31373 6 33341 0 0 0 31792 0 0 0 0 0 0 0 0 0
A 31796 2 0 0 31375 6 33342 0 0 0 31796 0 0 0 0 0 0 0 0 0
A 31800 2 0 0 31378 6 33343 0 0 0 31800 0 0 0 0 0 0 0 0 0
A 31804 2 0 0 31380 6 33344 0 0 0 31804 0 0 0 0 0 0 0 0 0
A 31881 1 0 0 31018 25213 33349 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31884 1 0 0 31012 25213 33351 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31887 1 0 0 31647 25213 33353 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31890 1 0 0 31648 25213 33355 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31893 1 0 0 29889 25219 33359 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31896 1 0 0 31730 25219 33361 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31899 1 0 0 31732 25219 33363 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31902 1 0 0 31272 25219 33365 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31905 1 0 0 31269 25219 33367 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31908 1 0 0 31738 25219 33369 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31911 1 0 0 31267 25219 33371 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31914 1 0 0 31741 25219 33373 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31917 1 0 0 31743 25219 33375 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31920 1 0 0 31745 25219 33377 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31923 1 0 0 31285 25225 33381 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31926 1 0 0 31279 25225 33383 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31929 1 0 0 31292 25231 33387 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31932 1 0 0 31293 25231 33389 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31935 1 0 0 31288 25231 33391 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31938 1 0 0 31555 25237 33395 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31941 1 0 0 31556 25237 33397 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31944 1 0 0 31854 25243 33401 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31947 1 0 0 31563 25243 33403 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31950 1 0 0 31564 25243 33405 0 0 0 0 0 0 0 0 0 0 0 0 0
A 32414 1 0 0 32221 26852 34519 0 0 0 0 0 0 0 0 0 0 0 0 0
A 32417 1 0 0 31810 26852 34521 0 0 0 0 0 0 0 0 0 0 0 0 0
A 32420 1 0 0 32159 26858 34525 0 0 0 0 0 0 0 0 0 0 0 0 0
A 32423 1 0 0 32229 26858 34527 0 0 0 0 0 0 0 0 0 0 0 0 0
A 32426 1 0 0 31819 26858 34529 0 0 0 0 0 0 0 0 0 0 0 0 0
A 32429 1 0 0 32165 26858 34531 0 0 0 0 0 0 0 0 0 0 0 0 0
A 32432 1 0 0 32167 26858 34533 0 0 0 0 0 0 0 0 0 0 0 0 0
A 32435 1 0 0 32237 26858 34535 0 0 0 0 0 0 0 0 0 0 0 0 0
Z
J 97 1 1
V 404 46 7 0
S 0 46 0 0 0
A 0 6 0 0 1 3 0
J 97 1 1
V 407 46 7 0
S 0 46 0 0 0
A 0 6 0 0 1 45 0
J 97 1 1
V 410 46 7 0
S 0 46 0 0 0
A 0 6 0 0 1 32 0
J 97 1 1
V 413 46 7 0
S 0 46 0 0 0
A 0 6 0 0 1 52 0
J 97 1 1
V 416 46 7 0
S 0 46 0 0 0
A 0 6 0 0 1 56 0
J 97 1 1
V 419 46 7 0
S 0 46 0 0 0
A 0 6 0 0 1 60 0
J 97 1 1
V 422 46 7 0
S 0 46 0 0 0
A 0 6 0 0 1 21 0
J 124 1 1
V 425 52 7 0
S 0 52 0 0 0
A 0 6 0 0 1 2 0
J 124 1 1
V 428 52 7 0
S 0 52 0 0 0
A 0 6 0 0 1 27 0
J 145 1 1
V 431 58 7 0
S 0 58 0 0 0
A 0 6 0 0 1 3 0
J 145 1 1
V 434 58 7 0
S 0 58 0 0 0
A 0 6 0 0 1 45 0
J 145 1 1
V 437 58 7 0
S 0 58 0 0 0
A 0 6 0 0 1 32 0
J 145 1 1
V 440 58 7 0
S 0 58 0 0 0
A 0 6 0 0 1 52 0
J 145 1 1
V 443 58 7 0
S 0 58 0 0 0
A 0 6 0 0 1 56 0
J 145 1 1
V 446 58 7 0
S 0 58 0 0 0
A 0 6 0 0 1 60 0
J 145 1 1
V 449 58 7 0
S 0 58 0 0 0
A 0 6 0 0 1 21 0
J 145 1 1
V 452 58 7 0
S 0 58 0 0 0
A 0 6 0 0 1 95 0
J 145 1 1
V 455 58 7 0
S 0 58 0 0 0
A 0 6 0 0 1 13 0
J 145 1 1
V 458 58 7 0
S 0 58 0 0 0
A 0 6 0 0 1 17 0
J 145 1 1
V 461 58 7 0
S 0 58 0 0 0
A 0 6 0 0 1 105 0
J 145 1 1
V 464 58 7 0
S 0 58 0 0 0
A 0 6 0 0 1 109 0
J 145 1 1
V 467 58 7 0
S 0 58 0 0 0
A 0 6 0 0 1 113 0
J 219 1 1
V 472 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 3 1
A 0 78 0 0 1 468 0
J 219 1 1
V 477 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 45 1
A 0 80 0 0 1 473 0
J 219 1 1
V 482 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 32 1
A 0 80 0 0 1 478 0
J 219 1 1
V 487 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 52 1
A 0 78 0 0 1 483 0
J 219 1 1
V 492 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 56 1
A 0 82 0 0 1 488 0
J 219 1 1
V 497 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 60 1
A 0 84 0 0 1 493 0
J 219 1 1
V 502 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 21 1
A 0 86 0 0 1 498 0
J 219 1 1
V 507 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 95 1
A 0 86 0 0 1 503 0
J 219 1 1
V 512 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 13 1
A 0 88 0 0 1 508 0
J 219 1 1
V 517 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 17 1
A 0 90 0 0 1 513 0
J 219 1 1
V 522 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 14 1
A 0 92 0 0 1 518 0
J 219 1 1
V 527 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 182 1
A 0 94 0 0 1 523 0
J 219 1 1
V 532 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 15 1
A 0 82 0 0 1 528 0
J 219 1 1
V 537 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 18 1
A 0 80 0 0 1 533 0
J 219 1 1
V 542 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 20 1
A 0 86 0 0 1 538 0
J 219 1 1
V 547 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 16 1
A 0 82 0 0 1 543 0
J 219 1 1
V 552 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 208 1
A 0 88 0 0 1 548 0
J 219 1 1
V 557 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 214 1
A 0 90 0 0 1 553 0
J 219 1 1
V 562 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 220 1
A 0 86 0 0 1 558 0
J 219 1 1
V 567 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 226 1
A 0 92 0 0 1 563 0
J 219 1 1
V 572 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 232 1
A 0 84 0 0 1 568 0
J 219 1 1
V 577 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 238 1
A 0 86 0 0 1 573 0
J 219 1 1
V 582 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 244 1
A 0 92 0 0 1 578 0
J 219 1 1
V 587 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 250 1
A 0 96 0 0 1 583 0
J 219 1 1
V 592 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 256 1
A 0 80 0 0 1 588 0
J 219 1 1
V 597 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 262 1
A 0 88 0 0 1 593 0
J 219 1 1
V 602 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 24 1
A 0 86 0 0 1 598 0
J 219 1 1
V 607 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 273 1
A 0 98 0 0 1 603 0
J 219 1 1
V 612 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 279 1
A 0 84 0 0 1 608 0
J 219 1 1
V 617 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 285 1
A 0 88 0 0 1 613 0
J 219 1 1
V 622 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 291 1
A 0 92 0 0 1 618 0
J 219 1 1
V 627 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 113 1
A 0 78 0 0 1 623 0
J 303 1 1
V 630 127 7 0
S 0 127 0 0 0
A 0 6 0 0 1 3 0
J 303 1 1
V 633 127 7 0
S 0 127 0 0 0
A 0 6 0 0 1 45 0
J 337 1 1
V 636 133 7 0
S 0 133 0 0 0
A 0 6 0 0 1 3 0
J 337 1 1
V 639 133 7 0
S 0 133 0 0 0
A 0 6 0 0 1 45 0
J 337 1 1
V 642 133 7 0
S 0 133 0 0 0
A 0 6 0 0 1 32 0
J 337 1 1
V 645 133 7 0
S 0 133 0 0 0
A 0 6 0 0 1 52 0
J 337 1 1
V 648 133 7 0
S 0 133 0 0 0
A 0 6 0 0 1 56 0
J 337 1 1
V 651 133 7 0
S 0 133 0 0 0
A 0 6 0 0 1 60 0
J 337 1 1
V 654 133 7 0
S 0 133 0 0 0
A 0 6 0 0 1 21 0
J 363 1 1
V 657 139 7 0
S 0 139 0 0 0
A 0 6 0 0 1 3 0
J 363 1 1
V 660 139 7 0
S 0 139 0 0 0
A 0 6 0 0 1 45 0
J 378 1 1
V 663 145 7 0
S 0 145 0 0 0
A 0 6 0 0 1 3 0
J 378 1 1
V 666 145 7 0
S 0 145 0 0 0
A 0 6 0 0 1 45 0
J 378 1 1
V 669 145 7 0
S 0 145 0 0 0
A 0 6 0 0 1 32 0
J 392 1 1
V 672 151 7 0
S 0 151 0 0 0
A 0 6 0 0 1 3 0
J 392 1 1
V 675 151 7 0
S 0 151 0 0 0
A 0 6 0 0 1 45 0
J 392 1 1
V 678 151 7 0
S 0 151 0 0 0
A 0 6 0 0 1 32 0
J 407 1 1
V 681 157 7 0
S 0 157 0 0 0
A 0 6 0 0 1 3 0
J 407 1 1
V 684 157 7 0
S 0 157 0 0 0
A 0 6 0 0 1 45 0
J 421 1 1
V 687 163 7 0
S 0 163 0 0 0
A 0 6 0 0 1 3 0
J 421 1 1
V 690 163 7 0
S 0 163 0 0 0
A 0 6 0 0 1 45 0
J 421 1 1
V 693 163 7 0
S 0 163 0 0 0
A 0 6 0 0 1 32 0
J 436 1 1
V 696 169 7 0
S 0 169 0 0 0
A 0 6 0 0 1 3 0
J 436 1 1
V 699 169 7 0
S 0 169 0 0 0
A 0 6 0 0 1 45 0
J 450 1 1
V 702 175 7 0
S 0 175 0 0 0
A 0 6 0 0 1 3 0
J 450 1 1
V 705 175 7 0
S 0 175 0 0 0
A 0 6 0 0 1 45 0
J 465 1 1
V 708 181 7 0
S 0 181 0 0 0
A 0 6 0 0 1 2 0
J 465 1 1
V 711 181 7 0
S 0 181 0 0 0
A 0 6 0 0 1 3 0
J 480 1 1
V 714 187 7 0
S 0 187 0 0 0
A 0 6 0 0 1 2 0
J 480 1 1
V 717 187 7 0
S 0 187 0 0 0
A 0 6 0 0 1 3 0
J 480 1 1
V 720 187 7 0
S 0 187 0 0 0
A 0 6 0 0 1 45 0
J 67 1 1
V 805 390 7 0
S 0 390 0 0 0
A 0 6 0 0 1 3 0
J 67 1 1
V 808 390 7 0
S 0 390 0 0 0
A 0 6 0 0 1 45 0
J 67 1 1
V 811 390 7 0
S 0 390 0 0 0
A 0 6 0 0 1 32 0
J 79 1 1
V 814 396 7 0
S 0 396 0 0 0
A 0 6 0 0 1 3 0
J 79 1 1
V 817 396 7 0
S 0 396 0 0 0
A 0 6 0 0 1 45 0
J 79 1 1
V 820 396 7 0
S 0 396 0 0 0
A 0 6 0 0 1 32 0
J 91 1 1
V 823 402 7 0
S 0 402 0 0 0
A 0 6 0 0 1 3 0
J 91 1 1
V 826 402 7 0
S 0 402 0 0 0
A 0 6 0 0 1 45 0
J 91 1 1
V 829 402 7 0
S 0 402 0 0 0
A 0 6 0 0 1 32 0
J 54 1 1
V 1150 1632 7 0
S 0 1632 0 0 0
A 0 6 0 0 1 2 0
J 54 1 1
V 1153 1632 7 0
S 0 1632 0 0 0
A 0 6 0 0 1 3 0
J 54 1 1
V 1156 1632 7 0
S 0 1632 0 0 0
A 0 6 0 0 1 45 0
J 66 1 1
V 1159 1638 7 0
S 0 1638 0 0 0
A 0 6 0 0 1 2 0
J 66 1 1
V 1162 1638 7 0
S 0 1638 0 0 0
A 0 6 0 0 1 3 0
J 66 1 1
V 1165 1638 7 0
S 0 1638 0 0 0
A 0 6 0 0 1 45 0
J 66 1 1
V 1168 1638 7 0
S 0 1638 0 0 0
A 0 6 0 0 1 32 0
J 66 1 1
V 1171 1638 7 0
S 0 1638 0 0 0
A 0 6 0 0 1 52 0
J 66 1 1
V 1174 1638 7 0
S 0 1638 0 0 0
A 0 6 0 0 1 56 0
J 69 1 1
V 1314 2168 7 0
S 0 2168 0 0 0
A 0 6 0 0 1 3 0
J 69 1 1
V 1317 2168 7 0
S 0 2168 0 0 0
A 0 6 0 0 1 45 0
J 69 1 1
V 1320 2168 7 0
S 0 2168 0 0 0
A 0 6 0 0 1 32 0
J 69 1 1
V 1323 2168 7 0
S 0 2168 0 0 0
A 0 6 0 0 1 52 0
J 69 1 1
V 1326 2168 7 0
S 0 2168 0 0 0
A 0 6 0 0 1 56 0
J 69 1 1
V 1329 2168 7 0
S 0 2168 0 0 0
A 0 6 0 0 1 60 0
J 69 1 1
V 1332 2168 7 0
S 0 2168 0 0 0
A 0 6 0 0 1 21 0
J 62 1 1
V 1555 3280 7 0
S 0 3280 0 0 0
A 0 6 0 0 1 3 0
J 62 1 1
V 1558 3280 7 0
S 0 3280 0 0 0
A 0 6 0 0 1 45 0
J 62 1 1
V 1561 3280 7 0
S 0 3280 0 0 0
A 0 6 0 0 1 32 0
J 62 1 1
V 1564 3280 7 0
S 0 3280 0 0 0
A 0 6 0 0 1 52 0
J 68 1 1
V 1686 3880 7 0
S 0 3880 0 0 0
A 0 6 0 0 1 2 0
J 68 1 1
V 1689 3880 7 0
S 0 3880 0 0 0
A 0 6 0 0 1 3 0
J 68 1 1
V 1692 3880 7 0
S 0 3880 0 0 0
A 0 6 0 0 1 45 0
J 77 1 1
V 7350 4082 7 0
S 0 4082 0 0 0
A 0 6 0 0 1 3 0
J 77 1 1
V 7353 4082 7 0
S 0 4082 0 0 0
A 0 6 0 0 1 45 0
J 77 1 1
V 7356 4082 7 0
S 0 4082 0 0 0
A 0 6 0 0 1 32 0
J 77 1 1
V 7359 4082 7 0
S 0 4082 0 0 0
A 0 6 0 0 1 52 0
J 77 1 1
V 7362 4082 7 0
S 0 4082 0 0 0
A 0 6 0 0 1 56 0
J 97 1 1
V 7365 4088 7 0
S 0 4088 0 0 0
A 0 6 0 0 1 3 0
J 97 1 1
V 7368 4088 7 0
S 0 4088 0 0 0
A 0 6 0 0 1 45 0
J 71 1 1
V 9519 8001 7 0
S 0 8001 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 9522 8001 7 0
S 0 8001 0 0 0
A 0 6 0 0 1 45 0
J 102 1 1
V 9525 8013 7 0
S 0 8013 0 0 0
A 0 6 0 0 1 2 0
J 102 1 1
V 9528 8013 7 0
S 0 8013 0 0 0
A 0 6 0 0 1 3 0
J 102 1 1
V 9531 8013 7 0
S 0 8013 0 0 0
A 0 6 0 0 1 45 0
J 102 1 1
V 9534 8013 7 0
S 0 8013 0 0 0
A 0 6 0 0 1 32 0
J 102 1 1
V 9537 8013 7 0
S 0 8013 0 0 0
A 0 6 0 0 1 52 0
J 102 1 1
V 9540 8013 7 0
S 0 8013 0 0 0
A 0 6 0 0 1 56 0
J 102 1 1
V 9543 8013 7 0
S 0 8013 0 0 0
A 0 6 0 0 1 60 0
J 102 1 1
V 9546 8013 7 0
S 0 8013 0 0 0
A 0 6 0 0 1 21 0
J 102 1 1
V 9549 8013 7 0
S 0 8013 0 0 0
A 0 6 0 0 1 95 0
J 102 1 1
V 9552 8013 7 0
S 0 8013 0 0 0
A 0 6 0 0 1 13 0
J 102 1 1
V 9555 8013 7 0
S 0 8013 0 0 0
A 0 6 0 0 1 17 0
J 102 1 1
V 9558 8013 7 0
S 0 8013 0 0 0
A 0 6 0 0 1 14 0
J 102 1 1
V 9561 8013 7 0
S 0 8013 0 0 0
A 0 6 0 0 1 182 0
J 102 1 1
V 9564 8013 7 0
S 0 8013 0 0 0
A 0 6 0 0 1 15 0
J 129 1 1
V 9567 8019 7 0
S 0 8019 0 0 0
A 0 6 0 0 1 2 0
J 129 1 1
V 9570 8019 7 0
S 0 8019 0 0 0
A 0 6 0 0 1 3 0
J 129 1 1
V 9573 8019 7 0
S 0 8019 0 0 0
A 0 6 0 0 1 45 0
J 129 1 1
V 9576 8019 7 0
S 0 8019 0 0 0
A 0 6 0 0 1 32 0
J 129 1 1
V 9579 8019 7 0
S 0 8019 0 0 0
A 0 6 0 0 1 52 0
J 129 1 1
V 9582 8019 7 0
S 0 8019 0 0 0
A 0 6 0 0 1 56 0
J 129 1 1
V 9585 8019 7 0
S 0 8019 0 0 0
A 0 6 0 0 1 60 0
J 129 1 1
V 9588 8019 7 0
S 0 8019 0 0 0
A 0 6 0 0 1 21 0
J 129 1 1
V 9591 8019 7 0
S 0 8019 0 0 0
A 0 6 0 0 1 95 0
J 71 1 1
V 10265 8782 7 0
S 0 8782 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 10268 8782 7 0
S 0 8782 0 0 0
A 0 6 0 0 1 45 0
J 72 1 1
V 10776 9061 7 0
S 0 9061 0 0 0
A 0 6 0 0 1 3 0
J 72 1 1
V 10779 9061 7 0
S 0 9061 0 0 0
A 0 6 0 0 1 45 0
J 72 1 1
V 10782 9061 7 0
S 0 9061 0 0 0
A 0 6 0 0 1 32 0
J 72 1 1
V 10785 9061 7 0
S 0 9061 0 0 0
A 0 6 0 0 1 52 0
J 72 1 1
V 10788 9061 7 0
S 0 9061 0 0 0
A 0 6 0 0 1 56 0
J 69 1 1
V 11280 9723 7 0
S 0 9723 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 11283 9723 7 0
S 0 9723 0 0 0
A 0 6 0 0 1 45 0
J 73 1 1
V 11286 9723 7 0
S 0 9723 0 0 0
A 0 6 0 0 1 52 0
J 75 1 1
V 11289 9723 7 0
S 0 9723 0 0 0
A 0 6 0 0 1 95 0
J 77 1 1
V 11292 9723 7 0
S 0 9723 0 0 0
A 0 6 0 0 1 20 0
J 79 1 1
V 11295 9723 7 0
S 0 9723 0 0 0
A 0 6 0 0 1 24 0
J 81 1 1
V 11298 9723 7 0
S 0 9723 0 0 0
A 0 6 0 0 1 1018 0
J 83 1 1
V 11301 9723 7 0
S 0 9723 0 0 0
A 0 6 0 0 1 10853 0
J 65 1 1
V 21387 14599 7 0
S 0 14599 0 0 0
A 0 6 0 0 1 3 0
J 65 1 1
V 21390 14599 7 0
S 0 14599 0 0 0
A 0 6 0 0 1 45 0
J 79 1 1
V 23894 18525 7 0
S 0 18525 0 0 0
A 0 6 0 0 1 23808 0
J 79 1 1
V 23897 18525 7 0
S 0 18525 0 0 0
A 0 6 0 0 1 27 0
J 84 1 1
V 23900 18525 7 0
S 0 18525 0 0 0
A 0 6 0 0 1 2 0
J 84 1 1
V 23903 18525 7 0
S 0 18525 0 0 0
A 0 6 0 0 1 3 0
J 84 1 1
V 23906 18525 7 0
S 0 18525 0 0 0
A 0 6 0 0 1 45 0
J 84 1 1
V 23909 18525 7 0
S 0 18525 0 0 0
A 0 6 0 0 1 32 0
J 91 1 1
V 23912 18525 7 0
S 0 18525 0 0 0
A 0 6 0 0 1 2 0
J 91 1 1
V 23915 18525 7 0
S 0 18525 0 0 0
A 0 6 0 0 1 3 0
J 91 1 1
V 23918 18525 7 0
S 0 18525 0 0 0
A 0 6 0 0 1 45 0
J 91 1 1
V 23921 18525 7 0
S 0 18525 0 0 0
A 0 6 0 0 1 32 0
J 91 1 1
V 23924 18525 7 0
S 0 18525 0 0 0
A 0 6 0 0 1 52 0
J 91 1 1
V 23927 18525 7 0
S 0 18525 0 0 0
A 0 6 0 0 1 56 0
J 91 1 1
V 23930 18525 7 0
S 0 18525 0 0 0
A 0 6 0 0 1 60 0
J 91 1 1
V 23933 18525 7 0
S 0 18525 0 0 0
A 0 6 0 0 1 21 0
J 80 1 1
V 24861 18776 7 0
S 0 18776 0 0 0
A 0 6 0 0 1 27 0
J 80 1 1
V 24864 18776 7 0
S 0 18776 0 0 0
A 0 6 0 0 1 2 0
J 80 1 1
V 24867 18776 7 0
S 0 18776 0 0 0
A 0 6 0 0 1 3 0
J 80 1 1
V 24870 18776 7 0
S 0 18776 0 0 0
A 0 6 0 0 1 45 0
J 96 1 1
V 24873 18782 7 0
S 0 18782 0 0 0
A 0 6 0 0 1 2 0
J 96 1 1
V 24876 18782 7 0
S 0 18782 0 0 0
A 0 6 0 0 1 3 0
J 96 1 1
V 24879 18782 7 0
S 0 18782 0 0 0
A 0 6 0 0 1 45 0
J 96 1 1
V 24882 18782 7 0
S 0 18782 0 0 0
A 0 6 0 0 1 32 0
J 80 1 1
V 25055 20069 7 0
S 0 20069 0 0 0
A 0 6 0 0 1 2 0
J 80 1 1
V 25058 20069 7 0
S 0 20069 0 0 0
A 0 6 0 0 1 3 0
J 95 1 1
V 25061 20075 7 0
S 0 20075 0 0 0
A 0 6 0 0 1 2 0
J 95 1 1
V 25064 20075 7 0
S 0 20075 0 0 0
A 0 6 0 0 1 3 0
J 70 1 1
V 31751 24795 7 0
S 0 24795 0 0 0
A 0 6 0 0 1 3 0
J 70 1 1
V 31754 24795 7 0
S 0 24795 0 0 0
A 0 6 0 0 1 45 0
J 64 1 1
V 31881 25213 7 0
S 0 25213 0 0 0
A 0 6 0 0 1 3 0
J 64 1 1
V 31884 25213 7 0
S 0 25213 0 0 0
A 0 6 0 0 1 45 0
J 64 1 1
V 31887 25213 7 0
S 0 25213 0 0 0
A 0 6 0 0 1 32 0
J 64 1 1
V 31890 25213 7 0
S 0 25213 0 0 0
A 0 6 0 0 1 52 0
J 82 1 1
V 31893 25219 7 0
S 0 25219 0 0 0
A 0 6 0 0 1 31768 0
J 82 1 1
V 31896 25219 7 0
S 0 25219 0 0 0
A 0 6 0 0 1 31772 0
J 82 1 1
V 31899 25219 7 0
S 0 25219 0 0 0
A 0 6 0 0 1 31776 0
J 82 1 1
V 31902 25219 7 0
S 0 25219 0 0 0
A 0 6 0 0 1 31780 0
J 82 1 1
V 31905 25219 7 0
S 0 25219 0 0 0
A 0 6 0 0 1 31784 0
J 82 1 1
V 31908 25219 7 0
S 0 25219 0 0 0
A 0 6 0 0 1 31788 0
J 82 1 1
V 31911 25219 7 0
S 0 25219 0 0 0
A 0 6 0 0 1 31792 0
J 82 1 1
V 31914 25219 7 0
S 0 25219 0 0 0
A 0 6 0 0 1 31796 0
J 82 1 1
V 31917 25219 7 0
S 0 25219 0 0 0
A 0 6 0 0 1 31800 0
J 82 1 1
V 31920 25219 7 0
S 0 25219 0 0 0
A 0 6 0 0 1 31804 0
J 106 1 1
V 31923 25225 7 0
S 0 25225 0 0 0
A 0 6 0 0 1 3 0
J 106 1 1
V 31926 25225 7 0
S 0 25225 0 0 0
A 0 6 0 0 1 45 0
J 119 1 1
V 31929 25231 7 0
S 0 25231 0 0 0
A 0 6 0 0 1 3 0
J 119 1 1
V 31932 25231 7 0
S 0 25231 0 0 0
A 0 6 0 0 1 45 0
J 119 1 1
V 31935 25231 7 0
S 0 25231 0 0 0
A 0 6 0 0 1 32 0
J 134 1 1
V 31938 25237 7 0
S 0 25237 0 0 0
A 0 6 0 0 1 3 0
J 134 1 1
V 31941 25237 7 0
S 0 25237 0 0 0
A 0 6 0 0 1 45 0
J 148 1 1
V 31944 25243 7 0
S 0 25243 0 0 0
A 0 6 0 0 1 3 0
J 148 1 1
V 31947 25243 7 0
S 0 25243 0 0 0
A 0 6 0 0 1 45 0
J 148 1 1
V 31950 25243 7 0
S 0 25243 0 0 0
A 0 6 0 0 1 32 0
J 69 1 1
V 32414 26852 7 0
S 0 26852 0 0 0
A 0 6 0 0 1 3 0
J 69 1 1
V 32417 26852 7 0
S 0 26852 0 0 0
A 0 6 0 0 1 45 0
J 83 1 1
V 32420 26858 7 0
S 0 26858 0 0 0
A 0 6 0 0 1 3 0
J 83 1 1
V 32423 26858 7 0
S 0 26858 0 0 0
A 0 6 0 0 1 45 0
J 83 1 1
V 32426 26858 7 0
S 0 26858 0 0 0
A 0 6 0 0 1 32 0
J 83 1 1
V 32429 26858 7 0
S 0 26858 0 0 0
A 0 6 0 0 1 52 0
J 83 1 1
V 32432 26858 7 0
S 0 26858 0 0 0
A 0 6 0 0 1 56 0
J 83 1 1
V 32435 26858 7 0
S 0 26858 0 0 0
A 0 6 0 0 1 60 0
Z
