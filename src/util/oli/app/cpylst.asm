; copy list of pointers

        include win1_mac_oli

        section utility

        xdef    ut_cpylst

;+++
; copy list of pointers
;
;               Entry                   Exit
;       a0      from list               preserved
;       a1      to list                 preserved
;---
ut_cpylst subr   a0/a1
lp      move.l  (a0)+,(a1)+
        bne.s   lp
        subend

        end
