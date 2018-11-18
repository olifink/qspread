* Sprite optcol
*
*	Mode 4
*	+|-----------------+
*	-w		  w-
*	|		   |
*	|w		  w|
*	|		   |
*	|wwwwwwwwwwwwwwwwww|
*	|wrrgrrrrrrrrrrgrrw|
*	|wrgrrrrrrrrrrrrgrw|
*	|wggggggrrrrggggggw|
*	|wrgrrrrrrrrrrrrgrw|
*	|wrrgrrrrrrrrrrgrrw|
*	|wwwwwwwwwwwwwwwwww|
*	|		   |
*	|w		  w|
*	|		   |
*	|w		  w|
*	+|-----------------+
*
	section sprite
	xdef	mes_optcol
	xref	mes_zero
mes_optcol
	dc.w	$0100,$0000
	dc.w	18,15,0,0
	dc.l	mcs_optcol-*
	dc.l	mes_zero-*
	dc.l	sp_optcol-*

mcs_optcol
	dc.w	$8080,$0000
	dc.w	$4040,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$8080,$0000
	dc.w	$4040,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$FFFF,$FFFF
	dc.w	$C0C0,$0000
	dc.w	$90EF,$02FD
	dc.w	$40C0,$0000
	dc.w	$A0DF,$01FE
	dc.w	$40C0,$0000
	dc.w	$FE81,$1FE0
	dc.w	$C040,$0000
	dc.w	$A0DF,$01FE
	dc.w	$40C0,$0000
	dc.w	$90EF,$02FD
	dc.w	$40C0,$0000
	dc.w	$FFFF,$FFFF
	dc.w	$C0C0,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$8080,$0000
	dc.w	$4040,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$8080,$0000
	dc.w	$4040,$0000

sp_optcol
	incbin 'win1_util_icon_asm_optcol_spr'
*
	end
