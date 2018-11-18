* Cell protection
*

	include win1_mac_oli
	include win1_spread_keys

	section prog

	xdef	acc_prct,acc_upct	; protect and unprotect
	xdef	is_proct		; check for protection

;+++
; check cell for protection
;		Entry			Exit
;	d0				0=protected, 1=unprotected
;	d1.l	c|r
;---
is_proct subr	a1
	suba.l	a1,a1			; get format word only
	xjsr	acc_getf
	bmi.s	isp_np

	swap	d0
	btst	#fw..prct,d0		; set protection bit
	beq.s	isp_np

	moveq	#0,d0

isp_exit
	subend

isp_np	moveq	#1,d0
	bra.s	isp_exit



;+++
; protect one cell
;
;		Entry			Exit
;	d1.l	c|r
;---
acc_prct subr	a1/d2
	suba.l	a1,a1			; get format word only
	xjsr	acc_getf
	bmi.s	prct_exit

	move.l	d0,d2
	swap	d2
	bset	#fw..prct,d2		; set protection bit
	xjsr	acc_fwrd		; write format word back

prct_exit
	subend


;+++
; unprotect one cell
;
;		Entry			Exit
;	d1.l	c|r
;---
acc_upct subr	a1/d2
	suba.l	a1,a1			; get format word only
	xjsr	acc_getf
	bmi.s	upct_exit

	move.l	d0,d2
	swap	d2
	bclr	#fw..prct,d2		; clear protection bit
	xjsr	acc_fwrd		; write format word back

upct_exit
	subend

	end
