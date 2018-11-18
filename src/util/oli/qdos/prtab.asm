; print a tab to a given channel

        include win1_mac_oli

        section utility

        xdef    ut_prtab

;+++
; print a tab to a given channel
;
;               Entry                           Exit
;       a0      channel id                      preserved
;
; errors: IOSS
;---
ut_prtab subr   d1
        moveq   #9,d1
        xjsr    ut_prchr
        subend

        end
