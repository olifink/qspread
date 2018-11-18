* Spreadsheet					      28/01-91
*	 - grid command routines

	 section  prog

	 include  win1_keys_wman
	 include  win1_keys_wstatus
	 include  win1_keys_wwork
	 include  win1_keys_qdos_pt
	 include  win1_keys_k
	 include  win1_keys_qdos_io
	 include  win1_mac_oli
	 include  win1_spread_keys

	 xdef	  grd_quit,ask_yn
	 xdef	  grd_calc,grd_wdth
	 xdef	  grd_selc,grd_selr
	 xdef	  grd_pwdt,grd_wdth_men
	 xdef	  cel_cwdt

	 xref	  cfg_cgap
	 xref.l   mv_wdrg,mcx_grid,mcy_grid,mv_stcr


*-------------------------------------------------------------------------------
* select column
grd_selc
	 subr	  d1
	 move.l   da_cbx0(a6),d1	     ; select first cell
	 xjsr	  acc_selc
	 subend


*-------------------------------------------------------------------------------
* select row
grd_selr subr	  d1
	 move.l   da_cbx0(a6),d1	     ; select first cell
	 xjsr	  acc_selr
	 subend

*-------------------------------------------------------------------------------
* quit qspread
grd_quit subr	  a3
	 tst.w	  da_saved(a6)
	 bne.s	  do_quit

	 xlea	  ask_f3_quit,a3
	 bsr	  ask_always_yn
	 beq.s	  quit_exit

do_quit
	 xjmp	  ut_kill

quit_exit
	 subend

*------------------------------------------------------------------------------
* recalculate grid
grd_calc
	 xjmp	  acc_clcn
;------------------------------------------------------------------------------
grd_wdth
	 xjsr	  xwm_wasdo
	 beq.s	  grd_pwdt
grd_wdth_men
	 subr	  d1-d4/a0-a3
	 xjsr	  wdt_puld
	 cmpi.b   #k.cancel,d4
	 beq.s	  wdth_exit

	 clr.w	  da_saved(a6)
	 move.w   mv_wdrg(a6),d0	     ; from column
	 move.w   mv_wdrg+2(a6),d1	     ; to column
	 move.w   mv_wdrg+4(a6),d2	     ; new column width

wdth_lp
	 bsr.s	  cel_cwdt		     ; change column width
	 cmp.w	  d0,d1

	 beq.s	  wdth_rdw		     ; all done
	 addq.w   #1,d0
	 bra.s	  wdth_lp

wdth_rdw
	 xjsr	  acc_calc		     ; complete recalculation
	 move.l   da_cbx0(a6),d1	     ; update formular info
	 xjsr	  dta_cell

wdth_exit
	 subend

; change column width
; d0=column number
; d2=width in chars
cel_cwdt subr	  a3/d0/d1/d2
	 move.l   ww_pappl(a4),a3
	 move.l   (a3),a3
	 move.l   wwa_xspc(a3),a3	     ; here is the spacing list
	 mulu	  #wwm.slen,d0
	 mulu	  #qs.xchar,d2
	 addq.w   #2,d2
	 move.w   d2,wwm_size(a3,d0.l)
	 move.b   cfg_cgap,d1
	 beq.s	  no_gap

	 addq.w   #2,d2

no_gap
	 move.w   d2,wwm_spce(a3,d0.l)
	 subend

;
; perfect width
grd_pwdt subr	  d1-d4/a0-a3

	 clr.w	  da_saved(a6)
	 move.l   da_ccell(a6),d1	      ; from column|row
	 move.l   da_cbx1(a6),d2	      ; to last column
	 bpl.s	  pw_ok

	 move.l   d1,d2

pw_ok
	move.w	 da_cby0(a6),d2

pw_lp
	 xjsr	  set_pwdt		      ; change column width

	swap	d1		; column to low word
	swap	d2		; here too
	cmp.w	d1,d2		; all done?
	beq.s	pw_rdw_done	; yupp!

	swap	d2		; back into right order
	addq.w	#1,d1		; next column
	swap	d1		; into right order too
	bra.s	pw_lp		; next column

pw_rdw_done
	swap	d1		; really required???
	swap	d2
	xjsr	acc_calc		   ; complete recalculation
	move.l	 da_cbx0(a6),d1 	    ; update formular info
	xjsr	 dta_cell
pw_exit subend


*+++
* ask for confirmation / answer yes or no
*
*		  Entry 		     Exit
*	 d1				     0=no / 1=yes
*	 a3	  ask block		     preserved
*---
ask_yn
	 tst.w	  mv_stcr(a6)		     ; confirmation req.?
	 beq.s	  yn_yes
ask_always_yn
	 moveq	  #0,d1
	 move.b   colm(a6),d1
	 xjsr	  pld_ask
	 tst.l	  d0
	 bmi.s	  do_kill

	 bchg	  #0,d0
	 move.l   d0,d1
	 moveq	  #0,d0

yn_exit
	 tst.w	  d1
	 rts

do_kill
	xjmp	kill

yn_yes
	moveq	 #0,d0
	 moveq	  #1,d1
	 rts

	 end
