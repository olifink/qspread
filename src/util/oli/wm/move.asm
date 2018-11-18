; standard window move routine

        include win1_mac_oli
        include win1_keys_wman
        include win1_keys_wstatus
        include win1_keys_qdos_pt

        section utility

        xdef    xwm_move
        xref    ut_appr

;+++
; standard window move routine
;
;               Entry                           Exit
;       a1      status area
;       a2      wman vector
;       a4      wwork
;---
xwm_move
        jsr     wm.chwin(a2)
        bmi     ut_appr
        bclr    #pt..wmov,wsp_weve(a1)
        xjmp    ut_rdwci

        end
