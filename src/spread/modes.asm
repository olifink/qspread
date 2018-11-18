* Spreadsheet					      29/11-91
*	 - mode selection

	 section  prog

	 include  win1_keys_wman
	 include  win1_keys_wwork
	 include  win1_keys_wstatus
	 include  win1_keys_qdos_pt
	 include  win1_mac_oli
	 include  win1_spread_keys

	 xdef	  mod_norm,mod_insc,mod_copy
	 xdef	  mod_insr,mod_delr,mod_delc
	 xdef	  mod_move,mod_macr,mod_echo
	 xdef	  mod_selc,act_macro,act_other,cel_copy

	 xref	  act_insc,act_insr,act_delc,act_delr,act_echo

	 xref.s   mli.csum,mli.csim,mli.date

act_macro
	 bsr.s	  act_togg
	 cmpi.b   #pt..do,d4
	 beq.s	  other_ok

	 move.l   d1,d5
	 move.l   d5,da_ccell(a6)   ; set current cell
	 move.l   d5,d1
	 xjsr	  dta_prcs

	 bra.s	  other_ok


act_other
	 move.l   d1,d5
	 bsr.s	  act_togg
	 cmpi.b   #pt..do,d4
	 beq.s	  other_ok

	 lea	  act_tab,a5
	 move.w   da_amode(a6),d1
	 subq.w   #1,d1
	 lsl.w	  #2,d1
	 adda.w   d1,a5
	 move.l   (a5),d1
	 beq.s	  other_ok

	 adda.l   d1,a5
	 jsr	  (a5)

other_ok
	 move.l   d0,d5
	 moveq	  #mli.csum,d1
	 xjsr	  rdw_mkav
	 bne.s	  do_kill

	 moveq	  #mli.csim,d1
	 xjsr	  rdw_mkav
	 bne.s	  do_kill

	 moveq	  #mli.date,d1
	 xjsr	  rdw_mkav
	 bne.s	  do_kill

	 xjsr	  cel_mark
	 moveq	  #0,d0
	 moveq	  #0,d4
	 bsr	  mod_norm
	 move.l   d5,d0
	 rts

r_togg	 reg	  a3/d3
act_togg subr	  a3/d3
	 eori.b   #wsi.slct,(a1,d2.w)	     ; toggle status again
	 bset	  #wsi..chg,(a1,d2.w)
	 moveq	  #wm.drsel,d3
	 move.l   da_wwork(a6),a3
	 move.l   ww_pappl(a3),a3
	 move.l   (a3),a3
	 jsr	  wm.mdraw(a2)
	 bmi.s	  do_kill

	 bclr	  #wsi..chg,(a1,d2.w)
	 subend

do_kill
	 xjmp	 kill

; action routines (are called with d5.l as action cell)
act_tab
	 dc.l	  act_delc-*	    ; delete column mode
	 dc.l	  act_delr-*	    ; delete row mode
	 dc.l	  act_insc-*	    ; insert column mode
	 dc.l	  act_insr-*	    ; insert row mode
	 dc.l	  act_copy-*	    ; copy mode
	 dc.l	  act_echo-*	    ; echo mode
	 dc.l	  act_copy-*	    ; move mode
	 dc.l	  act_selc-*	    ; selection (ID) mode


;
; ID-cell: appends cell reference to current buffer string
act_selc subr	  a0/a1
	 move.l   d5,d1
	 lea	  da_free(a6),a1    ; free buffer
	 xjsr	  con_cstr	    ; convert to range string
	 lea	  da_buff(a6),a0
	 xjsr	  st_appst	    ; append to formula
	 moveq	  #1,d0 	    ; continue editing
	 subend

r_acpy	 reg	  d1-d5/a0-a2/a5
act_copy
	 movem.l  r_acpy,-(sp)
	 move.w   da_amode(a6),d4
	 addq.w   #1,da_dupdt(a6)   ; don't update display
	 move.l   da_cbx0(a6),d1
	 move.l   d5,d3 	    ; d5=virtual column|row
	 sub.l	  d1,d3 	    ; d3=delta col/delta row
	 lea	  do_copy,a5
	 xjsr	  mul_blok
	 subq.w   #1,da_dupdt(a6)   ; update display now
	 movem.l  (sp)+,r_acpy
	 xjsr	  rdw_grid
	 rts

do_copy
	 move.l   d1,d2
	 add.l	  d3,d2
	 bsr.s	  mak_copy
	 cmpi.b   #mod.move,d4
	 bne.s	  copy_lb1

	 xjsr	  dta_rmvf

copy_lb1
	 moveq	  #0,d0
	 rts

mak_copy subr	  d1
	 move.l   d1,d5
	 move.l   d2,d1
	 xjsr	  ech_cact
	 xjsr	  cel_calc	    ; re-calculate cell
	 subend

*------------------------------------------------------------------------------
* set mode word and application window sprite

r_mode	 reg	  a3/a1
mod_norm
	 movem.l  r_mode,-(sp)
	 xjsr	  set_ckey
	 move.w   #mod.slct,da_amode(a6)     ; set normal action mode
	 xlea	  mes_arro,a1
	 bsr	  no_immodes		     ; reset immediate mode items

mod_exit
	 move.l   da_wwork(a6),a3
	 move.l   ww_pappl(a3),a3
	 move.l   (a3),a3
	 move.l   a1,wwa_pspr(a3)	     ; set arrow sprite
	 movem.l  (sp)+,r_mode
	 moveq	  #0,d0
	 rts

mod_insc
	 movem.l  r_mode,-(sp)
	 xjsr	  set_nkey
	 move.w   #mod.insc,da_amode(a6)     ; set insert column mode
	 xlea	  mes_insc,a1
	 bra	  mod_exit

mod_insr
	 movem.l  r_mode,-(sp)
	 xjsr	  set_nkey
	 move.w   #mod.insr,da_amode(a6)     ; set insert row mode
	 xlea	  mes_insr,a1
	 bra	  mod_exit

mod_delc
	 movem.l  r_mode,-(sp)
	 xjsr	  set_nkey
	 move.w   #mod.delc,da_amode(a6)     ; set delete column mode
	 xlea	  mes_delx,a1
	 bra	  mod_exit

mod_delr
	 movem.l  r_mode,-(sp)
	 xjsr	  set_nkey
	 move.w   #mod.delr,da_amode(a6)     ; set delete row mode
	 xlea	  mes_delx,a1
	 bra	  mod_exit

mod_copy
	 movem.l  r_mode,-(sp)
	 xjsr	  set_nkey
	 move.w   #mod.copy,da_amode(a6)     ; set copy row mode
	 xlea	  mes_ccpy,a1
	 bra	  mod_exit

mod_move
	 movem.l  r_mode,-(sp)
	 xjsr	  set_nkey
	 move.w   #mod.move,da_amode(a6)     ; set delete row mode
	 xlea	  mes_cmov,a1
	 bra	  mod_exit

mod_echo
	 movem.l  r_mode,-(sp)
	 xjsr	  set_nkey
	 move.w   #mod.echo,da_amode(a6)     ; set echo mode
	 xlea	  mes_cech,a1
	 bra	  mod_exit

mod_selc
	 movem.l  r_mode,-(sp)
	 xjsr	  set_nkey
	 move.w   #mod.selc,da_amode(a6)     ; set selection mode
	 xlea	  mes_selc,a1
	 bra	  mod_exit

mod_macr
	 movem.l  r_mode,-(sp)
	 xjsr	  set_nkey
	 move.w   d0,da_amode(a6)
	 cmpi.w   #-300,d0
	 bne.s	  macr_lin

	 xjsr	  mcr_sum
	 bra.s	  macr_cont

macr_lin
	 cmpi.w   #-301,d0
	 bne.s	  macr_date

	 xjsr	  mcr_lin
	 bra.s	  macr_cont

macr_date
	cmpi.w	#-302,d0
	bne.s	macr_usr
	xjsr	mcr_date
	bra.s	macr_cont

macr_usr
	 xjsr	  mcr_user

macr_cont
	 xlea	  mes_macr,a1
	 bra	  mod_exit


no_immodes subr a0-a4/d1-d3
	 move.l   da_wwork(a6),a4
	 move.l   da_wmvec(a6),a2
	 move.l   ww_wstat(a4),a1
	 move.l   ww_chid(a4),a0
	 move.b   #wsi.mkav,ws_litem+mli.csim(a1)
	 move.b   #wsi.mkav,ws_litem+mli.csum(a1)
	 move.b   #wsi.mkav,ws_litem+mli.date(a1)
	 moveq	  #wm.drsel,d3
	 jsr	  wm.ldraw(a2)
	 bne	  do_kill

	 bclr	  #wsi..chg,ws_litem+mli.csim(a1)
	 bclr	  #wsi..chg,ws_litem+mli.csum(a1)
	 bclr	  #wsi..chg,ws_litem+mli.date(a1)
	 subend

*------------------------------------------------------------------------------
* copy from one cell to another
* (and remove reference in old cell)
*
*		  Entry 		     Exit
*	 d1.l	  c|r of cell to copy from   preserved
*	 d2.l	  c|r of cell to copy to     preserved
*
* if one cell is out of range, nothing will be done.
*---
r_copy	 reg	  d1/d2/a2/a3
cel_copy
	 movem.l  r_copy,-(sp)
	 xjsr	  in_grid
	 bne.s	  copy_exit

	 xjsr	  dta_madr
	 move.l   a3,a2
	 exg	  d1,d2
	 xjsr	  in_grid
	 bne.s	  copy_exit

	 bsr	  dta_madr

	 move.l   wwm_pobj(a2),wwm_pobj(a3)
	 move.b   wwm_xjst(a2),wwm_xjst(a3)
	 clr.l	  wwm_pobj(a2)
	 clr.b	  wwm_xjst(a2)

copy_exit
	 movem.l  (sp)+,r_copy
	 rts

	 end
