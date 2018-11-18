* Spread	Sat, 1993 Feb 20 17:10:16
*    - about pulldown

	include win1_keys_wman
	include win1_keys_wstatus
	include win1_keys_wwork
	include win1_keys_wdef_long
	include win1_keys_qdos_pt
	include win1_spread_keys
	include win1_mac_oli

	section prog

	xdef	mea_abou


	xref.l	wwa.abou,wst_abou


	section prog

; setup, draw, read and then unset menu
; (returns with k.cancel/k.do in d4, according to do/quit)
r_pld	reg	a0-a5/d1-d4
mea_abou
	movem.l r_pld,-(sp)
	move.l	wsp_xpos(a1),d4
	add.l	ww_xorg(a4),d4
	move.l	#wwa.abou,d1
	moveq	#0,d2			; use default size
	lea	wst_abou(a6),a1
	xlea	men_abou,a3
	lea	cwy_abou(pc),a4 	; setup postprocessing
	suba.l	a5,a5			; draw postprocessing
	xjsr	ut_pullf		; (or use ut_pullf)
	movem.l (sp)+,r_pld
	xjmp	ut_rdwie

cwy_abou subr d0
	moveq	#0,d0
	move.b	colb(a6),d0
;;;	   xjsr    ut_ccwwd
	subend

	end
