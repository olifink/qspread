; delete one character in a string                    06/01-92 O.Fink

         section  string

         include  win1_keys_err

         xdef     st_delc                    ; delete one character

;+++
; delete one character in a string
; abcdef -> delete 3 -> string= abdef
;
;                 Entry                      Exit
;        a0       ptr to string              preserved
;        d1.w     position of character      preserved
;
; error codes:    err.orng   character out of string
; condition codes set
;---
r_delc   reg      d1/d2
st_delc
         movem.l  r_delc,-(sp)
         moveq    #0,d0
         tst.w    d1
         beq.s    delc_exit                  ; zero characeter
         moveq    #err.orng,d0
         move.w   (a0),d2
         sub.w    d1,d2
         bmi.s    delc_exit                  ; character out of range
         moveq    #0,d0
         sub.w    #1,(a0)                    ; new length
         bra.s    delc_end
delc_lp
         move.b   2(a0,d1.w),1(a0,d1.w)
         addq.w   #1,d1
delc_end
         dbra     d2,delc_lp

delc_exit
         movem.l  (sp)+,r_delc
         tst.l    d0
         rts

         end
