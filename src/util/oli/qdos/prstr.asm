; print string to channel			1993 O.Fink
;
	include win1_mac_oli
	include win1_keys_qdos_io

	section utility

	xdef	ut_prstr

;+++
; print a string to a given channel (timeout = -1)
;
;		Entry			Exit
;	a0	channel id		preserved
;	a1	ptr to string		preserved
;
; errors: IOSS
; cc:	  set
;---
ut_prstr subr	a1/d1/d2
	moveq	#iob.smul,d0
	move.w	(a1)+,d2
	xjsr	do_io
	subend

	end
