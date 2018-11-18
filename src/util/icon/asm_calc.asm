* Sprite calc
*
*	Mode 4
*	+|--------------+
*	- wwwwwwwwwwwww -
*	|w	       w|
*	|w rrrrrrrrrrr w|
*	|w rrrrrrrrrrr w|
*	|w rrrrrrrrrrr w|
*	|w	       w|
*	|w	       w|
*	|w ww ww ww ww w|
*	|w	       w|
*	|w ww ww ww ww w|
*	|w	       w|
*	|w ww ww ww ww w|
*	|w	    ww w|
*	|w ww ww ww ww w|
*	|w	       w|
*	| wwwwwwwwwwwww |
*	+|--------------+
*
	section sprite
	xdef	mes_calc
	xref	mes_zero
mes_calc
	dc.w	$0100,$0000
	dc.w	15,16,0,0
	dc.l	mcs_calc-*
	dc.l	mes_zero-*
	dc.l	sp_calc-*
mcs_calc
	dc.w	$7F7F,$FCFC
	dc.w	$8080,$0202
	dc.w	$80BF,$02FA
	dc.w	$80BF,$02FA
	dc.w	$80BF,$02FA
	dc.w	$8080,$0202
	dc.w	$8080,$0202
	dc.w	$B6B6,$DADA
	dc.w	$8080,$0202
	dc.w	$B6B6,$DADA
	dc.w	$8080,$0202
	dc.w	$B6B6,$DADA
	dc.w	$8080,$1A1A
	dc.w	$B6B6,$DADA
	dc.w	$8080,$0202
	dc.w	$7F7F,$FCFC
*
sp_calc
       incbin  'win1_util_icon_asm_calc_spr'


	end
