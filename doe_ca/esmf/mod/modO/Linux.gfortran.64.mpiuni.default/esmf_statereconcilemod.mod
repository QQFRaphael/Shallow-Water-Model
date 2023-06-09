GFORTRAN module created from /Users/dazlich/doe_ca/esmf/src/Superstructure/State/src/ESMF_StateReconcile.F90 on Mon Sep 10 14:58:30 2012
If you edit this, you'll get what you deserve.

(() () () () () ()
() () () () () () () () () () () () () () ())

()

()

()

()

(2 'esmf_statereconcile' 'esmf_statereconcilemod' 1 ((PROCEDURE
UNKNOWN-INTENT MODULE-PROC DECL SUBROUTINE ALWAYS_EXPLICIT) (UNKNOWN 0 ())
3 0 (4 5 6 7) () 0 () ())
7 'rc' '' 3 ((VARIABLE OUT UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
INTEGER 4 ()) 0 0 () () 0 () ())
6 'options' '' 3 ((VARIABLE IN UNKNOWN-PROC UNKNOWN OPTIONAL DUMMY) (
CHARACTER 1 (())) 0 0 () () 0 () ())
5 'vm' '' 3 ((VARIABLE IN UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 8 ()) 0 0
() () 0 () ())
8 'esmf_vm' 'esmf_vmmod' 1 ((DERIVED UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN
SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((9 'this' (DERIVED 10 ()) () 0 0 ())
(11 'isinit' (INTEGER 8 ()) () 0 0 (CONSTANT (INTEGER 4 ()) 0 '76838410')))
PRIVATE ())
10 'esmf_pointer' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((12 'ptr' (
INTEGER 8 ()) () 0 0 ())) PUBLIC ())
4 'state' '' 3 ((VARIABLE INOUT UNKNOWN-PROC UNKNOWN DUMMY) (DERIVED 13
()) 0 0 () () 0 () ())
13 'esmf_state' 'esmf_statetypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (UNKNOWN 0 ()) 0 0 () () 0 ((14 'statep' (DERIVED
15 ()) () 0 1 (NULL (UNKNOWN 0 ()) 0)) (16 'isinit' (INTEGER 8 ()) () 0
0 (CONSTANT (INTEGER 4 ()) 0 '76838410'))) PUBLIC ())
15 'esmf_stateclass' 'esmf_statetypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (UNKNOWN 0 ()) 0 0 () () 0 ((17 'base' (DERIVED 18
()) () 0 0 (STRUCTURE (DERIVED 18 ()) 0 ((() ()) ((CONSTANT (INTEGER 4 ())
0 '76838410') ())) ())) (19 'statestatus' (DERIVED 20 ()) () 0 0 ()) (
21 'st' (DERIVED 22 ()) () 0 0 ()) (23 'needed_default' (DERIVED 24 ())
() 0 0 ()) (25 'ready_default' (DERIVED 26 ()) () 0 0 ()) (27
'stvalid_default' (DERIVED 28 ()) () 0 0 ()) (29 'reqrestart_default' (
DERIVED 30 ()) () 0 0 ()) (31 'alloccount' (INTEGER 4 ()) () 0 0 ()) (
32 'datacount' (INTEGER 4 ()) () 0 0 ()) (33 'datalist' (DERIVED 34 ())
(1 DEFERRED () ()) 1 1 ()) (35 'isinit' (INTEGER 8 ()) () 0 0 (CONSTANT
(INTEGER 4 ()) 0 '76838410'))) PUBLIC ())
30 'esmf_reqforrestartflag' 'esmf_statetypesmod' 1 ((DERIVED
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0
((36 'required4restart' (INTEGER 4 ()) () 0 0 ())) PUBLIC ())
34 'esmf_stateitem' 'esmf_statetypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (UNKNOWN 0 ()) 0 0 () () 0 ((37 'datap' (DERIVED
38 ()) () 0 0 (STRUCTURE (DERIVED 38 ()) 0 (((STRUCTURE (DERIVED 39 ())
0 ((() ()) ((CONSTANT (INTEGER 4 ()) 0 '76838410') ())) ()) ()) ((
STRUCTURE (DERIVED 40 ()) 0 ((() ()) ((CONSTANT (INTEGER 4 ()) 0
'76838410') ())) ()) ()) ((STRUCTURE (DERIVED 41 ()) 0 ((() ()) ((
CONSTANT (INTEGER 4 ()) 0 '76838410') ())) ()) ()) ((STRUCTURE (DERIVED
42 ()) 0 ((() ()) ((CONSTANT (INTEGER 4 ()) 0 '76838410') ())) ()) ()) (
(STRUCTURE (DERIVED 43 ()) 0 ((() ()) ((CONSTANT (INTEGER 4 ()) 0
'76838410') ())) ()) ()) (() ()) ((CONSTANT (INTEGER 4 ()) 0 '76838410')
())) ())) (44 'otype' (DERIVED 45 ()) () 0 0 ()) (46 'needed' (DERIVED
24 ()) () 0 0 ()) (47 'ready' (DERIVED 26 ()) () 0 0 ()) (48 'valid' (
DERIVED 28 ()) () 0 0 ()) (49 'reqrestart' (DERIVED 30 ()) () 0 0 ()) (
50 'proxyflag' (LOGICAL 4 ()) () 0 0 ()) (51 'indirect_index' (INTEGER 4
()) () 0 0 ()) (52 'namep' (CHARACTER 1 ((CONSTANT (INTEGER 4 ()) 0 '128')))
() 0 0 ()) (53 'isinit' (INTEGER 8 ()) () 0 0 (CONSTANT (INTEGER 4 ()) 0
'76838410'))) PUBLIC ())
26 'esmf_readyflag' 'esmf_statetypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((54 'ready' (
INTEGER 4 ()) () 0 0 ())) PUBLIC ())
18 'esmf_base' 'esmf_basemod' 1 ((DERIVED UNKNOWN-INTENT UNKNOWN-PROC
UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((55 'this' (DERIVED 10 ())
() 0 0 ()) (56 'isinit' (INTEGER 8 ()) () 0 0 (CONSTANT (INTEGER 4 ()) 0
'76838410'))) PUBLIC ())
20 'esmf_status' 'esmf_utiltypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((57 'status'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
22 'esmf_statetype' 'esmf_statetypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((58 'state' (
INTEGER 4 ()) () 0 0 ())) PUBLIC ())
45 'esmf_stateitemtype' 'esmf_statetypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((59 'ot' (
INTEGER 4 ()) () 0 0 ())) PUBLIC ())
40 'esmf_fieldbundle' 'esmf_fieldbundlemod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((60 'btypep'
(DERIVED 61 ()) () 0 1 ()) (62 'isinit' (INTEGER 8 ()) () 0 0 (CONSTANT
(INTEGER 4 ()) 0 '76838410'))) PUBLIC ())
61 'esmf_fieldbundletype' 'esmf_fieldbundlemod' 1 ((DERIVED
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0
((63 'base' (DERIVED 18 ()) () 0 0 (STRUCTURE (DERIVED 18 ()) 0 ((() ())
((CONSTANT (INTEGER 4 ()) 0 '76838410') ())) ())) (64 'flist' (DERIVED
39 ()) (1 DEFERRED () ()) 1 1 ()) (65 'bundlestatus' (DERIVED 20 ()) ()
0 0 ()) (66 'gridstatus' (DERIVED 20 ()) () 0 0 ()) (67 'grid' (DERIVED
68 ()) () 0 0 (STRUCTURE (DERIVED 68 ()) 0 ((() ()) ((CONSTANT (INTEGER
4 ()) 0 '76838410') ())) ())) (69 'localbundle' (DERIVED 70 ()) () 0 0 (
STRUCTURE (DERIVED 70 ()) 0 (((STRUCTURE (DERIVED 71 ()) 0 ((() ()) ((
CONSTANT (INTEGER 4 ()) 0 '76838410') ())) ()) ()) (() ()) (() ()) (() ())
((CONSTANT (INTEGER 4 ()) 0 '76838410') ())) ())) (72 'pack_flag' (
DERIVED 73 ()) () 0 0 ()) (74 'iospec' (DERIVED 75 ()) () 0 0 ()) (76
'iostatus' (DERIVED 20 ()) () 0 0 ()) (77 'iscongruent' (LOGICAL 4 ()) ()
0 0 ()) (78 'haspattern' (LOGICAL 4 ()) () 0 0 ()) (79 'is_proxy' (
LOGICAL 4 ()) () 0 0 ()) (80 'field_count' (INTEGER 4 ()) () 0 0 ()) (
81 'isinit' (INTEGER 8 ()) () 0 0 (CONSTANT (INTEGER 4 ()) 0 '76838410')))
PUBLIC ())
75 'esmf_iospec' 'esmf_iospecmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((82 'iostatus'
(DERIVED 20 ()) () 0 0 ()) (83 'iofileformat' (DERIVED 84 ()) () 0 0 ())
(85 'iorwtype' (DERIVED 86 ()) () 0 0 ()) (87 'filename' (CHARACTER 1 (
(CONSTANT (INTEGER 4 ()) 0 '128'))) () 0 0 ()) (88 'asyncio' (LOGICAL 4
()) () 0 0 ())) PRIVATE ())
86 'esmf_iorwtype' 'esmf_iospecmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((89 'iorwtype'
(INTEGER 4 ()) () 0 0 ())) PRIVATE ())
84 'esmf_iofileformat' 'esmf_iospecmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((90
'iofileformat' (INTEGER 4 ()) () 0 0 ())) PRIVATE ())
68 'esmf_grid' 'esmf_gridmod' 1 ((DERIVED UNKNOWN-INTENT UNKNOWN-PROC
UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((91 'this' (DERIVED 10 ())
() 0 0 ()) (92 'isinit' (INTEGER 8 ()) () 0 0 (CONSTANT (INTEGER 4 ()) 0
'76838410'))) PUBLIC ())
70 'esmf_localfieldbundle' 'esmf_fieldbundlemod' 1 ((DERIVED
UNKNOWN-INTENT UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0
((93 'packed_data' (DERIVED 71 ()) () 0 0 (STRUCTURE (DERIVED 71 ()) 0 (
(() ()) ((CONSTANT (INTEGER 4 ()) 0 '76838410') ())) ())) (94 'gridstatus'
(DERIVED 20 ()) () 0 0 ()) (95 'arraystatus' (DERIVED 20 ()) () 0 0 ())
(96 'accesscount' (INTEGER 4 ()) () 0 0 ()) (97 'isinit' (INTEGER 8 ())
() 0 0 (CONSTANT (INTEGER 4 ()) 0 '76838410'))) PUBLIC ())
73 'esmf_packflag' 'esmf_fieldbundlemod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((98 'packflag'
(INTEGER 4 ()) () 0 0 ())) PUBLIC ())
38 'esmf_dataholder' 'esmf_statetypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN) (UNKNOWN 0 ()) 0 0 () () 0 ((99 'fp' (DERIVED 39 ())
() 0 0 (STRUCTURE (DERIVED 39 ()) 0 ((() ()) ((CONSTANT (INTEGER 4 ()) 0
'76838410') ())) ())) (100 'fbp' (DERIVED 40 ()) () 0 0 (STRUCTURE (
DERIVED 40 ()) 0 ((() ()) ((CONSTANT (INTEGER 4 ()) 0 '76838410') ())) ()))
(101 'ap' (DERIVED 41 ()) () 0 0 (STRUCTURE (DERIVED 41 ()) 0 ((() ()) (
(CONSTANT (INTEGER 4 ()) 0 '76838410') ())) ())) (102 'abp' (DERIVED 42
()) () 0 0 (STRUCTURE (DERIVED 42 ()) 0 ((() ()) ((CONSTANT (INTEGER 4 ())
0 '76838410') ())) ())) (103 'rp' (DERIVED 43 ()) () 0 0 (STRUCTURE (
DERIVED 43 ()) 0 ((() ()) ((CONSTANT (INTEGER 4 ()) 0 '76838410') ())) ()))
(104 'spp' (DERIVED 15 ()) () 0 1 ()) (105 'isinit' (INTEGER 8 ()) () 0
0 (CONSTANT (INTEGER 4 ()) 0 '76838410'))) PUBLIC ())
71 'esmf_internarray' 'esmf_internarraymod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((106 'this' (
DERIVED 10 ()) () 0 0 ()) (107 'isinit' (INTEGER 8 ()) () 0 0 (CONSTANT
(INTEGER 4 ()) 0 '76838410'))) PUBLIC ())
28 'esmf_validflag' 'esmf_statetypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((108 'valid'
(INTEGER 4 ()) () 0 0 ())) PUBLIC ())
39 'esmf_field' 'esmf_fieldmod' 1 ((DERIVED UNKNOWN-INTENT UNKNOWN-PROC
UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((109 'ftypep' (DERIVED 110
()) () 0 1 ()) (111 'isinit' (INTEGER 8 ()) () 0 0 (CONSTANT (INTEGER 4
()) 0 '76838410'))) PUBLIC ())
110 'esmf_fieldtype' 'esmf_fieldmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((112 'base' (
DERIVED 18 ()) () 0 0 (STRUCTURE (DERIVED 18 ()) 0 ((() ()) ((CONSTANT (
INTEGER 4 ()) 0 '76838410') ())) ())) (113 'array' (DERIVED 41 ()) () 0
0 (STRUCTURE (DERIVED 41 ()) 0 ((() ()) ((CONSTANT (INTEGER 4 ()) 0
'76838410') ())) ())) (114 'grid' (DERIVED 68 ()) () 0 0 (STRUCTURE (
DERIVED 68 ()) 0 ((() ()) ((CONSTANT (INTEGER 4 ()) 0 '76838410') ())) ()))
(115 'fieldstatus' (DERIVED 20 ()) () 0 0 ()) (116 'gridstatus' (
DERIVED 20 ()) () 0 0 ()) (117 'datastatus' (DERIVED 20 ()) () 0 0 ()) (
118 'iospec' (DERIVED 75 ()) () 0 0 ()) (119 'iostatus' (DERIVED 20 ())
() 0 0 ()) (120 'staggerloc' (DERIVED 121 ()) () 0 0 ()) (122
'array_internal' (LOGICAL 4 ()) () 0 0 ()) (123 'is_proxy' (LOGICAL 4 ())
() 0 0 ()) (124 'gridtofieldmap' (INTEGER 4 ()) (1 EXPLICIT (CONSTANT (
INTEGER 4 ()) 0 '1') (CONSTANT (INTEGER 4 ()) 0 '7')) 1 0 ()) (125
'ungriddedlbound' (INTEGER 4 ()) (1 EXPLICIT (CONSTANT (INTEGER 4 ()) 0
'1') (CONSTANT (INTEGER 4 ()) 0 '7')) 1 0 ()) (126 'ungriddedubound' (
INTEGER 4 ()) (1 EXPLICIT (CONSTANT (INTEGER 4 ()) 0 '1') (CONSTANT (
INTEGER 4 ()) 0 '7')) 1 0 ()) (127 'maxhalolwidth' (INTEGER 4 ()) (1
EXPLICIT (CONSTANT (INTEGER 4 ()) 0 '1') (CONSTANT (INTEGER 4 ()) 0 '7'))
1 0 ()) (128 'maxhalouwidth' (INTEGER 4 ()) (1 EXPLICIT (CONSTANT (
INTEGER 4 ()) 0 '1') (CONSTANT (INTEGER 4 ()) 0 '7')) 1 0 ()) (129
'isinit' (INTEGER 8 ()) () 0 0 (CONSTANT (INTEGER 4 ()) 0 '76838410')))
PUBLIC ())
121 'esmf_staggerloc' 'esmf_staggerlocmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((130
'staggerloc' (INTEGER 4 ()) () 0 0 ())) PUBLIC ())
41 'esmf_array' 'esmf_arraycreatemod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((131 'this' (
DERIVED 10 ()) () 0 0 ()) (132 'isinit' (INTEGER 8 ()) () 0 0 (CONSTANT
(INTEGER 4 ()) 0 '76838410'))) PRIVATE ())
24 'esmf_neededflag' 'esmf_statetypesmod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((133 'needed'
(INTEGER 4 ()) () 0 0 ())) PUBLIC ())
43 'esmf_routehandle' 'esmf_rhandlemod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((134 'this' (
DERIVED 10 ()) () 0 0 ()) (135 'isinit' (INTEGER 8 ()) () 0 0 (CONSTANT
(INTEGER 4 ()) 0 '76838410'))) PRIVATE ())
42 'esmf_arraybundle' 'esmf_arraybundlemod' 1 ((DERIVED UNKNOWN-INTENT
UNKNOWN-PROC UNKNOWN SEQUENCE) (UNKNOWN 0 ()) 0 0 () () 0 ((136 'this' (
DERIVED 10 ()) () 0 0 ()) (137 'isinit' (INTEGER 8 ()) () 0 0 (CONSTANT
(INTEGER 4 ()) 0 '76838410'))) PRIVATE ())
)

('esmf_statereconcile' 0 2)
