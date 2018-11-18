; Split a string                                      06/01-92 O.Fink

         section  string

         include  win1_keys_err

         xdef     st_splta          ; split string after position

;+++
; split a standard string after a position
; abcdef -> split after 2 -> 1st=ab ; 2nd=cdef
;
;                 Entry                      Exit
;        a0       ptr to string              preserved
;        a1       ptr to 1st new string (or 0) preserved
;        a2       ptr to 2nd new string (or 0) preserved
;        d1.w     split after this position  preserved
;
; error codes:    err.orng   split position not in string boundaries
; condition codes set
;---
r_splta  reg      d1/d2/a0-a2
st_splta
         movem.l  r_splta,-(sp)
         moveq    #err.orng,d0
         move.w   (a0)+,d2
         sub.w    d1,d2
         bmi.s    spt_exit                   ; split position orng

         move.l   a1,d0
         beq.s    no_1st
         move.w   d1,(a1)+                   ; copy first string
         bra.s    spt_end
spt_lp
         move.b   (a0)+,(a1)+
spt_end
         dbra     d1,spt_lp
         bra.s    st1_ok
no_1st   adda.w   d1,a0
st1_ok   move.l   a2,d0
         beq.s    no_2nd
         move.w   d2,(a2)+                   ; copy 2nd string
         bra.s    spt_end2
spt_lp2
         move.b   (a0)+,(a2)+
spt_end2
         dbra     d2,spt_lp2
no_2nd
         moveq    #0,d0                      ; no errors
spt_exit
         movem.l  (sp)+,r_splta
         tst.l    d0
         rts

         end
