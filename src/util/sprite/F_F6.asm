;Sprite source code generated with EASYSOURCE V3.02
; 1991/92  Albin Hessler Software
;************************************************

;   ->   F6  <-    1993 Jul 25 14:45:43

         section   sprite
         xdef      mes_f6
mes_f6
sp1_F6
         dc.w  $0100,$0000          ;form, time/adaption
         dc.w  $0008,$0007          ;x size, y size 
         dc.w  $0000,$0000          ;x origin, y origin 
         dc.l  cp1_F6-*             ;pointer to colour pattern
         dc.l  pm1_F6-*             ;pointer to pattern mask
         dc.l  0                    ;pointer to next definition 
cp1_F6
         dc.w  $E600,$0000
         dc.w  $8900,$0000
         dc.w  $8800,$0000
         dc.w  $CE00,$0000
         dc.w  $8900,$0000
         dc.w  $8900,$0000
         dc.w  $8600,$0000
pm1_F6
         dc.w  $0000,$0000
         dc.w  $0000,$0000
         dc.w  $0000,$0000
         dc.w  $0000,$0000
         dc.w  $0000,$0000
         dc.w  $0000,$0000
         dc.w  $0000,$0000
;
         end
