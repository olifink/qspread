; check filename extension			     V0.01

	include win1_mac_oli

	section utility

	xdef	ut_fextn

;+++
; check if filename ends in extension
; ..otherwise append the extension to the filename
;
;		Entry			Exit
;	a0	ptr to filename 	preserved
;	a1	ptr to extension	preserved
;---
ut_fextn subr	a0/a1/d0-d3
	move.w	(a0),d0 	; max. filenamelength is 36
	add.w	(a1),d0
	cmp.w	#41,d0
	bgt.s	fextn_exit

	move.w	(a1),d0 	; length of file extension
	beq.s	fextn_exit

	move.w	(a0),d1 	; if len(name)<len(extn)..
	sub.w	d0,d1		; ..append it anyway
	blt.s	append

	moveq	#0,d0		; case independent
	xjsr	st_fndst
	beq.s	fextn_exit
append
	xjsr	st_appst
fextn_exit
	subend

	end
