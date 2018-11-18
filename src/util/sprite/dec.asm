* Sprite dec
*
*	Mode 4
*	+------|-----+
*	|aaaa	     |
*	|aggaaa      |
*	|agga  aa    |
*	|agga	 aaaa|
*	-agga	 agga-
*	|agga	 aaaa|
*	|agga  aa    |
*	|aggaaa      |
*	|aaaa	     |
*	+------|-----+
*
	section sprite
	xdef	mes_dec
mes_dec
	dc.w	$0100,$0000
	dc.w	12,9,6,4
	dc.l	sc4_dec-*
	xref	mes_zero
	dc.l	mes_zero-*
	dc.l	0
sc4_dec
	dc.w	$f0f0,$0000
	dc.w	$9cfc,$0000
	dc.w	$93f3,$0000
	dc.w	$90f0,$f0f0
	dc.w	$90f0,$90f0
	dc.w	$90f0,$f0f0
	dc.w	$93f3,$0000
	dc.w	$9cfc,$0000
	dc.w	$f0f0,$0000
*
	end
