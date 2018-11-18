; is string a valid unsigned integer                  27/01-92 O.Fink

         section  string

         include  win1_keys_err

         xdef     st_isuic          ; is character unsigned integer
         xdef     st_isuis          ; is string unsigned integer

;+++
; is character unsigned integer
;
;                 Entry                      Exit
;        d1.b     character                  preserved
;
; error codes: err.nc      no unsigned integer character
; condition codes set
;---
st_isuic
         moveq    #err.nc,d0
         cmpi.b   #'0',d1
         blt.s    c_exit
         cmpi.b   #'9',d1
         bhi.s    c_exit
         moveq    #0,d0
c_exit
         tst.l    d0
         rts

;+++
; is string unsigned integer
;
;                 Entry                      Exit
;        a0       ptr to string              preserved
;
;
; error codes: err.nc      no unsigned integer string
; condition codes set
;---
r_isuis  reg      a0/d1/d2
st_isuis
         movem.l  r_isuis,-(sp)
         moveq    #err.nc,d0
         move.w   (a0)+,d2
         beq.s    s_exit
         bra.s    s_end
s_lp
         move.b   (a0)+,d1
         bsr      st_isuic
         bne.s    s_exit
s_end
         dbra     d2,s_lp
s_exit
         movem.l  (sp)+,r_isuis
         tst.l    d0
         rts

         end
