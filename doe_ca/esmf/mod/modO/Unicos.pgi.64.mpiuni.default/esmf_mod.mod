V24 esmf_mod
65 /u0/d/dazlich/doe_ca/esmf/src/Superstructure/ESMFMod/src/ESMF.F90 S582 0
08/28/2008  12:00:51
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
enduse
D 35 24 751 4 750 3
D 41 24 767 8 766 7
D 47 24 773 4 772 3
D 59 24 815 36 814 3
D 67 18 13
D 69 18 14
D 71 18 15
D 73 18 16
D 75 18 17
D 77 18 18
D 79 18 19
D 81 18 20
D 83 18 21
D 85 18 22
D 87 18 23
D 116 24 905 4 904 3
D 122 24 911 4 910 3
D 128 24 927 4 926 3
D 134 24 933 4 932 3
D 140 24 941 4 940 3
D 146 24 949 4 948 3
D 152 24 955 4 954 3
D 158 24 963 4 962 3
D 164 24 969 4 968 3
D 170 24 975 4 974 3
D 176 24 981 4 980 3
D 322 24 1212 4 1211 3
D 328 24 1220 4 1219 3
D 334 24 1228 4 1227 3
D 1537 24 1900 4 1899 3
D 1543 24 1908 4 1907 3
D 2055 24 2027 4 2026 3
D 3152 24 2901 4 2900 3
D 3746 24 3295 4 3294 3
D 3942 24 3375 4 3374 3
D 3948 24 3387 4 3386 3
D 7600 24 8678 4 8677 3
D 7612 24 8689 4 8688 3
D 7618 24 8719 4 8718 3
D 8354 24 10223 4 10222 3
D 8627 24 10520 4 10519 3
D 9280 24 11285 4 11284 3
D 14114 24 18971 4 18970 3
D 17773 24 23388 4 23387 3
D 18021 24 23505 4 23504 3
D 18027 24 23515 4 23514 3
D 19296 24 25109 4 25108 3
D 19302 24 25115 4 25114 3
D 24010 24 32544 4 32543 3
D 24413 24 33084 4 33083 3
D 24419 24 33094 4 33093 3
D 24425 24 33116 4 33115 3
D 24431 24 33122 4 33121 3
D 24437 24 33130 4 33129 3
D 24443 24 33136 4 33135 3
D 26019 24 34243 4 34242 3
D 26025 24 34249 4 34248 3
D 26948 18 13
D 26950 18 14
D 26952 18 15
D 26954 18 16
D 26956 18 17
D 26958 18 18
D 26960 18 19
D 26962 18 20
D 26964 18 21
D 26966 18 22
D 26968 18 23
S 582 24 0 0 0 8 1 0 4668 5 0 0 0 0 0 0 0 0 0 93 0 0 0 0 0 0 0 0 15 0 0 0 0 0 0 esmf_mod
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
S 653 3 0 0 0 26948 1 1 0 0 0 0 0 0 0 5621 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 42 61 73 65
S 654 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 11 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 655 3 0 0 0 26950 1 1 0 0 0 0 0 0 0 5631 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 49 4f 53 70 65 63
S 656 3 0 0 0 26950 1 1 0 0 0 0 0 0 0 5643 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 4c 6f 67 45 72 72
S 657 3 0 0 0 26948 1 1 0 0 0 0 0 0 0 5655 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 54 69 6d 65
S 658 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 13 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 659 3 0 0 0 26952 1 1 0 0 0 0 0 0 0 5665 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 43 61 6c 65 6e 64 61 72
S 660 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 17 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 661 3 0 0 0 26954 1 1 0 0 0 0 0 0 0 5679 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 54 69 6d 65 49 6e 74 65 72 76 61 6c
S 662 3 0 0 0 26956 1 1 0 0 0 0 0 0 0 5697 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 41 6c 61 72 6d
S 663 3 0 0 0 26956 1 1 0 0 0 0 0 0 0 5708 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 43 6c 6f 63 6b
S 664 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 665 3 0 0 0 26958 1 1 0 0 0 0 0 0 0 5719 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 41 72 72 61 79 53 70 65 63
S 666 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 667 3 0 0 0 26960 1 1 0 0 0 0 0 0 0 5734 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 15 45 53 4d 46 5f 4c 6f 63 61 6c 41 72 72 61 79
S 668 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 669 3 0 0 0 26962 1 1 0 0 0 0 0 0 0 5750 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 41 72 72 61 79 42 75 6e 64 6c 65
S 670 3 0 0 0 26964 1 1 0 0 0 0 0 0 0 5767 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 7 45 53 4d 46 5f 56 4d
S 671 3 0 0 0 26952 1 1 0 0 0 0 0 0 0 5775 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 44 45 4c 61 79 6f 75 74
S 672 3 0 0 0 26950 1 1 0 0 0 0 0 0 0 5789 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 43 6f 6e 66 69 67
S 673 3 0 0 0 26956 1 1 0 0 0 0 0 0 0 5801 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 41 72 72 61 79
S 674 3 0 0 0 26952 1 1 0 0 0 0 0 0 0 5812 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 49 6e 74 65 72 6e 44 47
S 675 3 0 0 0 26958 1 1 0 0 0 0 0 0 0 5826 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 43 6f 6d 6d 54 61 62 6c 65
S 676 3 0 0 0 26960 1 1 0 0 0 0 0 0 0 5841 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 15 45 53 4d 46 5f 52 6f 75 74 65 54 61 62 6c 65
S 677 3 0 0 0 26956 1 1 0 0 0 0 0 0 0 5857 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 52 6f 75 74 65
S 678 3 0 0 0 26962 1 1 0 0 0 0 0 0 0 5868 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 52 6f 75 74 65 48 61 6e 64 6c 65
S 679 3 0 0 0 26954 1 1 0 0 0 0 0 0 0 5885 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 46 69 65 6c 64 44 61 74 61 4d 61 70
S 680 3 0 0 0 26956 1 1 0 0 0 0 0 0 0 5903 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 46 69 65 6c 64
S 681 3 0 0 0 26962 1 1 0 0 0 0 0 0 0 5914 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 46 69 65 6c 64 42 75 6e 64 6c 65
S 682 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 20 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 683 3 0 0 0 26966 1 1 0 0 0 0 0 0 0 5931 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 20 45 53 4d 46 5f 54 72 61 6e 73 66 6f 72 6d 56 61 6c 75 65 73
S 684 3 0 0 0 26950 1 1 0 0 0 0 0 0 0 5952 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 52 65 67 72 69 64
S 685 3 0 0 0 26958 1 1 0 0 0 0 0 0 0 5964 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 54 72 61 6e 73 66 6f 72 6d
S 686 3 0 0 0 26956 1 1 0 0 0 0 0 0 0 5979 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 53 74 61 74 65
S 687 3 0 0 0 26968 1 1 0 0 0 0 0 0 0 5990 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 18 45 53 4d 46 5f 47 72 69 64 43 6f 6d 70 6f 6e 65 6e 74
S 688 3 0 0 0 26954 1 1 0 0 0 0 0 0 0 6009 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 43 70 6c 43 6f 6d 70 6f 6e 65 6e 74
S 689 3 0 0 0 26958 1 1 0 0 0 0 0 0 0 6027 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 43 6f 6d 70 6f 6e 65 6e 74
S 690 3 0 0 0 26962 1 1 0 0 0 0 0 0 0 6042 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 49 6e 74 65 72 6e 41 72 72 61 79
S 691 3 0 0 0 26948 1 1 0 0 0 0 0 0 0 6059 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 4e 6f 6e 65
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
R 751 5 14 esmf_utiltypesmod status
R 753 6 16 esmf_utiltypesmod esmf_status_uninit$ac
R 755 6 18 esmf_utiltypesmod esmf_status_ready$ac
R 757 6 20 esmf_utiltypesmod esmf_status_unallocated$ac
R 759 6 22 esmf_utiltypesmod esmf_status_allocated$ac
R 761 6 24 esmf_utiltypesmod esmf_status_busy$ac
R 763 6 26 esmf_utiltypesmod esmf_status_invalid$ac
R 765 6 28 esmf_utiltypesmod esmf_status_not_ready$ac
R 766 25 29 esmf_utiltypesmod esmf_pointer
R 767 5 30 esmf_utiltypesmod ptr
R 769 6 32 esmf_utiltypesmod esmf_null_pointer$ac
R 771 6 34 esmf_utiltypesmod esmf_bad_pointer$ac
R 772 25 35 esmf_utiltypesmod esmf_typekind
R 773 5 36 esmf_utiltypesmod dkind
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
R 815 5 78 esmf_utiltypesmod objectid
R 816 5 79 esmf_utiltypesmod objectname
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
R 905 5 168 esmf_utiltypesmod value
R 907 6 170 esmf_utiltypesmod esmf_local$ac
R 909 6 172 esmf_utiltypesmod esmf_global$ac
R 910 25 173 esmf_utiltypesmod esmf_domaintypeflag
R 911 5 174 esmf_utiltypesmod value
R 913 6 176 esmf_utiltypesmod esmf_domain_exclusive$ac
R 915 6 178 esmf_utiltypesmod esmf_domain_computational$ac
R 917 6 180 esmf_utiltypesmod esmf_domain_total$ac
R 919 6 182 esmf_utiltypesmod esmf_domain_allocated$ac
R 921 6 184 esmf_utiltypesmod esmf_domain_oldexclusive$ac
R 923 6 186 esmf_utiltypesmod esmf_domain_oldcomputational$ac
R 925 6 188 esmf_utiltypesmod esmf_domain_oldtotal$ac
R 926 25 189 esmf_utiltypesmod esmf_logical
R 927 5 190 esmf_utiltypesmod value
R 929 6 192 esmf_utiltypesmod esmf_true$ac
R 931 6 194 esmf_utiltypesmod esmf_false$ac
R 932 25 195 esmf_utiltypesmod esmf_reduceflag
R 933 5 196 esmf_utiltypesmod value
R 935 6 198 esmf_utiltypesmod esmf_sum$ac
R 937 6 200 esmf_utiltypesmod esmf_min$ac
R 939 6 202 esmf_utiltypesmod esmf_max$ac
R 940 25 203 esmf_utiltypesmod esmf_blockingflag
R 941 5 204 esmf_utiltypesmod value
R 943 6 206 esmf_utiltypesmod esmf_blocking$ac
R 945 6 208 esmf_utiltypesmod esmf_vasblocking$ac
R 947 6 210 esmf_utiltypesmod esmf_nonblocking$ac
R 948 25 211 esmf_utiltypesmod esmf_contextflag
R 949 5 212 esmf_utiltypesmod value
R 951 6 214 esmf_utiltypesmod esmf_child_in_new_vm$ac
R 953 6 216 esmf_utiltypesmod esmf_child_in_parent_vm$ac
R 954 25 217 esmf_utiltypesmod esmf_terminationflag
R 955 5 218 esmf_utiltypesmod value
R 957 6 220 esmf_utiltypesmod esmf_final$ac
R 959 6 222 esmf_utiltypesmod esmf_keepmpi$ac
R 961 6 224 esmf_utiltypesmod esmf_abort$ac
R 962 25 225 esmf_utiltypesmod esmf_depinflag
R 963 5 226 esmf_utiltypesmod value
R 965 6 228 esmf_utiltypesmod esmf_de_pin_pet$ac
R 967 6 230 esmf_utiltypesmod esmf_de_pin_vas$ac
R 968 25 231 esmf_utiltypesmod esmf_direction
R 969 5 232 esmf_utiltypesmod value
R 971 6 234 esmf_utiltypesmod esmf_mode_forward$ac
R 973 6 236 esmf_utiltypesmod esmf_mode_reverse$ac
R 974 25 237 esmf_utiltypesmod esmf_indexflag
R 975 5 238 esmf_utiltypesmod i_type
R 977 6 240 esmf_utiltypesmod esmf_index_delocal$ac
R 979 6 242 esmf_utiltypesmod esmf_index_global$ac
R 980 25 243 esmf_utiltypesmod esmf_regionflag
R 981 5 244 esmf_utiltypesmod i_type
R 983 6 246 esmf_utiltypesmod esmf_region_total$ac
R 985 6 248 esmf_utiltypesmod esmf_region_select$ac
R 987 6 250 esmf_utiltypesmod esmf_region_empty$ac
R 1211 25 1 esmf_logerrmod esmf_msgtype
R 1212 5 2 esmf_logerrmod mtype
R 1214 6 4 esmf_logerrmod esmf_log_info$ac
R 1216 6 6 esmf_logerrmod esmf_log_warning$ac
R 1218 6 8 esmf_logerrmod esmf_log_error$ac
R 1219 25 9 esmf_logerrmod esmf_halttype
R 1220 5 10 esmf_logerrmod htype
R 1222 6 12 esmf_logerrmod esmf_log_haltnever$ac
R 1224 6 14 esmf_logerrmod esmf_log_haltwarning$ac
R 1226 6 16 esmf_logerrmod esmf_log_halterror$ac
R 1227 25 17 esmf_logerrmod esmf_logtype
R 1228 5 18 esmf_logerrmod ftype
R 1230 6 20 esmf_logerrmod esmf_log_single$ac
R 1232 6 22 esmf_logerrmod esmf_log_multi$ac
R 1234 6 24 esmf_logerrmod esmf_log_none$ac
S 1735 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 64 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 1899 25 1 esmf_iospecmod esmf_iofileformat
R 1900 5 2 esmf_iospecmod iofileformat
R 1902 6 4 esmf_iospecmod esmf_io_fileformat_unspecified$ac
R 1904 6 6 esmf_iospecmod esmf_io_fileformat_netcdf$ac
R 1906 6 8 esmf_iospecmod esmf_io_fileformat_hdf$ac
R 1907 25 9 esmf_iospecmod esmf_iorwtype
R 1908 5 10 esmf_iospecmod iorwtype
R 1910 6 12 esmf_iospecmod esmf_io_rwtype_unspecified$ac
R 1912 6 14 esmf_iospecmod esmf_io_rwtype_readonly$ac
R 1914 6 16 esmf_iospecmod esmf_io_rwtype_writeonly$ac
R 1916 6 18 esmf_iospecmod esmf_io_rwtype_readwrite$ac
R 1918 6 20 esmf_iospecmod esmf_io_rwtype_append$ac
R 1920 6 22 esmf_iospecmod esmf_io_rwtype_truncate$ac
R 2026 25 2 esmf_calendarmod esmf_calendartype
R 2027 5 3 esmf_calendarmod calendartype
R 2029 6 5 esmf_calendarmod esmf_cal_gregorian$ac
R 2031 6 7 esmf_calendarmod esmf_cal_julian$ac
R 2033 6 9 esmf_calendarmod esmf_cal_julianday$ac
R 2035 6 11 esmf_calendarmod esmf_cal_noleap$ac
R 2037 6 13 esmf_calendarmod esmf_cal_360day$ac
R 2039 6 15 esmf_calendarmod esmf_cal_custom$ac
R 2041 6 17 esmf_calendarmod esmf_cal_nocalendar$ac
R 2900 25 1 esmf_alarmtypemod esmf_alarmlisttype
R 2901 5 2 esmf_alarmtypemod alarmlisttype
R 2903 6 4 esmf_alarmtypemod esmf_alarmlist_all$ac
R 2905 6 6 esmf_alarmtypemod esmf_alarmlist_ringing$ac
R 2907 6 8 esmf_alarmtypemod esmf_alarmlist_nextringing$ac
R 2909 6 10 esmf_alarmtypemod esmf_alarmlist_prevringing$ac
R 3294 25 1 esmf_arrayspecmod esmf_arrayspecstatus
R 3295 5 2 esmf_arrayspecmod status
R 3297 6 4 esmf_arrayspecmod esmf_arrayspec_status_unknown$ac
R 3299 6 6 esmf_arrayspecmod esmf_arrayspec_status_notset$ac
R 3301 6 8 esmf_arrayspecmod esmf_arrayspec_status_set$ac
R 3374 25 1 esmf_localarraycreatemod esmf_copyflag
R 3375 5 2 esmf_localarraycreatemod docopy
R 3377 6 4 esmf_localarraycreatemod esmf_data_copy$ac
R 3379 6 6 esmf_localarraycreatemod esmf_data_ref$ac
R 3381 6 8 esmf_localarraycreatemod esmf_data_defer$ac
R 3383 6 10 esmf_localarraycreatemod esmf_data_space$ac
R 3385 6 12 esmf_localarraycreatemod esmf_data_none$ac
R 3386 25 13 esmf_localarraycreatemod esmf_localarrayorigin
R 3387 5 14 esmf_localarraycreatemod origin
R 3389 6 16 esmf_localarraycreatemod esmf_from_fortran$ac
R 3391 6 18 esmf_localarraycreatemod esmf_from_cplusplus$ac
R 8677 25 1 esmf_internarraydatamapmod esmf_interleaveflag
R 8678 5 2 esmf_internarraydatamapmod il
R 8680 6 4 esmf_internarraydatamapmod esmf_interleave_by_block$ac
R 8682 6 6 esmf_internarraydatamapmod esmf_interleave_by_item$ac
R 8688 25 12 esmf_internarraydatamapmod esmf_relloc
R 8689 5 13 esmf_internarraydatamapmod relloc
R 8691 6 15 esmf_internarraydatamapmod esmf_cell_undefined$ac
R 8693 6 17 esmf_internarraydatamapmod esmf_cell_center$ac
R 8695 6 19 esmf_internarraydatamapmod esmf_cell_nface$ac
R 8697 6 21 esmf_internarraydatamapmod esmf_cell_sface$ac
R 8699 6 23 esmf_internarraydatamapmod esmf_cell_eface$ac
R 8701 6 25 esmf_internarraydatamapmod esmf_cell_wface$ac
R 8703 6 27 esmf_internarraydatamapmod esmf_cell_necorner$ac
R 8705 6 29 esmf_internarraydatamapmod esmf_cell_nwcorner$ac
R 8707 6 31 esmf_internarraydatamapmod esmf_cell_secorner$ac
R 8709 6 33 esmf_internarraydatamapmod esmf_cell_swcorner$ac
R 8711 6 35 esmf_internarraydatamapmod esmf_cell_topface$ac
R 8713 6 37 esmf_internarraydatamapmod esmf_cell_botface$ac
R 8715 6 39 esmf_internarraydatamapmod esmf_cell_cell$ac
R 8717 6 41 esmf_internarraydatamapmod esmf_cell_vertex$ac
R 8718 25 42 esmf_internarraydatamapmod esmf_indexorder
R 8719 5 43 esmf_internarraydatamapmod iorder
R 8721 6 45 esmf_internarraydatamapmod esmf_index_i$ac
R 8723 6 47 esmf_internarraydatamapmod esmf_index_ij$ac
R 8725 6 49 esmf_internarraydatamapmod esmf_index_ji$ac
R 8727 6 51 esmf_internarraydatamapmod esmf_index_ijk$ac
R 8729 6 53 esmf_internarraydatamapmod esmf_index_jik$ac
R 8731 6 55 esmf_internarraydatamapmod esmf_index_kji$ac
R 8733 6 57 esmf_internarraydatamapmod esmf_index_ikj$ac
R 8735 6 59 esmf_internarraydatamapmod esmf_index_jki$ac
R 8737 6 61 esmf_internarraydatamapmod esmf_index_kij$ac
R 10222 25 4 esmf_delayoutmod esmf_delayoutservicereply
R 10223 5 5 esmf_delayoutmod value
R 10225 6 7 esmf_delayoutmod esmf_delayout_service_accept$ac
R 10227 6 9 esmf_delayoutmod esmf_delayout_service_deny$ac
R 10519 25 4 esmf_distgridmod esmf_decompflag
R 10520 5 5 esmf_distgridmod value
R 10522 6 7 esmf_distgridmod esmf_decomp_default$ac
R 10524 6 9 esmf_distgridmod esmf_decomp_homogen$ac
R 10526 6 11 esmf_distgridmod esmf_decomp_restfirst$ac
R 10528 6 13 esmf_distgridmod esmf_decomp_restlast$ac
R 10530 6 15 esmf_distgridmod esmf_decomp_cyclic$ac
S 11279 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 69 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 11284 25 4 esmf_routemod esmf_routeoptions
R 11285 5 5 esmf_routemod option
R 11287 6 7 esmf_routemod esmf_route_option_async$ac
R 11289 6 9 esmf_routemod esmf_route_option_sync$ac
R 11291 6 11 esmf_routemod esmf_route_option_pack_pet$ac
R 11293 6 13 esmf_routemod esmf_route_option_pack_xp$ac
R 11295 6 15 esmf_routemod esmf_route_option_pack_nopack$ac
R 11297 6 17 esmf_routemod esmf_route_option_pack_vector$ac
R 11299 6 19 esmf_routemod esmf_route_option_pack_buffer$ac
R 11301 6 21 esmf_routemod esmf_route_option_default$ac
R 18970 25 1 esmf_internarraycreatemod esmf_arrayorigin
R 18971 5 2 esmf_internarraycreatemod origin
R 18973 6 4 esmf_internarraycreatemod esmf_from_fortran$ac1
R 18975 6 6 esmf_internarraycreatemod esmf_from_cplusplus$ac2
S 23385 3 0 0 0 6 1 1 0 0 0 0 0 0 0 -1 -2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 23387 25 1 esmf_staggerlocmod esmf_staggerloc
R 23388 5 2 esmf_staggerlocmod staggerloc
R 23396 6 10 esmf_staggerlocmod esmf_staggerloc_invalid$ac
R 23398 6 12 esmf_staggerlocmod esmf_staggerloc_uninit$ac
R 23400 6 14 esmf_staggerlocmod esmf_staggerloc_center$ac
R 23402 6 16 esmf_staggerlocmod esmf_staggerloc_edge1$ac
R 23404 6 18 esmf_staggerlocmod esmf_staggerloc_edge2$ac
R 23406 6 20 esmf_staggerlocmod esmf_staggerloc_corner$ac
R 23408 6 22 esmf_staggerlocmod esmf_staggerloc_center_vcenter$ac
R 23410 6 24 esmf_staggerlocmod esmf_staggerloc_edge1_vcenter$ac
R 23412 6 26 esmf_staggerlocmod esmf_staggerloc_edge2_vcenter$ac
R 23414 6 28 esmf_staggerlocmod esmf_staggerloc_corner_vcenter$ac
R 23416 6 30 esmf_staggerlocmod esmf_staggerloc_center_vface$ac
R 23418 6 32 esmf_staggerlocmod esmf_staggerloc_edge1_vface$ac
R 23420 6 34 esmf_staggerlocmod esmf_staggerloc_edge2_vface$ac
R 23422 6 36 esmf_staggerlocmod esmf_staggerloc_corner_vface$ac
R 23504 25 4 esmf_gridmod esmf_gridstatus
R 23505 5 5 esmf_gridmod gridstatus
R 23507 6 7 esmf_gridmod esmf_gridstatus_invalid$ac
R 23509 6 9 esmf_gridmod esmf_gridstatus_uninit$ac
R 23511 6 11 esmf_gridmod esmf_gridstatus_not_ready$ac
R 23513 6 13 esmf_gridmod esmf_gridstatus_shape_ready$ac
R 23514 25 14 esmf_gridmod esmf_gridconn
R 23515 5 15 esmf_gridmod gridconn
R 23517 6 17 esmf_gridmod esmf_gridconn_none$ac
R 23519 6 19 esmf_gridmod esmf_gridconn_periodic$ac
R 23521 6 21 esmf_gridmod esmf_gridconn_pole$ac
R 23523 6 23 esmf_gridmod esmf_gridconn_bipole$ac
R 25108 25 1 esmf_fieldmod esmf_access
R 25109 5 2 esmf_fieldmod a_type
R 25111 6 4 esmf_fieldmod esmf_readwrite$ac
R 25113 6 6 esmf_fieldmod esmf_readonly$ac
R 25114 25 7 esmf_fieldmod esmf_allocflag
R 25115 5 8 esmf_fieldmod a_type
R 25117 6 10 esmf_fieldmod esmf_alloc$ac
R 25119 6 12 esmf_fieldmod esmf_no_alloc$ac
R 32543 25 1 esmf_fieldbundlemod esmf_packflag
R 32544 5 2 esmf_fieldbundlemod packflag
R 32546 6 4 esmf_fieldbundlemod esmf_packed_data$ac
R 32548 6 6 esmf_fieldbundlemod esmf_no_packed_data$ac
S 33072 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 101 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 33073 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 102 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 33074 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 103 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 33075 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 104 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 33076 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 105 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 33077 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 106 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 33078 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 107 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 33079 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 108 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 33080 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 109 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 33081 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 110 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 33083 25 1 esmf_statetypesmod esmf_statetype
R 33084 5 2 esmf_statetypesmod state
R 33086 6 4 esmf_statetypesmod esmf_state_import$ac
R 33088 6 6 esmf_statetypesmod esmf_state_export$ac
R 33090 6 8 esmf_statetypesmod esmf_state_unspecified$ac
R 33092 6 10 esmf_statetypesmod esmf_state_invalid$ac
R 33093 25 11 esmf_statetypesmod esmf_stateitemtype
R 33094 5 12 esmf_statetypesmod ot
R 33096 6 14 esmf_statetypesmod esmf_stateitem_field$ac
R 33098 6 16 esmf_statetypesmod esmf_stateitem_fieldbundle$ac
R 33100 6 18 esmf_statetypesmod esmf_stateitem_array$ac
R 33102 6 20 esmf_statetypesmod esmf_stateitem_arraybundle$ac
R 33104 6 22 esmf_statetypesmod esmf_stateitem_routehandle$ac
R 33106 6 24 esmf_statetypesmod esmf_stateitem_state$ac
R 33108 6 26 esmf_statetypesmod esmf_stateitem_name$ac
R 33110 6 28 esmf_statetypesmod esmf_stateitem_indirect$ac
R 33112 6 30 esmf_statetypesmod esmf_stateitem_unknown$ac
R 33114 6 32 esmf_statetypesmod esmf_stateitem_notfound$ac
R 33115 25 33 esmf_statetypesmod esmf_neededflag
R 33116 5 34 esmf_statetypesmod needed
R 33118 6 36 esmf_statetypesmod esmf_needed$ac
R 33120 6 38 esmf_statetypesmod esmf_notneeded$ac
R 33121 25 39 esmf_statetypesmod esmf_readyflag
R 33122 5 40 esmf_statetypesmod ready
R 33124 6 42 esmf_statetypesmod esmf_readytowrite$ac
R 33126 6 44 esmf_statetypesmod esmf_readytoread$ac
R 33128 6 46 esmf_statetypesmod esmf_notready$ac
R 33129 25 47 esmf_statetypesmod esmf_reqforrestartflag
R 33130 5 48 esmf_statetypesmod required4restart
R 33132 6 50 esmf_statetypesmod esmf_required_for_restart$ac
R 33134 6 52 esmf_statetypesmod esmf_notrequired_for_restart$ac
R 33135 25 53 esmf_statetypesmod esmf_validflag
R 33136 5 54 esmf_statetypesmod valid
R 33138 6 56 esmf_statetypesmod esmf_valid$ac
R 33140 6 58 esmf_statetypesmod esmf_invalid$ac
R 33142 6 60 esmf_statetypesmod esmf_validityunknown$ac
R 34242 25 1 esmf_compmod esmf_comptype
R 34243 5 2 esmf_compmod ctype
R 34245 6 4 esmf_compmod esmf_comptype_grid$ac
R 34247 6 6 esmf_compmod esmf_comptype_cpl$ac
R 34248 25 7 esmf_compmod esmf_gridcomptype
R 34249 5 8 esmf_compmod gridcomptype
R 34251 6 10 esmf_compmod esmf_atm$ac
R 34253 6 12 esmf_compmod esmf_land$ac
R 34255 6 14 esmf_compmod esmf_ocean$ac
R 34257 6 16 esmf_compmod esmf_seaice$ac
R 34259 6 18 esmf_compmod esmf_river$ac
R 34261 6 20 esmf_compmod esmf_other$ac
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
A 404 1 0 0 319 35 753 0 0 0 0 0 0 0 0 0 0 0 0 0
A 407 1 0 0 322 35 755 0 0 0 0 0 0 0 0 0 0 0 0 0
A 410 1 0 0 325 35 757 0 0 0 0 0 0 0 0 0 0 0 0 0
A 413 1 0 0 272 35 759 0 0 0 0 0 0 0 0 0 0 0 0 0
A 416 1 0 0 278 35 761 0 0 0 0 0 0 0 0 0 0 0 0 0
A 419 1 0 0 284 35 763 0 0 0 0 0 0 0 0 0 0 0 0 0
A 422 1 0 0 398 35 765 0 0 0 0 0 0 0 0 0 0 0 0 0
A 425 1 0 0 0 41 769 0 0 0 0 0 0 0 0 0 0 0 0 0
A 428 1 0 0 0 41 771 0 0 0 0 0 0 0 0 0 0 0 0 0
A 431 1 0 0 0 47 775 0 0 0 0 0 0 0 0 0 0 0 0 0
A 434 1 0 0 0 47 777 0 0 0 0 0 0 0 0 0 0 0 0 0
A 437 1 0 0 0 47 779 0 0 0 0 0 0 0 0 0 0 0 0 0
A 440 1 0 0 0 47 781 0 0 0 0 0 0 0 0 0 0 0 0 0
A 443 1 0 0 0 47 783 0 0 0 0 0 0 0 0 0 0 0 0 0
A 446 1 0 0 0 47 785 0 0 0 0 0 0 0 0 0 0 0 0 0
A 449 1 0 0 0 47 787 0 0 0 0 0 0 0 0 0 0 0 0 0
A 452 1 0 0 0 47 789 0 0 0 0 0 0 0 0 0 0 0 0 0
A 455 1 0 0 0 47 791 0 0 0 0 0 0 0 0 0 0 0 0 0
A 458 1 0 0 0 47 793 0 0 0 0 0 0 0 0 0 0 0 0 0
A 461 1 0 0 0 47 795 0 0 0 0 0 0 0 0 0 0 0 0 0
A 464 1 0 0 0 47 797 0 0 0 0 0 0 0 0 0 0 0 0 0
A 467 1 0 0 0 47 799 0 0 0 0 0 0 0 0 0 0 0 0 0
A 468 2 0 0 0 67 653 0 0 0 468 0 0 0 0 0 0 0 0 0
A 472 1 0 0 0 59 818 0 0 0 0 0 0 0 0 0 0 0 0 0
A 473 2 0 0 0 69 655 0 0 0 473 0 0 0 0 0 0 0 0 0
A 477 1 0 0 0 59 820 0 0 0 0 0 0 0 0 0 0 0 0 0
A 478 2 0 0 0 69 656 0 0 0 478 0 0 0 0 0 0 0 0 0
A 482 1 0 0 0 59 822 0 0 0 0 0 0 0 0 0 0 0 0 0
A 483 2 0 0 0 67 657 0 0 0 483 0 0 0 0 0 0 0 0 0
A 487 1 0 0 0 59 824 0 0 0 0 0 0 0 0 0 0 0 0 0
A 488 2 0 0 0 71 659 0 0 0 488 0 0 0 0 0 0 0 0 0
A 492 1 0 0 0 59 826 0 0 0 0 0 0 0 0 0 0 0 0 0
A 493 2 0 0 0 73 661 0 0 0 493 0 0 0 0 0 0 0 0 0
A 497 1 0 0 0 59 828 0 0 0 0 0 0 0 0 0 0 0 0 0
A 498 2 0 0 0 75 662 0 0 0 498 0 0 0 0 0 0 0 0 0
A 502 1 0 0 0 59 830 0 0 0 0 0 0 0 0 0 0 0 0 0
A 503 2 0 0 0 75 663 0 0 0 503 0 0 0 0 0 0 0 0 0
A 507 1 0 0 0 59 832 0 0 0 0 0 0 0 0 0 0 0 0 0
A 508 2 0 0 0 77 665 0 0 0 508 0 0 0 0 0 0 0 0 0
A 512 1 0 0 0 59 834 0 0 0 0 0 0 0 0 0 0 0 0 0
A 513 2 0 0 0 79 667 0 0 0 513 0 0 0 0 0 0 0 0 0
A 517 1 0 0 0 59 836 0 0 0 0 0 0 0 0 0 0 0 0 0
A 518 2 0 0 262 81 669 0 0 0 518 0 0 0 0 0 0 0 0 0
A 522 1 0 0 0 59 838 0 0 0 0 0 0 0 0 0 0 0 0 0
A 523 2 0 0 0 83 670 0 0 0 523 0 0 0 0 0 0 0 0 0
A 527 1 0 0 0 59 840 0 0 0 0 0 0 0 0 0 0 0 0 0
A 528 2 0 0 352 71 671 0 0 0 528 0 0 0 0 0 0 0 0 0
A 532 1 0 0 0 59 842 0 0 0 0 0 0 0 0 0 0 0 0 0
A 533 2 0 0 0 69 672 0 0 0 533 0 0 0 0 0 0 0 0 0
A 537 1 0 0 394 59 844 0 0 0 0 0 0 0 0 0 0 0 0 0
A 538 2 0 0 355 75 673 0 0 0 538 0 0 0 0 0 0 0 0 0
A 542 1 0 0 0 59 846 0 0 0 0 0 0 0 0 0 0 0 0 0
A 543 2 0 0 0 71 674 0 0 0 543 0 0 0 0 0 0 0 0 0
A 547 1 0 0 0 59 848 0 0 0 0 0 0 0 0 0 0 0 0 0
A 548 2 0 0 0 77 675 0 0 0 548 0 0 0 0 0 0 0 0 0
A 552 1 0 0 0 59 850 0 0 0 0 0 0 0 0 0 0 0 0 0
A 553 2 0 0 0 79 676 0 0 0 553 0 0 0 0 0 0 0 0 0
A 557 1 0 0 0 59 852 0 0 0 0 0 0 0 0 0 0 0 0 0
A 558 2 0 0 358 75 677 0 0 0 558 0 0 0 0 0 0 0 0 0
A 562 1 0 0 0 59 854 0 0 0 0 0 0 0 0 0 0 0 0 0
A 563 2 0 0 291 81 678 0 0 0 563 0 0 0 0 0 0 0 0 0
A 567 1 0 0 0 59 856 0 0 0 0 0 0 0 0 0 0 0 0 0
A 568 2 0 0 361 73 679 0 0 0 568 0 0 0 0 0 0 0 0 0
A 572 1 0 0 0 59 858 0 0 0 0 0 0 0 0 0 0 0 0 0
A 573 2 0 0 0 75 680 0 0 0 573 0 0 0 0 0 0 0 0 0
A 577 1 0 0 0 59 860 0 0 0 0 0 0 0 0 0 0 0 0 0
A 578 2 0 0 0 81 681 0 0 0 578 0 0 0 0 0 0 0 0 0
A 582 1 0 0 0 59 862 0 0 0 0 0 0 0 0 0 0 0 0 0
A 583 2 0 0 0 85 683 0 0 0 583 0 0 0 0 0 0 0 0 0
A 587 1 0 0 41 59 864 0 0 0 0 0 0 0 0 0 0 0 0 0
A 588 2 0 0 30 69 684 0 0 0 588 0 0 0 0 0 0 0 0 0
A 592 1 0 0 44 59 866 0 0 0 0 0 0 0 0 0 0 0 0 0
A 593 2 0 0 367 77 685 0 0 0 593 0 0 0 0 0 0 0 0 0
A 597 1 0 0 48 59 868 0 0 0 0 0 0 0 0 0 0 0 0 0
A 598 2 0 0 33 75 686 0 0 0 598 0 0 0 0 0 0 0 0 0
A 602 1 0 0 51 59 870 0 0 0 0 0 0 0 0 0 0 0 0 0
A 603 2 0 0 0 87 687 0 0 0 603 0 0 0 0 0 0 0 0 0
A 607 1 0 0 385 59 872 0 0 0 0 0 0 0 0 0 0 0 0 0
A 608 2 0 0 35 73 688 0 0 0 608 0 0 0 0 0 0 0 0 0
A 612 1 0 0 388 59 874 0 0 0 0 0 0 0 0 0 0 0 0 0
A 613 2 0 0 36 77 689 0 0 0 613 0 0 0 0 0 0 0 0 0
A 617 1 0 0 391 59 876 0 0 0 0 0 0 0 0 0 0 0 0 0
A 618 2 0 0 0 81 690 0 0 0 618 0 0 0 0 0 0 0 0 0
A 622 1 0 0 0 59 878 0 0 0 0 0 0 0 0 0 0 0 0 0
A 623 2 0 0 38 67 691 0 0 0 623 0 0 0 0 0 0 0 0 0
A 627 1 0 0 66 59 880 0 0 0 0 0 0 0 0 0 0 0 0 0
A 630 1 0 0 557 116 907 0 0 0 0 0 0 0 0 0 0 0 0 0
A 633 1 0 0 562 116 909 0 0 0 0 0 0 0 0 0 0 0 0 0
A 636 1 0 0 572 122 913 0 0 0 0 0 0 0 0 0 0 0 0 0
A 639 1 0 0 577 122 915 0 0 0 0 0 0 0 0 0 0 0 0 0
A 642 1 0 0 582 122 917 0 0 0 0 0 0 0 0 0 0 0 0 0
A 645 1 0 0 587 122 919 0 0 0 0 0 0 0 0 0 0 0 0 0
A 648 1 0 0 592 122 921 0 0 0 0 0 0 0 0 0 0 0 0 0
A 651 1 0 0 597 122 923 0 0 0 0 0 0 0 0 0 0 0 0 0
A 654 1 0 0 602 122 925 0 0 0 0 0 0 0 0 0 0 0 0 0
A 657 1 0 0 0 128 929 0 0 0 0 0 0 0 0 0 0 0 0 0
A 660 1 0 0 208 128 931 0 0 0 0 0 0 0 0 0 0 0 0 0
A 663 1 0 0 220 134 935 0 0 0 0 0 0 0 0 0 0 0 0 0
A 666 1 0 0 226 134 937 0 0 0 0 0 0 0 0 0 0 0 0 0
A 669 1 0 0 0 134 939 0 0 0 0 0 0 0 0 0 0 0 0 0
A 672 1 0 0 0 140 943 0 0 0 0 0 0 0 0 0 0 0 0 0
A 675 1 0 0 0 140 945 0 0 0 0 0 0 0 0 0 0 0 0 0
A 678 1 0 0 0 140 947 0 0 0 0 0 0 0 0 0 0 0 0 0
A 681 1 0 0 533 146 951 0 0 0 0 0 0 0 0 0 0 0 0 0
A 684 1 0 0 543 146 953 0 0 0 0 0 0 0 0 0 0 0 0 0
A 687 1 0 0 0 152 957 0 0 0 0 0 0 0 0 0 0 0 0 0
A 690 1 0 0 573 152 959 0 0 0 0 0 0 0 0 0 0 0 0 0
A 693 1 0 0 26 152 961 0 0 0 0 0 0 0 0 0 0 0 0 0
A 696 1 0 0 598 158 965 0 0 0 0 0 0 0 0 0 0 0 0 0
A 699 1 0 0 608 158 967 0 0 0 0 0 0 0 0 0 0 0 0 0
A 702 1 0 0 0 164 971 0 0 0 0 0 0 0 0 0 0 0 0 0
A 705 1 0 0 0 164 973 0 0 0 0 0 0 0 0 0 0 0 0 0
A 708 1 0 0 0 170 977 0 0 0 0 0 0 0 0 0 0 0 0 0
A 711 1 0 0 0 170 979 0 0 0 0 0 0 0 0 0 0 0 0 0
A 714 1 0 0 416 176 983 0 0 0 0 0 0 0 0 0 0 0 0 0
A 717 1 0 0 419 176 985 0 0 0 0 0 0 0 0 0 0 0 0 0
A 720 1 0 0 422 176 987 0 0 0 0 0 0 0 0 0 0 0 0 0
A 805 1 0 0 151 322 1214 0 0 0 0 0 0 0 0 0 0 0 0 0
A 808 1 0 0 156 322 1216 0 0 0 0 0 0 0 0 0 0 0 0 0
A 811 1 0 0 161 322 1218 0 0 0 0 0 0 0 0 0 0 0 0 0
A 814 1 0 0 171 328 1222 0 0 0 0 0 0 0 0 0 0 0 0 0
A 817 1 0 0 176 328 1224 0 0 0 0 0 0 0 0 0 0 0 0 0
A 820 1 0 0 181 328 1226 0 0 0 0 0 0 0 0 0 0 0 0 0
A 823 1 0 0 192 334 1230 0 0 0 0 0 0 0 0 0 0 0 0 0
A 826 1 0 0 197 334 1232 0 0 0 0 0 0 0 0 0 0 0 0 0
A 829 1 0 0 202 334 1234 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1018 2 0 0 273 6 1735 0 0 0 1018 0 0 0 0 0 0 0 0 0
A 1150 1 0 0 1074 1537 1902 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1153 1 0 0 1076 1537 1904 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1156 1 0 0 0 1537 1906 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1159 1 0 0 952 1543 1910 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1162 1 0 0 0 1543 1912 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1165 1 0 0 0 1543 1914 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1168 1 0 0 1087 1543 1916 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1171 1 0 0 0 1543 1918 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1174 1 0 0 0 1543 1920 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1314 1 0 0 16 2055 2029 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1317 1 0 0 233 2055 2031 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1320 1 0 0 239 2055 2033 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1323 1 0 0 245 2055 2035 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1326 1 0 0 251 2055 2037 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1329 1 0 0 257 2055 2039 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1332 1 0 0 263 2055 2041 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1555 1 0 0 1530 3152 2903 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1558 1 0 0 1531 3152 2905 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1561 1 0 0 1270 3152 2907 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1564 1 0 0 1535 3152 2909 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1686 1 0 0 1464 3746 3297 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1689 1 0 0 1044 3746 3299 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1692 1 0 0 1468 3746 3301 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7350 1 0 0 6647 3942 3377 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7353 1 0 0 7293 3942 3379 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7356 1 0 0 7292 3942 3381 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7359 1 0 0 7297 3942 3383 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7362 1 0 0 7296 3942 3385 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7365 1 0 0 7300 3948 3389 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7368 1 0 0 7230 3948 3391 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9519 1 0 0 9476 7600 8680 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9522 1 0 0 9475 7600 8682 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9525 1 0 0 8730 7612 8691 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9528 1 0 0 6680 7612 8693 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9531 1 0 0 9482 7612 8695 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9534 1 0 0 9481 7612 8697 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9537 1 0 0 9264 7612 8699 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9540 1 0 0 9485 7612 8701 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9543 1 0 0 8783 7612 8703 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9546 1 0 0 9488 7612 8705 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9549 1 0 0 8266 7612 8707 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9552 1 0 0 9274 7612 8709 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9555 1 0 0 8948 7612 8711 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9558 1 0 0 7787 7612 8713 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9561 1 0 0 8341 7612 8715 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9564 1 0 0 9282 7612 8717 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9567 1 0 0 8625 7618 8721 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9570 1 0 0 8201 7618 8723 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9573 1 0 0 9150 7618 8725 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9576 1 0 0 8729 7618 8727 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9579 1 0 0 7627 7618 8729 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9582 1 0 0 7130 7618 8731 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9585 1 0 0 8621 7618 8733 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9588 1 0 0 9160 7618 8735 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9591 1 0 0 8261 7618 8737 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10265 1 0 0 10148 8354 10225 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10268 1 0 0 10242 8354 10227 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10776 1 0 0 10458 8627 10522 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10779 1 0 0 10463 8627 10524 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10782 1 0 0 10772 8627 10526 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10785 1 0 0 10474 8627 10528 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10788 1 0 0 10468 8627 10530 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10853 2 0 0 10534 6 11279 0 0 0 10853 0 0 0 0 0 0 0 0 0
A 11280 1 0 0 9975 9280 11287 0 0 0 0 0 0 0 0 0 0 0 0 0
A 11283 1 0 0 10503 9280 11289 0 0 0 0 0 0 0 0 0 0 0 0 0
A 11286 1 0 0 10253 9280 11291 0 0 0 0 0 0 0 0 0 0 0 0 0
A 11289 1 0 0 10502 9280 11293 0 0 0 0 0 0 0 0 0 0 0 0 0
A 11292 1 0 0 10992 9280 11295 0 0 0 0 0 0 0 0 0 0 0 0 0
A 11295 1 0 0 11269 9280 11297 0 0 0 0 0 0 0 0 0 0 0 0 0
A 11298 1 0 0 10507 9280 11299 0 0 0 0 0 0 0 0 0 0 0 0 0
A 11301 1 0 0 11273 9280 11301 0 0 0 0 0 0 0 0 0 0 0 0 0
A 21387 1 0 0 20579 14114 18973 0 0 0 0 0 0 0 0 0 0 0 0 0
A 21390 1 0 0 19636 14114 18975 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23808 2 0 0 21515 6 23385 0 0 0 23808 0 0 0 0 0 0 0 0 0
A 23894 1 0 0 23494 17773 23396 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23897 1 0 0 23496 17773 23398 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23900 1 0 0 21664 17773 23400 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23903 1 0 0 22801 17773 23402 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23906 1 0 0 23503 17773 23404 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23909 1 0 0 23502 17773 23406 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23912 1 0 0 21890 17773 23408 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23915 1 0 0 22770 17773 23410 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23918 1 0 0 21521 17773 23412 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23921 1 0 0 20055 17773 23414 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23924 1 0 0 22457 17773 23416 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23927 1 0 0 23808 17773 23418 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23930 1 0 0 22900 17773 23420 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23933 1 0 0 21292 17773 23422 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24861 1 0 0 24454 18021 23507 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24864 1 0 0 24120 18021 23509 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24867 1 0 0 24800 18021 23511 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24870 1 0 0 24513 18021 23513 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24873 1 0 0 24509 18027 23517 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24876 1 0 0 24508 18027 23519 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24879 1 0 0 24806 18027 23521 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24882 1 0 0 24805 18027 23523 0 0 0 0 0 0 0 0 0 0 0 0 0
A 25055 1 0 0 24999 19296 25111 0 0 0 0 0 0 0 0 0 0 0 0 0
A 25058 1 0 0 24506 19296 25113 0 0 0 0 0 0 0 0 0 0 0 0 0
A 25061 1 0 0 24801 19302 25117 0 0 0 0 0 0 0 0 0 0 0 0 0
A 25064 1 0 0 24507 19302 25119 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31751 1 0 0 29890 24010 32546 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31754 1 0 0 30235 24010 32548 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31768 2 0 0 31363 6 33072 0 0 0 31768 0 0 0 0 0 0 0 0 0
A 31772 2 0 0 31642 6 33073 0 0 0 31772 0 0 0 0 0 0 0 0 0
A 31776 2 0 0 31644 6 33074 0 0 0 31776 0 0 0 0 0 0 0 0 0
A 31780 2 0 0 31641 6 33075 0 0 0 31780 0 0 0 0 0 0 0 0 0
A 31784 2 0 0 31643 6 33076 0 0 0 31784 0 0 0 0 0 0 0 0 0
A 31788 2 0 0 31370 6 33077 0 0 0 31788 0 0 0 0 0 0 0 0 0
A 31792 2 0 0 31372 6 33078 0 0 0 31792 0 0 0 0 0 0 0 0 0
A 31796 2 0 0 31369 6 33079 0 0 0 31796 0 0 0 0 0 0 0 0 0
A 31800 2 0 0 31371 6 33080 0 0 0 31800 0 0 0 0 0 0 0 0 0
A 31804 2 0 0 31701 6 33081 0 0 0 31804 0 0 0 0 0 0 0 0 0
A 31881 1 0 0 31858 24413 33086 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31884 1 0 0 31341 24413 33088 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31887 1 0 0 30651 24413 33090 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31890 1 0 0 31864 24413 33092 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31893 1 0 0 31563 24419 33096 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31896 1 0 0 31568 24419 33098 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31899 1 0 0 31559 24419 33100 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31902 1 0 0 31564 24419 33102 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31905 1 0 0 30546 24419 33104 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31908 1 0 0 30548 24419 33106 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31911 1 0 0 31747 24419 33108 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31914 1 0 0 31693 24419 33110 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31917 1 0 0 31233 24419 33112 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31920 1 0 0 31700 24419 33114 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31923 1 0 0 31230 24425 33118 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31926 1 0 0 31844 24425 33120 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31929 1 0 0 31699 24431 33124 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31932 1 0 0 31571 24431 33126 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31935 1 0 0 31584 24431 33128 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31938 1 0 0 31678 24437 33132 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31941 1 0 0 31729 24437 33134 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31944 1 0 0 31733 24443 33138 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31947 1 0 0 31735 24443 33140 0 0 0 0 0 0 0 0 0 0 0 0 0
A 31950 1 0 0 31737 24443 33142 0 0 0 0 0 0 0 0 0 0 0 0 0
A 32414 1 0 0 32261 26019 34245 0 0 0 0 0 0 0 0 0 0 0 0 0
A 32417 1 0 0 31422 26019 34247 0 0 0 0 0 0 0 0 0 0 0 0 0
A 32420 1 0 0 32033 26025 34251 0 0 0 0 0 0 0 0 0 0 0 0 0
A 32423 1 0 0 32382 26025 34253 0 0 0 0 0 0 0 0 0 0 0 0 0
A 32426 1 0 0 31062 26025 34255 0 0 0 0 0 0 0 0 0 0 0 0 0
A 32429 1 0 0 32325 26025 34257 0 0 0 0 0 0 0 0 0 0 0 0 0
A 32432 1 0 0 32312 26025 34259 0 0 0 0 0 0 0 0 0 0 0 0 0
A 32435 1 0 0 32314 26025 34261 0 0 0 0 0 0 0 0 0 0 0 0 0
Z
J 97 1 1
V 404 35 7 0
S 0 35 0 0 0
A 0 6 0 0 1 3 0
J 97 1 1
V 407 35 7 0
S 0 35 0 0 0
A 0 6 0 0 1 45 0
J 97 1 1
V 410 35 7 0
S 0 35 0 0 0
A 0 6 0 0 1 32 0
J 97 1 1
V 413 35 7 0
S 0 35 0 0 0
A 0 6 0 0 1 52 0
J 97 1 1
V 416 35 7 0
S 0 35 0 0 0
A 0 6 0 0 1 56 0
J 97 1 1
V 419 35 7 0
S 0 35 0 0 0
A 0 6 0 0 1 60 0
J 97 1 1
V 422 35 7 0
S 0 35 0 0 0
A 0 6 0 0 1 21 0
J 124 1 1
V 425 41 7 0
S 0 41 0 0 0
A 0 6 0 0 1 2 0
J 124 1 1
V 428 41 7 0
S 0 41 0 0 0
A 0 6 0 0 1 27 0
J 145 1 1
V 431 47 7 0
S 0 47 0 0 0
A 0 6 0 0 1 3 0
J 145 1 1
V 434 47 7 0
S 0 47 0 0 0
A 0 6 0 0 1 45 0
J 145 1 1
V 437 47 7 0
S 0 47 0 0 0
A 0 6 0 0 1 32 0
J 145 1 1
V 440 47 7 0
S 0 47 0 0 0
A 0 6 0 0 1 52 0
J 145 1 1
V 443 47 7 0
S 0 47 0 0 0
A 0 6 0 0 1 56 0
J 145 1 1
V 446 47 7 0
S 0 47 0 0 0
A 0 6 0 0 1 60 0
J 145 1 1
V 449 47 7 0
S 0 47 0 0 0
A 0 6 0 0 1 21 0
J 145 1 1
V 452 47 7 0
S 0 47 0 0 0
A 0 6 0 0 1 95 0
J 145 1 1
V 455 47 7 0
S 0 47 0 0 0
A 0 6 0 0 1 13 0
J 145 1 1
V 458 47 7 0
S 0 47 0 0 0
A 0 6 0 0 1 17 0
J 145 1 1
V 461 47 7 0
S 0 47 0 0 0
A 0 6 0 0 1 105 0
J 145 1 1
V 464 47 7 0
S 0 47 0 0 0
A 0 6 0 0 1 109 0
J 145 1 1
V 467 47 7 0
S 0 47 0 0 0
A 0 6 0 0 1 113 0
J 219 1 1
V 472 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 3 1
A 0 67 0 0 1 468 0
J 219 1 1
V 477 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 45 1
A 0 69 0 0 1 473 0
J 219 1 1
V 482 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 32 1
A 0 69 0 0 1 478 0
J 219 1 1
V 487 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 52 1
A 0 67 0 0 1 483 0
J 219 1 1
V 492 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 56 1
A 0 71 0 0 1 488 0
J 219 1 1
V 497 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 60 1
A 0 73 0 0 1 493 0
J 219 1 1
V 502 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 21 1
A 0 75 0 0 1 498 0
J 219 1 1
V 507 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 95 1
A 0 75 0 0 1 503 0
J 219 1 1
V 512 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 13 1
A 0 77 0 0 1 508 0
J 219 1 1
V 517 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 17 1
A 0 79 0 0 1 513 0
J 219 1 1
V 522 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 14 1
A 0 81 0 0 1 518 0
J 219 1 1
V 527 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 182 1
A 0 83 0 0 1 523 0
J 219 1 1
V 532 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 15 1
A 0 71 0 0 1 528 0
J 219 1 1
V 537 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 18 1
A 0 69 0 0 1 533 0
J 219 1 1
V 542 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 20 1
A 0 75 0 0 1 538 0
J 219 1 1
V 547 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 16 1
A 0 71 0 0 1 543 0
J 219 1 1
V 552 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 208 1
A 0 77 0 0 1 548 0
J 219 1 1
V 557 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 214 1
A 0 79 0 0 1 553 0
J 219 1 1
V 562 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 220 1
A 0 75 0 0 1 558 0
J 219 1 1
V 567 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 226 1
A 0 81 0 0 1 563 0
J 219 1 1
V 572 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 232 1
A 0 73 0 0 1 568 0
J 219 1 1
V 577 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 238 1
A 0 75 0 0 1 573 0
J 219 1 1
V 582 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 244 1
A 0 81 0 0 1 578 0
J 219 1 1
V 587 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 250 1
A 0 85 0 0 1 583 0
J 219 1 1
V 592 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 256 1
A 0 69 0 0 1 588 0
J 219 1 1
V 597 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 262 1
A 0 77 0 0 1 593 0
J 219 1 1
V 602 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 24 1
A 0 75 0 0 1 598 0
J 219 1 1
V 607 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 273 1
A 0 87 0 0 1 603 0
J 219 1 1
V 612 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 279 1
A 0 73 0 0 1 608 0
J 219 1 1
V 617 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 285 1
A 0 77 0 0 1 613 0
J 219 1 1
V 622 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 291 1
A 0 81 0 0 1 618 0
J 219 1 1
V 627 59 7 0
S 0 59 0 0 0
A 0 6 0 0 1 113 1
A 0 67 0 0 1 623 0
J 303 1 1
V 630 116 7 0
S 0 116 0 0 0
A 0 6 0 0 1 3 0
J 303 1 1
V 633 116 7 0
S 0 116 0 0 0
A 0 6 0 0 1 45 0
J 337 1 1
V 636 122 7 0
S 0 122 0 0 0
A 0 6 0 0 1 3 0
J 337 1 1
V 639 122 7 0
S 0 122 0 0 0
A 0 6 0 0 1 45 0
J 337 1 1
V 642 122 7 0
S 0 122 0 0 0
A 0 6 0 0 1 32 0
J 337 1 1
V 645 122 7 0
S 0 122 0 0 0
A 0 6 0 0 1 52 0
J 337 1 1
V 648 122 7 0
S 0 122 0 0 0
A 0 6 0 0 1 56 0
J 337 1 1
V 651 122 7 0
S 0 122 0 0 0
A 0 6 0 0 1 60 0
J 337 1 1
V 654 122 7 0
S 0 122 0 0 0
A 0 6 0 0 1 21 0
J 363 1 1
V 657 128 7 0
S 0 128 0 0 0
A 0 6 0 0 1 3 0
J 363 1 1
V 660 128 7 0
S 0 128 0 0 0
A 0 6 0 0 1 45 0
J 378 1 1
V 663 134 7 0
S 0 134 0 0 0
A 0 6 0 0 1 3 0
J 378 1 1
V 666 134 7 0
S 0 134 0 0 0
A 0 6 0 0 1 45 0
J 378 1 1
V 669 134 7 0
S 0 134 0 0 0
A 0 6 0 0 1 32 0
J 392 1 1
V 672 140 7 0
S 0 140 0 0 0
A 0 6 0 0 1 3 0
J 392 1 1
V 675 140 7 0
S 0 140 0 0 0
A 0 6 0 0 1 45 0
J 392 1 1
V 678 140 7 0
S 0 140 0 0 0
A 0 6 0 0 1 32 0
J 407 1 1
V 681 146 7 0
S 0 146 0 0 0
A 0 6 0 0 1 3 0
J 407 1 1
V 684 146 7 0
S 0 146 0 0 0
A 0 6 0 0 1 45 0
J 421 1 1
V 687 152 7 0
S 0 152 0 0 0
A 0 6 0 0 1 3 0
J 421 1 1
V 690 152 7 0
S 0 152 0 0 0
A 0 6 0 0 1 45 0
J 421 1 1
V 693 152 7 0
S 0 152 0 0 0
A 0 6 0 0 1 32 0
J 436 1 1
V 696 158 7 0
S 0 158 0 0 0
A 0 6 0 0 1 3 0
J 436 1 1
V 699 158 7 0
S 0 158 0 0 0
A 0 6 0 0 1 45 0
J 450 1 1
V 702 164 7 0
S 0 164 0 0 0
A 0 6 0 0 1 3 0
J 450 1 1
V 705 164 7 0
S 0 164 0 0 0
A 0 6 0 0 1 45 0
J 465 1 1
V 708 170 7 0
S 0 170 0 0 0
A 0 6 0 0 1 2 0
J 465 1 1
V 711 170 7 0
S 0 170 0 0 0
A 0 6 0 0 1 3 0
J 480 1 1
V 714 176 7 0
S 0 176 0 0 0
A 0 6 0 0 1 2 0
J 480 1 1
V 717 176 7 0
S 0 176 0 0 0
A 0 6 0 0 1 3 0
J 480 1 1
V 720 176 7 0
S 0 176 0 0 0
A 0 6 0 0 1 45 0
J 67 1 1
V 805 322 7 0
S 0 322 0 0 0
A 0 6 0 0 1 3 0
J 67 1 1
V 808 322 7 0
S 0 322 0 0 0
A 0 6 0 0 1 45 0
J 67 1 1
V 811 322 7 0
S 0 322 0 0 0
A 0 6 0 0 1 32 0
J 79 1 1
V 814 328 7 0
S 0 328 0 0 0
A 0 6 0 0 1 3 0
J 79 1 1
V 817 328 7 0
S 0 328 0 0 0
A 0 6 0 0 1 45 0
J 79 1 1
V 820 328 7 0
S 0 328 0 0 0
A 0 6 0 0 1 32 0
J 91 1 1
V 823 334 7 0
S 0 334 0 0 0
A 0 6 0 0 1 3 0
J 91 1 1
V 826 334 7 0
S 0 334 0 0 0
A 0 6 0 0 1 45 0
J 91 1 1
V 829 334 7 0
S 0 334 0 0 0
A 0 6 0 0 1 32 0
J 54 1 1
V 1150 1537 7 0
S 0 1537 0 0 0
A 0 6 0 0 1 2 0
J 54 1 1
V 1153 1537 7 0
S 0 1537 0 0 0
A 0 6 0 0 1 3 0
J 54 1 1
V 1156 1537 7 0
S 0 1537 0 0 0
A 0 6 0 0 1 45 0
J 66 1 1
V 1159 1543 7 0
S 0 1543 0 0 0
A 0 6 0 0 1 2 0
J 66 1 1
V 1162 1543 7 0
S 0 1543 0 0 0
A 0 6 0 0 1 3 0
J 66 1 1
V 1165 1543 7 0
S 0 1543 0 0 0
A 0 6 0 0 1 45 0
J 66 1 1
V 1168 1543 7 0
S 0 1543 0 0 0
A 0 6 0 0 1 32 0
J 66 1 1
V 1171 1543 7 0
S 0 1543 0 0 0
A 0 6 0 0 1 52 0
J 66 1 1
V 1174 1543 7 0
S 0 1543 0 0 0
A 0 6 0 0 1 56 0
J 69 1 1
V 1314 2055 7 0
S 0 2055 0 0 0
A 0 6 0 0 1 3 0
J 69 1 1
V 1317 2055 7 0
S 0 2055 0 0 0
A 0 6 0 0 1 45 0
J 69 1 1
V 1320 2055 7 0
S 0 2055 0 0 0
A 0 6 0 0 1 32 0
J 69 1 1
V 1323 2055 7 0
S 0 2055 0 0 0
A 0 6 0 0 1 52 0
J 69 1 1
V 1326 2055 7 0
S 0 2055 0 0 0
A 0 6 0 0 1 56 0
J 69 1 1
V 1329 2055 7 0
S 0 2055 0 0 0
A 0 6 0 0 1 60 0
J 69 1 1
V 1332 2055 7 0
S 0 2055 0 0 0
A 0 6 0 0 1 21 0
J 62 1 1
V 1555 3152 7 0
S 0 3152 0 0 0
A 0 6 0 0 1 3 0
J 62 1 1
V 1558 3152 7 0
S 0 3152 0 0 0
A 0 6 0 0 1 45 0
J 62 1 1
V 1561 3152 7 0
S 0 3152 0 0 0
A 0 6 0 0 1 32 0
J 62 1 1
V 1564 3152 7 0
S 0 3152 0 0 0
A 0 6 0 0 1 52 0
J 68 1 1
V 1686 3746 7 0
S 0 3746 0 0 0
A 0 6 0 0 1 2 0
J 68 1 1
V 1689 3746 7 0
S 0 3746 0 0 0
A 0 6 0 0 1 3 0
J 68 1 1
V 1692 3746 7 0
S 0 3746 0 0 0
A 0 6 0 0 1 45 0
J 71 1 1
V 7350 3942 7 0
S 0 3942 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 7353 3942 7 0
S 0 3942 0 0 0
A 0 6 0 0 1 45 0
J 71 1 1
V 7356 3942 7 0
S 0 3942 0 0 0
A 0 6 0 0 1 32 0
J 71 1 1
V 7359 3942 7 0
S 0 3942 0 0 0
A 0 6 0 0 1 52 0
J 71 1 1
V 7362 3942 7 0
S 0 3942 0 0 0
A 0 6 0 0 1 56 0
J 91 1 1
V 7365 3948 7 0
S 0 3948 0 0 0
A 0 6 0 0 1 3 0
J 91 1 1
V 7368 3948 7 0
S 0 3948 0 0 0
A 0 6 0 0 1 45 0
J 71 1 1
V 9519 7600 7 0
S 0 7600 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 9522 7600 7 0
S 0 7600 0 0 0
A 0 6 0 0 1 45 0
J 102 1 1
V 9525 7612 7 0
S 0 7612 0 0 0
A 0 6 0 0 1 2 0
J 102 1 1
V 9528 7612 7 0
S 0 7612 0 0 0
A 0 6 0 0 1 3 0
J 102 1 1
V 9531 7612 7 0
S 0 7612 0 0 0
A 0 6 0 0 1 45 0
J 102 1 1
V 9534 7612 7 0
S 0 7612 0 0 0
A 0 6 0 0 1 32 0
J 102 1 1
V 9537 7612 7 0
S 0 7612 0 0 0
A 0 6 0 0 1 52 0
J 102 1 1
V 9540 7612 7 0
S 0 7612 0 0 0
A 0 6 0 0 1 56 0
J 102 1 1
V 9543 7612 7 0
S 0 7612 0 0 0
A 0 6 0 0 1 60 0
J 102 1 1
V 9546 7612 7 0
S 0 7612 0 0 0
A 0 6 0 0 1 21 0
J 102 1 1
V 9549 7612 7 0
S 0 7612 0 0 0
A 0 6 0 0 1 95 0
J 102 1 1
V 9552 7612 7 0
S 0 7612 0 0 0
A 0 6 0 0 1 13 0
J 102 1 1
V 9555 7612 7 0
S 0 7612 0 0 0
A 0 6 0 0 1 17 0
J 102 1 1
V 9558 7612 7 0
S 0 7612 0 0 0
A 0 6 0 0 1 14 0
J 102 1 1
V 9561 7612 7 0
S 0 7612 0 0 0
A 0 6 0 0 1 182 0
J 102 1 1
V 9564 7612 7 0
S 0 7612 0 0 0
A 0 6 0 0 1 15 0
J 129 1 1
V 9567 7618 7 0
S 0 7618 0 0 0
A 0 6 0 0 1 2 0
J 129 1 1
V 9570 7618 7 0
S 0 7618 0 0 0
A 0 6 0 0 1 3 0
J 129 1 1
V 9573 7618 7 0
S 0 7618 0 0 0
A 0 6 0 0 1 45 0
J 129 1 1
V 9576 7618 7 0
S 0 7618 0 0 0
A 0 6 0 0 1 32 0
J 129 1 1
V 9579 7618 7 0
S 0 7618 0 0 0
A 0 6 0 0 1 52 0
J 129 1 1
V 9582 7618 7 0
S 0 7618 0 0 0
A 0 6 0 0 1 56 0
J 129 1 1
V 9585 7618 7 0
S 0 7618 0 0 0
A 0 6 0 0 1 60 0
J 129 1 1
V 9588 7618 7 0
S 0 7618 0 0 0
A 0 6 0 0 1 21 0
J 129 1 1
V 9591 7618 7 0
S 0 7618 0 0 0
A 0 6 0 0 1 95 0
J 71 1 1
V 10265 8354 7 0
S 0 8354 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 10268 8354 7 0
S 0 8354 0 0 0
A 0 6 0 0 1 45 0
J 72 1 1
V 10776 8627 7 0
S 0 8627 0 0 0
A 0 6 0 0 1 3 0
J 72 1 1
V 10779 8627 7 0
S 0 8627 0 0 0
A 0 6 0 0 1 45 0
J 72 1 1
V 10782 8627 7 0
S 0 8627 0 0 0
A 0 6 0 0 1 32 0
J 72 1 1
V 10785 8627 7 0
S 0 8627 0 0 0
A 0 6 0 0 1 52 0
J 72 1 1
V 10788 8627 7 0
S 0 8627 0 0 0
A 0 6 0 0 1 56 0
J 69 1 1
V 11280 9280 7 0
S 0 9280 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 11283 9280 7 0
S 0 9280 0 0 0
A 0 6 0 0 1 45 0
J 73 1 1
V 11286 9280 7 0
S 0 9280 0 0 0
A 0 6 0 0 1 52 0
J 75 1 1
V 11289 9280 7 0
S 0 9280 0 0 0
A 0 6 0 0 1 95 0
J 77 1 1
V 11292 9280 7 0
S 0 9280 0 0 0
A 0 6 0 0 1 20 0
J 79 1 1
V 11295 9280 7 0
S 0 9280 0 0 0
A 0 6 0 0 1 24 0
J 81 1 1
V 11298 9280 7 0
S 0 9280 0 0 0
A 0 6 0 0 1 1018 0
J 83 1 1
V 11301 9280 7 0
S 0 9280 0 0 0
A 0 6 0 0 1 10853 0
J 59 1 1
V 21387 14114 7 0
S 0 14114 0 0 0
A 0 6 0 0 1 3 0
J 59 1 1
V 21390 14114 7 0
S 0 14114 0 0 0
A 0 6 0 0 1 45 0
J 79 1 1
V 23894 17773 7 0
S 0 17773 0 0 0
A 0 6 0 0 1 23808 0
J 79 1 1
V 23897 17773 7 0
S 0 17773 0 0 0
A 0 6 0 0 1 27 0
J 84 1 1
V 23900 17773 7 0
S 0 17773 0 0 0
A 0 6 0 0 1 2 0
J 84 1 1
V 23903 17773 7 0
S 0 17773 0 0 0
A 0 6 0 0 1 3 0
J 84 1 1
V 23906 17773 7 0
S 0 17773 0 0 0
A 0 6 0 0 1 45 0
J 84 1 1
V 23909 17773 7 0
S 0 17773 0 0 0
A 0 6 0 0 1 32 0
J 91 1 1
V 23912 17773 7 0
S 0 17773 0 0 0
A 0 6 0 0 1 2 0
J 91 1 1
V 23915 17773 7 0
S 0 17773 0 0 0
A 0 6 0 0 1 3 0
J 91 1 1
V 23918 17773 7 0
S 0 17773 0 0 0
A 0 6 0 0 1 45 0
J 91 1 1
V 23921 17773 7 0
S 0 17773 0 0 0
A 0 6 0 0 1 32 0
J 91 1 1
V 23924 17773 7 0
S 0 17773 0 0 0
A 0 6 0 0 1 52 0
J 91 1 1
V 23927 17773 7 0
S 0 17773 0 0 0
A 0 6 0 0 1 56 0
J 91 1 1
V 23930 17773 7 0
S 0 17773 0 0 0
A 0 6 0 0 1 60 0
J 91 1 1
V 23933 17773 7 0
S 0 17773 0 0 0
A 0 6 0 0 1 21 0
J 80 1 1
V 24861 18021 7 0
S 0 18021 0 0 0
A 0 6 0 0 1 27 0
J 80 1 1
V 24864 18021 7 0
S 0 18021 0 0 0
A 0 6 0 0 1 2 0
J 80 1 1
V 24867 18021 7 0
S 0 18021 0 0 0
A 0 6 0 0 1 3 0
J 80 1 1
V 24870 18021 7 0
S 0 18021 0 0 0
A 0 6 0 0 1 45 0
J 96 1 1
V 24873 18027 7 0
S 0 18027 0 0 0
A 0 6 0 0 1 2 0
J 96 1 1
V 24876 18027 7 0
S 0 18027 0 0 0
A 0 6 0 0 1 3 0
J 96 1 1
V 24879 18027 7 0
S 0 18027 0 0 0
A 0 6 0 0 1 45 0
J 96 1 1
V 24882 18027 7 0
S 0 18027 0 0 0
A 0 6 0 0 1 32 0
J 80 1 1
V 25055 19296 7 0
S 0 19296 0 0 0
A 0 6 0 0 1 2 0
J 80 1 1
V 25058 19296 7 0
S 0 19296 0 0 0
A 0 6 0 0 1 3 0
J 95 1 1
V 25061 19302 7 0
S 0 19302 0 0 0
A 0 6 0 0 1 2 0
J 95 1 1
V 25064 19302 7 0
S 0 19302 0 0 0
A 0 6 0 0 1 3 0
J 70 1 1
V 31751 24010 7 0
S 0 24010 0 0 0
A 0 6 0 0 1 3 0
J 70 1 1
V 31754 24010 7 0
S 0 24010 0 0 0
A 0 6 0 0 1 45 0
J 64 1 1
V 31881 24413 7 0
S 0 24413 0 0 0
A 0 6 0 0 1 3 0
J 64 1 1
V 31884 24413 7 0
S 0 24413 0 0 0
A 0 6 0 0 1 45 0
J 64 1 1
V 31887 24413 7 0
S 0 24413 0 0 0
A 0 6 0 0 1 32 0
J 64 1 1
V 31890 24413 7 0
S 0 24413 0 0 0
A 0 6 0 0 1 52 0
J 82 1 1
V 31893 24419 7 0
S 0 24419 0 0 0
A 0 6 0 0 1 31768 0
J 82 1 1
V 31896 24419 7 0
S 0 24419 0 0 0
A 0 6 0 0 1 31772 0
J 82 1 1
V 31899 24419 7 0
S 0 24419 0 0 0
A 0 6 0 0 1 31776 0
J 82 1 1
V 31902 24419 7 0
S 0 24419 0 0 0
A 0 6 0 0 1 31780 0
J 82 1 1
V 31905 24419 7 0
S 0 24419 0 0 0
A 0 6 0 0 1 31784 0
J 82 1 1
V 31908 24419 7 0
S 0 24419 0 0 0
A 0 6 0 0 1 31788 0
J 82 1 1
V 31911 24419 7 0
S 0 24419 0 0 0
A 0 6 0 0 1 31792 0
J 82 1 1
V 31914 24419 7 0
S 0 24419 0 0 0
A 0 6 0 0 1 31796 0
J 82 1 1
V 31917 24419 7 0
S 0 24419 0 0 0
A 0 6 0 0 1 31800 0
J 82 1 1
V 31920 24419 7 0
S 0 24419 0 0 0
A 0 6 0 0 1 31804 0
J 106 1 1
V 31923 24425 7 0
S 0 24425 0 0 0
A 0 6 0 0 1 3 0
J 106 1 1
V 31926 24425 7 0
S 0 24425 0 0 0
A 0 6 0 0 1 45 0
J 119 1 1
V 31929 24431 7 0
S 0 24431 0 0 0
A 0 6 0 0 1 3 0
J 119 1 1
V 31932 24431 7 0
S 0 24431 0 0 0
A 0 6 0 0 1 45 0
J 119 1 1
V 31935 24431 7 0
S 0 24431 0 0 0
A 0 6 0 0 1 32 0
J 134 1 1
V 31938 24437 7 0
S 0 24437 0 0 0
A 0 6 0 0 1 3 0
J 134 1 1
V 31941 24437 7 0
S 0 24437 0 0 0
A 0 6 0 0 1 45 0
J 148 1 1
V 31944 24443 7 0
S 0 24443 0 0 0
A 0 6 0 0 1 3 0
J 148 1 1
V 31947 24443 7 0
S 0 24443 0 0 0
A 0 6 0 0 1 45 0
J 148 1 1
V 31950 24443 7 0
S 0 24443 0 0 0
A 0 6 0 0 1 32 0
J 69 1 1
V 32414 26019 7 0
S 0 26019 0 0 0
A 0 6 0 0 1 3 0
J 69 1 1
V 32417 26019 7 0
S 0 26019 0 0 0
A 0 6 0 0 1 45 0
J 83 1 1
V 32420 26025 7 0
S 0 26025 0 0 0
A 0 6 0 0 1 3 0
J 83 1 1
V 32423 26025 7 0
S 0 26025 0 0 0
A 0 6 0 0 1 45 0
J 83 1 1
V 32426 26025 7 0
S 0 26025 0 0 0
A 0 6 0 0 1 32 0
J 83 1 1
V 32429 26025 7 0
S 0 26025 0 0 0
A 0 6 0 0 1 52 0
J 83 1 1
V 32432 26025 7 0
S 0 26025 0 0 0
A 0 6 0 0 1 56 0
J 83 1 1
V 32435 26025 7 0
S 0 26025 0 0 0
A 0 6 0 0 1 60 0
Z
