* Sprite bdelete
*
*	Mode 4
*	+|--------------------+
*	-wwwww		      -
*	|w	     www      |
*	|w rrr rrr   wawww    |
*	|w	   w wawrrwww |
*	|  rr rrrr w rrrrrrrrw|
*	|      wwwww rrrrrwww |
*	|	     wwwwwrrw |
*	|	wrwrrrrrrrwrw |
*	|	wrwrwrrrrrwrw |
*	|	wrwrwrwrwrwrw |
*	|	wrwrwrwwwrwrw |
*	|	wrwrwrrrrrwrw |
*	|	wrwrwrrrrrwrw |
*	|	wrrrwrrrrrrrw |
*	|	 wwrrrrrrrww  |
*	|	   wwwwwww    |
*	+|--------------------+
*
	section sprite
	xdef	mes_bdelete
	xref	mes_zero
mes_bdelete
	dc.w	$0100,$0000
	dc.w	21,16,0,0
	dc.l	mcs_bdelete-*
	dc.l	mes_zero-*
	dc.l	sp_bdelete-*
mcs_bdelete
	dc.w	$F8F8,$0000
	dc.w	$0000,$0000
	dc.w	$8080,$0E0E
	dc.w	$0000,$0000
	dc.w	$80BB,$0B8B
	dc.w	$8080,$0000
	dc.w	$8080,$2A2B
	dc.w	$70F0,$0000
	dc.w	$0037,$20AF
	dc.w	$08F8,$0000
	dc.w	$0303,$E0EF
	dc.w	$70F0,$0000
	dc.w	$0000,$0F0F
	dc.w	$90F0,$0000
	dc.w	$0101,$40FF
	dc.w	$50F0,$0000
	dc.w	$0101,$50FF
	dc.w	$50F0,$0000
	dc.w	$0101,$55FF
	dc.w	$50F0,$0000
	dc.w	$0101,$57FF
	dc.w	$50F0,$0000
	dc.w	$0101,$50FF
	dc.w	$50F0,$0000
	dc.w	$0101,$50FF
	dc.w	$50F0,$0000
	dc.w	$0101,$10FF
	dc.w	$10F0,$0000
	dc.w	$0000,$C0FF
	dc.w	$60E0,$0000
	dc.w	$0000,$3F3F
	dc.w	$8080,$0000
*
sp_bdelete
	incbin	'win1_util_icon_bdelete_spr'

	end
