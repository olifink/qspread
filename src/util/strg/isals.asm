; is string a valid alpha lower string                12/02-92 O.Fink

         section  string

         include  win1_keys_err

         xdef     st_isalc          ; is character alpha lower
         xdef     st_isals          ; is string alpha lower

;+++
; is character alpha lower character
;
;                 Entry                      Exit
;        d1.b     character                  preserved
;
; error codes: err.nc      no unsigned integer character
; condition codes set
;---
st_isalc
         moveq    #err.nc,d0
         cmpi.b   #'a',d1
         blt.s    c_exit
         cmpi.b   #'z',d1
         bhi.s    c_exit
         moveq    #0,d0
c_exit
         tst.l    d0
         rts

;+++
; is string alpha lower
;
;                 Entry                      Exit
;        a0       ptr to string              preserved
;
;
; error codes: err.nc      no unsigned alpha lower string
; condition codes set
;---
r_isals  reg      a0/d1/d2
st_isals
         movem.l  r_isals,-(sp)
         moveq    #err.nc,d0
         move.w   (a0)+,d2
         beq.s    s_exit
         bra.s    s_end
s_lp
         move.b   (a0)+,d1
         bsr      st_isalc
         bne.s    s_exit
s_end
         dbra     d2,s_lp
s_exit
         movem.l  (sp)+,r_isals
         tst.l    d0
         rts

         end
