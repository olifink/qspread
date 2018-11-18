* Formular Parser				      18/12-91
*	 - item scanning

	 include  win1_spread_fpars_keys
	 include  win1_mac_oli
	 include win1_keys_err

	 xdef	  prs_item

	 section  pars

*+++
* Get Item from formular string
*
*		  Entry 		    Exit
*	 A0   pointer to formular string    preserved
*	 A1   item buffer		    preserved
*	 D1.w parsing position		    updated
*	 D2.b				    delimiter code
*
*	 D0 error code set
*---
prs_item subr	  a0/a1/d4/d5
	 move.w   (a0)+,d5
	 moveq	  #0,d4 		     ; item length counter

item_nxt
	 moveq	  #cc.end,d0		     ; signal end delimiter
	 cmp.w	  d1,d5 		     ; ..if char would be
	 beq.s	  item_fnd		     ; ..outside the string

	 move.b   (a0,d1.w),d0		     ; current character
	 addq.w   #1,d1 		     ; parsing position counter
	 cmpi.b   #' ',d0		     ; spaces have no effect..
	 beq.s	  item_nxt		     ; ..whatsoever

	 bsr.s	  prs_dtst		     ; test for delimiting character
	 beq.s	  item_delfnd		     ; found something

	 move.b   d0,2(a1,d4.w) 	     ; put character in item buffer
	 addq.w   #1,d4 		     ; update item count
	 bra.s	  item_nxt		     ; try next character

item_delfnd
	cmp.w	#1,d1			; first item? cannot be delimiter!
	bne.s	item_fnd
	cmp.b	#'(',d0 		; open bracket is allowed, however
	beq.s	item_fnd
	cmp.b	#'-',d0 		; ... and negative sign
	beq.s	item_fnd
err_iexp
	moveq	#err.iexp,d0		; return error in expression
	bra.s	item_return

item_fnd
	cmp.b	#'-',d0 		; negative at end?
	bne.s	item_fnd2
	cmp.w	d1,d5			; end of string?
	beq.s	err_iexp		; not allowed!!!s

item_fnd2
	 bsr	  tst_end
	 beq.s	  item_x

	 move.b   d0,d2 		     ; store current delimiter
	 lsl.w	  #8,d2
	 move.b   (a0,d1.w),d2
	move.w	d2,-(sp)
	 bsr.s	  tst_cmp		     ; find cmp operation
	 bne.s	  item_dbl		     ; not found, use old
	move.w	(sp)+,d2

	cmp.b	(a0,d1.w),d0		; same character?
	bne.s	item_x			; no, must be okay
	cmp.w	#cc.open<<8+cc.open,d2	; only open and close brackets ..
	beq.s	item_x			; .. may occur twice or more times
	cmp.w	#cc.clos<<8+cc.clos,d2
	beq.s	item_x
	moveq	#err.ipar,d0
	bra.s	item_return

item_dbl
	addq.w	#2,sp			; adjust stack
	 move.b   d2,d0
	 addq.w   #1,d1

item_x
	 move.w   d4,(a1)		     ; set length of item buffer
	 move.b   d0,d2 		     ; return delimiter code
	 moveq	  #0,d0 		     ; return no errors
item_return
	 subend

*
* test for delimiting character
prs_dtst subr	  a0/d1
	 lea	  prs_dlst,a0		     ; start of character list

dtst_nxt
	 move.b   (a0)+,d1		     ; possible character
	 cmp.b	  #-1,d1		     ; end of list found
	 beq.s	  dtst_end

	 cmp.b	  d0,d1 		     ; matching character?
	 bne.s	  dtst_nxt		     ; test next character

	 moveq	  #0,d1
	 bsr.s	  tst_cmp		     ; test for multiple char delim.

dtst_end
	 tst.b	  d1			     ; set condition code
	 subend

	 ds.w	  0			     ; word alinged
prs_dlst dc.b	  op.add,op.sub
	 dc.b	  op.mul,op.div
	 dc.b	  op.pow,op.perc
	 dc.b	  cc.open,cc.clos
	 dc.b	  cc.end1,cc.end2
	 dc.b	  cp.and,cp.or
	 dc.b	  cp.not,cp.eq
	 dc.b	  cp.gt,cp.lt
	 dc.b	  -1			     ; end of list
	 ds.w	0

cmp_lst  dc.w	  cp.ne,cpc.ne		     ; multiple char operators
	 dc.w	  cp.ge,cpc.ge
	 dc.w	  cp.le,cpc.le
	 dc.w	  -1,0

; test compare operation
; d2.w 2 char operation
tst_cmp  subr	  a0/d0/d3
	 lea	  cmp_lst,a0

cmp_lp
	 move.w   (a0)+,d0
	 move.w   (a0)+,d3
	 beq.s	  cmp_exit

	 cmp.w	  d0,d2
	 bne.s	  cmp_lp
;;;	    move.w   d2,d3
cmp_exit
	 move.w   d3,d2
	 subend

; test for end character
; d0 char, Z set if end character
tst_end
	 cmp.b	  #cc.end,d0
	 beq.s	  tend_x

	 cmp.b	  #cc.end1,d0
	 beq.s	  tend_x

	 cmp.b	  #cc.end2,d0

tend_x
	 rts

	 end
