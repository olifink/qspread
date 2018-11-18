; standard window resize event handling

	include win1_mac_oli
	include win1_keys_wman
	include win1_keys_wwork
	include win1_keys_wstatus
	include win1_keys_wdef_long
	include win1_keys_qdos_pt

	section utility

	xdef	xwm_rsiz

;+++
; resize event handling
;
;		Entry			Exit
;	d1				new size
;	a2	wman vector		preserved
;	a4	wwork			preserved
; errors
;---
xwm_rsiz subr	d2-d3/a2-a3
	move.l	ww_wstat(a4),a1
	move.l	wsp_xpos(a1),d3
	btst	#pt..do,wsp_weve(a1)	; was it a DO?
	beq.s	req_size
	moveq	#-1,d2			; yes, then maximum size
	bra.s	set_size
req_size
	jsr	wm.chwin(a2)		; no, request size change
	bmi.s	kill
	move.l	ww_xsize(a4),d2 	; new size is current..
	sub.l	d1,d2			; ..plus change (-ve)
	bsr.s	test_size
set_size
	moveq	#-1,d1
	jsr	wm.unset(a2)		; unset old window
	bmi.s	kill
	move.l	d2,d1
	move.l	d3,wsp_xpos(a1)
	bclr	#pt..wsiz,wsp_weve(a1)	; unset resize event
	moveq	#0,d0
kill	subend

test_size
	tst.w	d2
	bpl.s	y_ok
	clr.w	d2
y_ok	swap	d2
	tst.w	d2
	bpl.s	x_ok
	clr.w	d2
x_ok	swap	d2
	rts

	end
