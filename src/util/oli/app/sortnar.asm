; sort array into new array and discard old one

        include win1_mac_oli

        section utility

        xdef    ut_sortnar

;+++
; sort an 2 dim array and discard unsorted array
;
;               Entry                           Exit
;       d1.l    array type (0=abs,1=rel)        0
;       a0      unsorted array descr.           sorted array descr. (abs)
;---
ut_sortnar subr a1
        move.l  a0,d0
        beq.s   exit
        move.l  a0,a1
        xjsr    ut_sortar
        bne.s   exit
        move.l  a0,-(sp)
        move.l  a1,a0
        xjsr    ut_rechp
        move.l  (sp)+,a0
exit    tst.l   d0
        subend

        end
