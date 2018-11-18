; release memory of row list

        section utility

        include win1_mac_oli
        include win1_keys_wwork
        include win1_keys_err

        xdef    xwm_rerl

;+++
; release memory of row list
;
;               Entry                           Exit
;       d0      subwindow number                error code
;       a4      wwork                           preserved
;
;---
xwm_rerl subr   a0/a3/d0
        xjsr    xwm_awadr                       ; get menu address
        move.l  wwa_rowl(a3),d0                 ; rowlist already installed?
        beq.s   no_row
        move.l  d0,a0
        xjsr    ut_rechp
no_row  clr.l   wwa_rowl(a3)
        subend

        end
