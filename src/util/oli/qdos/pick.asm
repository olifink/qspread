; pick and wake	a job

	include	win1_mac_oli
	include	win1_keys_qdos_io
	include	win1_keys_k

	section	utility

	xdef	ut_pick,ut_wake

;+++
; pick and wake	a job
;
;		Entry				Exit
;	a0	channel	ID
;	d1.l	job ID (-1=myself)		preserved
;
; error: ijob, ichn
;---
ut_wake	pushm	d1/d2
	moveq	#k.wake,d2
	bra.s	doit
ut_pick	subr	a0/d1/d2
	moveq	#0,d2			; pick event
doit	move.l	d1,d0			; care for id -1
	addq.l	#1,d0
	bne.s	idok
	xjsr	ut_myjbid		; get my jobid
idok	moveq	#iop.pick,d0
	xjsr	do_io
	subend

	end
