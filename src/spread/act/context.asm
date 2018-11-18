; Context menu and action routines	1998 Jochen Merz

	section program

	include win1_keys_wwork
	include win1_keys_wstatus
	include win1_keys_wman
	include win1_mac_xref
	include win1_spread_keys
	include win1_mac_assert

	xdef	mea_context
	xdef	do_context

	xref.l	wwa.context
	xref.s	wst_context

	xref.s	mli.ctx_eoblk,mli.ctx_units,mli.ctx_justify,mli.ctx_width
	xref.s	mli.ctx_delcol,mli.ctx_inscol,mli.ctx_delrow,mli.ctx_insrow

;+++
; The context menu is popped up, gets the loose menu item number returned
; in D0. The menu is removed and appropriate action is done.
;---
do_context
	movem.l d1-d7/a0-a5,-(sp)
	move.l	#wwa.context,d1 ; memory required
	lea	wst_context(a6),a1
	xlea	men_context,a3	; window definition
	xjsr	ut_setup_l
	bne	context_return

;;;	   movem.l d2/a3,-(sp)
;;;	   move.b  colm(a6),d2
;;;	   xjsr    wu_scmwn	   ; set colours
;;;	   movem.l (sp)+,d2/a3

	moveq	#-1,d1
	jsr	wm.pulld(a2)

	jsr	wm.wdraw(a2)

	jsr	wm.rptr(a2)	; read pointer
	xjsr	ut_unset	; remove menu
	xjsr	gu_fclos	; and close channel
	tst.l	d0
	blt.s	context_return
	bgt.s	a_command
	moveq	#-1,d0
	bra.s	context_return

a_command
	cmp.w	#mli.ctx_eoblk,d0   ; end of block handled by next routine
	beq.s	context_return
	movem.l (sp),d1-d7/a0-a5
	move.l	d0,-(sp)
	tst.w	da_cbx1(a6)	; do we have a block marked?
	bge.s	block_marked	; yes
	xjsr	cel_topl	; otherwise make this one the current cell
block_marked
	move.l	(sp)+,d0

	subq.w	#2,d0		; set number units
	beq.s	ctx_units
	subq.w	#1,d0		; set justification
	beq.s	ctx_justify
	subq.w	#1,d0
	beq.s	ctx_width	; cell width

	xlea	mod_insc,a3
	subq.w	#1,d0
	beq.s	mod_set
	xlea	mod_delc,a3
	subq.w	#1,d0
	beq.s	mod_set
	xlea	mod_insr,a3
	subq.w	#1,d0
	beq.s	mod_set
	xlea	mod_delr,a3
	subq.w	#1,d0
	beq.s	mod_set

	moveq	#-1,d0		; no valid selection
context_return
	movem.l (sp)+,d1-d7/a0-a5
	tst.l	d0
	rts

mea_context
	move.w	wwl_item(a3),d0
	move.b	#wsi.mkav,ws_litem(a1,d0.w)
	moveq	#-1,d3
	move.w	d0,-(sp)
	jsr	wm.ldraw(a2)
	moveq	#0,d0
	move.w	(sp)+,d0
	rts

ctx_units
	xjsr	cls_unit	; and call units menu for it
	bra.s	context_return

ctx_justify
	xjsr	cls_just	; and call justify menu
	bra.s	context_return

ctx_width
	xjsr	grd_wdth_men	; and call width menu
	bra.s	context_return

mod_set
	jsr	(a3)
	bra.s	context_return

	end
