* Sprite newrec
*
*	Mode 4
*	+|-------------------+
*	-		r    -
*	|	     g	g  g |
*	|	      r r r  |
*	|	       g g   |
*	|	    rgr   rgr|
*	|  www	       g g   |
*	| w   w       r r r  |
*	|ww   wwwwwwwrwwg  g |
*	|w		r    |
*	|w		w    |
*	|w		w    |
*	|w		w    |
*	|w		w    |
*	|w		w    |
*	|wwwwwwwwwwwwwwww    |
*	+|-------------------+
*
	section sprite
	xdef	mes_newrec
	xref	mes_zero
mes_newrec
	dc.w	$0100,$0000
	dc.w	20,15,0,0
	dc.l	mcs_newrec-*
	dc.l	mes_zero-*
	dc.l	0
mcs_newrec
	dc.w	$0000,$0001
	dc.w	$0000,$0000
	dc.w	$0000,$0900
	dc.w	$2000,$0000
	dc.w	$0000,$0005
	dc.w	$0040,$0000
	dc.w	$0000,$0200
	dc.w	$8000,$0000
	dc.w	$0000,$0814
	dc.w	$2050,$0000
	dc.w	$3838,$0200
	dc.w	$8000,$0000
	dc.w	$4444,$0005
	dc.w	$0040,$0000
	dc.w	$C7C7,$F7FE
	dc.w	$2000,$0000
	dc.w	$8080,$0001
	dc.w	$0000,$0000
	dc.w	$8080,$0101
	dc.w	$0000,$0000
	dc.w	$8080,$0101
	dc.w	$0000,$0000
	dc.w	$8080,$0101
	dc.w	$0000,$0000
	dc.w	$8080,$0101
	dc.w	$0000,$0000
	dc.w	$8080,$0101
	dc.w	$0000,$0000
	dc.w	$FFFF,$FFFF
	dc.w	$0000,$0000
*
	end
