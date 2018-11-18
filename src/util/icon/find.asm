* Sprite find
*
*	Mode 4
*	+|----------------+
*	-	 wwwww	  -
*	|      wwaaaarww  |
*	|     waaawwwarrw |
*	|    waaawaaawrrrw|
*	|    waaaaaawarrrw|
*	|    waaaaawaarrrw|
*	|    waaaaaaarrrrw|
*	|     waaaawrrrrw |
*	|     rwwrrrrrww  |
*	|    rrrwwwwww	  |
*	|   rrrw	  |
*	|  rrrw 	  |
*	| rrrw		  |
*	|rrrw		  |
*	|rrw		  |
*	+|----------------+
*
	section sprite
	xdef	mes_find
	xref	mes_zero
mes_find
	dc.w	$0100,$0000
	dc.w	17,15,0,0
	dc.l	mcs_find-*
	dc.l	mes_zero-*
	dc.l	sp_find-*
mcs_find
	dc.w	$0000,$F8F8
	dc.w	$0000,$0000
	dc.w	$0303,$060E
	dc.w	$0000,$0000
	dc.w	$0404,$7177
	dc.w	$0000,$0000
	dc.w	$0808,$888F
	dc.w	$8080,$0000
	dc.w	$0808,$1017
	dc.w	$8080,$0000
	dc.w	$0808,$2027
	dc.w	$8080,$0000
	dc.w	$0808,$000F
	dc.w	$8080,$0000
	dc.w	$0404,$213F
	dc.w	$0000,$0000
	dc.w	$0307,$06FE
	dc.w	$0000,$0000
	dc.w	$010F,$F8F8
	dc.w	$0000,$0000
	dc.w	$021E,$0000
	dc.w	$0000,$0000
	dc.w	$043C,$0000
	dc.w	$0000,$0000
	dc.w	$0878,$0000
	dc.w	$0000,$0000
	dc.w	$10F0,$0000
	dc.w	$0000,$0000
	dc.w	$20E0,$0000
	dc.w	$0000,$0000
*
sp_find
	incbin	'win1_util_icon_find_spr'

	end
