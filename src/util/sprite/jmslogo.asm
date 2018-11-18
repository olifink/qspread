;Sprite source code generated with EASYSOURCE V3.02
; 1991/92  Albin Hessler Software
;************************************************

;   ->	 jmslogo  <-	1993 Jul 26 18:42:37

	 section   sprite
	 xdef	   mes_jms
mes_jms
sp1_jms
	 dc.w  $0100,$0000	    ;form, time/adaption
	 dc.w  $0040,$0013	    ;x size, y size 
	 dc.w  $001F,$0000	    ;x origin, y origin 
	 dc.l  cp1_jmslogo-*	    ;pointer to colour pattern
	 dc.l  pm1_jmslogo-*	    ;pointer to pattern mask
	 dc.l  sp_jmslogo	    ;pointer to next definition
cp1_jmslogo
	 dc.w  $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
	 dc.w  $0000,$0000,$0000,$0100,$8080,$0000,$0000,$0000
	 dc.w  $0000,$0000,$0200,$0705,$E040,$4000,$0000,$0000
	 dc.w  $0000,$0000,$0300,$8F0A,$F1A0,$C000,$0000,$0000
	 dc.w  $0000,$0000,$0301,$F101,$8F00,$C000,$0000,$0000
	 dc.w  $0000,$0000,$0300,$FE00,$7F00,$C000,$0000,$0000
	 dc.w  $0000,$0007,$0300,$FF00,$FF00,$C000,$AA55,$8000
	 dc.w  $0000,$083F,$1B88,$FF00,$FF00,$D112,$55AA,$4080
	 dc.w  $0000,$003F,$1BD0,$FF00,$FF00,$D305,$AA55,$A050
	 dc.w  $0000,$001F,$0BE8,$E300,$C700,$C50A,$55AA,$40A0
	 dc.w  $0000,$000F,$03F0,$EB00,$D710,$CA05,$AA55,$0000
	 dc.w  $0000,$1017,$03F8,$EB08,$D700,$D512,$50A8,$0000
	 dc.w  $0000,$782B,$00F8,$0800,$1010,$1A19,$AA52,$0000
	 dc.w  $0101,$FC55,$01FC,$FFAA,$FFAA,$F1B0,$55A9,$8000
	 dc.w  $0702,$8682,$00FE,$FF55,$FF55,$8A85,$AA54,$E0A0
	 dc.w  $1C14,$0078,$00FE,$FFAA,$FCA8,$552A,$54AA,$F850
	 dc.w  $0001,$00FF,$00FC,$0000,$0000,$AA55,$AA54,$0000
	 dc.w  $0000,$003F,$00E0,$0000,$0000,$150A,$50A0,$0000
	 dc.w  $0000,$0000,$0000,$0000,$0000,$0000,$0000,$0000
pm1_jmslogo
	 dc.w  $0000,$0000,$0000,$0101,$8080,$0000,$0000,$0000
	 dc.w  $0000,$0000,$0606,$0707,$E0E0,$6060,$0000,$0000
	 dc.w  $0000,$0000,$0707,$9F9F,$F9F9,$E0E0,$0000,$0000
	 dc.w  $0000,$0000,$0707,$FFFF,$FFFF,$E0E0,$0000,$0000
	 dc.w  $0000,$0000,$0707,$FFFF,$FFFF,$E0E0,$0000,$0000
	 dc.w  $0000,$0707,$0707,$FFFF,$FFFF,$E0E0,$FFFF,$8080
	 dc.w  $0000,$3F3F,$9F9F,$FFFF,$FFFF,$FBFB,$FFFF,$C0C0
	 dc.w  $0000,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$F0F0
	 dc.w  $0000,$7F7F,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$F8F8
	 dc.w  $0000,$3F3F,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$F8F8
	 dc.w  $0000,$1F1F,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$F0F0
	 dc.w  $0000,$7F7F,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$0000
	 dc.w  $0101,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$8080
	 dc.w  $0707,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$E0E0
	 dc.w  $1F1F,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$F8F8
	 dc.w  $7F7F,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FEFE
	 dc.w  $FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF,$FFFF
	 dc.w  $0101,$FFFF,$FCFC,$0000,$0000,$FFFF,$FEFE,$0000
	 dc.w  $0000,$3F3F,$E0E0,$0000,$0000,$1F1F,$F8F8,$0000
;
sp_jmslogo
	 incbin  'win1_util_sprite_jms2_spr'

	 end
