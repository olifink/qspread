;Sprite source code generated with EASYSOURCE  1991 Albin Hessler Software
;**************************************************************************  

;   ->   spread_s  <-    1992 Mar 17 13:02:17

         section   sprite
         xdef      mes_macr
mes_macr
sp1
         dc.w  $0100,$0000          ;form, time/adaption
         dc.w  $000D,$000D          ;x size, y size 
         dc.w  $0006,$0006          ;x origin, y origin 
         dc.l  cp1-*                ;pointer to colour pattern
         dc.l  pm1-*                ;pointer to pattern mask
         dc.l  0                    ;pointer to next definition 
cp1
         dc.w  $0F0F,$8080
         dc.w  $0808,$8080
         dc.w  $0808,$8080
         dc.w  $0808,$8080
         dc.w  $F8F8,$F8F8
         dc.w  $8080,$0808
         dc.w  $8080,$0808
         dc.w  $8080,$0808
         dc.w  $F8F8,$F8F8
         dc.w  $0808,$8080
         dc.w  $0808,$8080
         dc.w  $0808,$8080
         dc.w  $0F0F,$8080
pm1
         dc.w  $0F0F,$8080
         dc.w  $0F0F,$8080
         dc.w  $0F0F,$8080
         dc.w  $0F0F,$8080
         dc.w  $FFFF,$F8F8
         dc.w  $FFFF,$F8F8
         dc.w  $FFFF,$F8F8
         dc.w  $FFFF,$F8F8
         dc.w  $FFFF,$F8F8
         dc.w  $0F0F,$8080
         dc.w  $0F0F,$8080
         dc.w  $0F0F,$8080
         dc.w  $0F0F,$8080
;
         end
