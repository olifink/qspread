* Sprite scrap
*
*	Mode 4
*	+|-----------------+
*	-	wwwwww	   -
*	|      wwrrrrww    |
*	|  wwwwwrrrrrrwwwww|
*	|  wrrwrrrrrrrrwrrw|
*	|  wr wwwwwwwwww rw|
*	|  wr		 rw|
*	|  w w	wwww www rw|
*	|    ww 	 rw|
*	|wwwwwww  www ww rw|
*	|wwwwwwww	 rw|
*	|wwwwwww  ww www rw|
*	|    ww 	 rw|
*	|  w w	rrrrrrrrrrw|
*	|  w   rrrrrrrrrrrw|
*	|  wwwwwwwwwwwwwwww|
*	+|-----------------+
*
	section sprite
	xdef	mes_scrap
	xref	mes_zero
mes_scrap
	dc.w	$0100,$0000
	dc.w	18,15,0,0
	dc.l	mcs_scrap-*
	dc.l	mes_zero-*
	dc.l	sp_scrap-*
mcs_scrap
	dc.w	$0101,$F8F8
	dc.w	$0000,$0000
	dc.w	$0303,$0CFC
	dc.w	$0000,$0000
	dc.w	$3E3F,$07FF
	dc.w	$C0C0,$0000
	dc.w	$243F,$02FF
	dc.w	$40C0,$0000
	dc.w	$2737,$FEFE
	dc.w	$40C0,$0000
	dc.w	$2030,$0000
	dc.w	$40C0,$0000
	dc.w	$2929,$EEEE
	dc.w	$40C0,$0000
	dc.w	$0C0C,$0000
	dc.w	$40C0,$0000
	dc.w	$FEFE,$7676
	dc.w	$40C0,$0000
	dc.w	$FFFF,$0000
	dc.w	$40C0,$0000
	dc.w	$FEFE,$6E6E
	dc.w	$40C0,$0000
	dc.w	$0C0C,$0000
	dc.w	$40C0,$0000
	dc.w	$2829,$00FF
	dc.w	$40C0,$0000
	dc.w	$2023,$00FF
	dc.w	$40C0,$0000
	dc.w	$3F3F,$FFFF
	dc.w	$C0C0,$0000
*
sp_scrap
	incbin	'win1_util_icon_scrap_spr'

	end
