V24 esmf_fieldprmod
71 /u0/d/dazlich/doe_ca/esmf/src/Infrastructure/Field/src/ESMF_FieldPr.F90 S582 0
08/28/2008  11:57:48
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
D 35 24 719 4 718 3
D 41 24 735 8 734 7
D 47 24 741 4 740 3
D 59 24 783 36 782 3
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
D 116 24 873 4 872 3
D 122 24 879 4 878 3
D 128 24 895 4 894 3
D 134 24 901 4 900 3
D 140 24 909 4 908 3
D 146 24 917 4 916 3
D 152 24 923 4 922 3
D 158 24 931 4 930 3
D 164 24 937 4 936 3
D 170 24 943 4 942 3
D 176 24 949 4 948 3
D 322 24 1180 4 1179 3
D 328 24 1188 4 1187 3
D 334 24 1196 4 1195 3
D 1445 24 3063 4 3062 3
D 1451 24 3071 4 3070 3
D 1623 24 3157 4 3156 3
D 1821 24 3237 4 3236 3
D 1827 24 3249 4 3248 3
D 5479 24 8544 4 8543 3
D 5728 24 8840 4 8839 3
D 5922 24 8957 4 8956 3
D 6577 24 9724 4 9723 3
D 8586 24 13222 4 13221 3
D 8592 24 13232 4 13231 3
D 11832 24 17981 4 17980 3
D 12649 18 13
D 12651 18 14
D 12653 18 15
D 12655 18 16
D 12657 18 17
D 12659 18 18
D 12661 18 19
D 12663 18 20
D 12665 18 21
D 12667 18 22
D 12669 18 23
D 12671 24 18420 4 18419 3
D 12677 24 18426 4 18425 3
D 12704 24 18450 16 18449 7
S 582 24 0 0 0 8 1 0 4668 5 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 16 0 0 0 0 0 0 esmf_fieldprmod
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
S 621 3 0 0 0 12649 1 1 0 0 0 0 0 0 0 5050 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 42 61 73 65
S 622 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 11 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 623 3 0 0 0 12651 1 1 0 0 0 0 0 0 0 5060 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 49 4f 53 70 65 63
S 624 3 0 0 0 12651 1 1 0 0 0 0 0 0 0 5072 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 4c 6f 67 45 72 72
S 625 3 0 0 0 12649 1 1 0 0 0 0 0 0 0 5084 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 54 69 6d 65
S 626 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 13 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 627 3 0 0 0 12653 1 1 0 0 0 0 0 0 0 5094 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 43 61 6c 65 6e 64 61 72
S 628 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 17 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 629 3 0 0 0 12655 1 1 0 0 0 0 0 0 0 5108 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 54 69 6d 65 49 6e 74 65 72 76 61 6c
S 630 3 0 0 0 12657 1 1 0 0 0 0 0 0 0 5126 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 41 6c 61 72 6d
S 631 3 0 0 0 12657 1 1 0 0 0 0 0 0 0 5137 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 43 6c 6f 63 6b
S 632 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 633 3 0 0 0 12659 1 1 0 0 0 0 0 0 0 5148 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 41 72 72 61 79 53 70 65 63
S 634 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 635 3 0 0 0 12661 1 1 0 0 0 0 0 0 0 5163 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 15 45 53 4d 46 5f 4c 6f 63 61 6c 41 72 72 61 79
S 636 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 637 3 0 0 0 12663 1 1 0 0 0 0 0 0 0 5179 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 41 72 72 61 79 42 75 6e 64 6c 65
S 638 3 0 0 0 12665 1 1 0 0 0 0 0 0 0 5196 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 7 45 53 4d 46 5f 56 4d
S 639 3 0 0 0 12653 1 1 0 0 0 0 0 0 0 5204 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 44 45 4c 61 79 6f 75 74
S 640 3 0 0 0 12651 1 1 0 0 0 0 0 0 0 5218 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 43 6f 6e 66 69 67
S 641 3 0 0 0 12657 1 1 0 0 0 0 0 0 0 5230 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 41 72 72 61 79
S 642 3 0 0 0 12653 1 1 0 0 0 0 0 0 0 5241 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 49 6e 74 65 72 6e 44 47
S 643 3 0 0 0 12659 1 1 0 0 0 0 0 0 0 5255 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 43 6f 6d 6d 54 61 62 6c 65
S 644 3 0 0 0 12661 1 1 0 0 0 0 0 0 0 5270 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 15 45 53 4d 46 5f 52 6f 75 74 65 54 61 62 6c 65
S 645 3 0 0 0 12657 1 1 0 0 0 0 0 0 0 5286 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 52 6f 75 74 65
S 646 3 0 0 0 12663 1 1 0 0 0 0 0 0 0 5297 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 52 6f 75 74 65 48 61 6e 64 6c 65
S 647 3 0 0 0 12655 1 1 0 0 0 0 0 0 0 5314 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 46 69 65 6c 64 44 61 74 61 4d 61 70
S 648 3 0 0 0 12657 1 1 0 0 0 0 0 0 0 5332 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 46 69 65 6c 64
S 649 3 0 0 0 12663 1 1 0 0 0 0 0 0 0 5343 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 46 69 65 6c 64 42 75 6e 64 6c 65
S 650 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 20 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 651 3 0 0 0 12667 1 1 0 0 0 0 0 0 0 5360 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 20 45 53 4d 46 5f 54 72 61 6e 73 66 6f 72 6d 56 61 6c 75 65 73
S 652 3 0 0 0 12651 1 1 0 0 0 0 0 0 0 5381 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 52 65 67 72 69 64
S 653 3 0 0 0 12659 1 1 0 0 0 0 0 0 0 5393 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 54 72 61 6e 73 66 6f 72 6d
S 654 3 0 0 0 12657 1 1 0 0 0 0 0 0 0 5408 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 53 74 61 74 65
S 655 3 0 0 0 12669 1 1 0 0 0 0 0 0 0 5419 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 18 45 53 4d 46 5f 47 72 69 64 43 6f 6d 70 6f 6e 65 6e 74
S 656 3 0 0 0 12655 1 1 0 0 0 0 0 0 0 5438 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 43 70 6c 43 6f 6d 70 6f 6e 65 6e 74
S 657 3 0 0 0 12659 1 1 0 0 0 0 0 0 0 5456 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 43 6f 6d 70 6f 6e 65 6e 74
S 658 3 0 0 0 12663 1 1 0 0 0 0 0 0 0 5471 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 49 6e 74 65 72 6e 41 72 72 61 79
S 659 3 0 0 0 12649 1 1 0 0 0 0 0 0 0 5488 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 4e 6f 6e 65
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
R 719 5 14 esmf_utiltypesmod status
R 721 6 16 esmf_utiltypesmod esmf_status_uninit$ac
R 723 6 18 esmf_utiltypesmod esmf_status_ready$ac
R 725 6 20 esmf_utiltypesmod esmf_status_unallocated$ac
R 727 6 22 esmf_utiltypesmod esmf_status_allocated$ac
R 729 6 24 esmf_utiltypesmod esmf_status_busy$ac
R 731 6 26 esmf_utiltypesmod esmf_status_invalid$ac
R 733 6 28 esmf_utiltypesmod esmf_status_not_ready$ac
R 734 25 29 esmf_utiltypesmod esmf_pointer
R 735 5 30 esmf_utiltypesmod ptr
R 737 6 32 esmf_utiltypesmod esmf_null_pointer$ac
R 739 6 34 esmf_utiltypesmod esmf_bad_pointer$ac
R 740 25 35 esmf_utiltypesmod esmf_typekind
R 741 5 36 esmf_utiltypesmod dkind
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
R 783 5 78 esmf_utiltypesmod objectid
R 784 5 79 esmf_utiltypesmod objectname
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
R 873 5 168 esmf_utiltypesmod value
R 875 6 170 esmf_utiltypesmod esmf_local$ac
R 877 6 172 esmf_utiltypesmod esmf_global$ac
R 878 25 173 esmf_utiltypesmod esmf_domaintypeflag
R 879 5 174 esmf_utiltypesmod value
R 881 6 176 esmf_utiltypesmod esmf_domain_exclusive$ac
R 883 6 178 esmf_utiltypesmod esmf_domain_computational$ac
R 885 6 180 esmf_utiltypesmod esmf_domain_total$ac
R 887 6 182 esmf_utiltypesmod esmf_domain_allocated$ac
R 889 6 184 esmf_utiltypesmod esmf_domain_oldexclusive$ac
R 891 6 186 esmf_utiltypesmod esmf_domain_oldcomputational$ac
R 893 6 188 esmf_utiltypesmod esmf_domain_oldtotal$ac
R 894 25 189 esmf_utiltypesmod esmf_logical
R 895 5 190 esmf_utiltypesmod value
R 897 6 192 esmf_utiltypesmod esmf_true$ac
R 899 6 194 esmf_utiltypesmod esmf_false$ac
R 900 25 195 esmf_utiltypesmod esmf_reduceflag
R 901 5 196 esmf_utiltypesmod value
R 903 6 198 esmf_utiltypesmod esmf_sum$ac
R 905 6 200 esmf_utiltypesmod esmf_min$ac
R 907 6 202 esmf_utiltypesmod esmf_max$ac
R 908 25 203 esmf_utiltypesmod esmf_blockingflag
R 909 5 204 esmf_utiltypesmod value
R 911 6 206 esmf_utiltypesmod esmf_blocking$ac
R 913 6 208 esmf_utiltypesmod esmf_vasblocking$ac
R 915 6 210 esmf_utiltypesmod esmf_nonblocking$ac
R 916 25 211 esmf_utiltypesmod esmf_contextflag
R 917 5 212 esmf_utiltypesmod value
R 919 6 214 esmf_utiltypesmod esmf_child_in_new_vm$ac
R 921 6 216 esmf_utiltypesmod esmf_child_in_parent_vm$ac
R 922 25 217 esmf_utiltypesmod esmf_terminationflag
R 923 5 218 esmf_utiltypesmod value
R 925 6 220 esmf_utiltypesmod esmf_final$ac
R 927 6 222 esmf_utiltypesmod esmf_keepmpi$ac
R 929 6 224 esmf_utiltypesmod esmf_abort$ac
R 930 25 225 esmf_utiltypesmod esmf_depinflag
R 931 5 226 esmf_utiltypesmod value
R 933 6 228 esmf_utiltypesmod esmf_de_pin_pet$ac
R 935 6 230 esmf_utiltypesmod esmf_de_pin_vas$ac
R 936 25 231 esmf_utiltypesmod esmf_direction
R 937 5 232 esmf_utiltypesmod value
R 939 6 234 esmf_utiltypesmod esmf_mode_forward$ac
R 941 6 236 esmf_utiltypesmod esmf_mode_reverse$ac
R 942 25 237 esmf_utiltypesmod esmf_indexflag
R 943 5 238 esmf_utiltypesmod i_type
R 945 6 240 esmf_utiltypesmod esmf_index_delocal$ac
R 947 6 242 esmf_utiltypesmod esmf_index_global$ac
R 948 25 243 esmf_utiltypesmod esmf_regionflag
R 949 5 244 esmf_utiltypesmod i_type
R 951 6 246 esmf_utiltypesmod esmf_region_total$ac
R 953 6 248 esmf_utiltypesmod esmf_region_select$ac
R 955 6 250 esmf_utiltypesmod esmf_region_empty$ac
R 1179 25 1 esmf_logerrmod esmf_msgtype
R 1180 5 2 esmf_logerrmod mtype
R 1182 6 4 esmf_logerrmod esmf_log_info$ac
R 1184 6 6 esmf_logerrmod esmf_log_warning$ac
R 1186 6 8 esmf_logerrmod esmf_log_error$ac
R 1187 25 9 esmf_logerrmod esmf_halttype
R 1188 5 10 esmf_logerrmod htype
R 1190 6 12 esmf_logerrmod esmf_log_haltnever$ac
R 1192 6 14 esmf_logerrmod esmf_log_haltwarning$ac
R 1194 6 16 esmf_logerrmod esmf_log_halterror$ac
R 1195 25 17 esmf_logerrmod esmf_logtype
R 1196 5 18 esmf_logerrmod ftype
R 1198 6 20 esmf_logerrmod esmf_log_single$ac
R 1200 6 22 esmf_logerrmod esmf_log_multi$ac
R 1202 6 24 esmf_logerrmod esmf_log_none$ac
S 1574 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 64 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 3062 25 1 esmf_iospecmod esmf_iofileformat
R 3063 5 2 esmf_iospecmod iofileformat
R 3065 6 4 esmf_iospecmod esmf_io_fileformat_unspecified$ac
R 3067 6 6 esmf_iospecmod esmf_io_fileformat_netcdf$ac
R 3069 6 8 esmf_iospecmod esmf_io_fileformat_hdf$ac
R 3070 25 9 esmf_iospecmod esmf_iorwtype
R 3071 5 10 esmf_iospecmod iorwtype
R 3073 6 12 esmf_iospecmod esmf_io_rwtype_unspecified$ac
R 3075 6 14 esmf_iospecmod esmf_io_rwtype_readonly$ac
R 3077 6 16 esmf_iospecmod esmf_io_rwtype_writeonly$ac
R 3079 6 18 esmf_iospecmod esmf_io_rwtype_readwrite$ac
R 3081 6 20 esmf_iospecmod esmf_io_rwtype_append$ac
R 3083 6 22 esmf_iospecmod esmf_io_rwtype_truncate$ac
R 3156 25 1 esmf_arrayspecmod esmf_arrayspecstatus
R 3157 5 2 esmf_arrayspecmod status
R 3159 6 4 esmf_arrayspecmod esmf_arrayspec_status_unknown$ac
R 3161 6 6 esmf_arrayspecmod esmf_arrayspec_status_notset$ac
R 3163 6 8 esmf_arrayspecmod esmf_arrayspec_status_set$ac
R 3236 25 1 esmf_localarraycreatemod esmf_copyflag
R 3237 5 2 esmf_localarraycreatemod docopy
R 3239 6 4 esmf_localarraycreatemod esmf_data_copy$ac
R 3241 6 6 esmf_localarraycreatemod esmf_data_ref$ac
R 3243 6 8 esmf_localarraycreatemod esmf_data_defer$ac
R 3245 6 10 esmf_localarraycreatemod esmf_data_space$ac
R 3247 6 12 esmf_localarraycreatemod esmf_data_none$ac
R 3248 25 13 esmf_localarraycreatemod esmf_localarrayorigin
R 3249 5 14 esmf_localarraycreatemod origin
R 3251 6 16 esmf_localarraycreatemod esmf_from_fortran$ac
R 3253 6 18 esmf_localarraycreatemod esmf_from_cplusplus$ac
R 8543 25 4 esmf_delayoutmod esmf_delayoutservicereply
R 8544 5 5 esmf_delayoutmod value
R 8546 6 7 esmf_delayoutmod esmf_delayout_service_accept$ac
R 8548 6 9 esmf_delayoutmod esmf_delayout_service_deny$ac
S 8836 3 0 0 0 6 1 1 0 0 0 0 0 0 0 -1 -2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 8837 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 69 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 8839 25 1 esmf_staggerlocmod esmf_staggerloc
R 8840 5 2 esmf_staggerlocmod staggerloc
R 8848 6 10 esmf_staggerlocmod esmf_staggerloc_invalid$ac
R 8850 6 12 esmf_staggerlocmod esmf_staggerloc_uninit$ac
R 8852 6 14 esmf_staggerlocmod esmf_staggerloc_center$ac
R 8854 6 16 esmf_staggerlocmod esmf_staggerloc_edge1$ac
R 8856 6 18 esmf_staggerlocmod esmf_staggerloc_edge2$ac
R 8858 6 20 esmf_staggerlocmod esmf_staggerloc_corner$ac
R 8860 6 22 esmf_staggerlocmod esmf_staggerloc_center_vcenter$ac
R 8862 6 24 esmf_staggerlocmod esmf_staggerloc_edge1_vcenter$ac
R 8864 6 26 esmf_staggerlocmod esmf_staggerloc_edge2_vcenter$ac
R 8866 6 28 esmf_staggerlocmod esmf_staggerloc_corner_vcenter$ac
R 8868 6 30 esmf_staggerlocmod esmf_staggerloc_center_vface$ac
R 8870 6 32 esmf_staggerlocmod esmf_staggerloc_edge1_vface$ac
R 8872 6 34 esmf_staggerlocmod esmf_staggerloc_edge2_vface$ac
R 8874 6 36 esmf_staggerlocmod esmf_staggerloc_corner_vface$ac
R 8956 25 4 esmf_distgridmod esmf_decompflag
R 8957 5 5 esmf_distgridmod value
R 8959 6 7 esmf_distgridmod esmf_decomp_default$ac
R 8961 6 9 esmf_distgridmod esmf_decomp_homogen$ac
R 8963 6 11 esmf_distgridmod esmf_decomp_restfirst$ac
R 8965 6 13 esmf_distgridmod esmf_decomp_restlast$ac
R 8967 6 15 esmf_distgridmod esmf_decomp_cyclic$ac
R 9723 25 4 esmf_routemod esmf_routeoptions
R 9724 5 5 esmf_routemod option
R 9726 6 7 esmf_routemod esmf_route_option_async$ac
R 9728 6 9 esmf_routemod esmf_route_option_sync$ac
R 9730 6 11 esmf_routemod esmf_route_option_pack_pet$ac
R 9732 6 13 esmf_routemod esmf_route_option_pack_xp$ac
R 9734 6 15 esmf_routemod esmf_route_option_pack_nopack$ac
R 9736 6 17 esmf_routemod esmf_route_option_pack_vector$ac
R 9738 6 19 esmf_routemod esmf_route_option_pack_buffer$ac
R 9740 6 21 esmf_routemod esmf_route_option_default$ac
R 13221 25 4 esmf_gridmod esmf_gridstatus
R 13222 5 5 esmf_gridmod gridstatus
R 13224 6 7 esmf_gridmod esmf_gridstatus_invalid$ac
R 13226 6 9 esmf_gridmod esmf_gridstatus_uninit$ac
R 13228 6 11 esmf_gridmod esmf_gridstatus_not_ready$ac
R 13230 6 13 esmf_gridmod esmf_gridstatus_shape_ready$ac
R 13231 25 14 esmf_gridmod esmf_gridconn
R 13232 5 15 esmf_gridmod gridconn
R 13234 6 17 esmf_gridmod esmf_gridconn_none$ac
R 13236 6 19 esmf_gridmod esmf_gridconn_periodic$ac
R 13238 6 21 esmf_gridmod esmf_gridconn_pole$ac
R 13240 6 23 esmf_gridmod esmf_gridconn_bipole$ac
R 17980 25 2 esmf_calendarmod esmf_calendartype
R 17981 5 3 esmf_calendarmod calendartype
R 17983 6 5 esmf_calendarmod esmf_cal_gregorian$ac
R 17985 6 7 esmf_calendarmod esmf_cal_julian$ac
R 17987 6 9 esmf_calendarmod esmf_cal_julianday$ac
R 17989 6 11 esmf_calendarmod esmf_cal_noleap$ac
R 17991 6 13 esmf_calendarmod esmf_cal_360day$ac
R 17993 6 15 esmf_calendarmod esmf_cal_custom$ac
R 17995 6 17 esmf_calendarmod esmf_cal_nocalendar$ac
R 18419 25 1 esmf_fieldmod esmf_access
R 18420 5 2 esmf_fieldmod a_type
R 18422 6 4 esmf_fieldmod esmf_readwrite$ac
R 18424 6 6 esmf_fieldmod esmf_readonly$ac
R 18425 25 7 esmf_fieldmod esmf_allocflag
R 18426 5 8 esmf_fieldmod a_type
R 18428 6 10 esmf_fieldmod esmf_alloc$ac
R 18430 6 12 esmf_fieldmod esmf_no_alloc$ac
R 18449 25 31 esmf_fieldmod esmf_field
R 18450 5 32 esmf_fieldmod ftypep
R 18452 5 34 esmf_fieldmod ftypep$p
R 18454 5 36 esmf_fieldmod isinit
S 18767 27 0 0 0 8 18768 582 79249 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_fieldprint
S 18768 23 5 0 0 0 18772 582 79249 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_fieldprint
S 18769 1 3 0 0 12704 1 18768 79025 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 field
S 18770 1 3 1 0 28 1 18768 14037 80000014 43000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 options
S 18771 1 3 2 0 6 1 18768 11128 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 18772 14 5 0 0 0 1 18768 79249 0 400000 0 0 0 6293 3 0 0 0 0 0 0 0 0 0 0 0 0 82 0 582 0 0 0 0 esmf_fieldprint
F 18772 3 18769 18770 18771
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
A 404 1 0 0 319 35 721 0 0 0 0 0 0 0 0 0 0 0 0 0
A 407 1 0 0 322 35 723 0 0 0 0 0 0 0 0 0 0 0 0 0
A 410 1 0 0 325 35 725 0 0 0 0 0 0 0 0 0 0 0 0 0
A 413 1 0 0 272 35 727 0 0 0 0 0 0 0 0 0 0 0 0 0
A 416 1 0 0 278 35 729 0 0 0 0 0 0 0 0 0 0 0 0 0
A 419 1 0 0 284 35 731 0 0 0 0 0 0 0 0 0 0 0 0 0
A 422 1 0 0 290 35 733 0 0 0 0 0 0 0 0 0 0 0 0 0
A 425 1 0 0 0 41 737 0 0 0 0 0 0 0 0 0 0 0 0 0
A 428 1 0 0 0 41 739 0 0 0 0 0 0 0 0 0 0 0 0 0
A 431 1 0 0 0 47 743 0 0 0 0 0 0 0 0 0 0 0 0 0
A 434 1 0 0 0 47 745 0 0 0 0 0 0 0 0 0 0 0 0 0
A 437 1 0 0 0 47 747 0 0 0 0 0 0 0 0 0 0 0 0 0
A 440 1 0 0 0 47 749 0 0 0 0 0 0 0 0 0 0 0 0 0
A 443 1 0 0 0 47 751 0 0 0 0 0 0 0 0 0 0 0 0 0
A 446 1 0 0 0 47 753 0 0 0 0 0 0 0 0 0 0 0 0 0
A 449 1 0 0 0 47 755 0 0 0 0 0 0 0 0 0 0 0 0 0
A 452 1 0 0 0 47 757 0 0 0 0 0 0 0 0 0 0 0 0 0
A 455 1 0 0 0 47 759 0 0 0 0 0 0 0 0 0 0 0 0 0
A 458 1 0 0 0 47 761 0 0 0 0 0 0 0 0 0 0 0 0 0
A 461 1 0 0 0 47 763 0 0 0 0 0 0 0 0 0 0 0 0 0
A 464 1 0 0 398 47 765 0 0 0 0 0 0 0 0 0 0 0 0 0
A 467 1 0 0 0 47 767 0 0 0 0 0 0 0 0 0 0 0 0 0
A 468 2 0 0 0 67 621 0 0 0 468 0 0 0 0 0 0 0 0 0
A 472 1 0 0 0 59 786 0 0 0 0 0 0 0 0 0 0 0 0 0
A 473 2 0 0 0 69 623 0 0 0 473 0 0 0 0 0 0 0 0 0
A 477 1 0 0 0 59 788 0 0 0 0 0 0 0 0 0 0 0 0 0
A 478 2 0 0 2 69 624 0 0 0 478 0 0 0 0 0 0 0 0 0
A 482 1 0 0 0 59 790 0 0 0 0 0 0 0 0 0 0 0 0 0
A 483 2 0 0 10 67 625 0 0 0 483 0 0 0 0 0 0 0 0 0
A 487 1 0 0 0 59 792 0 0 0 0 0 0 0 0 0 0 0 0 0
A 488 2 0 0 11 71 627 0 0 0 488 0 0 0 0 0 0 0 0 0
A 492 1 0 0 0 59 794 0 0 0 0 0 0 0 0 0 0 0 0 0
A 493 2 0 0 0 73 629 0 0 0 493 0 0 0 0 0 0 0 0 0
A 497 1 0 0 0 59 796 0 0 0 0 0 0 0 0 0 0 0 0 0
A 498 2 0 0 0 75 630 0 0 0 498 0 0 0 0 0 0 0 0 0
A 502 1 0 0 0 59 798 0 0 0 0 0 0 0 0 0 0 0 0 0
A 503 2 0 0 0 75 631 0 0 0 503 0 0 0 0 0 0 0 0 0
A 507 1 0 0 0 59 800 0 0 0 0 0 0 0 0 0 0 0 0 0
A 508 2 0 0 0 77 633 0 0 0 508 0 0 0 0 0 0 0 0 0
A 512 1 0 0 0 59 802 0 0 0 0 0 0 0 0 0 0 0 0 0
A 513 2 0 0 0 79 635 0 0 0 513 0 0 0 0 0 0 0 0 0
A 517 1 0 0 0 59 804 0 0 0 0 0 0 0 0 0 0 0 0 0
A 518 2 0 0 262 81 637 0 0 0 518 0 0 0 0 0 0 0 0 0
A 522 1 0 0 0 59 806 0 0 0 0 0 0 0 0 0 0 0 0 0
A 523 2 0 0 0 83 638 0 0 0 523 0 0 0 0 0 0 0 0 0
A 527 1 0 0 0 59 808 0 0 0 0 0 0 0 0 0 0 0 0 0
A 528 2 0 0 352 71 639 0 0 0 528 0 0 0 0 0 0 0 0 0
A 532 1 0 0 0 59 810 0 0 0 0 0 0 0 0 0 0 0 0 0
A 533 2 0 0 0 69 640 0 0 0 533 0 0 0 0 0 0 0 0 0
A 537 1 0 0 394 59 812 0 0 0 0 0 0 0 0 0 0 0 0 0
A 538 2 0 0 355 75 641 0 0 0 538 0 0 0 0 0 0 0 0 0
A 542 1 0 0 0 59 814 0 0 0 0 0 0 0 0 0 0 0 0 0
A 543 2 0 0 0 71 642 0 0 0 543 0 0 0 0 0 0 0 0 0
A 547 1 0 0 0 59 816 0 0 0 0 0 0 0 0 0 0 0 0 0
A 548 2 0 0 0 77 643 0 0 0 548 0 0 0 0 0 0 0 0 0
A 552 1 0 0 0 59 818 0 0 0 0 0 0 0 0 0 0 0 0 0
A 553 2 0 0 0 79 644 0 0 0 553 0 0 0 0 0 0 0 0 0
A 557 1 0 0 0 59 820 0 0 0 0 0 0 0 0 0 0 0 0 0
A 558 2 0 0 358 75 645 0 0 0 558 0 0 0 0 0 0 0 0 0
A 562 1 0 0 0 59 822 0 0 0 0 0 0 0 0 0 0 0 0 0
A 563 2 0 0 291 81 646 0 0 0 563 0 0 0 0 0 0 0 0 0
A 567 1 0 0 0 59 824 0 0 0 0 0 0 0 0 0 0 0 0 0
A 568 2 0 0 361 73 647 0 0 0 568 0 0 0 0 0 0 0 0 0
A 572 1 0 0 0 59 826 0 0 0 0 0 0 0 0 0 0 0 0 0
A 573 2 0 0 0 75 648 0 0 0 573 0 0 0 0 0 0 0 0 0
A 577 1 0 0 0 59 828 0 0 0 0 0 0 0 0 0 0 0 0 0
A 578 2 0 0 0 81 649 0 0 0 578 0 0 0 0 0 0 0 0 0
A 582 1 0 0 0 59 830 0 0 0 0 0 0 0 0 0 0 0 0 0
A 583 2 0 0 0 85 651 0 0 0 583 0 0 0 0 0 0 0 0 0
A 587 1 0 0 41 59 832 0 0 0 0 0 0 0 0 0 0 0 0 0
A 588 2 0 0 30 69 652 0 0 0 588 0 0 0 0 0 0 0 0 0
A 592 1 0 0 44 59 834 0 0 0 0 0 0 0 0 0 0 0 0 0
A 593 2 0 0 367 77 653 0 0 0 593 0 0 0 0 0 0 0 0 0
A 597 1 0 0 48 59 836 0 0 0 0 0 0 0 0 0 0 0 0 0
A 598 2 0 0 33 75 654 0 0 0 598 0 0 0 0 0 0 0 0 0
A 602 1 0 0 51 59 838 0 0 0 0 0 0 0 0 0 0 0 0 0
A 603 2 0 0 0 87 655 0 0 0 603 0 0 0 0 0 0 0 0 0
A 607 1 0 0 385 59 840 0 0 0 0 0 0 0 0 0 0 0 0 0
A 608 2 0 0 35 73 656 0 0 0 608 0 0 0 0 0 0 0 0 0
A 612 1 0 0 388 59 842 0 0 0 0 0 0 0 0 0 0 0 0 0
A 613 2 0 0 36 77 657 0 0 0 613 0 0 0 0 0 0 0 0 0
A 617 1 0 0 391 59 844 0 0 0 0 0 0 0 0 0 0 0 0 0
A 618 2 0 0 0 81 658 0 0 0 618 0 0 0 0 0 0 0 0 0
A 622 1 0 0 0 59 846 0 0 0 0 0 0 0 0 0 0 0 0 0
A 623 2 0 0 38 67 659 0 0 0 623 0 0 0 0 0 0 0 0 0
A 627 1 0 0 66 59 848 0 0 0 0 0 0 0 0 0 0 0 0 0
A 630 1 0 0 557 116 875 0 0 0 0 0 0 0 0 0 0 0 0 0
A 633 1 0 0 562 116 877 0 0 0 0 0 0 0 0 0 0 0 0 0
A 636 1 0 0 572 122 881 0 0 0 0 0 0 0 0 0 0 0 0 0
A 639 1 0 0 577 122 883 0 0 0 0 0 0 0 0 0 0 0 0 0
A 642 1 0 0 582 122 885 0 0 0 0 0 0 0 0 0 0 0 0 0
A 645 1 0 0 587 122 887 0 0 0 0 0 0 0 0 0 0 0 0 0
A 648 1 0 0 592 122 889 0 0 0 0 0 0 0 0 0 0 0 0 0
A 651 1 0 0 597 122 891 0 0 0 0 0 0 0 0 0 0 0 0 0
A 654 1 0 0 602 122 893 0 0 0 0 0 0 0 0 0 0 0 0 0
A 657 1 0 0 0 128 897 0 0 0 0 0 0 0 0 0 0 0 0 0
A 660 1 0 0 208 128 899 0 0 0 0 0 0 0 0 0 0 0 0 0
A 663 1 0 0 220 134 903 0 0 0 0 0 0 0 0 0 0 0 0 0
A 666 1 0 0 226 134 905 0 0 0 0 0 0 0 0 0 0 0 0 0
A 669 1 0 0 0 134 907 0 0 0 0 0 0 0 0 0 0 0 0 0
A 672 1 0 0 0 140 911 0 0 0 0 0 0 0 0 0 0 0 0 0
A 675 1 0 0 0 140 913 0 0 0 0 0 0 0 0 0 0 0 0 0
A 678 1 0 0 0 140 915 0 0 0 0 0 0 0 0 0 0 0 0 0
A 681 1 0 0 533 146 919 0 0 0 0 0 0 0 0 0 0 0 0 0
A 684 1 0 0 543 146 921 0 0 0 0 0 0 0 0 0 0 0 0 0
A 687 1 0 0 0 152 925 0 0 0 0 0 0 0 0 0 0 0 0 0
A 690 1 0 0 573 152 927 0 0 0 0 0 0 0 0 0 0 0 0 0
A 693 1 0 0 26 152 929 0 0 0 0 0 0 0 0 0 0 0 0 0
A 696 1 0 0 598 158 933 0 0 0 0 0 0 0 0 0 0 0 0 0
A 699 1 0 0 608 158 935 0 0 0 0 0 0 0 0 0 0 0 0 0
A 702 1 0 0 0 164 939 0 0 0 0 0 0 0 0 0 0 0 0 0
A 705 1 0 0 0 164 941 0 0 0 0 0 0 0 0 0 0 0 0 0
A 708 1 0 0 0 170 945 0 0 0 0 0 0 0 0 0 0 0 0 0
A 711 1 0 0 0 170 947 0 0 0 0 0 0 0 0 0 0 0 0 0
A 714 1 0 0 416 176 951 0 0 0 0 0 0 0 0 0 0 0 0 0
A 717 1 0 0 419 176 953 0 0 0 0 0 0 0 0 0 0 0 0 0
A 720 1 0 0 422 176 955 0 0 0 0 0 0 0 0 0 0 0 0 0
A 805 1 0 0 151 322 1182 0 0 0 0 0 0 0 0 0 0 0 0 0
A 808 1 0 0 156 322 1184 0 0 0 0 0 0 0 0 0 0 0 0 0
A 811 1 0 0 161 322 1186 0 0 0 0 0 0 0 0 0 0 0 0 0
A 814 1 0 0 171 328 1190 0 0 0 0 0 0 0 0 0 0 0 0 0
A 817 1 0 0 176 328 1192 0 0 0 0 0 0 0 0 0 0 0 0 0
A 820 1 0 0 181 328 1194 0 0 0 0 0 0 0 0 0 0 0 0 0
A 823 1 0 0 192 334 1198 0 0 0 0 0 0 0 0 0 0 0 0 0
A 826 1 0 0 197 334 1200 0 0 0 0 0 0 0 0 0 0 0 0 0
A 829 1 0 0 202 334 1202 0 0 0 0 0 0 0 0 0 0 0 0 0
A 869 2 0 0 473 6 1574 0 0 0 869 0 0 0 0 0 0 0 0 0
A 1509 1 0 0 0 1445 3065 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1512 1 0 0 0 1445 3067 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1515 1 0 0 1049 1445 3069 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1518 1 0 0 1053 1451 3073 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1521 1 0 0 1273 1451 3075 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1524 1 0 0 1272 1451 3077 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1527 1 0 0 1277 1451 3079 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1530 1 0 0 1276 1451 3081 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1533 1 0 0 847 1451 3083 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1580 1 0 0 1494 1623 3159 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1583 1 0 0 1496 1623 3161 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1586 1 0 0 1108 1623 3163 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7244 1 0 0 7163 1821 3239 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7247 1 0 0 7162 1821 3241 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7250 1 0 0 7167 1821 3243 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7253 1 0 0 7166 1821 3245 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7256 1 0 0 7171 1821 3247 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7259 1 0 0 6888 1827 3251 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7262 1 0 0 6893 1827 3253 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9440 1 0 0 7361 5479 8546 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9443 1 0 0 9297 5479 8548 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9444 2 0 0 8466 6 8837 0 0 0 9444 0 0 0 0 0 0 0 0 0
A 9446 2 0 0 8348 6 8836 0 0 0 9446 0 0 0 0 0 0 0 0 0
A 9532 1 0 0 9343 5728 8848 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9535 1 0 0 9348 5728 8850 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9538 1 0 0 9353 5728 8852 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9541 1 0 0 9352 5728 8854 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9544 1 0 0 9357 5728 8856 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9547 1 0 0 9356 5728 8858 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9550 1 0 0 9267 5728 8860 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9553 1 0 0 7624 5728 8862 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9556 1 0 0 9271 5728 8864 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9559 1 0 0 6131 5728 8866 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9562 1 0 0 8744 5728 8868 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9565 1 0 0 7736 5728 8870 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9568 1 0 0 9361 5728 8872 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9571 1 0 0 9360 5728 8874 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10079 1 0 0 10043 5922 8959 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10082 1 0 0 9705 5922 8961 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10085 1 0 0 9702 5922 8963 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10088 1 0 0 9707 5922 8965 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10091 1 0 0 9320 5922 8967 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10583 1 0 0 10462 6577 9726 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10586 1 0 0 10050 6577 9728 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10589 1 0 0 10052 6577 9730 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10592 1 0 0 9785 6577 9732 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10595 1 0 0 10202 6577 9734 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10598 1 0 0 9789 6577 9736 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10601 1 0 0 10057 6577 9738 0 0 0 0 0 0 0 0 0 0 0 0 0
A 10604 1 0 0 10059 6577 9740 0 0 0 0 0 0 0 0 0 0 0 0 0
A 13705 1 0 0 13572 8586 13224 0 0 0 0 0 0 0 0 0 0 0 0 0
A 13708 1 0 0 13567 8586 13226 0 0 0 0 0 0 0 0 0 0 0 0 0
A 13711 1 0 0 13576 8586 13228 0 0 0 0 0 0 0 0 0 0 0 0 0
A 13714 1 0 0 13571 8586 13230 0 0 0 0 0 0 0 0 0 0 0 0 0
A 13717 1 0 0 13492 8592 13234 0 0 0 0 0 0 0 0 0 0 0 0 0
A 13720 1 0 0 13495 8592 13236 0 0 0 0 0 0 0 0 0 0 0 0 0
A 13723 1 0 0 13496 8592 13238 0 0 0 0 0 0 0 0 0 0 0 0 0
A 13726 1 0 0 13499 8592 13240 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16513 1 0 0 15936 11832 17983 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16516 1 0 0 14940 11832 17985 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16519 1 0 0 13287 11832 17987 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16522 1 0 0 15942 11832 17989 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16525 1 0 0 15659 11832 17991 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16528 1 0 0 15947 11832 17993 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16531 1 0 0 15945 11832 17995 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16739 1 0 0 16363 12671 18422 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16742 1 0 0 16370 12671 18424 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16745 1 0 0 15980 12677 18428 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16748 1 0 0 15978 12677 18430 0 0 0 0 0 0 0 0 0 0 0 0 0
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
V 1509 1445 7 0
S 0 1445 0 0 0
A 0 6 0 0 1 2 0
J 54 1 1
V 1512 1445 7 0
S 0 1445 0 0 0
A 0 6 0 0 1 3 0
J 54 1 1
V 1515 1445 7 0
S 0 1445 0 0 0
A 0 6 0 0 1 45 0
J 66 1 1
V 1518 1451 7 0
S 0 1451 0 0 0
A 0 6 0 0 1 2 0
J 66 1 1
V 1521 1451 7 0
S 0 1451 0 0 0
A 0 6 0 0 1 3 0
J 66 1 1
V 1524 1451 7 0
S 0 1451 0 0 0
A 0 6 0 0 1 45 0
J 66 1 1
V 1527 1451 7 0
S 0 1451 0 0 0
A 0 6 0 0 1 32 0
J 66 1 1
V 1530 1451 7 0
S 0 1451 0 0 0
A 0 6 0 0 1 52 0
J 66 1 1
V 1533 1451 7 0
S 0 1451 0 0 0
A 0 6 0 0 1 56 0
J 68 1 1
V 1580 1623 7 0
S 0 1623 0 0 0
A 0 6 0 0 1 2 0
J 68 1 1
V 1583 1623 7 0
S 0 1623 0 0 0
A 0 6 0 0 1 3 0
J 68 1 1
V 1586 1623 7 0
S 0 1623 0 0 0
A 0 6 0 0 1 45 0
J 71 1 1
V 7244 1821 7 0
S 0 1821 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 7247 1821 7 0
S 0 1821 0 0 0
A 0 6 0 0 1 45 0
J 71 1 1
V 7250 1821 7 0
S 0 1821 0 0 0
A 0 6 0 0 1 32 0
J 71 1 1
V 7253 1821 7 0
S 0 1821 0 0 0
A 0 6 0 0 1 52 0
J 71 1 1
V 7256 1821 7 0
S 0 1821 0 0 0
A 0 6 0 0 1 56 0
J 91 1 1
V 7259 1827 7 0
S 0 1827 0 0 0
A 0 6 0 0 1 3 0
J 91 1 1
V 7262 1827 7 0
S 0 1827 0 0 0
A 0 6 0 0 1 45 0
J 71 1 1
V 9440 5479 7 0
S 0 5479 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 9443 5479 7 0
S 0 5479 0 0 0
A 0 6 0 0 1 45 0
J 79 1 1
V 9532 5728 7 0
S 0 5728 0 0 0
A 0 6 0 0 1 9446 0
J 79 1 1
V 9535 5728 7 0
S 0 5728 0 0 0
A 0 6 0 0 1 27 0
J 84 1 1
V 9538 5728 7 0
S 0 5728 0 0 0
A 0 6 0 0 1 2 0
J 84 1 1
V 9541 5728 7 0
S 0 5728 0 0 0
A 0 6 0 0 1 3 0
J 84 1 1
V 9544 5728 7 0
S 0 5728 0 0 0
A 0 6 0 0 1 45 0
J 84 1 1
V 9547 5728 7 0
S 0 5728 0 0 0
A 0 6 0 0 1 32 0
J 91 1 1
V 9550 5728 7 0
S 0 5728 0 0 0
A 0 6 0 0 1 2 0
J 91 1 1
V 9553 5728 7 0
S 0 5728 0 0 0
A 0 6 0 0 1 3 0
J 91 1 1
V 9556 5728 7 0
S 0 5728 0 0 0
A 0 6 0 0 1 45 0
J 91 1 1
V 9559 5728 7 0
S 0 5728 0 0 0
A 0 6 0 0 1 32 0
J 91 1 1
V 9562 5728 7 0
S 0 5728 0 0 0
A 0 6 0 0 1 52 0
J 91 1 1
V 9565 5728 7 0
S 0 5728 0 0 0
A 0 6 0 0 1 56 0
J 91 1 1
V 9568 5728 7 0
S 0 5728 0 0 0
A 0 6 0 0 1 60 0
J 91 1 1
V 9571 5728 7 0
S 0 5728 0 0 0
A 0 6 0 0 1 21 0
J 72 1 1
V 10079 5922 7 0
S 0 5922 0 0 0
A 0 6 0 0 1 3 0
J 72 1 1
V 10082 5922 7 0
S 0 5922 0 0 0
A 0 6 0 0 1 45 0
J 72 1 1
V 10085 5922 7 0
S 0 5922 0 0 0
A 0 6 0 0 1 32 0
J 72 1 1
V 10088 5922 7 0
S 0 5922 0 0 0
A 0 6 0 0 1 52 0
J 72 1 1
V 10091 5922 7 0
S 0 5922 0 0 0
A 0 6 0 0 1 56 0
J 69 1 1
V 10583 6577 7 0
S 0 6577 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 10586 6577 7 0
S 0 6577 0 0 0
A 0 6 0 0 1 45 0
J 73 1 1
V 10589 6577 7 0
S 0 6577 0 0 0
A 0 6 0 0 1 52 0
J 75 1 1
V 10592 6577 7 0
S 0 6577 0 0 0
A 0 6 0 0 1 95 0
J 77 1 1
V 10595 6577 7 0
S 0 6577 0 0 0
A 0 6 0 0 1 20 0
J 79 1 1
V 10598 6577 7 0
S 0 6577 0 0 0
A 0 6 0 0 1 24 0
J 81 1 1
V 10601 6577 7 0
S 0 6577 0 0 0
A 0 6 0 0 1 869 0
J 83 1 1
V 10604 6577 7 0
S 0 6577 0 0 0
A 0 6 0 0 1 9444 0
J 80 1 1
V 13705 8586 7 0
S 0 8586 0 0 0
A 0 6 0 0 1 27 0
J 80 1 1
V 13708 8586 7 0
S 0 8586 0 0 0
A 0 6 0 0 1 2 0
J 80 1 1
V 13711 8586 7 0
S 0 8586 0 0 0
A 0 6 0 0 1 3 0
J 80 1 1
V 13714 8586 7 0
S 0 8586 0 0 0
A 0 6 0 0 1 45 0
J 96 1 1
V 13717 8592 7 0
S 0 8592 0 0 0
A 0 6 0 0 1 2 0
J 96 1 1
V 13720 8592 7 0
S 0 8592 0 0 0
A 0 6 0 0 1 3 0
J 96 1 1
V 13723 8592 7 0
S 0 8592 0 0 0
A 0 6 0 0 1 45 0
J 96 1 1
V 13726 8592 7 0
S 0 8592 0 0 0
A 0 6 0 0 1 32 0
J 69 1 1
V 16513 11832 7 0
S 0 11832 0 0 0
A 0 6 0 0 1 3 0
J 69 1 1
V 16516 11832 7 0
S 0 11832 0 0 0
A 0 6 0 0 1 45 0
J 69 1 1
V 16519 11832 7 0
S 0 11832 0 0 0
A 0 6 0 0 1 32 0
J 69 1 1
V 16522 11832 7 0
S 0 11832 0 0 0
A 0 6 0 0 1 52 0
J 69 1 1
V 16525 11832 7 0
S 0 11832 0 0 0
A 0 6 0 0 1 56 0
J 69 1 1
V 16528 11832 7 0
S 0 11832 0 0 0
A 0 6 0 0 1 60 0
J 69 1 1
V 16531 11832 7 0
S 0 11832 0 0 0
A 0 6 0 0 1 21 0
J 80 1 1
V 16739 12671 7 0
S 0 12671 0 0 0
A 0 6 0 0 1 2 0
J 80 1 1
V 16742 12671 7 0
S 0 12671 0 0 0
A 0 6 0 0 1 3 0
J 95 1 1
V 16745 12677 7 0
S 0 12677 0 0 0
A 0 6 0 0 1 2 0
J 95 1 1
V 16748 12677 7 0
S 0 12677 0 0 0
A 0 6 0 0 1 3 0
Z
