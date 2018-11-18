; Set priority of current job

        section utility

        xdef    ut_prior

        include win1_keys_qdos_sms
;+++
; Set priority of current job
;
;               Entry                           Exit
;       d0      priority                        smashed
;
;       Error return: invalid job
;       Condition codes set on return
;---
ut_prior
        movem.l d1-d2/a0,-(sp)
        moveq   #-1,d1
        move.w  d0,d2
        moveq   #sms.spjb,d0
        trap    #do.sms2
        movem.l (sp)+,d1-d2/a0
        tst.l   d0
        rts

        end
