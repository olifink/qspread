* Spreadsheet					      08/06-92
*	 -  find formula references

	 include  win1_mac_oli
	 include  win1_keys_err

	 xdef	  cel_fref	    ; find reference in formula
	 xdef	  cel_rref	    ; resolve reference in skeleton

	 section  prog

f_relref equ	  9		    ; $09 = reference replacement

;+++
; resolve references in formula string
;
;		  Entry 		     Exit
;	 a0	  ptr to forumla
;	 a1	  ptr to skeleton
;	 a2	  ptr to reference list
;
;---
cel_rref subr	  a0-a3/d1-d3
	 move.l   a0,a3 	    ; forula backup pointer
	 addq.w   #2,a0

rref_lp
	 move.b   (a1)+,d0
	 beq.s	  rref_lpx

	 cmpi.b   #f_relref,d0	    ; was it a reference?
	 beq.s	  res_ref	    ; yes, resolve reference

	 move.b   d0,(a0)+
	 bra.s	  rref_lp

rref_lpx
	 move.l   a0,d2
	 sub.l	  a3,d2
	 subq.w   #2,d2
	 move.w   d2,(a3)	    ; store formula length
	 moveq	  #0,d0
	 subend

res_ref
	 movem.l  a1/d2,-(sp)
	 suba.w   #20,sp	    ; make space for location string
	 move.l   sp,a1
	 move.l   (a2)+,d1	    ; number to be converted
	 moveq	  #-1,d2
	 xjsr	  con_rnge	    ; convert to range
	 move.w   (a1)+,d1
	 bra.s	  ref_lpe	    ; now copy range into formula

ref_lp
	 move.b   (a1)+,(a0)+

ref_lpe
	 dbra	  d1,ref_lp
	 adda.w   #20,sp
	 movem.l  (sp)+,a1/d1
	 bra.s	  rref_lp	    ; continue as usual

;+++
; find cell references in formula string
; (reference list is terminated by #-1.l
;
;		  Entry 		     Exit
;	 a0	  ptr to formula
;	 a1	  ptr to skeleton
;	 a2	  ptr to reference list
;
;---
fr_form  equ	  $00
fr_skel  equ	  $04
fr_temp  equ	  $08
fr_list  equ	  $0c
fr_frm2  equ	  $10
stk_frm  equ	  $14

f_nothg  equ	  0
f_alpha  equ	  1
f_first  equ	  2
f_numb	 equ	  -1
f_cell	 equ	  -2


cel_fref subr	  a0-a3/a5/d1-d5
	 suba.w   #stk_frm,a7
	 move.l   a7,a5

	 move.l   a0,fr_form(a5)	     ; store call values
	 move.l   a1,fr_skel(a5)
	 move.l   a2,fr_list(a5)

	 move.w   (a0),d0
	 addq.w   #2,d0
	 bclr	  #0,d0
	 move.w   d0,fr_frm2(a5)
	 suba.w   d0,sp

	 move.l   sp,a1
	 move.l   a1,fr_temp(a5)

	 move.w   (a0)+,d0		     ; copy string into a more
	 bra.s	  fr_lpe1		     ; parserfriendly format

fr_lp1
	 move.b   (a0)+,(a1)+

fr_lpe1
	 dbra	  d0,fr_lp1
	 move.b   #0,(a1)

	 move.l   fr_temp(a5),a0
	 move.l   fr_skel(a5),a1
	 move.l   fr_list(a5),a2
	 moveq	  #f_nothg,d4
	 moveq	  #0,d3
	 moveq	  #0,d5
	 moveq	  #1,d1

fr_lp2
	 tst.b	  d1
	 beq.s	  fr_end

	 move.b   (a0,d3.w),d1
	 bsr.s	  skip_abs
	 bsr.s	  is_cell
	 cmp.b	  #f_first,d4
	 bne.s	  fr_lb1

	 move.w   d3,d5

fr_lb1
	 move.b   d1,(a1)+
	 cmp.b	  #f_cell,d4
	 beq.s	  fr_fnd

	 addq.w   #1,d3
	 bra	  fr_lp2

fr_end
	 move.b   #0,(a1)

fr_exit
	 move.l   #-1,(a2)+
	 move.w   fr_frm2(a5),d0
	 adda.w   d0,sp
	 adda.w   #stk_frm,sp
	 moveq	  #0,d0
	 subend

skip_abs
	 cmpi.b   #91,d1
	 bne.s	  abs_exit

abs_lp
	 move.b   d1,(a1)+
	 addq.w   #1,d3
	 move.b   (a0,d3.w),d1
	 cmpi.b   #93,d1
	 bne.s	  abs_lp

	 moveq	  #f_nothg,d4

abs_exit
	 rts

fr_fnd
	 move.w   d3,d0
	 sub.w	  d5,d0
	 suba.w   d0,a1
	 subq.w   #1,a1
	 bsr.s	  fnd_rng
	 move.b   #f_relref,(a1)+
	 moveq	  #f_nothg,d4
	 bra	  fr_lb1

fnd_rng  subr	  a0/d1/d2
	 move.l   a1,a0
	 move.w   d0,d1
	 xjsr	  con_r2mx
	 bne.s	  rng_null

rng_set
	 move.l   d1,(a2)+
	 subend

rng_null
	 moveq	  #0,d1
	 bra	  rng_set


is_cell
	 tst.b	  d4
	 bmi.s	  c_numb		     ; numbers found<0

c_alpha
	 bsr.s	  is_alpha
	 bne.s	  ca_no
	 tst.b	  d4
	 bne.s	  ca_more

	 moveq	  #f_first,d4
	 bra.s	  cell_x

ca_more
	 moveq	  #f_alpha,d4		     ; still on alpha
	 bra.s	  cell_x

ca_no
	 tst.b	  d4
	 beq.s	  cell_x

	 bsr.s	  is_numb
	 bne.s	  can_no

	 moveq	  #f_numb,d4
	 bra.s	  cell_x

can_no
	 moveq	  #f_nothg,d4
	 bra.s	  cell_x

c_numb
	 bsr.s	  is_numb
	 beq.s	  cell_x

	 moveq	  #f_cell,d4

cell_x
	 rts


is_numb
	 moveq	  #err.orng,d0
	 cmp.b	  #'0',d1
	 blt.s	  num_exit

	 cmp.b	  #'9',d1
	 bgt.s	  num_exit

	 moveq	  #0,d0

num_exit
	 tst.l	  d0
	 rts

is_alpha subr	  d1
	 moveq	  #err.orng,d0
	 btst	  #6,d1
	 beq.s	  alp_exit

	 andi.b   #%00011111,d1
	 beq.s	  alp_exit

	 subi.b   #26,d1
	 bgt.s	  alp_exit

	 moveq	  #0,d0

alp_exit
	 tst.l	  d0
	 subend

	 end
