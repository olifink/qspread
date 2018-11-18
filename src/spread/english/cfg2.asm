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
* Qjump's standard config block (TaB)
	 mkcfhead {QSpread Numbers/Formats},qs_vers
;-----------------value format configuration----------------------
	 mkcfitem 'TaBa',code,'O',cfg_ordr,,, {Entry/calculation order} \
		  0,,{columns} \
		  1,,{rows}
lr	 mkcfitem 'TaBb',code,'V',cfg_vjst,,, {Value justification in cell} \
		  1,,{left} \
		 -1,,{right}
	 mkcfitem 'TaBc',byte,0,cfg_fndp,,,{Decimal places for number},0,8
yesno	 mkcfitem 'TaBd',code,0,cfg_fnbr,,,{Parathesis when negative number} \
		  wsi.avbl,,{No} \
		  wsi.slct,,{Yes}
	 mkcfitem 'TaBe',code,0,cfg_fnsn,,,{Always sign number},.yesno
	 mkcfitem 'TaBf',code,0,cfg_fnsp,,,{Insert seperators after 3 digits},.yesno
onoff	 mkcfitem 'TaBg',code,0,cfg_fnge,,,{German representation} \
		  wsi.avbl,,{Off} \
		  wsi.slct,,{On}
	 mkcfitem 'TaBh',code,0,cfg_aclc,,,{Auto calculation on input},.onoff
	 mkcfitem 'TaBi',code,0,cfg_dfmt,,,{Numeric output formatting},.onoff
	 mkcfitem 'TaBj',code,0,cfg_emtz,,,{Empty cell when zero},.yesno
	 mkcfitem 'TaBk',code,0,cfg_emts,,,{Empty if same as above},.yesno
	 mkcfitem 'TaBl',code,0,cfg_sepr,,,{Digit seperator symbol}, \
		  44,,{,} \
		  159,,{Ÿ}
	 mkcfitem 'TaBm',string,0,cst_msyu,,pp_msym,{Special monetary symbol}
	 mkcfitem 'TaBn',byte,0,cfg_strd,,,{Round after decimal places (0=no)},0,7
	 mkcfend



*
* Configuration data
	 ds.w	0
	 cfgstrg  msyu,8,{ž}

	 cfgcode  vjst,-1
	 cfgcode  ordr,0
	 cfgbyte  fndp,2
	 cfgcode  fnsp,wsi.avbl
	 cfgcode  fnsn,wsi.avbl
	 cfgcode  fnge,wsi.avbl
	 cfgcode  fnbr,wsi.avbl
	 cfgcode  aclc,wsi.avbl
	 cfgcode  dfmt,wsi.slct
	 cfgcode  emtz,wsi.avbl
	 cfgcode  emts,wsi.avbl
	 cfgcode  sepr,{','}
	 cfgbyte  strd,0

	 ds.w	  0
	 end
