; print a space to a given channel

	include win1_mac_oli

	section utility

	xdef	ut_prspc

;+++
; print a space to a given channel
;
;		Entry				Exit
;	a0	channel id			preserved
;
; errors: IOSS
;---
ut_prspc subr	d1
	moveq	#32,d1
	xjsr	ut_prchr
	subend

	end
