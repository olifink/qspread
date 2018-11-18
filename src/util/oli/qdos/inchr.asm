; input a character from channel                       1993 O.Fink
;
        include win1_mac_oli
        include win1_keys_qdos_io

        section utility

        xdef    ut_inchr

;+++
; input a character from a given channel (timeout = -1)
;
;               Entry                   Exit
;       d1.b                            character
;       a0      channel id              preserved
;
; errors: IOSS
; cc:     set
;---
ut_inchr subr   a1/d1
        moveq   #iob.fbyt,d0
        xjsr    do_io
        subend

        end
