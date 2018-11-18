; find jcb of job                                     19/08-92 O.Fink
;

         include  win1_keys_qdos_sms
         include  win1_keys_sys
         include  win1_keys_jcb
         include  win1_keys_err
         include  win1_mac_oli

         section  utility

         xdef     ut_fjcb

;+++
; find address of job control block (jcb)
;
;                 Entry                      Exit
;        d1.l     job ID (or -1)             preserved
;        a1                                  adr of jcb
;
; error codes: err.ijob
;---
ut_fjcb  subr     a0/d1/d2/d3
         move.l   d1,d3
         moveq    #sms.info,d0
         trap     #do.sms2
         tst.l    d3
         bpl.s    lb
         move.l   d1,d3
lb       move.l   d3,d2
         move.l   sys_jbtt(a0),d0            ; check size of job tabe
         sub.l    sys_jbtb(a0),d0
         lsr.l    #2,d0
         sub.w    d2,d0
         bmi.s    err_exit

         mulu     #4,d2                      ; check entry in jt
         move.l   sys_jbtb(a0),a0
         move.l   (a0,d2.l),d0
         bmi.s    err_exit

         move.l   d0,a0                      ; check job tag
         swap     d3
         cmp.w    jcb_tag(a0),d3
         bne.s    err_exit

         move.l   a0,a1
         moveq    #0,d0
exit
         subend

err_exit
         moveq    #err.ijob,d0
         bra.s    exit

         end
