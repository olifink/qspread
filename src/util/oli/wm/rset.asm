; re-setup a window

        include win1_mac_oli
        include win1_keys_wman
        include win1_keys_wwork
        include win1_keys_wstatus

        section utility

        xdef    xwm_rset

;+++
; re-setup a window into a given definition
;
;               Entry                           Exit
;       d1.l    size (or 0, or -1)              position
;       a2      wman vector
;       a4      wwork
;---
xwm_rset subr   a0/a1/a3/d3/d2
        move.l  ww_chid(a4),a0          ; channel id
        move.l  ww_wstat(a4),a1         ; window status area
        move.l  ww_wdef(a4),a3          ; window defintion

        move.l  ws_ptpos(a1),d3         ; absolute pointer position
        move.l  ww_xorg(a4),d2          ; origin of window..
        sub.l   d2,d3                   ; ptr pos in primary
        add.l   ww_xsize(a4),d2         ; ..bottom right hand corner

        xjsr    xwm_wsiz                ; check window size
        jsr     wm.setup(a2)            ; setup window

        move.l  d3,ww_xorg(a4)          ; adjust pointer position
        sub.l   ww_xsize(a4),d2         ; get new origin
        add.l   d3,d2                   ; rel. by ptr pos
        move.l  d2,d1
        subend

        end
