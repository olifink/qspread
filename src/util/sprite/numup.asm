* Sprite numup
*
*	Mode 4
*	+|---------+
*	-    ww    -
*	|  wwwwww  |
*	|ww wwww ww|
*	|   wwww   |
*	+|---------+
*
	section sprite
	xdef	mes_numup
	xref	mes_zero
mes_numup
	dc.w	$0100,$0000
	dc.w	10,4,0,0
	dc.l	mcs_numup-*
	dc.l	mes_zero-*
	dc.l	0
mcs_numup
	dc.w	$0C0C,$0000
	dc.w	$3F3F,$0000
	dc.w	$DEDE,$C0C0
	dc.w	$1E1E,$0000
*
	end
