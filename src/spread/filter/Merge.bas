10 REMark *** Merge data into spreadsheet
20 REMark 
30 REMark v1.00 - First version released
50 :
1000 in=0 : out=1
1040 :
1050 GET #in;id%,app1%,app2%
1060 IF id%<>19196 OR app1%<>21328 OR app2%<>21060 THEN 
1070    x=ITEM_SELECT('Merge Filter Error','wrong input file format','OK')
1080    CLOSE #in,#out
1090    STOP
1095 END IF 
1100 :
1110 GET #in;ffv1%,ffv2%,xs%,ys%
1170 PUT #out;id%,app1%,app2%,ffv1%,ffv2%,0||0,0||0
1180 :
1190 FOR x=1 TO xs% : BGET #in;dummy%
1210 :
1220 REPeat tilleof
1230    IF EOF(#in) THEN EXIT tilleof
1240    BGET #in;byte
1250    BPUT #out;byte
1260 END REPeat tilleof
1270 CLOSE #in,#out
