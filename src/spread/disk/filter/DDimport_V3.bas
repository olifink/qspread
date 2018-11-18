10 REMark $$buff=10240
100 in_ch=0 : out_ch=1
105 REMark OPEN #3,'win1_util_utilites_ddf' : OPEN_NEW #4,'ram1_test_tab'
110 ddid$=INPUT$(#in_ch;10)             : REMark get DATAdesign id
120 ddlevel=-1
130 IF ddid$='DATAdesign' THEN ddlevel=0
140 IF ddid$='DATAdsgn01' THEN ddlevel=1
150 IF ddid$='DATAdsgn02' THEN ddlevel=2
160 :
170 IF ddlevel<0 THEN
180   x=ITEM_SELECT('ERROR','Not a valid DATAdesign file!','OK')
190   CLOSE #in_ch,#out_ch
200   STOP
210 ELSE
240   GET #in_ch;ddlenblk%,ddfields%,ddfieldlen%
250   ddfields$=INPUT$(#in_ch,ddlenblk%-4)
260 END IF
280 IF ddlevel=0 THEN FOR i=1 TO 4 : GET #in_ch;sort%
310 IF ddlevel>0 THEN FOR i=1 TO 20 : GET #in_ch;sort%
320 IF ddlevel>1
330   GET #in_ch;ddtab%
340   FOR i=1 TO 10 : GET #in_ch;ddjump%
350   GET #in_ch;ddsearch%,ddwinxs%,ddwinys%
360 END IF
370 :
380 qs_header #out_ch;'1.02'
390 qs_size #out_ch;0,0
400 :
410 col%=0 : row%=0
420 maxcol%=ddfields%
430 :
440 : REMark set fieldnames in top row
450 FOR i=0 TO ddfields%
460   qs_cell #out_ch;col%,row%,-1,'"'&ddfields$(1+i*ddfieldlen% TO (i+1)*ddfieldlen%)
470   col%=col%+1
480 END FOR i
490 :
500 col%=0 : row%=2
505 DIM recfield$(60)
510 REPeat loop
520   IF EOF(#in_ch) THEN EXIT loop
530   GET #in_ch;reclength%
540   FOR i=0 TO ddfields%
550     INPUT #in_ch;recfield$
560     line_pos=CHR$(13) INSTR recfield$
570     IF line_pos THEN recfield$=recfield$(1 TO line_pos-1)
580     qs_cell #out_ch;i,row%,-1,'"'&recfield$
590   END FOR i
600   row%=row%+1
610 END REPeat loop
620 CLOSE
30000 DEFine PROCedure qs_header(ch,vers$)
30010   PUT #ch;19196||0
30020   PRINT #ch;'SPRD'&vers$;
30030 END DEFine
30040 :
30050 DEFine PROCedure qs_size(ch,col%,row%)
30060   PUT #ch;col%||0,row%||0
30070 END DEFine
30080 :
30090 DEFine PROCedure qs_cols(ch,cols)
30100   LOCal i
30110   FOR i=0 TO DIMN(cols):BPUT #ch;cols(i)
30120 END DEFine
30130 :
30140 DEFine PROCedure qs_cell(ch,col%,row%,fmt%,f$)
30150   IF fmt%=-1 THEN fmt%=2048
30160   PUT #ch;col%||0,row%||0,fmt%||0,f$
30170 END DEFine
30180 :
30190 DEFine PROCedure qs_env(ch,code%,val%)
30200   PUT #ch;-1||0,code%||0,val%||0
30210 END DEFine
30220 :
30230 DEFine PROCedure qs_macro(ch,code%,mac$)
30240   PUT #ch;-1||0,-code%||0,mac$
30250 END DEFine
