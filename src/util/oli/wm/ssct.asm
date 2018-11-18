; set the number of columns/rows in section control block

        include win1_mac_oli
        include win1_keys_wwork
        include win1_keys_wstatus

        section  utility

        xdef    xwm_ssct

;+++
; set the number of columns/rows in section control block
;
;               Entry                   Exit
;       d1.w    0=columns/1=rows
;       a1      section control block
;       a3      appl-sub-wwork
; errors: always OK
; ccr set
;---
xwm_ssct subr    a3/a2/d1-d5
        lsl.w   #1,d1
        adda.w  d1,a3                   ; a3!! adjusted
        moveq   #0,d2                   ; d2 object count
        move.w  (a3),d3                 ; d3 window size
        sub.w   wwa_xoff(a3),d3         ; less the section offset
        move.w  wwa_ncol(a3),d5         ; d5 number of objects (row,col)
        adda.w  d1,a3
        move.l  wwa_xspc(a3),a2         ; a2 spacing list
        move.w  #1,wss_nsec(a1)         ; assume one section
        move.l  #(ww.scbar+2)<<16+(ww.pnbar+2),d4
        tst.w   d1
        bne.s   noswp
        swap    d4
noswp   sub.w   d4,d3                   ; size less the bottom/right arrows
        bra.s   lpe
lp      sub.w   wwm_spce(a2),d3         ; fit's the object?
        bmi.s   full                    ; ..no window is full
        adda.w  #wwm.slen,a2            ; next object
        addq.w  #1,d2
lpe     dbra    d5,lp
        clr.w   wss_nsec(a1)            ; it fits!
        suba.w  d1,a3
        clr.w   wwa_xoff(a3)            ; no offset needed
exit    moveq   #0,d0
        subend

full    clr.w   wss_sstt+2(a1)          ; first object
        move.w  d2,wss_ssiz+2(a1)       ; nr. of objects
        bra.s   exit

        end
