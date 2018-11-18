; insert one character in a string                    25/01-92 O.Fink

         section  string

         include  win1_keys_err

         xdef     st_insc                    ; insert one character

;+++
; insert one character in a string
; abcdef -> insert after 3 an 'x' -> string= abcxdef
;
;                 Entry                      Exit
;        a0       ptr to string              preserved
;        d1.w     pos. of char to insert after preserved
;        d2.b     character to insert        preserved
;
; error codes:    err.orng   character out of string
; condition codes set
;---
r_insc   reg      d1/d3
st_insc
         movem.l  r_insc,-(sp)
         moveq    #err.orng,d0
         move.w   (a0),d3
         cmp.w    d3,d1             ; position out of range
         bhi.s    insc_exit

         move.w   d3,d0             ; nr of chars to shift
         sub.w    d1,d0
         bra.s    insc_end
insc_lp
         move.b   1(a0,d3.w),2(a0,d3.w)      ; shift character right
         subq.w   #1,d3
insc_end
         dbra     d0,insc_lp
         move.b   d2,2(a0,d3.w)     ; put char
         addq.w   #1,(a0)           ; increase length
         moveq    #0,d0             ; no errors
insc_exit
         movem.l  (sp)+,r_insc
         tst.l    d0
         rts

         end
