100 in=3 : out=4
105 CLS
110 OPEN #in,'ram1_aba'
500 DIM cwidth%(63),row%(254),onoff$(2,3)
505 onoff$(1)="off" : onoff$(2)="on"
510 :
1000 id$=INPUT$(#in,4)
1010 PRINT "Application: ";id$
1020 :
1030 dummy$=INPUT$(#in,6)
1040 :
1050 BGET #in;xused,yused
1060 PRINT "Used: ";xused+1;',';yused+1
1070 :
1080 dummy$=INPUT$(#in,6)
1090 :
1095 FOR i=0 TO 254 : BGET #in,row%(i)
1100 FOR i=0 TO 63 : BGET #in,cwidth%(i)
1110 :
1115 PRINT "Column width: ";
1120 FOR i=0 TO xused : PRINT cwidth%(i)-1;',';
1130 PRINT
1140 :
1150 PRINT "Lines used: ";
1160 FOR i=0 TO 254 : IF row%(i)<>0 THEN PRINT i+1;',';
1165 PRINT
1170 :
1180 BGET #in;auto_calc,blank_zero,calc_order,disp_width
1190 BGET #in;form_feed,gaps_lines,lines_page,mon_symb,paper_width
1200 :
1210 PRINT "Auto calculation on input: ";onoff$(auto_calc+1)
1220 PRINT "Blank if zero: ";onoff$(blank_zero+1)
1230 PRINT "Calculation order: ";PICK$(calc_order+1,"column","row")
1240 PRINT "Monetary Symbol: ";CHR$(mon_symb)
1250 :
1260 dummy$=INPUT$(#in,34)
1265 FOR r=0 TO 254
1267   FOR i=0 TO row%(r)-1
1270     get_repinfo
1275     PRINT r,get_strg$
1277   END FOR i
1278 END FOR r
1280 :
2000 DEFine PROCedure get_repinfo
2010   GET #in,info%,repetition%
2020   PRINT "Info: ";info%
2030   PRINT "Rept: ";repetition%
2040 END DEFine 
2050 :
2060 DEFine FuNction get_strg$
2070   GET #in,length%
2080   x$=INPUT$(#in,length%)
2085   RETurn x$
2090 END DEFine 
2100 STOP
9999 CLOSE
