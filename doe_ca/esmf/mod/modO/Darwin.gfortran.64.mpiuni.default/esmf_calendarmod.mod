GFORTRAN module version '3' created from /Users/dazlich/gfortran/esmf//src/Infrastructure/TimeMgr/interface/ESMF_Calendar.F90 on Tue Dec 22 13:09:16 2009
MD5:03e2808a68e7ffaedf0478c092b250c6 -- If you edit this, you'll get what you deserve.

(() () () () () () () () () () () () (2 3 4 5) (6 7 8 9) () () () ()
() () () () () () () () ())

()

(('esmf_calendarcreate' 'esmf_calendarmod' 10 11 12) (
'esmf_calendarisleapyear' 'esmf_calendarmod' 13 14) (
'esmf_calendarsetdefault' 'esmf_calendarmod' 15 16) ('esmf_calendarset'
'esmf_calendarmod' 17 18))

()

()

(19 'esmf_cal_360day' 'esmf_calendarmod' 'esmf_cal_360day' 1 ((
PARAMETER UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN IMPLICIT-SAVE 0) (DERIVED
20 0 0 DERIVED ()) 0 0 () (STRUCTURE (DERIVED 20 0 0 DERIVED ()) 0 (((
CONSTANT (INTEGER 4 0 0 INTEGER ()) 0 '5') ())) ()) () 0 () () () 0 0)
21 'esmf_cal_custom' 'esmf_calendarmod' 'esmf_cal_custom' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN IMPLICIT-SAVE 0) (DERIVED 20 0 0
DERIVED ()) 0 0 () (STRUCTURE (DERIVED 20 0 0 DERIVED ()) 0 (((CONSTANT
(INTEGER 4 0 0 INTEGER ()) 0 '6') ())) ()) () 0 () () () 0 0)
22 'esmf_cal_gregorian' 'esmf_calendarmod' 'esmf_cal_gregorian' 1 ((
PARAMETER UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN IMPLICIT-SAVE 0) (DERIVED
20 0 0 DERIVED ()) 0 0 () (STRUCTURE (DERIVED 20 0 0 DERIVED ()) 0 (((
CONSTANT (INTEGER 4 0 0 INTEGER ()) 0 '1') ())) ()) () 0 () () () 0 0)
23 'esmf_cal_julian' 'esmf_calendarmod' 'esmf_cal_julian' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN IMPLICIT-SAVE 0) (DERIVED 20 0 0
DERIVED ()) 0 0 () (STRUCTURE (DERIVED 20 0 0 DERIVED ()) 0 (((CONSTANT
(INTEGER 4 0 0 INTEGER ()) 0 '2') ())) ()) () 0 () () () 0 0)
24 'esmf_cal_julianday' 'esmf_calendarmod' 'esmf_cal_julianday' 1 ((
PARAMETER UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN IMPLICIT-SAVE 0) (DERIVED
20 0 0 DERIVED ()) 0 0 () (STRUCTURE (DERIVED 20 0 0 DERIVED ()) 0 (((
CONSTANT (INTEGER 4 0 0 INTEGER ()) 0 '3') ())) ()) () 0 () () () 0 0)
25 'esmf_cal_nocalendar' 'esmf_calendarmod' 'esmf_cal_nocalendar' 1 ((
PARAMETER UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN IMPLICIT-SAVE 0) (DERIVED
20 0 0 DERIVED ()) 0 0 () (STRUCTURE (DERIVED 20 0 0 DERIVED ()) 0 (((
CONSTANT (INTEGER 4 0 0 INTEGER ()) 0 '7') ())) ()) () 0 () () () 0 0)
26 'esmf_cal_noleap' 'esmf_calendarmod' 'esmf_cal_noleap' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN IMPLICIT-SAVE 0) (DERIVED 20 0 0
DERIVED ()) 0 0 () (STRUCTURE (DERIVED 20 0 0 DERIVED ()) 0 (((CONSTANT
(INTEGER 4 0 0 INTEGER ()) 0 '4') ())) ()) () 0 () () () 0 0)
27 'esmf_calendar' 'esmf_calendarmod' 'esmf_calendar' 1 ((DERIVED
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN UNKNOWN 0 SEQUENCE PRIVATE_COMP) (
UNKNOWN 0 0 0 UNKNOWN ()) 0 0 () () 0 ((28 'this' (DERIVED 29 0 0
DERIVED ()) () (UNKNOWN-FL UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN UNKNOWN 0)
UNKNOWN-ACCESS ()) (30 'isinit' (INTEGER 8 0 0 INTEGER ()) () (
UNKNOWN-FL UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN UNKNOWN 0) UNKNOWN-ACCESS
(CONSTANT (INTEGER 4 0 0 INTEGER ()) 0 '76838410'))) PRIVATE (() () () ())
() 0 0)
31 'esmf_calendardestroy' 'esmf_calendarmod' 'esmf_calendardestroy' 1 (
(PROCEDURE UNKNOWN-INTENT MODULE-PROC DECL UNKNOWN 0 SUBROUTINE
ALWAYS_EXPLICIT) (UNKNOWN 0 0 0 UNKNOWN ()) 32 0 (33 34) () 0 () () () 0
0)
35 'esmf_calendarfinalize' 'esmf_calendarmod' 'esmf_calendarfinalize' 1
((PROCEDURE UNKNOWN-INTENT MODULE-PROC DECL UNKNOWN 0 SUBROUTINE
ALWAYS_EXPLICIT) (UNKNOWN 0 0 0 UNKNOWN ()) 36 0 (37) () 0 () () () 0 0)
38 'esmf_calendarget' 'esmf_calendarmod' 'esmf_calendarget' 1 ((
PROCEDURE UNKNOWN-INTENT MODULE-PROC DECL UNKNOWN 0 SUBROUTINE
ALWAYS_EXPLICIT) (UNKNOWN 0 0 0 UNKNOWN ()) 39 0 (40 41 42 43 44 45 46
47 48 49 50) () 0 () () () 0 0)
51 'esmf_calendargetinit' 'esmf_calendarmod' 'esmf_calendargetinit' 1 (
(PROCEDURE UNKNOWN-INTENT MODULE-PROC DECL UNKNOWN 0 FUNCTION
ALWAYS_EXPLICIT) (INTEGER 8 0 0 INTEGER ()) 52 0 (53) () 51 () () () 0 0)
54 'esmf_calendarinitialize' 'esmf_calendarmod' 'esmf_calendarinitialize'
1 ((PROCEDURE UNKNOWN-INTENT MODULE-PROC DECL UNKNOWN 0 SUBROUTINE
ALWAYS_EXPLICIT) (UNKNOWN 0 0 0 UNKNOWN ()) 55 0 (56 57) () 0 () () () 0
0)
58 'esmf_calendarprint' 'esmf_calendarmod' 'esmf_calendarprint' 1 ((
PROCEDURE UNKNOWN-INTENT MODULE-PROC DECL UNKNOWN 0 SUBROUTINE
ALWAYS_EXPLICIT) (UNKNOWN 0 0 0 UNKNOWN ()) 59 0 (60 61 62) () 0 () () ()
0 0)
63 'esmf_calendarreadrestart' 'esmf_calendarmod'
'esmf_calendarreadrestart' 1 ((PROCEDURE UNKNOWN-INTENT MODULE-PROC DECL
UNKNOWN 0 FUNCTION ALWAYS_EXPLICIT) (DERIVED 27 0 0 DERIVED ()) 64 0 (
65 66 67) () 63 () () () 0 0)
68 'esmf_calendarsetinitcreated' 'esmf_calendarmod'
'esmf_calendarsetinitcreated' 1 ((PROCEDURE UNKNOWN-INTENT MODULE-PROC
DECL UNKNOWN 0 SUBROUTINE ALWAYS_EXPLICIT) (UNKNOWN 0 0 0 UNKNOWN ()) 69
0 (70 71) () 0 () () () 0 0)
20 'esmf_calendartype' 'esmf_calendarmod' 'esmf_calendartype' 1 ((
DERIVED UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN UNKNOWN 0 SEQUENCE
PRIVATE_COMP) (UNKNOWN 0 0 0 UNKNOWN ()) 0 0 () () 0 ((72 'calendartype'
(INTEGER 4 0 0 INTEGER ()) () (UNKNOWN-FL UNKNOWN-INTENT UNKNOWN-PROC
UNKNOWN UNKNOWN 0) UNKNOWN-ACCESS ())) PRIVATE (() () () ()) () 0 0)
73 'esmf_calendarvalidate' 'esmf_calendarmod' 'esmf_calendarvalidate' 1
((PROCEDURE UNKNOWN-INTENT MODULE-PROC DECL UNKNOWN 0 SUBROUTINE
ALWAYS_EXPLICIT) (UNKNOWN 0 0 0 UNKNOWN ()) 74 0 (75 76 77) () 0 () () ()
0 0)
78 'esmf_calendarwriterestart' 'esmf_calendarmod'
'esmf_calendarwriterestart' 1 ((PROCEDURE UNKNOWN-INTENT MODULE-PROC
DECL UNKNOWN 0 SUBROUTINE ALWAYS_EXPLICIT) (UNKNOWN 0 0 0 UNKNOWN ()) 79
0 (80 81 82) () 0 () () () 0 0)
83 'months_per_year' 'esmf_calendarmod' 'months_per_year' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN IMPLICIT-SAVE 0) (INTEGER 4 0 0
INTEGER ()) 0 0 () (CONSTANT (INTEGER 4 0 0 INTEGER ()) 0 '12') () 0 ()
() () 0 0)
29 'esmf_pointer' 'esmf_utiltypesmod' 'esmf_pointer' 1 ((DERIVED
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN UNKNOWN 0 SEQUENCE) (UNKNOWN 0 0 0
UNKNOWN ()) 0 0 () () 0 ((84 'ptr' (INTEGER 8 0 0 INTEGER ()) () (
UNKNOWN-FL UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN UNKNOWN 0) UNKNOWN-ACCESS
())) PUBLIC (() () () ()) () 0 0)
5 'esmf_calendareq' 'esmf_calendarmod' 'esmf_calendareq' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL UNKNOWN 0 FUNCTION) (LOGICAL 4 0 0
LOGICAL ()) 85 0 (86 87) () 5 () () () 0 0)
9 'esmf_calendarne' 'esmf_calendarmod' 'esmf_calendarne' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL UNKNOWN 0 FUNCTION) (LOGICAL 4 0 0
LOGICAL ()) 88 0 (89 90) () 9 () () () 0 0)
4 'esmf_calendartypeeq' 'esmf_calendarmod' 'esmf_calendartypeeq' 1 ((
PROCEDURE UNKNOWN-INTENT MODULE-PROC DECL UNKNOWN 0 FUNCTION) (LOGICAL 4
0 0 LOGICAL ()) 91 0 (92 93) () 4 () () () 0 0)
8 'esmf_calendartypene' 'esmf_calendarmod' 'esmf_calendartypene' 1 ((
PROCEDURE UNKNOWN-INTENT MODULE-PROC DECL UNKNOWN 0 FUNCTION) (LOGICAL 4
0 0 LOGICAL ()) 94 0 (95 96) () 8 () () () 0 0)
3 'esmf_calendarcalandtypeeq' 'esmf_calendarmod'
'esmf_calendarcalandtypeeq' 1 ((PROCEDURE UNKNOWN-INTENT MODULE-PROC
DECL UNKNOWN 0 FUNCTION) (LOGICAL 4 0 0 LOGICAL ()) 97 0 (98 99) () 3 ()
() () 0 0)
7 'esmf_calendarcalandtypene' 'esmf_calendarmod'
'esmf_calendarcalandtypene' 1 ((PROCEDURE UNKNOWN-INTENT MODULE-PROC
DECL UNKNOWN 0 FUNCTION) (LOGICAL 4 0 0 LOGICAL ()) 100 0 (101 102) () 7
() () () 0 0)
2 'esmf_calendartypeandcaleq' 'esmf_calendarmod'
'esmf_calendartypeandcaleq' 1 ((PROCEDURE UNKNOWN-INTENT MODULE-PROC
DECL UNKNOWN 0 FUNCTION) (LOGICAL 4 0 0 LOGICAL ()) 103 0 (104 105) () 2
() () () 0 0)
6 'esmf_calendartypeandcalne' 'esmf_calendarmod'
'esmf_calendartypeandcalne' 1 ((PROCEDURE UNKNOWN-INTENT MODULE-PROC
DECL UNKNOWN 0 FUNCTION) (LOGICAL 4 0 0 LOGICAL ()) 106 0 (107 108) () 6
() () () 0 0)
12 'esmf_calendarcreatebuiltin' 'esmf_calendarmod'
'esmf_calendarcreatebuiltin' 1 ((PROCEDURE UNKNOWN-INTENT MODULE-PROC
DECL UNKNOWN 0 FUNCTION ALWAYS_EXPLICIT) (DERIVED 27 0 0 DERIVED ()) 109
0 (110 111 112) () 12 () () () 0 0)
11 'esmf_calendarcreatecopy' 'esmf_calendarmod' 'esmf_calendarcreatecopy'
1 ((PROCEDURE UNKNOWN-INTENT MODULE-PROC DECL UNKNOWN 0 FUNCTION
ALWAYS_EXPLICIT) (DERIVED 27 0 0 DERIVED ()) 113 0 (114 115) () 11 () ()
() 0 0)
10 'esmf_calendarcreatecustom' 'esmf_calendarmod'
'esmf_calendarcreatecustom' 1 ((PROCEDURE UNKNOWN-INTENT MODULE-PROC
DECL UNKNOWN 0 FUNCTION ALWAYS_EXPLICIT) (DERIVED 27 0 0 DERIVED ()) 116
0 (117 118 119 120 121 122 123) () 10 () () () 0 0)
14 'esmf_calendarisleapyeari4' 'esmf_calendarmod'
'esmf_calendarisleapyeari4' 1 ((PROCEDURE UNKNOWN-INTENT MODULE-PROC
DECL UNKNOWN 0 FUNCTION ALWAYS_EXPLICIT) (LOGICAL 4 0 0 LOGICAL ()) 124
0 (125 126 127) () 14 () () () 0 0)
13 'esmf_calendarisleapyeari8' 'esmf_calendarmod'
'esmf_calendarisleapyeari8' 1 ((PROCEDURE UNKNOWN-INTENT MODULE-PROC
DECL UNKNOWN 0 FUNCTION ALWAYS_EXPLICIT) (LOGICAL 4 0 0 LOGICAL ()) 128
0 (129 130 131) () 13 () () () 0 0)
18 'esmf_calendarsetbuiltin' 'esmf_calendarmod' 'esmf_calendarsetbuiltin'
1 ((PROCEDURE UNKNOWN-INTENT MODULE-PROC DECL UNKNOWN 0 SUBROUTINE
ALWAYS_EXPLICIT) (UNKNOWN 0 0 0 UNKNOWN ()) 132 0 (133 134 135 136) () 0
() () () 0 0)
17 'esmf_calendarsetcustom' 'esmf_calendarmod' 'esmf_calendarsetcustom'
1 ((PROCEDURE UNKNOWN-INTENT MODULE-PROC DECL UNKNOWN 0 SUBROUTINE
ALWAYS_EXPLICIT) (UNKNOWN 0 0 0 UNKNOWN ()) 137 0 (138 139 140 141 142
143 144 145) () 0 () () () 0 0)
16 'esmf_calendarsetdefaulttype' 'esmf_calendarmod'
'esmf_calendarsetdefaulttype' 1 ((PROCEDURE UNKNOWN-INTENT MODULE-PROC
DECL UNKNOWN 0 SUBROUTINE ALWAYS_EXPLICIT) (UNKNOWN 0 0 0 UNKNOWN ())
146 0 (147 148) () 0 () () () 0 0)
15 'esmf_calendarsetdefaultcal' 'esmf_calendarmod'
'esmf_calendarsetdefaultcal' 1 ((PROCEDURE UNKNOWN-INTENT MODULE-PROC
DECL UNKNOWN 0 SUBROUTINE ALWAYS_EXPLICIT) (UNKNOWN 0 0 0 UNKNOWN ())
149 0 (150 151) () 0 () () () 0 0)
53 'd' '' 'd' 52 ((VARIABLE IN UNKNOWN-PROC UNKNOWN UNKNOWN 0 OPTIONAL
DUMMY) (DERIVED 27 0 0 DERIVED ()) 0 0 () () 0 () () () 0 0)
70 'c' '' 'c' 69 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN UNKNOWN 0 DUMMY)
(DERIVED 27 0 0 DERIVED ()) 0 0 () () 0 () () () 0 0)
71 'rc' '' 'rc' 69 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0 () () () 0 0)
110 'name' '' 'name' 109 ((VARIABLE IN UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (CHARACTER 1 0 0 CHARACTER (())) 0 0 () () 0 () () () 0
0)
111 'calendartype' '' 'calendartype' 109 ((VARIABLE IN UNKNOWN-PROC
UNKNOWN UNKNOWN 0 DUMMY) (DERIVED 20 0 0 DERIVED ()) 0 0 () () 0 () () ()
0 0)
112 'rc' '' 'rc' 109 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0 () () () 0 0)
114 'calendar' '' 'calendar' 113 ((VARIABLE IN UNKNOWN-PROC UNKNOWN
UNKNOWN 0 DUMMY) (DERIVED 27 0 0 DERIVED ()) 0 0 () () 0 () () () 0 0)
115 'rc' '' 'rc' 113 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0 () () () 0 0)
117 'name' '' 'name' 116 ((VARIABLE IN UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (CHARACTER 1 0 0 CHARACTER (())) 0 0 () () 0 () () () 0
0)
118 'dayspermonth' '' 'dayspermonth' 116 ((VARIABLE IN UNKNOWN-PROC
UNKNOWN UNKNOWN 0 DIMENSION OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0
0 () (1 ASSUMED_SHAPE (CONSTANT (INTEGER 4 0 0 INTEGER ()) 0 '1') ()) 0
() () () 0 0)
119 'secondsperday' '' 'secondsperday' 116 ((VARIABLE IN UNKNOWN-PROC
UNKNOWN UNKNOWN 0 OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0
() () () 0 0)
44 'monthsperyear' '' 'monthsperyear' 39 ((VARIABLE OUT UNKNOWN-PROC
UNKNOWN UNKNOWN 0 OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0
() () () 0 0)
45 'secondsperday' '' 'secondsperday' 39 ((VARIABLE OUT UNKNOWN-PROC
UNKNOWN UNKNOWN 0 OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0
() () () 0 0)
46 'secondsperyear' '' 'secondsperyear' 39 ((VARIABLE OUT UNKNOWN-PROC
UNKNOWN UNKNOWN 0 OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0
() () () 0 0)
47 'daysperyear' '' 'daysperyear' 39 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN
UNKNOWN 0 OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0 () () ()
0 0)
48 'daysperyeardn' '' 'daysperyeardn' 39 ((VARIABLE OUT UNKNOWN-PROC
UNKNOWN UNKNOWN 0 OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0
() () () 0 0)
49 'daysperyeardd' '' 'daysperyeardd' 39 ((VARIABLE OUT UNKNOWN-PROC
UNKNOWN UNKNOWN 0 OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0
() () () 0 0)
50 'rc' '' 'rc' 39 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0 () () () 0 0)
56 'calendartype' '' 'calendartype' 55 ((VARIABLE IN UNKNOWN-PROC
UNKNOWN UNKNOWN 0 OPTIONAL DUMMY) (DERIVED 20 0 0 DERIVED ()) 0 0 () ()
0 () () () 0 0)
57 'rc' '' 'rc' 55 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0 () () () 0 0)
125 'calendar' '' 'calendar' 124 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN
UNKNOWN 0 DUMMY) (DERIVED 27 0 0 DERIVED ()) 0 0 () () 0 () () () 0 0)
126 'yy' '' 'yy' 124 ((VARIABLE IN UNKNOWN-PROC UNKNOWN UNKNOWN 0 DUMMY)
(INTEGER 4 0 0 INTEGER ()) 0 0 () () 0 () () () 0 0)
127 'rc' '' 'rc' 124 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0 () () () 0 0)
129 'calendar' '' 'calendar' 128 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN
UNKNOWN 0 DUMMY) (DERIVED 27 0 0 DERIVED ()) 0 0 () () 0 () () () 0 0)
130 'yy_i8' '' 'yy_i8' 128 ((VARIABLE IN UNKNOWN-PROC UNKNOWN UNKNOWN 0
DUMMY) (INTEGER 8 0 0 INTEGER ()) 0 0 () () 0 () () () 0 0)
120 'daysperyear' '' 'daysperyear' 116 ((VARIABLE IN UNKNOWN-PROC
UNKNOWN UNKNOWN 0 OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0
() () () 0 0)
121 'daysperyeardn' '' 'daysperyeardn' 116 ((VARIABLE IN UNKNOWN-PROC
UNKNOWN UNKNOWN 0 OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0
() () () 0 0)
122 'daysperyeardd' '' 'daysperyeardd' 116 ((VARIABLE IN UNKNOWN-PROC
UNKNOWN UNKNOWN 0 OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0
() () () 0 0)
123 'rc' '' 'rc' 116 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0 () () () 0 0)
33 'calendar' '' 'calendar' 32 ((VARIABLE UNKNOWN-INTENT UNKNOWN-PROC
UNKNOWN UNKNOWN 0 DUMMY) (DERIVED 27 0 0 DERIVED ()) 0 0 () () 0 () () ()
0 0)
34 'rc' '' 'rc' 32 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0 () () () 0 0)
37 'rc' '' 'rc' 36 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0 () () () 0 0)
40 'calendar' '' 'calendar' 39 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN
UNKNOWN 0 DUMMY) (DERIVED 27 0 0 DERIVED ()) 0 0 () () 0 () () () 0 0)
41 'name' '' 'name' 39 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (CHARACTER 1 0 0 CHARACTER (())) 0 0 () () 0 () () () 0
0)
42 'calendartype' '' 'calendartype' 39 ((VARIABLE OUT UNKNOWN-PROC
UNKNOWN UNKNOWN 0 OPTIONAL DUMMY) (DERIVED 20 0 0 DERIVED ()) 0 0 () ()
0 () () () 0 0)
43 'dayspermonth' '' 'dayspermonth' 39 ((VARIABLE OUT UNKNOWN-PROC
UNKNOWN UNKNOWN 0 DIMENSION OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0
0 () (1 ASSUMED_SHAPE (CONSTANT (INTEGER 4 0 0 INTEGER ()) 0 '1') ()) 0
() () () 0 0)
131 'rc' '' 'rc' 128 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0 () () () 0 0)
60 'calendar' '' 'calendar' 59 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN
UNKNOWN 0 DUMMY) (DERIVED 27 0 0 DERIVED ()) 0 0 () () 0 () () () 0 0)
61 'options' '' 'options' 59 ((VARIABLE IN UNKNOWN-PROC UNKNOWN UNKNOWN
0 OPTIONAL DUMMY) (CHARACTER 1 0 0 CHARACTER (())) 0 0 () () 0 () () ()
0 0)
62 'rc' '' 'rc' 59 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0 () () () 0 0)
65 'name' '' 'name' 64 ((VARIABLE IN UNKNOWN-PROC UNKNOWN UNKNOWN 0
DUMMY) (CHARACTER 1 0 0 CHARACTER (())) 0 0 () () 0 () () () 0 0)
66 'iospec' '' 'iospec' 64 ((VARIABLE IN UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (DERIVED 152 0 0 DERIVED ()) 0 0 () () 0 () () () 0 0)
67 'rc' '' 'rc' 64 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0 () () () 0 0)
133 'calendar' '' 'calendar' 132 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN
UNKNOWN 0 DUMMY) (DERIVED 27 0 0 DERIVED ()) 0 0 () () 0 () () () 0 0)
134 'name' '' 'name' 132 ((VARIABLE IN UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (CHARACTER 1 0 0 CHARACTER (())) 0 0 () () 0 () () () 0
0)
135 'calendartype' '' 'calendartype' 132 ((VARIABLE IN UNKNOWN-PROC
UNKNOWN UNKNOWN 0 DUMMY) (DERIVED 20 0 0 DERIVED ()) 0 0 () () 0 () () ()
0 0)
136 'rc' '' 'rc' 132 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0 () () () 0 0)
138 'calendar' '' 'calendar' 137 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN
UNKNOWN 0 DUMMY) (DERIVED 27 0 0 DERIVED ()) 0 0 () () 0 () () () 0 0)
139 'name' '' 'name' 137 ((VARIABLE IN UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (CHARACTER 1 0 0 CHARACTER (())) 0 0 () () 0 () () () 0
0)
140 'dayspermonth' '' 'dayspermonth' 137 ((VARIABLE IN UNKNOWN-PROC
UNKNOWN UNKNOWN 0 DIMENSION OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0
0 () (1 ASSUMED_SHAPE (CONSTANT (INTEGER 4 0 0 INTEGER ()) 0 '1') ()) 0
() () () 0 0)
141 'secondsperday' '' 'secondsperday' 137 ((VARIABLE IN UNKNOWN-PROC
UNKNOWN UNKNOWN 0 OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0
() () () 0 0)
142 'daysperyear' '' 'daysperyear' 137 ((VARIABLE IN UNKNOWN-PROC
UNKNOWN UNKNOWN 0 OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0
() () () 0 0)
143 'daysperyeardn' '' 'daysperyeardn' 137 ((VARIABLE IN UNKNOWN-PROC
UNKNOWN UNKNOWN 0 OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0
() () () 0 0)
144 'daysperyeardd' '' 'daysperyeardd' 137 ((VARIABLE IN UNKNOWN-PROC
UNKNOWN UNKNOWN 0 OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0
() () () 0 0)
145 'rc' '' 'rc' 137 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0 () () () 0 0)
147 'calendartype' '' 'calendartype' 146 ((VARIABLE IN UNKNOWN-PROC
UNKNOWN UNKNOWN 0 DUMMY) (DERIVED 20 0 0 DERIVED ()) 0 0 () () 0 () () ()
0 0)
148 'rc' '' 'rc' 146 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0 () () () 0 0)
150 'calendar' '' 'calendar' 149 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN
UNKNOWN 0 DUMMY) (DERIVED 27 0 0 DERIVED ()) 0 0 () () 0 () () () 0 0)
151 'rc' '' 'rc' 149 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0 () () () 0 0)
75 'calendar' '' 'calendar' 74 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN
UNKNOWN 0 DUMMY) (DERIVED 27 0 0 DERIVED ()) 0 0 () () 0 () () () 0 0)
76 'options' '' 'options' 74 ((VARIABLE IN UNKNOWN-PROC UNKNOWN UNKNOWN
0 OPTIONAL DUMMY) (CHARACTER 1 0 0 CHARACTER (())) 0 0 () () 0 () () ()
0 0)
77 'rc' '' 'rc' 74 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0 () () () 0 0)
80 'calendar' '' 'calendar' 79 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN
UNKNOWN 0 DUMMY) (DERIVED 27 0 0 DERIVED ()) 0 0 () () 0 () () () 0 0)
81 'iospec' '' 'iospec' 79 ((VARIABLE IN UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (DERIVED 152 0 0 DERIVED ()) 0 0 () () 0 () () () 0 0)
82 'rc' '' 'rc' 79 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN UNKNOWN 0
OPTIONAL DUMMY) (INTEGER 4 0 0 INTEGER ()) 0 0 () () 0 () () () 0 0)
86 'calendar1' '' 'calendar1' 85 ((VARIABLE IN UNKNOWN-PROC UNKNOWN
UNKNOWN 0 DUMMY) (DERIVED 27 0 0 DERIVED ()) 0 0 () () 0 () () () 0 0)
87 'calendar2' '' 'calendar2' 85 ((VARIABLE IN UNKNOWN-PROC UNKNOWN
UNKNOWN 0 DUMMY) (DERIVED 27 0 0 DERIVED ()) 0 0 () () 0 () () () 0 0)
92 'calendartype1' '' 'calendartype1' 91 ((VARIABLE IN UNKNOWN-PROC
UNKNOWN UNKNOWN 0 DUMMY) (DERIVED 20 0 0 DERIVED ()) 0 0 () () 0 () () ()
0 0)
93 'calendartype2' '' 'calendartype2' 91 ((VARIABLE IN UNKNOWN-PROC
UNKNOWN UNKNOWN 0 DUMMY) (DERIVED 20 0 0 DERIVED ()) 0 0 () () 0 () () ()
0 0)
98 'calendar' '' 'calendar' 97 ((VARIABLE IN UNKNOWN-PROC UNKNOWN
UNKNOWN 0 DUMMY) (DERIVED 27 0 0 DERIVED ()) 0 0 () () 0 () () () 0 0)
99 'calendartype' '' 'calendartype' 97 ((VARIABLE IN UNKNOWN-PROC
UNKNOWN UNKNOWN 0 DUMMY) (DERIVED 20 0 0 DERIVED ()) 0 0 () () 0 () () ()
0 0)
104 'calendartype' '' 'calendartype' 103 ((VARIABLE IN UNKNOWN-PROC
UNKNOWN UNKNOWN 0 DUMMY) (DERIVED 20 0 0 DERIVED ()) 0 0 () () 0 () () ()
0 0)
105 'calendar' '' 'calendar' 103 ((VARIABLE IN UNKNOWN-PROC UNKNOWN
UNKNOWN 0 DUMMY) (DERIVED 27 0 0 DERIVED ()) 0 0 () () 0 () () () 0 0)
89 'calendar1' '' 'calendar1' 88 ((VARIABLE IN UNKNOWN-PROC UNKNOWN
UNKNOWN 0 DUMMY) (DERIVED 27 0 0 DERIVED ()) 0 0 () () 0 () () () 0 0)
90 'calendar2' '' 'calendar2' 88 ((VARIABLE IN UNKNOWN-PROC UNKNOWN
UNKNOWN 0 DUMMY) (DERIVED 27 0 0 DERIVED ()) 0 0 () () 0 () () () 0 0)
95 'calendartype1' '' 'calendartype1' 94 ((VARIABLE IN UNKNOWN-PROC
UNKNOWN UNKNOWN 0 DUMMY) (DERIVED 20 0 0 DERIVED ()) 0 0 () () 0 () () ()
0 0)
96 'calendartype2' '' 'calendartype2' 94 ((VARIABLE IN UNKNOWN-PROC
UNKNOWN UNKNOWN 0 DUMMY) (DERIVED 20 0 0 DERIVED ()) 0 0 () () 0 () () ()
0 0)
101 'calendar' '' 'calendar' 100 ((VARIABLE IN UNKNOWN-PROC UNKNOWN
UNKNOWN 0 DUMMY) (DERIVED 27 0 0 DERIVED ()) 0 0 () () 0 () () () 0 0)
102 'calendartype' '' 'calendartype' 100 ((VARIABLE IN UNKNOWN-PROC
UNKNOWN UNKNOWN 0 DUMMY) (DERIVED 20 0 0 DERIVED ()) 0 0 () () 0 () () ()
0 0)
107 'calendartype' '' 'calendartype' 106 ((VARIABLE IN UNKNOWN-PROC
UNKNOWN UNKNOWN 0 DUMMY) (DERIVED 20 0 0 DERIVED ()) 0 0 () () 0 () () ()
0 0)
108 'calendar' '' 'calendar' 106 ((VARIABLE IN UNKNOWN-PROC UNKNOWN
UNKNOWN 0 DUMMY) (DERIVED 27 0 0 DERIVED ()) 0 0 () () 0 () () () 0 0)
152 'esmf_iospec' 'esmf_iospecmod' 'esmf_iospec' 1 ((DERIVED
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN UNKNOWN 0 SEQUENCE PRIVATE_COMP) (
UNKNOWN 0 0 0 UNKNOWN ()) 0 0 () () 0 ((153 'iostatus' (DERIVED 154 0 0
DERIVED ()) () (UNKNOWN-FL UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN UNKNOWN 0)
UNKNOWN-ACCESS ()) (155 'iofileformat' (DERIVED 156 0 0 DERIVED ()) () (
UNKNOWN-FL UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN UNKNOWN 0) UNKNOWN-ACCESS
()) (157 'iorwtype' (DERIVED 158 0 0 DERIVED ()) () (UNKNOWN-FL
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN UNKNOWN 0) UNKNOWN-ACCESS ()) (159
'filename' (CHARACTER 1 0 0 CHARACTER ((CONSTANT (INTEGER 4 0 0 INTEGER
()) 0 '128'))) () (UNKNOWN-FL UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN
UNKNOWN 0) UNKNOWN-ACCESS ()) (160 'asyncio' (LOGICAL 4 0 0 LOGICAL ())
() (UNKNOWN-FL UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN UNKNOWN 0)
UNKNOWN-ACCESS ())) PRIVATE (() () () ()) () 0 0)
154 'esmf_status' 'esmf_utiltypesmod' 'esmf_status' 1 ((DERIVED
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN UNKNOWN 0 SEQUENCE PRIVATE_COMP) (
UNKNOWN 0 0 0 UNKNOWN ()) 0 0 () () 0 ((161 'status' (INTEGER 4 0 0
INTEGER ()) () (UNKNOWN-FL UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN UNKNOWN 0)
UNKNOWN-ACCESS ())) PRIVATE (() () () ()) () 0 0)
156 'esmf_iofileformat' 'esmf_iospecmod' 'esmf_iofileformat' 1 ((
DERIVED UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN UNKNOWN 0 SEQUENCE
PRIVATE_COMP) (UNKNOWN 0 0 0 UNKNOWN ()) 0 0 () () 0 ((162 'iofileformat'
(INTEGER 4 0 0 INTEGER ()) () (UNKNOWN-FL UNKNOWN-INTENT UNKNOWN-PROC
UNKNOWN UNKNOWN 0) UNKNOWN-ACCESS ())) PRIVATE (() () () ()) () 0 0)
158 'esmf_iorwtype' 'esmf_iospecmod' 'esmf_iorwtype' 1 ((DERIVED
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN UNKNOWN 0 SEQUENCE PRIVATE_COMP) (
UNKNOWN 0 0 0 UNKNOWN ()) 0 0 () () 0 ((163 'iorwtype' (INTEGER 4 0 0
INTEGER ()) () (UNKNOWN-FL UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN UNKNOWN 0)
UNKNOWN-ACCESS ())) PRIVATE (() () () ()) () 0 0)
)

('esmf_cal_360day' 0 19 'esmf_cal_custom' 0 21 'esmf_cal_gregorian' 0 22
'esmf_cal_julian' 0 23 'esmf_cal_julianday' 0 24 'esmf_cal_nocalendar' 0
25 'esmf_cal_noleap' 0 26 'esmf_calendar' 0 27 'esmf_calendardestroy' 0
31 'esmf_calendarfinalize' 0 35 'esmf_calendarget' 0 38
'esmf_calendargetinit' 0 51 'esmf_calendarinitialize' 0 54
'esmf_calendarprint' 0 58 'esmf_calendarreadrestart' 0 63
'esmf_calendarsetinitcreated' 0 68 'esmf_calendartype' 0 20
'esmf_calendarvalidate' 0 73 'esmf_calendarwriterestart' 0 78
'months_per_year' 0 83)
