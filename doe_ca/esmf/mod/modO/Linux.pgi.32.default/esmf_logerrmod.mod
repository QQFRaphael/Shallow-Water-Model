V23 esmf_logerrmod
67 /raid/don/doe_ca/esmf/src/Infrastructure/LogErr/src/ESMF_LogErr.F90 S527
05/10/2004  10:51:10
use esmf_basemod public 0
enduse
D 102 24 623 4 622 3
D 167 24 1008 4 1007 3
D 173 24 1013 76 1012 3
D 179 18 229
D 181 24 1020 156 1019 3
D 187 21 173 1 3 3 0 0 0 0 0
 0 3 3 3 3 3
S 527 24 0 0 0 8 1 0 3942 5 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 13 0 0 0 0 0 0 esmf_logerrmod
S 532 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 537 3 0 0 0 6 1 1 0 0 0 0 0 0 0 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
R 622 25 76 esmf_basemod esmf_logical
R 623 5 77 esmf_basemod value
S 1007 25 1 0 0 167 1 527 7056 800004 800000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 esmf_logfiletype
S 1008 5 0 0 0 6 1 527 7073 800004 0 0 0 0 0 167 0 0 0 0 0 0 0 0 0 0 0 1 1008 0 527 0 0 0 0 ftype
S 1009 6 4 0 0 167 1010 527 7079 80004c 400000 0 0 0 0 0 0 0 0 1043 0 0 0 0 0 0 0 0 224 0 527 0 0 0 0 esmf_log_info
S 1010 6 4 0 0 167 1011 527 7093 80004c 400000 0 4 0 0 0 0 0 0 1043 0 0 0 0 0 0 0 0 226 0 527 0 0 0 0 esmf_log_warning
S 1011 6 4 0 0 167 1042 527 7110 80004c 400000 0 8 0 0 0 0 0 0 1043 0 0 0 0 0 0 0 0 228 0 527 0 0 0 0 esmf_log_error
S 1012 25 0 0 0 173 1 527 7125 800004 800000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 esmf_logentry
S 1013 5 0 0 0 6 1014 527 7139 800014 0 0 0 0 0 173 0 0 0 0 0 0 0 0 0 0 0 1 1013 0 527 0 0 0 0 number
S 1014 5 0 0 0 6 1015 527 7146 800014 0 0 4 0 0 173 0 0 0 0 0 0 0 0 0 0 0 1013 1014 0 527 0 0 0 0 pe_number
S 1015 5 0 0 0 6 1017 527 7156 800014 0 0 8 0 0 173 0 0 0 0 0 0 0 0 0 0 0 1014 1015 0 527 0 0 0 0 err_type
S 1016 3 0 0 0 6 0 1 0 0 0 0 0 0 0 0 32 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6
S 1017 5 0 0 0 179 1018 527 7165 800014 0 0 12 0 0 173 0 0 0 0 0 0 0 0 0 0 0 1015 1017 0 527 0 0 0 0 mod_name
S 1018 5 0 0 0 179 1 527 7174 800014 0 0 44 0 0 173 0 0 0 0 0 0 0 0 0 0 0 1017 1018 0 527 0 0 0 0 context
S 1019 25 0 0 0 181 1 527 7182 800004 800000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 esmf_log
S 1020 5 0 0 0 102 1021 527 7191 800014 0 0 0 0 0 181 0 0 0 0 0 0 0 0 0 0 0 1 1020 0 527 0 0 0 0 fileisopen
S 1021 5 0 0 0 6 1022 527 7202 800014 0 0 4 0 0 181 0 0 0 0 0 0 0 0 0 0 0 1020 1021 0 527 0 0 0 0 unitnumber
S 1022 5 0 0 0 102 1023 527 7213 800014 0 0 8 0 0 181 0 0 0 0 0 0 0 0 0 0 0 1021 1022 0 527 0 0 0 0 verbose
S 1023 5 0 0 0 102 1024 527 7221 800014 0 0 12 0 0 181 0 0 0 0 0 0 0 0 0 0 0 1022 1023 0 527 0 0 0 0 flush
S 1024 5 0 0 0 102 1025 527 7227 800014 0 0 16 0 0 181 0 0 0 0 0 0 0 0 0 0 0 1023 1024 0 527 0 0 0 0 root_only
S 1025 5 0 0 0 6 1026 527 7237 800014 0 0 20 0 0 181 0 0 0 0 0 0 0 0 0 0 0 1024 1025 0 527 0 0 0 0 halt
S 1026 5 0 0 0 167 1027 527 7242 800014 0 0 24 0 0 181 0 0 0 0 0 0 0 0 0 0 0 1025 1026 0 527 0 0 0 0 logtype
S 1027 5 0 0 0 6 1028 527 7250 800014 0 0 28 0 0 181 0 0 0 0 0 0 0 0 0 0 0 1026 1027 0 527 0 0 0 0 stream
S 1028 5 0 0 0 6 1029 527 7257 800014 0 0 32 0 0 181 0 0 0 0 0 0 0 0 0 0 0 1027 1028 0 527 0 0 0 0 max_elements
S 1029 5 0 0 0 187 1030 527 7270 800014 0 0 36 0 0 181 0 0 0 0 0 0 0 0 0 0 0 1028 1029 0 527 0 0 0 0 log_entry
S 1030 5 0 0 0 179 1031 527 7280 800014 0 0 112 0 0 181 0 0 0 0 0 0 0 0 0 0 0 1029 1030 0 527 0 0 0 0 namelogerrfile
S 1031 5 0 0 0 6 1032 527 7295 800014 0 0 144 0 0 181 0 0 0 0 0 0 0 0 0 0 0 1030 1031 0 527 0 0 0 0 maxtryopen
S 1032 5 0 0 0 6 1033 527 7306 800014 0 0 148 0 0 181 0 0 0 0 0 0 0 0 0 0 0 1031 1032 0 527 0 0 0 0 stdoutunitnumber
S 1033 5 0 0 0 102 1 527 7323 800014 0 0 152 0 0 181 0 0 0 0 0 0 0 0 0 0 0 1032 1033 0 527 0 0 0 0 fileio
S 1034 27 0 0 0 8 1048 527 7330 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 esmf_logopen
S 1035 27 0 0 0 8 1044 527 7343 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 esmf_logclose
S 1036 27 0 0 0 8 1053 527 7357 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 esmf_logwrite
S 1037 27 0 0 0 8 1092 527 7371 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 esmf_loginitialize
S 1038 27 0 0 0 8 1096 527 7390 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 esmf_logfinalize
S 1039 27 0 0 0 8 1061 527 7407 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 esmf_logfounderror
S 1040 27 0 0 0 8 1070 527 7426 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 esmf_logset
S 1041 27 0 0 0 8 1081 527 7438 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 esmf_logget
S 1042 6 4 0 0 181 1 527 7450 4 0 0 12 0 0 0 0 0 0 1043 0 0 0 0 0 0 0 0 0 0 527 0 0 0 0 glog
S 1043 11 0 0 0 8 692 527 7455 40800000 801000 0 168 0 0 1009 1042 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_logerrmod$0
S 1044 23 5 0 0 0 1047 527 7343 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_logclose
S 1045 1 3 2 0 6 1 1044 7472 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 1046 1 3 0 0 181 1 1044 78 4 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 alog
S 1047 14 5 0 0 0 1 1044 7343 0 400000 0 0 0 198 2 0 0 0 0 0 0 0 0 0 0 0 0 113 0 527 0 0 0 0 esmf_logclose
F 1047 2 1046 1045
S 1048 23 5 0 0 0 1052 527 7330 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_logopen
S 1049 1 3 0 0 28 1 1048 7475 4 43000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 filename
S 1050 1 3 2 0 6 1 1048 7484 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 1051 1 3 0 0 181 1 1048 78 4 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 alog
S 1052 14 5 0 0 0 1 1048 7330 0 400000 0 0 0 201 3 0 0 0 0 0 0 0 0 0 0 0 0 158 0 527 0 0 0 0 esmf_logopen
F 1052 3 1051 1049 1050
S 1053 23 5 0 0 0 1060 527 7357 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_logwrite
S 1054 1 3 1 0 28 1 1053 7487 4 43000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 msg
S 1055 1 3 1 0 28 1 1053 7491 80000004 43000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 module
S 1056 1 3 1 0 28 1 1053 7498 80000004 43000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 method
S 1057 1 3 2 0 6 1 1053 7505 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 1058 1 3 1 0 167 1 1053 7242 4 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 logtype
S 1059 1 3 1 0 181 1 1053 78 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 alog
S 1060 14 5 0 0 0 1 1053 7357 0 400000 0 0 0 205 6 0 0 0 0 0 0 0 0 0 0 0 0 207 0 527 0 0 0 0 esmf_logwrite
F 1060 6 1054 1058 1055 1056 1057 1059
S 1061 23 5 0 0 8 1068 527 7407 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_logfounderror
S 1062 1 3 1 0 6 1 1061 7508 4 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 1063 1 3 1 0 28 1 1061 7511 80000004 43000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 msg
S 1064 1 3 1 0 28 1 1061 7515 80000004 43000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 module
S 1065 1 3 1 0 28 1 1061 7522 80000004 43000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 method
S 1066 1 3 1 0 167 1 1061 7242 4 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 logtype
S 1067 1 3 1 0 181 1 1061 78 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 alog
S 1068 14 5 0 0 16 1 1061 7407 4 400000 0 0 0 212 6 0 0 1069 0 0 0 0 0 0 0 0 0 354 0 527 0 0 0 0 esmf_logfounderror
F 1068 6 1062 1063 1066 1064 1065 1067
S 1069 1 3 0 0 16 1 1061 7407 4 1003000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_logfounderror
S 1070 23 5 0 0 0 1080 527 7426 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_logset
S 1071 1 3 2 0 6 1 1070 7529 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 1072 1 3 0 0 181 1 1070 78 4 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 alog
S 1073 1 3 1 0 102 1 1070 7213 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 verbose
S 1074 1 3 1 0 102 1 1070 7221 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 flush
S 1075 1 3 1 0 102 1 1070 7227 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 root_only
S 1076 1 3 1 0 6 1 1070 7237 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 halt
S 1077 1 3 1 0 167 1 1070 7242 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 logtype
S 1078 1 3 1 0 6 1 1070 7250 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 stream
S 1079 1 3 1 0 6 1 1070 7257 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 max_elements
S 1080 14 5 0 0 0 1 1070 7426 0 400000 0 0 0 219 9 0 0 0 0 0 0 0 0 0 0 0 0 409 0 527 0 0 0 0 esmf_logset
F 1080 9 1072 1073 1074 1075 1076 1077 1078 1079 1071
S 1081 23 5 0 0 0 1091 527 7438 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_logget
S 1082 1 3 2 0 6 1 1081 7532 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 1083 1 3 1 0 181 1 1081 78 4 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 alog
S 1084 1 3 2 0 102 1 1081 7213 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 verbose
S 1085 1 3 2 0 102 1 1081 7221 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 flush
S 1086 1 3 2 0 102 1 1081 7227 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 root_only
S 1087 1 3 2 0 6 1 1081 7237 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 halt
S 1088 1 3 1 0 167 1 1081 7242 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 logtype
S 1089 1 3 2 0 6 1 1081 7250 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 stream
S 1090 1 3 2 0 6 1 1081 7257 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 max_elements
S 1091 14 5 0 0 0 1 1081 7438 0 400000 0 0 0 229 9 0 0 0 0 0 0 0 0 0 0 0 0 459 0 527 0 0 0 0 esmf_logget
F 1091 9 1083 1084 1085 1086 1087 1088 1089 1090 1082
S 1092 23 5 0 0 0 1095 527 7371 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_loginitialize
S 1093 1 3 0 0 28 1 1092 7535 4 43000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 filename
S 1094 1 3 2 0 6 1 1092 7544 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 1095 14 5 0 0 0 1 1092 7371 0 400000 0 0 0 239 2 0 0 0 0 0 0 0 0 0 0 0 0 527 0 527 0 0 0 0 esmf_loginitialize
F 1095 2 1093 1094
S 1096 23 5 0 0 0 1098 527 7390 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 esmf_logfinalize
S 1097 1 3 2 0 6 1 1096 7547 80000004 3000 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 rc
S 1098 14 5 0 0 0 1 1096 7390 0 400000 0 0 0 242 1 0 0 0 0 0 0 0 0 0 0 0 0 572 0 527 0 0 0 0 esmf_logfinalize
F 1098 1 1097
A 21 2 0 0 20 6 532 0 0 0 21 0 0 0 0 0 0 0 0 0
A 32 2 0 0 26 6 537 0 0 0 32 0 0 0 0 0 0 0 0 0
A 223 15 0 0 0 6 1008 3 0 0 0 0 0 0 0 0 0 0 0 0
A 224 15 0 0 0 167 1009 223 0 0 0 0 0 0 0 0 0 0 0 0
A 225 15 0 0 0 6 1008 32 0 0 0 0 0 0 0 0 0 0 0 0
A 226 15 0 0 0 167 1010 225 0 0 0 0 0 0 0 0 0 0 0 0
A 227 15 0 0 0 6 1008 21 0 0 0 0 0 0 0 0 0 0 0 0
A 228 15 0 0 0 167 1011 227 0 0 0 0 0 0 0 0 0 0 0 0
A 229 2 0 0 0 6 1016 0 0 0 229 0 0 0 0 0 0 0 0 0
Z
