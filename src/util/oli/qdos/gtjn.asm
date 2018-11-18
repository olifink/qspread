; set a new jobname					       O. Fink

	include win1_mac_oli
	include win1_keys_jcb

	section utility

	xdef	ut_gtjn 		; set a new jobname

;+++
; set a new jobname
;
;		Entry			Exit
;	d1.l	job id (or -1)
;	a1				ptr to jobname
;
; error and cc set
;---
ut_gtjn
	xjsr	ut_jbase		; get base address of job
	adda.w	#8,a1			; job name
exit	rts

	end
