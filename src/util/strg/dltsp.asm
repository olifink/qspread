; delete trailing spaces from a string                 18/01-92 O.Fink

         section  string

         include  win1_keys_err

         xdef     st_dltsp                   ; delete trailing spaces

;+++
; delete trailing spaces from a string
; "abc  " -> dltsp -> "abc"
;
;                 Entry                      Exit
;        a0       ptr to string              preserved
;
; error codes:    none
; condition codes: none
;---
r       reg    d1/d0
st_dltsp
        movem.l r,-(sp)
        move.w  (a0),d0
        beq.s   exit
loop    move.b  1(a0,d0.w),d1
        cmpi.b  #' ',d1
        bne.s   exit
        subq.w  #1,d0
        bne.s   loop
exit    move.w  d0,(a0)
        movem.l (sp)+,r
        rts

        end
