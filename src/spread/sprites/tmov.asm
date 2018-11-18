;Sprite source code generated with EASYSOURCE V3.02
; 1991/92  Albin Hessler Software
;************************************************

;   ->	 tmov  <-    1993 Jul 02 23:13:48

	 section   sprite
	 xdef	   mes_tmov
	 xref	   mes_zero

mes_tmov
sp1_tmov
	 dc.w  $0100,$0000	    ;form, time/adaption
	 dc.w  $0018,$000F	    ;x size, y size 
	 dc.w  $0011,$0009	    ;x origin, y origin 
	 dc.l  cp1_tmov-*	    ;pointer to colour pattern
	 dc.l  mes_zero-*	    ;pointer to pattern mask
	 dc.l  0		    ;pointer to next definition 
cp1_tmov
	 dc.w  $5555,$5050,$0000,$0000
	 dc.w  $80AA,$08A8,$0000,$0000
	 dc.w  $4055,$1050,$0000,$0000
	 dc.w  $83AB,$88A8,$0000,$0000
	 dc.w  $4656,$7070,$0000,$0000
	 dc.w  $81AB,$9B9B,$E0E0,$0000
	 dc.w  $4055,$6666,$7F7F,$0000
	 dc.w  $80AA,$18B8,$637F,$0000
	 dc.w  $5555,$6060,$637F,$0000
	 dc.w  $0000,$3F3F,$83FF,$0000
	 dc.w  $0000,$181F,$03FF,$0000
	 dc.w  $0000,$181F,$03FF,$0000
	 dc.w  $0000,$181F,$03FF,$0000
	 dc.w  $0000,$181F,$03FF,$0000
	 dc.w  $0000,$1F1F,$FFFF,$0000
;
	 end
