; input a multiple characters from channel                       1993 O.Fink
;
        include win1_mac_oli
        include win1_keys_qdos_io

        section utility

        xdef    ut_inmul

;+++
; input multiple chars from a given channel (timeout = -1)
;
;               Entry                   Exit
;       d2.w    nr. of bytes to read    preserved
;       a0      channel id              preserved
;       a1      base of buffer          preserved
;
; errors: IOSS
; cc:     set
;---
ut_inmul subr   a2/a1/d1/d2
        moveq   #iob.fmul,d0
        move.l  a1,a2
        addq.w  #2,a1
        xjsr    do_io
        bne.s   exit
        subq.w  #1,d1
        move.w  d1,(a2)
exit
        tst.l   d0
        subend

        end
