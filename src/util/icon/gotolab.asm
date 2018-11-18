* Sprite gotolab
*
*	Mode 4
*	+----|---------------+
*	- g gg	gg   w	 w   -
*	|g  g  g     ww ww   |
*	|g  gg gg    wwwww   |
*	|g  g  g g   wwwww   |
*	| g g	g    wwwww   |
*	|	   wwwwwwwww |
*	|	    wwwwwww  |
*	|	     wwwww   |
*	|	      www    |
*	|	       w     |
*	|		     |
*	|    w	 w  ww	ww w |
*	|    w	w w w w w  w |
*	|    w	w w ww	ww w |
*	|    w	www w w w  w |
*	|    ww w w ww	ww ww|
*	+----|---------------+
*
	section sprite
	xdef	mes_gotolab
mes_gotolab
	dc.w	$0100,$0000
	dc.w	20,16,4,0
	dc.l	mcs_gotolab-*
	dc.l	mms_gotolab-*
	dc.l	0
mcs_gotolab
	dc.w	$5900,$8808
	dc.w	$8080,$0000
	dc.w	$9200,$0D0D
	dc.w	$8080,$0000
	dc.w	$9B00,$0F0F
	dc.w	$8080,$0000
	dc.w	$9200,$8F0F
	dc.w	$8080,$0000
	dc.w	$5100,$0F0F
	dc.w	$8080,$0000
	dc.w	$0000,$3F3F
	dc.w	$E0E0,$0000
	dc.w	$0000,$1F1F
	dc.w	$C0C0,$0000
	dc.w	$0000,$0F0F
	dc.w	$8080,$0000
	dc.w	$0000,$0707
	dc.w	$0000,$0000
	dc.w	$0000,$0202
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0808,$9999
	dc.w	$A0A0,$0000
	dc.w	$0909,$5555
	dc.w	$2020,$0000
	dc.w	$0909,$5959
	dc.w	$A0A0,$0000
	dc.w	$0909,$D5D5
	dc.w	$2020,$0000
	dc.w	$0D0D,$5959
	dc.w	$B0B0,$0000
mms_gotolab
	dc.w	$5959,$8888
	dc.w	$8080,$0000
	dc.w	$9292,$0D0D
	dc.w	$8080,$0000
	dc.w	$9B9B,$0F0F
	dc.w	$8080,$0000
	dc.w	$9292,$8F8F
	dc.w	$8080,$0000
	dc.w	$5151,$0F0F
	dc.w	$8080,$0000
	dc.w	$0000,$3F3F
	dc.w	$E0E0,$0000
	dc.w	$0000,$1F1F
	dc.w	$C0C0,$0000
	dc.w	$0000,$0F0F
	dc.w	$8080,$0000
	dc.w	$0000,$0707
	dc.w	$0000,$0000
	dc.w	$0000,$0202
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0808,$9999
	dc.w	$A0A0,$0000
	dc.w	$0909,$5555
	dc.w	$2020,$0000
	dc.w	$0909,$5959
	dc.w	$A0A0,$0000
	dc.w	$0909,$D5D5
	dc.w	$2020,$0000
	dc.w	$0D0D,$5959
	dc.w	$B0B0,$0000
*

	end
