; is string a valid decimal number                    29/01-92 O.Fink

         section  string

         include  win1_keys_err

         xdef     st_isdcc          ; is character decimal number
         xdef     st_isdcs          ; is string decimal number

;+++
; is character decimal number
;
;                 Entry                      Exit
;        d1.b     character                  preserved
;
; error codes: err.nc      no unsigned integer character
; condition codes set
;---
r_isdcc  reg      a0/d2
st_isdcc
         movem.l  r_isdcc,-(sp)
         moveq    #err.nc,d0
         lea      clist,a0
c_lp
         move.b   (a0)+,d2
         beq.s    c_exit            ; end of list?
         cmp.b    d1,d2
         bne.s    c_lp              ; not found in list
         moveq    #0,d0
c_exit
         movem.l  (sp)+,r_isdcc
         tst.l    d0
         rts
clist    dc.b     '0123456789+-.',0
         ds.w     0

;+++
; is string decimal number
;
;                 Entry                      Exit
;        a0       ptr to string              preserved
;
;
; error codes: err.nc      no decimal number
; condition codes set
;---
r_isdcs  reg      a0/d1/d2
st_isdcs
         movem.l  r_isdcs,-(sp)
         moveq    #err.nc,d0
         move.w   (a0)+,d2
         beq.s    s_exit
         bra.s    s_end
s_lp
         move.b   (a0)+,d1
         bsr      st_isdcc
         bne.s    s_exit
s_end
         dbra     d2,s_lp
s_exit
         movem.l  (sp)+,r_isdcs
         tst.l    d0
         rts

         end
