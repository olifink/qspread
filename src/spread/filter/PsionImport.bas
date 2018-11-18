10 REMark *** Import PSION _exp File Filter
20 REMark *** (must be compiled with QLib, Channels off!)
30 REMark 
40 REMark v1.00 - First version released
50 REMark v1.01 - col/row order corrected
60 REMark v1.02 - column width support (has to be in first row)
70 REMark         only column order import
80 REMark v1.04 - comments added (yes, I now it should have been done before)
85 REMark v2.00 - Psion Export format too odd - new PsionExport Program
90 :
100 REMark *
110 REMark * change  QLib's buffer space for realy long lines
120 REMark $$buff=4096
130 :
140 :
1000 REMark read psion file from #1, and write QSpread file to #2
1010 in=0 : out=1
1020 INPUT #in;first_line$
1030 IF '"x$"' INSTR first_line$<>1 THEN 
1040    x=ITEM_SELECT('PsionImport Filter Error','wrong input file format','OK')
1050    CLOSE #in,#out
1052    STOP
1055 END IF 
1060 nr_of_col='0'&READ_STRING$('Psion Import','20','Nr. of columns',20)
1070 nr_of_row='0'&READ_STRING$('Psion Import','20','Nr. of rows',20)
1080 IF nr_of_col<2 THEN nr_of_col=2
1090 IF nr_of_row<2 THEN nr_of_row=2
1100 :
1110 DIM wdth%(1024)                    : REMark Prepare column widths
1120 FOR wcnt=0 TO 1024 : wdth%(wcnt)=10
1130 wcnt=0
1140 :
1150 PUT #out;19196||0                  : REMark Initialisation code
1160 PRINT #out;'SPRD1.00';             : REMark Application ID/File format version
1170 PUT #out;nr_of_col||0,nr_of_row||0 : REMark Grid size
1180 cwdth=1
1190 :
1200 col%=0 : row%=0
1210 INPUT #in,empty$
1220 REPeat x
1230     IF EOF(#in) THEN EXIT x        : REMark In case we get to the edge
1240     BGET #in;a
1250     IF a=26 THEN EXIT x            : REMark PSION uses CTRL-Z as EOF
1260     INPUT #in;x$
1270     a$=CHR$(a)&x$                  : REMark this is the export file line
1280     IF LEN(a$) THEN a$=a$(1 TO LEN(a$)-1)  : REMark Strip the <CR> at the end
1290     :
1300     col%=0                         : REMark start at the first column
1310                                    : REMark no need to process an empty line
1320     IF a$="" THEN row%=row%+1 : NEXT x
1330     :
1340     cell$=""                       : REMark in here goes the cell content
1350     FOR i=1 TO LEN(a$)
1360                                    : REMark cell contents are seperated by ,'s
1370        IF a$(i)=","
1380           write_cell               : REMark yes, we got a complete cell
1390           cell$=""                 : REMark empty it for the next cell
1400        ELSE 
1410           cell$=cell$&a$(i)        : REMark continue collecting cell content
1420        END IF 
1430     END FOR i
1440     write_cell                     : REMark don't forget the last cell
1450     row%=row%+1                    : REMark and now continue with the next row
1460     :
1470     : REMark here comes the special code for writing columns widths info
1480     IF cwdth
1490       FOR wcnt=0 TO nr_of_col-1 : BPUT #out,wdth%(wcnt)
1500       cwdth=0
1510     END IF 
1520 END REPeat x
1530 CLOSE #in,#out                     : REMark Important!! close channels!!
1540 :
1550 DEFine PROCedure write_cell
1560    IF cwdth
1570     check cell$
1580     wdth%(wcnt)=0&cell$
1590     wcnt=wcnt+1                    : REMark collect columns widths
1600    ELSE 
1610     format%=2                      : REMark assume numeric format
1620     check cell$                    : REMark check if cell is numeric
1630     IF cell$="" THEN RETurn        : REMark empty cell need no processing
1640                                    : REMark if it was a string, change format
1650     IF cell$(1)='"' THEN format%=2048
1660     PUT #out,col%,row%,format%,cell$ : REMark now write to the file
1670     col%=col%+1                    : REMark and go to the next column
1680    END IF 
1690 END DEFine 
1700 :
1710 REMark *
1720 REMark * This procedure checks if x$ may be considered as a number
1730 REMark * If not, it is changed so that it starts off with an "
1740 DEFine PROCedure check(x$)
1750    LOCal l,i,p(2)
1760    FOR i=0 TO 2:p(i)=0
1770    IF x$="" THEN RETurn 
1780    IF x$='""' THEN x$='"' : RETurn 
1790    IF x$(1)<>'"' THEN RETurn 
1800    x$=x$(1 TO LEN(x$)-1)
1810    l=LEN(x$)
1820    FOR i=2 TO l
1830      xx=x$(i) INSTR ".+-0123456789"
1840      IF xx=0 THEN RETurn 
1850      IF xx<4 THEN 
1860        IF p(xx-1) THEN RETurn : ELSE p(xx-1)=1
1870      END IF 
1880    END FOR i
1890    x$=x$(2 TO l)
1900 END DEFine 
