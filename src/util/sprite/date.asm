* Sprite date
*
*	Mode 4
*	+|-----------+
*	-w w www     -
*	|ww w  w     |
*	|w  r ww ww w|
*	|w rr w w  ww|
*	|w  r w  r  w|
*	|w rrrw r r w|
*	|w    w   r w|
*	|wwwwww rrr w|
*	|     w     w|
*	|     wwwwwww|
*	+|-----------+
*
	section sprite
	xdef	mes_date
	xref	mes_zero
mes_date
	dc.w	$0100,$0000
	dc.w	12,10,0,0
	dc.l	mcs_date-*
	dc.l	mes_zero-*
	dc.l	0
mcs_date
	dc.w	$AEAE,$0000
	dc.w	$D2D2,$0000
	dc.w	$8696,$D0D0
	dc.w	$85B5,$3030
	dc.w	$8494,$1090
	dc.w	$84BD,$1050
	dc.w	$8484,$1050
	dc.w	$FCFD,$10D0
	dc.w	$0404,$1010
	dc.w	$0707,$F0F0
*
	end
