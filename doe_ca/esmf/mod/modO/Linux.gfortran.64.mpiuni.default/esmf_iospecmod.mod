GFORTRAN module created from /Users/dazlich/doe_ca/esmf/src/Infrastructure/IOSpec/src/ESMF_IOSpec.F90 on Mon Sep 10 14:57:35 2012
If you edit this, you'll get what you deserve.

(() () () () () () ()
() () () () () (2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19) (20 21 22
23 24 25 26 27 28 29 30 31 32 33) () () () () () () ())

()

()

()

()

(34 'esmf_io_fileformat_hdf' 'esmf_iospecmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 35 ()) 0 0 () (STRUCTURE (
DERIVED 35 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '2') ())) ()) () 0 () ())
36 'esmf_io_fileformat_netcdf' 'esmf_iospecmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 35 ()) 0 0 () (STRUCTURE (
DERIVED 35 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '1') ())) ()) () 0 () ())
37 'esmf_io_rwtype_readonly' 'esmf_iospecmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 38 ()) 0 0 () (STRUCTURE (
DERIVED 38 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '1') ())) ()) () 0 () ())
39 'esmf_io_rwtype_truncate' 'esmf_iospecmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 38 ()) 0 0 () (STRUCTURE (
DERIVED 38 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '5') ())) ()) () 0 () ())
40 'esmf_io_rwtype_readwrite' 'esmf_iospecmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 38 ()) 0 0 () (STRUCTURE (
DERIVED 38 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '3') ())) ()) () 0 () ())
41 'esmf_io_rwtype_writeonly' 'esmf_iospecmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 38 ()) 0 0 () (STRUCTURE (
DERIVED 38 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '2') ())) ()) () 0 () ())
35 'esmf_iofileformat' 'esmf_iospecmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((42
'iofileformat' (INTEGER 4 ()) () 0 0 ())) PRIVATE ())
43 'esmf_io_rwtype_unspecified' 'esmf_iospecmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 38 ()) 0 0 () (STRUCTURE (
DERIVED 38 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '0') ())) ()) () 0 () ())
44 'esmf_io_rwtype_append' 'esmf_iospecmod' 1 ((PARAMETER UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (DERIVED 38 ()) 0 0 () (STRUCTURE (DERIVED 38 ())
0 (((CONSTANT (INTEGER 4 ()) 0 '4') ())) ()) () 0 () ())
45 'esmf_iospecget' 'esmf_iospecmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL SUBROUTINE ALWAYS_EXPLICIT) (UNKNOWN 0 ()) 46 0 (47 48
49 50 51 52) () 0 () ())
53 'esmf_iospec' 'esmf_iospecmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((54 'iostatus'
(DERIVED 55 ()) () 0 0 ()) (56 'iofileformat' (DERIVED 35 ()) () 0 0 ())
(57 'iorwtype' (DERIVED 38 ()) () 0 0 ()) (58 'filename' (CHARACTER 1 (
(CONSTANT (INTEGER 4 ()) 0 '128'))) () 0 0 ()) (59 'asyncio' (LOGICAL 4
()) () 0 0 ())) PRIVATE ())
38 'esmf_iorwtype' 'esmf_iospecmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((60 'iorwtype'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
61 'esmf_iostate' 'esmf_iospecmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((62 'nestlevel'
(INTEGER 4 ()) () 0 0 ()) (63 'filestate' (INTEGER 4 ()) () 0 0 ()) (64
'funit' (INTEGER 4 ()) () 0 0 ()) (65 'isopen' (LOGICAL 4 ()) () 0 0 ())
(66 'define_mode' (LOGICAL 4 ()) () 0 0 ()) (67 'singlefile' (LOGICAL 4
()) () 0 0 ()) (68 'parallel' (LOGICAL 4 ()) () 0 0 ()) (69 'using_mpiio'
(LOGICAL 4 ()) () 0 0 ())) PRIVATE ())
70 'esmf_iospecset' 'esmf_iospecmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL SUBROUTINE ALWAYS_EXPLICIT) (UNKNOWN 0 ()) 71 0 (72 73
74 75 76 77) () 0 () ())
78 'esmf_ioflush' 'esmf_iospecmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL SUBROUTINE ALWAYS_EXPLICIT) (UNKNOWN 0 ()) 79 0 (80 81)
() 0 () ())
82 'esmf_io_fileformat_unspecified' 'esmf_iospecmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 35 ()) 0 0 () (STRUCTURE (
DERIVED 35 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '0') ())) ()) () 0 () ())
50 'iorwtype' '' 46 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY)
(DERIVED 38 ()) 0 0 () () 0 () ())
77 'rc' '' 71 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
75 'iorwtype' '' 71 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
DERIVED 38 ()) 0 0 () () 0 () ())
51 'asyncio' '' 46 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
LOGICAL 4 ()) 0 0 () () 0 () ())
47 'iospec' '' 46 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 53
()) 0 0 () () 0 () ())
55 'esmf_status' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((83 'status'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
4 'esmf_rfeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 84 0 (85 86) () 4 () ())
81 'rc' '' 79 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
20 'esmf_iorwne' 'esmf_iospecmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 87 0 (88 89) () 20 () ())
7 'esmf_lgeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 90 0 (91 92) () 7 () ())
9 'esmf_tnfeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 93 0 (94 95) () 9 () ())
88 'iorw1' '' 87 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 38 ())
0 0 () () 0 () ())
49 'iofileformat' '' 46 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL
DUMMY) (DERIVED 35 ()) 0 0 () () 0 () ())
10 'esmf_ctfeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 96 0 (97 98) () 10 () ())
6 'esmf_dmeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 99 0 (100 101) () 6 () ())
8 'esmf_freq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 102 0 (103 104) () 8 () ())
15 'esmf_dkeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 105 0 (106 107) () 15 () ())
11 'esmf_bfeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 108 0 (109 110) () 11 () ())
12 'esmf_aieq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 111 0 (112 113) () 12 () ())
80 'unitnumber' '' 79 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
14 'esmf_pteq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 114 0 (115 116) () 14 () ())
26 'esmf_ctfne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 117 0 (118 119) () 26 () ())
25 'esmf_tnfne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 120 0 (121 122) () 25 () ())
32 'esmf_sfne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 123 0 (124 125) () 32 () ())
31 'esmf_dkne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 126 0 (127 128) () 31 () ())
48 'filename' '' 46 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY)
(CHARACTER 1 (())) 0 0 () () 0 () ())
23 'esmf_lgne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 129 0 (130 131) () 23 () ())
29 'esmf_tfne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 132 0 (133 134) () 29 () ())
89 'iorw2' '' 87 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 38 ())
0 0 () () 0 () ())
30 'esmf_ptne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 135 0 (136 137) () 30 () ())
22 'esmf_dmne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 138 0 (139 140) () 22 () ())
16 'esmf_sfeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 141 0 (142 143) () 16 () ())
28 'esmf_aine' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 144 0 (145 146) () 28 () ())
13 'esmf_tfeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 147 0 (148 149) () 13 () ())
76 'asyncio' '' 71 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
LOGICAL 4 ()) 0 0 () () 0 () ())
5 'esmf_ifeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 150 0 (151 152) () 5 () ())
52 'rc' '' 46 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
27 'esmf_bfne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 153 0 (154 155) () 27 () ())
142 'sf1' '' 141 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 55 ())
0 0 () () 0 () ())
106 'dk1' '' 105 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 156
()) 0 0 () () 0 () ())
156 'esmf_typekind' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((157 'dkind'
(INTEGER 4 ()) () 0 0 ())) PUBLIC ())
116 'pt2' '' 114 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 158
()) 0 0 () () 0 () ())
158 'esmf_pointer' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((159 'ptr' (
INTEGER 8 ()) () 0 0 ())) PUBLIC ())
115 'pt1' '' 114 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 158
()) 0 0 () () 0 () ())
143 'sf2' '' 141 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 55 ())
0 0 () () 0 () ())
113 'ai2' '' 111 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 160
()) 0 0 () () 0 () ())
160 'esmf_axisindex' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((161 'min' (
INTEGER 4 ()) () 0 0 ()) (162 'max' (INTEGER 4 ()) () 0 0 ()) (163
'stride' (INTEGER 4 ()) () 0 0 ()) (164 'pad' (INTEGER 4 ()) () 0 0 ())
(165 'isinit' (INTEGER 8 ()) () 0 0 (CONSTANT (INTEGER 4 ()) 0 '76838410')))
PUBLIC ())
112 'ai1' '' 111 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 160
()) 0 0 () () 0 () ())
109 'bf1' '' 108 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 166
()) 0 0 () () 0 () ())
166 'esmf_blockingflag' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((167 'value'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
107 'dk2' '' 105 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 156
()) 0 0 () () 0 () ())
92 'lg2' '' 90 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 168 ())
0 0 () () 0 () ())
168 'esmf_localglobalflag' 'esmf_utiltypesmod' 1 ((DERIVED
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0
((169 'value' (INTEGER 4 ()) () 0 0 ())) PUBLIC ())
148 'tf1' '' 147 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 170
()) 0 0 () () 0 () ())
170 'esmf_logical' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((171 'value'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
91 'lg1' '' 90 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 168 ())
0 0 () () 0 () ())
103 'fr1' '' 102 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 172
()) 0 0 () () 0 () ())
172 'esmf_direction' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((173 'value'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
100 'dm1' '' 99 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 174 ())
0 0 () () 0 () ())
174 'esmf_domaintypeflag' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((175 'value'
(INTEGER 4 ()) () 0 0 ())) PUBLIC ())
110 'bf2' '' 108 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 166
()) 0 0 () () 0 () ())
86 'rf2' '' 84 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 176 ())
0 0 () () 0 () ())
176 'esmf_regionflag' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((177 'i_type'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
85 'rf1' '' 84 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 176 ())
0 0 () () 0 () ())
124 'sf1' '' 123 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 55 ())
0 0 () () 0 () ())
101 'dm2' '' 99 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 174 ())
0 0 () () 0 () ())
125 'sf2' '' 123 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 55 ())
0 0 () () 0 () ())
104 'fr2' '' 102 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 172
()) 0 0 () () 0 () ())
152 'if2' '' 150 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 178
()) 0 0 () () 0 () ())
178 'esmf_indexflag' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((179 'i_type'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
94 'tnf1' '' 93 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 180 ())
0 0 () () 0 () ())
180 'esmf_terminationflag' 'esmf_utiltypesmod' 1 ((DERIVED
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0
((181 'value' (INTEGER 4 ()) () 0 0 ())) PRIVATE ())
151 'if1' '' 150 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 178
()) 0 0 () () 0 () ())
95 'tnf2' '' 93 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 180 ())
0 0 () () 0 () ())
137 'pt2' '' 135 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 158
()) 0 0 () () 0 () ())
97 'ctf1' '' 96 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 182 ())
0 0 () () 0 () ())
182 'esmf_contextflag' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((183 'value'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
136 'pt1' '' 135 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 158
()) 0 0 () () 0 () ())
122 'tnf2' '' 120 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 180
()) 0 0 () () 0 () ())
130 'lg1' '' 129 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 168
()) 0 0 () () 0 () ())
131 'lg2' '' 129 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 168
()) 0 0 () () 0 () ())
121 'tnf1' '' 120 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 180
()) 0 0 () () 0 () ())
154 'bf1' '' 153 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 166
()) 0 0 () () 0 () ())
149 'tf2' '' 147 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 170
()) 0 0 () () 0 () ())
155 'bf2' '' 153 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 166
()) 0 0 () () 0 () ())
118 'ctf1' '' 117 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 182
()) 0 0 () () 0 () ())
140 'dm2' '' 138 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 174
()) 0 0 () () 0 () ())
146 'ai2' '' 144 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 160
()) 0 0 () () 0 () ())
98 'ctf2' '' 96 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 182 ())
0 0 () () 0 () ())
119 'ctf2' '' 117 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 182
()) 0 0 () () 0 () ())
127 'dk1' '' 126 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 156
()) 0 0 () () 0 () ())
128 'dk2' '' 126 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 156
()) 0 0 () () 0 () ())
134 'tf2' '' 132 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 170
()) 0 0 () () 0 () ())
133 'tf1' '' 132 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 170
()) 0 0 () () 0 () ())
139 'dm1' '' 138 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 174
()) 0 0 () () 0 () ())
33 'esmf_lltne' 'esmf_logerrmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 184 0 (185 186) () 33 () ())
17 'esmf_llteq' 'esmf_logerrmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 187 0 (188 189) () 17 () ())
18 'esmf_lhteq' 'esmf_logerrmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 190 0 (191 192) () 18 () ())
3 'esmf_iospeq' 'esmf_iospecmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 193 0 (194 195) () 3 () ())
195 'iosp2' '' 193 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 35
()) 0 0 () () 0 () ())
194 'iosp1' '' 193 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 35
()) 0 0 () () 0 () ())
19 'esmf_lmteq' 'esmf_logerrmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 196 0 (197 198) () 19 () ())
197 'mt1' '' 196 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 199
()) 0 0 () () 0 () ())
189 'lt2' '' 187 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 200
()) 0 0 () () 0 () ())
200 'esmf_logtype' 'esmf_logerrmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((201 'ftype'
(INTEGER 4 ()) () 0 0 ())) PUBLIC ())
199 'esmf_msgtype' 'esmf_logerrmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((202 'mtype'
(INTEGER 4 ()) () 0 0 ())) PUBLIC ())
188 'lt1' '' 187 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 200
()) 0 0 () () 0 () ())
185 'lt1' '' 184 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 200
()) 0 0 () () 0 () ())
192 'ht2' '' 190 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 203
()) 0 0 () () 0 () ())
203 'esmf_halttype' 'esmf_logerrmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((204 'htype'
(INTEGER 4 ()) () 0 0 ())) PUBLIC ())
191 'ht1' '' 190 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 203
()) 0 0 () () 0 () ())
186 'lt2' '' 184 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 200
()) 0 0 () () 0 () ())
198 'mt2' '' 196 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 199
()) 0 0 () () 0 () ())
21 'esmf_iospne' 'esmf_iospecmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 205 0 (206 207) () 21 () ())
206 'iosp1' '' 205 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 35
()) 0 0 () () 0 () ())
207 'iosp2' '' 205 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 35
()) 0 0 () () 0 () ())
2 'esmf_iorweq' 'esmf_iospecmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 208 0 (209 210) () 2 () ())
210 'iorw2' '' 208 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 38
()) 0 0 () () 0 () ())
209 'iorw1' '' 208 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 38
()) 0 0 () () 0 () ())
72 'iospec' '' 71 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED
53 ()) 0 0 () () 0 () ())
74 'iofileformat' '' 71 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL
DUMMY) (DERIVED 35 ()) 0 0 () () 0 () ())
73 'filename' '' 71 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
CHARACTER 1 (())) 0 0 () () 0 () ())
145 'ai1' '' 144 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 160
()) 0 0 () () 0 () ())
24 'esmf_frne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 211 0 (212 213) () 24 () ())
213 'fr2' '' 211 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 172
()) 0 0 () () 0 () ())
212 'fr1' '' 211 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 172
()) 0 0 () () 0 () ())
)

('esmf_io_fileformat_unspecified' 0 82 'esmf_io_fileformat_netcdf' 0 36
'esmf_io_fileformat_hdf' 0 34 'esmf_ioflush' 0 78 'esmf_io_rwtype_append'
0 44 'esmf_io_rwtype_unspecified' 0 43 'esmf_io_rwtype_readwrite' 0 40
'esmf_io_rwtype_readonly' 0 37 'esmf_io_rwtype_truncate' 0 39
'esmf_iofileformat' 0 35 'esmf_io_rwtype_writeonly' 0 41 'esmf_iospecset'
0 70 'esmf_iorwtype' 0 38 'esmf_iospec' 0 53 'esmf_iospecget' 0 45
'esmf_iostate' 0 61)
