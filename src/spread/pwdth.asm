; column width
;

	include win1_mac_oli
	include win1_spread_keys

	section prog

	xdef	fnd_pwdt		; find perfect col width
	xdef	set_pwdt

;+++
; find perfect colum width
;
;		Entry			Exit
;	d1.l	col|(row)		preserved
;	d2				perfect widths
;---
fnd_pwdt subr	a1/d1/d3/d4
	move.w	da_cby0(a6),d1		; first row
	move.w	da_cby1(a6),d4		; last row
	bpl.s	pw_lok

	move.w	d1,d4			; first=last

pw_lok
	moveq	#0,d2			; assume smallest possible width

pw_lp	suba.l	a1,a1			; just wanna know the length
	xjsr	acc_cont		; get cell contents
	bne.s	pw_lpe

	cmp.w	d2,d3
	bls.s	pw_lpe

	cmp.w	#59,d3
	bgt.s	pw_lpe

	move.w	d3,d2

pw_lpe
	cmp.w	d1,d4
	beq.s	pw_exit

	addq.w	#1,d1
	bra.s	pw_lp

pw_exit
	moveq	#0,d0
	subend


;+++
; set perfect column width
;
;		Entry			Exit
;	d1.l	col|(row)
;---
set_pwdt subr	d1/d2
	bsr	fnd_pwdt		; find perfect width
	tst.w	d2			; leave it unchanged
	beq.s	set_no

	cmp.w	#1,d2			; one char is ok
	beq.s	set_do

	addq.w	#1,d2

set_do
	xjsr	acc_wdth		; set column width

set_no	subend


	end
