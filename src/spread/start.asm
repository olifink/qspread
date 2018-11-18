* Spreadsheet					      29/11-91
*	 - qdos job startup

	 include win1_keys_qdos_sms
	 include  win1_mac_oli
	 include  win1_spread_keys

	 section  start

	 xdef	  jobbase,cltab

	 xref.l   qs_vers,qs_date1,qs_date2,qs_date3

jobbase
	bra	start
	dc.w	0
	dc.w	$4AFB
qd_name
	dc.w	7
	dc.b	'QSpread                            '
	dc.b	'1992-2003 Jochen Merz Software   V'
	ds.w	0
	dc.l	qs_vers
	dc.l	qs_date1
	dc.l	qs_date2
	dc.l	qs_date3

	dc.b	10,0

cltab	 clkey	  {f},0,da_fname,42
	 clkey	  {h},0,da_helpd,42
	 clkey	  {d},0,da_fltd,42
	 clkey	  {e},0,da_fextn,6
	 clkey

	section relocation

relregs reg	d0/d1-d2/a0/a1		these are the registers used

start				      ; this is the relocation code
	movem.l relregs,-(sp)		it's fairly short
	lea	jobbase(pc),a1		this is program base
	move.l	a1,d2			in d2 for offsetting
	lea	rel_table(pc),a1	this is the table base
	tst.l	(a1)			any relocation items
	beq.s	no_table		no relocation or second start

	moveq	#sms.cach,d0
	moveq	#0,d1			cache off
	trap	#$1

	move.l	(a1)+,d0		get nr of relocation items
	bra.s	rel_dbra

nextone
	move.l	(a1)+,a0		get offset of item to relocate
	add.l	d2,0(a0,d2.l)		add base of program to it

rel_dbra
	subq.l	#1,d0
	bpl.s	nextone 		loop until finished

	lea	rel_table(pc),a1	this is the table base
	clr.l	(a1)			only one relocation

	moveq	#sms.cach,d0
	moveq	#1,d1			cache on
	trap	#$1

no_table
	movem.l (sp)+,relregs		end of relocation code

	jmp	main			go to program start

;-----------------------------------------------------------------------------
	section reltable
rel_table				; linker will put table in here

;   The Qlink/GST linker format relocation table is
; 
;	long	    Count of number of addresses needing relocation
;	long...     Displacement of address needing relocation relative
;		    to program start.


;-----------------------------------------------------------------------------
	section init

main
	xjmp	jobstart


	 end
