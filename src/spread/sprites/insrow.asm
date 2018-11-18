;Sprite source code generated with EASYSOURCE  1990 Albin Hessler Software
;************************************************************************** 

;Sprite  ->  insrow  <-    1992 Feb 14 11:27:31

         section   sprite
         xdef      mes_insr
mes_insr
sp1
         dc.w  $0100,$0000          ;form, time/adaption
         dc.w  $000A,$000D          ;x size, y size 
         dc.w  $0004,$0006          ;x origin, y origin 
         dc.l  cp1-*                ;pointer to colour pattern
         dc.l  pm1-*                ;pointer to pattern mask
         dc.l  0                    ;pointer to next definition 
cp1
         dc.w  $0000,$0000
         dc.w  $7F7F,$8080
         dc.w  $7F7F,$8080
         dc.w  $0C0C,$0000
         dc.w  $0C0C,$0000
         dc.w  $0C0C,$0000
         dc.w  $0C0C,$0000
         dc.w  $0C0C,$0000
         dc.w  $7F7F,$8080
         dc.w  $3F3F,$0000
         dc.w  $1E1E,$0000
         dc.w  $0C0C,$0000
         dc.w  $0000,$0000
pm1
         dc.w  $FFFF,$C0C0
         dc.w  $FFFF,$C0C0
         dc.w  $FFFF,$C0C0
         dc.w  $FFFF,$C0C0
         dc.w  $1E1E,$0000
         dc.w  $1E1E,$0000
         dc.w  $1E1E,$0000
         dc.w  $FFFF,$C0C0
         dc.w  $FFFF,$C0C0
         dc.w  $7F7F,$8080
         dc.w  $3F3F,$0000
         dc.w  $1E1E,$0000
         dc.w  $0C0C,$0000
;
         end
