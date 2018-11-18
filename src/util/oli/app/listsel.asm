; List Select					      23/01-92 O.Fink

	section utility

	xdef	mu_listsl

	xref	ut_usmen
	xref	ut_frmen

	include win1_keys_thg
	include win1_keys_menu

;+++
; List select entry
;
;		Entry			Exit
;	D0.l				error, 0 or +1 for ESC
;	D1.l	origin or -1		preserved
;	D2.l	colourways (list|main)	preserved
;	D3.l	menu item control	option selected
;	D4.l	maxlines|maxcolmns	preserved
;	D5.l	stlisttype|itlisttype	preserved
;		(0=abs, 1=rel)
;	A0	window title		preserved
;	A2	ptr to item list	preserved
;	A3	ptr to status list
;---
mu_listsl
stk.frm equ	$44
slc_reg reg	d1/d2/d4/d5/a0-a2/a4-a5
	movem.l slc_reg,-(sp)
	sub.l	#stk.frm,sp
	move.l	sp,a5			; prepare workspace

	movem.l d1-d3,-(sp)
	move.l	#'LIST',d2
	jsr	ut_usmen
	movem.l (sp)+,d1-d3
	bne.s	slc_error		; cannot use menu
	move.l	a1,a4			; that's the Thing

	move.w	#thp.call+thp.str,ls_mennm-4(a5)
	move.l	a0,ls_mennm(a5)

	move.w	#thp.call+thp.arr+thp.str,d0
	swap	d0
	move.w	d5,d0
	move.l	d0,ls_itlty(a5)
	move.l	a2,ls_itlst(a5)

	swap	d5
	move.w	#thp.call+thp.arr+thp.str,d0
	swap	d0
	move.w	d5,d0
	move.l	d0,ls_stlty(a5)
	move.l	a3,ls_stlst(a5)

	move.l	d3,ls_mictl(a5)

	move.l	d4,ls_colms(a5)
	swap	d4
	move.l	d4,ls_lines(a5)
	move.l	d1,ls_ypos(a5)
	swap	d1
	move.l	d1,ls_xpos(a5)

	move.w	d2,d0
	ext.l	d0
	move.l	d0,ls_mainc(a5)
	swap	d2
	ext.l	d2
	move.l	d2,ls_listc(a5)

	move.w	#thp.ret+thp.uwrd,ls_item-4(a5)
	lea	$40(a5),a1
	move.l	a1,ls_item(a5)

	move.l	a5,a1			; the parameter table
	jsr	thh_code(a4)		; do request via menu
	bne.s	err_rts 		; failed, do not read return parameter
	move.w	$40(a5),d3		; return parameter

err_rts
	jsr	ut_frmen		; free menu
slc_error
	add.l	#stk.frm,sp		; adjust stack
	movem.l (sp)+,slc_reg
	tst.l	d0
	rts

	end
