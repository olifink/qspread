;Sprite source code generated with EASYSOURCE V3.03
; 1991/92  Albin Hessler Software
;************************************************

;   ->	 tpct  <-    1994 Aug 24 11:42:53

	 section   sprite
	 xdef	   mes_tpct
	 xref	   mes_zero
mes_tpct
sp1_tpct
	 dc.w  $0100,$0000	    ;form, time/adaption
	 dc.w  $0013,$0010	    ;x size, y size 
	 dc.w  $000C,$000B	    ;x origin, y origin 
	 dc.l  cp1_tpct-*	    ;pointer to colour pattern
	 dc.l  mes_zero-*	    ;pointer to pattern mask
	 dc.l  0		    ;pointer to next definition 
cp1_tpct
	 dc.w  $FFFF,$F8F8,$0000,$0000
	 dc.w  $C0FF,$18F8,$0000,$0000
	 dc.w  $C0FF,$18F8,$0000,$0000
	 dc.w  $C0FF,$18F8,$0000,$0000
	 dc.w  $C0FF,$18F8,$0000,$0000
	 dc.w  $C0FF,$FFFF,$8080,$0000
	 dc.w  $C1FF,$8080,$C0C0,$0000
	 dc.w  $C1FF,$3E3E,$4040,$0000
	 dc.w  $FFFF,$7F7F,$6060,$0000
	 dc.w  $0202,$0000,$2020,$0000
	 dc.w  $0202,$0808,$2020,$0000
	 dc.w  $0202,$1C1C,$2020,$0000
	 dc.w  $0202,$0808,$2020,$0000
	 dc.w  $0303,$0808,$6060,$0000
	 dc.w  $0101,$8080,$C0C0,$0000
	 dc.w  $0000,$FFFF,$8080,$0000
;
	 end
