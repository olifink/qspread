;Sprite source code generated with EASYSOURCE  1991 Albin Hessler Software
;**************************************************************************

;   ->   asm_spr_  <-    1992 Jun 13 12:45:14

         section   sprite
         xdef      mes_f7
mes_f7
sp1
         dc.w  $0100,$0000          ;form, time/adaption
         dc.w  $0008,$0007          ;x size, y size 
         dc.w  $0000,$0000          ;x origin, y origin 
         dc.l  cp1-*                ;pointer to colour pattern
         dc.l  pm1-*                ;pointer to pattern mask
         dc.l  0                    ;pointer to next definition 
cp1
         dc.w  $EF00,$0000
         dc.w  $8900,$0000
         dc.w  $8100,$0000
         dc.w  $C200,$0000
         dc.w  $8200,$0000
         dc.w  $8400,$0000
         dc.w  $8400,$0000
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
