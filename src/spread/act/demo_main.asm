	section action

	include win1_mac_xref
	include win1_keys_wman
	include win1_keys_wwork
	include win1_keys_wstatus
	include win1_keys_qdos_pt
	include win1_keys_qdos_io
	include win1_keys_qdos_ioa
	include win1_keys_qdos_sms
	include win1_keys_k
	include win1_keys_qlv
	include win1_spread_keys

	xdef	mea_cfil
	xdef	mea_cgrd
	xdef	mea_ccel
	xdef	rmv_pull
	xdef	mea_ret_item

	xref.l	wwa.file,wwa.grid,wwa.cell

	xref.s	wst_file,wst_grid,wst_cell

	xref	fil_forg	; forget sheet
	xref	fil_xloa	; load new sheet
	xref	fil_xsav	; save current sheet
	xref	fil_xsas	; save as...
	xref	fil_ximp	; import from file
	xref	fil_xexp	; export to file
	xref	fil_scrp	; block into scrap
	xref	fil_mpag	; mark page
	xref	fil_prtp	; print current page
	xref	fil_prtb	; print current block
	xref	fil_prtf	; print formulae report
	xref	pld_popt	; change printer options

	xref	grd_calc
	xref	grd_wdth
	xref	grd_pwdt
	xref	grd_selc
	xref	mod_insc
	xref	mod_delc
	xref	grd_selr
	xref	mod_insr
	xref	mod_delr
	xref	pld_find
	xref	grd_quit

	xref	cls_eras
	xref	mod_copy
	xref	mod_move
	xref	cls_unit
	xref	cls_msym	  ; monetary symbol
	xref	cls_just
	xref	mod_echo	  ; echo cell
	xref	cls_prct
	xref	cls_upct

*  demo
demo
	xjsr	only_demo
	rts
*

mea_reg reg	d1-d7/a0-a4

mea_cgrd
	movem.l mea_reg,-(sp)		 ; save registers
	lea	jump_grid,a5
	lea	wst_grid(a6),a1
	xlea	men_grid,a3
	move.l	#wwa.grid,d1
	move.l	#$00e80022,d4
	bra.s	do_pull

mea_ccel
	movem.l mea_reg,-(sp)		 ; save registers
	lea	jump_cell,a5
	lea	wst_cell(a6),a1
	xlea	men_cell,a3
	move.l	#wwa.cell,d1
	move.l	#$00fc0022,d4
	bra.s	do_pull

mea_cfil
	movem.l mea_reg,-(sp)		 ; save registers
	lea	jump_files,a5
	lea	wst_file(a6),a1
	xlea	men_file,a3
	move.l	#wwa.file,d1
	move.l	#$00d20022,d4
do_pull
	add.l	ww_xorg(a4),d4
	move.l	d4,-(sp)
	xjsr	mod_norm
	xjsr	ut_setup_l
	move.l	(sp)+,d1
;;;	   movem.l d2/a3,-(sp)
;;;	    move.b  colm(a6),d2
;;;	   xjsr    wu_scmwn
;;;	   movem.l (sp)+,d2/a3
	jsr	wm.pulld(a2)
	jsr	wm.wdraw(a2)
do_rptr
	jsr	wm.rptr(a2)
	tst.l	d0
	bne.s	do_pulr
	moveq	#0,d0
	btst	#pt..move,wsp_weve(a1)
	bne.s	do_move
	btst	#pt..can,wsp_weve(a1)
	beq.s	do_rptr
do_pulr
	xjsr	ut_unset
	xjsr	gu_fclos
rmv_pull
	movem.l (sp)+,mea_reg
	move.l	d0,-(sp)
	xjsr	ut_rdwci
	move.l	(sp)+,d0
	beq.s	return
	subq.l	#1,d0		; first item is always ESC
	add.l	d0,d0
	add.l	d0,d0
	move.l	(a5,d0.l),a5
	moveq	#0,d0
	movem.l mea_reg,-(sp)
	jsr	(a5)
	movem.l (sp)+,mea_reg
return
	rts

do_move
	jsr	wm.chwin(a2)
	moveq	#-1,d3
	jsr	wm.ldraw(a2)
	bra.s	do_rptr

mea_ret_item
	xjsr	ut_rdwci
	moveq	#0,d0
	move.w	wwl_item(a3),d0
	rts

jump_files
	dc.l	fil_forg	;    forget sheet
	dc.l	fil_xloa	; ^L load new sheet
	dc.l	demo	    ; ^V save current sheet
	dc.l	demo	    ; ^N save as...
	dc.l	fil_ximp	;    import from file
	dc.l	demo	    ;	 export to file
	dc.l	demo	    ;	 block into scrap
	dc.l	fil_mpag	;    mark page
	dc.l	demo	    ; ^P print current page
	dc.l	demo	    ;	 print current block
	dc.l	fil_prtf	;    print formulae report
	dc.l	pld_popt	;    change printer options

jump_grid
	dc.l	grd_calc	; ^R recalculate grid
	dc.l	grd_wdth	;    change column with
	dc.l	grd_pwdt	;    perfect column with
	dc.l	grd_selc	;    select column
	dc.l	mod_insc	; ^K insert column
	dc.l	mod_delc	;    delete column
	dc.l	grd_selr	;    select row
	dc.l	mod_insr	; ^W insert row
	dc.l	mod_delr	; ^O delete row
	dc.l	pld_find	; ^S search
	dc.l	grd_quit	; ^X quit QSpread

jump_cell
	dc.l	cls_eras	;    erase range
	dc.l	mod_copy	; ^Y copy range
	dc.l	mod_move	; ^U move range
	dc.l	cls_unit	;    units
	dc.l	cls_msym	;    monetary symbol
	dc.l	cls_just	; ^T justification
	dc.l	mod_echo	; ^Z echo cell
	dc.l	cls_prct	;    protect range
	dc.l	cls_upct	;    unprotect range

	end
