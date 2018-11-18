* Sprite cros
*
*	Mode 4
*	+------|-----+
*	|rrrr	 rrrr|
*	| rrrr	rrrr |
*	|  rrr	rrr  |
*	|   rrrrrr   |
*	-    rrrr    -
*	|   rrrrrr   |
*	|  rrr	rrr  |
*	| rrrr	rrrr |
*	|rrrr	 rrrr|
*	+------|-----+
*
	section sprite
	xdef	mes_cros
mes_cros
	dc.w	$0100,$0000
	dc.w	12,9,6,5
	dc.l	sc4_cros-*
	dc.l	sm4_cros-*
	dc.l	0
sc4_cros
	dc.w	$00f0,$00f0
	dc.w	$0079,$00e0
	dc.w	$003f,$00c0
	dc.w	$001f,$0080
	dc.w	$000f,$0000
	dc.w	$001f,$0080
	dc.w	$003f,$00c0
	dc.w	$0079,$00e0
	dc.w	$00f0,$00f0
sm4_cros
	dc.w	$f0f0,$f0f0
	dc.w	$7979,$e0e0
	dc.w	$3f3f,$c0c0
	dc.w	$1f1f,$8080
	dc.w	$0f0f,$0000
	dc.w	$1f1f,$8080
	dc.w	$3f3f,$c0c0
	dc.w	$7979,$e0e0
	dc.w	$f0f0,$f0f0
	end
