; get 2 dim array information

        section utility

        include win1_mac_oli

        xdef    ut_arinf

;+++
; get 2 dim array information
;
;               Entry                           Exit
;       d1.l    array type (0=abs,1=rel)        nr. of elements
;       d2.w                                    multiplicator
;       a0      array descriptor                ptr to first element
;---
ut_arinf subr   a1
        move.l  a0,a1
        move.l  (a0),a0
        tst.l   d1
        beq.s   ar_abs
        adda.l  a1,a0
ar_abs  moveq   #1,d1
        add.w   6(a1),d1                ; nr of elements
        move.w  8(a1),d2                ; mulitplicator
        subend

        end
