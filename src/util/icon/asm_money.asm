* Sprite money
*
*	Mode 4
*	+|-------------------+
*	-	w  ww	     -
*	|      wrwwrrw	g    |
*	|      wrrrrw  g     |
*	|	wrrrggg g    |
*	|	ggggg	     |
*	|     wwwrrrwww      |
*	|   wwrrrrrrrrrwww   |
*	|  wrrrrrrwrwrrrrrw  |
*	| wrrrrrwwwwwwwwrrrw |
*	|wrrrrrwrrwrwrrrrrrrw|
*	|wrrrrrrwwwwwwwrrrrrw|
*	|wrrrrrrrrwrwrrwrrrrw|
*	|wrrrrrwwwwwwwwrrrrrw|
*	| wrrrrrrrwrwrrrrrrw |
*	|  wwrrrrrrrrrrrrww  |
*	|    wwwwwwwwwwww    |
*	+|-------------------+
*
	section sprite
	xdef	mes_money
	xref	mes_zero
mes_money
	dc.w	$0100,$0000
	dc.w	20,16,0,0
	dc.l	mcs_money-*
	dc.l	mes_zero-*
	dc.l	sp_money-*

mcs_money
	dc.w	$0101,$3030
	dc.w	$0000,$0000
	dc.w	$0203,$C9F8
	dc.w	$0000,$0000
	dc.w	$0203,$12F0
	dc.w	$0000,$0000
	dc.w	$0101,$1DE0
	dc.w	$0000,$0000
	dc.w	$0100,$F000
	dc.w	$0000,$0000
	dc.w	$0707,$1CFC
	dc.w	$0000,$0000
	dc.w	$181F,$03FF
	dc.w	$8080,$0000
	dc.w	$203F,$50FF
	dc.w	$40C0,$0000
	dc.w	$417F,$FEFF
	dc.w	$20E0,$0000
	dc.w	$82FF,$50FF
	dc.w	$10F0,$0000
	dc.w	$81FF,$FCFF
	dc.w	$10F0,$0000
	dc.w	$80FF,$52FF
	dc.w	$10F0,$0000
	dc.w	$83FF,$FCFF
	dc.w	$10F0,$0000
	dc.w	$407F,$50FF
	dc.w	$20E0,$0000
	dc.w	$303F,$00FF
	dc.w	$C0C0,$0000
	dc.w	$0F0F,$FFFF
	dc.w	$0000,$0000

sp_money
	incbin 'win1_util_icon_asm_money_spr'
*
	end
