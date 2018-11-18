100 a=ALCHP(2000)
110 LBYTES ram1_JMSOFT_REL_bin,a
120 OPEN_OVER#3,ram1_JMS_asm
130 p=a
140 PRINT #3;' section sprite'
150 PRINT #3\\' xdef mes_jms'
160 PRINT #3\\'mes_jms'
170 PRINT#3;' dc.w $';HEX$(PEEK_W(p),16);',$';HEX$(PEEK_W(p+2),16):p=p+4
180 PRINT#3;' dc.w $';HEX$(PEEK_W(p),16);',$';HEX$(PEEK_W(p+2),16):p=p+4
190 PRINT#3;' dc.w $';HEX$(PEEK_W(p),16);',$';HEX$(PEEK_W(p+2),16):p=p+4
200 PRINT#3;' dc.l sc_jms-*'
210 PRINT#3;' dc.l mes_zero-*'
220 PRINT#3;' dc.l 0'
230 PRINT#3
235 p=p+12
240 PRINT#3;'sc_jms'
250 FOR x=0 TO 767 STEP 4*4
255  PRINT #3;' dc.l ';
260  FOR y=x TO x+3
265   l=PEEK_L(p):p=p+4
267   PRINT #3;'$';HEX$(l,32);
268   IF y<>x+3:PRINT#3;',';:ELSE PRINT#3
270  END FOR y
280 END FOR x
285 PRINT#3;'mes_zero'
287 PRINT#3;' dcb.l 192,0'
288 PRINT#3;' end'
290 CLOSE
