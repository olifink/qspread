;lint to fp                                 05/01-92 O.Fink

        section utility

        include win1_mac_oli
        include win1_keys_qlv

        xdef    ut_lintfp           ; long int to fp

;+++
; long integer to fp
;
;               Entry                           Exit
;       a1,a6   arithmetic stack pointer
;---
ut_lintfp subr      d1/d4
          move.l    (a1,a6.l),d1
          subq.w    #2,a1
          move.l    d1,d4
          clr.w     0(a6,a1.l)
          tst.l     d4
          beq.s     fp_null
          move.w    #$820,d2
fp_lp     subq.w    #1,d2
          asl.l     #1,d4
          bvc.s     fp_lp
          roxr.l    #1,d4
          move.w    d2,0(a6,a1.l)
fp_null   move.l    d4,2(a6,a1.l)
          moveq     #0,d0
          subend

          end
