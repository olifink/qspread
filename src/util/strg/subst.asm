; get a sub-string                                    06/01-92 O.Fink

         section  string

         include  win1_keys_err

         xdef     st_subst                   ; get a substring

;+++
; get a subrstring from a standard string
; abcdef -> start 2 length 3 -> substring= bcd
;
;                 Entry                      Exit
;        a0       ptr to string              preserved
;        a1       ptr to sub string result   preserved
;        d1.w     substring start position   preserved
;        d2.w     substring length           preserved
;
; error codes:    err.orng   split position not in string boundaries
; condition codes set
;---
r_subst  reg      d1-d3/a0-a1
st_subst
         movem.l  r_subst,-(sp)
         tst.w    d2
         beq.s    sub_ok                     ; no length always works
         moveq    #err.orng,d0
         move.w   (a0)+,d3                   ; total string length
         sub.w    d1,d3
         bmi.s    sub_exit                   ; start position out of range
         sub.w    d2,d3
         bmi.s    sub_exit                   ; length out of range

         move.w   d2,(a1)+                   ; set substring length
         subq.w   #1,d1
         adda.w   d1,a0                      ; get to start of substring
sub_lp
         move.b   (a0)+,(a1)+                ; copy all chars of substring
         dbra     d2,sub_lp
sub_ok
         moveq    #0,d0
sub_exit
         movem.l  (sp)+,r_subst
         tst.l    d0
         rts

         end
