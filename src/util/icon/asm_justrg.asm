* Sprite justrg
*
*	Mode 4
*	+|-----------------+
*	-		g  -
*	|	    gggggg |
*	|		g  |
*	|		   |
*	|wwwwwwwwwwwwwwwwww|
*	|wrrrrrrrrrrrrrrrrw|
*	|wrrrrrrrrwrrrrwrrw|
*	|wrrrrrrrrwrrrwrwrw|
*	|wrrrrrrrrwrrrwrwrw|
*	|wrrrrrrrrwrwrrwrrw|
*	|wrrrrrrrrrrrrrrrrw|
*	|wwwwwwwwwwwwwwwwww|
*	+|-----------------+
*
	section sprite
	xdef	mes_justrg
	xref	mes_zero
mes_justrg
	dc.w	$0100,$0000
	dc.w	18,12,0,0
	dc.l	mcs_justrg-*
	dc.l	mes_zero-*
	dc.l	sp_justrg-*

mcs_justrg
	dc.w	$0000,$0100
	dc.w	$0000,$0000
	dc.w	$0000,$1F00
	dc.w	$8000,$0000
	dc.w	$0000,$0100
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$FFFF,$FFFF
	dc.w	$C0C0,$0000
	dc.w	$80FF,$00FF
	dc.w	$40C0,$0000
	dc.w	$80FF,$42FF
	dc.w	$40C0,$0000
	dc.w	$80FF,$45FF
	dc.w	$40C0,$0000
	dc.w	$80FF,$45FF
	dc.w	$40C0,$0000
	dc.w	$80FF,$52FF
	dc.w	$40C0,$0000
	dc.w	$80FF,$00FF
	dc.w	$40C0,$0000
	dc.w	$FFFF,$FFFF
	dc.w	$C0C0,$0000

sp_justrg
	incbin 'win1_util_icon_asm_justrg_spr'
*
	end
