;Sprite source code generated with EASYSOURCE V3.02
; 1991/92  Albin Hessler Software
;************************************************

;   ->	 tera  <-    1993 Jul 03 00:04:04

	 section   sprite
	 xdef	   mes_tera
	 xref	   mes_zero

mes_tera
sp1_tera
	 dc.w  $0100,$0000	    ;form, time/adaption
	 dc.w  $0010,$000F	    ;x size, y size 
	 dc.w  $0008,$0007	    ;x origin, y origin 
	 dc.l  cp1_tera-*	    ;pointer to colour pattern
	 dc.l  mes_zero-*	    ;pointer to pattern mask
	 dc.l  0		    ;pointer to next definition 
cp1_tera
	 dc.w  $C0C0,$0303
	 dc.w  $6060,$0606
	 dc.w  $3030,$0C0C
	 dc.w  $5D5D,$5C5C
	 dc.w  $2C2E,$32BA
	 dc.w  $4657,$6474
	 dc.w  $232B,$C2EA
	 dc.w  $4155,$84D4
	 dc.w  $232B,$C2EA
	 dc.w  $4657,$6474
	 dc.w  $2C2E,$32BA
	 dc.w  $5D5D,$5C5C
	 dc.w  $3030,$0C0C
	 dc.w  $6060,$0606
	 dc.w  $C0C0,$0303
;
	 end
