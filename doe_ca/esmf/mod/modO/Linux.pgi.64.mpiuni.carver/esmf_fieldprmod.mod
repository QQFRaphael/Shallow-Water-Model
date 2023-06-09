V24 esmf_fieldprmod
87 /global/u2/d/dazlich/cpl40-40/doe_ca/esmf/src/Infrastructure/Field/src/ESMF_FieldPr.F90 S582 0
11/22/2010  10:53:55
use esmf_calendarmod private
use esmf_gridmod private
use esmf_routemod private
use esmf_distgridmod private
use esmf_staggerlocmod private
use esmf_delayoutmod private
use esmf_localarraycreatemod private
use esmf_arrayspecmod private
use esmf_iospecmod private
use esmf_logerrmod private
use esmf_utiltypesmod private
use esmf_fieldmod private
use esmf_calendarmod private
use esmf_gridmod private
use esmf_routemod private
use esmf_distgridmod private
use esmf_staggerlocmod private
use esmf_delayoutmod private
use esmf_localarraycreatemod private
use esmf_arrayspecmod private
use esmf_iospecmod private
use esmf_logerrmod private
use esmf_utiltypesmod private
use esmf_fieldmod private
enduse
D 46 24 719 4 718 3
D 52 24 735 8 734 7
D 58 24 741 4 740 3
D 70 24 783 36 782 3
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
D 127 24 873 4 872 3
D 133 24 879 4 878 3
D 139 24 895 4 894 3
D 145 24 901 4 900 3
D 151 24 909 4 908 3
D 157 24 917 4 916 3
D 163 24 923 4 922 3
D 169 24 931 4 930 3
D 175 24 937 4 936 3
D 181 24 943 4 942 3
D 187 24 949 4 948 3
D 390 24 1199 4 1198 3
D 396 24 1207 4 1206 3
D 402 24 1215 4 1214 3
D 1549 24 3094 4 3093 3
D 1555 24 3102 4 3101 3
D 1739 24 3192 4 3191 3
D 1943 24 3274 4 3273 3
D 1949 24 3286 4 3285 3
D 5862 24 8668 4 8667 3
D 6117 24 8966 4 8965 3
D 6314 24 9084 4 9083 3
D 6978 24 9854 4 9853 3
D 8996 24 13355 4 13354 3
D 9002 24 13365 4 13364 3
D 12269 24 18123 4 18122 3
D 13098 18 13
D 13100 18 14
D 13102 18 15
D 13104 18 16
D 13106 18 17
D 13108 18 18
D 13110 18 19
D 13112 18 20
D 13114 18 21
D 13116 18 22
D 13118 18 23
D 13120 24 18566 4 18565 3
D 13126 24 18572 4 18571 3
D 13153 24 18596 16 18595 7
S 582 24 0 0 0 8 1 0 4659 10005 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 16 0 0 0 0 0 0 esmf_fieldprmod
S 601 3 0 0 0 6 1 1 0 0 0 0 0 0 0 -1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 603 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 7 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 604 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 605 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 8 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 608 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 609 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 610 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 5 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 611 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 6 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 613 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 9 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 614 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 615 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 90 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 616 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 91 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 617 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 99 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 618 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 18 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 619 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 25 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 620 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 32 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 621 3 0 0 0 13098 1 1 0 0 0 0 0 0 0 5041 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 42 61 73 65
S 622 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 11 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 623 3 0 0 0 13100 1 1 0 0 0 0 0 0 0 5051 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 49 4f 53 70 65 63
S 624 3 0 0 0 13100 1 1 0 0 0 0 0 0 0 5063 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 4c 6f 67 45 72 72
S 625 3 0 0 0 13098 1 1 0 0 0 0 0 0 0 5075 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 54 69 6d 65
S 626 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 13 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 627 3 0 0 0 13102 1 1 0 0 0 0 0 0 0 5085 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 43 61 6c 65 6e 64 61 72
S 628 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 17 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 629 3 0 0 0 13104 1 1 0 0 0 0 0 0 0 5099 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 54 69 6d 65 49 6e 74 65 72 76 61 6c
S 630 3 0 0 0 13106 1 1 0 0 0 0 0 0 0 5117 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 41 6c 61 72 6d
S 631 3 0 0 0 13106 1 1 0 0 0 0 0 0 0 5128 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 43 6c 6f 63 6b
S 632 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 633 3 0 0 0 13108 1 1 0 0 0 0 0 0 0 5139 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 41 72 72 61 79 53 70 65 63
S 634 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 635 3 0 0 0 13110 1 1 0 0 0 0 0 0 0 5154 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 15 45 53 4d 46 5f 4c 6f 63 61 6c 41 72 72 61 79
S 636 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 637 3 0 0 0 13112 1 1 0 0 0 0 0 0 0 5170 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 41 72 72 61 79 42 75 6e 64 6c 65
S 638 3 0 0 0 13114 1 1 0 0 0 0 0 0 0 5187 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 7 45 53 4d 46 5f 56 4d
S 639 3 0 0 0 13102 1 1 0 0 0 0 0 0 0 5195 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 44 45 4c 61 79 6f 75 74
S 640 3 0 0 0 13100 1 1 0 0 0 0 0 0 0 5209 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 43 6f 6e 66 69 67
S 641 3 0 0 0 13106 1 1 0 0 0 0 0 0 0 5221 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 41 72 72 61 79
S 642 3 0 0 0 13102 1 1 0 0 0 0 0 0 0 5232 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 49 6e 74 65 72 6e 44 47
S 643 3 0 0 0 13108 1 1 0 0 0 0 0 0 0 5246 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 43 6f 6d 6d 54 61 62 6c 65
S 644 3 0 0 0 13110 1 1 0 0 0 0 0 0 0 5261 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 15 45 53 4d 46 5f 52 6f 75 74 65 54 61 62 6c 65
S 645 3 0 0 0 13106 1 1 0 0 0 0 0 0 0 5277 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 52 6f 75 74 65
S 646 3 0 0 0 13112 1 1 0 0 0 0 0 0 0 5288 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 52 6f 75 74 65 48 61 6e 64 6c 65
S 647 3 0 0 0 13104 1 1 0 0 0 0 0 0 0 5305 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 46 69 65 6c 64 44 61 74 61 4d 61 70
S 648 3 0 0 0 13106 1 1 0 0 0 0 0 0 0 5323 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 46 69 65 6c 64
S 649 3 0 0 0 13112 1 1 0 0 0 0 0 0 0 5334 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 46 69 65 6c 64 42 75 6e 64 6c 65
S 650 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 20 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 651 3 0 0 0 13116 1 1 0 0 0 0 0 0 0 5351 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 20 45 53 4d 46 5f 54 72 61 6e 73 66 6f 72 6d 56 61 6c 75 65 73
S 652 3 0 0 0 13100 1 1 0 0 0 0 0 0 0 5372 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 52 65 67 72 69 64
S 653 3 0 0 0 13108 1 1 0 0 0 0 0 0 0 5384 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 54 72 61 6e 73 66 6f 72 6d
S 654 3 0 0 0 13106 1 1 0 0 0 0 0 0 0 5399 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 53 74 61 74 65
S 655 3 0 0 0 13118 1 1 0 0 0 0 0 0 0 5410 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 18 45 53 4d 46 5f 47 72 69 64 43 6f 6d 70 6f 6e 65 6e 74
S 656 3 0 0 0 13104 1 1 0 0 0 0 0 0 0 5429 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 43 70 6c 43 6f 6d 70 6f 6e 65 6e 74
S 657 3 0 0 0 13108 1 1 0 0 0 0 0 0 0 5447 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 43 6f 6d 70 6f 6e 65 6e 74
S 658 3 0 0 0 13112 1 1 0 0 0 0 0 0 0 5462 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 49 6e 74 65 72 6e 41 72 72 61 79
S 659 3 0 0 0 13098 1 1 0 0 0 0 0 0 0 5479 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 4e 6f 6e 65
S 671 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 12 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 677 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 21 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 679 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 22 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 681 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 23 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 683 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 24 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 686 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 26 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 688 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 28 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 690 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 29 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 692 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 30 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 694 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 31 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 697 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 33 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 699 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 34 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 701 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 35 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 703 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 36 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 718 25 13 esmf_utiltypesmod esmf_status
R 719 5 14 esmf_utiltypesmod status esmf_status
R 721 6 16 esmf_utiltypesmod esmf_status_uninit$ac
R 723 6 18 esmf_utiltypesmod esmf_status_ready$ac
R 725 6 20 esmf_utiltypesmod esmf_status_unallocated$ac
R 727 6 22 esmf_utiltypesmod esmf_status_allocated$ac
R 729 6 24 esmf_utiltypesmod esmf_status_busy$ac
R 731 6 26 esmf_utiltypesmod esmf_status_invalid$ac
R 733 6 28 esmf_utiltypesmod esmf_status_not_ready$ac
R 734 25 29 esmf_utiltypesmod esmf_pointer
R 735 5 30 esmf_utiltypesmod ptr esmf_pointer
R 737 6 32 esmf_utiltypesmod esmf_null_pointer$ac
R 739 6 34 esmf_utiltypesmod esmf_bad_pointer$ac
R 740 25 35 esmf_utiltypesmod esmf_typekind
R 741 5 36 esmf_utiltypesmod dkind esmf_typekind
R 743 6 38 esmf_utiltypesmod esmf_typekind_i1$ac
R 745 6 40 esmf_utiltypesmod esmf_typekind_i2$ac
R 747 6 42 esmf_utiltypesmod esmf_typekind_i4$ac
R 749 6 44 esmf_utiltypesmod esmf_typekind_i8$ac
R 751 6 46 esmf_utiltypesmod esmf_typekind_r4$ac
R 753 6 48 esmf_utiltypesmod esmf_typekind_r8$ac
R 755 6 50 esmf_utiltypesmod esmf_c8$ac
R 757 6 52 esmf_utiltypesmod esmf_c16$ac
R 759 6 54 esmf_utiltypesmod esmf_typekind_logical$ac
R 761 6 56 esmf_utiltypesmod esmf_typekind_character$ac
R 763 6 58 esmf_utiltypesmod esmf_typekind_i$ac
R 765 6 60 esmf_utiltypesmod esmf_typekind_r$ac
R 767 6 62 esmf_utiltypesmod esmf_nokind$ac
R 782 25 77 esmf_utiltypesmod esmf_objectid
R 783 5 78 esmf_utiltypesmod objectid esmf_objectid
R 784 5 79 esmf_utiltypesmod objectname esmf_objectid
R 786 6 81 esmf_utiltypesmod esmf_id_base$ac
R 788 6 83 esmf_utiltypesmod esmf_id_iospec$ac
R 790 6 85 esmf_utiltypesmod esmf_id_logerr$ac
R 792 6 87 esmf_utiltypesmod esmf_id_time$ac
R 794 6 89 esmf_utiltypesmod esmf_id_calendar$ac
R 796 6 91 esmf_utiltypesmod esmf_id_timeinterval$ac
R 798 6 93 esmf_utiltypesmod esmf_id_alarm$ac
R 800 6 95 esmf_utiltypesmod esmf_id_clock$ac
R 802 6 97 esmf_utiltypesmod esmf_id_arrayspec$ac
R 804 6 99 esmf_utiltypesmod esmf_id_localarray$ac
R 806 6 101 esmf_utiltypesmod esmf_id_arraybundle$ac
R 808 6 103 esmf_utiltypesmod esmf_id_vm$ac
R 810 6 105 esmf_utiltypesmod esmf_id_delayout$ac
R 812 6 107 esmf_utiltypesmod esmf_id_config$ac
R 814 6 109 esmf_utiltypesmod esmf_id_array$ac
R 816 6 111 esmf_utiltypesmod esmf_id_interndg$ac
R 818 6 113 esmf_utiltypesmod esmf_id_commtable$ac
R 820 6 115 esmf_utiltypesmod esmf_id_routetable$ac
R 822 6 117 esmf_utiltypesmod esmf_id_route$ac
R 824 6 119 esmf_utiltypesmod esmf_id_routehandle$ac
R 826 6 121 esmf_utiltypesmod esmf_id_fielddatamap$ac
R 828 6 123 esmf_utiltypesmod esmf_id_field$ac
R 830 6 125 esmf_utiltypesmod esmf_id_fieldbundle$ac
R 832 6 127 esmf_utiltypesmod esmf_id_transformvalues$ac
R 834 6 129 esmf_utiltypesmod esmf_id_regrid$ac
R 836 6 131 esmf_utiltypesmod esmf_id_transform$ac
R 838 6 133 esmf_utiltypesmod esmf_id_state$ac
R 840 6 135 esmf_utiltypesmod esmf_id_gridcomponent$ac
R 842 6 137 esmf_utiltypesmod esmf_id_cplcomponent$ac
R 844 6 139 esmf_utiltypesmod esmf_id_component$ac
R 846 6 141 esmf_utiltypesmod esmf_id_internarray$ac
R 848 6 143 esmf_utiltypesmod esmf_id_none$ac
R 872 25 167 esmf_utiltypesmod esmf_localglobalflag
R 873 5 168 esmf_utiltypesmod value esmf_localglobalflag
R 875 6 170 esmf_utiltypesmod esmf_local$ac
R 877 6 172 esmf_utiltypesmod esmf_global$ac
R 878 25 173 esmf_utiltypesmod esmf_domaintypeflag
R 879 5 174 esmf_utiltypesmod value esmf_domaintypeflag
R 881 6 176 esmf_utiltypesmod esmf_domain_exclusive$ac
R 883 6 178 esmf_utiltypesmod esmf_domain_computational$ac
R 885 6 180 esmf_utiltypesmod esmf_domain_total$ac
R 887 6 182 esmf_utiltypesmod esmf_domain_allocated$ac
R 889 6 184 esmf_utiltypesmod esmf_domain_oldexclusive$ac
R 891 6 186 esmf_utiltypesmod esmf_domain_oldcomputational$ac
R 893 6 188 esmf_utiltypesmod esmf_domain_oldtotal$ac
R 894 25 189 esmf_utiltypesmod esmf_logical
R 895 5 190 esmf_utiltypesmod value esmf_logical
R 897 6 192 esmf_utiltypesmod esmf_true$ac
R 899 6 194 esmf_utiltypesmod esmf_false$ac
R 900 25 195 esmf_utiltypesmod esmf_reduceflag
R 901 5 196 esmf_utiltypesmod value esmf_reduceflag
R 903 6 198 esmf_utiltypesmod esmf_sum$ac
R 905 6 200 esmf_utiltypesmod esmf_min$ac
R 907 6 202 esmf_utiltypesmod esmf_max$ac
R 908 25 203 esmf_utiltypesmod esmf_blockingflag
R 909 5 204 esmf_utiltypesmod value esmf_blockingflag
R 911 6 206 esmf_utiltypesmod esmf_blocking$ac
R 913 6 208 esmf_utiltypesmod esmf_vasblocking$ac
R 915 6 210 esmf_utiltypesmod esmf_nonblocking$ac
R 916 25 211 esmf_utiltypesmod esmf_contextflag
R 917 5 212 esmf_utiltypesmod value esmf_contextflag
R 919 6 214 esmf_utiltypesmod esmf_child_in_new_vm$ac
R 921 6 216 esmf_utiltypesmod esmf_child_in_parent_vm$ac
R 922 25 217 esmf_utiltypesmod esmf_terminationflag
R 923 5 218 esmf_utiltypesmod value esmf_terminationflag
R 925 6 220 esmf_utiltypesmod esmf_final$ac
R 927 6 222 esmf_utiltypesmod esmf_keepmpi$ac
R 929 6 224 esmf_utiltypesmod esmf_abort$ac
R 930 25 225 esmf_utiltypesmod esmf_depinflag
R 931 5 226 esmf_utiltypesmod value esmf_depinflag
R 933 6 228 esmf_utiltypesmod esmf_de_pin_pet$ac
R 935 6 230 esmf_utiltypesmod esmf_de_pin_vas$ac
R 936 25 231 esmf_utiltypesmod esmf_direction
R 937 5 232 esmf_utiltypesmod value esmf_direction
R 939 6 234 esmf_utiltypesmod esmf_mode_forward$ac
R 941 6 236 esmf_utiltypesmod esmf_mode_reverse$ac
R 942 25 237 esmf_utiltypesmod esmf_indexflag
R 943 5 238 esmf_utiltypesmod i_type esmf_indexflag
R 945 6 240 esmf_utiltypesmod esmf_index_delocal$ac
R 947 6 242 esmf_utiltypesmod esmf_index_global$ac
R 948 25 243 esmf_utiltypesmod esmf_regionflag
R 949 5 244 esmf_utiltypesmod i_type esmf_regionflag
R 951 6 246 esmf_utiltypesmod esmf_region_total$ac
R 953 6 248 esmf_utiltypesmod esmf_region_select$ac
R 955 6 250 esmf_utiltypesmod esmf_region_empty$ac
R 1198 25 1 esmf_logerrmod esmf_msgtype
R 1199 5 2 esmf_logerrmod mtype esmf_msgtype
R 1201 6 4 esmf_logerrmod esmf_log_info$ac
R 1203 6 6 esmf_logerrmod esmf_log_warning$ac
R 1205 6 8 esmf_logerrmod esmf_log_error$ac
R 1206 25 9 esmf_logerrmod esmf_halttype
R 1207 5 10 esmf_logerrmod htype esmf_halttype
R 1209 6 12 esmf_logerrmod esmf_log_haltnever$ac
R 1211 6 14 esmf_logerrmod esmf_log_haltwarning$ac
R 1213 6 16 esmf_logerrmod esmf_log_halterror$ac
R 1214 25 17 esmf_logerrmod esmf_logtype
R 1215 5 18 esmf_logerrmod ftype esmf_logtype
R 1217 6 20 esmf_logerrmod esmf_log_single$ac
R 1219 6 22 esmf_logerrmod esmf_log_multi$ac
R 1221 6 24 esmf_logerrmod esmf_log_none$ac
S 1599 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 64 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 3093 25 1 esmf_iospecmod esmf_iofileformat
R 3094 5 2 esmf_iospecmod iofileformat esmf_iofileformat
R 3096 6 4 esmf_iospecmod esmf_io_fileformat_unspecified$ac
R 3098 6 6 esmf_iospecmod esmf_io_fileformat_netcdf$ac
R 3100 6 8 esmf_iospecmod esmf_io_fileformat_hdf$ac
R 3101 25 9 esmf_iospecmod esmf_iorwtype
R 3102 5 10 esmf_iospecmod iorwtype esmf_iorwtype
R 3104 6 12 esmf_iospecmod esmf_io_rwtype_unspecified$ac
R 3106 6 14 esmf_iospecmod esmf_io_rwtype_readonly$ac
R 3108 6 16 esmf_iospecmod esmf_io_rwtype_writeonly$ac
R 3110 6 18 esmf_iospecmod esmf_io_rwtype_readwrite$ac
R 3112 6 20 esmf_iospecmod esmf_io_rwtype_append$ac
R 3114 6 22 esmf_iospecmod esmf_io_rwtype_truncate$ac
R 3191 25 1 esmf_arrayspecmod esmf_arrayspecstatus
R 3192 5 2 esmf_arrayspecmod status esmf_arrayspecstatus
R 3194 6 4 esmf_arrayspecmod esmf_arrayspec_status_unknown$ac
R 3196 6 6 esmf_arrayspecmod esmf_arrayspec_status_notset$ac
R 3198 6 8 esmf_arrayspecmod esmf_arrayspec_status_set$ac
R 3273 25 1 esmf_localarraycreatemod esmf_copyflag
R 3274 5 2 esmf_localarraycreatemod docopy esmf_copyflag
R 3276 6 4 esmf_localarraycreatemod esmf_data_copy$ac
R 3278 6 6 esmf_localarraycreatemod esmf_data_ref$ac
R 3280 6 8 esmf_localarraycreatemod esmf_data_defer$ac
R 3282 6 10 esmf_localarraycreatemod esmf_data_space$ac
R 3284 6 12 esmf_localarraycreatemod esmf_data_none$ac
R 3285 25 13 esmf_localarraycreatemod esmf_localarrayorigin
R 3286 5 14 esmf_localarraycreatemod origin esmf_localarrayorigin
R 3288 6 16 esmf_localarraycreatemod esmf_from_fortran$ac
R 3290 6 18 esmf_localarraycreatemod esmf_from_cplusplus$ac
R 8667 25 4 esmf_delayoutmod esmf_delayoutservicereply
R 8668 5 5 esmf_delayoutmod value esmf_delayoutservicereply
R 8670 6 7 esmf_delayoutmod esmf_delayout_service_accept$ac
R 8672 6 9 esmf_delayoutmod esmf_delayout_service_deny$ac
S 8962 3 0 0 0 6 1 1 0 0 0 0 0 0 0 -1 -2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 8963 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 69 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 8965 25 1 esmf_staggerlocmod esmf_staggerloc
R 8966 5 2 esmf_staggerlocmod staggerloc esmf_staggerloc
R 8974 6 10 esmf_staggerlocmod esmf_staggerloc_invalid$ac
R 8976 6 12 esmf_staggerlocmod esmf_staggerloc_uninit$ac
R 8978 6 14 esmf_staggerlocmod esmf_staggerloc_center$ac
R 8980 6 16 esmf_staggerlocmod esmf_staggerloc_edge1$ac
R 8982 6 18 esmf_staggerlocmod esmf_staggerloc_edge2$ac
R 8984 6 20 esmf_staggerlocmod esmf_staggerloc_corner$ac
R 8986 6 22 esmf_staggerlocmod esmf_staggerloc_center_vcenter$ac
R 8988 6 24 esmf_staggerlocmod esmf_staggerloc_edge1_vcenter$ac
R 8990 6 26 esmf_staggerlocmod esmf_staggerloc_edge2_vcenter$ac
R 8992 6 28 esmf_staggerlocmod esmf_staggerloc_corner_vcenter$ac
R 8994 6 30 esmf_staggerlocmod esmf_staggerloc_center_vface$ac
R 8996 6 32 esmf_staggerlocmod esmf_staggerloc_edge1_vface$ac
R 8998 6 34 esmf_staggerlocmod esmf_staggerloc_edge2_vface$ac
R 9000 6 36 esmf_staggerlocmod esmf_staggerloc_corner_vface$ac
R 9083 25 4 esmf_distgridmod esmf_decompflag
R 9084 5 5 esmf_distgridmod value esmf_decompflag
R 9086 6 7 esmf_distgridmod esmf_decomp_default$ac
R 9088 6 9 esmf_distgridmod esmf_decomp_homogen$ac
R 9090 6 11 esmf_distgridmod esmf_decomp_restfirst$ac
R 9092 6 13 esmf_distgridmod esmf_decomp_restlast$ac
R 9094 6 15 esmf_distgridmod esmf_decomp_cyclic$ac
R 9853 25 4 esmf_routemod esmf_routeoptions
R 9854 5 5 esmf_routemod option esmf_routeoptions
R 9856 6 7 esmf_routemod esmf_route_option_async$ac
R 9858 6 9 esmf_routemod esmf_route_option_sync$ac
R 9860 6 11 esmf_routemod esmf_route_option_pack_pet$ac
R 9862 6 13 esmf_routemod esmf_route_option_pack_xp$ac
R 9864 6 15 esmf_routemod esmf_route_option_pack_nopack$ac
R 9866 6 17 esmf_routemod esmf_route_option_pack_vector$ac
R 9868 6 19 esmf_routemod esmf_route_option_pack_buffer$ac
R 9870 6 21 esmf_routemod esmf_route_option_default$ac
R 13354 25 4 esmf_gridmod esmf_gridstatus
R 13355 5 5 esmf_gridmod gridstatus esmf_gridstatus
R 13357 6 7 esmf_gridmod esmf_gridstatus_invalid$ac
R 13359 6 9 esmf_gridmod esmf_gridstatus_uninit$ac
R 13361 6 11 esmf_gridmod esmf_gridstatus_not_ready$ac
R 13363 6 13 esmf_gridmod esmf_gridstatus_shape_ready$ac
R 13364 25 14 esmf_gridmod esmf_gridconn
R 13365 5 15 esmf_gridmod gridconn esmf_gridconn
R 13367 6 17 esmf_gridmod esmf_gridconn_none$ac
R 13369 6 19 esmf_gridmod esmf_gridconn_periodic$ac
R 13371 6 21 esmf_gridmod esmf_gridconn_pole$ac
R 13373 6 23 esmf_gridmod esmf_gridconn_bipole$ac
R 18122 25 2 esmf_calendarmod esmf_calendartype
R 18123 5 3 esmf_calendarmod calendartype esmf_calendartype
R 18125 6 5 esmf_calendarmod esmf_cal_gregorian$ac
R 18127 6 7 esmf_calendarmod esmf_cal_julian$ac
R 18129 6 9 esmf_calendarmod esmf_cal_julianday$ac
R 18131 6 11 esmf_calendarmod esmf_cal_noleap$ac
R 18133 6 13 esmf_calendarmod esmf_cal_360day$ac
R 18135 6 15 esmf_calendarmod esmf_cal_custom$ac
R 18137 6 17 esmf_calendarmod esmf_cal_nocalendar$ac
R 18565 25 1 esmf_fieldmod esmf_access
R 18566 5 2 esmf_fieldmod a_type esmf_access
R 18568 6 4 esmf_fieldmod esmf_readwrite$ac
R 18570 6 6 esmf_fieldmod esmf_readonly$ac
R 18571 25 7 esmf_fieldmod esmf_allocflag
R 18572 5 8 esmf_fieldmod a_type esmf_allocflag
R 18574 6 10 esmf_fieldmod esmf_alloc$ac
R 18576 6 12 esmf_fieldmod esmf_no_alloc$ac
R 18595 25 31 esmf_fieldmod esmf_field
R 18596 5 32 esmf_fieldmod ftypep esmf_field
R 18598 5 34 esmf_fieldmod ftypep$p esmf_field
R 18600 5 36 esmf_fieldmod isinit esmf_field
S 18917 27 0 0 0 8 18918 582 85198 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_fieldprint
S 18918 23 5 0 0 0 18922 582 85198 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_fieldprint
S 18919 1 3 3 0 13153 1 18918 84974 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 field
S 18920 1 3 1 0 28 1 18918 14974 80000014 43000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 options
S 18921 1 3 2 0 6 1 18918 11819 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 18922 14 5 0 0 0 1 18918 85198 0 400000 0 0 0 6293 3 0 0 0 0 0 0 0 0 0 0 0 0 82 0 582 0 0 0 0 esmf_fieldprint
F 18922 3 18919 18920 18921
A 13 2 0 0 0 6 613 0 0 0 13 0 0 0 0 0 0 0 0 0
A 14 2 0 0 0 6 622 0 0 0 14 0 0 0 0 0 0 0 0 0
A 15 2 0 0 0 6 626 0 0 0 15 0 0 0 0 0 0 0 0 0
A 16 2 0 0 0 6 628 0 0 0 16 0 0 0 0 0 0 0 0 0
A 17 2 0 0 0 6 614 0 0 0 17 0 0 0 0 0 0 0 0 0
A 18 2 0 0 0 6 632 0 0 0 18 0 0 0 0 0 0 0 0 0
A 19 2 0 0 0 6 634 0 0 0 19 0 0 0 0 0 0 0 0 0
A 20 2 0 0 0 6 636 0 0 0 20 0 0 0 0 0 0 0 0 0
A 21 2 0 0 0 6 603 0 0 0 21 0 0 0 0 0 0 0 0 0
A 22 2 0 0 0 6 650 0 0 0 22 0 0 0 0 0 0 0 0 0
A 23 2 0 0 0 6 618 0 0 0 23 0 0 0 0 0 0 0 0 0
A 24 2 0 0 0 6 620 0 0 0 24 0 0 0 0 0 0 0 0 0
A 27 2 0 0 0 6 601 0 0 0 27 0 0 0 0 0 0 0 0 0
A 32 2 0 0 0 6 604 0 0 0 32 0 0 0 0 0 0 0 0 0
A 45 2 0 0 0 6 608 0 0 0 45 0 0 0 0 0 0 0 0 0
A 52 2 0 0 0 6 609 0 0 0 52 0 0 0 0 0 0 0 0 0
A 56 2 0 0 0 6 610 0 0 0 56 0 0 0 0 0 0 0 0 0
A 60 2 0 0 0 6 611 0 0 0 60 0 0 0 0 0 0 0 0 0
A 95 2 0 0 0 6 605 0 0 0 95 0 0 0 0 0 0 0 0 0
A 105 2 0 0 0 6 615 0 0 0 105 0 0 0 0 0 0 0 0 0
A 109 2 0 0 0 6 616 0 0 0 109 0 0 0 0 0 0 0 0 0
A 113 2 0 0 0 6 617 0 0 0 113 0 0 0 0 0 0 0 0 0
A 182 2 0 0 0 6 671 0 0 0 182 0 0 0 0 0 0 0 0 0
A 208 2 0 0 0 6 677 0 0 0 208 0 0 0 0 0 0 0 0 0
A 214 2 0 0 0 6 679 0 0 0 214 0 0 0 0 0 0 0 0 0
A 220 2 0 0 0 6 681 0 0 0 220 0 0 0 0 0 0 0 0 0
A 226 2 0 0 0 6 683 0 0 0 226 0 0 0 0 0 0 0 0 0
A 232 2 0 0 193 6 619 0 0 0 232 0 0 0 0 0 0 0 0 0
A 238 2 0 0 0 6 686 0 0 0 238 0 0 0 0 0 0 0 0 0
A 244 2 0 0 0 6 688 0 0 0 244 0 0 0 0 0 0 0 0 0
A 250 2 0 0 0 6 690 0 0 0 250 0 0 0 0 0 0 0 0 0
A 256 2 0 0 0 6 692 0 0 0 256 0 0 0 0 0 0 0 0 0
A 262 2 0 0 0 6 694 0 0 0 262 0 0 0 0 0 0 0 0 0
A 273 2 0 0 0 6 697 0 0 0 273 0 0 0 0 0 0 0 0 0
A 279 2 0 0 0 6 699 0 0 0 279 0 0 0 0 0 0 0 0 0
A 285 2 0 0 0 6 701 0 0 0 285 0 0 0 0 0 0 0 0 0
A 291 2 0 0 0 6 703 0 0 0 291 0 0 0 0 0 0 0 0 0
A 404 1 0 0 0 46 721 0 0 0 0 0 0 0 0 0 0 0 0 0
A 407 1 0 0 0 46 723 0 0 0 0 0 0 0 0 0 0 0 0 0
A 410 1 0 0 0 46 725 0 0 0 0 0 0 0 0 0 0 0 0 0
A 413 1 0 0 0 46 727 0 0 0 0 0 0 0 0 0 0 0 0 0
A 416 1 0 0 0 46 729 0 0 0 0 0 0 0 0 0 0 0 0 0
A 419 1 0 0 5 46 731 0 0 0 0 0 0 0 0 0 0 0 0 0
A 422 1 0 0 7 46 733 0 0 0 0 0 0 0 0 0 0 0 0 0
A 425 1 0 0 0 52 737 0 0 0 0 0 0 0 0 0 0 0 0 0
A 428 1 0 0 0 52 739 0 0 0 0 0 0 0 0 0 0 0 0 0
A 431 1 0 0 0 58 743 0 0 0 0 0 0 0 0 0 0 0 0 0
A 434 1 0 0 0 58 745 0 0 0 0 0 0 0 0 0 0 0 0 0
A 437 1 0 0 0 58 747 0 0 0 0 0 0 0 0 0 0 0 0 0
A 440 1 0 0 0 58 749 0 0 0 0 0 0 0 0 0 0 0 0 0
A 443 1 0 0 0 58 751 0 0 0 0 0 0 0 0 0 0 0 0 0
A 446 1 0 0 0 58 753 0 0 0 0 0 0 0 0 0 0 0 0 0
A 449 1 0 0 0 58 755 0 0 0 0 0 0 0 0 0 0 0 0 0
A 452 1 0 0 0 58 757 0 0 0 0 0 0 0 0 0 0 0 0 0
A 455 1 0 0 0 58 759 0 0 0 0 0 0 0 0 0 0 0 0 0
A 458 1 0 0 0 58 761 0 0 0 0 0 0 0 0 0 0 0 0 0
A 461 1 0 0 0 58 763 0 0 0 0 0 0 0 0 0 0 0 0 0
A 464 1 0 0 0 58 765 0 0 0 0 0 0 0 0 0 0 0 0 0
A 467 1 0 0 0 58 767 0 0 0 0 0 0 0 0 0 0 0 0 0
A 468 2 0 0 0 78 621 0 0 0 468 0 0 0 0 0 0 0 0 0
A 472 1 0 0 232 70 786 0 0 0 0 0 0 0 0 0 0 0 0 0
A 473 2 0 0 296 80 623 0 0 0 473 0 0 0 0 0 0 0 0 0
A 477 1 0 0 203 70 788 0 0 0 0 0 0 0 0 0 0 0 0 0
A 478 2 0 0 220 80 624 0 0 0 478 0 0 0 0 0 0 0 0 0
A 482 1 0 0 209 70 790 0 0 0 0 0 0 0 0 0 0 0 0 0
A 483 2 0 0 337 78 625 0 0 0 483 0 0 0 0 0 0 0 0 0
A 487 1 0 0 215 70 792 0 0 0 0 0 0 0 0 0 0 0 0 0
A 488 2 0 0 0 82 627 0 0 0 488 0 0 0 0 0 0 0 0 0
A 492 1 0 0 221 70 794 0 0 0 0 0 0 0 0 0 0 0 0 0
A 493 2 0 0 238 84 629 0 0 0 493 0 0 0 0 0 0 0 0 0
A 497 1 0 0 227 70 796 0 0 0 0 0 0 0 0 0 0 0 0 0
A 498 2 0 0 0 86 630 0 0 0 498 0 0 0 0 0 0 0 0 0
A 502 1 0 0 0 70 798 0 0 0 0 0 0 0 0 0 0 0 0 0
A 503 2 0 0 244 86 631 0 0 0 503 0 0 0 0 0 0 0 0 0
A 507 1 0 0 0 70 800 0 0 0 0 0 0 0 0 0 0 0 0 0
A 508 2 0 0 250 88 633 0 0 0 508 0 0 0 0 0 0 0 0 0
A 512 1 0 0 0 70 802 0 0 0 0 0 0 0 0 0 0 0 0 0
A 513 2 0 0 256 90 635 0 0 0 513 0 0 0 0 0 0 0 0 0
A 517 1 0 0 0 70 804 0 0 0 0 0 0 0 0 0 0 0 0 0
A 518 2 0 0 262 92 637 0 0 0 518 0 0 0 0 0 0 0 0 0
A 522 1 0 0 0 70 806 0 0 0 0 0 0 0 0 0 0 0 0 0
A 523 2 0 0 0 94 638 0 0 0 523 0 0 0 0 0 0 0 0 0
A 527 1 0 0 268 70 808 0 0 0 0 0 0 0 0 0 0 0 0 0
A 528 2 0 0 0 82 639 0 0 0 528 0 0 0 0 0 0 0 0 0
A 532 1 0 0 274 70 810 0 0 0 0 0 0 0 0 0 0 0 0 0
A 533 2 0 0 273 80 640 0 0 0 533 0 0 0 0 0 0 0 0 0
A 537 1 0 0 280 70 812 0 0 0 0 0 0 0 0 0 0 0 0 0
A 538 2 0 0 0 86 641 0 0 0 538 0 0 0 0 0 0 0 0 0
A 542 1 0 0 286 70 814 0 0 0 0 0 0 0 0 0 0 0 0 0
A 543 2 0 0 279 82 642 0 0 0 543 0 0 0 0 0 0 0 0 0
A 547 1 0 0 292 70 816 0 0 0 0 0 0 0 0 0 0 0 0 0
A 548 2 0 0 0 88 643 0 0 0 548 0 0 0 0 0 0 0 0 0
A 552 1 0 0 0 70 818 0 0 0 0 0 0 0 0 0 0 0 0 0
A 553 2 0 0 285 90 644 0 0 0 553 0 0 0 0 0 0 0 0 0
A 557 1 0 0 0 70 820 0 0 0 0 0 0 0 0 0 0 0 0 0
A 558 2 0 0 0 86 645 0 0 0 558 0 0 0 0 0 0 0 0 0
A 562 1 0 0 0 70 822 0 0 0 0 0 0 0 0 0 0 0 0 0
A 563 2 0 0 291 92 646 0 0 0 563 0 0 0 0 0 0 0 0 0
A 567 1 0 0 117 70 824 0 0 0 0 0 0 0 0 0 0 0 0 0
A 568 2 0 0 0 84 647 0 0 0 568 0 0 0 0 0 0 0 0 0
A 572 1 0 0 119 70 826 0 0 0 0 0 0 0 0 0 0 0 0 0
A 573 2 0 0 0 86 648 0 0 0 573 0 0 0 0 0 0 0 0 0
A 577 1 0 0 121 70 828 0 0 0 0 0 0 0 0 0 0 0 0 0
A 578 2 0 0 0 92 649 0 0 0 578 0 0 0 0 0 0 0 0 0
A 582 1 0 0 123 70 830 0 0 0 0 0 0 0 0 0 0 0 0 0
A 583 2 0 0 0 96 651 0 0 0 583 0 0 0 0 0 0 0 0 0
A 587 1 0 0 0 70 832 0 0 0 0 0 0 0 0 0 0 0 0 0
A 588 2 0 0 0 80 652 0 0 0 588 0 0 0 0 0 0 0 0 0
A 592 1 0 0 125 70 834 0 0 0 0 0 0 0 0 0 0 0 0 0
A 593 2 0 0 0 88 653 0 0 0 593 0 0 0 0 0 0 0 0 0
A 597 1 0 0 0 70 836 0 0 0 0 0 0 0 0 0 0 0 0 0
A 598 2 0 0 0 86 654 0 0 0 598 0 0 0 0 0 0 0 0 0
A 602 1 0 0 182 70 838 0 0 0 0 0 0 0 0 0 0 0 0 0
A 603 2 0 0 0 98 655 0 0 0 603 0 0 0 0 0 0 0 0 0
A 607 1 0 0 0 70 840 0 0 0 0 0 0 0 0 0 0 0 0 0
A 608 2 0 0 0 84 656 0 0 0 608 0 0 0 0 0 0 0 0 0
A 612 1 0 0 0 70 842 0 0 0 0 0 0 0 0 0 0 0 0 0
A 613 2 0 0 0 88 657 0 0 0 613 0 0 0 0 0 0 0 0 0
A 617 1 0 0 208 70 844 0 0 0 0 0 0 0 0 0 0 0 0 0
A 618 2 0 0 0 92 658 0 0 0 618 0 0 0 0 0 0 0 0 0
A 622 1 0 0 214 70 846 0 0 0 0 0 0 0 0 0 0 0 0 0
A 623 2 0 0 38 78 659 0 0 0 623 0 0 0 0 0 0 0 0 0
A 627 1 0 0 478 70 848 0 0 0 0 0 0 0 0 0 0 0 0 0
A 630 1 0 0 0 127 875 0 0 0 0 0 0 0 0 0 0 0 0 0
A 633 1 0 0 0 127 877 0 0 0 0 0 0 0 0 0 0 0 0 0
A 636 1 0 0 572 133 881 0 0 0 0 0 0 0 0 0 0 0 0 0
A 639 1 0 0 577 133 883 0 0 0 0 0 0 0 0 0 0 0 0 0
A 642 1 0 0 582 133 885 0 0 0 0 0 0 0 0 0 0 0 0 0
A 645 1 0 0 587 133 887 0 0 0 0 0 0 0 0 0 0 0 0 0
A 648 1 0 0 592 133 889 0 0 0 0 0 0 0 0 0 0 0 0 0
A 651 1 0 0 597 133 891 0 0 0 0 0 0 0 0 0 0 0 0 0
A 654 1 0 0 602 133 893 0 0 0 0 0 0 0 0 0 0 0 0 0
A 657 1 0 0 612 139 897 0 0 0 0 0 0 0 0 0 0 0 0 0
A 660 1 0 0 617 139 899 0 0 0 0 0 0 0 0 0 0 0 0 0
A 663 1 0 0 2 145 903 0 0 0 0 0 0 0 0 0 0 0 0 0
A 666 1 0 0 3 145 905 0 0 0 0 0 0 0 0 0 0 0 0 0
A 669 1 0 0 0 145 907 0 0 0 0 0 0 0 0 0 0 0 0 0
A 672 1 0 0 0 151 911 0 0 0 0 0 0 0 0 0 0 0 0 0
A 675 1 0 0 0 151 913 0 0 0 0 0 0 0 0 0 0 0 0 0
A 678 1 0 0 0 151 915 0 0 0 0 0 0 0 0 0 0 0 0 0
A 681 1 0 0 0 157 919 0 0 0 0 0 0 0 0 0 0 0 0 0
A 684 1 0 0 0 157 921 0 0 0 0 0 0 0 0 0 0 0 0 0
A 687 1 0 0 0 163 925 0 0 0 0 0 0 0 0 0 0 0 0 0
A 690 1 0 0 0 163 927 0 0 0 0 0 0 0 0 0 0 0 0 0
A 693 1 0 0 0 163 929 0 0 0 0 0 0 0 0 0 0 0 0 0
A 696 1 0 0 0 169 933 0 0 0 0 0 0 0 0 0 0 0 0 0
A 699 1 0 0 0 169 935 0 0 0 0 0 0 0 0 0 0 0 0 0
A 702 1 0 0 0 175 939 0 0 0 0 0 0 0 0 0 0 0 0 0
A 705 1 0 0 0 175 941 0 0 0 0 0 0 0 0 0 0 0 0 0
A 708 1 0 0 407 181 945 0 0 0 0 0 0 0 0 0 0 0 0 0
A 711 1 0 0 410 181 947 0 0 0 0 0 0 0 0 0 0 0 0 0
A 714 1 0 0 416 187 951 0 0 0 0 0 0 0 0 0 0 0 0 0
A 717 1 0 0 419 187 953 0 0 0 0 0 0 0 0 0 0 0 0 0
A 720 1 0 0 422 187 955 0 0 0 0 0 0 0 0 0 0 0 0 0
A 805 1 0 0 455 390 1201 0 0 0 0 0 0 0 0 0 0 0 0 0
A 808 1 0 0 458 390 1203 0 0 0 0 0 0 0 0 0 0 0 0 0
A 811 1 0 0 461 390 1205 0 0 0 0 0 0 0 0 0 0 0 0 0
A 814 1 0 0 467 396 1209 0 0 0 0 0 0 0 0 0 0 0 0 0
A 817 1 0 0 0 396 1211 0 0 0 0 0 0 0 0 0 0 0 0 0
A 820 1 0 0 0 396 1213 0 0 0 0 0 0 0 0 0 0 0 0 0
A 823 1 0 0 642 402 1217 0 0 0 0 0 0 0 0 0 0 0 0 0
A 826 1 0 0 645 402 1219 0 0 0 0 0 0 0 0 0 0 0 0 0
A 829 1 0 0 648 402 1221 0 0 0 0 0 0 0 0 0 0 0 0 0
A 869 2 0 0 0 6 1599 0 0 0 869 0 0 0 0 0 0 0 0 0
A 1509 1 0 0 307 1549 3096 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1512 1 0 0 941 1549 3098 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1515 1 0 0 1359 1549 3100 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1518 1 0 0 1299 1555 3104 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1521 1 0 0 1298 1555 3106 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1524 1 0 0 1303 1555 3108 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1527 1 0 0 1302 1555 3110 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1530 1 0 0 879 1555 3112 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1533 1 0 0 878 1555 3114 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1580 1 0 0 1548 1739 3194 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1583 1 0 0 919 1739 3196 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1586 1 0 0 1427 1739 3198 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7244 1 0 0 6888 1943 3276 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7247 1 0 0 6893 1943 3278 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7250 1 0 0 6892 1943 3280 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7253 1 0 0 6897 1943 3282 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7256 1 0 0 6896 1943 3284 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7259 1 0 0 6907 1949 3288 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7262 1 0 0 6911 1949 3290 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9440 1 0 0 6210 5862 8670 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9443 1 0 0 6215 5862 8672 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9444 2 0 0 8727 6 8963 0 0 0 9444 0 0 0 0 0 0 0 0 0
A 9446 2 0 0 6912 6 8962 0 0 0 9446 0 0 0 0 0 0 0 0 0
A 9532 1 0 0 9088 6117 8974 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9535 1 0 0 6539 6117 8976 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9538 1 0 0 8148 6117 8978 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9541 1 0 0 9169 6117 8980 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9544 1 0 0 8673 6117 8982 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9547 1 0 0 8951 6117 8984 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9550 1 0 0 7939 6117 8986 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9553 1 0 0 8417 6117 8988 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9556 1 0 0 8940 6117 8990 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9559 1 0 0 9493 6117 8992 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9562 1 0 0 9492 6117 8994 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9565 1 0 0 8989 6117 8996 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9568 1 0 0 9057 6117 8998 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9571 1 0 0 8950 6117 9000 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10079 1 0 0 9834 6314 9086 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10082 1 0 0 9836 6314 9088 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10085 1 0 0 9833 6314 9090 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10088 1 0 0 9838 6314 9092 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10091 1 0 0 9844 6314 9094 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10583 1 0 0 10441 6978 9856 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10586 1 0 0 10174 6978 9858 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10589 1 0 0 9792 6978 9860 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10592 1 0 0 9794 6978 9862 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10595 1 0 0 9791 6978 9864 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10598 1 0 0 10420 6978 9866 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10601 1 0 0 10277 6978 9868 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10604 1 0 0 9804 6978 9870 0 0 0 0 0 0 0 0 0 0 0 0 0
A 13705 1 0 0 13488 8996 13357 0 0 0 0 0 0 0 0 0 0 0 0 0
A 13708 1 0 0 13483 8996 13359 0 0 0 0 0 0 0 0 0 0 0 0 0
A 13711 1 0 0 13492 8996 13361 0 0 0 0 0 0 0 0 0 0 0 0 0
A 13714 1 0 0 13487 8996 13363 0 0 0 0 0 0 0 0 0 0 0 0 0
A 13717 1 0 0 13491 9002 13367 0 0 0 0 0 0 0 0 0 0 0 0 0
A 13720 1 0 0 13500 9002 13369 0 0 0 0 0 0 0 0 0 0 0 0 0
A 13723 1 0 0 13495 9002 13371 0 0 0 0 0 0 0 0 0 0 0 0 0
A 13726 1 0 0 13504 9002 13373 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16513 1 0 0 16364 12269 18125 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16516 1 0 0 16422 12269 18127 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16519 1 0 0 16265 12269 18129 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16522 1 0 0 16426 12269 18131 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16525 1 0 0 16428 12269 18133 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16528 1 0 0 16430 12269 18135 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16531 1 0 0 16432 12269 18137 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16739 1 0 0 16579 13120 18568 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16742 1 0 0 16044 13120 18570 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16745 1 0 0 16339 13126 18574 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16748 1 0 0 16345 13126 18576 0 0 0 0 0 0 0 0 0 0 0 0 0
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
V 1509 1549 7 0
S 0 1549 0 0 0
A 0 6 0 0 1 2 0
J 54 1 1
V 1512 1549 7 0
S 0 1549 0 0 0
A 0 6 0 0 1 3 0
J 54 1 1
V 1515 1549 7 0
S 0 1549 0 0 0
A 0 6 0 0 1 45 0
J 66 1 1
V 1518 1555 7 0
S 0 1555 0 0 0
A 0 6 0 0 1 2 0
J 66 1 1
V 1521 1555 7 0
S 0 1555 0 0 0
A 0 6 0 0 1 3 0
J 66 1 1
V 1524 1555 7 0
S 0 1555 0 0 0
A 0 6 0 0 1 45 0
J 66 1 1
V 1527 1555 7 0
S 0 1555 0 0 0
A 0 6 0 0 1 32 0
J 66 1 1
V 1530 1555 7 0
S 0 1555 0 0 0
A 0 6 0 0 1 52 0
J 66 1 1
V 1533 1555 7 0
S 0 1555 0 0 0
A 0 6 0 0 1 56 0
J 68 1 1
V 1580 1739 7 0
S 0 1739 0 0 0
A 0 6 0 0 1 2 0
J 68 1 1
V 1583 1739 7 0
S 0 1739 0 0 0
A 0 6 0 0 1 3 0
J 68 1 1
V 1586 1739 7 0
S 0 1739 0 0 0
A 0 6 0 0 1 45 0
J 77 1 1
V 7244 1943 7 0
S 0 1943 0 0 0
A 0 6 0 0 1 3 0
J 77 1 1
V 7247 1943 7 0
S 0 1943 0 0 0
A 0 6 0 0 1 45 0
J 77 1 1
V 7250 1943 7 0
S 0 1943 0 0 0
A 0 6 0 0 1 32 0
J 77 1 1
V 7253 1943 7 0
S 0 1943 0 0 0
A 0 6 0 0 1 52 0
J 77 1 1
V 7256 1943 7 0
S 0 1943 0 0 0
A 0 6 0 0 1 56 0
J 97 1 1
V 7259 1949 7 0
S 0 1949 0 0 0
A 0 6 0 0 1 3 0
J 97 1 1
V 7262 1949 7 0
S 0 1949 0 0 0
A 0 6 0 0 1 45 0
J 71 1 1
V 9440 5862 7 0
S 0 5862 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 9443 5862 7 0
S 0 5862 0 0 0
A 0 6 0 0 1 45 0
J 79 1 1
V 9532 6117 7 0
S 0 6117 0 0 0
A 0 6 0 0 1 9446 0
J 79 1 1
V 9535 6117 7 0
S 0 6117 0 0 0
A 0 6 0 0 1 27 0
J 84 1 1
V 9538 6117 7 0
S 0 6117 0 0 0
A 0 6 0 0 1 2 0
J 84 1 1
V 9541 6117 7 0
S 0 6117 0 0 0
A 0 6 0 0 1 3 0
J 84 1 1
V 9544 6117 7 0
S 0 6117 0 0 0
A 0 6 0 0 1 45 0
J 84 1 1
V 9547 6117 7 0
S 0 6117 0 0 0
A 0 6 0 0 1 32 0
J 91 1 1
V 9550 6117 7 0
S 0 6117 0 0 0
A 0 6 0 0 1 2 0
J 91 1 1
V 9553 6117 7 0
S 0 6117 0 0 0
A 0 6 0 0 1 3 0
J 91 1 1
V 9556 6117 7 0
S 0 6117 0 0 0
A 0 6 0 0 1 45 0
J 91 1 1
V 9559 6117 7 0
S 0 6117 0 0 0
A 0 6 0 0 1 32 0
J 91 1 1
V 9562 6117 7 0
S 0 6117 0 0 0
A 0 6 0 0 1 52 0
J 91 1 1
V 9565 6117 7 0
S 0 6117 0 0 0
A 0 6 0 0 1 56 0
J 91 1 1
V 9568 6117 7 0
S 0 6117 0 0 0
A 0 6 0 0 1 60 0
J 91 1 1
V 9571 6117 7 0
S 0 6117 0 0 0
A 0 6 0 0 1 21 0
J 72 1 1
V 10079 6314 7 0
S 0 6314 0 0 0
A 0 6 0 0 1 3 0
J 72 1 1
V 10082 6314 7 0
S 0 6314 0 0 0
A 0 6 0 0 1 45 0
J 72 1 1
V 10085 6314 7 0
S 0 6314 0 0 0
A 0 6 0 0 1 32 0
J 72 1 1
V 10088 6314 7 0
S 0 6314 0 0 0
A 0 6 0 0 1 52 0
J 72 1 1
V 10091 6314 7 0
S 0 6314 0 0 0
A 0 6 0 0 1 56 0
J 69 1 1
V 10583 6978 7 0
S 0 6978 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 10586 6978 7 0
S 0 6978 0 0 0
A 0 6 0 0 1 45 0
J 73 1 1
V 10589 6978 7 0
S 0 6978 0 0 0
A 0 6 0 0 1 52 0
J 75 1 1
V 10592 6978 7 0
S 0 6978 0 0 0
A 0 6 0 0 1 95 0
J 77 1 1
V 10595 6978 7 0
S 0 6978 0 0 0
A 0 6 0 0 1 20 0
J 79 1 1
V 10598 6978 7 0
S 0 6978 0 0 0
A 0 6 0 0 1 24 0
J 81 1 1
V 10601 6978 7 0
S 0 6978 0 0 0
A 0 6 0 0 1 869 0
J 83 1 1
V 10604 6978 7 0
S 0 6978 0 0 0
A 0 6 0 0 1 9444 0
J 80 1 1
V 13705 8996 7 0
S 0 8996 0 0 0
A 0 6 0 0 1 27 0
J 80 1 1
V 13708 8996 7 0
S 0 8996 0 0 0
A 0 6 0 0 1 2 0
J 80 1 1
V 13711 8996 7 0
S 0 8996 0 0 0
A 0 6 0 0 1 3 0
J 80 1 1
V 13714 8996 7 0
S 0 8996 0 0 0
A 0 6 0 0 1 45 0
J 96 1 1
V 13717 9002 7 0
S 0 9002 0 0 0
A 0 6 0 0 1 2 0
J 96 1 1
V 13720 9002 7 0
S 0 9002 0 0 0
A 0 6 0 0 1 3 0
J 96 1 1
V 13723 9002 7 0
S 0 9002 0 0 0
A 0 6 0 0 1 45 0
J 96 1 1
V 13726 9002 7 0
S 0 9002 0 0 0
A 0 6 0 0 1 32 0
J 69 1 1
V 16513 12269 7 0
S 0 12269 0 0 0
A 0 6 0 0 1 3 0
J 69 1 1
V 16516 12269 7 0
S 0 12269 0 0 0
A 0 6 0 0 1 45 0
J 69 1 1
V 16519 12269 7 0
S 0 12269 0 0 0
A 0 6 0 0 1 32 0
J 69 1 1
V 16522 12269 7 0
S 0 12269 0 0 0
A 0 6 0 0 1 52 0
J 69 1 1
V 16525 12269 7 0
S 0 12269 0 0 0
A 0 6 0 0 1 56 0
J 69 1 1
V 16528 12269 7 0
S 0 12269 0 0 0
A 0 6 0 0 1 60 0
J 69 1 1
V 16531 12269 7 0
S 0 12269 0 0 0
A 0 6 0 0 1 21 0
J 80 1 1
V 16739 13120 7 0
S 0 13120 0 0 0
A 0 6 0 0 1 2 0
J 80 1 1
V 16742 13120 7 0
S 0 13120 0 0 0
A 0 6 0 0 1 3 0
J 95 1 1
V 16745 13126 7 0
S 0 13126 0 0 0
A 0 6 0 0 1 2 0
J 95 1 1
V 16748 13126 7 0
S 0 13126 0 0 0
A 0 6 0 0 1 3 0
Z
