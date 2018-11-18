30000 DEFine PROCedure qs_header(ch,vers$)
30010   PUT #ch%;19196||0
30020   PRINT #ch%;'SPRD'&vers$;
30030 END DEFine 
30040 :
30050 DEFine PROCedure qs_size(ch,col%,row%)
30060   PUT #ch%;col%,row%
30070 END DEFine 
30080 :
30090 DEFine PROCedure qs_cols(ch,cols)
30100   LOCal i
30110   FOR i=0 TO DIMN(cols):BPUT #ch;cols(i)
30120 END DEFine 
30130 :
30140 DEFine PROCedure qs_cell(ch,col%,row%,fmt%,f$)
30150   IF fmt%=-1 THEN fmt%=2048
30160   PUT #ch;col%,row%,fmt%,f$
30170 END DEFine 
30180 :
30190 DEFine PROCedure qs_env(ch,code%,val%)
30200   PUT #ch;-1||0,code%,val%
30210 END DEFine 
30220 :
30230 DEFine PROCedure qs_macro(ch,code%,mac$)
30240   PUT #ch;-1||0,-code%,mac$
30250 END DEFine 
