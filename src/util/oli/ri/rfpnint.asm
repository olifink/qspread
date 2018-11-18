; round fp to nearest long int                          24/09-92 O.Fink
;

        include win1_keys_qlv
        include win1_mac_oli

        section utility

        xdef    ut_fpint                 ; int(fp)

;+++
; round fp to nearest long int
;
;               Entry                   Exit
;       a1,a6.l stack                   updated
;
; error codes: err.ovfl overflow
; condition codes set
;---
ut_fpint subr   d1/d4
        moveq   #qa.nlint,d0    ; round to nearest long int
        xjsr    ut_doqa
        bne.s   exit
        xjsr    ut_lintfp       ; long int to fp
exit
        subend

        end
