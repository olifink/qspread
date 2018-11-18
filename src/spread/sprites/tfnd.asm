;Sprite source code generated with EASYSOURCE V3.02
; 1991/92  Albin Hessler Software
;************************************************

;   ->	 tfnd  <-    1993 Jul 02 23:13:40

	 section   sprite
	 xdef	   mes_tfnd
	 xref	   mes_zero

mes_tfnd
sp1_tfnd
	 dc.w  $0100,$0000	    ;form, time/adaption
	 dc.w  $0014,$0013	    ;x size, y size 
	 dc.w  $0007,$0007	    ;x origin, y origin 
	 dc.l  cp1_tfnd-*	    ;pointer to colour pattern
	 dc.l  mes_zero-*	    ;pointer to pattern mask
	 dc.l  0		    ;pointer to next definition 
cp1_tfnd
	 dc.w  $0700,$E000,$0000,$0000
	 dc.w  $1F00,$F000,$0000,$0000
	 dc.w  $3F0F,$F8C0,$0000,$0000
	 dc.w  $7030,$3C30,$0000,$0000
	 dc.w  $404C,$4C08,$0000,$0000
	 dc.w  $4850,$6C08,$0000,$0000
	 dc.w  $A890,$3404,$0000,$0000
	 dc.w  $8080,$7404,$0000,$0000
	 dc.w  $8080,$F404,$0000,$0000
	 dc.w  $4140,$E808,$0000,$0000
	 dc.w  $4340,$DC1C,$0000,$0000
	 dc.w  $3030,$3A3E,$0000,$0000
	 dc.w  $0F0F,$D1DF,$0000,$0000
	 dc.w  $0000,$080F,$8080,$0000
	 dc.w  $0300,$8407,$40C0,$0000
	 dc.w  $0300,$8203,$20E0,$0000
	 dc.w  $0300,$8101,$10F0,$0000
	 dc.w  $0000,$0000,$90F0,$0000
	 dc.w  $0000,$0000,$6060,$0000
;
	 end
