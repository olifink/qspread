* Sprite wwrap
*
*	Mode 4
*	+|-----------------+
*	-www wwww ww wwgg  -
*	|	       gg  |
*	|wwwww wwww ww gg  |
*	|	       gg  |
*	|www wwww ww wwgg  |
*	|	       gg  |
*	|wwww ww wwwwwwwwww|
*	|		   |
*	|	       gg  |
*	|		   |
*	|	       gg  |
*	|		   |
*	|	       gg  |
*	|		   |
*	+|-----------------+
*
	section sprite
	xdef	mes_wwrap
	xref	mes_zero
mes_wwrap
	dc.w	$0100,$0000
	dc.w	18,14,0,0
	dc.l	mcs_wwrap-*
	dc.l	mes_zero-*
	dc.l	sp_wwrap-*
mcs_wwrap
	dc.w	$EFEF,$6F6C
	dc.w	$0000,$0000
	dc.w	$0000,$0300
	dc.w	$0000,$0000
	dc.w	$FBFB,$DBD8
	dc.w	$0000,$0000
	dc.w	$0000,$0300
	dc.w	$0000,$0000
	dc.w	$EFEF,$6F6C
	dc.w	$0000,$0000
	dc.w	$0000,$0300
	dc.w	$0000,$0000
	dc.w	$F6F6,$FFFF
	dc.w	$C0C0,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0300
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0300
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0300
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000

*
sp_wwrap
	incbin	'win1_util_icon_wwrap_spr'

	end
