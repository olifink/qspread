; Password handling		2001 Jochen Merz

	section action

	include win1_spread_keys
	include win1_mac_xref
	include win1_keys_wman
	include win1_keys_wstatus
	include win1_keys_wwork
	include win1_keys_err

	xdef	mea_password	; action routine for main window
	xdef	check_password	; verification for load

	xref.s	mli.password
	xref.l	wst_main

; set or replace current password (in main menu)
mea_password
	movem.l d1-d3/a0-a3,-(sp)
	tst.l	v_password(a6)	; do we have a password set?
	beq.s	new_password	; no, request new password

	xlea	met_paswrd,a2	; request
	lea	da_buff+100(a6),a3 ; buffer
	bsr	get_password
	bgt.s	password_esc
	move.l	a3,a0
	xjsr	ut_password	; convert string to password value
	cmp.l	v_password(a6),d1
	beq.s	new_password
	xlea	met_paswrong,a0
	bsr	report_error
	bra.s	password_exit

new_password
	xlea	met_paswd1,a2	; new password
	lea	da_buff+100(a6),a3 ; buffer
	bsr.s	get_password
	bgt.s	password_esc

	xlea	met_paswd2,a2	; new password
	lea	da_buff+160(a6),a3 ; buffer
	bsr.s	get_password
	bgt.s	password_esc

	lea	da_buff+100(a6),a0 ; password 1
	lea	da_buff+160(a6),a1 ; password 2
	moveq	#2,d0		; we need exact comparison
	xjsr	st_cmpst
	beq.s	password_set
	xlea	met_pasdiff,a0
	bsr.s	report_error
	bra.s	new_password

password_set
	lea	da_buff+100(a6),a0
	xjsr	ut_password	; convert string to password value
	move.l	d1,v_password(a6) ; and set new password

password_exit
	moveq	#wsi.mkav,d1
	tst.l	v_password(a6)	; any password set?
	beq.s	password_notset
	moveq	#wsi.mksl,d1
password_notset
	move.b	d1,wst_main+ws_litem+mli.password(a6) ; assume no pw
	movem.l (sp)+,d1-d3/a0-a3
	moveq	#-1,d3				; redraw selective
	moveq	#0,d4				; no event
	jmp	wm.ldraw(a2)

password_esc
	tst.l	v_password(a6)	; any password set?
	beq.s	password_exit	; no, just exit
	xlea	met_pasesc,a0
	bsr.s	report_error
	bra.s	password_exit

get_password
	moveq	#-1,d1		; origin
;;;	   move.b  colm(a6),d2	   ; colour
	moveq	#0,d2
	move.l	#$00800010,d3	; password request plus length
	xlea	met_pastit,a0	; title
	clr.w	(a3)		; .. which starts empty
	xjsr	mu_reqst
	tst.l	d0
	rts

report_error
	move.l	a0,d0
	bset	#31,d0
	moveq	#-1,d1		; origin
;;;	   move.b  colm(a6),d2	   ; colour
	moveq	#0,d2
	xjmp	mu_rperr

;+++
; Request password until it matches password provided in D2.
;
;		Entry			Exit
;	d2.l	password		preserved
;---
check_password
	movem.l d1-d3/a0-a4,-(sp)
check_loop
	xlea	met_paswrd,a2	; request
	lea	da_buff+100(a6),a3 ; buffer
	bsr	get_password
	bgt.s	die
	move.l	a3,a0
	xjsr	ut_password	; convert string to password value
	moveq	#0,d0
	cmp.l	4(sp),d1	; same as pw provided in D2?
	beq.s	check_same
	xlea	met_paswrong,a0
	bsr	report_error
	bra.s	check_loop
check_same
	movem.l (sp)+,d1-d3/a0-a4
	rts

die
	xlea	met_paswrong,a0
	move.l	a0,d0
	bset	#31,d0
	tst.l	d0
	bra.s	check_same

	end
