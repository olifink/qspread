; sort an array

        include win1_mac_oli

        section utility

        xdef    ut_sortar

;+++
; sort an 2 dim array
;
;               Entry                           Exit
;       d1.l    array type (0=abs,1=rel)        (always absolute array)
;       a0      array descriptor                new array descriptor
;---
ut_sortar subr  a1/d1/d2
        xjsr    ut_ar2nlst              ; create a new list from array
        bne.s   exit
        xjsr    ut_arsiz                ; get array size
        xjsr    ut_sortlst              ; sort list of pointers
        bne.s   exit
        xjsr    ut_arinf
        xjsr    ut_alar
        bne.s   exit
        move.l  a0,-(sp)
        xjsr    ut_arinf
        xjsr    ut_lst2ar               ; list to array contents
        xjsr    ut_relst
        move.l  (sp)+,a0
exit    tst.l   d0
        subend

        end
