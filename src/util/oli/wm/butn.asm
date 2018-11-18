; close primary, and make a button

	section utility

	include win1_mac_oli
	include win1_keys_wwork
	include win1_keys_wstatus
	include win1_keys_qdos_pt

	xdef	xwm_butn

;+++
; close primary and make a button
;
;		Entry				Exit
;	d1					old window size
;	d2	colourway
;	a0					new channel id
;	a2					wman vector
;	a3	button name
;	a4	wwork
;---
xwm_butn subr	a1/d2-d3
	move.l	ww_wstat(a4),a1
	bclr	#pt..zzzz,wsp_weve(a1)
	move.l	ww_chid(a4),a0
	xjsr	do_close			; close primary

	andi.l	#3,d2
	moveq	#-1,d1				; try button frame
	xjsr	mu_buttn
*	 bne.s	 exit
	xjsr	ut_opcon			; open primary channel
	bne.s	exit
	move.l	a0,ww_chid(a4)
	move.l	ww_xsize(a4),d1
exit	tst.l	d0
	subend

	end
