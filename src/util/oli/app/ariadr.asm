; get item address in 2dim string array

        include win1_mac_oli
        include win1_keys_err

        section utility

        xdef    ut_ariadr

;+++
; get item address in 2dim string array
;
;               Entry                           Exit
;       d1.l    array type (0=abs,1=rel)        preserved
;       d2.w    item number                     preserved
;       a0      array desctiptor                preserved
;       a1                                      ptr to array item
;
; errors: orng  item number not in array
;---
ut_ariadr subr  a0/d1-d3
        move.w  d2,d3
        xjsr    ut_arinf
        sub.w   d3,d1
        bmi.s   error
        mulu    d2,d3
        lea     (a0,d3.l),a1
        moveq   #0,d0
exit    subend

error   moveq   #err.orng,d0
        bra.s   exit

        end

error
