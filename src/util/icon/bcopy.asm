* Sprite bcopy
*
*	Mode 4
*	+|-------------------+
*	|	 wwwwww      |
*	-  wwww  waaaaw  wwww-
*	|  w  w  wrrrrw  w  w|
*	|  wwwwwwwwwwwwwwwwww|
*	|  wwwwwwwaaaawwwwwww|
*	|  wwwwwwawwwwawwwwww|
*	|  wwwwwawaaaawawwwww|
*	|  wwwwwawaaaawawwwww|
*	|  wwwwwwawwwwawwwwww|
*	|     wwwwaaaawwwwwww|
*	|wwww  wwwwwwwwwwwwww|
*	|w		     |
*	|w rrrr rr r w	     |
*	|	     w	     |
*	|  rr rr rrr w	     |
*	|	  wwww	     |
*	+|-------------------+
*
	section sprite
	xdef	mes_bcopy
	xref	mes_zero
mes_bcopy
	dc.w	$0100,$0000
	dc.w	20,16,0,0
	dc.l	mcs_bcopy-*
	dc.l	mes_zero-*
	dc.l	sp_bcopy-*
mcs_bcopy
	dc.w	$0000,$FCFC
	dc.w	$0000,$0000
	dc.w	$3C3C,$8484
	dc.w	$F0F0,$0000
	dc.w	$2424,$84FC
	dc.w	$9090,$0000
	dc.w	$3F3F,$FFFF
	dc.w	$F0F0,$0000
	dc.w	$3F3F,$8787
	dc.w	$F0F0,$0000
	dc.w	$3F3F,$7B7B
	dc.w	$F0F0,$0000
	dc.w	$3E3E,$8585
	dc.w	$F0F0,$0000
	dc.w	$3E3E,$8585
	dc.w	$F0F0,$0000
	dc.w	$3F3F,$7B7B
	dc.w	$F0F0,$0000
	dc.w	$0707,$8787
	dc.w	$F0F0,$0000
	dc.w	$F3F3,$FFFF
	dc.w	$F0F0,$0000
	dc.w	$8080,$0000
	dc.w	$0000,$0000
	dc.w	$80BD,$08A8
	dc.w	$0000,$0000
	dc.w	$0000,$0808
	dc.w	$0000,$0000
	dc.w	$0036,$08E8
	dc.w	$0000,$0000
	dc.w	$0000,$7878
	dc.w	$0000,$0000
*
sp_bcopy
	incbin	'win1_util_icon_bcopy_spr'

	end
