;Sprite source code generated with EASYSOURCE V3.02
; 1991/92  Albin Hessler Software
;************************************************

;   ->	 tech  <-    1993 Jul 03 00:22:41

	 section   sprite
	 xdef	   mes_tech
	 xref	   mes_zero

mes_tech
sp1_tech
	 dc.w  $0100,$0000	    ;form, time/adaption
	 dc.w  $0018,$000F	    ;x size, y size 
	 dc.w  $0011,$0009	    ;x origin, y origin 
	 dc.l  cp1_tech-*	    ;pointer to colour pattern
	 dc.l  mes_zero-*	    ;pointer to pattern mask
	 dc.l  0		    ;pointer to next definition 
cp1_tech
	 dc.w  $FFFF,$FBFB,$0000,$0000
	 dc.w  $C0FF,$1BFB,$6060,$0000
	 dc.w  $C0FF,$1BFB,$6060,$0000
	 dc.w  $C3FF,$9BFB,$6C6C,$0000
	 dc.w  $C6FE,$7878,$0C0C,$0000
	 dc.w  $C1FF,$9B9B,$E0E0,$0000
	 dc.w  $C0FF,$66E6,$7F7F,$0000
	 dc.w  $C0FF,$18F8,$637F,$0000
	 dc.w  $FFFF,$E0E0,$637F,$0000
	 dc.w  $0000,$3F3F,$83FF,$0000
	 dc.w  $3F3F,$989F,$03FF,$0000
	 dc.w  $0000,$181F,$03FF,$0000
	 dc.w  $0F0F,$D8DF,$03FF,$0000
	 dc.w  $0000,$181F,$03FF,$0000
	 dc.w  $0303,$DFDF,$FFFF,$0000
;
	 end
