* pulldown a standard submenu				13/07-92
*

	include win1_keys_wman
	include win1_keys_wstatus
	include win1_keys_wwork
	include win1_keys_wdef_long
	include win1_mac_oli
	include win1_keys_qdos_pt

	section utility

	xdef	pld_smen		; pulldown a standard submenu

*+++
* pulldown a submenu and perform action
*
*	d0				error, or menu number (if no actn)
*	d1 : main colourway
*	a0 : (channel id) or 0
*	a1 : ptr to submenu info block
*	a2 : (wmvec, if a0<>0)
*	a3 : (ptr to loose item, if a0<>0)
*	a4 : (wwork, if a0<>0)
*---
mib_name equ	$00		l rel ptr to menu name
mib_cmds equ	$04		l rel ptr to menu contents
mib_actn equ	$08		l rel ptr to action tables (or 0)
r_adr	reg	a0-a3
pld_smen subr a0-a5/d1-d5
;
; draw menu extension select list
	movem.l r_adr,-(sp)
	move.l	d1,d2		; colourway
	swap	d2
	move.w	d1,d2
	moveq	#1,d3		; selection key highlight
	moveq	#-1,d1
	move.l	a3,d0		; posn rel. to pointer
	beq.s	puld_ok
	move.l	wwl_xorg(a3),d1 ; position at loose item
puld_ok
	suba.l	a3,a3
	moveq	#0,d4		; nr col/lines
	moveq	#1,d5		; rel. defined array
	lea	mib_name(a1),a0 ; menu name
	add.l	(a0),a0
	lea	mib_cmds(a1),a2 ; menu items
	add.l	(a2),a2
	xjsr	mu_listsl
	movem.l (sp)+,r_adr
	bmi.s	puld_err	; error occured during pulldown

;
; try to access action routines, if supplied
	lea	mib_actn(a1),a1
	move.l	(a1),d0 	; action list supplied?
	beq.s	no_actn
	tst.w	d3
	bmi.s	puld_skip	; esc selected... skip action
;
; find appropriate routine
	add.l	d0,a1		; action list
	mulu	#4,d3
	lea	0(a1,d3.l),a1	; ptr to action
	move.l	(a1),d0
	beq.s	puld_skip	; no action routine supplied, skip
	add.l	d0,a1
	bsr.s	puld_rdw
	jsr	(a1)		; execute action routine
;
; general exit
puld_err
	tst.l	d0
	subend


puld_rdw subr	  d0-d3/a1
	move.l	a0,d0
	beq.s	rdw_no
	move.l	ww_wstat(a4),a1 ; set ptr to status routine
	cmpa.l	#0,a3		; was it a loose item?
	beq.s	cibdr
	xjsr	ut_rdwci	; redraw loose item
cibdr
	xjsr	xwm_clbdr
rdw_no
	 subend

puld_skip
	bsr.s	puld_rdw
	moveq	#0,d0
	moveq	#0,d4
	bra.s	puld_err

no_actn
	bsr.s	puld_rdw
	moveq	#0,d4
	move.w	d3,d0
	addq.w	#1,d0
	bra.s	puld_err
	end
