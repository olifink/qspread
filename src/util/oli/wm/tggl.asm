; toggle loose item through a list

        include win1_mac_oli
        include win1_keys_wwork
        include win1_keys_wman

        section utility

        xdef    xwm_tggl

;+++
; toggle loose item through a list
;
;               Entry                           Exit
;       a0      toggle list stucture            channel id
;       a1      status area
;       a3      ptr to loose item
;       a4      wwork
;---
xwm_tggl subr   a5
        move.l  a0,a5                   ; a5 is toggle list
        add.l   (a0),a0                 ; get array descriptor
        moveq   #1,d1                   ; always relative array
        xjsr    ut_arinf                ; get array information
        move.w  4(a5),d0
        cmp.w   d1,d0
        bne.s   getitem
        moveq   #0,d0
getitem mulu    d0,d2
        addq.w  #1,d0
        move.w  d0,4(a5)
        bsr.s   chgitem
        move.l  ww_chid(a4),a0
        xjsr    ut_rdwci
        subend

chgitem subr    a1
        lea     (a0,d2.l),a1            ; ptr to object
        move.w  wwl_item(a3),d1         ; item number
        jsr     wm.stlob(a2)
        subend

        end
