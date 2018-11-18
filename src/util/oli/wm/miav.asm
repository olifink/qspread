; make a menu item available and redraw it

        include win1_mac_oli
        include win1_keys_wstatus
        include win1_keys_wman

        section prog

        xdef    xwm_miav

;+++
; make a menu item available and redraw it
;
;               Entry                           Exit
;       d2.w    item number
;       a0      channel id
;       a3      subwindow defn
;       a4      wwork
;
; errors: ioss
;---
xwm_miav subr   d3
        move.b  #wsi.mkav,(a1,d2.w)
        moveq   #wm.drsel,d3
        jsr     wm.mdraw(a2)
        bne.s   exit
        bclr    #wsi..chg,(a1,d2.w)
exit    subend

        end
