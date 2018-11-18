;Sprite source code generated with EASYSOURCE  1990 Albin Hessler Software
;************************************************************************** 

;Sprite  ->  delcol  <-    1992 Feb 14 11:27:20

	 section   sprite
	 xdef	   mes_delx
mes_delx
sp1
	 dc.w  $0100,$0000	    ;form, time/adaption
	 dc.w  $0018,$000F	    ;x size, y size 
	 dc.w  $000C,$0007	    ;x origin, y origin 
	 dc.l  cp1-*		    ;pointer to colour pattern
	 dc.l  pm1-*		    ;pointer to pattern mask
	 dc.l  0		    ;pointer to next definition 
cp1
	 dc.w  $0000,$0000,$0000,$0000
	 dc.w  $0606,$0000,$6060,$0000
	 dc.w  $0303,$0000,$C0C0,$0000
	 dc.w  $0101,$8181,$8080,$0000
	 dc.w  $7E7E,$DBDB,$7E7E,$0000
	 dc.w  $4040,$6666,$0202,$0000
	 dc.w  $4040,$3C3C,$0202,$0000
	 dc.w  $4040,$1818,$0202,$0000
	 dc.w  $4040,$3C3C,$0202,$0000
	 dc.w  $4040,$6666,$0202,$0000
	 dc.w  $7E7E,$DBDB,$7E7E,$0000
	 dc.w  $0101,$8181,$8080,$0000
	 dc.w  $0303,$0000,$C0C0,$0000
	 dc.w  $0606,$0000,$6060,$0000
	 dc.w  $0000,$0000,$0000,$0000
pm1
	 dc.w  $0606,$0000,$6060,$0000
	 dc.w  $0F0F,$0000,$F0F0,$0000
	 dc.w  $0707,$8181,$E0E0,$0000
	 dc.w  $FFFF,$FFFF,$FFFF,$0000
	 dc.w  $FFFF,$FFFF,$FFFF,$0000
	 dc.w  $FFFF,$FFFF,$FFFF,$0000
	 dc.w  $FFFF,$FFFF,$FFFF,$0000
	 dc.w  $FFFF,$FFFF,$FFFF,$0000
	 dc.w  $FFFF,$FFFF,$FFFF,$0000
	 dc.w  $FFFF,$FFFF,$FFFF,$0000
	 dc.w  $FFFF,$FFFF,$FFFF,$0000
	 dc.w  $FFFF,$FFFF,$FFFF,$0000
	 dc.w  $0707,$8181,$E0E0,$0000
	 dc.w  $0F0F,$0000,$F0F0,$0000
	 dc.w  $0606,$0000,$6060,$0000
;
	 end
