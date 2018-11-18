1035 PRINT "Init code:   ";
1040 GET #0,id% : PRINT "$";HEX$(id%,16)
1045 PRINT "Application: ";
1050 FOR i=1 TO 4 : BGET #0;byte : PRINT CHR$(byte);
1055 PRINT
1060 PRINT "Version:     ";
1070 FOR i=1 TO 4 : BGET #0;byte : PRINT CHR$(byte);
1080 PRINT
1090 PRINT "Columns:     ";
1100 GET #0;word% : PRINT word%
1105 columns=word%
1110 PRINT "Rows:        ";
1120 GET #0;word% : PRINT word%
1130 :
1135 PRINT "Width:       ";
1140 FOR i=1 TO columns
1150    BGET #0;wdth : PRINT wdth;", ";
1160 END FOR i
1170 PRINT
1180 :
1190 REPeat loop
1200    IF EOF(#0) THEN EXIT loop
1210    GET #0;word1%,word2%
1220    IF word1%=-1
1225      IF word2%>=0 THEN 
1230       PRINT "Environment code ";
1240       GET #0;envr%
1250       PRINT "#";word2%;" / value ";envr%
1255      ELSE 
1257       PRINT "Macro function #";-word2%;": ";
1258       GET #0;macr$
1259       PRINT macr$
1260      END IF 
1265    ELSE 
1270       PRINT "Cell ";word1%;"/";word2%;
1280       GET #0;format%,formular$
1290       PRINT "(";HEX$(format%,16);") :";formular$
1300    END IF 
1310 END REPeat loop
9999 CLOSE #0,#1
