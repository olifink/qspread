; bubble sort a list

        section utility

        include win1_mac_oli

        xdef    ut_bublst

;+++
; sort a string array
;
;               Entry                           Exit
;       a1      ptr to list
; errors
;---
ut_bublst subr   d4/a2
        move.l  a1,a2
sort_lp bsr     sort_go                 ; make one sort
        bne.s   sort_lp                 ; until no more changes
        subend

sort_go subr    a0/a1/a2
        moveq   #0,d4                   ; no elements changed
lp      move.l  (a2),d0                 ; get next pointer
        beq.s   exit                    ; end of list found?
        move.l  d0,a0                   ; ptr is first string
        move.l  4(a2),d0                ; get following element
        beq.s   exit                    ; end of list now?
        move.l  d0,a1                   ; this is 2nd string
        moveq   #1,d0                   ; basic comparison
        xjsr    st_cmpst                ; compare strings
        ble.s   nochg                   ; if first is bigger..
        move.l  a0,4(a2)                ; ..swap elements
        move.l  a1,(a2)
        moveq   #1,d4                   ; set changed flag
nochg   addq.w  #4,a2                   ; next element pair
        bra.s   lp
exit    tst.l   d4
        subend

        end
