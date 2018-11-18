* Spreadsheet					      29/11-91
*	 - configuration information (english)
*
	 include  win1_mac_multiconfig02
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
	 cfgstrg  helpf,38,{flp1_help_}
	 cfgstrg  prtf,38,{flp1_driver_epson_bas}
	 cfgstrg  prtd,38,{flp1_driver_}
	 cfgstrg  prtp,36,{PAR}
	 cfgstrg  extn,5,{_tab}
	 cfgstrg  flti,38,{}
	 cfgstrg  flte,38,{}
	 cfgstrg  fltd,38,{flp1_filter_}
	 cfgstrg  dig0,20,{Zero}
	 cfgstrg  dig1,20,{One}
	 cfgstrg  dig2,20,{Two}
	 cfgstrg  dig3,20,{Three}
	 cfgstrg  dig4,20,{Four}
	 cfgstrg  dig5,20,{Five}
	 cfgstrg  dig6,20,{Six}
	 cfgstrg  dig7,20,{Seven}
	 cfgstrg  dig8,20,{Eight}
	 cfgstrg  dig9,20,{Nine}
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
	 cfgcode  dtfmt,0	 ; date default format

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
	 cfgbyte  dtfms,'/'	 ; date separator
	cfgbyte  prtcpi,0
	cfgbyte  prtdraft,wsi.avbl
	cfgbyte  prtff,wsi.slct


	 ds.w	  0


*
* Qjump's standard config block 02 TAB

	mkcfstart
	 mkcfhead {QSpreadDemo General/Windows},qs_vers
	 mkcfitem 'TABc',word,'X',cfg_size,,, {Default window width (or 0 for maximum)},0,65535
	 mkcfitem 'TABd',word,'Y',cfg_ysiz,,, {Default window height (or 0 for maximum)},0,65535
	 mkcfitem 'TABe',word,'C',cfg_colmn,,,{Number of columns},2,9999
	 mkcfitem 'TABf',word,'R',cfg_rows,,, {Number of rows},2,9999
	 mkcfitem 'TABg',word,'W',cfg_cwdt,,, {Initial column width},1,60
	 mkcfitem 'TABm',string,0,cst_locd,,,{Local data directory},cfs.dir
	 mkcfitem 'TABn',string,0,cst_flti,,,{Import filter},cfs.file
	 mkcfitem 'TABo',string,0,cst_flte,,,{Export filter},cfs.file
	 mkcfitem 'TABp',string,0,cst_fltd,,,{Filter directory},cfs.dir
	 mkcfitem 'TABr',string,'E',cst_extn,,,{File extension},cfs.ext
	 mkcfitem 'TABs',string,'H',cst_helpf,,,{Help directory},cfs.dir
yesno	 mkcfitem 'TABt',code,'B',cfg_sabk,,,{Backup file on save} \
		  wsi.avbl,,{No},wsi.slct,,{Yes}
	 mkcfitem 'TABu',code,0,cfg_stcr,,,{Confirmation request},.yesno
	 mkcfitem 'TABv',code,0,cfg_cgap,,,{Use border for cell indication},.yesno
	 mkcfitem 'TABw',code,0,cfg_tool,,,{Show Toolbar initially},.yesno
;;;	    mkcfitem 'TABx',code,0,cfg_def,,,{Get default colourways from Menu-Rext},.yesno
;;;colr     mkcfitem '_COL',code,0,cfg_mainc,,po_def,{Main Colourways: Choose one of four combinations }\
;;;	    0,,{White/Green},1,,{Black/Red},2,,{White/Red},3,,{Black/Green}
;;;	    mkcfitem '_COS',code,0,cfg_gridc,,po_def,{Sub Colourways: Choose one of four combinations },.colr
;;;	    mkcfitem '_COB',code,0,cfg_butnc,,po_def,{Button Colourways: Choose one of four combinations },.colr

	mkcfblend

* Printer configuration items block 02 (auch obere TAB)
	mkcfhead {QSpreadDemo Drucker-Einstellungen},qs_vers

	mkcfitem 'TABh',string,0,cst_prtp,,,{Print output}
	mkcfitem 'TABl',string,0,cst_prtf,,,{Printerdriver},cfs.file
	mkcfitem 'TABj',word,0,cfg_prtw,,,{Printer page width (in characters)},40,256
	mkcfitem 'TABk',word,0,cfg_prtl,,,{Printer page length (in lines)},10,200
	mkcfitem 'TABq',string,0,cst_prtd,,,{Printerdriver directory},cfs.dir
	mkcfitem 'TAB1',code,0,cfg_prtcpi,,,{Character size},0,,{Pica},1,,{Elite},2,,{Condensed}
onoff	mkcfitem 'TAB2',code,0,cfg_prtdraft,,,{Draft},wsi.avbl,,{Off},wsi.slct,,{On}
	mkcfitem 'TAB3',code,0,cfg_prtff,,,{FF at end of page},.onoff


	mkcfblend

*
* Qjump's standard config block 02 TaB
	 mkcfhead {QSpreadDemo Numbers/Formats},qs_vers
;-----------------value format configuration----------------------
	 mkcfitem 'TaBa',code,'O',cfg_ordr,,,{Calculation/input order} \
		  0,,{columns},1,,{rows}
	 mkcfitem 'TaBs',code,'O',cfg_automov,,,{Automatic cursor move after input} \
		  0,,{None},1,,{Down},2,,{Right}
	 mkcfitem 'TaBb',code,'V',cfg_vjst,,,{Value justification in cell} \
		  1,,{left},-1,,{right}
	 mkcfitem 'TaBc',byte,0,cfg_fndp,,,{Decimal places for number},0,8
	 mkcfitem 'TaBd',code,0,cfg_fnbr,,,{Parathesis when negative number},.yesno
	 mkcfitem 'TaBe',code,0,cfg_fnsn,,,{Always sign number},.yesno
	 mkcfitem 'TaBf',code,0,cfg_fnsp,,,{Insert seperators after 3 digits},.yesno
onoff	 mkcfitem 'TaBg',code,0,cfg_fnge,,,{German representation} \
		  wsi.avbl,,{Off},wsi.slct,,{On}
	 mkcfitem 'TaBh',code,0,cfg_aclc,,,{Auto calculation on input},.onoff
	 mkcfitem 'TaBi',code,0,cfg_dfmt,,,{Numeric output formatting},.onoff
	 mkcfitem 'TaBj',code,0,cfg_emtz,,,{Empty cell when zero},.yesno
	 mkcfitem 'TaBk',code,0,cfg_emts,,,{Empty if same as above},.yesno
	 mkcfitem 'TaBl',code,0,cfg_sepr,,,{Digit seperator symbol}, \
		  44,,{,},159,,{Ÿ}
	mkcfitem 'TaBF',code,0,cfg_dtfmt,,,{Default date representation},0,,{dd/mm/yy},1,,{dd/mm/yyyy} \
		  2,,{mm/dd/yy},3,,{mm/dd/yyyy}
	mkcfitem 'TaBS',char,'/',cfg_dtfms,,,{Default date separator},$1e
	 mkcfitem 'TaB1',string,0,cst_msy1,,pp_msy1,{Currency 1}
	 mkcfitem 'TaB2',string,0,cst_msy2,,pp_msy2,{Currency 2}
	 mkcfitem 'TaB3',string,0,cst_msy3,,pp_msy3,{Currency 3}
	 mkcfitem 'TaB4',string,0,cst_msy4,,pp_msy4,{Currency 4}
	 mkcfitem 'TaB5',string,0,cst_msy5,,pp_msy5,{Currency 5}
	 mkcfitem 'TaB6',string,0,cst_msy6,,pp_msy6,{Currency 6}
	 mkcfitem 'TaBn',byte,0,cfg_strd,,,{Round after decimal places (0=no)},0,7
	 mkcfitem 'Tabr',word,0,cfg_calc,,, {Number of re-calculations},1,10

	 mkcfblend

*
* Qjump's standard config block 02 Tab
	 mkcfhead {QSpreadDemo Special},qs_vers
;-----------------user function definitions-----------------------
	 mkcfitem 'Taba',string,0,cst_mcn1,,,{User function 1}
	 mkcfitem 'Tabb',string,0,cst_mcn2,,,{User function 2}
	 mkcfitem 'Tabc',string,0,cst_mcn3,,,{User function 3}
	 mkcfitem 'Tabd',string,0,cst_mcn4,,,{User function 4}
	 mkcfitem 'Tabe',string,0,cst_mcn5,,,{User function 5}
;-----------------digit names-------------------------------------
	 mkcfitem 'Tabf',string,0,cst_dig0,,,{Name for digit 0}
	 mkcfitem 'Tabg',string,0,cst_dig1,,,{Name for digit 1}
	 mkcfitem 'Tabh',string,0,cst_dig2,,,{Name for digit 2}
	 mkcfitem 'Tabi',string,0,cst_dig3,,,{Name for digit 3}
	 mkcfitem 'Tabj',string,0,cst_dig4,,,{Name for digit 4}
	 mkcfitem 'Tabk',string,0,cst_dig5,,,{Name for digit 5}
	 mkcfitem 'Tabl',string,0,cst_dig6,,,{Name for digit 6}
	 mkcfitem 'Tabm',string,0,cst_dig7,,,{Name for digit 7}
	 mkcfitem 'Tabn',string,0,cst_dig8,,,{Name for digit 8}
	 mkcfitem 'Tabo',string,0,cst_dig9,,,{Name for digit 9}
;-----------------external functions------------------------------
*	  mkcfitem 'Tabp',string,0,cst_nxfn,,,{Numeric external file},cfs.file
*	  mkcfitem 'Tabq',string,0,cst_sxfn,,,{String external file},cfs.file
      

	 mkcfend


	 end
