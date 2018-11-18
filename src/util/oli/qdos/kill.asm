; Kill current job

        section utility

        xdef    ut_kill,gu_die

        include win1_keys_qdos_sms
;+++
; Kill current job
;---
ut_kill
gu_die
        moveq   #0,d3
        moveq   #-1,d1
        moveq   #sms.frjb,d0
        trap    #do.sms2

        end
