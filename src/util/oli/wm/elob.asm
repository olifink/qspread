; Edit / read loose item texts				15/07-92 O.Fink

	include win1_mac_oli
	include win1_keys_wman
	include win1_keys_wwork
	include win1_keys_qdos_io

	section utility

	xdef	xwm_rlob	; read from loose item object
	xdef	xwm_elob	; edit loose item object

;+++
; read loose item object
;
;	d1 :				d1 : terminating character
;	a0 : channel id
;	a2 : wmvec
;	a3 : loose item
;
; errors: all IOSS
;---
xwm_rlob subr a1/d2/d5
	move.w	#wm.rname,d5
general
	moveq	#0,d2
	move.w	wwl_item(a3),d1
	jsr	wm.swlit(a2)
	bne.s	rlob_exit
	moveq	#iow.sova,d0
	moveq	#0,d1
	xjsr	do_io
	bne.s	rlob_exit
	move.l	wwl_pobj(a3),a1
	jsr	(a2,d5.w)
	tst.l	d0
rlob_exit
	subend

;+++
; edit loose item object
;
;	a0 : channel id
;	a2 : wmvec
;	a3 : loose item
;
; errors: all IOSS
;---
xwm_elob subr a1/d2/d5
	move.w	#wm.ename,d5
	bra.s	general

	END
