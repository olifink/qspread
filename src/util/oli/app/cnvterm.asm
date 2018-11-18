; convert termination character to signed value

         include  win1_keys_k

         section  utility

         xdef     cnv_term

;+++
; convert termination character
;
;        d1.b : termination character        d1.l : +1/0/-1
; no errors set
;---
cnv_term
         cmpi.b   #k.esc,d1
         beq.s    term_esc
         cmpi.b   #k.up,d1
         beq.s    term_up
         moveq    #1,d1
         rts
term_up
         moveq    #-1,d1
         rts
term_esc
         moveq    #0,d1
         rts

         end
