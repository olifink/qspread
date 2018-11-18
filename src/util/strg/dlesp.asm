; delete ending spaces from a string                 18/01-92 O.Fink

         section  string

         include  win1_mac_xref
         include  win1_keys_err

         xdef     st_dlesp                   ; delete ending spaces

;+++
; delete ending spaces from a string
; "abc  " -> dlesp -> "abc"
;
;                 Entry                      Exit
;        a0       ptr to string              preserved
;
; error codes:    none
; condition codes: none
;---
r_dllsp   reg      d0-d2
st_dlesp
         movem.l  r_dllsp,-(sp)
st_lp
         move.w   (a0),d1                    ; length of string
         beq.s    st_exit
         move.b   1(a0,d1.w),d2
         subi.b   #' ',d2
         bne.s    st_exit
         xbsr     st_delc                    ; delete character
         bra.s    st_lp

st_exit
         movem.l  (sp)+,r_dllsp
         rts

         end
