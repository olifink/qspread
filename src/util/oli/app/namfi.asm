; get the real name of a filename               18/11-92
;
        section utility

        include win1_mac_oli

        xdef    ut_namfi        ; get NAMe from FIlename

;+++
; get name from filename
;
;       a0      ptr to filename
;       a1      ptr to string (is appended!)
;---
ut_namfi subr   a0/a1/a2/d1/d3
        move.w  (a0)+,d3
        moveq   #2,d0
        bra.s   lp1_end
lp1_top
        move.b  (a0,d3.w),d1    ; find the 2nd last underscore
        cmpi.b  #'_',d1
        bne.s   lp1_end
        subq.w  #1,d0
        beq.s   found
lp1_end
        dbra    d3,lp1_top
exit
        moveq   #0,d0
        subend

found   move.l  a1,a2           ; move to the end of the string
        add.w   (a1)+,a1
        addq.w  #1,d3
        moveq   #0,d1
fnd_lp
        move.b  (a0,d3.w),d0
        cmpi.b  #'_',d0
        beq.s   fnd_x
        move.b  d0,(a1)+
        addq.w  #1,d1
        addq.w  #1,d3
        bra.s   fnd_lp
fnd_x
        add.w   d1,(a2)
        bra.s   exit

        end
