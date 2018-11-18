;Sprite source code generated with EASYSOURCE  1990 Albin Hessler Software
;************************************************************************** 

;Sprite  ->  inscol  <-    1992 Feb 14 11:27:27

         section   sprite
         xdef      mes_insc
mes_insc
sp1
         dc.w  $0100,$0000          ;form, time/adaption
         dc.w  $000D,$000A          ;x size, y size 
         dc.w  $0006,$0005          ;x origin, y origin 
         dc.l  cp1-*                ;pointer to colour pattern
         dc.l  pm1-*                ;pointer to pattern mask
         dc.l  0                    ;pointer to next definition 
cp1
         dc.w  $0000,$0000
         dc.w  $6060,$8080
         dc.w  $6060,$C0C0
         dc.w  $6060,$E0E0
         dc.w  $7F7F,$F0F0
         dc.w  $7F7F,$F0F0
         dc.w  $6060,$E0E0
         dc.w  $6060,$C0C0
         dc.w  $6060,$8080
         dc.w  $0000,$0000
pm1
         dc.w  $F1F1,$8080
         dc.w  $F1F1,$C0C0
         dc.w  $F1F1,$E0E0
         dc.w  $FFFF,$F0F0
         dc.w  $FFFF,$F8F8
         dc.w  $FFFF,$F8F8
         dc.w  $FFFF,$F0F0
         dc.w  $F1F1,$E0E0
         dc.w  $F1F1,$C0C0
         dc.w  $F1F1,$8080
;
         end
