V24 esmf_statereconcilemod
78 /u0/d/dazlich/doe_ca/esmf/src/Superstructure/State/src/ESMF_StateReconcile.F90 S582 0
08/28/2008  11:59:18
use esmf_fieldbundlemod private
use esmf_internarraydatamapmod private
use esmf_fieldmod private
use esmf_gridmod private
use esmf_staggerlocmod private
use esmf_calendarmod private
use esmf_distgridmod private
use esmf_routemod private
use esmf_localarraycreatemod private
use esmf_iospecmod private
use esmf_arrayspecmod private
use esmf_delayoutmod private
use esmf_logerrmod private
use esmf_utiltypesmod private
use esmf_statetypesmod private
use esmf_vmmod private
enduse
D 35 24 712 4 711 3
D 41 24 728 8 727 7
D 47 24 734 4 733 3
D 59 24 776 36 775 3
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
D 116 24 866 4 865 3
D 122 24 872 4 871 3
D 128 24 888 4 887 3
D 134 24 894 4 893 3
D 140 24 902 4 901 3
D 146 24 910 4 909 3
D 152 24 916 4 915 3
D 158 24 924 4 923 3
D 164 24 930 4 929 3
D 170 24 936 4 935 3
D 176 24 942 4 941 3
D 322 24 1173 4 1172 3
D 328 24 1181 4 1180 3
D 334 24 1189 4 1188 3
D 743 24 1613 16 1612 7
D 755 24 1619 8 1618 7
D 1454 24 3002 4 3001 3
D 1703 24 3298 4 3297 3
D 1871 24 3363 4 3362 3
D 1877 24 3371 4 3370 3
D 2079 24 3470 4 3469 3
D 2085 24 3482 4 3481 3
D 4664 24 7992 4 7991 3
D 5073 24 8376 4 8375 3
D 10839 24 16514 4 16513 3
D 11192 24 16750 4 16749 3
D 11440 24 16868 4 16867 3
D 11446 24 16878 4 16877 3
D 12395 24 18374 4 18373 3
D 12401 24 18380 4 18379 3
D 12643 24 18724 4 18723 3
D 12655 24 18735 4 18734 3
D 12661 24 18765 4 18764 3
D 13286 24 19347 4 19346 3
D 13689 24 19887 4 19886 3
D 13695 24 19897 4 19896 3
D 13701 24 19919 4 19918 3
D 13707 24 19925 4 19924 3
D 13713 24 19933 4 19932 3
D 13719 24 19939 4 19938 3
D 13754 24 19986 16 19985 7
D 14045 18 13
D 14047 18 14
D 14049 18 15
D 14051 18 16
D 14053 18 17
D 14055 18 18
D 14057 18 19
D 14059 18 20
D 14061 18 21
D 14063 18 22
D 14065 18 23
D 14241 24 20811 936 20809 7
D 14247 21 14241 1 17625 17624 0 1 0 0 1
 17619 17622 17623 17619 17622 17620
D 14250 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 14253 21 14241 1 17634 17633 0 1 0 0 1
 17628 17631 17632 17628 17631 17629
D 14256 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 14259 21 6 1 17643 17642 0 1 0 0 1
 17637 17640 17641 17637 17640 17638
D 14262 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 14265 21 6 1 17652 17651 0 1 0 0 1
 17646 17649 17650 17646 17649 17647
D 14268 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 14271 21 755 1 17661 17660 0 1 0 0 1
 17655 17658 17659 17655 17658 17656
D 14274 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 14277 21 755 1 17670 17669 0 1 0 0 1
 17664 17667 17668 17664 17667 17665
D 14280 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 14283 21 6 1 17679 17678 0 1 0 0 1
 17673 17676 17677 17673 17676 17674
D 14286 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 14289 21 6 1 17688 17687 0 1 0 0 1
 17682 17685 17686 17682 17685 17683
D 14292 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 14295 21 6 2 17703 17702 0 1 0 0 1
 17692 17695 17700 17692 17695 17693
 17696 17699 17701 17696 17699 17697
D 14298 21 6 1 0 226 0 0 0 0 0
 0 226 0 3 226 0
D 14301 21 6 2 17718 17717 0 1 0 0 1
 17707 17710 17715 17707 17710 17708
 17711 17714 17716 17711 17714 17712
D 14304 21 6 1 0 226 0 0 0 0 0
 0 226 0 3 226 0
D 14307 18 17722
D 14309 21 14241 1 17726 17732 0 1 0 0 1
 17727 17730 17731 17727 17730 17728
D 14312 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 14315 21 14241 1 17734 17740 0 1 0 0 1
 17735 17738 17739 17735 17738 17736
D 14318 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 14321 21 14241 1 17742 17748 0 1 0 0 1
 17743 17746 17747 17743 17746 17744
D 14324 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
S 582 24 0 0 0 8 1 0 4668 5 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 15 0 0 0 0 0 0 esmf_statereconcilemod
S 594 3 0 0 0 6 1 1 0 0 0 0 0 0 0 -1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 596 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 7 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 597 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 598 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 8 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 601 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 602 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 603 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 5 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 604 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 6 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 606 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 9 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 607 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 608 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 90 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 609 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 91 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 610 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 99 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 611 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 18 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 612 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 25 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 613 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 32 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 614 3 0 0 0 14045 1 1 0 0 0 0 0 0 0 4949 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 42 61 73 65
S 615 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 11 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 616 3 0 0 0 14047 1 1 0 0 0 0 0 0 0 4959 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 49 4f 53 70 65 63
S 617 3 0 0 0 14047 1 1 0 0 0 0 0 0 0 4971 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 4c 6f 67 45 72 72
S 618 3 0 0 0 14045 1 1 0 0 0 0 0 0 0 4983 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 54 69 6d 65
S 619 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 13 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 620 3 0 0 0 14049 1 1 0 0 0 0 0 0 0 4993 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 43 61 6c 65 6e 64 61 72
S 621 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 17 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 622 3 0 0 0 14051 1 1 0 0 0 0 0 0 0 5007 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 54 69 6d 65 49 6e 74 65 72 76 61 6c
S 623 3 0 0 0 14053 1 1 0 0 0 0 0 0 0 5025 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 41 6c 61 72 6d
S 624 3 0 0 0 14053 1 1 0 0 0 0 0 0 0 5036 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 43 6c 6f 63 6b
S 625 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 626 3 0 0 0 14055 1 1 0 0 0 0 0 0 0 5047 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 41 72 72 61 79 53 70 65 63
S 627 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 628 3 0 0 0 14057 1 1 0 0 0 0 0 0 0 5062 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 15 45 53 4d 46 5f 4c 6f 63 61 6c 41 72 72 61 79
S 629 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 630 3 0 0 0 14059 1 1 0 0 0 0 0 0 0 5078 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 41 72 72 61 79 42 75 6e 64 6c 65
S 631 3 0 0 0 14061 1 1 0 0 0 0 0 0 0 5095 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 7 45 53 4d 46 5f 56 4d
S 632 3 0 0 0 14049 1 1 0 0 0 0 0 0 0 5103 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 44 45 4c 61 79 6f 75 74
S 633 3 0 0 0 14047 1 1 0 0 0 0 0 0 0 5117 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 43 6f 6e 66 69 67
S 634 3 0 0 0 14053 1 1 0 0 0 0 0 0 0 5129 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 41 72 72 61 79
S 635 3 0 0 0 14049 1 1 0 0 0 0 0 0 0 5140 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 49 6e 74 65 72 6e 44 47
S 636 3 0 0 0 14055 1 1 0 0 0 0 0 0 0 5154 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 43 6f 6d 6d 54 61 62 6c 65
S 637 3 0 0 0 14057 1 1 0 0 0 0 0 0 0 5169 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 15 45 53 4d 46 5f 52 6f 75 74 65 54 61 62 6c 65
S 638 3 0 0 0 14053 1 1 0 0 0 0 0 0 0 5185 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 52 6f 75 74 65
S 639 3 0 0 0 14059 1 1 0 0 0 0 0 0 0 5196 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 52 6f 75 74 65 48 61 6e 64 6c 65
S 640 3 0 0 0 14051 1 1 0 0 0 0 0 0 0 5213 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 46 69 65 6c 64 44 61 74 61 4d 61 70
S 641 3 0 0 0 14053 1 1 0 0 0 0 0 0 0 5231 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 46 69 65 6c 64
S 642 3 0 0 0 14059 1 1 0 0 0 0 0 0 0 5242 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 46 69 65 6c 64 42 75 6e 64 6c 65
S 643 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 20 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 644 3 0 0 0 14063 1 1 0 0 0 0 0 0 0 5259 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 20 45 53 4d 46 5f 54 72 61 6e 73 66 6f 72 6d 56 61 6c 75 65 73
S 645 3 0 0 0 14047 1 1 0 0 0 0 0 0 0 5280 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 52 65 67 72 69 64
S 646 3 0 0 0 14055 1 1 0 0 0 0 0 0 0 5292 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 54 72 61 6e 73 66 6f 72 6d
S 647 3 0 0 0 14053 1 1 0 0 0 0 0 0 0 5307 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 53 74 61 74 65
S 648 3 0 0 0 14065 1 1 0 0 0 0 0 0 0 5318 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 18 45 53 4d 46 5f 47 72 69 64 43 6f 6d 70 6f 6e 65 6e 74
S 649 3 0 0 0 14051 1 1 0 0 0 0 0 0 0 5337 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 43 70 6c 43 6f 6d 70 6f 6e 65 6e 74
S 650 3 0 0 0 14055 1 1 0 0 0 0 0 0 0 5355 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 43 6f 6d 70 6f 6e 65 6e 74
S 651 3 0 0 0 14059 1 1 0 0 0 0 0 0 0 5370 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 49 6e 74 65 72 6e 41 72 72 61 79
S 652 3 0 0 0 14045 1 1 0 0 0 0 0 0 0 5387 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 4e 6f 6e 65
S 664 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 12 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 670 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 21 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 672 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 22 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 674 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 23 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 676 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 24 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 679 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 26 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 681 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 28 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 683 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 29 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 685 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 30 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 687 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 31 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 690 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 33 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 692 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 34 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 694 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 35 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 696 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 36 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 711 25 13 esmf_utiltypesmod esmf_status
R 712 5 14 esmf_utiltypesmod status
R 714 6 16 esmf_utiltypesmod esmf_status_uninit$ac
R 716 6 18 esmf_utiltypesmod esmf_status_ready$ac
R 718 6 20 esmf_utiltypesmod esmf_status_unallocated$ac
R 720 6 22 esmf_utiltypesmod esmf_status_allocated$ac
R 722 6 24 esmf_utiltypesmod esmf_status_busy$ac
R 724 6 26 esmf_utiltypesmod esmf_status_invalid$ac
R 726 6 28 esmf_utiltypesmod esmf_status_not_ready$ac
R 727 25 29 esmf_utiltypesmod esmf_pointer
R 728 5 30 esmf_utiltypesmod ptr
R 730 6 32 esmf_utiltypesmod esmf_null_pointer$ac
R 732 6 34 esmf_utiltypesmod esmf_bad_pointer$ac
R 733 25 35 esmf_utiltypesmod esmf_typekind
R 734 5 36 esmf_utiltypesmod dkind
R 736 6 38 esmf_utiltypesmod esmf_typekind_i1$ac
R 738 6 40 esmf_utiltypesmod esmf_typekind_i2$ac
R 740 6 42 esmf_utiltypesmod esmf_typekind_i4$ac
R 742 6 44 esmf_utiltypesmod esmf_typekind_i8$ac
R 744 6 46 esmf_utiltypesmod esmf_typekind_r4$ac
R 746 6 48 esmf_utiltypesmod esmf_typekind_r8$ac
R 748 6 50 esmf_utiltypesmod esmf_c8$ac
R 750 6 52 esmf_utiltypesmod esmf_c16$ac
R 752 6 54 esmf_utiltypesmod esmf_typekind_logical$ac
R 754 6 56 esmf_utiltypesmod esmf_typekind_character$ac
R 756 6 58 esmf_utiltypesmod esmf_typekind_i$ac
R 758 6 60 esmf_utiltypesmod esmf_typekind_r$ac
R 760 6 62 esmf_utiltypesmod esmf_nokind$ac
R 775 25 77 esmf_utiltypesmod esmf_objectid
R 776 5 78 esmf_utiltypesmod objectid
R 777 5 79 esmf_utiltypesmod objectname
R 779 6 81 esmf_utiltypesmod esmf_id_base$ac
R 781 6 83 esmf_utiltypesmod esmf_id_iospec$ac
R 783 6 85 esmf_utiltypesmod esmf_id_logerr$ac
R 785 6 87 esmf_utiltypesmod esmf_id_time$ac
R 787 6 89 esmf_utiltypesmod esmf_id_calendar$ac
R 789 6 91 esmf_utiltypesmod esmf_id_timeinterval$ac
R 791 6 93 esmf_utiltypesmod esmf_id_alarm$ac
R 793 6 95 esmf_utiltypesmod esmf_id_clock$ac
R 795 6 97 esmf_utiltypesmod esmf_id_arrayspec$ac
R 797 6 99 esmf_utiltypesmod esmf_id_localarray$ac
R 799 6 101 esmf_utiltypesmod esmf_id_arraybundle$ac
R 801 6 103 esmf_utiltypesmod esmf_id_vm$ac
R 803 6 105 esmf_utiltypesmod esmf_id_delayout$ac
R 805 6 107 esmf_utiltypesmod esmf_id_config$ac
R 807 6 109 esmf_utiltypesmod esmf_id_array$ac
R 809 6 111 esmf_utiltypesmod esmf_id_interndg$ac
R 811 6 113 esmf_utiltypesmod esmf_id_commtable$ac
R 813 6 115 esmf_utiltypesmod esmf_id_routetable$ac
R 815 6 117 esmf_utiltypesmod esmf_id_route$ac
R 817 6 119 esmf_utiltypesmod esmf_id_routehandle$ac
R 819 6 121 esmf_utiltypesmod esmf_id_fielddatamap$ac
R 821 6 123 esmf_utiltypesmod esmf_id_field$ac
R 823 6 125 esmf_utiltypesmod esmf_id_fieldbundle$ac
R 825 6 127 esmf_utiltypesmod esmf_id_transformvalues$ac
R 827 6 129 esmf_utiltypesmod esmf_id_regrid$ac
R 829 6 131 esmf_utiltypesmod esmf_id_transform$ac
R 831 6 133 esmf_utiltypesmod esmf_id_state$ac
R 833 6 135 esmf_utiltypesmod esmf_id_gridcomponent$ac
R 835 6 137 esmf_utiltypesmod esmf_id_cplcomponent$ac
R 837 6 139 esmf_utiltypesmod esmf_id_component$ac
R 839 6 141 esmf_utiltypesmod esmf_id_internarray$ac
R 841 6 143 esmf_utiltypesmod esmf_id_none$ac
R 865 25 167 esmf_utiltypesmod esmf_localglobalflag
R 866 5 168 esmf_utiltypesmod value
R 868 6 170 esmf_utiltypesmod esmf_local$ac
R 870 6 172 esmf_utiltypesmod esmf_global$ac
R 871 25 173 esmf_utiltypesmod esmf_domaintypeflag
R 872 5 174 esmf_utiltypesmod value
R 874 6 176 esmf_utiltypesmod esmf_domain_exclusive$ac
R 876 6 178 esmf_utiltypesmod esmf_domain_computational$ac
R 878 6 180 esmf_utiltypesmod esmf_domain_total$ac
R 880 6 182 esmf_utiltypesmod esmf_domain_allocated$ac
R 882 6 184 esmf_utiltypesmod esmf_domain_oldexclusive$ac
R 884 6 186 esmf_utiltypesmod esmf_domain_oldcomputational$ac
R 886 6 188 esmf_utiltypesmod esmf_domain_oldtotal$ac
R 887 25 189 esmf_utiltypesmod esmf_logical
R 888 5 190 esmf_utiltypesmod value
R 890 6 192 esmf_utiltypesmod esmf_true$ac
R 892 6 194 esmf_utiltypesmod esmf_false$ac
R 893 25 195 esmf_utiltypesmod esmf_reduceflag
R 894 5 196 esmf_utiltypesmod value
R 896 6 198 esmf_utiltypesmod esmf_sum$ac
R 898 6 200 esmf_utiltypesmod esmf_min$ac
R 900 6 202 esmf_utiltypesmod esmf_max$ac
R 901 25 203 esmf_utiltypesmod esmf_blockingflag
R 902 5 204 esmf_utiltypesmod value
R 904 6 206 esmf_utiltypesmod esmf_blocking$ac
R 906 6 208 esmf_utiltypesmod esmf_vasblocking$ac
R 908 6 210 esmf_utiltypesmod esmf_nonblocking$ac
R 909 25 211 esmf_utiltypesmod esmf_contextflag
R 910 5 212 esmf_utiltypesmod value
R 912 6 214 esmf_utiltypesmod esmf_child_in_new_vm$ac
R 914 6 216 esmf_utiltypesmod esmf_child_in_parent_vm$ac
R 915 25 217 esmf_utiltypesmod esmf_terminationflag
R 916 5 218 esmf_utiltypesmod value
R 918 6 220 esmf_utiltypesmod esmf_final$ac
R 920 6 222 esmf_utiltypesmod esmf_keepmpi$ac
R 922 6 224 esmf_utiltypesmod esmf_abort$ac
R 923 25 225 esmf_utiltypesmod esmf_depinflag
R 924 5 226 esmf_utiltypesmod value
R 926 6 228 esmf_utiltypesmod esmf_de_pin_pet$ac
R 928 6 230 esmf_utiltypesmod esmf_de_pin_vas$ac
R 929 25 231 esmf_utiltypesmod esmf_direction
R 930 5 232 esmf_utiltypesmod value
R 932 6 234 esmf_utiltypesmod esmf_mode_forward$ac
R 934 6 236 esmf_utiltypesmod esmf_mode_reverse$ac
R 935 25 237 esmf_utiltypesmod esmf_indexflag
R 936 5 238 esmf_utiltypesmod i_type
R 938 6 240 esmf_utiltypesmod esmf_index_delocal$ac
R 940 6 242 esmf_utiltypesmod esmf_index_global$ac
R 941 25 243 esmf_utiltypesmod esmf_regionflag
R 942 5 244 esmf_utiltypesmod i_type
R 944 6 246 esmf_utiltypesmod esmf_region_total$ac
R 946 6 248 esmf_utiltypesmod esmf_region_select$ac
R 948 6 250 esmf_utiltypesmod esmf_region_empty$ac
R 1172 25 1 esmf_logerrmod esmf_msgtype
R 1173 5 2 esmf_logerrmod mtype
R 1175 6 4 esmf_logerrmod esmf_log_info$ac
R 1177 6 6 esmf_logerrmod esmf_log_warning$ac
R 1179 6 8 esmf_logerrmod esmf_log_error$ac
R 1180 25 9 esmf_logerrmod esmf_halttype
R 1181 5 10 esmf_logerrmod htype
R 1183 6 12 esmf_logerrmod esmf_log_haltnever$ac
R 1185 6 14 esmf_logerrmod esmf_log_haltwarning$ac
R 1187 6 16 esmf_logerrmod esmf_log_halterror$ac
R 1188 25 17 esmf_logerrmod esmf_logtype
R 1189 5 18 esmf_logerrmod ftype
R 1191 6 20 esmf_logerrmod esmf_log_single$ac
R 1193 6 22 esmf_logerrmod esmf_log_multi$ac
R 1195 6 24 esmf_logerrmod esmf_log_none$ac
S 1443 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 64 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 1612 25 4 esmf_vmmod esmf_vm
R 1613 5 5 esmf_vmmod this
R 1614 5 6 esmf_vmmod isinit
R 1618 25 10 esmf_vmmod esmf_vmid
R 1619 5 11 esmf_vmmod this
R 3001 25 4 esmf_delayoutmod esmf_delayoutservicereply
R 3002 5 5 esmf_delayoutmod value
R 3004 6 7 esmf_delayoutmod esmf_delayout_service_accept$ac
R 3006 6 9 esmf_delayoutmod esmf_delayout_service_deny$ac
R 3297 25 1 esmf_arrayspecmod esmf_arrayspecstatus
R 3298 5 2 esmf_arrayspecmod status
R 3300 6 4 esmf_arrayspecmod esmf_arrayspec_status_unknown$ac
R 3302 6 6 esmf_arrayspecmod esmf_arrayspec_status_notset$ac
R 3304 6 8 esmf_arrayspecmod esmf_arrayspec_status_set$ac
R 3362 25 1 esmf_iospecmod esmf_iofileformat
R 3363 5 2 esmf_iospecmod iofileformat
R 3365 6 4 esmf_iospecmod esmf_io_fileformat_unspecified$ac
R 3367 6 6 esmf_iospecmod esmf_io_fileformat_netcdf$ac
R 3369 6 8 esmf_iospecmod esmf_io_fileformat_hdf$ac
R 3370 25 9 esmf_iospecmod esmf_iorwtype
R 3371 5 10 esmf_iospecmod iorwtype
R 3373 6 12 esmf_iospecmod esmf_io_rwtype_unspecified$ac
R 3375 6 14 esmf_iospecmod esmf_io_rwtype_readonly$ac
R 3377 6 16 esmf_iospecmod esmf_io_rwtype_writeonly$ac
R 3379 6 18 esmf_iospecmod esmf_io_rwtype_readwrite$ac
R 3381 6 20 esmf_iospecmod esmf_io_rwtype_append$ac
R 3383 6 22 esmf_iospecmod esmf_io_rwtype_truncate$ac
S 3455 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 19 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 3469 25 1 esmf_localarraycreatemod esmf_copyflag
R 3470 5 2 esmf_localarraycreatemod docopy
R 3472 6 4 esmf_localarraycreatemod esmf_data_copy$ac
R 3474 6 6 esmf_localarraycreatemod esmf_data_ref$ac
R 3476 6 8 esmf_localarraycreatemod esmf_data_defer$ac
R 3478 6 10 esmf_localarraycreatemod esmf_data_space$ac
R 3480 6 12 esmf_localarraycreatemod esmf_data_none$ac
R 3481 25 13 esmf_localarraycreatemod esmf_localarrayorigin
R 3482 5 14 esmf_localarraycreatemod origin
R 3484 6 16 esmf_localarraycreatemod esmf_from_fortran$ac
R 3486 6 18 esmf_localarraycreatemod esmf_from_cplusplus$ac
S 7986 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 69 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 7991 25 4 esmf_routemod esmf_routeoptions
R 7992 5 5 esmf_routemod option
R 7994 6 7 esmf_routemod esmf_route_option_async$ac
R 7996 6 9 esmf_routemod esmf_route_option_sync$ac
R 7998 6 11 esmf_routemod esmf_route_option_pack_pet$ac
R 8000 6 13 esmf_routemod esmf_route_option_pack_xp$ac
R 8002 6 15 esmf_routemod esmf_route_option_pack_nopack$ac
R 8004 6 17 esmf_routemod esmf_route_option_pack_vector$ac
R 8006 6 19 esmf_routemod esmf_route_option_pack_buffer$ac
R 8008 6 21 esmf_routemod esmf_route_option_default$ac
R 8375 25 4 esmf_distgridmod esmf_decompflag
R 8376 5 5 esmf_distgridmod value
R 8378 6 7 esmf_distgridmod esmf_decomp_default$ac
R 8380 6 9 esmf_distgridmod esmf_decomp_homogen$ac
R 8382 6 11 esmf_distgridmod esmf_decomp_restfirst$ac
R 8384 6 13 esmf_distgridmod esmf_decomp_restlast$ac
R 8386 6 15 esmf_distgridmod esmf_decomp_cyclic$ac
R 16513 25 2 esmf_calendarmod esmf_calendartype
R 16514 5 3 esmf_calendarmod calendartype
R 16516 6 5 esmf_calendarmod esmf_cal_gregorian$ac
R 16518 6 7 esmf_calendarmod esmf_cal_julian$ac
R 16520 6 9 esmf_calendarmod esmf_cal_julianday$ac
R 16522 6 11 esmf_calendarmod esmf_cal_noleap$ac
R 16524 6 13 esmf_calendarmod esmf_cal_360day$ac
R 16526 6 15 esmf_calendarmod esmf_cal_custom$ac
R 16528 6 17 esmf_calendarmod esmf_cal_nocalendar$ac
S 16747 3 0 0 0 6 1 1 0 0 0 0 0 0 0 -1 -2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 16749 25 1 esmf_staggerlocmod esmf_staggerloc
R 16750 5 2 esmf_staggerlocmod staggerloc
R 16758 6 10 esmf_staggerlocmod esmf_staggerloc_invalid$ac
R 16760 6 12 esmf_staggerlocmod esmf_staggerloc_uninit$ac
R 16762 6 14 esmf_staggerlocmod esmf_staggerloc_center$ac
R 16764 6 16 esmf_staggerlocmod esmf_staggerloc_edge1$ac
R 16766 6 18 esmf_staggerlocmod esmf_staggerloc_edge2$ac
R 16768 6 20 esmf_staggerlocmod esmf_staggerloc_corner$ac
R 16770 6 22 esmf_staggerlocmod esmf_staggerloc_center_vcenter$ac
R 16772 6 24 esmf_staggerlocmod esmf_staggerloc_edge1_vcenter$ac
R 16774 6 26 esmf_staggerlocmod esmf_staggerloc_edge2_vcenter$ac
R 16776 6 28 esmf_staggerlocmod esmf_staggerloc_corner_vcenter$ac
R 16778 6 30 esmf_staggerlocmod esmf_staggerloc_center_vface$ac
R 16780 6 32 esmf_staggerlocmod esmf_staggerloc_edge1_vface$ac
R 16782 6 34 esmf_staggerlocmod esmf_staggerloc_edge2_vface$ac
R 16784 6 36 esmf_staggerlocmod esmf_staggerloc_corner_vface$ac
R 16867 25 4 esmf_gridmod esmf_gridstatus
R 16868 5 5 esmf_gridmod gridstatus
R 16870 6 7 esmf_gridmod esmf_gridstatus_invalid$ac
R 16872 6 9 esmf_gridmod esmf_gridstatus_uninit$ac
R 16874 6 11 esmf_gridmod esmf_gridstatus_not_ready$ac
R 16876 6 13 esmf_gridmod esmf_gridstatus_shape_ready$ac
R 16877 25 14 esmf_gridmod esmf_gridconn
R 16878 5 15 esmf_gridmod gridconn
R 16880 6 17 esmf_gridmod esmf_gridconn_none$ac
R 16882 6 19 esmf_gridmod esmf_gridconn_periodic$ac
R 16884 6 21 esmf_gridmod esmf_gridconn_pole$ac
R 16886 6 23 esmf_gridmod esmf_gridconn_bipole$ac
R 18373 25 1 esmf_fieldmod esmf_access
R 18374 5 2 esmf_fieldmod a_type
R 18376 6 4 esmf_fieldmod esmf_readwrite$ac
R 18378 6 6 esmf_fieldmod esmf_readonly$ac
R 18379 25 7 esmf_fieldmod esmf_allocflag
R 18380 5 8 esmf_fieldmod a_type
R 18382 6 10 esmf_fieldmod esmf_alloc$ac
R 18384 6 12 esmf_fieldmod esmf_no_alloc$ac
R 18723 25 1 esmf_internarraydatamapmod esmf_interleaveflag
R 18724 5 2 esmf_internarraydatamapmod il
R 18726 6 4 esmf_internarraydatamapmod esmf_interleave_by_block$ac
R 18728 6 6 esmf_internarraydatamapmod esmf_interleave_by_item$ac
R 18734 25 12 esmf_internarraydatamapmod esmf_relloc
R 18735 5 13 esmf_internarraydatamapmod relloc
R 18737 6 15 esmf_internarraydatamapmod esmf_cell_undefined$ac
R 18739 6 17 esmf_internarraydatamapmod esmf_cell_center$ac
R 18741 6 19 esmf_internarraydatamapmod esmf_cell_nface$ac
R 18743 6 21 esmf_internarraydatamapmod esmf_cell_sface$ac
R 18745 6 23 esmf_internarraydatamapmod esmf_cell_eface$ac
R 18747 6 25 esmf_internarraydatamapmod esmf_cell_wface$ac
R 18749 6 27 esmf_internarraydatamapmod esmf_cell_necorner$ac
R 18751 6 29 esmf_internarraydatamapmod esmf_cell_nwcorner$ac
R 18753 6 31 esmf_internarraydatamapmod esmf_cell_secorner$ac
R 18755 6 33 esmf_internarraydatamapmod esmf_cell_swcorner$ac
R 18757 6 35 esmf_internarraydatamapmod esmf_cell_topface$ac
R 18759 6 37 esmf_internarraydatamapmod esmf_cell_botface$ac
R 18761 6 39 esmf_internarraydatamapmod esmf_cell_cell$ac
R 18763 6 41 esmf_internarraydatamapmod esmf_cell_vertex$ac
R 18764 25 42 esmf_internarraydatamapmod esmf_indexorder
R 18765 5 43 esmf_internarraydatamapmod iorder
R 18767 6 45 esmf_internarraydatamapmod esmf_index_i$ac
R 18769 6 47 esmf_internarraydatamapmod esmf_index_ij$ac
R 18771 6 49 esmf_internarraydatamapmod esmf_index_ji$ac
R 18773 6 51 esmf_internarraydatamapmod esmf_index_ijk$ac
R 18775 6 53 esmf_internarraydatamapmod esmf_index_jik$ac
R 18777 6 55 esmf_internarraydatamapmod esmf_index_kji$ac
R 18779 6 57 esmf_internarraydatamapmod esmf_index_ikj$ac
R 18781 6 59 esmf_internarraydatamapmod esmf_index_jki$ac
R 18783 6 61 esmf_internarraydatamapmod esmf_index_kij$ac
R 19346 25 1 esmf_fieldbundlemod esmf_packflag
R 19347 5 2 esmf_fieldbundlemod packflag
R 19349 6 4 esmf_fieldbundlemod esmf_packed_data$ac
R 19351 6 6 esmf_fieldbundlemod esmf_no_packed_data$ac
S 19875 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 101 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 19876 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 102 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 19877 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 103 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 19878 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 104 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 19879 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 105 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 19880 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 106 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 19881 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 107 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 19882 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 108 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 19883 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 109 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 19884 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 110 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 19886 25 1 esmf_statetypesmod esmf_statetype
R 19887 5 2 esmf_statetypesmod state
R 19889 6 4 esmf_statetypesmod esmf_state_import$ac
R 19891 6 6 esmf_statetypesmod esmf_state_export$ac
R 19893 6 8 esmf_statetypesmod esmf_state_unspecified$ac
R 19895 6 10 esmf_statetypesmod esmf_state_invalid$ac
R 19896 25 11 esmf_statetypesmod esmf_stateitemtype
R 19897 5 12 esmf_statetypesmod ot
R 19899 6 14 esmf_statetypesmod esmf_stateitem_field$ac
R 19901 6 16 esmf_statetypesmod esmf_stateitem_fieldbundle$ac
R 19903 6 18 esmf_statetypesmod esmf_stateitem_array$ac
R 19905 6 20 esmf_statetypesmod esmf_stateitem_arraybundle$ac
R 19907 6 22 esmf_statetypesmod esmf_stateitem_routehandle$ac
R 19909 6 24 esmf_statetypesmod esmf_stateitem_state$ac
R 19911 6 26 esmf_statetypesmod esmf_stateitem_name$ac
R 19913 6 28 esmf_statetypesmod esmf_stateitem_indirect$ac
R 19915 6 30 esmf_statetypesmod esmf_stateitem_unknown$ac
R 19917 6 32 esmf_statetypesmod esmf_stateitem_notfound$ac
R 19918 25 33 esmf_statetypesmod esmf_neededflag
R 19919 5 34 esmf_statetypesmod needed
R 19921 6 36 esmf_statetypesmod esmf_needed$ac
R 19923 6 38 esmf_statetypesmod esmf_notneeded$ac
R 19924 25 39 esmf_statetypesmod esmf_readyflag
R 19925 5 40 esmf_statetypesmod ready
R 19927 6 42 esmf_statetypesmod esmf_readytowrite$ac
R 19929 6 44 esmf_statetypesmod esmf_readytoread$ac
R 19931 6 46 esmf_statetypesmod esmf_notready$ac
R 19932 25 47 esmf_statetypesmod esmf_reqforrestartflag
R 19933 5 48 esmf_statetypesmod required4restart
R 19935 6 50 esmf_statetypesmod esmf_required_for_restart$ac
R 19937 6 52 esmf_statetypesmod esmf_notrequired_for_restart$ac
R 19938 25 53 esmf_statetypesmod esmf_validflag
R 19939 5 54 esmf_statetypesmod valid
R 19941 6 56 esmf_statetypesmod esmf_valid$ac
R 19943 6 58 esmf_statetypesmod esmf_invalid$ac
R 19945 6 60 esmf_statetypesmod esmf_validityunknown$ac
R 19985 25 100 esmf_statetypesmod esmf_state
R 19986 5 101 esmf_statetypesmod statep
R 19988 5 103 esmf_statetypesmod statep$p
R 19990 5 105 esmf_statetypesmod isinit
S 20807 6 4 0 0 6 1 582 89631 80001c 0 0 0 0 0 0 0 0 0 20881 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 bufsize
S 20809 25 0 0 0 14241 1 582 89639 800014 800004 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_stateiteminfo
S 20810 6 4 0 0 6 20816 582 88609 40800016 0 0 0 0 0 0 0 0 0 20882 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_0_6
S 20811 5 6 0 0 14247 20813 582 89658 10a00014 14 0 0 20813 0 14241 0 20815 0 0 0 0 0 0 0 0 20812 1 20811 20814 582 0 0 0 0 childlist
S 20812 5 0 0 0 14250 20817 582 89668 40822004 1020 0 16 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20814 20812 0 582 0 0 0 0 childlist$sd
S 20813 5 0 0 0 7 20814 582 89681 40802001 1020 0 0 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20811 20813 0 582 0 0 0 0 childlist$p
S 20814 5 0 0 0 7 20812 582 89693 40802000 1020 0 8 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20813 20814 0 582 0 0 0 0 childlist$o
S 20815 22 0 0 0 8 1 582 89705 40000000 1000 0 0 0 20811 0 0 0 0 20812 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 childlist$arrdsc
S 20816 6 4 0 0 6 20824 582 89722 40800016 0 0 4 0 0 0 0 0 0 20882 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_1_4
S 20817 5 6 0 0 14253 20819 582 89730 10a00014 14 0 88 20819 0 14241 0 20821 0 0 0 0 0 0 0 0 20818 20811 20817 20820 582 0 0 0 0 attrlist
S 20818 5 0 0 0 14256 20822 582 89739 40822004 1020 0 104 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20820 20818 0 582 0 0 0 0 attrlist$sd
S 20819 5 0 0 0 7 20820 582 89751 40802001 1020 0 88 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20817 20819 0 582 0 0 0 0 attrlist$p
S 20820 5 0 0 0 7 20818 582 89762 40802000 1020 0 96 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20819 20820 0 582 0 0 0 0 attrlist$o
S 20821 22 0 0 0 8 1 582 89773 40000000 1000 0 0 0 20817 0 0 0 0 20818 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 attrlist$arrdsc
S 20822 5 0 0 0 6 20823 582 89789 800014 0 0 176 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20817 20822 0 582 0 0 0 0 mycount
S 20823 5 0 0 0 6 20825 582 89797 800014 0 0 180 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20822 20823 0 582 0 0 0 0 theircount
S 20824 6 4 0 0 6 20831 582 43818 40800016 0 0 8 0 0 0 0 0 0 20882 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_2_3
S 20825 5 6 0 0 14259 20827 582 89808 10a00014 14 0 184 20827 0 14241 0 20829 0 0 0 0 0 0 0 0 20826 20823 20825 20828 582 0 0 0 0 idsend
S 20826 5 0 0 0 14262 20830 582 89815 40822004 1020 0 200 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20828 20826 0 582 0 0 0 0 idsend$sd
S 20827 5 0 0 0 7 20828 582 89825 40802001 1020 0 184 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20825 20827 0 582 0 0 0 0 idsend$p
S 20828 5 0 0 0 7 20826 582 89834 40802000 1020 0 192 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20827 20828 0 582 0 0 0 0 idsend$o
S 20829 22 0 0 0 6 1 582 89843 40000000 1000 0 0 0 20825 0 0 0 0 20826 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 idsend$arrdsc
S 20830 5 6 0 0 14265 20833 582 89857 10a00014 14 0 272 20833 0 14241 0 20835 0 0 0 0 0 0 0 0 20832 20825 20830 20834 582 0 0 0 0 idrecv
S 20831 6 4 0 0 6 20836 582 43826 40800016 0 0 12 0 0 0 0 0 0 20882 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_3_2
S 20832 5 0 0 0 14268 20837 582 89864 40822004 1020 0 288 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20834 20832 0 582 0 0 0 0 idrecv$sd
S 20833 5 0 0 0 7 20834 582 89874 40802001 1020 0 272 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20830 20833 0 582 0 0 0 0 idrecv$p
S 20834 5 0 0 0 7 20832 582 89883 40802000 1020 0 280 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20833 20834 0 582 0 0 0 0 idrecv$o
S 20835 22 0 0 0 6 1 582 89892 40000000 1000 0 0 0 20830 0 0 0 0 20832 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 idrecv$arrdsc
S 20836 6 4 0 0 6 20843 582 43843 40800016 0 0 16 0 0 0 0 0 0 20882 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_4_2
S 20837 5 6 0 0 14271 20839 582 89906 10a00014 14 0 360 20839 0 14241 0 20841 0 0 0 0 0 0 0 0 20838 20830 20837 20840 582 0 0 0 0 vmidsend
S 20838 5 0 0 0 14274 20842 582 89915 40822004 1020 0 376 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20840 20838 0 582 0 0 0 0 vmidsend$sd
S 20839 5 0 0 0 7 20840 582 89927 40802001 1020 0 360 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20837 20839 0 582 0 0 0 0 vmidsend$p
S 20840 5 0 0 0 7 20838 582 89938 40802000 1020 0 368 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20839 20840 0 582 0 0 0 0 vmidsend$o
S 20841 22 0 0 0 8 1 582 89949 40000000 1000 0 0 0 20837 0 0 0 0 20838 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 vmidsend$arrdsc
S 20842 5 6 0 0 14277 20845 582 89965 10a00014 14 0 448 20845 0 14241 0 20847 0 0 0 0 0 0 0 0 20844 20837 20842 20846 582 0 0 0 0 vmidrecv
S 20843 6 4 0 0 6 20848 582 48541 40800016 0 0 20 0 0 0 0 0 0 20882 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_5_2
S 20844 5 0 0 0 14280 20849 582 89974 40822004 1020 0 464 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20846 20844 0 582 0 0 0 0 vmidrecv$sd
S 20845 5 0 0 0 7 20846 582 89986 40802001 1020 0 448 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20842 20845 0 582 0 0 0 0 vmidrecv$p
S 20846 5 0 0 0 7 20844 582 89997 40802000 1020 0 456 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20845 20846 0 582 0 0 0 0 vmidrecv$o
S 20847 22 0 0 0 8 1 582 90008 40000000 1000 0 0 0 20842 0 0 0 0 20844 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 vmidrecv$arrdsc
S 20848 6 4 0 0 6 20855 582 43851 40800016 0 0 24 0 0 0 0 0 0 20882 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_6_2
S 20849 5 6 0 0 14283 20851 582 90024 10a00014 14 0 536 20851 0 14241 0 20853 0 0 0 0 0 0 0 0 20850 20842 20849 20852 582 0 0 0 0 objsend
S 20850 5 0 0 0 14286 20854 582 90032 40822004 1020 0 552 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20852 20850 0 582 0 0 0 0 objsend$sd
S 20851 5 0 0 0 7 20852 582 90043 40802001 1020 0 536 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20849 20851 0 582 0 0 0 0 objsend$p
S 20852 5 0 0 0 7 20850 582 90053 40802000 1020 0 544 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20851 20852 0 582 0 0 0 0 objsend$o
S 20853 22 0 0 0 8 1 582 90063 40000000 1000 0 0 0 20849 0 0 0 0 20850 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 objsend$arrdsc
S 20854 5 6 0 0 14289 20857 582 90078 10a00014 14 0 624 20857 0 14241 0 20859 0 0 0 0 0 0 0 0 20856 20849 20854 20858 582 0 0 0 0 objrecv
S 20855 6 4 0 0 6 20860 582 43288 40800016 0 0 28 0 0 0 0 0 0 20882 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_7_2
S 20856 5 0 0 0 14292 20862 582 90086 40822004 1020 0 640 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20858 20856 0 582 0 0 0 0 objrecv$sd
S 20857 5 0 0 0 7 20858 582 90097 40802001 1020 0 624 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20854 20857 0 582 0 0 0 0 objrecv$p
S 20858 5 0 0 0 7 20856 582 90107 40802000 1020 0 632 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20857 20858 0 582 0 0 0 0 objrecv$o
S 20859 22 0 0 0 8 1 582 90117 40000000 1000 0 0 0 20854 0 0 0 0 20856 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 objrecv$arrdsc
S 20860 6 4 0 0 6 20861 582 48399 40800016 0 0 32 0 0 0 0 0 0 20882 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_8_2
S 20861 6 4 0 0 6 20868 582 43296 40800016 0 0 36 0 0 0 0 0 0 20882 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_9_2
S 20862 5 6 0 0 14295 20864 582 90132 10a00014 14 0 712 20864 0 14241 0 20866 0 0 0 0 0 0 0 0 20863 20854 20862 20865 582 0 0 0 0 blindsend
S 20863 5 0 0 0 14298 20867 582 90142 40822004 1020 0 728 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20865 20863 0 582 0 0 0 0 blindsend$sd
S 20864 5 0 0 0 7 20865 582 90155 40802001 1020 0 712 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20862 20864 0 582 0 0 0 0 blindsend$p
S 20865 5 0 0 0 7 20863 582 90167 40802000 1020 0 720 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20864 20865 0 582 0 0 0 0 blindsend$o
S 20866 22 0 0 0 8 1 582 90179 40000000 1000 0 0 0 20862 0 0 0 0 20863 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 blindsend$arrdsc
S 20867 5 6 0 0 14301 20871 582 90196 10a00014 14 0 824 20871 0 14241 0 20873 0 0 0 0 0 0 0 0 20870 20862 20867 20872 582 0 0 0 0 blindrecv
S 20868 6 4 0 0 6 20869 582 43304 40800016 0 0 40 0 0 0 0 0 0 20882 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_10_2
S 20869 6 4 0 0 6 1 582 43322 40800016 0 0 44 0 0 0 0 0 0 20882 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_11_2
S 20870 5 0 0 0 14304 1 582 90206 40822004 1020 0 840 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20872 20870 0 582 0 0 0 0 blindrecv$sd
S 20871 5 0 0 0 7 20872 582 90219 40802001 1020 0 824 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20867 20871 0 582 0 0 0 0 blindrecv$p
S 20872 5 0 0 0 7 20870 582 90231 40802000 1020 0 832 0 0 14241 0 0 0 0 0 0 0 0 0 0 0 20871 20872 0 582 0 0 0 0 blindrecv$o
S 20873 22 0 0 0 8 1 582 90243 40000000 1000 0 0 0 20867 0 0 0 0 20870 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 blindrecv$arrdsc
S 20874 16 0 0 0 6 1 582 90260 14 400000 0 0 0 0 1 3 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_bt_newobj
S 20875 16 0 0 0 6 1 582 90275 14 400000 0 0 0 0 2 45 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_bt_dupobj
S 20876 16 0 0 0 6 1 582 90290 14 400000 0 0 0 0 3 32 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_bt_endmarker
S 20877 27 0 0 0 8 20883 582 90308 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_statereconcile
S 20878 3 0 0 0 6 0 1 0 0 0 0 0 0 0 0 73 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 20879 3 0 0 0 14307 0 1 0 0 0 0 0 0 0 90328 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 73 24 49 64 3a 20 45 53 4d 46 5f 53 74 61 74 65 52 65 63 6f 6e 63 69 6c 65 2e 46 39 30 2c 76 20 31 2e 34 32 2e 32 2e 35 20 32 30 30 38 2f 30 35 2f 30 36 20 30 34 3a 33 31 3a 34 30 20 63 64 65 6c 75 63 61 20 45 78 70 20 24
S 20880 16 0 0 0 14307 1 582 13170 14 440000 0 0 0 0 20879 17723 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 version
S 20881 11 0 0 0 8 20014 582 90402 40800010 801000 0 4 0 0 20807 20807 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_statereconcilemod$12
S 20882 11 0 0 0 8 20881 582 90428 40800010 801000 0 48 0 0 20810 20869 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_statereconcilemod$4
S 20883 23 5 0 0 0 20888 582 90308 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_statereconcile
S 20884 1 3 1 0 743 1 20883 15526 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 vm
S 20885 1 3 1 0 28 1 20883 13370 80000014 43000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 options
S 20886 1 3 2 0 6 1 20883 11027 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 20887 1 3 0 0 13754 1 20883 85082 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 state
S 20888 14 5 0 0 0 1 20883 90308 0 400000 0 0 0 7262 4 0 0 0 0 0 0 0 0 0 0 0 0 139 0 582 0 0 0 0 esmf_statereconcile
F 20888 4 20887 20884 20885 20886
S 20889 23 5 0 0 0 20894 582 90453 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_stateinfobuild
S 20890 7 3 0 0 14309 1 20889 90473 10800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 20895 0 0 0 0 0 0 0 0 stateinfolist
S 20891 1 3 1 0 743 1 20889 15526 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 vm
S 20892 1 3 2 0 6 1 20889 11027 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 20893 1 3 1 0 13754 1 20889 85082 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 state
S 20894 14 5 0 0 0 1 20889 90453 10 400000 0 0 0 7267 4 0 0 0 0 0 0 0 0 0 0 0 0 232 0 582 0 0 0 0 esmf_stateinfobuild
F 20894 4 20893 20890 20891 20892
S 20895 8 1 0 0 14312 1 20889 90487 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 stateinfolist$sd
S 20899 23 5 0 0 0 20902 582 90557 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_stateinfodrop
S 20900 7 3 0 0 14315 1 20899 90473 10800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 20903 0 0 0 0 0 0 0 0 stateinfolist
S 20901 1 3 2 0 6 1 20899 11027 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 20902 14 5 0 0 0 1 20899 90557 10 400000 0 0 0 7272 2 0 0 0 0 0 0 0 0 0 0 0 0 430 0 582 0 0 0 0 esmf_stateinfodrop
F 20902 2 20900 20901
S 20903 8 1 0 0 14318 1 20899 90576 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 stateinfolist$sd1
S 20907 23 5 0 0 0 20912 582 90650 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_stateproxycreate
S 20908 7 3 0 0 14321 1 20907 90473 10800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 20913 0 0 0 0 0 0 0 0 stateinfolist
S 20909 1 3 1 0 743 1 20907 15526 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 vm
S 20910 1 3 2 0 6 1 20907 11027 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 20911 1 3 0 0 13754 1 20907 85082 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 state
S 20912 14 5 0 0 0 1 20907 90650 10 400000 0 0 0 7275 4 0 0 0 0 0 0 0 0 0 0 0 0 510 0 582 0 0 0 0 esmf_stateproxycreate
F 20912 4 20911 20908 20909 20910
S 20913 8 1 0 0 14324 1 20907 90672 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 stateinfolist$sd5
A 13 2 0 0 0 6 606 0 0 0 13 0 0 0 0 0 0 0 0 0
A 14 2 0 0 0 6 615 0 0 0 14 0 0 0 0 0 0 0 0 0
A 15 2 0 0 0 6 619 0 0 0 15 0 0 0 0 0 0 0 0 0
A 16 2 0 0 0 6 621 0 0 0 16 0 0 0 0 0 0 0 0 0
A 17 2 0 0 0 6 607 0 0 0 17 0 0 0 0 0 0 0 0 0
A 18 2 0 0 0 6 625 0 0 0 18 0 0 0 0 0 0 0 0 0
A 19 2 0 0 0 6 627 0 0 0 19 0 0 0 0 0 0 0 0 0
A 20 2 0 0 0 6 629 0 0 0 20 0 0 0 0 0 0 0 0 0
A 21 2 0 0 0 6 596 0 0 0 21 0 0 0 0 0 0 0 0 0
A 22 2 0 0 0 6 643 0 0 0 22 0 0 0 0 0 0 0 0 0
A 23 2 0 0 0 6 611 0 0 0 23 0 0 0 0 0 0 0 0 0
A 24 2 0 0 0 6 613 0 0 0 24 0 0 0 0 0 0 0 0 0
A 27 2 0 0 0 6 594 0 0 0 27 0 0 0 0 0 0 0 0 0
A 32 2 0 0 0 6 597 0 0 0 32 0 0 0 0 0 0 0 0 0
A 45 2 0 0 0 6 601 0 0 0 45 0 0 0 0 0 0 0 0 0
A 52 2 0 0 0 6 602 0 0 0 52 0 0 0 0 0 0 0 0 0
A 56 2 0 0 0 6 603 0 0 0 56 0 0 0 0 0 0 0 0 0
A 60 2 0 0 0 6 604 0 0 0 60 0 0 0 0 0 0 0 0 0
A 95 2 0 0 0 6 598 0 0 0 95 0 0 0 0 0 0 0 0 0
A 105 2 0 0 0 6 608 0 0 0 105 0 0 0 0 0 0 0 0 0
A 109 2 0 0 0 6 609 0 0 0 109 0 0 0 0 0 0 0 0 0
A 113 2 0 0 0 6 610 0 0 0 113 0 0 0 0 0 0 0 0 0
A 182 2 0 0 0 6 664 0 0 0 182 0 0 0 0 0 0 0 0 0
A 208 2 0 0 0 6 670 0 0 0 208 0 0 0 0 0 0 0 0 0
A 214 2 0 0 0 6 672 0 0 0 214 0 0 0 0 0 0 0 0 0
A 220 2 0 0 0 6 674 0 0 0 220 0 0 0 0 0 0 0 0 0
A 226 2 0 0 0 6 676 0 0 0 226 0 0 0 0 0 0 0 0 0
A 232 2 0 0 193 6 612 0 0 0 232 0 0 0 0 0 0 0 0 0
A 238 2 0 0 0 6 679 0 0 0 238 0 0 0 0 0 0 0 0 0
A 244 2 0 0 0 6 681 0 0 0 244 0 0 0 0 0 0 0 0 0
A 250 2 0 0 0 6 683 0 0 0 250 0 0 0 0 0 0 0 0 0
A 256 2 0 0 0 6 685 0 0 0 256 0 0 0 0 0 0 0 0 0
A 262 2 0 0 0 6 687 0 0 0 262 0 0 0 0 0 0 0 0 0
A 273 2 0 0 0 6 690 0 0 0 273 0 0 0 0 0 0 0 0 0
A 279 2 0 0 0 6 692 0 0 0 279 0 0 0 0 0 0 0 0 0
A 285 2 0 0 0 6 694 0 0 0 285 0 0 0 0 0 0 0 0 0
A 291 2 0 0 0 6 696 0 0 0 291 0 0 0 0 0 0 0 0 0
A 404 1 0 0 319 35 714 0 0 0 0 0 0 0 0 0 0 0 0 0
A 407 1 0 0 322 35 716 0 0 0 0 0 0 0 0 0 0 0 0 0
A 410 1 0 0 325 35 718 0 0 0 0 0 0 0 0 0 0 0 0 0
A 413 1 0 0 272 35 720 0 0 0 0 0 0 0 0 0 0 0 0 0
A 416 1 0 0 278 35 722 0 0 0 0 0 0 0 0 0 0 0 0 0
A 419 1 0 0 284 35 724 0 0 0 0 0 0 0 0 0 0 0 0 0
A 422 1 0 0 290 35 726 0 0 0 0 0 0 0 0 0 0 0 0 0
A 425 1 0 0 0 41 730 0 0 0 0 0 0 0 0 0 0 0 0 0
A 428 1 0 0 0 41 732 0 0 0 0 0 0 0 0 0 0 0 0 0
A 431 1 0 0 0 47 736 0 0 0 0 0 0 0 0 0 0 0 0 0
A 434 1 0 0 0 47 738 0 0 0 0 0 0 0 0 0 0 0 0 0
A 437 1 0 0 0 47 740 0 0 0 0 0 0 0 0 0 0 0 0 0
A 440 1 0 0 0 47 742 0 0 0 0 0 0 0 0 0 0 0 0 0
A 443 1 0 0 0 47 744 0 0 0 0 0 0 0 0 0 0 0 0 0
A 446 1 0 0 0 47 746 0 0 0 0 0 0 0 0 0 0 0 0 0
A 449 1 0 0 0 47 748 0 0 0 0 0 0 0 0 0 0 0 0 0
A 452 1 0 0 0 47 750 0 0 0 0 0 0 0 0 0 0 0 0 0
A 455 1 0 0 0 47 752 0 0 0 0 0 0 0 0 0 0 0 0 0
A 458 1 0 0 0 47 754 0 0 0 0 0 0 0 0 0 0 0 0 0
A 461 1 0 0 0 47 756 0 0 0 0 0 0 0 0 0 0 0 0 0
A 464 1 0 0 0 47 758 0 0 0 0 0 0 0 0 0 0 0 0 0
A 467 1 0 0 0 47 760 0 0 0 0 0 0 0 0 0 0 0 0 0
A 468 2 0 0 0 67 614 0 0 0 468 0 0 0 0 0 0 0 0 0
A 472 1 0 0 0 59 779 0 0 0 0 0 0 0 0 0 0 0 0 0
A 473 2 0 0 0 69 616 0 0 0 473 0 0 0 0 0 0 0 0 0
A 477 1 0 0 0 59 781 0 0 0 0 0 0 0 0 0 0 0 0 0
A 478 2 0 0 0 69 617 0 0 0 478 0 0 0 0 0 0 0 0 0
A 482 1 0 0 0 59 783 0 0 0 0 0 0 0 0 0 0 0 0 0
A 483 2 0 0 0 67 618 0 0 0 483 0 0 0 0 0 0 0 0 0
A 487 1 0 0 0 59 785 0 0 0 0 0 0 0 0 0 0 0 0 0
A 488 2 0 0 0 71 620 0 0 0 488 0 0 0 0 0 0 0 0 0
A 492 1 0 0 401 59 787 0 0 0 0 0 0 0 0 0 0 0 0 0
A 493 2 0 0 0 73 622 0 0 0 493 0 0 0 0 0 0 0 0 0
A 497 1 0 0 0 59 789 0 0 0 0 0 0 0 0 0 0 0 0 0
A 498 2 0 0 0 75 623 0 0 0 498 0 0 0 0 0 0 0 0 0
A 502 1 0 0 0 59 791 0 0 0 0 0 0 0 0 0 0 0 0 0
A 503 2 0 0 2 75 624 0 0 0 503 0 0 0 0 0 0 0 0 0
A 507 1 0 0 0 59 793 0 0 0 0 0 0 0 0 0 0 0 0 0
A 508 2 0 0 3 77 626 0 0 0 508 0 0 0 0 0 0 0 0 0
A 512 1 0 0 0 59 795 0 0 0 0 0 0 0 0 0 0 0 0 0
A 513 2 0 0 0 79 628 0 0 0 513 0 0 0 0 0 0 0 0 0
A 517 1 0 0 0 59 797 0 0 0 0 0 0 0 0 0 0 0 0 0
A 518 2 0 0 262 81 630 0 0 0 518 0 0 0 0 0 0 0 0 0
A 522 1 0 0 0 59 799 0 0 0 0 0 0 0 0 0 0 0 0 0
A 523 2 0 0 0 83 631 0 0 0 523 0 0 0 0 0 0 0 0 0
A 527 1 0 0 0 59 801 0 0 0 0 0 0 0 0 0 0 0 0 0
A 528 2 0 0 352 71 632 0 0 0 528 0 0 0 0 0 0 0 0 0
A 532 1 0 0 0 59 803 0 0 0 0 0 0 0 0 0 0 0 0 0
A 533 2 0 0 0 69 633 0 0 0 533 0 0 0 0 0 0 0 0 0
A 537 1 0 0 394 59 805 0 0 0 0 0 0 0 0 0 0 0 0 0
A 538 2 0 0 355 75 634 0 0 0 538 0 0 0 0 0 0 0 0 0
A 542 1 0 0 0 59 807 0 0 0 0 0 0 0 0 0 0 0 0 0
A 543 2 0 0 0 71 635 0 0 0 543 0 0 0 0 0 0 0 0 0
A 547 1 0 0 0 59 809 0 0 0 0 0 0 0 0 0 0 0 0 0
A 548 2 0 0 0 77 636 0 0 0 548 0 0 0 0 0 0 0 0 0
A 552 1 0 0 0 59 811 0 0 0 0 0 0 0 0 0 0 0 0 0
A 553 2 0 0 0 79 637 0 0 0 553 0 0 0 0 0 0 0 0 0
A 557 1 0 0 0 59 813 0 0 0 0 0 0 0 0 0 0 0 0 0
A 558 2 0 0 358 75 638 0 0 0 558 0 0 0 0 0 0 0 0 0
A 562 1 0 0 0 59 815 0 0 0 0 0 0 0 0 0 0 0 0 0
A 563 2 0 0 291 81 639 0 0 0 563 0 0 0 0 0 0 0 0 0
A 567 1 0 0 0 59 817 0 0 0 0 0 0 0 0 0 0 0 0 0
A 568 2 0 0 361 73 640 0 0 0 568 0 0 0 0 0 0 0 0 0
A 572 1 0 0 0 59 819 0 0 0 0 0 0 0 0 0 0 0 0 0
A 573 2 0 0 0 75 641 0 0 0 573 0 0 0 0 0 0 0 0 0
A 577 1 0 0 0 59 821 0 0 0 0 0 0 0 0 0 0 0 0 0
A 578 2 0 0 0 81 642 0 0 0 578 0 0 0 0 0 0 0 0 0
A 582 1 0 0 0 59 823 0 0 0 0 0 0 0 0 0 0 0 0 0
A 583 2 0 0 0 85 644 0 0 0 583 0 0 0 0 0 0 0 0 0
A 587 1 0 0 41 59 825 0 0 0 0 0 0 0 0 0 0 0 0 0
A 588 2 0 0 30 69 645 0 0 0 588 0 0 0 0 0 0 0 0 0
A 592 1 0 0 44 59 827 0 0 0 0 0 0 0 0 0 0 0 0 0
A 593 2 0 0 367 77 646 0 0 0 593 0 0 0 0 0 0 0 0 0
A 597 1 0 0 48 59 829 0 0 0 0 0 0 0 0 0 0 0 0 0
A 598 2 0 0 33 75 647 0 0 0 598 0 0 0 0 0 0 0 0 0
A 602 1 0 0 51 59 831 0 0 0 0 0 0 0 0 0 0 0 0 0
A 603 2 0 0 0 87 648 0 0 0 603 0 0 0 0 0 0 0 0 0
A 607 1 0 0 385 59 833 0 0 0 0 0 0 0 0 0 0 0 0 0
A 608 2 0 0 35 73 649 0 0 0 608 0 0 0 0 0 0 0 0 0
A 612 1 0 0 388 59 835 0 0 0 0 0 0 0 0 0 0 0 0 0
A 613 2 0 0 36 77 650 0 0 0 613 0 0 0 0 0 0 0 0 0
A 617 1 0 0 391 59 837 0 0 0 0 0 0 0 0 0 0 0 0 0
A 618 2 0 0 0 81 651 0 0 0 618 0 0 0 0 0 0 0 0 0
A 622 1 0 0 0 59 839 0 0 0 0 0 0 0 0 0 0 0 0 0
A 623 2 0 0 38 67 652 0 0 0 623 0 0 0 0 0 0 0 0 0
A 627 1 0 0 66 59 841 0 0 0 0 0 0 0 0 0 0 0 0 0
A 630 1 0 0 557 116 868 0 0 0 0 0 0 0 0 0 0 0 0 0
A 633 1 0 0 562 116 870 0 0 0 0 0 0 0 0 0 0 0 0 0
A 636 1 0 0 572 122 874 0 0 0 0 0 0 0 0 0 0 0 0 0
A 639 1 0 0 577 122 876 0 0 0 0 0 0 0 0 0 0 0 0 0
A 642 1 0 0 582 122 878 0 0 0 0 0 0 0 0 0 0 0 0 0
A 645 1 0 0 587 122 880 0 0 0 0 0 0 0 0 0 0 0 0 0
A 648 1 0 0 592 122 882 0 0 0 0 0 0 0 0 0 0 0 0 0
A 651 1 0 0 597 122 884 0 0 0 0 0 0 0 0 0 0 0 0 0
A 654 1 0 0 602 122 886 0 0 0 0 0 0 0 0 0 0 0 0 0
A 657 1 0 0 0 128 890 0 0 0 0 0 0 0 0 0 0 0 0 0
A 660 1 0 0 208 128 892 0 0 0 0 0 0 0 0 0 0 0 0 0
A 663 1 0 0 220 134 896 0 0 0 0 0 0 0 0 0 0 0 0 0
A 666 1 0 0 226 134 898 0 0 0 0 0 0 0 0 0 0 0 0 0
A 669 1 0 0 0 134 900 0 0 0 0 0 0 0 0 0 0 0 0 0
A 672 1 0 0 0 140 904 0 0 0 0 0 0 0 0 0 0 0 0 0
A 675 1 0 0 0 140 906 0 0 0 0 0 0 0 0 0 0 0 0 0
A 678 1 0 0 0 140 908 0 0 0 0 0 0 0 0 0 0 0 0 0
A 681 1 0 0 533 146 912 0 0 0 0 0 0 0 0 0 0 0 0 0
A 684 1 0 0 543 146 914 0 0 0 0 0 0 0 0 0 0 0 0 0
A 687 1 0 0 0 152 918 0 0 0 0 0 0 0 0 0 0 0 0 0
A 690 1 0 0 573 152 920 0 0 0 0 0 0 0 0 0 0 0 0 0
A 693 1 0 0 26 152 922 0 0 0 0 0 0 0 0 0 0 0 0 0
A 696 1 0 0 598 158 926 0 0 0 0 0 0 0 0 0 0 0 0 0
A 699 1 0 0 608 158 928 0 0 0 0 0 0 0 0 0 0 0 0 0
A 702 1 0 0 0 164 932 0 0 0 0 0 0 0 0 0 0 0 0 0
A 705 1 0 0 0 164 934 0 0 0 0 0 0 0 0 0 0 0 0 0
A 708 1 0 0 0 170 938 0 0 0 0 0 0 0 0 0 0 0 0 0
A 711 1 0 0 0 170 940 0 0 0 0 0 0 0 0 0 0 0 0 0
A 714 1 0 0 416 176 944 0 0 0 0 0 0 0 0 0 0 0 0 0
A 717 1 0 0 419 176 946 0 0 0 0 0 0 0 0 0 0 0 0 0
A 720 1 0 0 422 176 948 0 0 0 0 0 0 0 0 0 0 0 0 0
A 805 1 0 0 151 322 1175 0 0 0 0 0 0 0 0 0 0 0 0 0
A 808 1 0 0 156 322 1177 0 0 0 0 0 0 0 0 0 0 0 0 0
A 811 1 0 0 161 322 1179 0 0 0 0 0 0 0 0 0 0 0 0 0
A 814 1 0 0 171 328 1183 0 0 0 0 0 0 0 0 0 0 0 0 0
A 817 1 0 0 176 328 1185 0 0 0 0 0 0 0 0 0 0 0 0 0
A 820 1 0 0 181 328 1187 0 0 0 0 0 0 0 0 0 0 0 0 0
A 823 1 0 0 192 334 1191 0 0 0 0 0 0 0 0 0 0 0 0 0
A 826 1 0 0 197 334 1193 0 0 0 0 0 0 0 0 0 0 0 0 0
A 829 1 0 0 202 334 1195 0 0 0 0 0 0 0 0 0 0 0 0 0
A 830 2 0 0 708 6 1443 0 0 0 830 0 0 0 0 0 0 0 0 0
A 1619 1 0 0 1261 1454 3004 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1622 1 0 0 399 1454 3006 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1669 1 0 0 1492 1703 3300 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1672 1 0 0 1309 1703 3302 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1675 1 0 0 0 1703 3304 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1737 1 0 0 1399 1871 3365 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1740 1 0 0 1400 1871 3367 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1743 1 0 0 1402 1871 3369 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1746 1 0 0 1717 1877 3373 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1749 1 0 0 1719 1877 3375 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1752 1 0 0 1721 1877 3377 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1755 1 0 0 1610 1877 3379 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1758 1 0 0 1725 1877 3381 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1761 1 0 0 1726 1877 3383 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1801 2 0 0 1281 6 3455 0 0 0 1801 0 0 0 0 0 0 0 0 0
A 7418 1 0 0 6998 2079 3472 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7421 1 0 0 7002 2079 3474 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7424 1 0 0 7075 2079 3476 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7427 1 0 0 7008 2079 3478 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7430 1 0 0 7010 2079 3480 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7433 1 0 0 6314 2085 3484 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7436 1 0 0 6837 2085 3486 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7459 2 0 0 6953 6 7986 0 0 0 7459 0 0 0 0 0 0 0 0 0
A 7886 1 0 0 7677 4664 7994 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7889 1 0 0 7578 4664 7996 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7892 1 0 0 7035 4664 7998 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7895 1 0 0 7609 4664 8000 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7898 1 0 0 7608 4664 8002 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7901 1 0 0 7614 4664 8004 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7904 1 0 0 7616 4664 8006 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7907 1 0 0 7612 4664 8008 0 0 0 0 0 0 0 0 0 0 0 0 0
A 8415 1 0 0 7946 5073 8378 0 0 0 0 0 0 0 0 0 0 0 0 0
A 8418 1 0 0 7945 5073 8380 0 0 0 0 0 0 0 0 0 0 0 0 0
A 8421 1 0 0 8325 5073 8382 0 0 0 0 0 0 0 0 0 0 0 0 0
A 8424 1 0 0 8324 5073 8384 0 0 0 0 0 0 0 0 0 0 0 0 0
A 8427 1 0 0 7954 5073 8386 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15520 1 0 0 15070 10839 16516 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15523 1 0 0 15068 10839 16518 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15526 1 0 0 15484 10839 16520 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15529 1 0 0 15485 10839 16522 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15532 1 0 0 15282 10839 16524 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15535 1 0 0 15283 10839 16526 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15538 1 0 0 15067 10839 16528 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15574 2 0 0 15176 6 16747 0 0 0 15574 0 0 0 0 0 0 0 0 0
A 15660 1 0 0 15357 11192 16758 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15663 1 0 0 15574 11192 16760 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15666 1 0 0 14853 11192 16762 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15669 1 0 0 15180 11192 16764 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15672 1 0 0 15175 11192 16766 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15675 1 0 0 15360 11192 16768 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15678 1 0 0 15543 11192 16770 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15681 1 0 0 14870 11192 16772 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15684 1 0 0 13957 11192 16774 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15687 1 0 0 14876 11192 16776 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15690 1 0 0 14873 11192 16778 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15693 1 0 0 15364 11192 16780 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15696 1 0 0 15365 11192 16782 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15699 1 0 0 13232 11192 16784 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16627 1 0 0 16571 11440 16870 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16630 1 0 0 16295 11440 16872 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16633 1 0 0 16290 11440 16874 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16636 1 0 0 16299 11440 16876 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16639 1 0 0 16303 11446 16880 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16642 1 0 0 16298 11446 16882 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16645 1 0 0 16307 11446 16884 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16648 1 0 0 16302 11446 16886 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16753 1 0 0 16485 12395 18376 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16756 1 0 0 16486 12395 18378 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16759 1 0 0 16023 12401 18382 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16762 1 0 0 16410 12401 18384 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16902 1 0 0 14446 12643 18726 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16905 1 0 0 15529 12643 18728 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16908 1 0 0 16556 12655 18737 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16911 1 0 0 16879 12655 18739 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16914 1 0 0 16228 12655 18741 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16917 1 0 0 16555 12655 18743 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16920 1 0 0 16232 12655 18745 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16923 1 0 0 16227 12655 18747 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16926 1 0 0 16236 12655 18749 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16929 1 0 0 16231 12655 18751 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16932 1 0 0 16558 12655 18753 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16935 1 0 0 16235 12655 18755 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16938 1 0 0 16244 12655 18757 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16941 1 0 0 16557 12655 18759 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16944 1 0 0 16248 12655 18761 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16947 1 0 0 16243 12655 18763 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16950 1 0 0 16687 12661 18767 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16953 1 0 0 16153 12661 18769 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16956 1 0 0 16154 12661 18771 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16959 1 0 0 16157 12661 18773 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16962 1 0 0 16158 12661 18775 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16965 1 0 0 15810 12661 18777 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16968 1 0 0 15811 12661 18779 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16971 1 0 0 16693 12661 18781 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16974 1 0 0 16694 12661 18783 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17221 1 0 0 16278 13286 19349 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17224 1 0 0 16279 13286 19351 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17238 2 0 0 17083 6 19875 0 0 0 17238 0 0 0 0 0 0 0 0 0
A 17242 2 0 0 17112 6 19876 0 0 0 17242 0 0 0 0 0 0 0 0 0
A 17246 2 0 0 17114 6 19877 0 0 0 17246 0 0 0 0 0 0 0 0 0
A 17250 2 0 0 17111 6 19878 0 0 0 17250 0 0 0 0 0 0 0 0 0
A 17254 2 0 0 17113 6 19879 0 0 0 17254 0 0 0 0 0 0 0 0 0
A 17258 2 0 0 17085 6 19880 0 0 0 17258 0 0 0 0 0 0 0 0 0
A 17262 2 0 0 16667 6 19881 0 0 0 17262 0 0 0 0 0 0 0 0 0
A 17266 2 0 0 17091 6 19882 0 0 0 17266 0 0 0 0 0 0 0 0 0
A 17270 2 0 0 17090 6 19883 0 0 0 17270 0 0 0 0 0 0 0 0 0
A 17274 2 0 0 17089 6 19884 0 0 0 17274 0 0 0 0 0 0 0 0 0
A 17351 1 0 0 14849 13689 19889 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17354 1 0 0 14846 13689 19891 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17357 1 0 0 16841 13689 19893 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17360 1 0 0 16588 13689 19895 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17363 1 0 0 16840 13695 19899 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17366 1 0 0 15172 13695 19901 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17369 1 0 0 16844 13695 19903 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17372 1 0 0 14856 13695 19905 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17375 1 0 0 15171 13695 19907 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17378 1 0 0 16589 13695 19909 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17381 1 0 0 16590 13695 19911 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17384 1 0 0 16849 13695 19913 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17387 1 0 0 15972 13695 19915 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17390 1 0 0 16853 13695 19917 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17393 1 0 0 16805 13701 19921 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17396 1 0 0 16808 13701 19923 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17399 1 0 0 16249 13707 19927 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17402 1 0 0 17034 13707 19929 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17405 1 0 0 16599 13707 19931 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17408 1 0 0 17106 13713 19935 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17411 1 0 0 17009 13713 19937 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17414 1 0 0 16832 13719 19941 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17417 1 0 0 16835 13719 19943 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17420 1 0 0 16536 13719 19945 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17618 1 0 1 16857 14250 20812 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17619 10 0 0 16535 6 17618 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17620 10 0 0 17619 6 17618 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17621 4 0 0 17152 6 17620 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17622 4 0 0 16015 6 17619 0 17621 0 0 0 0 1 0 0 0 0 0 0
A 17623 10 0 0 17620 6 17618 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17624 10 0 0 17623 6 17618 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17625 10 0 0 17624 6 17618 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17627 1 0 1 16304 14256 20818 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17628 10 0 0 17195 6 17627 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17629 10 0 0 17628 6 17627 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17630 4 0 0 17425 6 17629 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17631 4 0 0 17033 6 17628 0 17630 0 0 0 0 1 0 0 0 0 0 0
A 17632 10 0 0 17629 6 17627 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17633 10 0 0 17632 6 17627 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17634 10 0 0 17633 6 17627 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17636 1 0 1 15908 14262 20826 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17637 10 0 0 17200 6 17636 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17638 10 0 0 17637 6 17636 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17639 4 0 0 17557 6 17638 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17640 4 0 0 16979 6 17637 0 17639 0 0 0 0 1 0 0 0 0 0 0
A 17641 10 0 0 17638 6 17636 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17642 10 0 0 17641 6 17636 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17643 10 0 0 17642 6 17636 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17645 1 0 1 17053 14268 20832 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17646 10 0 0 17597 6 17645 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17647 10 0 0 17646 6 17645 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17648 4 0 0 17562 6 17647 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17649 4 0 0 17369 6 17646 0 17648 0 0 0 0 1 0 0 0 0 0 0
A 17650 10 0 0 17647 6 17645 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17651 10 0 0 17650 6 17645 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17652 10 0 0 17651 6 17645 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17654 1 0 1 17188 14274 20838 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17655 10 0 0 17604 6 17654 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17656 10 0 0 17655 6 17654 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17657 4 0 0 17436 6 17656 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17658 4 0 0 17595 6 17655 0 17657 0 0 0 0 1 0 0 0 0 0 0
A 17659 10 0 0 17656 6 17654 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17660 10 0 0 17659 6 17654 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17661 10 0 0 17660 6 17654 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17663 1 0 1 17197 14280 20844 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17664 10 0 0 17534 6 17663 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17665 10 0 0 17664 6 17663 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17666 4 0 0 17657 6 17665 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17667 4 0 0 17119 6 17664 0 17666 0 0 0 0 1 0 0 0 0 0 0
A 17668 10 0 0 17665 6 17663 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17669 10 0 0 17668 6 17663 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17670 10 0 0 17669 6 17663 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17672 1 0 1 17588 14286 20850 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17673 10 0 0 16905 6 17672 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17674 10 0 0 17673 6 17672 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17675 4 0 0 16642 6 17674 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17676 4 0 0 17460 6 17673 0 17675 0 0 0 0 1 0 0 0 0 0 0
A 17677 10 0 0 17674 6 17672 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17678 10 0 0 17677 6 17672 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17679 10 0 0 17678 6 17672 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17681 1 0 1 16475 14292 20856 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17682 10 0 0 16917 6 17681 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17683 10 0 0 17682 6 17681 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17684 4 0 0 14806 6 17683 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17685 4 0 0 16894 6 17682 0 17684 0 0 0 0 1 0 0 0 0 0 0
A 17686 10 0 0 17683 6 17681 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17687 10 0 0 17686 6 17681 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17688 10 0 0 17687 6 17681 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17691 1 0 3 17575 14298 20863 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17692 10 0 0 16926 6 17691 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17693 10 0 0 17692 6 17691 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17694 4 0 0 17050 6 17693 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17695 4 0 0 17643 6 17692 0 17694 0 0 0 0 1 0 0 0 0 0 0
A 17696 10 0 0 17693 6 17691 16 0 0 0 0 0 0 0 0 0 0 0 0
X 1 1801
A 17697 10 0 0 17696 6 17691 19 0 0 0 0 0 0 0 0 0 0 0 0
X 1 22
A 17698 4 0 0 17447 6 17697 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17699 4 0 0 17150 6 17696 0 17698 0 0 0 0 1 0 0 0 0 0 0
A 17700 10 0 0 17697 6 17691 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17701 10 0 0 17700 6 17691 22 0 0 0 0 0 0 0 0 0 0 0 0
X 1 220
A 17702 10 0 0 17701 6 17691 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17703 10 0 0 17702 6 17691 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17706 1 0 3 17309 14304 20870 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17707 10 0 0 17399 6 17706 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17708 10 0 0 17707 6 17706 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17709 4 0 0 17323 6 17708 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17710 4 0 0 17583 6 17707 0 17709 0 0 0 0 1 0 0 0 0 0 0
A 17711 10 0 0 17708 6 17706 16 0 0 0 0 0 0 0 0 0 0 0 0
X 1 1801
A 17712 10 0 0 17711 6 17706 19 0 0 0 0 0 0 0 0 0 0 0 0
X 1 22
A 17713 4 0 0 16707 6 17712 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17714 4 0 0 17120 6 17711 0 17713 0 0 0 0 1 0 0 0 0 0 0
A 17715 10 0 0 17712 6 17706 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17716 10 0 0 17715 6 17706 22 0 0 0 0 0 0 0 0 0 0 0 0
X 1 220
A 17717 10 0 0 17716 6 17706 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17718 10 0 0 17717 6 17706 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17722 2 0 0 17328 6 20878 0 0 0 17722 0 0 0 0 0 0 0 0 0
A 17723 2 0 0 16493 14307 20879 0 0 0 17723 0 0 0 0 0 0 0 0 0
A 17725 1 0 1 17615 14312 20895 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17726 10 0 0 17630 6 17725 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17727 10 0 0 17726 6 17725 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17728 10 0 0 17727 6 17725 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17729 4 0 0 17466 6 17728 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17730 4 0 0 17681 6 17727 0 17729 0 0 0 0 1 0 0 0 0 0 0
A 17731 10 0 0 17728 6 17725 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17732 10 0 0 17731 6 17725 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17733 1 0 1 16735 14318 20903 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17734 10 0 0 17555 6 17733 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17735 10 0 0 17734 6 17733 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17736 10 0 0 17735 6 17733 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17737 4 0 0 17662 6 17736 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17738 4 0 0 17582 6 17735 0 17737 0 0 0 0 1 0 0 0 0 0 0
A 17739 10 0 0 17736 6 17733 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17740 10 0 0 17739 6 17733 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17741 1 0 1 17676 14324 20913 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17742 10 0 0 17221 6 17741 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17743 10 0 0 17742 6 17741 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17744 10 0 0 17743 6 17741 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17745 4 0 0 17314 6 17744 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17746 4 0 0 17190 6 17743 0 17745 0 0 0 0 1 0 0 0 0 0 0
A 17747 10 0 0 17744 6 17741 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17748 10 0 0 17747 6 17741 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
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
J 71 1 1
V 1619 1454 7 0
S 0 1454 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 1622 1454 7 0
S 0 1454 0 0 0
A 0 6 0 0 1 45 0
J 68 1 1
V 1669 1703 7 0
S 0 1703 0 0 0
A 0 6 0 0 1 2 0
J 68 1 1
V 1672 1703 7 0
S 0 1703 0 0 0
A 0 6 0 0 1 3 0
J 68 1 1
V 1675 1703 7 0
S 0 1703 0 0 0
A 0 6 0 0 1 45 0
J 54 1 1
V 1737 1871 7 0
S 0 1871 0 0 0
A 0 6 0 0 1 2 0
J 54 1 1
V 1740 1871 7 0
S 0 1871 0 0 0
A 0 6 0 0 1 3 0
J 54 1 1
V 1743 1871 7 0
S 0 1871 0 0 0
A 0 6 0 0 1 45 0
J 66 1 1
V 1746 1877 7 0
S 0 1877 0 0 0
A 0 6 0 0 1 2 0
J 66 1 1
V 1749 1877 7 0
S 0 1877 0 0 0
A 0 6 0 0 1 3 0
J 66 1 1
V 1752 1877 7 0
S 0 1877 0 0 0
A 0 6 0 0 1 45 0
J 66 1 1
V 1755 1877 7 0
S 0 1877 0 0 0
A 0 6 0 0 1 32 0
J 66 1 1
V 1758 1877 7 0
S 0 1877 0 0 0
A 0 6 0 0 1 52 0
J 66 1 1
V 1761 1877 7 0
S 0 1877 0 0 0
A 0 6 0 0 1 56 0
J 71 1 1
V 7418 2079 7 0
S 0 2079 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 7421 2079 7 0
S 0 2079 0 0 0
A 0 6 0 0 1 45 0
J 71 1 1
V 7424 2079 7 0
S 0 2079 0 0 0
A 0 6 0 0 1 32 0
J 71 1 1
V 7427 2079 7 0
S 0 2079 0 0 0
A 0 6 0 0 1 52 0
J 71 1 1
V 7430 2079 7 0
S 0 2079 0 0 0
A 0 6 0 0 1 56 0
J 91 1 1
V 7433 2085 7 0
S 0 2085 0 0 0
A 0 6 0 0 1 3 0
J 91 1 1
V 7436 2085 7 0
S 0 2085 0 0 0
A 0 6 0 0 1 45 0
J 69 1 1
V 7886 4664 7 0
S 0 4664 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 7889 4664 7 0
S 0 4664 0 0 0
A 0 6 0 0 1 45 0
J 73 1 1
V 7892 4664 7 0
S 0 4664 0 0 0
A 0 6 0 0 1 52 0
J 75 1 1
V 7895 4664 7 0
S 0 4664 0 0 0
A 0 6 0 0 1 95 0
J 77 1 1
V 7898 4664 7 0
S 0 4664 0 0 0
A 0 6 0 0 1 20 0
J 79 1 1
V 7901 4664 7 0
S 0 4664 0 0 0
A 0 6 0 0 1 24 0
J 81 1 1
V 7904 4664 7 0
S 0 4664 0 0 0
A 0 6 0 0 1 830 0
J 83 1 1
V 7907 4664 7 0
S 0 4664 0 0 0
A 0 6 0 0 1 7459 0
J 72 1 1
V 8415 5073 7 0
S 0 5073 0 0 0
A 0 6 0 0 1 3 0
J 72 1 1
V 8418 5073 7 0
S 0 5073 0 0 0
A 0 6 0 0 1 45 0
J 72 1 1
V 8421 5073 7 0
S 0 5073 0 0 0
A 0 6 0 0 1 32 0
J 72 1 1
V 8424 5073 7 0
S 0 5073 0 0 0
A 0 6 0 0 1 52 0
J 72 1 1
V 8427 5073 7 0
S 0 5073 0 0 0
A 0 6 0 0 1 56 0
J 69 1 1
V 15520 10839 7 0
S 0 10839 0 0 0
A 0 6 0 0 1 3 0
J 69 1 1
V 15523 10839 7 0
S 0 10839 0 0 0
A 0 6 0 0 1 45 0
J 69 1 1
V 15526 10839 7 0
S 0 10839 0 0 0
A 0 6 0 0 1 32 0
J 69 1 1
V 15529 10839 7 0
S 0 10839 0 0 0
A 0 6 0 0 1 52 0
J 69 1 1
V 15532 10839 7 0
S 0 10839 0 0 0
A 0 6 0 0 1 56 0
J 69 1 1
V 15535 10839 7 0
S 0 10839 0 0 0
A 0 6 0 0 1 60 0
J 69 1 1
V 15538 10839 7 0
S 0 10839 0 0 0
A 0 6 0 0 1 21 0
J 79 1 1
V 15660 11192 7 0
S 0 11192 0 0 0
A 0 6 0 0 1 15574 0
J 79 1 1
V 15663 11192 7 0
S 0 11192 0 0 0
A 0 6 0 0 1 27 0
J 84 1 1
V 15666 11192 7 0
S 0 11192 0 0 0
A 0 6 0 0 1 2 0
J 84 1 1
V 15669 11192 7 0
S 0 11192 0 0 0
A 0 6 0 0 1 3 0
J 84 1 1
V 15672 11192 7 0
S 0 11192 0 0 0
A 0 6 0 0 1 45 0
J 84 1 1
V 15675 11192 7 0
S 0 11192 0 0 0
A 0 6 0 0 1 32 0
J 91 1 1
V 15678 11192 7 0
S 0 11192 0 0 0
A 0 6 0 0 1 2 0
J 91 1 1
V 15681 11192 7 0
S 0 11192 0 0 0
A 0 6 0 0 1 3 0
J 91 1 1
V 15684 11192 7 0
S 0 11192 0 0 0
A 0 6 0 0 1 45 0
J 91 1 1
V 15687 11192 7 0
S 0 11192 0 0 0
A 0 6 0 0 1 32 0
J 91 1 1
V 15690 11192 7 0
S 0 11192 0 0 0
A 0 6 0 0 1 52 0
J 91 1 1
V 15693 11192 7 0
S 0 11192 0 0 0
A 0 6 0 0 1 56 0
J 91 1 1
V 15696 11192 7 0
S 0 11192 0 0 0
A 0 6 0 0 1 60 0
J 91 1 1
V 15699 11192 7 0
S 0 11192 0 0 0
A 0 6 0 0 1 21 0
J 80 1 1
V 16627 11440 7 0
S 0 11440 0 0 0
A 0 6 0 0 1 27 0
J 80 1 1
V 16630 11440 7 0
S 0 11440 0 0 0
A 0 6 0 0 1 2 0
J 80 1 1
V 16633 11440 7 0
S 0 11440 0 0 0
A 0 6 0 0 1 3 0
J 80 1 1
V 16636 11440 7 0
S 0 11440 0 0 0
A 0 6 0 0 1 45 0
J 96 1 1
V 16639 11446 7 0
S 0 11446 0 0 0
A 0 6 0 0 1 2 0
J 96 1 1
V 16642 11446 7 0
S 0 11446 0 0 0
A 0 6 0 0 1 3 0
J 96 1 1
V 16645 11446 7 0
S 0 11446 0 0 0
A 0 6 0 0 1 45 0
J 96 1 1
V 16648 11446 7 0
S 0 11446 0 0 0
A 0 6 0 0 1 32 0
J 80 1 1
V 16753 12395 7 0
S 0 12395 0 0 0
A 0 6 0 0 1 2 0
J 80 1 1
V 16756 12395 7 0
S 0 12395 0 0 0
A 0 6 0 0 1 3 0
J 95 1 1
V 16759 12401 7 0
S 0 12401 0 0 0
A 0 6 0 0 1 2 0
J 95 1 1
V 16762 12401 7 0
S 0 12401 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 16902 12643 7 0
S 0 12643 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 16905 12643 7 0
S 0 12643 0 0 0
A 0 6 0 0 1 45 0
J 102 1 1
V 16908 12655 7 0
S 0 12655 0 0 0
A 0 6 0 0 1 2 0
J 102 1 1
V 16911 12655 7 0
S 0 12655 0 0 0
A 0 6 0 0 1 3 0
J 102 1 1
V 16914 12655 7 0
S 0 12655 0 0 0
A 0 6 0 0 1 45 0
J 102 1 1
V 16917 12655 7 0
S 0 12655 0 0 0
A 0 6 0 0 1 32 0
J 102 1 1
V 16920 12655 7 0
S 0 12655 0 0 0
A 0 6 0 0 1 52 0
J 102 1 1
V 16923 12655 7 0
S 0 12655 0 0 0
A 0 6 0 0 1 56 0
J 102 1 1
V 16926 12655 7 0
S 0 12655 0 0 0
A 0 6 0 0 1 60 0
J 102 1 1
V 16929 12655 7 0
S 0 12655 0 0 0
A 0 6 0 0 1 21 0
J 102 1 1
V 16932 12655 7 0
S 0 12655 0 0 0
A 0 6 0 0 1 95 0
J 102 1 1
V 16935 12655 7 0
S 0 12655 0 0 0
A 0 6 0 0 1 13 0
J 102 1 1
V 16938 12655 7 0
S 0 12655 0 0 0
A 0 6 0 0 1 17 0
J 102 1 1
V 16941 12655 7 0
S 0 12655 0 0 0
A 0 6 0 0 1 14 0
J 102 1 1
V 16944 12655 7 0
S 0 12655 0 0 0
A 0 6 0 0 1 182 0
J 102 1 1
V 16947 12655 7 0
S 0 12655 0 0 0
A 0 6 0 0 1 15 0
J 129 1 1
V 16950 12661 7 0
S 0 12661 0 0 0
A 0 6 0 0 1 2 0
J 129 1 1
V 16953 12661 7 0
S 0 12661 0 0 0
A 0 6 0 0 1 3 0
J 129 1 1
V 16956 12661 7 0
S 0 12661 0 0 0
A 0 6 0 0 1 45 0
J 129 1 1
V 16959 12661 7 0
S 0 12661 0 0 0
A 0 6 0 0 1 32 0
J 129 1 1
V 16962 12661 7 0
S 0 12661 0 0 0
A 0 6 0 0 1 52 0
J 129 1 1
V 16965 12661 7 0
S 0 12661 0 0 0
A 0 6 0 0 1 56 0
J 129 1 1
V 16968 12661 7 0
S 0 12661 0 0 0
A 0 6 0 0 1 60 0
J 129 1 1
V 16971 12661 7 0
S 0 12661 0 0 0
A 0 6 0 0 1 21 0
J 129 1 1
V 16974 12661 7 0
S 0 12661 0 0 0
A 0 6 0 0 1 95 0
J 70 1 1
V 17221 13286 7 0
S 0 13286 0 0 0
A 0 6 0 0 1 3 0
J 70 1 1
V 17224 13286 7 0
S 0 13286 0 0 0
A 0 6 0 0 1 45 0
J 64 1 1
V 17351 13689 7 0
S 0 13689 0 0 0
A 0 6 0 0 1 3 0
J 64 1 1
V 17354 13689 7 0
S 0 13689 0 0 0
A 0 6 0 0 1 45 0
J 64 1 1
V 17357 13689 7 0
S 0 13689 0 0 0
A 0 6 0 0 1 32 0
J 64 1 1
V 17360 13689 7 0
S 0 13689 0 0 0
A 0 6 0 0 1 52 0
J 82 1 1
V 17363 13695 7 0
S 0 13695 0 0 0
A 0 6 0 0 1 17238 0
J 82 1 1
V 17366 13695 7 0
S 0 13695 0 0 0
A 0 6 0 0 1 17242 0
J 82 1 1
V 17369 13695 7 0
S 0 13695 0 0 0
A 0 6 0 0 1 17246 0
J 82 1 1
V 17372 13695 7 0
S 0 13695 0 0 0
A 0 6 0 0 1 17250 0
J 82 1 1
V 17375 13695 7 0
S 0 13695 0 0 0
A 0 6 0 0 1 17254 0
J 82 1 1
V 17378 13695 7 0
S 0 13695 0 0 0
A 0 6 0 0 1 17258 0
J 82 1 1
V 17381 13695 7 0
S 0 13695 0 0 0
A 0 6 0 0 1 17262 0
J 82 1 1
V 17384 13695 7 0
S 0 13695 0 0 0
A 0 6 0 0 1 17266 0
J 82 1 1
V 17387 13695 7 0
S 0 13695 0 0 0
A 0 6 0 0 1 17270 0
J 82 1 1
V 17390 13695 7 0
S 0 13695 0 0 0
A 0 6 0 0 1 17274 0
J 106 1 1
V 17393 13701 7 0
S 0 13701 0 0 0
A 0 6 0 0 1 3 0
J 106 1 1
V 17396 13701 7 0
S 0 13701 0 0 0
A 0 6 0 0 1 45 0
J 119 1 1
V 17399 13707 7 0
S 0 13707 0 0 0
A 0 6 0 0 1 3 0
J 119 1 1
V 17402 13707 7 0
S 0 13707 0 0 0
A 0 6 0 0 1 45 0
J 119 1 1
V 17405 13707 7 0
S 0 13707 0 0 0
A 0 6 0 0 1 32 0
J 134 1 1
V 17408 13713 7 0
S 0 13713 0 0 0
A 0 6 0 0 1 3 0
J 134 1 1
V 17411 13713 7 0
S 0 13713 0 0 0
A 0 6 0 0 1 45 0
J 148 1 1
V 17414 13719 7 0
S 0 13719 0 0 0
A 0 6 0 0 1 3 0
J 148 1 1
V 17417 13719 7 0
S 0 13719 0 0 0
A 0 6 0 0 1 45 0
J 148 1 1
V 17420 13719 7 0
S 0 13719 0 0 0
A 0 6 0 0 1 32 0
Z
