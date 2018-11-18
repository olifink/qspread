;Sprite source code generated with EASYSOURCE  1991 Albin Hessler Software
;**************************************************************************

;   ->   asm_spr_  <-    1992 Jun 13 12:43:09

         section   sprite
         xdef      mes_mous
mes_mous
sp1
         dc.w  $0100,$0000          ;form, time/adaption
         dc.w  $0020,$0011          ;x size, y size 
         dc.w  $0000,$0000          ;x origin, y origin 
         dc.l  cp1-*                ;pointer to colour pattern
         dc.l  pm1-*                ;pointer to pattern mask
         dc.l  0                    ;pointer to next definition 
cp1
         dc.w  $0000,$0000,$0000,$0000
         dc.w  $0000,$0702,$C080,$0000
         dc.w  $0000,$1F05,$F040,$0000
         dc.w  $0000,$1F0A,$F8A0,$0000
         dc.w  $0F05,$9E15,$18F0,$0000
         dc.w  $3F2A,$C98E,$E0F0,$0000
         dc.w  $7F55,$F75D,$0008,$0800
         dc.w  $5F0A,$FEAA,$E7E2,$7C28
         dc.w  $5F55,$FE54,$C7C5,$F850
         dc.w  $5F0A,$FFAA,$0F0A,$E0A0
         dc.w  $5F15,$EF45,$FF55,$8000
         dc.w  $2F0A,$EEAB,$FCA8,$0000
         dc.w  $2F00,$DF55,$00FC,$0000
         dc.w  $1302,$BFAA,$F0A0,$0000
         dc.w  $0000,$7F55,$0000,$0000
         dc.w  $0000,$3E0A,$0000,$0000
         dc.w  $0000,$3C04,$0000,$0000
pm1
         dc.w  $0000,$0F0F,$C0C0,$0000
         dc.w  $0000,$1F1F,$F0F0,$0000
         dc.w  $0000,$3F3F,$F8F8,$0000
         dc.w  $0F0F,$BFBF,$FCFC,$0000
         dc.w  $3F3F,$FFFF,$FCFC,$0707
         dc.w  $7F7F,$FFFF,$F8F8,$0F0F
         dc.w  $FFFF,$FFFF,$FFFF,$7F7F
         dc.w  $FFFF,$FFFF,$FFFF,$FEFE
         dc.w  $FFFF,$FFFF,$FFFF,$FCFC
         dc.w  $FFFF,$FFFF,$FFFF,$F8F8
         dc.w  $FFFF,$FFFF,$FFFF,$E0E0
         dc.w  $7F7F,$FFFF,$FFFF,$8080
         dc.w  $7F7F,$FFFF,$FCFC,$0000
         dc.w  $3F3F,$FFFF,$F8F8,$0000
         dc.w  $0F0F,$FFFF,$F0F0,$0000
         dc.w  $0000,$7F7F,$0000,$0000
         dc.w  $0000,$7E7E,$0000,$0000
;
         end
