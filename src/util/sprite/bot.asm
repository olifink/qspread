* Sprite bot
*
*	Mode 4
*	+------|-----+
*	|	  aaa|
*	| a	  a  |
*	| ga	  a  |
*	| gga	  a  |
*	- ggga	  a  -
*	| gggga   a  |
*	| ggggga  a  |
*	| aaaaaaa a  |
*	|	  aaa|
*	+------|-----+
*
	section sprite
	xdef	mes_bot
mes_bot
	dc.w	$0100,$0000
	dc.w	12,9,6,4
	dc.l	sc4_bot-*
	xref	mes_zero
	dc.l	mes_zero-*
	dc.l	0
sc4_bot
	dc.w	$0000,$7070
	dc.w	$4040,$4040
	dc.w	$2060,$4040
	dc.w	$1070,$4040
	dc.w	$0878,$4040
	dc.w	$047c,$4040
	dc.w	$027e,$4040
	dc.w	$7f7f,$4040
	dc.w	$0000,$7070
*
	end
