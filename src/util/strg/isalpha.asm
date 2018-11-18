; check if character is alphabetic              11/09-92 O.Fink

        include win1_keys_err

subr     macro    rs
rxx      setstr   [rs]
[.lab]   movem.l  [rxx],-(sp)
         endm

subend   macro
[.lab]   movem.l  (sp)+,[rxx]
         rts
         endm


        section string

        xdef    st_isa

;+++
; check for alphabethic character
;
;               Entry                           Exit
;       d1.b    character                       preserved
;
; error codes:  err.nc          not alphabetic
; condition codes: set
;---
st_isa  subr    d2
        moveq   #err.nc,d0
        btst    #6,d1           ; only alpha allowed
        beq.s   type_x
        move.b  d1,d2
        andi.b  #%11111,d2
        subi.b  #26,d2
        bgt.s   type_x          ; exclude symbol block
        moveq   #0,d0
type_x  tst.l   d0
        subend

        end
