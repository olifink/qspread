; set filetype in header
;

	include win1_mac_oli
	include win1_keys_qdos_io
	include win1_keys_hdr

	section utility

	xdef	ut_sftyp		; set filetype

;+++
; set exec filetype and dataspace
;
;	a0	channel id
;	d1.b	file type
;errors: ioss
;---
ut_sftyp subr	a1/d2/d3
	move.b	d1,d3
	suba.l	#16,sp
	move.l	sp,a1
	move.l	a1,-(sp)
	moveq	#iof.rhdr,d0
	moveq	#16,d2
	xjsr	do_io
	move.l	(sp)+,a1
	tst.l	d0
	bne.s	exit
	move.b	d3,hdr_type(a1)
	moveq	#iof.shdr,d0
	xjsr	do_io
exit	adda.l	#16,sp
	tst.l	d0
	subend

	end
