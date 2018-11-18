* Spreadsheet					      10/05-92
*	 - filter execution

	 section  prog

	 include  win1_keys_qdos_pt
	 include  win1_keys_qdos_io
	 include  win1_keys_qdos_ioa
	 include  win1_keys_qdos_sms
	 include  win1_keys_sys
	 include  win1_keys_jcb
	 include  win1_keys_err
	 include  win1_mac_oli
	 include  win1_spread_keys

	 xdef	  flt_print


;+++
; load and prepare filter job
;
;		  Entry 		     Exit
;	 d0				     error code
;	 a0	  open pipe id		     preserved
;	 a1	  filter filename	     active pipe id
;---
flt_print
prt.reg reg	d1-d7/a0/a3-a5
	movem.l prt.reg,-(sp)
	move.l	a0,d2
	lea	pipeout_def,a0
	moveq	#ioa.knew,d3
	xjsr	gu_fopen
	bne.s	prt_error
	move.l	a0,d3		; open output pipe first
	lea	pipein_def,a0
	xjsr	gu_fopen
	bne.s	prt_error_cld3	; return error but close other pipe first
	move.l	a0,d4		; input for filter

	move.l	d4,-(sp)
	move.l	d4,d5		; input pipe is #0
	move.l	d2,d6		; print output is #1
;;;	   move.b  colm(a6),d7	   ; colourway for error window
	moveq	#0,d7
	move.l	a1,a0		; driver filename
	xlea	met_drivnm,a5	; printer driver name
	xlea	met_nodriv,a4	; error message
	xjsr	ut_exfilter	; try to start filter
	move.l	(sp)+,d4
	tst.l	d0
	bne.s	prt_error_cld34
	move.l	d4,a0		; input pipe should belong to filter
	xjsr	ioa_sown
;;;	   moveq   #ioa.sown,d0    ; set owner of channel
;;;	   trap    #do.ioa
	move.l	d2,a0		; should be owner of the filter output
	xjsr	ioa_sown
;;;	   moveq   #ioa.sown,d0
;;;	   trap    #do.ioa
	moveq	#8,d2		; now activate the filter at some priority
	moveq	#sms.spjb,d0
	trap	#do.sms2	; get it going

	move.l	d3,a1		; that's the output for QSpread
	bra.s	prt_error

prt_error_cld34
	move.l	d4,a0
	xjsr	gu_fclos
prt_error_cld3
	move.l	d3,a0
	xjsr	gu_fclos

prt_error
	movem.l (sp)+,prt.reg
	tst.l	d0
	rts

pipeout_def
	dc.w	8
	dc.b	'PIPE_980'
pipein_def
	dc.w	4
	dc.b	'PIPE'

	end
