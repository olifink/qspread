* Sprite bstart
*
*	Mode 4
*	+|-----------------+
*	-wwwww	    ggg ggg-
*	|  w	    g	  g|
*	|  w	    gg	 g |
*	|  w	    g	g  |
*	|w w w	    g	g  |
*	| www		   |
*	|  w		   |
*	|		   |
*	|wwwwww 	   |
*	|ww		   |
*	|ww rr rrrr rr rrrr|
*	|ww		   |
*	|   rrr rr rrrrr rr|
*	|		   |
*	|   rrrr rrr rr rrr|
*	+|-----------------+
*
	section sprite
	xdef	mes_bstart
	xref	mes_zero
mes_bstart
	dc.w	$0100,$0000
	dc.w	18,15,0,0
	dc.l	mcs_bstart-*
	dc.l	mes_zero-*
	dc.l	sp_bstart-*
mcs_bstart
	dc.w	$F8F8,$1D00
	dc.w	$C000,$0000
	dc.w	$2020,$1000
	dc.w	$4000,$0000
	dc.w	$2020,$1800
	dc.w	$8000,$0000
	dc.w	$2020,$1100
	dc.w	$0000,$0000
	dc.w	$A8A8,$1100
	dc.w	$0000,$0000
	dc.w	$7070,$0000
	dc.w	$0000,$0000
	dc.w	$2020,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$FCFC,$0000
	dc.w	$0000,$0000
	dc.w	$C0C0,$0000
	dc.w	$0000,$0000
	dc.w	$C0DB,$00DB
	dc.w	$00C0,$0000
	dc.w	$C0C0,$0000
	dc.w	$0000,$0000
	dc.w	$001D,$00BE
	dc.w	$00C0,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$001E,$00ED
	dc.w	$00C0,$0000
*
sp_bstart
	incbin	'win1_util_icon_bstart_spr'

	end
