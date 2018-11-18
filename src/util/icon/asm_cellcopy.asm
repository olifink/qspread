* Sprite cellcopy
*
*	Mode 4
*	+|-------------------+
*	-wwwwwwwwwww	     -
*	|wrrrrrrrrrw	     |
*	|wrrrrrrrrrw	     |
*	|wrrrrrrrrrw	     |
*	|wrrrrwwrrrw	     |
*	|wrrrwaawwrw	     |
*	|wrrrrwwaaww  www    |
*	|wrrrrrrwwaawwaawwwww|
*	|wwwwwwwwwwwaaaawrrrw|
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
	xdef	mes_cellcopy
	xref	mes_zero
mes_cellcopy
	dc.w	$0100,$0000
	dc.w	20,16,0,0
	dc.l	mcs_cellcopy-*
	dc.l	mes_zero-*
	dc.l	sp_cellcopy-*
mcs_cellcopy
	dc.w	$FFFF,$E0E0
	dc.w	$0000,$0000
	dc.w	$80FF,$20E0
	dc.w	$0000,$0000
	dc.w	$80FF,$20E0
	dc.w	$0000,$0000
	dc.w	$80FF,$20E0
	dc.w	$0000,$0000
	dc.w	$86FF,$20E0
	dc.w	$0000,$0000
	dc.w	$89F9,$A0E0
	dc.w	$0000,$0000
	dc.w	$86FE,$6767
	dc.w	$0000,$0000
	dc.w	$81FF,$9999
	dc.w	$F0F0,$0000
	dc.w	$FFFF,$E1E1
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
sp_cellcopy
	incbin	'win1_util_icon_asm_cellcopy_spr'

	end
