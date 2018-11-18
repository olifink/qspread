; General conversion routines for jobs (2)		19/12-91 O.Fink

	include win1_keys_qlv

	section utility

	xdef	ut_fpdec	; floating point to decimal
	xdef	ut_iwdec	; integer word to decimal
	xdef	ut_ibbin	; integer byte to binary
	xdef	ut_iwbin	; integer word to binary
	xdef	ut_ilbin	; integer long to binary
	xdef	ut_ibhex	; integer byte to hex
	xdef	ut_iwhex	; integer word to hex
	xdef	ut_ilhex	; integer long to hex
	xdef	ut_tostr	; general conversion

;+++
; Standard routines to convert values to strings
;
;		Entry				Exit
;	a0	pointer to string space 	preserved
;	a1	pointer to value (6 bytes)	preserved
;
;	error codes: err.xp
;	condition codes set
;---
ut_fpdec
	move.l	a2,-(sp)
	move.w	cv.fpdec,a2
	bsr.s	ut_tostr
exit
	tst.w	(a0)		; empty string?
	beq.s	really_exit
	cmp.w	#'-.',2(a0)	; bad negative display?
	bne.s	really_exit
	movem.l d1/a0,-(sp)	; preserve work regs
	move.w	(a0)+,d1	; length
loop
	move.b	-1(a0,d1.w),(a0,d1.w) ; shift up string
	dbra	d1,loop
	movem.l (sp)+,d1/a0
	move.w	#'-0',2(a0)	; fill in '-0' instead of '-.'
	addq.w	#1,(a0) 	; one more character
really_exit
	tst.l	d0
	move.l	(sp)+,a2
	rts

ut_iwdec
	move.l	a2,-(sp)
	move.w	cv.iwdec,a2
	bsr.s	ut_tostr
	bra.s	exit

ut_ibbin
	move.l	a2,-(sp)
	move.w	cv.ibbin,a2
	bsr.s	ut_tostr
	bra.s	exit

ut_iwbin
	move.l	a2,-(sp)
	move.w	cv.iwbin,a2
	bsr.s	ut_tostr
	bra.s	exit

ut_ilbin
	move.l	a2,-(sp)
	move.w	cv.ilbin,a2
	bsr.s	ut_tostr
	bra.s	exit

ut_ibhex
	move.l	a2,-(sp)
	move.w	cv.ibhex,a2
	bsr.s	ut_tostr
	bra.s	exit

ut_iwhex
	move.l	a2,-(sp)
	move.w	cv.iwhex,a2
	bsr.s	ut_tostr
	bra.s	exit

ut_ilhex
	move.l	a2,-(sp)
	move.w	cv.ilhex,a2
	bsr.s	ut_tostr
	bra.s	exit

;+++
; Convert a value (in internal format) to a standard string
;
;		Entry				Exit
;	a0	points to string space		preserved
;	a1	pointer to value		preserved
;	a2	vector				preserved
;
;	error and condition code set
;---
r_tostr reg	a0-a6/d1-d3/d7
f_tostr equ	50			; stack frame
ut_tostr
	movem.l r_tostr,-(sp)
	move.l	a0,a3			; store call value
	move.l	a1,a4

* get some workspace
	lea	-6(a7),a1		; new RI stack
	suba.l	#f_tostr,a7		; reframe SP
	move.l	a7,a0			; buffer is on bottom of stack
	suba.l	a6,a6			; all is rel. to a6

	move.l	(a4),(a1)		; copy value
	move.w	4(a4),4(a1)		; always 6 bytes
	bsr.s	sub_conv		; the real conversion
	bsr.s	sub_cinf		; convert from internal format

	adda.l	#f_tostr,a7		; remove stack frame
	movem.l (sp)+,r_tostr
	tst.l	d0
	rts

*+++
* copy from internal format to string
*
*		Entry				Exit
*	a0	ptr to buffer			preserved
*	a3	ptr to string			preserved
*	d1	length of buffer		preserved
*
*---
r_cinf	reg	a0/a3/d0
sub_cinf
	movem.l  r_cinf,-(sp)
	move.w	d1,(a3)+		; length of string
	bra.s	cinf_end		; copy the characters
cinf_lp
	move.b	(a0)+,(a3)+
cinf_end
	dbra	d1,cinf_lp
	movem.l  (sp)+,r_cinf
	rts

*+++
* call conversion routine
*
*		Entry				Exit
*	a0	ptr to buffer (rel. a6) 	preserved
*	a1	ptr to RI-stack (rel. a6)	preserved
*	a2	vector
*	d1.w					length of buffer
*
*	error codes: err.xp
*---
r_conv	reg	d2/d3/a0/a1/a2/a3
sub_conv
	movem.l r_conv,-(sp)
	jsr	(a2)
	move.l	a0,d1			; updated buffer
	movem.l (sp)+,r_conv
	move.l	d2,-(sp)
	move.l	a0,d2
	sub.l	d2,d1			; total length of buffer
	move.l	(sp)+,d2
	tst.l	d0
	rts


	end
