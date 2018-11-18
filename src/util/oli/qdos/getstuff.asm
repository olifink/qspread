; Get HOTKEY buffer                          09/01-92 O.Fink

        section utility

        include win1_keys_hk_vector

        xdef    ut_getbf

        xref    ut_hkuse
        xref    ut_hkfre

;+++
; Get stuffer buffer contents
;
;               Entry                   Exit
;       D0      key: 0=current/-1=prev. always succeeds
;       A1      buffer                  preserved
;---
ut_getbf
        movem.l a0-a3,-(sp)
        move.l  a1,a0
        bsr     ut_hkuse
        bne.s   stf_err
        move.l  hk.gtbuf(a3),a2
        jsr     (a2)
        bsr     ut_hkfre
        move.w  d0,(a0)+
        bra.s   lpe
lp      move.b  (a1)+,(a0)+
lpe     dbra    d0,lp
        moveq   #0,d0
stf_err
        movem.l (sp)+,a0-a3
        rts

        end
