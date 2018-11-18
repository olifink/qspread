; find one character in a string (reverse)             06/01-92 O.Fink

         section  string

         include win1_mac_oli
         include  win1_keys_err

         xdef     st_fndcr                   ; find one character reverse

;+++
; find one character in a string starting from the back
; abcdef -> find "d" -> d1=4
;
;                 Entry                      Exit
;        a0       ptr to string              preserved
;        d1.w     scanning position (>0)     position of character found
;        d2.b     character to look for      preserved
;
; error codes:    err.itnf          character not found in string
; condition codes set
;---
st_fndcr subr   a0/d2
        moveq   #err.itnf,d0
        cmp.w   (a0),d1
        bcs.s   inside
        move.w  (a0),d1
inside  tst.w   d1
        beq.s   exit
        cmp.b   1(a0,d1.w),d2
        beq.s   found
        dbra    d1,inside
exit    tst.l   d0
        subend

found   moveq   #0,d0
        bra.s   exit

         end
