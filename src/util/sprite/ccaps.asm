* Sprite ccaps
*
*	Mode 4
*	+|---------+
*	- ggg  gg  -
*	|g    gggg |
*	|g   g gg g|
*	|g     gg  |
*	|g   g gg g|
*	|g    gggg |
*	| ggg  gg  |
*	+|---------+
*
	section sprite
	xdef	mes_ccaps
	xref	mes_zero
mes_ccaps
	dc.w	$0100,$0000
	dc.w	10,7,0,0
	dc.l	sc4_ccaps-*
	dc.l	mes_zero-*
	dc.l	0
sc4_ccaps
	dc.w	$7300,$0000
	dc.w	$8700,$8000
	dc.w	$8B00,$4000
	dc.w	$8300,$0000
	dc.w	$8B00,$4000
	dc.w	$8700,$8000
	dc.w	$7300,$0000
*
	end
