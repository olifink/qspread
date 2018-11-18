* Sprite save
*
*	Mode 4
*	+|-------------------+
*	-    w		     -
*	|    ww      w	     |
*	|wwwwwww    wrw      |
*	|wwwwwwww  warrw     |
*	|wwwwwww  waaarrw    |
*	|    ww  waaaaarrw   |
*	|    w	waaaaarrrrw  |
*	|      waaaaarrrwwrw |
*	|     wrraaarrrwwwwrw|
*	|      wrrarrrwwwwww |
*	|	wrrrrwawwww  |
*	|	 wrrwaaaww   |
*	|	  wrrwaaw    |
*	|	   wrrww     |
*	|	    wrw      |
*	|	     w	     |
*	+|-------------------+
*
	section sprite
	xdef	mes_save
	xref	mes_zero
mes_save
	dc.w	$0100,$0000
	dc.w	20,16,0,0
	dc.l	mcs_save-*
	dc.l	mes_zero-*
	dc.l	sp_save-*
mcs_save
	dc.w	$0808,$0000
	dc.w	$0000,$0000
	dc.w	$0C0C,$0808
	dc.w	$0000,$0000
	dc.w	$FEFE,$141C
	dc.w	$0000,$0000
	dc.w	$FFFF,$222E
	dc.w	$0000,$0000
	dc.w	$FEFE,$4147
	dc.w	$0000,$0000
	dc.w	$0C0C,$8083
	dc.w	$8080,$0000
	dc.w	$0909,$0007
	dc.w	$40C0,$0000
	dc.w	$0202,$010F
	dc.w	$A0E0,$0000
	dc.w	$0407,$031F
	dc.w	$D0F0,$0000
	dc.w	$0203,$07BF
	dc.w	$E0E0,$0000
	dc.w	$0101,$0BFB
	dc.w	$C0C0,$0000
	dc.w	$0000,$91F1
	dc.w	$8080,$0000
	dc.w	$0000,$4979
	dc.w	$0000,$0000
	dc.w	$0000,$263E
	dc.w	$0000,$0000
	dc.w	$0000,$141C
	dc.w	$0000,$0000
	dc.w	$0000,$0808
	dc.w	$0000,$0000
*
sp_save
	incbin	'win1_util_icon_save_spr'

	end
