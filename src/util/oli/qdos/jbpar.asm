; get standard QDOS job parameters
;

        section utility

        include win1_mac_oli

        xdef    ut_jbpar

;+++
; get QDOS job parameters
;
;               Entry                        Exit
;       a1                                   ptr to command line
;       a2                                   ptr to channel ist
;       a7      bottom of data area          preserved
;---
ut_jbpar
        lea     4(sp),a2
        move.l  a2,a1
        move.w  (a1)+,d1         ; nr. of channels
        mulu    #4,d1
        adda.l  d1,a1
        rts

        end
