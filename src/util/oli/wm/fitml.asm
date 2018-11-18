; fit an regular sized menu into an appl. window

	section utility

	include win1_mac_oli
	include win1_keys_wwork
	include win1_keys_wstatus

	xdef	xwm_fyml		; only y fit supported yet
;	xdef	xwm_fxml

;+++
; fit an regular sized menu into an appl. window
;
;	a3	ptr to appl. window
;---
xwm_fyml subr	a2
	move.l	wwa_part+wwa.clen(a3),d0	; y control block
	beq.s	exit
	move.l	d0,a2
	clr.w	wss_nsec(a2)			; assume no sections
	clr.w	wss_sstt+2(a2)
	move.w	wwa_ysiz(a3),d0 		; window size
	ext.l	d0
	move.l	wwa_yspc(a3),d1
	neg.l	d1
	divu	d1,d0
	cmp.w	wwa_nrow(a3),d0
	bge.s	yfits				; no control section req.

	subq.w	#1,d0				; one row less
	move.w	#1,wss_nsec(a2) 		; set one section
	move.w	wwa_iatt+wwa_curw(a3),d1
	lsl.w	#1,d1
	add.w	#ww.scbar,d1
	sub.w	d1,wwa_xsiz(a3) 		; reduce window
	add.w	d1,wwa_xspc(a3) 		; reduce item size..
	add.w	d1,wwa_xspc+2(a3)		; ..and spacing
	move.w	wwa_iatt+wwa_curw(a3),d1
	lsl.w	#1,d1
	add.w	#ww.scarr,d1
	move.w	d1,wwa_yoff(a3) 		; set section offset


yfits	move.w	d0,wss_ssiz+2(a2)
exit	moveq	#0,d0
	subend

	end
