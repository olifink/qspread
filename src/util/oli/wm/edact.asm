; loose item edit / read action routines

        include win1_mac_oli
        include win1_keys_wman
        include win1_keys_wwork
        include win1_keys_wstatus

        section utility

        xdef    mea_edit,mea_read

;+++
; edit/read loose item
;
;               Entry                   Exit
;       d3                              ???
;       d4      event number            no event
;       a0      channel id              preserved
;       a1      status area             preserved
;       a2      wman vec                preserved
;       a3      ptr to loose item       ???
;       a4      wwork                   preserved
;
; error and condition codes set
;---
mea_edit
        move.w  #wm.ename,d3            ; edit routine
        bra.s   do_it
mea_read
        move.w  #wm.rname,d3
do_it   move.w  wwl_item(a3),d1         ; set window area
        moveq   #wsi.avbl,d2
        jsr     wm.swlit(a2)
        bne.s   exit
        move.l  wwl_pobj(a3),a1
        jsr     (a2,d3.w)               ; call edit/read vector
        bmi.s   exit
        move.l  ww_wstat(a4),a1         ; redraw item
        move.w  wwl_item(a3),d1
        move.b  #wsi.mkav,ws_litem(a1,d1.w) ; reset item status
        xjsr    xwm_ldrwc               ; selective redraw
        moveq   #0,d4
        moveq   #0,d0
exit    rts

        end
