; set absolute pointer position

        include win1_mac_oli
        include win1_keys_qdos_io

        section utility

        xdef    xwm_saptr

;+++
; set relative pointer position
;
;               Entry                           Exit
;       d1.l    position
;       a0      channel id
;
; errors
;---
xwm_saptr subr  d2
        moveq   #iop.sptr,d0
        moveq   #0,d2
        xjsr    do_io
        subend

        end
