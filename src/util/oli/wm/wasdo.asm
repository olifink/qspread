; test for a do

        include win1_keys_wwork
        include win1_keys_wstatus
        include win1_mac_oli
        include win1_keys_k

        section utility

        xdef    xwm_wasdo

;+++
; test for a do
;
;               Entry                           Exit
;       a4      wwork
;
; cc: Z it was a do, NZ no do
;---
xwm_wasdo subr  a1
        move.l  ww_wstat(a4),a1
        cmp.b   #k.do,wsp_kstr(a1)
exit    subend

        end
