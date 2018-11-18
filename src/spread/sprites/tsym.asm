;Sprite source code generated with EASYSOURCE V3.02
; 1991/92  Albin Hessler Software
;************************************************

;   ->	 tsym  <-    1993 Jul 02 23:13:56

	 section   sprite
	 xdef	   mes_tsym
	 xref	   mes_zero
mes_tsym
sp1_tsym
	 dc.w  $0100,$0000	    ;form, time/adaption
	 dc.w  $0015,$000F	    ;x size, y size 
	 dc.w  $000A,$0009	    ;x origin, y origin 
	 dc.l  cp1_tsym-*	    ;pointer to colour pattern
	 dc.l  mes_zero-*	    ;pointer to pattern mask
	 dc.l  0		    ;pointer to next definition 
cp1_tsym
	 dc.w  $0000,$8484,$0000,$0000
	 dc.w  $0101,$6AEE,$0000,$0000
	 dc.w  $0101,$12FE,$4040,$0000
	 dc.w  $0000,$84FC,$8080,$0000
	 dc.w  $0000,$7F7F,$E0E0,$0000
	 dc.w  $0101,$FCFC,$0000,$0000
	 dc.w  $0607,$03FF,$C0C0,$0000
	 dc.w  $181F,$20FF,$20E0,$0000
	 dc.w  $607F,$FCFF,$10F0,$0000
	 dc.w  $81FF,$20FF,$08F8,$0000
	 dc.w  $80FF,$F8FF,$08F8,$0000
	 dc.w  $80FF,$24FF,$08F8,$0000
	 dc.w  $417F,$F8FF,$30F0,$0000
	 dc.w  $383F,$21FF,$C0C0,$0000
	 dc.w  $0707,$FEFE,$0000,$0000
;
	 end
