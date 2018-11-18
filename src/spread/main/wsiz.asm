; calculate window size

	include win1_mac_oli
	include win1_keys_wdef_long
	include win1_keys_wman
	include win1_keys_wwork
	include win1_keys_wstatus


	section utility

	xdef	qwm_wsiz
	xdef	qwm_rset

;+++
; re-setup a window into a given definition
;
;		Entry				Exit
;	d1.l	size (or 0, or -1)		position
;	a2	wman vector
;	a4	wwork
;---
qwm_rset subr	a0/a1/a3/d3/d2
	move.l	ww_chid(a4),a0		; channel id
	move.l	ww_wstat(a4),a1 	; window status area
	move.l	ww_wdef(a4),a3		; window defintion

	move.l	ws_ptpos(a1),d3 	; absolute pointer position
	move.l	ww_xorg(a4),d2		; origin of window..
	sub.l	d2,d3			; ptr pos in primary
	add.l	ww_xsize(a4),d2 	; ..bottom right hand corner

	bsr.s	qwm_wsiz		; check window size
	xjsr	ut_wm_setup		; setup window

	move.l	d3,ww_xorg(a4)		; adjust pointer position
	sub.l	ww_xsize(a4),d2 	; get new origin
	add.l	d3,d2			; rel. by ptr pos
	move.l	d2,d1
	subend


;+++
; calculate window size
;
;		Entry				Exit
;	d1.l	size (or -1 for max)		new size
;	a0	channel id
;	a3	wdef
;---
qwm_wsiz subr	d2/d3/a3
	move.b	wd_wattr+wda_shdd(a3),d0	; shadow x
	ext.w	d0
	mulu	#ww.shadx,d0
	move.w	d0,d2
	swap	d2
	move.b	wd_wattr+wda_shdd(a3),d0	; shadow y
	ext.w	d0
	mulu	#ww.shady,d0
	move.w	d0,d2
	move.w	wd_wattr+wda_borw(a3),d0	; border x
	lsl.w	#1,d0
	swap	d0
	move.w	wd_wattr+wda_borw(a3),d0	; border y
	lsl.l	#1,d0
	add.l	d0,d2				; d2 border/shadow pixels
	move.l	d1,d3				; d3 requested size
	bpl.s	siz_ok

	move.l	#$7fff7fff,d3

siz_ok
	xjsr	ut_gwlma			; d1 screen limits
	beq.s	siz_ok1

	xjmp	ut_appr

siz_ok1
	sub.l	d2,d1				; ...less border/shadow
	xjsr	row_siz
	cmp.w	d3,d1
	bge.s	y_ok

	move.w	d1,d3

y_ok
	swap	d3
	swap	d1
	cmp.w	d3,d1
	bge.s	x_ok

	move.w	d1,d3

x_ok
	andi.w	#-4,d3				; x size multiple of 4
	swap	d3
	move.l	d3,d1
	moveq	#0,d0
exit	subend

	end
