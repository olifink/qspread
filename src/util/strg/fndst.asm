; find a string in a string				11/09-92 O.Fink

	section string

	include win1_keys_err
	include win1_mac_xref

subr	 macro	  rs
rxx	 setstr   [rs]
[.lab]	 movem.l  [rxx],-(sp)
	 endm
subend	 macro
[.lab]	 movem.l  (sp)+,[rxx]
	 rts
	 endm

	xdef	st_fndst

;+++
; find a string in another string
; abcdefg -> find "de" -> d1=4
;
;		Entry				Exit
;	a0	ptr to string			preserved
;	a1	ptr to string to look for	preserved
;	d0.b	comparison type
;		0=case independant
;		1=case dependant
;	d1.w	scanning position (>0)		position found
;
; error codes:	err.itnf		string not found
;		err.orng		scanning position out of string
; condition codes set
;---
st_fndst subr	a0/a1/d2-d4
	move.w	d1,d3		; d3.w : scanning position
	beq.s	err_range
	subq.w	#1,d3
	move.b	d0,d4		; d4.b : compr. type

	move.w	(a0)+,d0	; search string must be shorter or equal
	move.w	(a1)+,d1
	cmp.w	d1,d0
	blt.s	err_range

	adda.w	d3,a0
	sub.w	d3,d0

lp
	bsr.s	cmp_chr 	; compare the next two characters
	beq.s	found
not_fnd
	addq.w	#1,a0
	addq.w	#1,d3
	subq.w	#1,d0
	cmp.w	d1,d0
	bpl.s	lp

	moveq	#err.itnf,d0
fndst_exit
	addq.w	#1,d3
	move.w	d3,d1
	tst.l	d0
	subend

fndst_ok
	moveq	#0,d0
	bra.s	fndst_exit

found	bsr.s	all_strg
	beq.s	fndst_ok
	bra.s	not_fnd

err_range
	moveq	#err.orng,d0
	bra.s	fndst_exit


all_strg subr	a0/a1/d1
all_lp
	addq.w	#1,a0			; eq=found / ne=not found
	addq.w	#1,a1
	subq.w	#1,d1
	beq.s	all_exit
	bsr.s	cmp_chr
	beq.s	all_lp
all_exit
	subend


cmp_chr subr	d0/d1
	move.b	(a0),d1
	bsr.s	type
	move.b	d1,d0
	move.b	(a1),d1
	bsr.s	type
	cmp.b	d0,d1
	subend

type	subr	d0
	xbsr	st_isa		; is it alphabethic ?
	bne.s	type_x
	tst.b	d4
	bne.s	type_x
	bclr	#5,d1
type_x
	subend

	end
