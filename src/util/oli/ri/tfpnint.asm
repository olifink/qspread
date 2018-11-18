; truncate fp to long int fp                            18/11-92 O.Fink
;

        include win1_keys_qlv
        include win1_mac_oli

        section utility

        xdef    ut_fptint                ; int(fp)

;+++
; truncate fp to long int fp
;
;               Entry                   Exit
;       a1,a6.l stack                   updated
;
; error codes: err.ovfl overflow
; condition codes set
;---
ut_fptint subr   d1/d4
        subq.w  #6,a1           ; push 0.5
        move.l  #$08004000,(a1)
        clr.w   4(a1)
        moveq   #qa.sub,d0      ; x-0.5
        xjsr    ut_doqa
        bne.s   exit
        moveq   #qa.nlint,d0    ; round to nearest long int
        xjsr    ut_doqa
        bne.s   exit
        xjsr    ut_lintfp       ; long int to fp
exit
        subend

        end
