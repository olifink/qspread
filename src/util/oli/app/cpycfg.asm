; copy config infos to data area

        include win1_mac_oli

        section utility

        xdef    ut_cpycfg

;+++
; copy config infos to data area
;
;               Entry                           Exit
;       a0      copy list
;       a6      base of data area
;---
ut_cpycfg subr  a0/a1/a2
        move.l  a0,a2
lp      move.w  (a2)+,d0                ; get next item
        bmi.s   ok                      ; end of list marker
        move.l  a2,a1                   ; a1 is from ptr
        add.l   (a2)+,a1                ; this is relative to itself
        move.l  (a2)+,a0                ; a0 is to ptr
        adda.l  a6,a0                   ; this is relative to a6
        cmpi.w  #$08,d0
        beq.s   do_byte
        cmpi.w  #$0a,d0
        beq.s   do_word
        cmpi.w  #$0c,d0
        beq.s   do_long
        xjsr    ut_cpyst
        bra.s   lp
ok      moveq   #0,d0
exit    subend

do_byte move.b  (a1),(a0)
        bra.s   lp
do_word move.w  (a1),(a0)
        bra.s   lp
do_long move.l  (a1),(a0)
        bra.s   lp

        end
