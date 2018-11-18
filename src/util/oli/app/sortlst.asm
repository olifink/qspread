; sort list of pointers

	include win1_mac_oli

	section utility

	xdef	ut_sortlst

;+++
; sort list of string pointers
;
;		Entry				Exit
;	d1.l	0 or nr. of elements
;	a1	ptr to list
;
; errors: imem
; cc set
;+++
ut_sortlst subr    a0-a3/d1-d3
	tst.l	d1
	bne.s	nr_known
	xjsr	ut_cntlst		; count nr of elements
nr_known
	move.l	a1,a0			; a0 final index
	xjsr	ut_allst		; allocate space for temp index
	bne.s	exit
	xjsr	ut_cpylst		; copy to temp list

	move.l	a0,a2			; a2 final running pointer
	move.l	a1,a3			; a3 unsorted list adr
	bra.s	start

again	bsr.s	rival			; get valid rival ptr
	beq.s	eol			; no more rivals.. smallest found
	bsr.s	compare 		; compare rival to smallest
	bpl.s	nochg			; rival is bigger.. no change
	move.l	a0,a1			; rival becomes smallest
nochg	addq.w	#4,a0			; next rival in list
	bra.s	again			; ..try again

eol	move.l	(a1),d0 		; ptr to smallest string
	move.l	d0,(a2)+		; put smallest in final list
	move.l	#1,(a1) 		; blank it out of unsorted list

start	move.l	a3,a0			; first is new rival
	bsr.s	rival			; get a real rival ptr
	beq.s	nomore			; no more rivals found?
	move.l	a0,a1			; first is new smallest
	bra.s	again			; for all elements

nomore	clr.l	(a2)			; end of final list
	move.l	a3,a0
	xjsr	ut_rechp

exit	subend


; mi = eol
; eq = smaller
; ne = no change
compare subr	a0/a1/d1
	move.l	(a0),a0 		; rival string
	move.l	(a1),a1 		; smallest string
	moveq	#1,d0			; basic comparison
	xjsr	st_cmpst		; compare strings
	subend

deleted addq.l	#4,a0			; try next entry
rival	move.l	(a0),d0 		; rival entry
	beq.s	str_eol 		; end of list reached
	cmp.l	#1,d0			; rival deleted?
	beq.s	deleted
str_eol rts

	end
