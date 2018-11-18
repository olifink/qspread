; fill string with one character             27/01-92 O.Fink

         section  string

         include  win1_keys_err

         xdef     st_filst                   ; fill a string

;+++
; fill a string with one character
; x,10 -> xxxxxxxxxx
;
;                 Entry                      Exit
;        a0       ptr to string              preserved
;        d1.b     character to fill with     preserved
;        d2.w     fill length                preserved
;---
r_filst  reg      a0/d2
st_filst
         movem.l  r_filst,-(sp)
         move.w   d2,(a0)+
         bra.s    fil_end
fil_lp
         move.b   d1,(a0)+
fil_end
         dbra     d2,fil_lp
fil_exit
         movem.l  (sp)+,r_filst
         rts

         end
