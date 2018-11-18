* Sprite info
*
*	Mode 4
*	+|-----------------+
*	-     wwwwwwww	   -
*	|   wwwrrrrrrwww   |
*	|  wwrrrrwwrrrrww  |
*	| wwrrrrrwwrrrrrww |
*	| wrrrrrrrrrrrrrrw |
*	|wwrrrrrwwwrrrrrrww|
*	|wrrrrrrwwwrrrrrrrw|
*	|wrrrrrrrwwrrrrrrrw|
*	|wwrrrrrrwwrrrrrrww|
*	| wrrrrrwwwwrrrrrw |
*	| wwrrrrwwwwrrrrww |
*	|  wwrrrrrrrrrrww  |
*	|   wwwrrrrrrwww   |
*	|     wwwwwwww	   |
*	+|-----------------+
*
	section sprite
	xdef	mes_info
	xref	mes_zero
mes_info
	dc.w	$0100,$0000
	dc.w	18,14,0,0
	dc.l	mcs_info-*
	dc.l	mes_zero-*
	dc.l	sp_info-*
mcs_info
	dc.w	$0707,$F8F8
	dc.w	$0000,$0000
	dc.w	$1C1F,$0EFE
	dc.w	$0000,$0000
	dc.w	$303F,$C3FF
	dc.w	$0000,$0000
	dc.w	$607F,$C1FF
	dc.w	$8080,$0000
	dc.w	$407F,$00FF
	dc.w	$8080,$0000
	dc.w	$C1FF,$C0FF
	dc.w	$C0C0,$0000
	dc.w	$81FF,$C0FF
	dc.w	$40C0,$0000
	dc.w	$80FF,$C0FF
	dc.w	$40C0,$0000
	dc.w	$C0FF,$C0FF
	dc.w	$C0C0,$0000
	dc.w	$417F,$E0FF
	dc.w	$8080,$0000
	dc.w	$617F,$E1FF
	dc.w	$8080,$0000
	dc.w	$303F,$03FF
	dc.w	$0000,$0000
	dc.w	$1C1F,$0EFE
	dc.w	$0000,$0000
	dc.w	$0707,$F8F8
	dc.w	$0000,$0000
*
sp_info
	incbin	'win1_util_icon_info_spr'

	end
