; load file contents				 17/08-92 O.Fink
;

	 include  win1_mac_oli
	 include  win1_keys_err
	 include  win1_keys_qdos_ioa
	 include  win1_keys_qdos_io
	 include  win1_keys_qdos_sms
	 include  win1_keys_hdr

	 section  utility

	 xdef	  ut_ldf

;+++
; load file contents
;
;		  Entry 		     Exit
;	 d3	  key for open		     length of file
;	 a0	  ptr to filename	     ptr to area
;
; errors: IOSS errors, err.ipar if not executable
;---
ut_ldf	 subr	  d2/a1-a3
	 suba.w   #$20,sp
	 move.l   sp,a3

	 moveq	  #ioa.open,d0		     ; open file
	 xjsr	  do_open
	 bne.s	  et_errx

	 moveq	  #iof.rhdr,d0		     ; read header
	 moveq	  #$10,d2
	 move.l   a3,a1
	 xjsr	  do_io
	 bne.s	  et_err

	 move.l   a0,-(sp)		; allocate space for file
	 move.l   hdr_flen(a3),d1
	 xjsr	  ut_alchp
	 move.l   a0,a1
	 move.l   (sp)+,a0
	 tst.l	  d0
	 bne.s	  et_err

	 moveq	  #iof.load,d0		     ; load job
	 move.l   hdr_flen(a3),d2
	 jsr	  do_io
	 move.l   hdr_flen(a3),d3
et_err
	 xjsr	  do_close		     ; close file
	 move.l   a1,a0
et_errx
	 adda.w   #$20,sp
	 tst.l	  d0
	 subend

	 end
