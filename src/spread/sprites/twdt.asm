;Sprite source code generated with EASYSOURCE V3.02
; 1991/92  Albin Hessler Software
;************************************************

;   ->	 twdt  <-    1993 Jul 02 23:14:03

	 section   sprite
	 xdef	   mes_twdt
	 xref	   mes_zero
mes_twdt
sp1_twdt
	 dc.w  $0100,$0000	    ;form, time/adaption
	 dc.w  $0014,$000F	    ;x size, y size 
	 dc.w  $0007,$0007	    ;x origin, y origin 
	 dc.l  cp1_twdt-*	    ;pointer to colour pattern
	 dc.l  mes_zero-*	    ;pointer to pattern mask
	 dc.l  0		    ;pointer to next definition 
cp1_twdt
	 dc.w  $4040,$0000,$2020,$0000
	 dc.w  $8080,$0000,$1010,$0000
	 dc.w  $4040,$0000,$2020,$0000
	 dc.w  $FFFF,$FFFF,$F0F0,$0000
	 dc.w  $C0FF,$00FF,$30F0,$0000
	 dc.w  $C8FF,$01FF,$30F0,$0000
	 dc.w  $D0FF,$00FF,$B0F0,$0000
	 dc.w  $FFFF,$0FFF,$F0F0,$0000
	 dc.w  $D0FF,$00FF,$B0F0,$0000
	 dc.w  $C8FF,$01FF,$30F0,$0000
	 dc.w  $C0FF,$00FF,$30F0,$0000
	 dc.w  $FFFF,$FFFF,$F0F0,$0000
	 dc.w  $4040,$0000,$2020,$0000
	 dc.w  $8080,$0000,$1010,$0000
	 dc.w  $4040,$0000,$2020,$0000
;
	 end
