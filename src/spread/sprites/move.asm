;Sprite source code generated with EASYSOURCE  1990 Albin Hessler Software
;************************************************************************** 

;Sprite  ->  spread_s  <-    1992 Feb 14 22:33:01

	 section   sprite
	 xdef	   mes_cmov
mes_cmov
sp1
	 dc.w  $0100,$0000	    ;form, time/adaption
	 dc.w  $001D,$0014	    ;x size, y size 
	 dc.w  $0001,$0001	    ;x origin, y origin 
	 dc.l  cp1-*		    ;pointer to colour pattern
	 dc.l  pm1-*		    ;pointer to pattern mask
	 dc.l  0		    ;pointer to next definition 
cp1
	 dc.w  $0000,$0000,$0000,$0000
	 dc.w  $4040,$0000,$0000,$0000
	 dc.w  $6060,$0000,$0000,$0000
	 dc.w  $7070,$0000,$0000,$0000
	 dc.w  $7878,$0000,$0000,$0000
	 dc.w  $7C7C,$0000,$0000,$0000
	 dc.w  $7E7E,$0000,$0000,$0000
	 dc.w  $7F7F,$0000,$0000,$0000
	 dc.w  $7F7F,$8080,$0000,$0000
	 dc.w  $7E7E,$0000,$0000,$0000
	 dc.w  $6666,$0000,$0000,$0000
	 dc.w  $0303,$FFFF,$FFFF,$F0F0
	 dc.w  $0202,$ECEC,$DDDD,$1010
	 dc.w  $0202,$4B4B,$5D5D,$7070
	 dc.w  $0202,$ABAB,$6B6B,$3030
	 dc.w  $0202,$EBEB,$6B6B,$7070
	 dc.w  $0202,$EBEB,$7777,$7070
	 dc.w  $0202,$ECEC,$F7F7,$1010
	 dc.w  $0303,$FFFF,$FFFF,$F0F0
	 dc.w  $0000,$0000,$0000,$0000
pm1
	 dc.w  $C0C0,$0000,$0000,$0000
	 dc.w  $E0E0,$0000,$0000,$0000
	 dc.w  $F0F0,$0000,$0000,$0000
	 dc.w  $F8F8,$0000,$0000,$0000
	 dc.w  $FCFC,$0000,$0000,$0000
	 dc.w  $FEFE,$0000,$0000,$0000
	 dc.w  $FFFF,$0000,$0000,$0000
	 dc.w  $FFFF,$8080,$0000,$0000
	 dc.w  $FFFF,$C0C0,$0000,$0000
	 dc.w  $FFFF,$8080,$0000,$0000
	 dc.w  $FFFF,$FFFF,$FFFF,$F8F8
	 dc.w  $6767,$FFFF,$FFFF,$F8F8
	 dc.w  $0707,$FFFF,$FFFF,$F8F8
	 dc.w  $0707,$FFFF,$FFFF,$F8F8
	 dc.w  $0707,$FFFF,$FFFF,$F8F8
	 dc.w  $0707,$FFFF,$FFFF,$F8F8
	 dc.w  $0707,$FFFF,$FFFF,$F8F8
	 dc.w  $0707,$FFFF,$FFFF,$F8F8
	 dc.w  $0707,$FFFF,$FFFF,$F8F8
	 dc.w  $0707,$FFFF,$FFFF,$F8F8
;
	 end
