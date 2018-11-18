* Spreadsheet					      29/11-91
*	 - command action routines

	 section  prog

	 include  win1_keys_wman
	 include  win1_keys_wstatus
	 include  win1_keys_wwork
	 include  win1_keys_qdos_pt
	 include  win1_mac_oli
	 include  win1_spread_keys

; mea_cfil,mea_cgrd,mea_ccel raus!

	 xdef	  mea_cstt
	 xdef	  mea_chlp,mea_csmc,mea_csim,mea_csum,mea_csdt
	 xdef	  cmd_puld

	 xref	  cfg_helpf
	 xref	mod_norm

get_cway
	 moveq	  #0,d1
;;;	    move.b   colm(a6),d1
	 rts

mea_chlp
	 jsr	  mod_norm
	 bsr	  get_cway
	 bsr	  unselect

help_again
	 xlea	  sub_help,a1
	 xjsr	  pld_smen
	 tst.w	  d0
	 ble.s	  loos_ret

	 subq.w   #1,d0
	 bsr	  view_help
	 bra.s	  help_again


mea_csum
	 move.w   #-300,d0
	 xjsr	  mod_macr
	 moveq	  #0,d0
	 moveq	  #0,d4
	 rts

mea_csim
	 move.w   #-301,d0
	 xjsr	  mod_macr
	 moveq	  #0,d0
	 moveq	  #0,d4
	 rts

mea_csdt
	move.w	#-302,d0
	xjsr	mod_macr
	moveq	#0,d0
	moveq	#0,d4
	rts

mea_csmc
	 jsr	  mod_norm
	 xjsr	  pld_macr
	 bra.s	  loos_ret

mea_cstt
	 jsr	  mod_norm
	 xjsr	  stt_puld
	 tst.b	  da_toolb(a6)
	 beq.s	  loos_ret

	 bsr.s	  rest_w
	 bra.s	  loos_ret

rest_w	 subr	  d1-d6/a3
	 move.l   wsp_xpos(a1),d5
	 move.l   wsp_xorg(a1),d6
	 add.l	  d5,d6
	 clr.b	  da_toolb(a6)
	 xjsr	  set_nset
	 subend

loos_ret
	 bsr	  unselect
	 moveq	  #0,d0
	 moveq	  #0,d4
	 rts


shw_err
	 tst.l	  d0
	 beq.s	  shw_exit

	 xjsr	  rep_error

shw_exit
	 clr.w	  da_dupdt(a6)
	 rts

*+++
* pull down command menu
*
*		  Entry 		     Exit
*	 d1	  menu item control	     option selected,-1=esc,-2=ok
*	 a0	  ptr to window title	     preserved
*	 a2	  ptr to item list	     preserved
*	 a3	  ptr to loose item	     preserved
*---
r_cmd	 reg	  a0-a3/d2-d7
cmd_puld
	 movem.l  r_cmd,-(sp)		     ; select a file command
	 move.l   d1,d3 		     ; menu item control
	 move.l   a3,d1
	 beq.s	  puld_rel

	 move.l   wwl_xorg(a3),d1	     ; origin
	 bra.s	  puld_ok

puld_rel
	 moveq	  #-1,d1

puld_ok
;;;	    move.b   cols(a6),d2	       ; list colourway
;;;	    ext.w    d2
;;;	    swap     d2
;;;	    move.b   colm(a6),d2	       ; main colourway
;;;	    ext.w    d2
	 moveq	#0,d2
	 suba.l   a3,a3
	 moveq	  #0,d4 		     ; nr. of lines/columns
	 moveq	  #1,d5 		     ; rel. itemlist
	 xjsr	  mu_listsl		     ; select list
	 move.w   d3,d1
	 movem.l  (sp)+,r_cmd
	 tst.l	  d0			     ; what happened?
	 beq.s	  puld_ok1

	 xjmp	  kill

puld_ok1
	 rts
*
* Show Help File
*
* d0=nr. of help item
view_help
	 movem.l  r_cmd,-(sp)		     ; view help file
	 move.l   da_cway(a6),d2
	 moveq	  #0,d3 		     ; chars
	 moveq	  #0,d4
	 moveq	  #0,d5
	 bsr.s	  gt_hlpfn		; get helpfilename
	 xjsr	  mu_view
	 movem.l  (sp)+,r_cmd
	 moveq	  #0,d0 		     ; what happened?
	 rts

gt_hlpfn subr	  a1/d1/d2
	 move.l   d0,d2
	 lea	  da_helpd(a6),a1	; copy help directory..
	 lea	  da_anbuf(a6),a0	; into buffer
	 xjsr	  ut_cpyst
	 xlea	  arr_hlpf,a1		; get list of helpfilename
	 move.w   8(a1),d1
	 mulu	  d2,d1 		; get string in list
	 lea	  14(a1,d1.l),a1
	 xjsr	  st_appst		; append it to directory
	 subend


*
* deselect current item and return from action routine
unselect
	 xjmp	   ut_rdwci

	 end
