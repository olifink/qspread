* Spreadsheet					      29/11-91
*	 - configuration information (german)
*
	 include  win1_mac_config02
	 include  win1_mac_olicfg
	 include  win1_keys_wstatus
	 include  win1_keys_k

	 section  config

	 xref.l   qs_vers

*
* Qjump's standard config block 02 TAB
	 mkcfhead {QSpread Generelles/Fenster},qs_vers
cway	 mkcfitem 'TABa',code,'M',cfg_mainc,,,{Hauptfester Farben} \
		  0,,{weiœ/gr‡n}\
		  1,,{schwarz/rot}\
		  2,,{weiœ/rot}\
		  3,,{schwarz/gr‡n}
	 mkcfitem 'TABb',code,'G',cfg_gridc,,,{Gitterfenster Farben},.cway
	 mkcfitem 'TABc',word,'X',cfg_size,,, {Fensterbreite (oder 0 f‡r Maximum)},0,65535
	 mkcfitem 'TABd',word,'Y',cfg_ysiz,,, {Fensterh„he (oder 0 f‡r Maximum)},0,65535
	 mkcfitem 'TABe',word,'C',cfg_colmn,,,{Anzahl der Spalten},2,9999
	 mkcfitem 'TABf',word,'R',cfg_rows,,, {Anzahl der Zeilen},2,9999
	 mkcfitem 'TABg',word,'W',cfg_cwdt,,, {Spaltenbreite},1,60
	 mkcfitem 'TABh',string,0,cst_prtp,,,{Ger€tename des Druckers}
	 mkcfitem 'TABi',string,0,cst_prti,,,{Drucker Initialisierung}
	 mkcfitem 'TABj',word,0,cfg_prtw,,,{Papierbreite (in Zeichen)},40,256
	 mkcfitem 'TABk',word,0,cfg_prtl,,,{Papierl€nge (in Zeilen)},10,200
	 mkcfitem 'TABl',string,0,cst_prtf,,,{Name des Druckerfilters},cfs.file
	 mkcfitem 'TABm',string,0,cst_locd,,,{Lokales Dateiverzeichnis},cfs.dir
	 mkcfitem 'TABn',string,0,cst_flti,,,{Import Filter Name},cfs.file
	 mkcfitem 'TABo',string,0,cst_flte,,,{Export Filter Name},cfs.file
	 mkcfitem 'TABp',string,0,cst_fltd,,,{Transferfilter Verzeichnis},cfs.dir
	 mkcfitem 'TABq',string,0,cst_prtd,,,{Druckerfilter Verzeichnis},cfs.dir
	 mkcfitem 'TABr',string,'E',cst_extn,,,{Datei Erweiterung},cfs.ext
	 mkcfitem 'TABs',string,'H',cst_helpf,,,{Hilfe Verzeichnis},cfs.dir
yesno	 mkcfitem 'TABt',code,'K',cfg_sabk,,,{Kopie beim Sichern} \
		  wsi.avbl,,{Nein} \
		  wsi.slct,,{Ja}
	 mkcfitem 'TABu',code,0,cfg_stcr,,,{Best€tigungsnachfragen},.yesno
	 mkcfitem 'TABv',code,0,cfg_cgap,,,{Rahmen f‡r Zellenerkennung},.yesno
	 mkcfitem 'TABw',code,0,cfg_tool,,,{Toolbox anzeigen},.yesno
	 mkcfend



*
* Configuration data
	 ds.w	  0
	 cfgword  size,0
	 cfgword  ysiz,0
	 cfgcode  mainc,0	    ; white/green
	 cfgcode  gridc,3	    ; white/green

	 cfgstrg  flti,38,{flp1_Filter_PsionImport}
	 cfgstrg  flte,38,{flp1_Filter_TextExport}
	 cfgstrg  fltd,38,{flp1_Filter_}
						 
	 cfgstrg  locd,38,{win1_prog_qspread_}
	 cfgstrg  helpf,38,{flp1_Hilfe_}
	 cfgstrg  prtf,38,{flp1_Printer_DeskJet}
	 cfgstrg  prtd,38,{flp1_Printer_}
	 cfgstrg  prti,36,{\init}
	 cfgstrg  prtp,36,{PAR}
	 cfgstrg  extn,5,{_tab}

	 cfgword  prtw,80
	 cfgword  prtl,60
	 cfgword  colmn,50
	 cfgword  rows,50
	 cfgword  cwdt,10
	 cfgcode  sabk,wsi.avbl
	 cfgcode  stcr,wsi.slct
	 cfgcode  cgap,wsi.slct
	 cfgcode  tool,wsi.slct
	 ds.w	  0
	 end
