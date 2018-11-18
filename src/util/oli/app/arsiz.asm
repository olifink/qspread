; get 2 dim array size

        section utility

        include win1_mac_oli

        xdef    ut_arsiz

;+++
; get 2 dim array size
;
;               Entry                           Exit
;       d1.l                                    nr. of elements
;       a0      array descriptor                preserved
;---
ut_arsiz
ar_abs  moveq   #1,d1
        add.w   6(a0),d1                ; nr of elements
        rts

        end
