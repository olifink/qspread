;Sprite source code generated with EASYSOURCE  1990 Albin Hessler Software
;************************************************************************** 

;Sprite  ->  spread_s  <-    1992 Feb 14 20:50:29

         section   sprite
         xdef      mes_ccpy
mes_ccpy
sp1
         dc.w  $0100,$0000          ;form, time/adaption
         dc.w  $001C,$0014          ;x size, y size 
         dc.w  $0001,$0001          ;x origin, y origin 
         dc.l  cp1-*                ;pointer to colour pattern
         dc.l  pm1-*                ;pointer to pattern mask
         dc.l  0                    ;pointer to next definition 
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
         dc.w  $0303,$FFFF,$FFFF,$E0E0
         dc.w  $0303,$3333,$1B1B,$A0A0
         dc.w  $0202,$EDED,$6D6D,$6060
         dc.w  $0202,$EDED,$6E6E,$E0E0
         dc.w  $0202,$EDED,$1E1E,$E0E0
         dc.w  $0202,$EDED,$7E7E,$E0E0
         dc.w  $0303,$3333,$7E7E,$E0E0
         dc.w  $0303,$FFFF,$FFFF,$E0E0
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
         dc.w  $FFFF,$FFFF,$FFFF,$F0F0
         dc.w  $6767,$FFFF,$FFFF,$F0F0
         dc.w  $0707,$FFFF,$FFFF,$F0F0
         dc.w  $0707,$FFFF,$FFFF,$F0F0
         dc.w  $0707,$FFFF,$FFFF,$F0F0
         dc.w  $0707,$FFFF,$FFFF,$F0F0
         dc.w  $0707,$FFFF,$FFFF,$F0F0
         dc.w  $0707,$FFFF,$FFFF,$F0F0
         dc.w  $0707,$FFFF,$FFFF,$F0F0
         dc.w  $0707,$FFFF,$FFFF,$F0F0
;
         end
