* Spreadsheet					      29/11-91
*	 - main window text / key defintions german
*
	 include  win1_mac_array
	 include  win1_mac_text
	 include  win1_mac_oli
	 include  win1_keys_k

	 section  menu

	 xdef	  tab_mon,tab_day,lst_keys

k.quot	 equ	  $22			     ; quotation mark is missing, too

	mktext	 demo,{Nur in der Vollversion m„glich}

	mktext	upjb,{SPREADChange}

*
* selection keys for main window

	 mkselk   move,k.move
	 mkselk   size,k.size
	 mkselk   slep,k.sleep
	 mkselk   grid,k.csf5		     ; ^F10 gets you into Grid window
	 mkselk   goto,k.sf5		     ; F10 Goto selection
	 mkselk   data,k.tab		     ; TAB is for data entry
	 mkselk   datado,k.stab 	     ; SHIFT TAB for big data entry
	 mkselk   cell,0		     ; no cell jumping
	 mkselk   norm,k.cancel 	     ; ESC normal mode
	 mkselk   tool,k.stab		     ; sTAB goes to tools window

*
* Shortcuts
	mkxstr	ctlg,'G'-'@',{^G}       ; Select column
	mkxstr	ctlh,'H'-'@',{^H}       ; Select row
	mkxstr	ctli,'I'-'@',{^I}       ; Insert row
	mkxstr	ctlk,'K'-'@',{^K}       ; Insert column
	mkxstr	ctll,'L'-'@',{^L}       ; Load
	mkxstr	ctlm,'M'-'@',{^M}       ; Delete column
	mkxstr	ctln,'N'-'@',{^N}       ; Save with new name
	mkxstr	ctlo,'O'-'@',{^O}       ; Delete row
	mkxstr	ctlp,'P'-'@',{^P}       ; Print
	mkxstr	ctlr,'R'-'@',{^R}       ; Recalculate
	mkxstr	ctls,'S'-'@',{^S}       ; Search
	mkxstr	ctlt,'T'-'@',{^T}       ; Justification
	mkxstr	ctlu,'U'-'@',{^U}       ; Move range
	mkxstr	ctlv,'V'-'@',{^V}       ; Save
	mkxstr	ctlw,'W'-'@',{^W}       ; Column width
	mkxstr	ctlx,'X'-'@',{^X}       ; Quit
	mkxstr	ctly,'Y'-'@',{^Y}       ; Copy range
	mkxstr	ctlz,'Z'-'@',{^Z}       ; Echo range

*
* text definitions for main window
	 mktits   flag,{QSpreadDemo}             ; window flag title
	 mktitl   titl,{QSpreadDemo}
	 mktext   nona,{OHNE NAMEN}          ; no name text for file info
	 mktext   sept,{:}                   ; range seperator item
	 mktext   ovfl,{!Fehler}             ; Overflow error

*
* message texts
	 romtext  covr,{Zu viele Zellen}
	 rommsg   covr,{Es k„nnen Probleme mit dem Window Manager\auftreten. Fortfahren?}
	 rommsg   f3_quit,{Wollen Sie QSpread wirklich verlassen?\Datei ist nicht gesichert -  nderungen verwerfen?}
	 romtext  eras,{L„schen}
	 rommsg   eras,{Alle Zellen im aktuellen Bereich\l„schen. Sind Sie sicher?}
	 romtext  prct,{Sch‡tzen}
	 rommsg   prct,{Alle Zellen im aktuellen Bereich\sch‡tzen. Sind Sie sicher?}
	 romtext  upct,{Schutz aufheben}
	 rommsg   upct,{F‡r alle Zellen im aktuellen Bereich\den Schutz aufheben. Sind Sie sicher?}
	 rommsg   f2_forget,{Datei ist nicht gesichert!\ nderungen verwerfen?}
	 romtext  delc,{Spalten l„schen}
	 rommsg   delc,{Angegebene Spalten aus dem Arbeitsblatt\entfernen?}
	 romtext  delr,{Zeilen l„schen}
	 rommsg   delr,{Angegebene Zeilen aus dem Arbeitsblatt\entfernen?}
	 romtext  insc,{Spalten einf‡gen}
	 rommsg   insc,{Anzahl der Spalten}
	 romtext  insr,{Zeilen einf‡gen}
	 rommsg   insr,{Anzahl der Zeilen}
	 mktits   eddo,{Formel eingeben oder editieren:}
	mktext	pastit,{Passwort}
	mktext	paswrd,{Bitte Passwort eingeben:}
	mktext	paswd1,{Bitte neues Password eingeben:}
	mktext	paswd2,{Bitte neues Password wiederholen:}
	mktext	paswrong,{Passwort ist falsch!}
	mktext	pasdiff,{Unterschiedliche Passw„rter.\Altes Password wird behalten!}
	mktext	pasesc,{Abbruch. Altes Password wird behalten!}
	mktext	err_icfv,{Inkompatibles Dateiformat}


	 askmenu  delr
	 askmenu  delc
	 askmenu  f3_quit
	 askmenu  f2_forget
	 askmenu  covr
	 askmenu  eras
	 askmenu  prct
	 askmenu  upct

*
* Justify and other submenus
	 romtext  cjst,{Ausrichtung}
	 romtext  mjst,{W€hlen Sie die neue Ausrichtung der\Zellen.}
	 romtext  mjsr,{rechts}
	 romtext  mjsl,{links}
	 romtext  cmsy,{Symbol}

*
* command text defintion for loose items
	 mkxstr   chlp,k.help,{Hilfe}        ; F1 = Help
	 mkxstr   cfil,k.f2,{Datei}          ; F2 = File
	 mkxstr   cgrd,k.f3,{Gitter}         ; F3 = Grid
	 mkxstr   ccel,k.f4,{Zelle}          ; F4 = Cell
	 mkxstr   cstt,k.f5,{Status}         ; F5 = Status
	 mkxstr   csmc,k.sf1,{Fn's}          ; F6 = Macros
	 mkxustr  csim,'_',{_}               ; immediate mode
	 mkxstr   call,k.sf3,{Alle}          ; all cells
	 mkxstr   caga,k.sf4,{Wieder}        ; again
	 mkselk   csum,'+'
	 mktext   xsum,{sum(\r)}             ; sum macro
	 mktext   xlin,{rept$(-,wdth(\r))}   ; line macro

*
* Command array lists

	 arrdesc  help,8,30
	 arrstr   {‡ber Standardfunktionen}
	 arrstr   { ... Dateneingabe}
	 arrstr   { ... mathematische Funktionen}
	 arrstr   { ... Dateifunktionen}
	 arrstr   { ... Gitterkommandos}
	 arrstr   { ... Zellkommandos}
	 arrstr   { ... Voreinstellungen}
	 arrstr   { ... Macro Funktionen}

	 arrdesc  hlpf,8,10
	 arrstr   {Standard}
	 arrstr   {Eingabe}
	 arrstr   {Mathe}
	 arrstr   {Datei}
	 arrstr   {Gitter}
	 arrstr   {Zelle}
	 arrstr   {Status}
	 arrstr   {Macro}

	 arrdesc  xerr,3,30
	 arrstr   {Dateiformat falsch}
	 arrstr   {Dateiversion inkompatibel}
	 arrstr   {Filterjob abgebrochen}

*
*	F2 Files menu
*
	mktits	f2_file,{DATEI}
	mkxstr	f2_forget,'V',{Vergesse Arbeitsblatt}
	mkxstr	f2_load,'L',{Lade Arbeitsblatt ..}
	mkxstr	f2_save,'S',{Speichere Arbeitsblatt}
	mkxustr f2_savenew,'N',{Speichere mit neuem Namen ..}
	mkxstr	f2_import,'I',{Importiere aus Datei ..}
	mkxstr	f2_export,'E',{Exportiere in Datei ..}
	mkxstr	f2_scrap,'B',{Block in Zwischenablage}
	mkxstr	f2_markpage,'M',{Markiere eine Seite}
	mkxstr	f2_print,'D',{Drucke eine Seite}
	mkxustr f2_printb,'A',{Drucke aktuellen Bereich}
	mkxustr f2_formrep,'R',{Drucke Formel-Report}
	mkxstr	f2_fileopt,' ',{ ndere Drucker/Filter-Optionen ..}

*
*	F3 Grid menu
*
	mktits	f3_grid,{GITTER}
	mkxstr	f3_recalc,'N',{Neu-Berechnen}
	mkxustr f3_width,' ',{ ndere Spaltenbreite ..}
	mkxstr	f3_pwidth,'P',{Perfekte Spaltenbreite}
	mkxustr f3_selcol,'A',{Spalte ausw€hlen}
	mkxustr f3_inscol,'E',{Spalten einf‡gen}
	mkxustr f3_delcol,'S',{Spalten l„schen}
	mkxustr f3_selrow,'Z',{Zeile ausw€hlen}
	mkxustr f3_insrow,'I',{Zeilen einf‡gen}
	mkxustr f3_delrow,'¤',{Zeilen l„schen}
	mkxstr	f3_search,'S',{Suchen ..}
	mkxstr	f3_quit,'Q',{QSpread beenden}

*
*	F4 Cell menu
*
	mktits	f4_cell,{ZELLE}
	mkxstr	f4_erase,'L',{L„sche Bereich}
	mkxstr	f4_copy,'C',{Kopiere Bereich}
	mkxstr	f4_move,'V',{Verschiebe Bereich}
	mkxstr	f4_units,'Z',{Zahlen ..}
	mkxustr f4_money,'W',{W€hrungssymbol ..}
	mkxustr f4_justify,'A',{Ausrichtung}
	mkxstr	f4_echo,'E',{Echo ‡ber Bereich}
	mkxstr	f4_protect,'B',{Bereich sch‡tzen}
	mkxustr f4_unprotect,'S',{Schutz aufheben}

*
*	Context menu
*
	mkxustr ctx_eoblk,'M',{Markiere Block-Ende}

	 arrdesc  msym,7,8
	 arrstr   {}
msy_usr1 arrstr   {`}
msy_usr2 arrstr   {$}
msy_usr3 arrstr   {µ}
msy_usr4 arrstr   {DM}
msy_usr5 arrstr   {¤S}
msy_usr6 arrstr   {FFr}

	 mktext   ldir,{Lokal}
	 arrdesc  ldir,4,18
met_ddat arrstr   {Datenverzeichnis}
met_dflt arrstr   {Transferfilter}
met_dprt arrstr   {Druckertreiber}
met_dhlp arrstr   {Hilfedateien}

*
* Miscalleanious
	 mkxustr  ok,'O',{OK}
	 mkxustr  esc,k.cancel,{ESC}

*
* number format menu defintions
	 mkxustr  fndp,'N',{Nachkommastellen:}
	 mkxustr  fnsn,'I',{Immer mit Vorzeichen}
	 mkxustr  fnbr,'K',{Klammern wenn negativ}
	 mkxustr  fnsp,'T',{Trennung einf‡gen}
	 mkxustr  fnge,'D',{Deutsche Darstellung}
	 mktits   fntt,{Zahlen}
	 mktext   fnpv,{Vorschau: -1234.5 ->}
	 mktext   fnnr,{-1234.5}

*
* status menu texts
	 mktits   sttt,{STATUS}
	 mkxustr  stco,'R',{Reihenfolge:}
	 mktext   stcl,{Spalte}
	 mktext   strw,{Zeile}
	 mkxustr  stnc,'U',{Anzahl Neuberechnungen:}
	 mktext   stcm,{Cursorbewegung nach Eingabe:}
	 mkxustr  stcmn,'N',{Nein}
	 mkxustr  stcmd,'W',{Abw€rts}
	 mkxustr  stcmr,'G',{Rechts}
	 mkxustr  strd,'A',{Kommastellen runden}
	 mkxustr  stun,'Z',{Zahlen global}
	 mkxustr  stms,'W',{W€hrungssymbol global}
	 mkxustr  stjs,'H',{Zahlenausrichtung global}
	 mkxustr  stdi,'E',{Ziffernbezeichnungen}
	 mkxustr  stld,'V',{Lokale Verzeichnisse}
	 mkxustr  stbk,'K',{Kopie beim Sichern}
	 mkxustr  stac,'N',{Nach Eingabe rechnen}
	 mkxustr  stez,'L',{Leere Zelle bei Null}
	 mkxustr  stsm,'G',{Leer wenn gleicher Wert}
	 mkxustr  stfn,'F',{Zahlen formatieren}
	 mkxustr  stcr,'B',{Best€tigungsnachfrage}
	 mkxustr  sttb,'T',{Toolbar}

*
* width menu texts
	 mktits   wdtt,{BREITE}
	 mktits   wdcc,{ ndere Spalten}
	 mkxustr  wdfr,'V',{von}
	 mkxustr  wdto,'B',{bis}
	 mkxustr  wdnw,'N',{Neue Breite:}

*
* grid size menu definition
	 mktits   sztt,{GR¤SSE}
	 mkxustr  szco,'S',{Spalten}
	 mkxustr  szro,'Z',{Zeilen}

*
* find menu definition
	mktits	cfnd,{FINDE}
	mkxustr fndt,'S',{Suche nach diesem Text:}
	mkxustr ffrm,'F',{in Formeln}
	mkxustr fupw,'U',{Aufw€rts}
	mkxustr fdwn,'A',{Abw€rts}

*
* printer options menu definition
	 mktits   pott,{DRUCK/FILTER-OPTIONEN}
	 mkxustr  popw,'B',{Papierbreite (Zeichen):}
	 mkxustr  popl,'L',{Papierl€nge (Zeilen):}
	 mkxustr  popt,'Z',{Drucke zu:}
	 mkxustr  popp,'D',{Druckertreiber:}
	 mkxustr  poif,'M',{Import-Filter:}
	 mkxustr  poef,'E',{Export-Filter:}
	 mktext   pflt,{W€hle Transferfilter}
	 mktext   pprt,{W€hle Druckertreiber}
	 mktext   drivnm,{QSpread Druckertreiber}
	 mktext   nodriv,{Druckertreiber Fehler}
	 mkxustr  prff,'F',{Form Feed}
	 mkxustr  prpica,'A',{Pica}
	 mkxustr  prelit,'I',{Elite}
	 mkxustr  prcond,'C',{Schmalschrift}
	 mkxustr  prdraf,'D',{Schnell}

*
* User functions definitions
	 mktits   mctt,{Funktionen}
	 mkxustr  mcn1,'1',{1}
	 mkxustr  mcn2,'2',{2}
	 mkxustr  mcn3,'3',{3}
	 mkxustr  mcn4,'4',{4}
	 mkxustr  mcn5,'5',{5}
	 mkxustr  mcn6,'6',{6}
	 mkxustr  mcn7,'7',{7}
	 mkxustr  mcn8,'8',{8}
	 mkxustr  mcn9,'9',{9}
	 mkxustr  mcn0,'0',{0}

*
* About window text definitions
	 mktext   aver,{Version}
	 mktits   acpr,{Copyright 1992-99}
	 mktits   ajms,{Jochen Merz Software}
	 mktext   aaut,{Autoren:\} \
		       { Oliver Fink\} \
		       { Jochen Merz\} \
		       { Bernd Reinhardt}

*
* digit spelling window
	 mktits   ditt,{Ziffern}

*
* month name table
tab_mon  dc.w	  12
	 dc.w	  7,'Januar    '
	 dc.w	  8,'Februar   '
	 dc.w	  5,'M€rz      '
	 dc.w	  5,'April     '
	 dc.w	  3,'Mai       '
	 dc.w	  4,'Juni      '
	 dc.w	  4,'Juli      '
	 dc.w	  6,'August    '
	 dc.w	  9,'September '
	 dc.w	  7,'Oktober   '
	 dc.w	  8,'November  '
	 dc.w	  8,'Dezember  '

*
* day name table
tab_day  dc.w	  12
	 dc.w	  6,'Montag    '
	 dc.w	  8,'Dienstag  '
	 dc.w	  8,'Mittwoch  '
	 dc.w	 10,'Donnerstag'
	 dc.w	  7,'Freitag   '
	 dc.w	  7,'Samstag   '
	 dc.w	  7,'Sonntag   '

*
* submenu command actionn structures
act_ldir subact   dir_data
	 subact   dir_tflt
	 subact   dir_pflt
	 subact   dir_help

	 submenu  help,chlp,help,0
	 submenu  ldir,ldir,ldir,ldir

;
; formulae entry keys for grid
	 include win1_spread_keytable_asm

	 end
