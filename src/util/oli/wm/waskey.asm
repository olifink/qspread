; test for a keystroke

        include win1_keys_wwork
        include win1_keys_wstatus
        include win1_mac_oli

        section utility

        xdef    xwm_waskey

;+++
; test for a keystroke
;
;               Entry                           Exit
;       a4      wwork
;
; errors: 0=it was a keystroke, <>0 other event
;---
xwm_waskey subr  a1
        move.l  ww_wstat(a4),a1
        cmp.b   #8,wsp_kstr(a1)
        bgt.s   waskey
        moveq   #1,d0
exit    subend
waskey  moveq   #0,d0
        bra.s   exit

        end
