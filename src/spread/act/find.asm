* spread	Mon, 1993 Jun 14 17:57:10
*    - find pulldown

	include win1_keys_wman
	include win1_keys_wstatus
	include win1_keys_wwork
	include win1_keys_wdef_long
	include win1_keys_qdos_pt
	include win1_keys_k
	include win1_spread_keys
	include win1_mac_oli

	section prog

	xdef	pld_find,ini_find,mea_fdir,mea_caga


	xref.l	mli.ftxt,mli.fdwn,mli.fupw
	xref.l	mv_find,mli.caga
	xref.l	wwa.find,wst_find,wst_main

	section prog

ini_find subr	a1
	clr.w	mv_find(a6)
	lea	wst_find(a6),a1
	move.b	#wsi.slct,ws_litem+mli.fdwn(a1)  ; pre-select downward search
	subend

pld_find
	xjsr	xwm_wasdo
	beq.s	only_fnd

	bsr.s	pld_findw		; pulldown find window
	cmpi.b	#k.cancel,d4		; ESC'd?
	beq.s	pld_exit

only_fnd
	xjsr	do_find 		; do the actual finding

pld_exit
	rts

mea_caga
	xjsr	do_find
	xjmp	ut_rdwci


; setup, draw, read and then unset menu
; (returns with k.cancel/k.do in d4, according to do/quit)
pld_findw subr	 a0-a5/d1-d3
	move.l	ww_wstat(a4),a1
	move.l	wsp_xpos(a1),d4 	; uncomment if fixed
	add.l	ww_xorg(a4),d4		; position is required
	move.l	#wwa.find,d1
	moveq	#0,d2			; use default size
	lea	wst_find(a6),a1
	xlea	men_find,a3
	lea	cwy_find(pc),a4 	; setup postprocessing
	suba.l	a5,a5
	xjsr	ut_pullf		; (or use ut_pullf)
	tst.l	d0
	subend

cwy_find subr d0/a1			; convert colourway
	moveq	#0,d0
;;;	   move.b  colm(a6),d0
;;;	   xjsr    ut_ccwwd
	moveq	#mli.ftxt,d1		; set find text item
	lea	mv_find(a6),a1
	jsr	wm.stlob(a2)
	subend

; action routines for downwards/upwards toggle
mea_fdir
	move.w	wwl_item(a3),d1
	xlea	lel_fdir,a3
	xjsr	xwm_exsll
	moveq	#0,d3
	rts

	end
