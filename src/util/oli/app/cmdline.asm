* Utilities                                           29/10-92 O.Fink
*        - parse command line parameter
*
         section  utility

         include  win1_keys_err
         include  win1_mac_oli

         xdef     ut_prscl

;+++
; parse command line and set options in data area
;
;                 Enry                       Exit
;        a1       ptr to command line        smashed
;        a2       ptr to switch table        preserved
;
; no errors
;
; the switch table has the following layout
;        dc.b     char,0            ; switch character (or -1)
;        dc.w     len               ; maximum parameter length
;        dc.w     offset            ; parameter address rel. (a6)
;---
ut_prscl subr    a0/d1-d4
         move.w   (a1)+,d3
         moveq    #0,d1                      ; don't find spaces
cli_lp   bsr.s    cli_getc                   ; get a character
         bne.s    cli_exit                   ; end of string?
cli_cmd  cmpi.b   #'\',d1                    ; command begin
         bne.s    cli_lp                     ; try next char

         bsr.s    cli_getc
         bne.s    cli_exit
         bset     #5,d1                      ; make it lower case
         move.l   a2,a0                      ; parameter table
cli_swlp move.b   (a0),d0
         bmi.s    cli_cmd                    ; end of table

         cmp.b    d0,d1                      ; the current switch?
         beq.s    cli_dosw
         addq.w   #6,a0                      ; next entry in table
         bra.s    cli_swlp


; get a parameter string
; a0 points to result area
; a1 command line ptr
; d4 maximum length
cli_dosw cmp.b    #1,1(a0)
         beq.s    cli_swch
         move.w   2(a0),d4                   ; maximum parameter length
         move.w   4(a0),d2
         lea      (a6,d2.w),a0               ; parameter area in data area
         moveq    #0,d2                      ; parameter length counter
clf_lp   bsr.s    cli_getc
         bne.s    clf_exit
         cmpi.b   #123,d1                    ; check parethesis
         bne.s    clf_nocb
         bset     #8,d1                      ; inside curly brackets
         bra.s    clf_lp
clf_nocb cmpi.b   #125,d1
         bne.s    clf_nccb
         bclr     #8,d1                      ; outside curly brackets
         bra.s    clf_lp
clf_nccb btst     #8,d1                      ; are we inside?
         bne.s    clf_pnth
         cmpi.b   #'\',d1
         beq.s    cli_cmd
clf_pnth move.b   d1,2(a0,d2.w)
         addq.w   #1,d2
         cmp.w    d4,d2                      ; check maximum length
         beq.s    clf_exit
         move.w   d2,(a0)
         bra.s    clf_lp
clf_exit bra      cli_lp

cli_exit moveq    #0,d0
         subend

cli_swch move.w   4(a0),d2
         st       (a6,d2.w)                  ; parameter area in data area
         bra.s    cli_lp

; gets the next character in string, or err.nc if end of string
; if bit 8 of d1 is set, spaces are found
cli_getc
         tst.w    d3
         beq.s    getc_err
         subq.w   #1,d3
         move.b   (a1)+,d1
         btst     #8,d1             ; spaces allowed
         bne.s    getc_sp
         cmpi.b   #' ',d1           ; strip spaces
         beq.s    cli_getc
getc_sp  moveq    #0,d0
         rts
getc_err
         moveq    #err.nc,d0
         rts
         end
