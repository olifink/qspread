10 REMark *** Import PSION _exp File Filter
20 REMark *** (must be compiled with QLib, Channels off!)
30 REMark 
40 REMark v1.00 - First version released
50 REMark v1.01 - col/row order corrected
60 REMark v1.02 - column width support (has to be in first row)
70 REMark         only column order import
80 REMark v1.04 - comments added (yes, I now it should have been done before)
90 :
100 REMark *
110 REMark * change  QLib's buffer space for really long lines
120 REMark $$buff=4096
130 :
140 :
1000 REMark read psion file from #1, and write QSpread file to #2
1010 in=0 : out=1
1020 nr_of_col='0'&READ_STRING$('Psion Import','20','Nr. of columns',20)
1030 nr_of_row='0'&READ_STRING$('Psion Import','20','Nr. of rows',20)
1040 IF nr_of_col<2 THEN nr_of_col=2
1050 IF nr_of_row<2 THEN nr_of_row=2
1060 :
1070 DIM wdth%(1024)                    : REMark Prepare column widths
1080 FOR wcnt=0 TO 1024 : wdth%(wcnt)=10
1090 wcnt=0
1100 :
1110 PUT #out;1914||0                   : REMark Initialisation code
1120 PRINT #out;'SPRD1.00';             : REMark Application ID/File format version
1130 PUT #out;nr_of_col||0,nr_of_row||0 : REMark Grid size
1140 cwdth=1
1150 :
1160 col%=0 : row%=0
1170 REPeat x
1180     IF EOF(#in) THEN EXIT x        : REMark In case we get to the edge
1190     BGET #in;a
1200     IF a=26 THEN EXIT x            : REMark PSION uses CTRL-Z as EOF
1210     INPUT #in;x$
1220     a$=CHR$(a)&x$                  : REMark this is the export file line
1230     IF LEN(a$) THEN a$=a$(1 TO LEN(a$)-1)  : REMark Strip the <CR> at the end
1240     :
1250     col%=0                         : REMark start at the first column
1260                                    : REMark no need to process an empty line
1270     IF a$="" THEN row%=row%+1 : NEXT x
1280     :
1290     cell$=""                       : REMark in here goes the cell content
1300     FOR i=1 TO LEN(a$)
1310                                    : REMark cell contents are seperated by ,'s
1320        IF a$(i)=","
1330           write_cell               : REMark yes, we got a complete cell
1340           cell$=""                 : REMark empty it for the next cell
1350        ELSE 
1360           cell$=cell$&a$(i)        : REMark continue collecting cell content
1370        END IF 
1380     END FOR i
1390     write_cell                     : REMark don't forget the last cell
1400     row%=row%+1                    : REMark and now continue with the next row
1410     :
1420     : REMark here comes the special code for writing columns widths info
1430     IF cwdth
1440       FOR wcnt=0 TO nr_of_col-1 : BPUT #out,wdth%(wcnt)
1450       cwdth=0
1460     END IF 
1470 END REPeat x
1480 CLOSE #in,#out                     : REMark Important!! close channels!!
1490 :
1500 DEFine PROCedure write_cell
1510    IF cwdth
1520     wdth%(wcnt)="0"&cell$(3 TO LEN(cell$)-2)
1530     wcnt=wcnt+1                    : REMark collect columns widths
1540    ELSE 
1550     format%=2                      : REMark assume numeric format
1560     check cell$                    : REMark check if cell is numeric
1570     IF cell$="" THEN RETurn        : REMark empty cell need no processing
1580                                    : REMark if it was a string, change format
1590     IF cell$(1)='"' THEN format%=2048
1600     PUT #out,col%,row%,format%,cell$ : REMark now write to the file
1610     col%=col%+1                    : REMark and go to the next column
1620    END IF 
1630 END DEFine 
1640 :
1650 REMark *
1660 REMark * This procedure checks if x$ may be considered as a number
1670 REMark * If not, it is changed so that it starts off with an "
1680 DEFine PROCedure check(x$)
1690    LOCal l,i,p(2)
1700    FOR i=0 TO 2:p(i)=0
1710    IF x$="" THEN RETurn 
1720    IF x$='""' THEN x$='"' : RETurn 
1730    IF x$(1)<>'"' THEN RETurn 
1740    x$=x$(1 TO LEN(x$)-1)
1750    l=LEN(x$)
1760    FOR i=2 TO l
1770      xx=x$(i) INSTR ".+-0123456789"
1780      IF xx=0 THEN RETurn 
1790      IF xx<4 THEN 
1800        IF p(xx-1) THEN RETurn : ELSE p(xx-1)=1
1810      END IF 
1820    END FOR i
1830    x$=x$(2 TO l)
1840 END DEFine 
