V24 esmf_localarraymod
101 /global/u2/d/dazlich/cpl40-40/doe_ca/esmf/src/Infrastructure/LocalArray/interface/ESMF_LocalArray.F90 S582 0
11/22/2010  10:52:59
use esmf_localarraycreatemod public 0 direct
use esmf_localarraygetmod public 0 direct
use esmf_arrayspecmod private
use esmf_iospecmod private
use esmf_logerrmod private
use esmf_utiltypesmod private
use esmf_arrayspecmod private
use esmf_iospecmod private
use esmf_logerrmod private
use esmf_utiltypesmod private
enduse
D 46 24 704 4 703 3
D 52 24 720 8 719 7
D 58 24 726 4 725 3
D 70 24 768 36 767 3
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
D 127 24 858 4 857 3
D 133 24 864 4 863 3
D 139 24 880 4 879 3
D 145 24 886 4 885 3
D 151 24 894 4 893 3
D 157 24 902 4 901 3
D 163 24 908 4 907 3
D 169 24 916 4 915 3
D 175 24 922 4 921 3
D 181 24 928 4 927 3
D 187 24 934 4 933 3
D 390 24 1185 4 1184 3
D 396 24 1193 4 1192 3
D 402 24 1201 4 1200 3
D 620 24 1463 4 1462 3
D 626 24 1471 4 1470 3
D 810 24 1562 4 1561 3
D 1014 24 1643 4 1642 3
D 1020 24 1655 4 1654 3
D 3650 18 13
D 3652 18 14
D 3654 18 15
D 3656 18 16
D 3658 18 17
D 3660 18 18
D 3662 18 19
D 3664 18 20
D 3666 18 21
D 3668 18 22
D 3670 18 23
S 582 24 0 0 0 8 1 0 4659 10005 0 0 0 0 0 0 0 0 0 25 0 0 0 0 0 0 0 0 16 0 0 0 0 0 0 esmf_localarraymod
S 586 3 0 0 0 6 1 1 0 0 0 0 0 0 0 -1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 588 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 7 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 589 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 590 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 8 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 593 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 594 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 595 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 5 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 596 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 6 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 598 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 9 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 599 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 600 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 90 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 601 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 91 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 602 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 99 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 603 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 18 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 604 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 25 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 605 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 32 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 606 3 0 0 0 3650 1 1 0 0 0 0 0 0 0 4824 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 42 61 73 65
S 607 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 11 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 608 3 0 0 0 3652 1 1 0 0 0 0 0 0 0 4834 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 49 4f 53 70 65 63
S 609 3 0 0 0 3652 1 1 0 0 0 0 0 0 0 4846 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 4c 6f 67 45 72 72
S 610 3 0 0 0 3650 1 1 0 0 0 0 0 0 0 4858 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 54 69 6d 65
S 611 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 13 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 612 3 0 0 0 3654 1 1 0 0 0 0 0 0 0 4868 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 43 61 6c 65 6e 64 61 72
S 613 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 17 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 614 3 0 0 0 3656 1 1 0 0 0 0 0 0 0 4882 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 54 69 6d 65 49 6e 74 65 72 76 61 6c
S 615 3 0 0 0 3658 1 1 0 0 0 0 0 0 0 4900 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 41 6c 61 72 6d
S 616 3 0 0 0 3658 1 1 0 0 0 0 0 0 0 4911 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 43 6c 6f 63 6b
S 617 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 618 3 0 0 0 3660 1 1 0 0 0 0 0 0 0 4922 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 41 72 72 61 79 53 70 65 63
S 619 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 620 3 0 0 0 3662 1 1 0 0 0 0 0 0 0 4937 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 15 45 53 4d 46 5f 4c 6f 63 61 6c 41 72 72 61 79
S 621 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 622 3 0 0 0 3664 1 1 0 0 0 0 0 0 0 4953 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 41 72 72 61 79 42 75 6e 64 6c 65
S 623 3 0 0 0 3666 1 1 0 0 0 0 0 0 0 4970 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 7 45 53 4d 46 5f 56 4d
S 624 3 0 0 0 3654 1 1 0 0 0 0 0 0 0 4978 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 44 45 4c 61 79 6f 75 74
S 625 3 0 0 0 3652 1 1 0 0 0 0 0 0 0 4992 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 43 6f 6e 66 69 67
S 626 3 0 0 0 3658 1 1 0 0 0 0 0 0 0 5004 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 41 72 72 61 79
S 627 3 0 0 0 3654 1 1 0 0 0 0 0 0 0 5015 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 49 6e 74 65 72 6e 44 47
S 628 3 0 0 0 3660 1 1 0 0 0 0 0 0 0 5029 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 43 6f 6d 6d 54 61 62 6c 65
S 629 3 0 0 0 3662 1 1 0 0 0 0 0 0 0 5044 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 15 45 53 4d 46 5f 52 6f 75 74 65 54 61 62 6c 65
S 630 3 0 0 0 3658 1 1 0 0 0 0 0 0 0 5060 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 52 6f 75 74 65
S 631 3 0 0 0 3664 1 1 0 0 0 0 0 0 0 5071 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 52 6f 75 74 65 48 61 6e 64 6c 65
S 632 3 0 0 0 3656 1 1 0 0 0 0 0 0 0 5088 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 46 69 65 6c 64 44 61 74 61 4d 61 70
S 633 3 0 0 0 3658 1 1 0 0 0 0 0 0 0 5106 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 46 69 65 6c 64
S 634 3 0 0 0 3664 1 1 0 0 0 0 0 0 0 5117 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 46 69 65 6c 64 42 75 6e 64 6c 65
S 635 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 20 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 636 3 0 0 0 3668 1 1 0 0 0 0 0 0 0 5134 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 20 45 53 4d 46 5f 54 72 61 6e 73 66 6f 72 6d 56 61 6c 75 65 73
S 637 3 0 0 0 3652 1 1 0 0 0 0 0 0 0 5155 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 52 65 67 72 69 64
S 638 3 0 0 0 3660 1 1 0 0 0 0 0 0 0 5167 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 54 72 61 6e 73 66 6f 72 6d
S 639 3 0 0 0 3658 1 1 0 0 0 0 0 0 0 5182 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 53 74 61 74 65
S 640 3 0 0 0 3670 1 1 0 0 0 0 0 0 0 5193 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 18 45 53 4d 46 5f 47 72 69 64 43 6f 6d 70 6f 6e 65 6e 74
S 641 3 0 0 0 3656 1 1 0 0 0 0 0 0 0 5212 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 43 70 6c 43 6f 6d 70 6f 6e 65 6e 74
S 642 3 0 0 0 3660 1 1 0 0 0 0 0 0 0 5230 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 43 6f 6d 70 6f 6e 65 6e 74
S 643 3 0 0 0 3664 1 1 0 0 0 0 0 0 0 5245 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 49 6e 74 65 72 6e 41 72 72 61 79
S 644 3 0 0 0 3650 1 1 0 0 0 0 0 0 0 5262 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 4e 6f 6e 65
S 656 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 12 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 662 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 21 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 664 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 22 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 666 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 23 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 668 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 24 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 671 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 26 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 673 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 28 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 675 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 29 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 677 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 30 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 679 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 31 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 682 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 33 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 684 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 34 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 686 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 35 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 688 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 36 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 703 25 13 esmf_utiltypesmod esmf_status
R 704 5 14 esmf_utiltypesmod status esmf_status
R 706 6 16 esmf_utiltypesmod esmf_status_uninit$ac
R 708 6 18 esmf_utiltypesmod esmf_status_ready$ac
R 710 6 20 esmf_utiltypesmod esmf_status_unallocated$ac
R 712 6 22 esmf_utiltypesmod esmf_status_allocated$ac
R 714 6 24 esmf_utiltypesmod esmf_status_busy$ac
R 716 6 26 esmf_utiltypesmod esmf_status_invalid$ac
R 718 6 28 esmf_utiltypesmod esmf_status_not_ready$ac
R 719 25 29 esmf_utiltypesmod esmf_pointer
R 720 5 30 esmf_utiltypesmod ptr esmf_pointer
R 722 6 32 esmf_utiltypesmod esmf_null_pointer$ac
R 724 6 34 esmf_utiltypesmod esmf_bad_pointer$ac
R 725 25 35 esmf_utiltypesmod esmf_typekind
R 726 5 36 esmf_utiltypesmod dkind esmf_typekind
R 728 6 38 esmf_utiltypesmod esmf_typekind_i1$ac
R 730 6 40 esmf_utiltypesmod esmf_typekind_i2$ac
R 732 6 42 esmf_utiltypesmod esmf_typekind_i4$ac
R 734 6 44 esmf_utiltypesmod esmf_typekind_i8$ac
R 736 6 46 esmf_utiltypesmod esmf_typekind_r4$ac
R 738 6 48 esmf_utiltypesmod esmf_typekind_r8$ac
R 740 6 50 esmf_utiltypesmod esmf_c8$ac
R 742 6 52 esmf_utiltypesmod esmf_c16$ac
R 744 6 54 esmf_utiltypesmod esmf_typekind_logical$ac
R 746 6 56 esmf_utiltypesmod esmf_typekind_character$ac
R 748 6 58 esmf_utiltypesmod esmf_typekind_i$ac
R 750 6 60 esmf_utiltypesmod esmf_typekind_r$ac
R 752 6 62 esmf_utiltypesmod esmf_nokind$ac
R 767 25 77 esmf_utiltypesmod esmf_objectid
R 768 5 78 esmf_utiltypesmod objectid esmf_objectid
R 769 5 79 esmf_utiltypesmod objectname esmf_objectid
R 771 6 81 esmf_utiltypesmod esmf_id_base$ac
R 773 6 83 esmf_utiltypesmod esmf_id_iospec$ac
R 775 6 85 esmf_utiltypesmod esmf_id_logerr$ac
R 777 6 87 esmf_utiltypesmod esmf_id_time$ac
R 779 6 89 esmf_utiltypesmod esmf_id_calendar$ac
R 781 6 91 esmf_utiltypesmod esmf_id_timeinterval$ac
R 783 6 93 esmf_utiltypesmod esmf_id_alarm$ac
R 785 6 95 esmf_utiltypesmod esmf_id_clock$ac
R 787 6 97 esmf_utiltypesmod esmf_id_arrayspec$ac
R 789 6 99 esmf_utiltypesmod esmf_id_localarray$ac
R 791 6 101 esmf_utiltypesmod esmf_id_arraybundle$ac
R 793 6 103 esmf_utiltypesmod esmf_id_vm$ac
R 795 6 105 esmf_utiltypesmod esmf_id_delayout$ac
R 797 6 107 esmf_utiltypesmod esmf_id_config$ac
R 799 6 109 esmf_utiltypesmod esmf_id_array$ac
R 801 6 111 esmf_utiltypesmod esmf_id_interndg$ac
R 803 6 113 esmf_utiltypesmod esmf_id_commtable$ac
R 805 6 115 esmf_utiltypesmod esmf_id_routetable$ac
R 807 6 117 esmf_utiltypesmod esmf_id_route$ac
R 809 6 119 esmf_utiltypesmod esmf_id_routehandle$ac
R 811 6 121 esmf_utiltypesmod esmf_id_fielddatamap$ac
R 813 6 123 esmf_utiltypesmod esmf_id_field$ac
R 815 6 125 esmf_utiltypesmod esmf_id_fieldbundle$ac
R 817 6 127 esmf_utiltypesmod esmf_id_transformvalues$ac
R 819 6 129 esmf_utiltypesmod esmf_id_regrid$ac
R 821 6 131 esmf_utiltypesmod esmf_id_transform$ac
R 823 6 133 esmf_utiltypesmod esmf_id_state$ac
R 825 6 135 esmf_utiltypesmod esmf_id_gridcomponent$ac
R 827 6 137 esmf_utiltypesmod esmf_id_cplcomponent$ac
R 829 6 139 esmf_utiltypesmod esmf_id_component$ac
R 831 6 141 esmf_utiltypesmod esmf_id_internarray$ac
R 833 6 143 esmf_utiltypesmod esmf_id_none$ac
R 857 25 167 esmf_utiltypesmod esmf_localglobalflag
R 858 5 168 esmf_utiltypesmod value esmf_localglobalflag
R 860 6 170 esmf_utiltypesmod esmf_local$ac
R 862 6 172 esmf_utiltypesmod esmf_global$ac
R 863 25 173 esmf_utiltypesmod esmf_domaintypeflag
R 864 5 174 esmf_utiltypesmod value esmf_domaintypeflag
R 866 6 176 esmf_utiltypesmod esmf_domain_exclusive$ac
R 868 6 178 esmf_utiltypesmod esmf_domain_computational$ac
R 870 6 180 esmf_utiltypesmod esmf_domain_total$ac
R 872 6 182 esmf_utiltypesmod esmf_domain_allocated$ac
R 874 6 184 esmf_utiltypesmod esmf_domain_oldexclusive$ac
R 876 6 186 esmf_utiltypesmod esmf_domain_oldcomputational$ac
R 878 6 188 esmf_utiltypesmod esmf_domain_oldtotal$ac
R 879 25 189 esmf_utiltypesmod esmf_logical
R 880 5 190 esmf_utiltypesmod value esmf_logical
R 882 6 192 esmf_utiltypesmod esmf_true$ac
R 884 6 194 esmf_utiltypesmod esmf_false$ac
R 885 25 195 esmf_utiltypesmod esmf_reduceflag
R 886 5 196 esmf_utiltypesmod value esmf_reduceflag
R 888 6 198 esmf_utiltypesmod esmf_sum$ac
R 890 6 200 esmf_utiltypesmod esmf_min$ac
R 892 6 202 esmf_utiltypesmod esmf_max$ac
R 893 25 203 esmf_utiltypesmod esmf_blockingflag
R 894 5 204 esmf_utiltypesmod value esmf_blockingflag
R 896 6 206 esmf_utiltypesmod esmf_blocking$ac
R 898 6 208 esmf_utiltypesmod esmf_vasblocking$ac
R 900 6 210 esmf_utiltypesmod esmf_nonblocking$ac
R 901 25 211 esmf_utiltypesmod esmf_contextflag
R 902 5 212 esmf_utiltypesmod value esmf_contextflag
R 904 6 214 esmf_utiltypesmod esmf_child_in_new_vm$ac
R 906 6 216 esmf_utiltypesmod esmf_child_in_parent_vm$ac
R 907 25 217 esmf_utiltypesmod esmf_terminationflag
R 908 5 218 esmf_utiltypesmod value esmf_terminationflag
R 910 6 220 esmf_utiltypesmod esmf_final$ac
R 912 6 222 esmf_utiltypesmod esmf_keepmpi$ac
R 914 6 224 esmf_utiltypesmod esmf_abort$ac
R 915 25 225 esmf_utiltypesmod esmf_depinflag
R 916 5 226 esmf_utiltypesmod value esmf_depinflag
R 918 6 228 esmf_utiltypesmod esmf_de_pin_pet$ac
R 920 6 230 esmf_utiltypesmod esmf_de_pin_vas$ac
R 921 25 231 esmf_utiltypesmod esmf_direction
R 922 5 232 esmf_utiltypesmod value esmf_direction
R 924 6 234 esmf_utiltypesmod esmf_mode_forward$ac
R 926 6 236 esmf_utiltypesmod esmf_mode_reverse$ac
R 927 25 237 esmf_utiltypesmod esmf_indexflag
R 928 5 238 esmf_utiltypesmod i_type esmf_indexflag
R 930 6 240 esmf_utiltypesmod esmf_index_delocal$ac
R 932 6 242 esmf_utiltypesmod esmf_index_global$ac
R 933 25 243 esmf_utiltypesmod esmf_regionflag
R 934 5 244 esmf_utiltypesmod i_type esmf_regionflag
R 936 6 246 esmf_utiltypesmod esmf_region_total$ac
R 938 6 248 esmf_utiltypesmod esmf_region_select$ac
R 940 6 250 esmf_utiltypesmod esmf_region_empty$ac
R 1184 25 1 esmf_logerrmod esmf_msgtype
R 1185 5 2 esmf_logerrmod mtype esmf_msgtype
R 1187 6 4 esmf_logerrmod esmf_log_info$ac
R 1189 6 6 esmf_logerrmod esmf_log_warning$ac
R 1191 6 8 esmf_logerrmod esmf_log_error$ac
R 1192 25 9 esmf_logerrmod esmf_halttype
R 1193 5 10 esmf_logerrmod htype esmf_halttype
R 1195 6 12 esmf_logerrmod esmf_log_haltnever$ac
R 1197 6 14 esmf_logerrmod esmf_log_haltwarning$ac
R 1199 6 16 esmf_logerrmod esmf_log_halterror$ac
R 1200 25 17 esmf_logerrmod esmf_logtype
R 1201 5 18 esmf_logerrmod ftype esmf_logtype
R 1203 6 20 esmf_logerrmod esmf_log_single$ac
R 1205 6 22 esmf_logerrmod esmf_log_multi$ac
R 1207 6 24 esmf_logerrmod esmf_log_none$ac
R 1462 25 1 esmf_iospecmod esmf_iofileformat
R 1463 5 2 esmf_iospecmod iofileformat esmf_iofileformat
R 1465 6 4 esmf_iospecmod esmf_io_fileformat_unspecified$ac
R 1467 6 6 esmf_iospecmod esmf_io_fileformat_netcdf$ac
R 1469 6 8 esmf_iospecmod esmf_io_fileformat_hdf$ac
R 1470 25 9 esmf_iospecmod esmf_iorwtype
R 1471 5 10 esmf_iospecmod iorwtype esmf_iorwtype
R 1473 6 12 esmf_iospecmod esmf_io_rwtype_unspecified$ac
R 1475 6 14 esmf_iospecmod esmf_io_rwtype_readonly$ac
R 1477 6 16 esmf_iospecmod esmf_io_rwtype_writeonly$ac
R 1479 6 18 esmf_iospecmod esmf_io_rwtype_readwrite$ac
R 1481 6 20 esmf_iospecmod esmf_io_rwtype_append$ac
R 1483 6 22 esmf_iospecmod esmf_io_rwtype_truncate$ac
R 1561 25 1 esmf_arrayspecmod esmf_arrayspecstatus
R 1562 5 2 esmf_arrayspecmod status esmf_arrayspecstatus
R 1564 6 4 esmf_arrayspecmod esmf_arrayspec_status_unknown$ac
R 1566 6 6 esmf_arrayspecmod esmf_arrayspec_status_notset$ac
R 1568 6 8 esmf_arrayspecmod esmf_arrayspec_status_set$ac
R 1642 25 1 esmf_localarraycreatemod esmf_copyflag
R 1643 5 2 esmf_localarraycreatemod docopy esmf_copyflag
R 1645 6 4 esmf_localarraycreatemod esmf_data_copy$ac
R 1647 6 6 esmf_localarraycreatemod esmf_data_ref$ac
R 1649 6 8 esmf_localarraycreatemod esmf_data_defer$ac
R 1651 6 10 esmf_localarraycreatemod esmf_data_space$ac
R 1653 6 12 esmf_localarraycreatemod esmf_data_none$ac
R 1654 25 13 esmf_localarraycreatemod esmf_localarrayorigin
R 1655 5 14 esmf_localarraycreatemod origin esmf_localarrayorigin
R 1657 6 16 esmf_localarraycreatemod esmf_from_fortran$ac
R 1659 6 18 esmf_localarraycreatemod esmf_from_cplusplus$ac
A 13 2 0 0 0 6 598 0 0 0 13 0 0 0 0 0 0 0 0 0
A 14 2 0 0 0 6 607 0 0 0 14 0 0 0 0 0 0 0 0 0
A 15 2 0 0 0 6 611 0 0 0 15 0 0 0 0 0 0 0 0 0
A 16 2 0 0 0 6 613 0 0 0 16 0 0 0 0 0 0 0 0 0
A 17 2 0 0 0 6 599 0 0 0 17 0 0 0 0 0 0 0 0 0
A 18 2 0 0 0 6 617 0 0 0 18 0 0 0 0 0 0 0 0 0
A 19 2 0 0 0 6 619 0 0 0 19 0 0 0 0 0 0 0 0 0
A 20 2 0 0 0 6 621 0 0 0 20 0 0 0 0 0 0 0 0 0
A 21 2 0 0 0 6 588 0 0 0 21 0 0 0 0 0 0 0 0 0
A 22 2 0 0 0 6 635 0 0 0 22 0 0 0 0 0 0 0 0 0
A 23 2 0 0 0 6 603 0 0 0 23 0 0 0 0 0 0 0 0 0
A 24 2 0 0 0 6 605 0 0 0 24 0 0 0 0 0 0 0 0 0
A 27 2 0 0 0 6 586 0 0 0 27 0 0 0 0 0 0 0 0 0
A 32 2 0 0 0 6 589 0 0 0 32 0 0 0 0 0 0 0 0 0
A 45 2 0 0 0 6 593 0 0 0 45 0 0 0 0 0 0 0 0 0
A 52 2 0 0 0 6 594 0 0 0 52 0 0 0 0 0 0 0 0 0
A 56 2 0 0 0 6 595 0 0 0 56 0 0 0 0 0 0 0 0 0
A 60 2 0 0 0 6 596 0 0 0 60 0 0 0 0 0 0 0 0 0
A 95 2 0 0 0 6 590 0 0 0 95 0 0 0 0 0 0 0 0 0
A 105 2 0 0 0 6 600 0 0 0 105 0 0 0 0 0 0 0 0 0
A 109 2 0 0 0 6 601 0 0 0 109 0 0 0 0 0 0 0 0 0
A 113 2 0 0 0 6 602 0 0 0 113 0 0 0 0 0 0 0 0 0
A 182 2 0 0 0 6 656 0 0 0 182 0 0 0 0 0 0 0 0 0
A 208 2 0 0 0 6 662 0 0 0 208 0 0 0 0 0 0 0 0 0
A 214 2 0 0 0 6 664 0 0 0 214 0 0 0 0 0 0 0 0 0
A 220 2 0 0 0 6 666 0 0 0 220 0 0 0 0 0 0 0 0 0
A 226 2 0 0 0 6 668 0 0 0 226 0 0 0 0 0 0 0 0 0
A 232 2 0 0 193 6 604 0 0 0 232 0 0 0 0 0 0 0 0 0
A 238 2 0 0 0 6 671 0 0 0 238 0 0 0 0 0 0 0 0 0
A 244 2 0 0 0 6 673 0 0 0 244 0 0 0 0 0 0 0 0 0
A 250 2 0 0 0 6 675 0 0 0 250 0 0 0 0 0 0 0 0 0
A 256 2 0 0 0 6 677 0 0 0 256 0 0 0 0 0 0 0 0 0
A 262 2 0 0 0 6 679 0 0 0 262 0 0 0 0 0 0 0 0 0
A 273 2 0 0 0 6 682 0 0 0 273 0 0 0 0 0 0 0 0 0
A 279 2 0 0 0 6 684 0 0 0 279 0 0 0 0 0 0 0 0 0
A 285 2 0 0 0 6 686 0 0 0 285 0 0 0 0 0 0 0 0 0
A 291 2 0 0 0 6 688 0 0 0 291 0 0 0 0 0 0 0 0 0
A 404 1 0 0 0 46 706 0 0 0 0 0 0 0 0 0 0 0 0 0
A 407 1 0 0 0 46 708 0 0 0 0 0 0 0 0 0 0 0 0 0
A 410 1 0 0 0 46 710 0 0 0 0 0 0 0 0 0 0 0 0 0
A 413 1 0 0 0 46 712 0 0 0 0 0 0 0 0 0 0 0 0 0
A 416 1 0 0 0 46 714 0 0 0 0 0 0 0 0 0 0 0 0 0
A 419 1 0 0 0 46 716 0 0 0 0 0 0 0 0 0 0 0 0 0
A 422 1 0 0 0 46 718 0 0 0 0 0 0 0 0 0 0 0 0 0
A 425 1 0 0 0 52 722 0 0 0 0 0 0 0 0 0 0 0 0 0
A 428 1 0 0 0 52 724 0 0 0 0 0 0 0 0 0 0 0 0 0
A 431 1 0 0 0 58 728 0 0 0 0 0 0 0 0 0 0 0 0 0
A 434 1 0 0 0 58 730 0 0 0 0 0 0 0 0 0 0 0 0 0
A 437 1 0 0 0 58 732 0 0 0 0 0 0 0 0 0 0 0 0 0
A 440 1 0 0 0 58 734 0 0 0 0 0 0 0 0 0 0 0 0 0
A 443 1 0 0 0 58 736 0 0 0 0 0 0 0 0 0 0 0 0 0
A 446 1 0 0 0 58 738 0 0 0 0 0 0 0 0 0 0 0 0 0
A 449 1 0 0 0 58 740 0 0 0 0 0 0 0 0 0 0 0 0 0
A 452 1 0 0 0 58 742 0 0 0 0 0 0 0 0 0 0 0 0 0
A 455 1 0 0 0 58 744 0 0 0 0 0 0 0 0 0 0 0 0 0
A 458 1 0 0 0 58 746 0 0 0 0 0 0 0 0 0 0 0 0 0
A 461 1 0 0 0 58 748 0 0 0 0 0 0 0 0 0 0 0 0 0
A 464 1 0 0 0 58 750 0 0 0 0 0 0 0 0 0 0 0 0 0
A 467 1 0 0 0 58 752 0 0 0 0 0 0 0 0 0 0 0 0 0
A 468 2 0 0 0 78 606 0 0 0 468 0 0 0 0 0 0 0 0 0
A 472 1 0 0 232 70 771 0 0 0 0 0 0 0 0 0 0 0 0 0
A 473 2 0 0 296 80 608 0 0 0 473 0 0 0 0 0 0 0 0 0
A 477 1 0 0 203 70 773 0 0 0 0 0 0 0 0 0 0 0 0 0
A 478 2 0 0 220 80 609 0 0 0 478 0 0 0 0 0 0 0 0 0
A 482 1 0 0 209 70 775 0 0 0 0 0 0 0 0 0 0 0 0 0
A 483 2 0 0 337 78 610 0 0 0 483 0 0 0 0 0 0 0 0 0
A 487 1 0 0 215 70 777 0 0 0 0 0 0 0 0 0 0 0 0 0
A 488 2 0 0 0 82 612 0 0 0 488 0 0 0 0 0 0 0 0 0
A 492 1 0 0 221 70 779 0 0 0 0 0 0 0 0 0 0 0 0 0
A 493 2 0 0 238 84 614 0 0 0 493 0 0 0 0 0 0 0 0 0
A 497 1 0 0 227 70 781 0 0 0 0 0 0 0 0 0 0 0 0 0
A 498 2 0 0 0 86 615 0 0 0 498 0 0 0 0 0 0 0 0 0
A 502 1 0 0 0 70 783 0 0 0 0 0 0 0 0 0 0 0 0 0
A 503 2 0 0 244 86 616 0 0 0 503 0 0 0 0 0 0 0 0 0
A 507 1 0 0 0 70 785 0 0 0 0 0 0 0 0 0 0 0 0 0
A 508 2 0 0 250 88 618 0 0 0 508 0 0 0 0 0 0 0 0 0
A 512 1 0 0 0 70 787 0 0 0 0 0 0 0 0 0 0 0 0 0
A 513 2 0 0 256 90 620 0 0 0 513 0 0 0 0 0 0 0 0 0
A 517 1 0 0 0 70 789 0 0 0 0 0 0 0 0 0 0 0 0 0
A 518 2 0 0 262 92 622 0 0 0 518 0 0 0 0 0 0 0 0 0
A 522 1 0 0 0 70 791 0 0 0 0 0 0 0 0 0 0 0 0 0
A 523 2 0 0 0 94 623 0 0 0 523 0 0 0 0 0 0 0 0 0
A 527 1 0 0 268 70 793 0 0 0 0 0 0 0 0 0 0 0 0 0
A 528 2 0 0 0 82 624 0 0 0 528 0 0 0 0 0 0 0 0 0
A 532 1 0 0 274 70 795 0 0 0 0 0 0 0 0 0 0 0 0 0
A 533 2 0 0 273 80 625 0 0 0 533 0 0 0 0 0 0 0 0 0
A 537 1 0 0 280 70 797 0 0 0 0 0 0 0 0 0 0 0 0 0
A 538 2 0 0 0 86 626 0 0 0 538 0 0 0 0 0 0 0 0 0
A 542 1 0 0 286 70 799 0 0 0 0 0 0 0 0 0 0 0 0 0
A 543 2 0 0 279 82 627 0 0 0 543 0 0 0 0 0 0 0 0 0
A 547 1 0 0 292 70 801 0 0 0 0 0 0 0 0 0 0 0 0 0
A 548 2 0 0 0 88 628 0 0 0 548 0 0 0 0 0 0 0 0 0
A 552 1 0 0 0 70 803 0 0 0 0 0 0 0 0 0 0 0 0 0
A 553 2 0 0 285 90 629 0 0 0 553 0 0 0 0 0 0 0 0 0
A 557 1 0 0 0 70 805 0 0 0 0 0 0 0 0 0 0 0 0 0
A 558 2 0 0 0 86 630 0 0 0 558 0 0 0 0 0 0 0 0 0
A 562 1 0 0 0 70 807 0 0 0 0 0 0 0 0 0 0 0 0 0
A 563 2 0 0 291 92 631 0 0 0 563 0 0 0 0 0 0 0 0 0
A 567 1 0 0 117 70 809 0 0 0 0 0 0 0 0 0 0 0 0 0
A 568 2 0 0 0 84 632 0 0 0 568 0 0 0 0 0 0 0 0 0
A 572 1 0 0 119 70 811 0 0 0 0 0 0 0 0 0 0 0 0 0
A 573 2 0 0 0 86 633 0 0 0 573 0 0 0 0 0 0 0 0 0
A 577 1 0 0 121 70 813 0 0 0 0 0 0 0 0 0 0 0 0 0
A 578 2 0 0 0 92 634 0 0 0 578 0 0 0 0 0 0 0 0 0
A 582 1 0 0 123 70 815 0 0 0 0 0 0 0 0 0 0 0 0 0
A 583 2 0 0 0 96 636 0 0 0 583 0 0 0 0 0 0 0 0 0
A 587 1 0 0 0 70 817 0 0 0 0 0 0 0 0 0 0 0 0 0
A 588 2 0 0 0 80 637 0 0 0 588 0 0 0 0 0 0 0 0 0
A 592 1 0 0 125 70 819 0 0 0 0 0 0 0 0 0 0 0 0 0
A 593 2 0 0 0 88 638 0 0 0 593 0 0 0 0 0 0 0 0 0
A 597 1 0 0 0 70 821 0 0 0 0 0 0 0 0 0 0 0 0 0
A 598 2 0 0 0 86 639 0 0 0 598 0 0 0 0 0 0 0 0 0
A 602 1 0 0 182 70 823 0 0 0 0 0 0 0 0 0 0 0 0 0
A 603 2 0 0 0 98 640 0 0 0 603 0 0 0 0 0 0 0 0 0
A 607 1 0 0 0 70 825 0 0 0 0 0 0 0 0 0 0 0 0 0
A 608 2 0 0 0 84 641 0 0 0 608 0 0 0 0 0 0 0 0 0
A 612 1 0 0 0 70 827 0 0 0 0 0 0 0 0 0 0 0 0 0
A 613 2 0 0 0 88 642 0 0 0 613 0 0 0 0 0 0 0 0 0
A 617 1 0 0 208 70 829 0 0 0 0 0 0 0 0 0 0 0 0 0
A 618 2 0 0 0 92 643 0 0 0 618 0 0 0 0 0 0 0 0 0
A 622 1 0 0 214 70 831 0 0 0 0 0 0 0 0 0 0 0 0 0
A 623 2 0 0 38 78 644 0 0 0 623 0 0 0 0 0 0 0 0 0
A 627 1 0 0 478 70 833 0 0 0 0 0 0 0 0 0 0 0 0 0
A 630 1 0 0 0 127 860 0 0 0 0 0 0 0 0 0 0 0 0 0
A 633 1 0 0 0 127 862 0 0 0 0 0 0 0 0 0 0 0 0 0
A 636 1 0 0 572 133 866 0 0 0 0 0 0 0 0 0 0 0 0 0
A 639 1 0 0 577 133 868 0 0 0 0 0 0 0 0 0 0 0 0 0
A 642 1 0 0 582 133 870 0 0 0 0 0 0 0 0 0 0 0 0 0
A 645 1 0 0 587 133 872 0 0 0 0 0 0 0 0 0 0 0 0 0
A 648 1 0 0 592 133 874 0 0 0 0 0 0 0 0 0 0 0 0 0
A 651 1 0 0 597 133 876 0 0 0 0 0 0 0 0 0 0 0 0 0
A 654 1 0 0 602 133 878 0 0 0 0 0 0 0 0 0 0 0 0 0
A 657 1 0 0 612 139 882 0 0 0 0 0 0 0 0 0 0 0 0 0
A 660 1 0 0 617 139 884 0 0 0 0 0 0 0 0 0 0 0 0 0
A 663 1 0 0 0 145 888 0 0 0 0 0 0 0 0 0 0 0 0 0
A 666 1 0 0 0 145 890 0 0 0 0 0 0 0 0 0 0 0 0 0
A 669 1 0 0 0 145 892 0 0 0 0 0 0 0 0 0 0 0 0 0
A 672 1 0 0 0 151 896 0 0 0 0 0 0 0 0 0 0 0 0 0
A 675 1 0 0 0 151 898 0 0 0 0 0 0 0 0 0 0 0 0 0
A 678 1 0 0 0 151 900 0 0 0 0 0 0 0 0 0 0 0 0 0
A 681 1 0 0 10 157 904 0 0 0 0 0 0 0 0 0 0 0 0 0
A 684 1 0 0 11 157 906 0 0 0 0 0 0 0 0 0 0 0 0 0
A 687 1 0 0 0 163 910 0 0 0 0 0 0 0 0 0 0 0 0 0
A 690 1 0 0 0 163 912 0 0 0 0 0 0 0 0 0 0 0 0 0
A 693 1 0 0 0 163 914 0 0 0 0 0 0 0 0 0 0 0 0 0
A 696 1 0 0 0 169 918 0 0 0 0 0 0 0 0 0 0 0 0 0
A 699 1 0 0 0 169 920 0 0 0 0 0 0 0 0 0 0 0 0 0
A 702 1 0 0 0 175 924 0 0 0 0 0 0 0 0 0 0 0 0 0
A 705 1 0 0 0 175 926 0 0 0 0 0 0 0 0 0 0 0 0 0
A 708 1 0 0 407 181 930 0 0 0 0 0 0 0 0 0 0 0 0 0
A 711 1 0 0 410 181 932 0 0 0 0 0 0 0 0 0 0 0 0 0
A 714 1 0 0 416 187 936 0 0 0 0 0 0 0 0 0 0 0 0 0
A 717 1 0 0 419 187 938 0 0 0 0 0 0 0 0 0 0 0 0 0
A 720 1 0 0 422 187 940 0 0 0 0 0 0 0 0 0 0 0 0 0
A 805 1 0 0 101 390 1187 0 0 0 0 0 0 0 0 0 0 0 0 0
A 808 1 0 0 104 390 1189 0 0 0 0 0 0 0 0 0 0 0 0 0
A 811 1 0 0 108 390 1191 0 0 0 0 0 0 0 0 0 0 0 0 0
A 814 1 0 0 0 396 1195 0 0 0 0 0 0 0 0 0 0 0 0 0
A 817 1 0 0 0 396 1197 0 0 0 0 0 0 0 0 0 0 0 0 0
A 820 1 0 0 0 396 1199 0 0 0 0 0 0 0 0 0 0 0 0 0
A 823 1 0 0 766 402 1203 0 0 0 0 0 0 0 0 0 0 0 0 0
A 826 1 0 0 319 402 1205 0 0 0 0 0 0 0 0 0 0 0 0 0
A 829 1 0 0 322 402 1207 0 0 0 0 0 0 0 0 0 0 0 0 0
A 891 1 0 0 25 620 1465 0 0 0 0 0 0 0 0 0 0 0 0 0
A 894 1 0 0 28 620 1467 0 0 0 0 0 0 0 0 0 0 0 0 0
A 897 1 0 0 31 620 1469 0 0 0 0 0 0 0 0 0 0 0 0 0
A 900 1 0 0 0 626 1473 0 0 0 0 0 0 0 0 0 0 0 0 0
A 903 1 0 0 0 626 1475 0 0 0 0 0 0 0 0 0 0 0 0 0
A 906 1 0 0 0 626 1477 0 0 0 0 0 0 0 0 0 0 0 0 0
A 909 1 0 0 0 626 1479 0 0 0 0 0 0 0 0 0 0 0 0 0
A 912 1 0 0 0 626 1481 0 0 0 0 0 0 0 0 0 0 0 0 0
A 915 1 0 0 0 626 1483 0 0 0 0 0 0 0 0 0 0 0 0 0
A 962 1 0 0 0 810 1564 0 0 0 0 0 0 0 0 0 0 0 0 0
A 965 1 0 0 0 810 1566 0 0 0 0 0 0 0 0 0 0 0 0 0
A 968 1 0 0 0 810 1568 0 0 0 0 0 0 0 0 0 0 0 0 0
A 6626 1 0 0 6323 1014 1645 0 0 0 0 0 0 0 0 0 0 0 0 0
A 6629 1 0 0 6322 1014 1647 0 0 0 0 0 0 0 0 0 0 0 0 0
A 6632 1 0 0 6327 1014 1649 0 0 0 0 0 0 0 0 0 0 0 0 0
A 6635 1 0 0 6326 1014 1651 0 0 0 0 0 0 0 0 0 0 0 0 0
A 6638 1 0 0 6331 1014 1653 0 0 0 0 0 0 0 0 0 0 0 0 0
A 6641 1 0 0 6338 1020 1657 0 0 0 0 0 0 0 0 0 0 0 0 0
A 6644 1 0 0 6342 1020 1659 0 0 0 0 0 0 0 0 0 0 0 0 0
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
V 891 620 7 0
S 0 620 0 0 0
A 0 6 0 0 1 2 0
J 54 1 1
V 894 620 7 0
S 0 620 0 0 0
A 0 6 0 0 1 3 0
J 54 1 1
V 897 620 7 0
S 0 620 0 0 0
A 0 6 0 0 1 45 0
J 66 1 1
V 900 626 7 0
S 0 626 0 0 0
A 0 6 0 0 1 2 0
J 66 1 1
V 903 626 7 0
S 0 626 0 0 0
A 0 6 0 0 1 3 0
J 66 1 1
V 906 626 7 0
S 0 626 0 0 0
A 0 6 0 0 1 45 0
J 66 1 1
V 909 626 7 0
S 0 626 0 0 0
A 0 6 0 0 1 32 0
J 66 1 1
V 912 626 7 0
S 0 626 0 0 0
A 0 6 0 0 1 52 0
J 66 1 1
V 915 626 7 0
S 0 626 0 0 0
A 0 6 0 0 1 56 0
J 68 1 1
V 962 810 7 0
S 0 810 0 0 0
A 0 6 0 0 1 2 0
J 68 1 1
V 965 810 7 0
S 0 810 0 0 0
A 0 6 0 0 1 3 0
J 68 1 1
V 968 810 7 0
S 0 810 0 0 0
A 0 6 0 0 1 45 0
J 77 1 1
V 6626 1014 7 0
S 0 1014 0 0 0
A 0 6 0 0 1 3 0
J 77 1 1
V 6629 1014 7 0
S 0 1014 0 0 0
A 0 6 0 0 1 45 0
J 77 1 1
V 6632 1014 7 0
S 0 1014 0 0 0
A 0 6 0 0 1 32 0
J 77 1 1
V 6635 1014 7 0
S 0 1014 0 0 0
A 0 6 0 0 1 52 0
J 77 1 1
V 6638 1014 7 0
S 0 1014 0 0 0
A 0 6 0 0 1 56 0
J 97 1 1
V 6641 1020 7 0
S 0 1020 0 0 0
A 0 6 0 0 1 3 0
J 97 1 1
V 6644 1020 7 0
S 0 1020 0 0 0
A 0 6 0 0 1 45 0
Z