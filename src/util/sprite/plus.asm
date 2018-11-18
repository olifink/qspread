* Sprite plus
*
*	Mode 4
*	+------|-----+
*	|    aaaa    |
*	|    agga    |
*	|    agga    |
*	|aaaaaggaaaaa|
*	-agggggggggga-
*	|aaaaaggaaaaa|
*	|    agga    |
*	|    agga    |
*	|    aaaa    |
*	+------|-----+
*
	section sprite
	xdef	mes_plus
mes_plus
	dc.w	$0100,$0000
	dc.w	12,9,6,5
	dc.l	sc4_plus-*
	xref	mes_zero
	dc.l	mes_zero-*
	dc.l	0
sc4_plus
	dc.w	$0f0f,$0000
	dc.w	$090f,$0000
	dc.w	$090f,$0000
	dc.w	$f9ff,$f0f0
	dc.w	$80ff,$10f0
	dc.w	$f9ff,$f0f0
	dc.w	$090f,$0000
	dc.w	$090f,$0000
	dc.w	$0f0f,$0000
*
	end
