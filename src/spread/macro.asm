* Spreadsheet					      17/03-92
*	 - macro operation

	 section  prog

	 include  win1_keys_wman
	 include  win1_keys_wwork
	 include  win1_keys_wstatus
	 include  win1_keys_qdos_pt
	 include  win1_keys_sys
	 include  win1_keys_qdos_sms
	 include  win1_spread_keys
	 include  win1_mac_oli

	 xdef	  mcr_user
	 xdef	  mcr_sum,mcr_lin,mcr_date

	 xref.s   mli.data
	 xref.l   mv_mcnr

	xref	cfg_dtfmt,cfg_dtfms

mcr_user
	 neg.w	  d0
	 subq.w   #2,d0
	 mulu	  #80,d0
	 lea	  mv_mcnr(a6),a1
	 adda.w   d0,a1
	 bra.s	  mcr_ok

mcr_sum
	 xlea	  met_xsum,a1

mcr_ok
	 bsr.s	  mcr_xpnd
	 moveq	  #mli.data,d1
	 jsr	  wm.stlob(a2)
	 beq.s	  mcr_ok1

	 xjmp	   kill

mcr_ok1
	 xjsr	  rdw_lchg
	 rts

mcr_date
	movem.l d6/d7/a0/a2,-(sp)

	moveq	#sms.rrtc,d0
	trap	#do.smsq

	lea	da_buff+3(a6),a1
	move.b	#-1,da_buff+12(a6)
	move.b	cfg_dtfms,d6
	move.b	cfg_dtfmt,d7
	xjsr	ut_datex

	lea	da_buff(a6),a1
	move.w	#11,(a1)		; assume long date
	move.b	#'"',2(a1)
	cmp.b	#-1,da_buff+12(a6)	; short date?
	bne.s	date_long
	subq.w	#2,(a1) 		; yes adjust string length
date_long
	movem.l (sp)+,d6/d7/a0/a2
	bra.s	mcr_ok

mcr_lin
	 xlea	  met_xlin,a1
	 bra.s	  mcr_ok

*+++
* extpand a macro text into the buffer
*
*		  Entry 		     Exit
*	 a1	  ptr to macro		     ptr to buffer
*---
r_xpnd	 reg	  a3/a2/d1/d3/d0/a5
mcr_xpnd
	 movem.l  r_xpnd,-(sp)
	 moveq	  #0,d1 	    ; length counter
	 move.l   a1,a3
	 lea	  da_buff(a6),a1
	 lea	  2(a1),a2

	 move.w   (a3)+,d3
	 bra.s	  xpnd_end

xpnd_lp
	 move.b   (a3)+,d0
	 cmpi.b   #'\',d0
	 beq.s	  xpnd_cmd

	 move.b   d0,(a2)+
	 addq.w   #1,d1

xpnd_end
	 dbra	  d3,xpnd_lp

xpnd_bye
	 move.w   d1,(a1)
	 movem.l  (sp)+,r_xpnd
	 rts

xpnd_cmd
	 subq.w   #1,d3
	 bmi.s	  xpnd_bye

	 move.b   (a3)+,d0
	 bset	  #5,d0 	    ; lower case
	 cmpi.b   #'r',d0
	 beq.s	  xpnd_rng

	 bra	  xpnd_end

xpnd_rng
	 lea	  da_cinfo(a6),a5
	 move.w   (a5)+,d0
	 add.w	  d0,d1
	 bra.s	  xrng_end

xrng_lp
	 move.b   (a5)+,(a2)+

xrng_end
	 dbra	  d0,xrng_lp
	 bra	  xpnd_end



	 end
