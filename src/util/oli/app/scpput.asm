; Put something into the Scrap
;					28/05-92 O.Fink

	section utility

	include win1_keys_thg
;;;	   include win1_keys_scrap


	xdef	sc_put

	xref	ut_usscp
	xref	ut_frscp
;+++
; Put something into the scrap
;
;		Entry				Exit
;	d1.b	type of data			preserved
;	d2.l	add string flag / len. of data	preserved
;	a0	base address of data		preserved
;	a2	user copy code			preserved
;
;	Error returns:	ERR.NI	Thing or THING not implemented
;---
scp_dtyp equ	 3
scp_styp equ	$4
scp_strg equ	$8
scp_flln equ	$c
scp_uccd equ	$10
stk_frm equ	24			; room for parameter table
r_put	reg    d1-d4/a0-a4
sc_put
	movem.l r_put,-(sp)

	movem.l d1-d2,-(sp)
	move.l	#'PUT ',d2
	bsr	ut_usscp		; try to use Scrap Thing
	movem.l (sp)+,d1-d2
	tst.l	d0
	bne.s	no_scrap		; failed

	move.l	a1,a4
	suba.l	#stk_frm,sp
	move.l	sp,a1
	move.b	d1,scp_dtyp(a1) 	; type of data
	tst.b	d1
	bne.s	put_graf

	move.w	#thp.call+thp.str,scp_styp(a1)	      ; put text
	bra.s	put_data
put_graf
	move.w	#thp.call+thp.slng,scp_styp(a1)
put_data
	move.l	a0,scp_strg(a1)

	move.l	d2,scp_flln(a1)
	move.l	a2,scp_uccd(a1)

	jsr	thh_code(a4)		; clear it
	adda.l	#stk_frm,sp
	bsr	ut_frscp		; and free Scrap Extension
no_scrap
	movem.l (sp)+,r_put
	rts
	end
