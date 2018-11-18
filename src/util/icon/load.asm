* Sprite load
*
*	Mode 4
*	+|-------------------+
*	-		 w   -
*	|	w	 ww  |
*	|      wrw    wwwwww |
*	|     warrw   wwwwwww|
*	|    waaarrw  wwwwww |
*	|   waaaaarrw	 ww  |
*	|  waaaaarrrrw	 w   |
*	| waaaaarrrwwrw      |
*	|wrraaarrrwwwwrw     |
*	| wrrarrrwwwwww      |
*	|  wrrrrwawwww	     |
*	|   wrrwaaaww	     |
*	|    wrrwaaw	     |
*	|     wrrww	     |
*	|      wrw	     |
*	|	w	     |
*	+|-------------------+
*
	section sprite
	xdef	mes_load
	xref	mes_zero
mes_load
	dc.w	$0100,$0000
	dc.w	20,16,0,0
	dc.l	mcs_load-*
	dc.l	mes_zero-*
	dc.l	sp_load-*
mcs_load
	dc.w	$0000,$0000
	dc.w	$8080,$0000
	dc.w	$0101,$0000
	dc.w	$C0C0,$0000
	dc.w	$0203,$8787
	dc.w	$E0E0,$0000
	dc.w	$0405,$47C7
	dc.w	$F0F0,$0000
	dc.w	$0808,$27E7
	dc.w	$E0E0,$0000
	dc.w	$1010,$1070
	dc.w	$C0C0,$0000
	dc.w	$2020,$08F8
	dc.w	$8080,$0000
	dc.w	$4041,$34FC
	dc.w	$0000,$0000
	dc.w	$80E3,$7AFE
	dc.w	$0000,$0000
	dc.w	$4077,$FCFC
	dc.w	$0000,$0000
	dc.w	$213F,$7878
	dc.w	$0000,$0000
	dc.w	$121E,$3030
	dc.w	$0000,$0000
	dc.w	$090F,$2020
	dc.w	$0000,$0000
	dc.w	$0407,$C0C0
	dc.w	$0000,$0000
	dc.w	$0203,$8080
	dc.w	$0000,$0000
	dc.w	$0101,$0000
	dc.w	$0000,$0000
*
sp_load
	incbin	'win1_util_icon_load_spr'

	end
