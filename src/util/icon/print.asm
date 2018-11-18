* Sprite print
*
*	Mode 4
*	+|-------------------+
*	-    wwwwwwwwwwww    -
*	|    waaaaaaaaaaw    |
*	|    wawwawwawwaw    |
*	|    waaaaaaaaaaw    |
*	|    wawawwawwwaw    |
*	|  wwwaaaaaaaaaawww  |
*	|  wawawwwawwawawaw  |
*	|  wawaaaaaaaaaawaw  |
*	|wwwwwwwwwwwwwwwwwwww|
*	|wrararararararararaw|
*	|wrwrwrrrrrrrrwwwwwrw|
*	|wrrrrrrrrrrrrrrrrrrw|
*	|wwwwwwwwwwwwwwwwwwww|
*	| wrarararararararaw |
*	|  wwwwwwwwwwwwwwww  |
*	+|-------------------+
*
	section sprite
	xdef	mes_print
	xref	mes_zero
mes_print
	dc.w	$0100,$0000
	dc.w	20,15,0,0
	dc.l	mcs_print-*
	dc.l	mes_zero-*
	dc.l	sp_print-*
mcs_print
	dc.w	$0F0F,$FFFF
	dc.w	$0000,$0000
	dc.w	$0808,$0101
	dc.w	$0000,$0000
	dc.w	$0B0B,$6D6D
	dc.w	$0000,$0000
	dc.w	$0808,$0101
	dc.w	$0000,$0000
	dc.w	$0A0A,$DDDD
	dc.w	$0000,$0000
	dc.w	$3838,$0101
	dc.w	$C0C0,$0000
	dc.w	$2B2B,$B5B5
	dc.w	$4040,$0000
	dc.w	$2828,$0101
	dc.w	$4040,$0000
	dc.w	$FFFF,$FFFF
	dc.w	$F0F0,$0000
	dc.w	$80D5,$0055
	dc.w	$1050,$0000
	dc.w	$A8FF,$07FF
	dc.w	$D0F0,$0000
	dc.w	$80FF,$00FF
	dc.w	$10F0,$0000
	dc.w	$FFFF,$FFFF
	dc.w	$F0F0,$0000
	dc.w	$406A,$00AA
	dc.w	$20A0,$0000
	dc.w	$3F3F,$FFFF
	dc.w	$C0C0,$0000
*
sp_print
	incbin	'win1_util_icon_print_spr'

	end
