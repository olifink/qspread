; print internal format of string to channel            1993 O.Fink
;
        include win1_mac_oli
        include win1_keys_qdos_io

        section utility

        xdef    ut_prsti

;+++
; print an internal format string to a given channel (timeout = -1)
; (padded even!)
;
;               Entry                   Exit
;       a0      channel id              preserved
;       a1      ptr to string           preserved
;
; errors: IOSS
; cc:     set
;---
ut_prsti subr   a1/d1/d2
        moveq   #iob.smul,d0
        moveq   #3,d2
        add.w   (a1),d2
        bclr    #0,d2
        xjsr    do_io
        subend

        end
