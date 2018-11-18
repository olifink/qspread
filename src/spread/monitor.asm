* Spreadsheet					      28/12-91
*	 - monitor cell operations

	 section  prog

	 include  win1_keys_wman
	 include  win1_keys_wstatus
	 include  win1_keys_wwork
	 include  win1_keys_err
	 include  win1_keys_jcb
	 include  win1_keys_qdos_sms
	 include  win1_keys_qdos_io
	 include  win1_mac_oli
	 include  win1_spread_keys

	 xdef	  mon_strt
	 xdef	  mon_stop

	 xref.l   mli.goto


mon_strt subr	  a0-a2/d0-d4
	 clr.l	  da_moncl(a6)
	 move.l   da_wmvec(a6),a2
	 moveq	  #mli.goto,d1	    ; set window to goto item
	 moveq	  #wsi.slct,d2
	 jsr	  wm.swlit(a2)
	 tst.l	  d0
	 bne.s	  strt_exit

	 moveq	  #$20,d2		     ; code space
	 move.l   #$200,d3		     ; data space
	 moveq	  #0,d4 		     ; do not start at all
	 lea	  mon_job,a1
	 lea	  mon_name,a2
	 xjsr	  ut_crjob
	 tst.l	  d0
	 bne.s	  strt_exit

	 move.l   d1,da_monid(a6)
	 move.l   jcb_a6(a0),a1 	     ; get data space area
	 add.l	  jcb_a4(a0),a1
	 move.l   a6,(a1)		     ; hello, I am here
	 moveq	  #sms.spjb,d0
	 moveq	  #2,d2 		     ; priority
	 trap	  #do.sms2

strt_exit
	 subend


*
* our own little monitor job
mon_name qstrg	  {Monitor}
mon_job
	 lea	  0(a4,a6.l),a6
	 move.l   (a6),a5	    ; owner jobs data area

	 move.l   da_chan(a5),a0
	 move.l   da_wwork(a5),a4

	 moveq	  #iow.spap,d0
	 move.w   ww_lattr+wwa_selc+wwa_back(a4),d1
	 moveq	  #forever,d3
	 move.l   da_wmvec(a6),a2
	 jsr	  wm.trap3(a2)

	 tst.l	  d0
	 bne.s	  mon_kill

	 moveq	  #iow.sstr,d0
	 jsr	  wm.trap3(a2)
	 tst.l	  d0
	 bne.s	  mon_kill

	 moveq	  #iow.sink,d0
	 move.w   ww_lattr+wwa_selc+wwa_ink(a4),d1
	 jsr	  wm.trap3(a2)
	 tst.l	  d0
	 bne.s	  mon_kill

mon_lp
	 move.l   da_chan(a5),a0
	 moveq	  #iow.clra,d0
	 moveq	  #forever,d3
	 trap	  #do.io
	 tst.l	  d0
	 bne.s	  mon_kill

	 moveq	  #iow.spix,d0
	 moveq	  #1,d1
	 moveq	  #0,d2
	 trap	  #do.io
	 tst.l	  d0
	 bne.s	  mon_kill

	 move.l   da_moncl(a5),d1   ; convert cell number to string
	 lea	  4(a6),a1
	 xjsr	  con_cstr

	 moveq	  #iob.smul,d0
	 move.w   (a1)+,d2
	 moveq	  #forever,d3
	 trap	  #do.io
	 tst.l	  d0
	 bne.s	  mon_kill

	 moveq	  #sms.ssjb,d0	    ; sleep for a while
	 moveq	  #sms.myjb,d1
	 moveq	  #20,d3
	 suba.l   a1,a1
	 trap	  #do.sms2

	 bra	  mon_lp

mon_kill
	 clr.l	  da_monid(a5)
	 move.l   d0,d3
	 moveq	  #sms.frjb,d0
	 moveq	  #sms.myjb,d1
	 trap	  #do.sms2


mon_stop subr	  d0-d3/a0-a3
	 moveq	  #sms.frjb,d0
	 move.l   da_monid(a6),d1
	 beq.s	  stop_rdw

	 moveq	  #0,d3
	 trap	  #do.sms2
	 clr.l	  da_monid(a6)

stop_rdw
	 move.l   da_chan(a6),a0
	 move.l   da_wwork(a6),a4
	 moveq	  #mli.goto,d1
	 xjsr	  rdw_mkav

	 subend

	 end
