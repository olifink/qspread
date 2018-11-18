* Sprite bmove
*
*	Mode 4
*	+|-----------------+
*	-     wwww	   -
*	|     w 	   |
*	|     w rr rr r w  |
*	|   w w 	w w|
*	|rr w	rrr rrr w w|
*	|   w	     wwww w|
*	|rr w		  w|
*	|   wwwwwwwwwwwwwww|
*	|rr   w 	w  |
*	|    w w   rrr w w |
*	| rr  w 	w  |
*	+|-----------------+
*
	section sprite
	xdef	mes_bmove
	xref	mes_zero
mes_bmove
	dc.w	$0100,$0000
	dc.w	18,11,0,0
	dc.l	mcs_bmove-*
	dc.l	mes_zero-*
	dc.l	sp_bmove-*
mcs_bmove
	dc.w	$0707,$8080
	dc.w	$0000,$0000
	dc.w	$0404,$0000
	dc.w	$0000,$0000
	dc.w	$0405,$01B5
	dc.w	$0000,$0000
	dc.w	$1414,$0101
	dc.w	$4040,$0000
	dc.w	$10D1,$01DD
	dc.w	$4040,$0000
	dc.w	$1010,$0F0F
	dc.w	$4040,$0000
	dc.w	$10D0,$0000
	dc.w	$4040,$0000
	dc.w	$1F1F,$FFFF
	dc.w	$C0C0,$0000
	dc.w	$04C4,$0101
	dc.w	$0000,$0000
	dc.w	$0A0A,$023A
	dc.w	$8080,$0000
	dc.w	$0464,$0101
	dc.w	$0000,$0000
*
sp_bmove
	incbin	'win1_util_icon_bmove_spr'

	end
