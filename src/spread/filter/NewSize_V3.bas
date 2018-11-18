100 REMark *** Load data with new sheetsize
110 REMark
120 REMark v2.00 - deals with all formats up to 1.04
130 :
140 in=0 : out=1
150 :
160 DIM cwdt%(1024) : FOR i=0 TO 1024 : cwdt%(i)=10
170 :
180 GET #in,id%
190 BGET#in,a1%,a2%,a3%,a4%
200 BGET#in,v1%,v2%,v3%,v4%
210 a$=CHR$(a1%)&CHR$(a2%)&CHR$(a3%)&CHR$(a4%)
220 v$=CHR$(v1%)&CHR$(v2%)&CHR$(v3%)&CHR$(v4%)
230 IF id%<>19196 OR a$<>"SPRD"
240    x=ITEM_SELECT('NewSize Filter Error','wrong input file format','OK')
250    CLOSE #in,#out
260    STOP
270 END IF
280 IF v$(1 TO 3)<>"1.0" AND v$(4)>"4"
290    x=ITEM_SELECT('NewSize Filter Error','wrong input file format','OK')
300    CLOSE #in,#out
310    STOP
320 END IF
330 :
340 PUT #out;id%
350 PRINT#out;a$;v$;
360 :
370 IF v$(4)>="3"
380  BGET#in,p1%,p2%,p3%,p4%
390  BPUT#out,p1%,p2%,p3%,p4%
400 END IF
410 GET #in,xs%,ys%
420 old_col=xs%
430 :
440 nr_of_col='0'&READ_STRING$('NewSize',''&xs%,'Nr. of columns',20)
445 IF nr_of_col<xs%:GO TO 440
450 nr_of_row='0'&READ_STRING$('NewSize',''&ys%,'Nr. of rows',20)
455 IF nr_of_row<xs%:GO TO 450
460 xs%=nr_of_col
470 ys%=nr_of_row
475 PUT#out,xs%,ys%
480 :
485 FOR x=1 TO old_col : BGET #in;cwdt%(x)
487 FOR x=1 TO nr_of_col : BPUT #out;cwdt%(x)
490 :
500 REPeat tilleof
510    IF EOF(#in) THEN EXIT tilleof
520    BGET #in;byte
530    BPUT #out;byte
540 END REPeat tilleof
550 CLOSE #in,#out
