* base address of job
*

        include win1_keys_qdos_sms
        include win1_mac_oli

        section utility

        xdef    ut_jbase

;+++
; find base address of job
;
;               Entry                           Exit
;       d1.l    job ID (or -1)                  preserved
;       a1                                      base address of job
;
; errors: ijob
;---
ut_jbase subr   d1-d3/a0
        moveq   #0,d2                   ; system job at top of tree
        moveq   #sms.injb,d0            ; information on job
        trap    #do.sms2
        move.l  a0,a1
        tst.l   d0
        subend

        end
