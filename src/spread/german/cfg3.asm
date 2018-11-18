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
* Qjump's standard config block 02 Tab
	 mkcfhead {QSpread Spezial},qs_vers
;-----------------user function definitions-----------------------
	 mkcfitem 'Taba',string,0,cst_mcn1,,,{Funktion 1     }
	 mkcfitem 'Tabb',string,0,cst_mcn2,,,{Funktion 2     }
	 mkcfitem 'Tabc',string,0,cst_mcn3,,,{Funktion 3     }
	 mkcfitem 'Tabd',string,0,cst_mcn4,,,{Funktion 4     }
	 mkcfitem 'Tabe',string,0,cst_mcn5,,,{Funktion 5     }
;-----------------digit names-------------------------------------
	 mkcfitem 'Tabf',string,0,cst_dig0,,,{Ziffer Ÿ0'}
	 mkcfitem 'Tabg',string,0,cst_dig1,,,{Ziffer Ÿ1'}
	 mkcfitem 'Tabh',string,0,cst_dig2,,,{Ziffer Ÿ2'}
	 mkcfitem 'Tabi',string,0,cst_dig3,,,{Ziffer Ÿ3'}
	 mkcfitem 'Tabj',string,0,cst_dig4,,,{Ziffer Ÿ4'}
	 mkcfitem 'Tabk',string,0,cst_dig5,,,{Ziffer Ÿ5'}
	 mkcfitem 'Tabl',string,0,cst_dig6,,,{Ziffer Ÿ6'}
	 mkcfitem 'Tabm',string,0,cst_dig7,,,{Ziffer Ÿ7'}
	 mkcfitem 'Tabn',string,0,cst_dig8,,,{Ziffer Ÿ8'}
	 mkcfitem 'Tabo',string,0,cst_dig9,,,{Ziffer Ÿ9'}
;-----------------external functions------------------------------
*	  mkcfitem 'Tabp',string,0,cst_nxfn,,,{Externer Zahlenjob},cfs.file
*	  mkcfitem 'Tabq',string,0,cst_sxfn,,,{Externer Textjob},cfs.file
	 mkcfend

*
* Configuration data
	 ds.w	0
	 cfgstrg  mcn1,60,{}
	 cfgstrg  mcn2,60,{}
	 cfgstrg  mcn3,60,{}
	 cfgstrg  mcn4,60,{}
	 cfgstrg  mcn5,60,{}

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
;	  cfgstrg  nxfn,36,{ram1_num_obj}
;	  cfgstrg  sxfn,36,{ram1_str_obj}
	 ds.w	  0
	 end
