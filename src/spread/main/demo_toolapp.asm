* Toolbar action routines

	include win1_keys_wman
	include win1_keys_wstatus
	include win1_keys_wwork
	include win1_keys_wdef_long
	include win1_keys_qdos_pt
	include win1_mac_xref
	include win1_mac_oli
	include win1_spread_keys

	section prog

	xdef	mea_toolcalc,mea_toolhelp,mea_digit,mea_money,mea_find
	xdef	mea_gwith,mea_toolload,mea_toolsave,mea_toolprint
	xdef	mea_toolcellecho,mea_toolcellcopy,mea_toolcellmove
	xdef	mea_toolcelldel,mea_toolcellprot,mea_toolscrap
	xdef	mea_tooljustlf,mea_tooljustrg,only_demo


only_demo
	movem.l d0-d2/a0,-(sp)
	xlea	met_demo,a0
	move.l	a0,d0
	bset	#31,d0			; special error
	moveq	#-1,d1			; show at pointer
	move.b	colm(a6),d2		; with config colourway
	xjsr	mu_rperr		; the error
	movem.l (sp)+,d0-d2/a0
	rts

mea_toolcalc
	movem.l d1-d5/a0-a5,-(sp)
	xjsr	grd_calc

mea_end
	movem.l (sp)+,d1-d5/a0-a5
	xjmp	ut_rdwci

mea_toolhelp
	movem.l d1-d5/a0-a5,-(sp)
	cmp.b	#2,d2			; DO
	beq.s	do_info 		; yes, we need HELP

	xjsr	mea_chlp
	bra.s	mea_end

do_info
	movem.l (sp)+,d1-d5/a0-a5
	xjmp	mea_abou

mea_digit
	movem.l d1-d5/a0-a5,-(sp)
	xjsr	cls_unit
	bra.s	mea_end

mea_money
	movem.l d1-d5/a0-a5,-(sp)
	xjsr	cls_msym
	bra.s	mea_end

mea_find
	movem.l d1-d5/a0-a5,-(sp)
	xjsr	pld_find
	bra.s	mea_end

mea_gwith
	movem.l d1-d5/a0-a5,-(sp)
	cmp.b	#2,d2			; DO
	beq.s	do_perfect		; yes

	xjsr	grd_wdth
	bra.s	mea_end

do_perfect
	xjsr	grd_pwdt
	bra.s	mea_end

mea_toolload
	movem.l d1-d5/a0-a5,-(sp)
	cmp.b	#2,d2			; DO
	beq.s	do_load 		; yes

	xjsr	fil_xloa
	bra.s	mea_end

do_load
	xjsr	fil_ximp
	bra.s	mea_end

mea_toolsave
	movem.l d1-d5/a0-a5,-(sp)
	cmp.b	#2,d2			; DO
	beq.s	do_save 		; yes

	bsr	only_demo
;;;	   xjsr    fil_xsav
	bra	mea_end

do_save
	bsr	only_demo
;;;	   xjsr    fil_xsas
	bra	mea_end

mea_toolprint
	movem.l d1-d5/a0-a5,-(sp)
	cmp.b	#2,d2			; DO
	beq.s	do_print		; yes

	bsr	only_demo
;;;	   xjsr    fil_prtp
	bra	mea_end

do_print
	bsr	only_demo
;;;	   xjsr    fil_prtp
	bra	mea_end

mea_toolcellecho
	movem.l d1-d5/a0-a5,-(sp)
	xjsr	mod_echo
	bra	mea_end

mea_toolcellcopy
	movem.l d1-d5/a0-a5,-(sp)
	xjsr	mod_copy
	bra	mea_end

mea_toolcellmove
	movem.l d1-d5/a0-a5,-(sp)
	xjsr	mod_move
	bra	mea_end

mea_toolcelldel
	movem.l d1-d5/a0-a5,-(sp)
	xjsr	cls_eras
	bra	mea_end

mea_toolcellprot
	movem.l d1-d5/a0-a5,-(sp)
	cmp.b	#2,d2			; DO
	beq.s	do_unprotect		; yes

	xjsr	cls_prct
	bra	mea_end

do_unprotect
	xjsr	cls_upct
	bra	mea_end

mea_toolscrap
	movem.l d1-d5/a0-a5,-(sp)
	bsr	only_demo
;;;	   xjsr    fil_scrp
	bra	mea_end

mea_tooljustlf
	movem.l d1-d5/a0-a5,-(sp)
	xjsr	cls_justl
	bra	mea_end

mea_tooljustrg
	movem.l d1-d5/a0-a5,-(sp)
	xjsr	cls_justr
	bra	mea_end

	end

; toolbox item routine
mea_tbox
	bsr.s	tool_act
	move.b	#wsi.mkav,(a1,d2.w)
	moveq	#wm.drsel,d3
	jsr	wm.mdraw(a2)
	bne.s	do_kill

	bclr	#wsi..chg,(a1,d2.w)
	moveq	#0,d4
	rts

end
