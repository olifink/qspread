* Sprite help
*
*	Mode 4
*	+|----------------+
*	- www	ggg    www-
*	|w    ggggggg w	  |
*	|w    gg   gg w	  |
*	| ww gg	    gg ww |
*	|   w gg   gg	 w|
*	|   w ggggggg	 w|
*	|www	ggg   www |
*	+|----------------+
*
	section	sprite
	xdef	mes_help
	xref	mes_zero

mes_help
	dc.w	$0100,$0000
	dc.w	17,7,0,0
	dc.l	sc4_help-*
	dc.l	mes_zero-*
	dc.l	0
sc4_help
	dc.w	$7170,$C303
	dc.w	$8080,$0000
	dc.w	$8780,$F404
	dc.w	$0000,$0000
	dc.w	$8680,$3404
	dc.w	$0000,$0000
	dc.w	$6C60,$1B03
	dc.w	$0000,$0000
	dc.w	$1610,$3000
	dc.w	$8080,$0000
	dc.w	$1710,$F000
	dc.w	$8080,$0000
	dc.w	$E1E0,$C707
	dc.w	$0000,$0000
*
	end
