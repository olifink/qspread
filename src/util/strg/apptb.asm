; append spaces according to a tabulator to a string    18/01-92 O.Fink

         section  string

        include win1_keys_err

        xdef    st_apptb

;+++
; append spaces for tabulation
; "abc" (tab=8) -> apptb -> "abc     "
;
;                 Entry                      Exit
;        d1.w     tabulation width           preserved
;        a0       ptr to string              preserved
;
; error codes:    none
; condition codes: none
;---
r       reg     d1/d0/a1
st_apptb
        movem.l r,-(sp)
        move.w  (a0),d0
        ext.l   d0
        divu    d1,d0
        swap    d0
        neg.w   d0
        add.w   d1,d0
        bne.s   dotab
        move.w  d1,d0
dotab
        move.l  a0,a1
        move.w  (a1)+,d1
        add.w   d1,a1
        add.w   d0,(a0)
        bra.s   tblpe
tb      move.b  #' ',(a1)+
tblpe   dbra    d0,tb
        movem.l (sp)+,r
        rts

        end
