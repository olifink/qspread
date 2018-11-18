* QMail Sun, 1992 Jul 12
*    - Extended window manager functions

	include win1_keys_wman
	include win1_keys_wstatus
	include win1_keys_wwork
	include win1_keys_wdef_long
	include win1_keys_err
	include win1_keys_qdos_io
	include win1_mac_oli

	section utility

	xdef	xwm_swio		; set window to info object

*+++
* set window to info window object
* (attributes are set accordingly, window not cleared)
*
*	d1.l : iwindw | iobj
*	a0				a0 : channel id
*	a4 : wwork			(preserved)
*---
xwm_swio subr a1-a3/d1-d5
	move.l	ww_chid(a4),a0		; window channel id
	move.l	ww_xorg(a4),d4		; abs. window position
	move.l	ww_pinfo(a4),a3 	; info window list
	move.l	d1,d2
	swap	d2
	mulu	#wwi.elen,d2
	adda.w	d2,a3			; our info window
	move.w	wwi_watt+wwa_papr(a3),d5 ; paper colour
	add.l	wwi_xorg(a3),d4 	; abs. posn of iwindw
	move.l	wwi_pobl(a3),a3 	; ptr. to obj list
	mulu	#wwo.elen,d1
	adda.w	d1,a3			; ptr. to our obj
	add.l	d4,wwo_xorg(a3) 	; make pos. absolut

	moveq	#iow.defw,d0		; define window
	moveq	#0,d1
	moveq	#0,d2
	lea	wwo_xsiz(a3),a1
	xjsr	do_io
	sub.l	d4,wwo_xorg(a3) 	; make window abs. again
	tst.l	d0
	bne.s	swio_exit

	moveq	#0,d1			; set attributes
	tst.b	wwo_type(a3)		; test object type
	bne.s	no_text
	move.w	wwo_ink(a3),d1
no_text
	moveq	#iow.sink,d0		; set ink
	jsr	do_io
	bne.s	swio_exit

	move.w	d5,d1
	moveq	#iow.spap,d0		; set paper
	jsr	do_io
	bne.s	swio_exit

	move.w	d5,d1
	moveq	#iow.sstr,d0		; set strip
	jsr	do_io
	bne.s	swio_exit

	moveq	#0,d1			; set overwrite attr
	moveq	#iow.sova,d0
	jsr	do_io
;;;	   bne.s   swio_exit

swio_exit
	tst.l	d0
	subend

	end
