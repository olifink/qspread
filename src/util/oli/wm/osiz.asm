; calculate optimal window size for menu list

	include win1_mac_oli
	include win1_keys_wdef_long

	section utility

	xdef	xwm_osiz

;+++
; calculate optimal window size for menu list
;
;	d1				preferred size
;	a3	wdef
;	a4	array descriptor
;---
xwm_osiz subr	a3/d0
	move.l	wd_xsize(a3),d1 		; the window size
	andi.l	#$0fff0fff,d1			; mask out the scaling bits
	move.l	a4,d0
	beq.s	exit
	lea	wd_rbase+wd_pappl(a3),a3	; now find the first..
	add.w	(a3),a3 			; application window in list
	add.w	(a3),a3
	move.l	wda_xsiz(a3),d0 		; get it's size
	andi.l	#$0fff0fff,d0			; without scaling bits
	sub.l	d0,d1				; size without application
	swap	d1
	moveq	#6,d0
	mulu	10(a4),d0
	addq.w	#4,d0
	add.w	d0,d1
	swap	d1
	move.w	6(a4),d0
	addq.w	#1,d0
	mulu	#12,d0	       ; row size for menu
	add.w	d0,d1
exit	subend

	end
