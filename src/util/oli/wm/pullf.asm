; pull down a new window at fixed position			 J. Merz
;							08/02-92 O. Fink

	section utility

	include win1_keys_wman
	include win1_keys_wstatus
	include win1_keys_wwork
	include win1_keys_k
	include win1_keys_qdos_pt

	xdef	ut_pullf

	xref	ut_setup_l
	xref	ut_unset
	xref	ut_appr
	xref	do_close

;+++
; This routine pulls up a window.
;
;		Entry				   Exit
;	d1.l	size required for this layout	   ???
;	d4	position (in main window)	   k.do / k.cancel
;	a0					   channel ID
;	a1	window status area		   preserved
;	a2	window manager vector		   preserved
;	a3	menu to set up			   ???
;	a4	modify routine after setup (or 0)  window working area
;	a5	modify routine after draw (or 0)   ???
;---
ut_pullf
	move.l	a4,-(sp)	; keep routine
	jsr	ut_setup_l
	move.l	(sp)+,a3
	bne	ut_appr
	move.l	a3,d0		; routine supplied?
	beq.s	pull_nsr
	move.l	a1,-(sp)
	jsr	(a3)		; call set item sub-routine
	move.l	(sp)+,a1
pull_nsr
	move.l	d4,d1
	add.l	ww_xorg(a4),d1
	jsr	wm.pulld(a2)	; position the window
	bne	ut_appr
	jsr	wm.wdraw(a2)	; and draw its contents
	bne	ut_appr
	move.l	a5,d0		; routine supplied?
	beq.s	pull_ndr
	jsr	(a5)		; call pre-draw routine
pull_ndr

rptr_lp
	jsr	wm.rptr(a2)
	moveq	#k.cancel,d4
	btst	#pt..can,wsp_weve(a1)	; cancelled?
	bne.s	rptr_can
	moveq	#k.do,d4
	btst	#pt..do,wsp_weve(a1)	; DOne?
	beq.s	rptr_lp
rptr_can

	bsr	ut_unset	; unset window
	bra	do_close	; and close it
	end
