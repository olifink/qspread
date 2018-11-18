100 REMark **
110 REMark ** This SuperBASIC program sets up a Hotkey to
120 REMark ** perform the action of preparing a table in Psions Abacus
130 REMark ** to be completly importable into QSpread using the
140 REMark ** "PsionImport" filter
150 REMark ** (column width are preserved)
152 REMark $$asmb=win1_rext_Outln_rext,0,54
153 :
155 set_window
170 REPeat loop
180   INPUT "Auf welchen Hotkey wollen Sie die Abacus"\"Exportvorbereitungsbefehle legen? > ";hk$
190   IF LEN(hk$)=1 THEN EXIT loop
200   PRINT "**** Fehler: Hotkey kann nur ein Zeichen (Taste) sein!"\\
210 END REPeat loop
220 :
230 REPeat loop
240   INPUT "Name der letzten Spalte? > ";lcol$
250   IF LEN(lcol$)>2 THEN NEXT loop
260   FOR i=1 TO LEN(lcol$)
270      IF NOT(lcol$(i) INSTR "ABCDEFGHIJKLMNOPQRSTUVWXYZ") THEN 
280         PRINT "**** Fehler: Falsche Abacus Spaltenbezeichnung!"\\
290         NEXT loop
300      END IF 
310   END FOR i
320   EXIT loop
330 END REPeat loop
350 :
360 REMark *
370 REMark * remove any old definition for this hotkey
380 xerr=HOT_REMV(hk$)
390 :
400 REMark *
410 REMark * prepare keyboard queue characters
420 lf$=CHR$(10)
430 f3$=CHR$(240)
440 f5$=CHR$(248)
450 :
460 REMark * F3 - Raster - Einf‡gen - Zeilen - at 1 - number of rows: 3
470 kq$=f3$ & 'REZ1' & lf$ & '3' & lf$
480 :
490 REMark * F5 Goto - A1
500 kq$=kq$ & f5$ & lf$
510 :
520 REMark * A1="x
530 kq$=kq$ & '"x' & lf$
540 :
550 REMark * F3 - Echo - A1 - ‡ber Bereich A1:??1
560 kq$=kq$ & f3$ & 'E' & lf$ & 'A1:'&lcol$&'1' & lf$
570 :
580 REMark * F5 Goto - A3
590 kq$=kq$ & f5$ & 'A3' & lf$
600 :
610 REMark * A3=breite()
620 kq$=kq$ & "breite()" & lf$
630 :
640 REMark * F3 - Echo - A3 - ‡ber Bereich A3:??3
650 kq$=kq$ & f3$ & 'EA3' & lf$ & 'A3:'&lcol$&'3' & lf$
660 :
670 REMark * F3 - Datei - Export - Abacus/Archive - Bereich - Spalten - tofile
680 kq$=kq$ & f3$ & 'DEA' & lf$ & 'S'
690 :
700 ERT HOT_KEY(hk$,kq$)
710 PRINT \"Abacus nach QSpread Exportvorbeitungstaste definiert."
720 PRINT "Dr‡cken Sie ALT-"&hk$&" in Abacus."
730 PRINT \\"DONE."; : CURSEN #1 : a$=INKEY$(#1,-1) : CURDIS #1
740 :
750 :
760 DEFine PROCedure set_window
765   OPEN_NEW #1;'con_2x1a0x0'
770   OUTLN 400,120,20,20,4,4
780   BORDER 1,0 : PAPER 7 : INK 0 : CLS
790   PAPER 92 : AT 0,0 : CLS 3
800   PAPER 7 : CURSOR 158,1: PRINT " Psion Export "
810   WINDOW 392,106,24,32
820   BORDER 1,4 : CLS
830   PRINT "Dieses Programm definiert einen Hotkey, der die Tasten-  "
840   PRINT "dr‡cke in Abacus simuliert, um eine Tabelle so vorzubereiten,"
850   PRINT 'daœ sie mit "PsionImport" importiert werden kann'\\
870 END DEFine 
