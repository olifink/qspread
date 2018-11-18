* Sprite inc
*
*	Mode 4
*	+------|-----+
*	|	 aaaa|
*	|      aaagga|
*	|    aa  agga|
*	|aaaa	 agga|
*	-agga	 agga-
*	|aaaa	 agga|
*	|    aa  agga|
*	|      aaagga|
*	|	 aaaa|
*	+------|-----+
*
	section sprite
	xdef	mes_inc
mes_inc
	dc.w	$0100,$0000
	dc.w	12,9,6,4
	dc.l	sc4_inc-*
	xref	mes_zero
	dc.l	mes_zero-*
	dc.l	0
sc4_inc
	dc.w	$0000,$f0f0
	dc.w	$0303,$90f0
	dc.w	$0c0c,$90f0
	dc.w	$f0f0,$90f0
	dc.w	$90f0,$90f0
	dc.w	$f0f0,$90f0
	dc.w	$0c0c,$90f0
	dc.w	$0303,$90f0
	dc.w	$0000,$f0f0
*
	end
