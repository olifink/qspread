* spread	Mon, 1993 Jun 14 17:57:05
*    - Edit Do window

	include win1_mac_menu_long
	include win1_keys_colour
	include win1_keys_wman
	include win1_keys_wwork
	include win1_keys_wstatus
	include win1_keys_wdef_long

	section menu

	xref.s	met.eddo

size	equ	6*80+12
high	equ	6*12+10-30

     window	eddo

	size	size,high
	origin	20,10			; origin in application menu
	wattr	0			\ shadow 0 wide
	1,c.mbord			\ border 1 wide
	c.mback
	sprite	0
	border	1,c.mhigh	   ; current item is outlined
	iattr	c.mpunav,c.miunav,0,0	; unavailable
	iattr	c.mpavbl,c.miavbl,0,0	; available
	iattr	c.mpslct,c.mislct,0,0	; selected
	help	0			; no help

     size_opt	a
	size	size,high		; minimum size, not scaleable
	info	eddo			; information window table
	loos	0			; loose item table
	appn	0			; no application sub-window
     s_end				; end of size options

     i_wlst	eddo
       i_windw				; enter or edit formula
	size	size-8,high-18
	origin	4,16
	wattr	0,1,c.ibord,c.iback
	olst	0
       i_windw				; enter or edit formula inside
	size	size-12,high-20
	origin	6,18
	wattr	0,0,0,c.iback
	olst	0
       i_windw				; behind text
	size	size-4,14
	origin	2,0
	wattr	0,0,0,c.mfill
	olst	0
       i_windw				; enter or edit formula
	size	met.eddo+met.eddo+4,12
	origin	size/2-met.eddo,2
	wattr	0,0,0,c.tback
	olst	ol0
     i_end

     i_olst	ol0			; enter or edit formula
       i_item
	size	144,12
	origin	2,1
	type	text
	ink	c.tink
	csize	0,0
	text	eddo
     i_end

	setwrk

	end
