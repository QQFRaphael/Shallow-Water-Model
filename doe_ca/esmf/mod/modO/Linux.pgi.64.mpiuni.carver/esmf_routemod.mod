V24 esmf_routemod
91 /global/u2/d/dazlich/cpl40-40/doe_ca/esmf/src/Infrastructure/Route/interface/ESMF_Route.F90 S582 0
11/22/2010  10:53:20
use esmf_iospecmod private
use esmf_arrayspecmod private
use esmf_logerrmod private
use esmf_localarraycreatemod private
use esmf_delayoutmod private
use esmf_xpacketmod private
use esmf_vmmod private
use esmf_utiltypesmod private
use esmf_iospecmod private
use esmf_arrayspecmod private
use esmf_logerrmod private
use esmf_localarraycreatemod private
use esmf_delayoutmod private
use esmf_xpacketmod private
use esmf_vmmod private
use esmf_utiltypesmod private
enduse
D 46 24 709 4 708 3
D 52 24 725 8 724 7
D 58 24 731 4 730 3
D 70 24 773 36 772 3
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
D 100 24 840 24 839 7
D 115 24 851 112 850 7
D 127 24 863 4 862 3
D 133 24 869 4 868 3
D 139 24 885 4 884 3
D 145 24 891 4 890 3
D 151 24 899 4 898 3
D 157 24 907 4 906 3
D 163 24 913 4 912 3
D 169 24 921 4 920 3
D 175 24 927 4 926 3
D 181 24 933 4 932 3
D 187 24 939 4 938 3
D 390 24 1189 4 1188 3
D 396 24 1197 4 1196 3
D 402 24 1205 4 1204 3
D 827 18 862
D 987 24 1651 16 1650 7
D 1530 24 2977 16 2976 7
D 1536 24 2980 4 2979 3
D 1791 24 3278 4 3277 3
D 1965 24 3345 4 3344 3
D 1971 24 3353 4 3352 3
D 2185 24 3456 4 3455 3
D 2191 24 3468 4 3467 3
D 2197 24 3474 16 3473 7
D 6070 18 13
D 6072 18 14
D 6074 18 15
D 6076 18 16
D 6078 18 17
D 6080 18 18
D 6082 18 19
D 6084 18 20
D 6086 18 21
D 6088 18 22
D 6090 18 23
D 6092 24 8847 80 8846 7
D 6117 24 8908 16 8907 7
D 6123 24 8911 4 8910 3
D 6129 21 6 1 0 3 0 0 0 0 0
 0 3 0 3 3 0
D 6132 21 6 1 0 3 0 0 0 0 0
 0 3 0 3 3 0
D 6135 21 100 2 9508 9519 0 1 0 0 1
 9509 9512 9513 9509 9512 9510
 9514 9517 9518 9514 9517 9515
D 6138 21 6 1 0 226 0 0 0 0 0
 0 226 0 3 226 0
D 6141 21 100 2 9521 9532 0 1 0 0 1
 9522 9525 9526 9522 9525 9523
 9527 9530 9531 9527 9530 9528
D 6144 21 6 1 0 226 0 0 0 0 0
 0 226 0 3 226 0
D 6147 21 6 2 9533 9539 1 1 0 0 1
 3 9534 3 3 9534 9535
 3 9536 9537 3 9536 9538
D 6150 21 6 1 3 32 0 0 0 0 0
 0 32 3 3 32 32
D 6153 21 139 1 9540 9543 1 1 0 0 1
 3 9541 3 3 9541 9542
D 6156 21 100 1 9545 9551 0 1 0 0 1
 9546 9549 9550 9546 9549 9547
D 6159 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 6162 21 100 2 9553 9564 0 1 0 0 1
 9554 9557 9558 9554 9557 9555
 9559 9562 9563 9559 9562 9560
D 6165 21 6 1 0 226 0 0 0 0 0
 0 226 0 3 226 0
D 6168 21 100 1 9566 9572 0 1 0 0 1
 9567 9570 9571 9567 9570 9568
D 6171 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 6174 21 100 2 9574 9585 0 1 0 0 1
 9575 9578 9579 9575 9578 9576
 9580 9583 9584 9580 9583 9581
D 6177 21 6 1 0 226 0 0 0 0 0
 0 226 0 3 226 0
D 6180 21 100 2 9587 9598 0 1 0 0 1
 9588 9591 9592 9588 9591 9589
 9593 9596 9597 9593 9596 9594
D 6183 21 6 1 0 226 0 0 0 0 0
 0 226 0 3 226 0
D 6186 21 100 2 9600 9611 0 1 0 0 1
 9601 9604 9605 9601 9604 9602
 9606 9609 9610 9606 9609 9607
D 6189 21 6 1 0 226 0 0 0 0 0
 0 226 0 3 226 0
D 6192 21 6 1 9612 9615 1 1 0 0 1
 3 9613 3 3 9613 9614
D 6195 21 6 2 9616 9622 1 1 0 0 1
 3 9617 3 3 9617 9618
 3 9619 9620 3 9619 9621
D 6198 21 6 1 3 32 0 0 0 0 0
 0 32 3 3 32 32
D 6201 21 100 2 9624 9635 0 1 0 0 1
 9625 9628 9629 9625 9628 9626
 9630 9633 9634 9630 9633 9631
D 6204 21 6 1 0 226 0 0 0 0 0
 0 226 0 3 226 0
D 6207 21 100 2 9637 9648 0 1 0 0 1
 9638 9641 9642 9638 9641 9639
 9643 9646 9647 9643 9646 9644
D 6210 21 6 1 0 226 0 0 0 0 0
 0 226 0 3 226 0
D 6213 21 6 1 9649 9652 1 1 0 0 1
 3 9650 3 3 9650 9651
D 6216 21 6 2 9653 9659 1 1 0 0 1
 3 9654 3 3 9654 9655
 3 9656 9657 3 9656 9658
D 6219 21 6 1 3 32 0 0 0 0 0
 0 32 3 3 32 32
D 6222 21 100 2 9661 9672 0 1 0 0 1
 9662 9665 9666 9662 9665 9663
 9667 9670 9671 9667 9670 9668
D 6225 21 6 1 0 226 0 0 0 0 0
 0 226 0 3 226 0
D 6228 21 6 1 9673 9676 1 1 0 0 1
 3 9674 3 3 9674 9675
D 6231 21 6 2 9677 9683 1 1 0 0 1
 3 9678 3 3 9678 9679
 3 9680 9681 3 9680 9682
D 6234 21 6 1 3 32 0 0 0 0 0
 0 32 3 3 32 32
D 6237 21 100 2 9685 9696 0 1 0 0 1
 9686 9689 9690 9686 9689 9687
 9691 9694 9695 9691 9694 9692
D 6240 21 6 1 0 226 0 0 0 0 0
 0 226 0 3 226 0
D 6243 21 6 1 9697 9700 1 1 0 0 1
 3 9698 3 3 9698 9699
D 6246 21 6 2 9701 9707 1 1 0 0 1
 3 9702 3 3 9702 9703
 3 9704 9705 3 9704 9706
D 6249 21 6 1 3 32 0 0 0 0 0
 0 32 3 3 32 32
D 6252 21 100 2 9709 9720 0 1 0 0 1
 9710 9713 9714 9710 9713 9711
 9715 9718 9719 9715 9718 9716
D 6255 21 6 1 0 226 0 0 0 0 0
 0 226 0 3 226 0
D 6258 21 100 2 9722 9733 0 1 0 0 1
 9723 9726 9727 9723 9726 9724
 9728 9731 9732 9728 9731 9729
D 6261 21 6 1 0 226 0 0 0 0 0
 0 226 0 3 226 0
D 6264 21 6 2 9734 9740 1 1 0 0 1
 3 9735 3 3 9735 9736
 3 9737 9738 3 9737 9739
D 6267 21 6 1 3 32 0 0 0 0 0
 0 32 3 3 32 32
D 6270 21 100 2 9742 9753 0 1 0 0 1
 9743 9746 9747 9743 9746 9744
 9748 9751 9752 9748 9751 9749
D 6273 21 6 1 0 226 0 0 0 0 0
 0 226 0 3 226 0
D 6276 21 100 2 9755 9766 0 1 0 0 1
 9756 9759 9760 9756 9759 9757
 9761 9764 9765 9761 9764 9762
D 6279 21 6 1 0 226 0 0 0 0 0
 0 226 0 3 226 0
D 6282 21 6 2 9767 9773 1 1 0 0 1
 3 9768 3 3 9768 9769
 3 9770 9771 3 9770 9772
D 6285 21 6 1 3 32 0 0 0 0 0
 0 32 3 3 32 32
D 6288 21 2197 1 9774 9777 1 1 0 0 1
 3 9775 3 3 9775 9776
D 6291 21 2197 1 9778 9781 1 1 0 0 1
 3 9779 3 3 9779 9780
D 6294 21 6 1 9783 9789 0 1 0 0 1
 9784 9787 9788 9784 9787 9785
D 6297 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 6300 21 6 1 9791 9797 0 1 0 0 1
 9792 9795 9796 9792 9795 9793
D 6303 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 6306 21 6 2 9799 9810 0 1 0 0 1
 9800 9803 9804 9800 9803 9801
 9805 9808 9809 9805 9808 9806
D 6309 21 6 1 0 226 0 0 0 0 0
 0 226 0 3 226 0
D 6312 21 6 1 9812 9818 0 1 0 0 1
 9813 9816 9817 9813 9816 9814
D 6315 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 6318 21 9 1 9820 9826 0 1 0 0 1
 9821 9824 9825 9821 9824 9822
D 6321 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 6324 21 9 1 9828 9834 0 1 0 0 1
 9829 9832 9833 9829 9832 9830
D 6327 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 6330 21 9 2 9836 9847 0 1 0 0 1
 9837 9840 9841 9837 9840 9838
 9842 9845 9846 9842 9845 9843
D 6333 21 6 1 0 226 0 0 0 0 0
 0 226 0 3 226 0
D 6336 21 9 1 9849 9855 0 1 0 0 1
 9850 9853 9854 9850 9853 9851
D 6339 21 6 1 0 23 0 0 0 0 0
 0 23 0 3 23 0
D 6342 21 9 3 9857 9873 0 1 0 0 1
 9858 9861 9862 9858 9861 9859
 9863 9866 9867 9863 9866 9864
 9868 9871 9872 9868 9871 9869
D 6345 21 6 1 0 256 0 0 0 0 0
 0 256 0 3 256 0
D 6348 21 9 2 9875 9886 0 1 0 0 1
 9876 9879 9880 9876 9879 9877
 9881 9884 9885 9881 9884 9882
D 6351 21 6 1 0 226 0 0 0 0 0
 0 226 0 3 226 0
D 6354 21 6 1 9887 9890 1 1 0 0 1
 3 9888 3 3 9888 9889
D 6357 21 6 1 9891 9894 1 1 0 0 1
 3 9892 3 3 9892 9893
S 582 24 0 0 0 8 1 0 4659 10005 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 15 0 0 0 0 0 0 esmf_routemod
S 591 3 0 0 0 6 1 1 0 0 0 0 0 0 0 -1 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 593 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 7 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 594 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 595 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 8 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 598 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 599 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 600 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 5 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 601 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 6 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 603 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 9 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 604 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 605 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 90 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 606 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 91 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 607 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 99 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 608 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 18 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 609 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 25 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 610 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 32 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 611 3 0 0 0 6070 1 1 0 0 0 0 0 0 0 4882 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 42 61 73 65
S 612 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 11 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 613 3 0 0 0 6072 1 1 0 0 0 0 0 0 0 4892 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 49 4f 53 70 65 63
S 614 3 0 0 0 6072 1 1 0 0 0 0 0 0 0 4904 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 4c 6f 67 45 72 72
S 615 3 0 0 0 6070 1 1 0 0 0 0 0 0 0 4916 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 54 69 6d 65
S 616 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 13 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 617 3 0 0 0 6074 1 1 0 0 0 0 0 0 0 4926 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 43 61 6c 65 6e 64 61 72
S 618 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 17 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 619 3 0 0 0 6076 1 1 0 0 0 0 0 0 0 4940 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 54 69 6d 65 49 6e 74 65 72 76 61 6c
S 620 3 0 0 0 6078 1 1 0 0 0 0 0 0 0 4958 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 41 6c 61 72 6d
S 621 3 0 0 0 6078 1 1 0 0 0 0 0 0 0 4969 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 43 6c 6f 63 6b
S 622 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 14 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 623 3 0 0 0 6080 1 1 0 0 0 0 0 0 0 4980 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 41 72 72 61 79 53 70 65 63
S 624 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 15 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 625 3 0 0 0 6082 1 1 0 0 0 0 0 0 0 4995 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 15 45 53 4d 46 5f 4c 6f 63 61 6c 41 72 72 61 79
S 626 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 16 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 627 3 0 0 0 6084 1 1 0 0 0 0 0 0 0 5011 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 41 72 72 61 79 42 75 6e 64 6c 65
S 628 3 0 0 0 6086 1 1 0 0 0 0 0 0 0 5028 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 7 45 53 4d 46 5f 56 4d
S 629 3 0 0 0 6074 1 1 0 0 0 0 0 0 0 5036 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 44 45 4c 61 79 6f 75 74
S 630 3 0 0 0 6072 1 1 0 0 0 0 0 0 0 5050 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 43 6f 6e 66 69 67
S 631 3 0 0 0 6078 1 1 0 0 0 0 0 0 0 5062 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 41 72 72 61 79
S 632 3 0 0 0 6074 1 1 0 0 0 0 0 0 0 5073 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 13 45 53 4d 46 5f 49 6e 74 65 72 6e 44 47
S 633 3 0 0 0 6080 1 1 0 0 0 0 0 0 0 5087 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 43 6f 6d 6d 54 61 62 6c 65
S 634 3 0 0 0 6082 1 1 0 0 0 0 0 0 0 5102 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 15 45 53 4d 46 5f 52 6f 75 74 65 54 61 62 6c 65
S 635 3 0 0 0 6078 1 1 0 0 0 0 0 0 0 5118 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 52 6f 75 74 65
S 636 3 0 0 0 6084 1 1 0 0 0 0 0 0 0 5129 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 52 6f 75 74 65 48 61 6e 64 6c 65
S 637 3 0 0 0 6076 1 1 0 0 0 0 0 0 0 5146 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 46 69 65 6c 64 44 61 74 61 4d 61 70
S 638 3 0 0 0 6078 1 1 0 0 0 0 0 0 0 5164 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 46 69 65 6c 64
S 639 3 0 0 0 6084 1 1 0 0 0 0 0 0 0 5175 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 46 69 65 6c 64 42 75 6e 64 6c 65
S 640 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 20 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 641 3 0 0 0 6088 1 1 0 0 0 0 0 0 0 5192 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 20 45 53 4d 46 5f 54 72 61 6e 73 66 6f 72 6d 56 61 6c 75 65 73
S 642 3 0 0 0 6072 1 1 0 0 0 0 0 0 0 5213 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 11 45 53 4d 46 5f 52 65 67 72 69 64
S 643 3 0 0 0 6080 1 1 0 0 0 0 0 0 0 5225 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 54 72 61 6e 73 66 6f 72 6d
S 644 3 0 0 0 6078 1 1 0 0 0 0 0 0 0 5240 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 10 45 53 4d 46 5f 53 74 61 74 65
S 645 3 0 0 0 6090 1 1 0 0 0 0 0 0 0 5251 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 18 45 53 4d 46 5f 47 72 69 64 43 6f 6d 70 6f 6e 65 6e 74
S 646 3 0 0 0 6076 1 1 0 0 0 0 0 0 0 5270 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 17 45 53 4d 46 5f 43 70 6c 43 6f 6d 70 6f 6e 65 6e 74
S 647 3 0 0 0 6080 1 1 0 0 0 0 0 0 0 5288 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 14 45 53 4d 46 5f 43 6f 6d 70 6f 6e 65 6e 74
S 648 3 0 0 0 6084 1 1 0 0 0 0 0 0 0 5303 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 16 45 53 4d 46 5f 49 6e 74 65 72 6e 41 72 72 61 79
S 649 3 0 0 0 6070 1 1 0 0 0 0 0 0 0 5320 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 9 45 53 4d 46 5f 4e 6f 6e 65
S 661 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 12 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 667 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 21 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 669 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 22 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 671 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 23 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 673 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 24 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 676 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 26 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 678 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 28 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 680 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 29 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 682 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 30 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 684 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 31 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 687 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 33 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 689 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 34 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 691 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 35 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 693 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 36 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 708 25 13 esmf_utiltypesmod esmf_status
R 709 5 14 esmf_utiltypesmod status esmf_status
R 711 6 16 esmf_utiltypesmod esmf_status_uninit$ac
R 713 6 18 esmf_utiltypesmod esmf_status_ready$ac
R 715 6 20 esmf_utiltypesmod esmf_status_unallocated$ac
R 717 6 22 esmf_utiltypesmod esmf_status_allocated$ac
R 719 6 24 esmf_utiltypesmod esmf_status_busy$ac
R 721 6 26 esmf_utiltypesmod esmf_status_invalid$ac
R 723 6 28 esmf_utiltypesmod esmf_status_not_ready$ac
R 724 25 29 esmf_utiltypesmod esmf_pointer
R 725 5 30 esmf_utiltypesmod ptr esmf_pointer
R 727 6 32 esmf_utiltypesmod esmf_null_pointer$ac
R 729 6 34 esmf_utiltypesmod esmf_bad_pointer$ac
R 730 25 35 esmf_utiltypesmod esmf_typekind
R 731 5 36 esmf_utiltypesmod dkind esmf_typekind
R 733 6 38 esmf_utiltypesmod esmf_typekind_i1$ac
R 735 6 40 esmf_utiltypesmod esmf_typekind_i2$ac
R 737 6 42 esmf_utiltypesmod esmf_typekind_i4$ac
R 739 6 44 esmf_utiltypesmod esmf_typekind_i8$ac
R 741 6 46 esmf_utiltypesmod esmf_typekind_r4$ac
R 743 6 48 esmf_utiltypesmod esmf_typekind_r8$ac
R 745 6 50 esmf_utiltypesmod esmf_c8$ac
R 747 6 52 esmf_utiltypesmod esmf_c16$ac
R 749 6 54 esmf_utiltypesmod esmf_typekind_logical$ac
R 751 6 56 esmf_utiltypesmod esmf_typekind_character$ac
R 753 6 58 esmf_utiltypesmod esmf_typekind_i$ac
R 755 6 60 esmf_utiltypesmod esmf_typekind_r$ac
R 757 6 62 esmf_utiltypesmod esmf_nokind$ac
R 772 25 77 esmf_utiltypesmod esmf_objectid
R 773 5 78 esmf_utiltypesmod objectid esmf_objectid
R 774 5 79 esmf_utiltypesmod objectname esmf_objectid
R 776 6 81 esmf_utiltypesmod esmf_id_base$ac
R 778 6 83 esmf_utiltypesmod esmf_id_iospec$ac
R 780 6 85 esmf_utiltypesmod esmf_id_logerr$ac
R 782 6 87 esmf_utiltypesmod esmf_id_time$ac
R 784 6 89 esmf_utiltypesmod esmf_id_calendar$ac
R 786 6 91 esmf_utiltypesmod esmf_id_timeinterval$ac
R 788 6 93 esmf_utiltypesmod esmf_id_alarm$ac
R 790 6 95 esmf_utiltypesmod esmf_id_clock$ac
R 792 6 97 esmf_utiltypesmod esmf_id_arrayspec$ac
R 794 6 99 esmf_utiltypesmod esmf_id_localarray$ac
R 796 6 101 esmf_utiltypesmod esmf_id_arraybundle$ac
R 798 6 103 esmf_utiltypesmod esmf_id_vm$ac
R 800 6 105 esmf_utiltypesmod esmf_id_delayout$ac
R 802 6 107 esmf_utiltypesmod esmf_id_config$ac
R 804 6 109 esmf_utiltypesmod esmf_id_array$ac
R 806 6 111 esmf_utiltypesmod esmf_id_interndg$ac
R 808 6 113 esmf_utiltypesmod esmf_id_commtable$ac
R 810 6 115 esmf_utiltypesmod esmf_id_routetable$ac
R 812 6 117 esmf_utiltypesmod esmf_id_route$ac
R 814 6 119 esmf_utiltypesmod esmf_id_routehandle$ac
R 816 6 121 esmf_utiltypesmod esmf_id_fielddatamap$ac
R 818 6 123 esmf_utiltypesmod esmf_id_field$ac
R 820 6 125 esmf_utiltypesmod esmf_id_fieldbundle$ac
R 822 6 127 esmf_utiltypesmod esmf_id_transformvalues$ac
R 824 6 129 esmf_utiltypesmod esmf_id_regrid$ac
R 826 6 131 esmf_utiltypesmod esmf_id_transform$ac
R 828 6 133 esmf_utiltypesmod esmf_id_state$ac
R 830 6 135 esmf_utiltypesmod esmf_id_gridcomponent$ac
R 832 6 137 esmf_utiltypesmod esmf_id_cplcomponent$ac
R 834 6 139 esmf_utiltypesmod esmf_id_component$ac
R 836 6 141 esmf_utiltypesmod esmf_id_internarray$ac
R 838 6 143 esmf_utiltypesmod esmf_id_none$ac
R 839 25 144 esmf_utiltypesmod esmf_axisindex
R 840 5 145 esmf_utiltypesmod min esmf_axisindex
R 841 5 146 esmf_utiltypesmod max esmf_axisindex
R 842 5 147 esmf_utiltypesmod stride esmf_axisindex
R 843 5 148 esmf_utiltypesmod pad esmf_axisindex
R 844 5 149 esmf_utiltypesmod isinit esmf_axisindex
R 850 25 155 esmf_utiltypesmod esmf_domainlist
R 851 5 156 esmf_utiltypesmod num_domains esmf_domainlist
R 852 5 157 esmf_utiltypesmod current_size esmf_domainlist
R 853 5 158 esmf_utiltypesmod total_points esmf_domainlist
R 854 5 159 esmf_utiltypesmod pad_for_64bit esmf_domainlist
R 856 5 161 esmf_utiltypesmod domains esmf_domainlist
R 857 5 162 esmf_utiltypesmod domains$sd esmf_domainlist
R 858 5 163 esmf_utiltypesmod domains$p esmf_domainlist
R 859 5 164 esmf_utiltypesmod domains$o esmf_domainlist
R 861 5 166 esmf_utiltypesmod isinit esmf_domainlist
R 862 25 167 esmf_utiltypesmod esmf_localglobalflag
R 863 5 168 esmf_utiltypesmod value esmf_localglobalflag
R 865 6 170 esmf_utiltypesmod esmf_local$ac
R 867 6 172 esmf_utiltypesmod esmf_global$ac
R 868 25 173 esmf_utiltypesmod esmf_domaintypeflag
R 869 5 174 esmf_utiltypesmod value esmf_domaintypeflag
R 871 6 176 esmf_utiltypesmod esmf_domain_exclusive$ac
R 873 6 178 esmf_utiltypesmod esmf_domain_computational$ac
R 875 6 180 esmf_utiltypesmod esmf_domain_total$ac
R 877 6 182 esmf_utiltypesmod esmf_domain_allocated$ac
R 879 6 184 esmf_utiltypesmod esmf_domain_oldexclusive$ac
R 881 6 186 esmf_utiltypesmod esmf_domain_oldcomputational$ac
R 883 6 188 esmf_utiltypesmod esmf_domain_oldtotal$ac
R 884 25 189 esmf_utiltypesmod esmf_logical
R 885 5 190 esmf_utiltypesmod value esmf_logical
R 887 6 192 esmf_utiltypesmod esmf_true$ac
R 889 6 194 esmf_utiltypesmod esmf_false$ac
R 890 25 195 esmf_utiltypesmod esmf_reduceflag
R 891 5 196 esmf_utiltypesmod value esmf_reduceflag
R 893 6 198 esmf_utiltypesmod esmf_sum$ac
R 895 6 200 esmf_utiltypesmod esmf_min$ac
R 897 6 202 esmf_utiltypesmod esmf_max$ac
R 898 25 203 esmf_utiltypesmod esmf_blockingflag
R 899 5 204 esmf_utiltypesmod value esmf_blockingflag
R 901 6 206 esmf_utiltypesmod esmf_blocking$ac
R 903 6 208 esmf_utiltypesmod esmf_vasblocking$ac
R 905 6 210 esmf_utiltypesmod esmf_nonblocking$ac
R 906 25 211 esmf_utiltypesmod esmf_contextflag
R 907 5 212 esmf_utiltypesmod value esmf_contextflag
R 909 6 214 esmf_utiltypesmod esmf_child_in_new_vm$ac
R 911 6 216 esmf_utiltypesmod esmf_child_in_parent_vm$ac
R 912 25 217 esmf_utiltypesmod esmf_terminationflag
R 913 5 218 esmf_utiltypesmod value esmf_terminationflag
R 915 6 220 esmf_utiltypesmod esmf_final$ac
R 917 6 222 esmf_utiltypesmod esmf_keepmpi$ac
R 919 6 224 esmf_utiltypesmod esmf_abort$ac
R 920 25 225 esmf_utiltypesmod esmf_depinflag
R 921 5 226 esmf_utiltypesmod value esmf_depinflag
R 923 6 228 esmf_utiltypesmod esmf_de_pin_pet$ac
R 925 6 230 esmf_utiltypesmod esmf_de_pin_vas$ac
R 926 25 231 esmf_utiltypesmod esmf_direction
R 927 5 232 esmf_utiltypesmod value esmf_direction
R 929 6 234 esmf_utiltypesmod esmf_mode_forward$ac
R 931 6 236 esmf_utiltypesmod esmf_mode_reverse$ac
R 932 25 237 esmf_utiltypesmod esmf_indexflag
R 933 5 238 esmf_utiltypesmod i_type esmf_indexflag
R 935 6 240 esmf_utiltypesmod esmf_index_delocal$ac
R 937 6 242 esmf_utiltypesmod esmf_index_global$ac
R 938 25 243 esmf_utiltypesmod esmf_regionflag
R 939 5 244 esmf_utiltypesmod i_type esmf_regionflag
R 941 6 246 esmf_utiltypesmod esmf_region_total$ac
R 943 6 248 esmf_utiltypesmod esmf_region_select$ac
R 945 6 250 esmf_utiltypesmod esmf_region_empty$ac
R 958 26 263 esmf_utiltypesmod =
O 958 2 8955 8954
R 1188 25 1 esmf_logerrmod esmf_msgtype
R 1189 5 2 esmf_logerrmod mtype esmf_msgtype
R 1191 6 4 esmf_logerrmod esmf_log_info$ac
R 1193 6 6 esmf_logerrmod esmf_log_warning$ac
R 1195 6 8 esmf_logerrmod esmf_log_error$ac
R 1196 25 9 esmf_logerrmod esmf_halttype
R 1197 5 10 esmf_logerrmod htype esmf_halttype
R 1199 6 12 esmf_logerrmod esmf_log_haltnever$ac
R 1201 6 14 esmf_logerrmod esmf_log_haltwarning$ac
R 1203 6 16 esmf_logerrmod esmf_log_halterror$ac
R 1204 25 17 esmf_logerrmod esmf_logtype
R 1205 5 18 esmf_logerrmod ftype esmf_logtype
R 1207 6 20 esmf_logerrmod esmf_log_single$ac
R 1209 6 22 esmf_logerrmod esmf_log_multi$ac
R 1211 6 24 esmf_logerrmod esmf_log_none$ac
S 1479 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 64 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 1650 25 4 esmf_vmmod esmf_vm
R 1651 5 5 esmf_vmmod this esmf_vm
R 1652 5 6 esmf_vmmod isinit esmf_vm
R 2976 25 1 esmf_delayoutmod esmf_delayout
R 2977 5 2 esmf_delayoutmod this esmf_delayout
R 2978 5 3 esmf_delayoutmod isinit esmf_delayout
R 2979 25 4 esmf_delayoutmod esmf_delayoutservicereply
R 2980 5 5 esmf_delayoutmod value esmf_delayoutservicereply
R 2982 6 7 esmf_delayoutmod esmf_delayout_service_accept$ac
R 2984 6 9 esmf_delayoutmod esmf_delayout_service_deny$ac
R 3277 25 1 esmf_arrayspecmod esmf_arrayspecstatus
R 3278 5 2 esmf_arrayspecmod status esmf_arrayspecstatus
R 3280 6 4 esmf_arrayspecmod esmf_arrayspec_status_unknown$ac
R 3282 6 6 esmf_arrayspecmod esmf_arrayspec_status_notset$ac
R 3284 6 8 esmf_arrayspecmod esmf_arrayspec_status_set$ac
R 3344 25 1 esmf_iospecmod esmf_iofileformat
R 3345 5 2 esmf_iospecmod iofileformat esmf_iofileformat
R 3347 6 4 esmf_iospecmod esmf_io_fileformat_unspecified$ac
R 3349 6 6 esmf_iospecmod esmf_io_fileformat_netcdf$ac
R 3351 6 8 esmf_iospecmod esmf_io_fileformat_hdf$ac
R 3352 25 9 esmf_iospecmod esmf_iorwtype
R 3353 5 10 esmf_iospecmod iorwtype esmf_iorwtype
R 3355 6 12 esmf_iospecmod esmf_io_rwtype_unspecified$ac
R 3357 6 14 esmf_iospecmod esmf_io_rwtype_readonly$ac
R 3359 6 16 esmf_iospecmod esmf_io_rwtype_writeonly$ac
R 3361 6 18 esmf_iospecmod esmf_io_rwtype_readwrite$ac
R 3363 6 20 esmf_iospecmod esmf_io_rwtype_append$ac
R 3365 6 22 esmf_iospecmod esmf_io_rwtype_truncate$ac
S 3441 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 19 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 3455 25 1 esmf_localarraycreatemod esmf_copyflag
R 3456 5 2 esmf_localarraycreatemod docopy esmf_copyflag
R 3458 6 4 esmf_localarraycreatemod esmf_data_copy$ac
R 3460 6 6 esmf_localarraycreatemod esmf_data_ref$ac
R 3462 6 8 esmf_localarraycreatemod esmf_data_defer$ac
R 3464 6 10 esmf_localarraycreatemod esmf_data_space$ac
R 3466 6 12 esmf_localarraycreatemod esmf_data_none$ac
R 3467 25 13 esmf_localarraycreatemod esmf_localarrayorigin
R 3468 5 14 esmf_localarraycreatemod origin esmf_localarrayorigin
R 3470 6 16 esmf_localarraycreatemod esmf_from_fortran$ac
R 3472 6 18 esmf_localarraycreatemod esmf_from_cplusplus$ac
R 3473 25 19 esmf_localarraycreatemod esmf_localarray
R 3474 5 20 esmf_localarraycreatemod this esmf_localarray
R 3475 5 21 esmf_localarraycreatemod isinit esmf_localarray
R 8846 25 1 esmf_xpacketmod esmf_xpacket
R 8847 5 2 esmf_xpacketmod rank esmf_xpacket
R 8848 5 3 esmf_xpacketmod offset esmf_xpacket
R 8849 5 4 esmf_xpacketmod contig_length esmf_xpacket
R 8850 5 5 esmf_xpacketmod stride esmf_xpacket
R 8851 5 6 esmf_xpacketmod rep_count esmf_xpacket
R 8852 5 7 esmf_xpacketmod isinit esmf_xpacket
S 8907 25 0 0 0 6117 1 582 50204 10800004 800010 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 8961 0 0 0 582 0 0 0 0 esmf_route
S 8908 5 0 0 0 52 8909 582 13664 800014 0 0 0 0 0 6117 0 0 0 0 0 0 0 0 0 0 0 1 8908 0 582 0 0 0 0 this
S 8909 5 0 0 0 7 1 582 8894 800014 0 0 8 0 0 6117 0 0 0 0 0 0 0 0 0 0 0 8908 8909 0 582 0 0 0 0 isinit
S 8910 25 1 0 0 6123 1 582 50215 10800004 800010 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 8960 0 0 0 582 0 0 0 0 esmf_routeoptions
S 8911 5 0 0 0 6 1 582 50233 80001c 0 0 0 0 0 6123 0 0 0 0 0 0 0 0 0 0 0 1 8911 0 582 0 0 0 0 option
S 8912 16 0 0 0 6123 1 582 50240 4 400000 0 0 0 0 8913 1 0 0 0 0 0 0 0 0 0 0 0 9481 0 582 0 0 0 0 esmf_route_option_async
S 8913 6 4 0 0 6123 8915 582 50264 4080005c 400000 0 0 0 0 0 0 0 0 8962 0 0 0 0 0 0 0 0 9481 0 582 0 8912 0 0 esmf_route_option_async$ac
S 8914 16 0 0 0 6123 1 582 50291 4 400000 0 0 0 0 8915 2 0 0 0 0 0 0 0 0 0 0 0 9484 0 582 0 0 0 0 esmf_route_option_sync
S 8915 6 4 0 0 6123 8917 582 50314 4080005c 400000 0 4 0 0 0 0 0 0 8962 0 0 0 0 0 0 0 0 9484 0 582 0 8914 0 0 esmf_route_option_sync$ac
S 8916 16 0 0 0 6123 1 582 50340 4 400000 0 0 0 0 8917 3 0 0 0 0 0 0 0 0 0 0 0 9487 0 582 0 0 0 0 esmf_route_option_pack_pet
S 8917 6 4 0 0 6123 8919 582 50367 4080005c 400000 0 8 0 0 0 0 0 0 8962 0 0 0 0 0 0 0 0 9487 0 582 0 8916 0 0 esmf_route_option_pack_pet$ac
S 8918 16 0 0 0 6123 1 582 50397 4 400000 0 0 0 0 8919 4 0 0 0 0 0 0 0 0 0 0 0 9490 0 582 0 0 0 0 esmf_route_option_pack_xp
S 8919 6 4 0 0 6123 8921 582 50423 4080005c 400000 0 12 0 0 0 0 0 0 8962 0 0 0 0 0 0 0 0 9490 0 582 0 8918 0 0 esmf_route_option_pack_xp$ac
S 8920 16 0 0 0 6123 1 582 50452 4 400000 0 0 0 0 8921 5 0 0 0 0 0 0 0 0 0 0 0 9493 0 582 0 0 0 0 esmf_route_option_pack_nopack
S 8921 6 4 0 0 6123 8923 582 50482 4080005c 400000 0 16 0 0 0 0 0 0 8962 0 0 0 0 0 0 0 0 9493 0 582 0 8920 0 0 esmf_route_option_pack_nopack$ac
S 8922 16 0 0 0 6123 1 582 50515 4 400000 0 0 0 0 8923 6 0 0 0 0 0 0 0 0 0 0 0 9496 0 582 0 0 0 0 esmf_route_option_pack_vector
S 8923 6 4 0 0 6123 8925 582 50545 4080005c 400000 0 20 0 0 0 0 0 0 8962 0 0 0 0 0 0 0 0 9496 0 582 0 8922 0 0 esmf_route_option_pack_vector$ac
S 8924 16 0 0 0 6123 1 582 50578 4 400000 0 0 0 0 8925 7 0 0 0 0 0 0 0 0 0 0 0 9499 0 582 0 0 0 0 esmf_route_option_pack_buffer
S 8925 6 4 0 0 6123 8928 582 50608 4080005c 400000 0 24 0 0 0 0 0 0 8962 0 0 0 0 0 0 0 0 9499 0 582 0 8924 0 0 esmf_route_option_pack_buffer$ac
S 8926 16 0 0 0 6123 1 582 50641 4 400000 0 0 0 0 8928 8 0 0 0 0 0 0 0 0 0 0 0 9503 0 582 0 0 0 0 esmf_route_option_default
S 8927 3 0 0 0 6 0 1 0 0 0 0 0 0 0 0 69 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 8928 6 4 0 0 6123 1 582 50667 4080005c 400000 0 28 0 0 0 0 0 0 8962 0 0 0 0 0 0 0 0 9503 0 582 0 8926 0 0 esmf_route_option_default$ac
S 8929 27 0 0 0 8 8967 582 50696 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routegetinit
S 8930 27 0 0 0 8 8963 582 50714 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routesetinitcreated
S 8931 27 0 0 0 8 8984 582 50739 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routecreate
S 8932 27 0 0 0 8 8989 582 50756 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routedestroy
S 8933 27 0 0 0 8 9237 582 50774 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routeset
S 8934 27 0 0 0 8 9253 582 50788 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routesetsend
S 8935 27 0 0 0 8 9247 582 50806 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routesetrecv
S 8936 27 0 0 0 8 9242 582 50824 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routesetrecvitems
S 8937 27 0 0 0 8 8999 582 50847 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routegetrecvitems
S 8938 27 0 0 0 8 9015 582 50870 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routeprecomputehalo
S 8939 27 0 0 0 8 9047 582 50895 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routeprecomputeredist
S 8940 27 0 0 0 8 9078 582 50922 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routeprecomputeredistv
S 8941 27 0 0 0 8 9139 582 50950 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routeprecomputeredista2a
S 8942 27 0 0 0 8 9188 582 50980 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routeprecomputeregrid
S 8943 27 0 0 0 8 9004 582 51007 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routeprecomputedomlist
S 8944 27 0 0 0 8 9264 582 51035 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routerun
S 8945 27 0 0 0 8 9270 582 51049 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routerunlist
S 8946 27 0 0 0 8 9284 582 51067 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routerunf90ptri411d
S 8947 27 0 0 0 8 9298 582 51092 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routerunf90ptri421d
S 8948 27 0 0 0 8 9312 582 51117 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routerunf90ptrr811d
S 8949 27 0 0 0 8 9326 582 51142 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routerunf90ptrr821d
S 8950 27 0 0 0 8 9340 582 51167 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routerunf90ptrr832d
S 8951 27 0 0 0 8 9354 582 51192 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routevalidate
S 8952 27 0 0 0 8 9259 582 51211 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routeprint
S 8953 26 0 0 0 0 1 582 51227 0 0 0 0 1 0 0 0 0 0 1 0 0 0 382 1 0 0 0 0 0 582 0 0 0 0 +
O 8953 1 8956
S 8954 27 0 0 0 6 8976 582 51229 10010 0 0 0 384 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 iras
Q 8954 958 0
S 8955 27 0 0 0 8 8980 582 51234 10010 0 0 0 385 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 rias
Q 8955 958 0
S 8956 27 0 0 0 8 8971 582 51239 10010 0 0 0 383 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 radd
Q 8956 8953 0
S 8957 3 0 0 0 827 0 1 0 0 0 0 0 0 0 51244 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 18 64 24 49 64 3a 20 45 53 4d 46 5f 52 6f 75 74 65 2e 46 39 30 2c 76 20 31 2e 39 37 2e 32 2e 32 20 32 30 30 38 2f 30 36 2f 32 34 20 32 31 3a 35 33 3a 35 37 20 65 73 63 68 77 61 62 20 45 78 70 20 24
S 8958 16 0 0 0 827 1 582 14044 14 440000 0 0 0 0 8957 9505 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 version
S 8959 23 0 0 0 0 958 582 10599 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 =
S 8960 8 5 0 0 6129 1 582 51309 40022004 1220 0 0 0 6123 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routemod$esmf_routeoptions$td
S 8961 8 5 0 0 6132 1 582 51344 40022004 1220 0 0 0 6117 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 582 0 0 0 0 esmf_routemod$esmf_route$td
S 8962 11 0 0 0 8 8526 582 51372 40800010 801000 0 32 0 0 8913 8928 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 _esmf_routemod$12
S 8963 23 5 0 0 0 8966 582 50714 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routesetinitcreated
S 8964 1 3 3 0 6117 1 8963 51390 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 r
S 8965 1 3 2 0 6 1 8963 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 8966 14 5 0 0 0 1 8963 50714 0 400000 0 0 0 2765 2 0 0 0 0 0 0 0 0 0 0 0 0 170 0 582 0 0 0 0 esmf_routesetinitcreated
F 8966 2 8964 8965
S 8967 23 5 0 0 8 8969 582 50696 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routegetinit
S 8968 1 3 1 0 6117 1 8967 12264 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 d
S 8969 14 5 0 0 7 1 8967 50696 4 400000 0 0 0 2768 1 0 0 8970 0 0 0 0 0 0 0 0 0 209 0 582 0 0 0 0 esmf_routegetinit
F 8969 1 8968
S 8970 1 3 0 0 7 1 8967 50696 14 1003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routegetinit
S 8971 23 5 0 0 8 8974 582 51239 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 radd
S 8972 1 3 1 0 6123 1 8971 51392 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 first
S 8973 1 3 1 0 6123 1 8971 51398 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 second
S 8974 14 5 0 0 6123 1 8971 51239 14 400000 0 0 0 2770 2 0 0 8975 0 0 0 0 0 0 0 0 0 240 0 582 0 0 0 0 radd
F 8974 2 8972 8973
S 8975 1 3 0 0 6123 1 8971 51239 14 1003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 radd
S 8976 23 5 0 0 0 8979 582 51229 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 iras
S 8977 1 3 2 0 6123 1 8976 51392 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 first
S 8978 1 3 1 0 6 1 8976 51398 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 second
S 8979 14 5 0 0 0 1 8976 51229 10 400000 0 0 0 2773 2 0 0 0 0 0 0 0 0 0 0 0 0 248 0 582 0 0 0 0 iras
F 8979 2 8977 8978
S 8980 23 5 0 0 0 8983 582 51234 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rias
S 8981 1 3 2 0 6 1 8980 51392 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 first
S 8982 1 3 1 0 6123 1 8980 51398 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 second
S 8983 14 5 0 0 0 1 8980 51234 10 400000 0 0 0 2776 2 0 0 0 0 0 0 0 0 0 0 0 0 256 0 582 0 0 0 0 rias
F 8983 2 8981 8982
S 8984 23 5 0 0 8 8987 582 50739 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routecreate
S 8985 1 3 1 0 987 1 8984 16560 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 vm
S 8986 1 3 2 0 6 1 8984 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 8987 14 5 0 0 6117 1 8984 50739 4 400000 0 0 0 2779 2 0 0 8988 0 0 0 0 0 0 0 0 0 275 0 582 0 0 0 0 esmf_routecreate
F 8987 2 8985 8986
S 8988 1 3 0 0 6117 1 8984 50739 14 1003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routecreate
S 8989 23 5 0 0 0 8992 582 50756 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routedestroy
S 8990 1 3 3 0 6117 1 8989 51405 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 route
S 8991 1 3 2 0 6 1 8989 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 8992 14 5 0 0 0 1 8989 50756 0 400000 0 0 0 2782 2 0 0 0 0 0 0 0 0 0 0 0 0 335 0 582 0 0 0 0 esmf_routedestroy
F 8992 2 8990 8991
S 8993 23 5 0 0 0 8998 582 51411 10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routeget
S 8994 1 3 3 0 6117 1 8993 51405 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 route
S 8995 1 3 2 0 6 1 8993 50174 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 value1
S 8996 1 3 2 0 6 1 8993 50181 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 value2
S 8997 1 3 2 0 6 1 8993 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 8998 14 5 0 0 0 1 8993 51411 10 400000 0 0 0 2785 4 0 0 0 0 0 0 0 0 0 0 0 0 386 0 582 0 0 0 0 esmf_routeget
F 8998 4 8994 8995 8996 8997
S 8999 23 5 0 0 0 9003 582 50847 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routegetrecvitems
S 9000 1 3 3 0 6117 1 8999 51405 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 route
S 9001 1 3 2 0 6 1 8999 51425 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 nitems
S 9002 1 3 2 0 6 1 8999 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 9003 14 5 0 0 0 1 8999 50847 0 400000 0 0 0 2790 3 0 0 0 0 0 0 0 0 0 0 0 0 447 0 582 0 0 0 0 esmf_routegetrecvitems
F 9003 3 9000 9001 9002
S 9004 23 5 0 0 0 9014 582 51007 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routeprecomputedomlist
S 9005 1 3 3 0 6117 1 9004 51405 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 route
S 9006 1 3 1 0 6 1 9004 8916 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rank
S 9007 1 3 3 0 1530 1 9004 51432 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcdelayout
S 9008 1 3 3 0 1530 1 9004 51444 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstdelayout
S 9009 1 3 3 0 115 1 9004 51456 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcdomainlist
S 9010 1 3 3 0 115 1 9004 51470 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstdomainlist
S 9011 1 3 1 0 16 1 9004 51484 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 hassrcdata
S 9012 1 3 1 0 16 1 9004 51495 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 hasdstdata
S 9013 1 3 2 0 6 1 9004 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 9014 14 5 0 0 0 1 9004 51007 0 400000 0 0 0 2794 9 0 0 0 0 0 0 0 0 0 0 0 0 507 0 582 0 0 0 0 esmf_routeprecomputedomlist
F 9014 9 9005 9006 9007 9008 9009 9010 9011 9012 9013
S 9015 23 5 0 0 0 9027 582 50870 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routeprecomputehalo
S 9016 1 3 3 0 6117 1 9015 51405 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 route
S 9017 1 3 1 0 6 1 9015 8916 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rank
S 9018 1 3 1 0 6 1 9015 51506 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 my_de
S 9019 7 3 0 0 6135 1 9015 51512 10800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9028 0 0 0 0 0 0 0 0 ai_exc
S 9020 7 3 0 0 6141 1 9015 51519 10800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9032 0 0 0 0 0 0 0 0 ai_tot
S 9021 1 3 1 0 6 1 9015 51526 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ai_count
S 9022 7 3 1 0 6147 1 9015 51535 20000014 10003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 global_start
S 9023 7 3 1 0 6150 1 9015 51548 800014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 global_count
S 9024 1 3 3 0 1530 1 9015 19167 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 delayout
S 9025 7 3 1 0 6153 1 9015 51561 20000014 10003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 periodic
S 9026 1 3 2 0 6 1 9015 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 9027 14 5 0 0 0 1 9015 50870 20000000 400000 0 0 0 2804 11 0 0 0 0 0 0 0 0 0 0 0 0 653 0 582 0 0 0 0 esmf_routeprecomputehalo
F 9027 11 9016 9017 9018 9019 9020 9021 9022 9023 9024 9025 9026
S 9028 8 1 0 0 6138 1 9015 51570 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ai_exc$sd
S 9032 8 1 0 0 6144 1 9015 51612 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ai_tot$sd
S 9036 6 1 0 0 6 1 9015 51654 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_14_2
S 9037 6 1 0 0 6 1 9015 51663 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_16_2
S 9038 6 1 0 0 6 1 9015 51672 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_17_2
S 9039 6 1 0 0 6 1 9015 51681 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_19_2
S 9040 6 1 0 0 6 1 9015 51690 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_20_2
S 9041 6 1 0 0 6 1 9015 51699 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_9567
S 9042 6 1 0 0 6 1 9015 51708 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_9570
S 9043 6 1 0 0 6 1 9015 51717 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_21_2
S 9044 6 1 0 0 6 1 9015 51726 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_23_2
S 9045 6 1 0 0 6 1 9015 51735 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_24_2
S 9046 6 1 0 0 6 1 9015 51744 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_9577
S 9047 23 5 0 0 0 9061 582 50895 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routeprecomputeredist
S 9048 1 3 3 0 6117 1 9047 51405 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 route
S 9049 1 3 1 0 6 1 9047 8916 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rank
S 9050 1 3 1 0 139 1 9047 51484 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 hassrcdata
S 9051 1 3 3 0 1530 1 9047 51432 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcdelayout
S 9052 1 3 1 0 6 1 9047 51753 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 mysrcde
S 9053 7 3 0 0 6162 1 9047 51761 10800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9066 0 0 0 0 0 0 0 0 srcglobalcompaiperdeperrank
S 9054 7 3 0 0 6156 1 9047 51789 10800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9062 0 0 0 0 0 0 0 0 mysrcglobaltotalaiperrank
S 9055 1 3 1 0 139 1 9047 51495 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 hasdstdata
S 9056 1 3 3 0 1530 1 9047 51444 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstdelayout
S 9057 1 3 1 0 6 1 9047 51815 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 mydstde
S 9058 7 3 0 0 6174 1 9047 51823 10800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9074 0 0 0 0 0 0 0 0 dstglobalcompaiperdeperrank
S 9059 7 3 0 0 6168 1 9047 51851 10800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9070 0 0 0 0 0 0 0 0 mydstglobaltotalaiperrank
S 9060 1 3 2 0 6 1 9047 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 9061 14 5 0 0 0 1 9047 50895 0 400000 0 0 0 2816 13 0 0 0 0 0 0 0 0 0 0 0 0 766 0 582 0 0 0 0 esmf_routeprecomputeredist
F 9061 13 9048 9049 9050 9051 9052 9053 9054 9055 9056 9057 9058 9059 9060
S 9062 8 1 0 0 6159 1 9047 51877 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 mysrcglobaltotalaiperrank$sd
S 9066 8 1 0 0 6165 1 9047 51995 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcglobalcompaiperdeperrank$sd
S 9070 8 1 0 0 6171 1 9047 52121 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 mydstglobaltotalaiperrank$sd
S 9074 8 1 0 0 6177 1 9047 52239 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstglobalcompaiperdeperrank$sd
S 9078 23 5 0 0 0 9100 582 50922 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routeprecomputeredistv
S 9079 1 3 3 0 6117 1 9078 51405 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 route
S 9080 1 3 1 0 6 1 9078 8916 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rank
S 9081 1 3 1 0 139 1 9078 51495 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 hasdstdata
S 9082 1 3 1 0 6 1 9078 52365 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstmyde
S 9083 1 3 1 0 16 1 9078 52373 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstvector
S 9084 7 3 0 0 6180 1 9078 52383 10800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9101 0 0 0 0 0 0 0 0 dstcompai
S 9085 7 3 0 0 6186 1 9078 52393 10800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9105 0 0 0 0 0 0 0 0 dsttotalai
S 9086 7 3 1 0 6192 1 9078 52404 20000014 10003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstaicountperde
S 9087 7 3 1 0 6195 1 9078 52420 20000014 10003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstglobalstart
S 9088 7 3 1 0 6198 1 9078 52435 800014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstglobalcount
S 9089 1 3 3 0 1530 1 9078 51444 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstdelayout
S 9090 1 3 1 0 139 1 9078 51484 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 hassrcdata
S 9091 1 3 1 0 6 1 9078 52450 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcmyde
S 9092 1 3 1 0 16 1 9078 52458 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcvector
S 9093 7 3 0 0 6201 1 9078 52468 10800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9120 0 0 0 0 0 0 0 0 srccompai
S 9094 7 3 0 0 6207 1 9078 52478 10800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9124 0 0 0 0 0 0 0 0 srctotalai
S 9095 7 3 1 0 6213 1 9078 52489 20000014 10003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcaicountperde
S 9096 7 3 1 0 6216 1 9078 52505 20000014 10003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcglobalstart
S 9097 7 3 1 0 6219 1 9078 52520 800014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcglobalcount
S 9098 1 3 3 0 1530 1 9078 51432 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcdelayout
S 9099 1 3 2 0 6 1 9078 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 9100 14 5 0 0 0 1 9078 50922 20000000 400000 0 0 0 2830 21 0 0 0 0 0 0 0 0 0 0 0 0 938 0 582 0 0 0 0 esmf_routeprecomputeredistv
F 9100 21 9079 9080 9081 9082 9083 9084 9085 9086 9087 9088 9089 9090 9091 9092 9093 9094 9095 9096 9097 9098 9099
S 9101 8 1 0 0 6183 1 9078 52535 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstcompai$sd
S 9105 8 1 0 0 6189 1 9078 52589 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dsttotalai$sd
S 9109 6 1 0 0 6 1 9078 51654 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_14_2
S 9110 6 1 0 0 6 1 9078 51663 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_16_2
S 9111 6 1 0 0 6 1 9078 51672 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_17_2
S 9112 6 1 0 0 6 1 9078 52647 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_9643
S 9113 6 1 0 0 6 1 9078 52656 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_18_2
S 9114 6 1 0 0 6 1 9078 51690 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_20_2
S 9115 6 1 0 0 6 1 9078 51717 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_21_2
S 9116 6 1 0 0 6 1 9078 51726 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_23_2
S 9117 6 1 0 0 6 1 9078 51735 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_24_2
S 9118 6 1 0 0 6 1 9078 52665 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_9653
S 9119 6 1 0 0 6 1 9078 52674 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_9656
S 9120 8 1 0 0 6204 1 9078 52683 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srccompai$sd
S 9124 8 1 0 0 6210 1 9078 52737 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srctotalai$sd
S 9128 6 1 0 0 6 1 9078 52795 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_39_2
S 9129 6 1 0 0 6 1 9078 52804 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_41_2
S 9130 6 1 0 0 6 1 9078 52813 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_42_2
S 9131 6 1 0 0 6 1 9078 52822 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_9715
S 9132 6 1 0 0 6 1 9078 52831 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_43_2
S 9133 6 1 0 0 6 1 9078 52840 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_45_2
S 9134 6 1 0 0 6 1 9078 52849 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_46_2
S 9135 6 1 0 0 6 1 9078 52858 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_48_2
S 9136 6 1 0 0 6 1 9078 52867 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_49_2
S 9137 6 1 0 0 6 1 9078 52876 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_9725
S 9138 6 1 0 0 6 1 9078 52885 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_9728
S 9139 23 5 0 0 0 9157 582 50950 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routeprecomputeredista2a
S 9140 1 3 3 0 6117 1 9139 51405 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 route
S 9141 1 3 1 0 6 1 9139 8916 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rank
S 9142 1 3 1 0 139 1 9139 51495 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 hasdstdata
S 9143 1 3 1 0 6 1 9139 52365 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstmyde
S 9144 7 3 0 0 6222 1 9139 52383 10800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9158 0 0 0 0 0 0 0 0 dstcompai
S 9145 7 3 1 0 6228 1 9139 52404 20000014 10003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstaicountperde
S 9146 7 3 1 0 6231 1 9139 52420 20000014 10003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstglobalstart
S 9147 7 3 1 0 6234 1 9139 52435 800014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstglobalcount
S 9148 1 3 3 0 1530 1 9139 51444 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstdelayout
S 9149 1 3 1 0 139 1 9139 51484 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 hassrcdata
S 9150 1 3 1 0 6 1 9139 52450 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcmyde
S 9151 7 3 0 0 6237 1 9139 52468 10800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9173 0 0 0 0 0 0 0 0 srccompai
S 9152 7 3 1 0 6243 1 9139 52489 20000014 10003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcaicountperde
S 9153 7 3 1 0 6246 1 9139 52505 20000014 10003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcglobalstart
S 9154 7 3 1 0 6249 1 9139 52520 800014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcglobalcount
S 9155 1 3 3 0 1530 1 9139 51432 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcdelayout
S 9156 1 3 2 0 6 1 9139 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 9157 14 5 0 0 0 1 9139 50950 20000000 400000 0 0 0 2852 17 0 0 0 0 0 0 0 0 0 0 0 0 1129 0 582 0 0 0 0 esmf_routeprecomputeredista2a
F 9157 17 9140 9141 9142 9143 9144 9145 9146 9147 9148 9149 9150 9151 9152 9153 9154 9155 9156
S 9158 8 1 0 0 6225 1 9139 52894 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstcompai$sd1
S 9162 6 1 0 0 6 1 9139 49400 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_7_2
S 9163 6 1 0 0 6 1 9139 52952 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_9_2
S 9164 6 1 0 0 6 1 9139 49425 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_10_2
S 9165 6 1 0 0 6 1 9139 52960 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_9691
S 9166 6 1 0 0 6 1 9139 49434 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_11_2
S 9167 6 1 0 0 6 1 9139 52969 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_13_2
S 9168 6 1 0 0 6 1 9139 51654 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_14_2
S 9169 6 1 0 0 6 1 9139 51663 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_16_2
S 9170 6 1 0 0 6 1 9139 51672 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_17_2
S 9171 6 1 0 0 6 1 9139 52978 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_9701
S 9172 6 1 0 0 6 1 9139 52987 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_9704
S 9173 8 1 0 0 6240 1 9139 52996 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srccompai$sd5
S 9177 6 1 0 0 6 1 9139 53054 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_25_2
S 9178 6 1 0 0 6 1 9139 53063 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_27_2
S 9179 6 1 0 0 6 1 9139 53072 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_28_2
S 9180 6 1 0 0 6 1 9139 53081 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_9737
S 9181 6 1 0 0 6 1 9139 53090 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_29_2
S 9182 6 1 0 0 6 1 9139 53099 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_31_2
S 9183 6 1 0 0 6 1 9139 53108 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_32_2
S 9184 6 1 0 0 6 1 9139 53117 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_34_2
S 9185 6 1 0 0 6 1 9139 53126 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_35_2
S 9186 6 1 0 0 6 1 9139 53135 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_9747
S 9187 6 1 0 0 6 1 9139 53144 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_9750
S 9188 23 5 0 0 0 9206 582 50980 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routeprecomputeregrid
S 9189 1 3 3 0 6117 1 9188 51405 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 route
S 9190 1 3 1 0 6 1 9188 8916 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rank
S 9191 1 3 1 0 6 1 9188 53153 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 my_de_dst
S 9192 7 3 0 0 6252 1 9188 53163 10800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9207 0 0 0 0 0 0 0 0 ai_dst_exc
S 9193 7 3 0 0 6258 1 9188 53174 10800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9211 0 0 0 0 0 0 0 0 ai_dst_tot
S 9194 1 3 1 0 6 1 9188 53185 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ai_dst_count
S 9195 7 3 1 0 6264 1 9188 53198 20000014 10003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dst_global_start
S 9196 7 3 1 0 6267 1 9188 53215 800014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dst_global_count
S 9197 1 3 3 0 1530 1 9188 51444 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstdelayout
S 9198 1 3 1 0 6 1 9188 53232 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 my_de_src
S 9199 7 3 0 0 6270 1 9188 53242 10800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9222 0 0 0 0 0 0 0 0 ai_src_exc
S 9200 7 3 0 0 6276 1 9188 53253 10800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9226 0 0 0 0 0 0 0 0 ai_src_tot
S 9201 1 3 1 0 6 1 9188 53264 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ai_src_count
S 9202 7 3 1 0 6282 1 9188 53277 20000014 10003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 src_global_start
S 9203 7 3 1 0 6285 1 9188 53294 800014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 src_global_count
S 9204 1 3 3 0 1530 1 9188 51432 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcdelayout
S 9205 1 3 2 0 6 1 9188 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 9206 14 5 0 0 0 1 9188 50980 20000000 400000 0 0 0 2870 17 0 0 0 0 0 0 0 0 0 0 0 0 1285 0 582 0 0 0 0 esmf_routeprecomputeregrid
F 9206 17 9189 9190 9191 9192 9193 9194 9195 9196 9197 9198 9199 9200 9201 9202 9203 9204 9205
S 9207 8 1 0 0 6255 1 9188 53311 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ai_dst_exc$sd
S 9211 8 1 0 0 6261 1 9188 53369 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ai_dst_tot$sd
S 9215 6 1 0 0 6 1 9188 51654 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_14_2
S 9216 6 1 0 0 6 1 9188 51663 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_16_2
S 9217 6 1 0 0 6 1 9188 51672 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_17_2
S 9218 6 1 0 0 6 1 9188 51681 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_19_2
S 9219 6 1 0 0 6 1 9188 51690 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_20_2
S 9220 6 1 0 0 6 1 9188 53427 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_9768
S 9221 6 1 0 0 6 1 9188 53436 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_9771
S 9222 8 1 0 0 6273 1 9188 53445 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ai_src_exc$sd
S 9226 8 1 0 0 6279 1 9188 53503 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ai_src_tot$sd
S 9230 6 1 0 0 6 1 9188 53126 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_35_2
S 9231 6 1 0 0 6 1 9188 53561 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_37_2
S 9232 6 1 0 0 6 1 9188 53570 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_38_2
S 9233 6 1 0 0 6 1 9188 53579 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_40_2
S 9234 6 1 0 0 6 1 9188 52804 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_41_2
S 9235 6 1 0 0 6 1 9188 53588 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_9833
S 9236 6 1 0 0 6 1 9188 53597 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_9836
S 9237 23 5 0 0 0 9241 582 50774 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routeset
S 9238 1 3 3 0 6117 1 9237 51405 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 route
S 9239 1 3 1 0 6123 1 9237 14301 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 options
S 9240 1 3 2 0 6 1 9237 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 9241 14 5 0 0 0 1 9237 50774 0 400000 0 0 0 2888 3 0 0 0 0 0 0 0 0 0 0 0 0 1440 0 582 0 0 0 0 esmf_routeset
F 9241 3 9238 9239 9240
S 9242 23 5 0 0 0 9246 582 50824 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routesetrecvitems
S 9243 1 3 3 0 6117 1 9242 51405 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 route
S 9244 1 3 1 0 6 1 9242 51425 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 nitems
S 9245 1 3 2 0 6 1 9242 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 9246 14 5 0 0 0 1 9242 50824 0 400000 0 0 0 2892 3 0 0 0 0 0 0 0 0 0 0 0 0 1496 0 582 0 0 0 0 esmf_routesetrecvitems
F 9246 3 9243 9244 9245
S 9247 23 5 0 0 0 9252 582 50806 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routesetrecv
S 9248 1 3 3 0 6117 1 9247 51405 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 route
S 9249 1 3 1 0 6 1 9247 53606 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcpet
S 9250 1 3 3 0 6092 1 9247 53613 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 xp
S 9251 1 3 2 0 6 1 9247 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 9252 14 5 0 0 0 1 9247 50806 0 400000 0 0 0 2896 4 0 0 0 0 0 0 0 0 0 0 0 0 1556 0 582 0 0 0 0 esmf_routesetrecv
F 9252 4 9248 9249 9250 9251
S 9253 23 5 0 0 0 9258 582 50788 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routesetsend
S 9254 1 3 3 0 6117 1 9253 51405 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 route
S 9255 1 3 1 0 6 1 9253 53616 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 destpet
S 9256 1 3 3 0 6092 1 9253 53613 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 xp
S 9257 1 3 2 0 6 1 9253 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 9258 14 5 0 0 0 1 9253 50788 0 400000 0 0 0 2901 4 0 0 0 0 0 0 0 0 0 0 0 0 1620 0 582 0 0 0 0 esmf_routesetsend
F 9258 4 9254 9255 9256 9257
S 9259 23 5 0 0 0 9263 582 51211 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routeprint
S 9260 1 3 3 0 6117 1 9259 51405 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 route
S 9261 1 3 1 0 28 1 9259 14301 80000014 43000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 options
S 9262 1 3 2 0 6 1 9259 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 9263 14 5 0 0 0 1 9259 51211 0 400000 0 0 0 2906 3 0 0 0 0 0 0 0 0 0 0 0 0 1684 0 582 0 0 0 0 esmf_routeprint
F 9263 3 9260 9261 9262
S 9264 23 5 0 0 0 9269 582 51035 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routerun
S 9265 1 3 3 0 6117 1 9264 51405 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 route
S 9266 1 3 3 0 2197 1 9264 53624 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcarray
S 9267 1 3 3 0 2197 1 9264 53633 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstarray
S 9268 1 3 2 0 6 1 9264 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 9269 14 5 0 0 0 1 9264 51035 0 400000 0 0 0 2910 4 0 0 0 0 0 0 0 0 0 0 0 0 1753 0 582 0 0 0 0 esmf_routerun
F 9269 4 9265 9266 9267 9268
S 9270 23 5 0 0 0 9275 582 51049 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routerunlist
S 9271 1 3 3 0 6117 1 9270 51405 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 route
S 9272 7 3 3 0 6288 1 9270 53642 a0000014 10003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcarraylist
S 9273 7 3 3 0 6291 1 9270 53655 a0000014 10003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstarraylist
S 9274 1 3 2 0 6 1 9270 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 9275 14 5 0 0 0 1 9270 51049 20000000 400000 0 0 0 2915 4 0 0 0 0 0 0 0 0 0 0 0 0 1845 0 582 0 0 0 0 esmf_routerunlist
F 9275 4 9271 9272 9273 9274
S 9276 6 1 0 0 6 1 9270 49351 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_0_4
S 9277 6 1 0 0 6 1 9270 49359 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_2_3
S 9278 6 1 0 0 6 1 9270 49367 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_3_2
S 9279 6 1 0 0 6 1 9270 53668 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_9779
S 9280 6 1 0 0 6 1 9270 49384 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_4_2
S 9281 6 1 0 0 6 1 9270 49392 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_6_2
S 9282 6 1 0 0 6 1 9270 49400 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_7_2
S 9283 6 1 0 0 6 1 9270 53677 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_9786
S 9284 23 5 0 0 0 9289 582 51067 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routerunf90ptri411d
S 9285 1 3 3 0 6117 1 9284 51405 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 route
S 9286 7 3 0 0 6294 1 9284 53624 90800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9290 0 0 0 0 0 0 0 0 srcarray
S 9287 7 3 0 0 6300 1 9284 53633 90800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9294 0 0 0 0 0 0 0 0 dstarray
S 9288 1 3 2 0 6 1 9284 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 9289 14 5 0 0 0 1 9284 51067 0 400000 0 0 0 2920 4 0 0 0 0 0 0 0 0 0 0 0 0 1981 0 582 0 0 0 0 esmf_routerunf90ptri411d
F 9289 4 9285 9286 9287 9288
S 9290 8 1 0 0 6297 1 9284 53686 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcarray$sd
S 9294 8 1 0 0 6303 1 9284 53736 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstarray$sd
S 9298 23 5 0 0 0 9303 582 51092 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routerunf90ptri421d
S 9299 1 3 3 0 6117 1 9298 51405 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 route
S 9300 7 3 0 0 6306 1 9298 53624 90800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9304 0 0 0 0 0 0 0 0 srcarray
S 9301 7 3 0 0 6312 1 9298 53633 90800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9308 0 0 0 0 0 0 0 0 dstarray
S 9302 1 3 2 0 6 1 9298 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 9303 14 5 0 0 0 1 9298 51092 0 400000 0 0 0 2925 4 0 0 0 0 0 0 0 0 0 0 0 0 2055 0 582 0 0 0 0 esmf_routerunf90ptri421d
F 9303 4 9299 9300 9301 9302
S 9304 8 1 0 0 6309 1 9298 53786 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcarray$sd9
S 9308 8 1 0 0 6315 1 9298 53843 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstarray$sd13
S 9312 23 5 0 0 0 9317 582 51117 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routerunf90ptrr811d
S 9313 1 3 3 0 6117 1 9312 51405 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 route
S 9314 7 3 0 0 6318 1 9312 53624 90800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9318 0 0 0 0 0 0 0 0 srcarray
S 9315 7 3 0 0 6324 1 9312 53633 90800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9322 0 0 0 0 0 0 0 0 dstarray
S 9316 1 3 2 0 6 1 9312 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 9317 14 5 0 0 0 1 9312 51117 0 400000 0 0 0 2930 4 0 0 0 0 0 0 0 0 0 0 0 0 2129 0 582 0 0 0 0 esmf_routerunf90ptrr811d
F 9317 4 9313 9314 9315 9316
S 9318 8 1 0 0 6321 1 9312 53901 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcarray$sd17
S 9322 8 1 0 0 6327 1 9312 53959 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstarray$sd21
S 9326 23 5 0 0 0 9331 582 51142 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routerunf90ptrr821d
S 9327 1 3 3 0 6117 1 9326 51405 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 route
S 9328 7 3 0 0 6330 1 9326 53624 90800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9332 0 0 0 0 0 0 0 0 srcarray
S 9329 7 3 0 0 6336 1 9326 53633 90800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9336 0 0 0 0 0 0 0 0 dstarray
S 9330 1 3 2 0 6 1 9326 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 9331 14 5 0 0 0 1 9326 51142 0 400000 0 0 0 2935 4 0 0 0 0 0 0 0 0 0 0 0 0 2203 0 582 0 0 0 0 esmf_routerunf90ptrr821d
F 9331 4 9327 9328 9329 9330
S 9332 8 1 0 0 6333 1 9326 54017 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcarray$sd25
S 9336 8 1 0 0 6339 1 9326 54075 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstarray$sd29
S 9340 23 5 0 0 0 9345 582 51167 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routerunf90ptrr832d
S 9341 1 3 3 0 6117 1 9340 51405 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 route
S 9342 7 3 0 0 6342 1 9340 53624 90800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9346 0 0 0 0 0 0 0 0 srcarray
S 9343 7 3 0 0 6348 1 9340 53633 90800014 3014 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 9350 0 0 0 0 0 0 0 0 dstarray
S 9344 1 3 2 0 6 1 9340 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 9345 14 5 0 0 0 1 9340 51167 0 400000 0 0 0 2940 4 0 0 0 0 0 0 0 0 0 0 0 0 2278 0 582 0 0 0 0 esmf_routerunf90ptrr832d
F 9345 4 9341 9342 9343 9344
S 9346 8 1 0 0 6345 1 9340 54133 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcarray$sd33
S 9350 8 1 0 0 6351 1 9340 54191 40822014 1020 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstarray$sd37
S 9354 23 5 0 0 0 9362 582 51192 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_routevalidate
S 9355 1 3 3 0 6117 1 9354 51405 14 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 route
S 9356 1 3 1 0 6 1 9354 54249 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcbufcount
S 9357 7 3 1 0 6354 1 9354 54261 a0000014 10003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 srcbufsizes
S 9358 1 3 1 0 6 1 9354 54273 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstbufcount
S 9359 7 3 1 0 6357 1 9354 54285 a0000014 10003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 dstbufsizes
S 9360 1 3 1 0 28 1 9354 14301 80000014 43000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 options
S 9361 1 3 2 0 6 1 9354 11660 80000014 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 9362 14 5 0 0 0 1 9354 51192 20000000 400000 0 0 0 2945 7 0 0 0 0 0 0 0 0 0 0 0 0 2352 0 582 0 0 0 0 esmf_routevalidate
F 9362 7 9355 9356 9357 9358 9359 9360 9361
S 9363 6 1 0 0 6 1 9354 49351 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_0_4
S 9364 6 1 0 0 6 1 9354 49359 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_2_3
S 9365 6 1 0 0 6 1 9354 49367 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_3_2
S 9366 6 1 0 0 6 1 9354 54297 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_9892
S 9367 6 1 0 0 6 1 9354 49384 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_4_2
S 9368 6 1 0 0 6 1 9354 49392 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_6_2
S 9369 6 1 0 0 6 1 9354 49400 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_b_7_2
S 9370 6 1 0 0 6 1 9354 54306 40800016 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 z_e_9899
A 13 2 0 0 0 6 603 0 0 0 13 0 0 0 0 0 0 0 0 0
A 14 2 0 0 0 6 612 0 0 0 14 0 0 0 0 0 0 0 0 0
A 15 2 0 0 0 6 616 0 0 0 15 0 0 0 0 0 0 0 0 0
A 16 2 0 0 0 6 618 0 0 0 16 0 0 0 0 0 0 0 0 0
A 17 2 0 0 0 6 604 0 0 0 17 0 0 0 0 0 0 0 0 0
A 18 2 0 0 0 6 622 0 0 0 18 0 0 0 0 0 0 0 0 0
A 19 2 0 0 0 6 624 0 0 0 19 0 0 0 0 0 0 0 0 0
A 20 2 0 0 0 6 626 0 0 0 20 0 0 0 0 0 0 0 0 0
A 21 2 0 0 0 6 593 0 0 0 21 0 0 0 0 0 0 0 0 0
A 22 2 0 0 0 6 640 0 0 0 22 0 0 0 0 0 0 0 0 0
A 23 2 0 0 0 6 608 0 0 0 23 0 0 0 0 0 0 0 0 0
A 24 2 0 0 0 6 610 0 0 0 24 0 0 0 0 0 0 0 0 0
A 27 2 0 0 0 6 591 0 0 0 27 0 0 0 0 0 0 0 0 0
A 32 2 0 0 0 6 594 0 0 0 32 0 0 0 0 0 0 0 0 0
A 45 2 0 0 0 6 598 0 0 0 45 0 0 0 0 0 0 0 0 0
A 52 2 0 0 0 6 599 0 0 0 52 0 0 0 0 0 0 0 0 0
A 56 2 0 0 0 6 600 0 0 0 56 0 0 0 0 0 0 0 0 0
A 60 2 0 0 0 6 601 0 0 0 60 0 0 0 0 0 0 0 0 0
A 95 2 0 0 0 6 595 0 0 0 95 0 0 0 0 0 0 0 0 0
A 105 2 0 0 0 6 605 0 0 0 105 0 0 0 0 0 0 0 0 0
A 109 2 0 0 0 6 606 0 0 0 109 0 0 0 0 0 0 0 0 0
A 113 2 0 0 0 6 607 0 0 0 113 0 0 0 0 0 0 0 0 0
A 182 2 0 0 0 6 661 0 0 0 182 0 0 0 0 0 0 0 0 0
A 208 2 0 0 0 6 667 0 0 0 208 0 0 0 0 0 0 0 0 0
A 214 2 0 0 0 6 669 0 0 0 214 0 0 0 0 0 0 0 0 0
A 220 2 0 0 0 6 671 0 0 0 220 0 0 0 0 0 0 0 0 0
A 226 2 0 0 0 6 673 0 0 0 226 0 0 0 0 0 0 0 0 0
A 232 2 0 0 193 6 609 0 0 0 232 0 0 0 0 0 0 0 0 0
A 238 2 0 0 0 6 676 0 0 0 238 0 0 0 0 0 0 0 0 0
A 244 2 0 0 0 6 678 0 0 0 244 0 0 0 0 0 0 0 0 0
A 250 2 0 0 0 6 680 0 0 0 250 0 0 0 0 0 0 0 0 0
A 256 2 0 0 0 6 682 0 0 0 256 0 0 0 0 0 0 0 0 0
A 262 2 0 0 0 6 684 0 0 0 262 0 0 0 0 0 0 0 0 0
A 273 2 0 0 0 6 687 0 0 0 273 0 0 0 0 0 0 0 0 0
A 279 2 0 0 0 6 689 0 0 0 279 0 0 0 0 0 0 0 0 0
A 285 2 0 0 0 6 691 0 0 0 285 0 0 0 0 0 0 0 0 0
A 291 2 0 0 0 6 693 0 0 0 291 0 0 0 0 0 0 0 0 0
A 404 1 0 0 0 46 711 0 0 0 0 0 0 0 0 0 0 0 0 0
A 407 1 0 0 0 46 713 0 0 0 0 0 0 0 0 0 0 0 0 0
A 410 1 0 0 0 46 715 0 0 0 0 0 0 0 0 0 0 0 0 0
A 413 1 0 0 0 46 717 0 0 0 0 0 0 0 0 0 0 0 0 0
A 416 1 0 0 0 46 719 0 0 0 0 0 0 0 0 0 0 0 0 0
A 419 1 0 0 0 46 721 0 0 0 0 0 0 0 0 0 0 0 0 0
A 422 1 0 0 0 46 723 0 0 0 0 0 0 0 0 0 0 0 0 0
A 425 1 0 0 0 52 727 0 0 0 0 0 0 0 0 0 0 0 0 0
A 428 1 0 0 0 52 729 0 0 0 0 0 0 0 0 0 0 0 0 0
A 431 1 0 0 0 58 733 0 0 0 0 0 0 0 0 0 0 0 0 0
A 434 1 0 0 9 58 735 0 0 0 0 0 0 0 0 0 0 0 0 0
A 437 1 0 0 0 58 737 0 0 0 0 0 0 0 0 0 0 0 0 0
A 440 1 0 0 0 58 739 0 0 0 0 0 0 0 0 0 0 0 0 0
A 443 1 0 0 0 58 741 0 0 0 0 0 0 0 0 0 0 0 0 0
A 446 1 0 0 0 58 743 0 0 0 0 0 0 0 0 0 0 0 0 0
A 449 1 0 0 0 58 745 0 0 0 0 0 0 0 0 0 0 0 0 0
A 452 1 0 0 0 58 747 0 0 0 0 0 0 0 0 0 0 0 0 0
A 455 1 0 0 0 58 749 0 0 0 0 0 0 0 0 0 0 0 0 0
A 458 1 0 0 0 58 751 0 0 0 0 0 0 0 0 0 0 0 0 0
A 461 1 0 0 0 58 753 0 0 0 0 0 0 0 0 0 0 0 0 0
A 464 1 0 0 0 58 755 0 0 0 0 0 0 0 0 0 0 0 0 0
A 467 1 0 0 0 58 757 0 0 0 0 0 0 0 0 0 0 0 0 0
A 468 2 0 0 0 78 611 0 0 0 468 0 0 0 0 0 0 0 0 0
A 472 1 0 0 232 70 776 0 0 0 0 0 0 0 0 0 0 0 0 0
A 473 2 0 0 296 80 613 0 0 0 473 0 0 0 0 0 0 0 0 0
A 477 1 0 0 203 70 778 0 0 0 0 0 0 0 0 0 0 0 0 0
A 478 2 0 0 220 80 614 0 0 0 478 0 0 0 0 0 0 0 0 0
A 482 1 0 0 209 70 780 0 0 0 0 0 0 0 0 0 0 0 0 0
A 483 2 0 0 337 78 615 0 0 0 483 0 0 0 0 0 0 0 0 0
A 487 1 0 0 215 70 782 0 0 0 0 0 0 0 0 0 0 0 0 0
A 488 2 0 0 0 82 617 0 0 0 488 0 0 0 0 0 0 0 0 0
A 492 1 0 0 221 70 784 0 0 0 0 0 0 0 0 0 0 0 0 0
A 493 2 0 0 238 84 619 0 0 0 493 0 0 0 0 0 0 0 0 0
A 497 1 0 0 227 70 786 0 0 0 0 0 0 0 0 0 0 0 0 0
A 498 2 0 0 0 86 620 0 0 0 498 0 0 0 0 0 0 0 0 0
A 502 1 0 0 0 70 788 0 0 0 0 0 0 0 0 0 0 0 0 0
A 503 2 0 0 244 86 621 0 0 0 503 0 0 0 0 0 0 0 0 0
A 507 1 0 0 0 70 790 0 0 0 0 0 0 0 0 0 0 0 0 0
A 508 2 0 0 250 88 623 0 0 0 508 0 0 0 0 0 0 0 0 0
A 512 1 0 0 0 70 792 0 0 0 0 0 0 0 0 0 0 0 0 0
A 513 2 0 0 256 90 625 0 0 0 513 0 0 0 0 0 0 0 0 0
A 517 1 0 0 0 70 794 0 0 0 0 0 0 0 0 0 0 0 0 0
A 518 2 0 0 262 92 627 0 0 0 518 0 0 0 0 0 0 0 0 0
A 522 1 0 0 0 70 796 0 0 0 0 0 0 0 0 0 0 0 0 0
A 523 2 0 0 0 94 628 0 0 0 523 0 0 0 0 0 0 0 0 0
A 527 1 0 0 268 70 798 0 0 0 0 0 0 0 0 0 0 0 0 0
A 528 2 0 0 0 82 629 0 0 0 528 0 0 0 0 0 0 0 0 0
A 532 1 0 0 274 70 800 0 0 0 0 0 0 0 0 0 0 0 0 0
A 533 2 0 0 273 80 630 0 0 0 533 0 0 0 0 0 0 0 0 0
A 537 1 0 0 280 70 802 0 0 0 0 0 0 0 0 0 0 0 0 0
A 538 2 0 0 0 86 631 0 0 0 538 0 0 0 0 0 0 0 0 0
A 542 1 0 0 286 70 804 0 0 0 0 0 0 0 0 0 0 0 0 0
A 543 2 0 0 279 82 632 0 0 0 543 0 0 0 0 0 0 0 0 0
A 547 1 0 0 292 70 806 0 0 0 0 0 0 0 0 0 0 0 0 0
A 548 2 0 0 0 88 633 0 0 0 548 0 0 0 0 0 0 0 0 0
A 552 1 0 0 0 70 808 0 0 0 0 0 0 0 0 0 0 0 0 0
A 553 2 0 0 285 90 634 0 0 0 553 0 0 0 0 0 0 0 0 0
A 557 1 0 0 0 70 810 0 0 0 0 0 0 0 0 0 0 0 0 0
A 558 2 0 0 0 86 635 0 0 0 558 0 0 0 0 0 0 0 0 0
A 562 1 0 0 0 70 812 0 0 0 0 0 0 0 0 0 0 0 0 0
A 563 2 0 0 291 92 636 0 0 0 563 0 0 0 0 0 0 0 0 0
A 567 1 0 0 117 70 814 0 0 0 0 0 0 0 0 0 0 0 0 0
A 568 2 0 0 0 84 637 0 0 0 568 0 0 0 0 0 0 0 0 0
A 572 1 0 0 119 70 816 0 0 0 0 0 0 0 0 0 0 0 0 0
A 573 2 0 0 0 86 638 0 0 0 573 0 0 0 0 0 0 0 0 0
A 577 1 0 0 121 70 818 0 0 0 0 0 0 0 0 0 0 0 0 0
A 578 2 0 0 0 92 639 0 0 0 578 0 0 0 0 0 0 0 0 0
A 582 1 0 0 123 70 820 0 0 0 0 0 0 0 0 0 0 0 0 0
A 583 2 0 0 0 96 641 0 0 0 583 0 0 0 0 0 0 0 0 0
A 587 1 0 0 0 70 822 0 0 0 0 0 0 0 0 0 0 0 0 0
A 588 2 0 0 0 80 642 0 0 0 588 0 0 0 0 0 0 0 0 0
A 592 1 0 0 125 70 824 0 0 0 0 0 0 0 0 0 0 0 0 0
A 593 2 0 0 0 88 643 0 0 0 593 0 0 0 0 0 0 0 0 0
A 597 1 0 0 0 70 826 0 0 0 0 0 0 0 0 0 0 0 0 0
A 598 2 0 0 0 86 644 0 0 0 598 0 0 0 0 0 0 0 0 0
A 602 1 0 0 182 70 828 0 0 0 0 0 0 0 0 0 0 0 0 0
A 603 2 0 0 0 98 645 0 0 0 603 0 0 0 0 0 0 0 0 0
A 607 1 0 0 0 70 830 0 0 0 0 0 0 0 0 0 0 0 0 0
A 608 2 0 0 0 84 646 0 0 0 608 0 0 0 0 0 0 0 0 0
A 612 1 0 0 0 70 832 0 0 0 0 0 0 0 0 0 0 0 0 0
A 613 2 0 0 0 88 647 0 0 0 613 0 0 0 0 0 0 0 0 0
A 617 1 0 0 208 70 834 0 0 0 0 0 0 0 0 0 0 0 0 0
A 618 2 0 0 0 92 648 0 0 0 618 0 0 0 0 0 0 0 0 0
A 622 1 0 0 214 70 836 0 0 0 0 0 0 0 0 0 0 0 0 0
A 623 2 0 0 38 78 649 0 0 0 623 0 0 0 0 0 0 0 0 0
A 627 1 0 0 478 70 838 0 0 0 0 0 0 0 0 0 0 0 0 0
A 630 1 0 0 0 127 865 0 0 0 0 0 0 0 0 0 0 0 0 0
A 633 1 0 0 0 127 867 0 0 0 0 0 0 0 0 0 0 0 0 0
A 636 1 0 0 572 133 871 0 0 0 0 0 0 0 0 0 0 0 0 0
A 639 1 0 0 577 133 873 0 0 0 0 0 0 0 0 0 0 0 0 0
A 642 1 0 0 582 133 875 0 0 0 0 0 0 0 0 0 0 0 0 0
A 645 1 0 0 587 133 877 0 0 0 0 0 0 0 0 0 0 0 0 0
A 648 1 0 0 592 133 879 0 0 0 0 0 0 0 0 0 0 0 0 0
A 651 1 0 0 597 133 881 0 0 0 0 0 0 0 0 0 0 0 0 0
A 654 1 0 0 602 133 883 0 0 0 0 0 0 0 0 0 0 0 0 0
A 657 1 0 0 612 139 887 0 0 0 0 0 0 0 0 0 0 0 0 0
A 660 1 0 0 617 139 889 0 0 0 0 0 0 0 0 0 0 0 0 0
A 663 1 0 0 0 145 893 0 0 0 0 0 0 0 0 0 0 0 0 0
A 666 1 0 0 0 145 895 0 0 0 0 0 0 0 0 0 0 0 0 0
A 669 1 0 0 0 145 897 0 0 0 0 0 0 0 0 0 0 0 0 0
A 672 1 0 0 0 151 901 0 0 0 0 0 0 0 0 0 0 0 0 0
A 675 1 0 0 2 151 903 0 0 0 0 0 0 0 0 0 0 0 0 0
A 678 1 0 0 3 151 905 0 0 0 0 0 0 0 0 0 0 0 0 0
A 681 1 0 0 0 157 909 0 0 0 0 0 0 0 0 0 0 0 0 0
A 684 1 0 0 0 157 911 0 0 0 0 0 0 0 0 0 0 0 0 0
A 687 1 0 0 0 163 915 0 0 0 0 0 0 0 0 0 0 0 0 0
A 690 1 0 0 0 163 917 0 0 0 0 0 0 0 0 0 0 0 0 0
A 693 1 0 0 0 163 919 0 0 0 0 0 0 0 0 0 0 0 0 0
A 696 1 0 0 0 169 923 0 0 0 0 0 0 0 0 0 0 0 0 0
A 699 1 0 0 0 169 925 0 0 0 0 0 0 0 0 0 0 0 0 0
A 702 1 0 0 0 175 929 0 0 0 0 0 0 0 0 0 0 0 0 0
A 705 1 0 0 0 175 931 0 0 0 0 0 0 0 0 0 0 0 0 0
A 708 1 0 0 407 181 935 0 0 0 0 0 0 0 0 0 0 0 0 0
A 711 1 0 0 410 181 937 0 0 0 0 0 0 0 0 0 0 0 0 0
A 714 1 0 0 416 187 941 0 0 0 0 0 0 0 0 0 0 0 0 0
A 717 1 0 0 419 187 943 0 0 0 0 0 0 0 0 0 0 0 0 0
A 720 1 0 0 422 187 945 0 0 0 0 0 0 0 0 0 0 0 0 0
A 805 1 0 0 455 390 1191 0 0 0 0 0 0 0 0 0 0 0 0 0
A 808 1 0 0 458 390 1193 0 0 0 0 0 0 0 0 0 0 0 0 0
A 811 1 0 0 461 390 1195 0 0 0 0 0 0 0 0 0 0 0 0 0
A 814 1 0 0 467 396 1199 0 0 0 0 0 0 0 0 0 0 0 0 0
A 817 1 0 0 0 396 1201 0 0 0 0 0 0 0 0 0 0 0 0 0
A 820 1 0 0 0 396 1203 0 0 0 0 0 0 0 0 0 0 0 0 0
A 823 1 0 0 642 402 1207 0 0 0 0 0 0 0 0 0 0 0 0 0
A 826 1 0 0 645 402 1209 0 0 0 0 0 0 0 0 0 0 0 0 0
A 829 1 0 0 648 402 1211 0 0 0 0 0 0 0 0 0 0 0 0 0
A 862 2 0 0 0 6 1479 0 0 0 862 0 0 0 0 0 0 0 0 0
A 1608 1 0 0 1530 1536 2982 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1611 1 0 0 1138 1536 2984 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1658 1 0 0 1234 1791 3280 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1661 1 0 0 1571 1791 3282 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1664 1 0 0 1404 1791 3284 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1726 1 0 0 1240 1965 3347 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1729 1 0 0 1239 1965 3349 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1732 1 0 0 1406 1965 3351 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1735 1 0 0 1209 1971 3355 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1738 1 0 0 1214 1971 3357 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1741 1 0 0 1213 1971 3359 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1744 1 0 0 1218 1971 3361 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1747 1 0 0 1217 1971 3363 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1750 1 0 0 1222 1971 3365 0 0 0 0 0 0 0 0 0 0 0 0 0
A 1790 2 0 0 1462 6 3441 0 0 0 1790 0 0 0 0 0 0 0 0 0
A 7407 1 0 0 6940 2185 3458 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7410 1 0 0 6942 2185 3460 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7413 1 0 0 6946 2185 3462 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7416 1 0 0 6948 2185 3464 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7419 1 0 0 6950 2185 3466 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7422 1 0 0 5912 2191 3470 0 0 0 0 0 0 0 0 0 0 0 0 0
A 7425 1 0 0 5916 2191 3472 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9480 15 0 0 0 6 8911 3 0 0 0 0 0 0 0 0 0 0 0 0
A 9481 15 0 0 0 6123 8912 9480 0 0 0 0 0 0 0 0 0 0 0 0
A 9482 1 0 0 7436 6123 8913 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9483 15 0 0 0 6 8911 45 0 0 0 0 0 0 0 0 0 0 0 0
A 9484 15 0 0 0 6123 8914 9483 0 0 0 0 0 0 0 0 0 0 0 0
A 9485 1 0 0 8863 6123 8915 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9486 15 0 0 0 6 8911 52 0 0 0 0 0 0 0 0 0 0 0 0
A 9487 15 0 0 0 6123 8916 9486 0 0 0 0 0 0 0 0 0 0 0 0
A 9488 1 0 0 8517 6123 8917 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9489 15 0 0 0 6 8911 95 0 0 0 0 0 0 0 0 0 0 0 0
A 9490 15 0 0 0 6123 8918 9489 0 0 0 0 0 0 0 0 0 0 0 0
A 9491 1 0 0 7302 6123 8919 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9492 15 0 0 0 6 8911 20 0 0 0 0 0 0 0 0 0 0 0 0
A 9493 15 0 0 0 6123 8920 9492 0 0 0 0 0 0 0 0 0 0 0 0
A 9494 1 0 0 9354 6123 8921 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9495 15 0 0 0 6 8911 24 0 0 0 0 0 0 0 0 0 0 0 0
A 9496 15 0 0 0 6123 8922 9495 0 0 0 0 0 0 0 0 0 0 0 0
A 9497 1 0 0 9302 6123 8923 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9498 15 0 0 0 6 8911 862 0 0 0 0 0 0 0 0 0 0 0 0
A 9499 15 0 0 0 6123 8924 9498 0 0 0 0 0 0 0 0 0 0 0 0
A 9500 1 0 0 7867 6123 8925 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9501 2 0 0 9418 6 8927 0 0 0 9501 0 0 0 0 0 0 0 0 0
A 9502 15 0 0 0 6 8911 9501 0 0 0 0 0 0 0 0 0 0 0 0
A 9503 15 0 0 0 6123 8926 9502 0 0 0 0 0 0 0 0 0 0 0 0
A 9504 1 0 0 7317 6123 8928 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9505 2 0 0 9387 827 8957 0 0 0 9505 0 0 0 0 0 0 0 0 0
A 9507 1 0 3 7299 6138 9028 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9508 10 0 0 8927 6 9507 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9509 10 0 0 9508 6 9507 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9510 10 0 0 9509 6 9507 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9511 4 0 0 9459 6 9510 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9512 4 0 0 9389 6 9509 0 9511 0 0 0 0 1 0 0 0 0 0 0
A 9513 10 0 0 9510 6 9507 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9514 10 0 0 9513 6 9507 16 0 0 0 0 0 0 0 0 0 0 0 0
X 1 1790
A 9515 10 0 0 9514 6 9507 19 0 0 0 0 0 0 0 0 0 0 0 0
X 1 22
A 9516 4 0 0 7783 6 9515 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9517 4 0 0 6891 6 9514 0 9516 0 0 0 0 1 0 0 0 0 0 0
A 9518 10 0 0 9515 6 9507 22 0 0 0 0 0 0 0 0 0 0 0 0
X 1 220
A 9519 10 0 0 9518 6 9507 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9520 1 0 3 9374 6144 9032 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9521 10 0 0 8940 6 9520 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9522 10 0 0 9521 6 9520 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9523 10 0 0 9522 6 9520 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9524 4 0 0 9473 6 9523 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9525 4 0 0 6941 6 9522 0 9524 0 0 0 0 1 0 0 0 0 0 0
A 9526 10 0 0 9523 6 9520 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9527 10 0 0 9526 6 9520 16 0 0 0 0 0 0 0 0 0 0 0 0
X 1 1790
A 9528 10 0 0 9527 6 9520 19 0 0 0 0 0 0 0 0 0 0 0 0
X 1 22
A 9529 4 0 0 7450 6 9528 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9530 4 0 0 9076 6 9527 0 9529 0 0 0 0 1 0 0 0 0 0 0
A 9531 10 0 0 9528 6 9520 22 0 0 0 0 0 0 0 0 0 0 0 0
X 1 220
A 9532 10 0 0 9531 6 9520 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9533 1 0 0 9462 6 9040 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9534 1 0 0 9417 6 9036 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9535 1 0 0 9461 6 9041 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9536 1 0 0 9460 6 9038 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9537 1 0 0 9416 6 9037 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9538 1 0 0 9423 6 9042 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9539 1 0 0 9501 6 9039 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9540 1 0 0 9424 6 9045 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9541 1 0 0 9463 6 9043 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9542 1 0 0 9468 6 9046 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9543 1 0 0 9466 6 9044 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9544 1 0 1 9398 6159 9062 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9545 10 0 0 9541 6 9544 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9546 10 0 0 9545 6 9544 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9547 10 0 0 9546 6 9544 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9548 4 0 0 7407 6 9547 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9549 4 0 0 9429 6 9546 0 9548 0 0 0 0 1 0 0 0 0 0 0
A 9550 10 0 0 9547 6 9544 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9551 10 0 0 9550 6 9544 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9552 1 0 3 8616 6165 9066 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9553 10 0 0 9549 6 9552 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9554 10 0 0 9553 6 9552 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9555 10 0 0 9554 6 9552 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9556 4 0 0 8192 6 9555 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9557 4 0 0 9010 6 9554 0 9556 0 0 0 0 1 0 0 0 0 0 0
A 9558 10 0 0 9555 6 9552 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9559 10 0 0 9558 6 9552 16 0 0 0 0 0 0 0 0 0 0 0 0
X 1 1790
A 9560 10 0 0 9559 6 9552 19 0 0 0 0 0 0 0 0 0 0 0 0
X 1 22
A 9561 4 0 0 6149 6 9560 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9562 4 0 0 7813 6 9559 0 9561 0 0 0 0 1 0 0 0 0 0 0
A 9563 10 0 0 9560 6 9552 22 0 0 0 0 0 0 0 0 0 0 0 0
X 1 220
A 9564 10 0 0 9563 6 9552 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9565 1 0 1 9141 6171 9070 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9566 10 0 0 8473 6 9565 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9567 10 0 0 9566 6 9565 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9568 10 0 0 9567 6 9565 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9569 4 0 0 6953 6 9568 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9570 4 0 0 9187 6 9567 0 9569 0 0 0 0 1 0 0 0 0 0 0
A 9571 10 0 0 9568 6 9565 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9572 10 0 0 9571 6 9565 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9573 1 0 3 9137 6177 9074 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9574 10 0 0 8640 6 9573 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9575 10 0 0 9574 6 9573 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9576 10 0 0 9575 6 9573 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9577 4 0 0 8604 6 9576 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9578 4 0 0 9131 6 9575 0 9577 0 0 0 0 1 0 0 0 0 0 0
A 9579 10 0 0 9576 6 9573 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9580 10 0 0 9579 6 9573 16 0 0 0 0 0 0 0 0 0 0 0 0
X 1 1790
A 9581 10 0 0 9580 6 9573 19 0 0 0 0 0 0 0 0 0 0 0 0
X 1 22
A 9582 4 0 0 6974 6 9581 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9583 4 0 0 9497 6 9580 0 9582 0 0 0 0 1 0 0 0 0 0 0
A 9584 10 0 0 9581 6 9573 22 0 0 0 0 0 0 0 0 0 0 0 0
X 1 220
A 9585 10 0 0 9584 6 9573 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9586 1 0 3 9005 6183 9101 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9587 10 0 0 9147 6 9586 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9588 10 0 0 9587 6 9586 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9589 10 0 0 9588 6 9586 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9590 4 0 0 6986 6 9589 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9591 4 0 0 7935 6 9588 0 9590 0 0 0 0 1 0 0 0 0 0 0
A 9592 10 0 0 9589 6 9586 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9593 10 0 0 9592 6 9586 16 0 0 0 0 0 0 0 0 0 0 0 0
X 1 1790
A 9594 10 0 0 9593 6 9586 19 0 0 0 0 0 0 0 0 0 0 0 0
X 1 22
A 9595 4 0 0 6993 6 9594 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9596 4 0 0 7922 6 9593 0 9595 0 0 0 0 1 0 0 0 0 0 0
A 9597 10 0 0 9594 6 9586 22 0 0 0 0 0 0 0 0 0 0 0 0
X 1 220
A 9598 10 0 0 9597 6 9586 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9599 1 0 3 7483 6189 9105 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9600 10 0 0 6869 6 9599 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9601 10 0 0 9600 6 9599 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9602 10 0 0 9601 6 9599 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9603 4 0 0 9118 6 9602 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9604 4 0 0 6934 6 9601 0 9603 0 0 0 0 1 0 0 0 0 0 0
A 9605 10 0 0 9602 6 9599 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9606 10 0 0 9605 6 9599 16 0 0 0 0 0 0 0 0 0 0 0 0
X 1 1790
A 9607 10 0 0 9606 6 9599 19 0 0 0 0 0 0 0 0 0 0 0 0
X 1 22
A 9608 4 0 0 6467 6 9607 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9609 4 0 0 8835 6 9606 0 9608 0 0 0 0 1 0 0 0 0 0 0
A 9610 10 0 0 9607 6 9599 22 0 0 0 0 0 0 0 0 0 0 0 0
X 1 220
A 9611 10 0 0 9610 6 9599 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9612 1 0 0 9475 6 9111 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9613 1 0 0 9524 6 9109 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9614 1 0 0 9042 6 9112 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9615 1 0 0 8913 6 9110 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9616 1 0 0 9047 6 9117 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9617 1 0 0 9477 6 9113 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9618 1 0 0 7598 6 9118 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9619 1 0 0 6910 6 9115 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9620 1 0 0 9529 6 9114 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9621 1 0 0 8143 6 9119 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9622 1 0 0 9478 6 9116 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9623 1 0 3 8052 6204 9120 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9624 10 0 0 9052 6 9623 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9625 10 0 0 9624 6 9623 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9626 10 0 0 9625 6 9623 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9627 4 0 0 8621 6 9626 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9628 4 0 0 9296 6 9625 0 9627 0 0 0 0 1 0 0 0 0 0 0
A 9629 10 0 0 9626 6 9623 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9630 10 0 0 9629 6 9623 16 0 0 0 0 0 0 0 0 0 0 0 0
X 1 1790
A 9631 10 0 0 9630 6 9623 19 0 0 0 0 0 0 0 0 0 0 0 0
X 1 22
A 9632 4 0 0 8841 6 9631 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9633 4 0 0 9628 6 9630 0 9632 0 0 0 0 1 0 0 0 0 0 0
A 9634 10 0 0 9631 6 9623 22 0 0 0 0 0 0 0 0 0 0 0 0
X 1 220
A 9635 10 0 0 9634 6 9623 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9636 1 0 3 9225 6210 9124 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9637 10 0 0 9065 6 9636 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9638 10 0 0 9637 6 9636 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9639 10 0 0 9638 6 9636 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9640 4 0 0 8634 6 9639 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9641 4 0 0 9512 6 9638 0 9640 0 0 0 0 1 0 0 0 0 0 0
A 9642 10 0 0 9639 6 9636 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9643 10 0 0 9642 6 9636 16 0 0 0 0 0 0 0 0 0 0 0 0
X 1 1790
A 9644 10 0 0 9643 6 9636 19 0 0 0 0 0 0 0 0 0 0 0 0
X 1 22
A 9645 4 0 0 8639 6 9644 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9646 4 0 0 9534 6 9643 0 9645 0 0 0 0 1 0 0 0 0 0 0
A 9647 10 0 0 9644 6 9636 22 0 0 0 0 0 0 0 0 0 0 0 0
X 1 220
A 9648 10 0 0 9647 6 9636 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9649 1 0 0 8539 6 9130 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9650 1 0 0 8103 6 9128 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9651 1 0 0 6936 6 9131 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9652 1 0 0 9604 6 9129 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9653 1 0 0 6943 6 9136 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9654 1 0 0 9020 6 9132 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9655 1 0 0 8784 6 9137 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9656 1 0 0 9525 6 9134 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9657 1 0 0 9548 6 9133 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9658 1 0 0 7886 6 9138 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9659 1 0 0 9648 6 9135 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9660 1 0 3 9174 6225 9158 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9661 10 0 0 6960 6 9660 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9662 10 0 0 9661 6 9660 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9663 10 0 0 9662 6 9660 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9664 4 0 0 9179 6 9663 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9665 4 0 0 7738 6 9662 0 9664 0 0 0 0 1 0 0 0 0 0 0
A 9666 10 0 0 9663 6 9660 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9667 10 0 0 9666 6 9660 16 0 0 0 0 0 0 0 0 0 0 0 0
X 1 1790
A 9668 10 0 0 9667 6 9660 19 0 0 0 0 0 0 0 0 0 0 0 0
X 1 22
A 9669 4 0 0 9184 6 9668 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9670 4 0 0 9359 6 9667 0 9669 0 0 0 0 1 0 0 0 0 0 0
A 9671 10 0 0 9668 6 9660 22 0 0 0 0 0 0 0 0 0 0 0 0
X 1 220
A 9672 10 0 0 9671 6 9660 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9673 1 0 0 9432 6 9164 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9674 1 0 0 9577 6 9162 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9675 1 0 0 8701 6 9165 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9676 1 0 0 9093 6 9163 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9677 1 0 0 9071 6 9170 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9678 1 0 0 9289 6 9166 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9679 1 0 0 8580 6 9171 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9680 1 0 0 9098 6 9168 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9681 1 0 0 9582 6 9167 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9682 1 0 0 9251 6 9172 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9683 1 0 0 6978 6 9169 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9684 1 0 3 9517 6240 9173 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9685 10 0 0 9113 6 9684 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9686 10 0 0 9685 6 9684 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9687 10 0 0 9686 6 9684 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9688 4 0 0 8682 6 9687 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9689 4 0 0 9405 6 9686 0 9688 0 0 0 0 1 0 0 0 0 0 0
A 9690 10 0 0 9687 6 9684 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9691 10 0 0 9690 6 9684 16 0 0 0 0 0 0 0 0 0 0 0 0
X 1 1790
A 9692 10 0 0 9691 6 9684 19 0 0 0 0 0 0 0 0 0 0 0 0
X 1 22
A 9693 4 0 0 8687 6 9692 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9694 4 0 0 9598 6 9691 0 9693 0 0 0 0 1 0 0 0 0 0 0
A 9695 10 0 0 9692 6 9684 22 0 0 0 0 0 0 0 0 0 0 0 0
X 1 220
A 9696 10 0 0 9695 6 9684 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9697 1 0 0 6992 6 9179 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9698 1 0 0 6990 6 9177 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9699 1 0 0 9595 6 9180 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9700 1 0 0 9108 6 9178 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9701 1 0 0 8974 6 9185 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9702 1 0 0 9221 6 9181 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9703 1 0 0 9259 6 9186 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9704 1 0 0 9696 6 9183 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9705 1 0 0 9109 6 9182 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9706 1 0 0 6456 6 9187 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9707 1 0 0 9160 6 9184 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9708 1 0 3 9154 6255 9207 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9709 10 0 0 9552 6 9708 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9710 10 0 0 9709 6 9708 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9711 10 0 0 9710 6 9708 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9712 4 0 0 8715 6 9711 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9713 4 0 0 7003 6 9710 0 9712 0 0 0 0 1 0 0 0 0 0 0
A 9714 10 0 0 9711 6 9708 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9715 10 0 0 9714 6 9708 16 0 0 0 0 0 0 0 0 0 0 0 0
X 1 1790
A 9716 10 0 0 9715 6 9708 19 0 0 0 0 0 0 0 0 0 0 0 0
X 1 22
A 9717 4 0 0 8720 6 9716 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9718 4 0 0 9089 6 9715 0 9717 0 0 0 0 1 0 0 0 0 0 0
A 9719 10 0 0 9716 6 9708 22 0 0 0 0 0 0 0 0 0 0 0 0
X 1 220
A 9720 10 0 0 9719 6 9708 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9721 1 0 3 6811 6261 9211 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9722 10 0 0 8706 6 9721 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9723 10 0 0 9722 6 9721 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9724 10 0 0 9723 6 9721 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9725 4 0 0 8867 6 9724 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9726 4 0 0 8894 6 9723 0 9725 0 0 0 0 1 0 0 0 0 0 0
A 9727 10 0 0 9724 6 9721 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9728 10 0 0 9727 6 9721 16 0 0 0 0 0 0 0 0 0 0 0 0
X 1 1790
A 9729 10 0 0 9728 6 9721 19 0 0 0 0 0 0 0 0 0 0 0 0
X 1 22
A 9730 4 0 0 9388 6 9729 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9731 4 0 0 9572 6 9728 0 9730 0 0 0 0 1 0 0 0 0 0 0
A 9732 10 0 0 9729 6 9721 22 0 0 0 0 0 0 0 0 0 0 0 0
X 1 220
A 9733 10 0 0 9732 6 9721 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9734 1 0 0 9119 6 9219 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9735 1 0 0 7030 6 9215 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9736 1 0 0 9733 6 9220 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9737 1 0 0 9632 6 9217 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9738 1 0 0 9146 6 9216 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9739 1 0 0 9151 6 9221 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9740 1 0 0 8242 6 9218 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9741 1 0 3 9268 6273 9222 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9742 10 0 0 8649 6 9741 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9743 10 0 0 9742 6 9741 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9744 10 0 0 9743 6 9741 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9745 4 0 0 9404 6 9744 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9746 4 0 0 9506 6 9743 0 9745 0 0 0 0 1 0 0 0 0 0 0
A 9747 10 0 0 9744 6 9741 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9748 10 0 0 9747 6 9741 16 0 0 0 0 0 0 0 0 0 0 0 0
X 1 1790
A 9749 10 0 0 9748 6 9741 19 0 0 0 0 0 0 0 0 0 0 0 0
X 1 22
A 9750 4 0 0 6602 6 9749 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9751 4 0 0 9658 6 9748 0 9750 0 0 0 0 1 0 0 0 0 0 0
A 9752 10 0 0 9749 6 9741 22 0 0 0 0 0 0 0 0 0 0 0 0
X 1 220
A 9753 10 0 0 9752 6 9741 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9754 1 0 3 7519 6279 9226 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9755 10 0 0 8662 6 9754 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9756 10 0 0 9755 6 9754 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9757 10 0 0 9756 6 9754 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9758 4 0 0 9155 6 9757 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9759 4 0 0 9705 6 9756 0 9758 0 0 0 0 1 0 0 0 0 0 0
A 9760 10 0 0 9757 6 9754 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9761 10 0 0 9760 6 9754 16 0 0 0 0 0 0 0 0 0 0 0 0
X 1 1790
A 9762 10 0 0 9761 6 9754 19 0 0 0 0 0 0 0 0 0 0 0 0
X 1 22
A 9763 4 0 0 8757 6 9762 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9764 4 0 0 7020 6 9761 0 9763 0 0 0 0 1 0 0 0 0 0 0
A 9765 10 0 0 9762 6 9754 22 0 0 0 0 0 0 0 0 0 0 0 0
X 1 220
A 9766 10 0 0 9765 6 9754 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9767 1 0 0 9164 6 9234 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9768 1 0 0 9645 6 9230 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9769 1 0 0 9269 6 9235 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9770 1 0 0 6508 6 9232 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9771 1 0 0 6507 6 9231 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9772 1 0 0 7845 6 9236 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9773 1 0 0 6489 6 9233 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9774 1 0 0 9693 6 9278 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9775 1 0 0 6541 6 9276 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9776 1 0 0 8786 6 9279 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9777 1 0 0 9207 6 9277 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9778 1 0 0 9212 6 9282 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9779 1 0 0 8258 6 9280 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9780 1 0 0 9373 6 9283 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9781 1 0 0 8691 6 9281 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9782 1 0 1 9745 6297 9290 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9783 10 0 0 9781 6 9782 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9784 10 0 0 9783 6 9782 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9785 10 0 0 9784 6 9782 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9786 4 0 0 8108 6 9785 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9787 4 0 0 9014 6 9784 0 9786 0 0 0 0 1 0 0 0 0 0 0
A 9788 10 0 0 9785 6 9782 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9789 10 0 0 9788 6 9782 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9790 1 0 1 9122 6303 9294 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9791 10 0 0 9377 6 9790 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9792 10 0 0 9791 6 9790 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9793 10 0 0 9792 6 9790 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9794 4 0 0 9273 6 9793 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9795 4 0 0 9746 6 9792 0 9794 0 0 0 0 1 0 0 0 0 0 0
A 9796 10 0 0 9793 6 9790 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9797 10 0 0 9796 6 9790 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9798 1 0 3 9680 6309 9304 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9799 10 0 0 9712 6 9798 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9800 10 0 0 9799 6 9798 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9801 10 0 0 9800 6 9798 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9802 4 0 0 8796 6 9801 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9803 4 0 0 9504 6 9800 0 9802 0 0 0 0 1 0 0 0 0 0 0
A 9804 10 0 0 9801 6 9798 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9805 10 0 0 9804 6 9798 16 0 0 0 0 0 0 0 0 0 0 0 0
X 1 1790
A 9806 10 0 0 9805 6 9798 19 0 0 0 0 0 0 0 0 0 0 0 0
X 1 22
A 9807 4 0 0 8734 6 9806 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9808 4 0 0 8655 6 9805 0 9807 0 0 0 0 1 0 0 0 0 0 0
A 9809 10 0 0 9806 6 9798 22 0 0 0 0 0 0 0 0 0 0 0 0
X 1 220
A 9810 10 0 0 9809 6 9798 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9811 1 0 1 9682 6315 9308 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9812 10 0 0 9725 6 9811 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9813 10 0 0 9812 6 9811 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9814 10 0 0 9813 6 9811 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9815 4 0 0 8809 6 9814 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9816 4 0 0 9660 6 9813 0 9815 0 0 0 0 1 0 0 0 0 0 0
A 9817 10 0 0 9814 6 9811 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9818 10 0 0 9817 6 9811 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9819 1 0 1 6859 6321 9318 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9820 10 0 0 9399 6 9819 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9821 10 0 0 9820 6 9819 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9822 10 0 0 9821 6 9819 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9823 4 0 0 8817 6 9822 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9824 4 0 0 9375 6 9821 0 9823 0 0 0 0 1 0 0 0 0 0 0
A 9825 10 0 0 9822 6 9819 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9826 10 0 0 9825 6 9819 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9827 1 0 1 8864 6327 9322 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9828 10 0 0 9750 6 9827 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9829 10 0 0 9828 6 9827 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9830 10 0 0 9829 6 9827 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9831 4 0 0 9447 6 9830 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9832 4 0 0 9543 6 9829 0 9831 0 0 0 0 1 0 0 0 0 0 0
A 9833 10 0 0 9830 6 9827 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9834 10 0 0 9833 6 9827 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9835 1 0 3 9787 6333 9332 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9836 10 0 0 9758 6 9835 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9837 10 0 0 9836 6 9835 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9838 10 0 0 9837 6 9835 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9839 4 0 0 9256 6 9838 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9840 4 0 0 9335 6 9837 0 9839 0 0 0 0 1 0 0 0 0 0 0
A 9841 10 0 0 9838 6 9835 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9842 10 0 0 9841 6 9835 16 0 0 0 0 0 0 0 0 0 0 0 0
X 1 1790
A 9843 10 0 0 9842 6 9835 19 0 0 0 0 0 0 0 0 0 0 0 0
X 1 22
A 9844 4 0 0 6826 6 9843 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9845 4 0 0 9288 6 9842 0 9844 0 0 0 0 1 0 0 0 0 0 0
A 9846 10 0 0 9843 6 9835 22 0 0 0 0 0 0 0 0 0 0 0 0
X 1 220
A 9847 10 0 0 9846 6 9835 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9848 1 0 1 6695 6339 9336 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9849 10 0 0 9250 6 9848 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9850 10 0 0 9849 6 9848 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9851 10 0 0 9850 6 9848 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9852 4 0 0 9331 6 9851 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9853 4 0 0 7352 6 9850 0 9852 0 0 0 0 1 0 0 0 0 0 0
A 9854 10 0 0 9851 6 9848 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9855 10 0 0 9854 6 9848 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9856 1 0 5 8286 6345 9346 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9857 10 0 0 9152 6 9856 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9858 10 0 0 9857 6 9856 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9859 10 0 0 9858 6 9856 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9860 4 0 0 9339 6 9859 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9861 4 0 0 8760 6 9858 0 9860 0 0 0 0 1 0 0 0 0 0 0
A 9862 10 0 0 9859 6 9856 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9863 10 0 0 9862 6 9856 16 0 0 0 0 0 0 0 0 0 0 0 0
X 1 1790
A 9864 10 0 0 9863 6 9856 19 0 0 0 0 0 0 0 0 0 0 0 0
X 1 22
A 9865 4 0 0 9344 6 9864 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9866 4 0 0 9819 6 9863 0 9865 0 0 0 0 1 0 0 0 0 0 0
A 9867 10 0 0 9864 6 9856 22 0 0 0 0 0 0 0 0 0 0 0 0
X 1 220
A 9868 10 0 0 9867 6 9856 25 0 0 0 0 0 0 0 0 0 0 0 0
X 1 232
A 9869 10 0 0 9868 6 9856 28 0 0 0 0 0 0 0 0 0 0 0 0
X 1 238
A 9870 4 0 0 9349 6 9869 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9871 4 0 0 9381 6 9868 0 9870 0 0 0 0 1 0 0 0 0 0 0
A 9872 10 0 0 9869 6 9856 31 0 0 0 0 0 0 0 0 0 0 0 0
X 1 250
A 9873 10 0 0 9872 6 9856 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9874 1 0 3 7357 6351 9350 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9875 10 0 0 8791 6 9874 1 0 0 0 0 0 0 0 0 0 0 0 0
X 1 95
A 9876 10 0 0 9875 6 9874 4 0 0 0 0 0 0 0 0 0 0 0 0
X 1 15
A 9877 10 0 0 9876 6 9874 7 0 0 0 0 0 0 0 0 0 0 0 0
X 1 18
A 9878 4 0 0 8468 6 9877 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9879 4 0 0 9763 6 9876 0 9878 0 0 0 0 1 0 0 0 0 0 0
A 9880 10 0 0 9877 6 9874 10 0 0 0 0 0 0 0 0 0 0 0 0
X 1 16
A 9881 10 0 0 9880 6 9874 16 0 0 0 0 0 0 0 0 0 0 0 0
X 1 1790
A 9882 10 0 0 9881 6 9874 19 0 0 0 0 0 0 0 0 0 0 0 0
X 1 22
A 9883 4 0 0 9437 6 9882 0 3 0 0 0 0 2 0 0 0 0 0 0
A 9884 4 0 0 8761 6 9881 0 9883 0 0 0 0 1 0 0 0 0 0 0
A 9885 10 0 0 9882 6 9874 22 0 0 0 0 0 0 0 0 0 0 0 0
X 1 220
A 9886 10 0 0 9885 6 9874 13 0 0 0 0 0 0 0 0 0 0 0 0
X 1 21
A 9887 1 0 0 9741 6 9365 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9888 1 0 0 7767 6 9363 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9889 1 0 0 9332 6 9366 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9890 1 0 0 8415 6 9364 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9891 1 0 0 9754 6 9369 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9892 1 0 0 7779 6 9367 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9893 1 0 0 9794 6 9370 0 0 0 0 0 0 0 0 0 0 0 0 0
A 9894 1 0 0 8555 6 9368 0 0 0 0 0 0 0 0 0 0 0 0 0
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
V 1608 1536 7 0
S 0 1536 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 1611 1536 7 0
S 0 1536 0 0 0
A 0 6 0 0 1 45 0
J 68 1 1
V 1658 1791 7 0
S 0 1791 0 0 0
A 0 6 0 0 1 2 0
J 68 1 1
V 1661 1791 7 0
S 0 1791 0 0 0
A 0 6 0 0 1 3 0
J 68 1 1
V 1664 1791 7 0
S 0 1791 0 0 0
A 0 6 0 0 1 45 0
J 54 1 1
V 1726 1965 7 0
S 0 1965 0 0 0
A 0 6 0 0 1 2 0
J 54 1 1
V 1729 1965 7 0
S 0 1965 0 0 0
A 0 6 0 0 1 3 0
J 54 1 1
V 1732 1965 7 0
S 0 1965 0 0 0
A 0 6 0 0 1 45 0
J 66 1 1
V 1735 1971 7 0
S 0 1971 0 0 0
A 0 6 0 0 1 2 0
J 66 1 1
V 1738 1971 7 0
S 0 1971 0 0 0
A 0 6 0 0 1 3 0
J 66 1 1
V 1741 1971 7 0
S 0 1971 0 0 0
A 0 6 0 0 1 45 0
J 66 1 1
V 1744 1971 7 0
S 0 1971 0 0 0
A 0 6 0 0 1 32 0
J 66 1 1
V 1747 1971 7 0
S 0 1971 0 0 0
A 0 6 0 0 1 52 0
J 66 1 1
V 1750 1971 7 0
S 0 1971 0 0 0
A 0 6 0 0 1 56 0
J 77 1 1
V 7407 2185 7 0
S 0 2185 0 0 0
A 0 6 0 0 1 3 0
J 77 1 1
V 7410 2185 7 0
S 0 2185 0 0 0
A 0 6 0 0 1 45 0
J 77 1 1
V 7413 2185 7 0
S 0 2185 0 0 0
A 0 6 0 0 1 32 0
J 77 1 1
V 7416 2185 7 0
S 0 2185 0 0 0
A 0 6 0 0 1 52 0
J 77 1 1
V 7419 2185 7 0
S 0 2185 0 0 0
A 0 6 0 0 1 56 0
J 97 1 1
V 7422 2191 7 0
S 0 2191 0 0 0
A 0 6 0 0 1 3 0
J 97 1 1
V 7425 2191 7 0
S 0 2191 0 0 0
A 0 6 0 0 1 45 0
J 69 1 1
V 9482 6123 7 0
S 0 6123 0 0 0
A 0 6 0 0 1 3 0
J 71 1 1
V 9485 6123 7 0
S 0 6123 0 0 0
A 0 6 0 0 1 45 0
J 73 1 1
V 9488 6123 7 0
S 0 6123 0 0 0
A 0 6 0 0 1 52 0
J 75 1 1
V 9491 6123 7 0
S 0 6123 0 0 0
A 0 6 0 0 1 95 0
J 77 1 1
V 9494 6123 7 0
S 0 6123 0 0 0
A 0 6 0 0 1 20 0
J 79 1 1
V 9497 6123 7 0
S 0 6123 0 0 0
A 0 6 0 0 1 24 0
J 81 1 1
V 9500 6123 7 0
S 0 6123 0 0 0
A 0 6 0 0 1 862 0
J 83 1 1
V 9504 6123 7 0
S 0 6123 0 0 0
A 0 6 0 0 1 9501 0
Z
