V24 esmf_localarraymod
85 /u0/d/dazlich/doe_ca/esmf/src/Infrastructure/LocalArray/interface/ESMF_LocalArray.F90 S582 0
08/28/2008  11:54:29
use esmf_localarraycreatemod public 0 direct
use esmf_localarraygetmod public 0 direct
use esmf_arrayspecmod private
use esmf_iospecmod private
use esmf_logerrmod private
use esmf_utiltypesmod private
enduse
D 35 24 704 4 703 3
D 41 24 720 8 719 7
D 47 24 726 4 725 3
D 59 24 768 36 767 3
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
D 116 24 858 4 857 3
D 122 24 864 4 863 3
D 128 24 880 4 879 3
D 134 24 886 4 885 3
D 140 24 894 4 893 3
D 146 24 902 4 901 3
D 152 24 908 4 907 3
D 158 24 916 4 915 3
D 164 24 922 4 921 3
D 170 24 928 4 927 3
D 176 24 934 4 933 3
D 322 24 1166 4 1165 3
D 328 24 1174 4 1173 3
D 334 24 1182 4 1181 3
D 534 24 1438 4 1437 3
D 540 24 1446 4 1445 3
D 712 24 1533 4 1532 3
D 910 24 1612 4 1611 3
D 916 24 1624 4 1623 3
D 3411 18 13
D 3413 18 14
D 3415 18 15
D 3417 18 16
D 3419 18 17
D 3421 18 18
D 3423 18 19
D 3425 18 20
D 3427 18 21
D 3429 18 22
D 3431 18 23
S 582 24 0 0 0 8 1 0 4668 5 0 0 0 0 0 0 0 0 0 25 0 0 0 0 0 0 0 0 16 0 0 0 0 0 0 esmf_localarraymod
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
S 606 3 0 0 0 3411 1 1 0 0 0 0 0 0 0 4833 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 42 61 73 65
S 607 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 11 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 608 3 0 0 0 3413 1 1 0 0 0 0 0 0 0 4843 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 49 4f 53 70 65 63
S 609 3 0 0 0 3413 1 1 0 0 0 0 0 0 0 4855 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 4c 6f 67 45 72 72
S 610 3 0 0 0 3411 1 1 0 0 0 0 0 0 0 4867 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 54 69 6d 65
S 611 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 13 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 612 3 0 0 0 3415 1 1 0 0 0 0 0 0 0 4877 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 43 61 6c 65 6e 64 61 72
S 613 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 17 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 614 3 0 0 0 3417 1 1 0 0 0 0 0 0 0 4891 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 54 69 6d 65 49 6e 74 65 72 76 61 6c
S 615 3 0 0 0 3419 1 1 0 0 0 0 0 0 0 4909 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 41 6c 61 72 6d
S 616 3 0 0 0 3419 1 1 0 0 0 0 0 0 0 4920 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 43 6c 6f 63 6b
S 617 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 618 3 0 0 0 3421 1 1 0 0 0 0 0 0 0 4931 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 41 72 72 61 79 53 70 65 63
S 619 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 620 3 0 0 0 3423 1 1 0 0 0 0 0 0 0 4946 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 15 45 53 4d 46 5f 4c 6f 63 61 6c 41 72 72 61 79
S 621 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 622 3 0 0 0 3425 1 1 0 0 0 0 0 0 0 4962 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 41 72 72 61 79 42 75 6e 64 6c 65
S 623 3 0 0 0 3427 1 1 0 0 0 0 0 0 0 4979 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 7 45 53 4d 46 5f 56 4d
S 624 3 0 0 0 3415 1 1 0 0 0 0 0 0 0 4987 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 44 45 4c 61 79 6f 75 74
S 625 3 0 0 0 3413 1 1 0 0 0 0 0 0 0 5001 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 43 6f 6e 66 69 67
S 626 3 0 0 0 3419 1 1 0 0 0 0 0 0 0 5013 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 41 72 72 61 79
S 627 3 0 0 0 3415 1 1 0 0 0 0 0 0 0 5024 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 49 6e 74 65 72 6e 44 47
S 628 3 0 0 0 3421 1 1 0 0 0 0 0 0 0 5038 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 43 6f 6d 6d 54 61 62 6c 65
S 629 3 0 0 0 3423 1 1 0 0 0 0 0 0 0 5053 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 15 45 53 4d 46 5f 52 6f 75 74 65 54 61 62 6c 65
S 630 3 0 0 0 3419 1 1 0 0 0 0 0 0 0 5069 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 52 6f 75 74 65
S 631 3 0 0 0 3425 1 1 0 0 0 0 0 0 0 5080 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 52 6f 75 74 65 48 61 6e 64 6c 65
S 632 3 0 0 0 3417 1 1 0 0 0 0 0 0 0 5097 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 46 69 65 6c 64 44 61 74 61 4d 61 70
S 633 3 0 0 0 3419 1 1 0 0 0 0 0 0 0 5115 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 46 69 65 6c 64
S 634 3 0 0 0 3425 1 1 0 0 0 0 0 0 0 5126 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 46 69 65 6c 64 42 75 6e 64 6c 65
S 635 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 20 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 636 3 0 0 0 3429 1 1 0 0 0 0 0 0 0 5143 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 20 45 53 4d 46 5f 54 72 61 6e 73 66 6f 72 6d 56 61 6c 75 65 73
S 637 3 0 0 0 3413 1 1 0 0 0 0 0 0 0 5164 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 52 65 67 72 69 64
S 638 3 0 0 0 3421 1 1 0 0 0 0 0 0 0 5176 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 54 72 61 6e 73 66 6f 72 6d
S 639 3 0 0 0 3419 1 1 0 0 0 0 0 0 0 5191 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 53 74 61 74 65
S 640 3 0 0 0 3431 1 1 0 0 0 0 0 0 0 5202 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 18 45 53 4d 46 5f 47 72 69 64 43 6f 6d 70 6f 6e 65 6e 74
S 641 3 0 0 0 3417 1 1 0 0 0 0 0 0 0 5221 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 43 70 6c 43 6f 6d 70 6f 6e 65 6e 74
S 642 3 0 0 0 3421 1 1 0 0 0 0 0 0 0 5239 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 43 6f 6d 70 6f 6e 65 6e 74
S 643 3 0 0 0 3425 1 1 0 0 0 0 0 0 0 5254 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 49 6e 74 65 72 6e 41 72 72 61 79
S 644 3 0 0 0 3411 1 1 0 0 0 0 0 0 0 5271 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 4e 6f 6e 65
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
R 704 5 14 esmf_utiltypesmod status
R 706 6 16 esmf_utiltypesmod esmf_status_uninit$ac
R 708 6 18 esmf_utiltypesmod esmf_status_ready$ac
R 710 6 20 esmf_utiltypesmod esmf_status_unallocated$ac
R 712 6 22 esmf_utiltypesmod esmf_status_allocated$ac
R 714 6 24 esmf_utiltypesmod esmf_status_busy$ac
R 716 6 26 esmf_utiltypesmod esmf_status_invalid$ac
R 718 6 28 esmf_utiltypesmod esmf_status_not_ready$ac
R 719 25 29 esmf_utiltypesmod esmf_pointer
R 720 5 30 esmf_utiltypesmod ptr
R 722 6 32 esmf_utiltypesmod esmf_null_pointer$ac
R 724 6 34 esmf_utiltypesmod esmf_bad_pointer$ac
R 725 25 35 esmf_utiltypesmod esmf_typekind
R 726 5 36 esmf_utiltypesmod dkind
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
R 768 5 78 esmf_utiltypesmod objectid
R 769 5 79 esmf_utiltypesmod objectname
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
R 858 5 168 esmf_utiltypesmod value
R 860 6 170 esmf_utiltypesmod esmf_local$ac
R 862 6 172 esmf_utiltypesmod esmf_global$ac
R 863 25 173 esmf_utiltypesmod esmf_domaintypeflag
R 864 5 174 esmf_utiltypesmod value
R 866 6 176 esmf_utiltypesmod esmf_domain_exclusive$ac
R 868 6 178 esmf_utiltypesmod esmf_domain_computational$ac
R 870 6 180 esmf_utiltypesmod esmf_domain_total$ac
R 872 6 182 esmf_utiltypesmod esmf_domain_allocated$ac
R 874 6 184 esmf_utiltypesmod esmf_domain_oldexclusive$ac
R 876 6 186 esmf_utiltypesmod esmf_domain_oldcomputational$ac
R 878 6 188 esmf_utiltypesmod esmf_domain_oldtotal$ac
R 879 25 189 esmf_utiltypesmod esmf_logical
R 880 5 190 esmf_utiltypesmod value
R 882 6 192 esmf_utiltypesmod esmf_true$ac
R 884 6 194 esmf_utiltypesmod esmf_false$ac
R 885 25 195 esmf_utiltypesmod esmf_reduceflag
R 886 5 196 esmf_utiltypesmod value
R 888 6 198 esmf_utiltypesmod esmf_sum$ac
R 890 6 200 esmf_utiltypesmod esmf_min$ac
R 892 6 202 esmf_utiltypesmod esmf_max$ac
R 893 25 203 esmf_utiltypesmod esmf_blockingflag
R 894 5 204 esmf_utiltypesmod value
R 896 6 206 esmf_utiltypesmod esmf_blocking$ac
R 898 6 208 esmf_utiltypesmod esmf_vasblocking$ac
R 900 6 210 esmf_utiltypesmod esmf_nonblocking$ac
R 901 25 211 esmf_utiltypesmod esmf_contextflag
R 902 5 212 esmf_utiltypesmod value
R 904 6 214 esmf_utiltypesmod esmf_child_in_new_vm$ac
R 906 6 216 esmf_utiltypesmod esmf_child_in_parent_vm$ac
R 907 25 217 esmf_utiltypesmod esmf_terminationflag
R 908 5 218 esmf_utiltypesmod value
R 910 6 220 esmf_utiltypesmod esmf_final$ac
R 912 6 222 esmf_utiltypesmod esmf_keepmpi$ac
R 914 6 224 esmf_utiltypesmod esmf_abort$ac
R 915 25 225 esmf_utiltypesmod esmf_depinflag
R 916 5 226 esmf_utiltypesmod value
R 918 6 228 esmf_utiltypesmod esmf_de_pin_pet$ac
R 920 6 230 esmf_utiltypesmod esmf_de_pin_vas$ac
R 921 25 231 esmf_utiltypesmod esmf_direction
R 922 5 232 esmf_utiltypesmod value
R 924 6 234 esmf_utiltypesmod esmf_mode_forward$ac
R 926 6 236 esmf_utiltypesmod esmf_mode_reverse$ac
R 927 25 237 esmf_utiltypesmod esmf_indexflag
R 928 5 238 esmf_utiltypesmod i_type
R 930 6 240 esmf_utiltypesmod esmf_index_delocal$ac
R 932 6 242 esmf_utiltypesmod esmf_index_global$ac
R 933 25 243 esmf_utiltypesmod esmf_regionflag
R 934 5 244 esmf_utiltypesmod i_type
R 936 6 246 esmf_utiltypesmod esmf_region_total$ac
R 938 6 248 esmf_utiltypesmod esmf_region_select$ac
R 940 6 250 esmf_utiltypesmod esmf_region_empty$ac
R 1165 25 1 esmf_logerrmod esmf_msgtype
R 1166 5 2 esmf_logerrmod mtype
R 1168 6 4 esmf_logerrmod esmf_log_info$ac
R 1170 6 6 esmf_logerrmod esmf_log_warning$ac
R 1172 6 8 esmf_logerrmod esmf_log_error$ac
R 1173 25 9 esmf_logerrmod esmf_halttype
R 1174 5 10 esmf_logerrmod htype
R 1176 6 12 esmf_logerrmod esmf_log_haltnever$ac
R 1178 6 14 esmf_logerrmod esmf_log_haltwarning$ac
R 1180 6 16 esmf_logerrmod esmf_log_halterror$ac
R 1181 25 17 esmf_logerrmod esmf_logtype
R 1182 5 18 esmf_logerrmod ftype
R 1184 6 20 esmf_logerrmod esmf_log_single$ac
R 1186 6 22 esmf_logerrmod esmf_log_multi$ac
R 1188 6 24 esmf_logerrmod esmf_log_none$ac
R 1437 25 1 esmf_iospecmod esmf_iofileformat
R 1438 5 2 esmf_iospecmod iofileformat
R 1440 6 4 esmf_iospecmod esmf_io_fileformat_unspecified$ac
R 1442 6 6 esmf_iospecmod esmf_io_fileformat_netcdf$ac
R 1444 6 8 esmf_iospecmod esmf_io_fileformat_hdf$ac
R 1445 25 9 esmf_iospecmod esmf_iorwtype
R 1446 5 10 esmf_iospecmod iorwtype
R 1448 6 12 esmf_iospecmod esmf_io_rwtype_unspecified$ac
R 1450 6 14 esmf_iospecmod esmf_io_rwtype_readonly$ac
R 1452 6 16 esmf_iospecmod esmf_io_rwtype_writeonly$ac
R 1454 6 18 esmf_iospecmod esmf_io_rwtype_readwrite$ac
R 1456 6 20 esmf_iospecmod esmf_io_rwtype_append$ac
R 1458 6 22 esmf_iospecmod esmf_io_rwtype_truncate$ac
R 1532 25 1 esmf_arrayspecmod esmf_arrayspecstatus
R 1533 5 2 esmf_arrayspecmod status
R 1535 6 4 esmf_arrayspecmod esmf_arrayspec_status_unknown$ac
R 1537 6 6 esmf_arrayspecmod esmf_arrayspec_status_notset$ac
R 1539 6 8 esmf_arrayspecmod esmf_arrayspec_status_set$ac
R 1611 25 1 esmf_localarraycreatemod esmf_copyflag
R 1612 5 2 esmf_localarraycreatemod docopy
R 1614 6 4 esmf_localarraycreatemod esmf_data_copy$ac
R 1616 6 6 esmf_localarraycreatemod esmf_data_ref$ac
R 1618 6 8 esmf_localarraycreatemod esmf_data_defer$ac
R 1620 6 10 esmf_localarraycreatemod esmf_data_space$ac
R 1622 6 12 esmf_localarraycreatemod esmf_data_none$ac
R 1623 25 13 esmf_localarraycreatemod esmf_localarrayorigin
R 1624 5 14 esmf_localarraycreatemod origin
R 1626 6 16 esmf_localarraycreatemod esmf_from_fortran$ac
R 1628 6 18 esmf_localarraycreatemod esmf_from_cplusplus$ac
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
A 404 1 0 0 319 35 706 0 0 0 0 0 0 0 0 0 0 0 0 0
A 407 1 0 0 322 35 708 0 0 0 0 0 0 0 0 0 0 0 0 0
A 410 1 0 0 325 35 710 0 0 0 0 0 0 0 0 0 0 0 0 0
A 413 1 0 0 272 35 712 0 0 0 0 0 0 0 0 0 0 0 0 0
A 416 1 0 0 278 35 714 0 0 0 0 0 0 0 0 0 0 0 0 0
A 419 1 0 0 284 35 716 0 0 0 0 0 0 0 0 0 0 0 0 0
A 422 1 0 0 290 35 718 0 0 0 0 0 0 0 0 0 0 0 0 0
A 425 1 0 0 0 41 722 0 0 0 0 0 0 0 0 0 0 0 0 0
A 428 1 0 0 0 41 724 0 0 0 0 0 0 0 0 0 0 0 0 0
A 431 1 0 0 0 47 728 0 0 0 0 0 0 0 0 0 0 0 0 0
A 434 1 0 0 0 47 730 0 0 0 0 0 0 0 0 0 0 0 0 0
A 437 1 0 0 0 47 732 0 0 0 0 0 0 0 0 0 0 0 0 0
A 440 1 0 0 0 47 734 0 0 0 0 0 0 0 0 0 0 0 0 0
A 443 1 0 0 0 47 736 0 0 0 0 0 0 0 0 0 0 0 0 0
A 446 1 0 0 0 47 738 0 0 0 0 0 0 0 0 0 0 0 0 0
A 449 1 0 0 0 47 740 0 0 0 0 0 0 0 0 0 0 0 0 0
A 452 1 0 0 0 47 742 0 0 0 0 0 0 0 0 0 0 0 0 0
A 455 1 0 0 0 47 744 0 0 0 0 0 0 0 0 0 0 0 0 0
A 458 1 0 0 0 47 746 0 0 0 0 0 0 0 0 0 0 0 0 0
A 461 1 0 0 0 47 748 0 0 0 0 0 0 0 0 0 0 0 0 0
A 464 1 0 0 0 47 750 0 0 0 0 0 0 0 0 0 0 0 0 0
A 467 1 0 0 0 47 752 0 0 0 0 0 0 0 0 0 0 0 0 0
A 468 2 0 0 0 67 606 0 0 0 468 0 0 0 0 0 0 0 0 0
A 472 1 0 0 0 59 771 0 0 0 0 0 0 0 0 0 0 0 0 0
A 473 2 0 0 0 69 608 0 0 0 473 0 0 0 0 0 0 0 0 0
A 477 1 0 0 0 59 773 0 0 0 0 0 0 0 0 0 0 0 0 0
A 478 2 0 0 0 69 609 0 0 0 478 0 0 0 0 0 0 0 0 0
A 482 1 0 0 0 59 775 0 0 0 0 0 0 0 0 0 0 0 0 0
A 483 2 0 0 0 67 610 0 0 0 483 0 0 0 0 0 0 0 0 0
A 487 1 0 0 0 59 777 0 0 0 0 0 0 0 0 0 0 0 0 0
A 488 2 0 0 0 71 612 0 0 0 488 0 0 0 0 0 0 0 0 0
A 492 1 0 0 0 59 779 0 0 0 0 0 0 0 0 0 0 0 0 0
A 493 2 0 0 0 73 614 0 0 0 493 0 0 0 0 0 0 0 0 0
A 497 1 0 0 0 59 781 0 0 0 0 0 0 0 0 0 0 0 0 0
A 498 2 0 0 0 75 615 0 0 0 498 0 0 0 0 0 0 0 0 0
A 502 1 0 0 0 59 783 0 0 0 0 0 0 0 0 0 0 0 0 0
A 503 2 0 0 0 75 616 0 0 0 503 0 0 0 0 0 0 0 0 0
A 507 1 0 0 0 59 785 0 0 0 0 0 0 0 0 0 0 0 0 0
A 508 2 0 0 0 77 618 0 0 0 508 0 0 0 0 0 0 0 0 0
A 512 1 0 0 401 59 787 0 0 0 0 0 0 0 0 0 0 0 0 0
A 513 2 0 0 0 79 620 0 0 0 513 0 0 0 0 0 0 0 0 0
A 517 1 0 0 0 59 789 0 0 0 0 0 0 0 0 0 0 0 0 0
A 518 2 0 0 262 81 622 0 0 0 518 0 0 0 0 0 0 0 0 0
A 522 1 0 0 0 59 791 0 0 0 0 0 0 0 0 0 0 0 0 0
A 523 2 0 0 0 83 623 0 0 0 523 0 0 0 0 0 0 0 0 0
A 527 1 0 0 0 59 793 0 0 0 0 0 0 0 0 0 0 0 0 0
A 528 2 0 0 352 71 624 0 0 0 528 0 0 0 0 0 0 0 0 0
A 532 1 0 0 0 59 795 0 0 0 0 0 0 0 0 0 0 0 0 0
A 533 2 0 0 10 69 625 0 0 0 533 0 0 0 0 0 0 0 0 0
A 537 1 0 0 394 59 797 0 0 0 0 0 0 0 0 0 0 0 0 0
A 538 2 0 0 355 75 626 0 0 0 538 0 0 0 0 0 0 0 0 0
A 542 1 0 0 0 59 799 0 0 0 0 0 0 0 0 0 0 0 0 0
A 543 2 0 0 11 71 627 0 0 0 543 0 0 0 0 0 0 0 0 0
A 547 1 0 0 0 59 801 0 0 0 0 0 0 0 0 0 0 0 0 0
A 548 2 0 0 0 77 628 0 0 0 548 0 0 0 0 0 0 0 0 0
A 552 1 0 0 0 59 803 0 0 0 0 0 0 0 0 0 0 0 0 0
A 553 2 0 0 0 79 629 0 0 0 553 0 0 0 0 0 0 0 0 0
A 557 1 0 0 0 59 805 0 0 0 0 0 0 0 0 0 0 0 0 0
A 558 2 0 0 358 75 630 0 0 0 558 0 0 0 0 0 0 0 0 0
A 562 1 0 0 0 59 807 0 0 0 0 0 0 0 0 0 0 0 0 0
A 563 2 0 0 291 81 631 0 0 0 563 0 0 0 0 0 0 0 0 0
A 567 1 0 0 0 59 809 0 0 0 0 0 0 0 0 0 0 0 0 0
A 568 2 0 0 361 73 632 0 0 0 568 0 0 0 0 0 0 0 0 0
A 572 1 0 0 0 59 811 0 0 0 0 0 0 0 0 0 0 0 0 0
A 573 2 0 0 0 75 633 0 0 0 573 0 0 0 0 0 0 0 0 0
A 577 1 0 0 0 59 813 0 0 0 0 0 0 0 0 0 0 0 0 0
A 578 2 0 0 0 81 634 0 0 0 578 0 0 0 0 0 0 0 0 0
A 582 1 0 0 0 59 815 0 0 0 0 0 0 0 0 0 0 0 0 0
A 583 2 0 0 0 85 636 0 0 0 583 0 0 0 0 0 0 0 0 0
A 587 1 0 0 41 59 817 0 0 0 0 0 0 0 0 0 0 0 0 0
A 588 2 0 0 30 69 637 0 0 0 588 0 0 0 0 0 0 0 0 0
A 592 1 0 0 44 59 819 0 0 0 0 0 0 0 0 0 0 0 0 0
A 593 2 0 0 367 77 638 0 0 0 593 0 0 0 0 0 0 0 0 0
A 597 1 0 0 48 59 821 0 0 0 0 0 0 0 0 0 0 0 0 0
A 598 2 0 0 33 75 639 0 0 0 598 0 0 0 0 0 0 0 0 0
A 602 1 0 0 51 59 823 0 0 0 0 0 0 0 0 0 0 0 0 0
A 603 2 0 0 0 87 640 0 0 0 603 0 0 0 0 0 0 0 0 0
A 607 1 0 0 385 59 825 0 0 0 0 0 0 0 0 0 0 0 0 0
A 608 2 0 0 35 73 641 0 0 0 608 0 0 0 0 0 0 0 0 0
A 612 1 0 0 388 59 827 0 0 0 0 0 0 0 0 0 0 0 0 0
A 613 2 0 0 36 77 642 0 0 0 613 0 0 0 0 0 0 0 0 0
A 617 1 0 0 391 59 829 0 0 0 0 0 0 0 0 0 0 0 0 0
A 618 2 0 0 0 81 643 0 0 0 618 0 0 0 0 0 0 0 0 0
A 622 1 0 0 0 59 831 0 0 0 0 0 0 0 0 0 0 0 0 0
A 623 2 0 0 38 67 644 0 0 0 623 0 0 0 0 0 0 0 0 0
A 627 1 0 0 66 59 833 0 0 0 0 0 0 0 0 0 0 0 0 0
A 630 1 0 0 557 116 860 0 0 0 0 0 0 0 0 0 0 0 0 0
A 633 1 0 0 562 116 862 0 0 0 0 0 0 0 0 0 0 0 0 0
A 636 1 0 0 572 122 866 0 0 0 0 0 0 0 0 0 0 0 0 0
A 639 1 0 0 577 122 868 0 0 0 0 0 0 0 0 0 0 0 0 0
A 642 1 0 0 582 122 870 0 0 0 0 0 0 0 0 0 0 0 0 0
A 645 1 0 0 587 122 872 0 0 0 0 0 0 0 0 0 0 0 0 0
A 648 1 0 0 592 122 874 0 0 0 0 0 0 0 0 0 0 0 0 0
A 651 1 0 0 597 122 876 0 0 0 0 0 0 0 0 0 0 0 0 0
A 654 1 0 0 602 122 878 0 0 0 0 0 0 0 0 0 0 0 0 0
A 657 1 0 0 0 128 882 0 0 0 0 0 0 0 0 0 0 0 0 0
A 660 1 0 0 208 128 884 0 0 0 0 0 0 0 0 0 0 0 0 0
A 663 1 0 0 220 134 888 0 0 0 0 0 0 0 0 0 0 0 0 0
A 666 1 0 0 226 134 890 0 0 0 0 0 0 0 0 0 0 0 0 0
A 669 1 0 0 0 134 892 0 0 0 0 0 0 0 0 0 0 0 0 0
A 672 1 0 0 0 140 896 0 0 0 0 0 0 0 0 0 0 0 0 0
A 675 1 0 0 0 140 898 0 0 0 0 0 0 0 0 0 0 0 0 0
A 678 1 0 0 0 140 900 0 0 0 0 0 0 0 0 0 0 0 0 0
A 681 1 0 0 533 146 904 0 0 0 0 0 0 0 0 0 0 0 0 0
A 684 1 0 0 543 146 906 0 0 0 0 0 0 0 0 0 0 0 0 0
A 687 1 0 0 0 152 910 0 0 0 0 0 0 0 0 0 0 0 0 0
A 690 1 0 0 573 152 912 0 0 0 0 0 0 0 0 0 0 0 0 0
A 693 1 0 0 26 152 914 0 0 0 0 0 0 0 0 0 0 0 0 0
A 696 1 0 0 598 158 918 0 0 0 0 0 0 0 0 0 0 0 0 0
A 699 1 0 0 608 158 920 0 0 0 0 0 0 0 0 0 0 0 0 0
A 702 1 0 0 0 164 924 0 0 0 0 0 0 0 0 0 0 0 0 0
A 705 1 0 0 0 164 926 0 0 0 0 0 0 0 0 0 0 0 0 0
A 708 1 0 0 0 170 930 0 0 0 0 0 0 0 0 0 0 0 0 0
A 711 1 0 0 0 170 932 0 0 0 0 0 0 0 0 0 0 0 0 0
A 714 1 0 0 416 176 936 0 0 0 0 0 0 0 0 0 0 0 0 0
A 717 1 0 0 419 176 938 0 0 0 0 0 0 0 0 0 0 0 0 0
A 720 1 0 0 422 176 940 0 0 0 0 0 0 0 0 0 0 0 0 0
A 805 1 0 0 497 322 1168 0 0 0 0 0 0 0 0 0 0 0 0 0
A 808 1 0 0 502 322 1170 0 0 0 0 0 0 0 0 0 0 0 0 0
A 811 1 0 0 507 322 1172 0 0 0 0 0 0 0 0 0 0 0 0 0
A 814 1 0 0 517 328 1176 0 0 0 0 0 0 0 0 0 0 0 0 0
A 817 1 0 0 522 328 1178 0 0 0 0 0 0 0 0 0 0 0 0 0
A 820 1 0 0 527 328 1180 0 0 0 0 0 0 0 0 0 0 0 0 0
A 823 1 0 0 537 334 1184 0 0 0 0 0 0 0 0 0 0 0 0 0
A 826 1 0 0 542 334 1186 0 0 0 0 0 0 0 0 0 0 0 0 0
A 829 1 0 0 547 334 1188 0 0 0 0 0 0 0 0 0 0 0 0 0
A 891 1 0 0 141 534 1440 0 0 0 0 0 0 0 0 0 0 0 0 0
A 894 1 0 0 146 534 1442 0 0 0 0 0 0 0 0 0 0 0 0 0
A 897 1 0 0 721 534 1444 0 0 0 0 0 0 0 0 0 0 0 0 0
A 900 1 0 0 727 540 1448 0 0 0 0 0 0 0 0 0 0 0 0 0
A 903 1 0 0 166 540 1450 0 0 0 0 0 0 0 0 0 0 0 0 0
A 906 1 0 0 730 540 1452 0 0 0 0 0 0 0 0 0 0 0 0 0
A 909 1 0 0 733 540 1454 0 0 0 0 0 0 0 0 0 0 0 0 0
A 912 1 0 0 736 540 1456 0 0 0 0 0 0 0 0 0 0 0 0 0
A 915 1 0 0 187 540 1458 0 0 0 0 0 0 0 0 0 0 0 0 0
A 962 1 0 0 404 712 1535 0 0 0 0 0 0 0 0 0 0 0 0 0
A 965 1 0 0 407 712 1537 0 0 0 0 0 0 0 0 0 0 0 0 0
A 968 1 0 0 410 712 1539 0 0 0 0 0 0 0 0 0 0 0 0 0
A 6626 1 0 0 6318 910 1614 0 0 0 0 0 0 0 0 0 0 0 0 0
A 6629 1 0 0 6282 910 1616 0 0 0 0 0 0 0 0 0 0 0 0 0
A 6632 1 0 0 5760 910 1618 0 0 0 0 0 0 0 0 0 0 0 0 0
A 6635 1 0 0 6283 910 1620 0 0 0 0 0 0 0 0 0 0 0 0 0
A 6638 1 0 0 5764 910 1622 0 0 0 0 0 0 0 0 0 0 0 0 0
A 6641 1 0 0 6200 916 1626 0 0 0 0 0 0 0 0 0 0 0 0 0
A 6644 1 0 0 6204 916 1628 0 0 0 0 0 0 0 0 0 0 0 0 0
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
V 891 534 7 0
S 0 534 0 0 0
A 0 6 0 0 1 2 0
J 54 1 1
V 894 534 7 0
S 0 534 0 0 0
A 0 6 0 0 1 3 0
J 54 1 1
V 897 534 7 0
S 0 534 0 0 0
A 0 6 0 0 1 45 0
J 66 1 1
V 900 540 7 0
S 0 540 0 0 0
A 0 6 0 0 1 2 0
J 66 1 1
V 903 540 7 0
S 0 540 0 0 0
A 0 6 0 0 1 3 0
J 66 1 1
V 906 540 7 0
S 0 540 0 0 0
A 0 6 0 0 1 45 0
J 66 1 1
V 909 540 7 0
S 0 540 0 0 0
A 0 6 0 0 1 32 0
J 66 1 1
V 912 540 7 0
S 0 540 0 0 0
A 0 6 0 0 1 52 0
J 66 1 1
V 915 540 7 0
S 0 540 0 0 0
A 0 6 0 0 1 56 0
J 68 1 1
V 962 712 7 0
S 0 712 0 0 0
A 0 6 0 0 1 2 0
J 68 1 1
V 965 712 7 0
S 0 712 0 0 0
A 0 6 0 0 1 3 0
J 68 1 1
V 968 712 7 0
S 0 712 0 0 0
A 0 6 0 0 1 45 0
J 71 1 1
V 6626 910 7 0
S 0 910 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 6629 910 7 0
S 0 910 0 0 0
A 0 6 0 0 1 45 0
J 71 1 1
V 6632 910 7 0
S 0 910 0 0 0
A 0 6 0 0 1 32 0
J 71 1 1
V 6635 910 7 0
S 0 910 0 0 0
A 0 6 0 0 1 52 0
J 71 1 1
V 6638 910 7 0
S 0 910 0 0 0
A 0 6 0 0 1 56 0
J 91 1 1
V 6641 916 7 0
S 0 916 0 0 0
A 0 6 0 0 1 3 0
J 91 1 1
V 6644 916 7 0
S 0 916 0 0 0
A 0 6 0 0 1 45 0
Z
