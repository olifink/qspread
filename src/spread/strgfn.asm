* Spreadsheet					      13/01-92
*	 - string function routines

	 section  prog

	 include  win1_keys_wman
	 include  win1_keys_wstatus
	 include  win1_keys_wwork
	 include  win1_keys_err
	 include  win1_keys_qlv
	 include  win1_mac_oli
	 include  win1_spread_keys
	 include  win1_spread_fparser_keys

	 xdef	  dta_stfn

	 xref.l   mv_digt
	xref	cfg_dtfmt,cfg_dtfms

sfn.len  equ	  10

;+++
; check for string function
;
;		  Entry 		     Exit
;	 a2				     adr of fn (if found)
;	 a3	  ptr to formular	     preserved
;
; error codes: err.itnf    no matching function found
;	       no.err	   function code at (a2)
;---
dta_stfn subr	  a0/a1/d4
	 move.l   a3,a0 	    ; compare formular with stfn tab
	 lea	  tab_stfn,a1

stfn_lp
	 tst.w	  (a1)
	 bmi.s	  stfn_nf

	 move.w   (a0),d4	    ; length of formular
	 move.w   (a1),(a0)
	 bsr	  sfn_cmp
	 move.w   d4,(a0)
	 tst.l	  d0
	 beq.s	  stfn_ok	    ; ok, function found

	 add.w	  #sfn.len+2,a1
	 bra.s	  stfn_lp

stfn_nf
	 moveq	  #err.itnf,d0

stfn_exit
	 subend

stfn_ok
	 add.w	  #sfn.len,a1
	 move.l   a1,a2
	 add.w	  (a2),a2
	 moveq	  #0,d0
	 bra.s	  stfn_exit


;----------------string function table---------------------
tab_stfn
	 dc.w	  7,'month$( '	    ; month function
	 dc.w	  sfn_mon-*
	 dc.w	  5,'day$(   '	    ; day function
	 dc.w	  sfn_day-*
	 dc.w	  6,'rept$(  '	    ; repeat function
	 dc.w	  sfn_rpt-*
	 dc.w	  7,'digit$( '	    ; digit spelling function
	 dc.w	  sfn_dig-*
;	  dc.w	   5,'xfn$(   '
;	  dc.w	   sfn_xfn-*
	 dc.w	  6,'date$(  '	    ; date function
	 dc.w	  sfn_date-*
	 dc.w	  6,'time$(  '	    ; time function
	 dc.w	  sfn_time-*

	 dc.w	  -1


;-----------------string functions--------------------------


sfn_date subr	  a0/a1/d1

	bsr	sfn_getf		; get one floating argument
	bne.s	date_exit

	moveq	#qa.nlint,d0
	xjsr	prs_doqa
	bne.s	date_exit
	move.l	(a1),d1 		; get the date

	move.l	d1,-(sp)		; preserve date
	move.b	cfg_dtfmt,d7		; assume default format
	bsr	sfn_gets
	lea	da_buff(a6),a0
	moveq	#1,d1			; find second parameter
	moveq	#',',d2 		; which comes after a comma
	xjsr	st_findc
	bne.s	date_noopt
	move.b	2(a0,d1.w),d7
	sub.b	#'0',d7
date_noopt
	move.l	(sp)+,d1

	movem.l d6-d7/a0,-(sp)
	move.b	cfg_dtfms,d6		; separator
	lea	da_buff+2(a6),a1	; buffer
	xjsr	ut_datex		; convert to date
	lea	da_buff+2(a6),a0	; buffer
	sub.l	a0,a1			; length of string
	move.w	a1,-(a0)		; ... put before characters
	move.l	a0,a1
	movem.l (sp)+,d6-d7/a0

	 move.l   da_ccell(a6),d1   ; current cell
	 xjsr	  str_main	    ; main entry for string
	 bne.s	  date_exit

	 move.l   a3,val_form(a0)
	 moveq	  #0,d0

date_exit
	 subend

sfn_time subr	  a0/a1/d1
	 bsr	  sfn_getf	    ; get one floating argument
	 bne.s	  time_exit

	 moveq	  #qa.nlint,d0
	 xjsr	  prs_doqa
	 bne.s	  time_exit

	 move.l   (a1),d1	    ; get value
	 lea	  da_buff+2(a6),a1    ; buffer
	 xjsr	  ut_timdat	    ; convert to date
	 lea	  da_buff(a6),a1    ; buffer
	 move.w   #5,(a1)

	 move.l   da_ccell(a6),d1   ; current cell
	 xjsr	  str_main	    ; main entry for string
	 bne.s	  time_exit

	 move.l   a3,val_form(a0)
	 moveq	  #0,d0

time_exit
	 subend



sfn_mon
	 subr	  a0/a1/d1
	 move.l   da_wmvec(a6),a2
	 bsr	  sfn_geti	    ; get integer parameter
	 bne.s	  mon_exit

	 moveq	  #err.orng,d0
	 subq.w   #1,d1
	 bmi.s	  mon_exit

	 divu	  #12,d1
	 swap	  d1

	 xlea	  tab_mon,a1	    ; get month string in table
	 mulu	  (a1)+,d1
	 add.w	  d1,a1

	 move.l   da_ccell(a6),d1   ; current cell
	 xjsr	  str_main	    ; main entry for string
	 bne.s	  mon_exit

	 move.l   a3,val_form(a0)
	 moveq	  #0,d0

mon_exit
	 subend

sfn_day
	 subr	  a0/a1/d1
	 move.l   da_wmvec(a6),a2
	 bsr	  sfn_geti	    ; get integer parameter
	 bne.s	  day_exit

	 moveq	  #err.orng,d0
	 subq.w   #1,d1
	 bmi.s	  day_exit

	 divu	  #7,d1
	 swap	  d1

	 xlea	  tab_day,a1	    ; get month string in table
	 mulu	  (a1)+,d1
	 add.w	  d1,a1

	 move.l   da_ccell(a6),d1   ; current cell
	 xjsr	  str_main	    ; main entry for string
	 bne.s	  day_exit

	 move.l   a3,val_form(a0)
	 moveq	  #0,d0

day_exit
	 subend

sfn_rpt
	 subr	  a0/a1/d1/d2
	 move.l   da_wmvec(a6),a2
	 bsr	  sfn_get2	    ; get arguments
	 bne.s	  rpt_exit

	 moveq	  #err.orng,d0
	 cmp.w	  #da.buff-64,d2     ; maximum length 512-64=448
	 bgt.s	  rpt_exit

	 tst.w	  d2
	 bpl.s	  rpt_ok

	 neg.w	  d2

rpt_ok
	 lea	  da_buff(a6),a0    ; build string in buffer
	 xjsr	  st_filst
	 move.l   a0,a1
	 move.l   da_ccell(a6),d1
	 xjsr	  str_main
	 bne.s	  rpt_exit

	 move.l   a3,val_form(a0)

rpt_exit
	 moveq	  #0,d0
	 subend

sfn_dig
	 subr	  a0/a1/d1/d2
	 move.l   da_wmvec(a6),a2
	 bsr.s	  sfn_geti	    ; get integer parameter
	 bne.s	  dig_exit

	 lea	  da_buff(a6),a0   ; buffer for decimal number
	 xjsr	  ut_ildec
	 xjsr	  st_xpnde
	 move.l   a0,a2

	 lea	  da_buff+20(a6),a0
	 clr.w	  (a0)
	 move.w   (a2)+,d2
	 moveq	  #0,d0
	 bra.s	  dig_lpe

dig_lp
	 move.b   (a2)+,d0
	 cmpi.b   #'-',d0
	 beq.s	  dig_lpe

	 sub.b	  #'0',d0
	 mulu	  #30,d0
	 lea	  mv_digt(a6),a1
	 adda.l   d0,a1
	 xjsr	  st_appst
	 moveq	  #' ',d1
	 xjsr	  st_appc

dig_lpe
	 dbra	  d2,dig_lp

	 move.l   a0,a1
	 move.l   da_wmvec(a6),a2
	 move.l   da_ccell(a6),d1   ; current cell
	 xjsr	  str_main	    ; main entry for string
	 bne.s	  dig_exit

	 move.l   a3,val_form(a0)
	 moveq	  #0,d0

dig_exit
	 subend


;+++
; get one integer argument
;
;		  Entry 		     Exit
;	 a3	  ptr to formular	     preserved
;	 d1.l				     value of arg.
;
; error codes: err.xp etc.
;---
sfn_geti subr	  a0/a1/d2
	 bsr.s	  sfn_gets	    ; get string into buffer

	 lea	  da_buff(a6),a1
	 move.l   a3,-(sp)	    ; invoke formular parser
	 move.l   a1,a3
	 xjsr	  prc_fpar
	 move.l   (sp)+,a3
	 bne.s	  geti_exit

	 lea	  da_buff+da.buff-6(a6),a1   ; top of stack
	 moveq	  #qa.nlint,d0
	 xjsr	  prs_doqa
	 bne.s	  geti_exit

	 move.l   (a1),d1	    ; get integer from stack

geti_exit
	 tst.l	  d0
	 subend

;+++
; get one floating argument
;
;		  Entry 		     Exit
;	 a3	  ptr to formular	     preserved
;	 a1.l				     top of stack
;
; error codes: err.xp etc.
;---
sfn_getf subr	  a0/d2
	 bsr.s	  sfn_gets	    ; get string into buffer

	 lea	  da_buff(a6),a1
	 move.l   a3,-(sp)	    ; invoke formular parser
	 move.l   a1,a3
	 xjsr	  prc_fpar
	 move.l   (sp)+,a3
	 bne.s	  getf_exit

	 lea	  da_buff+da.buff-6(a6),a1   ; top of stack

getf_exit
	 tst.l	  d0
	 subend


;+++
; get one string arguement into the buffer
;
;		  Entry 		     Exit
;	 a3	  ptr to formular	     preserved
;
; error codes... anything can go wrong
;---
sfn_gets subr	  d1-d3/a0-a3
	 move.l   a3,a0
	 moveq	  #1,d1 	    ; find start of argument
	 moveq	  #'(',d2	    ; d1=start position of argument
	 xjsr	  st_findc
	 bne.s	  gets_exit

	 move.w   (a0),d2	    ; find length of argument
	 sub.w	  d1,d2
	 subq.w   #1,d2
	 addq.w   #1,d1

	 lea	  da_buff(a6),a1    ; put the argument into the buffer
	 xjsr	  st_subst

gets_exit
	 tst.l	  d0
	 subend

;+++
; get 2 arguments (char,integer)
;
;		  Entry 		     Exit
;	 a3	  ptr to formular	     preserved
;	 d1.b				     character
;	 d2.l				     value of argument
;
; error codes: err.xp etc.
;---
sfn_get2 subr	  a0/a1/d4
	 move.l   a3,a0

	 moveq	  #1,d1 	    ; find start of argument
	 moveq	  #'(',d2	    ; d1=start position of argument
	 xjsr	  st_findc
	 bne.s	  get2_exit

	 move.b   2(a0,d1.w),d4     ; character argument

	 addq.w   #1,d1 	    ; find start of integer argument
	 moveq	  #',',d2	    ; d1=start position of argument
	 xjsr	  st_findc
	 bne.s	  get2_exit

	 move.w   (a0),d2	    ; find length of argument
	 sub.w	  d1,d2
	 subq.w   #1,d2

	 lea	  da_buff(a6),a1    ; put the argument into the buffer
	 addq.w   #1,d1
	 xjsr	  st_subst
	 bne.s	  get2_exit

	 move.l   a3,-(sp)	    ; invoke formular parser
	 move.l   a1,a3
	 xjsr	   prc_fpar
	 move.l   (sp)+,a3
	 bne	  geti_exit

	 lea	  da_buff+da.buff-6(a6),a1   ; top of stack
	 moveq	  #qa.nlint,d0
	 xjsr	  prs_doqa
	 bne.s	  get2_exit

	 move.b   d4,d1 	    ; character argument
	 move.l   (a1),d2	    ; get integer from stack

get2_exit
	 tst.l	  d0
	 subend


;+++
; case independant string comparison
;
;		  Entry 		     Exit
;	 a0	  ptr to 1st string	     preserved
;	 a1	  ptr to 2nd string	     preserved
;	 d0				     -1 lesser, 0 equal, +1 greater
;---
r_comp	 reg	  a2/a6/d2
sfn_cmp
	 movem.l  r_comp,-(sp)
	 suba.l   a6,a6
	 moveq	  #1,d0 	    ; case independent compare
	 moveq	  #0,d2
	 move.w   ut.cstr,a2
	 jsr	  (a2)
	 movem.l  (sp)+,r_comp
	 rts

	 end

;sfn_xfn  subr	   a0/a1/a3
;	  tst.w    da_extsf(a6)
;	  beq.s    xfn_exit
;
;	  bsr	   sfn_getf
;	  bne.s    xfn_exit
;
;	  bsr.s    xfn_strg
;xfn_exit
;	  lea	   da_extbf(a6),a1   ; buffer
;	  tst.l    d0
;	  beq.s    xfn_skip
;
;	  move.l   #$00013f00,(a1)
;
;xfn_skip
;	  move.l   da_ccell(a6),d1   ; current cell
;	  bsr	   str_main	     ; main entry for string
;	  bne.s    xfn_bye
;
;	  move.l   a3,val_form(a0)
;	  moveq    #0,d0
;xfn_bye  subend

;xfn_strg subr	   a0/a1/d1-d3
;	  lea	   da_extbf(a6),a0
;	  move.l   (a1),(a0)	     ; copy fp from stack
;	  move.w   4(a1),4(a0)
;	  move.l   a0,d1	     ; this address
;	  lea	   da_anbuf(a6),a0
;	  xjsr	   ut_ildec
;	  xjsr	   st_xpnde
;	  move.l   a0,a2
;	  move.l   #$0020ffff,d1     ; add. dataspace, owner
;	  lea	   da_extsf(a6),a0
;	  xjsr	   ut_ldexe
;	  bne.s    xfns_x
;
;	  suba.l   a0,a0	     ; input channel
;	  suba.l   a1,a1	     ; output channel
;	  moveq    #32,d2	     ; pritority
;	  moveq    #-1,d3	     ; wait for job to complete
;	  xjsr	   ut_acjb	     ; activate job
;xfns_x   subend
