100 REMark Special filter which prints QSpread output
110 REMark to ram8_, construting the filename automatically
120 REMark All bytes come in via #0
130 REMark nothing goes to #1
140 :
150 REPeat find_filename
160  IF EOF(#0):STOP
170  BGET#0,c
180  SELect ON c
190   =1
200   BGET#0,o
210   IF o=CODE("f")
220    f$=""
230    REPeat
240     BGET#0,f
250     IF f=2:EXIT find_filename
260     f$=f$&CHR$(f)
270    END REPeat
280   END IF
290  END SELect
300 END REPeat find_filename
305 IF f$="":BEEP 10000,10000:STOP
310 file$="ram8_"&f$(6 TO LEN(f$)-3)&"txt"
320 OPEN_OVER#3,file$
330 :
340 REPeat loop
350  IF EOF(#0):STOP    : REMark That's it
360  BGET#0,c           : REMark Fetch char
370  SELect ON c
380   =1 :REPeat :BGET#0,c:IF c=2:EXIT :ELSE END REPeat
390   =12               :REMark FormFeed - just ignore it
400   =REMAINDER :BPUT#3,c:REMark Write char
410  END SELect
420 END REPeat loop
