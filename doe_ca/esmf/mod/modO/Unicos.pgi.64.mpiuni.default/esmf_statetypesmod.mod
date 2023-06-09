V24 esmf_statetypesmod
74 /u0/d/dazlich/doe_ca/esmf/src/Superstructure/State/src/ESMF_StateTypes.F90 S582 0
08/28/2008  11:59:01
use esmf_internarraydatamapmod private
use esmf_gridmod private
use esmf_staggerlocmod private
use esmf_calendarmod private
use esmf_distgridmod private
use esmf_routemod private
use esmf_localarraycreatemod private
use esmf_arrayspecmod private
use esmf_delayoutmod private
use esmf_iospecmod private
use esmf_logerrmod private
use esmf_utiltypesmod private
use esmf_basemod private
use esmf_rhandlemod private
use esmf_arraybundlemod private
use esmf_arraycreatemod private
use esmf_fieldbundlemod private
use esmf_fieldmod private
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
D 540 24 1446 16 1445 7
D 737 24 1608 4 1607 3
D 743 24 1616 4 1615 3
D 1632 24 3094 4 3093 3
D 1881 24 3390 4 3389 3
D 2079 24 3469 4 3468 3
D 2085 24 3481 4 3480 3
D 4664 24 7991 4 7990 3
D 5073 24 8375 4 8374 3
D 5542 24 9077 16 9076 7
D 7275 24 12256 16 12255 7
D 9164 18 12780
D 10606 24 16229 16 16228 7
D 10839 24 16512 4 16511 3
D 11192 24 16748 4 16747 3
D 11440 24 16866 4 16865 3
D 11446 24 16876 4 16875 3
D 12395 24 18372 4 18371 3
D 12401 24 18378 4 18377 3
D 12428 24 18402 16 18401 7
D 12643 24 18722 4 18721 3
D 12655 24 18733 4 18732 3
D 12661 24 18763 4 18762 3
D 13264 18 13
D 13266 18 14
D 13268 18 15
D 13270 18 16
D 13272 18 17
D 13274 18 18
D 13276 18 19
D 13278 18 20
D 13280 18 21
D 13282 18 22
D 13284 18 23
D 13286 24 19345 4 19344 3
D 13322 24 19385 16 19384 7
D 13391 24 19874 4 19873 3
D 13397 24 19884 4 19883 3
D 13403 24 19916 4 19915 3
D 13409 24 19922 4 19921 3
D 13415 24 19930 4 19929 3
D 13421 24 19936 4 19935 3
D 13427 24 19944 96 19943 7
D 13433 24 19966 144 19949 7
D 13439 21 6 1 0 3 0 0 0 0 0
 0 3 0 3 3 0
D 13442 24 19956 264 19955 7
D 13448 18 29
D 13450 21 13442 1 17315 17314 0 1 0 0 1
 17309 17312 17313 17309 17312 17310
D 13453 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 13456 24 19983 16 19982 7
D 13462 21 6 1 0 3 0 0 0 0 0
 0 3 0 3 3 0
S 582 24 0 0 0 8 1 0 4668 5 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 15 0 0 0 0 0 0 esmf_statetypesmod
S 594 3 0 0 0 6 1 1 0 0 0 0 0 0 0 -1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 595 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 128 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
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
S 614 3 0 0 0 13264 1 1 0 0 0 0 0 0 0 4943 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 42 61 73 65
S 615 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 11 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 616 3 0 0 0 13266 1 1 0 0 0 0 0 0 0 4953 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 49 4f 53 70 65 63
S 617 3 0 0 0 13266 1 1 0 0 0 0 0 0 0 4965 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 4c 6f 67 45 72 72
S 618 3 0 0 0 13264 1 1 0 0 0 0 0 0 0 4977 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 54 69 6d 65
S 619 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 13 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 620 3 0 0 0 13268 1 1 0 0 0 0 0 0 0 4987 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 43 61 6c 65 6e 64 61 72
S 621 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 17 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 622 3 0 0 0 13270 1 1 0 0 0 0 0 0 0 5001 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 54 69 6d 65 49 6e 74 65 72 76 61 6c
S 623 3 0 0 0 13272 1 1 0 0 0 0 0 0 0 5019 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 41 6c 61 72 6d
S 624 3 0 0 0 13272 1 1 0 0 0 0 0 0 0 5030 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 43 6c 6f 63 6b
S 625 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 626 3 0 0 0 13274 1 1 0 0 0 0 0 0 0 5041 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 41 72 72 61 79 53 70 65 63
S 627 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 628 3 0 0 0 13276 1 1 0 0 0 0 0 0 0 5056 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 15 45 53 4d 46 5f 4c 6f 63 61 6c 41 72 72 61 79
S 629 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 630 3 0 0 0 13278 1 1 0 0 0 0 0 0 0 5072 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 41 72 72 61 79 42 75 6e 64 6c 65
S 631 3 0 0 0 13280 1 1 0 0 0 0 0 0 0 5089 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 7 45 53 4d 46 5f 56 4d
S 632 3 0 0 0 13268 1 1 0 0 0 0 0 0 0 5097 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 44 45 4c 61 79 6f 75 74
S 633 3 0 0 0 13266 1 1 0 0 0 0 0 0 0 5111 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 43 6f 6e 66 69 67
S 634 3 0 0 0 13272 1 1 0 0 0 0 0 0 0 5123 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 41 72 72 61 79
S 635 3 0 0 0 13268 1 1 0 0 0 0 0 0 0 5134 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 49 6e 74 65 72 6e 44 47
S 636 3 0 0 0 13274 1 1 0 0 0 0 0 0 0 5148 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 43 6f 6d 6d 54 61 62 6c 65
S 637 3 0 0 0 13276 1 1 0 0 0 0 0 0 0 5163 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 15 45 53 4d 46 5f 52 6f 75 74 65 54 61 62 6c 65
S 638 3 0 0 0 13272 1 1 0 0 0 0 0 0 0 5179 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 52 6f 75 74 65
S 639 3 0 0 0 13278 1 1 0 0 0 0 0 0 0 5190 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 52 6f 75 74 65 48 61 6e 64 6c 65
S 640 3 0 0 0 13270 1 1 0 0 0 0 0 0 0 5207 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 46 69 65 6c 64 44 61 74 61 4d 61 70
S 641 3 0 0 0 13272 1 1 0 0 0 0 0 0 0 5225 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 46 69 65 6c 64
S 642 3 0 0 0 13278 1 1 0 0 0 0 0 0 0 5236 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 46 69 65 6c 64 42 75 6e 64 6c 65
S 643 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 20 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 644 3 0 0 0 13282 1 1 0 0 0 0 0 0 0 5253 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 20 45 53 4d 46 5f 54 72 61 6e 73 66 6f 72 6d 56 61 6c 75 65 73
S 645 3 0 0 0 13266 1 1 0 0 0 0 0 0 0 5274 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 52 65 67 72 69 64
S 646 3 0 0 0 13274 1 1 0 0 0 0 0 0 0 5286 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 54 72 61 6e 73 66 6f 72 6d
S 647 3 0 0 0 13272 1 1 0 0 0 0 0 0 0 5301 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 53 74 61 74 65
S 648 3 0 0 0 13284 1 1 0 0 0 0 0 0 0 5312 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 18 45 53 4d 46 5f 47 72 69 64 43 6f 6d 70 6f 6e 65 6e 74
S 649 3 0 0 0 13270 1 1 0 0 0 0 0 0 0 5331 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 43 70 6c 43 6f 6d 70 6f 6e 65 6e 74
S 650 3 0 0 0 13274 1 1 0 0 0 0 0 0 0 5349 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 43 6f 6d 70 6f 6e 65 6e 74
S 651 3 0 0 0 13278 1 1 0 0 0 0 0 0 0 5364 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 49 6e 74 65 72 6e 41 72 72 61 79
S 652 3 0 0 0 13264 1 1 0 0 0 0 0 0 0 5381 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 4e 6f 6e 65
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
R 959 26 261 esmf_utiltypesmod ==
O 959 5 20003 20002 20001 20000 19999
R 960 26 262 esmf_utiltypesmod !=
O 960 5 20008 20007 20006 20005 20004
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
R 1445 25 1 esmf_basemod esmf_base
R 1446 5 2 esmf_basemod this
R 1447 5 3 esmf_basemod isinit
R 1607 25 1 esmf_iospecmod esmf_iofileformat
R 1608 5 2 esmf_iospecmod iofileformat
R 1610 6 4 esmf_iospecmod esmf_io_fileformat_unspecified$ac
R 1612 6 6 esmf_iospecmod esmf_io_fileformat_netcdf$ac
R 1614 6 8 esmf_iospecmod esmf_io_fileformat_hdf$ac
R 1615 25 9 esmf_iospecmod esmf_iorwtype
R 1616 5 10 esmf_iospecmod iorwtype
R 1618 6 12 esmf_iospecmod esmf_io_rwtype_unspecified$ac
R 1620 6 14 esmf_iospecmod esmf_io_rwtype_readonly$ac
R 1622 6 16 esmf_iospecmod esmf_io_rwtype_writeonly$ac
R 1624 6 18 esmf_iospecmod esmf_io_rwtype_readwrite$ac
R 1626 6 20 esmf_iospecmod esmf_io_rwtype_append$ac
R 1628 6 22 esmf_iospecmod esmf_io_rwtype_truncate$ac
R 3093 25 4 esmf_delayoutmod esmf_delayoutservicereply
R 3094 5 5 esmf_delayoutmod value
R 3096 6 7 esmf_delayoutmod esmf_delayout_service_accept$ac
R 3098 6 9 esmf_delayoutmod esmf_delayout_service_deny$ac
R 3389 25 1 esmf_arrayspecmod esmf_arrayspecstatus
R 3390 5 2 esmf_arrayspecmod status
R 3392 6 4 esmf_arrayspecmod esmf_arrayspec_status_unknown$ac
R 3394 6 6 esmf_arrayspecmod esmf_arrayspec_status_notset$ac
R 3396 6 8 esmf_arrayspecmod esmf_arrayspec_status_set$ac
R 3468 25 1 esmf_localarraycreatemod esmf_copyflag
R 3469 5 2 esmf_localarraycreatemod docopy
R 3471 6 4 esmf_localarraycreatemod esmf_data_copy$ac
R 3473 6 6 esmf_localarraycreatemod esmf_data_ref$ac
R 3475 6 8 esmf_localarraycreatemod esmf_data_defer$ac
R 3477 6 10 esmf_localarraycreatemod esmf_data_space$ac
R 3479 6 12 esmf_localarraycreatemod esmf_data_none$ac
R 3480 25 13 esmf_localarraycreatemod esmf_localarrayorigin
R 3481 5 14 esmf_localarraycreatemod origin
R 3483 6 16 esmf_localarraycreatemod esmf_from_fortran$ac
R 3485 6 18 esmf_localarraycreatemod esmf_from_cplusplus$ac
S 7985 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 69 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 7990 25 4 esmf_routemod esmf_routeoptions
R 7991 5 5 esmf_routemod option
R 7993 6 7 esmf_routemod esmf_route_option_async$ac
R 7995 6 9 esmf_routemod esmf_route_option_sync$ac
R 7997 6 11 esmf_routemod esmf_route_option_pack_pet$ac
R 7999 6 13 esmf_routemod esmf_route_option_pack_xp$ac
R 8001 6 15 esmf_routemod esmf_route_option_pack_nopack$ac
R 8003 6 17 esmf_routemod esmf_route_option_pack_vector$ac
R 8005 6 19 esmf_routemod esmf_route_option_pack_buffer$ac
R 8007 6 21 esmf_routemod esmf_route_option_default$ac
R 8374 25 4 esmf_distgridmod esmf_decompflag
R 8375 5 5 esmf_distgridmod value
R 8377 6 7 esmf_distgridmod esmf_decomp_default$ac
R 8379 6 9 esmf_distgridmod esmf_decomp_homogen$ac
R 8381 6 11 esmf_distgridmod esmf_decomp_restfirst$ac
R 8383 6 13 esmf_distgridmod esmf_decomp_restlast$ac
R 8385 6 15 esmf_distgridmod esmf_decomp_cyclic$ac
R 9076 25 1 esmf_arraycreatemod esmf_array
R 9077 5 2 esmf_arraycreatemod this
R 9078 5 3 esmf_arraycreatemod isinit
R 12255 25 28 esmf_rhandlemod esmf_routehandle
R 12256 5 29 esmf_rhandlemod this
R 12257 5 30 esmf_rhandlemod isinit
S 13188 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 70 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 16228 25 1 esmf_arraybundlemod esmf_arraybundle
R 16229 5 2 esmf_arraybundlemod this
R 16230 5 3 esmf_arraybundlemod isinit
R 16511 25 2 esmf_calendarmod esmf_calendartype
R 16512 5 3 esmf_calendarmod calendartype
R 16514 6 5 esmf_calendarmod esmf_cal_gregorian$ac
R 16516 6 7 esmf_calendarmod esmf_cal_julian$ac
R 16518 6 9 esmf_calendarmod esmf_cal_julianday$ac
R 16520 6 11 esmf_calendarmod esmf_cal_noleap$ac
R 16522 6 13 esmf_calendarmod esmf_cal_360day$ac
R 16524 6 15 esmf_calendarmod esmf_cal_custom$ac
R 16526 6 17 esmf_calendarmod esmf_cal_nocalendar$ac
S 16745 3 0 0 0 6 1 1 0 0 0 0 0 0 0 -1 -2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 16747 25 1 esmf_staggerlocmod esmf_staggerloc
R 16748 5 2 esmf_staggerlocmod staggerloc
R 16756 6 10 esmf_staggerlocmod esmf_staggerloc_invalid$ac
R 16758 6 12 esmf_staggerlocmod esmf_staggerloc_uninit$ac
R 16760 6 14 esmf_staggerlocmod esmf_staggerloc_center$ac
R 16762 6 16 esmf_staggerlocmod esmf_staggerloc_edge1$ac
R 16764 6 18 esmf_staggerlocmod esmf_staggerloc_edge2$ac
R 16766 6 20 esmf_staggerlocmod esmf_staggerloc_corner$ac
R 16768 6 22 esmf_staggerlocmod esmf_staggerloc_center_vcenter$ac
R 16770 6 24 esmf_staggerlocmod esmf_staggerloc_edge1_vcenter$ac
R 16772 6 26 esmf_staggerlocmod esmf_staggerloc_edge2_vcenter$ac
R 16774 6 28 esmf_staggerlocmod esmf_staggerloc_corner_vcenter$ac
R 16776 6 30 esmf_staggerlocmod esmf_staggerloc_center_vface$ac
R 16778 6 32 esmf_staggerlocmod esmf_staggerloc_edge1_vface$ac
R 16780 6 34 esmf_staggerlocmod esmf_staggerloc_edge2_vface$ac
R 16782 6 36 esmf_staggerlocmod esmf_staggerloc_corner_vface$ac
R 16865 25 4 esmf_gridmod esmf_gridstatus
R 16866 5 5 esmf_gridmod gridstatus
R 16868 6 7 esmf_gridmod esmf_gridstatus_invalid$ac
R 16870 6 9 esmf_gridmod esmf_gridstatus_uninit$ac
R 16872 6 11 esmf_gridmod esmf_gridstatus_not_ready$ac
R 16874 6 13 esmf_gridmod esmf_gridstatus_shape_ready$ac
R 16875 25 14 esmf_gridmod esmf_gridconn
R 16876 5 15 esmf_gridmod gridconn
R 16878 6 17 esmf_gridmod esmf_gridconn_none$ac
R 16880 6 19 esmf_gridmod esmf_gridconn_periodic$ac
R 16882 6 21 esmf_gridmod esmf_gridconn_pole$ac
R 16884 6 23 esmf_gridmod esmf_gridconn_bipole$ac
R 18371 25 1 esmf_fieldmod esmf_access
R 18372 5 2 esmf_fieldmod a_type
R 18374 6 4 esmf_fieldmod esmf_readwrite$ac
R 18376 6 6 esmf_fieldmod esmf_readonly$ac
R 18377 25 7 esmf_fieldmod esmf_allocflag
R 18378 5 8 esmf_fieldmod a_type
R 18380 6 10 esmf_fieldmod esmf_alloc$ac
R 18382 6 12 esmf_fieldmod esmf_no_alloc$ac
R 18401 25 31 esmf_fieldmod esmf_field
R 18402 5 32 esmf_fieldmod ftypep
R 18404 5 34 esmf_fieldmod ftypep$p
R 18406 5 36 esmf_fieldmod isinit
R 18721 25 1 esmf_internarraydatamapmod esmf_interleaveflag
R 18722 5 2 esmf_internarraydatamapmod il
R 18724 6 4 esmf_internarraydatamapmod esmf_interleave_by_block$ac
R 18726 6 6 esmf_internarraydatamapmod esmf_interleave_by_item$ac
R 18732 25 12 esmf_internarraydatamapmod esmf_relloc
R 18733 5 13 esmf_internarraydatamapmod relloc
R 18735 6 15 esmf_internarraydatamapmod esmf_cell_undefined$ac
R 18737 6 17 esmf_internarraydatamapmod esmf_cell_center$ac
R 18739 6 19 esmf_internarraydatamapmod esmf_cell_nface$ac
R 18741 6 21 esmf_internarraydatamapmod esmf_cell_sface$ac
R 18743 6 23 esmf_internarraydatamapmod esmf_cell_eface$ac
R 18745 6 25 esmf_internarraydatamapmod esmf_cell_wface$ac
R 18747 6 27 esmf_internarraydatamapmod esmf_cell_necorner$ac
R 18749 6 29 esmf_internarraydatamapmod esmf_cell_nwcorner$ac
R 18751 6 31 esmf_internarraydatamapmod esmf_cell_secorner$ac
R 18753 6 33 esmf_internarraydatamapmod esmf_cell_swcorner$ac
R 18755 6 35 esmf_internarraydatamapmod esmf_cell_topface$ac
R 18757 6 37 esmf_internarraydatamapmod esmf_cell_botface$ac
R 18759 6 39 esmf_internarraydatamapmod esmf_cell_cell$ac
R 18761 6 41 esmf_internarraydatamapmod esmf_cell_vertex$ac
R 18762 25 42 esmf_internarraydatamapmod esmf_indexorder
R 18763 5 43 esmf_internarraydatamapmod iorder
R 18765 6 45 esmf_internarraydatamapmod esmf_index_i$ac
R 18767 6 47 esmf_internarraydatamapmod esmf_index_ij$ac
R 18769 6 49 esmf_internarraydatamapmod esmf_index_ji$ac
R 18771 6 51 esmf_internarraydatamapmod esmf_index_ijk$ac
R 18773 6 53 esmf_internarraydatamapmod esmf_index_jik$ac
R 18775 6 55 esmf_internarraydatamapmod esmf_index_kji$ac
R 18777 6 57 esmf_internarraydatamapmod esmf_index_ikj$ac
R 18779 6 59 esmf_internarraydatamapmod esmf_index_jki$ac
R 18781 6 61 esmf_internarraydatamapmod esmf_index_kij$ac
R 19344 25 1 esmf_fieldbundlemod esmf_packflag
R 19345 5 2 esmf_fieldbundlemod packflag
R 19347 6 4 esmf_fieldbundlemod esmf_packed_data$ac
R 19349 6 6 esmf_fieldbundlemod esmf_no_packed_data$ac
R 19384 25 41 esmf_fieldbundlemod esmf_fieldbundle
R 19385 5 42 esmf_fieldbundlemod btypep
R 19387 5 44 esmf_fieldbundlemod btypep$p
R 19389 5 46 esmf_fieldbundlemod isinit
S 19873 25 1 0 0 13391 1 582 84959 800004 800000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_statetype
S 19874 5 0 0 0 6 1 582 84974 80000c 0 0 0 0 0 13391 0 0 0 0 0 0 0 0 0 0 0 1 19874 0 582 0 0 0 0 state
S 19875 16 0 0 0 13391 1 582 84980 4 400000 0 0 0 0 19876 1 0 0 0 0 0 0 0 0 0 0 0 17226 0 582 0 0 0 0 esmf_state_import
S 19876 6 4 0 0 13391 19878 582 84998 4080005c 400000 0 0 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17226 0 582 0 19875 0 0 esmf_state_import$ac
S 19877 16 0 0 0 13391 1 582 85019 4 400000 0 0 0 0 19878 2 0 0 0 0 0 0 0 0 0 0 0 17229 0 582 0 0 0 0 esmf_state_export
S 19878 6 4 0 0 13391 19880 582 85037 4080005c 400000 0 4 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17229 0 582 0 19877 0 0 esmf_state_export$ac
S 19879 16 0 0 0 13391 1 582 85058 4 400000 0 0 0 0 19880 3 0 0 0 0 0 0 0 0 0 0 0 17232 0 582 0 0 0 0 esmf_state_unspecified
S 19880 6 4 0 0 13391 19882 582 85081 4080005c 400000 0 8 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17232 0 582 0 19879 0 0 esmf_state_unspecified$ac
S 19881 16 0 0 0 13391 1 582 85107 4 400000 0 0 0 0 19882 4 0 0 0 0 0 0 0 0 0 0 0 17235 0 582 0 0 0 0 esmf_state_invalid
S 19882 6 4 0 0 13391 19887 582 85126 4080005c 400000 0 12 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17235 0 582 0 19881 0 0 esmf_state_invalid$ac
S 19883 25 1 0 0 13397 1 582 85148 800004 800000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_stateitemtype
S 19884 5 0 0 0 6 1 582 85167 80000c 0 0 0 0 0 13397 0 0 0 0 0 0 0 0 0 0 0 1 19884 0 582 0 0 0 0 ot
S 19885 16 0 0 0 13397 1 582 85170 4 400000 0 0 0 0 19887 5 0 0 0 0 0 0 0 0 0 0 0 17239 0 582 0 0 0 0 esmf_stateitem_field
S 19886 3 0 0 0 6 0 1 0 0 0 0 0 0 0 0 101 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 19887 6 4 0 0 13397 19890 582 85191 4080005c 400000 0 16 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17239 0 582 0 19885 0 0 esmf_stateitem_field$ac
S 19888 16 0 0 0 13397 1 582 85215 4 400000 0 0 0 0 19890 6 0 0 0 0 0 0 0 0 0 0 0 17243 0 582 0 0 0 0 esmf_stateitem_fieldbundle
S 19889 3 0 0 0 6 0 1 0 0 0 0 0 0 0 0 102 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 19890 6 4 0 0 13397 19893 582 85242 4080005c 400000 0 20 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17243 0 582 0 19888 0 0 esmf_stateitem_fieldbundle$ac
S 19891 16 0 0 0 13397 1 582 85272 4 400000 0 0 0 0 19893 7 0 0 0 0 0 0 0 0 0 0 0 17247 0 582 0 0 0 0 esmf_stateitem_array
S 19892 3 0 0 0 6 0 1 0 0 0 0 0 0 0 0 103 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 19893 6 4 0 0 13397 19896 582 85293 4080005c 400000 0 24 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17247 0 582 0 19891 0 0 esmf_stateitem_array$ac
S 19894 16 0 0 0 13397 1 582 85317 4 400000 0 0 0 0 19896 8 0 0 0 0 0 0 0 0 0 0 0 17251 0 582 0 0 0 0 esmf_stateitem_arraybundle
S 19895 3 0 0 0 6 0 1 0 0 0 0 0 0 0 0 104 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 19896 6 4 0 0 13397 19899 582 85344 4080005c 400000 0 28 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17251 0 582 0 19894 0 0 esmf_stateitem_arraybundle$ac
S 19897 16 0 0 0 13397 1 582 85374 4 400000 0 0 0 0 19899 9 0 0 0 0 0 0 0 0 0 0 0 17255 0 582 0 0 0 0 esmf_stateitem_routehandle
S 19898 3 0 0 0 6 0 1 0 0 0 0 0 0 0 0 105 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 19899 6 4 0 0 13397 19902 582 85401 4080005c 400000 0 32 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17255 0 582 0 19897 0 0 esmf_stateitem_routehandle$ac
S 19900 16 0 0 0 13397 1 582 85431 4 400000 0 0 0 0 19902 10 0 0 0 0 0 0 0 0 0 0 0 17259 0 582 0 0 0 0 esmf_stateitem_state
S 19901 3 0 0 0 6 0 1 0 0 0 0 0 0 0 0 106 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 19902 6 4 0 0 13397 19905 582 85452 4080005c 400000 0 36 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17259 0 582 0 19900 0 0 esmf_stateitem_state$ac
S 19903 16 0 0 0 13397 1 582 85476 4 400000 0 0 0 0 19905 11 0 0 0 0 0 0 0 0 0 0 0 17263 0 582 0 0 0 0 esmf_stateitem_name
S 19904 3 0 0 0 6 0 1 0 0 0 0 0 0 0 0 107 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 19905 6 4 0 0 13397 19908 582 85496 4080005c 400000 0 40 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17263 0 582 0 19903 0 0 esmf_stateitem_name$ac
S 19906 16 0 0 0 13397 1 582 85519 4 400000 0 0 0 0 19908 12 0 0 0 0 0 0 0 0 0 0 0 17267 0 582 0 0 0 0 esmf_stateitem_indirect
S 19907 3 0 0 0 6 0 1 0 0 0 0 0 0 0 0 108 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 19908 6 4 0 0 13397 19911 582 85543 4080005c 400000 0 44 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17267 0 582 0 19906 0 0 esmf_stateitem_indirect$ac
S 19909 16 0 0 0 13397 1 582 85570 4 400000 0 0 0 0 19911 13 0 0 0 0 0 0 0 0 0 0 0 17271 0 582 0 0 0 0 esmf_stateitem_unknown
S 19910 3 0 0 0 6 0 1 0 0 0 0 0 0 0 0 109 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 19911 6 4 0 0 13397 19914 582 85593 4080005c 400000 0 48 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17271 0 582 0 19909 0 0 esmf_stateitem_unknown$ac
S 19912 16 0 0 0 13397 1 582 85619 4 400000 0 0 0 0 19914 14 0 0 0 0 0 0 0 0 0 0 0 17275 0 582 0 0 0 0 esmf_stateitem_notfound
S 19913 3 0 0 0 6 0 1 0 0 0 0 0 0 0 0 110 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 19914 6 4 0 0 13397 19918 582 85643 4080005c 400000 0 52 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17275 0 582 0 19912 0 0 esmf_stateitem_notfound$ac
S 19915 25 1 0 0 13403 1 582 85670 800004 800000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_neededflag
S 19916 5 0 0 0 6 1 582 85686 80000c 0 0 0 0 0 13403 0 0 0 0 0 0 0 0 0 0 0 1 19916 0 582 0 0 0 0 needed
S 19917 16 0 0 0 13403 1 582 85693 4 400000 0 0 0 0 19918 15 0 0 0 0 0 0 0 0 0 0 0 17278 0 582 0 0 0 0 esmf_needed
S 19918 6 4 0 0 13403 19920 582 85705 4080005c 400000 0 56 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17278 0 582 0 19917 0 0 esmf_needed$ac
S 19919 16 0 0 0 13403 1 582 85720 4 400000 0 0 0 0 19920 16 0 0 0 0 0 0 0 0 0 0 0 17281 0 582 0 0 0 0 esmf_notneeded
S 19920 6 4 0 0 13403 19924 582 85735 4080005c 400000 0 60 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17281 0 582 0 19919 0 0 esmf_notneeded$ac
S 19921 25 1 0 0 13409 1 582 85753 800004 800000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_readyflag
S 19922 5 0 0 0 6 1 582 85768 80000c 0 0 0 0 0 13409 0 0 0 0 0 0 0 0 0 0 0 1 19922 0 582 0 0 0 0 ready
S 19923 16 0 0 0 13409 1 582 85774 4 400000 0 0 0 0 19924 17 0 0 0 0 0 0 0 0 0 0 0 17284 0 582 0 0 0 0 esmf_readytowrite
S 19924 6 4 0 0 13409 19926 582 85792 4080005c 400000 0 64 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17284 0 582 0 19923 0 0 esmf_readytowrite$ac
S 19925 16 0 0 0 13409 1 582 85813 4 400000 0 0 0 0 19926 18 0 0 0 0 0 0 0 0 0 0 0 17287 0 582 0 0 0 0 esmf_readytoread
S 19926 6 4 0 0 13409 19928 582 85830 4080005c 400000 0 68 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17287 0 582 0 19925 0 0 esmf_readytoread$ac
S 19927 16 0 0 0 13409 1 582 85850 4 400000 0 0 0 0 19928 19 0 0 0 0 0 0 0 0 0 0 0 17290 0 582 0 0 0 0 esmf_notready
S 19928 6 4 0 0 13409 19932 582 85864 4080005c 400000 0 72 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17290 0 582 0 19927 0 0 esmf_notready$ac
S 19929 25 1 0 0 13415 1 582 85881 800004 800000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_reqforrestartflag
S 19930 5 0 0 0 6 1 582 85904 80000c 0 0 0 0 0 13415 0 0 0 0 0 0 0 0 0 0 0 1 19930 0 582 0 0 0 0 required4restart
S 19931 16 0 0 0 13415 1 582 85921 4 400000 0 0 0 0 19932 20 0 0 0 0 0 0 0 0 0 0 0 17293 0 582 0 0 0 0 esmf_required_for_restart
S 19932 6 4 0 0 13415 19934 582 85947 4080005c 400000 0 76 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17293 0 582 0 19931 0 0 esmf_required_for_restart$ac
S 19933 16 0 0 0 13415 1 582 85976 4 400000 0 0 0 0 19934 21 0 0 0 0 0 0 0 0 0 0 0 17296 0 582 0 0 0 0 esmf_notrequired_for_restart
S 19934 6 4 0 0 13415 19938 582 86005 4080005c 400000 0 80 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17296 0 582 0 19933 0 0 esmf_notrequired_for_restart$ac
S 19935 25 1 0 0 13421 1 582 86037 800004 800000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_validflag
S 19936 5 0 0 0 6 1 582 86052 80000c 0 0 0 0 0 13421 0 0 0 0 0 0 0 0 0 0 0 1 19936 0 582 0 0 0 0 valid
S 19937 16 0 0 0 13421 1 582 86058 4 400000 0 0 0 0 19938 22 0 0 0 0 0 0 0 0 0 0 0 17299 0 582 0 0 0 0 esmf_valid
S 19938 6 4 0 0 13421 19940 582 86069 4080005c 400000 0 84 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17299 0 582 0 19937 0 0 esmf_valid$ac
S 19939 16 0 0 0 13421 1 582 86083 4 400000 0 0 0 0 19940 23 0 0 0 0 0 0 0 0 0 0 0 17302 0 582 0 0 0 0 esmf_invalid
S 19940 6 4 0 0 13421 19942 582 86096 4080005c 400000 0 88 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17302 0 582 0 19939 0 0 esmf_invalid$ac
S 19941 16 0 0 0 13421 1 582 86112 4 400000 0 0 0 0 19942 24 0 0 0 0 0 0 0 0 0 0 0 17305 0 582 0 0 0 0 esmf_validityunknown
S 19942 6 4 0 0 13421 1 582 86133 4080005c 400000 0 92 0 0 0 0 0 0 20011 0 0 0 0 0 0 0 0 17305 0 582 0 19941 0 0 esmf_validityunknown$ac
S 19943 25 0 0 0 13427 1 582 86157 4 800004 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_dataholder
S 19944 5 0 0 0 12428 19945 582 86173 800004 0 0 0 0 0 13427 0 0 0 0 0 0 0 0 0 0 0 1 19944 0 582 0 0 0 0 fp
S 19945 5 0 0 0 13322 19946 582 86176 800004 0 0 16 0 0 13427 0 0 0 0 0 0 0 0 0 0 0 19944 19945 0 582 0 0 0 0 fbp
S 19946 5 0 0 0 5542 19947 582 86180 800004 0 0 32 0 0 13427 0 0 0 0 0 0 0 0 0 0 0 19945 19946 0 582 0 0 0 0 ap
S 19947 5 0 0 0 10606 19948 582 86183 800004 0 0 48 0 0 13427 0 0 0 0 0 0 0 0 0 0 0 19946 19947 0 582 0 0 0 0 abp
S 19948 5 0 0 0 7275 19950 582 86187 800004 0 0 64 0 0 13427 0 0 0 0 0 0 0 0 0 0 0 19947 19948 0 582 0 0 0 0 rp
S 19949 25 0 0 0 13433 1 582 86190 4 800004 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_stateclass
S 19950 5 6 0 0 13433 19952 582 86206 800004 14 0 80 19952 0 13427 0 0 0 0 0 0 0 0 0 0 19951 19948 19950 19953 582 0 0 0 0 spp
S 19951 8 1 0 0 13439 1 582 86210 40822004 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 spp$sd
S 19952 5 0 0 0 7 19954 582 86217 40802001 1020 0 80 0 0 13427 0 0 0 0 0 0 0 0 0 0 0 19950 19952 0 582 0 0 0 0 spp$p
S 19953 6 1 0 0 7 1 582 86223 40802010 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 spp$o
S 19954 5 0 0 0 7 1 582 8955 800004 0 0 88 0 0 13427 0 0 0 0 0 0 0 0 0 0 0 19950 19954 0 582 0 0 0 0 isinit
S 19955 25 0 0 0 13442 1 582 86229 4 800004 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_stateitem
S 19956 5 0 0 0 13427 19957 582 86244 800004 0 0 0 0 0 13442 0 0 0 0 0 0 0 0 0 0 0 1 19956 0 582 0 0 0 0 datap
S 19957 5 0 0 0 13397 19958 582 86250 800004 0 0 96 0 0 13442 0 0 0 0 0 0 0 0 0 0 0 19956 19957 0 582 0 0 0 0 otype
S 19958 5 0 0 0 13403 19959 582 85686 800004 0 0 100 0 0 13442 0 0 0 0 0 0 0 0 0 0 0 19957 19958 0 582 0 0 0 0 needed
S 19959 5 0 0 0 13409 19960 582 85768 800004 0 0 104 0 0 13442 0 0 0 0 0 0 0 0 0 0 0 19958 19959 0 582 0 0 0 0 ready
S 19960 5 0 0 0 13421 19961 582 86052 800004 0 0 108 0 0 13442 0 0 0 0 0 0 0 0 0 0 0 19959 19960 0 582 0 0 0 0 valid
S 19961 5 0 0 0 13415 19962 582 86256 800004 0 0 112 0 0 13442 0 0 0 0 0 0 0 0 0 0 0 19960 19961 0 582 0 0 0 0 reqrestart
S 19962 5 0 0 0 16 19963 582 86267 800004 0 0 116 0 0 13442 0 0 0 0 0 0 0 0 0 0 0 19961 19962 0 582 0 0 0 0 proxyflag
S 19963 5 0 0 0 6 19964 582 86277 800004 0 0 120 0 0 13442 0 0 0 0 0 0 0 0 0 0 0 19962 19963 0 582 0 0 0 0 indirect_index
S 19964 5 0 0 0 13448 19965 582 86292 800004 0 0 124 0 0 13442 0 0 0 0 0 0 0 0 0 0 0 19963 19964 0 582 0 0 0 0 namep
S 19965 5 0 0 0 7 1 582 8955 800004 0 0 256 0 0 13442 0 0 0 0 0 0 0 0 0 0 0 19964 19965 0 582 0 0 0 0 isinit
S 19966 5 0 0 0 540 19967 582 13172 800004 0 0 0 0 0 13433 0 0 0 0 0 0 0 0 0 0 0 1 19966 0 582 0 0 0 0 base
S 19967 5 0 0 0 35 19968 582 86298 800004 0 0 16 0 0 13433 0 0 0 0 0 0 0 0 0 0 0 19966 19967 0 582 0 0 0 0 statestatus
S 19968 5 0 0 0 13391 19969 582 86310 800004 0 0 20 0 0 13433 0 0 0 0 0 0 0 0 0 0 0 19967 19968 0 582 0 0 0 0 st
S 19969 5 0 0 0 13403 19970 582 86313 800004 0 0 24 0 0 13433 0 0 0 0 0 0 0 0 0 0 0 19968 19969 0 582 0 0 0 0 needed_default
S 19970 5 0 0 0 13409 19971 582 86328 800004 0 0 28 0 0 13433 0 0 0 0 0 0 0 0 0 0 0 19969 19970 0 582 0 0 0 0 ready_default
S 19971 5 0 0 0 13421 19972 582 86342 800004 0 0 32 0 0 13433 0 0 0 0 0 0 0 0 0 0 0 19970 19971 0 582 0 0 0 0 stvalid_default
S 19972 5 0 0 0 13415 19973 582 86358 800004 0 0 36 0 0 13433 0 0 0 0 0 0 0 0 0 0 0 19971 19972 0 582 0 0 0 0 reqrestart_default
S 19973 5 0 0 0 6 19974 582 86377 800004 0 0 40 0 0 13433 0 0 0 0 0 0 0 0 0 0 0 19972 19973 0 582 0 0 0 0 alloccount
S 19974 5 0 0 0 6 19976 582 86388 800004 0 0 44 0 0 13433 0 0 0 0 0 0 0 0 0 0 0 19973 19974 0 582 0 0 0 0 datacount
S 19975 6 4 0 0 6 1 582 48350 40800016 0 0 0 0 0 0 0 0 0 20012 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_0_5
S 19976 5 6 0 0 13450 19978 582 86398 10a00004 14 0 48 19978 0 13433 0 19980 0 0 0 0 0 0 0 0 19977 19974 19976 19979 582 0 0 0 0 datalist
S 19977 5 0 0 0 13453 19981 582 86407 40822004 1020 0 64 0 0 13433 0 0 0 0 0 0 0 0 0 0 0 19979 19977 0 582 0 0 0 0 datalist$sd
S 19978 5 0 0 0 7 19979 582 86419 40802001 1020 0 48 0 0 13433 0 0 0 0 0 0 0 0 0 0 0 19976 19978 0 582 0 0 0 0 datalist$p
S 19979 5 0 0 0 7 19977 582 86430 40802000 1020 0 56 0 0 13433 0 0 0 0 0 0 0 0 0 0 0 19978 19979 0 582 0 0 0 0 datalist$o
S 19980 22 0 0 0 8 1 582 86441 40000000 1000 0 0 0 19976 0 0 0 0 19977 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 datalist$arrdsc
S 19981 5 0 0 0 7 1 582 8955 800004 0 0 136 0 0 13433 0 0 0 0 0 0 0 0 0 0 0 19976 19981 0 582 0 0 0 0 isinit
S 19982 25 0 0 0 13456 1 582 86457 4 800004 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_state
S 19983 5 6 0 0 13433 19985 582 86468 800004 14 0 0 19985 0 13456 0 0 0 0 0 0 0 0 0 0 19984 1 19983 19986 582 0 0 0 0 statep
S 19984 8 1 0 0 13462 1 582 86475 40822004 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 statep$sd
S 19985 5 0 0 0 7 19987 582 86485 40802001 1020 0 0 0 0 13456 0 0 0 0 0 0 0 0 0 0 0 19983 19985 0 582 0 0 0 0 statep$p
S 19986 6 1 0 0 7 1 582 86494 40802010 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 statep$o
S 19987 5 0 0 0 7 1 582 8955 800004 0 0 8 0 0 13456 0 0 0 0 0 0 0 0 0 0 0 19983 19987 0 582 0 0 0 0 isinit
S 19988 27 0 0 0 8 20063 582 86503 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_dataholdervalidate
S 19989 27 0 0 0 8 20074 582 86527 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_stateitemvalidate
S 19990 27 0 0 0 8 20085 582 86550 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_stateclassvalidate
S 19991 27 0 0 0 8 20067 582 86574 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_dataholderinit
S 19992 27 0 0 0 8 20070 582 86594 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_dataholdergetinit
S 19993 27 0 0 0 8 20078 582 86617 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_stateiteminit
S 19994 27 0 0 0 8 20081 582 86636 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_stateitemgetinit
S 19995 27 0 0 0 8 20089 582 86658 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_stateclassgetinit
S 19996 27 0 0 0 8 20093 582 86681 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_stategetinit
S 19997 3 0 0 0 9164 0 1 0 0 0 0 0 0 0 86699 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 70 24 49 64 3a 20 45 53 4d 46 5f 53 74 61 74 65 54 79 70 65 73 2e 46 39 30 2c 76 20 31 2e 32 32 2e 32 2e 35 20 32 30 30 38 2f 30 34 2f 32 34 20 31 38 3a 30 32 3a 35 34 20 74 68 65 75 72 69 63 68 20 45 78 70 20 24
S 19998 16 0 0 0 9164 1 582 13164 14 440000 0 0 0 0 19997 17316 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 version
S 19999 27 0 0 0 8 20013 582 86770 10010 0 0 0 1047 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_oteq
Q 19999 959 0
S 20000 27 0 0 0 8 20023 582 86780 10010 0 0 0 1049 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_imexeq
Q 20000 959 0
S 20001 27 0 0 0 8 20033 582 86792 10010 0 0 0 1051 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_needeq
Q 20001 959 0
S 20002 27 0 0 0 8 20043 582 86804 10010 0 0 0 1053 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_redyeq
Q 20002 959 0
S 20003 27 0 0 0 8 20053 582 86816 10010 0 0 0 1055 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_valideq
Q 20003 959 0
S 20004 27 0 0 0 8 20018 582 86829 10010 0 0 0 1048 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_otne
Q 20004 960 0
S 20005 27 0 0 0 8 20028 582 86839 10010 0 0 0 1050 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_imexne
Q 20005 960 0
S 20006 27 0 0 0 8 20038 582 86851 10010 0 0 0 1052 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_needne
Q 20006 960 0
S 20007 27 0 0 0 8 20048 582 86863 10010 0 0 0 1054 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_redyne
Q 20007 960 0
S 20008 27 0 0 0 8 20058 582 86875 10010 0 0 0 1056 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_validne
Q 20008 960 0
S 20009 23 0 0 0 0 960 582 10657 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 !=
S 20010 23 0 0 0 0 959 582 10654 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 ==
S 20011 11 0 0 0 8 19448 582 86888 40800010 801000 0 96 0 0 19876 19942 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_statetypesmod$12
S 20012 11 0 0 0 8 20011 582 86910 40800010 801000 0 4 0 0 19975 19975 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_statetypesmod$4
S 20013 23 5 0 0 8 20016 582 86770 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_oteq
S 20014 1 3 1 0 13397 1 20013 86931 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 s1
S 20015 1 3 1 0 13397 1 20013 86934 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 s2
S 20016 14 5 0 0 16 1 20013 86770 14 400000 0 0 0 6799 2 0 0 20017 0 0 0 0 0 0 0 0 0 323 0 582 0 0 0 0 esmf_oteq
F 20016 2 20014 20015
S 20017 1 3 0 0 16 1 20013 86770 14 1003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_oteq
S 20018 23 5 0 0 8 20021 582 86829 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_otne
S 20019 1 3 1 0 13397 1 20018 86931 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 s1
S 20020 1 3 1 0 13397 1 20018 86934 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 s2
S 20021 14 5 0 0 16 1 20018 86829 14 400000 0 0 0 6802 2 0 0 20022 0 0 0 0 0 0 0 0 0 330 0 582 0 0 0 0 esmf_otne
F 20021 2 20019 20020
S 20022 1 3 0 0 16 1 20018 86829 14 1003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_otne
S 20023 23 5 0 0 8 20026 582 86780 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_imexeq
S 20024 1 3 1 0 13391 1 20023 86931 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 s1
S 20025 1 3 1 0 13391 1 20023 86934 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 s2
S 20026 14 5 0 0 16 1 20023 86780 14 400000 0 0 0 6805 2 0 0 20027 0 0 0 0 0 0 0 0 0 338 0 582 0 0 0 0 esmf_imexeq
F 20026 2 20024 20025
S 20027 1 3 0 0 16 1 20023 86780 14 1003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_imexeq
S 20028 23 5 0 0 8 20031 582 86839 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_imexne
S 20029 1 3 1 0 13391 1 20028 86931 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 s1
S 20030 1 3 1 0 13391 1 20028 86934 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 s2
S 20031 14 5 0 0 16 1 20028 86839 14 400000 0 0 0 6808 2 0 0 20032 0 0 0 0 0 0 0 0 0 345 0 582 0 0 0 0 esmf_imexne
F 20031 2 20029 20030
S 20032 1 3 0 0 16 1 20028 86839 14 1003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_imexne
S 20033 23 5 0 0 8 20036 582 86792 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_needeq
S 20034 1 3 1 0 13403 1 20033 86931 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 s1
S 20035 1 3 1 0 13403 1 20033 86934 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 s2
S 20036 14 5 0 0 16 1 20033 86792 14 400000 0 0 0 6811 2 0 0 20037 0 0 0 0 0 0 0 0 0 353 0 582 0 0 0 0 esmf_needeq
F 20036 2 20034 20035
S 20037 1 3 0 0 16 1 20033 86792 14 1003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_needeq
S 20038 23 5 0 0 8 20041 582 86851 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_needne
S 20039 1 3 1 0 13403 1 20038 86931 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 s1
S 20040 1 3 1 0 13403 1 20038 86934 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 s2
S 20041 14 5 0 0 16 1 20038 86851 14 400000 0 0 0 6814 2 0 0 20042 0 0 0 0 0 0 0 0 0 360 0 582 0 0 0 0 esmf_needne
F 20041 2 20039 20040
S 20042 1 3 0 0 16 1 20038 86851 14 1003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_needne
S 20043 23 5 0 0 8 20046 582 86804 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_redyeq
S 20044 1 3 1 0 13409 1 20043 86931 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 s1
S 20045 1 3 1 0 13409 1 20043 86934 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 s2
S 20046 14 5 0 0 16 1 20043 86804 14 400000 0 0 0 6817 2 0 0 20047 0 0 0 0 0 0 0 0 0 368 0 582 0 0 0 0 esmf_redyeq
F 20046 2 20044 20045
S 20047 1 3 0 0 16 1 20043 86804 14 1003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_redyeq
S 20048 23 5 0 0 8 20051 582 86863 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_redyne
S 20049 1 3 1 0 13409 1 20048 86931 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 s1
S 20050 1 3 1 0 13409 1 20048 86934 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 s2
S 20051 14 5 0 0 16 1 20048 86863 14 400000 0 0 0 6820 2 0 0 20052 0 0 0 0 0 0 0 0 0 375 0 582 0 0 0 0 esmf_redyne
F 20051 2 20049 20050
S 20052 1 3 0 0 16 1 20048 86863 14 1003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_redyne
S 20053 23 5 0 0 8 20056 582 86816 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_valideq
S 20054 1 3 1 0 13421 1 20053 86931 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 s1
S 20055 1 3 1 0 13421 1 20053 86934 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 s2
S 20056 14 5 0 0 16 1 20053 86816 14 400000 0 0 0 6823 2 0 0 20057 0 0 0 0 0 0 0 0 0 383 0 582 0 0 0 0 esmf_valideq
F 20056 2 20054 20055
S 20057 1 3 0 0 16 1 20053 86816 14 1003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_valideq
S 20058 23 5 0 0 8 20061 582 86875 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_validne
S 20059 1 3 1 0 13421 1 20058 86931 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 s1
S 20060 1 3 1 0 13421 1 20058 86934 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 s2
S 20061 14 5 0 0 16 1 20058 86875 14 400000 0 0 0 6826 2 0 0 20062 0 0 0 0 0 0 0 0 0 390 0 582 0 0 0 0 esmf_validne
F 20061 2 20059 20060
S 20062 1 3 0 0 16 1 20058 86875 14 1003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_validne
S 20063 23 5 0 0 0 20066 582 86503 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_dataholdervalidate
S 20064 1 3 0 0 13427 1 20063 86937 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dh
S 20065 1 3 2 0 6 1 20063 11021 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 20066 14 5 0 0 0 1 20063 86503 0 400000 0 0 0 6829 2 0 0 0 0 0 0 0 0 0 0 0 0 406 0 582 0 0 0 0 esmf_dataholdervalidate
F 20066 2 20064 20065
S 20067 23 5 0 0 0 20069 582 86574 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_dataholderinit
S 20068 1 3 0 0 13427 1 20067 86937 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dh
S 20069 14 5 0 0 0 1 20067 86574 0 400000 0 0 0 6832 1 0 0 0 0 0 0 0 0 0 0 0 0 448 0 582 0 0 0 0 esmf_dataholderinit
F 20069 1 20068
S 20070 23 5 0 0 8 20072 582 86594 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_dataholdergetinit
S 20071 1 3 1 0 13427 1 20070 86937 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dh
S 20072 14 5 0 0 7 1 20070 86594 4 400000 0 0 0 6834 1 0 0 20073 0 0 0 0 0 0 0 0 0 477 0 582 0 0 0 0 esmf_dataholdergetinit
F 20072 1 20071
S 20073 1 3 0 0 7 1 20070 86594 14 1003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_dataholdergetinit
S 20074 23 5 0 0 0 20077 582 86527 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_stateitemvalidate
S 20075 1 3 0 0 13442 1 20074 86940 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 si
S 20076 1 3 2 0 6 1 20074 11021 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 20077 14 5 0 0 0 1 20074 86527 0 400000 0 0 0 6836 2 0 0 0 0 0 0 0 0 0 0 0 0 514 0 582 0 0 0 0 esmf_stateitemvalidate
F 20077 2 20075 20076
S 20078 23 5 0 0 0 20080 582 86617 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_stateiteminit
S 20079 1 3 0 0 13442 1 20078 86940 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 si
S 20080 14 5 0 0 0 1 20078 86617 0 400000 0 0 0 6839 1 0 0 0 0 0 0 0 0 0 0 0 0 556 0 582 0 0 0 0 esmf_stateiteminit
F 20080 1 20079
S 20081 23 5 0 0 8 20083 582 86636 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_stateitemgetinit
S 20082 1 3 1 0 13442 1 20081 86940 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 si
S 20083 14 5 0 0 7 1 20081 86636 4 400000 0 0 0 6841 1 0 0 20084 0 0 0 0 0 0 0 0 0 585 0 582 0 0 0 0 esmf_stateitemgetinit
F 20083 1 20082
S 20084 1 3 0 0 7 1 20081 86636 14 1003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_stateitemgetinit
S 20085 23 5 0 0 0 20088 582 86550 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_stateclassvalidate
S 20086 1 3 1 0 13433 1 20085 86943 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 sc
S 20087 1 3 2 0 6 1 20085 11021 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 20088 14 5 0 0 0 1 20085 86550 0 400000 0 0 0 6843 2 0 0 0 0 0 0 0 0 0 0 0 0 621 0 582 0 0 0 0 esmf_stateclassvalidate
F 20088 2 20086 20087
S 20089 23 5 0 0 8 20091 582 86658 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_stateclassgetinit
S 20090 1 3 1 0 13433 1 20089 86943 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 sc
S 20091 14 5 0 0 7 1 20089 86658 4 400000 0 0 0 6846 1 0 0 20092 0 0 0 0 0 0 0 0 0 665 0 582 0 0 0 0 esmf_stateclassgetinit
F 20091 1 20090
S 20092 1 3 0 0 7 1 20089 86658 14 1003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_stateclassgetinit
S 20093 23 5 0 0 8 20095 582 86681 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_stategetinit
S 20094 1 3 1 0 13456 1 20093 11019 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 s
S 20095 14 5 0 0 7 1 20093 86681 4 400000 0 0 0 6848 1 0 0 20096 0 0 0 0 0 0 0 0 0 702 0 582 0 0 0 0 esmf_stategetinit
F 20095 1 20094
S 20096 1 3 0 0 7 1 20093 86681 14 1003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_stategetinit
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
A 29 2 0 0 0 6 595 0 0 0 29 0 0 0 0 0 0 0 0 0
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
A 962 1 0 0 203 737 1610 0 0 0 0 0 0 0 0 0 0 0 0 0
A 965 1 0 0 209 737 1612 0 0 0 0 0 0 0 0 0 0 0 0 0
A 968 1 0 0 215 737 1614 0 0 0 0 0 0 0 0 0 0 0 0 0
A 971 1 0 0 227 743 1618 0 0 0 0 0 0 0 0 0 0 0 0 0
A 974 1 0 0 0 743 1620 0 0 0 0 0 0 0 0 0 0 0 0 0
A 977 1 0 0 0 743 1622 0 0 0 0 0 0 0 0 0 0 0 0 0
A 980 1 0 0 764 743 1624 0 0 0 0 0 0 0 0 0 0 0 0 0
A 983 1 0 0 0 743 1626 0 0 0 0 0 0 0 0 0 0 0 0 0
A 986 1 0 0 933 743 1628 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1705 1 0 0 1452 1632 3096 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1708 1 0 0 1451 1632 3098 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1755 1 0 0 1395 1881 3392 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1758 1 0 0 503 1881 3394 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1761 1 0 0 1186 1881 3396 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7418 1 0 0 6998 2079 3471 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7421 1 0 0 7002 2079 3473 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7424 1 0 0 7004 2079 3475 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7427 1 0 0 7075 2079 3477 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7430 1 0 0 7010 2079 3479 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7433 1 0 0 7005 2085 3483 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7436 1 0 0 7006 2085 3485 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7459 2 0 0 6953 6 7985 0 0 0 7459 0 0 0 0 0 0 0 0 0
A 7886 1 0 0 7576 4664 7993 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7889 1 0 0 7573 4664 7995 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7892 1 0 0 7578 4664 7997 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7895 1 0 0 7035 4664 7999 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7898 1 0 0 7609 4664 8001 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7901 1 0 0 7608 4664 8003 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7904 1 0 0 7614 4664 8005 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7907 1 0 0 7616 4664 8007 0 0 0 0 0 0 0 0 0 0 0 0 0
A 8415 1 0 0 7941 5073 8377 0 0 0 0 0 0 0 0 0 0 0 0 0
A 8418 1 0 0 7946 5073 8379 0 0 0 0 0 0 0 0 0 0 0 0 0
A 8421 1 0 0 7945 5073 8381 0 0 0 0 0 0 0 0 0 0 0 0 0
A 8424 1 0 0 8325 5073 8383 0 0 0 0 0 0 0 0 0 0 0 0 0
A 8427 1 0 0 8324 5073 8385 0 0 0 0 0 0 0 0 0 0 0 0 0
A 12780 2 0 0 10307 6 13188 0 0 0 12780 0 0 0 0 0 0 0 0 0
A 15520 1 0 0 14446 10839 16514 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15523 1 0 0 15485 10839 16516 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15526 1 0 0 15070 10839 16518 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15529 1 0 0 15283 10839 16520 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15532 1 0 0 15484 10839 16522 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15535 1 0 0 15085 10839 16524 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15538 1 0 0 15282 10839 16526 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15574 2 0 0 15176 6 16745 0 0 0 15574 0 0 0 0 0 0 0 0 0
A 15660 1 0 0 14853 11192 16756 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15663 1 0 0 15356 11192 16758 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15666 1 0 0 15175 11192 16760 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15669 1 0 0 15574 11192 16762 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15672 1 0 0 15361 11192 16764 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15675 1 0 0 15180 11192 16766 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15678 1 0 0 14570 11192 16768 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15681 1 0 0 15543 11192 16770 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15684 1 0 0 14873 11192 16772 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15687 1 0 0 14870 11192 16774 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15690 1 0 0 15365 11192 16776 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15693 1 0 0 14876 11192 16778 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15696 1 0 0 14874 11192 16780 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15699 1 0 0 15364 11192 16782 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16627 1 0 0 16290 11440 16868 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16630 1 0 0 16291 11440 16870 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16633 1 0 0 16294 11440 16872 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16636 1 0 0 16295 11440 16874 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16639 1 0 0 16299 11446 16878 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16642 1 0 0 16302 11446 16880 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16645 1 0 0 16303 11446 16882 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16648 1 0 0 16306 11446 16884 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16753 1 0 0 16481 12395 18374 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16756 1 0 0 16490 12395 18376 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16759 1 0 0 16405 12401 18380 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16762 1 0 0 16406 12401 18382 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16902 1 0 0 15526 12643 18724 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16905 1 0 0 15068 12643 18726 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16908 1 0 0 15466 12655 18735 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16911 1 0 0 16555 12655 18737 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16914 1 0 0 16879 12655 18739 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16917 1 0 0 16227 12655 18741 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16920 1 0 0 16228 12655 18743 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16923 1 0 0 16231 12655 18745 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16926 1 0 0 16232 12655 18747 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16929 1 0 0 16235 12655 18749 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16932 1 0 0 16236 12655 18751 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16935 1 0 0 16557 12655 18753 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16938 1 0 0 16558 12655 18755 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16941 1 0 0 16243 12655 18757 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16944 1 0 0 16244 12655 18759 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16947 1 0 0 16247 12655 18761 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16950 1 0 0 16154 12661 18765 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16953 1 0 0 16596 12661 18767 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16956 1 0 0 16158 12661 18769 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16959 1 0 0 16153 12661 18771 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16962 1 0 0 15811 12661 18773 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16965 1 0 0 16157 12661 18775 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16968 1 0 0 16694 12661 18777 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16971 1 0 0 15810 12661 18779 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16974 1 0 0 16529 12661 18781 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17221 1 0 0 16274 13286 19347 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17224 1 0 0 16283 13286 19349 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17225 15 0 0 0 6 19874 3 0 0 0 0 0 0 0 0 0 0 0 0
A 17226 15 0 0 0 13391 19875 17225 0 0 0 0 0 0 0 0 0 0 0 0
A 17227 1 0 0 16407 13391 19876 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17228 15 0 0 0 6 19874 45 0 0 0 0 0 0 0 0 0 0 0 0
A 17229 15 0 0 0 13391 19877 17228 0 0 0 0 0 0 0 0 0 0 0 0
A 17230 1 0 0 16658 13391 19878 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17231 15 0 0 0 6 19874 32 0 0 0 0 0 0 0 0 0 0 0 0
A 17232 15 0 0 0 13391 19879 17231 0 0 0 0 0 0 0 0 0 0 0 0
A 17233 1 0 0 16411 13391 19880 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17234 15 0 0 0 6 19874 52 0 0 0 0 0 0 0 0 0 0 0 0
A 17235 15 0 0 0 13391 19881 17234 0 0 0 0 0 0 0 0 0 0 0 0
A 17236 1 0 0 16412 13391 19882 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17237 2 0 0 16455 6 19886 0 0 0 17237 0 0 0 0 0 0 0 0 0
A 17238 15 0 0 0 6 19884 17237 0 0 0 0 0 0 0 0 0 0 0 0
A 17239 15 0 0 0 13397 19885 17238 0 0 0 0 0 0 0 0 0 0 0 0
A 17240 1 0 0 15957 13397 19887 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17241 2 0 0 17092 6 19889 0 0 0 17241 0 0 0 0 0 0 0 0 0
A 17242 15 0 0 0 6 19884 17241 0 0 0 0 0 0 0 0 0 0 0 0
A 17243 15 0 0 0 13397 19888 17242 0 0 0 0 0 0 0 0 0 0 0 0
A 17244 1 0 0 14847 13397 19890 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17245 2 0 0 16716 6 19892 0 0 0 17245 0 0 0 0 0 0 0 0 0
A 17246 15 0 0 0 6 19884 17245 0 0 0 0 0 0 0 0 0 0 0 0
A 17247 15 0 0 0 13397 19891 17246 0 0 0 0 0 0 0 0 0 0 0 0
A 17248 1 0 0 16588 13397 19893 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17249 2 0 0 16976 6 19895 0 0 0 17249 0 0 0 0 0 0 0 0 0
A 17250 15 0 0 0 6 19884 17249 0 0 0 0 0 0 0 0 0 0 0 0
A 17251 15 0 0 0 13397 19894 17250 0 0 0 0 0 0 0 0 0 0 0 0
A 17252 1 0 0 16842 13397 19896 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17253 2 0 0 15743 6 19898 0 0 0 17253 0 0 0 0 0 0 0 0 0
A 17254 15 0 0 0 6 19884 17253 0 0 0 0 0 0 0 0 0 0 0 0
A 17255 15 0 0 0 13397 19897 17254 0 0 0 0 0 0 0 0 0 0 0 0
A 17256 1 0 0 16841 13397 19899 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17257 2 0 0 15744 6 19901 0 0 0 17257 0 0 0 0 0 0 0 0 0
A 17258 15 0 0 0 6 19884 17257 0 0 0 0 0 0 0 0 0 0 0 0
A 17259 15 0 0 0 13397 19900 17258 0 0 0 0 0 0 0 0 0 0 0 0
A 17260 1 0 0 16847 13397 19902 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17261 2 0 0 17115 6 19904 0 0 0 17261 0 0 0 0 0 0 0 0 0
A 17262 15 0 0 0 6 19884 17261 0 0 0 0 0 0 0 0 0 0 0 0
A 17263 15 0 0 0 13397 19903 17262 0 0 0 0 0 0 0 0 0 0 0 0
A 17264 1 0 0 15171 13397 19905 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17265 2 0 0 15243 6 19907 0 0 0 17265 0 0 0 0 0 0 0 0 0
A 17266 15 0 0 0 6 19884 17265 0 0 0 0 0 0 0 0 0 0 0 0
A 17267 15 0 0 0 13397 19906 17266 0 0 0 0 0 0 0 0 0 0 0 0
A 17268 1 0 0 16592 13397 19908 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17269 2 0 0 14957 6 19910 0 0 0 17269 0 0 0 0 0 0 0 0 0
A 17270 15 0 0 0 6 19884 17269 0 0 0 0 0 0 0 0 0 0 0 0
A 17271 15 0 0 0 13397 19909 17270 0 0 0 0 0 0 0 0 0 0 0 0
A 17272 1 0 0 14856 13397 19911 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17273 2 0 0 16980 6 19913 0 0 0 17273 0 0 0 0 0 0 0 0 0
A 17274 15 0 0 0 6 19884 17273 0 0 0 0 0 0 0 0 0 0 0 0
A 17275 15 0 0 0 13397 19912 17274 0 0 0 0 0 0 0 0 0 0 0 0
A 17276 1 0 0 16591 13397 19914 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17277 15 0 0 0 6 19916 3 0 0 0 0 0 0 0 0 0 0 0 0
A 17278 15 0 0 0 13403 19917 17277 0 0 0 0 0 0 0 0 0 0 0 0
A 17279 1 0 0 16851 13403 19918 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17280 15 0 0 0 6 19916 45 0 0 0 0 0 0 0 0 0 0 0 0
A 17281 15 0 0 0 13403 19919 17280 0 0 0 0 0 0 0 0 0 0 0 0
A 17282 1 0 0 16854 13403 19920 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17283 15 0 0 0 6 19922 3 0 0 0 0 0 0 0 0 0 0 0 0
A 17284 15 0 0 0 13409 19923 17283 0 0 0 0 0 0 0 0 0 0 0 0
A 17285 1 0 0 16252 13409 19924 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17286 15 0 0 0 6 19922 45 0 0 0 0 0 0 0 0 0 0 0 0
A 17287 15 0 0 0 13409 19925 17286 0 0 0 0 0 0 0 0 0 0 0 0
A 17288 1 0 0 16947 13409 19926 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17289 15 0 0 0 6 19922 32 0 0 0 0 0 0 0 0 0 0 0 0
A 17290 15 0 0 0 13409 19927 17289 0 0 0 0 0 0 0 0 0 0 0 0
A 17291 1 0 0 16710 13409 19928 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17292 15 0 0 0 6 19930 3 0 0 0 0 0 0 0 0 0 0 0 0
A 17293 15 0 0 0 13415 19931 17292 0 0 0 0 0 0 0 0 0 0 0 0
A 17294 1 0 0 17035 13415 19932 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17295 15 0 0 0 6 19930 45 0 0 0 0 0 0 0 0 0 0 0 0
A 17296 15 0 0 0 13415 19933 17295 0 0 0 0 0 0 0 0 0 0 0 0
A 17297 1 0 0 17036 13415 19934 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17298 15 0 0 0 6 19936 3 0 0 0 0 0 0 0 0 0 0 0 0
A 17299 15 0 0 0 13421 19937 17298 0 0 0 0 0 0 0 0 0 0 0 0
A 17300 1 0 0 17154 13421 19938 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17301 15 0 0 0 6 19936 45 0 0 0 0 0 0 0 0 0 0 0 0
A 17302 15 0 0 0 13421 19939 17301 0 0 0 0 0 0 0 0 0 0 0 0
A 17303 1 0 0 16607 13421 19940 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17304 15 0 0 0 6 19936 32 0 0 0 0 0 0 0 0 0 0 0 0
A 17305 15 0 0 0 13421 19941 17304 0 0 0 0 0 0 0 0 0 0 0 0
A 17306 1 0 0 16602 13421 19942 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17308 1 0 1 17091 13453 19977 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17309 10 0 0 16350 6 17308 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17310 10 0 0 17309 6 17308 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17311 4 0 0 16860 6 17310 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17312 4 0 0 16345 6 17309 0 17311 0 0 0 0 1 0 0 0 0 0 0
A 17313 10 0 0 17310 6 17308 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17314 10 0 0 17313 6 17308 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17315 10 0 0 17314 6 17308 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17316 2 0 0 15910 9164 19997 0 0 0 17316 0 0 0 0 0 0 0 0 0
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
V 962 737 7 0
S 0 737 0 0 0
A 0 6 0 0 1 2 0
J 54 1 1
V 965 737 7 0
S 0 737 0 0 0
A 0 6 0 0 1 3 0
J 54 1 1
V 968 737 7 0
S 0 737 0 0 0
A 0 6 0 0 1 45 0
J 66 1 1
V 971 743 7 0
S 0 743 0 0 0
A 0 6 0 0 1 2 0
J 66 1 1
V 974 743 7 0
S 0 743 0 0 0
A 0 6 0 0 1 3 0
J 66 1 1
V 977 743 7 0
S 0 743 0 0 0
A 0 6 0 0 1 45 0
J 66 1 1
V 980 743 7 0
S 0 743 0 0 0
A 0 6 0 0 1 32 0
J 66 1 1
V 983 743 7 0
S 0 743 0 0 0
A 0 6 0 0 1 52 0
J 66 1 1
V 986 743 7 0
S 0 743 0 0 0
A 0 6 0 0 1 56 0
J 71 1 1
V 1705 1632 7 0
S 0 1632 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 1708 1632 7 0
S 0 1632 0 0 0
A 0 6 0 0 1 45 0
J 68 1 1
V 1755 1881 7 0
S 0 1881 0 0 0
A 0 6 0 0 1 2 0
J 68 1 1
V 1758 1881 7 0
S 0 1881 0 0 0
A 0 6 0 0 1 3 0
J 68 1 1
V 1761 1881 7 0
S 0 1881 0 0 0
A 0 6 0 0 1 45 0
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
V 17227 13391 7 0
S 0 13391 0 0 0
A 0 6 0 0 1 3 0
J 64 1 1
V 17230 13391 7 0
S 0 13391 0 0 0
A 0 6 0 0 1 45 0
J 64 1 1
V 17233 13391 7 0
S 0 13391 0 0 0
A 0 6 0 0 1 32 0
J 64 1 1
V 17236 13391 7 0
S 0 13391 0 0 0
A 0 6 0 0 1 52 0
J 82 1 1
V 17240 13397 7 0
S 0 13397 0 0 0
A 0 6 0 0 1 17237 0
J 82 1 1
V 17244 13397 7 0
S 0 13397 0 0 0
A 0 6 0 0 1 17241 0
J 82 1 1
V 17248 13397 7 0
S 0 13397 0 0 0
A 0 6 0 0 1 17245 0
J 82 1 1
V 17252 13397 7 0
S 0 13397 0 0 0
A 0 6 0 0 1 17249 0
J 82 1 1
V 17256 13397 7 0
S 0 13397 0 0 0
A 0 6 0 0 1 17253 0
J 82 1 1
V 17260 13397 7 0
S 0 13397 0 0 0
A 0 6 0 0 1 17257 0
J 82 1 1
V 17264 13397 7 0
S 0 13397 0 0 0
A 0 6 0 0 1 17261 0
J 82 1 1
V 17268 13397 7 0
S 0 13397 0 0 0
A 0 6 0 0 1 17265 0
J 82 1 1
V 17272 13397 7 0
S 0 13397 0 0 0
A 0 6 0 0 1 17269 0
J 82 1 1
V 17276 13397 7 0
S 0 13397 0 0 0
A 0 6 0 0 1 17273 0
J 106 1 1
V 17279 13403 7 0
S 0 13403 0 0 0
A 0 6 0 0 1 3 0
J 106 1 1
V 17282 13403 7 0
S 0 13403 0 0 0
A 0 6 0 0 1 45 0
J 119 1 1
V 17285 13409 7 0
S 0 13409 0 0 0
A 0 6 0 0 1 3 0
J 119 1 1
V 17288 13409 7 0
S 0 13409 0 0 0
A 0 6 0 0 1 45 0
J 119 1 1
V 17291 13409 7 0
S 0 13409 0 0 0
A 0 6 0 0 1 32 0
J 134 1 1
V 17294 13415 7 0
S 0 13415 0 0 0
A 0 6 0 0 1 3 0
J 134 1 1
V 17297 13415 7 0
S 0 13415 0 0 0
A 0 6 0 0 1 45 0
J 148 1 1
V 17300 13421 7 0
S 0 13421 0 0 0
A 0 6 0 0 1 3 0
J 148 1 1
V 17303 13421 7 0
S 0 13421 0 0 0
A 0 6 0 0 1 45 0
J 148 1 1
V 17306 13421 7 0
S 0 13421 0 0 0
A 0 6 0 0 1 32 0
Z
