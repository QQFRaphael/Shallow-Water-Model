V26 esmf_gridcompmod
77 /Users/dazlich/doe_ca/esmf/src/Superstructure/Component/src/ESMF_GridComp.F90 S582 0
09/06/2012  22:20:23
use esmf_fieldmod private
use esmf_routemod private
use esmf_arrayspecmod private
use esmf_alarmtypemod private
use esmf_logerrmod private
use esmf_iospecmod private
use esmf_statetypesmod private
use esmf_utiltypesmod private
use esmf_clocktypemod private
use esmf_compmod private
use esmf_statemod private
use esmf_arraybundlemod private
use esmf_fieldbundlemod private
use esmf_fieldgetmod private
use esmf_fieldcreatemod private
use esmf_fieldsetmod private
use esmf_internarraymod private
use esmf_internarraydatamapmod private
use esmf_gridmod private
use esmf_arraymod private
use esmf_arrayscattermod private
use esmf_arrayprmod private
use esmf_arraygathermod private
use esmf_arraygetmod private
use esmf_arraycreatemod private
use esmf_distgridmod private
use esmf_staggerlocmod private
use esmf_localarraygetmod private
use esmf_localarraycreatemod private
use esmf_clockmod private
use esmf_timeintervalmod private
use esmf_calendarmod private
use esmf_configmod private
use esmf_utilmod private
use esmf_delayoutmod private
use esmf_vmmod private
use esmf_fieldmod private
use esmf_routemod private
use esmf_arrayspecmod private
use esmf_alarmtypemod private
use esmf_logerrmod private
use esmf_iospecmod private
use esmf_statetypesmod private
use esmf_utiltypesmod private
use esmf_clocktypemod private
use esmf_compmod private
use esmf_statemod private
use esmf_arraybundlemod private
use esmf_fieldbundlemod private
use esmf_fieldgetmod private
use esmf_fieldcreatemod private
use esmf_fieldsetmod private
use esmf_internarraymod private
use esmf_internarraydatamapmod private
use esmf_gridmod private
use esmf_arraymod private
use esmf_arrayscattermod private
use esmf_arrayprmod private
use esmf_arraygathermod private
use esmf_arraygetmod private
use esmf_arraycreatemod private
use esmf_distgridmod private
use esmf_staggerlocmod private
use esmf_localarraygetmod private
use esmf_localarraycreatemod private
use esmf_clockmod private
use esmf_timeintervalmod private
use esmf_calendarmod private
use esmf_configmod private
use esmf_utilmod private
use esmf_delayoutmod private
use esmf_vmmod private
enduse
D 58 24 714 4 713 3
D 64 24 730 8 729 7
D 70 24 736 4 735 3
D 82 24 778 36 777 3
D 90 18 13
D 92 18 14
D 94 18 15
D 96 18 16
D 98 18 17
D 100 18 18
D 102 18 19
D 104 18 20
D 106 18 21
D 108 18 22
D 110 18 23
D 139 24 868 4 867 3
D 145 24 874 4 873 3
D 151 24 890 4 889 3
D 157 24 896 4 895 3
D 163 24 904 4 903 3
D 169 24 912 4 911 3
D 175 24 918 4 917 3
D 181 24 926 4 925 3
D 187 24 932 4 931 3
D 193 24 938 4 937 3
D 199 24 944 4 943 3
D 402 24 1195 4 1194 3
D 408 24 1203 4 1202 3
D 414 24 1211 4 1210 3
D 841 24 1638 4 1637 3
D 847 24 1646 4 1645 3
D 853 24 1660 144 1659 3
D 1037 24 1739 16 1738 7
D 1586 24 3069 4 3068 3
D 1687 18 1495
D 2058 24 3562 16 3505 7
D 2267 24 3799 4 3798 3
D 2783 24 4053 4 4052 3
D 3140 24 4124 16 4123 7
D 3890 24 4766 4 4765 3
D 4092 24 4847 4 4846 3
D 4098 24 4859 4 4858 3
D 8072 24 10306 4 10305 3
D 8461 24 10690 4 10689 3
D 8658 24 10809 4 10808 3
D 13116 24 17873 16 17872 7
D 13122 24 17876 4 17875 3
D 13128 24 17886 4 17885 3
D 14089 24 19387 4 19386 3
D 14095 24 19393 4 19392 3
D 14352 24 19743 4 19742 3
D 14364 24 19754 4 19753 3
D 14370 24 19784 4 19783 3
D 19135 24 27465 4 27464 3
D 19848 24 28298 4 28297 3
D 19854 24 28308 4 28307 3
D 19860 24 28330 4 28329 3
D 19866 24 28336 4 28335 3
D 19872 24 28344 4 28343 3
D 19878 24 28350 4 28349 3
D 19913 24 28397 16 28396 7
D 20801 18 13
D 20803 18 14
D 20805 18 15
D 20807 18 16
D 20809 18 17
D 20811 18 18
D 20813 18 19
D 20815 18 20
D 20817 18 21
D 20819 18 22
D 20821 18 23
D 20823 24 29248 4 29247 3
D 20829 24 29254 4 29253 3
D 20870 24 29328 16 29327 7
D 20945 21 6 1 24603 24606 1 1 0 0 1
 3 24604 3 3 24604 24605
S 582 24 0 0 0 8 1 0 4658 10015 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 15 0 0 0 0 0 0 esmf_gridcompmod
S 596 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 -1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 598 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 7 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 599 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 600 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 8 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 603 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 604 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 605 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 5 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 606 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 6 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 608 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 9 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 609 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 610 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 90 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 611 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 91 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 612 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 99 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 613 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 18 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 614 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 25 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 615 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 32 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 616 3 0 0 0 20801 1 1 0 0 0 A 0 0 0 0 0 0 0 0 4953 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 42 61 73 65
S 617 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 11 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 618 3 0 0 0 20803 1 1 0 0 0 A 0 0 0 0 0 0 0 0 4963 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 49 4f 53 70 65 63
S 619 3 0 0 0 20803 1 1 0 0 0 A 0 0 0 0 0 0 0 0 4975 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 4c 6f 67 45 72 72
S 620 3 0 0 0 20801 1 1 0 0 0 A 0 0 0 0 0 0 0 0 4987 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 54 69 6d 65
S 621 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 13 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 622 3 0 0 0 20805 1 1 0 0 0 A 0 0 0 0 0 0 0 0 4997 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 43 61 6c 65 6e 64 61 72
S 623 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 17 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 624 3 0 0 0 20807 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5011 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 54 69 6d 65 49 6e 74 65 72 76 61 6c
S 625 3 0 0 0 20809 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5029 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 41 6c 61 72 6d
S 626 3 0 0 0 20809 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5040 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 43 6c 6f 63 6b
S 627 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 628 3 0 0 0 20811 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5051 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 41 72 72 61 79 53 70 65 63
S 629 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 630 3 0 0 0 20813 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5066 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 15 45 53 4d 46 5f 4c 6f 63 61 6c 41 72 72 61 79
S 631 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 632 3 0 0 0 20815 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5082 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 41 72 72 61 79 42 75 6e 64 6c 65
S 633 3 0 0 0 20817 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5099 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 7 45 53 4d 46 5f 56 4d
S 634 3 0 0 0 20805 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5107 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 44 45 4c 61 79 6f 75 74
S 635 3 0 0 0 20803 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5121 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 43 6f 6e 66 69 67
S 636 3 0 0 0 20809 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5133 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 41 72 72 61 79
S 637 3 0 0 0 20805 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5144 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 49 6e 74 65 72 6e 44 47
S 638 3 0 0 0 20811 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5158 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 43 6f 6d 6d 54 61 62 6c 65
S 639 3 0 0 0 20813 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5173 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 15 45 53 4d 46 5f 52 6f 75 74 65 54 61 62 6c 65
S 640 3 0 0 0 20809 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5189 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 52 6f 75 74 65
S 641 3 0 0 0 20815 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5200 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 52 6f 75 74 65 48 61 6e 64 6c 65
S 642 3 0 0 0 20807 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5217 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 46 69 65 6c 64 44 61 74 61 4d 61 70
S 643 3 0 0 0 20809 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5235 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 46 69 65 6c 64
S 644 3 0 0 0 20815 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5246 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 46 69 65 6c 64 42 75 6e 64 6c 65
S 645 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 20 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 646 3 0 0 0 20819 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5263 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 20 45 53 4d 46 5f 54 72 61 6e 73 66 6f 72 6d 56 61 6c 75 65 73
S 647 3 0 0 0 20803 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5284 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 52 65 67 72 69 64
S 648 3 0 0 0 20811 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5296 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 54 72 61 6e 73 66 6f 72 6d
S 649 3 0 0 0 20809 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5311 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 53 74 61 74 65
S 650 3 0 0 0 20821 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5322 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 18 45 53 4d 46 5f 47 72 69 64 43 6f 6d 70 6f 6e 65 6e 74
S 651 3 0 0 0 20807 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5341 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 43 70 6c 43 6f 6d 70 6f 6e 65 6e 74
S 652 3 0 0 0 20811 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5359 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 43 6f 6d 70 6f 6e 65 6e 74
S 653 3 0 0 0 20815 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5374 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 49 6e 74 65 72 6e 41 72 72 61 79
S 654 3 0 0 0 20801 1 1 0 0 0 A 0 0 0 0 0 0 0 0 5391 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 4e 6f 6e 65
S 666 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 12 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 672 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 21 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 674 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 22 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 676 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 23 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 678 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 24 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 681 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 26 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 683 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 28 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 685 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 29 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 687 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 30 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 689 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 31 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 692 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 33 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 694 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 34 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 696 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 35 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 698 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 36 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 713 25 13 esmf_utiltypesmod esmf_status
R 714 5 14 esmf_utiltypesmod status esmf_status
R 716 6 16 esmf_utiltypesmod esmf_status_uninit$ac
R 718 6 18 esmf_utiltypesmod esmf_status_ready$ac
R 720 6 20 esmf_utiltypesmod esmf_status_unallocated$ac
R 722 6 22 esmf_utiltypesmod esmf_status_allocated$ac
R 724 6 24 esmf_utiltypesmod esmf_status_busy$ac
R 726 6 26 esmf_utiltypesmod esmf_status_invalid$ac
R 728 6 28 esmf_utiltypesmod esmf_status_not_ready$ac
R 729 25 29 esmf_utiltypesmod esmf_pointer
R 730 5 30 esmf_utiltypesmod ptr esmf_pointer
R 732 6 32 esmf_utiltypesmod esmf_null_pointer$ac
R 734 6 34 esmf_utiltypesmod esmf_bad_pointer$ac
R 735 25 35 esmf_utiltypesmod esmf_typekind
R 736 5 36 esmf_utiltypesmod dkind esmf_typekind
R 738 6 38 esmf_utiltypesmod esmf_typekind_i1$ac
R 740 6 40 esmf_utiltypesmod esmf_typekind_i2$ac
R 742 6 42 esmf_utiltypesmod esmf_typekind_i4$ac
R 744 6 44 esmf_utiltypesmod esmf_typekind_i8$ac
R 746 6 46 esmf_utiltypesmod esmf_typekind_r4$ac
R 748 6 48 esmf_utiltypesmod esmf_typekind_r8$ac
R 750 6 50 esmf_utiltypesmod esmf_c8$ac
R 752 6 52 esmf_utiltypesmod esmf_c16$ac
R 754 6 54 esmf_utiltypesmod esmf_typekind_logical$ac
R 756 6 56 esmf_utiltypesmod esmf_typekind_character$ac
R 758 6 58 esmf_utiltypesmod esmf_typekind_i$ac
R 760 6 60 esmf_utiltypesmod esmf_typekind_r$ac
R 762 6 62 esmf_utiltypesmod esmf_nokind$ac
R 777 25 77 esmf_utiltypesmod esmf_objectid
R 778 5 78 esmf_utiltypesmod objectid esmf_objectid
R 779 5 79 esmf_utiltypesmod objectname esmf_objectid
R 781 6 81 esmf_utiltypesmod esmf_id_base$ac
R 783 6 83 esmf_utiltypesmod esmf_id_iospec$ac
R 785 6 85 esmf_utiltypesmod esmf_id_logerr$ac
R 787 6 87 esmf_utiltypesmod esmf_id_time$ac
R 789 6 89 esmf_utiltypesmod esmf_id_calendar$ac
R 791 6 91 esmf_utiltypesmod esmf_id_timeinterval$ac
R 793 6 93 esmf_utiltypesmod esmf_id_alarm$ac
R 795 6 95 esmf_utiltypesmod esmf_id_clock$ac
R 797 6 97 esmf_utiltypesmod esmf_id_arrayspec$ac
R 799 6 99 esmf_utiltypesmod esmf_id_localarray$ac
R 801 6 101 esmf_utiltypesmod esmf_id_arraybundle$ac
R 803 6 103 esmf_utiltypesmod esmf_id_vm$ac
R 805 6 105 esmf_utiltypesmod esmf_id_delayout$ac
R 807 6 107 esmf_utiltypesmod esmf_id_config$ac
R 809 6 109 esmf_utiltypesmod esmf_id_array$ac
R 811 6 111 esmf_utiltypesmod esmf_id_interndg$ac
R 813 6 113 esmf_utiltypesmod esmf_id_commtable$ac
R 815 6 115 esmf_utiltypesmod esmf_id_routetable$ac
R 817 6 117 esmf_utiltypesmod esmf_id_route$ac
R 819 6 119 esmf_utiltypesmod esmf_id_routehandle$ac
R 821 6 121 esmf_utiltypesmod esmf_id_fielddatamap$ac
R 823 6 123 esmf_utiltypesmod esmf_id_field$ac
R 825 6 125 esmf_utiltypesmod esmf_id_fieldbundle$ac
R 827 6 127 esmf_utiltypesmod esmf_id_transformvalues$ac
R 829 6 129 esmf_utiltypesmod esmf_id_regrid$ac
R 831 6 131 esmf_utiltypesmod esmf_id_transform$ac
R 833 6 133 esmf_utiltypesmod esmf_id_state$ac
R 835 6 135 esmf_utiltypesmod esmf_id_gridcomponent$ac
R 837 6 137 esmf_utiltypesmod esmf_id_cplcomponent$ac
R 839 6 139 esmf_utiltypesmod esmf_id_component$ac
R 841 6 141 esmf_utiltypesmod esmf_id_internarray$ac
R 843 6 143 esmf_utiltypesmod esmf_id_none$ac
R 867 25 167 esmf_utiltypesmod esmf_localglobalflag
R 868 5 168 esmf_utiltypesmod value esmf_localglobalflag
R 870 6 170 esmf_utiltypesmod esmf_local$ac
R 872 6 172 esmf_utiltypesmod esmf_global$ac
R 873 25 173 esmf_utiltypesmod esmf_domaintypeflag
R 874 5 174 esmf_utiltypesmod value esmf_domaintypeflag
R 876 6 176 esmf_utiltypesmod esmf_domain_exclusive$ac
R 878 6 178 esmf_utiltypesmod esmf_domain_computational$ac
R 880 6 180 esmf_utiltypesmod esmf_domain_total$ac
R 882 6 182 esmf_utiltypesmod esmf_domain_allocated$ac
R 884 6 184 esmf_utiltypesmod esmf_domain_oldexclusive$ac
R 886 6 186 esmf_utiltypesmod esmf_domain_oldcomputational$ac
R 888 6 188 esmf_utiltypesmod esmf_domain_oldtotal$ac
R 889 25 189 esmf_utiltypesmod esmf_logical
R 890 5 190 esmf_utiltypesmod value esmf_logical
R 892 6 192 esmf_utiltypesmod esmf_true$ac
R 894 6 194 esmf_utiltypesmod esmf_false$ac
R 895 25 195 esmf_utiltypesmod esmf_reduceflag
R 896 5 196 esmf_utiltypesmod value esmf_reduceflag
R 898 6 198 esmf_utiltypesmod esmf_sum$ac
R 900 6 200 esmf_utiltypesmod esmf_min$ac
R 902 6 202 esmf_utiltypesmod esmf_max$ac
R 903 25 203 esmf_utiltypesmod esmf_blockingflag
R 904 5 204 esmf_utiltypesmod value esmf_blockingflag
R 906 6 206 esmf_utiltypesmod esmf_blocking$ac
R 908 6 208 esmf_utiltypesmod esmf_vasblocking$ac
R 910 6 210 esmf_utiltypesmod esmf_nonblocking$ac
R 911 25 211 esmf_utiltypesmod esmf_contextflag
R 912 5 212 esmf_utiltypesmod value esmf_contextflag
R 914 6 214 esmf_utiltypesmod esmf_child_in_new_vm$ac
R 916 6 216 esmf_utiltypesmod esmf_child_in_parent_vm$ac
R 917 25 217 esmf_utiltypesmod esmf_terminationflag
R 918 5 218 esmf_utiltypesmod value esmf_terminationflag
R 920 6 220 esmf_utiltypesmod esmf_final$ac
R 922 6 222 esmf_utiltypesmod esmf_keepmpi$ac
R 924 6 224 esmf_utiltypesmod esmf_abort$ac
R 925 25 225 esmf_utiltypesmod esmf_depinflag
R 926 5 226 esmf_utiltypesmod value esmf_depinflag
R 928 6 228 esmf_utiltypesmod esmf_de_pin_pet$ac
R 930 6 230 esmf_utiltypesmod esmf_de_pin_vas$ac
R 931 25 231 esmf_utiltypesmod esmf_direction
R 932 5 232 esmf_utiltypesmod value esmf_direction
R 934 6 234 esmf_utiltypesmod esmf_mode_forward$ac
R 936 6 236 esmf_utiltypesmod esmf_mode_reverse$ac
R 937 25 237 esmf_utiltypesmod esmf_indexflag
R 938 5 238 esmf_utiltypesmod i_type esmf_indexflag
R 940 6 240 esmf_utiltypesmod esmf_index_delocal$ac
R 942 6 242 esmf_utiltypesmod esmf_index_global$ac
R 943 25 243 esmf_utiltypesmod esmf_regionflag
R 944 5 244 esmf_utiltypesmod i_type esmf_regionflag
R 946 6 246 esmf_utiltypesmod esmf_region_total$ac
R 948 6 248 esmf_utiltypesmod esmf_region_select$ac
R 950 6 250 esmf_utiltypesmod esmf_region_empty$ac
R 1194 25 1 esmf_logerrmod esmf_msgtype
R 1195 5 2 esmf_logerrmod mtype esmf_msgtype
R 1197 6 4 esmf_logerrmod esmf_log_info$ac
R 1199 6 6 esmf_logerrmod esmf_log_warning$ac
R 1201 6 8 esmf_logerrmod esmf_log_error$ac
R 1202 25 9 esmf_logerrmod esmf_halttype
R 1203 5 10 esmf_logerrmod htype esmf_halttype
R 1205 6 12 esmf_logerrmod esmf_log_haltnever$ac
R 1207 6 14 esmf_logerrmod esmf_log_haltwarning$ac
R 1209 6 16 esmf_logerrmod esmf_log_halterror$ac
R 1210 25 17 esmf_logerrmod esmf_logtype
R 1211 5 18 esmf_logerrmod ftype esmf_logtype
R 1213 6 20 esmf_logerrmod esmf_log_single$ac
R 1215 6 22 esmf_logerrmod esmf_log_multi$ac
R 1217 6 24 esmf_logerrmod esmf_log_none$ac
S 1471 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 64 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 1637 25 1 esmf_iospecmod esmf_iofileformat
R 1638 5 2 esmf_iospecmod iofileformat esmf_iofileformat
R 1640 6 4 esmf_iospecmod esmf_io_fileformat_unspecified$ac
R 1642 6 6 esmf_iospecmod esmf_io_fileformat_netcdf$ac
R 1644 6 8 esmf_iospecmod esmf_io_fileformat_hdf$ac
R 1645 25 9 esmf_iospecmod esmf_iorwtype
R 1646 5 10 esmf_iospecmod iorwtype esmf_iorwtype
R 1648 6 12 esmf_iospecmod esmf_io_rwtype_unspecified$ac
R 1650 6 14 esmf_iospecmod esmf_io_rwtype_readonly$ac
R 1652 6 16 esmf_iospecmod esmf_io_rwtype_writeonly$ac
R 1654 6 18 esmf_iospecmod esmf_io_rwtype_readwrite$ac
R 1656 6 20 esmf_iospecmod esmf_io_rwtype_append$ac
R 1658 6 22 esmf_iospecmod esmf_io_rwtype_truncate$ac
R 1659 25 23 esmf_iospecmod esmf_iospec
R 1660 5 24 esmf_iospecmod iostatus esmf_iospec
R 1661 5 25 esmf_iospecmod iofileformat esmf_iospec
R 1662 5 26 esmf_iospecmod iorwtype esmf_iospec
R 1663 5 27 esmf_iospecmod filename esmf_iospec
R 1664 5 28 esmf_iospecmod asyncio esmf_iospec
R 1738 25 4 esmf_vmmod esmf_vm
R 1739 5 5 esmf_vmmod this esmf_vm
R 1740 5 6 esmf_vmmod isinit esmf_vm
R 1752 19 18 esmf_vmmod esmf_vmallfullreduce
R 1753 19 19 esmf_vmmod esmf_vmallgather
R 1754 19 20 esmf_vmmod esmf_vmallgatherv
R 1755 19 21 esmf_vmmod esmf_vmallreduce
R 1756 19 22 esmf_vmmod esmf_vmalltoallv
R 1758 19 24 esmf_vmmod esmf_vmbroadcast
R 1761 19 27 esmf_vmmod esmf_vmgather
R 1762 19 28 esmf_vmmod esmf_vmgatherv
R 1770 19 36 esmf_vmmod esmf_vmrecv
R 1772 19 38 esmf_vmmod esmf_vmreduce
R 1773 19 39 esmf_vmmod esmf_vmscatter
R 1774 19 40 esmf_vmmod esmf_vmscatterv
R 1775 19 41 esmf_vmmod esmf_vmsend
R 1777 19 43 esmf_vmmod esmf_vmsendrecv
S 3063 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 67 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 3068 25 4 esmf_delayoutmod esmf_delayoutservicereply
R 3069 5 5 esmf_delayoutmod value esmf_delayoutservicereply
R 3071 6 7 esmf_delayoutmod esmf_delayout_service_accept$ac
R 3073 6 9 esmf_delayoutmod esmf_delayout_service_deny$ac
R 3075 19 11 esmf_delayoutmod esmf_delayoutcreate
R 3369 19 4 esmf_utilmod esmf_domainlistadd
R 3372 19 7 esmf_utilmod esmf_axisindexprint
R 3499 19 6 esmf_configmod esmf_configgetattribute
R 3503 19 10 esmf_configmod esmf_configsetattribute
R 3505 25 12 esmf_configmod esmf_config
R 3562 5 69 esmf_configmod cptr esmf_config
R 3564 5 71 esmf_configmod cptr$p esmf_config
R 3566 5 73 esmf_configmod isinit esmf_config
R 3798 25 2 esmf_calendarmod esmf_calendartype
R 3799 5 3 esmf_calendarmod calendartype esmf_calendartype
R 3801 6 5 esmf_calendarmod esmf_cal_gregorian$ac
R 3803 6 7 esmf_calendarmod esmf_cal_julian$ac
R 3805 6 9 esmf_calendarmod esmf_cal_julianday$ac
R 3807 6 11 esmf_calendarmod esmf_cal_noleap$ac
R 3809 6 13 esmf_calendarmod esmf_cal_360day$ac
R 3811 6 15 esmf_calendarmod esmf_cal_custom$ac
R 3813 6 17 esmf_calendarmod esmf_cal_nocalendar$ac
R 3817 19 21 esmf_calendarmod esmf_calendarcreate
R 3822 19 26 esmf_calendarmod esmf_calendarisleapyear
R 3825 19 29 esmf_calendarmod esmf_calendarset
R 3826 19 30 esmf_calendarmod esmf_calendarsetdefault
R 4052 25 1 esmf_alarmtypemod esmf_alarmlisttype
R 4053 5 2 esmf_alarmtypemod alarmlisttype esmf_alarmlisttype
R 4055 6 4 esmf_alarmtypemod esmf_alarmlist_all$ac
R 4057 6 6 esmf_alarmtypemod esmf_alarmlist_ringing$ac
R 4059 6 8 esmf_alarmtypemod esmf_alarmlist_nextringing$ac
R 4061 6 10 esmf_alarmtypemod esmf_alarmlist_prevringing$ac
R 4123 25 1 esmf_clocktypemod esmf_clock
R 4124 5 2 esmf_clocktypemod this esmf_clock
R 4125 5 3 esmf_clocktypemod isinit esmf_clock
R 4178 19 10 esmf_timeintervalmod esmf_timeintervalget
R 4182 19 14 esmf_timeintervalmod esmf_timeintervalset
R 4214 19 46 esmf_timeintervalmod mod
R 4583 19 2 esmf_clockmod esmf_clockcreate
R 4765 25 1 esmf_arrayspecmod esmf_arrayspecstatus
R 4766 5 2 esmf_arrayspecmod status esmf_arrayspecstatus
R 4768 6 4 esmf_arrayspecmod esmf_arrayspec_status_unknown$ac
R 4770 6 6 esmf_arrayspecmod esmf_arrayspec_status_notset$ac
R 4772 6 8 esmf_arrayspecmod esmf_arrayspec_status_set$ac
R 4846 25 1 esmf_localarraycreatemod esmf_copyflag
R 4847 5 2 esmf_localarraycreatemod docopy esmf_copyflag
R 4849 6 4 esmf_localarraycreatemod esmf_data_copy$ac
R 4851 6 6 esmf_localarraycreatemod esmf_data_ref$ac
R 4853 6 8 esmf_localarraycreatemod esmf_data_defer$ac
R 4855 6 10 esmf_localarraycreatemod esmf_data_space$ac
R 4857 6 12 esmf_localarraycreatemod esmf_data_none$ac
R 4858 25 13 esmf_localarraycreatemod esmf_localarrayorigin
R 4859 5 14 esmf_localarraycreatemod origin esmf_localarrayorigin
R 4861 6 16 esmf_localarraycreatemod esmf_from_fortran$ac
R 4863 6 18 esmf_localarraycreatemod esmf_from_cplusplus$ac
R 5287 19 442 esmf_localarraycreatemod esmf_localarraycreate
R 9832 19 422 esmf_localarraygetmod esmf_localarrayget
S 10300 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 69 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 10305 25 4 esmf_routemod esmf_routeoptions
R 10306 5 5 esmf_routemod option esmf_routeoptions
R 10308 6 7 esmf_routemod esmf_route_option_async$ac
R 10310 6 9 esmf_routemod esmf_route_option_sync$ac
R 10312 6 11 esmf_routemod esmf_route_option_pack_pet$ac
R 10314 6 13 esmf_routemod esmf_route_option_pack_xp$ac
R 10316 6 15 esmf_routemod esmf_route_option_pack_nopack$ac
R 10318 6 17 esmf_routemod esmf_route_option_pack_vector$ac
R 10320 6 19 esmf_routemod esmf_route_option_pack_buffer$ac
R 10322 6 21 esmf_routemod esmf_route_option_default$ac
S 10687 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 -1 -2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 10689 25 1 esmf_staggerlocmod esmf_staggerloc
R 10690 5 2 esmf_staggerlocmod staggerloc esmf_staggerloc
R 10692 19 4 esmf_staggerlocmod esmf_staggerlocset
R 10698 6 10 esmf_staggerlocmod esmf_staggerloc_invalid$ac
R 10700 6 12 esmf_staggerlocmod esmf_staggerloc_uninit$ac
R 10702 6 14 esmf_staggerlocmod esmf_staggerloc_center$ac
R 10704 6 16 esmf_staggerlocmod esmf_staggerloc_edge1$ac
R 10706 6 18 esmf_staggerlocmod esmf_staggerloc_edge2$ac
R 10708 6 20 esmf_staggerlocmod esmf_staggerloc_corner$ac
R 10710 6 22 esmf_staggerlocmod esmf_staggerloc_center_vcenter$ac
R 10712 6 24 esmf_staggerlocmod esmf_staggerloc_edge1_vcenter$ac
R 10714 6 26 esmf_staggerlocmod esmf_staggerloc_edge2_vcenter$ac
R 10716 6 28 esmf_staggerlocmod esmf_staggerloc_corner_vcenter$ac
R 10718 6 30 esmf_staggerlocmod esmf_staggerloc_center_vface$ac
R 10720 6 32 esmf_staggerlocmod esmf_staggerloc_edge1_vface$ac
R 10722 6 34 esmf_staggerlocmod esmf_staggerloc_edge2_vface$ac
R 10724 6 36 esmf_staggerlocmod esmf_staggerloc_corner_vface$ac
R 10808 25 4 esmf_distgridmod esmf_decompflag
R 10809 5 5 esmf_distgridmod value esmf_decompflag
R 10811 6 7 esmf_distgridmod esmf_decomp_default$ac
R 10813 6 9 esmf_distgridmod esmf_decomp_homogen$ac
R 10815 6 11 esmf_distgridmod esmf_decomp_restfirst$ac
R 10817 6 13 esmf_distgridmod esmf_decomp_restlast$ac
R 10819 6 15 esmf_distgridmod esmf_decomp_cyclic$ac
R 10820 19 16 esmf_distgridmod esmf_distgridcreate
R 10822 19 18 esmf_distgridmod esmf_distgridget
R 11514 19 4 esmf_arraycreatemod esmf_arraycreate
R 14833 19 1 esmf_arraygetmod esmf_arrayget
R 15427 19 1 esmf_arraygathermod esmf_arraygather
R 16367 19 4 esmf_arrayprmod esmf_arrayrediststore
R 16451 19 1 esmf_arrayscattermod esmf_arrayscatter
R 17413 19 1 esmf_arraymod esmf_arrayhalo
R 17416 19 4 esmf_arraymod esmf_arrayreduce
R 17417 19 5 esmf_arraymod esmf_arrayset
R 17420 19 8 esmf_arraymod esmf_arraysmmstore
R 17872 25 1 esmf_gridmod esmf_grid
R 17873 5 2 esmf_gridmod this esmf_grid
R 17874 5 3 esmf_gridmod isinit esmf_grid
R 17875 25 4 esmf_gridmod esmf_gridstatus
R 17876 5 5 esmf_gridmod gridstatus esmf_gridstatus
R 17878 6 7 esmf_gridmod esmf_gridstatus_invalid$ac
R 17880 6 9 esmf_gridmod esmf_gridstatus_uninit$ac
R 17882 6 11 esmf_gridmod esmf_gridstatus_not_ready$ac
R 17884 6 13 esmf_gridmod esmf_gridstatus_shape_ready$ac
R 17885 25 14 esmf_gridmod esmf_gridconn
R 17886 5 15 esmf_gridmod gridconn esmf_gridconn
R 17888 6 17 esmf_gridmod esmf_gridconn_none$ac
R 17890 6 19 esmf_gridmod esmf_gridconn_periodic$ac
R 17892 6 21 esmf_gridmod esmf_gridconn_pole$ac
R 17894 6 23 esmf_gridmod esmf_gridconn_bipole$ac
R 17897 19 26 esmf_gridmod esmf_gridaddcoord
R 17899 19 28 esmf_gridmod esmf_gridcreate
R 17901 19 30 esmf_gridmod esmf_gridcreateshapetile
R 17903 19 32 esmf_gridmod esmf_gridget
R 17904 19 33 esmf_gridmod esmf_gridgetcoord
R 17906 19 35 esmf_gridmod esmf_gridset
R 17907 19 36 esmf_gridmod esmf_gridsetcoord
R 17908 19 37 esmf_gridmod esmf_gridsetcommitshapetile
R 19386 25 1 esmf_fieldmod esmf_access
R 19387 5 2 esmf_fieldmod a_type esmf_access
R 19389 6 4 esmf_fieldmod esmf_readwrite$ac
R 19391 6 6 esmf_fieldmod esmf_readonly$ac
R 19392 25 7 esmf_fieldmod esmf_allocflag
R 19393 5 8 esmf_fieldmod a_type esmf_allocflag
R 19395 6 10 esmf_fieldmod esmf_alloc$ac
R 19397 6 12 esmf_fieldmod esmf_no_alloc$ac
R 19742 25 1 esmf_internarraydatamapmod esmf_interleaveflag
R 19743 5 2 esmf_internarraydatamapmod il esmf_interleaveflag
R 19745 6 4 esmf_internarraydatamapmod esmf_interleave_by_block$ac
R 19747 6 6 esmf_internarraydatamapmod esmf_interleave_by_item$ac
R 19753 25 12 esmf_internarraydatamapmod esmf_relloc
R 19754 5 13 esmf_internarraydatamapmod relloc esmf_relloc
R 19756 6 15 esmf_internarraydatamapmod esmf_cell_undefined$ac
R 19758 6 17 esmf_internarraydatamapmod esmf_cell_center$ac
R 19760 6 19 esmf_internarraydatamapmod esmf_cell_nface$ac
R 19762 6 21 esmf_internarraydatamapmod esmf_cell_sface$ac
R 19764 6 23 esmf_internarraydatamapmod esmf_cell_eface$ac
R 19766 6 25 esmf_internarraydatamapmod esmf_cell_wface$ac
R 19768 6 27 esmf_internarraydatamapmod esmf_cell_necorner$ac
R 19770 6 29 esmf_internarraydatamapmod esmf_cell_nwcorner$ac
R 19772 6 31 esmf_internarraydatamapmod esmf_cell_secorner$ac
R 19774 6 33 esmf_internarraydatamapmod esmf_cell_swcorner$ac
R 19776 6 35 esmf_internarraydatamapmod esmf_cell_topface$ac
R 19778 6 37 esmf_internarraydatamapmod esmf_cell_botface$ac
R 19780 6 39 esmf_internarraydatamapmod esmf_cell_cell$ac
R 19782 6 41 esmf_internarraydatamapmod esmf_cell_vertex$ac
R 19783 25 42 esmf_internarraydatamapmod esmf_indexorder
R 19784 5 43 esmf_internarraydatamapmod iorder esmf_indexorder
R 19786 6 45 esmf_internarraydatamapmod esmf_index_i$ac
R 19788 6 47 esmf_internarraydatamapmod esmf_index_ij$ac
R 19790 6 49 esmf_internarraydatamapmod esmf_index_ji$ac
R 19792 6 51 esmf_internarraydatamapmod esmf_index_ijk$ac
R 19794 6 53 esmf_internarraydatamapmod esmf_index_jik$ac
R 19796 6 55 esmf_internarraydatamapmod esmf_index_kji$ac
R 19798 6 57 esmf_internarraydatamapmod esmf_index_ikj$ac
R 19800 6 59 esmf_internarraydatamapmod esmf_index_jki$ac
R 19802 6 61 esmf_internarraydatamapmod esmf_index_kij$ac
R 19809 19 68 esmf_internarraydatamapmod esmf_arraydatamapsetdefault
R 19980 19 15 esmf_internarraymod esmf_iarraygetattribute
R 19981 19 16 esmf_internarraymod esmf_iarraysetattribute
R 19983 19 18 esmf_internarraymod esmf_iarraygetattributeinfo
R 19985 19 20 esmf_internarraymod esmf_iarraygetaxisindex
R 20375 19 1 esmf_fieldsetmod esmf_fieldset
R 20376 19 2 esmf_fieldsetmod esmf_fieldsetcommit
R 22784 19 1 esmf_fieldcreatemod esmf_fieldcreate
R 22786 19 3 esmf_fieldcreatemod esmf_fieldcreatenodata
R 25101 19 1 esmf_fieldgetmod esmf_fieldget
R 27464 25 1 esmf_fieldbundlemod esmf_packflag
R 27465 5 2 esmf_fieldbundlemod packflag esmf_packflag
R 27467 6 4 esmf_fieldbundlemod esmf_packed_data$ac
R 27469 6 6 esmf_fieldbundlemod esmf_no_packed_data$ac
R 27517 19 54 esmf_fieldbundlemod esmf_fieldbundlecreate
R 27519 19 56 esmf_fieldbundlemod esmf_fieldbundleget
R 27520 19 57 esmf_fieldbundlemod esmf_fieldbundleadd
R 28013 19 9 esmf_arraybundlemod esmf_arraybundlerediststore
R 28017 19 13 esmf_arraybundlemod esmf_arraybundlesmmstore
S 28286 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 101 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 28287 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 102 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 28288 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 103 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 28289 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 104 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 28290 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 105 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 28291 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 106 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 28292 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 107 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 28293 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 108 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 28294 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 109 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 28295 3 0 0 0 6 1 1 0 0 0 A 0 0 0 0 0 0 0 0 0 110 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 28297 25 1 esmf_statetypesmod esmf_statetype
R 28298 5 2 esmf_statetypesmod state esmf_statetype
R 28300 6 4 esmf_statetypesmod esmf_state_import$ac
R 28302 6 6 esmf_statetypesmod esmf_state_export$ac
R 28304 6 8 esmf_statetypesmod esmf_state_unspecified$ac
R 28306 6 10 esmf_statetypesmod esmf_state_invalid$ac
R 28307 25 11 esmf_statetypesmod esmf_stateitemtype
R 28308 5 12 esmf_statetypesmod ot esmf_stateitemtype
R 28310 6 14 esmf_statetypesmod esmf_stateitem_field$ac
R 28312 6 16 esmf_statetypesmod esmf_stateitem_fieldbundle$ac
R 28314 6 18 esmf_statetypesmod esmf_stateitem_array$ac
R 28316 6 20 esmf_statetypesmod esmf_stateitem_arraybundle$ac
R 28318 6 22 esmf_statetypesmod esmf_stateitem_routehandle$ac
R 28320 6 24 esmf_statetypesmod esmf_stateitem_state$ac
R 28322 6 26 esmf_statetypesmod esmf_stateitem_name$ac
R 28324 6 28 esmf_statetypesmod esmf_stateitem_indirect$ac
R 28326 6 30 esmf_statetypesmod esmf_stateitem_unknown$ac
R 28328 6 32 esmf_statetypesmod esmf_stateitem_notfound$ac
R 28329 25 33 esmf_statetypesmod esmf_neededflag
R 28330 5 34 esmf_statetypesmod needed esmf_neededflag
R 28332 6 36 esmf_statetypesmod esmf_needed$ac
R 28334 6 38 esmf_statetypesmod esmf_notneeded$ac
R 28335 25 39 esmf_statetypesmod esmf_readyflag
R 28336 5 40 esmf_statetypesmod ready esmf_readyflag
R 28338 6 42 esmf_statetypesmod esmf_readytowrite$ac
R 28340 6 44 esmf_statetypesmod esmf_readytoread$ac
R 28342 6 46 esmf_statetypesmod esmf_notready$ac
R 28343 25 47 esmf_statetypesmod esmf_reqforrestartflag
R 28344 5 48 esmf_statetypesmod required4restart esmf_reqforrestartflag
R 28346 6 50 esmf_statetypesmod esmf_required_for_restart$ac
R 28348 6 52 esmf_statetypesmod esmf_notrequired_for_restart$ac
R 28349 25 53 esmf_statetypesmod esmf_validflag
R 28350 5 54 esmf_statetypesmod valid esmf_validflag
R 28352 6 56 esmf_statetypesmod esmf_valid$ac
R 28354 6 58 esmf_statetypesmod esmf_invalid$ac
R 28356 6 60 esmf_statetypesmod esmf_validityunknown$ac
R 28396 25 100 esmf_statetypesmod esmf_state
R 28397 5 101 esmf_statetypesmod statep esmf_state
R 28399 5 103 esmf_statetypesmod statep$p esmf_state
R 28401 5 105 esmf_statetypesmod isinit esmf_state
R 28523 19 3 esmf_statemod esmf_stateadd
R 28524 19 4 esmf_statemod esmf_stateget
R 29247 25 1 esmf_compmod esmf_comptype
R 29248 5 2 esmf_compmod ctype esmf_comptype
R 29250 6 4 esmf_compmod esmf_comptype_grid$ac
R 29252 6 6 esmf_compmod esmf_comptype_cpl$ac
R 29253 25 7 esmf_compmod esmf_gridcomptype
R 29254 5 8 esmf_compmod gridcomptype esmf_gridcomptype
R 29256 6 10 esmf_compmod esmf_atm$ac
R 29258 6 12 esmf_compmod esmf_land$ac
R 29260 6 14 esmf_compmod esmf_ocean$ac
R 29262 6 16 esmf_compmod esmf_seaice$ac
R 29264 6 18 esmf_compmod esmf_river$ac
R 29266 6 20 esmf_compmod esmf_other$ac
R 29327 25 81 esmf_compmod esmf_gridcomp
R 29328 5 82 esmf_compmod compp esmf_gridcomp
R 29330 5 84 esmf_compmod compp$p esmf_gridcomp
R 29332 5 86 esmf_compmod isinit esmf_gridcomp
S 29553 19 0 0 0 8 1 582 121083 4000 0 A 0 0 0 0 0 0 0 0 0 29574 0 0 0 0 0 0 1556 1 0 0 0 0 0 582 0 0 0 0 esmf_gridcompcreate
O 29553 1 29574
S 29554 27 0 0 0 8 29610 582 121103 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_gridcompdestroy
S 29555 27 0 0 0 8 29627 582 121124 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_gridcompget
S 29556 27 0 0 0 8 29670 582 121141 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_gridcompset
S 29557 27 0 0 0 8 29614 582 121158 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_gridcompgetinit
S 29558 27 0 0 0 8 29704 582 121179 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_gridcompvalidate
S 29559 27 0 0 0 8 29648 582 121201 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_gridcompprint
S 29560 27 0 0 0 8 29639 582 121220 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_gridcompinitialize
S 29561 27 0 0 0 8 29661 582 121244 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_gridcomprun
S 29562 27 0 0 0 8 29618 582 121261 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_gridcompfinalize
S 29563 27 0 0 0 8 29709 582 121283 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_gridcompwriterestart
S 29564 27 0 0 0 8 29653 582 121309 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_gridcompreadrestart
S 29565 27 0 0 0 8 29680 582 121334 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_gridcompsetvmmaxthreads
S 29566 27 0 0 0 8 29688 582 121363 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_gridcompsetvmminthreads
S 29567 27 0 0 0 8 29696 582 121392 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_gridcompsetvmmaxpes
S 29568 27 0 0 0 8 29717 582 121417 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_gridcompwait
S 29569 27 0 0 0 8 29722 582 121435 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_gridcompispetlocal
S 29570 14 5 0 0 0 1 582 121459 0 0 A 0 0 0 0 0 0 0 10177 5 0 0 0 0 0 0 0 0 0 0 0 0 145 0 582 0 0 0 0 esmf_gridcompsetentrypoint
F 29570 5 29578 29579 29580 29581 29582
S 29571 14 5 0 0 0 1 582 121486 0 0 A 0 0 0 0 0 0 0 10187 3 0 0 0 0 0 0 0 0 0 0 0 0 179 0 582 0 0 0 0 esmf_gridcompsetservices
F 29571 3 29588 29589 29590
S 29572 3 0 0 0 1687 0 1 0 0 0 A 0 0 0 0 0 0 0 0 121511 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 67 24 49 64 3a 20 45 53 4d 46 5f 47 72 69 64 43 6f 6d 70 2e 46 39 30 2c 76 20 31 2e 39 34 2e 32 2e 33 20 32 30 30 38 2f 30 36 2f 32 34 20 32 31 3a 35 34 3a 30 31 20 65 73 63 68 77 61 62 20 45 78 70 20 24
S 29573 16 0 0 0 1687 1 582 14084 14 440000 A 0 0 0 0 0 0 0 0 29572 24601 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 version
S 29574 27 0 0 0 8 29593 582 121083 10000 400000 A 0 0 0 0 0 0 1557 0 0 29553 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_gridcompcreate
Q 29574 29553 0
S 29578 1 3 0 0 20870 1 29570 121588 2014 2000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 comp
S 29579 1 3 1 0 28 1 29570 121593 2014 42000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 subroutinetype
S 29580 14 3 0 0 6 1 29570 121608 12010 2000 A 0 0 0 0 0 0 0 10182 5 0 0 0 0 0 0 0 0 0 0 0 0 153 0 0 0 0 0 0 subroutinename
F 29580 5 29583 29584 29585 29586 29587
S 29581 1 3 1 0 6 1 29570 120913 2014 2000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 phase
S 29582 1 3 2 0 6 1 29570 11752 2014 2000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 29583 1 3 0 0 20870 1 29580 121588 2014 2000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 comp
S 29584 1 3 0 0 19913 1 29580 120878 2014 2000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 importstate
S 29585 1 3 0 0 19913 1 29580 120890 2014 2000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 exportstate
S 29586 1 3 0 0 3140 1 29580 25176 2014 2000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 clock
S 29587 1 3 2 0 6 1 29580 11752 2014 2000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 29588 1 3 3 0 20870 1 29571 121588 2014 2000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 comp
S 29589 14 3 0 0 6 1 29571 121608 12010 2000 A 0 0 0 0 0 0 0 10190 2 0 0 0 0 0 0 0 0 0 0 0 0 186 0 0 0 0 0 0 subroutinename
F 29589 2 29591 29592
S 29590 1 3 2 0 6 1 29571 11752 2014 2000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 29591 1 3 0 0 20870 1 29589 121588 2014 2000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 comp
S 29592 1 3 2 0 6 1 29589 11752 2014 2000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 29593 23 5 0 0 8 29604 582 121083 20000 0 A 0 0 0 0 0 0 0 0 0 29553 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_gridcompcreate
S 29594 1 3 1 0 28 1 29593 14165 80000014 43000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 name
S 29595 1 3 1 0 20829 1 29593 119577 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 gridcomptype
S 29596 1 3 3 0 13116 1 29593 84883 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 grid
S 29597 1 3 3 0 2058 1 29593 22337 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 config
S 29598 1 3 1 0 28 1 29593 119901 80000014 43000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 configfile
S 29599 1 3 3 0 3140 1 29593 25176 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 clock
S 29600 7 3 1 0 20945 1 29593 18934 a0000014 10003000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 petlist
S 29601 1 3 1 0 169 1 29593 18942 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 contextflag
S 29602 1 3 3 0 1037 1 29593 121623 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 parentvm
S 29603 1 3 2 0 6 1 29593 11752 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 29604 14 5 0 0 20870 1 29593 121083 20020004 400000 A 0 0 0 0 0 0 0 10193 10 29553 0 29605 0 0 0 0 0 0 0 0 0 214 0 582 0 0 0 0 esmf_gridcompcreate
F 29604 10 29594 29595 29596 29597 29598 29599 29600 29601 29602 29603
S 29605 1 3 0 0 20870 1 29593 121083 14 1003000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_gridcompcreate
S 29606 6 1 0 0 6 1 29593 120850 40800016 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_0_8
S 29607 6 1 0 0 6 1 29593 56135 40800016 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_2_3
S 29608 6 1 0 0 6 1 29593 56143 40800016 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_3_2
S 29609 6 1 0 0 6 1 29593 121632 40800016 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_24608
S 29610 23 5 0 0 0 29613 582 121103 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_gridcompdestroy
S 29611 1 3 0 0 20870 1 29610 121642 14 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 gridcomp
S 29612 1 3 2 0 6 1 29610 11752 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 29613 14 5 0 0 0 1 29610 121103 0 400000 A 0 0 0 0 0 0 0 10204 2 0 0 0 0 0 0 0 0 0 0 0 0 337 0 582 0 0 0 0 esmf_gridcompdestroy
F 29613 2 29611 29612
S 29614 23 5 0 0 8 29616 582 121158 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_gridcompgetinit
S 29615 1 3 1 0 20870 1 29614 12356 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 d
S 29616 14 5 0 0 7 1 29614 121158 4 400000 A 0 0 0 0 0 0 0 10207 1 0 0 29617 0 0 0 0 0 0 0 0 0 401 0 582 0 0 0 0 esmf_gridcompgetinit
F 29616 1 29615
S 29617 1 3 0 0 7 1 29614 121158 14 1003000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_gridcompgetinit
S 29618 23 5 0 0 0 29626 582 121261 20000 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_gridcompfinalize
S 29619 1 3 0 0 20870 1 29618 121642 14 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 gridcomp
S 29620 1 3 3 0 19913 1 29618 120878 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 importstate
S 29621 1 3 3 0 19913 1 29618 120890 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 exportstate
S 29622 1 3 3 0 3140 1 29618 25176 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 clock
S 29623 1 3 1 0 6 1 29618 120913 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 phase
S 29624 1 3 1 0 163 1 29618 17577 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 blockingflag
S 29625 1 3 2 0 6 1 29618 11752 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 29626 14 5 0 0 0 1 29618 121261 20000 400000 A 0 0 0 0 0 0 0 10209 7 0 0 0 0 0 0 0 0 0 0 0 0 433 0 582 0 0 0 0 esmf_gridcompfinalize
F 29626 7 29619 29620 29621 29622 29623 29624 29625
S 29627 23 5 0 0 0 29638 582 121124 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_gridcompget
S 29628 1 3 3 0 20870 1 29627 121642 14 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 gridcomp
S 29629 1 3 2 0 28 1 29627 14165 80000014 43000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 name
S 29630 1 3 2 0 20829 1 29627 119577 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 gridcomptype
S 29631 1 3 2 0 13116 1 29627 84883 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 grid
S 29632 1 3 2 0 2058 1 29627 22337 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 config
S 29633 1 3 2 0 28 1 29627 119901 80000014 43000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 configfile
S 29634 1 3 2 0 3140 1 29627 25176 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 clock
S 29635 1 3 2 0 1037 1 29627 17545 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 vm
S 29636 1 3 2 0 169 1 29627 18942 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 contextflag
S 29637 1 3 2 0 6 1 29627 11752 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 29638 14 5 0 0 0 1 29627 121124 0 400000 A 0 0 0 0 0 0 0 10217 10 0 0 0 0 0 0 0 0 0 0 0 0 519 0 582 0 0 0 0 esmf_gridcompget
F 29638 10 29628 29629 29630 29631 29632 29633 29634 29635 29636 29637
S 29639 23 5 0 0 0 29647 582 121220 20000 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_gridcompinitialize
S 29640 1 3 0 0 20870 1 29639 121642 14 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 gridcomp
S 29641 1 3 3 0 19913 1 29639 120878 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 importstate
S 29642 1 3 3 0 19913 1 29639 120890 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 exportstate
S 29643 1 3 3 0 3140 1 29639 25176 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 clock
S 29644 1 3 1 0 6 1 29639 120913 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 phase
S 29645 1 3 1 0 163 1 29639 17577 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 blockingflag
S 29646 1 3 2 0 6 1 29639 11752 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 29647 14 5 0 0 0 1 29639 121220 20000 400000 A 0 0 0 0 0 0 0 10228 7 0 0 0 0 0 0 0 0 0 0 0 0 592 0 582 0 0 0 0 esmf_gridcompinitialize
F 29647 7 29640 29641 29642 29643 29644 29645 29646
S 29648 23 5 0 0 0 29652 582 121201 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_gridcompprint
S 29649 1 3 0 0 20870 1 29648 121642 14 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 gridcomp
S 29650 1 3 1 0 28 1 29648 14341 80000014 43000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 options
S 29651 1 3 2 0 6 1 29648 11752 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 29652 14 5 0 0 0 1 29648 121201 0 400000 A 0 0 0 0 0 0 0 10236 3 0 0 0 0 0 0 0 0 0 0 0 0 677 0 582 0 0 0 0 esmf_gridcompprint
F 29652 3 29649 29650 29651
S 29653 23 5 0 0 0 29660 582 121309 20000 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_gridcompreadrestart
S 29654 1 3 3 0 20870 1 29653 121642 14 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 gridcomp
S 29655 1 3 3 0 853 1 29653 15265 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 iospec
S 29656 1 3 3 0 3140 1 29653 25176 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 clock
S 29657 1 3 1 0 6 1 29653 120913 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 phase
S 29658 1 3 1 0 163 1 29653 17577 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 blockingflag
S 29659 1 3 2 0 6 1 29653 11752 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 29660 14 5 0 0 0 1 29653 121309 20000 400000 A 0 0 0 0 0 0 0 10240 6 0 0 0 0 0 0 0 0 0 0 0 0 730 0 582 0 0 0 0 esmf_gridcompreadrestart
F 29660 6 29654 29655 29656 29657 29658 29659
S 29661 23 5 0 0 0 29669 582 121244 20000 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_gridcomprun
S 29662 1 3 0 0 20870 1 29661 121642 14 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 gridcomp
S 29663 1 3 3 0 19913 1 29661 120878 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 importstate
S 29664 1 3 3 0 19913 1 29661 120890 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 exportstate
S 29665 1 3 3 0 3140 1 29661 25176 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 clock
S 29666 1 3 1 0 6 1 29661 120913 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 phase
S 29667 1 3 1 0 163 1 29661 17577 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 blockingflag
S 29668 1 3 2 0 6 1 29661 11752 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 29669 14 5 0 0 0 1 29661 121244 20000 400000 A 0 0 0 0 0 0 0 10247 7 0 0 0 0 0 0 0 0 0 0 0 0 807 0 582 0 0 0 0 esmf_gridcomprun
F 29669 7 29662 29663 29664 29665 29666 29667 29668
S 29670 23 5 0 0 0 29679 582 121141 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_gridcompset
S 29671 1 3 3 0 20870 1 29670 121642 14 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 gridcomp
S 29672 1 3 1 0 28 1 29670 14165 80000014 43000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 name
S 29673 1 3 1 0 20829 1 29670 119577 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 gridcomptype
S 29674 1 3 3 0 13116 1 29670 84883 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 grid
S 29675 1 3 3 0 2058 1 29670 22337 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 config
S 29676 1 3 1 0 28 1 29670 119901 80000014 43000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 configfile
S 29677 1 3 3 0 3140 1 29670 25176 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 clock
S 29678 1 3 2 0 6 1 29670 11752 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 29679 14 5 0 0 0 1 29670 121141 0 400000 A 0 0 0 0 0 0 0 10255 8 0 0 0 0 0 0 0 0 0 0 0 0 894 0 582 0 0 0 0 esmf_gridcompset
F 29679 8 29671 29672 29673 29674 29675 29676 29677 29678
S 29680 23 5 0 0 0 29687 582 121334 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_gridcompsetvmmaxthreads
S 29681 1 3 3 0 20870 1 29680 121642 14 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 gridcomp
S 29682 1 3 1 0 6 1 29680 2379 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 max
S 29683 1 3 1 0 6 1 29680 18963 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 pref_intra_process
S 29684 1 3 1 0 6 1 29680 18982 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 pref_intra_ssi
S 29685 1 3 1 0 6 1 29680 18997 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 pref_inter_ssi
S 29686 1 3 2 0 6 1 29680 11752 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 29687 14 5 0 0 0 1 29680 121334 0 400000 A 0 0 0 0 0 0 0 10264 6 0 0 0 0 0 0 0 0 0 0 0 0 970 0 582 0 0 0 0 esmf_gridcompsetvmmaxthreads
F 29687 6 29681 29682 29683 29684 29685 29686
S 29688 23 5 0 0 0 29695 582 121363 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_gridcompsetvmminthreads
S 29689 1 3 3 0 20870 1 29688 121642 14 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 gridcomp
S 29690 1 3 1 0 6 1 29688 2379 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 max
S 29691 1 3 1 0 6 1 29688 18963 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 pref_intra_process
S 29692 1 3 1 0 6 1 29688 18982 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 pref_intra_ssi
S 29693 1 3 1 0 6 1 29688 18997 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 pref_inter_ssi
S 29694 1 3 2 0 6 1 29688 11752 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 29695 14 5 0 0 0 1 29688 121363 0 400000 A 0 0 0 0 0 0 0 10271 6 0 0 0 0 0 0 0 0 0 0 0 0 1029 0 582 0 0 0 0 esmf_gridcompsetvmminthreads
F 29695 6 29689 29690 29691 29692 29693 29694
S 29696 23 5 0 0 0 29703 582 121392 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_gridcompsetvmmaxpes
S 29697 1 3 3 0 20870 1 29696 121642 14 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 gridcomp
S 29698 1 3 1 0 6 1 29696 2379 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 max
S 29699 1 3 1 0 6 1 29696 18963 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 pref_intra_process
S 29700 1 3 1 0 6 1 29696 18982 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 pref_intra_ssi
S 29701 1 3 1 0 6 1 29696 18997 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 pref_inter_ssi
S 29702 1 3 2 0 6 1 29696 11752 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 29703 14 5 0 0 0 1 29696 121392 0 400000 A 0 0 0 0 0 0 0 10278 6 0 0 0 0 0 0 0 0 0 0 0 0 1089 0 582 0 0 0 0 esmf_gridcompsetvmmaxpes
F 29703 6 29697 29698 29699 29700 29701 29702
S 29704 23 5 0 0 0 29708 582 121179 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_gridcompvalidate
S 29705 1 3 0 0 20870 1 29704 121642 14 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 gridcomp
S 29706 1 3 1 0 28 1 29704 14341 80000014 43000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 options
S 29707 1 3 2 0 6 1 29704 11752 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 29708 14 5 0 0 0 1 29704 121179 0 400000 A 0 0 0 0 0 0 0 10285 3 0 0 0 0 0 0 0 0 0 0 0 0 1149 0 582 0 0 0 0 esmf_gridcompvalidate
F 29708 3 29705 29706 29707
S 29709 23 5 0 0 0 29716 582 121283 20000 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_gridcompwriterestart
S 29710 1 3 3 0 20870 1 29709 121642 14 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 gridcomp
S 29711 1 3 3 0 853 1 29709 15265 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 iospec
S 29712 1 3 3 0 3140 1 29709 25176 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 clock
S 29713 1 3 1 0 6 1 29709 120913 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 phase
S 29714 1 3 1 0 163 1 29709 17577 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 blockingflag
S 29715 1 3 2 0 6 1 29709 11752 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 29716 14 5 0 0 0 1 29709 121283 20000 400000 A 0 0 0 0 0 0 0 10289 6 0 0 0 0 0 0 0 0 0 0 0 0 1200 0 582 0 0 0 0 esmf_gridcompwriterestart
F 29716 6 29710 29711 29712 29713 29714 29715
S 29717 23 5 0 0 0 29721 582 121417 0 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_gridcompwait
S 29718 1 3 3 0 20870 1 29717 121642 14 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 gridcomp
S 29719 1 3 1 0 163 1 29717 17577 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 blockingflag
S 29720 1 3 2 0 6 1 29717 11752 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 29721 14 5 0 0 0 1 29717 121417 0 400000 A 0 0 0 0 0 0 0 10296 3 0 0 0 0 0 0 0 0 0 0 0 0 1274 0 582 0 0 0 0 esmf_gridcompwait
F 29721 3 29718 29719 29720
S 29722 23 5 0 0 8 29725 582 121435 20000 0 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_gridcompispetlocal
S 29723 1 3 3 0 20870 1 29722 121642 14 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 gridcomp
S 29724 1 3 2 0 6 1 29722 11752 80000014 3000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 29725 14 5 0 0 16 1 29722 121435 20004 400000 A 0 0 0 0 0 0 0 10300 2 0 0 29726 0 0 0 0 0 0 0 0 0 1326 0 582 0 0 0 0 esmf_gridcompispetlocal
F 29725 2 29723 29724
S 29726 1 3 0 0 16 1 29722 121435 14 1003000 A 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_gridcompispetlocal
A 13 2 0 0 0 6 608 0 0 0 13 0 0 0 0 0 0 0 0 0
A 14 2 0 0 0 6 617 0 0 0 14 0 0 0 0 0 0 0 0 0
A 15 2 0 0 0 6 621 0 0 0 15 0 0 0 0 0 0 0 0 0
A 16 2 0 0 0 6 623 0 0 0 16 0 0 0 0 0 0 0 0 0
A 17 2 0 0 0 6 609 0 0 0 17 0 0 0 0 0 0 0 0 0
A 18 2 0 0 0 6 627 0 0 0 18 0 0 0 0 0 0 0 0 0
A 19 2 0 0 0 6 629 0 0 0 19 0 0 0 0 0 0 0 0 0
A 20 2 0 0 0 6 631 0 0 0 20 0 0 0 0 0 0 0 0 0
A 21 2 0 0 0 6 598 0 0 0 21 0 0 0 0 0 0 0 0 0
A 22 2 0 0 0 6 645 0 0 0 22 0 0 0 0 0 0 0 0 0
A 23 2 0 0 0 6 613 0 0 0 23 0 0 0 0 0 0 0 0 0
A 24 2 0 0 0 6 615 0 0 0 24 0 0 0 0 0 0 0 0 0
A 27 2 0 0 0 6 596 0 0 0 27 0 0 0 0 0 0 0 0 0
A 32 2 0 0 0 6 599 0 0 0 32 0 0 0 0 0 0 0 0 0
A 45 2 0 0 0 6 603 0 0 0 45 0 0 0 0 0 0 0 0 0
A 52 2 0 0 0 6 604 0 0 0 52 0 0 0 0 0 0 0 0 0
A 56 2 0 0 0 6 605 0 0 0 56 0 0 0 0 0 0 0 0 0
A 60 2 0 0 0 6 606 0 0 0 60 0 0 0 0 0 0 0 0 0
A 95 2 0 0 0 6 600 0 0 0 95 0 0 0 0 0 0 0 0 0
A 105 2 0 0 0 6 610 0 0 0 105 0 0 0 0 0 0 0 0 0
A 109 2 0 0 0 6 611 0 0 0 109 0 0 0 0 0 0 0 0 0
A 113 2 0 0 0 6 612 0 0 0 113 0 0 0 0 0 0 0 0 0
A 182 2 0 0 0 6 666 0 0 0 182 0 0 0 0 0 0 0 0 0
A 208 2 0 0 0 6 672 0 0 0 208 0 0 0 0 0 0 0 0 0
A 214 2 0 0 0 6 674 0 0 0 214 0 0 0 0 0 0 0 0 0
A 220 2 0 0 0 6 676 0 0 0 220 0 0 0 0 0 0 0 0 0
A 226 2 0 0 0 6 678 0 0 0 226 0 0 0 0 0 0 0 0 0
A 232 2 0 0 0 6 614 0 0 0 232 0 0 0 0 0 0 0 0 0
A 238 2 0 0 0 6 681 0 0 0 238 0 0 0 0 0 0 0 0 0
A 244 2 0 0 0 6 683 0 0 0 244 0 0 0 0 0 0 0 0 0
A 250 2 0 0 0 6 685 0 0 0 250 0 0 0 0 0 0 0 0 0
A 256 2 0 0 0 6 687 0 0 0 256 0 0 0 0 0 0 0 0 0
A 262 2 0 0 0 6 689 0 0 0 262 0 0 0 0 0 0 0 0 0
A 273 2 0 0 0 6 692 0 0 0 273 0 0 0 0 0 0 0 0 0
A 279 2 0 0 0 6 694 0 0 0 279 0 0 0 0 0 0 0 0 0
A 285 2 0 0 0 6 696 0 0 0 285 0 0 0 0 0 0 0 0 0
A 291 2 0 0 0 6 698 0 0 0 291 0 0 0 0 0 0 0 0 0
A 404 1 0 0 147 58 716 0 0 0 0 0 0 0 0 0 0 0 0 0
A 407 1 0 0 157 58 718 0 0 0 0 0 0 0 0 0 0 0 0 0
A 410 1 0 0 167 58 720 0 0 0 0 0 0 0 0 0 0 0 0 0
A 413 1 0 0 177 58 722 0 0 0 0 0 0 0 0 0 0 0 0 0
A 416 1 0 0 183 58 724 0 0 0 0 0 0 0 0 0 0 0 0 0
A 419 1 0 0 193 58 726 0 0 0 0 0 0 0 0 0 0 0 0 0
A 422 1 0 0 203 58 728 0 0 0 0 0 0 0 0 0 0 0 0 0
A 425 1 0 0 337 64 732 0 0 0 0 0 0 0 0 0 0 0 0 0
A 428 1 0 0 340 64 734 0 0 0 0 0 0 0 0 0 0 0 0 0
A 431 1 0 0 3 70 738 0 0 0 0 0 0 0 0 0 0 0 0 0
A 434 1 0 0 0 70 740 0 0 0 0 0 0 0 0 0 0 0 0 0
A 437 1 0 0 0 70 742 0 0 0 0 0 0 0 0 0 0 0 0 0
A 440 1 0 0 0 70 744 0 0 0 0 0 0 0 0 0 0 0 0 0
A 443 1 0 0 0 70 746 0 0 0 0 0 0 0 0 0 0 0 0 0
A 446 1 0 0 0 70 748 0 0 0 0 0 0 0 0 0 0 0 0 0
A 449 1 0 0 0 70 750 0 0 0 0 0 0 0 0 0 0 0 0 0
A 452 1 0 0 0 70 752 0 0 0 0 0 0 0 0 0 0 0 0 0
A 455 1 0 0 0 70 754 0 0 0 0 0 0 0 0 0 0 0 0 0
A 458 1 0 0 25 70 756 0 0 0 0 0 0 0 0 0 0 0 0 0
A 461 1 0 0 28 70 758 0 0 0 0 0 0 0 0 0 0 0 0 0
A 464 1 0 0 31 70 760 0 0 0 0 0 0 0 0 0 0 0 0 0
A 467 1 0 0 34 70 762 0 0 0 0 0 0 0 0 0 0 0 0 0
A 468 2 0 0 0 90 616 0 0 0 468 0 0 0 0 0 0 0 0 0
A 472 1 0 0 0 82 781 0 0 0 0 0 0 0 0 0 0 0 0 0
A 473 2 0 0 0 92 618 0 0 0 473 0 0 0 0 0 0 0 0 0
A 477 1 0 0 0 82 783 0 0 0 0 0 0 0 0 0 0 0 0 0
A 478 2 0 0 220 92 619 0 0 0 478 0 0 0 0 0 0 0 0 0
A 482 1 0 0 0 82 785 0 0 0 0 0 0 0 0 0 0 0 0 0
A 483 2 0 0 0 90 620 0 0 0 483 0 0 0 0 0 0 0 0 0
A 487 1 0 0 0 82 787 0 0 0 0 0 0 0 0 0 0 0 0 0
A 488 2 0 0 0 94 622 0 0 0 488 0 0 0 0 0 0 0 0 0
A 492 1 0 0 0 82 789 0 0 0 0 0 0 0 0 0 0 0 0 0
A 493 2 0 0 0 96 624 0 0 0 493 0 0 0 0 0 0 0 0 0
A 497 1 0 0 0 82 791 0 0 0 0 0 0 0 0 0 0 0 0 0
A 498 2 0 0 0 98 625 0 0 0 498 0 0 0 0 0 0 0 0 0
A 502 1 0 0 0 82 793 0 0 0 0 0 0 0 0 0 0 0 0 0
A 503 2 0 0 0 98 626 0 0 0 503 0 0 0 0 0 0 0 0 0
A 507 1 0 0 0 82 795 0 0 0 0 0 0 0 0 0 0 0 0 0
A 508 2 0 0 0 100 628 0 0 0 508 0 0 0 0 0 0 0 0 0
A 512 1 0 0 0 82 797 0 0 0 0 0 0 0 0 0 0 0 0 0
A 513 2 0 0 0 102 630 0 0 0 513 0 0 0 0 0 0 0 0 0
A 517 1 0 0 0 82 799 0 0 0 0 0 0 0 0 0 0 0 0 0
A 518 2 0 0 0 104 632 0 0 0 518 0 0 0 0 0 0 0 0 0
A 522 1 0 0 0 82 801 0 0 0 0 0 0 0 0 0 0 0 0 0
A 523 2 0 0 0 106 633 0 0 0 523 0 0 0 0 0 0 0 0 0
A 527 1 0 0 0 82 803 0 0 0 0 0 0 0 0 0 0 0 0 0
A 528 2 0 0 0 94 634 0 0 0 528 0 0 0 0 0 0 0 0 0
A 532 1 0 0 0 82 805 0 0 0 0 0 0 0 0 0 0 0 0 0
A 533 2 0 0 273 92 635 0 0 0 533 0 0 0 0 0 0 0 0 0
A 537 1 0 0 0 82 807 0 0 0 0 0 0 0 0 0 0 0 0 0
A 538 2 0 0 0 98 636 0 0 0 538 0 0 0 0 0 0 0 0 0
A 542 1 0 0 0 82 809 0 0 0 0 0 0 0 0 0 0 0 0 0
A 543 2 0 0 279 94 637 0 0 0 543 0 0 0 0 0 0 0 0 0
A 547 1 0 0 0 82 811 0 0 0 0 0 0 0 0 0 0 0 0 0
A 548 2 0 0 0 100 638 0 0 0 548 0 0 0 0 0 0 0 0 0
A 552 1 0 0 0 82 813 0 0 0 0 0 0 0 0 0 0 0 0 0
A 553 2 0 0 0 102 639 0 0 0 553 0 0 0 0 0 0 0 0 0
A 557 1 0 0 0 82 815 0 0 0 0 0 0 0 0 0 0 0 0 0
A 558 2 0 0 0 98 640 0 0 0 558 0 0 0 0 0 0 0 0 0
A 562 1 0 0 0 82 817 0 0 0 0 0 0 0 0 0 0 0 0 0
A 563 2 0 0 0 104 641 0 0 0 563 0 0 0 0 0 0 0 0 0
A 567 1 0 0 0 82 819 0 0 0 0 0 0 0 0 0 0 0 0 0
A 568 2 0 0 0 96 642 0 0 0 568 0 0 0 0 0 0 0 0 0
A 572 1 0 0 0 82 821 0 0 0 0 0 0 0 0 0 0 0 0 0
A 573 2 0 0 0 98 643 0 0 0 573 0 0 0 0 0 0 0 0 0
A 577 1 0 0 0 82 823 0 0 0 0 0 0 0 0 0 0 0 0 0
A 578 2 0 0 0 104 644 0 0 0 578 0 0 0 0 0 0 0 0 0
A 582 1 0 0 0 82 825 0 0 0 0 0 0 0 0 0 0 0 0 0
A 583 2 0 0 0 108 646 0 0 0 583 0 0 0 0 0 0 0 0 0
A 587 1 0 0 0 82 827 0 0 0 0 0 0 0 0 0 0 0 0 0
A 588 2 0 0 0 92 647 0 0 0 588 0 0 0 0 0 0 0 0 0
A 592 1 0 0 0 82 829 0 0 0 0 0 0 0 0 0 0 0 0 0
A 593 2 0 0 0 100 648 0 0 0 593 0 0 0 0 0 0 0 0 0
A 597 1 0 0 0 82 831 0 0 0 0 0 0 0 0 0 0 0 0 0
A 598 2 0 0 0 98 649 0 0 0 598 0 0 0 0 0 0 0 0 0
A 602 1 0 0 0 82 833 0 0 0 0 0 0 0 0 0 0 0 0 0
A 603 2 0 0 0 110 650 0 0 0 603 0 0 0 0 0 0 0 0 0
A 607 1 0 0 0 82 835 0 0 0 0 0 0 0 0 0 0 0 0 0
A 608 2 0 0 0 96 651 0 0 0 608 0 0 0 0 0 0 0 0 0
A 612 1 0 0 0 82 837 0 0 0 0 0 0 0 0 0 0 0 0 0
A 613 2 0 0 0 100 652 0 0 0 613 0 0 0 0 0 0 0 0 0
A 617 1 0 0 0 82 839 0 0 0 0 0 0 0 0 0 0 0 0 0
A 618 2 0 0 398 104 653 0 0 0 618 0 0 0 0 0 0 0 0 0
A 622 1 0 0 0 82 841 0 0 0 0 0 0 0 0 0 0 0 0 0
A 623 2 0 0 0 90 654 0 0 0 623 0 0 0 0 0 0 0 0 0
A 627 1 0 0 66 82 843 0 0 0 0 0 0 0 0 0 0 0 0 0
A 630 1 0 0 0 139 870 0 0 0 0 0 0 0 0 0 0 0 0 0
A 633 1 0 0 0 139 872 0 0 0 0 0 0 0 0 0 0 0 0 0
A 636 1 0 0 572 145 876 0 0 0 0 0 0 0 0 0 0 0 0 0
A 639 1 0 0 577 145 878 0 0 0 0 0 0 0 0 0 0 0 0 0
A 642 1 0 0 582 145 880 0 0 0 0 0 0 0 0 0 0 0 0 0
A 645 1 0 0 587 145 882 0 0 0 0 0 0 0 0 0 0 0 0 0
A 648 1 0 0 592 145 884 0 0 0 0 0 0 0 0 0 0 0 0 0
A 651 1 0 0 597 145 886 0 0 0 0 0 0 0 0 0 0 0 0 0
A 654 1 0 0 602 145 888 0 0 0 0 0 0 0 0 0 0 0 0 0
A 657 1 0 0 612 151 892 0 0 0 0 0 0 0 0 0 0 0 0 0
A 660 1 0 0 617 151 894 0 0 0 0 0 0 0 0 0 0 0 0 0
A 663 1 0 0 627 157 898 0 0 0 0 0 0 0 0 0 0 0 0 0
A 666 1 0 0 69 157 900 0 0 0 0 0 0 0 0 0 0 0 0 0
A 669 1 0 0 0 157 902 0 0 0 0 0 0 0 0 0 0 0 0 0
A 672 1 0 0 0 163 906 0 0 0 0 0 0 0 0 0 0 0 0 0
A 675 1 0 0 0 163 908 0 0 0 0 0 0 0 0 0 0 0 0 0
A 678 1 0 0 0 163 910 0 0 0 0 0 0 0 0 0 0 0 0 0
A 681 1 0 0 0 169 914 0 0 0 0 0 0 0 0 0 0 0 0 0
A 684 1 0 0 0 169 916 0 0 0 0 0 0 0 0 0 0 0 0 0
A 687 1 0 0 0 175 920 0 0 0 0 0 0 0 0 0 0 0 0 0
A 690 1 0 0 0 175 922 0 0 0 0 0 0 0 0 0 0 0 0 0
A 693 1 0 0 0 175 924 0 0 0 0 0 0 0 0 0 0 0 0 0
A 696 1 0 0 0 181 928 0 0 0 0 0 0 0 0 0 0 0 0 0
A 699 1 0 0 0 181 930 0 0 0 0 0 0 0 0 0 0 0 0 0
A 702 1 0 0 0 187 934 0 0 0 0 0 0 0 0 0 0 0 0 0
A 705 1 0 0 0 187 936 0 0 0 0 0 0 0 0 0 0 0 0 0
A 708 1 0 0 0 193 940 0 0 0 0 0 0 0 0 0 0 0 0 0
A 711 1 0 0 0 193 942 0 0 0 0 0 0 0 0 0 0 0 0 0
A 714 1 0 0 0 199 946 0 0 0 0 0 0 0 0 0 0 0 0 0
A 717 1 0 0 0 199 948 0 0 0 0 0 0 0 0 0 0 0 0 0
A 720 1 0 0 468 199 950 0 0 0 0 0 0 0 0 0 0 0 0 0
A 805 1 0 0 0 402 1197 0 0 0 0 0 0 0 0 0 0 0 0 0
A 808 1 0 0 22 402 1199 0 0 0 0 0 0 0 0 0 0 0 0 0
A 811 1 0 0 301 402 1201 0 0 0 0 0 0 0 0 0 0 0 0 0
A 814 1 0 0 116 408 1205 0 0 0 0 0 0 0 0 0 0 0 0 0
A 817 1 0 0 118 408 1207 0 0 0 0 0 0 0 0 0 0 0 0 0
A 820 1 0 0 120 408 1209 0 0 0 0 0 0 0 0 0 0 0 0 0
A 823 1 0 0 0 414 1213 0 0 0 0 0 0 0 0 0 0 0 0 0
A 826 1 0 0 124 414 1215 0 0 0 0 0 0 0 0 0 0 0 0 0
A 829 1 0 0 708 414 1217 0 0 0 0 0 0 0 0 0 0 0 0 0
A 830 2 0 0 0 6 1471 0 0 0 830 0 0 0 0 0 0 0 0 0
A 962 1 0 0 791 841 1640 0 0 0 0 0 0 0 0 0 0 0 0 0
A 965 1 0 0 0 841 1642 0 0 0 0 0 0 0 0 0 0 0 0 0
A 968 1 0 0 367 841 1644 0 0 0 0 0 0 0 0 0 0 0 0 0
A 971 1 0 0 0 847 1648 0 0 0 0 0 0 0 0 0 0 0 0 0
A 974 1 0 0 373 847 1650 0 0 0 0 0 0 0 0 0 0 0 0 0
A 977 1 0 0 802 847 1652 0 0 0 0 0 0 0 0 0 0 0 0 0
A 980 1 0 0 0 847 1654 0 0 0 0 0 0 0 0 0 0 0 0 0
A 983 1 0 0 0 847 1656 0 0 0 0 0 0 0 0 0 0 0 0 0
A 986 1 0 0 0 847 1658 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1495 2 0 0 1362 6 3063 0 0 0 1495 0 0 0 0 0 0 0 0 0
A 1662 1 0 0 1446 1586 3071 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1665 1 0 0 1445 1586 3073 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1853 1 0 0 1591 2267 3801 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1856 1 0 0 1590 2267 3803 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1859 1 0 0 1595 2267 3805 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1862 1 0 0 1594 2267 3807 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1865 1 0 0 1599 2267 3809 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1868 1 0 0 1598 2267 3811 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1871 1 0 0 1413 2267 3813 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1988 1 0 0 0 2783 4055 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1991 1 0 0 1098 2783 4057 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1994 1 0 0 1097 2783 4059 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1997 1 0 0 1102 2783 4061 0 0 0 0 0 0 0 0 0 0 0 0 0
A 2223 1 0 0 2120 3890 4768 0 0 0 0 0 0 0 0 0 0 0 0 0
A 2226 1 0 0 2160 3890 4770 0 0 0 0 0 0 0 0 0 0 0 0 0
A 2229 1 0 0 2162 3890 4772 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7886 1 0 0 7436 4092 4849 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7889 1 0 0 7441 4092 4851 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7892 1 0 0 7440 4092 4853 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7895 1 0 0 7448 4092 4855 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7898 1 0 0 7452 4092 4857 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7901 1 0 0 7851 4098 4861 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7904 1 0 0 7850 4098 4863 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9948 2 0 0 6780 6 10300 0 0 0 9948 0 0 0 0 0 0 0 0 0
A 10375 1 0 0 9838 8072 10308 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10378 1 0 0 9966 8072 10310 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10381 1 0 0 9983 8072 10312 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10384 1 0 0 10329 8072 10314 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10387 1 0 0 9981 8072 10316 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10390 1 0 0 9987 8072 10318 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10393 1 0 0 10069 8072 10320 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10396 1 0 0 9611 8072 10322 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10398 2 0 0 10301 6 10687 0 0 0 10398 0 0 0 0 0 0 0 0 0
A 10484 1 0 0 9373 8461 10698 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10487 1 0 0 10063 8461 10700 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10490 1 0 0 10058 8461 10702 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10493 1 0 0 10062 8461 10704 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10496 1 0 0 10065 8461 10706 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10499 1 0 0 10281 8461 10708 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10502 1 0 0 10067 8461 10710 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10505 1 0 0 10097 8461 10712 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10508 1 0 0 10098 8461 10714 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10511 1 0 0 10105 8461 10716 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10514 1 0 0 10103 8461 10718 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10517 1 0 0 8846 8461 10720 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10520 1 0 0 10101 8461 10722 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10523 1 0 0 7912 8461 10724 0 0 0 0 0 0 0 0 0 0 0 0 0
A 11031 1 0 0 9001 8658 10811 0 0 0 0 0 0 0 0 0 0 0 0 0
A 11034 1 0 0 9327 8658 10813 0 0 0 0 0 0 0 0 0 0 0 0 0
A 11037 1 0 0 9734 8658 10815 0 0 0 0 0 0 0 0 0 0 0 0 0
A 11040 1 0 0 10332 8658 10817 0 0 0 0 0 0 0 0 0 0 0 0 0
A 11043 1 0 0 8211 8658 10819 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16860 1 0 0 16447 13122 17878 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16863 1 0 0 15587 13122 17880 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16866 1 0 0 15584 13122 17882 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16869 1 0 0 15592 13122 17884 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16872 1 0 0 15582 13128 17888 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16875 1 0 0 15576 13128 17890 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16878 1 0 0 15864 13128 17892 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16881 1 0 0 15588 13128 17894 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16986 1 0 0 16818 14089 19389 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16989 1 0 0 16819 14089 19391 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16992 1 0 0 15914 14095 19395 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16995 1 0 0 15916 14095 19397 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17135 1 0 0 16209 14352 19745 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17138 1 0 0 16207 14352 19747 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17141 1 0 0 17086 14364 19756 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17144 1 0 0 17081 14364 19758 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17147 1 0 0 16622 14364 19760 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17150 1 0 0 17085 14364 19762 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17153 1 0 0 16624 14364 19764 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17156 1 0 0 16619 14364 19766 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17159 1 0 0 17092 14364 19768 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17162 1 0 0 16629 14364 19770 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17165 1 0 0 17096 14364 19772 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17168 1 0 0 17091 14364 19774 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17171 1 0 0 16636 14364 19776 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17174 1 0 0 17095 14364 19778 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17177 1 0 0 16234 14364 19780 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17180 1 0 0 16229 14364 19782 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17183 1 0 0 16510 14370 19786 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17186 1 0 0 16958 14370 19788 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17189 1 0 0 16514 14370 19790 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17192 1 0 0 16802 14370 19792 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17195 1 0 0 16803 14370 19794 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17198 1 0 0 16521 14370 19796 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17201 1 0 0 16965 14370 19798 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17204 1 0 0 16967 14370 19800 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17207 1 0 0 16969 14370 19802 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23980 1 0 0 23646 19135 27467 0 0 0 0 0 0 0 0 0 0 0 0 0
A 23983 1 0 0 23643 19135 27469 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24119 2 0 0 24090 6 28286 0 0 0 24119 0 0 0 0 0 0 0 0 0
A 24123 2 0 0 24091 6 28287 0 0 0 24123 0 0 0 0 0 0 0 0 0
A 24127 2 0 0 24084 6 28288 0 0 0 24127 0 0 0 0 0 0 0 0 0
A 24131 2 0 0 24085 6 28289 0 0 0 24131 0 0 0 0 0 0 0 0 0
A 24135 2 0 0 23766 6 28290 0 0 0 24135 0 0 0 0 0 0 0 0 0
A 24139 2 0 0 23769 6 28291 0 0 0 24139 0 0 0 0 0 0 0 0 0
A 24143 2 0 0 24096 6 28292 0 0 0 24143 0 0 0 0 0 0 0 0 0
A 24147 2 0 0 23768 6 28293 0 0 0 24147 0 0 0 0 0 0 0 0 0
A 24151 2 0 0 24097 6 28294 0 0 0 24151 0 0 0 0 0 0 0 0 0
A 24155 2 0 0 23984 6 28295 0 0 0 24155 0 0 0 0 0 0 0 0 0
A 24232 1 0 0 23722 19848 28300 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24235 1 0 0 24189 19848 28302 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24238 1 0 0 23911 19848 28304 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24241 1 0 0 23910 19848 28306 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24244 1 0 0 23735 19854 28310 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24247 1 0 0 23742 19854 28312 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24250 1 0 0 23747 19854 28314 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24253 1 0 0 23738 19854 28316 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24256 1 0 0 23743 19854 28318 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24259 1 0 0 23750 19854 28320 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24262 1 0 0 23949 19854 28322 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24265 1 0 0 23917 19854 28324 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24268 1 0 0 23916 19854 28326 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24271 1 0 0 24190 19854 28328 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24274 1 0 0 23598 19860 28332 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24277 1 0 0 23603 19860 28334 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24280 1 0 0 24199 19866 28338 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24283 1 0 0 24201 19866 28340 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24286 1 0 0 24202 19866 28342 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24289 1 0 0 22776 19872 28346 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24292 1 0 0 23870 19872 28348 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24295 1 0 0 24011 19878 28352 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24298 1 0 0 24010 19878 28354 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24301 1 0 0 23116 19878 28356 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24579 1 0 0 24126 20823 29250 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24582 1 0 0 24374 20823 29252 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24585 1 0 0 24154 20829 29256 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24588 1 0 0 24377 20829 29258 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24591 1 0 0 24130 20829 29260 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24594 1 0 0 24150 20829 29262 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24597 1 0 0 23086 20829 29264 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24600 1 0 0 23948 20829 29266 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24601 2 0 0 24511 1687 29572 0 0 0 24601 0 0 0 0 0 0 0 0 0
A 24603 1 0 0 24415 6 29608 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24604 1 0 0 24410 6 29606 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24605 1 0 0 24412 6 29609 0 0 0 0 0 0 0 0 0 0 0 0 0
A 24606 1 0 0 24413 6 29607 0 0 0 0 0 0 0 0 0 0 0 0 0
Z
J 97 1 1
V 404 58 7 0
S 0 58 0 0 0
A 0 6 0 0 1 3 0
J 97 1 1
V 407 58 7 0
S 0 58 0 0 0
A 0 6 0 0 1 45 0
J 97 1 1
V 410 58 7 0
S 0 58 0 0 0
A 0 6 0 0 1 32 0
J 97 1 1
V 413 58 7 0
S 0 58 0 0 0
A 0 6 0 0 1 52 0
J 97 1 1
V 416 58 7 0
S 0 58 0 0 0
A 0 6 0 0 1 56 0
J 97 1 1
V 419 58 7 0
S 0 58 0 0 0
A 0 6 0 0 1 60 0
J 97 1 1
V 422 58 7 0
S 0 58 0 0 0
A 0 6 0 0 1 21 0
J 124 1 1
V 425 64 7 0
S 0 64 0 0 0
A 0 6 0 0 1 2 0
J 124 1 1
V 428 64 7 0
S 0 64 0 0 0
A 0 6 0 0 1 27 0
J 145 1 1
V 431 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 3 0
J 145 1 1
V 434 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 45 0
J 145 1 1
V 437 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 32 0
J 145 1 1
V 440 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 52 0
J 145 1 1
V 443 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 56 0
J 145 1 1
V 446 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 60 0
J 145 1 1
V 449 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 21 0
J 145 1 1
V 452 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 95 0
J 145 1 1
V 455 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 13 0
J 145 1 1
V 458 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 17 0
J 145 1 1
V 461 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 105 0
J 145 1 1
V 464 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 109 0
J 145 1 1
V 467 70 7 0
S 0 70 0 0 0
A 0 6 0 0 1 113 0
J 219 1 1
V 472 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 3 1
A 0 90 0 0 1 468 0
J 219 1 1
V 477 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 45 1
A 0 92 0 0 1 473 0
J 219 1 1
V 482 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 32 1
A 0 92 0 0 1 478 0
J 219 1 1
V 487 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 52 1
A 0 90 0 0 1 483 0
J 219 1 1
V 492 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 56 1
A 0 94 0 0 1 488 0
J 219 1 1
V 497 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 60 1
A 0 96 0 0 1 493 0
J 219 1 1
V 502 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 21 1
A 0 98 0 0 1 498 0
J 219 1 1
V 507 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 95 1
A 0 98 0 0 1 503 0
J 219 1 1
V 512 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 13 1
A 0 100 0 0 1 508 0
J 219 1 1
V 517 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 17 1
A 0 102 0 0 1 513 0
J 219 1 1
V 522 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 14 1
A 0 104 0 0 1 518 0
J 219 1 1
V 527 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 182 1
A 0 106 0 0 1 523 0
J 219 1 1
V 532 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 15 1
A 0 94 0 0 1 528 0
J 219 1 1
V 537 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 18 1
A 0 92 0 0 1 533 0
J 219 1 1
V 542 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 20 1
A 0 98 0 0 1 538 0
J 219 1 1
V 547 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 16 1
A 0 94 0 0 1 543 0
J 219 1 1
V 552 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 208 1
A 0 100 0 0 1 548 0
J 219 1 1
V 557 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 214 1
A 0 102 0 0 1 553 0
J 219 1 1
V 562 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 220 1
A 0 98 0 0 1 558 0
J 219 1 1
V 567 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 226 1
A 0 104 0 0 1 563 0
J 219 1 1
V 572 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 232 1
A 0 96 0 0 1 568 0
J 219 1 1
V 577 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 238 1
A 0 98 0 0 1 573 0
J 219 1 1
V 582 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 244 1
A 0 104 0 0 1 578 0
J 219 1 1
V 587 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 250 1
A 0 108 0 0 1 583 0
J 219 1 1
V 592 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 256 1
A 0 92 0 0 1 588 0
J 219 1 1
V 597 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 262 1
A 0 100 0 0 1 593 0
J 219 1 1
V 602 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 24 1
A 0 98 0 0 1 598 0
J 219 1 1
V 607 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 273 1
A 0 110 0 0 1 603 0
J 219 1 1
V 612 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 279 1
A 0 96 0 0 1 608 0
J 219 1 1
V 617 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 285 1
A 0 100 0 0 1 613 0
J 219 1 1
V 622 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 291 1
A 0 104 0 0 1 618 0
J 219 1 1
V 627 82 7 0
S 0 82 0 0 0
A 0 6 0 0 1 113 1
A 0 90 0 0 1 623 0
J 303 1 1
V 630 139 7 0
S 0 139 0 0 0
A 0 6 0 0 1 3 0
J 303 1 1
V 633 139 7 0
S 0 139 0 0 0
A 0 6 0 0 1 45 0
J 337 1 1
V 636 145 7 0
S 0 145 0 0 0
A 0 6 0 0 1 3 0
J 337 1 1
V 639 145 7 0
S 0 145 0 0 0
A 0 6 0 0 1 45 0
J 337 1 1
V 642 145 7 0
S 0 145 0 0 0
A 0 6 0 0 1 32 0
J 337 1 1
V 645 145 7 0
S 0 145 0 0 0
A 0 6 0 0 1 52 0
J 337 1 1
V 648 145 7 0
S 0 145 0 0 0
A 0 6 0 0 1 56 0
J 337 1 1
V 651 145 7 0
S 0 145 0 0 0
A 0 6 0 0 1 60 0
J 337 1 1
V 654 145 7 0
S 0 145 0 0 0
A 0 6 0 0 1 21 0
J 363 1 1
V 657 151 7 0
S 0 151 0 0 0
A 0 6 0 0 1 3 0
J 363 1 1
V 660 151 7 0
S 0 151 0 0 0
A 0 6 0 0 1 45 0
J 378 1 1
V 663 157 7 0
S 0 157 0 0 0
A 0 6 0 0 1 3 0
J 378 1 1
V 666 157 7 0
S 0 157 0 0 0
A 0 6 0 0 1 45 0
J 378 1 1
V 669 157 7 0
S 0 157 0 0 0
A 0 6 0 0 1 32 0
J 392 1 1
V 672 163 7 0
S 0 163 0 0 0
A 0 6 0 0 1 3 0
J 392 1 1
V 675 163 7 0
S 0 163 0 0 0
A 0 6 0 0 1 45 0
J 392 1 1
V 678 163 7 0
S 0 163 0 0 0
A 0 6 0 0 1 32 0
J 407 1 1
V 681 169 7 0
S 0 169 0 0 0
A 0 6 0 0 1 3 0
J 407 1 1
V 684 169 7 0
S 0 169 0 0 0
A 0 6 0 0 1 45 0
J 421 1 1
V 687 175 7 0
S 0 175 0 0 0
A 0 6 0 0 1 3 0
J 421 1 1
V 690 175 7 0
S 0 175 0 0 0
A 0 6 0 0 1 45 0
J 421 1 1
V 693 175 7 0
S 0 175 0 0 0
A 0 6 0 0 1 32 0
J 436 1 1
V 696 181 7 0
S 0 181 0 0 0
A 0 6 0 0 1 3 0
J 436 1 1
V 699 181 7 0
S 0 181 0 0 0
A 0 6 0 0 1 45 0
J 450 1 1
V 702 187 7 0
S 0 187 0 0 0
A 0 6 0 0 1 3 0
J 450 1 1
V 705 187 7 0
S 0 187 0 0 0
A 0 6 0 0 1 45 0
J 465 1 1
V 708 193 7 0
S 0 193 0 0 0
A 0 6 0 0 1 2 0
J 465 1 1
V 711 193 7 0
S 0 193 0 0 0
A 0 6 0 0 1 3 0
J 480 1 1
V 714 199 7 0
S 0 199 0 0 0
A 0 6 0 0 1 2 0
J 480 1 1
V 717 199 7 0
S 0 199 0 0 0
A 0 6 0 0 1 3 0
J 480 1 1
V 720 199 7 0
S 0 199 0 0 0
A 0 6 0 0 1 45 0
J 67 1 1
V 805 402 7 0
S 0 402 0 0 0
A 0 6 0 0 1 3 0
J 67 1 1
V 808 402 7 0
S 0 402 0 0 0
A 0 6 0 0 1 45 0
J 67 1 1
V 811 402 7 0
S 0 402 0 0 0
A 0 6 0 0 1 32 0
J 79 1 1
V 814 408 7 0
S 0 408 0 0 0
A 0 6 0 0 1 3 0
J 79 1 1
V 817 408 7 0
S 0 408 0 0 0
A 0 6 0 0 1 45 0
J 79 1 1
V 820 408 7 0
S 0 408 0 0 0
A 0 6 0 0 1 32 0
J 91 1 1
V 823 414 7 0
S 0 414 0 0 0
A 0 6 0 0 1 3 0
J 91 1 1
V 826 414 7 0
S 0 414 0 0 0
A 0 6 0 0 1 45 0
J 91 1 1
V 829 414 7 0
S 0 414 0 0 0
A 0 6 0 0 1 32 0
J 54 1 1
V 962 841 7 0
S 0 841 0 0 0
A 0 6 0 0 1 2 0
J 54 1 1
V 965 841 7 0
S 0 841 0 0 0
A 0 6 0 0 1 3 0
J 54 1 1
V 968 841 7 0
S 0 841 0 0 0
A 0 6 0 0 1 45 0
J 66 1 1
V 971 847 7 0
S 0 847 0 0 0
A 0 6 0 0 1 2 0
J 66 1 1
V 974 847 7 0
S 0 847 0 0 0
A 0 6 0 0 1 3 0
J 66 1 1
V 977 847 7 0
S 0 847 0 0 0
A 0 6 0 0 1 45 0
J 66 1 1
V 980 847 7 0
S 0 847 0 0 0
A 0 6 0 0 1 32 0
J 66 1 1
V 983 847 7 0
S 0 847 0 0 0
A 0 6 0 0 1 52 0
J 66 1 1
V 986 847 7 0
S 0 847 0 0 0
A 0 6 0 0 1 56 0
J 71 1 1
V 1662 1586 7 0
S 0 1586 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 1665 1586 7 0
S 0 1586 0 0 0
A 0 6 0 0 1 45 0
J 69 1 1
V 1853 2267 7 0
S 0 2267 0 0 0
A 0 6 0 0 1 3 0
J 69 1 1
V 1856 2267 7 0
S 0 2267 0 0 0
A 0 6 0 0 1 45 0
J 69 1 1
V 1859 2267 7 0
S 0 2267 0 0 0
A 0 6 0 0 1 32 0
J 69 1 1
V 1862 2267 7 0
S 0 2267 0 0 0
A 0 6 0 0 1 52 0
J 69 1 1
V 1865 2267 7 0
S 0 2267 0 0 0
A 0 6 0 0 1 56 0
J 69 1 1
V 1868 2267 7 0
S 0 2267 0 0 0
A 0 6 0 0 1 60 0
J 69 1 1
V 1871 2267 7 0
S 0 2267 0 0 0
A 0 6 0 0 1 21 0
J 62 1 1
V 1988 2783 7 0
S 0 2783 0 0 0
A 0 6 0 0 1 3 0
J 62 1 1
V 1991 2783 7 0
S 0 2783 0 0 0
A 0 6 0 0 1 45 0
J 62 1 1
V 1994 2783 7 0
S 0 2783 0 0 0
A 0 6 0 0 1 32 0
J 62 1 1
V 1997 2783 7 0
S 0 2783 0 0 0
A 0 6 0 0 1 52 0
J 68 1 1
V 2223 3890 7 0
S 0 3890 0 0 0
A 0 6 0 0 1 2 0
J 68 1 1
V 2226 3890 7 0
S 0 3890 0 0 0
A 0 6 0 0 1 3 0
J 68 1 1
V 2229 3890 7 0
S 0 3890 0 0 0
A 0 6 0 0 1 45 0
J 77 1 1
V 7886 4092 7 0
S 0 4092 0 0 0
A 0 6 0 0 1 3 0
J 77 1 1
V 7889 4092 7 0
S 0 4092 0 0 0
A 0 6 0 0 1 45 0
J 77 1 1
V 7892 4092 7 0
S 0 4092 0 0 0
A 0 6 0 0 1 32 0
J 77 1 1
V 7895 4092 7 0
S 0 4092 0 0 0
A 0 6 0 0 1 52 0
J 77 1 1
V 7898 4092 7 0
S 0 4092 0 0 0
A 0 6 0 0 1 56 0
J 97 1 1
V 7901 4098 7 0
S 0 4098 0 0 0
A 0 6 0 0 1 3 0
J 97 1 1
V 7904 4098 7 0
S 0 4098 0 0 0
A 0 6 0 0 1 45 0
J 69 1 1
V 10375 8072 7 0
S 0 8072 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 10378 8072 7 0
S 0 8072 0 0 0
A 0 6 0 0 1 45 0
J 73 1 1
V 10381 8072 7 0
S 0 8072 0 0 0
A 0 6 0 0 1 52 0
J 75 1 1
V 10384 8072 7 0
S 0 8072 0 0 0
A 0 6 0 0 1 95 0
J 77 1 1
V 10387 8072 7 0
S 0 8072 0 0 0
A 0 6 0 0 1 20 0
J 79 1 1
V 10390 8072 7 0
S 0 8072 0 0 0
A 0 6 0 0 1 24 0
J 81 1 1
V 10393 8072 7 0
S 0 8072 0 0 0
A 0 6 0 0 1 830 0
J 83 1 1
V 10396 8072 7 0
S 0 8072 0 0 0
A 0 6 0 0 1 9948 0
J 79 1 1
V 10484 8461 7 0
S 0 8461 0 0 0
A 0 6 0 0 1 10398 0
J 79 1 1
V 10487 8461 7 0
S 0 8461 0 0 0
A 0 6 0 0 1 27 0
J 84 1 1
V 10490 8461 7 0
S 0 8461 0 0 0
A 0 6 0 0 1 2 0
J 84 1 1
V 10493 8461 7 0
S 0 8461 0 0 0
A 0 6 0 0 1 3 0
J 84 1 1
V 10496 8461 7 0
S 0 8461 0 0 0
A 0 6 0 0 1 45 0
J 84 1 1
V 10499 8461 7 0
S 0 8461 0 0 0
A 0 6 0 0 1 32 0
J 91 1 1
V 10502 8461 7 0
S 0 8461 0 0 0
A 0 6 0 0 1 2 0
J 91 1 1
V 10505 8461 7 0
S 0 8461 0 0 0
A 0 6 0 0 1 3 0
J 91 1 1
V 10508 8461 7 0
S 0 8461 0 0 0
A 0 6 0 0 1 45 0
J 91 1 1
V 10511 8461 7 0
S 0 8461 0 0 0
A 0 6 0 0 1 32 0
J 91 1 1
V 10514 8461 7 0
S 0 8461 0 0 0
A 0 6 0 0 1 52 0
J 91 1 1
V 10517 8461 7 0
S 0 8461 0 0 0
A 0 6 0 0 1 56 0
J 91 1 1
V 10520 8461 7 0
S 0 8461 0 0 0
A 0 6 0 0 1 60 0
J 91 1 1
V 10523 8461 7 0
S 0 8461 0 0 0
A 0 6 0 0 1 21 0
J 72 1 1
V 11031 8658 7 0
S 0 8658 0 0 0
A 0 6 0 0 1 3 0
J 72 1 1
V 11034 8658 7 0
S 0 8658 0 0 0
A 0 6 0 0 1 45 0
J 72 1 1
V 11037 8658 7 0
S 0 8658 0 0 0
A 0 6 0 0 1 32 0
J 72 1 1
V 11040 8658 7 0
S 0 8658 0 0 0
A 0 6 0 0 1 52 0
J 72 1 1
V 11043 8658 7 0
S 0 8658 0 0 0
A 0 6 0 0 1 56 0
J 80 1 1
V 16860 13122 7 0
S 0 13122 0 0 0
A 0 6 0 0 1 27 0
J 80 1 1
V 16863 13122 7 0
S 0 13122 0 0 0
A 0 6 0 0 1 2 0
J 80 1 1
V 16866 13122 7 0
S 0 13122 0 0 0
A 0 6 0 0 1 3 0
J 80 1 1
V 16869 13122 7 0
S 0 13122 0 0 0
A 0 6 0 0 1 45 0
J 96 1 1
V 16872 13128 7 0
S 0 13128 0 0 0
A 0 6 0 0 1 2 0
J 96 1 1
V 16875 13128 7 0
S 0 13128 0 0 0
A 0 6 0 0 1 3 0
J 96 1 1
V 16878 13128 7 0
S 0 13128 0 0 0
A 0 6 0 0 1 45 0
J 96 1 1
V 16881 13128 7 0
S 0 13128 0 0 0
A 0 6 0 0 1 32 0
J 80 1 1
V 16986 14089 7 0
S 0 14089 0 0 0
A 0 6 0 0 1 2 0
J 80 1 1
V 16989 14089 7 0
S 0 14089 0 0 0
A 0 6 0 0 1 3 0
J 95 1 1
V 16992 14095 7 0
S 0 14095 0 0 0
A 0 6 0 0 1 2 0
J 95 1 1
V 16995 14095 7 0
S 0 14095 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 17135 14352 7 0
S 0 14352 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 17138 14352 7 0
S 0 14352 0 0 0
A 0 6 0 0 1 45 0
J 102 1 1
V 17141 14364 7 0
S 0 14364 0 0 0
A 0 6 0 0 1 2 0
J 102 1 1
V 17144 14364 7 0
S 0 14364 0 0 0
A 0 6 0 0 1 3 0
J 102 1 1
V 17147 14364 7 0
S 0 14364 0 0 0
A 0 6 0 0 1 45 0
J 102 1 1
V 17150 14364 7 0
S 0 14364 0 0 0
A 0 6 0 0 1 32 0
J 102 1 1
V 17153 14364 7 0
S 0 14364 0 0 0
A 0 6 0 0 1 52 0
J 102 1 1
V 17156 14364 7 0
S 0 14364 0 0 0
A 0 6 0 0 1 56 0
J 102 1 1
V 17159 14364 7 0
S 0 14364 0 0 0
A 0 6 0 0 1 60 0
J 102 1 1
V 17162 14364 7 0
S 0 14364 0 0 0
A 0 6 0 0 1 21 0
J 102 1 1
V 17165 14364 7 0
S 0 14364 0 0 0
A 0 6 0 0 1 95 0
J 102 1 1
V 17168 14364 7 0
S 0 14364 0 0 0
A 0 6 0 0 1 13 0
J 102 1 1
V 17171 14364 7 0
S 0 14364 0 0 0
A 0 6 0 0 1 17 0
J 102 1 1
V 17174 14364 7 0
S 0 14364 0 0 0
A 0 6 0 0 1 14 0
J 102 1 1
V 17177 14364 7 0
S 0 14364 0 0 0
A 0 6 0 0 1 182 0
J 102 1 1
V 17180 14364 7 0
S 0 14364 0 0 0
A 0 6 0 0 1 15 0
J 129 1 1
V 17183 14370 7 0
S 0 14370 0 0 0
A 0 6 0 0 1 2 0
J 129 1 1
V 17186 14370 7 0
S 0 14370 0 0 0
A 0 6 0 0 1 3 0
J 129 1 1
V 17189 14370 7 0
S 0 14370 0 0 0
A 0 6 0 0 1 45 0
J 129 1 1
V 17192 14370 7 0
S 0 14370 0 0 0
A 0 6 0 0 1 32 0
J 129 1 1
V 17195 14370 7 0
S 0 14370 0 0 0
A 0 6 0 0 1 52 0
J 129 1 1
V 17198 14370 7 0
S 0 14370 0 0 0
A 0 6 0 0 1 56 0
J 129 1 1
V 17201 14370 7 0
S 0 14370 0 0 0
A 0 6 0 0 1 60 0
J 129 1 1
V 17204 14370 7 0
S 0 14370 0 0 0
A 0 6 0 0 1 21 0
J 129 1 1
V 17207 14370 7 0
S 0 14370 0 0 0
A 0 6 0 0 1 95 0
J 70 1 1
V 23980 19135 7 0
S 0 19135 0 0 0
A 0 6 0 0 1 3 0
J 70 1 1
V 23983 19135 7 0
S 0 19135 0 0 0
A 0 6 0 0 1 45 0
J 64 1 1
V 24232 19848 7 0
S 0 19848 0 0 0
A 0 6 0 0 1 3 0
J 64 1 1
V 24235 19848 7 0
S 0 19848 0 0 0
A 0 6 0 0 1 45 0
J 64 1 1
V 24238 19848 7 0
S 0 19848 0 0 0
A 0 6 0 0 1 32 0
J 64 1 1
V 24241 19848 7 0
S 0 19848 0 0 0
A 0 6 0 0 1 52 0
J 82 1 1
V 24244 19854 7 0
S 0 19854 0 0 0
A 0 6 0 0 1 24119 0
J 82 1 1
V 24247 19854 7 0
S 0 19854 0 0 0
A 0 6 0 0 1 24123 0
J 82 1 1
V 24250 19854 7 0
S 0 19854 0 0 0
A 0 6 0 0 1 24127 0
J 82 1 1
V 24253 19854 7 0
S 0 19854 0 0 0
A 0 6 0 0 1 24131 0
J 82 1 1
V 24256 19854 7 0
S 0 19854 0 0 0
A 0 6 0 0 1 24135 0
J 82 1 1
V 24259 19854 7 0
S 0 19854 0 0 0
A 0 6 0 0 1 24139 0
J 82 1 1
V 24262 19854 7 0
S 0 19854 0 0 0
A 0 6 0 0 1 24143 0
J 82 1 1
V 24265 19854 7 0
S 0 19854 0 0 0
A 0 6 0 0 1 24147 0
J 82 1 1
V 24268 19854 7 0
S 0 19854 0 0 0
A 0 6 0 0 1 24151 0
J 82 1 1
V 24271 19854 7 0
S 0 19854 0 0 0
A 0 6 0 0 1 24155 0
J 106 1 1
V 24274 19860 7 0
S 0 19860 0 0 0
A 0 6 0 0 1 3 0
J 106 1 1
V 24277 19860 7 0
S 0 19860 0 0 0
A 0 6 0 0 1 45 0
J 119 1 1
V 24280 19866 7 0
S 0 19866 0 0 0
A 0 6 0 0 1 3 0
J 119 1 1
V 24283 19866 7 0
S 0 19866 0 0 0
A 0 6 0 0 1 45 0
J 119 1 1
V 24286 19866 7 0
S 0 19866 0 0 0
A 0 6 0 0 1 32 0
J 134 1 1
V 24289 19872 7 0
S 0 19872 0 0 0
A 0 6 0 0 1 3 0
J 134 1 1
V 24292 19872 7 0
S 0 19872 0 0 0
A 0 6 0 0 1 45 0
J 148 1 1
V 24295 19878 7 0
S 0 19878 0 0 0
A 0 6 0 0 1 3 0
J 148 1 1
V 24298 19878 7 0
S 0 19878 0 0 0
A 0 6 0 0 1 45 0
J 148 1 1
V 24301 19878 7 0
S 0 19878 0 0 0
A 0 6 0 0 1 32 0
J 69 1 1
V 24579 20823 7 0
S 0 20823 0 0 0
A 0 6 0 0 1 3 0
J 69 1 1
V 24582 20823 7 0
S 0 20823 0 0 0
A 0 6 0 0 1 45 0
J 83 1 1
V 24585 20829 7 0
S 0 20829 0 0 0
A 0 6 0 0 1 3 0
J 83 1 1
V 24588 20829 7 0
S 0 20829 0 0 0
A 0 6 0 0 1 45 0
J 83 1 1
V 24591 20829 7 0
S 0 20829 0 0 0
A 0 6 0 0 1 32 0
J 83 1 1
V 24594 20829 7 0
S 0 20829 0 0 0
A 0 6 0 0 1 52 0
J 83 1 1
V 24597 20829 7 0
S 0 20829 0 0 0
A 0 6 0 0 1 56 0
J 83 1 1
V 24600 20829 7 0
S 0 20829 0 0 0
A 0 6 0 0 1 60 0
Z
