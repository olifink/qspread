; format a number string			      06/01-92 O.Fink

	 section  utility

	 xdef	  ut_fnumb
	 xref	  ut_cpyst


;+++
; format a number string by the given format string (english)
;
;		  Entry 		     Exit
;	 d1.b	  =0 normal/=1 german
;	 a0	  ptr to format string	     preserved
;	 a1	  ptr to decimal number      preserved
;	 a2	  ptr to string buffer	     preserved
;---
c.digit  equ	  '#'
c.neg	 equ	  '-'
c.pos	 equ	  '+'
c.point  equ	  '.'
c.space  equ	  ' '
c.sep	 equ	  ','
c.sep2	 equ	  'Ÿ'
c.null	 equ	  '0'
c.err	 equ	  '*'
c.br1	 equ	  '('
c.br2	 equ	  ')'

r_fnumb  reg	  a0-a2/d0-d5
ut_fnumb
	 movem.l  r_fnumb,-(sp)

	 move.l   d1,d5
	 exg	  a1,a2
	 exg	  a0,a1 		     ; a0 is the final string
	 bsr	  ut_cpyst
	 bsr	  own_fpnt		     ; find decimal point in format
	 exg	  a1,a2
	 move.w   d1,d3 		     ; d3=decimal point in format

	 exg	  a0,a1
	 bsr	  own_fpnt		     ; find decimal point in number
	 move.w   d1,d4 		     ; d4=decimal point in number
	 exg	  a0,a1

	 bsr	  own_intg		     ; copy the integer part
	 bmi.s	  fnumb_err
	 bsr	  own_frac		     ; copy fractional part
	 bsr.s	  own_neg
	 tst.b	  d5
	 beq.s	  fnumb_exit
	 bsr.s	  own_germ		     ; german representation
fnumb_exit
	 movem.l  (sp)+,r_fnumb
	 rts
*
* fill the digits with stars if number won't fit into format
fnumb_err
	 exg	  a1,a2
	 bsr	  ut_cpyst		     ; copy format again
	 move.w   (a0)+,d0
	 bra.s	  err_end
err_lp
	 move.b   (a0),d1
	 cmpi.b   #c.digit,d1
	 beq.s	  err_fil
	 cmpi.b   #c.sep,d1
	 beq.s	  err_fil
	 cmpi.b   #c.sep2,d1
	 beq.s	  err_fil
	 cmpi.b   #c.point,d1
	 bne.s	  err_end
err_fil
	 move.b   #c.err,(a0)		     ; fill it with stars
err_end
	 addq.w   #1,a0
	 dbra	  d0,err_lp
	 bra.s	  fnumb_exit

;+++
; change output string to german (exchange , and . )
;
;		  Entry 		     Exit
;	 a0	  ptr to format 	     preserved
;---
r_germ	 reg	  a0/d0-d1
own_germ
	 movem.l  r_germ,-(sp)
	 move.w   (a0)+,d0
	 bra.s	  germ_end
germ_lp
	 move.b   (a0),d1
	 bsr.s	  mk_germ
	 move.b   d1,(a0)+
germ_end
	 dbra	  d1,germ_lp
	 movem.l  (sp)+,r_germ
	 rts

mk_germ
	 cmpi.b   #'.',d1
	 beq.s	  ret_gpt
	 cmpi.b   #',',d1
	 beq.s	  ret_gsp
	 rts
ret_gpt
	 moveq	  #',',d1
	 rts
ret_gsp
	 moveq	  #'.',d1
	 rts

;+++
; change output if number was negativ
;
;		  Entry 		     Exit
;	 a0	  ptr to format 	     preserved
;	 a1	  ptr to number 	     preserved
;---
r_neg	 reg	  a0/a1/d0-d3
own_neg
	 movem.l  r_neg,-(sp)
	 moveq	  #0,d1 		     ; d1 sign of number
	 cmpi.b   #c.neg,2(a1)
	 bne.s	  neg_lb1
	 moveq	  #-1,d1
neg_lb1
	 move.w   (a0)+,d0		     ; d0 length of format
	 bra.s	  neg_end1
neg_lp1
	 move.b   (a0),d2		     ; d2 current character
	 cmpi.b   #c.pos,d2
	 beq.s	  neg_set
	 cmpi.b   #c.neg,d2
	 beq.s	  neg_set
	 cmpi.b   #c.br1,d2
	 beq.s	  neg_set
	 cmpi.b   #c.br2,d2
	 bne.s	  neg_nchg
neg_set
	 tst.b	  d1			     ; test number sign
	 bmi.s	  neg_mkn

	 cmpi.b   #c.pos,d2		     ; make positive
	 beq.s	  neg_nchg
neg_spos
	 moveq	  #c.space,d2
	 bra.s	  neg_set2
neg_post
	 moveq	  #c.neg,d2
	 bra.s	  neg_set2
neg_mkn
	 cmpi.b   #c.pos,d2		     ; make negative
	 beq.s	  neg_post
neg_nchg
	 addq.w   #1,a0 		     ; get to next character
	 bra.s	  neg_end1
neg_set2
	 move.b   d2,(a0)+
neg_end1
	 dbra	  d0,neg_lp1
neg_exit
	 movem.l  (sp)+,r_neg
	 bsr.s	  sgn_flt		     ; floating sign
	 rts

r_sgn	 reg	  a0/d0/d2
sgn_flt
	 movem.l  r_sgn,-(sp)
	 move.w   (a0)+,d0
	 bra.s	  sgn_end1
sgn_lp1
	 move.b   (a0)+,d2
	 cmpi.b   #c.space,d2
	 bne.s	  sgn_lb2
sgn_end1
	 dbra	  d0,sgn_lp1
sgn_exit
	 movem.l  (sp)+,r_sgn
	 rts

sgn_lb2
	 cmpi.b   #1,d0 		     ; more thane one char left
	 bmi.s	  sgn_exit

	 cmpi.b   #c.pos,d2		     ; is it +,-,(
	 beq.s	  sgn_lb3
	 cmpi.b   #c.neg,d2
	 beq.s	  sgn_lb3
	 cmpi.b   #c.br1,d2
	 bne.s	  sgn_exit
sgn_lb3
	 cmpi.b   #c.sep,(a0)		     ; spare or seperator following?
	 beq.s	  sgn_lb4
	 cmpi.b   #c.sep2,(a0)
	 beq.s	  sgn_lb4
	 cmpi.b   #c.space,(a0)
	 bne.s	  sgn_exit
sgn_lb4
	 move.b   #c.space,-1(a0)	     ; shift sign char right
	 move.b   d2,(a0)
	 dbra	  d0,sgn_lp1
	 bra.s	  sgn_exit


;+++
; copy the fractional part from number into format
;
;		  Entry 		     Exit
;	 a0	  ptr to format 	     preserved
;	 a1	  ptr to number 	     preserved
;	 d3.w	  dec.point in format (or -1) preserved
;	 d4.w	  dec.point in number (or -1) preserved
;---
r_frac	 reg	  d2/d3/d4
own_frac
	 movem.l  r_frac,-(sp)
frac_lp
	 tst.w	  d3
	 bmi.s	  frac_exit		     ; no decimal point, no fraction..
	 addq.w   #1,d3 		     ; first fractional digit position
	 cmp.w	  (a0),d3		     ; any fractional digits
	 bpl.s	  frac_exit

	 moveq	  #c.null,d2
	 tst.w	  d4
	 bmi.s	  frac_set		     ; no decimal point, fract=0
	 addq.w   #1,d4
	 cmp.w	  (a1),d4		     ; any fractional digital at all
	 bpl.s	  frac_set
	 move.b   2(a1,d4.w),d2
frac_set
	 move.b   2(a0,d3.w),d0 	     ; get format character
	 cmpi.b   #c.digit,d0		     ; is it a # ?
	 bne.s	  frac_exit		     ; no, end reached
	 move.b   d2,2(a0,d3.w) 	     ; copy character
	 bra.s	  frac_lp

frac_exit
	 movem.l  (sp)+,r_frac
	 rts

;+++
; copy the integer par from number into format
;
;		  Entry 		     Exit
;	 a0	  ptr to format 	     preserved
;	 a1	  ptr to number 	     preserved
;	 d3.w	  dec.point in format (or -1) preserved
;	 d4.w	  dec.point in number (or -1) preserved
;
; error codes : err.nc	number too large to fit into string
;---
r_intg	 reg	  d3/d4
own_intg
	 movem.l  r_intg,-(sp)

	 moveq	  #0,d0
	 tst.w	  d3		    ; was there a decimal point
	 beq.s	  intg_exit	    ; at the beginning
	 bpl.s	  intg_lb1	    ; anywhere
	 move.w   (a0),d3	    ; nowhere, assume it at the end
intg_lb1
	 subq.w   #1,d3 	    ; get to position before decimal point

	 tst.w	  d4		    ; was there a decimal point in number
	 beq.s	  intg_nul	    ; at the beginning is null
	 bpl.s	  intg_lb2	    ; anywhere
	 move.w   (a1),d4	    ; nowhere, assume it at the end
intg_lb2
	 subq.w   #1,d4 	    ; get to position of before decimal point
intg_lp
	 move.b   2(a0,d3.w),d0     ; get format character
	 cmpi.b   #c.digit,d0	    ; is it a # ?
	 beq.s	  intg_dig
	 cmpi.b   #c.sep,d0
	 beq.s	  intg_sep	    ; seperator
	 cmpi.b   #c.sep2,d0
	 beq.s	  intg_sep
	 bne.s	  intg_nod	    ; no digit
intg_char
	 move.b   d1,2(a0,d3.w)     ; set character
intg_end
	 dbra	  d3,intg_lp
	 moveq	  #0,d0
	 tst.w	  d4
	 bmi.s	  intg_exit
	 moveq	  #-1,d0
intg_exit
	 movem.l  (sp)+,r_intg
	 tst.l	  d0
	 rts

intg_sep
	 moveq	  #c.space,d1
	 tst.w	  d4		    ; any digits left
	 bmi.s	  intg_char	    ; no, delete any other chars
intg_nod
	 bra.s	  intg_end	    ; else skip this character

intg_nul
	 moveq	  #c.null,d1	    ; integer part is null
	 moveq	  #-1,d4
	 bra.s	  intg_char
intg_dig
	 moveq	  #c.space,d1
	 tst.w	  d4		    ; any characters left?
	 bmi.s	  intg_char

	 move.b   2(a1,d4.w),d1     ; get number character
	 cmpi.b   #c.neg,d1
	 bne.s	  intg_skip
	 moveq	  #c.space,d1
intg_skip
	 subq.w   #1,d4
	 bra.s	  intg_char

;+++
; find decimal point in format string
;
;		  Entry 		     Exit
;	 a0	  ptr to string 	     preserved
;	 d1.w				     pos. of decimal point (or -1)
;---
own_fpnt
	 move.w   (a0),d1		     ; positional offset
	 bra.s	  fpnt_end
fpnt_lp
	 cmp.b	  #c.point,2(a0,d1.w)	     ; is it a decimal point?
	 beq.s	  fpnt_exit		     ; yes..
fpnt_end
	 dbra	  d1,fpnt_lp
fpnt_exit
	 rts


	 END
