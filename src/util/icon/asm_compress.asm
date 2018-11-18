* Sprite compress
*
*	Mode 4
*	+---|----------------+
*	-   wwwwwwwwww	     -
*	|   wwwwwwwwwwwwwwww |
*	|rrrrrrrrr  wwwwwwww |
*	|r    r  r    rrrww  |
*	|r ww  r r    rwwr   |
*	|r	rr   wwrrr   |
*	|r w ww  r    rrrww  |
*	|r	 r    rwwr   |
*	|r www w r   wwrrr   |
*	|r	 r    rrrww  |
*	|r ww ww r    rww    |
*	|rrrrrrrrr  wwwwwwww |
*	|   wwwwwwwwwwwwwwww |
*	|   wwwwwwwwwwrwwr   |
*	|	     wwrrr   |
*	|	      rrrww  |
*	+---|----------------+
*
	section sprite
	xdef	mes_compress
	xref	mes_zero
mes_compress
	dc.w	$0100,$0000
	dc.w	20,16,0,0
	dc.l	mcs_compress-*
	dc.l	mes_zero-*
	dc.l	sp_compress-*
mcs_compress
	dc.w	$1F1F,$F8F8
	dc.w	$0000,$0000
	dc.w	$1F1F,$FFFF
	dc.w	$E0E0,$0000
	dc.w	$00FF,$1F9F
	dc.w	$E0E0,$0000
	dc.w	$0084,$0087
	dc.w	$C0C0,$0000
	dc.w	$30B2,$0387
	dc.w	$0080,$0000
	dc.w	$0081,$0C8F
	dc.w	$0080,$0000
	dc.w	$2CAC,$0087
	dc.w	$C0C0,$0000
	dc.w	$0080,$0387
	dc.w	$0080,$0000
	dc.w	$3ABA,$0C8F
	dc.w	$0080,$0000
	dc.w	$0080,$0087
	dc.w	$C0C0,$0000
	dc.w	$36B6,$0387
	dc.w	$0000,$0000
	dc.w	$00FF,$1F9F
	dc.w	$E0E0,$0000
	dc.w	$1F1F,$FFFF
	dc.w	$E0E0,$0000
	dc.w	$1F1F,$FBFF
	dc.w	$0080,$0000
	dc.w	$0000,$0C0F
	dc.w	$0080,$0000
	dc.w	$0000,$0007
	dc.w	$C0C0,$0000
*
sp_compress
	incbin	'win1_util_icon_compress_spr'

	end
