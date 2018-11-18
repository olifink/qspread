* Sprite numdown
*
*	Mode 4
*	+|---------+
*	-   wwww   -
*	|ww wwww ww|
*	|  wwwwww  |
*	|    ww    |
*	+|---------+
*
	section sprite
	xdef	mes_numdown
	xref	mes_zero
mes_numdown
	dc.w	$0100,$0000
	dc.w	10,4,0,0
	dc.l	mcs_numdown-*
	dc.l	mes_zero-*
	dc.l	0
mcs_numdown
	dc.w	$1E1E,$0000
	dc.w	$DEDE,$C0C0
	dc.w	$3F3F,$0000
	dc.w	$0C0C,$0000
*
	end
