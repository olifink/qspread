; run an loose item action routine

        include win1_mac_oli
        include win1_keys_wwork
        include win1_keys_wstatus

        section utility

        xdef    xwm_liact

;+++
; run an loose item action routine
;
;               Entry                           Exit
;       d1.w    item number
;       a4      wwork
;---
xwm_liact
        move.l  ww_wstat(a4),a1
        move.l  ww_chid(a4),a0
        xjsr    xwm_liadr
        move.l  wsp_xpos(a1),d1
        moveq   #0,d2
        moveq   #0,d4
        move.l  wwl_pact(a3),-(sp)
        rts


        end
