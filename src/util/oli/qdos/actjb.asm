; activate a job and pass parameters		      15/08-92 O.Fink
;

	 include  win1_mac_oli
	 include  win1_keys_qdos_sms
	 include  win1_keys_jcb
	 include  win1_keys_sys
	 include  win1_keys_err

	 section  utility

	 xdef	  ut_acjb

;+++
; activate a job
;
;		  Entry 		     Exit
;	 d1.l	  job ID
;	 d2.b	  priority
;	 d3	  timeout (0 or -1)
;	 a0	  channel ID (or 0)
;	 a1	  channel ID (or 0)
;	 a2	  ptr to command line (or 0)
;
; error codes: err.fdnf or job error codes
;---
ut_acjb  subr	  a3
	 jsr	  setpara	    ; set parameters in job
	 bne.s	  a_exit
	 moveq	  #sms.acjb,d0
	 trap	  #do.sms2
	 tst.l	  d0
a_exit	 subend

setpara  subr	  d1/d2/a1/d3/a4
	 exg	  a1,a3
	 xjsr	  ut_fjcb	    ; find job control block
	 bne.s	  s_exit
	 exg	  a1,a3

	 move.l   jcb_a7(a3),a4
	 adda.w   #4,a4
	 move.l   a2,d0
	 bne.s	  set_cmdl
	 move.w   #0,-(a4)
	 bra.s	  no_cmdl
set_cmdl
	 move.w   (a2),d0	    ; set command line
	 addq.w   #3,d0
	 bclr	  #0,d0
	 sub.w	  d0,a4

	 movem.l  a0/a1,-(sp)
	 move.l   a2,a1
	 move.l   a4,a0
	 xjsr	  ut_cpyst
	 movem.l  (sp)+,a0/a1
no_cmdl
	 moveq	  #0,d1
	 move.l   a1,d0 	    ; set channels
	 beq.s	  no_chan1
	 addq.w   #1,d1
	 move.l   d0,-(a4)
no_chan1
	 move.l   a0,d0
	 beq.s	  no_chans
	 addq.w   #1,d1
	 move.l   d0,-(a4)
no_chans
	 move.w   d1,-(a4)	    ; set nr of channels
	 move.l   a4,jcb_a7(a3)
	 moveq	  #0,d0
s_exit
	 subend

	 END
