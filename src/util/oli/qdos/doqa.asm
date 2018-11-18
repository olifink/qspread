; do arithmetic operation on stack                      24/09-92 O.Fink
;

        include win1_keys_qlv
        include win1_mac_oli

        section utility

        xdef    ut_doqa                 ; do one arithm. operation
        xdef    ut_domqa                ; do more arithm. operations

;+++
; do one arithmetic operation
;
;               Entry                   Exit
;       a1,a6.l stack                   updated
;       d0.w    operation               error code
;
; error codes: err.ovfl overflow
; condition codes set
;---
ut_doqa subr    a2/a3/a4/d7
        moveq   #0,d7
        move.l  d7,a3
        move.l  d7,a4
        move.w  qa.op,a2
        jsr     (a2)
        tst.l   d0
        subend

;+++
; do multiple arithmetic operations
;
;               Entry                   Exit
;       a1,a6.l stack                   updated
;       a3,a6.l ptr to operations list  preserved
;
; error codes: err.ovfl overflow
; condition codes set
;---
ut_domqa subr    a2/a4
        moveq   #0,d7
        move.l  d7,a4
        move.w  qa.mop,a2
        jsr     (a2)
        tst.l   d0
        subend

        end
