; QD Driver sample - just remove control codes	1998 Jochen Merz

	section program

	include win1_keys_err
	include win1_keys_qdos_io
	include win1_keys_qdos_sms

	bra.s	start
	dc.w	0,0
	dc.w	$4afb,9,'QD driver '

start
	move.w	(sp),d0
	subq.w	#2,d0			; right number of params
	bne.s	die			; no, die
	move.l	2(sp),a4		; input pipe
	move.l	6(sp),a5		; output pipe

loop
	bsr.s	fetch_byte
	cmp.b	#1,d1			; start of code?
	bne.s	send_it

; insert here any kind of control code handling

skip_code
	bsr.s	fetch_byte
	cmp.b	#2,d1
	bne.s	skip_code
	bra.s	loop
send_it
	bsr.s	send_byte
	bra.s	loop

die
	moveq	#0,d3
	moveq	#sms.frjb,d0
	moveq	#-1,d1
	trap	#do.sms2		; commit suicide

fetch_byte
	move.l	a4,a0
	moveq	#iob.fbyt,d0
	moveq	#-1,d3
	trap	#do.io			; fetch byte
	tst.l	d0
	bne.s	die			; failed, die
	rts

send_byte
	move.l	a5,a0
	moveq	#iob.sbyt,d0
	trap	#do.io
	tst.l	d0
	bne.s	  die
	rts

	end
