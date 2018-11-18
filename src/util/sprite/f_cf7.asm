;Sprite source code generated with EASYSOURCE  1991 Albin Hessler Software
;**************************************************************************

;   ->   asm_spr_  <-    1992 Jun 13 12:44:51

         section   sprite
         xdef      mes_cf7
mes_cf7
sp1
         dc.w  $0100,$0000          ;form, time/adaption
         dc.w  $000C,$0007          ;x size, y size 
         dc.w  $0000,$0000          ;x origin, y origin 
         dc.l  cp1-*                ;pointer to colour pattern
         dc.l  pm1-*                ;pointer to pattern mask
         dc.l  0                    ;pointer to next definition 
cp1
         dc.w  $6E00,$F000
         dc.w  $8800,$9000
         dc.w  $8800,$1000
         dc.w  $8C00,$2000
         dc.w  $8800,$2000
         dc.w  $8800,$4000
         dc.w  $6800,$4000
pm1
         dc.w  $0000,$0000
         dc.w  $0000,$0000
         dc.w  $0000,$0000
         dc.w  $0000,$0000
         dc.w  $0000,$0000
         dc.w  $0000,$0000
         dc.w  $0000,$0000
;
         end
