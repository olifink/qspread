;Sprite source code generated with EASYSOURCE  1991 Albin Hessler Software
;**************************************************************************

;   ->   asm_spr_  <-    1992 Jun 13 12:45:26

         section   sprite
         xdef      mes_tab
mes_tab
sp1
         dc.w  $0100,$0000          ;form, time/adaption
         dc.w  $000E,$0007          ;x size, y size 
         dc.w  $0000,$0000          ;x origin, y origin 
         dc.l  cp1-*                ;pointer to colour pattern
         dc.l  pm1-*                ;pointer to pattern mask
         dc.l  0                    ;pointer to next definition 
cp1
         dc.w  $F300,$3800
         dc.w  $2400,$A400
         dc.w  $2400,$A400
         dc.w  $2700,$B800
         dc.w  $2400,$A400
         dc.w  $2400,$A400
         dc.w  $2400,$B800
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
