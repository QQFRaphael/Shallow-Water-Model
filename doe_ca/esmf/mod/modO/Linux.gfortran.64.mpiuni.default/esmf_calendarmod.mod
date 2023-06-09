GFORTRAN module created from /Users/dazlich/doe_ca/esmf/src/Infrastructure/TimeMgr/interface/ESMF_Calendar.F90 on Mon Sep 10 14:57:38 2012
If you edit this, you'll get what you deserve.

(() () () () () () ()
() () () () () (2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22
23) (24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41) () () () ()
() () ())

()

(('esmf_calendarcreate' '' 42 43 44) ('esmf_calendarisleapyear' '' 45 46)
('esmf_calendarset' '' 47 48) ('esmf_calendarsetdefault' '' 49 50))

()

()

(51 'esmf_cal_360day' 'esmf_calendarmod' 1 ((PARAMETER UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (DERIVED 52 ()) 0 0 () (STRUCTURE (DERIVED 52 ())
0 (((CONSTANT (INTEGER 4 ()) 0 '5') ())) ()) () 0 () ())
53 'esmf_cal_gregorian' 'esmf_calendarmod' 1 ((PARAMETER UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (DERIVED 52 ()) 0 0 () (STRUCTURE (DERIVED 52 ())
0 (((CONSTANT (INTEGER 4 ()) 0 '1') ())) ()) () 0 () ())
54 'esmf_cal_julian' 'esmf_calendarmod' 1 ((PARAMETER UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (DERIVED 52 ()) 0 0 () (STRUCTURE (DERIVED 52 ())
0 (((CONSTANT (INTEGER 4 ()) 0 '2') ())) ()) () 0 () ())
55 'esmf_cal_custom' 'esmf_calendarmod' 1 ((PARAMETER UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (DERIVED 52 ()) 0 0 () (STRUCTURE (DERIVED 52 ())
0 (((CONSTANT (INTEGER 4 ()) 0 '6') ())) ()) () 0 () ())
56 'esmf_cal_noleap' 'esmf_calendarmod' 1 ((PARAMETER UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (DERIVED 52 ()) 0 0 () (STRUCTURE (DERIVED 52 ())
0 (((CONSTANT (INTEGER 4 ()) 0 '4') ())) ()) () 0 () ())
57 'esmf_cal_nocalendar' 'esmf_calendarmod' 1 ((PARAMETER UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (DERIVED 52 ()) 0 0 () (STRUCTURE (DERIVED 52 ())
0 (((CONSTANT (INTEGER 4 ()) 0 '7') ())) ()) () 0 () ())
58 'esmf_calendar' 'esmf_calendarmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((59 'this' (
DERIVED 60 ()) () 0 0 ()) (61 'isinit' (INTEGER 8 ()) () 0 0 (CONSTANT (
INTEGER 4 ()) 0 '76838410'))) PRIVATE ())
62 'esmf_calendardestroy' 'esmf_calendarmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL SUBROUTINE ALWAYS_EXPLICIT) (UNKNOWN 0 ())
63 0 (64 65) () 0 () ())
66 'esmf_calendarfinalize' 'esmf_calendarmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL SUBROUTINE ALWAYS_EXPLICIT) (UNKNOWN 0 ())
67 0 (68) () 0 () ())
69 'esmf_calendarget' 'esmf_calendarmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL SUBROUTINE ALWAYS_EXPLICIT) (UNKNOWN 0 ()) 70 0 (71 72
73 74 75 76 77 78 79 80 81) () 0 () ())
82 'esmf_cal_julianday' 'esmf_calendarmod' 1 ((PARAMETER UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (DERIVED 52 ()) 0 0 () (STRUCTURE (DERIVED 52 ())
0 (((CONSTANT (INTEGER 4 ()) 0 '3') ())) ()) () 0 () ())
83 'esmf_calendarinitialize' 'esmf_calendarmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL SUBROUTINE ALWAYS_EXPLICIT) (UNKNOWN 0 ())
84 0 (85 86) () 0 () ())
87 'esmf_calendarprint' 'esmf_calendarmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL SUBROUTINE ALWAYS_EXPLICIT) (UNKNOWN 0 ()) 88 0 (89 90
91) () 0 () ())
92 'esmf_calendarreadrestart' 'esmf_calendarmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL FUNCTION ALWAYS_EXPLICIT) (DERIVED 58 ())
93 0 (94 95 96) () 92 () ())
97 'esmf_calendarsetinitcreated' 'esmf_calendarmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL SUBROUTINE ALWAYS_EXPLICIT) (UNKNOWN 0 ())
98 0 (99 100) () 0 () ())
101 'esmf_calendarvalidate' 'esmf_calendarmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL SUBROUTINE ALWAYS_EXPLICIT) (UNKNOWN 0 ())
102 0 (103 104 105) () 0 () ())
106 'esmf_calendarwriterestart' 'esmf_calendarmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL SUBROUTINE ALWAYS_EXPLICIT) (UNKNOWN 0 ())
107 0 (108 109 110) () 0 () ())
52 'esmf_calendartype' 'esmf_calendarmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((111
'calendartype' (INTEGER 4 ()) () 0 0 ())) PRIVATE ())
112 'esmf_calendargetinit' 'esmf_calendarmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL FUNCTION ALWAYS_EXPLICIT) (INTEGER 8 ())
113 0 (114) () 112 () ())
115 'months_per_year' 'esmf_calendarmod' 1 ((PARAMETER UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (INTEGER 4 ()) 0 0 () (CONSTANT (INTEGER 4 ()) 0
'12') () 0 () ())
99 'c' '' 98 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 58 ())
0 0 () () 0 () ())
47 'esmf_calendarsetcustom' 'esmf_calendarmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL SUBROUTINE ALWAYS_EXPLICIT) (UNKNOWN 0 ())
116 0 (117 118 119 120 121 122 123 124) () 0 () ())
6 'esmf_rfeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 125 0 (126 127) () 6 () ())
60 'esmf_pointer' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((128 'ptr' (
INTEGER 8 ()) () 0 0 ())) PUBLIC ())
46 'esmf_calendarisleapyeari4' 'esmf_calendarmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL FUNCTION ALWAYS_EXPLICIT) (LOGICAL 4 ())
129 0 (130 131 132) () 46 () ())
10 'esmf_freq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 133 0 (134 135) () 10 () ())
11 'esmf_tnfeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 136 0 (137 138) () 11 () ())
9 'esmf_lgeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 139 0 (140 141) () 9 () ())
8 'esmf_dmeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 142 0 (143 144) () 8 () ())
14 'esmf_aieq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 145 0 (146 147) () 14 () ())
13 'esmf_bfeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 148 0 (149 150) () 13 () ())
12 'esmf_ctfeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 151 0 (152 153) () 12 () ())
30 'esmf_frne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 154 0 (155 156) () 30 () ())
16 'esmf_pteq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 157 0 (158 159) () 16 () ())
17 'esmf_dkeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 160 0 (161 162) () 17 () ())
32 'esmf_ctfne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 163 0 (164 165) () 32 () ())
38 'esmf_sfne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 166 0 (167 168) () 38 () ())
34 'esmf_aine' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 169 0 (170 171) () 34 () ())
31 'esmf_tnfne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 172 0 (173 174) () 31 () ())
33 'esmf_bfne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 175 0 (176 177) () 33 () ())
100 'rc' '' 98 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
36 'esmf_ptne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 178 0 (179 180) () 36 () ())
37 'esmf_dkne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 181 0 (182 183) () 37 () ())
35 'esmf_tfne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 184 0 (185 186) () 35 () ())
28 'esmf_dmne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 187 0 (188 189) () 28 () ())
48 'esmf_calendarsetbuiltin' 'esmf_calendarmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL SUBROUTINE ALWAYS_EXPLICIT) (UNKNOWN 0 ())
190 0 (191 192 193 194) () 0 () ())
29 'esmf_lgne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 195 0 (196 197) () 29 () ())
18 'esmf_sfeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 198 0 (199 200) () 18 () ())
49 'esmf_calendarsetdefaultcal' 'esmf_calendarmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL SUBROUTINE ALWAYS_EXPLICIT) (UNKNOWN 0 ())
201 0 (202 203) () 0 () ())
15 'esmf_tfeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 204 0 (205 206) () 15 () ())
50 'esmf_calendarsetdefaulttype' 'esmf_calendarmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL SUBROUTINE ALWAYS_EXPLICIT) (UNKNOWN 0 ())
207 0 (208 209) () 0 () ())
45 'esmf_calendarisleapyeari8' 'esmf_calendarmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL FUNCTION ALWAYS_EXPLICIT) (LOGICAL 4 ())
210 0 (211 212 213) () 45 () ())
7 'esmf_ifeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 214 0 (215 216) () 7 () ())
200 'sf2' '' 198 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 217
()) 0 0 () () 0 () ())
217 'esmf_status' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((218 'status'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
158 'pt1' '' 157 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 60 ())
0 0 () () 0 () ())
159 'pt2' '' 157 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 60 ())
0 0 () () 0 () ())
199 'sf1' '' 198 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 217
()) 0 0 () () 0 () ())
146 'ai1' '' 145 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 219
()) 0 0 () () 0 () ())
219 'esmf_axisindex' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((220 'min' (
INTEGER 4 ()) () 0 0 ()) (221 'max' (INTEGER 4 ()) () 0 0 ()) (222
'stride' (INTEGER 4 ()) () 0 0 ()) (223 'pad' (INTEGER 4 ()) () 0 0 ())
(224 'isinit' (INTEGER 8 ()) () 0 0 (CONSTANT (INTEGER 4 ()) 0 '76838410')))
PUBLIC ())
147 'ai2' '' 145 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 219
()) 0 0 () () 0 () ())
205 'tf1' '' 204 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 225
()) 0 0 () () 0 () ())
225 'esmf_logical' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((226 'value'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
149 'bf1' '' 148 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 227
()) 0 0 () () 0 () ())
227 'esmf_blockingflag' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((228 'value'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
141 'lg2' '' 139 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 229
()) 0 0 () () 0 () ())
229 'esmf_localglobalflag' 'esmf_utiltypesmod' 1 ((DERIVED
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0
((230 'value' (INTEGER 4 ()) () 0 0 ())) PUBLIC ())
162 'dk2' '' 160 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 231
()) 0 0 () () 0 () ())
231 'esmf_typekind' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((232 'dkind'
(INTEGER 4 ()) () 0 0 ())) PUBLIC ())
140 'lg1' '' 139 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 229
()) 0 0 () () 0 () ())
143 'dm1' '' 142 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 233
()) 0 0 () () 0 () ())
233 'esmf_domaintypeflag' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((234 'value'
(INTEGER 4 ()) () 0 0 ())) PUBLIC ())
135 'fr2' '' 133 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 235
()) 0 0 () () 0 () ())
235 'esmf_direction' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((236 'value'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
134 'fr1' '' 133 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 235
()) 0 0 () () 0 () ())
127 'rf2' '' 125 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 237
()) 0 0 () () 0 () ())
237 'esmf_regionflag' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((238 'i_type'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
144 'dm2' '' 142 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 233
()) 0 0 () () 0 () ())
167 'sf1' '' 166 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 217
()) 0 0 () () 0 () ())
168 'sf2' '' 166 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 217
()) 0 0 () () 0 () ())
215 'if1' '' 214 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 239
()) 0 0 () () 0 () ())
239 'esmf_indexflag' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((240 'i_type'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
216 'if2' '' 214 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 239
()) 0 0 () () 0 () ())
137 'tnf1' '' 136 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 241
()) 0 0 () () 0 () ())
241 'esmf_terminationflag' 'esmf_utiltypesmod' 1 ((DERIVED
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0
((242 'value' (INTEGER 4 ()) () 0 0 ())) PRIVATE ())
176 'bf1' '' 175 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 227
()) 0 0 () () 0 () ())
180 'pt2' '' 178 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 60 ())
0 0 () () 0 () ())
138 'tnf2' '' 136 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 241
()) 0 0 () () 0 () ())
179 'pt1' '' 178 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 60 ())
0 0 () () 0 () ())
152 'ctf1' '' 151 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 243
()) 0 0 () () 0 () ())
243 'esmf_contextflag' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((244 'value'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
174 'tnf2' '' 172 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 241
()) 0 0 () () 0 () ())
156 'fr2' '' 154 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 235
()) 0 0 () () 0 () ())
206 'tf2' '' 204 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 225
()) 0 0 () () 0 () ())
196 'lg1' '' 195 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 229
()) 0 0 () () 0 () ())
155 'fr1' '' 154 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 235
()) 0 0 () () 0 () ())
188 'dm1' '' 187 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 233
()) 0 0 () () 0 () ())
197 'lg2' '' 195 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 229
()) 0 0 () () 0 () ())
173 'tnf1' '' 172 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 241
()) 0 0 () () 0 () ())
126 'rf1' '' 125 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 237
()) 0 0 () () 0 () ())
165 'ctf2' '' 163 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 243
()) 0 0 () () 0 () ())
164 'ctf1' '' 163 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 243
()) 0 0 () () 0 () ())
177 'bf2' '' 175 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 227
()) 0 0 () () 0 () ())
185 'tf1' '' 184 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 225
()) 0 0 () () 0 () ())
171 'ai2' '' 169 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 219
()) 0 0 () () 0 () ())
183 'dk2' '' 181 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 231
()) 0 0 () () 0 () ())
186 'tf2' '' 184 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 225
()) 0 0 () () 0 () ())
20 'esmf_iospeq' 'esmf_iospecmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 245 0 (246 247) () 20 () ())
170 'ai1' '' 169 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 219
()) 0 0 () () 0 () ())
182 'dk1' '' 181 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 231
()) 0 0 () () 0 () ())
23 'esmf_lmteq' 'esmf_logerrmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 248 0 (249 250) () 23 () ())
19 'esmf_iorweq' 'esmf_iospecmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 251 0 (252 253) () 19 () ())
153 'ctf2' '' 151 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 243
()) 0 0 () () 0 () ())
22 'esmf_lhteq' 'esmf_logerrmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 254 0 (255 256) () 22 () ())
21 'esmf_llteq' 'esmf_logerrmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 257 0 (258 259) () 21 () ())
39 'esmf_iorwne' 'esmf_iospecmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 260 0 (261 262) () 39 () ())
262 'iorw2' '' 260 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED
263 ()) 0 0 () () 0 () ())
189 'dm2' '' 187 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 233
()) 0 0 () () 0 () ())
150 'bf2' '' 148 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 227
()) 0 0 () () 0 () ())
41 'esmf_lltne' 'esmf_logerrmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 264 0 (265 266) () 41 () ())
261 'iorw1' '' 260 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED
263 ()) 0 0 () () 0 () ())
42 'esmf_calendarcreatecustom' 'esmf_calendarmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL FUNCTION ALWAYS_EXPLICIT) (DERIVED 58 ())
267 0 (268 269 270 271 272 273 274) () 42 () ())
269 'dayspermonth' '' 267 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DIMENSION
OPTIONAL DUMMY) (INTEGER 4 ()) 0 0 () (1 ASSUMED_SHAPE (CONSTANT (
INTEGER 4 ()) 0 '1') ()) 0 () ())
271 'daysperyear' '' 267 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL
DUMMY) (INTEGER 4 ()) 0 0 () () 0 () ())
270 'secondsperday' '' 267 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL
DUMMY) (INTEGER 4 ()) 0 0 () () 0 () ())
268 'name' '' 267 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
CHARACTER 1 (())) 0 0 () () 0 () ())
273 'daysperyeardd' '' 267 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL
DUMMY) (INTEGER 4 ()) 0 0 () () 0 () ())
274 'rc' '' 267 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
272 'daysperyeardn' '' 267 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL
DUMMY) (INTEGER 4 ()) 0 0 () () 0 () ())
266 'lt2' '' 264 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 275
()) 0 0 () () 0 () ())
255 'ht1' '' 254 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 276
()) 0 0 () () 0 () ())
256 'ht2' '' 254 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 276
()) 0 0 () () 0 () ())
258 'lt1' '' 257 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 275
()) 0 0 () () 0 () ())
246 'iosp1' '' 245 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED
277 ()) 0 0 () () 0 () ())
277 'esmf_iofileformat' 'esmf_iospecmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((278
'iofileformat' (INTEGER 4 ()) () 0 0 ())) PRIVATE ())
250 'mt2' '' 248 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 279
()) 0 0 () () 0 () ())
249 'mt1' '' 248 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 279
()) 0 0 () () 0 () ())
247 'iosp2' '' 245 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED
277 ()) 0 0 () () 0 () ())
253 'iorw2' '' 251 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED
263 ()) 0 0 () () 0 () ())
276 'esmf_halttype' 'esmf_logerrmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((280 'htype'
(INTEGER 4 ()) () 0 0 ())) PUBLIC ())
275 'esmf_logtype' 'esmf_logerrmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((281 'ftype'
(INTEGER 4 ()) () 0 0 ())) PUBLIC ())
252 'iorw1' '' 251 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED
263 ()) 0 0 () () 0 () ())
279 'esmf_msgtype' 'esmf_logerrmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((282 'mtype'
(INTEGER 4 ()) () 0 0 ())) PUBLIC ())
259 'lt2' '' 257 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 275
()) 0 0 () () 0 () ())
265 'lt1' '' 264 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 275
()) 0 0 () () 0 () ())
64 'calendar' '' 63 ((VARIABLE UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN DUMMY)
(DERIVED 58 ()) 0 0 () () 0 () ())
68 'rc' '' 67 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
71 'calendar' '' 70 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 58 ()) 0 0 () () 0 () ())
72 'name' '' 70 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
CHARACTER 1 (())) 0 0 () () 0 () ())
73 'calendartype' '' 70 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL
DUMMY) (DERIVED 52 ()) 0 0 () () 0 () ())
74 'dayspermonth' '' 70 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN DIMENSION
OPTIONAL DUMMY) (INTEGER 4 ()) 0 0 () (1 ASSUMED_SHAPE (CONSTANT (
INTEGER 4 ()) 0 '1') ()) 0 () ())
65 'rc' '' 63 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
78 'daysperyear' '' 70 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL
DUMMY) (INTEGER 4 ()) 0 0 () () 0 () ())
79 'daysperyeardn' '' 70 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL
DUMMY) (INTEGER 4 ()) 0 0 () () 0 () ())
77 'secondsperyear' '' 70 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL
DUMMY) (INTEGER 4 ()) 0 0 () () 0 () ())
76 'secondsperday' '' 70 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL
DUMMY) (INTEGER 4 ()) 0 0 () () 0 () ())
75 'monthsperyear' '' 70 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL
DUMMY) (INTEGER 4 ()) 0 0 () () 0 () ())
81 'rc' '' 70 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
5 'esmf_calendareq' 'esmf_calendarmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 283 0 (284 285) () 5 () ())
4 'esmf_calendartypeeq' 'esmf_calendarmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 286 0 (287 288) () 4 () ())
3 'esmf_calendarcalandtypeeq' 'esmf_calendarmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 289 0 (290 291)
() 3 () ())
25 'esmf_calendarcalandtypene' 'esmf_calendarmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 292 0 (293 294)
() 25 () ())
114 'd' '' 113 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
DERIVED 58 ()) 0 0 () () 0 () ())
24 'esmf_calendartypeandcalne' 'esmf_calendarmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 295 0 (296 297)
() 24 () ())
26 'esmf_calendartypene' 'esmf_calendarmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 298 0 (299 300) () 26 () ())
27 'esmf_calendarne' 'esmf_calendarmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 301 0 (302 303) () 27 () ())
44 'esmf_calendarcreatebuiltin' 'esmf_calendarmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL FUNCTION ALWAYS_EXPLICIT) (DERIVED 58 ())
304 0 (305 306 307) () 44 () ())
306 'calendartype' '' 304 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 52 ()) 0 0 () () 0 () ())
305 'name' '' 304 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
CHARACTER 1 (())) 0 0 () () 0 () ())
307 'rc' '' 304 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
2 'esmf_calendartypeandcaleq' 'esmf_calendarmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 308 0 (309 310)
() 2 () ())
43 'esmf_calendarcreatecopy' 'esmf_calendarmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL FUNCTION ALWAYS_EXPLICIT) (DERIVED 58 ())
311 0 (312 313) () 43 () ())
312 'calendar' '' 311 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 58 ()) 0 0 () () 0 () ())
313 'rc' '' 311 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
85 'calendartype' '' 84 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL
DUMMY) (DERIVED 52 ()) 0 0 () () 0 () ())
130 'calendar' '' 129 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 58 ()) 0 0 () () 0 () ())
86 'rc' '' 84 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
80 'daysperyeardd' '' 70 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL
DUMMY) (INTEGER 4 ()) 0 0 () () 0 () ())
212 'yy_i8' '' 210 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (INTEGER 8
()) 0 0 () () 0 () ())
89 'calendar' '' 88 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 58 ()) 0 0 () () 0 () ())
91 'rc' '' 88 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
90 'options' '' 88 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
CHARACTER 1 (())) 0 0 () () 0 () ())
94 'name' '' 93 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (CHARACTER 1 (
())) 0 0 () () 0 () ())
213 'rc' '' 210 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
96 'rc' '' 93 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
192 'name' '' 190 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
CHARACTER 1 (())) 0 0 () () 0 () ())
191 'calendar' '' 190 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 58 ()) 0 0 () () 0 () ())
95 'iospec' '' 93 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
DERIVED 314 ()) 0 0 () () 0 () ())
314 'esmf_iospec' 'esmf_iospecmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((315 'iostatus'
(DERIVED 217 ()) () 0 0 ()) (316 'iofileformat' (DERIVED 277 ()) () 0 0
()) (317 'iorwtype' (DERIVED 263 ()) () 0 0 ()) (318 'filename' (
CHARACTER 1 ((CONSTANT (INTEGER 4 ()) 0 '128'))) () 0 0 ()) (319 'asyncio'
(LOGICAL 4 ()) () 0 0 ())) PRIVATE ())
40 'esmf_iospne' 'esmf_iospecmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 320 0 (321 322) () 40 () ())
263 'esmf_iorwtype' 'esmf_iospecmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((323 'iorwtype'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
321 'iosp1' '' 320 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED
277 ()) 0 0 () () 0 () ())
322 'iosp2' '' 320 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED
277 ()) 0 0 () () 0 () ())
211 'calendar' '' 210 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 58 ()) 0 0 () () 0 () ())
132 'rc' '' 129 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
131 'yy' '' 129 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (INTEGER 4 ())
0 0 () () 0 () ())
194 'rc' '' 190 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
119 'dayspermonth' '' 116 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DIMENSION
OPTIONAL DUMMY) (INTEGER 4 ()) 0 0 () (1 ASSUMED_SHAPE (CONSTANT (
INTEGER 4 ()) 0 '1') ()) 0 () ())
118 'name' '' 116 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
CHARACTER 1 (())) 0 0 () () 0 () ())
117 'calendar' '' 116 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 58 ()) 0 0 () () 0 () ())
122 'daysperyeardn' '' 116 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL
DUMMY) (INTEGER 4 ()) 0 0 () () 0 () ())
124 'rc' '' 116 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
123 'daysperyeardd' '' 116 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL
DUMMY) (INTEGER 4 ()) 0 0 () () 0 () ())
121 'daysperyear' '' 116 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL
DUMMY) (INTEGER 4 ()) 0 0 () () 0 () ())
120 'secondsperday' '' 116 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL
DUMMY) (INTEGER 4 ()) 0 0 () () 0 () ())
193 'calendartype' '' 190 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 52 ()) 0 0 () () 0 () ())
202 'calendar' '' 201 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 58 ()) 0 0 () () 0 () ())
209 'rc' '' 207 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
208 'calendartype' '' 207 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 52 ()) 0 0 () () 0 () ())
103 'calendar' '' 102 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 58 ()) 0 0 () () 0 () ())
203 'rc' '' 201 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
104 'options' '' 102 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY)
(CHARACTER 1 (())) 0 0 () () 0 () ())
108 'calendar' '' 107 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 58 ()) 0 0 () () 0 () ())
110 'rc' '' 107 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
285 'calendar2' '' 283 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 58 ()) 0 0 () () 0 () ())
288 'calendartype2' '' 286 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 52 ()) 0 0 () () 0 () ())
287 'calendartype1' '' 286 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 52 ()) 0 0 () () 0 () ())
284 'calendar1' '' 283 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 58 ()) 0 0 () () 0 () ())
109 'iospec' '' 107 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
DERIVED 314 ()) 0 0 () () 0 () ())
105 'rc' '' 102 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
291 'calendartype' '' 289 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 52 ()) 0 0 () () 0 () ())
290 'calendar' '' 289 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 58 ()) 0 0 () () 0 () ())
310 'calendar' '' 308 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 58 ()) 0 0 () () 0 () ())
302 'calendar1' '' 301 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 58 ()) 0 0 () () 0 () ())
299 'calendartype1' '' 298 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 52 ()) 0 0 () () 0 () ())
303 'calendar2' '' 301 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 58 ()) 0 0 () () 0 () ())
293 'calendar' '' 292 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 58 ()) 0 0 () () 0 () ())
294 'calendartype' '' 292 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 52 ()) 0 0 () () 0 () ())
297 'calendar' '' 295 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 58 ()) 0 0 () () 0 () ())
296 'calendartype' '' 295 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 52 ()) 0 0 () () 0 () ())
300 'calendartype2' '' 298 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 52 ()) 0 0 () () 0 () ())
309 'calendartype' '' 308 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 52 ()) 0 0 () () 0 () ())
161 'dk1' '' 160 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 231
()) 0 0 () () 0 () ())
)

('months_per_year' 0 115 'esmf_calendargetinit' 0 112 'esmf_cal_julianday'
0 82 'esmf_cal_custom' 0 55 'esmf_cal_360day' 0 51 'esmf_cal_julian' 0
54 'esmf_cal_gregorian' 0 53 'esmf_calendar' 0 58 'esmf_cal_nocalendar'
0 57 'esmf_cal_noleap' 0 56 'esmf_calendarget' 0 69 'esmf_calendardestroy'
0 62 'esmf_calendarfinalize' 0 66 'esmf_calendarreadrestart' 0 92
'esmf_calendarinitialize' 0 83 'esmf_calendarprint' 0 87
'esmf_calendartype' 0 52 'esmf_calendarsetinitcreated' 0 97
'esmf_calendarwriterestart' 0 106 'esmf_calendarvalidate' 0 101)
