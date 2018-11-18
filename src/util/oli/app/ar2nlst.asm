; make array to new list

        include win1_mac_oli

        section utility

        xdef    ut_ar2nlst

;+++
; make array to new list
;
;               Entry                           Exit
;       d1.l    array type (0=abs,1=rel)        preserved
;       a0      array descriptor                preserved
;       a1                                      ptr to list space
;
; error: err.imem
; cc set
;---
ut_ar2nlst subr  a0/a2/d1/d2
        xjsr    ut_arinf                ; get array information
        xjsr    ut_allst                ; allocate list space
        bne.s   exit
        move.l  a1,a2
        bra.s   lpe
lp      move.l  a0,(a2)+
        add.w   d2,a0
lpe     dbra    d1,lp
        move.l  #0,(a2)                 ; 0 is end of list marker
exit    subend


        end
