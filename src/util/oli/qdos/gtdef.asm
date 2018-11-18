; get default directory string

        include win1_mac_oli
        include win1_keys_qdos_sms
        include win1_keys_sys

        section utility

        xdef    ut_gtdef                ; get a default directory
        xdef    ut_gtdd                 ; get Data Default directory
        xdef    ut_gtpd                 ; get Program Default directory
        xdef    ut_gtsd                 ; get deStination Default directory



ut_gtpd moveq   #-1,d0
        bra.s   ut_gtdef
ut_gtsd moveq   #1,d0
        bra.s   ut_gtdef
ut_gtdd moveq   #0,d0

;+++
; get a default directory
;
;               Entry                           Exit
;       a0      ptr to string                   preserved
;       d0.b    -1=prog default
;               0=data default
;               1=dest default
;---
ut_gtdef subr   a0/a1/a5/d1-d4
        clr.w   (a0)
        move.l  a0,a1           ; store parameter
        moveq   #0,d4
        move.b  d0,d4

        moveq   #sms.info,d0    ; get system variables
        trap    #do.sms2
        move.l  a0,a5

        moveq   #0,d0
        addq.b  #1,d4           ; get offset in sysvars
        lsl.l   #2,d4
        add.w   #sys_prgd,d4
        move.l  (a5,d4.l),d4    ; get ptr to directory
        beq.s   gtdef_exit

        move.l  a1,a0           ; copy directory name
        move.l  d4,a1
        xjsr    ut_cpyst

gtdef_exit
        tst.l   d0
        subend


        end
