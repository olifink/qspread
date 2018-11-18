; set toggle item

        include win1_mac_oli
        include win1_keys_wman

        section utility

        xdef    xwm_stgl

;+++
; set toggle item
;
;               Entry                           Exit
;       d1      loose item numer
;       a2      wman vector
;       a3      toggle list
;       a4      wwork
;---
xwm_stgl subr   a0/a1
        move.l  a3,a0
        add.l   (a0),a0
        push    d1
        moveq   #1,d1
        xjsr    ut_arinf                ; get address of first item
        pop     d1
        move.w  4(a3),d0                ; get current item
        subq.w  #1,d0
        mulu    d0,d2
        lea     (a0,d2.l),a1
        jsr     wm.stlob(a2)
        subend

        end
