100 REMark Special filter which prints QSpread output
110 REMark to ram8_, construting the filename automatically
120 REMark All bytes come in via #0
130 REMark nothing goes to #1
140 :
150 init_tra
160 :
170 REPeat find_filename
180  IF EOF(#0):STOP
190  BGET#0,c
200  SELect ON c
210   =1
220   BGET#0,o
230   IF o=CODE("f")
240    f$=""
250    REPeat
260     BGET#0,f
270     IF f=2:EXIT find_filename
280     f$=f$&CHR$(f)
290    END REPeat
300   END IF
310  END SELect
320 END REPeat find_filename
330 IF f$="":BEEP 10000,10000:STOP
340 file$="msd2_"&dos_file$(f$(6 TO))
350 file$=file$(TO LEN(file$)-3)&"txt"
360 OPEN_OVER#3,file$
370 :
380 REMark Print Header
390 PRINT #3,"Jochen Merz Shareware"&chr$(13)
400 PRINT #3,"Im stillen Winkel 12"&chr$(13)
410 PRINT #3,"47169 Duisburg"&chr$(13)
420 PRINT #3,"Deutschland",TO 50;"Duisburg, den ";DATE_FMT$&chr$(13)
430 PRINT #3;chr$(13)
440 PRINT #3;FILL$("-",72)&chr$(13)
445 PRINT #3;chr$(13)
450 :
460 REPeat loop
470  IF EOF(#0):STOP    : REMark That's it
480  BGET#0,c           : REMark Fetch char
490  SELect ON c
500   =1 :REPeat :BGET#0,c:IF c=2:EXIT :ELSE END REPeat
510   =12               :REMark FormFeed - just ignore it
520   =10:BPUT#3,13,10
530   =REMAINDER :BPUT#3,tra%(c):REMark Write char
540  END SELect
550 END REPeat loop
560 :
570 DEFine FuNction dos_file$(fi$)
580  REMark first correct extension delimiter
590  l=LEN(fi$):IF fi$(l-3)="_":fi$(l-3)="."
600  REMark next remove all leading subdirectories
610  REPeat
620   u="_" INSTR fi$
630   IF NOT u:EXIT
640   fi$=fi$(u+1 TO)
650  END REPeat
720  RETurn fi$
730 END DEFine
740 :
750 DEFine PROCedure init_tra
760  DIM tra%(255)
770  FOR char=0 TO 255:tra%(char)=char
780  RESTORE
790  REPeat
800   IF EOF:EXIT
810   READ sms_char$,dos_char
820   tra%(CODE(sms_char$))=dos_char
830  END REPeat
840 END DEFine
850 :
860 DATA '€',228
870 DATA '„',246
880 DATA '‡',252
890 DATA 'œ',223
900 DATA ' ',196
910 DATA '¤',214
920 DATA '§',220
930 DATA '`',163
940 DATA '¶',167
950 DATA 'µ',128
