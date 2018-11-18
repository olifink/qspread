; find action routine

	include win1_keys_wstatus
	include win1_keys_err
	include win1_mac_oli
	include win1_spread_keys

	section prog

	xdef	do_find

	xref.l	wst_find,mli.fdwn,mli.ffrm,mv_find

;+++
; find ... (well it)
;---
do_find subr	a3-a4/d4
	lea	wst_find(a6),a3
	move.l	da_wwork(a6),a4
	move.b	ws_litem+mli.fdwn(a3),d4 ; search direction (set for downwards)
	move.l	da_cbx0(a6),d1		; current cell ...
	xjsr	in_used 		; ... in used area (???)
	bne.s	lpx

lp
	bsr.s	f_next			; get next cell
	bne.s	lpx

	bsr.s	do_cmp			; compare information
	beq.s	found

	bra.s	lp

lpx
	moveq	#0,d0
	subend

found
	xjsr	acc_goto
	bra.s	lpx


;
; compare formulae and buffer
do_cmp	subr	a0/a1/d1
	bsr.s	f_cell			; find information
	bne.s	cmp_x

	lea	mv_find(a6),a1		; find buffer
	moveq	#0,d0			; case independance
	moveq	#1,d1			; scanning position
	xjsr	st_fndst		; find string

cmp_x	subend


;
; get cell formula or display information
; a0 : information string
; error: itnf  no value/formula connected
f_cell	subr	a3
	xjsr	dta_vadr		; find value block
	bne.s	c_exit			; ..no block connected

	tst.b	wst_find+ws_litem+mli.ffrm(a6)
	bne.s	c_form

	lea	val_strg(a3),a0 	; get display string of value block

c_bye
	moveq	#0,d0

c_exit	subend

c_form
	move.l	val_form(a3),d0 	; any formula connected?
	beq.s	form_nf

	move.l	d0,a0
	bra.s	c_bye

form_nf
	moveq	#err.itnf,d0
	bra.s	c_exit



; get next cell number, according to search order
; d1.l
f_next
	tst.b	d4			; upwards or downwards?
	beq.s	f_upw

	xjmp	cel_nxtg
f_upw
	xjmp	cel_prvg

	end
