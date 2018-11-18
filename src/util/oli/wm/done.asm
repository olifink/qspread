; was there a DO event ?

        include win1_keys_wstatus
        include win1_keys_qdos_pt

        section utility

        xdef    xwm_done                ; you DID it

;+++
; was there a DO event ?
; (it gets cleared)
;
;               Entry                   Exit
;       a1      status area             preserved
;
; CCR: Z yes, there was a DO
;---
xwm_done bclr   #pt..do,wsp_weve(a1)
        rts

        end
