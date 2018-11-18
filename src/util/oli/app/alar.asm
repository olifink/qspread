; allocate a new array

        include win1_mac_oli

        section utility

        xdef    ut_alar

;+++
; allocate a new array (type abs.)
;
;               Entry                           Exit
;       d1.l    nr. of elements                 0 (=type absolute)
;       d2.w    multiplicator                   preserved
;       a0                                      array descriptor
;
; errors: imem
; cc set
;---
ut_alar subr    d2
        bsr.s   aloc
        bne.s   exit
        move.l  a0,-(sp)
        moveq   #14,d0
        add.l   a0,d0
        move.l  d0,(a0)+                 ; array contents pointer
        move.w  #2,(a0)+                 ; 2 dimensions
        subq.l  #1,d1
        move.w  d1,(a0)+                ; nr of elements
        move.w  d2,(a0)+                ; multiplicator
        subq.w  #2,d2
        move.w  d2,(a0)+               ; length
        move.w  #1,(a0)
        move.l  (sp)+,a0
        moveq   #0,d1
        moveq   #0,d0
exit    subend

aloc    subr    d1
        mulu.w  d2,d1
        add.l   #14,d1
        xjsr    ut_alchp
        subend

        end
