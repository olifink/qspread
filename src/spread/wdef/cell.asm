; Cell menu window (variable size)      1999 Jochen Merz

	include win1_keys_wdef_long
	include win1_keys_wwork
	include win1_keys_wstatus
	include win1_mac_menu_long
	include win1_keys_wman
	include win1_keys_colour

	xref.s	met.f4_cell
	xref.s	meu.f4_money,meu.f4_justify,meu.f4_unprotect

cl.xsiz equ	140
cl.ysiz equ	160-36

    window	cell
	size	cl.xsiz,cl.ysiz
	origin	cl.xsiz-8,8
	wattr	1,1,c.mbord,c.mback
	sprite	0
	border	1,c.mhigh
	iattr	c.mpunav,c.miunav,0,0	; unavailable
	iattr	c.mpavbl,c.miavbl,0,0	; available
	iattr	c.mpslct,c.mislct,0,0	; selected
	help	0

    size_opt	a
	size	cl.xsiz,cl.ysiz
	info	cell
	loos	cell
	appn	0
    s_end

    l_ilst	cell
      l_item	f4_esc,0
	size	30,10
	origin	cl.xsiz-34,2
	justify 0,0
	type	text
	selkey	esc
	text	esc
	item	mli.f4_esc
	action	quit
      l_item	f4_erase,1
	size	cl.xsiz-28,10
	origin	6,15
	justify 1,0
	type	text-1
	selkey	f4_erase
	text	f4_erase
	item	mli.f4_erase
	action	ret_item
      l_item	f4_copy,2
	size	cl.xsiz-28,10
	origin	6,27
	justify 1,0
	type	text-1
	selkey	f4_copy
	text	f4_copy
	item	mli.f4_copy
	action	ret_item
      l_item	f4_move,3
	size	cl.xsiz-28,10
	origin	6,39
	justify 1,0
	type	text-1
	selkey	f4_move
	text	f4_move
	item	mli.f4_move
	action	ret_item
      l_item	f4_units,4
	size	cl.xsiz-28,10
	origin	6,51
	justify 1,0
	type	text-1
	selkey	f4_units
	text	f4_units
	item	mli.f4_units
	action	ret_item
      l_item	f4_money,5
	size	cl.xsiz-28,10
	origin	6,63
	justify 1,0
	type	text-meu.f4_money
	selkey	f4_money
	text	f4_money
	item	mli.f4_money
	action	ret_item
      l_item	f4_justify,6
	size	cl.xsiz-28,10
	origin	6,75
	justify 1,0
	type	text-meu.f4_justify
	selkey	f4_justify
	text	f4_justify
	item	mli.f4_justify
	action	ret_item
      l_item	f4_echo,7
	size	cl.xsiz-28,10
	origin	6,87
	justify 1,0
	type	text-1
	selkey	f4_echo
	text	f4_echo
	item	mli.f4_echo
	action	ret_item
      l_item	f4_protect,8
	size	cl.xsiz-28,10
	origin	6,99
	justify 1,0
	type	text-1
	selkey	f4_protect
	text	f4_protect
	item	mli.f4_protect
	action	ret_item
      l_item	f4_unprotect,9
	size	cl.xsiz-28,10
	origin	6,111
	justify 1,0
	type	text-meu.f4_unprotect
	selkey	f4_unprotect
	text	f4_unprotect
	item	mli.f4_unprotect
	action	ret_item
      l_item
	size	30,10
	origin	4,2
	justify 0,0
	type	sprite
	selkey	move
	sprite	move
	item	10
	action	move
    l_end

    i_wlst	cell
      i_windw
	size	cl.xsiz-40-36,14
	origin	38,1
	wattr	0,0,0,c.mfill
	olst	0
      i_windw
	size	met.f4_cell+met.f4_cell+2,10
	origin	cl.xsiz/2-met.f4_cell,2
	wattr	0,0,0,c.tback
	olst	cell
      i_windw
	size	cl.xsiz-8,cl.ysiz-16
	origin	4,14
	wattr	0,1,c.ibord,c.iback
	olst	ckey
    i_end

    i_olst	cell
      i_item
	size	met.f4_cell+met.f4_cell,10
	origin	0,0
	type	text
	ink	c.tink
	csize	0,0
	text	f4_cell
    i_end

    i_olst	ckey
      i_item
	size	12,10
	origin	cl.xsiz-22,1+12
	type	text
	ink	c.ilow
	csize	0,0
	text	ctly
      i_item
	size	12,10
	origin	cl.xsiz-22,1+12*2
	type	text
	ink	c.ilow
	csize	0,0
	text	ctlu
      i_item
	size	12,10
	origin	cl.xsiz-22,1+12*5
	type	text
	ink	c.ilow
	csize	0,0
	text	ctlt
      i_item
	size	12,10
	origin	cl.xsiz-22,1+12*6
	type	text
	ink	c.ilow
	csize	0,0
	text	ctlz
    i_end

	setwrk

	end
