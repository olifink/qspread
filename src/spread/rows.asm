; QSpread Gird command
; - Insert rows

	include win1_mac_oli
	include win1_keys_wwork
	include win1_spread_keys

	section prog

	xdef	act_insr,act_delr

;+++
; delete rows
;
;		Entry			Exit
;	d5	col|row of position
;---
act_delr subr	d4/a5
	move.l	d5,d1			; d5.w = Pos. of row where to start
	xjsr	acc_selr		; select row
	bne.s	delr_exit

delr_again
	moveq	#1,d1			; request number of rows
	bsr	req_row
	bne.s	delr_exit

	move.w	d1,d4			; d4.w = Nr. of rows to delete
	move.w	da_nrows(a6),d1 	; last row
	subq.w	#1,d1
	sub.w	d5,d1			; d1.w = max. nr. to delete
	cmp.w	d4,d1
	ble.s	delr_again

	move.l	da_cbx1(a6),d1		; make the whole range to remove
	add.w	d4,d1
	subq.w	#1,d1
	xjsr	cel_botr

	movem.l a3,-(sp)		; is he sure?
	xlea	ask_delr,a3
	xjsr	ask_yn
	movem.l (sp)+,a3
	tst.b	d1
	beq.s	delr_exit		; no, whimp

	clr.w	da_saved(a6)
	move.l	da_ordr(a6),-(sp)	; order for processing rows!!
	move.l	#$00010000,da_ordr(a6)	; (because of overflowing strings)

	addq.w	#1,da_dupdt(a6)
	lea	acc_clr,a5		; clear rows to delete
	xjsr	mul_blok
	lea	derc_cell,a5		; now process the whole grid...
	xjsr	mul_grid
	subq.w	#1,da_dupdt(a6)
	move.l	(sp)+,da_ordr(a6)

	xjsr	acc_calc

delr_exit
	move.l	d5,d1			; mark recently selected cell
	xjsr	cel_topl
	moveq	#0,d0
	subend

;+++
; delete rows, action routine for one cell
;
;		Entry			Exit
;	d1.l	col|row of currentcell
;	d4.w	nr. of cols to delete
;	d5.w	pos. of first col
;---
derc_cell subr	d1-d5/a1
	move.l	d1,d2			; d2.w = cell.row
	lea	da_echf(a6),a1		; formula buffer
	xjsr	acc_getf		; get formula

	move.l	d0,d3
	swap	d3			; d3.w = format word

	tst.w	d0			; was it a string?
	bne.s	refd_no

	tst.w	(a1)			; any formula at all?
	beq.s	refd_no

	bsr.s	delrc_refs		; adjust references

refd_no
	xjsr	acc_clr 		; clear cell
	add.w	d4,d5
	cmp.w	d2,d5
	bhi.s	delrc_noadj

	sub.w	d4,d1

delrc_noadj
	tst.w	(a1)
	beq.s	delrc_exit

	xjsr	acc_putf
	move.w	d3,d2
	xjsr	acc_fwrd

delrc_exit
	moveq	#0,d0
	subend

; adjust formula references
delrc_refs subr  a0-a2
	lea	da_echf(a6),a0		; find references
	lea	da_echs(a6),a1
	lea	da_echl(a6),a2
	xjsr	cel_fref
	bsr.s	refi_adj		; adjust reference values
	xjsr	cel_rref		; resolve references
	subend

refi_adj subr	a2/d1
adi_lp
	move.l	(a2),d1 		; get reference cell
	bmi.s	adi_ok			; end of list?

	cmp.w	d1,d5			; check for correct row
	bhi.s	adi_ok

	sub.w	d4,d1			; calc new position
	move.l	d1,(a2)+		; restore reference
	bra.s	adi_lp

adi_ok	subend



;+++
; insert rows
;
;		Entry			Exit
;	d5	col|row of position
;---
act_insr subr	 d4/a5
	moveq	#0,d1
	bsr	req_row 		; reqest number of rows
	bne.s	insr_exit

	clr.w	da_saved(a6)
	move.w	d1,d4			; d4.w = Nr. of rows
					; d5.w = insert row position

	addq.w	#1,da_dupdt(a6)
	lea	insr_cell,a5		; now process the whole grid...
	xjsr	mul_rgrd		; .. in reverse order
	subq.w	#1,da_dupdt(a6)

	xjsr	acc_calc		; re-calculate and redraw

insr_exit
	moveq	#0,d0
	subend


;+++
; Insert rows, action for one cell
;
;		Entry			Exit
;	d1.l	col|row of cell 	preserved
;	d4.w	nr. of rows to ins	preserved
;	d5.w	position where to ins	preserved
;---
insr_cell subr	d1-d5/a1
	move.l	d1,d2			; d2.w=cell.row
	lea	da_echf(a6),a1		; formula buffer
	xjsr	acc_getf		; get formula

	move.l	d0,d3
	swap	d3			; d3.w = format word

	tst.w	d0			; was it a string?
	bne.s	refs_no

	tst.w	(a1)			; any formula at all?
	beq.s	refs_no

	bsr.s	insr_refs		; adjust references

refs_no
	xjsr	acc_clr 		; clear cell d1
	cmp.w	d2,d5
	bgt.s	insrc_noadj

	add.w	d4,d1			; calc new position of cell

insrc_noadj
	tst.w	(a1)
	beq.s	insrc_exit
	xjsr	acc_putf		; put formula into new cell
	move.w	d3,d2			; change format word of cell
	xjsr	acc_fwrd
insrc_exit

	moveq	#0,d0
	subend

insr_refs subr	a0-a2
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

	cmp.w	d1,d5			; check for correct column
	bgt.s	adj_ok

	add.w	d4,d1			; calc new position
	move.l	d1,(a2)+		; restore reference
	bra.s	adj_lp

adj_ok	subend



;+++
; Request number of rows to insert
;
;		Entry			Exit
;	d1.w	insert=0, delete<>0	value
;
; error and condition codes set (=1 ... ESC)
;---
req_row subr	a0/a2/a3/d2-d3
row_again
	move.w	d1,d0
	moveq	#-1,d1			; origin
	moveq	#0,d2
;;;	   move.b  colm(a6),d2		  ; main colourway
	moveq	#20,d3			; window width
	xlea	met_insr,a0
	xlea	msg_insr,a2
	tst.w	d0
	beq.s	reqr_ins

	xlea	met_delr,a0

reqr_ins
	lea	da_anbuf(a6),a3
	move.l	#$00013100,(a3) 	; default one row
	xjsr	mu_reqst
	bne.s	reqr_exit		; error or ESC?

	move.l	a3,a0			; ptr to string
	xjsr	con_decw		; convert to decimal
	cmp.w	da_nrows(a6),d0
	bge.s	row_again

	tst.w	d0
	beq.s	row_again

	move.w	d0,d1			; result
	moveq	#0,d0

reqr_exit
	tst.l	d0
	subend

	end
