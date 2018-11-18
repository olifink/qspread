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
* Qjump's standard config block  (Tab)
	 mkcfhead {QSpread Demo Special},qs_vers
;-----------------user function definitions-----------------------
	 mkcfitem 'Taba',string,0,cst_mcn1,,,{User function 1}
	 mkcfitem 'Tabb',string,0,cst_mcn2,,,{User function 2}
	 mkcfitem 'Tabc',string,0,cst_mcn3,,,{User function 3}
	 mkcfitem 'Tabd',string,0,cst_mcn4,,,{User function 4}
	 mkcfitem 'Tabe',string,0,cst_mcn5,,,{User function 5}
;-----------------digit names-------------------------------------
	 mkcfitem 'Tabf',string,0,cst_dig0,,,{Name for digit Ÿ0'}
	 mkcfitem 'Tabg',string,0,cst_dig1,,,{Name for digit Ÿ1'}
	 mkcfitem 'Tabh',string,0,cst_dig2,,,{Name for digit Ÿ2'}
	 mkcfitem 'Tabi',string,0,cst_dig3,,,{Name for digit Ÿ3'}
	 mkcfitem 'Tabj',string,0,cst_dig4,,,{Name for digit Ÿ4'}
	 mkcfitem 'Tabk',string,0,cst_dig5,,,{Name for digit Ÿ5'}
	 mkcfitem 'Tabl',string,0,cst_dig6,,,{Name for digit Ÿ6'}
	 mkcfitem 'Tabm',string,0,cst_dig7,,,{Name for digit Ÿ7'}
	 mkcfitem 'Tabn',string,0,cst_dig8,,,{Name for digit Ÿ8'}
	 mkcfitem 'Tabo',string,0,cst_dig9,,,{Name for digit Ÿ9'}
;-----------------external functions------------------------------
*	  mkcfitem 'Tabp',string,0,cst_nxfn,,,{Numeric external file},cfs.file
*	  mkcfitem 'Tabq',string,0,cst_sxfn,,,{String external file},cfs.file
	 mkcfend

*
* Configuration data
	 ds.w	0
	 cfgstrg  mcn1,60,{}
	 cfgstrg  mcn2,60,{}
	 cfgstrg  mcn3,60,{}
	 cfgstrg  mcn4,60,{}
	 cfgstrg  mcn5,60,{}

	 cfgstrg  dig0,20,{null}
	 cfgstrg  dig1,20,{one}
	 cfgstrg  dig2,20,{two}
	 cfgstrg  dig3,20,{three}
	 cfgstrg  dig4,20,{four}
	 cfgstrg  dig5,20,{five}
	 cfgstrg  dig6,20,{six}
	 cfgstrg  dig7,20,{seven}
	 cfgstrg  dig8,20,{eight}
	 cfgstrg  dig9,20,{nine}
;	  cfgstrg  nxfn,36,{ram1_num_obj}
;	  cfgstrg  sxfn,36,{ram1_str_obj}
	 ds.w	  0
	 end
