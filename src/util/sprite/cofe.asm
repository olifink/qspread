* Sprite cofe
*
*	Mode 4
*	+|------------------+
*	-    w	 w   w	    -
*	|   w	w   w	    |
*	|   w	 w w	    |
*	|    w	w   w	    |
*	|		    |
*	|   wwwwwwwwww	    |
*	| wwaaaaaaaaaaww    |
*	| w wwaaaaaaww w    |
*	| w   wwwwww   www  |
*	|  w	      w   w |
*	|   w	     w w  w |
*	|    w	    w	ww  |
*	|    w	    w	    |
*	|     w    w	    |
*	| www w    w www    |
*	|w     wwww	w   |
*	| www	     www    |
*	|    wwwwwwww	    |
*	+|------------------+
*
	section sprite
	xdef	mes_cofe
mes_cofe
	dc.w	$0100,$0000
	dc.w	19,18,0,0
	dc.l	sc4_cofe-*
	dc.l	sm4_cofe-*
	dc.l	0
sc4_cofe
	dc.w	$0808,$8888
	dc.w	$0000,$0000
	dc.w	$1111,$1010
	dc.w	$0000,$0000
	dc.w	$1010,$A0A0
	dc.w	$0000,$0000
	dc.w	$0909,$1010
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$1F1F,$F8F8
	dc.w	$0000,$0000
	dc.w	$6060,$0606
	dc.w	$0000,$0000
	dc.w	$5858,$1A1A
	dc.w	$0000,$0000
	dc.w	$4747,$E3E3
	dc.w	$8080,$0000
	dc.w	$2020,$0404
	dc.w	$4040,$0000
	dc.w	$1010,$0A0A
	dc.w	$4040,$0000
	dc.w	$0808,$1111
	dc.w	$8080,$0000
	dc.w	$0808,$1010
	dc.w	$0000,$0000
	dc.w	$0404,$2020
	dc.w	$0000,$0000
	dc.w	$7474,$2E2E
	dc.w	$0000,$0000
	dc.w	$8383,$C1C1
	dc.w	$0000,$0000
	dc.w	$7070,$0E0E
	dc.w	$0000,$0000
	dc.w	$0F0F,$F0F0
	dc.w	$0000,$0000
sm4_cofe
	dcb.w	80,0
*
	end
