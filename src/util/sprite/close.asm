;Sprite source code generated with EASYSOURCE  1991 Albin Hessler Software
;**************************************************************************

;   ->   asm_spr_  <-    1992 Jun 13 12:42:49

         section   sprite
         xdef      mes_clos
mes_clos
sp1
         dc.w  $0100,$0000          ;form, time/adaption
         dc.w  $000E,$0007          ;x size, y size 
         dc.w  $0006,$0003          ;x origin, y origin 
         dc.l  cp1-*                ;pointer to colour pattern
         dc.l  pm1-*                ;pointer to pattern mask
         dc.l  0                    ;pointer to next definition 
cp1
         dc.w  $FFFF,$FCFC
         dc.w  $F0FF,$3CFC
         dc.w  $CCFF,$CCFC
         dc.w  $C3FF,$0CFC
         dc.w  $CCFF,$CCFC
         dc.w  $F0FF,$3CFC
         dc.w  $FFFF,$FCFC
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
