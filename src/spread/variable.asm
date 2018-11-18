* Spreadsheet					V0.01
*	 - variable evaluation

	 section  prog

	 include  win1_keys_wman
	 include  win1_keys_wwork
	 include  win1_keys_wstatus
	 include  win1_keys_err
	 include  win1_mac_oli
	 include  win1_spread_keys

	 xdef	  var_eval
	 xdef	  var_val
	xdef	var_isv 	; is a value connected?
	xdef	var_chkval	; enquire type of value

*+++
* constant number connected to the variable name?
*
*	 a0	  ptr to variable name	     preserved
*	 a1	  ptr to stack		     updated
*
* errors: err.nc  no const connected
* condition codes set
*---
var_const subr	  a0/a2/d1
	 move.l   a1,a2 	    ; save stack pointer
	 lea	  const_tab,a1

const_lp
	 moveq	  #err.nc,d0
	 move.w   (a1),d1	    ; length of current constant
	 bmi.s	  const_exit	    ; end of constant table

	 cmp.w	  (a0),d1	    ; same length?
	 bne.s	  const_exit	    ; no, can't be this constant

	 moveq	  #0,d0 	    ; compare caseindependant
	 moveq	  #1,d1 	    ; start at posn 1
	 xjsr	  st_fndst	    ; find string
	 bne.s	  const_nxt

	 subq.w   #1,d1
	 beq.s	  const_fnd

const_nxt
	 adda.w   #12,a1
	 bra.s	  const_lp

const_fnd
	 move.l   8(a1),-(a2)	    ; place fp on stack
	 move.w   6(a1),-(a2)
	 moveq	  #0,d0

const_exit
	 move.l   a2,a1
	 tst.l	  d0
	 subend

const_tab dc.w	  2,'pi  ',$0802,$6487,$ed51
	 dc.w	  -1



*+++
* variable evaluation procedure
*
*		  Entry 		     Exit
*	 a0	  ptr to variable name	     ???
*	 a1	  ptr to stack		     updated
*
* error codes: err.itnf    variable not found
*---
r_eval
var_eval
	 bsr	  var_const		     ; any constant number connected
	 beq.s	  eval_exit		     ; ..to the name

	 exg	  a0,a1
	 xjsr	  con_strc		     ; convert to matrix number
	 exg	  a0,a1
	 bne.s	  eval_err

	 bsr.s	  var_val		     ; put its value on stack
	 moveq	  #0,d0

eval_exit
	 rts

eval_err
	 moveq	  #err.itnf,d0
	 rts


*+++
* get value of given cell
*
*		  Entry 		     Exit
*	 d1.l	  matrix number 	     preserved
*	 a1	  ptr to stack		     updated
*---
r_val	 reg	  d1/d2/a3/a4
var_val
	 movem.l  r_val,-(sp)
	 move.l   da_wwork(a6),a4	     ; grid working area
	 xjsr	  dta_madr		     ; get address
	 subq.w   #6,a1
	 move.l   wwm_pobj(a3),d2
	 beq.s	  val_zero

	 sub.l	  #val_strg,d2		     ; get to value
	 move.l   d2,a3
	 tst.w	  (a3)			     ; string ?
	 bmi.s	  val_zero

	 move.l   (a3),(a1)		     ; copy value
	 move.w   4(a3),4(a1)

val_exit
	 movem.l  (sp)+,r_val
	 rts


val_zero
	 clr.l	  (a1)
	 clr.w	  4(a1)
	 bra.s	  val_exit


*+++
* is there a value for the variable?
*
*		  Entry 		     Exit
*	 d1.l	  matrix number 	     preserved
*
* error codes: err.nf if no value connected
*---
r_isv	reg	 d1/d2/a3/a4
var_isv
	 movem.l  r_isv,-(sp)
	 moveq	  #err.itnf,d0
	 move.l   da_wwork(a6),a4	     ; grid working area
	 xjsr	  dta_madr		     ; get address
	 move.l   wwm_pobj(a3),d2
	 beq.s	  isv_exit

	 moveq	  #0,d0

isv_exit
	 movem.l  (sp)+,r_isv
	 tst.l	  d0
	 rts

*+++
* Inquire type of variable or value
*
*		Entry			Exit
*	d0.l				0 no value, -1 string, +1 number
*	d1.l	matrix number		preserved
*---
var_chkval
	movem.l r_isv,-(sp)
	move.l	da_wwork(a6),a4 	; grid working area
	xjsr	dta_madr		; get address
	move.l	wwm_pobj(a3),d0 	; empty, return 0
	beq.s	isv_exit
	move.l	d0,a3
	moveq	#-1,d0			; assume string
	sub.l	#val_strg,a3		; get to value
	tst.w	(a3)			; string ?
	bmi.s	isv_exit
	moveq	#1,d0			; must be number
	bra.s	isv_exit

	end
