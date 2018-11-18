; Context menu (variable size)	    1998 Jochen Merz

	include win1_keys_wdef_long
	include win1_keys_wwork
	include win1_keys_wstatus
	include win1_mac_menu_long
	include win1_keys_wman
	include win1_keys_colour

	xref.s	meu.f3_inscol,meu.f3_delcol
	xref.s	meu.f3_insrow,meu.f3_delrow
	xref.s	meu.ctx_eoblk
	xref.s	meu.f4_justify,meu.f3_width

fl.xsiz equ	154
fl.ysiz equ	112

    window	context
	size	fl.xsiz,fl.ysiz
	origin	fl.xsiz-14,18
	wattr	1,1,c.mbord,c.mback
	sprite	0
	border	1,c.mhigh
	iattr	c.mpunav,c.miunav,0,0	; unavailable
	iattr	c.mpavbl,c.miavbl,0,0	; available
	iattr	c.mpslct,c.mislct,0,0	; selected
	help	0

    size_opt	a
	size	fl.xsiz,fl.ysiz
	info	context
	loos	context
	appn	0
    s_end

    l_ilst	context
      l_item
	size	30,10
	origin	fl.xsiz-34,2
	justify 0,0
	type	text
	selkey	esc
	text	esc
	item	0
	action	quit
      l_item	ctx_eoblk,1
	size	fl.xsiz-12,10
	origin	6,15
	justify 1,0
	type	text-meu.ctx_eoblk
	selkey	ctx_eoblk
	text	ctx_eoblk
	item	mli.ctx_eoblk
	action	context
      l_item	ctx_units,2
	size	fl.xsiz-12,10
	origin	6,27
	justify 1,0
	type	text-1
	selkey	f4_units
	text	f4_units
	item	mli.ctx_units
	action	context
      l_item	ctx_justify,3
	size	fl.xsiz-12,10
	origin	6,39
	justify 1,0
	type	text-meu.f4_justify
	selkey	f4_justify
	text	f4_justify
	item	mli.ctx_justify
	action	context
      l_item	ctx_width,4
	size	fl.xsiz-12,10
	origin	6,51
	justify 1,0
	type	text-meu.f3_width
	selkey	f3_width
	text	f3_width
	item	mli.ctx_width
	action	context
      l_item	ctx_inscol,5
	size	fl.xsiz-12,10
	origin	6,63
	justify 1,0
	type	text-meu.f3_inscol
	selkey	f3_inscol
	text	f3_inscol
	item	mli.ctx_inscol
	action	context
      l_item	ctx_delcol,6
	size	fl.xsiz-12,10
	origin	6,75
	justify 1,0
	type	text-meu.f3_delcol
	selkey	f3_delcol
	text	f3_delcol
	item	mli.ctx_delcol
	action	context
      l_item	ctx_insrow,7
	size	fl.xsiz-12,10
	origin	6,87
	justify 1,0
	type	text-meu.f3_insrow
	selkey	f3_insrow
	text	f3_insrow
	item	mli.ctx_insrow
	action	context
      l_item	ctx_delrow,8
	size	fl.xsiz-12,10
	origin	6,99
	justify 1,0
	type	text-meu.f3_delrow
	selkey	f3_delrow
	text	f3_delrow
	item	mli.ctx_delrow
	action	context
    l_end

    i_wlst	context
      i_windw
	size	fl.xsiz-36,14
	origin	2,1
	wattr	0,0,0,c.mfill
	olst	0
      i_windw
	size	fl.xsiz-8,fl.ysiz-16
	origin	4,14
	wattr	0,1,c.ibord,c.iback
	olst	0
    i_end

	setwrk

	end
