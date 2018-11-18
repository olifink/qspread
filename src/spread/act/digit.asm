* spread	Tue, 1993 May 25 20:04:53
*    - digit pulldown

	include win1_keys_wman
	include win1_keys_wstatus
	include win1_keys_wwork
	include win1_keys_wdef_long
	include win1_keys_qdos_pt
	include win1_spread_keys
	include win1_mac_oli

	section prog

	xdef	pld_digt,mea_digt,ini_digt
	
	xref.l	mv_digt,mli.dig0,mli.dig9
	xref.l	wwa.digt,wst_digt

	section prog

ini_digt subr	a0/a1
	lea	mv_digt(a6),a0
	xlea	cfg_dig0,a1
	xjsr	ut_cpyst
	adda.w	#30,a0
	xlea	cfg_dig1,a1
	xjsr	ut_cpyst
	adda.w	#30,a0
	xlea	cfg_dig2,a1
	xjsr	ut_cpyst
	adda.w	#30,a0
	xlea	cfg_dig3,a1
	xjsr	ut_cpyst
	adda.w	#30,a0
	xlea	cfg_dig4,a1
	xjsr	ut_cpyst
	adda.w	#30,a0
	xlea	cfg_dig5,a1
	xjsr	ut_cpyst
	adda.w	#30,a0
	xlea	cfg_dig6,a1
	xjsr	ut_cpyst
	adda.w	#30,a0
	xlea	cfg_dig7,a1
	xjsr	 ut_cpyst
	adda.w	#30,a0
	xlea	cfg_dig8,a1
	xjsr	ut_cpyst
	adda.w	#30,a0
	xlea	cfg_dig9,a1
	xjsr	ut_cpyst
	subend


; setup, draw, read and then unset menu
; (returns with k.cancel/k.do in d4, according to do/quit)
r_pld	reg	a0-a5/d1-d3
pld_digt
	movem.l r_pld,-(sp)
	move.l	wsp_xpos(a1),d4 	; uncomment if fixed
	add.l	ww_xorg(a4),d4		; position is required
	move.l	#wwa.digt,d1
	moveq	#0,d2			; use default size
	lea	wst_digt(a6),a1
	xlea	men_digt,a3
	lea	cwy_digt(pc),a4 	; setup postprocessing
	suba.l	a5,a5			; draw postprocessing
	xjsr	ut_pullf		; (or use ut_pullf)
	tst.l	d0
	movem.l (sp)+,r_pld
	rts

cwy_digt subr d0/d1/a1			; convert colourway
	moveq	#0,d0
;;;	   move.b  colm(a6),d0
;;;	   xjsr    ut_ccwwd
	moveq	#mli.dig0,d1
	lea	mv_digt(a6),a1
lp1
	jsr	wm.stlob(a2)
	adda.w	#30,a1
	addq.w	#1,d1
	cmpi.w	#mli.dig9+1,d1
	bne.s	lp1

	subend

mea_digt
	xjsr	edt_strg
	moveq	#0,d0
	moveq	#0,d4
	rts






























	end
