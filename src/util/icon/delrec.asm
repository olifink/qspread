* Sprite delrec
*
*	Mode 4
*	+|-------------------+
*	-		     -
*	|		     |
*	|	ggg	ggg  |
*	|	 gggg  ggg   |
*	|  www	   gggggg    |
*	| w   w     gggg     |
*	|ww   wwwwwgggggg    |
*	|w	  ggg  ggg   |
*	|w rrr r ggg rr ggg  |
*	|w	ggg	ggg  |
*	|w rr rrgg rr r wgg  |
*	|w	g	w g  |
*	|w rrr rrr r rr w    |
*	|w		w    |
*	|wwwwwwwwwwwwwwww    |
*	+|-------------------+
*
	section sprite
	xdef	mes_delrec
	xref	mes_zero
mes_delrec
	dc.w	$0100,$0000
	dc.w	20,15,0,0
	dc.l	mcs_delrec-*
	dc.l	mes_zero-*
	dc.l	sp_bdelete-*
mcs_delrec
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0100,$C100
	dc.w	$C000,$0000
	dc.w	$0000,$F300
	dc.w	$8000,$0000
	dc.w	$3838,$3F00
	dc.w	$0000,$0000
	dc.w	$4444,$1E00
	dc.w	$0000,$0000
	dc.w	$C7C7,$FFC0
	dc.w	$0000,$0000
	dc.w	$8080,$7300
	dc.w	$8000,$0000
	dc.w	$80BA,$E10C
	dc.w	$C000,$0000
	dc.w	$8180,$C100
	dc.w	$C000,$0000
	dc.w	$81B6,$8135
	dc.w	$C000,$0000
	dc.w	$8180,$0101
	dc.w	$4000,$0000
	dc.w	$80BB,$01AD
	dc.w	$0000,$0000
	dc.w	$8080,$0101
	dc.w	$0000,$0000
	dc.w	$FFFF,$FFFF
	dc.w	$0000,$0000
*
sp_bdelete
	incbin	'win1_util_icon_bdelete_spr'

	end
