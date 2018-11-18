; make list to array contents

        include win1_mac_oli

        section utility

        xdef    ut_lst2ar

;+++
; make list to array contents
;
;               Entry                           Exit
;       d2.w    multiplicator                   preserved
;       a0      ptr to first element            preserved
;       a1      ptr to list                     preserved
;---
ut_lst2ar subr  a0/a1/d1
lp      move.l  (a1)+,d1
        beq.s   eol
        bsr.s   copy
        bra.s   lp
eol     subend

copy    subr    a1
        move.l  d1,a1
        xjsr    ut_cpyst
        adda.w  d2,a0
        subend

        end
