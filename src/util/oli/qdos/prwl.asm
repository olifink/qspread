; print word/long to channel                       1993 O.Fink
;
        include win1_mac_oli
        include win1_keys_qdos_io

        section utility

        xdef    ut_prw
        xdef    ut_prl

;+++
; print a character to a given channel (timeout = -1)
;
;               Entry                   Exit
;       d1.w/l  character               preserved
;       a0      channel id              preserved
;
; errors: IOSS
; cc:     set
;---
ut_prw  subr   a1/d1/d2
        suba.w  #2,sp
        move.l  sp,a1
        move.w  d1,(a1)
        moveq   #2,d0
        xjsr    ut_prmul
        adda.l  #2,sp
        subend

ut_prl  subr   a1/d1/d2
        suba.w  #4,sp
        move.l  sp,a1
        move.l  d1,(a1)
        moveq   #4,d0
        xjsr    ut_prmul
        adda.w  #4,sp
        subend

        end
