	include win1_keys_wdef_long
	include win1_keys_wwork
	include win1_keys_wstatus
	include win1_keys_wman
	include WIN1_mac_menu_long
	include WIN1_keys_colour

	section menu

size	equ	40
high	equ	12

	window	wait

	size	size,high
	origin	0,0			; origin in application menu
	wattr	0			\ shadow 0 wide
		1,c.bbord		\ border 1 wide
		c.bback
	sprite	0
	border	1,c.bhigh
	iattr	c.mpunav,c.miunav,0,0	; unavailable
	iattr	c.bback,c.bink,0,0   ; available
	iattr	c.mpslct,c.mislct,0,0	; selected
	help	0			; no help

     size_opt	a
	size	size,high,4,0		; minimum size, x scaleable
	info	0			; information window table
	loos	wait			; loose item table
	appn	0			; no applicatin sub-window

     s_end				; end of size options

      l_ilst	wait
       l_item	wait,0			; DD wait-item
	size	6*6,10,4,0		; size x scaleable
	origin	2,1
	justify 1,0
	type	text
	selkey	0
	text	0
	item	mli.wait
	action	quit
      l_end



	setwrk

	end
