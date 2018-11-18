100 REMark *** Measurement Data Import Filter
110 REMark 
120 REMark v1.00
130 REMark $$buff=4096
140 :
1000 in=0 : out=1
1010 PUT #out;19196||0           : REMark ID-word
1020 PRINT #out;'SPRD1.00';      : REMark Application / File version
1030 PUT #out;0||0,0||0          : REMark Grid size (unchanged)
1040 :
1050 nr$=""
1060 col%=0 : row%=0     : REMark column / row counter
1070 :
1080 REPeat loop
1090   IF EOF(#in) THEN EXIT loop
1100   INPUT #in;dat_line$
1110   dat_line$=dat_line$&" "
1120   FOR pos=1 TO LEN(dat_line$)
1130     IF dat_line$(pos) INSTR '0123456789+-.E'
1140       nr$=nr$&dat_line$(pos)
1150     ELSE 
1160       write_cell
1170     END IF 
1180   END FOR pos
1190   write_cell
1200   IF col%<>0 THEN row%=row%+1 : col%=0
1210 END REPeat loop
1220 PUT #out;-1||0,6||0,0||0            : REMark format numbers off
1230 CLOSE #in,#out
1240 :
1250 DEFine PROCedure write_cell
1260   IF nr$<>"" THEN 
1270      PUT #out;col%,row%,2||0,no_exp$(nr$)
1280      nr$=""
1290      col%=col%+1
1300   END IF 
1310 END DEFine 
1320 :
1330 DEFine FuNction no_exp$(x$)
1340    LOCal nr,b$(20),i
1350    nr=x$
1360    IF nr=0
1370      ndp=0
1380    ELSE 
1390      ndp=LOG10(ABS(nr))
1400      ndp=8-ndp-((ndp-INT(ndp))<>0)
1410    END IF 
1420    b$=FDEC$(nr,20,ndp)
1430    a$=""
1440    FOR i=1 TO LEN(b$) : IF b$(i)<>" " THEN a$=a$&b$(i)
1450    RETurn a$
1460 END DEFine 
