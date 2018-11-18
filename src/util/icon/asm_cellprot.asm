* Sprite cellprot
*
*	Mode 4
*	+|------------------+
*	-wwwwwwwwwwww	    -
*	|wrrrrrrrrrrw	    |
*	|wrrrrrrrrrrw	    |
*	|wrrrrrrrrrrw	    |
*	|wrrrrrrrwwwwwwwww  |
*	|wrrrrrrwwaaaaaaaww |
*	|wrrrrrrwaawwwwwaaw |
*	|wrrrrrwwawwwwwwwaww|
*	|wwwwwwwaaaaaaaaaaaw|
*	|      waaaaawaaaaaw|
*	|      waaaawwwaaaaw|
*	|      waaaaawaaaaaw|
*	|      wwaaaawaaaaww|
*	|	wwaaaaaaaww |
*	|	 wwwwwwwww  |
*	+|------------------+
*
	section sprite
	xdef	mes_cellprot
	xref	mes_zero
mes_cellprot
	dc.w	$0100,$0000
	dc.w	19,15,0,0
	dc.l	mcs_cellprot-*
	dc.l	mes_zero-*
	dc.l	sp_cellprot-*

mcs_cellprot
	dc.w	$FFFF,$F0F0
	dc.w	$0000,$0000
	dc.w	$80FF,$10F0
	dc.w	$0000,$0000
	dc.w	$80FF,$10F0
	dc.w	$0000,$0000
	dc.w	$80FF,$10F0
	dc.w	$0000,$0000
	dc.w	$80FF,$FFFF
	dc.w	$8080,$0000
	dc.w	$81FF,$8080
	dc.w	$C0C0,$0000
	dc.w	$81FF,$3E3E
	dc.w	$4040,$0000
	dc.w	$83FF,$7F7F
	dc.w	$6060,$0000
	dc.w	$FEFE,$0000
	dc.w	$2020,$0000
	dc.w	$0202,$0808
	dc.w	$2020,$0000
	dc.w	$0202,$1C1C
	dc.w	$2020,$0000
	dc.w	$0202,$0808
	dc.w	$2020,$0000
	dc.w	$0303,$0808
	dc.w	$6060,$0000
	dc.w	$0101,$8080
	dc.w	$C0C0,$0000
	dc.w	$0000,$FFFF
	dc.w	$8080,$0000

sp_cellprot
	incbin 'win1_util_icon_asm_Cellprot_spr'
*
	end
