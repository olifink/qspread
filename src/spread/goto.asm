* Spreadsheet					      06/03-92
*	 - goto cell / manual block selection

	 section  prog

	 include  win1_keys_wman
	 include  win1_keys_wstatus
	 include  win1_keys_wwork
	 include  win1_keys_qdos_pt
	 include  win1_mac_oli
	 include  win1_spread_keys

	 xdef	  mea_goto

	 xref.l   mli.goto,mcy_grid,mcx_grid

mea_goto subr	  a0-a3
	 moveq	  #mli.goto,d1		     ; edit in goto item
	 bsr.s	  setstrg
	 lea	  da_buff(a6),a3
	 xjsr	  mu_swrds
	 beq.s	goto_ok

	 xjmp	  kill
goto_ok
	 cmpi.b   #10,d1
	 bne.s	  goto_extra

	 move.l   a3,a1
	 xjsr	  con_strc

	 beq.s	  goto_do

goto_top
	 moveq	  #0,d1 		     ; assume A1 if orng

goto_do
	xjsr	 acc_goto

goto_exit
	 subend

goto_extra
	 xjsr	  cnv_term
	 beq.s	  goto_cur

	 bmi.s	  goto_top

	 move.l   da_usedx(a6),d1
	 bra.s	  goto_do

goto_cur
	 xjsr	  cel_info
	 bra.s	  goto_exit

setstrg subr	a0/a1/d1/d2
	lea	da_buff(a6),a0
	lea	da_cinfo(a6),a1
	xjsr	ut_cpyst
	moveq	#1,d1			; scanning position
	xlea	met_sept,a1
	move.w	(a1)+,d0
	move.b	-1(a1,d0.w),d2		; watch out for seperator
	xjsr	st_findc
	bne.s	set_x

	subq.w	#1,d1
	move.w	d1,(a0)

set_x	subend

	 end
