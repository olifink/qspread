; allocate memory for pointer list

        include win1_mac_oli

        section utility

        xdef    ut_allst,ut_relst

;+++
; allocate memory for pointer list
; (d1+1 long words)
;
;               Entry                           Exit
;       d1.l    nr of elements                  preserved
;       a1                                      ptr to list
;
; errors: err.imem
; cc set
;---
ut_allst subr   d1/a0
        addq.l  #1,d1
        lsl.l   #2,d1
        xjsr    ut_alchp
        move.l  a0,a1
        tst.l   d0
        subend

;+++
; release list
;
;       a1      ptr to list
;---
ut_relst subr   a0
        move.l  a1,a0
        xjsr    ut_rechp
        subend

        end
