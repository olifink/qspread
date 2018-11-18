; append a character after a string                     06/01-92 O.Fink

         section  string

         include  win1_keys_err

         xdef     st_appc                    ; append a character

;+++
; append a character after a string (there must be enough space!)
; abcdef -> append 1 -> abcdef1
;
;                 Entry                      Exit
;        d1.b     character                  preserved
;        a0       ptr to string              preserved
;
; error codes:    none
; condition codes set
;---
st_appc
         move.w   (a0),d0
         addq.w   #1,d0
         move.w   d0,(a0)
         move.b   d1,1(a0,d0.w)
         moveq    #0,d0
         rts

         end
