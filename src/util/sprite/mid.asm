* Sprite mid
*
*	Mode 4
*	+------|-----+
*	|	  aaa|
*	| a	  a  |
*	| gaa	  a  |
*	| gggaa   a  |
*	- gggggaa a  -
*	| gggaa   a  |
*	| gaa	  a  |
*	| a	  a  |
*	|	  aaa|
*	+------|-----+
*
	section sprite
	xdef	mes_mid
mes_mid
	dc.w	$0100,$0000
	dc.w	12,9,6,4
	dc.l	sc4_mid-*
	xref	mes_zero
	dc.l	mes_zero-*
	dc.l	0
sc4_mid
	dc.w	$0000,$7070
	dc.w	$4040,$4040
	dc.w	$3070,$4040
	dc.w	$0c7c,$4040
	dc.w	$037f,$4040
	dc.w	$0c7c,$4040
	dc.w	$3070,$4040
	dc.w	$4040,$4040
	dc.w	$0000,$7070
*
	end
