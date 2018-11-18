; standard pull down menu				(J. Merz)
;							08/02-92 O. Fink

	section utility

	include win1_keys_wman
	include win1_keys_wstatus
	include win1_keys_wwork
	include win1_keys_k
	include win1_keys_qdos_pt
	include win1_mac_oli

	xdef	xwm_pulld
	xref	ut_appr

;+++
; This routine pulls down a window and reads it
;
;		Entry				   Exit
;	d2	window size			   preserved
;	d4	position (in main window)	   k.do / k.cancel
;	a0					   channel ID
;	a2	window manager vector		   preserved
;	a3	pulldown window to draw 	   preserved
;	a6	global status area		   preserved
;---

; pulldown window stucture
pd_size equ	0		; wwa.name l size required
pd_stat equ	4		; wst_name l status area rel. to a6
pd_menu equ	8		; men_name-* l window defintion
pd_pset equ	12		; post_setup-* l setup postprocessing or 0
pd_pdrw equ	16		; post_draw-*  l draw postprocessing or 0

xwm_pulld subr	a1-a4/d1-d3
	move.l	a3,-(sp)
	move.l	pd_size(a3),d1	; size required
	move.l	pd_stat(a3),d0	; status area offset
	lea	(a6,d0.l),a1	; status area
	lea	pd_menu(a3),a3
	add.l	(a3),a3
	xjsr	ut_setup_l	; do the setup stuff
	bne	ut_appr
	movem.l (sp)+,a3

	move.l	pd_pset(a3),d0	; routine supplied?
	beq.s	pull_nsr
	movem.l a1/a3,-(sp)
	lea	pd_pset(a3,d0.l),a3
	jsr	(a3)		; post setup processing
	movem.l (sp)+,a1/a3
pull_nsr

	move.l	d4,d1
	bmi.s	pos_rel
	add.l	ww_xorg(a4),d1
pos_rel
	jsr	wm.pulld(a2)	; position the window
	bne	ut_appr
	jsr	wm.wdraw(a2)	; and draw its contents
	bne	ut_appr

	move.l	pd_pdrw(a3),d0	; routine supplied?
	beq.s	pull_ndr
	lea	pd_pdrw(a3,d0.l),a3
	jsr	(a3)		; call pre-draw routine
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

	xjsr	ut_unset	; unset window
	xjsr	do_close	; and close it
	subend

	end
