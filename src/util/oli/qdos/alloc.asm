; Allocate memory                                     18/12-91 O.Fink

        include win1_keys_qdos_sms

        xdef    ut_alcmy
        xdef    ut_alcsys

        section utility

no.owner        equ     0

;+++
; allocate common heap space for myself
;
;                 Entry                      Exit
;        D1.l     number of bytes req.       nr. of bytes allocated
;        A0                                  base address of area
;
;        errors codes:  err.imem
;---
alreg    reg      d2/d3/a1-a3
ut_alcmy
         movem.l  alreg,-(sp)
         moveq    #sms.myjb,d2
         moveq    #sms.achp,d0
         trap     #do.sms2
         movem.l  (sp)+,alreg
         tst.l    d0
         rts


;+++
; allocate common heap space for system
;
;                 Entry                      Exit
;        D1.l     number of bytes req.       nr. of bytes allocated
;        A0                                  base address of area
;
;        errors codes:  err.imem
;---
ut_alcsys
         movem.l  alreg,-(sp)
         moveq    #no.owner,d2
         moveq    #sms.achp,d0
         trap     #do.sms2
         movem.l  (sp)+,alreg
         tst.l    d0
         rts

         end
