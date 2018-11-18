* Sprite cellmove
*
*	Mode 4
*	+|-------------------+
*	- w w w w w	     -
*	|w r r r r w	     |
*	| r r r r r	     |
*	|w r r r r w	     |
*	| r r wwr r	     |
*	|w r waaww w	     |
*	| r r wwaaww  www    |
*	|w r r rwwaawwaawwwww|
*	| w w w wwwwaaaawrrrw|
*	|	 waaaaaawrrrw|
*	|	 wwwwwwwwrrrw|
*	|	  wrrrrrrrrrw|
*	|	  wrrrrrrrrrw|
*	|	  wrrrrrrrrrw|
*	|	  wrrrrrrrrrw|
*	|	  wwwwwwwwwww|
*	+|-------------------+
*
	section sprite
	xdef	mes_cellmove
	xref	mes_zero
mes_cellmove
	dc.w	$0100,$0000
	dc.w	20,16,0,0
	dc.l	mcs_cellmove-*
	dc.l	mes_zero-*
	dc.l	sp_cellmove-*
mcs_cellmove
	dc.w	$5555,$4040
	dc.w	$0000,$0000
	dc.w	$80AA,$20A0
	dc.w	$0000,$0000
	dc.w	$0055,$0040
	dc.w	$0000,$0000
	dc.w	$80AA,$20A0
	dc.w	$0000,$0000
	dc.w	$0657,$0040
	dc.w	$0000,$0000
	dc.w	$89A9,$A0A0
	dc.w	$0000,$0000
	dc.w	$0656,$6767
	dc.w	$0000,$0000
	dc.w	$81AB,$9999
	dc.w	$F0F0,$0000
	dc.w	$5555,$E1E1
	dc.w	$10F0,$0000
	dc.w	$0000,$8181
	dc.w	$10F0,$0000
	dc.w	$0000,$FFFF
	dc.w	$10F0,$0000
	dc.w	$0000,$407F
	dc.w	$10F0,$0000
	dc.w	$0000,$407F
	dc.w	$10F0,$0000
	dc.w	$0000,$407F
	dc.w	$10F0,$0000
	dc.w	$0000,$407F
	dc.w	$10F0,$0000
	dc.w	$0000,$7F7F
	dc.w	$F0F0,$0000
*
sp_cellmove
	incbin	'win1_util_icon_asm_cellmove_spr'

	end
