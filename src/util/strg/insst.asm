; insert one string in another                        06/01-92 O.Fink

         section  string

         include  win1_keys_err

         xdef     st_insst                   ; insert a string

;+++
; insert a string in another one
; abcdef -> insert 123 after 2 -> ab123def
;
;                 Entry                      Exit
;        a0       ptr to string              preserved
;        a1       ptr to string inserted     preserved
;        a2       ptr to result string       preserved
;        d1.w     position to insert after   preserved
;
; error codes:    err.orng          position out of range
; condition codes set
;---
r_insst   reg      d1-d3/a0-a2
st_insst
         movem.l  r_insst,-(sp)
         moveq    #err.orng,d0
         move.w   (a0)+,d2
         move.w   d2,d3
         sub.w    d1,d3
         bmi.s    ins_exit

         add.w    (a1),d2
         move.w   d2,(a2)+          ; new string length

         move.w   (a1)+,d2          ; length of insert string

         bra.s    ins_end           ; copy the first part
ins_lp
         move.b   (a0)+,(a2)+
ins_end
         dbra     d1,ins_lp

         bra.s    ins_end2          ; insert the string
ins_lp2
         move.b   (a1)+,(a2)+
ins_end2
         dbra     d2,ins_lp2

         bra.s    ins_end3          ; copy the rest
ins_lp3
         move.b   (a0)+,(a2)+
ins_end3
         dbra     d3,ins_lp3
         moveq    #0,d0

ins_exit
         movem.l  (sp)+,r_insst
         tst.l    d0
         rts

         end
