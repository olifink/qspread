* Sprite gotoproc
*
*	Mode 4
*	+----|---------------+
*	- g gg ggg   w	 w   -
*	|g  g	 g   ww ww   |
*	|g  gg	g    wwwww   |
*	|g  g  g     wwwww   |
*	| g g  g     wwwww   |
*	|	   wwwwwwwww |
*	|	    wwwwwww  |
*	|	     wwwww   |
*	|	      www    |
*	|	       w     |
*	|		     |
*	|     ww  ww   w   w |
*	|     w w w w w w w w|
*	|     ww  ww  w w w  |
*	|     w   w w w w w w|
*	|     w   w w  w   w |
*	+----|---------------+
*
	section sprite
	xdef	mes_gotoproc
mes_gotoproc
	dc.w	$0100,$0000
	dc.w	20,16,4,0
	dc.l	mcs_gotoproc-*
	dc.l	mms_gotoproc-*
	dc.l	0
mcs_gotoproc
	dc.w	$5B00,$8808
	dc.w	$8080,$0000
	dc.w	$9000,$8D0D
	dc.w	$8080,$0000
	dc.w	$9900,$0F0F
	dc.w	$8080,$0000
	dc.w	$9200,$0F0F
	dc.w	$8080,$0000
	dc.w	$5200,$0F0F
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
	dc.w	$0606,$6262
	dc.w	$2020,$0000
	dc.w	$0505,$5555
	dc.w	$5050,$0000
	dc.w	$0606,$6565
	dc.w	$4040,$0000
	dc.w	$0404,$5555
	dc.w	$5050,$0000
	dc.w	$0404,$5252
	dc.w	$2020,$0000
mms_gotoproc
	dc.w	$5B5B,$8888
	dc.w	$8080,$0000
	dc.w	$9090,$8D8D
	dc.w	$8080,$0000
	dc.w	$9999,$0F0F
	dc.w	$8080,$0000
	dc.w	$9292,$0F0F
	dc.w	$8080,$0000
	dc.w	$5252,$0F0F
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
	dc.w	$0606,$6262
	dc.w	$2020,$0000
	dc.w	$0505,$5555
	dc.w	$5050,$0000
	dc.w	$0606,$6565
	dc.w	$4040,$0000
	dc.w	$0404,$5555
	dc.w	$5050,$0000
	dc.w	$0404,$5252
	dc.w	$2020,$0000
*


	end
