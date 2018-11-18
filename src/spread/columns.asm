; QSpread Grid command
; - Insert columns

	include win1_mac_oli
	include win1_keys_wwork
	include win1_spread_keys

	section prog

	xdef	act_insc,act_delc

;+++
; delete columns
;
;		Entry			Exit
;	d5	col|row of position
;---
act_delc subr	d4/a5
	move.l	d5,d1
	swap	d5			; d5.w = Pos. of col where to start
	xjsr	acc_selc		; select column
	bne.s	delc_exit

delc_again
	moveq	#1,d1			; request number of columns
	bsr	req_col
	bne.s	delc_exit
	move.w	d1,d4			; d4.w = Nr. of cols to delete

	move.w	da_ncols(a6),d1 	; last column
	subq.w	#1,d1
	sub.w	d5,d1			; d1.w = max. nr. to delete
	cmp.w	d4,d1
	ble.s	delc_again

	move.l	da_cbx1(a6),d1		; make the whole range to remove
	swap	d1
	add.w	d4,d1
	subq.w	#1,d1
	swap	d1
	xjsr	cel_botr

	movem.l a3,-(sp)		; is he sure?
	xlea	ask_delc,a3
	xjsr	ask_yn
	movem.l (sp)+,a3
	tst.b	d1
	beq.s	delc_exit		; no, whimp

	clr.w	da_saved(a6)
	addq.w	#1,da_dupdt(a6)
	lea	acc_clr,a5		; clear rows to delete
	xjsr	mul_blok
	lea	decc_cell,a5		; now process the whole grid...
	xjsr	mul_grid
	subq.w	#1,da_dupdt(a6)

	bsr	del_col
	xjsr	acc_calc

delc_exit
	swap	d5
	move.l	d5,d1			; mark recently selected cell
	xjsr	cel_topl
	moveq	#0,d0
	subend

;+++
; delete columns, action routine for one cell
;
;		Entry			Exit
;	d1.l	col|row of currentcell
;	d4.w	nr. of cols to delete
;	d5.w	pos. of first col
;---
decc_cell subr	d1-d5/a1
	move.l	d1,d2
	swap	d2			; d2.w = cell.col
	lea	da_echf(a6),a1		; formula buffer
	xjsr	acc_getf		; get formula

	move.l	d0,d3
	swap	d3			; d3.w = format word

	tst.w	d0			; was it a string?
	bne.s	refd_no
	tst.w	(a1)			; any formula at all?
	beq.s	refd_no

	bsr.s	delcc_refs		; adjust references

refd_no
	xjsr	acc_clr 		; clear cell
	add.w	d4,d5
	cmp.w	d2,d5
	bhi.s	delcc_noadj

	swap	d1
	sub.w	d4,d1
	swap	d1

delcc_noadj
	tst.w	(a1)
	beq.s	delcc_exit

	xjsr	acc_putf
	move.w	d3,d2
	xjsr	acc_fwrd

delcc_exit
	moveq	#0,d0
	subend

; adjust formula references
delcc_refs subr  a0-a2
	lea	da_echf(a6),a0		; find references
	lea	da_echs(a6),a1
	lea	da_echl(a6),a2
	xjsr	cel_fref
	bsr.s	refi_adj		; adjust reference values
	xjsr	cel_rref		; resolve references
	subend

refi_adj subr	a2/d1
adi_lp	move.l	(a2),d1 		; get reference cell
	bmi.s	adi_ok			; end of list?

	swap	d1
	cmp.w	d1,d5			; check for correct column
	bhi.s	adi_ok

	sub.w	d4,d1			; calc new position
	swap	d1
	move.l	d1,(a2)+		; restore reference
	bra.s	adi_lp


adi_ok	subend


;+++
; insert columns
;
;		Entry			Exit
;	d5	col|row of position
;---
act_insc	subr	d4/a5
	moveq	#0,d1
	bsr	req_col 		; reqest number of columns
	bne.s	insc_exit
	clr.w	da_saved(a6)
	move.w	d1,d4			; d4.w = Nr. of columns
	clr.w	d5
	swap	d5			; d5.w = insert column position

	addq.w	#1,da_dupdt(a6)
	lea	insc_cell,a5		; now process the whole grid...
	xjsr	mul_rgrd		; .. in reverse order
	subq.w	#1,da_dupdt(a6)

	bsr	ins_col 		; adjust column widths
	xjsr	acc_calc		; re-calculate and redraw all

insc_exit
	moveq	#0,d0
	subend


;+++
; Insert columns, action for one cell
;
;		Entry			Exit
;	d1.l	col|row of cell 	preserved
;	d4.w	nr. of columns to ins	preserved
;	d5.w	position where to ins	preserved
;---
insc_cell subr d1-d4/d5/a1

	move.l	d1,d2
	swap	d2			; d2.w=cell.col
	lea	da_echf(a6),a1		; formula buffer
	xjsr	acc_getf		; get formula

	move.l	d0,d3
	swap	d3			; d3.w=format word

	tst.w	d0			; was it a string?
	bne.s	refs_no

	tst.w	(a1)			; any formula at all?
	beq.s	refs_no

	bsr.s	insc_refs		; adjust references

refs_no
	xjsr	acc_clr 		; clear cell d1
	cmp.w	d2,d5
	bhi.s	inscc_noadj

	swap	d1			; calc new position of cell
	add.w	d4,d1
	swap	d1

inscc_noadj
	tst.w	(a1)
	beq.s	inscc_exit

	xjsr	acc_putf		; put formula into new cell
	move.w	d3,d2
	xjsr	acc_fwrd		; set format word

inscc_exit
	moveq	#0,d0
	subend

insc_refs subr	a0-a2
	lea	da_echf(a6),a0		; find references
	lea	da_echs(a6),a1
	lea	da_echl(a6),a2
	xjsr	cel_fref
	bsr.s	refs_adj		; adjust reference values
	xjsr	cel_rref		; resolve references
	subend

refs_adj subr	a2/d1
adj_lp
	move.l	(a2),d1 		; get reference cell
	bmi.s	adj_ok			; end of list?

	swap	d1
	cmp.w	d1,d5			; check for correct column
	bhi.s	adj_ok

	add.w	d4,d1			; calc new position
	swap	d1
	move.l	d1,(a2)+		; restore reference
	bra.s	adj_lp

adj_ok	subend



;+++
; Request number of columns to insert/delete
;
;		Entry			Exit
;	d1.w	insert=0, delete <>0	value
;
; error and condition codes set (=1 ... ESC)
;---
req_col subr	a0/a2/a3/d2-d3
col_again
	move.w	d1,d0
	moveq	#-1,d1			; origin
	moveq	#0,d2
;;;	   move.b  colm(a6),d2		  ; main colourway
	moveq	#20,d3			; window width
	xlea	met_insc,a0
	xlea	msg_insc,a2
	tst.w	d0
	beq.s	reqc_ins

	xlea	met_delc,a0

reqc_ins
	lea	da_anbuf(a6),a3
	move.l	#$00013100,(a3) 	; default one column
	xjsr	mu_reqst
	bne.s	reqc_exit		; error or ESC?

	move.l	a3,a0			; ptr to string
	xjsr	con_decw		; convert to decimal
	cmp.w	da_ncols(a6),d0
	bge.s	col_again

	tst.w	d0
	beq.s	col_again

	move.w	d0,d1			; result
	moveq	#0,d0

reqc_exit
	tst.l	d0
	subend


; adjust column widths for insert
ins_col subr	a3/d2-d5
	move.l	ww_pappl(a4),a3
	move.l	(a3),a3 		; get first application window
	move.l	wwa_xspc(a3),a3 	; spacing list
	move.w	da_ncols(a6),d3 	; number of columns

insc_lp
	subq.w	#1,d3			; last column number
	cmp.w	d3,d5			; process..
	bgt.s	insc_lpe		; ..only columns needed

	bsr.s	do_insc
	bra.s	insc_lp

insc_lpe
	move.w	da_colwd(a6),d1 	; calc default column width
	mulu	#qs.xchar,d1
	addq.w	#2,d1
	move.w	d1,d2
	swap	d2
	move.w	d1,d2
	add.w	#2,d2

	mulu	#wwm.slen,d5
	lea	(a3,d5.l),a3
	bra.s	insc_lpe1

insc_lp1
	move.l	d2,(a3)+

insc_lpe1
	dbra	d4,insc_lp1

	moveq	#0,d0
	subend

do_insc subr	d1-d3
	moveq	#0,d2
	move.w	d3,d2
	add.w	d4,d2
	swap	d2
	move.l	d2,d1
	xjsr	in_grid 		; check if new row is still in grid
	bne.s	do_exit

	mulu	#wwm.slen,d3
	swap	d2
	mulu	#wwm.slen,d2
	move.l	(a3,d3.l),(a3,d2.l)	; copy width

do_exit
	subend

; adjust column widths for delete
del_col subr	a3/d2-d5
	move.l	ww_pappl(a4),a3
	move.l	(a3),a3 		; get first application window
	move.l	wwa_xspc(a3),a3 	; spacing list
	move.w	da_ncols(a6),d3 	; number of columns
	subq.w	#1,d3
	add.w	d4,d5
	move.w	d5,d2
	subq.w	#1,d2

delc_lp
	addq.w	#1,d2
	bsr.s	do_delc
	cmp.w	d2,d3
	bne.s	delc_lp

; set default widths of new columns
	move.w	da_colwd(a6),d1 	; calc default column width
	mulu	#qs.xchar,d1
	addq.w	#2,d1
	move.w	d1,d2
	swap	d2
	move.w	d1,d2
	add.w	#2,d2

	move.w	da_ncols(a6),d3 	; d3=last column number
	subq.w	#1,d3
	sub.w	d4,d3			; set the last (d4) columns...
	addq.w	#1,d3			; to default width
	mulu	#wwm.slen,d3
	lea	(a3,d3.l),a3
	bra.s	delc_lpe1

delc_lp1
	move.l	d2,(a3)+

delc_lpe1
	dbra	d4,delc_lp1

	moveq	#0,d0
	subend

do_delc subr	d1-d3
	move.w	d2,d3
	moveq	#0,d2
	move.w	d3,d2
	sub.w	d4,d2
	swap	d2
	move.l	d2,d1
	xjsr	in_grid 		; check if new pos is still in grid
	bne.s	dod_exit

	mulu	#wwm.slen,d3
	swap	d2
	mulu	#wwm.slen,d2
	move.l	(a3,d3.l),(a3,d2.l)	; copy width

dod_exit
	subend


	end
