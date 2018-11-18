* spread	Thu, 1992 Apr 30 15:47:14
*    - macro pulldown

	include win1_keys_wman
	include win1_keys_wstatus
	include win1_keys_wwork
	include win1_keys_wdef_long
	include win1_keys_qdos_pt
	include win1_keys_k
	include win1_Spread_keys
	include win1_mac_oli

	section prog

	xdef	pld_macr
	xdef	mea_mcnr
	xdef	ini_macr

	
	xref	cfg_mcn1,cfg_mcn2,cfg_mcn3,cfg_mcn4,cfg_mcn5

	xref.s	mli.mcn1,mli.mcn2,mli.mcn3,mli.mcn4,mli.mcn5

	xref.l	wwa.macr,wst_macr,mv_mcnr,mv_mcmd

	section prog

; setup, draw, read and then unset menu
; (returns with k.cancel/k.do in d4, according to ok/esc)
r_pld	reg	a0-a5/d1-d3
pld_macr
	movem.l r_pld,-(sp)
	move.l	 wsp_xpos(a1),d4
	add.l	 ww_xorg(a4),d4
	move.l	#wwa.macr,d1
	moveq	#0,d2
	lea	wst_macr(a6),a1
	xlea	men_macr,a3
	lea	spp_macr(pc),a4 		; setup postprocessing
	suba.l	a5,a5				; draw postprocessing
	xjsr	ut_pullf

pld_exit
	movem.l (sp)+,r_pld
	bsr.s	do_macr
	tst.l	d0
	rts

do_macr subr	d1/d0
	tst.l	d0
	bne.s	do_exit

	move.w	mv_mcmd(a6),d1		     ; any macro modes set?
	bpl.s	do_exit

	move.w	d1,d0
	xjsr	mod_macr
	moveq	#0,d0

do_exit
	subend

spp_macr subr	  a1
;;;	    move.b   colm(a6),d0	       ; adjust colourway
;;;	    andi.l   #$f,d0
;;;	    xjsr     ut_ccwwd

	 clr.w	  mv_mcmd(a6)
	 moveq	  #mli.mcn1,d1		     ; set actual items
	 lea	  mv_mcnr(a6),a1
	 jsr	  wm.stlob(a2)
	 bne.s	  spp_exit

	 moveq	  #mli.mcn2,d1		     ; set actual items
	 adda.w   #80,a1
	 jsr	  wm.stlob(a2)
	 bne.s	  spp_exit

	 moveq	  #mli.mcn3,d1		     ; set actual items
	 adda.w   #80,a1
	 jsr	  wm.stlob(a2)
	 bne.s	  spp_exit

	 moveq	  #mli.mcn4,d1		     ; set actual items
	 adda.w   #80,a1
	 jsr	  wm.stlob(a2)
	 bne.s	  spp_exit

	 moveq	  #mli.mcn5,d1		     ; set actual items
	 adda.w   #80,a1
	 jsr	  wm.stlob(a2)

spp_exit
	 subend

ini_macr subr	  a0/a1
	 lea	  cfg_mcn1,a1		     ; copy defaults
	 lea	  mv_mcnr(a6),a0
	 xjsr	  ut_cpyst
	 lea	  cfg_mcn2,a1		     ; copy defaults
	 adda.w   #80,a0
	 xjsr	  ut_cpyst
	 lea	  cfg_mcn3,a1		     ; copy defaults
	 adda.w   #80,a0
	 xjsr	  ut_cpyst
	 lea	  cfg_mcn4,a1		     ; copy defaults
	 adda.w   #80,a0
	 xjsr	  ut_cpyst
	 lea	  cfg_mcn5,a1		     ; copy defaults
	 adda.w   #80,a0
	 xjsr	  ut_cpyst
	 subend

mea_mcnr
	 bsr.s	  unselect
	 cmp.b	  #k.do,d2		     ; was it a do keystroke?
	 bne.s	  mcnr_mod

	 xjsr	  edt_strg		     ; edit string in item
	 moveq	  #0,d4
	 moveq	  #0,d0
	 rts

mcnr_mod
	 move.w   wwl_item(a3),d4	     ; set macro mode
	 neg.w	  d4			     ; macro number as event
	 move.w   d4,mv_mcmd(a6)
	 moveq	  #pt..can,d4
	 bset	  #pt..can,wsp_weve(a1)
	 moveq	  #0,d0
	 rts

unselect subr	  d2/d3
	 xjsr	  ut_rdwie
	 subend


	end
