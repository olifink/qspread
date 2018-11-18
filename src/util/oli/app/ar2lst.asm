; make array to list

        include win1_mac_oli

        section utility

        xdef    ut_ar2lst

;+++
; make array to list
;
;               Entry                           Exit
;       d1.l    array type (0=abs,1=rel)        preserved
;       a0      array descriptor                preserved
;       a1      ptr to list space               preserved
;---
ut_ar2lst subr  a0/a1/d1/d2
        xjsr    ut_arinf                ; get array information
        bra.s   lpe
lp      move.l  a0,(a1)+
        add.w   d2,a0
lpe     dbra    d1,lp
        move.l  #0,(a1)                ; 0 is end of list marker
        subend


        end
