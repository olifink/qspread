* Spreadsheet					      29/11-91
*	 - configuration information (english)
*
	 include  win1_mac_config02
	 include  win1_mac_olicfg
	 include  win1_keys_wstatus
	 include  win1_keys_k

	 section  config

	 xref.l   qs_vers

*
* Qjump's standard config block level 2 (TAB)
	 mkcfhead {QSpread General/Windows},qs_vers
cway	 mkcfitem 'TABa',code,'M',cfg_mainc,,,{Main window colourway} \
		  0,,{white/green}\
		  1,,{black/red}\
		  2,,{white/red}\
		  3,,{black/green}
	 mkcfitem 'TABb',code,'G',cfg_gridc,,,{Grid window colourway},.cway
	 mkcfitem 'TABc',word,'X',cfg_size,,, {Default window width (or 0 for maximum)},0,65535
	 mkcfitem 'TABd',word,'Y',cfg_ysiz,,, {Default window height (or 0 for maximum)},0,65535
	 mkcfitem 'TABe',word,'C',cfg_colmn,,,{Number of columns},2,9999
	 mkcfitem 'TABf',word,'R',cfg_rows,,, {Number of rows},2,9999
	 mkcfitem 'TABg',word,'W',cfg_cwdt,,, {Initial column width},1,60
	 mkcfitem 'TABh',string,0,cst_prtp,,,{Printer devicename}
	 mkcfitem 'TABi',string,0,cst_prti,,,{Printer initialisation code}
	 mkcfitem 'TABj',word,0,cfg_prtw,,,{Printer page width (in characters)},40,256
	 mkcfitem 'TABk',word,0,cfg_prtl,,,{Printer page length (in lines)},10,200
	 mkcfitem 'TABl',string,0,cst_prtf,,,{Printer filterjob name},cfs.file
	 mkcfitem 'TABm',string,0,cst_locd,,,{Local data directory},cfs.dir
	 mkcfitem 'TABn',string,0,cst_flti,,,{Import filterjob name},cfs.file
	 mkcfitem 'TABo',string,0,cst_flte,,,{Export filterjob name},cfs.file
	 mkcfitem 'TABp',string,0,cst_fltd,,,{Transfer filter directory},cfs.dir
	 mkcfitem 'TABq',string,0,cst_prtd,,,{Printer filter directory},cfs.dir
	 mkcfitem 'TABr',string,'E',cst_extn,,,{File extension},cfs.ext
	 mkcfitem 'TABs',string,'H',cst_helpf,,,{Help directory},cfs.dir
yesno	 mkcfitem 'TABt',code,'B',cfg_sabk,,,{Backup file on save} \
		  wsi.avbl,,{No} \
		  wsi.slct,,{Yes}
	 mkcfitem 'TABu',code,0,cfg_stcr,,,{Confirmation request},.yesno
	 mkcfitem 'TABv',code,0,cfg_cgap,,,{Use border for cell indication},.yesno
	 mkcfitem 'TABw',code,0,cfg_tool,,,{Show Toolbar initially},.yesno
	 mkcfend



*
* Configuration data
	 ds.w	  0
	 cfgword  size,0
	 cfgword  ysiz,0
	 cfgcode  mainc,0	    ; white/green
	 cfgcode  gridc,3	    ; no.... black/green

	 cfgstrg  flti,38,{flp1_Filter_PsionImport}
	 cfgstrg  flte,38,{flp1_Filter_TextExport}
	 cfgstrg  fltd,38,{flp1_Filter_}
						 
	 cfgstrg  locd,38,{flp1_}
	 cfgstrg  helpf,38,{flp1_Help_}
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
