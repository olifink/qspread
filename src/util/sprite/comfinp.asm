* Sprite comfinp
*
*	Mode 4
*	+|-------------------------------+
*	-	      gggg		 -
*	|	      gggg		 |
*	|	      gggg		 |
*	|ww  w ww     gggg    www w w www|
*	|w w w w w    gggg    w   w w  w |
*	|w w w ww     gggg    ww   w   w |
*	|w w w w w    gggg    w   w w  w |
*	|ww  w w w wwwggggwww www w w  w |
*	+|-------------------------------+
*
	section sprite
	xdef	mes_comfinp
	xref	mes_zero
mes_comfinp
	dc.w	$0100,$0000
	dc.w	32,8,0,0
	dc.l	mcs_comfinp-*
	dc.l	mes_zero-*
	dc.l	0
mcs_comfinp
	dc.w	$0000,$0700
	dc.w	$8000,$0000
	dc.w	$0000,$0700
	dc.w	$8000,$0000
	dc.w	$0000,$0700
	dc.w	$8000,$0000
	dc.w	$CBCB,$0700
	dc.w	$8707,$5757
	dc.w	$AAAA,$8780
	dc.w	$8404,$5252
	dc.w	$ABAB,$0700
	dc.w	$8606,$2222
	dc.w	$AAAA,$8780
	dc.w	$8404,$5252
	dc.w	$CACA,$BFB8
	dc.w	$F777,$5252
	dc.w	$0000,$0707
	dc.w	$8080,$0000
	dc.w	$0000,$0707
	dc.w	$8080,$0000
	dc.w	$0000,$0707
	dc.w	$8080,$0000
	dc.w	$CBCB,$0707
	dc.w	$8787,$5757

*
	end
