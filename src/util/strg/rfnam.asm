; get real filename

	include win1_mac_oli

	section string

	xdef	st_rfnam

;+++
; get real filename (skip subdirectories)
; (win1_test_fred_barnie -> barnie)
;
;		Entry				Exit
;	a0	ptr to string			preserved
;	a1	ptr to buffer			preserved
;---
st_rfnam subr	a0/a1/a2/d1-d2
	moveq	#-1,d1			; find last '-'
	moveq	#'_',d2
	xbsr	st_fndcr
	beq.s	found
	moveq	#1,d1
found	move.l	a1,a2
	suba.l	a1,a1
	xbsr	st_splta
	subend

	end
