* unrecoverable applitcation error handling	      20/06-92 O.Fink
*

	 include  win1_mac_oli
	 include  win1_keys_qlv
	 include  win1_keys_qdos_io
	 include  win1_keys_qdos_sms

	 section  utility

	 xdef	  ut_appr

;+++
; report unrecoverable application error
; close primary window, if still open
;
;		  Entry 		     no exit
;	 d0	  error code
;---
ut_appr
	 move.l   d0,d7
	 bpl.s	  kill
	 xjsr	  ut_gpwjb	    ; get primary ID
	 bne.s	  no_prim
	 xjsr	  do_close	    ; close if still open open
no_prim
	 lea	  con_blk,a1	    ; setup error window
	 move.w   opw.con,a2
	 jsr	  (a2)
	 bne.s	  kill
	 moveq	  #iow.defb,d0
	 moveq	  #$80,d1
	 moveq	  #4,d2
	 xjsr	  do_io

	 bsr.s	  f_jbnm	    ; write job name
	 bsr.s	  write
	 bne.s	  kill
	 lea	  m_fail,a1	    ; has failed etc.
	 bsr.s	  write
	 bne.s	  kill

	 moveq	  #iow.sink,d0	    ; red ink
	 moveq	  #2,d1
	 jsr	  do_io
	 bne.s	  kill

	 move.l   d7,d0 	    ; error message
	 bgt.s	  er_user	    ; user defined error msg
	 move.w   ut.werms,a2
	 jsr	  (a2)
wait
	 moveq	  #iow.ecur,d0	    ; wait for user response
	 jsr	  do_io
	 bne.s	  kill
	 moveq	  #iob.fbyt,d0
	 jsr	  do_io
	 bne.s	  kill
	 moveq	  #iow.dcur,d0
	 jsr	  do_io

kill
	 xjsr	  ut_kill

er_user
	 move.l   d0,a1
	 bsr.s	  write
	 bra.s	  wait

f_jbnm	 subr	  d1-d3/a0
	 moveq	  #sms.info,d0
	 trap	  #do.sms2
	 moveq	  #sms.injb,d0
	 moveq	  #0,d2
	 trap	  #do.sms2
	 bne.s	  kill
	 lea	  8(a0),a1
	 subend

write	 subr	  d2/a1
	 move.w   (a1)+,d2
	 moveq	  #iob.smul,d0
	 jsr	  do_io
	 subend

m_fail	 dc.w	  36
	 dc.b	  ' ... has failed with the error',10,'     '
con_blk
	 dc.b	  2,2,7,0
	 dc.w	  448,40,32,80
	 end
