* Sprite goto
*
*	Mode 4
*	+|------------------+
*	-    w ww	    -
*	|  w w ww   ww w    |
*	|w w	    ww w w  |
*	|w  wwww	 w w|
*	| wwwwwww    wwww  w|
*	|wwwwwwww   wwwwwww |
*	|wwwwwww    wwwwwwww|
*	| wwwwww     wwwwwww|
*	| wwwwww     wwwwww |
*	|  wwwww     wwwwww |
*	|  wwwww     wwwww  |
*	|  wwwwww    wwwww  |
*	|   wwwww   wwwwww  |
*	|   wwwww   wwwww   |
*	|    www    wwwww   |
*	|	     www    |
*	+|------------------+
*
	section sprite
	xdef	mes_goto
	xref	mes_zero
mes_goto
	dc.w	$0100,$0000
	dc.w	19,16,0,0
	dc.l	mcs_goto-*
	dc.l	mes_zero-*
	dc.l	0
mcs_goto
	dc.w	$0B0B,$0000
	dc.w	$0000,$0000
	dc.w	$2B2B,$1A1A
	dc.w	$0000,$0000
	dc.w	$A0A0,$1A1A
	dc.w	$8080,$0000
	dc.w	$9E9E,$0000
	dc.w	$A0A0,$0000
	dc.w	$7F7F,$0F0F
	dc.w	$2020,$0000
	dc.w	$FFFF,$1F1F
	dc.w	$C0C0,$0000
	dc.w	$FEFE,$1F1F
	dc.w	$E0E0,$0000
	dc.w	$7E7E,$0F0F
	dc.w	$E0E0,$0000
	dc.w	$7E7E,$0F0F
	dc.w	$C0C0,$0000
	dc.w	$3E3E,$0F0F
	dc.w	$C0C0,$0000
	dc.w	$3E3E,$0F0F
	dc.w	$8080,$0000
	dc.w	$3F3F,$0F0F
	dc.w	$8080,$0000
	dc.w	$1F1F,$1F1F
	dc.w	$8080,$0000
	dc.w	$1F1F,$1F1F
	dc.w	$0000,$0000
	dc.w	$0E0E,$1F1F
	dc.w	$0000,$0000
	dc.w	$0000,$0E0E
	dc.w	$0000,$0000
*
	end
