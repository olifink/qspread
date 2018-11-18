; create menu lists from array

	section utility

	include win1_mac_oli
	include win1_keys_wwork
	include win1_keys_err

	xdef	xwm_mkrl

;+++
; create menu lists from 2 dim array
;
;		Entry			Exit
;	d1	array type (0=abs/1=rel) max. item string length
;	d2	1=make selkeys		 nr of items
;	a0	array desctiptor	 status area
;	a1	item action routine	 row list pointer
;---
xwm_mkrl subr	a3/d3/d4/d5
	move.l	a0,d0
	beq.s	exit
	moveq	#err.ipar,d0
	cmpi.w	#2,4(a0)		; 2-dim-arr?
	bne.s	exit
	move.l	(a0),a3 		; a0 ptr to array contents
	tst.b	d1
	beq.s	absarr
	adda.l	a0,a3			; make array absolute
absarr	move.l	d2,d5
	move.l	a1,d4			; d4 item action
	moveq	#1,d2
	add.w	6(a0),d2		; d2 nr of items
	move.w	8(a0),d3		; d3 offset beween elements
	move.w	10(a0),d1		; d1 maximum item length
	bsr.s	res_space
	bne.s	exit
	bsr.s	row_creat		; create row list
	moveq	#0,d0
exit	subend


res_space subr	a0/d1
	moveq	#wwm.olen+wwm.rlen+1,d1 ; space for objects, status..
	mulu	d2,d1			; ..and row list
	xjsr	ut_alchp
	move.l	a0,a1
	tst.l	d0
	subend

row_creat subr	a1/d1/a3
	moveq	#wwm.rlen,d1
	mulu	d2,d1
	lea	(a1,d1.l),a0		; ptr to object list
	move.w	d2,d1			; d1=counter
	bra.s	rw_lpe
rw_lp	move.l	a0,(a1)+		; wwm_rows
	adda.l	#wwm.olen,a0		; next object
	move.l	a0,(a1)+		; wwm_rowe
rw_lpe	dbra	d1,rw_lp
	move.w	d2,d1
	moveq	#0,d0			; item number count
	bra.s	obj_lpe
obj_lp	move.w	#$0100,(a1)+		; xjst,yjst
	tst.l	d5
	bne.s	dokeys
	clr.w	(a1)+			; type text, no selkey
ptritm	move.l	a3,(a1)+		; ptr to object
	move.w	d0,(a1)+		; item number
	move.l	d4,(a1)+		; item action
	addq.w	#1,d0			; next item
	adda.w	d3,a3			; next object
obj_lpe dbra	d1,obj_lp
	move.l	a1,a0
	subend

dokeys	push	d1
	move.b	#-1,(a1)+
	move.b	2(a3),d1
	bclr	#5,d1
	move.b	d1,(a1)+
	pop	d1
	bra.s	ptritm
	end
