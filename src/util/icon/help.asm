* Sprite help
*
*	Mode 4
*	+|-------------------+
*	|    wwww	     |
*	|  wwrrrrww	     |
*	- wrrrrrrrrw	     -
*	|wrrrwwwwrrw   rrr   |
*	|wrrw	 wrrw rrrrrr |
*	| ww	 wrrw	  rrr|
*	|      wwrrw	   rr|
*	|     wrrrrw	   rr|
*	|    wrrrww	  rrr|
*	|    wrrw     rrrrrr |
*	|    wrrw   rrrrrr   |
*	|     ww   rrrggg  g |
*	|	   rr g   gg |
*	|     wwr     gg   g |
*	|    wrrwr    g    g |
*	|     ww      g   ggg|
*	+|-------------------+
*
	section sprite
	xdef	mes_help
	xref	mes_zero
mes_help
	dc.w	$0100,$0000
	dc.w	20,16,0,0
	dc.l	mcs_help-*
	dc.l	mes_zero-*
	dc.l	sp_help-*
mcs_help
	dc.w	$0F0F,$0000
	dc.w	$0000,$0000
	dc.w	$303F,$C0C0
	dc.w	$0000,$0000
	dc.w	$407F,$20E0
	dc.w	$0000,$0000
	dc.w	$8FFF,$20E3
	dc.w	$0080,$0000
	dc.w	$90F0,$90F7
	dc.w	$00E0,$0000
	dc.w	$6060,$90F0
	dc.w	$0070,$0000
	dc.w	$0303,$20E0
	dc.w	$0030,$0000
	dc.w	$0407,$20E0
	dc.w	$0030,$0000
	dc.w	$080F,$C0C0
	dc.w	$0070,$0000
	dc.w	$090F,$0007
	dc.w	$00E0,$0000
	dc.w	$090F,$001F
	dc.w	$0080,$0000
	dc.w	$0606,$0738
	dc.w	$2000,$0000
	dc.w	$0000,$0430
	dc.w	$6000,$0000
	dc.w	$0607,$0600
	dc.w	$2000,$0000
	dc.w	$090F,$0480
	dc.w	$2000,$0000
	dc.w	$0606,$0400
	dc.w	$7000,$0000
*
sp_help
	incbin	'win1_util_icon_help_spr'

	end
