; read current time and date from real time clock

        section utility

        include win1_mac_oli
        include win1_keys_qdos_sms

        xdef    ut_rrtc

;+++
; read current time and date from real time clock
;
;               Entry                           Exit
;       d1.l                                    time in seconds
;---
ut_rrtc subr    d2/a0
        moveq   #sms.rrtc,d0
        trap    #do.sms2
        subend

        end
