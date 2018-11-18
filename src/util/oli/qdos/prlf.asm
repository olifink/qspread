; print a line feed to a given channel

        include win1_mac_oli

        section utility

        xdef    ut_prlf

;+++
; print a line feed to a given channel
;
;               Entry                           Exit
;       a0      channel id                      preserved
;
; errors: IOSS
;---
ut_prlf subr   d1
        moveq   #10,d1
        xjsr    ut_prchr
        subend

        end
