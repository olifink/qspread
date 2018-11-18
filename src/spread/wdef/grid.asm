; Grid menu window (variable size)      1999 Jochen Merz

	include win1_keys_wdef_long
	include win1_keys_wwork
	include win1_keys_wstatus
	include win1_mac_menu_long
	include win1_keys_wman
	include win1_keys_colour

	xref.s	met.f3_grid
	xref.s	meu.f3_selcol,meu.f3_insrow,meu.f3_delrow,meu.f3_width
	xref.s	meu.f3_delcol,meu.f3_selrow

gr.xsiz equ	170
gr.ysiz equ	160-12

    window	grid
	size	gr.xsiz,gr.ysiz
	origin	gr.xsiz-8,8
	wattr	1,1,c.mbord,c.mback
	sprite	0
	border	1,c.mhigh
	iattr	c.mpunav,c.miunav,0,0	; unavailable
	iattr	c.mpavbl,c.miavbl,0,0	; available
	iattr	c.mpslct,c.mislct,0,0	; selected
	help	0

    size_opt	a
	size	gr.xsiz,gr.ysiz
	info	grid
	loos	grid
	appn	0
    s_end

    l_ilst	grid
      l_item	f3_esc,0
	size	30,10
	origin	gr.xsiz-34,2
	justify 0,0
	type	text
	selkey	esc
	text	esc
	item	mli.f3_esc
	action	quit
      l_item	f3_recalc,1
	size	gr.xsiz-28,10
	origin	6,15
	justify 1,0
	type	text-1
	selkey	f3_recalc
	text	f3_recalc
	item	mli.f3_recalc
	action	ret_item
      l_item	f3_width,2
	size	gr.xsiz-28,10
	origin	6,27
	justify 1,0
	type	text-meu.f3_width
	selkey	f3_width
	text	f3_width
	item	mli.f3_width
	action	ret_item
      l_item	f3_pwidth,3
	size	gr.xsiz-28,10
	origin	6,39
	justify 1,0
	type	text-1
	selkey	f3_pwidth
	text	f3_pwidth
	item	mli.f3_pwidth
	action	ret_item
      l_item	f3_selcol,4
	size	gr.xsiz-28,10
	origin	6,51
	justify 1,0
	type	text-meu.f3_selcol
	selkey	f3_selcol
	text	f3_selcol
	item	mli.f3_selcol
	action	ret_item
      l_item	f3_inscol,5
	size	gr.xsiz-28,10
	origin	6,63
	justify 1,0
	type	text-1
	selkey	f3_inscol
	text	f3_inscol
	item	mli.f3_inscol
	action	ret_item
      l_item	f3_delcol,6
	size	gr.xsiz-28,10
	origin	6,75
	justify 1,0
	type	text-meu.f3_delcol
	selkey	f3_delcol
	text	f3_delcol
	item	mli.f3_delcol
	action	ret_item
      l_item	f3_selrow,7
	size	gr.xsiz-28,10
	origin	6,87
	justify 1,0
	type	text-meu.f3_selrow
	selkey	f3_selrow
	text	f3_selrow
	item	mli.f3_selrow
	action	ret_item
      l_item	f3_insrow,8
	size	gr.xsiz-28,10
	origin	6,99
	justify 1,0
	type	text-meu.f3_insrow
	selkey	f3_insrow
	text	f3_insrow
	item	mli.f3_insrow
	action	ret_item
      l_item	f3_delrow,9
	size	gr.xsiz-28,10
	origin	6,111
	justify 1,0
	type	text-meu.f3_delrow
	selkey	f3_delrow
	text	f3_delrow
	item	mli.f3_delrow
	action	ret_item
      l_item	f3_search,10
	size	gr.xsiz-28,10
	origin	6,123
	justify 1,0
	type	text-1
	selkey	f3_search
	text	f3_search
	item	mli.f3_search
	action	ret_item
      l_item	f3_quit,11
	size	gr.xsiz-28,10
	origin	6,135
	justify 1,0
	type	text-1
	selkey	f3_quit
	text	f3_quit
	item	mli.f3_quit
	action	ret_item
      l_item
	size	30,10
	origin	4,2
	justify 0,0
	type	sprite
	selkey	move
	sprite	move
	item	12
	action	move
    l_end

    i_wlst	grid
      i_windw
	size	gr.xsiz-40-36,14
	origin	38,1
	wattr	0,0,0,c.mfill
	olst	0
      i_windw
	size	met.f3_grid+met.f3_grid+2,10
	origin	gr.xsiz/2-met.f3_grid,2
	wattr	0,0,0,c.tback
	olst	grid
      i_windw
	size	gr.xsiz-8,gr.ysiz-16
	origin	4,14
	wattr	0,1,c.ibord,c.iback
	olst	ckey
    i_end

    i_olst	grid
      i_item
	size	met.f3_grid+met.f3_grid,10
	origin	0,0
	type	text
	ink	c.tink
	csize	0,0
	text	f3_grid
    i_end

    i_olst	ckey
      i_item
	size	12,10
	origin	gr.xsiz-22,1
	type	text
	ink	c.ilow
	csize	0,0
	text	ctlr
      i_item
	size	12,10
	origin	gr.xsiz-22,1+12*4
	type	text
	ink	c.ilow
	csize	0,0
	text	ctlk
      i_item
	size	12,10
	origin	gr.xsiz-22,1+12*7
	type	text
	ink	c.ilow
	csize	0,0
	text	ctlw
      i_item
	size	12,10
	origin	gr.xsiz-22,1+12*8
	type	text
	ink	c.ilow
	csize	0,0
	text	ctlo
      i_item
	size	12,10
	origin	gr.xsiz-22,1+12*9
	type	text
	ink	c.ilow
	csize	0,0
	text	ctls
      i_item
	size	12,10
	origin	gr.xsiz-22,1+12*10
	type	text
	ink	c.ilow
	csize	0,0
	text	ctlx
    i_end

	setwrk

	end
