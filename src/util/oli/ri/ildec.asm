; signed long integer number to decimal string

        include win1_keys_err
        include win1_mac_oli

        section string

        xdef    ut_ildec                ; number to string

;+++
; singed long integer number to string
;
;               Entry                   Exit
;       d1.l    number                  preserved
;       a0      ptr to string           preserved
;
; error codes: always ok
;---
frame   equ     20
ut_ildec subr a0/a1/a6
        move.l  sp,a1
        suba.w  #frame,sp
        suba.l  a6,a6
        move.l  d1,-(a1)
        xjsr    ut_lintfp               ; to fp
        xjsr    ut_fpdec                ; to dec
        adda.w  #frame,sp
        subend
        end
