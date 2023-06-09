GFORTRAN module created from /Users/dazlich/doe_ca/esmf/src/Superstructure/State/src/ESMF_StateTypes.F90 on Mon Sep 10 14:58:29 2012
If you edit this, you'll get what you deserve.

(() () () () () () () () () () () () (2 3 4 5 6 7
8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32
33) (34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55
56 57 58 59 60 61) () () () () () () ())

()

()

()

()

(62 'esmf_dataholder' 'esmf_statetypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (UNKNOWN 0 ()) 0 0 () () 0 ((63 'fp' (DERIVED 64 ())
() 0 0 (STRUCTURE (DERIVED 64 ()) 0 ((() ()) ((CONSTANT (INTEGER 4 ()) 0
'76838410') ())) ())) (65 'fbp' (DERIVED 66 ()) () 0 0 (STRUCTURE (
DERIVED 66 ()) 0 ((() ()) ((CONSTANT (INTEGER 4 ()) 0 '76838410') ())) ()))
(67 'ap' (DERIVED 68 ()) () 0 0 (STRUCTURE (DERIVED 68 ()) 0 ((() ()) (
(CONSTANT (INTEGER 4 ()) 0 '76838410') ())) ())) (69 'abp' (DERIVED 70 ())
() 0 0 (STRUCTURE (DERIVED 70 ()) 0 ((() ()) ((CONSTANT (INTEGER 4 ()) 0
'76838410') ())) ())) (71 'rp' (DERIVED 72 ()) () 0 0 (STRUCTURE (
DERIVED 72 ()) 0 ((() ()) ((CONSTANT (INTEGER 4 ()) 0 '76838410') ())) ()))
(73 'spp' (DERIVED 74 ()) () 0 1 ()) (75 'isinit' (INTEGER 8 ()) () 0 0
(CONSTANT (INTEGER 4 ()) 0 '76838410'))) PUBLIC ())
76 'esmf_dataholderinit' 'esmf_statetypesmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL SUBROUTINE) (UNKNOWN 0 ()) 77 0 (78) ()
0 () ())
79 'esmf_dataholdervalidate' 'esmf_statetypesmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL SUBROUTINE ALWAYS_EXPLICIT) (UNKNOWN 0 ())
80 0 (81 82) () 0 () ())
83 'esmf_dataholdergetinit' 'esmf_statetypesmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL FUNCTION ALWAYS_EXPLICIT) (INTEGER 8 ())
84 0 (85) () 83 () ())
86 'esmf_invalid' 'esmf_statetypesmod' 1 ((PARAMETER UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (DERIVED 87 ()) 0 0 () (STRUCTURE (DERIVED 87 ())
0 (((CONSTANT (INTEGER 4 ()) 0 '2') ())) ()) () 0 () ())
88 'esmf_neededflag' 'esmf_statetypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((89 'needed'
(INTEGER 4 ()) () 0 0 ())) PUBLIC ())
90 'esmf_notneeded' 'esmf_statetypesmod' 1 ((PARAMETER UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (DERIVED 88 ()) 0 0 () (STRUCTURE (DERIVED 88 ())
0 (((CONSTANT (INTEGER 4 ()) 0 '2') ())) ()) () 0 () ())
91 'esmf_notrequired_for_restart' 'esmf_statetypesmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 92 ()) 0 0 () (STRUCTURE (
DERIVED 92 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '2') ())) ()) () 0 () ())
93 'esmf_notready' 'esmf_statetypesmod' 1 ((PARAMETER UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (DERIVED 94 ()) 0 0 () (STRUCTURE (DERIVED 94 ())
0 (((CONSTANT (INTEGER 4 ()) 0 '3') ())) ()) () 0 () ())
95 'esmf_needed' 'esmf_statetypesmod' 1 ((PARAMETER UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (DERIVED 88 ()) 0 0 () (STRUCTURE (DERIVED 88 ())
0 (((CONSTANT (INTEGER 4 ()) 0 '1') ())) ()) () 0 () ())
94 'esmf_readyflag' 'esmf_statetypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((96 'ready' (
INTEGER 4 ()) () 0 0 ())) PUBLIC ())
97 'esmf_readytowrite' 'esmf_statetypesmod' 1 ((PARAMETER UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (DERIVED 94 ()) 0 0 () (STRUCTURE (DERIVED 94 ())
0 (((CONSTANT (INTEGER 4 ()) 0 '1') ())) ()) () 0 () ())
98 'esmf_readytoread' 'esmf_statetypesmod' 1 ((PARAMETER UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (DERIVED 94 ()) 0 0 () (STRUCTURE (DERIVED 94 ())
0 (((CONSTANT (INTEGER 4 ()) 0 '2') ())) ()) () 0 () ())
92 'esmf_reqforrestartflag' 'esmf_statetypesmod' 1 ((DERIVED
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0
((99 'required4restart' (INTEGER 4 ()) () 0 0 ())) PUBLIC ())
100 'esmf_required_for_restart' 'esmf_statetypesmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 92 ()) 0 0 () (STRUCTURE (
DERIVED 92 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '1') ())) ()) () 0 () ())
101 'esmf_state' 'esmf_statetypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (UNKNOWN 0 ()) 0 0 () () 0 ((102 'statep' (
DERIVED 74 ()) () 0 1 (NULL (UNKNOWN 0 ()) 0)) (103 'isinit' (INTEGER 8
()) () 0 0 (CONSTANT (INTEGER 4 ()) 0 '76838410'))) PUBLIC ())
104 'esmf_state_import' 'esmf_statetypesmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 105 ()) 0 0 () (STRUCTURE
(DERIVED 105 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '1') ())) ()) () 0 () ())
106 'esmf_state_unspecified' 'esmf_statetypesmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 105 ()) 0 0 () (STRUCTURE
(DERIVED 105 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '3') ())) ()) () 0 () ())
74 'esmf_stateclass' 'esmf_statetypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (UNKNOWN 0 ()) 0 0 () () 0 ((107 'base' (DERIVED
108 ()) () 0 0 (STRUCTURE (DERIVED 108 ()) 0 ((() ()) ((CONSTANT (
INTEGER 4 ()) 0 '76838410') ())) ())) (109 'statestatus' (DERIVED 110 ())
() 0 0 ()) (111 'st' (DERIVED 105 ()) () 0 0 ()) (112 'needed_default' (
DERIVED 88 ()) () 0 0 ()) (113 'ready_default' (DERIVED 94 ()) () 0 0 ())
(114 'stvalid_default' (DERIVED 87 ()) () 0 0 ()) (115
'reqrestart_default' (DERIVED 92 ()) () 0 0 ()) (116 'alloccount' (
INTEGER 4 ()) () 0 0 ()) (117 'datacount' (INTEGER 4 ()) () 0 0 ()) (
118 'datalist' (DERIVED 119 ()) (1 DEFERRED () ()) 1 1 ()) (120 'isinit'
(INTEGER 8 ()) () 0 0 (CONSTANT (INTEGER 4 ()) 0 '76838410'))) PUBLIC ())
121 'esmf_state_invalid' 'esmf_statetypesmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 105 ()) 0 0 () (STRUCTURE
(DERIVED 105 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '4') ())) ()) () 0 () ())
122 'esmf_stategetinit' 'esmf_statetypesmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL FUNCTION ALWAYS_EXPLICIT) (INTEGER 8 ())
123 0 (124) () 122 () ())
125 'esmf_stateitem_array' 'esmf_statetypesmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 126 ()) 0 0 () (STRUCTURE
(DERIVED 126 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '103') ())) ()) () 0 ()
())
127 'esmf_stateitem_arraybundle' 'esmf_statetypesmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 126 ()) 0 0 () (STRUCTURE
(DERIVED 126 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '104') ())) ()) () 0 ()
())
119 'esmf_stateitem' 'esmf_statetypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (UNKNOWN 0 ()) 0 0 () () 0 ((128 'datap' (DERIVED
62 ()) () 0 0 (STRUCTURE (DERIVED 62 ()) 0 (((STRUCTURE (DERIVED 64 ())
0 ((() ()) ((CONSTANT (INTEGER 4 ()) 0 '76838410') ())) ()) ()) ((
STRUCTURE (DERIVED 66 ()) 0 ((() ()) ((CONSTANT (INTEGER 4 ()) 0
'76838410') ())) ()) ()) ((STRUCTURE (DERIVED 68 ()) 0 ((() ()) ((
CONSTANT (INTEGER 4 ()) 0 '76838410') ())) ()) ()) ((STRUCTURE (DERIVED
70 ()) 0 ((() ()) ((CONSTANT (INTEGER 4 ()) 0 '76838410') ())) ()) ()) (
(STRUCTURE (DERIVED 72 ()) 0 ((() ()) ((CONSTANT (INTEGER 4 ()) 0
'76838410') ())) ()) ()) (() ()) ((CONSTANT (INTEGER 4 ()) 0 '76838410')
())) ())) (129 'otype' (DERIVED 126 ()) () 0 0 ()) (130 'needed' (
DERIVED 88 ()) () 0 0 ()) (131 'ready' (DERIVED 94 ()) () 0 0 ()) (132
'valid' (DERIVED 87 ()) () 0 0 ()) (133 'reqrestart' (DERIVED 92 ()) ()
0 0 ()) (134 'proxyflag' (LOGICAL 4 ()) () 0 0 ()) (135 'indirect_index'
(INTEGER 4 ()) () 0 0 ()) (136 'namep' (CHARACTER 1 ((CONSTANT (INTEGER
4 ()) 0 '128'))) () 0 0 ()) (137 'isinit' (INTEGER 8 ()) () 0 0 (
CONSTANT (INTEGER 4 ()) 0 '76838410'))) PUBLIC ())
138 'esmf_stateclassvalidate' 'esmf_statetypesmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL SUBROUTINE ALWAYS_EXPLICIT) (UNKNOWN 0 ())
139 0 (140 141) () 0 () ())
142 'esmf_stateitem_field' 'esmf_statetypesmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 126 ()) 0 0 () (STRUCTURE
(DERIVED 126 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '101') ())) ()) () 0 ()
())
143 'esmf_stateclassgetinit' 'esmf_statetypesmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL FUNCTION ALWAYS_EXPLICIT) (INTEGER 8 ())
144 0 (145) () 143 () ())
146 'esmf_state_export' 'esmf_statetypesmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 105 ()) 0 0 () (STRUCTURE
(DERIVED 105 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '2') ())) ()) () 0 () ())
147 'esmf_stateitem_indirect' 'esmf_statetypesmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 126 ()) 0 0 () (STRUCTURE
(DERIVED 126 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '108') ())) ()) () 0 ()
())
148 'esmf_stateitem_name' 'esmf_statetypesmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 126 ()) 0 0 () (STRUCTURE
(DERIVED 126 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '107') ())) ()) () 0 ()
())
149 'esmf_stateitem_notfound' 'esmf_statetypesmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 126 ()) 0 0 () (STRUCTURE
(DERIVED 126 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '110') ())) ()) () 0 ()
())
150 'esmf_stateitem_routehandle' 'esmf_statetypesmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 126 ()) 0 0 () (STRUCTURE
(DERIVED 126 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '105') ())) ()) () 0 ()
())
151 'esmf_stateitem_unknown' 'esmf_statetypesmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 126 ()) 0 0 () (STRUCTURE
(DERIVED 126 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '109') ())) ()) () 0 ()
())
152 'esmf_stateitem_state' 'esmf_statetypesmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 126 ()) 0 0 () (STRUCTURE
(DERIVED 126 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '106') ())) ()) () 0 ()
())
153 'esmf_stateitemgetinit' 'esmf_statetypesmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL FUNCTION ALWAYS_EXPLICIT) (INTEGER 8 ())
154 0 (155) () 153 () ())
156 'esmf_stateiteminit' 'esmf_statetypesmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL SUBROUTINE) (UNKNOWN 0 ()) 157 0 (158) ()
0 () ())
105 'esmf_statetype' 'esmf_statetypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((159 'state'
(INTEGER 4 ()) () 0 0 ())) PUBLIC ())
160 'esmf_stateitemvalidate' 'esmf_statetypesmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL SUBROUTINE ALWAYS_EXPLICIT) (UNKNOWN 0 ())
161 0 (162 163) () 0 () ())
126 'esmf_stateitemtype' 'esmf_statetypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((164 'ot' (
INTEGER 4 ()) () 0 0 ())) PUBLIC ())
87 'esmf_validflag' 'esmf_statetypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((165 'valid'
(INTEGER 4 ()) () 0 0 ())) PUBLIC ())
166 'esmf_validityunknown' 'esmf_statetypesmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 87 ()) 0 0 () (STRUCTURE (
DERIVED 87 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '3') ())) ()) () 0 () ())
167 'esmf_valid' 'esmf_statetypesmod' 1 ((PARAMETER UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (DERIVED 87 ()) 0 0 () (STRUCTURE (DERIVED 87 ())
0 (((CONSTANT (INTEGER 4 ()) 0 '1') ())) ()) () 0 () ())
168 'esmf_stateitem_fieldbundle' 'esmf_statetypesmod' 1 ((PARAMETER
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (DERIVED 126 ()) 0 0 () (STRUCTURE
(DERIVED 126 ()) 0 (((CONSTANT (INTEGER 4 ()) 0 '102') ())) ()) () 0 ()
())
23 'esmf_iorweq' 'esmf_iospecmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 169 0 (170 171) () 23 () ())
24 'esmf_iospeq' 'esmf_iospecmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 172 0 (173 174) () 24 () ())
51 'esmf_iorwne' 'esmf_iospecmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 175 0 (176 177) () 51 () ())
141 'rc' '' 139 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
7 'esmf_rfeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 178 0 (179 180) () 7 () ())
110 'esmf_status' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((181 'status'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
52 'esmf_iospne' 'esmf_iospecmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 182 0 (183 184) () 52 () ())
10 'esmf_lgeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 185 0 (186 187) () 10 () ())
12 'esmf_tnfeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 188 0 (189 190) () 12 () ())
13 'esmf_ctfeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 191 0 (192 193) () 13 () ())
9 'esmf_dmeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 194 0 (195 196) () 9 () ())
11 'esmf_freq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 197 0 (198 199) () 11 () ())
14 'esmf_bfeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 200 0 (201 202) () 14 () ())
15 'esmf_aieq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 203 0 (204 205) () 15 () ())
18 'esmf_dkeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 206 0 (207 208) () 18 () ())
41 'esmf_frne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 209 0 (210 211) () 41 () ())
17 'esmf_pteq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 212 0 (213 214) () 17 () ())
37 'esmf_imexne' 'esmf_statetypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 215 0 (216 217) () 37 () ())
43 'esmf_ctfne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 218 0 (219 220) () 43 () ())
42 'esmf_tnfne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 221 0 (222 223) () 42 () ())
44 'esmf_bfne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 224 0 (225 226) () 44 () ())
47 'esmf_ptne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 227 0 (228 229) () 47 () ())
48 'esmf_dkne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 230 0 (231 232) () 48 () ())
49 'esmf_sfne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 233 0 (234 235) () 49 () ())
45 'esmf_aine' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 236 0 (237 238) () 45 () ())
40 'esmf_lgne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 239 0 (240 241) () 40 () ())
108 'esmf_base' 'esmf_basemod' 1 ((DERIVED UNKNOWN-INTENT UNKNOWN-PROC
UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((242 'this' (DERIVED 243 ())
() 0 0 ()) (244 'isinit' (INTEGER 8 ()) () 0 0 (CONSTANT (INTEGER 4 ())
0 '76838410'))) PUBLIC ())
243 'esmf_pointer' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((245 'ptr' (
INTEGER 8 ()) () 0 0 ())) PUBLIC ())
19 'esmf_sfeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 246 0 (247 248) () 19 () ())
39 'esmf_dmne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 249 0 (250 251) () 39 () ())
16 'esmf_tfeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 252 0 (253 254) () 16 () ())
8 'esmf_ifeq' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 255 0 (256 257) () 8 () ())
247 'sf1' '' 246 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 110
()) 0 0 () () 0 () ())
248 'sf2' '' 246 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 110
()) 0 0 () () 0 () ())
214 'pt2' '' 212 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 243
()) 0 0 () () 0 () ())
213 'pt1' '' 212 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 243
()) 0 0 () () 0 () ())
205 'ai2' '' 203 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 258
()) 0 0 () () 0 () ())
258 'esmf_axisindex' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((259 'min' (
INTEGER 4 ()) () 0 0 ()) (260 'max' (INTEGER 4 ()) () 0 0 ()) (261
'stride' (INTEGER 4 ()) () 0 0 ()) (262 'pad' (INTEGER 4 ()) () 0 0 ())
(263 'isinit' (INTEGER 8 ()) () 0 0 (CONSTANT (INTEGER 4 ()) 0 '76838410')))
PUBLIC ())
207 'dk1' '' 206 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 264
()) 0 0 () () 0 () ())
264 'esmf_typekind' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((265 'dkind'
(INTEGER 4 ()) () 0 0 ())) PUBLIC ())
253 'tf1' '' 252 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 266
()) 0 0 () () 0 () ())
266 'esmf_logical' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((267 'value'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
208 'dk2' '' 206 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 264
()) 0 0 () () 0 () ())
201 'bf1' '' 200 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 268
()) 0 0 () () 0 () ())
268 'esmf_blockingflag' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((269 'value'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
198 'fr1' '' 197 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 270
()) 0 0 () () 0 () ())
270 'esmf_direction' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((271 'value'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
195 'dm1' '' 194 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 272
()) 0 0 () () 0 () ())
272 'esmf_domaintypeflag' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((273 'value'
(INTEGER 4 ()) () 0 0 ())) PUBLIC ())
186 'lg1' '' 185 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 274
()) 0 0 () () 0 () ())
274 'esmf_localglobalflag' 'esmf_utiltypesmod' 1 ((DERIVED
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0
((275 'value' (INTEGER 4 ()) () 0 0 ())) PUBLIC ())
187 'lg2' '' 185 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 274
()) 0 0 () () 0 () ())
202 'bf2' '' 200 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 268
()) 0 0 () () 0 () ())
204 'ai1' '' 203 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 258
()) 0 0 () () 0 () ())
180 'rf2' '' 178 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 276
()) 0 0 () () 0 () ())
276 'esmf_regionflag' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((277 'i_type'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
179 'rf1' '' 178 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 276
()) 0 0 () () 0 () ())
234 'sf1' '' 233 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 110
()) 0 0 () () 0 () ())
235 'sf2' '' 233 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 110
()) 0 0 () () 0 () ())
256 'if1' '' 255 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 278
()) 0 0 () () 0 () ())
278 'esmf_indexflag' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((279 'i_type'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
254 'tf2' '' 252 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 266
()) 0 0 () () 0 () ())
189 'tnf1' '' 188 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 280
()) 0 0 () () 0 () ())
280 'esmf_terminationflag' 'esmf_utiltypesmod' 1 ((DERIVED
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0
((281 'value' (INTEGER 4 ()) () 0 0 ())) PRIVATE ())
192 'ctf1' '' 191 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 282
()) 0 0 () () 0 () ())
282 'esmf_contextflag' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((283 'value'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
229 'pt2' '' 227 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 243
()) 0 0 () () 0 () ())
225 'bf1' '' 224 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 268
()) 0 0 () () 0 () ())
211 'fr2' '' 209 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 270
()) 0 0 () () 0 () ())
228 'pt1' '' 227 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 243
()) 0 0 () () 0 () ())
190 'tnf2' '' 188 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 280
()) 0 0 () () 0 () ())
257 'if2' '' 255 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 278
()) 0 0 () () 0 () ())
196 'dm2' '' 194 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 272
()) 0 0 () () 0 () ())
210 'fr1' '' 209 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 270
()) 0 0 () () 0 () ())
240 'lg1' '' 239 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 274
()) 0 0 () () 0 () ())
222 'tnf1' '' 221 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 280
()) 0 0 () () 0 () ())
223 'tnf2' '' 221 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 280
()) 0 0 () () 0 () ())
199 'fr2' '' 197 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 270
()) 0 0 () () 0 () ())
162 'si' '' 161 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED
119 ()) 0 0 () () 0 () ())
250 'dm1' '' 249 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 272
()) 0 0 () () 0 () ())
219 'ctf1' '' 218 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 282
()) 0 0 () () 0 () ())
226 'bf2' '' 224 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 268
()) 0 0 () () 0 () ())
251 'dm2' '' 249 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 272
()) 0 0 () () 0 () ())
238 'ai2' '' 236 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 258
()) 0 0 () () 0 () ())
232 'dk2' '' 230 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 264
()) 0 0 () () 0 () ())
193 'ctf2' '' 191 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 282
()) 0 0 () () 0 () ())
231 'dk1' '' 230 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 264
()) 0 0 () () 0 () ())
20 'esmf_llteq' 'esmf_logerrmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 284 0 (285 286) () 20 () ())
22 'esmf_lmteq' 'esmf_logerrmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 287 0 (288 289) () 22 () ())
50 'esmf_lltne' 'esmf_logerrmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 290 0 (291 292) () 50 () ())
21 'esmf_lhteq' 'esmf_logerrmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 293 0 (294 295) () 21 () ())
163 'rc' '' 161 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
237 'ai1' '' 236 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 258
()) 0 0 () () 0 () ())
286 'lt2' '' 284 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 296
()) 0 0 () () 0 () ())
220 'ctf2' '' 218 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 282
()) 0 0 () () 0 () ())
241 'lg2' '' 239 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 274
()) 0 0 () () 0 () ())
46 'esmf_tfne' 'esmf_utiltypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 297 0 (298 299) () 46 () ())
298 'tf1' '' 297 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 266
()) 0 0 () () 0 () ())
299 'tf2' '' 297 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 266
()) 0 0 () () 0 () ())
291 'lt1' '' 290 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 296
()) 0 0 () () 0 () ())
288 'mt1' '' 287 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 300
()) 0 0 () () 0 () ())
300 'esmf_msgtype' 'esmf_logerrmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((301 'mtype'
(INTEGER 4 ()) () 0 0 ())) PUBLIC ())
289 'mt2' '' 287 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 300
()) 0 0 () () 0 () ())
292 'lt2' '' 290 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 296
()) 0 0 () () 0 () ())
285 'lt1' '' 284 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 296
()) 0 0 () () 0 () ())
294 'ht1' '' 293 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 302
()) 0 0 () () 0 () ())
302 'esmf_halttype' 'esmf_logerrmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((303 'htype'
(INTEGER 4 ()) () 0 0 ())) PUBLIC ())
155 'si' '' 154 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
DERIVED 119 ()) 0 0 () () 0 () ())
177 'iorw2' '' 175 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED
304 ()) 0 0 () () 0 () ())
304 'esmf_iorwtype' 'esmf_iospecmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((305 'iorwtype'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
176 'iorw1' '' 175 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED
304 ()) 0 0 () () 0 () ())
174 'iosp2' '' 172 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED
306 ()) 0 0 () () 0 () ())
306 'esmf_iofileformat' 'esmf_iospecmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((307
'iofileformat' (INTEGER 4 ()) () 0 0 ())) PRIVATE ())
183 'iosp1' '' 182 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED
306 ()) 0 0 () () 0 () ())
170 'iorw1' '' 169 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED
304 ()) 0 0 () () 0 () ())
171 'iorw2' '' 169 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED
304 ()) 0 0 () () 0 () ())
184 'iosp2' '' 182 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED
306 ()) 0 0 () () 0 () ())
173 'iosp1' '' 172 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED
306 ()) 0 0 () () 0 () ())
82 'rc' '' 80 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
295 'ht2' '' 293 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 302
()) 0 0 () () 0 () ())
34 'esmf_validne' 'esmf_statetypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 308 0 (309 310) () 34 () ())
309 's1' '' 308 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 87 ())
0 0 () () 0 () ())
124 's' '' 123 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
DERIVED 101 ()) 0 0 () () 0 () ())
25 'esmf_pfeq' 'esmf_fieldbundlemod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 311 0 (312 313) () 25 () ())
5 'esmf_imexeq' 'esmf_statetypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 314 0 (315 316) () 5 () ())
315 's1' '' 314 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 105 ())
0 0 () () 0 () ())
316 's2' '' 314 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 105 ())
0 0 () () 0 () ())
27 'esmf_ileq' 'esmf_internarraydatamapmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 317 0 (318 319) () 27 () ())
66 'esmf_fieldbundle' 'esmf_fieldbundlemod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((320 'btypep'
(DERIVED 321 ()) () 0 1 ()) (322 'isinit' (INTEGER 8 ()) () 0 0 (
CONSTANT (INTEGER 4 ()) 0 '76838410'))) PUBLIC ())
321 'esmf_fieldbundletype' 'esmf_fieldbundlemod' 1 ((DERIVED
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0
((323 'base' (DERIVED 108 ()) () 0 0 (STRUCTURE (DERIVED 108 ()) 0 ((()
()) ((CONSTANT (INTEGER 4 ()) 0 '76838410') ())) ())) (324 'flist' (
DERIVED 64 ()) (1 DEFERRED () ()) 1 1 ()) (325 'bundlestatus' (DERIVED
110 ()) () 0 0 ()) (326 'gridstatus' (DERIVED 110 ()) () 0 0 ()) (327
'grid' (DERIVED 328 ()) () 0 0 (STRUCTURE (DERIVED 328 ()) 0 ((() ()) (
(CONSTANT (INTEGER 4 ()) 0 '76838410') ())) ())) (329 'localbundle' (
DERIVED 330 ()) () 0 0 (STRUCTURE (DERIVED 330 ()) 0 (((STRUCTURE (
DERIVED 331 ()) 0 ((() ()) ((CONSTANT (INTEGER 4 ()) 0 '76838410') ()))
()) ()) (() ()) (() ()) (() ()) ((CONSTANT (INTEGER 4 ()) 0 '76838410')
())) ())) (332 'pack_flag' (DERIVED 333 ()) () 0 0 ()) (334 'iospec' (
DERIVED 335 ()) () 0 0 ()) (336 'iostatus' (DERIVED 110 ()) () 0 0 ()) (
337 'iscongruent' (LOGICAL 4 ()) () 0 0 ()) (338 'haspattern' (LOGICAL 4
()) () 0 0 ()) (339 'is_proxy' (LOGICAL 4 ()) () 0 0 ()) (340
'field_count' (INTEGER 4 ()) () 0 0 ()) (341 'isinit' (INTEGER 8 ()) ()
0 0 (CONSTANT (INTEGER 4 ()) 0 '76838410'))) PUBLIC ())
335 'esmf_iospec' 'esmf_iospecmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((342 'iostatus'
(DERIVED 110 ()) () 0 0 ()) (343 'iofileformat' (DERIVED 306 ()) () 0 0
()) (344 'iorwtype' (DERIVED 304 ()) () 0 0 ()) (345 'filename' (
CHARACTER 1 ((CONSTANT (INTEGER 4 ()) 0 '128'))) () 0 0 ()) (346 'asyncio'
(LOGICAL 4 ()) () 0 0 ())) PRIVATE ())
328 'esmf_grid' 'esmf_gridmod' 1 ((DERIVED UNKNOWN-INTENT UNKNOWN-PROC
UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((347 'this' (DERIVED 243 ())
() 0 0 ()) (348 'isinit' (INTEGER 8 ()) () 0 0 (CONSTANT (INTEGER 4 ())
0 '76838410'))) PUBLIC ())
330 'esmf_localfieldbundle' 'esmf_fieldbundlemod' 1 ((DERIVED
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0
((349 'packed_data' (DERIVED 331 ()) () 0 0 (STRUCTURE (DERIVED 331 ())
0 ((() ()) ((CONSTANT (INTEGER 4 ()) 0 '76838410') ())) ())) (350
'gridstatus' (DERIVED 110 ()) () 0 0 ()) (351 'arraystatus' (DERIVED 110
()) () 0 0 ()) (352 'accesscount' (INTEGER 4 ()) () 0 0 ()) (353 'isinit'
(INTEGER 8 ()) () 0 0 (CONSTANT (INTEGER 4 ()) 0 '76838410'))) PUBLIC ())
333 'esmf_packflag' 'esmf_fieldbundlemod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((354 'packflag'
(INTEGER 4 ()) () 0 0 ())) PUBLIC ())
145 'sc' '' 144 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
DERIVED 74 ()) 0 0 () () 0 () ())
4 'esmf_needeq' 'esmf_statetypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 355 0 (356 357) () 4 () ())
64 'esmf_field' 'esmf_fieldmod' 1 ((DERIVED UNKNOWN-INTENT UNKNOWN-PROC
UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((358 'ftypep' (DERIVED 359
()) () 0 1 ()) (360 'isinit' (INTEGER 8 ()) () 0 0 (CONSTANT (INTEGER 4
()) 0 '76838410'))) PUBLIC ())
359 'esmf_fieldtype' 'esmf_fieldmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((361 'base' (
DERIVED 108 ()) () 0 0 (STRUCTURE (DERIVED 108 ()) 0 ((() ()) ((
CONSTANT (INTEGER 4 ()) 0 '76838410') ())) ())) (362 'array' (DERIVED 68
()) () 0 0 (STRUCTURE (DERIVED 68 ()) 0 ((() ()) ((CONSTANT (INTEGER 4 ())
0 '76838410') ())) ())) (363 'grid' (DERIVED 328 ()) () 0 0 (STRUCTURE (
DERIVED 328 ()) 0 ((() ()) ((CONSTANT (INTEGER 4 ()) 0 '76838410') ()))
())) (364 'fieldstatus' (DERIVED 110 ()) () 0 0 ()) (365 'gridstatus' (
DERIVED 110 ()) () 0 0 ()) (366 'datastatus' (DERIVED 110 ()) () 0 0 ())
(367 'iospec' (DERIVED 335 ()) () 0 0 ()) (368 'iostatus' (DERIVED 110 ())
() 0 0 ()) (369 'staggerloc' (DERIVED 370 ()) () 0 0 ()) (371
'array_internal' (LOGICAL 4 ()) () 0 0 ()) (372 'is_proxy' (LOGICAL 4 ())
() 0 0 ()) (373 'gridtofieldmap' (INTEGER 4 ()) (1 EXPLICIT (CONSTANT (
INTEGER 4 ()) 0 '1') (CONSTANT (INTEGER 4 ()) 0 '7')) 1 0 ()) (374
'ungriddedlbound' (INTEGER 4 ()) (1 EXPLICIT (CONSTANT (INTEGER 4 ()) 0
'1') (CONSTANT (INTEGER 4 ()) 0 '7')) 1 0 ()) (375 'ungriddedubound' (
INTEGER 4 ()) (1 EXPLICIT (CONSTANT (INTEGER 4 ()) 0 '1') (CONSTANT (
INTEGER 4 ()) 0 '7')) 1 0 ()) (376 'maxhalolwidth' (INTEGER 4 ()) (1
EXPLICIT (CONSTANT (INTEGER 4 ()) 0 '1') (CONSTANT (INTEGER 4 ()) 0 '7'))
1 0 ()) (377 'maxhalouwidth' (INTEGER 4 ()) (1 EXPLICIT (CONSTANT (
INTEGER 4 ()) 0 '1') (CONSTANT (INTEGER 4 ()) 0 '7')) 1 0 ()) (378
'isinit' (INTEGER 8 ()) () 0 0 (CONSTANT (INTEGER 4 ()) 0 '76838410')))
PUBLIC ())
370 'esmf_staggerloc' 'esmf_staggerlocmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((379
'staggerloc' (INTEGER 4 ()) () 0 0 ())) PUBLIC ())
2 'esmf_valideq' 'esmf_statetypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 380 0 (381 382) () 2 () ())
381 's1' '' 380 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 87 ())
0 0 () () 0 () ())
382 's2' '' 380 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 87 ())
0 0 () () 0 () ())
29 'esmf_staggerlocequal' 'esmf_staggerlocmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 383 0 (384 385)
() 29 () ())
6 'esmf_oteq' 'esmf_statetypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 386 0 (387 388) () 6 () ())
387 's1' '' 386 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 126 ())
0 0 () () 0 () ())
32 'esmf_cfeq' 'esmf_localarraycreatemod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 389 0 (390 391) () 32 () ())
31 'esmf_gridconnequal' 'esmf_gridmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 392 0 (393 394) () 31 () ())
53 'esmf_pfne' 'esmf_fieldbundlemod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 395 0 (396 397) () 53 () ())
30 'esmf_gridstatusequal' 'esmf_gridmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 398 0 (399 400) () 30 () ())
38 'esmf_otne' 'esmf_statetypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 401 0 (402 403) () 38 () ())
403 's2' '' 401 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 126 ())
0 0 () () 0 () ())
33 'esmf_sreq' 'esmf_delayoutmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 404 0 (405 406) () 33 () ())
58 'esmf_gridstatusnotequal' 'esmf_gridmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 407 0 (408 409) () 58 () ())
59 'esmf_gridconnnotequal' 'esmf_gridmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 410 0 (411 412) () 59 () ())
55 'esmf_ilne' 'esmf_internarraydatamapmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 413 0 (414 415) () 55 () ())
56 'esmf_rlne' 'esmf_internarraydatamapmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 416 0 (417 418) () 56 () ())
61 'esmf_srne' 'esmf_delayoutmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 419 0 (420 421) () 61 () ())
57 'esmf_staggerlocnotequal' 'esmf_staggerlocmod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 422 0 (423 424)
() 57 () ())
28 'esmf_rleq' 'esmf_internarraydatamapmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 425 0 (426 427) () 28 () ())
296 'esmf_logtype' 'esmf_logerrmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((428 'ftype'
(INTEGER 4 ()) () 0 0 ())) PUBLIC ())
54 'esmf_ione' 'esmf_internarraydatamapmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 429 0 (430 431) () 54 () ())
26 'esmf_ioeq' 'esmf_internarraydatamapmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 432 0 (433 434) () 26 () ())
217 's2' '' 215 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 105 ())
0 0 () () 0 () ())
310 's2' '' 308 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 87 ())
0 0 () () 0 () ())
85 'dh' '' 84 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
DERIVED 62 ()) 0 0 () () 0 () ())
3 'esmf_redyeq' 'esmf_statetypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 435 0 (436 437) () 3 () ())
437 's2' '' 435 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 94 ())
0 0 () () 0 () ())
436 's1' '' 435 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 94 ())
0 0 () () 0 () ())
357 's2' '' 355 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 88 ())
0 0 () () 0 () ())
331 'esmf_internarray' 'esmf_internarraymod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((438 'this' (
DERIVED 243 ()) () 0 0 ()) (439 'isinit' (INTEGER 8 ()) () 0 0 (
CONSTANT (INTEGER 4 ()) 0 '76838410'))) PUBLIC ())
356 's1' '' 355 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 88 ())
0 0 () () 0 () ())
396 'pf1' '' 395 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 333
()) 0 0 () () 0 () ())
397 'pf2' '' 395 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 333
()) 0 0 () () 0 () ())
385 'staggerloc2' '' 383 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 370 ()) 0 0 () () 0 () ())
417 'rl1' '' 416 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 440
()) 0 0 () () 0 () ())
434 'io2' '' 432 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 441
()) 0 0 () () 0 () ())
433 'io1' '' 432 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 441
()) 0 0 () () 0 () ())
426 'rl1' '' 425 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 440
()) 0 0 () () 0 () ())
430 'io1' '' 429 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 441
()) 0 0 () () 0 () ())
384 'staggerloc1' '' 383 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 370 ()) 0 0 () () 0 () ())
158 'si' '' 157 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED
119 ()) 0 0 () () 0 () ())
414 'il1' '' 413 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 442
()) 0 0 () () 0 () ())
415 'il2' '' 413 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 442
()) 0 0 () () 0 () ())
423 'staggerloc1' '' 422 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 370 ()) 0 0 () () 0 () ())
427 'rl2' '' 425 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 440
()) 0 0 () () 0 () ())
319 'il2' '' 317 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 442
()) 0 0 () () 0 () ())
318 'il1' '' 317 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 442
()) 0 0 () () 0 () ())
441 'esmf_indexorder' 'esmf_internarraydatamapmod' 1 ((DERIVED
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0
((443 'iorder' (INTEGER 4 ()) () 0 0 ())) PRIVATE ())
442 'esmf_interleaveflag' 'esmf_internarraydatamapmod' 1 ((DERIVED
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0
((444 'il' (INTEGER 4 ()) () 0 0 ())) PRIVATE ())
406 'sr2' '' 404 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 445
()) 0 0 () () 0 () ())
390 'cf1' '' 389 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 446
()) 0 0 () () 0 () ())
391 'cf2' '' 389 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 446
()) 0 0 () () 0 () ())
394 'gridconn2' '' 392 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 447 ()) 0 0 () () 0 () ())
412 'gridconn2' '' 410 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 447 ()) 0 0 () () 0 () ())
400 'gridstatus2' '' 398 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 448 ()) 0 0 () () 0 () ())
393 'gridconn1' '' 392 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 447 ()) 0 0 () () 0 () ())
420 'sr1' '' 419 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 445
()) 0 0 () () 0 () ())
447 'esmf_gridconn' 'esmf_gridmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((449 'gridconn'
(INTEGER 4 ()) () 0 0 ())) PUBLIC ())
409 'gridstatus2' '' 407 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 448 ()) 0 0 () () 0 () ())
408 'gridstatus1' '' 407 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 448 ()) 0 0 () () 0 () ())
421 'sr2' '' 419 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 445
()) 0 0 () () 0 () ())
411 'gridconn1' '' 410 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 447 ()) 0 0 () () 0 () ())
216 's1' '' 215 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 105 ())
0 0 () () 0 () ())
312 'pf1' '' 311 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 333
()) 0 0 () () 0 () ())
313 'pf2' '' 311 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 333
()) 0 0 () () 0 () ())
424 'staggerloc2' '' 422 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 370 ()) 0 0 () () 0 () ())
418 'rl2' '' 416 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 440
()) 0 0 () () 0 () ())
445 'esmf_delayoutservicereply' 'esmf_delayoutmod' 1 ((DERIVED
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN) (UNKNOWN 0 ()) 0 0 () () 0 ((450
'value' (INTEGER 4 ()) () 0 0 ())) PRIVATE ())
399 'gridstatus1' '' 398 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (
DERIVED 448 ()) 0 0 () () 0 () ())
448 'esmf_gridstatus' 'esmf_gridmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((451
'gridstatus' (INTEGER 4 ()) () 0 0 ())) PUBLIC ())
402 's1' '' 401 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 126 ())
0 0 () () 0 () ())
388 's2' '' 386 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 126 ())
0 0 () () 0 () ())
68 'esmf_array' 'esmf_arraycreatemod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((452 'this' (
DERIVED 243 ()) () 0 0 ()) (453 'isinit' (INTEGER 8 ()) () 0 0 (
CONSTANT (INTEGER 4 ()) 0 '76838410'))) PRIVATE ())
70 'esmf_arraybundle' 'esmf_arraybundlemod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((454 'this' (
DERIVED 243 ()) () 0 0 ()) (455 'isinit' (INTEGER 8 ()) () 0 0 (
CONSTANT (INTEGER 4 ()) 0 '76838410'))) PRIVATE ())
78 'dh' '' 77 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 62 ())
0 0 () () 0 () ())
35 'esmf_redyne' 'esmf_statetypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 456 0 (457 458) () 35 () ())
458 's2' '' 456 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 94 ())
0 0 () () 0 () ())
72 'esmf_routehandle' 'esmf_rhandlemod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((459 'this' (
DERIVED 243 ()) () 0 0 ()) (460 'isinit' (INTEGER 8 ()) () 0 0 (
CONSTANT (INTEGER 4 ()) 0 '76838410'))) PRIVATE ())
36 'esmf_needne' 'esmf_statetypesmod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 461 0 (462 463) () 36 () ())
462 's1' '' 461 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 88 ())
0 0 () () 0 () ())
463 's2' '' 461 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 88 ())
0 0 () () 0 () ())
140 'sc' '' 139 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 74 ())
0 0 () () 0 () ())
405 'sr1' '' 404 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 445
()) 0 0 () () 0 () ())
457 's1' '' 456 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 94 ())
0 0 () () 0 () ())
81 'dh' '' 80 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 62 ())
0 0 () () 0 () ())
446 'esmf_copyflag' 'esmf_localarraycreatemod' 1 ((DERIVED
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0
((464 'docopy' (INTEGER 4 ()) () 0 0 ())) PRIVATE ())
440 'esmf_relloc' 'esmf_internarraydatamapmod' 1 ((DERIVED
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0
((465 'relloc' (INTEGER 4 ()) () 0 0 ())) PUBLIC ())
431 'io2' '' 429 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 441
()) 0 0 () () 0 () ())
60 'esmf_cfne' 'esmf_localarraycreatemod' 1 ((PROCEDURE UNKNOWN-INTENT
MODULE-PROC DECL FUNCTION) (LOGICAL 4 ()) 466 0 (467 468) () 60 () ())
467 'cf1' '' 466 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 446
()) 0 0 () () 0 () ())
468 'cf2' '' 466 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 446
()) 0 0 () () 0 () ())
)

('esmf_dataholdergetinit' 0 83 'esmf_dataholder' 0 62
'esmf_dataholdervalidate' 0 79 'esmf_dataholderinit' 0 76 'esmf_invalid'
0 86 'esmf_needed' 0 95 'esmf_neededflag' 0 88 'esmf_notready' 0 93
'esmf_notneeded' 0 90 'esmf_notrequired_for_restart' 0 91
'esmf_stateitem_fieldbundle' 0 168 'esmf_readytoread' 0 98
'esmf_readyflag' 0 94 'esmf_readytowrite' 0 97 'esmf_state_export' 0 146
'esmf_required_for_restart' 0 100 'esmf_reqforrestartflag' 0 92
'esmf_state' 0 101 'esmf_stateclassgetinit' 0 143 'esmf_state_invalid' 0
121 'esmf_state_import' 0 104 'esmf_stateclass' 0 74
'esmf_state_unspecified' 0 106 'esmf_stateitem_field' 0 142
'esmf_stateclassvalidate' 0 138 'esmf_stateitem' 0 119 'esmf_stategetinit'
0 122 'esmf_stateitem_arraybundle' 0 127 'esmf_stateitem_array' 0 125
'esmf_stateitemtype' 0 126 'esmf_stateiteminit' 0 156
'esmf_stateitemgetinit' 0 153 'esmf_stateitem_state' 0 152
'esmf_stateitem_routehandle' 0 150 'esmf_stateitem_notfound' 0 149
'esmf_stateitem_name' 0 148 'esmf_stateitem_indirect' 0 147
'esmf_stateitem_unknown' 0 151 'esmf_stateitemvalidate' 0 160
'esmf_statetype' 0 105 'esmf_valid' 0 167 'esmf_validityunknown' 0 166
'esmf_validflag' 0 87)
