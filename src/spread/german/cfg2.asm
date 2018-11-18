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
* Qjump's standard config block 02 TaB
	 mkcfhead {QSpread Zahlen/Darstellung},qs_vers
;-----------------value format configuration----------------------
	 mkcfitem 'TaBa',code,'O',cfg_ordr,,, {Eingabe-/Berechnungsfolge} \
		  0,,{spaltenweise} \
		  1,,{zeilenweise}
lr	 mkcfitem 'TaBb',code,'V',cfg_vjst,,, {Wertausrichtung} \
		  1,,{links} \
		 -1,,{rechts}
	 mkcfitem 'TaBc',byte,0,cfg_fndp,,,{Nachkommastellen},0,8
yesno	 mkcfitem 'TaBd',code,0,cfg_fnbr,,,{Negative Werte in Klammern} \
		  wsi.avbl,,{Nein} \
		  wsi.slct,,{Ja}
	 mkcfitem 'TaBe',code,0,cfg_fnsn,,,{Vorzeichen immer darstellen},.yesno
	 mkcfitem 'TaBf',code,0,cfg_fnsp,,,{Trennzeichen einf‡gen},.yesno
onoff	 mkcfitem 'TaBg',code,0,cfg_fnge,,,{Deutsche Darstellung} \
		  wsi.avbl,,{Aus} \
		  wsi.slct,,{An}
	 mkcfitem 'TaBh',code,0,cfg_aclc,,,{Berechnungen nach jeder Eingabe},.onoff
	 mkcfitem 'TaBi',code,0,cfg_dfmt,,,{Zahlenformatierung},.onoff
	 mkcfitem 'TaBj',code,0,cfg_emtz,,,{Zelle leer bei Null},.yesno
	 mkcfitem 'TaBk',code,0,cfg_emts,,,{Zelle leer bei gleichem Wert},.yesno
	 mkcfitem 'TaBl',code,0,cfg_sepr,,,{Ziffentrennungs-Symbol}, \
		  44,,{,} \
		  159,,{Ÿ}
	 mkcfitem 'TaBm',string,0,cst_msyu,,pp_msym,{Spezielles W€hrungssymbol}
	 mkcfitem 'TaBn',byte,0,cfg_strd,,,{Nachkommastellen runden (0=nein)},0,7
	 mkcfend



*
* Configuration data
	 ds.w	  0
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
