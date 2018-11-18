* Spreadsheet					      29/11-91
*	 - main window text / key defintions english
*
	 include  win1_mac_array
	 include  win1_mac_text
	 include  win1_mac_oli
	 include  win1_keys_k

	 section  text

	 xdef	  tab_mon,tab_day,lst_keys

k.quot	 equ	  $22			     ; quotation mark is missing, too

	mktext	 demo,{Possible only in full version!}

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
	 mkselk   cell,0		     ; nothing (cell jumping doesn't work)
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
	mkxstr	ctlw,'W'-'@',{^W}       ; Insert row
	mkxstr	ctlx,'X'-'@',{^X}       ; Quit
	mkxstr	ctly,'Y'-'@',{^Y}       ; Copy range
	mkxstr	ctlz,'Z'-'@',{^Z}       ; Echo range

*
* text definitions for main window
	 mktits   flag,{QSpreadDemo}             ; window flag title
	 mktitl   titl,{QSpreadDemo}
	 mktext   nona,{NO NAME}             ; no name text for file info
	 mktext   sept,{:}                   ; range seperator item
	 mktext   ovfl,{!err}                ; overflow error
*
* message texts
	 romtext  covr,{Too many cells}
	 rommsg   covr,{This may cause window manager problems!\Do you want to continue?}
	 rommsg   f3_quit,{Do you really want to quit QSpread?\File is not saved - Abandon changes?}
	 romtext  eras,{Erase}
	 rommsg   eras,{Erase currently selected range of\cells. Are you sure?}
	 romtext  prct,{Protect}
	 rommsg   prct,{Protect currently selected range of\cells. Are you sure?}
	 romtext  upct,{Unprotect}
	 rommsg   upct,{Unprotect currently selected range\of cells. Are you sure?}
	 rommsg   f2_forget,{File is not saved, data will be lost!\Abandon changes?}
	 romtext  delc,{Delete columns}
	 rommsg   delc,{Remove these columns from the sheet!\Are you sure?}
	 romtext  delr,{Delete rows}
	 rommsg   delr,{Remove these rows from the sheet!\Are you sure?}
	 romtext  insc,{Insert columns}
	 rommsg   insc,{Nr. of columns}
	 romtext  insr,{Insert rows}
	 rommsg   insr,{Nr. of rows}
	 mktits   eddo,{Enter or edit formula:}
	mktext	pastit,{Password}
	mktext	paswrd,{Please enter password:}
	mktext	paswd1,{Please enter new password:}
	mktext	paswd2,{Please repeat new password:}
	mktext	paswrong,{Sorry, Password is wrong!}
	mktext	pasdiff,{Passwords are different!}
	mktext	pasesc,{Aborted. Retaining old password!}
	mktext	err_icfv,{Incompatible file format}

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
	 romtext  cjst,{Justify}
	 romtext  mjst,{Please select the new justification\for cells.}
	 romtext  mjsr,{right}
	 romtext  mjsl,{left}
	 romtext  cmsy,{Symbol}

*
* command text defintion for loose items
	 mkxstr   chlp,k.help,{Help}         ; F1 = Help
	 mkxstr   cfil,k.f2,{File}           ; F2 = File
	 mkxstr   cgrd,k.f3,{Grid}           ; F3 = Grid
	 mkxstr   ccel,k.f4,{Cell}           ; F4 = Cell
	 mkxstr   cstt,k.f5,{Status}         ; F5 = Status
	 mkxstr   csmc,k.sf1,{Fn's}          ; F6 = Macros
	 mkxustr  csim,'_',{_}               ; line mode
	 mkxstr   call,k.sf3,{All}           ; all cells
	 mkxstr   caga,k.sf4,{Again}         ; again
	 mkselk   csum,'+'
	 mktext   xsum,{sum(\r)}             ; sum macro
	 mktext   xlin,{rept$(-,wdth(\r))}   ; line macro

*
* Command array lists

	 arrdesc  help,8,22		 ;
	 arrstr   {about standard items}
	 arrstr   {  ... data entry}
	 arrstr   {  ... math functions}
	 arrstr   {  ... file operations}
	 arrstr   {  ... grid commands}
	 arrstr   {  ... cell commands}
	 arrstr   {  ... status menu}
	 arrstr   {  ... macro functions}

	 arrdesc  hlpf,8,20
	 arrstr   {stditem}
	 arrstr   {entry}
	 arrstr   {math}
	 arrstr   {files}
	 arrstr   {grid}
	 arrstr   {cell}
	 arrstr   {status}
	 arrstr   {macro}

	 arrdesc  xerr,3,30
	 arrstr   {wrong file format}
	 arrstr   {incompatible file version}
	 arrstr   {filter-job terminated}

*
*	F2 Files menu
*
	mktits	f2_file,{FILE}
	mkxstr	f2_forget,'F',{Forget sheet}
	mkxstr	f2_load,'L',{Load sheet ..}
	mkxstr	f2_save,'S',{Save current sheet}
	mkxustr f2_savenew,'N',{Save with new filename ..}
	mkxstr	f2_import,'I',{Import from file ..}
	mkxstr	f2_export,'E',{Export to file ..}
	mkxstr	f2_scrap,'B',{Block into scrap}
	mkxstr	f2_markpage,'M',{Mark page}
	mkxstr	f2_print,'P',{Print current page}
	mkxustr f2_printb,'K',{Print current block}
	mkxustr f2_formrep,'R',{Formulae report}
	mkxstr	f2_fileopt,'C',{Change print/filter options ..}

*
*	F3 Grid Menu
*
	mktits	f3_grid,{GRID}
	mkxstr	f3_recalc,'R',{Recalculate grid}
	mkxustr f3_width,'W',{Change column width ..}
	mkxstr	f3_pwidth,'P',{Perfect column width}
	mkxustr f3_selcol,'C',{Select column}
	mkxustr f3_inscol,'I',{Insert columns}
	mkxustr f3_delcol,'D',{Delete columns}
	mkxustr f3_selrow,'R',{Select row}
	mkxustr f3_insrow,'N',{Insert rows}
	mkxustr f3_delrow,'E',{Delete rows}
	mkxstr	f3_search,'S',{Search ..}
	mkxstr	f3_quit,'Q',{Quit QSpread}

*
*	F4 Cell menu
*
	mktits	f4_cell,{CELL}
	mkxstr	f4_erase,'E',{Erase range}
	mkxstr	f4_copy,'C',{Copy range}
	mkxstr	f4_move,'M',{Move range}
	mkxstr	f4_units,'U',{Units ..}
	mkxustr f4_money,'S',{Currency symbol ..}
	mkxustr f4_justify,'J',{Justification}
	mkxstr	f4_echo,'R',{Echo over range}
	mkxstr	f4_protect,'P',{Protect range}
	mkxustr f4_unprotect,'O',{Unprotect range}

*
*	Context menu
*
	mkxustr ctx_eoblk,'M',{Mark end of block}

	 arrdesc  msym,7,8
	 arrstr   {}
msy_usr1 arrstr   {`}
msy_usr2 arrstr   {$}
msy_usr3 arrstr   {µ}
msy_usr4 arrstr   {DM}
msy_usr5 arrstr   {¤S}
msy_usr6 arrstr   {FFr}

	 mktext   ldir,{Dirs}
	 arrdesc  ldir,4,18
met_ddat arrstr   {Data storage}
met_dflt arrstr   {Transfer filters}
met_dprt arrstr   {Printer drivers}
met_dhlp arrstr   {Help information}

*
* Miscallaneous
	 mkxustr  ok,'O',{OK}
	 mkxustr  esc,k.cancel,{ESC}

*
* number format menu defintions
	 mkxustr  fndp,'D',{Decimal places:}
	 mkxustr  fnsn,'A',{Always sign number}
	 mkxustr  fnbr,'B',{Brackets if negative}
	 mkxustr  fnsp,'I',{Insert seperators}
	 mkxustr  fnge,'G',{German representation}
	 mktits   fntt,{Units}
	 mktext   fnpv,{Preview: -1234.5 ->}
	 mktext   fnnr,{-1234.5}

*
* status menu texts
	 mktits   sttt,{STATUS}
	 mkxustr  stco,'L',{Calculation/input order:}
	 mktext   stcl,{column}
	 mktext   strw,{row}
	 mkxustr  stnc,'R',{Number of re-calculations:}
	 mktext   stcm,{Cursor-move after input:}
	 mkxustr  stcmn,'N',{None}
	 mkxustr  stcmd,'W',{Down}
	 mkxustr  stcmr,'G',{Right}
	 mkxustr  strd,'P',{Round decimal places}
	 mkxustr  stun,'U',{Global units ..}
	 mkxustr  stms,'M',{Global currency symbol ..}
	 mkxustr  stjs,'J',{Global number justification ..}
	 mkxustr  stdi,'D',{Set digit names ..}
	 mkxustr  stld,'I',{Local directories ..}
	 mkxustr  stbk,'B',{Backup file on save}
	 mkxustr  stac,'A',{Auto-calculation on input}
	 mkxustr  stez,'E',{Empty if zero}
	 mkxustr  stsm,'S',{Empty if same as above}
	 mkxustr  stfn,'F',{Format numbers}
	 mkxustr  stcr,'C',{Confirmation request}
	 mkxustr  sttb,'T',{Toolbar}

*
* width menu texts
	 mktits   wdtt,{WIDTH}
	 mktits   wdcc,{Change columns}
	 mkxustr  wdfr,'F',{from}
	 mkxustr  wdto,'T',{to}
	 mkxustr  wdnw,'N',{to new width}

*
* grid size menu definition
	 mktits   sztt,{GRID SIZE}
	 mkxustr  szco,'C',{columns}
	 mkxustr  szro,'R',{rows}

*
* find menu definition
	mktits	cfnd,{FIND}
	mkxustr fndt,'S',{Search for this text:}
	mkxustr ffrm,'F',{in formulae}
	mkxustr fupw,'U',{Upwards}
	mkxustr fdwn,'D',{Downwards}

*
* printer options menu definition
	 mktits   pott,{PRINT/FILTER OPTIONS}
	 mkxustr  popw,'W',{Paper width (chars):}
	 mkxustr  popl,'L',{Paper length (lines):}
	 mkxustr  popt,'T',{Print to:}
	 mkxustr  popp,'P',{Printer driver:}
	 mkxustr  poif,'M',{Import filter:}
	 mkxustr  poef,'E',{Export filter:}
	 mktext   pflt,{Select transfer filter}
	 mktext   pprt,{Select printer driver}
	 mktext   drivnm,{QSpread Printerdriver}
	 mktext   nodriv,{Printerdriver error}
	 mkxustr  prff,'F',{Form Feed}
	 mkxustr  prpica,'A',{Pica}
	 mkxustr  prelit,'I',{Elite}
	 mkxustr  prcond,'C',{Condensed}
	 mkxustr  prdraf,'D',{Draft}

*
* User functions definitions (also used in digit names)
	 mktits   mctt,{USER FUNCTIONS}
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
	 mktext   aaut,{Authors:\} \
		       { Oliver Fink\} \
		       { Jochen Merz\} \
		       { Bernd Reinhardt}

*
* digit spelling window
	 mktits   ditt,{Digit names}

*
* month name table
tab_mon  dc.w	  12
	 dc.w	  7,'January   '
	 dc.w	  8,'February  '
	 dc.w	  5,'March     '
	 dc.w	  5,'April     '
	 dc.w	  3,'May       '
	 dc.w	  4,'June      '
	 dc.w	  4,'July      '
	 dc.w	  6,'August    '
	 dc.w	  9,'September '
	 dc.w	  7,'October   '
	 dc.w	  8,'November  '
	 dc.w	  8,'December  '

*
* day name table
tab_day  dc.w	  12
	 dc.w	  6,'Monday    '
	 dc.w	  7,'Tuesday   '
	 dc.w	  9,'Wednesday '
	 dc.w	  8,'Thursday  '
	 dc.w	  6,'Friday    '
	 dc.w	  8,'Saturday  '
	 dc.w	  6,'Sunday    '

*
* submenu command action structures
act_ldir subact   dir_data
	 subact   dir_tflt
	 subact   dir_pflt
	 subact   dir_help

	 submenu  help,chlp,help,0
	 submenu  ldir,ldir,ldir,ldir

;
; formulae entry keys for grid
	 include  win1_spread_keytable_asm

	 end
