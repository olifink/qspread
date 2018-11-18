; redraw loose items

        section utility

        include win1_keys_wman

        xdef    xwm_ldrwc               ; redraw changed loose items
        xdef    xwm_ldrwa               ; redraw all loose items

;+++
; redraw changed/all loose items
;
;               Entry                           Exit
;       a0      channel id
;       a2      wman vector
;       a4      working definition
;---
xwm_ldrwc
        movem.l d3,-(sp)
        moveq   #wm.drsel,d3
        bra.s   do_draw
xwm_ldrwa
        move.l  d3,-(sp)
        moveq   #wm.drall,d3
do_draw jsr     wm.ldraw(a2)
        tst.l   d0
        movem.l (sp)+,d3
        rts
        end


        end



