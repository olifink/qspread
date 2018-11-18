; Files menu window (variable size)	 1999 Jochen Merz

	include win1_keys_wdef_long
	include win1_keys_wwork
	include win1_keys_wstatus
	include win1_mac_menu_long
	include win1_keys_wman
	include win1_keys_colour

	xref.s	met.f2_file
	xref.s	meu.f2_savenew,meu.f2_printb,meu.f2_formrep

fl.xsiz equ	200
fl.ysiz equ	160

    window	file
	size	fl.xsiz,fl.ysiz
	origin	fl.xsiz-8,8
	wattr	1,1,c.mbord,c.mback
	sprite	0
	border	1,c.mhigh
	iattr	c.mpunav,c.miunav,0,0	; unavailable
	iattr	c.mpavbl,c.miavbl,0,0	; available
	iattr	c.mpslct,c.mislct,0,0	; selected
	help	0

    size_opt	a
	size	fl.xsiz,fl.ysiz
	info	file
	loos	file
	appn	0
    s_end

    l_ilst	file
      l_item	f2_esc,0
	size	30,10
	origin	fl.xsiz-34,2
	justify 0,0
	type	text
	selkey	esc
	text	esc
	item	mli.f2_esc
	action	quit
      l_item	f2_forget,1
	size	fl.xsiz-28,10
	origin	6,15
	justify 1,0
	type	text-1
	selkey	f2_forget
	text	f2_forget
	item	mli.f2_forget
	action	ret_item
      l_item	f2_load,2
	size	fl.xsiz-28,10
	origin	6,27
	justify 1,0
	type	text-1
	selkey	f2_load
	text	f2_load
	item	mli.f2_load
	action	ret_item
      l_item	f2_save,3
	size	fl.xsiz-28,10
	origin	6,39
	justify 1,0
	type	text-1
	selkey	f2_save
	text	f2_save
	item	mli.f2_save
	action	ret_item
      l_item	f2_savenew,4
	size	fl.xsiz-28,10
	origin	6,51
	justify 1,0
	type	text-meu.f2_savenew
	selkey	f2_savenew
	text	f2_savenew
	item	mli.f2_savenew
	action	ret_item
      l_item	f2_import,5
	size	fl.xsiz-28,10
	origin	6,63
	justify 1,0
	type	text-1
	selkey	f2_import
	text	f2_import
	item	mli.f2_import
	action	ret_item
      l_item	f2_export,6
	size	fl.xsiz-28,10
	origin	6,75
	justify 1,0
	type	text-1
	selkey	f2_export
	text	f2_export
	item	mli.f2_export
	action	ret_item
      l_item	f2_scrap,7
	size	fl.xsiz-28,10
	origin	6,87
	justify 1,0
	type	text-1
	selkey	f2_scrap
	text	f2_scrap
	item	mli.f2_scrap
	action	ret_item
      l_item	f2_markpage,8
	size	fl.xsiz-28,10
	origin	6,99
	justify 1,0
	type	text-1
	selkey	f2_markpage
	text	f2_markpage
	item	mli.f2_markpage
	action	ret_item
      l_item	f2_print,9
	size	fl.xsiz-28,10
	origin	6,111
	justify 1,0
	type	text-1
	selkey	f2_print
	text	f2_print
	item	mli.f2_print
	action	ret_item
      l_item	f2_printb,10
	size	fl.xsiz-28,10
	origin	6,123
	justify 1,0
	type	text-meu.f2_printb
	selkey	f2_printb
	text	f2_printb
	item	mli.f2_printb
	action	ret_item
      l_item	f2_formrep,11
	size	fl.xsiz-28,10
	origin	6,135
	justify 1,0
	type	text-meu.f2_formrep
	selkey	f2_formrep
	text	f2_formrep
	item	mli.f2_formrep
	action	ret_item
      l_item	f2_fileopt,12
	size	fl.xsiz-28,10
	origin	6,147
	justify 1,0
	type	text-1
	selkey	f2_fileopt
	text	f2_fileopt
	item	mli.f2_fileopt
	action	ret_item
      l_item
	size	30,10
	origin	4,2
	justify 0,0
	type	sprite
	selkey	move
	sprite	move
	item	13
	action	move
    l_end

    i_wlst	file
      i_windw
	size	fl.xsiz-40-36,14
	origin	38,1
	wattr	0,0,0,c.mfill
	olst	0
      i_windw
	size	met.f2_file+met.f2_file+2,10
	origin	fl.xsiz/2-met.f2_file,2
	wattr	0,0,0,c.tback
	olst	file
      i_windw
	size	fl.xsiz-8,fl.ysiz-16
	origin	4,14
	wattr	0,1,c.ibord,c.iback
	olst	ckey
    i_end

    i_olst	file
      i_item
	size	met.f2_file+met.f2_file,10
	origin	0,0
	type	text
	ink	c.tink
	csize	0,0
	text	f2_file
    i_end

    i_olst	ckey
      i_item
	size	12,10
	origin	fl.xsiz-22,1+12
	type	text
	ink	c.ilow
	csize	0,0
	text	ctll
      i_item
	size	12,10
	origin	fl.xsiz-22,1+24
	type	text
	ink	c.ilow
	csize	0,0
	text	ctlv
      i_item
	size	12,10
	origin	fl.xsiz-22,1+36
	type	text
	ink	c.ilow
	csize	0,0
	text	ctln
      i_item
	size	12,10
	origin	fl.xsiz-22,1+8*12
	type	text
	ink	c.ilow
	csize	0,0
	text	ctlp
    i_end

	setwrk

	end
