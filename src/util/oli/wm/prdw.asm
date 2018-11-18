; calculate window size

        include win1_mac_oli
        include win1_keys_wman
        include win1_keys_wwork

        section utility

        xdef    xwm_prdw

;+++
; calculate window size
;
;               Entry                           Exit
;       d1.l    origin (or -1)
;       a2      wman
;       a4      wwork
; errors: IOSS
;---
xwm_prdw
        jsr     wm.prpos(a2)
        bne.s   exit
        jsr     wm.wdraw(a2)
exit    rts

        end
