;Sprite source code generated with EASYSOURCE V3.02
; 1991/92  Albin Hessler Software
;************************************************

;   ->	 tcpy  <-    1993 Jul 02 23:13:28

	 section   sprite
	 xdef	   mes_tcpy
	 xref	   mes_zero
mes_tcpy
sp1_tcpy
	 dc.w  $0100,$0000	    ;form, time/adaption
	 dc.w  $0018,$000F	    ;x size, y size 
	 dc.w  $0011,$0009	    ;x origin, y origin 
	 dc.l  cp1_tcpy-*	    ;pointer to colour pattern
	 dc.l  mes_zero-*	    ;pointer to pattern mask
	 dc.l  0		    ;pointer to next definition 
cp1_tcpy
	 dc.w  $FFFF,$F8F8,$0000,$0000
	 dc.w  $C0FF,$18F8,$0000,$0000
	 dc.w  $C0FF,$18F8,$0000,$0000
	 dc.w  $C3FF,$98F8,$0000,$0000
	 dc.w  $C6FE,$7878,$0000,$0000
	 dc.w  $C1FF,$9B9B,$E0E0,$0000
	 dc.w  $C0FF,$66E6,$7F7F,$0000
	 dc.w  $C0FF,$18F8,$637F,$0000
	 dc.w  $FFFF,$E0E0,$637F,$0000
	 dc.w  $0000,$3F3F,$83FF,$0000
	 dc.w  $0000,$181F,$03FF,$0000
	 dc.w  $0000,$181F,$03FF,$0000
	 dc.w  $0000,$181F,$03FF,$0000
	 dc.w  $0000,$181F,$03FF,$0000
	 dc.w  $0000,$1F1F,$FFFF,$0000
;
	 end
