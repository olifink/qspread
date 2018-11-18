* Sprite blend
*
*	Mode 4
*	+|-----------------+
*	-ggg ggg      wwwww-
*	|g   g g	w  |
*	|gg  ggg	w  |
*	|g   g g	w  |
*	|g   ggg      w w w|
*	|	       www |
*	|		w  |
*	|		   |
*	|rr rrrr rr rrrr   |
*	|		   |
*	|rrr rr rrrrr rr   |
*	|		 ww|
*	|rrrr rrr rr rrr ww|
*	|		 ww|
*	|	     wwwwww|
*	+|-----------------+
*
	section sprite
	xdef	mes_blend
	xref	mes_zero
mes_blend
	dc.w	$0100,$0000
	dc.w	18,15,0,0
	dc.l	mcs_blend-*
	dc.l	mes_zero-*
	dc.l	sp_blend-*
mcs_blend
	dc.w	$EE00,$0707
	dc.w	$C0C0,$0000
	dc.w	$8A00,$0101
	dc.w	$0000,$0000
	dc.w	$CE00,$0101
	dc.w	$0000,$0000
	dc.w	$8A00,$0101
	dc.w	$0000,$0000
	dc.w	$8E00,$0505
	dc.w	$4040,$0000
	dc.w	$0000,$0303
	dc.w	$8080,$0000
	dc.w	$0000,$0101
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$00DE,$00DE
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$00ED,$00F6
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$C0C0,$0000
	dc.w	$00F7,$006E
	dc.w	$C0C0,$0000
	dc.w	$0000,$0000
	dc.w	$C0C0,$0000
	dc.w	$0000,$0F0F
	dc.w	$C0C0,$0000
*
sp_blend
	incbin	'win1_util_icon_blend_spr'

	end
