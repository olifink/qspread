;Sprite source code generated with EASYSOURCE  1991 Albin Hessler Software
;**************************************************************************

;    ->   spread_s  <-    1992 Nov 05 15:06:51

         section   sprite
         xdef      mes_selc
mes_selc
sp1
         dc.w  $0100,$0000          ;form, time/adaption
         dc.w  $000B,$000D          ;x size, y size 
         dc.w  $0005,$0005          ;x origin, y origin 
         dc.l  cp1-*                ;pointer to colour pattern
         dc.l  pm1-*                ;pointer to pattern mask
         dc.l  0                    ;pointer to next definition 
cp1
         dc.w  $3F3F,$8080
         dc.w  $4040,$4040
         dc.w  $8080,$2020
         dc.w  $8E8E,$2020
         dc.w  $8A8A,$2020
         dc.w  $7474,$4040
         dc.w  $0808,$8080
         dc.w  $1111,$0000
         dc.w  $1111,$0000
         dc.w  $1F1F,$0000
         dc.w  $1111,$0000
         dc.w  $1111,$0000
         dc.w  $1F1F,$0000
pm1
         dc.w  $3F3F,$8080
         dc.w  $7F7F,$C0C0
         dc.w  $FFFF,$E0E0
         dc.w  $FFFF,$E0E0
         dc.w  $FBFB,$E0E0
         dc.w  $7777,$C0C0
         dc.w  $0F0F,$8080
         dc.w  $1F1F,$0000
         dc.w  $1F1F,$0000
         dc.w  $1F1F,$0000
         dc.w  $1F1F,$0000
         dc.w  $1F1F,$0000
         dc.w  $1F1F,$0000
;
         end
