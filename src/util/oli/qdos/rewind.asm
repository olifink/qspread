; rewind file to first position

        include win1_mac_oli
        include win1_keys_qdos_io

        section utility

        xdef    ut_rewind

;+++
; rewind file to first position
;
;               Entry                           Exit
;       a0      channel id                      preserved
;
; errors: ioss
; cc set
;---
ut_rewind subr  a1/d1
        moveq   #0,d1           ; rewind to beginning
        moveq   #iof.posa,d0    ; position absolute
        xjsr    do_io
        subend

        end
