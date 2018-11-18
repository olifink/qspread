; convert integer word to decimal string
;

        include win1_mac_oli

        section utility

        xdef    cnv_iwstr

;+++
; convert integer word to decimal string
; d1.w=$abcd    (a0)-> '43981'
;
;               Entry                           Exit
;       d1.w    word integer                    preserved
;       a0      ptr to string                   preserved
;---
cnv_iwstr subr   d1/a0/a1
        suba.w  #6,sp
        move.l  sp,a1
        move.w  d1,(a1)
        xjsr    ut_iwdec
        adda.w  #6,sp
        subend

        end
