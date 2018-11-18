; print character to channel			   1993 O.Fink
;
	include win1_mac_oli
	include win1_keys_qdos_io

	section utility

	xdef	ut_prchr

;+++
; print a character to a given channel (timeout = -1)
;
;		Entry			Exit
;	d1.b	character		preserved
;	a0	channel id		preserved
;
; errors: IOSS
; cc:	  set
;---
ut_prchr subr	a1/d1/d2
	moveq	#iob.sbyt,d0
	xjsr	do_io
	subend

	end
