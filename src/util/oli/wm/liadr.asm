; find loose item address from item object number
;

        include win1_keys_err
        include win1_keys_wwork
        section utility


        xdef    xwm_liadr

;+++
; loose item in wwork
;
;               Entry                           Exit
;       d1.w    item obj. number
;       a3                                      address in wwork
;       a4      wwork
; errors: orng
;---
xwm_liadr
        moveq   #err.orng,d0
        cmp.w   ww_nlitm(a4),d1
        bhi.s   exit
        move.w  d1,d0
        mulu    #wwl.elen,d0
        move.l  ww_plitm(a4),a3
        adda.l  d0,a3
        moveq   #0,d0
exit    tst.l   d0
        rts

        end
