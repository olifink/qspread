* Spreadsheet					      06/03-92
*	 - external functions for parser

	 section  prog

	 include  win1_keys_qlv
	 include  win1_keys_err
	 include  win1_mac_oli
	 include  win1_spread_keys
	 include  win1_spread_fpars_keys
	 include  win1_spread_fpars_mac

	 xdef	  tab_fn


;
; external function table
tab_fn	 xfnlist  {col},0           ; col()
	 xfnlist  {row},0           ; row()
	 xfnlist  {sum},0           ; sum(r:r)  sum
	 xfnlist  {avg},0           ; avg(r:r)  average
	 xfnlist  {wdth},0          ; wdth(r:r) width of columns
	 xfnlist  {cnta},0          ; cnta(r:r) count all cells
	 xfnlist  {cnt},0           ; cnt(r:r)  count cells <> 0
	 xfnlist  {cntnum},0        ; cnt(r:r)  count numerical cells <> 0
	 xfnlist  {len},0           ; len(r)    length of cell
	 xfnlist  {rint},1          ; rint(x)   round to nearest integer
	 xfnlist  {int},1           ; int(x)    truncate to nearest integer
	 xfnlist  {sgn},1           ; sgn(x)    return sign of value
;	  xfnlist  {xfn},1           ; fxn(x)    external function call
	 xfnlist  {date},0          ; date()    date of today in seconds
	 xfnlist  {if},0            ; if(cond;true;false)
	 xfnlist

; external function if(c,t,f)
; test for condition, if <>0 return true else false
xfn_if
	 lea	  2(a0,d1.w),a4
	 adda.w   d2,a4
	 move.b   (a4),d4
	 move.b   #';',(a4)	  ; mark the end
	 move.l   d2,d1
	 xlea	  var_eval,a3
	 lea	  tab_fn,a2
	 xjsr	  prs_form	; parse sub-formula again
	 bne.s	  if_exit

	 bsr.s	  tst_ri
	 bne.s	  if_true

	 addq.w   #1,d1
	 moveq	  #';',d2
	 xjsr	  st_findc
	 bne.s	  if_exit

if_true
	 xjsr	  prs_form	    ; parse sub-formula again
	 move.b   d4,(a4)
	 tst.l	  d0

if_exit
	 rts

tst_ri
	 tst.l	  -4(a1)
	 bne.s	  tri1_x

	 tst.w	  -6(a1)

tri1_x
	 rts


; external function date()
; returns the column number of the current cell
xfn_date subr	  a6
	 moveq	  #err.iexp,d0
	 tst.w	  d1		    ; length of argument has to be 0
	 bne.s	  date_exit

	 xjsr	  ut_rrtc	    ; read real time clock
	 move.l   d1,-(a1)	    ; put it on stack
	 suba.l   a6,a6
	 xjsr	  ut_lintfp	    ; convert to floating point

date_exit subend

; external function sgn(x)
; returns -1 if x negative, 1 if positive, 0 if 0
xfn_sgn
	 subr	  a6

	 suba.l   a6,a6
	 move.l   2(a6,a1.l),d0    ; mantissa 0?
	 beq.s	  sgn_done

sgn_non_zero
	 bmi.s	  sgn_negative

	 move.w   #$0801,(a6,a1.l)  ; this is float 1
	 move.l   #$40000000,2(a6,a1.l)
	 bra.s	  sgn_done

sgn_negative
	 move.w   #$0800,(a6,a1.l)  ; this is float -1
	 move.l   #$80000000,2(a6,a1.l)

sgn_done
	 moveq	  #0,d0
	 subend

; external function rint(x)
; rounds x to the nearest integer
xfn_rint subr	  a6
	 suba.l   a6,a6
	 xjsr	ut_fpint
	 subend

; external function int(x)
; truncates x to the nearest integer
xfn_int  subr	  a6
	 suba.l   a6,a6
	 xjsr	  ut_fptint
	 subend


; external function len(r)
; returns the length of the string at cell r
xfn_len  subr	  a4
	 move.l   da_wwork(a6),a4
	 lea	  2(a0,d2.w),a0 	     ; get to range string
	 xjsr	  con_r2mx
	 bne.s	  len_exit

	 xjsr	  dta_vadr
	 bne.s	  len_null

	 move.w   val_strg(a3),-(a1)	     ; put length on the stack
	 move.w   val_fwrd(a3),d3
	 btst	  #fw..strg,d3		     ; was it a number
	 beq.s	  len_ret

	 btst	  #fw..cont,d3		     ; continuating string?
	 beq.s	  len_ret		     ; ..no

len_lp
	 xjsr	  cel_nxtc
	 bne.s	  len_ret

	 jsr	  dta_vadr
	 bne.s	  len_ret

	 move.w   val_fwrd(a3),d3
	 btst	  #fw..strg,d3		     ; was it a number
	 beq.s	  len_ret

	 move.w   val_strg(a3),d2
	 add.w	  d2,(a1)
	 btst	  #fw..cont,d3		     ; continuating string?
	 bne	  len_lp

len_ret
	 moveq	  #qa.float,d0		     ; float integer
	 xjsr	  prs_doqa

len_exit
	 subend

len_null
	 move.w   #0,-(a1)
	 bra.s	  len_ret

; external function col()
; returns the column number of the current cell
xfn_col
	 moveq	  #err.iexp,d0
	 tst.w	  d1		    ; length of argument has to be 0
	 bne.s	  col_exit

	 move.w   da_ccell(a6),-(a1); current cell column
	 addq.w   #1,(a1)
	 moveq	  #qa.float,d0	    ; float integer
	 xjsr	  prs_doqa

col_exit
	 rts

; external function row()
; returns the column number of the current cell
xfn_row
	 moveq	  #err.iexp,d0
	 tst.w	  d1		    ; length of argument has to be 0
	 bne.s	  row_exit

	 move.w   da_ccell+2(a6),-(a1) ; current cell row
	 addq.w   #1,(a1)
	 moveq	  #qa.float,d0	    ; float integer
	 xjsr	  prs_doqa

row_exit
	 rts


; external function sum(r:r)
;
r_sum	 reg	  d4/d5/d6/a5
xfn_sum
	 movem.l  r_sum,-(sp)
	 moveq	  #-1,d6

sum_do
	 moveq	  #err.iexp,d0
	 tst.w	  d1		    ; was there a parameter?
	 beq.s	  sum_exit	    ; ..no, error

	 adda.w   d2,a0
	 addq.w   #2,a0
	 xjsr	  con_r2mx	    ; ..yes, get it

	 moveq	  #err.iexp,d0	    ; was is valid?
	 tst.l	  d1
	 bmi.s	  sum_exit	    ; ..no error

	 move.l   da_cbx0(a6),d4    ; get old block
	 move.l   da_cbx1(a6),d5

	 move.l   d1,da_cbx0(a6)    ; the parameter range
	 move.l   d2,da_cbx1(a6)

	 suba.l   #6,a1 	    ; push 0
	 clr.l	  (a1)
	 clr.w	  4(a1)
	 lea	  sum_act,a5	    ; action routine
	 xjsr	  mul_blok	    ; over the block
	 bmi.s	  sum_bye

	 tst.l	  d6		    ; was it avg()?
	 bmi.s	  sum_bye

	 subq.w   #2,a1 	    ; push nr. of elements
	 move.w   d6,(a1)
	 moveq	  #qa.float,d0
	 xjsr	  prs_doqa
	 bmi.s	  sum_bye

	 moveq	  #qa.div,d0	    ; divide
	 xjsr	  prs_doqa

sum_bye
	 move.l   d4,da_cbx0(a6)    ; restore old values
	 move.l   d5,da_cbx1(a6)

sum_exit
	 movem.l  (sp)+,r_sum
	 rts

sum_act
	 xjsr	  var_val	    ; put value onto the stack
	 tst.l	  d6
	 bpl	  avg_act

sum_cont
	 moveq	  #qa.add,d0
	 bsr	  prs_doqa
	 rts




; external function cnt(r:r)
;
r_cnt	 reg	  d4/d5/d6/a5
xfn_cnt
	 movem.l  r_cnt,-(sp)
	 moveq	  #err.iexp,d0
	 tst.w	  d1		    ; was there a parameter?
	 beq.s	  cnt_exit	    ; ..no, error

	 adda.w   d2,a0
	 addq.w   #2,a0
	 bsr	  con_r2mx	    ; ..yes, get it

	 moveq	  #err.iexp,d0	    ; was is valid?
	 tst.l	  d1
	 bmi.s	  cnt_exit	    ; ..no error

	 move.l   da_cbx0(a6),d4    ; get old block
	 move.l   da_cbx1(a6),d5

	 move.l   d1,da_cbx0(a6)    ; the parameter range
	 move.l   d2,da_cbx1(a6)

	 moveq	  #0,d6
	 lea	  cnt_act,a5	    ; action routine
	 bsr	  mul_blok	    ; over the block
	 bmi.s	  cnt_bye

	 subq.w   #2,a1 	    ; push nr. of elements
	 move.w   d6,(a1)
	 moveq	  #qa.float,d0
	 bsr	  prs_doqa

cnt_bye
	 move.l   d4,da_cbx0(a6)    ; restore old values
	 move.l   d5,da_cbx1(a6)

cnt_exit
	 movem.l  (sp)+,r_cnt
	 rts

cnt_act
	 xjsr	  var_isv	    ; any value connected
	 bne.s	  cnta_x

	 addq.l   #1,d6

cnta_x
	 moveq	  #0,d0
	 rts

; external function cnt(r:r)
;
xfn_cntnum
	movem.l r_cnt,-(sp)
	moveq	#err.iexp,d0
	tst.w	d1		; was there a parameter?
	beq.s	cnt_exit	; ..no, error

	adda.w	d2,a0
	addq.w	#2,a0
	bsr	con_r2mx	; ..yes, get it

	moveq	#err.iexp,d0	; was is valid?
	tst.l	d1
	bmi.s	cnt_exit	; ..no error

	move.l	da_cbx0(a6),d4	; get old block
	move.l	da_cbx1(a6),d5

	move.l	d1,da_cbx0(a6)	; the parameter range
	move.l	d2,da_cbx1(a6)

	moveq	#0,d6
	lea	cntnum_act,a5	; action routine
	bsr	mul_blok	; over the block
	bmi.s	cntnum_bye

	subq.w	#2,a1		; push nr. of elements
	move.w	d6,(a1)
	moveq	#qa.float,d0
	bsr	prs_doqa

cntnum_bye
	move.l	d4,da_cbx0(a6)	; restore old values
	move.l	d5,da_cbx1(a6)
	bra.s	cnt_exit

cntnum_act
	xjsr	var_chkval	; any value connected
	ble.s	cnta_x

	addq.l	#1,d6		; another one found
	bra.s	cnta_x


; external function cnta(r:r)
;
r_cna	 reg	  d4/d5/d6/a5
xfn_cnta
	 movem.l  r_cna,-(sp)
	 moveq	  #err.iexp,d0
	 tst.w	  d1		    ; was there a parameter?
	 beq.s	  cna_exit	    ; ..no, error

	 adda.w   d2,a0
	 addq.w   #2,a0
	 bsr	  con_r2mx	    ; ..yes, get it

	 moveq	  #err.iexp,d0	    ; was is valid?
	 tst.l	  d1
	 bmi.s	  cna_exit	    ; ..no error

	 move.l   da_cbx0(a6),d4    ; get old block
	 move.l   da_cbx1(a6),d5

	 move.l   d1,da_cbx0(a6)    ; the parameter range
	 move.l   d2,da_cbx1(a6)

	 moveq	  #0,d6
	 lea	  cna_act,a5	    ; action routine
	 bsr	  mul_blok	    ; over the block
	 bmi.s	  cna_bye

	 subq.w   #2,a1 	    ; push nr. of elements
	 move.w   d6,(a1)
	 moveq	  #qa.float,d0
	 bsr	  prs_doqa

cna_bye
	 move.l   d4,da_cbx0(a6)    ; restore old values
	 move.l   d5,da_cbx1(a6)

cna_exit
	 movem.l  (sp)+,r_cna
	 rts

cna_act
	 addq.l   #1,d6
	 moveq	  #0,d0
	 rts





; external function wdth(r:r)
;
r_wdt	 reg	  d3/d4/d5/a5
xfn_wdth
	 movem.l  r_wdt,-(sp)
	 moveq	  #err.iexp,d0
	 tst.w	  d1		    ; was there a parameter?
	 beq.s	  wdt_exit	    ; ..no, error

	 adda.w   d2,a0
	 addq.w   #2,a0
	 bsr	  con_r2mx	    ; ..yes, get it

	 moveq	  #err.iexp,d0	    ; was is valid?
	 tst.l	  d1
	 bmi.s	  wdt_exit	    ; ..no error

	 move.l   da_cbx0(a6),d4    ; get old block
	 move.l   da_cbx1(a6),d5

	 clr.w	  d1
	 clr.w	  d2
	 move.l   d1,da_cbx0(a6)    ; the parameter range
	 move.l   d2,da_cbx1(a6)

	 suba.l   #6,a1 	    ; push 0
	 clr.l	  (a1)
	 clr.w	  4(a1)
	 lea	  wdt_act,a5	    ; action routine
	 bsr	  mul_blok	    ; over the block

	 move.l   d4,da_cbx0(a6)    ; restore old values
	 move.l   d5,da_cbx1(a6)

wdt_exit
	 movem.l  (sp)+,r_wdt
	 rts

wdt_act
	 xjsr	  cel_wdth	     ; put value onto the stack
	 move.w   d3,-(a1)
	 moveq	  #qa.float,d0
	 bsr	  prs_doqa
	 bmi.s	  wdta_exit

	 moveq	  #qa.add,d0	    ; add for multiple columns
	 bsr	  prs_doqa

wdta_exit
	 rts

; external function average
;
xfn_avg
	 movem.l  r_sum,-(sp)
	 moveq	  #0,d6
	 bra	  sum_do

avg_act
	 addq.w   #1,d6
	 bra	  sum_cont

	 end

; external function xfn(x)
; executes external job
;xfn_xfn  subr	   a0-a2
;	  tst.w    da_extnf(a6)
;	  beq.s    xfn_exit
;
;	  move.l   a1,d1	     ; transfer top of stack
;	  lea	   da_anbuf(a6),a0
;	  xjsr	   ut_ildec
;	  xjsr	   st_xpnde
;	  move.l   a0,a2
;	  move.l   #$0020ffff,d1     ; add. dataspace, owner
;	  lea	   da_extnf(a6),a0
;	  xjsr	   ut_ldexe
;	  bne.s    xfn_exit
;
;	  suba.l   a0,a0	     ; input channel
;	  suba.l   a1,a1	     ; output channel
;	  moveq    #32,d2	     ; pritority
;	  moveq    #-1,d3	     ; wait for job to complete
;	  xjsr	   ut_acjb	     ; activate job
;
;xfn_exit moveq    #0,d0
;	  subend
