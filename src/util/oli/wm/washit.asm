; test for a hit

        include win1_keys_wwork
        include win1_keys_wstatus
        include win1_mac_oli
        include win1_keys_k

        section utility

        xdef    xwm_washit

;+++
; test for a hit
;
;               Entry                           Exit
;       a4      wwork
;
; cc: Z it was a hit, NZ no hit
;---
xwm_washit subr  a1
        move.l  ww_wstat(a4),a1
        cmp.b   #k.hit,wsp_kstr(a1)
exit    subend

        end
