; load an executable file			      17/08-92 O.Fink
;

	 include  win1_mac_oli
	 include  win1_keys_err
	 include  win1_keys_qdos_ioa
	 include  win1_keys_qdos_io
	 include  win1_keys_qdos_sms
	 include  win1_keys_hdr

	 section  utility

	 xdef	  ut_et,ut_ldexe

;+++
; load an execuable file, and create an job
;
;		  Entry 		     Exit
;	 d1.l	  +data|owner		     job ID
;	 a0	  ptr to filename	     ptr to area
;
; errors: IOSS errors, err.ipar if not executable
;---
ut_ldexe
ut_et	 subr	  d2-d3/d5/a1-a3
	 move.l   d1,d5
	 suba.w   #$20,sp
	 move.l   sp,a3

	 moveq	  #ioa.open,d0		     ; open file
	 moveq	  #ioa.kshr,d3
	 xjsr	  do_open
	 bne.s	  et_errx

	 moveq	  #iof.rhdr,d0		     ; read header
	 moveq	  #$10,d2
	 move.l   a3,a1
	 xjsr	  do_io
	 bne.s	  et_err

	 moveq	  #err.ipar,d0		     ; check for executable file
	 cmp.b	  #hdrt.exe,hdr_type(a3)
	 bne.s	  et_err

	 move.l   a0,-(sp)
	 moveq	  #sms.crjb,d0		     ; create a job entry
	 move.w   d5,d1
	 ext.l	  d1
	 move.l   hdr_flen(a3),d2
	 move.l   hdr_data(a3),d3
	 swap	  d5
	 ext.l	  d5
	 add.l	  d5,d3
	 suba.l   a1,a1
	 trap	  #do.sms2
	 tst.l	  d0
	 bne.s	  et_err
	 move.l   a0,a1
	 move.l   (sp)+,a0
	 move.l   d1,d3

	 moveq	  #iof.load,d0		     ; load job
	 move.l   hdr_flen(a3),d2
	 jsr	  do_io
;;;	    bne.s    et_err

et_err
	 xjsr	  do_close		     ; close file
	 move.l   d3,d1
et_errx
	 adda.w   #$20,sp
	 tst.l	  d0
	 subend

	 end
