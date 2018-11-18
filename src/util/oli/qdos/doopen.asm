; Open a channel for current job

	section utility

	xdef	do_open
	xref	gu_fopen

	include win1_keys_qdos_ioa
;+++
; Open a channel for the current job
;
;		Entry				Exit
;	d1-d2					preserved
;	d3	open key			???
;	a0	pointer to name 		???
;
;	Error returns: any I/O error
;	condition codes set
;---
do_open
	movem.l d1/a1,-(sp)
	moveq	#myself,d1
	moveq	#ioa.open,d0
	trap	#do.ioa
	movem.l (sp)+,d1/a1
	tst.l	d0
	rts
*
	end
