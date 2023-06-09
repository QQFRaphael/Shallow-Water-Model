V24 esmf_statereconcilemod
94 /global/u2/d/dazlich/cpl40-40/doe_ca/esmf/src/Superstructure/State/src/ESMF_StateReconcile.F90 S582 0
11/22/2010  10:54:25
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
D 46 24 712 4 711 3
D 52 24 728 8 727 7
D 58 24 734 4 733 3
D 70 24 776 36 775 3
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
D 127 24 866 4 865 3
D 133 24 872 4 871 3
D 139 24 888 4 887 3
D 145 24 894 4 893 3
D 151 24 902 4 901 3
D 157 24 910 4 909 3
D 163 24 916 4 915 3
D 169 24 924 4 923 3
D 175 24 930 4 929 3
D 181 24 936 4 935 3
D 187 24 942 4 941 3
D 390 24 1192 4 1191 3
D 396 24 1200 4 1199 3
D 402 24 1208 4 1207 3
D 835 24 1640 16 1639 7
D 847 24 1646 8 1645 7
D 1561 24 3034 4 3033 3
D 1816 24 3332 4 3331 3
D 1990 24 3399 4 3398 3
D 1996 24 3407 4 3406 3
D 2210 24 3510 4 3509 3
D 2216 24 3522 4 3521 3
D 4930 24 8077 4 8076 3
D 5345 24 8463 4 8462 3
D 11264 24 16652 4 16651 3
D 11626 24 16891 4 16890 3
D 11877 24 17010 4 17009 3
D 11883 24 17020 4 17019 3
D 12844 24 18520 4 18519 3
D 12850 24 18526 4 18525 3
D 13104 24 18874 4 18873 3
D 13116 24 18885 4 18884 3
D 13122 24 18915 4 18914 3
D 13771 24 19505 4 19504 3
D 14189 24 20050 4 20049 3
D 14195 24 20060 4 20059 3
D 14201 24 20082 4 20081 3
D 14207 24 20088 4 20087 3
D 14213 24 20096 4 20095 3
D 14219 24 20102 4 20101 3
D 14254 24 20149 16 20148 7
D 14575 18 13
D 14577 18 14
D 14579 18 15
D 14581 18 16
D 14583 18 17
D 14585 18 18
D 14587 18 19
D 14589 18 20
D 14591 18 21
D 14593 18 22
D 14595 18 23
D 14771 24 20984 936 20982 7
D 14777 21 14771 1 17625 17624 0 1 0 0 1
 17619 17622 17623 17619 17622 17620
D 14780 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 14783 21 14771 1 17634 17633 0 1 0 0 1
 17628 17631 17632 17628 17631 17629
D 14786 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 14789 21 6 1 17643 17642 0 1 0 0 1
 17637 17640 17641 17637 17640 17638
D 14792 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 14795 21 6 1 17652 17651 0 1 0 0 1
 17646 17649 17650 17646 17649 17647
D 14798 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 14801 21 847 1 17661 17660 0 1 0 0 1
 17655 17658 17659 17655 17658 17656
D 14804 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 14807 21 847 1 17670 17669 0 1 0 0 1
 17664 17667 17668 17664 17667 17665
D 14810 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 14813 21 6 1 17679 17678 0 1 0 0 1
 17673 17676 17677 17673 17676 17674
D 14816 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 14819 21 6 1 17688 17687 0 1 0 0 1
 17682 17685 17686 17682 17685 17683
D 14822 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 14825 21 6 2 17703 17702 0 1 0 0 1
 17692 17695 17700 17692 17695 17693
 17696 17699 17701 17696 17699 17697
D 14828 21 6 1 0 226 0 0 0 0 0
 0 226 0 3 226 0
D 14831 21 6 2 17718 17717 0 1 0 0 1
 17707 17710 17715 17707 17710 17708
 17711 17714 17716 17711 17714 17712
D 14834 21 6 1 0 226 0 0 0 0 0
 0 226 0 3 226 0
D 14837 18 17722
D 14839 21 6 1 0 3 0 0 0 0 0
 0 3 0 3 3 0
D 14842 21 14771 1 17726 17732 0 1 0 0 1
 17727 17730 17731 17727 17730 17728
D 14845 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 14848 21 14771 1 17734 17740 0 1 0 0 1
 17735 17738 17739 17735 17738 17736
D 14851 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 14854 21 14771 1 17742 17748 0 1 0 0 1
 17743 17746 17747 17743 17746 17744
D 14857 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
S 582 24 0 0 0 8 1 0 4659 10005 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 15 0 0 0 0 0 0 esmf_statereconcilemod
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
S 614 3 0 0 0 14575 1 1 0 0 0 0 0 0 0 4940 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 42 61 73 65
S 615 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 11 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 616 3 0 0 0 14577 1 1 0 0 0 0 0 0 0 4950 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 49 4f 53 70 65 63
S 617 3 0 0 0 14577 1 1 0 0 0 0 0 0 0 4962 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 4c 6f 67 45 72 72
S 618 3 0 0 0 14575 1 1 0 0 0 0 0 0 0 4974 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 54 69 6d 65
S 619 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 13 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 620 3 0 0 0 14579 1 1 0 0 0 0 0 0 0 4984 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 43 61 6c 65 6e 64 61 72
S 621 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 17 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 622 3 0 0 0 14581 1 1 0 0 0 0 0 0 0 4998 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 54 69 6d 65 49 6e 74 65 72 76 61 6c
S 623 3 0 0 0 14583 1 1 0 0 0 0 0 0 0 5016 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 41 6c 61 72 6d
S 624 3 0 0 0 14583 1 1 0 0 0 0 0 0 0 5027 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 43 6c 6f 63 6b
S 625 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 626 3 0 0 0 14585 1 1 0 0 0 0 0 0 0 5038 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 41 72 72 61 79 53 70 65 63
S 627 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 628 3 0 0 0 14587 1 1 0 0 0 0 0 0 0 5053 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 15 45 53 4d 46 5f 4c 6f 63 61 6c 41 72 72 61 79
S 629 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 630 3 0 0 0 14589 1 1 0 0 0 0 0 0 0 5069 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 41 72 72 61 79 42 75 6e 64 6c 65
S 631 3 0 0 0 14591 1 1 0 0 0 0 0 0 0 5086 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 7 45 53 4d 46 5f 56 4d
S 632 3 0 0 0 14579 1 1 0 0 0 0 0 0 0 5094 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 44 45 4c 61 79 6f 75 74
S 633 3 0 0 0 14577 1 1 0 0 0 0 0 0 0 5108 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 43 6f 6e 66 69 67
S 634 3 0 0 0 14583 1 1 0 0 0 0 0 0 0 5120 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 41 72 72 61 79
S 635 3 0 0 0 14579 1 1 0 0 0 0 0 0 0 5131 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 49 6e 74 65 72 6e 44 47
S 636 3 0 0 0 14585 1 1 0 0 0 0 0 0 0 5145 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 43 6f 6d 6d 54 61 62 6c 65
S 637 3 0 0 0 14587 1 1 0 0 0 0 0 0 0 5160 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 15 45 53 4d 46 5f 52 6f 75 74 65 54 61 62 6c 65
S 638 3 0 0 0 14583 1 1 0 0 0 0 0 0 0 5176 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 52 6f 75 74 65
S 639 3 0 0 0 14589 1 1 0 0 0 0 0 0 0 5187 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 52 6f 75 74 65 48 61 6e 64 6c 65
S 640 3 0 0 0 14581 1 1 0 0 0 0 0 0 0 5204 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 46 69 65 6c 64 44 61 74 61 4d 61 70
S 641 3 0 0 0 14583 1 1 0 0 0 0 0 0 0 5222 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 46 69 65 6c 64
S 642 3 0 0 0 14589 1 1 0 0 0 0 0 0 0 5233 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 46 69 65 6c 64 42 75 6e 64 6c 65
S 643 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 20 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 644 3 0 0 0 14593 1 1 0 0 0 0 0 0 0 5250 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 20 45 53 4d 46 5f 54 72 61 6e 73 66 6f 72 6d 56 61 6c 75 65 73
S 645 3 0 0 0 14577 1 1 0 0 0 0 0 0 0 5271 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 52 65 67 72 69 64
S 646 3 0 0 0 14585 1 1 0 0 0 0 0 0 0 5283 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 54 72 61 6e 73 66 6f 72 6d
S 647 3 0 0 0 14583 1 1 0 0 0 0 0 0 0 5298 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 53 74 61 74 65
S 648 3 0 0 0 14595 1 1 0 0 0 0 0 0 0 5309 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 18 45 53 4d 46 5f 47 72 69 64 43 6f 6d 70 6f 6e 65 6e 74
S 649 3 0 0 0 14581 1 1 0 0 0 0 0 0 0 5328 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 43 70 6c 43 6f 6d 70 6f 6e 65 6e 74
S 650 3 0 0 0 14585 1 1 0 0 0 0 0 0 0 5346 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 43 6f 6d 70 6f 6e 65 6e 74
S 651 3 0 0 0 14589 1 1 0 0 0 0 0 0 0 5361 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 49 6e 74 65 72 6e 41 72 72 61 79
S 652 3 0 0 0 14575 1 1 0 0 0 0 0 0 0 5378 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 4e 6f 6e 65
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
R 712 5 14 esmf_utiltypesmod status esmf_status
R 714 6 16 esmf_utiltypesmod esmf_status_uninit$ac
R 716 6 18 esmf_utiltypesmod esmf_status_ready$ac
R 718 6 20 esmf_utiltypesmod esmf_status_unallocated$ac
R 720 6 22 esmf_utiltypesmod esmf_status_allocated$ac
R 722 6 24 esmf_utiltypesmod esmf_status_busy$ac
R 724 6 26 esmf_utiltypesmod esmf_status_invalid$ac
R 726 6 28 esmf_utiltypesmod esmf_status_not_ready$ac
R 727 25 29 esmf_utiltypesmod esmf_pointer
R 728 5 30 esmf_utiltypesmod ptr esmf_pointer
R 730 6 32 esmf_utiltypesmod esmf_null_pointer$ac
R 732 6 34 esmf_utiltypesmod esmf_bad_pointer$ac
R 733 25 35 esmf_utiltypesmod esmf_typekind
R 734 5 36 esmf_utiltypesmod dkind esmf_typekind
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
R 776 5 78 esmf_utiltypesmod objectid esmf_objectid
R 777 5 79 esmf_utiltypesmod objectname esmf_objectid
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
R 866 5 168 esmf_utiltypesmod value esmf_localglobalflag
R 868 6 170 esmf_utiltypesmod esmf_local$ac
R 870 6 172 esmf_utiltypesmod esmf_global$ac
R 871 25 173 esmf_utiltypesmod esmf_domaintypeflag
R 872 5 174 esmf_utiltypesmod value esmf_domaintypeflag
R 874 6 176 esmf_utiltypesmod esmf_domain_exclusive$ac
R 876 6 178 esmf_utiltypesmod esmf_domain_computational$ac
R 878 6 180 esmf_utiltypesmod esmf_domain_total$ac
R 880 6 182 esmf_utiltypesmod esmf_domain_allocated$ac
R 882 6 184 esmf_utiltypesmod esmf_domain_oldexclusive$ac
R 884 6 186 esmf_utiltypesmod esmf_domain_oldcomputational$ac
R 886 6 188 esmf_utiltypesmod esmf_domain_oldtotal$ac
R 887 25 189 esmf_utiltypesmod esmf_logical
R 888 5 190 esmf_utiltypesmod value esmf_logical
R 890 6 192 esmf_utiltypesmod esmf_true$ac
R 892 6 194 esmf_utiltypesmod esmf_false$ac
R 893 25 195 esmf_utiltypesmod esmf_reduceflag
R 894 5 196 esmf_utiltypesmod value esmf_reduceflag
R 896 6 198 esmf_utiltypesmod esmf_sum$ac
R 898 6 200 esmf_utiltypesmod esmf_min$ac
R 900 6 202 esmf_utiltypesmod esmf_max$ac
R 901 25 203 esmf_utiltypesmod esmf_blockingflag
R 902 5 204 esmf_utiltypesmod value esmf_blockingflag
R 904 6 206 esmf_utiltypesmod esmf_blocking$ac
R 906 6 208 esmf_utiltypesmod esmf_vasblocking$ac
R 908 6 210 esmf_utiltypesmod esmf_nonblocking$ac
R 909 25 211 esmf_utiltypesmod esmf_contextflag
R 910 5 212 esmf_utiltypesmod value esmf_contextflag
R 912 6 214 esmf_utiltypesmod esmf_child_in_new_vm$ac
R 914 6 216 esmf_utiltypesmod esmf_child_in_parent_vm$ac
R 915 25 217 esmf_utiltypesmod esmf_terminationflag
R 916 5 218 esmf_utiltypesmod value esmf_terminationflag
R 918 6 220 esmf_utiltypesmod esmf_final$ac
R 920 6 222 esmf_utiltypesmod esmf_keepmpi$ac
R 922 6 224 esmf_utiltypesmod esmf_abort$ac
R 923 25 225 esmf_utiltypesmod esmf_depinflag
R 924 5 226 esmf_utiltypesmod value esmf_depinflag
R 926 6 228 esmf_utiltypesmod esmf_de_pin_pet$ac
R 928 6 230 esmf_utiltypesmod esmf_de_pin_vas$ac
R 929 25 231 esmf_utiltypesmod esmf_direction
R 930 5 232 esmf_utiltypesmod value esmf_direction
R 932 6 234 esmf_utiltypesmod esmf_mode_forward$ac
R 934 6 236 esmf_utiltypesmod esmf_mode_reverse$ac
R 935 25 237 esmf_utiltypesmod esmf_indexflag
R 936 5 238 esmf_utiltypesmod i_type esmf_indexflag
R 938 6 240 esmf_utiltypesmod esmf_index_delocal$ac
R 940 6 242 esmf_utiltypesmod esmf_index_global$ac
R 941 25 243 esmf_utiltypesmod esmf_regionflag
R 942 5 244 esmf_utiltypesmod i_type esmf_regionflag
R 944 6 246 esmf_utiltypesmod esmf_region_total$ac
R 946 6 248 esmf_utiltypesmod esmf_region_select$ac
R 948 6 250 esmf_utiltypesmod esmf_region_empty$ac
R 1191 25 1 esmf_logerrmod esmf_msgtype
R 1192 5 2 esmf_logerrmod mtype esmf_msgtype
R 1194 6 4 esmf_logerrmod esmf_log_info$ac
R 1196 6 6 esmf_logerrmod esmf_log_warning$ac
R 1198 6 8 esmf_logerrmod esmf_log_error$ac
R 1199 25 9 esmf_logerrmod esmf_halttype
R 1200 5 10 esmf_logerrmod htype esmf_halttype
R 1202 6 12 esmf_logerrmod esmf_log_haltnever$ac
R 1204 6 14 esmf_logerrmod esmf_log_haltwarning$ac
R 1206 6 16 esmf_logerrmod esmf_log_halterror$ac
R 1207 25 17 esmf_logerrmod esmf_logtype
R 1208 5 18 esmf_logerrmod ftype esmf_logtype
R 1210 6 20 esmf_logerrmod esmf_log_single$ac
R 1212 6 22 esmf_logerrmod esmf_log_multi$ac
R 1214 6 24 esmf_logerrmod esmf_log_none$ac
S 1468 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 64 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 1639 25 4 esmf_vmmod esmf_vm
R 1640 5 5 esmf_vmmod this esmf_vm
R 1641 5 6 esmf_vmmod isinit esmf_vm
R 1645 25 10 esmf_vmmod esmf_vmid
R 1646 5 11 esmf_vmmod this esmf_vmid
R 3033 25 4 esmf_delayoutmod esmf_delayoutservicereply
R 3034 5 5 esmf_delayoutmod value esmf_delayoutservicereply
R 3036 6 7 esmf_delayoutmod esmf_delayout_service_accept$ac
R 3038 6 9 esmf_delayoutmod esmf_delayout_service_deny$ac
R 3331 25 1 esmf_arrayspecmod esmf_arrayspecstatus
R 3332 5 2 esmf_arrayspecmod status esmf_arrayspecstatus
R 3334 6 4 esmf_arrayspecmod esmf_arrayspec_status_unknown$ac
R 3336 6 6 esmf_arrayspecmod esmf_arrayspec_status_notset$ac
R 3338 6 8 esmf_arrayspecmod esmf_arrayspec_status_set$ac
R 3398 25 1 esmf_iospecmod esmf_iofileformat
R 3399 5 2 esmf_iospecmod iofileformat esmf_iofileformat
R 3401 6 4 esmf_iospecmod esmf_io_fileformat_unspecified$ac
R 3403 6 6 esmf_iospecmod esmf_io_fileformat_netcdf$ac
R 3405 6 8 esmf_iospecmod esmf_io_fileformat_hdf$ac
R 3406 25 9 esmf_iospecmod esmf_iorwtype
R 3407 5 10 esmf_iospecmod iorwtype esmf_iorwtype
R 3409 6 12 esmf_iospecmod esmf_io_rwtype_unspecified$ac
R 3411 6 14 esmf_iospecmod esmf_io_rwtype_readonly$ac
R 3413 6 16 esmf_iospecmod esmf_io_rwtype_writeonly$ac
R 3415 6 18 esmf_iospecmod esmf_io_rwtype_readwrite$ac
R 3417 6 20 esmf_iospecmod esmf_io_rwtype_append$ac
R 3419 6 22 esmf_iospecmod esmf_io_rwtype_truncate$ac
S 3495 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 19 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 3509 25 1 esmf_localarraycreatemod esmf_copyflag
R 3510 5 2 esmf_localarraycreatemod docopy esmf_copyflag
R 3512 6 4 esmf_localarraycreatemod esmf_data_copy$ac
R 3514 6 6 esmf_localarraycreatemod esmf_data_ref$ac
R 3516 6 8 esmf_localarraycreatemod esmf_data_defer$ac
R 3518 6 10 esmf_localarraycreatemod esmf_data_space$ac
R 3520 6 12 esmf_localarraycreatemod esmf_data_none$ac
R 3521 25 13 esmf_localarraycreatemod esmf_localarrayorigin
R 3522 5 14 esmf_localarraycreatemod origin esmf_localarrayorigin
R 3524 6 16 esmf_localarraycreatemod esmf_from_fortran$ac
R 3526 6 18 esmf_localarraycreatemod esmf_from_cplusplus$ac
S 8071 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 69 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 8076 25 4 esmf_routemod esmf_routeoptions
R 8077 5 5 esmf_routemod option esmf_routeoptions
R 8079 6 7 esmf_routemod esmf_route_option_async$ac
R 8081 6 9 esmf_routemod esmf_route_option_sync$ac
R 8083 6 11 esmf_routemod esmf_route_option_pack_pet$ac
R 8085 6 13 esmf_routemod esmf_route_option_pack_xp$ac
R 8087 6 15 esmf_routemod esmf_route_option_pack_nopack$ac
R 8089 6 17 esmf_routemod esmf_route_option_pack_vector$ac
R 8091 6 19 esmf_routemod esmf_route_option_pack_buffer$ac
R 8093 6 21 esmf_routemod esmf_route_option_default$ac
R 8462 25 4 esmf_distgridmod esmf_decompflag
R 8463 5 5 esmf_distgridmod value esmf_decompflag
R 8465 6 7 esmf_distgridmod esmf_decomp_default$ac
R 8467 6 9 esmf_distgridmod esmf_decomp_homogen$ac
R 8469 6 11 esmf_distgridmod esmf_decomp_restfirst$ac
R 8471 6 13 esmf_distgridmod esmf_decomp_restlast$ac
R 8473 6 15 esmf_distgridmod esmf_decomp_cyclic$ac
R 16651 25 2 esmf_calendarmod esmf_calendartype
R 16652 5 3 esmf_calendarmod calendartype esmf_calendartype
R 16654 6 5 esmf_calendarmod esmf_cal_gregorian$ac
R 16656 6 7 esmf_calendarmod esmf_cal_julian$ac
R 16658 6 9 esmf_calendarmod esmf_cal_julianday$ac
R 16660 6 11 esmf_calendarmod esmf_cal_noleap$ac
R 16662 6 13 esmf_calendarmod esmf_cal_360day$ac
R 16664 6 15 esmf_calendarmod esmf_cal_custom$ac
R 16666 6 17 esmf_calendarmod esmf_cal_nocalendar$ac
S 16888 3 0 0 0 6 1 1 0 0 0 0 0 0 0 -1 -2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 16890 25 1 esmf_staggerlocmod esmf_staggerloc
R 16891 5 2 esmf_staggerlocmod staggerloc esmf_staggerloc
R 16899 6 10 esmf_staggerlocmod esmf_staggerloc_invalid$ac
R 16901 6 12 esmf_staggerlocmod esmf_staggerloc_uninit$ac
R 16903 6 14 esmf_staggerlocmod esmf_staggerloc_center$ac
R 16905 6 16 esmf_staggerlocmod esmf_staggerloc_edge1$ac
R 16907 6 18 esmf_staggerlocmod esmf_staggerloc_edge2$ac
R 16909 6 20 esmf_staggerlocmod esmf_staggerloc_corner$ac
R 16911 6 22 esmf_staggerlocmod esmf_staggerloc_center_vcenter$ac
R 16913 6 24 esmf_staggerlocmod esmf_staggerloc_edge1_vcenter$ac
R 16915 6 26 esmf_staggerlocmod esmf_staggerloc_edge2_vcenter$ac
R 16917 6 28 esmf_staggerlocmod esmf_staggerloc_corner_vcenter$ac
R 16919 6 30 esmf_staggerlocmod esmf_staggerloc_center_vface$ac
R 16921 6 32 esmf_staggerlocmod esmf_staggerloc_edge1_vface$ac
R 16923 6 34 esmf_staggerlocmod esmf_staggerloc_edge2_vface$ac
R 16925 6 36 esmf_staggerlocmod esmf_staggerloc_corner_vface$ac
R 17009 25 4 esmf_gridmod esmf_gridstatus
R 17010 5 5 esmf_gridmod gridstatus esmf_gridstatus
R 17012 6 7 esmf_gridmod esmf_gridstatus_invalid$ac
R 17014 6 9 esmf_gridmod esmf_gridstatus_uninit$ac
R 17016 6 11 esmf_gridmod esmf_gridstatus_not_ready$ac
R 17018 6 13 esmf_gridmod esmf_gridstatus_shape_ready$ac
R 17019 25 14 esmf_gridmod esmf_gridconn
R 17020 5 15 esmf_gridmod gridconn esmf_gridconn
R 17022 6 17 esmf_gridmod esmf_gridconn_none$ac
R 17024 6 19 esmf_gridmod esmf_gridconn_periodic$ac
R 17026 6 21 esmf_gridmod esmf_gridconn_pole$ac
R 17028 6 23 esmf_gridmod esmf_gridconn_bipole$ac
R 18519 25 1 esmf_fieldmod esmf_access
R 18520 5 2 esmf_fieldmod a_type esmf_access
R 18522 6 4 esmf_fieldmod esmf_readwrite$ac
R 18524 6 6 esmf_fieldmod esmf_readonly$ac
R 18525 25 7 esmf_fieldmod esmf_allocflag
R 18526 5 8 esmf_fieldmod a_type esmf_allocflag
R 18528 6 10 esmf_fieldmod esmf_alloc$ac
R 18530 6 12 esmf_fieldmod esmf_no_alloc$ac
R 18873 25 1 esmf_internarraydatamapmod esmf_interleaveflag
R 18874 5 2 esmf_internarraydatamapmod il esmf_interleaveflag
R 18876 6 4 esmf_internarraydatamapmod esmf_interleave_by_block$ac
R 18878 6 6 esmf_internarraydatamapmod esmf_interleave_by_item$ac
R 18884 25 12 esmf_internarraydatamapmod esmf_relloc
R 18885 5 13 esmf_internarraydatamapmod relloc esmf_relloc
R 18887 6 15 esmf_internarraydatamapmod esmf_cell_undefined$ac
R 18889 6 17 esmf_internarraydatamapmod esmf_cell_center$ac
R 18891 6 19 esmf_internarraydatamapmod esmf_cell_nface$ac
R 18893 6 21 esmf_internarraydatamapmod esmf_cell_sface$ac
R 18895 6 23 esmf_internarraydatamapmod esmf_cell_eface$ac
R 18897 6 25 esmf_internarraydatamapmod esmf_cell_wface$ac
R 18899 6 27 esmf_internarraydatamapmod esmf_cell_necorner$ac
R 18901 6 29 esmf_internarraydatamapmod esmf_cell_nwcorner$ac
R 18903 6 31 esmf_internarraydatamapmod esmf_cell_secorner$ac
R 18905 6 33 esmf_internarraydatamapmod esmf_cell_swcorner$ac
R 18907 6 35 esmf_internarraydatamapmod esmf_cell_topface$ac
R 18909 6 37 esmf_internarraydatamapmod esmf_cell_botface$ac
R 18911 6 39 esmf_internarraydatamapmod esmf_cell_cell$ac
R 18913 6 41 esmf_internarraydatamapmod esmf_cell_vertex$ac
R 18914 25 42 esmf_internarraydatamapmod esmf_indexorder
R 18915 5 43 esmf_internarraydatamapmod iorder esmf_indexorder
R 18917 6 45 esmf_internarraydatamapmod esmf_index_i$ac
R 18919 6 47 esmf_internarraydatamapmod esmf_index_ij$ac
R 18921 6 49 esmf_internarraydatamapmod esmf_index_ji$ac
R 18923 6 51 esmf_internarraydatamapmod esmf_index_ijk$ac
R 18925 6 53 esmf_internarraydatamapmod esmf_index_jik$ac
R 18927 6 55 esmf_internarraydatamapmod esmf_index_kji$ac
R 18929 6 57 esmf_internarraydatamapmod esmf_index_ikj$ac
R 18931 6 59 esmf_internarraydatamapmod esmf_index_jki$ac
R 18933 6 61 esmf_internarraydatamapmod esmf_index_kij$ac
R 19504 25 1 esmf_fieldbundlemod esmf_packflag
R 19505 5 2 esmf_fieldbundlemod packflag esmf_packflag
R 19507 6 4 esmf_fieldbundlemod esmf_packed_data$ac
R 19509 6 6 esmf_fieldbundlemod esmf_no_packed_data$ac
S 20038 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 101 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 20039 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 102 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 20040 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 103 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 20041 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 104 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 20042 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 105 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 20043 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 106 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 20044 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 107 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 20045 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 108 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 20046 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 109 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 20047 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 110 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 20049 25 1 esmf_statetypesmod esmf_statetype
R 20050 5 2 esmf_statetypesmod state esmf_statetype
R 20052 6 4 esmf_statetypesmod esmf_state_import$ac
R 20054 6 6 esmf_statetypesmod esmf_state_export$ac
R 20056 6 8 esmf_statetypesmod esmf_state_unspecified$ac
R 20058 6 10 esmf_statetypesmod esmf_state_invalid$ac
R 20059 25 11 esmf_statetypesmod esmf_stateitemtype
R 20060 5 12 esmf_statetypesmod ot esmf_stateitemtype
R 20062 6 14 esmf_statetypesmod esmf_stateitem_field$ac
R 20064 6 16 esmf_statetypesmod esmf_stateitem_fieldbundle$ac
R 20066 6 18 esmf_statetypesmod esmf_stateitem_array$ac
R 20068 6 20 esmf_statetypesmod esmf_stateitem_arraybundle$ac
R 20070 6 22 esmf_statetypesmod esmf_stateitem_routehandle$ac
R 20072 6 24 esmf_statetypesmod esmf_stateitem_state$ac
R 20074 6 26 esmf_statetypesmod esmf_stateitem_name$ac
R 20076 6 28 esmf_statetypesmod esmf_stateitem_indirect$ac
R 20078 6 30 esmf_statetypesmod esmf_stateitem_unknown$ac
R 20080 6 32 esmf_statetypesmod esmf_stateitem_notfound$ac
R 20081 25 33 esmf_statetypesmod esmf_neededflag
R 20082 5 34 esmf_statetypesmod needed esmf_neededflag
R 20084 6 36 esmf_statetypesmod esmf_needed$ac
R 20086 6 38 esmf_statetypesmod esmf_notneeded$ac
R 20087 25 39 esmf_statetypesmod esmf_readyflag
R 20088 5 40 esmf_statetypesmod ready esmf_readyflag
R 20090 6 42 esmf_statetypesmod esmf_readytowrite$ac
R 20092 6 44 esmf_statetypesmod esmf_readytoread$ac
R 20094 6 46 esmf_statetypesmod esmf_notready$ac
R 20095 25 47 esmf_statetypesmod esmf_reqforrestartflag
R 20096 5 48 esmf_statetypesmod required4restart esmf_reqforrestartflag
R 20098 6 50 esmf_statetypesmod esmf_required_for_restart$ac
R 20100 6 52 esmf_statetypesmod esmf_notrequired_for_restart$ac
R 20101 25 53 esmf_statetypesmod esmf_validflag
R 20102 5 54 esmf_statetypesmod valid esmf_validflag
R 20104 6 56 esmf_statetypesmod esmf_valid$ac
R 20106 6 58 esmf_statetypesmod esmf_invalid$ac
R 20108 6 60 esmf_statetypesmod esmf_validityunknown$ac
R 20148 25 100 esmf_statetypesmod esmf_state
R 20149 5 101 esmf_statetypesmod statep esmf_state
R 20151 5 103 esmf_statetypesmod statep$p esmf_state
R 20153 5 105 esmf_statetypesmod isinit esmf_state
S 20980 6 4 0 0 6 1 582 96534 80001c 0 0 0 0 0 0 0 0 0 21055 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 bufsize
S 20982 25 0 0 0 14771 1 582 96542 10800014 800014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 21054 0 0 0 582 0 0 0 0 esmf_stateiteminfo
S 20983 6 4 0 0 6 20989 582 95512 40800016 0 0 0 0 0 0 0 0 0 21056 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_0_6
S 20984 5 6 0 0 14777 20986 582 96561 10a00014 14 0 0 20986 0 14771 0 20988 0 0 0 0 0 0 0 0 20985 1 20984 20987 582 0 0 0 0 childlist
S 20985 5 0 0 0 14780 20990 582 96571 40822004 1020 0 16 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 20987 20985 0 582 0 0 0 0 childlist$sd
S 20986 5 0 0 0 7 20987 582 96584 40802001 1020 0 0 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 20984 20986 0 582 0 0 0 0 childlist$p
S 20987 5 0 0 0 7 20985 582 96596 40802000 1020 0 8 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 20986 20987 0 582 0 0 0 0 childlist$o
S 20988 22 1 0 0 8 1 582 96608 40000000 1000 0 0 0 20984 0 0 0 0 20985 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 childlist$arrdsc
S 20989 6 4 0 0 6 20997 582 96625 40800016 0 0 4 0 0 0 0 0 0 21056 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_1_4
S 20990 5 6 0 0 14783 20992 582 96633 10a00014 14 0 88 20992 0 14771 0 20994 0 0 0 0 0 0 0 0 20991 20984 20990 20993 582 0 0 0 0 attrlist
S 20991 5 0 0 0 14786 20995 582 96642 40822004 1020 0 104 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 20993 20991 0 582 0 0 0 0 attrlist$sd
S 20992 5 0 0 0 7 20993 582 96654 40802001 1020 0 88 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 20990 20992 0 582 0 0 0 0 attrlist$p
S 20993 5 0 0 0 7 20991 582 96665 40802000 1020 0 96 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 20992 20993 0 582 0 0 0 0 attrlist$o
S 20994 22 1 0 0 8 1 582 96676 40000000 1000 0 0 0 20990 0 0 0 0 20991 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 attrlist$arrdsc
S 20995 5 0 0 0 6 20996 582 96692 800014 0 0 176 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 20990 20995 0 582 0 0 0 0 mycount
S 20996 5 0 0 0 6 20998 582 96700 800014 0 0 180 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 20995 20996 0 582 0 0 0 0 theircount
S 20997 6 4 0 0 6 21004 582 47272 40800016 0 0 8 0 0 0 0 0 0 21056 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_2_3
S 20998 5 6 0 0 14789 21000 582 96711 10a00014 14 0 184 21000 0 14771 0 21002 0 0 0 0 0 0 0 0 20999 20996 20998 21001 582 0 0 0 0 idsend
S 20999 5 0 0 0 14792 21003 582 96718 40822004 1020 0 200 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 21001 20999 0 582 0 0 0 0 idsend$sd
S 21000 5 0 0 0 7 21001 582 96728 40802001 1020 0 184 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 20998 21000 0 582 0 0 0 0 idsend$p
S 21001 5 0 0 0 7 20999 582 96737 40802000 1020 0 192 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 21000 21001 0 582 0 0 0 0 idsend$o
S 21002 22 1 0 0 6 1 582 96746 40000000 1000 0 0 0 20998 0 0 0 0 20999 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 idsend$arrdsc
S 21003 5 6 0 0 14795 21006 582 96760 10a00014 14 0 272 21006 0 14771 0 21008 0 0 0 0 0 0 0 0 21005 20998 21003 21007 582 0 0 0 0 idrecv
S 21004 6 4 0 0 6 21009 582 47280 40800016 0 0 12 0 0 0 0 0 0 21056 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_3_2
S 21005 5 0 0 0 14798 21010 582 96767 40822004 1020 0 288 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 21007 21005 0 582 0 0 0 0 idrecv$sd
S 21006 5 0 0 0 7 21007 582 96777 40802001 1020 0 272 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 21003 21006 0 582 0 0 0 0 idrecv$p
S 21007 5 0 0 0 7 21005 582 96786 40802000 1020 0 280 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 21006 21007 0 582 0 0 0 0 idrecv$o
S 21008 22 1 0 0 6 1 582 96795 40000000 1000 0 0 0 21003 0 0 0 0 21005 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 idrecv$arrdsc
S 21009 6 4 0 0 6 21016 582 47297 40800016 0 0 16 0 0 0 0 0 0 21056 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_4_2
S 21010 5 6 0 0 14801 21012 582 96809 10a00014 14 0 360 21012 0 14771 0 21014 0 0 0 0 0 0 0 0 21011 21003 21010 21013 582 0 0 0 0 vmidsend
S 21011 5 0 0 0 14804 21015 582 96818 40822004 1020 0 376 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 21013 21011 0 582 0 0 0 0 vmidsend$sd
S 21012 5 0 0 0 7 21013 582 96830 40802001 1020 0 360 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 21010 21012 0 582 0 0 0 0 vmidsend$p
S 21013 5 0 0 0 7 21011 582 96841 40802000 1020 0 368 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 21012 21013 0 582 0 0 0 0 vmidsend$o
S 21014 22 1 0 0 8 1 582 96852 40000000 1000 0 0 0 21010 0 0 0 0 21011 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 vmidsend$arrdsc
S 21015 5 6 0 0 14807 21018 582 96868 10a00014 14 0 448 21018 0 14771 0 21020 0 0 0 0 0 0 0 0 21017 21010 21015 21019 582 0 0 0 0 vmidrecv
S 21016 6 4 0 0 6 21021 582 52100 40800016 0 0 20 0 0 0 0 0 0 21056 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_5_2
S 21017 5 0 0 0 14810 21022 582 96877 40822004 1020 0 464 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 21019 21017 0 582 0 0 0 0 vmidrecv$sd
S 21018 5 0 0 0 7 21019 582 96889 40802001 1020 0 448 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 21015 21018 0 582 0 0 0 0 vmidrecv$p
S 21019 5 0 0 0 7 21017 582 96900 40802000 1020 0 456 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 21018 21019 0 582 0 0 0 0 vmidrecv$o
S 21020 22 1 0 0 8 1 582 96911 40000000 1000 0 0 0 21015 0 0 0 0 21017 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 vmidrecv$arrdsc
S 21021 6 4 0 0 6 21028 582 47305 40800016 0 0 24 0 0 0 0 0 0 21056 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_6_2
S 21022 5 6 0 0 14813 21024 582 96927 10a00014 14 0 536 21024 0 14771 0 21026 0 0 0 0 0 0 0 0 21023 21015 21022 21025 582 0 0 0 0 objsend
S 21023 5 0 0 0 14816 21027 582 96935 40822004 1020 0 552 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 21025 21023 0 582 0 0 0 0 objsend$sd
S 21024 5 0 0 0 7 21025 582 96946 40802001 1020 0 536 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 21022 21024 0 582 0 0 0 0 objsend$p
S 21025 5 0 0 0 7 21023 582 96956 40802000 1020 0 544 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 21024 21025 0 582 0 0 0 0 objsend$o
S 21026 22 1 0 0 8 1 582 96966 40000000 1000 0 0 0 21022 0 0 0 0 21023 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 objsend$arrdsc
S 21027 5 6 0 0 14819 21030 582 96981 10a00014 14 0 624 21030 0 14771 0 21032 0 0 0 0 0 0 0 0 21029 21022 21027 21031 582 0 0 0 0 objrecv
S 21028 6 4 0 0 6 21033 582 46742 40800016 0 0 28 0 0 0 0 0 0 21056 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_7_2
S 21029 5 0 0 0 14822 21035 582 96989 40822004 1020 0 640 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 21031 21029 0 582 0 0 0 0 objrecv$sd
S 21030 5 0 0 0 7 21031 582 97000 40802001 1020 0 624 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 21027 21030 0 582 0 0 0 0 objrecv$p
S 21031 5 0 0 0 7 21029 582 97010 40802000 1020 0 632 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 21030 21031 0 582 0 0 0 0 objrecv$o
S 21032 22 1 0 0 8 1 582 97020 40000000 1000 0 0 0 21027 0 0 0 0 21029 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 objrecv$arrdsc
S 21033 6 4 0 0 6 21034 582 51958 40800016 0 0 32 0 0 0 0 0 0 21056 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_8_2
S 21034 6 4 0 0 6 21041 582 46750 40800016 0 0 36 0 0 0 0 0 0 21056 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_9_2
S 21035 5 6 0 0 14825 21037 582 97035 10a00014 14 0 712 21037 0 14771 0 21039 0 0 0 0 0 0 0 0 21036 21027 21035 21038 582 0 0 0 0 blindsend
S 21036 5 0 0 0 14828 21040 582 97045 40822004 1020 0 728 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 21038 21036 0 582 0 0 0 0 blindsend$sd
S 21037 5 0 0 0 7 21038 582 97058 40802001 1020 0 712 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 21035 21037 0 582 0 0 0 0 blindsend$p
S 21038 5 0 0 0 7 21036 582 97070 40802000 1020 0 720 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 21037 21038 0 582 0 0 0 0 blindsend$o
S 21039 22 1 0 0 8 1 582 97082 40000000 1000 0 0 0 21035 0 0 0 0 21036 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 blindsend$arrdsc
S 21040 5 6 0 0 14831 21044 582 97099 10a00014 14 0 824 21044 0 14771 0 21046 0 0 0 0 0 0 0 0 21043 21035 21040 21045 582 0 0 0 0 blindrecv
S 21041 6 4 0 0 6 21042 582 46758 40800016 0 0 40 0 0 0 0 0 0 21056 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_10_2
S 21042 6 4 0 0 6 1 582 46776 40800016 0 0 44 0 0 0 0 0 0 21056 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 z_b_11_2
S 21043 5 0 0 0 14834 1 582 97109 40822004 1020 0 840 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 21045 21043 0 582 0 0 0 0 blindrecv$sd
S 21044 5 0 0 0 7 21045 582 97122 40802001 1020 0 824 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 21040 21044 0 582 0 0 0 0 blindrecv$p
S 21045 5 0 0 0 7 21043 582 97134 40802000 1020 0 832 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 21044 21045 0 582 0 0 0 0 blindrecv$o
S 21046 22 1 0 0 8 1 582 97146 40000000 1000 0 0 0 21040 0 0 0 0 21043 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 blindrecv$arrdsc
S 21047 16 0 0 0 6 1 582 97163 14 400000 0 0 0 0 1 3 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_bt_newobj
S 21048 16 0 0 0 6 1 582 97178 14 400000 0 0 0 0 2 45 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_bt_dupobj
S 21049 16 0 0 0 6 1 582 97193 14 400000 0 0 0 0 3 32 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_bt_endmarker
S 21050 27 0 0 0 8 21057 582 97211 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_statereconcile
S 21051 3 0 0 0 6 0 1 0 0 0 0 0 0 0 0 73 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 21052 3 0 0 0 14837 0 1 0 0 0 0 0 0 0 97231 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 73 24 49 64 3a 20 45 53 4d 46 5f 53 74 61 74 65 52 65 63 6f 6e 63 69 6c 65 2e 46 39 30 2c 76 20 31 2e 34 32 2e 32 2e 35 20 32 30 30 38 2f 30 35 2f 30 36 20 30 34 3a 33 31 3a 34 30 20 63 64 65 6c 75 63 61 20 45 78 70 20 24
S 21053 16 0 0 0 14837 1 582 14050 14 440000 0 0 0 0 21052 17723 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 version
S 21054 8 5 0 0 14839 1 582 97305 40022004 1220 0 0 0 14771 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_statereconcilemod$esmf_stateiteminfo$td
S 21055 11 0 0 0 8 20187 582 97350 40800010 801000 0 4 0 0 20980 20980 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 _esmf_statereconcilemod$12
S 21056 11 0 0 0 8 21055 582 97377 40800010 801000 0 48 0 0 20983 21042 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 _esmf_statereconcilemod$4
S 21057 23 5 0 0 0 21062 582 97211 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_statereconcile
S 21058 1 3 3 0 14254 1 21057 91602 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 state
S 21059 1 3 1 0 835 1 21057 16566 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 vm
S 21060 1 3 1 0 28 1 21057 14307 80000014 43000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 options
S 21061 1 3 2 0 6 1 21057 11718 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 21062 14 5 0 0 0 1 21057 97211 0 400000 0 0 0 7262 4 0 0 0 0 0 0 0 0 0 0 0 0 139 0 582 0 0 0 0 esmf_statereconcile
F 21062 4 21058 21059 21060 21061
S 21063 23 5 0 0 0 21068 582 97403 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_stateinfobuild
S 21064 1 3 1 0 14254 1 21063 91602 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 state
S 21065 7 3 0 0 14842 1 21063 97423 10800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 21069 0 0 0 0 0 0 0 0 stateinfolist
S 21066 1 3 1 0 835 1 21063 16566 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 vm
S 21067 1 3 2 0 6 1 21063 11718 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 21068 14 5 0 0 0 1 21063 97403 10 400000 0 0 0 7267 4 0 0 0 0 0 0 0 0 0 0 0 0 232 0 582 0 0 0 0 esmf_stateinfobuild
F 21068 4 21064 21065 21066 21067
S 21069 8 1 0 0 14845 1 21063 97437 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 stateinfolist$sd
S 21073 23 5 0 0 0 21076 582 97507 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_stateinfodrop
S 21074 7 3 0 0 14848 1 21073 97423 10800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 21077 0 0 0 0 0 0 0 0 stateinfolist
S 21075 1 3 2 0 6 1 21073 11718 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 21076 14 5 0 0 0 1 21073 97507 10 400000 0 0 0 7272 2 0 0 0 0 0 0 0 0 0 0 0 0 430 0 582 0 0 0 0 esmf_stateinfodrop
F 21076 2 21074 21075
S 21077 8 1 0 0 14851 1 21073 97526 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 stateinfolist$sd1
S 21081 23 5 0 0 0 21086 582 97600 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_stateproxycreate
S 21082 1 3 3 0 14254 1 21081 91602 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 state
S 21083 7 3 0 0 14854 1 21081 97423 10800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 21087 0 0 0 0 0 0 0 0 stateinfolist
S 21084 1 3 1 0 835 1 21081 16566 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 vm
S 21085 1 3 2 0 6 1 21081 11718 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 21086 14 5 0 0 0 1 21081 97600 10 400000 0 0 0 7275 4 0 0 0 0 0 0 0 0 0 0 0 0 510 0 582 0 0 0 0 esmf_stateproxycreate
F 21086 4 21082 21083 21084 21085
S 21087 8 1 0 0 14857 1 21081 97622 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 stateinfolist$sd5
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
A 404 1 0 0 0 46 714 0 0 0 0 0 0 0 0 0 0 0 0 0
A 407 1 0 0 0 46 716 0 0 0 0 0 0 0 0 0 0 0 0 0
A 410 1 0 0 0 46 718 0 0 0 0 0 0 0 0 0 0 0 0 0
A 413 1 0 0 0 46 720 0 0 0 0 0 0 0 0 0 0 0 0 0
A 416 1 0 0 0 46 722 0 0 0 0 0 0 0 0 0 0 0 0 0
A 419 1 0 0 0 46 724 0 0 0 0 0 0 0 0 0 0 0 0 0
A 422 1 0 0 0 46 726 0 0 0 0 0 0 0 0 0 0 0 0 0
A 425 1 0 0 0 52 730 0 0 0 0 0 0 0 0 0 0 0 0 0
A 428 1 0 0 0 52 732 0 0 0 0 0 0 0 0 0 0 0 0 0
A 431 1 0 0 0 58 736 0 0 0 0 0 0 0 0 0 0 0 0 0
A 434 1 0 0 0 58 738 0 0 0 0 0 0 0 0 0 0 0 0 0
A 437 1 0 0 0 58 740 0 0 0 0 0 0 0 0 0 0 0 0 0
A 440 1 0 0 0 58 742 0 0 0 0 0 0 0 0 0 0 0 0 0
A 443 1 0 0 0 58 744 0 0 0 0 0 0 0 0 0 0 0 0 0
A 446 1 0 0 0 58 746 0 0 0 0 0 0 0 0 0 0 0 0 0
A 449 1 0 0 0 58 748 0 0 0 0 0 0 0 0 0 0 0 0 0
A 452 1 0 0 0 58 750 0 0 0 0 0 0 0 0 0 0 0 0 0
A 455 1 0 0 0 58 752 0 0 0 0 0 0 0 0 0 0 0 0 0
A 458 1 0 0 0 58 754 0 0 0 0 0 0 0 0 0 0 0 0 0
A 461 1 0 0 0 58 756 0 0 0 0 0 0 0 0 0 0 0 0 0
A 464 1 0 0 0 58 758 0 0 0 0 0 0 0 0 0 0 0 0 0
A 467 1 0 0 0 58 760 0 0 0 0 0 0 0 0 0 0 0 0 0
A 468 2 0 0 0 78 614 0 0 0 468 0 0 0 0 0 0 0 0 0
A 472 1 0 0 232 70 779 0 0 0 0 0 0 0 0 0 0 0 0 0
A 473 2 0 0 296 80 616 0 0 0 473 0 0 0 0 0 0 0 0 0
A 477 1 0 0 203 70 781 0 0 0 0 0 0 0 0 0 0 0 0 0
A 478 2 0 0 220 80 617 0 0 0 478 0 0 0 0 0 0 0 0 0
A 482 1 0 0 209 70 783 0 0 0 0 0 0 0 0 0 0 0 0 0
A 483 2 0 0 337 78 618 0 0 0 483 0 0 0 0 0 0 0 0 0
A 487 1 0 0 215 70 785 0 0 0 0 0 0 0 0 0 0 0 0 0
A 488 2 0 0 0 82 620 0 0 0 488 0 0 0 0 0 0 0 0 0
A 492 1 0 0 221 70 787 0 0 0 0 0 0 0 0 0 0 0 0 0
A 493 2 0 0 238 84 622 0 0 0 493 0 0 0 0 0 0 0 0 0
A 497 1 0 0 227 70 789 0 0 0 0 0 0 0 0 0 0 0 0 0
A 498 2 0 0 0 86 623 0 0 0 498 0 0 0 0 0 0 0 0 0
A 502 1 0 0 0 70 791 0 0 0 0 0 0 0 0 0 0 0 0 0
A 503 2 0 0 244 86 624 0 0 0 503 0 0 0 0 0 0 0 0 0
A 507 1 0 0 0 70 793 0 0 0 0 0 0 0 0 0 0 0 0 0
A 508 2 0 0 250 88 626 0 0 0 508 0 0 0 0 0 0 0 0 0
A 512 1 0 0 0 70 795 0 0 0 0 0 0 0 0 0 0 0 0 0
A 513 2 0 0 256 90 628 0 0 0 513 0 0 0 0 0 0 0 0 0
A 517 1 0 0 0 70 797 0 0 0 0 0 0 0 0 0 0 0 0 0
A 518 2 0 0 262 92 630 0 0 0 518 0 0 0 0 0 0 0 0 0
A 522 1 0 0 0 70 799 0 0 0 0 0 0 0 0 0 0 0 0 0
A 523 2 0 0 0 94 631 0 0 0 523 0 0 0 0 0 0 0 0 0
A 527 1 0 0 268 70 801 0 0 0 0 0 0 0 0 0 0 0 0 0
A 528 2 0 0 0 82 632 0 0 0 528 0 0 0 0 0 0 0 0 0
A 532 1 0 0 274 70 803 0 0 0 0 0 0 0 0 0 0 0 0 0
A 533 2 0 0 273 80 633 0 0 0 533 0 0 0 0 0 0 0 0 0
A 537 1 0 0 280 70 805 0 0 0 0 0 0 0 0 0 0 0 0 0
A 538 2 0 0 0 86 634 0 0 0 538 0 0 0 0 0 0 0 0 0
A 542 1 0 0 286 70 807 0 0 0 0 0 0 0 0 0 0 0 0 0
A 543 2 0 0 279 82 635 0 0 0 543 0 0 0 0 0 0 0 0 0
A 547 1 0 0 292 70 809 0 0 0 0 0 0 0 0 0 0 0 0 0
A 548 2 0 0 0 88 636 0 0 0 548 0 0 0 0 0 0 0 0 0
A 552 1 0 0 0 70 811 0 0 0 0 0 0 0 0 0 0 0 0 0
A 553 2 0 0 285 90 637 0 0 0 553 0 0 0 0 0 0 0 0 0
A 557 1 0 0 0 70 813 0 0 0 0 0 0 0 0 0 0 0 0 0
A 558 2 0 0 0 86 638 0 0 0 558 0 0 0 0 0 0 0 0 0
A 562 1 0 0 0 70 815 0 0 0 0 0 0 0 0 0 0 0 0 0
A 563 2 0 0 291 92 639 0 0 0 563 0 0 0 0 0 0 0 0 0
A 567 1 0 0 117 70 817 0 0 0 0 0 0 0 0 0 0 0 0 0
A 568 2 0 0 0 84 640 0 0 0 568 0 0 0 0 0 0 0 0 0
A 572 1 0 0 119 70 819 0 0 0 0 0 0 0 0 0 0 0 0 0
A 573 2 0 0 0 86 641 0 0 0 573 0 0 0 0 0 0 0 0 0
A 577 1 0 0 121 70 821 0 0 0 0 0 0 0 0 0 0 0 0 0
A 578 2 0 0 0 92 642 0 0 0 578 0 0 0 0 0 0 0 0 0
A 582 1 0 0 123 70 823 0 0 0 0 0 0 0 0 0 0 0 0 0
A 583 2 0 0 0 96 644 0 0 0 583 0 0 0 0 0 0 0 0 0
A 587 1 0 0 0 70 825 0 0 0 0 0 0 0 0 0 0 0 0 0
A 588 2 0 0 0 80 645 0 0 0 588 0 0 0 0 0 0 0 0 0
A 592 1 0 0 125 70 827 0 0 0 0 0 0 0 0 0 0 0 0 0
A 593 2 0 0 0 88 646 0 0 0 593 0 0 0 0 0 0 0 0 0
A 597 1 0 0 0 70 829 0 0 0 0 0 0 0 0 0 0 0 0 0
A 598 2 0 0 0 86 647 0 0 0 598 0 0 0 0 0 0 0 0 0
A 602 1 0 0 182 70 831 0 0 0 0 0 0 0 0 0 0 0 0 0
A 603 2 0 0 0 98 648 0 0 0 603 0 0 0 0 0 0 0 0 0
A 607 1 0 0 0 70 833 0 0 0 0 0 0 0 0 0 0 0 0 0
A 608 2 0 0 0 84 649 0 0 0 608 0 0 0 0 0 0 0 0 0
A 612 1 0 0 0 70 835 0 0 0 0 0 0 0 0 0 0 0 0 0
A 613 2 0 0 0 88 650 0 0 0 613 0 0 0 0 0 0 0 0 0
A 617 1 0 0 208 70 837 0 0 0 0 0 0 0 0 0 0 0 0 0
A 618 2 0 0 0 92 651 0 0 0 618 0 0 0 0 0 0 0 0 0
A 622 1 0 0 214 70 839 0 0 0 0 0 0 0 0 0 0 0 0 0
A 623 2 0 0 38 78 652 0 0 0 623 0 0 0 0 0 0 0 0 0
A 627 1 0 0 478 70 841 0 0 0 0 0 0 0 0 0 0 0 0 0
A 630 1 0 0 0 127 868 0 0 0 0 0 0 0 0 0 0 0 0 0
A 633 1 0 0 0 127 870 0 0 0 0 0 0 0 0 0 0 0 0 0
A 636 1 0 0 572 133 874 0 0 0 0 0 0 0 0 0 0 0 0 0
A 639 1 0 0 577 133 876 0 0 0 0 0 0 0 0 0 0 0 0 0
A 642 1 0 0 582 133 878 0 0 0 0 0 0 0 0 0 0 0 0 0
A 645 1 0 0 587 133 880 0 0 0 0 0 0 0 0 0 0 0 0 0
A 648 1 0 0 592 133 882 0 0 0 0 0 0 0 0 0 0 0 0 0
A 651 1 0 0 597 133 884 0 0 0 0 0 0 0 0 0 0 0 0 0
A 654 1 0 0 602 133 886 0 0 0 0 0 0 0 0 0 0 0 0 0
A 657 1 0 0 612 139 890 0 0 0 0 0 0 0 0 0 0 0 0 0
A 660 1 0 0 617 139 892 0 0 0 0 0 0 0 0 0 0 0 0 0
A 663 1 0 0 0 145 896 0 0 0 0 0 0 0 0 0 0 0 0 0
A 666 1 0 0 0 145 898 0 0 0 0 0 0 0 0 0 0 0 0 0
A 669 1 0 0 0 145 900 0 0 0 0 0 0 0 0 0 0 0 0 0
A 672 1 0 0 10 151 904 0 0 0 0 0 0 0 0 0 0 0 0 0
A 675 1 0 0 11 151 906 0 0 0 0 0 0 0 0 0 0 0 0 0
A 678 1 0 0 0 151 908 0 0 0 0 0 0 0 0 0 0 0 0 0
A 681 1 0 0 0 157 912 0 0 0 0 0 0 0 0 0 0 0 0 0
A 684 1 0 0 0 157 914 0 0 0 0 0 0 0 0 0 0 0 0 0
A 687 1 0 0 0 163 918 0 0 0 0 0 0 0 0 0 0 0 0 0
A 690 1 0 0 0 163 920 0 0 0 0 0 0 0 0 0 0 0 0 0
A 693 1 0 0 0 163 922 0 0 0 0 0 0 0 0 0 0 0 0 0
A 696 1 0 0 0 169 926 0 0 0 0 0 0 0 0 0 0 0 0 0
A 699 1 0 0 0 169 928 0 0 0 0 0 0 0 0 0 0 0 0 0
A 702 1 0 0 0 175 932 0 0 0 0 0 0 0 0 0 0 0 0 0
A 705 1 0 0 0 175 934 0 0 0 0 0 0 0 0 0 0 0 0 0
A 708 1 0 0 407 181 938 0 0 0 0 0 0 0 0 0 0 0 0 0
A 711 1 0 0 410 181 940 0 0 0 0 0 0 0 0 0 0 0 0 0
A 714 1 0 0 416 187 944 0 0 0 0 0 0 0 0 0 0 0 0 0
A 717 1 0 0 419 187 946 0 0 0 0 0 0 0 0 0 0 0 0 0
A 720 1 0 0 422 187 948 0 0 0 0 0 0 0 0 0 0 0 0 0
A 805 1 0 0 455 390 1194 0 0 0 0 0 0 0 0 0 0 0 0 0
A 808 1 0 0 458 390 1196 0 0 0 0 0 0 0 0 0 0 0 0 0
A 811 1 0 0 461 390 1198 0 0 0 0 0 0 0 0 0 0 0 0 0
A 814 1 0 0 467 396 1202 0 0 0 0 0 0 0 0 0 0 0 0 0
A 817 1 0 0 0 396 1204 0 0 0 0 0 0 0 0 0 0 0 0 0
A 820 1 0 0 0 396 1206 0 0 0 0 0 0 0 0 0 0 0 0 0
A 823 1 0 0 642 402 1210 0 0 0 0 0 0 0 0 0 0 0 0 0
A 826 1 0 0 645 402 1212 0 0 0 0 0 0 0 0 0 0 0 0 0
A 829 1 0 0 648 402 1214 0 0 0 0 0 0 0 0 0 0 0 0 0
A 830 2 0 0 0 6 1468 0 0 0 830 0 0 0 0 0 0 0 0 0
A 1619 1 0 0 1435 1561 3036 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1622 1 0 0 1090 1561 3038 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1669 1 0 0 1520 1816 3334 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1672 1 0 0 1526 1816 3336 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1675 1 0 0 1528 1816 3338 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1737 1 0 0 1533 1990 3401 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1740 1 0 0 1122 1990 3403 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1743 1 0 0 1582 1990 3405 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1746 1 0 0 1637 1996 3409 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1749 1 0 0 1335 1996 3411 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1752 1 0 0 30 1996 3413 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1755 1 0 0 1641 1996 3415 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1758 1 0 0 1537 1996 3417 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1761 1 0 0 1542 1996 3419 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1801 2 0 0 1473 6 3495 0 0 0 1801 0 0 0 0 0 0 0 0 0
A 7418 1 0 0 7207 2210 3512 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7421 1 0 0 7209 2210 3514 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7424 1 0 0 7213 2210 3516 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7427 1 0 0 7215 2210 3518 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7430 1 0 0 7384 2210 3520 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7433 1 0 0 7387 2216 3524 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7436 1 0 0 7388 2216 3526 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7459 2 0 0 6953 6 8071 0 0 0 7459 0 0 0 0 0 0 0 0 0
A 7886 1 0 0 7167 4930 8079 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7889 1 0 0 7477 4930 8081 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7892 1 0 0 6612 4930 8083 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7895 1 0 0 7566 4930 8085 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7898 1 0 0 6618 4930 8087 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7901 1 0 0 7169 4930 8089 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7904 1 0 0 7781 4930 8091 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7907 1 0 0 7801 4930 8093 0 0 0 0 0 0 0 0 0 0 0 0 0
A 8415 1 0 0 8372 5345 8465 0 0 0 0 0 0 0 0 0 0 0 0 0
A 8418 1 0 0 8371 5345 8467 0 0 0 0 0 0 0 0 0 0 0 0 0
A 8421 1 0 0 8376 5345 8469 0 0 0 0 0 0 0 0 0 0 0 0 0
A 8424 1 0 0 8375 5345 8471 0 0 0 0 0 0 0 0 0 0 0 0 0
A 8427 1 0 0 8380 5345 8473 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15520 1 0 0 15189 11264 16654 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15523 1 0 0 15488 11264 16656 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15526 1 0 0 15191 11264 16658 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15529 1 0 0 15372 11264 16660 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15532 1 0 0 15373 11264 16662 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15535 1 0 0 14601 11264 16664 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15538 1 0 0 14599 11264 16666 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15574 2 0 0 15559 6 16888 0 0 0 15574 0 0 0 0 0 0 0 0 0
A 15660 1 0 0 15013 11626 16899 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15663 1 0 0 15022 11626 16901 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15666 1 0 0 15019 11626 16903 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15669 1 0 0 15269 11626 16905 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15672 1 0 0 15007 11626 16907 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15675 1 0 0 15024 11626 16909 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15678 1 0 0 15268 11626 16911 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15681 1 0 0 15476 11626 16913 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15684 1 0 0 15477 11626 16915 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15687 1 0 0 14101 11626 16917 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15690 1 0 0 14408 11626 16919 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15693 1 0 0 15033 11626 16921 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15696 1 0 0 15030 11626 16923 0 0 0 0 0 0 0 0 0 0 0 0 0
A 15699 1 0 0 15274 11626 16925 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16627 1 0 0 16450 11877 17012 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16630 1 0 0 16445 11877 17014 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16633 1 0 0 16454 11877 17016 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16636 1 0 0 16449 11877 17018 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16639 1 0 0 16453 11883 17022 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16642 1 0 0 16463 11883 17024 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16645 1 0 0 16460 11883 17026 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16648 1 0 0 16462 11883 17028 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16753 1 0 0 16207 12844 18522 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16756 1 0 0 15071 12844 18524 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16759 1 0 0 16742 12850 18528 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16762 1 0 0 16744 12850 18530 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16902 1 0 0 16553 13104 18876 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16905 1 0 0 16554 13104 18878 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16908 1 0 0 16227 13116 18887 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16911 1 0 0 16236 13116 18889 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16914 1 0 0 16603 13116 18891 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16917 1 0 0 16558 13116 18893 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16920 1 0 0 16235 13116 18895 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16923 1 0 0 16268 13116 18897 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16926 1 0 0 16557 13116 18899 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16929 1 0 0 16318 13116 18901 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16932 1 0 0 16615 13116 18903 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16935 1 0 0 16616 13116 18905 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16938 1 0 0 16247 13116 18907 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16941 1 0 0 16620 13116 18909 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16944 1 0 0 16251 13116 18911 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16947 1 0 0 16563 13116 18913 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16950 1 0 0 16759 13122 18917 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16953 1 0 0 16762 13122 18919 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16956 1 0 0 16746 13122 18921 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16959 1 0 0 16748 13122 18923 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16962 1 0 0 16505 13122 18925 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16965 1 0 0 16506 13122 18927 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16968 1 0 0 16899 13122 18929 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16971 1 0 0 16510 13122 18931 0 0 0 0 0 0 0 0 0 0 0 0 0
A 16974 1 0 0 16595 13122 18933 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17221 1 0 0 16610 13771 19507 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17224 1 0 0 16619 13771 19509 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17238 2 0 0 16464 6 20038 0 0 0 17238 0 0 0 0 0 0 0 0 0
A 17242 2 0 0 17112 6 20039 0 0 0 17242 0 0 0 0 0 0 0 0 0
A 17246 2 0 0 17114 6 20040 0 0 0 17246 0 0 0 0 0 0 0 0 0
A 17250 2 0 0 17111 6 20041 0 0 0 17250 0 0 0 0 0 0 0 0 0
A 17254 2 0 0 17113 6 20042 0 0 0 17254 0 0 0 0 0 0 0 0 0
A 17258 2 0 0 16648 6 20043 0 0 0 17258 0 0 0 0 0 0 0 0 0
A 17262 2 0 0 16465 6 20044 0 0 0 17262 0 0 0 0 0 0 0 0 0
A 17266 2 0 0 16066 6 20045 0 0 0 17266 0 0 0 0 0 0 0 0 0
A 17270 2 0 0 16672 6 20046 0 0 0 17270 0 0 0 0 0 0 0 0 0
A 17274 2 0 0 16674 6 20047 0 0 0 17274 0 0 0 0 0 0 0 0 0
A 17351 1 0 0 16988 14189 20052 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17354 1 0 0 17178 14189 20054 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17357 1 0 0 17122 14189 20056 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17360 1 0 0 16987 14189 20058 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17363 1 0 0 15649 14195 20062 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17366 1 0 0 16023 14195 20064 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17369 1 0 0 16018 14195 20066 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17372 1 0 0 16405 14195 20068 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17375 1 0 0 16975 14195 20070 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17378 1 0 0 17196 14195 20072 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17381 1 0 0 17197 14195 20074 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17384 1 0 0 16413 14195 20076 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17387 1 0 0 16414 14195 20078 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17390 1 0 0 16417 14195 20080 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17393 1 0 0 16421 14201 20084 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17396 1 0 0 17209 14201 20086 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17399 1 0 0 16426 14207 20090 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17402 1 0 0 17214 14207 20092 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17405 1 0 0 17106 14207 20094 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17408 1 0 0 17054 14213 20098 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17411 1 0 0 17057 14213 20100 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17414 1 0 0 16578 14219 20104 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17417 1 0 0 16345 14219 20106 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17420 1 0 0 16348 14219 20108 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17618 1 0 1 16840 14780 20985 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17619 10 0 0 16446 6 17618 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17620 10 0 0 17619 6 17618 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17621 4 0 0 17421 6 17620 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17622 4 0 0 17562 6 17619 0 17621 0 0 0 0 1 0 0 0 0 0 0
A 17623 10 0 0 17620 6 17618 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17624 10 0 0 17623 6 17618 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17625 10 0 0 17624 6 17618 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17627 1 0 1 17613 14786 20991 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17628 10 0 0 16669 6 17627 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17629 10 0 0 17628 6 17627 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17630 4 0 0 17506 6 17629 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17631 4 0 0 17130 6 17628 0 17630 0 0 0 0 1 0 0 0 0 0 0
A 17632 10 0 0 17629 6 17627 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17633 10 0 0 17632 6 17627 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17634 10 0 0 17633 6 17627 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17636 1 0 1 17422 14792 20999 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17637 10 0 0 17250 6 17636 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17638 10 0 0 17637 6 17636 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17639 4 0 0 17221 6 17638 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17640 4 0 0 17477 6 17637 0 17639 0 0 0 0 1 0 0 0 0 0 0
A 17641 10 0 0 17638 6 17636 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17642 10 0 0 17641 6 17636 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17643 10 0 0 17642 6 17636 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17645 1 0 1 17068 14798 21005 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17646 10 0 0 14956 6 17645 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17647 10 0 0 17646 6 17645 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17648 4 0 0 17507 6 17647 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17649 4 0 0 17065 6 17646 0 17648 0 0 0 0 1 0 0 0 0 0 0
A 17650 10 0 0 17647 6 17645 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17651 10 0 0 17650 6 17645 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17652 10 0 0 17651 6 17645 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17654 1 0 1 17648 14804 21011 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17655 10 0 0 15494 6 17654 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17656 10 0 0 17655 6 17654 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17657 4 0 0 16175 6 17656 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17658 4 0 0 14959 6 17655 0 17657 0 0 0 0 1 0 0 0 0 0 0
A 17659 10 0 0 17656 6 17654 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17660 10 0 0 17659 6 17654 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17661 10 0 0 17660 6 17654 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17663 1 0 1 15810 14810 21017 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17664 10 0 0 17118 6 17663 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17665 10 0 0 17664 6 17663 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17666 4 0 0 17657 6 17665 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17667 4 0 0 16850 6 17664 0 17666 0 0 0 0 1 0 0 0 0 0 0
A 17668 10 0 0 17665 6 17663 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17669 10 0 0 17668 6 17663 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17670 10 0 0 17669 6 17663 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17672 1 0 1 17384 14816 21023 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17673 10 0 0 16984 6 17672 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17674 10 0 0 17673 6 17672 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17675 4 0 0 17513 6 17674 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17676 4 0 0 17587 6 17673 0 17675 0 0 0 0 1 0 0 0 0 0 0
A 17677 10 0 0 17674 6 17672 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17678 10 0 0 17677 6 17672 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17679 10 0 0 17678 6 17672 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17681 1 0 1 17399 14822 21029 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17682 10 0 0 17119 6 17681 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17683 10 0 0 17682 6 17681 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17684 4 0 0 16544 6 17683 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17685 4 0 0 17265 6 17682 0 17684 0 0 0 0 1 0 0 0 0 0 0
A 17686 10 0 0 17683 6 17681 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17687 10 0 0 17686 6 17681 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17688 10 0 0 17687 6 17681 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17691 1 0 3 16664 14828 21036 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17692 10 0 0 16655 6 17691 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17693 10 0 0 17692 6 17691 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17694 4 0 0 16551 6 17693 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17695 4 0 0 17643 6 17692 0 17694 0 0 0 0 1 0 0 0 0 0 0
A 17696 10 0 0 17693 6 17691 16 0 0 0 0 0 0 0 0 0 0 0 0
X 1 1801
A 17697 10 0 0 17696 6 17691 19 0 0 0 0 0 0 0 0 0 0 0 0
X 1 22
A 17698 4 0 0 16191 6 17697 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17699 4 0 0 16493 6 17696 0 17698 0 0 0 0 1 0 0 0 0 0 0
A 17700 10 0 0 17697 6 17691 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17701 10 0 0 17700 6 17691 22 0 0 0 0 0 0 0 0 0 0 0 0
X 1 220
A 17702 10 0 0 17701 6 17691 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17703 10 0 0 17702 6 17691 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17706 1 0 3 16843 14834 21043 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17707 10 0 0 17309 6 17706 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17708 10 0 0 17707 6 17706 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17709 4 0 0 16879 6 17708 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17710 4 0 0 16355 6 17707 0 17709 0 0 0 0 1 0 0 0 0 0 0
A 17711 10 0 0 17708 6 17706 16 0 0 0 0 0 0 0 0 0 0 0 0
X 1 1801
A 17712 10 0 0 17711 6 17706 19 0 0 0 0 0 0 0 0 0 0 0 0
X 1 22
A 17713 4 0 0 16883 6 17712 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17714 4 0 0 17193 6 17711 0 17713 0 0 0 0 1 0 0 0 0 0 0
A 17715 10 0 0 17712 6 17706 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17716 10 0 0 17715 6 17706 22 0 0 0 0 0 0 0 0 0 0 0 0
X 1 220
A 17717 10 0 0 17716 6 17706 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17718 10 0 0 17717 6 17706 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17722 2 0 0 17266 6 21051 0 0 0 17722 0 0 0 0 0 0 0 0 0
A 17723 2 0 0 16292 14837 21052 0 0 0 17723 0 0 0 0 0 0 0 0 0
A 17725 1 0 1 17721 14845 21069 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17726 10 0 0 17630 6 17725 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17727 10 0 0 17726 6 17725 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17728 10 0 0 17727 6 17725 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17729 4 0 0 17594 6 17728 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17730 4 0 0 17199 6 17727 0 17729 0 0 0 0 1 0 0 0 0 0 0
A 17731 10 0 0 17728 6 17725 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17732 10 0 0 17731 6 17725 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17733 1 0 1 17087 14851 21077 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17734 10 0 0 17133 6 17733 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17735 10 0 0 17734 6 17733 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17736 10 0 0 17735 6 17733 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17737 4 0 0 17602 6 17736 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17738 4 0 0 17582 6 17735 0 17737 0 0 0 0 1 0 0 0 0 0 0
A 17739 10 0 0 17736 6 17733 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17740 10 0 0 17739 6 17733 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 17741 1 0 1 17334 14857 21087 0 0 0 0 0 0 0 0 0 0 0 0 0
A 17742 10 0 0 17508 6 17741 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 17743 10 0 0 17742 6 17741 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 17744 10 0 0 17743 6 17741 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 17745 4 0 0 17609 6 17744 0 3 0 0 0 0 2 0 0 0 0 0 0
A 17746 4 0 0 16448 6 17743 0 17745 0 0 0 0 1 0 0 0 0 0 0
A 17747 10 0 0 17744 6 17741 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 17748 10 0 0 17747 6 17741 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
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
J 71 1 1
V 1619 1561 7 0
S 0 1561 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 1622 1561 7 0
S 0 1561 0 0 0
A 0 6 0 0 1 45 0
J 68 1 1
V 1669 1816 7 0
S 0 1816 0 0 0
A 0 6 0 0 1 2 0
J 68 1 1
V 1672 1816 7 0
S 0 1816 0 0 0
A 0 6 0 0 1 3 0
J 68 1 1
V 1675 1816 7 0
S 0 1816 0 0 0
A 0 6 0 0 1 45 0
J 54 1 1
V 1737 1990 7 0
S 0 1990 0 0 0
A 0 6 0 0 1 2 0
J 54 1 1
V 1740 1990 7 0
S 0 1990 0 0 0
A 0 6 0 0 1 3 0
J 54 1 1
V 1743 1990 7 0
S 0 1990 0 0 0
A 0 6 0 0 1 45 0
J 66 1 1
V 1746 1996 7 0
S 0 1996 0 0 0
A 0 6 0 0 1 2 0
J 66 1 1
V 1749 1996 7 0
S 0 1996 0 0 0
A 0 6 0 0 1 3 0
J 66 1 1
V 1752 1996 7 0
S 0 1996 0 0 0
A 0 6 0 0 1 45 0
J 66 1 1
V 1755 1996 7 0
S 0 1996 0 0 0
A 0 6 0 0 1 32 0
J 66 1 1
V 1758 1996 7 0
S 0 1996 0 0 0
A 0 6 0 0 1 52 0
J 66 1 1
V 1761 1996 7 0
S 0 1996 0 0 0
A 0 6 0 0 1 56 0
J 77 1 1
V 7418 2210 7 0
S 0 2210 0 0 0
A 0 6 0 0 1 3 0
J 77 1 1
V 7421 2210 7 0
S 0 2210 0 0 0
A 0 6 0 0 1 45 0
J 77 1 1
V 7424 2210 7 0
S 0 2210 0 0 0
A 0 6 0 0 1 32 0
J 77 1 1
V 7427 2210 7 0
S 0 2210 0 0 0
A 0 6 0 0 1 52 0
J 77 1 1
V 7430 2210 7 0
S 0 2210 0 0 0
A 0 6 0 0 1 56 0
J 97 1 1
V 7433 2216 7 0
S 0 2216 0 0 0
A 0 6 0 0 1 3 0
J 97 1 1
V 7436 2216 7 0
S 0 2216 0 0 0
A 0 6 0 0 1 45 0
J 69 1 1
V 7886 4930 7 0
S 0 4930 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 7889 4930 7 0
S 0 4930 0 0 0
A 0 6 0 0 1 45 0
J 73 1 1
V 7892 4930 7 0
S 0 4930 0 0 0
A 0 6 0 0 1 52 0
J 75 1 1
V 7895 4930 7 0
S 0 4930 0 0 0
A 0 6 0 0 1 95 0
J 77 1 1
V 7898 4930 7 0
S 0 4930 0 0 0
A 0 6 0 0 1 20 0
J 79 1 1
V 7901 4930 7 0
S 0 4930 0 0 0
A 0 6 0 0 1 24 0
J 81 1 1
V 7904 4930 7 0
S 0 4930 0 0 0
A 0 6 0 0 1 830 0
J 83 1 1
V 7907 4930 7 0
S 0 4930 0 0 0
A 0 6 0 0 1 7459 0
J 72 1 1
V 8415 5345 7 0
S 0 5345 0 0 0
A 0 6 0 0 1 3 0
J 72 1 1
V 8418 5345 7 0
S 0 5345 0 0 0
A 0 6 0 0 1 45 0
J 72 1 1
V 8421 5345 7 0
S 0 5345 0 0 0
A 0 6 0 0 1 32 0
J 72 1 1
V 8424 5345 7 0
S 0 5345 0 0 0
A 0 6 0 0 1 52 0
J 72 1 1
V 8427 5345 7 0
S 0 5345 0 0 0
A 0 6 0 0 1 56 0
J 69 1 1
V 15520 11264 7 0
S 0 11264 0 0 0
A 0 6 0 0 1 3 0
J 69 1 1
V 15523 11264 7 0
S 0 11264 0 0 0
A 0 6 0 0 1 45 0
J 69 1 1
V 15526 11264 7 0
S 0 11264 0 0 0
A 0 6 0 0 1 32 0
J 69 1 1
V 15529 11264 7 0
S 0 11264 0 0 0
A 0 6 0 0 1 52 0
J 69 1 1
V 15532 11264 7 0
S 0 11264 0 0 0
A 0 6 0 0 1 56 0
J 69 1 1
V 15535 11264 7 0
S 0 11264 0 0 0
A 0 6 0 0 1 60 0
J 69 1 1
V 15538 11264 7 0
S 0 11264 0 0 0
A 0 6 0 0 1 21 0
J 79 1 1
V 15660 11626 7 0
S 0 11626 0 0 0
A 0 6 0 0 1 15574 0
J 79 1 1
V 15663 11626 7 0
S 0 11626 0 0 0
A 0 6 0 0 1 27 0
J 84 1 1
V 15666 11626 7 0
S 0 11626 0 0 0
A 0 6 0 0 1 2 0
J 84 1 1
V 15669 11626 7 0
S 0 11626 0 0 0
A 0 6 0 0 1 3 0
J 84 1 1
V 15672 11626 7 0
S 0 11626 0 0 0
A 0 6 0 0 1 45 0
J 84 1 1
V 15675 11626 7 0
S 0 11626 0 0 0
A 0 6 0 0 1 32 0
J 91 1 1
V 15678 11626 7 0
S 0 11626 0 0 0
A 0 6 0 0 1 2 0
J 91 1 1
V 15681 11626 7 0
S 0 11626 0 0 0
A 0 6 0 0 1 3 0
J 91 1 1
V 15684 11626 7 0
S 0 11626 0 0 0
A 0 6 0 0 1 45 0
J 91 1 1
V 15687 11626 7 0
S 0 11626 0 0 0
A 0 6 0 0 1 32 0
J 91 1 1
V 15690 11626 7 0
S 0 11626 0 0 0
A 0 6 0 0 1 52 0
J 91 1 1
V 15693 11626 7 0
S 0 11626 0 0 0
A 0 6 0 0 1 56 0
J 91 1 1
V 15696 11626 7 0
S 0 11626 0 0 0
A 0 6 0 0 1 60 0
J 91 1 1
V 15699 11626 7 0
S 0 11626 0 0 0
A 0 6 0 0 1 21 0
J 80 1 1
V 16627 11877 7 0
S 0 11877 0 0 0
A 0 6 0 0 1 27 0
J 80 1 1
V 16630 11877 7 0
S 0 11877 0 0 0
A 0 6 0 0 1 2 0
J 80 1 1
V 16633 11877 7 0
S 0 11877 0 0 0
A 0 6 0 0 1 3 0
J 80 1 1
V 16636 11877 7 0
S 0 11877 0 0 0
A 0 6 0 0 1 45 0
J 96 1 1
V 16639 11883 7 0
S 0 11883 0 0 0
A 0 6 0 0 1 2 0
J 96 1 1
V 16642 11883 7 0
S 0 11883 0 0 0
A 0 6 0 0 1 3 0
J 96 1 1
V 16645 11883 7 0
S 0 11883 0 0 0
A 0 6 0 0 1 45 0
J 96 1 1
V 16648 11883 7 0
S 0 11883 0 0 0
A 0 6 0 0 1 32 0
J 80 1 1
V 16753 12844 7 0
S 0 12844 0 0 0
A 0 6 0 0 1 2 0
J 80 1 1
V 16756 12844 7 0
S 0 12844 0 0 0
A 0 6 0 0 1 3 0
J 95 1 1
V 16759 12850 7 0
S 0 12850 0 0 0
A 0 6 0 0 1 2 0
J 95 1 1
V 16762 12850 7 0
S 0 12850 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 16902 13104 7 0
S 0 13104 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 16905 13104 7 0
S 0 13104 0 0 0
A 0 6 0 0 1 45 0
J 102 1 1
V 16908 13116 7 0
S 0 13116 0 0 0
A 0 6 0 0 1 2 0
J 102 1 1
V 16911 13116 7 0
S 0 13116 0 0 0
A 0 6 0 0 1 3 0
J 102 1 1
V 16914 13116 7 0
S 0 13116 0 0 0
A 0 6 0 0 1 45 0
J 102 1 1
V 16917 13116 7 0
S 0 13116 0 0 0
A 0 6 0 0 1 32 0
J 102 1 1
V 16920 13116 7 0
S 0 13116 0 0 0
A 0 6 0 0 1 52 0
J 102 1 1
V 16923 13116 7 0
S 0 13116 0 0 0
A 0 6 0 0 1 56 0
J 102 1 1
V 16926 13116 7 0
S 0 13116 0 0 0
A 0 6 0 0 1 60 0
J 102 1 1
V 16929 13116 7 0
S 0 13116 0 0 0
A 0 6 0 0 1 21 0
J 102 1 1
V 16932 13116 7 0
S 0 13116 0 0 0
A 0 6 0 0 1 95 0
J 102 1 1
V 16935 13116 7 0
S 0 13116 0 0 0
A 0 6 0 0 1 13 0
J 102 1 1
V 16938 13116 7 0
S 0 13116 0 0 0
A 0 6 0 0 1 17 0
J 102 1 1
V 16941 13116 7 0
S 0 13116 0 0 0
A 0 6 0 0 1 14 0
J 102 1 1
V 16944 13116 7 0
S 0 13116 0 0 0
A 0 6 0 0 1 182 0
J 102 1 1
V 16947 13116 7 0
S 0 13116 0 0 0
A 0 6 0 0 1 15 0
J 129 1 1
V 16950 13122 7 0
S 0 13122 0 0 0
A 0 6 0 0 1 2 0
J 129 1 1
V 16953 13122 7 0
S 0 13122 0 0 0
A 0 6 0 0 1 3 0
J 129 1 1
V 16956 13122 7 0
S 0 13122 0 0 0
A 0 6 0 0 1 45 0
J 129 1 1
V 16959 13122 7 0
S 0 13122 0 0 0
A 0 6 0 0 1 32 0
J 129 1 1
V 16962 13122 7 0
S 0 13122 0 0 0
A 0 6 0 0 1 52 0
J 129 1 1
V 16965 13122 7 0
S 0 13122 0 0 0
A 0 6 0 0 1 56 0
J 129 1 1
V 16968 13122 7 0
S 0 13122 0 0 0
A 0 6 0 0 1 60 0
J 129 1 1
V 16971 13122 7 0
S 0 13122 0 0 0
A 0 6 0 0 1 21 0
J 129 1 1
V 16974 13122 7 0
S 0 13122 0 0 0
A 0 6 0 0 1 95 0
J 70 1 1
V 17221 13771 7 0
S 0 13771 0 0 0
A 0 6 0 0 1 3 0
J 70 1 1
V 17224 13771 7 0
S 0 13771 0 0 0
A 0 6 0 0 1 45 0
J 64 1 1
V 17351 14189 7 0
S 0 14189 0 0 0
A 0 6 0 0 1 3 0
J 64 1 1
V 17354 14189 7 0
S 0 14189 0 0 0
A 0 6 0 0 1 45 0
J 64 1 1
V 17357 14189 7 0
S 0 14189 0 0 0
A 0 6 0 0 1 32 0
J 64 1 1
V 17360 14189 7 0
S 0 14189 0 0 0
A 0 6 0 0 1 52 0
J 82 1 1
V 17363 14195 7 0
S 0 14195 0 0 0
A 0 6 0 0 1 17238 0
J 82 1 1
V 17366 14195 7 0
S 0 14195 0 0 0
A 0 6 0 0 1 17242 0
J 82 1 1
V 17369 14195 7 0
S 0 14195 0 0 0
A 0 6 0 0 1 17246 0
J 82 1 1
V 17372 14195 7 0
S 0 14195 0 0 0
A 0 6 0 0 1 17250 0
J 82 1 1
V 17375 14195 7 0
S 0 14195 0 0 0
A 0 6 0 0 1 17254 0
J 82 1 1
V 17378 14195 7 0
S 0 14195 0 0 0
A 0 6 0 0 1 17258 0
J 82 1 1
V 17381 14195 7 0
S 0 14195 0 0 0
A 0 6 0 0 1 17262 0
J 82 1 1
V 17384 14195 7 0
S 0 14195 0 0 0
A 0 6 0 0 1 17266 0
J 82 1 1
V 17387 14195 7 0
S 0 14195 0 0 0
A 0 6 0 0 1 17270 0
J 82 1 1
V 17390 14195 7 0
S 0 14195 0 0 0
A 0 6 0 0 1 17274 0
J 106 1 1
V 17393 14201 7 0
S 0 14201 0 0 0
A 0 6 0 0 1 3 0
J 106 1 1
V 17396 14201 7 0
S 0 14201 0 0 0
A 0 6 0 0 1 45 0
J 119 1 1
V 17399 14207 7 0
S 0 14207 0 0 0
A 0 6 0 0 1 3 0
J 119 1 1
V 17402 14207 7 0
S 0 14207 0 0 0
A 0 6 0 0 1 45 0
J 119 1 1
V 17405 14207 7 0
S 0 14207 0 0 0
A 0 6 0 0 1 32 0
J 134 1 1
V 17408 14213 7 0
S 0 14213 0 0 0
A 0 6 0 0 1 3 0
J 134 1 1
V 17411 14213 7 0
S 0 14213 0 0 0
A 0 6 0 0 1 45 0
J 148 1 1
V 17414 14219 7 0
S 0 14219 0 0 0
A 0 6 0 0 1 3 0
J 148 1 1
V 17417 14219 7 0
S 0 14219 0 0 0
A 0 6 0 0 1 45 0
J 148 1 1
V 17420 14219 7 0
S 0 14219 0 0 0
A 0 6 0 0 1 32 0
Z
