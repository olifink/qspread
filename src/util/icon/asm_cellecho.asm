* Sprite cellecho
*
*	Mode 4
*	+|-------------------+
*	-wwwwwwwwwww g	     -
*	|wrrrrrrrrrw g g     |
*	|wrrrrrrrrrw g g g   |
*	|wrrrrrrrrrw g g g g |
*	|wrrrrwwrrrw g g g g |
*	|wrrrwaawwrw	   g |
*	|wrrrrwwaaww  www    |
*	|wrrrrrrwwaawwaawwwww|
*	|wwwwwwwwwwwaaaawrrrw|
*	|	 waaaaaawrrrw|
*	| gggggg wwwwwwwwrrrw|
*	|	  wrrrrrrrrrw|
*	|   ggggg wrrrrrrrrrw|
*	|	  wrrrrrrrrrw|
*	|     ggg wrrrrrrrrrw|
*	|	  wwwwwwwwwww|
*	+|-------------------+
*
	section sprite
	xdef	mes_cellecho
	xref	mes_zero
mes_cellecho
	dc.w	$0100,$0000
	dc.w	20,16,0,0
	dc.l	mcs_cellecho-*
	dc.l	mes_zero-*
	dc.l	sp_cellecho-*

mcs_cellecho
	dc.w	$FFFF,$E8E0
	dc.w	$0000,$0000
	dc.w	$80FF,$2AE0
	dc.w	$0000,$0000
	dc.w	$80FF,$2AE0
	dc.w	$8000,$0000
	dc.w	$80FF,$2AE0
	dc.w	$A000,$0000
	dc.w	$86FF,$2AE0
	dc.w	$A000,$0000
	dc.w	$89F9,$A0E0
	dc.w	$2000,$0000
	dc.w	$86FE,$6767
	dc.w	$0000,$0000
	dc.w	$81FF,$9999
	dc.w	$F0F0,$0000
	dc.w	$FFFF,$E1E1
	dc.w	$10F0,$0000
	dc.w	$0000,$8181
	dc.w	$10F0,$0000
	dc.w	$7E00,$FFFF
	dc.w	$10F0,$0000
	dc.w	$0000,$407F
	dc.w	$10F0,$0000
	dc.w	$1F00,$407F
	dc.w	$10F0,$0000
	dc.w	$0000,$407F
	dc.w	$10F0,$0000
	dc.w	$0700,$407F
	dc.w	$10F0,$0000
	dc.w	$0000,$7F7F
	dc.w	$F0F0,$0000

sp_cellecho
	incbin	'win1_util_icon_asm_cellecho_spr'

*
	end
