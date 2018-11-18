10 REMark *** Load data with new Sheetsize
20 REMark 
30 REMark v1.00 - First version released
50 :
1000 in=0 : out=1
1030 IF nr_of_col<2 THEN nr_of_col=2
1040 IF nr_of_row<2 THEN nr_of_row=2
1045 DIM cwdt%(1024) : FOR i=0 TO 1024 : cwdt%(i)=10
1050 FOR i=1 TO 10
1060    BGET #in;byte
1070    BPUT #out;byte
1080 END FOR i
1090 GET #in;xs%,ys%
1095 old_col=xs%
1096 nr_of_col='0'&READ_STRING$('NewSize',''&xs%,'Nr. of columns',20)
1097 nr_of_row='0'&READ_STRING$('NewSize',''&ys%,'Nr. of rows',20)
1100 xs%=nr_of_col
1110 ys%=nr_of_row
1120 PUT #out;xs%,ys%
1125 :
1127 FOR x=1 TO old_col : BGET #in;cwdt%(x)
1130 FOR x=1 TO nr_of_col : BPUT #out;cwdt%(x)
1170 :
1200 REPeat tilleof
1210    IF EOF(#in) THEN EXIT tilleof
1220    BGET #in;byte
1230    BPUT #out;byte
1240 END REPeat tilleof
1250 CLOSE #in,#out
