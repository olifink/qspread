; get the device name of a full filename

	include win1_mac_oli

	section string

	xdef	st_devnm

;+++
; get the device name of a full filename
; (win1_fred_test_barnie -> win1_)
;
;		Entry				Exit
;	a0	ptr to full name		preserved
;	a1	ptr to buffer			preserved
;---
st_devnm subr	a0/a1/a2/d1/d2
	moveq	#1,d1		; first scanning position
	moveq	#'_',d2 	; look for first underscore
	xbsr	st_findc	; find character
	beq.s	found
	move.w	(a0),d1
found	suba.l	a2,a2
	xbsr	st_splta	; split string after position
	subend

	end
