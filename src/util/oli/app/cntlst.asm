; count elements in list

        include win1_mac_oli

        section utility

        xdef    ut_cntlst

;+++
; count nr. of elements in list
;
;               Entry                           Exit
;       d1.l                                    nr of elements
;       a1      ptr to list                     preserved
;---
ut_cntlst subr  a1/d0
        moveq   #0,d1
lp      move.l  (a1)+,d0
        beq.s   exit
        addq.l  #1,d1
        bra.s   lp
exit    subend

        end
