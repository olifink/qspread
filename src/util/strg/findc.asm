; find one character in a string                    06/01-92 O.Fink

         section  string

         include  win1_keys_err

         xdef     st_findc                   ; find one character

;+++
; find one character in a string
; abcdef -> find "d" -> d1=4
;
;                 Entry                      Exit
;        a0       ptr to string              preserved
;        d1.w     scanning position (>0)     position of character found
;        d2.b     character to look for      preserved
;
; error codes:    err.itnf          character not found in string
;                 err.orng          scanning position not in string
; condition codes set
;---
r_findc   reg      a0/d2/d3
st_findc
         movem.l  r_findc,-(sp)
         moveq    #0,d0
         tst.w    d1
         beq.s    find_exit                  ; zero scanning position
         moveq    #err.orng,d0
         move.w   (a0)+,d3
         sub.w    d1,d3
         addq.w   #1,d3
         bmi.s    find_exit

         moveq    #err.itnf,d0
         bra.s    find_end
find_lp
         cmp.b    -1(a0,d1.w),d2
         beq.s    found
         addq.w   #1,d1
find_end
         dbra     d3,find_lp
find_exit
         movem.l  (sp)+,r_findc
         tst.l    d0
         rts
found
         moveq    #0,d0
         bra.s    find_exit

         end
