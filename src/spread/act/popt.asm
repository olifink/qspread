* propt Mon, 1992 Apr 06 19:58:15
*    - popt pulldown

	include win1_keys_wman
	include win1_keys_wstatus
	include win1_keys_wwork
	include win1_keys_wdef_long
	include win1_keys_qdos_pt
	include win1_mac_oli
	include win1_spread_keys

	section prog

	xdef	pld_popt,ini_popt,edt_strg
	xdef	mea_pook,mea_poes,mea_poef,mea_poif
	xdef	mea_popw,mea_popl,mea_popp,mea_popf
	xdef	mea_prpica
	
	xref	cfg_prtl,cfg_prtw,cfg_prtff,cfg_prtdraft

	xref.l	mv_popp,mv_popf
	xref.l	mv_popl,mv_popw,mv_poif,mv_poef,wwa.popt,wst_popt

	xref.s	mli.popp,mli.popf
	xref.s	mli.popw,mli.popl,mli.poif,mli.poef,mli.prff
	xref.s	mli.prpica,mli.prelit,mli.prcond,mli.prdraf

	section prog

;+++
; Pica, Elite, Condensed radio buttons
;---
mea_prpica
	move.w	wwl_item(a3),d3 	; item number
	lea	pica_list,a3		; the button list
	xjsr	wu_radio
	moveq	#-1,d3
	jmp	wm.ldraw(a2)		; redraw changes

pica_list dc.w	mli.prpica,mli.prelit,mli.prcond,-1

;
; init printer options
ini_popt subr	a0/a1/d1/d2
	moveq	#0,d0
	xlea	cfg_prtcpi,a1
	move.b	(a1),d0
	lea	wst_popt(a6),a1
	move.b	#wsi.slct,ws_litem+mli.prpica(a1,d0.w)
	move.b	cfg_prtff,ws_litem+mli.prff(a1)
	move.b	cfg_prtdraft,ws_litem+mli.prdraf(a1)
	lea	mv_popp(a6),a0
	xlea	cfg_prtp,a1
	xjsr	ut_cpyst
	lea	mv_popf(a6),a0
	xlea	cfg_prtf,a1
	xjsr	ut_cpyst
	lea	mv_popw(a6),a1
	move.l	a1,a0
	move.w	cfg_prtw,(a0)+
	xjsr	ut_iwdec
	lea	mv_popl(a6),a1
	move.l	a1,a0
	move.w	cfg_prtl,(a0)+
	xjsr	ut_iwdec
	subend


; setup, draw, read and then unset menu
; (returns with k.cancel/k.do in d4, according to ok/esc)
r_pld	reg	a0-a5/d1-d4
pld_popt
	movem.l r_pld,-(sp)
	move.l	#wwa.popt,d1
	moveq	#0,d2
	move.l	ww_wstat(a4),a1
	move.l	wsp_xpos(a1),d4
	add.l	ww_xorg(a4),d4
	lea	wst_popt(a6),a1
	xlea	men_popt,a3
	lea	puld_chg(pc),a4 		; setup postprocessing
	suba.l	a5,a5				; draw postprocessing
	xjsr	ut_pullf
	movem.l (sp)+,r_pld
	tst.l	d0
	rts

*
* change wwork
puld_chg
	 movem.l  d3/a1/d1/d0,-(sp)
;;;	    move.b   colm(a6),d0
;;;	     andi.l   #$F,d0
;;;	    xjsr     ut_ccwwd			; change main colourway

	 lea	  mv_popp(a6),a1
	 moveq	  #mli.popp,d1
	 jsr	  wm.stlob(a2)
	 lea	  mv_popf(a6),a1
	 moveq	  #mli.popf,d1
	 jsr	  wm.stlob(a2)
	 lea	  mv_popw+2(a6),a1
	 moveq	  #mli.popw,d1
	 jsr	  wm.stlob(a2)
	 lea	  mv_popl+2(a6),a1
	 moveq	  #mli.popl,d1
	 jsr	  wm.stlob(a2)
	 lea	  mv_popf(a6),a1
	 moveq	  #mli.popf,d1
	 jsr	  wm.stlob(a2)
	 lea	  mv_poif(a6),a1
	 moveq	  #mli.poif,d1
	 jsr	  wm.stlob(a2)
	 lea	  mv_poef(a6),a1
	 moveq	  #mli.poef,d1
	 jsr	  wm.stlob(a2)
	 movem.l  (sp)+,d3/a1/d1/d0
	 rts

*
* OK/ESCape from menu
mea_pook
	 bsr	  unselect
	 bset	  #pt..do,wsp_weve(a1)
	 moveq	  #pt..do,d4
	 moveq	  #0,d0
	 rts
mea_poes
	 bsr	  unselect
	 bset	  #pt..can,wsp_weve(a1)
	 moveq	  #pt..can,d4
	 moveq	  #0,d0
	 rts

loos_ret
	 moveq	  #0,d0
	 moveq	  #0,d4
	 rts


r_loos	 reg	  a0-a4/d1/d2/d4
mea_popw
	 movem.l  r_loos,-(sp)
	 bsr	  unselect
	 move.w   wwl_item(a3),d1
	 lea	  mv_popw+2(a6),a3

popw_lp
	 move.l   #$01000028,d2
	 xjsr	  edt_unum
	 bmi.s	  popw_lp

	 move.w   d3,mv_popw(a6)
	 movem.l  (sp)+,r_loos
	 bra.s	  loos_ret

mea_popl
	 movem.l  r_loos,-(sp)
	 bsr.s	  unselect
	 move.w   wwl_item(a3),d1
	 lea	  mv_popl+2(a6),a3

popl_lp
	 move.l   #$00c8000a,d2
	 xjsr	  edt_unum
	 bmi.s	  popl_lp

	 move.w   d3,mv_popl(a6)
	 movem.l  (sp)+,r_loos
	 bra.s	  loos_ret

edt_strg
	 movem.l  r_loos,-(sp)
	 bsr.s	  unselect
	 move.w   wwl_item(a3),d1
	 move.l   wwl_pobj(a3),a3
	 xjsr	  mu_swrds
	 beq.s	  edt_strg_rts

	 xjmp	  kill

edt_strg_rts
	 movem.l  (sp)+,r_loos
	 rts

mea_poif
	movem.l a0-a4/d1-d5,-(sp)
	lea	txt_imf,a4
	move.l	a4,d4
	bra.s	sel_filter

mea_poef
	movem.l a0-a4/d1-d5,-(sp)
	lea	txt_exf,a4
	move.l	a4,d4
	bra.s	sel_filter

mea_popf
	movem.l a0-a4/d1-d5,-(sp)
	moveq	#0,d4
sel_filter
	bsr.s	pof_selc
	movem.l (sp)+,a0-a4/d1-d5
unselect
	xjmp	 ut_rdwci

mea_popp
	 bsr	  edt_strg
	 bra	  loos_ret

pof_selc
	move.w	wwl_item(a3),d0
	move.l	wwl_pobj(a3),a2 		; default name and buffer

	lea	da_fltd(a6),a3			; assume filter directory
	xlea	met_pflt,a0
	sub.w	#mli.popf,d0			; was printer filter selected?
	bne.s	noprt

	lea	da_prtd(a6),a3			; use printer directory
	xlea	met_pprt,a0

noprt
	move.l	a2,a4
	moveq	#-1,d1
	move.l	da_cway(a6),d2
	moveq	#0,d5
	xjsr	mu_fsel
	moveq	#0,d0
	rts

txt_imf
	dc.w	4,'_imf'
txt_exf
	dc.w	4,'_exf'

	end
