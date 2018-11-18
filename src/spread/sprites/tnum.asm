;Sprite source code generated with EASYSOURCE V3.02
; 1991/92  Albin Hessler Software
;************************************************

;   ->	 tnum  <-    1993 Jul 05 22:34:11

	 section   sprite
	 xdef	   mes_tnum
	 xref	   mes_zero

mes_tnum
sp1_tnum
	 dc.w  $0100,$0000	    ;form, time/adaption
	 dc.w  $0016,$000C	    ;x size, y size 
	 dc.w  $0009,$0005	    ;x origin, y origin 
	 dc.l  cp1_tnum-*	    ;pointer to colour pattern
	 dc.l  mes_zero-*	    ;pointer to pattern mask
	 dc.l  0		    ;pointer to next definition 
cp1_tnum
	 dc.w  $8200,$3C00,$0400,$0000
	 dc.w  $C600,$1A00,$0C00,$0000
	 dc.w  $C600,$0600,$0C00,$0000
	 dc.w  $C600,$0600,$0C00,$0000
	 dc.w  $C600,$0600,$0C00,$0000
	 dc.w  $BA00,$3A00,$0800,$0000
	 dc.w  $7C00,$5C00,$0400,$0000
	 dc.w  $0600,$6000,$0C00,$0000
	 dc.w  $0600,$6000,$0C00,$0000
	 dc.w  $0600,$6000,$0C00,$0000
	 dc.w  $0600,$5800,$CC00,$0000
	 dc.w  $0400,$3C00,$C400,$0000
;
	 end
