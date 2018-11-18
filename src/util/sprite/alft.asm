* Sprite alft
*
*	Mode 4
*	+------|-----+
*	|a	     |
*	|a a	  a  |
*	|a a	aaa  |
*	|a a  aaaaa  |
*	-a aaaaaaaa  -
*	|a a  aaaaa  |
*	|a a	aaa  |
*	|a a	  a  |
*	|a	     |
*	+------|-----+
*
	section sprite
	xdef	mes_alft
mes_alft
	dc.w	$0100,$0000
	dc.w	12,9,6,4
	dc.l	sc4_alft-*
	xref	mes_zero
	dc.l	mes_zero-*
	dc.l	0
sc4_alft
	dc.w	$8080,$0000
	dc.w	$a0a0,$4040
	dc.w	$a1a1,$c0c0
	dc.w	$a7a7,$c0c0
	dc.w	$bfbf,$c0c0
	dc.w	$a7a7,$c0c0
	dc.w	$a1a1,$c0c0
	dc.w	$a0a0,$4040
	dc.w	$8080,$0000
*
	end
