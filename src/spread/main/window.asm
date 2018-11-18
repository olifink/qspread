* Spreadsheet					      29/11-91
*	 - general window handeling

	section prog

	xdef	do_window,close_flash,open_flash

	xref.s	wst_main

	include win1_keys_wman
	include win1_keys_wstatus
	include win1_keys_wwork
	include win1_keys_qdos_pt
	include win1_keys_qdos_io
	include win1_keys_qlv
	include win1_keys_err
	include win1_mac_oli
	include win1_spread_keys
	include win1_mac_assert
	include win1_keys_colour

do_window
	moveq	#0,d6
	move.b	cffui(a6),d6
	swap	d6			; flash delay
	moveq	#0,d7
	move.b	v_expldel(a6),d7
	ext.w	d7
	swap	d7			; help delay
rdptr
	move.l	wsp_xpos(a1),d4 	; save pointer origin
	moveq	#0,d2			; no event to return on
	moveq	#5,d3			; short timeout
	jsr	wm.rptrt(a2)
	bgt.s	edit			; something to edit

	cmp.l	#err.nc,d0
	bne.s	help_not_required
	tst.l	d7			; help disabled?
	bmi.s	help_not_required
	cmp.l	wsp_xpos(a1),d4 	; same position?
	bne.s	help_reset_count
	cmp.l	wsp_chid(a1),a0 	; pointer inside our window?
	bne.s	help_reset_count
	tst.l	wsp_swnr(a1)		; within sub-window?
	bge.s	help_reset_count
	addq.w	#5,d7
	move.l	d7,d0
	swap	d0
	cmp.w	d7,d0
	bgt.s	help_not_required

	move.b	v_explcol(a6),d7	; colours for explanatory window
	xlea	tab_explanation,a3
	xbsr	ut_explanation
	clr.w	d7
	bra.s	do_window

help_reset_count
	clr.w	d7
help_not_required

	tst.l	d6			; flash change item?
	beq.s	dont_flash		; no, skip
	addq.w	#5,d6
	move.l	d6,d0
	swap	d0
	cmp.w	d6,d0			; delay reached?
	bgt.s	dont_flash
	bsr	flash_icon		; flash change icon
	clr.w	d6
dont_flash

	btst	#pt..can,wsp_weve(a1)	; please sleep (w_esc)
	bne.s	w_zz_esc

	btst	#pt..wmov,wsp_weve(a1)	; test for move event
	bne.s	w_move

	btst	#pt..wsiz,wsp_weve(a1)	; test for resize event
	bne.s	w_size

	btst	#pt..zzzz,wsp_weve(a1)	; test for sleep event
	bne.s	w_zzzz

	bra	rdptr

do_kill
	xjmp	kill

edit
	xjmp	do_edit 	       ; was xjsr before

* window move event
w_move
	bsr	close_flash
	xjsr	xwm_move
	bsr	open_flash
	bra	rdptr

* window resize event
w_size
	bsr	close_flash
	xjsr	xwm_rsiz
	move.l	ww_wdef(a4),a3		; get window definition
	xjsr	qwm_wsiz
	move.l	d1,da_winsz(a6)
	xjsr	set_nset
	bsr	open_flash
	bra	rdptr

	assert	mod.slct,0
* window sleep (by pressing ESC)
w_zz_esc
	tst.w	da_amode(a6)		; any special mode selected?
	beq.s	w_zzzz
	xbsr	mod_norm
	bra	rdptr

* window sleep event
slepreg reg	d4-d7/a2
w_zzzz
	movem.l slepreg,-(sp)
	bsr	close_flash		; close channel of flash-icon

	move.l	da_chan(a6),d0
	beq.s	do_kill

	move.l	d0,a0
	xjsr	gu_fclos		; close window
	clr.l	da_chan(a6)

	moveq	#1,d0
	xjsr	gu_spjob		; change priority to 1

	moveq	#-1,d1
	xjsr	ut_gtjn 	       ; get jobname
	move.l	a1,a3
	moveq	#-1,d1			; position
	move.b	colb(a6),d2	       ; config button-colourway
	moveq	#0,d3			; no edit sprite
	moveq	#1,d4			; default allow ESC

	tst.w	da_saved(a6)		; did we need confirmation request
	bne.s	no_conf 		; no

	moveq	#1,d3			; we need edit sprite
	moveq	#0,d4			; ... and no ESC

no_conf
	xjsr	mu_xbtn
	bne.s	s_error 		; we got problems

	cmp.b	#2,d1			; HIT  ??
	beq.s	end_hit

	cmp.b	#3,d1			; DO  ??
	beq.s	end_do

	cmp.b	#0,d1			; ESC
	beq.s	try_kill

	bra.s	end_hit

s_error
	movem.l (sp)+,slepreg
	xjmp	kill			; show error and die

try_kill
	tst.w	da_saved(a6)		; did we ne confirmation request
	beq.s	end_do			; yes

	movem.l (sp)+,slepreg
	moveq	#err.nc,d0		; return with error
	xjmp	gu_die			; ESC

end_hit
end_do
end_wake
	moveq	#32,d0
	xjsr	gu_spjob		; change priority back to 32

	move.l	#'1.60',d0		; minimum Pointer Interface version
	move.l	#'1.55',a0		; minimum Window Manager version
	xjsr	wu_gwman		; get wman vector & open con_
	bne.s	s_error

	move.l	a0,da_chan(a6)		 ; channel id wegzetten

	move.l	da_wwork(a6),a4
	move.l	a0,ww_chid(a4)
	jsr	set_nset	      ; do another window setup
	bsr.s	open_flash
	movem.l (sp)+,slepreg
	bra	rdptr
*-------------------
w_esc
	xjsr   mod_norm
	bra    rdptr


mainreg reg	d1-d7/a0-a5
;----------------------------------------------------------------------------
flash_icon
	movem.l mainreg,-(sp)
	move.l	up_chid(a6),d0		; any channel-id
	beq.s	flash_rts		; no

	tst.w	da_saved(a6)		; need a flashing sprite
	bne.s	flash_test_on		; no

	tst.b	sprt_on(a6)		; sprite on ??
	bne.s	try_flash_clear 	; yes, so clear it

try_flash
	move.l	d0,a0
	moveq	#0,d1			; at 0,0
	moveq	#1,d3			; timeout
	xlea	mes_edited,a1
	moveq	#iop.wspt,d0
	trap	#3
	not.b	sprt_on(a6)
	bra.s	flash_rts

try_flash_clear
	move.b	cffui(a6),d1		; need a flashing sprite
	beq.s	flash_rts		; no

flash_test_on
	tst.b	sprt_on(a6)		; sprite on ??
	beq.s	flash_rts		; no

flash_clear
	move.l	d0,a0
	xjsr	gu_clra
	clr.b	sprt_on(a6)		; clear sprite

flash_rts
	movem.l (sp)+,mainreg
	rts

;----------------------------------------------------------------------

close_flash
	movem.l d0/a0,-(sp)
	move.l	up_chid(a6),d0
	beq.s	flash_closed

	move.l	d0,a0
	xjsr	gu_fclos

	clr.l	up_chid(a6)

flash_closed
	movem.l (sp)+,d0/a0
	rts
;------------------------------------------------------------------------
open_flash
	movem.l d0-d7/a0-a5,-(sp)
	bsr.s	close_flash

	move.l	da_wwork(a6),a4
	move.w	ww_xsize(a4),d1
	sub.w	#44,d1
	add.w	ww_xorg(a4),d1
	swap	d1
	move.w	ww_yorg(a4),d1
	add.w	#2,d1

open_flashc
	lea	place,a5
	move.l	d1,(a5)
	lea	updt_con(pc),a1
	move.l	da_wmvec(a6),a2
	move.w	#opw.con,d0
	jsr	wm.opw(a2)
	bne.s	op_err

	move.l	a0,up_chid(a6)
	clr.b	sprt_on(a6)

op_err
	movem.l (sp)+,d0-d7/a0-a5
	rts

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
updt_con
	dc.w	c.ibord 		; border colour
	dc.w	0			; border with
	dc.w	c.iback 		; backround
	dc.w	c.iink			; ink
	dc.w	14			; pixels wide
	dc.w	9			; pixels high
place
	dc.w	0			; at 0,0
	dc.w	0


	 end
