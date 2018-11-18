; print decimal string of integer word to channel
;

        include win1_mac_oli

        section utility

        xdef    ut_priwd

;+++
; convert integer word to decimal string
; d1.w=$abcd    (a0)-> '43981'
;
;               Entry                           Exit
;       d1.w    word integer                    preserved
;       a0      channel id                      preserved
;
; errors: IOSS
;---
ut_priwd subr   a0-a1/d1
        move.l  a0,a1
        suba.w  #12,sp
        move.l  sp,a0
        xjsr    cnv_iwstr
        exg     a0,a1
        xjsr    ut_prstr
        adda.w  #12,sp
        subend

        end
