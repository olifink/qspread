* Spreadsheet					      29/11-91
*	 - configuration information (german)
*
	 include  win1_mac_multiconfig
	 include  win1_mac_olicfg
	 include  win1_keys_wstatus
	 include  win1_keys_k

	 section  config

	 xref.l   qs_vers

*
* Configuration data
	 cfgstrg  mcn1,60,{}
	 cfgstrg  mcn2,60,{}
	 cfgstrg  mcn3,60,{}
	 cfgstrg  mcn4,60,{}
	 cfgstrg  mcn5,60,{}
	 cfgstrg  locd,38,{flp1_qspread_}
	 cfgstrg  helpf,38,{flp1_hilfe_}
	 cfgstrg  prtf,38,{flp1_driver_epson_bas}
	 cfgstrg  prtd,38,{flp1_driver_}
	 cfgstrg  prtp,36,{PAR}
	 cfgstrg  extn,5,{_tab}
	 cfgstrg  flti,38,{flp1_filter_PsionImport}
	 cfgstrg  flte,38,{}
	 cfgstrg  fltd,38,{flp1_filter_}
	 cfgstrg  dig0,20,{Null}
	 cfgstrg  dig1,20,{Eins}
	 cfgstrg  dig2,20,{Zwei}
	 cfgstrg  dig3,20,{Drei}
	 cfgstrg  dig4,20,{Vier}
	 cfgstrg  dig5,20,{F‡nf}
	 cfgstrg  dig6,20,{Sechs}
	 cfgstrg  dig7,20,{Sieben}
	 cfgstrg  dig8,20,{Acht}
	 cfgstrg  dig9,20,{Neun}
	cfgstrg msy1,8,{`}
	cfgstrg msy2,8,{$}
	cfgstrg msy3,8,{µ}
	cfgstrg msy4,8,{DM}
	cfgstrg msy5,8,{¤S}
	cfgstrg msy6,8,{FFr}

	 cfgcode  vjst,-1
	 cfgcode  ordr,0
	 cfgcode  fnsp,wsi.avbl
	 cfgcode  fnsn,wsi.avbl
	 cfgcode  fnge,wsi.avbl
	 cfgcode  fnbr,wsi.avbl
	 cfgcode  aclc,wsi.avbl
	 cfgcode  dfmt,wsi.slct
	 cfgcode  emtz,wsi.avbl
	 cfgcode  emts,wsi.avbl
	 cfgcode  sepr,{','}
	 cfgcode  def,wsi.slct
	 cfgcode  mainc,0	    ; white/green
	 cfgcode  gridc,3	    ; black/green
	 cfgcode  butnc,0	    ; white/green
	 cfgcode  sabk,wsi.avbl
	 cfgcode  stcr,wsi.slct
	 cfgcode  cgap,wsi.slct
	 cfgcode  tool,wsi.slct
	 cfgcode  automov,1
	 cfgcode  dtfmt,0

	 ds.w	0

	 cfgword  size,0
	 cfgword  ysiz,0
	 cfgword  prtw,80
	 cfgword  prtl,60
	 cfgword  colmn,50
	 cfgword  rows,50
	 cfgword  cwdt,10
	 cfgword  calc,2
	
	 cfgbyte  fndp,2
	 cfgbyte  strd,0
	 cfgbyte  dtfms,'/'
	cfgbyte  prtcpi,0
	cfgbyte  prtdraft,wsi.avbl
	cfgbyte  prtff,wsi.slct

	 ds.w	  0


*
* Qjump's standard config block 02 TAB

	mkcfstart
	 mkcfhead {QSpread Generelles/Fenster},qs_vers
	 mkcfitem 'TABc',word,0,cfg_size,,, {Fensterbreite (oder 0 f‡r Maximum)},0,65535
	 mkcfitem 'TABd',word,0,cfg_ysiz,,, {Fensterh„he (oder 0 f‡r Maximum)},0,65535
	 mkcfitem 'TABe',word,0,cfg_colmn,,,{Anzahl der Spalten},2,9999
	 mkcfitem 'TABf',word,0,cfg_rows,,, {Anzahl der Zeilen},2,9999
	 mkcfitem 'TABg',word,0,cfg_cwdt,,, {Spaltenbreite},1,60
	 mkcfitem 'TABm',string,0,cst_locd,,,{Lokales Dateiverzeichnis},cfs.dir
	 mkcfitem 'TABn',string,0,cst_flti,,,{Import Filter Name},cfs.file
	 mkcfitem 'TABo',string,0,cst_flte,,,{Export Filter Name},cfs.file
	 mkcfitem 'TABp',string,0,cst_fltd,,,{Transferfilter Verzeichnis},cfs.dir
	 mkcfitem 'TABr',string,0,cst_extn,,,{Datei Erweiterung},cfs.ext
	 mkcfitem 'TABs',string,0,cst_helpf,,,{Hilfe Verzeichnis},cfs.dir
yesno	 mkcfitem 'TABt',code,0,cfg_sabk,,,{Kopie beim Sichern} \
		  wsi.avbl,,{Nein},wsi.slct,,{Ja}
	 mkcfitem 'TABu',code,0,cfg_stcr,,,{Best€tigungsnachfragen},.yesno
	 mkcfitem 'TABv',code,0,cfg_cgap,,,{Rahmen f‡r Zellenerkennung},.yesno
	 mkcfitem 'TABw',code,0,cfg_tool,,,{Toolbox anzeigen},.yesno
;;;	    mkcfitem 'TABx',code,0,cfg_def,,,{Voreingestellte Farben von Menu-Rext ‡bernehmen},.yesno
;;;colr     mkcfitem '_COL',code,0,cfg_mainc,,po_def,{Haupt-Fensterfarbe: eine der 4 Kombinationen ist m„glich }\
;;;	    0,,{Weiœ/Gr‡n},1,,{Schwarz/Rot},2,,{Weiœ/Rot},3,,{Schwarz/Gr‡n}
;;;	    mkcfitem '_COS',code,0,cfg_gridc,,po_def,{Gitter-Fensterfarbe: eine der 4 Kombinationen ist m„glich },.colr
;;;	    mkcfitem '_COB',code,0,cfg_butnc,,po_def,{Buttonfarbe: eine der 4 Kombinationen ist m„glich },.colr

	 mkcfblend

*
* Printer configuration items block 02 (auch obere TAB)
	mkcfhead {QSpread Drucker-Einstellungen},qs_vers
	mkcfitem 'TABh',string,0,cst_prtp,,,{Druckausgabe}
	mkcfitem 'TABl',string,0,cst_prtf,,,{Druckertreiber},cfs.file
	mkcfitem 'TABj',word,0,cfg_prtw,,,{Papierbreite (in Zeichen)},40,256
	mkcfitem 'TABk',word,0,cfg_prtl,,,{Papierl€nge (in Zeilen)},10,200
	mkcfitem 'TABq',string,0,cst_prtd,,,{Druckertreiber-Verzeichnis},cfs.dir
	mkcfitem 'TAB1',code,0,cfg_prtcpi,,,{Schriftbreite},0,,{Pica},1,,{Elite},2,,{Condensed}
onoff	mkcfitem 'TAB2',code,0,cfg_prtdraft,,,{Draft},wsi.avbl,,{Aus},wsi.slct,,{An}
	mkcfitem 'TAB3',code,0,cfg_prtff,,,{FF am Seitenende},.onoff

	mkcfblend
*
* Qjump's standard config block 02 TaB
	 mkcfhead {QSpread Zahlen/Darstellung},qs_vers
;-----------------value format configuration----------------------
	 mkcfitem 'TaBa',code,0,cfg_ordr,,, {Eingabe-/Berechnungsfolge} \
		  0,,{spaltenweise},1,,{zeilenweise}
	 mkcfitem 'TaBs',code,'O',cfg_automov,,,{Automatische Cursorbewegung nach Eingabe} \
		  0,,{Nein},1,,{Abw€rts},2,,{Rechts}
	 mkcfitem 'TaBb',code,0,cfg_vjst,,, {Wertausrichtung} \
		  1,,{links},-1,,{rechts}
	 mkcfitem 'TaBc',byte,0,cfg_fndp,,,{Nachkommastellen},0,8
	 mkcfitem 'TaBd',code,0,cfg_fnbr,,,{Negative Werte in Klammern},.yesno
	 mkcfitem 'TaBe',code,0,cfg_fnsn,,,{Vorzeichen immer darstellen},.yesno
	 mkcfitem 'TaBf',code,0,cfg_fnsp,,,{Trennzeichen einf‡gen},.yesno
	 mkcfitem 'TaBg',code,0,cfg_fnge,,,{Deutsche Darstellung},.onoff
onoff	 mkcfitem 'TaBh',code,0,cfg_aclc,,,{Berechnungen nach jeder Eingabe},wsi.avbl,,{Aus},wsi.slct,,{An}
	 mkcfitem 'TaBi',code,0,cfg_dfmt,,,{Zahlenformatierung},.onoff
	 mkcfitem 'TaBj',code,0,cfg_emtz,,,{Zelle leer bei Null},.yesno
	 mkcfitem 'TaBk',code,0,cfg_emts,,,{Zelle leer bei gleichem Wert},.yesno
	 mkcfitem 'TaBl',code,0,cfg_sepr,,,{Ziffentrennungs-Symbol}, \
		  44,,{,},159,,{Ÿ}
	mkcfitem 'TaBF',code,0,cfg_dtfmt,,,{Datum-Format},0,,{tt/mm/jj},1,,{tt/mm/jjjj} \
		  2,,{mm/tt/jj},3,,{mm/tt/jjj}
	mkcfitem 'TaBS',char,'/',cfg_dtfms,,,{Datum-Trennzeichen},$1e
	 mkcfitem 'TaB1',string,0,cst_msy1,,pp_msy1,{W€hrung 1}
	 mkcfitem 'TaB2',string,0,cst_msy2,,pp_msy2,{W€hrung 2}
	 mkcfitem 'TaB3',string,0,cst_msy3,,pp_msy3,{W€hrung 3}
	 mkcfitem 'TaB4',string,0,cst_msy4,,pp_msy4,{W€hrung 4}
	 mkcfitem 'TaB5',string,0,cst_msy5,,pp_msy5,{W€hrung 5}
	 mkcfitem 'TaB6',string,0,cst_msy6,,pp_msy6,{W€hrung 6}
	 mkcfitem 'TaBn',byte,0,cfg_strd,,,{Nachkommastellen runden (0=nein)},0,7
	 mkcfitem 'Tabr',word,0,cfg_calc,,, {Anzahl der Neuberechnungen},1,10

	 mkcfblend

*
* Qjump's standard config block 02 Tab
	 mkcfhead {QSpread Spezial},qs_vers
;-----------------user function definitions-----------------------
	 mkcfitem 'Taba',string,0,cst_mcn1,,,{Funktion 1}
	 mkcfitem 'Tabb',string,0,cst_mcn2,,,{Funktion 2}
	 mkcfitem 'Tabc',string,0,cst_mcn3,,,{Funktion 3}
	 mkcfitem 'Tabd',string,0,cst_mcn4,,,{Funktion 4}
	 mkcfitem 'Tabe',string,0,cst_mcn5,,,{Funktion 5}
;-----------------digit names-------------------------------------
	 mkcfitem 'Tabf',string,0,cst_dig0,,,{Name f‡r Ziffer 0}
	 mkcfitem 'Tabg',string,0,cst_dig1,,,{Name f‡r Ziffer 1}
	 mkcfitem 'Tabh',string,0,cst_dig2,,,{Name f‡r Ziffer 2}
	 mkcfitem 'Tabi',string,0,cst_dig3,,,{Name f‡r Ziffer 3}
	 mkcfitem 'Tabj',string,0,cst_dig4,,,{Name f‡r Ziffer 4}
	 mkcfitem 'Tabk',string,0,cst_dig5,,,{Name f‡r Ziffer 5}
	 mkcfitem 'Tabl',string,0,cst_dig6,,,{Name f‡r Ziffer 6}
	 mkcfitem 'Tabm',string,0,cst_dig7,,,{Name f‡r Ziffer 7}
	 mkcfitem 'Tabn',string,0,cst_dig8,,,{Name f‡r Ziffer 8}
	 mkcfitem 'Tabo',string,0,cst_dig9,,,{Name f‡r Ziffer 9}
;-----------------external functions------------------------------
*	  mkcfitem 'Tabp',string,0,cst_nxfn,,,{Externer Zahlenjob},cfs.file
*	  mkcfitem 'Tabq',string,0,cst_sxfn,,,{Externer Textjob},cfs.file
	 mkcfend


	 end
