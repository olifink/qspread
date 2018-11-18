; multiple keystroke routine for application subwinodw

        include win1_mac_oli

        section utility

        xdef    xwm_amky

;+++
; multiple keystroke routine for application subwinodw
;
;               Entry                           Exit
;       d2.l    keystroke code                  multiple keystroke code
;       a1      ptr to keystroke counter (.l)   preserved
;---
xwm_amky
        tst.l  d2                       ; any keystroke at all?
        beq.s   exit
        cmp.b   3(a1),d2                ; counter for the same key?
        bne.s   exit
        move.l  (a1),d2                 ; get old counter
        add.l   #$100,d2                ; increase it
exit    move.l  d2,(a1)                 ; store it again
        rts

        end
