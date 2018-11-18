* Sprite gotofn
*
*	Mode 4
*	+----|---------------+
*	- g gg ggg   w	 w   -
*	|g  g  g g   ww ww   |
*	|g  gg ggg   wwwww   |
*	|g  g  g g   wwwww   |
*	| g g  ggg   wwwww   |
*	|	   wwwwwwwww |
*	|	    wwwwwww  |
*	|	     wwwww   |
*	|	      www    |
*	|	       w     |
*	|		     |
*	|    www w w w	w  w |
*	|    w	 w w ww w w w|
*	|    ww  w w w ww w  |
*	|    w	 w w w	w w w|
*	|    w	  w  w	w  w |
*	+----|---------------+
*
	section sprite
	xdef	mes_gotofn
mes_gotofn
	dc.w	$0100,$0000
	dc.w	20,16,4,0
	dc.l	mcs_gotofn-*
	dc.l	mms_gotofn-*
	dc.l	0
mcs_gotofn
	dc.w	$5B00,$8808
	dc.w	$8080,$0000
	dc.w	$9200,$8D0D
	dc.w	$8080,$0000
	dc.w	$9B00,$8F0F
	dc.w	$8080,$0000
	dc.w	$9200,$8F0F
	dc.w	$8080,$0000
	dc.w	$5300,$8F0F
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
	dc.w	$0E0E,$A9A9
	dc.w	$2020,$0000
	dc.w	$0808,$ADAD
	dc.w	$5050,$0000
	dc.w	$0C0C,$ABAB
	dc.w	$4040,$0000
	dc.w	$0808,$A9A9
	dc.w	$5050,$0000
	dc.w	$0808,$4949
	dc.w	$2020,$0000
mms_gotofn
	dc.w	$5B5B,$8888
	dc.w	$8080,$0000
	dc.w	$9292,$8D8D
	dc.w	$8080,$0000
	dc.w	$9B9B,$8F8F
	dc.w	$8080,$0000
	dc.w	$9292,$8F8F
	dc.w	$8080,$0000
	dc.w	$5353,$8F8F
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
	dc.w	$0E0E,$A9A9
	dc.w	$2020,$0000
	dc.w	$0808,$ADAD
	dc.w	$5050,$0000
	dc.w	$0C0C,$ABAB
	dc.w	$4040,$0000
	dc.w	$0808,$A9A9
	dc.w	$5050,$0000
	dc.w	$0808,$4949
	dc.w	$2020,$0000
*

	end
