; General conversion routines for jobs

	include win1_keys_qlv

	section utility

	xdef	ut_decfp	; decimal to floating point
	xdef	ut_deciw	; decimal to integer word
	xdef	ut_binib	; binary to integer byte
	xdef	ut_biniw	; binary to integer word
	xdef	ut_binil	; binary to integer long
	xdef	ut_hexib	; hex to integer byte
	xdef	ut_hexiw	; hex to integer word
	xdef	ut_hexil	; hex to integer long
	xdef	ut_toval	; general conversion

;+++
; Standard routines to convert strings to values
;
;		Entry				Exit
;	a0	pointer to string		preserved
;	a1	pointer to free space (6 bytes) preserved (now result)
;
;	error codes: err.xp
;	condition codes set
;---
ut_decfp
	move.l	a2,-(sp)
	move.w	cv.decfp,a2
	bsr.s	ut_toval
exit	move.l	(sp)+,a2
	rts

ut_deciw
	move.l	a2,-(sp)
	move.w	cv.deciw,a2
	bsr.s	ut_toval
	bra.s	exit

ut_binib
	move.l	a2,-(sp)
	move.w	cv.binib,a2
	bsr.s	ut_toval
	bra.s	exit

ut_biniw
	move.l	a2,-(sp)
	move.w	cv.biniw,a2
	bsr.s	ut_toval
	bra.s	exit

ut_binil
	move.l	a2,-(sp)
	move.w	cv.binil,a2
	bsr.s	ut_toval
	bra.s	exit

ut_hexib
	move.l	a2,-(sp)
	move.w	cv.hexib,a2
	bsr.s	ut_toval
	bra.s	exit

ut_hexiw
	move.l	a2,-(sp)
	move.w	cv.hexiw,a2
	bsr.s	ut_toval
	bra.s	exit


ut_hexil
	move.l	a2,-(sp)
	move.w	cv.hexil,a2
	bsr.s	ut_toval
	bra.s	exit

;+++
; Convert standard number string to a value (in internal format)
;
;		Entry				Exit
;	a0	points to string		preserved
;	a1	pointer to free space (6 bytes) points to result
;	a2	vector				preserved
;
;	error and condition code set
;---
r_toval reg	a0-a6/d1-d3/d7
f_toval equ	50			; stack frame
ut_toval
	movem.l r_toval,-(sp)
	move.l	a0,a3			; store call value
	move.l	a1,a4

* get some workspace
	lea	-6(a7),a1		; new RI stack
	suba.l	#f_toval,a7		; reframe SP
	move.l	a7,a0			; buffer is on bottom of stack
	suba.l	a6,a6			; all is rel. to a6

	bsr.s	sub_cinf		; copy string to internal format
	bsr.s	sub_conv		; the real conversion

	move.l	(a1)+,(a4)+		; set the return value
	move.w	(a1)+,(a4)+
	adda.l	#f_toval,a7		; remove stack frame
	movem.l (sp)+,r_toval
	tst.l	d0
	rts

*+++
* copy from string to internal format (chars+0)
*
*		Entry				Exit
*	a0	ptr to buffer			preserved
*	a3	ptr to string			preserved
*
*---
r_cinf	reg	a0/a3/d0
sub_cinf
	movem.l  r_cinf,-(sp)
	move.w	(a3)+,d0		; length of string
	bra.s	cinf_end		; copy the characters
cinf_lp
	move.b	(a3)+,(a0)+
cinf_end
	dbra	d0,cinf_lp
	move.b	#0,(a0)+		; end of this item
	movem.l  (sp)+,r_cinf
	rts

*+++
* call conversion routine
*
*		Entry				Exit
*	a0	ptr to buffer (rel. a6) 	preserved
*	a1	ptr to RI-stack (rel. a6)	updated
*	a2	vector
*
*	error codes: err.xp
*---
r_conv	reg	d1-d3/d7/a0/a2/a3
sub_conv
	movem.l r_conv,-(sp)
	moveq	#0,d7
	jsr	(a2)
	tst.l	d0
	movem.l (sp)+,r_conv
	rts


	end
