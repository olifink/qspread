; Execute a thing
;

        section utility

        xdef    ut_thex

        include win1_keys_qdos_sms
        include win1_keys_thg
        include win1_keys_err
        include win1_keys_sys
;+++
; Execute a thing
;
;                 Entry                      Exit
;        d1       owner                      Job ID
;        d2       priority/timeout            preserved
;        a0       thing name                 preserved
;        a1       parameter string           preserved
;
; condition codes set
;---
ut_thex
         movem.l  a4,-(sp)
         bsr.s    ut_thvec2             ; find th_exec
         bne.s    xx
         jsr     (a4)
xx
         movem.l  (sp)+,a4
         tst.l    d0
         rts

ut_thvec2
        movem.l d1-d2/d7/a0,-(sp)
        moveq   #sms.info,d0            ; get system variables
        trap    #do.sms2
        move.w  sr,d7                   ; save current sr
        trap    #0                      ; into supervisor mode
        move.l  sys_thgl(a0),d1         ; this is the Thing list
        beq.s   thvec_nf                ; empty list, very bad!
        move.l  d1,a0
thvec_lp
        move.l  (a0),d1                 ; get next list entry
        beq.s   th_found                ; end of list? Here should be THING!
        move.l  d1,a0                   ; next link
        bra     thvec_lp
thvec_nf
        moveq   #err.nimp,d0            ; THING does not exist
        bra.s   thvec_rt
th_found
        move.l  th_thing(a0),a0         ; get start of Thing
        cmp.l   #-1,thh_type(a0)        ; is it our special THING?
        bne.s   thvec_nf                ; sorry, it isn't
        move.l  12(a0),a4               ; this is the vector we look for
thvec_rt
        move.w  d7,sr
        movem.l (sp)+,d1-d2/d7/a0
        tst.l   d0
        rts

        end
