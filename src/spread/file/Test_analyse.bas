1000 CLS
1010 INPUT "QSpread file for analysis> ";file$
1020 OPEN_IN #3,file$
1027 :
1035 PRINT "Init code:   ";
1040 GET #3,id% : PRINT "$";HEX$(id%,16)
1045 PRINT "Application: ";
1050 FOR i=1 TO 4 : BGET byte : PRINT CHR$(byte);
1055 PRINT
1060 PRINT "Version:     ";
1070 FOR i=1 TO 4 : BGET byte : PRINT CHR$(byte);
1080 PRINT
1090 PRINT "Columns:     ";
1100 GET word% : PRINT word%
1105 columns=word%
1110 PRINT "Rows:        ";
1120 GET word% : PRINT word%
1130 :
1135 PRINT "Width:       ";
1140 FOR i=1 TO columns
1150    BGET #3;wdth : PRINT wdth;", ";
1160 END FOR i
1170 PRINT
1180 :
1190 REPeat loop
1200    IF EOF(#3) THEN EXIT loop
1210    GET #3;word1%,word2%
1220    IF word1%=-1
1230       PRINT "Environment code ";
1240       GET #3;envr%
1250       PRINT "#";word2%;" / value ";envr%
1260    ELSE 
1270       PRINT "Cell ";word1%;"/";word2%;
1280       GET #3;format%,formular$
1290       PRINT "(";HEX$(format%,16);") :";formular$
1300    END IF 
1310 END REPeat loop
9999 CLOSE #3
