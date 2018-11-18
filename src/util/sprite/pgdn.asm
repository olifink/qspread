* Sprite pgdn
*
*	Mode 4
*	+------|-----+
*	|aaaaaaaaaaaa|
*	|a   agga   a|
*	|a   agga   a|
*	|aaaaaggaaaaa|
*	-a agggggga a-
*	|a  agggga  a|
*	|a   agga   a|
*	|a    aa    a|
*	|aaaaaaaaaaaa|
*	+------|-----+
*
	section sprite
	xdef	mes_pgdn
mes_pgdn
	dc.w	$0100,$0000
	dc.w	12,9,6,5
	dc.l	sc4_pgdn-*
	xref	mes_zero
	dc.l	mes_zero-*
	dc.l	0
sc4_pgdn
	dc.w	$ffff,$f0f0
	dc.w	$898f,$1010
	dc.w	$898f,$1010
	dc.w	$f9ff,$f0f0
	dc.w	$a0bf,$50d0
	dc.w	$909f,$9090
	dc.w	$898f,$1010
	dc.w	$8686,$1010
	dc.w	$ffff,$f0f0
*
	end
