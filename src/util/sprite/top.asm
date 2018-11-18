* Sprite top
*
*	Mode 4
*	+------|-----+
*	|	  aaa|
*	| aaaaaaa a  |
*	| ggggga  a  |
*	| gggga   a  |
*	- ggga	  a  -
*	| gga	  a  |
*	| ga	  a  |
*	| a	  a  |
*	|	  aaa|
*	+------|-----+
*
	section sprite
	xdef	mes_top
mes_top
	dc.w	$0100,$0000
	dc.w	12,9,6,4
	dc.l	sc4_top-*
	xref	mes_zero
	dc.l	mes_zero-*
	dc.l	0
sc4_top
	dc.w	$0000,$7070
	dc.w	$7f7f,$4040
	dc.w	$027e,$4040
	dc.w	$047c,$4040
	dc.w	$0878,$4040
	dc.w	$1070,$4040
	dc.w	$2060,$4040
	dc.w	$4040,$4040
	dc.w	$0000,$7070
*
	end
