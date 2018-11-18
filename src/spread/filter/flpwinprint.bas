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
340 file$=dos_file$("flp1_"&f$(6 TO))
345 file$=file$(TO LEN(file$)-3)&"txt"
350 OPEN_OVER#3,file$
360 :
370 REPeat loop
380  IF EOF(#0):STOP    : REMark That's it
390  BGET#0,c           : REMark Fetch char
400  SELect ON c
410   =1 :REPeat :BGET#0,c:IF c=2:EXIT :ELSE END REPeat
420   =12               :REMark FormFeed - just ignore it
425   =10:BPUT#3,13,10
430   =REMAINDER :BPUT#3,tra%(c):REMark Write char
440  END SELect
450 END REPeat loop
460 :
470 DEFine FuNction dos_file$(fi$)
480  REMark first correct extension delimiter
490  l=LEN(fi$):IF fi$(l-3)="_":fi$(l-3)="."
510  REMark next remove all leading subdirectories
520  REPeat
530   u="_" INSTR fi$(6 TO)
540   IF NOT u:EXIT
550   fi$=fi$(TO 5)&fi$(u+6 TO)
560  END REPeat
570  REMark finally make sure filename length is max 8 chars+extension
580  REPeat
590   l=LEN(fi$)
600   IF l<=17:EXIT
610   fi$=fi$(TO l-5)&fi$(l-3 TO)
620  END REPeat
630  RETurn fi$
640 END DEFine
650 :
660 DEFine PROCedure init_tra
670  DIM tra%(255)
680  FOR char=0 TO 255:tra%(char)=char
690  RESTORE
700  REPeat
710   IF EOF:EXIT
720   READ sms_char$,dos_char
730   tra%(CODE(sms_char$))=dos_char
740  END REPeat
750 END DEFine
760 :
770 DATA '€',228
780 DATA '„',246
790 DATA '‡',252
800 DATA 'œ',223
810 DATA ' ',196
820 DATA '¤',214
830 DATA '§',220
840 DATA '`',163
850 DATA '¶',167
