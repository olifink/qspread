;Sprite source code generated with EASYSOURCE  1991 Albin Hessler Software
;**************************************************************************

;   ->   asm_spr_  <-    1992 Jun 13 12:45:20

         section   sprite
         xdef      mes_f9
mes_f9
sp1
         dc.w  $0100,$0000          ;form, time/adaption
         dc.w  $0008,$0007          ;x size, y size 
         dc.w  $0000,$0000          ;x origin, y origin 
         dc.l  cp1-*                ;pointer to colour pattern
         dc.l  pm1-*                ;pointer to pattern mask
         dc.l  0                    ;pointer to next definition 
cp1
         dc.w  $E600,$0000
         dc.w  $8900,$0000
         dc.w  $8900,$0000
         dc.w  $C700,$0000
         dc.w  $8100,$0000
         dc.w  $8900,$0000
         dc.w  $8600,$0000
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
