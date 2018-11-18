; check for SMS2

        include win1_keys_qdos_sms
        include win1_mac_oli

        section utility

        xdef    ut_sms2

;+++
; check for sms2
;
; errors: ok, or sms2 only
;---
ut_sms2 subr    a0-a3/d1-d3
        moveq   #sms.info,d0
        trap    #do.sms2
        andi.l  #$ff00ffff,d2           ; blank out language
        cmp.l   #$32003030,d2
        bge.s   is_sms
        lea     sms_err,a0
        move.l  a0,d0
        bset    #31,d0
        bra.s   exit
is_sms  moveq   #0,d0
exit    tst.l   d0
        subend

sms_err qstrg   {Sorry... SMS2 only!}

        end
