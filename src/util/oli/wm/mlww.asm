; put menu list into window working defintion

	section utility

	include win1_mac_oli
	include win1_keys_wwork
	include win1_keys_err

	xdef	xwm_mlww

;+++
; put menu list into window working defintion
;
;		Entry			Exit
;	d0.l	menu subwindow nr	always ok
;	d1.w	max. item length
;	d2.w	nr of items
;	a0	menu status area	channel id
;	a1	row list pointer
;	a3				ptr to subwindow defn
;	a4	wwork
;---
xwm_mlww
	xjsr	xwm_awadr		; get application window address
	move.l	a0,wwa_mstt(a3) 	; menu status block
	move.w	#1,wwa_ncol(a3) 	; 1 column
	move.w	d2,wwa_nrow(a3) 	; many rows

	move.w	wwa_xsiz(a3),d2
	move.w	wwa_iatt+wwa_curw(a3),d0
	lsl.w	#2,d0
	sub.w	d0,d2
	swap	d2
	move.w	wwa_xsiz(a3),d2
	neg.l	d2
	move.l	d2,wwa_xspc(a3) 	; constant x spacing
	move.l	#$fff6fff4,wwa_yspc(a3) ; constant y spacing
	move.l	a1,wwa_rowl(a3)
	move.l	ww_chid(a4),a0
	moveq	#0,d0
	rts


	END
