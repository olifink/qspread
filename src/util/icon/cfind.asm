* Sprite cfind
*
*	Mode 4
*	+---|----------------+
*	|ggg ggg    wwwww    |
*	|g   g g  wwaaaarww  |
*	-gg  ggg waaawwwarrw -
*	|g     gwaaawaaawrrrw|
*	|g   gggwaaaaaawarrrw|
*	|	waaaaawaarrrw|
*	|	waaaaaaarrrrw|
*	|	 waaaawrrrrw |
*	|	 rwwrrrrrww  |
*	|	rrrwwwwww    |
*	|      rrrw	     |
*	|     rrrw	     |
*	|    rrrw	     |
*	|   rrrw   ww  ww  ww|
*	|   rrw    ww  ww  ww|
*	+---|----------------+
*
	section sprite
	xdef	mes_cfind
	xref	mes_zero
mes_cfind
	dc.w	$0100,$0000
	dc.w	20,15,0,0	;3,2
	dc.l	mcs_cfind-*
	dc.l	mes_zero-*
	dc.l	sp_cfind-*
mcs_cfind
	dc.w	$EE00,$1F1F
	dc.w	$0000,$0000
	dc.w	$8A00,$6061
	dc.w	$C0C0,$0000
	dc.w	$CE00,$8E8E
	dc.w	$20E0,$0000
	dc.w	$8301,$1111
	dc.w	$10F0,$0000
	dc.w	$8F01,$0202
	dc.w	$10F0,$0000
	dc.w	$0101,$0404
	dc.w	$10F0,$0000
	dc.w	$0101,$0001
	dc.w	$10F0,$0000
	dc.w	$0000,$8487
	dc.w	$20E0,$0000
	dc.w	$0000,$60FF
	dc.w	$C0C0,$0000
	dc.w	$0001,$3FFF
	dc.w	$0000,$0000
	dc.w	$0003,$40C0
	dc.w	$0000,$0000
	dc.w	$0007,$8080
	dc.w	$0000,$0000
	dc.w	$010F,$0000
	dc.w	$0000,$0000
	dc.w	$021E,$3333
	dc.w	$3030,$0000
	dc.w	$041C,$3333
	dc.w	$3030,$0000
*
sp_cfind
	incbin	'win1_util_icon_cfind_spr'

	end
