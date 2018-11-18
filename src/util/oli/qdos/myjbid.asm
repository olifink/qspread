; find real job ID of myself

        include win1_mac_oli
        include win1_keys_qdos_sms

        section utility

        xdef    ut_myjbid

;+++
; find real job ID of myself
;
;               Entry                           Exit
;       d1.l                                    current job ID
;---
ut_myjbid subr  a0/d2
        moveq   #sms.info,d0
        trap    #do.sms2
        subend

        end
