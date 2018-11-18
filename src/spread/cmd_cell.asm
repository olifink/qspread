* Spreadsheet					      28/01-91
*	 - cell command routines

	 section  prog

	 include  win1_keys_wman
	 include  win1_keys_wstatus
	 include  win1_keys_wwork
	 include  win1_keys_err
	 include  win1_mac_oli
	 include  win1_spread_keys

	 xdef	  cls_eras,cls_just,cls_justl,cls_justr
	 xdef	  cls_unit,cls_msym
	 xdef	  cel_cgfw,cls_prct,cls_upct
	 xdef	  jst_puld

	 xref.l   mv_fnwd,mv_stms

local	 equ	  $ff
global	 equ	  $0

*
* erase cells
r_eras	 reg	  a3
cls_eras

	 tst.l	  da_cbx1(a6)	; more than one cell marked?
	 bmi.s	  eras_noask	; no, don't ask for confirmation

	 movem.l  r_eras,-(sp)
	 xlea	  ask_eras,a3	; ask for confirmation
	 xjsr	  ask_yn
	 movem.l  (sp)+,r_eras
	 beq.s	  eras_exit	; don't erase

eras_noask
	 clr.w	  da_saved(a6)
	 addq.w   #1,da_dupdt(a6)   ; don't update the display
	 xlea	  dta_rmvf,a5	    ; action routine
	 xjsr	  mul_blok	    ; ..over the block
	 subq.w   #1,da_dupdt(a6)   ; update display now
	 xjsr	  rdw_grid
	 xjsr	  dta_cell

eras_exit
	 rts

*
* protect cells
r_prct	 reg	  a3
cls_prct
	 tst.l	  da_cbx1(a6)
	 bmi.s	  prct_noask

	 movem.l  r_prct,-(sp)
	 xlea	  ask_prct,a3
	 xjsr	  ask_yn
	 movem.l  (sp)+,r_prct
	 beq.s	  prct_exit

prct_noask
	 clr.w	  da_saved(a6)
	 addq.w   #1,da_dupdt(a6)   ; don't update the display
	 xlea	  acc_prct,a5	    ; action routine
	 xjsr	  mul_blok	    ; ..over the block
	 subq.w   #1,da_dupdt(a6)   ; update display now

prct_exit
	 rts


*
* unprotect cells
r_upct	 reg	  a3
cls_upct
	 tst.l	  da_cbx1(a6)
	 bmi.s	  upct_noask

	 movem.l  r_upct,-(sp)
	 xlea	  ask_upct,a3
	 xjsr	  ask_yn
	 movem.l  (sp)+,r_upct
	 beq.s	  upct_exit

upct_noask
	 clr.w	  da_saved(a6)
	 addq.w   #1,da_dupdt(a6)   ; don't update the display
	 xlea	  acc_upct,a5	    ; action routine
	 xjsr	  mul_blok	    ; ..over the block
	 subq.w   #1,da_dupdt(a6)   ; update display now

upct_exit
	 rts


*
* justfiy cells


cls_justl subr	   a0-a5
	move.w	#1,d2
	bra.s	cls_just_l_r

cls_justr subr	   a0-a5
	move.w	#-1,d2
	bra.s	cls_just_l_r

cls_just subr	  a0-a5
	 bsr	  jst_puld	    ; request justfication window
	 bmi.s	  just_exit

	 move.w   d1,d2 	    ; d2: justification value

cls_just_l_r
	 clr.w	  da_saved(a6)
	 addq.w   #1,da_dupdt(a6)   ; don't update the display
	 xlea	  cel_just,a5	    ; justify cell..
	 xjsr	  mul_blok	    ; ..over the block range
	 subq.w   #1,da_dupdt(a6)   ; update display now
	 xjsr	  rdw_grid
	 moveq	  #0,d0

just_exit
	 subend

*
* units cells
cls_unit subr	  a0-a5
	 move.w   da_fword(a6),mv_fnwd(a6)   ; assume global format
	 move.l   da_cbx0(a6),d1    ; first cell
	 xjsr	  dta_vadr
	 bne.s	  unit_l1

	 move.w   val_fwrd(a3),d0
	 btst	  #fw..strg,d0
	 bne.s	  unit_l1

	 move.w   d0,mv_fnwd(a6)

unit_l1
	 xjsr	  fnm_puld	    ; request units window
	 bmi.s	  unit_exit

	 clr.w	  da_saved(a6)
	 addq.w   #1,da_dupdt(a6)   ; don't update the display
	 xjsr	  mon_strt
	 move.w   mv_fnwd(a6),d2
	 lea	  do_unit,a5
	 xjsr	  mul_blok
	 xjsr	  mon_stop
	 subq.w   #1,da_dupdt(a6)   ; update display now
	 xjsr	  rdw_grid
	 moveq	  #0,d0

unit_exit

	 subend


do_unit
	 move.l   d1,da_moncl(a6)
	 xjsr	  is_proct
	 beq.s	  dunit_x

	 bsr.s	  cel_cgfw	    ; change format word of cell
	 xjsr	  cel_calc	    ; recalculate cell

dunit_x
	 moveq	  #0,d0
	 rts

*
* symbol cells
cls_msym subr	  a0-a5
	 xjsr	  pld_msym	    ; request monetary symbol
	 bmi.s	  msym_exit

	 clr.w	  da_saved(a6)
	 addq.w   #1,da_dupdt(a6)   ; don't update the display
	 xjsr	  mon_strt
	 move.w   mv_stms(a6),d2
	 ror.w	  #4,d2
	 lea	  do_msym(pc),a5
	 xjsr	  mul_blok
	 xjsr	  mon_stop
	 subq.w   #1,da_dupdt(a6)   ; update display now
	 xjsr	  rdw_grid
	 moveq	  #0,d0

msym_exit
	 subend

do_msym
	 xjsr	  is_proct
	 beq.s	  dsym_x

	 move.l   d1,da_moncl(a6)
	 bsr.s	  cel_cgfx	    ; change format word of cell
	 xjsr	  cel_calc	    ; recalculate cell

dsym_x
	 moveq	  #0,d0
	 rts

*+++
* change units part format word of given cell
*
*		  Entry 		     Exit
*	 d1.l	  c|r of cell		     preserved
*	 d2.w	  format word		      preserved
*---
r_cgfw	 reg	  d0/d1/d2/a3
cel_cgfw
	 movem.l  r_cgfw,-(sp)
	 xjsr	  is_proct
	 beq.s	  cgfw_exit

	 bsr	  dta_vadr
	 bne.s	  cgfw_exit

	 move.w   val_fwrd(a3),d1
	 btst	  #fw..strg,d1
	 bne.s	  cgfw_exit

	 andi.w   #$ff00,d1
	 andi.w   #$ff,d2
	 or.w	  d2,d1
	 move.w   d1,val_fwrd(a3)

cgfw_exit
	 movem.l  (sp)+,r_cgfw
	 rts

*+++
* change msymbol part of format word of given cell
*
*		  Entry 		     Exit
*	 d1.l	  c|r of cell		     preserved
*	 d2.w	  format word		     preserved
*---
r_cgfx	 reg	  d2/a3/d3
cel_cgfx
	 movem.l  r_cgfx,-(sp)
	 xjsr	  is_proct
	 beq.s	  cgfx_exit

	 bsr	  dta_vadr
	 bne.s	  cgfx_exit

	 move.w   val_fwrd(a3),d3
	 btst	  #fw..strg,d3
	 bne.s	  cgfx_exit

	 andi.w   #%1000111111111111,d3
	 andi.w   #%0111000000000000,d2
	 or.w	  d2,d3
	 move.w   d3,val_fwrd(a3)

cgfx_exit
	 movem.l  (sp)+,r_cgfx
	 rts

*+++
* justification subwindow
*
*		  Entry 		     Exit
*
*	 D1.w				     value justification
*
* error codes: err.nimp    Menu extension not found
*	       err.nc	   esc'aped from menu
* condition codes set
*---
jst_puld subr	  d2/d3/d5-d7/a0-a2
	 moveq	  #-1,d1
	 moveq	  #0,d2
;;;	    move.b   colm(a6),d2
	 xlea	  met_mjsr,a0
	 move.l   a0,d5
	 xlea	  met_mjsl,a0
	 move.l   a0,d6
	 moveq.l  #0,d7
	 xlea	  met_cjst,a0
	 xlea	  met_mjst,a2
	 xjsr	  mu_selct
	 bne.s	  puld_exit

	 tst.w	  d3
	 beq.s	  puld_no

	 moveq	  #1,d1
	 subq.w   #1,d3
	 bne.s	  puld_exit

	 neg.w	  d1

puld_exit
	 tst.l	  d0
	 subend

puld_no
	 moveq	  #err.nc,d0
	 bra.s	  puld_exit

	 end
