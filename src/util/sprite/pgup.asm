* Sprite pgup
*
*	Mode 4
*	+------|-----+
*	|aaaaaaaaaaaa|
*	|a    aa    a|
*	|a   agga   a|
*	|a  agggga  a|
*	-a agggggga a-
*	|aaaaaggaaaaa|
*	|a   agga   a|
*	|a   agga   a|
*	|aaaaaaaaaaaa|
*	+------|-----+
*
	section sprite
	xdef	mes_pgup
mes_pgup
	dc.w	$0100,$0000
	dc.w	12,9,6,5
	dc.l	sc4_pgup-*
	xref	mes_zero
	dc.l	mes_zero-*
	dc.l	0
sc4_pgup
	dc.w	$ffff,$f0f0
	dc.w	$8686,$1010
	dc.w	$898f,$1010
	dc.w	$909f,$9090
	dc.w	$a0bf,$50d0
	dc.w	$f9ff,$f0f0
	dc.w	$898f,$1010
	dc.w	$898f,$1010
	dc.w	$ffff,$f0f0
*
	end
