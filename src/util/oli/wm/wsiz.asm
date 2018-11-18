; calculate window size

	include win1_mac_oli
	include win1_keys_wwork
	include win1_keys_wdef_long

	section utility

	xdef	xwm_wsiz
	xref	ut_appr

;+++
; calculate window size
;
;		Entry				Exit
;	d1.l	size (or -1 for max)		new size
;	a0	channel id
;	a3	wdef
;---
xwm_wsiz subr	d2/d3/a3
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
	bne	ut_appr
	sub.l	d2,d1				; ...less border/shadow
	cmp.w	d3,d1
	bge.s	y_ok
	move.w	d1,d3
y_ok	swap	d3
	swap	d1
	cmp.w	d3,d1
	bge.s	x_ok
	move.w	d1,d3
x_ok	andi.w	#-4,d3				; x size multiple of 4
	swap	d3
	move.l	d3,d1
	moveq	#0,d0
exit	subend

	end
