* Sprite attn
*
*	Mode 4
*	+-|------------------+
*	-	  rr	     -
*	|	 rrrr	     |
*	|	rrwwrr	     |
*	|      rrwaawrr      |
*	|     rrwwaawwrr     |
*	|    rrwwwaawwwrr    |
*	|   rrwwwwwwwwwwrr   |
*	|  rrwwwwwaawwwwwrr  |
*	| rrwwwwwwwwwwwwwwrr |
*	|rrrrrrrrrrrrrrrrrrrr|
*	+-|------------------+
*
	section sprite
	xdef	mes_attn
mes_attn
	dc.w	$0100,$0000
	dc.w	20,10,1,0
	dc.l	sc4_attn-*
	dc.l	sm4_attn-*
	dc.l	0
sc4_attn
	dc.w	$0000,$0060
	dc.w	$0000,$0000
	dc.w	$0000,$00F0
	dc.w	$0000,$0000
	dc.w	$0001,$60F8
	dc.w	$0000,$0000
	dc.w	$0003,$909C
	dc.w	$0000,$0000
	dc.w	$0107,$989E
	dc.w	$0000,$0000
	dc.w	$030F,$9C9F
	dc.w	$0000,$0000
	dc.w	$071F,$FEFF
	dc.w	$0080,$0000
	dc.w	$0F3F,$9F9F
	dc.w	$00C0,$0000
	dc.w	$1F7F,$FFFF
	dc.w	$80E0,$0000
	dc.w	$00FF,$00FF
	dc.w	$00F0,$0000
sm4_attn
	dc.w	$0000,$6060
	dc.w	$0000,$0000
	dc.w	$0000,$F0F0
	dc.w	$0000,$0000
	dc.w	$0101,$F8F8
	dc.w	$0000,$0000
	dc.w	$0303,$FCFC
	dc.w	$0000,$0000
	dc.w	$0707,$FEFE
	dc.w	$0000,$0000
	dc.w	$0F0F,$FFFF
	dc.w	$0000,$0000
	dc.w	$1F1F,$FFFF
	dc.w	$8080,$0000
	dc.w	$3F3F,$FFFF
	dc.w	$C0C0,$0000
	dc.w	$7F7F,$FFFF
	dc.w	$E0E0,$0000
	dc.w	$FFFF,$FFFF
	dc.w	$F0F0,$0000
*
	end
