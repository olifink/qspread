; first setup of a window

	include win1_mac_oli
	include win1_keys_wman
	include win1_keys_wwork

	section utility

	xdef	xwm_fset

;+++
; first setup of a window
;
;		Entry				Exit
;	d1.l	size (or 0, or -1)
;	a2	wman vector
;	a3	primary block
;	a6	global status area
;---
xwm_fset subr	a3/d1-d3
	move.l	d1,d2			; size
	move.l	(a3)+,d1		; layout memory size
	move.l	(a3)+,a1
	adda.l	a6,a1			; status area
	add.l	(a3),a3 		; window defintion
	xjsr	ut_setup_l
	subend
	end
