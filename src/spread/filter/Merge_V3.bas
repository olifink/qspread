100 REMark *** Merge data into spreadsheet
110 REMark
120 REMark v2.00 - deals with all formats up to 1.04
130 :
140 in=0 : out=1
150 :
160 GET #in,id%
170 BGET#in,a1%,a2%,a3%,a4%
180 BGET#in,v1%,v2%,v3%,v4%
190 a$=CHR$(a1%)&CHR$(a2%)&CHR$(a3%)&CHR$(a4%)
200 v$=CHR$(v1%)&CHR$(v2%)&CHR$(v3%)&CHR$(v4%)
210 IF id%<>19196 OR a$<>"SPRD"
220    x=ITEM_SELECT('Merge Filter Error','wrong input file format','OK')
230    CLOSE #in,#out
240    STOP
250 END IF
260 IF v$(1 TO 3)<>"1.0" AND v$(4)>"4"
270    x=ITEM_SELECT('Merge Filter Error','wrong input file format','OK')
280    CLOSE #in,#out
290    STOP
300 END IF
310 :
320 PUT #out;id%
330 PRINT#out;a$;v$;
340 :
350 IF v$(4)>="3"
360  BGET#in,p1%,p2%,p3%,p4%
370  BPUT#out,p1%,p2%,p3%,p4%
380 END IF
390 GET #in,xs%,ys%
395 PUT #out,0||0,0||0
400 :
410 FOR x=1 TO xs% : BGET #in;dummy%
420 :
430 REPeat tilleof
440    IF EOF(#in) THEN EXIT tilleof
450    BGET #in;byte
460    BPUT #out;byte
470 END REPeat tilleof
480 CLOSE #in,#out
