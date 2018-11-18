; append one string after another                     06/01-92 O.Fink

         section  string

         include  win1_keys_err

         xdef     st_appst                   ; append a string after another

;+++
; append a string after another (there must be enough space!)
; abcdef -> append 1234 -> abcdef1234
;
;                 Entry                      Exit
;        a0       ptr to string              preserved
;        a1       ptr to string appended     preserved
;
; error codes:    none
; condition codes set
;---
r_appst   reg      d1-d2/a0-a1
st_appst
         movem.l  r_appst,-(sp)

         move.w   (a1)+,d1
         move.w   (a0),d2           ; get old length
         add.w    d1,(a0)+          ; set new length
         adda.w   d2,a0             ; new position
         bra.s    app_end
app_lp
         move.b   (a1)+,(a0)+
app_end
         dbra     d1,app_lp

app_exit
         movem.l  (sp)+,r_appst
         rts

         end
