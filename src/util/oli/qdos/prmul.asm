; print multiple bytes to channel                       1993 O.Fink
;
        include win1_mac_oli
        include win1_keys_qdos_io

        section utility

        xdef    ut_prmul

;+++
; print multiple bytes to a given channel (timeout = -1)
;
;               Entry                   Exit
;       a0      channel id              preserved
;       a1      ptr to buffer           preserved
;       d0.w    number of bytes to write error code
;
; errors: IOSS
; cc:     set
;---
ut_prmul subr   a1/d1/d2
        move.w  d0,d2
        moveq   #iob.smul,d0
        xjsr    do_io
        subend
        end
