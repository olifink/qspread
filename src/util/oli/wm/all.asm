; set all menu items to a given status

        include win1_mac_oli
        include win1_keys_wwork

        section utility

        xdef    xwm_all

;+++
; set all menu items to a given status
;
;               Entry                           Exit
;       d0.w    application window nr
;       d1.b    new item status
;       a4      wwork
;
; no errors
;---
xwm_all subr    a3
        xjsr    xwm_awadr               ; get address of appl. subwindow
        move.w  wwa_ncol(a3),d0
        mulu    wwa_nrow(a3),d0
        move.l  wwa_mstt(a3),a3         ; menu status area
        bra.s   lpe
lp      move.b  d1,(a3)+
lpe     dbra    d0,lp
        moveq   #0,d0
        subend

        end
