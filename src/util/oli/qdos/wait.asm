; wait for a while

        include win1_keys_qdos_sms
        include win1_mac_oli

        section  utility

        xdef    ut_wait

;+++
; wait (suspend a job) for a while
;
;               Entry                           Exit
;       d0      wait period                     error code
;       d1      job ID (or -1)                  preserved
;---
ut_wait subr    a0/a1/d3
        move.w  d0,d3
        suba.l  a1,a1
        moveq   #sms.ssjb,d0
        trap    #do.sms2
        tst.l   d0
        subend

        end
