; Clear the Scrap
;					28/05-92 O.Fink

	section utility

	include win1_keys_thg
;;;	   include win1_keys_scrap

	xdef	sc_clr

	xref	ut_usscp
	xref	ut_frscp
;+++
; Clear the scrap
;
;		Entry				Exit
;
;	Error returns:	ERR.NI	Thing or THING not implemented
;---
r_clr	 reg	 d4/a0-a4
sc_clr
	movem.l r_clr,-(sp)

	movem.l d1-d2,-(sp)
	move.l	#'CLR ',d2		; we need report error
	bsr	ut_usscp		; try to use Scrap Thing
	movem.l (sp)+,d1-d2
	tst.l	d0
	bne.s	no_scrap		; failed

	jsr	thh_code(a1)		; clear it

	bsr	ut_frscp		; and free Scrap Extension
no_scrap
	movem.l (sp)+,r_clr
	rts
	end
