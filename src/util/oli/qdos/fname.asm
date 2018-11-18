; read real filename
;

	include win1_mac_oli
	include win1_keys_qdos_io
	include win1_keys_hdr

	section utility

	xdef	ut_fname		; read filename

;+++
; read real filename
;
;	a0	channel id
;	a1	ptr to buffer
;errors: ioss
;---
ut_fname subr	a0-a2/d2/d3
	move.l	a1,a2
	suba.l	#64,sp
	move.l	sp,a1
	move.l	a1,-(sp)
	moveq	#iof.rhdr,d0
	moveq	#64,d2
	xjsr	do_io
	move.l	(sp)+,a1
	tst.l	d0
	bne.s	exit
	lea	hdr_name(a1),a1
	move.l	a2,a0
	xjsr	ut_cpyst
exit	adda.l	#64,sp
	tst.l	d0
	subend

	end
