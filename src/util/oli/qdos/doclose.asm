; Close a channel

	section utility

	xdef	do_close
	xref	gu_fclos

	include win1_keys_qdos_ioa
;+++
; Close a channel, but keep condition codes
;
;		Entry				Exit
;	d0					preserved
;	a0	channel ID			???
;---
do_close
	movem.l d0/a1,-(sp)
	moveq	#ioa.clos,d0
	trap	#do.ioa
	movem.l (sp)+,d0/a1
	tst.l	d0
	rts
*
