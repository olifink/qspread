; position file pointer absolute/relative

        include win1_mac_oli
        include win1_keys_qdos_io

        section utility

        xdef    ut_fposa
        xdef    ut_fposr

;+++
; position file pointer absolute/relative
;
;               Entry                           Exit
;       d1.l    file position                   new file position
;       a0      channel id                      preserved
;
; errors: ichn, eof
;---
ut_fposa moveq  #iof.posa,d0
        bra.s   both
ut_fposr moveq  #iof.posr,d0
both    push    a1
        xjsr    do_io
        pop     a1
        tst.l   d0
        rts

        end
