	include win1_keys_wwork
	include win1_keys_wstatus
	include win1_keys_wman
	include win1_keys_colour
	include win1_mac_menu_long

	section menu

	xref.s	met.acpr,met.ajms,met.titl
ab.xsiz equ    160
ab.ysiz equ    160	;58+43

    window  abou
	size	ab.xsiz,ab.ysiz
	origin	ab.xsiz-50,ab.ysiz-7
	wattr	1,1,c.mbord,c.mback
	sprite	0
	border	1,c.mhigh
	iattr	c.mpunav,c.miunav,0,0	; unavailable
	iattr	c.mpavbl,c.miavbl,0,0	; available
	iattr	c.mpslct,c.mislct,0,0	; selected
	help	0

    size_opt	a
	size	ab.xsiz,ab.ysiz
	info	abou
	loos	abou
	appn	0
    s_end

    l_ilst	abou
      l_item
	size	ab.xsiz-12,10
	origin	6,ab.ysiz-13
	justify 0,0
	type	text-1
	selkey	ok
	text	ok
	item	0
	action	do
    l_end

    i_wlst	abou
      i_windw
	size	ab.xsiz-4,14
	origin	2,0
	wattr	0,0,0,c.mfill
	olst	0
      i_windw
	size	met.titl+met.titl+4,10
	origin	ab.xsiz/2-2-met.titl,2
	wattr	0,0,0,c.tback
	olst	titl
      i_windw
	size	ab.xsiz-8,ab.ysiz-30	;16
	origin	4,15
	wattr	0,1,c.ibord,c.iback
	olst	cpry
      i_windw
	size	ab.xsiz-8,1
	origin	4,14+31+52
	wattr	0,0,0,c.lines
	olst	0
    i_end

    i_olst	cpry
      i_item
	size	64,10
	origin	ab.xsiz/2-52,0
	type	text
	ink	c.iink
	csize	1,0
	text	aver
      i_item
	size	32,10
	origin	ab.xsiz/2+14,0
	type	text
	ink	c.iink
	csize	1,0
	text	vers
      i_item
	size	64,48
	origin	ab.xsiz/2-34,10
	type	sprite
	dc.l	0
	dc.w	0
	sprite	jms

      i_item
	size	met.acpr+met.acpr,10
	origin	ab.xsiz/2-met.acpr-4,58 ;10
	type	text
	ink	c.iink
	csize	0,0
	text	acpr
      i_item
	size	met.ajms+met.ajms,10
	origin	ab.xsiz/2-met.ajms-4,68 ;20
	type	text
	ink	c.iink
	csize	0,0
	text	ajms
      i_item
	size	ab.xsiz-16,40
	origin	2,86			;32
	type	text
	ink	c.iink
	csize	0,0
	text	aaut
    i_end

    i_olst	titl
      i_item
	size	met.titl+met.titl,10
	origin	2,0
	type	text
	ink	c.tink
	csize	2,0
	text	titl
    i_end

	setwrk

	end
