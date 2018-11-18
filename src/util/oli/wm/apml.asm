; create complete menu subwindow from array

        section utility

        include win1_mac_oli
        include win1_keys_wwork
        include win1_keys_err

        xdef    xwm_apml

;+++
; create application menu from array
;
;               Entry                           Exit
;       d0      subwindow number                error code
;       d1      array type (0=abs, 1=rel)
;       d2      1=make selectionkeys
;       a0      array descriptor                channel id
;       a1      item action routine
;       a4      wwork                           preserved
;
; errors
;---
xwm_apml subr   d3/a3
        xjsr    xwm_rerl                        ; release row list
        bne.s   exit
        move.l  a0,d0
        beq.s   nolist
        xjsr    xwm_mkrl                        ; make row list
        bmi.s   exit
        xjsr    xwm_mlww                        ; put it into wwork
        bmi.s   exit
        xjsr    xwm_fyml                        ; fit it into menu
exit    tst.l   d0
        subend

nolist  move.l  ww_chid(a4),a0
        bra.s   exit

        end
