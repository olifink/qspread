; Round fp						24/09-92 O.Fink
;

	include win1_mac_oli
	include win1_keys_qlv

	section utility

	xdef	ut_round
;+++
; round fp
;
;		Entry			Exit
;	d0.w	nr. of decimal places (1-7)
;   (a1,a6.l)	RI stack		preserved (updated)
;
; error codes: ovfl	overflow
;---
ut_round subr	a2/d3-d4
	move.w	d0,d3
	subq.w	#2,a1
	move.w	#10,(a1,a6.l)		; 10^n
	moveq	#qa.float,d0
	xjsr	ut_doqa
	bne.s	exit
	subq.w	#2,a1
	move.w	d3,(a1,a6.l)
	moveq	#qa.float,d0
	xjsr	ut_doqa
	bne.s	exit
	moveq	#qa.pwrf,d0
	xjsr	ut_doqa
	bne.s	exit
	move.l	(a1,a6.l),d3
	move.w	4(a1,a6.l),d4
	moveq	#qa.mul,d0
	xjsr	ut_doqa 		; *
	bne.s	exit
	xjsr	ut_fpint		; rint(x)
	bne.s	exit
	subq.w	#6,a1
	move.w	d4,4(a1,a6.l)
	move.l	d3,(a1,a6.l)		; /10^n
	moveq	#qa.div,d0
	xjsr	ut_doqa
exit
	tst.l	d0
	subend

	end
