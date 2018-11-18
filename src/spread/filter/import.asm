; Psion Import Filter						1993 O. Fink
;

	section prog
	include win1_keys_err
	include win1_mac_oli
	include win1_spread_file_format_keys

da_inch equ	$00			;input channel id
da_ouch equ	$04			;output channel id
da_col	equ	$08			;number of columns
da_row	equ	$0a			;number of rows
da_cell equ	$18			;cell information
da_cont equ	$1e			;contents string
da_buff equ	$100			;line buffer
da.buff equ	2048			;length of buffer
col	equ	0
row	equ	2

	qdosjob {Psion Import},start
	qstrg	{written 1993 by O.Fink}

start
	xjsr	ut_clwsp		;clear workspace
	move.l	#'1.49',d1		;check extended enviroment versions
	move.l	#'1.39',d2
	move.l	#'3.14',d3
	xjsr	ut_xver
	moveq	#err.ichn,d0
	move.w	(sp)+,d1		;check for two channels
	subq.w	#2,d1
	bne.s	error

	move.l	(sp)+,da_inch(a6)	;get in- and output channel
	move.l	(sp)+,da_ouch(a6)

	bsr	get_line		;get line from input channel
	bne	in_eof			;did we get the end of file

	moveq	#err.ipar,d0		;wrong file format
	move.w	(a1),d1 		;..if line is shorter than 4 chars
	cmp.w	#4,d1
	blt	error

	move.l	2(a1),d1
	cmp.l	#'"x$"',d1		;..if PsionExport wasn't used
	bne	error

	bsr	make_header

	bsr	get_line		; one line of dummies
	bsr	get_line		; get column widths
	bne	in_eof

	moveq	#1,d6			; special mode for columns widths
	clr.w	da_cell+sfc_cnr+row(a6) ; start with the first row

line_loop
	clr.w	da_cell+sfc_cnr+col(a6) ; start with the first column again
	bsr	get_line
	bne	in_eof

	bsr	do_line
	addq.w	#1,da_cell+sfc_cnr+row(a6) ; next row
	moveq	#0,d6			; switch special mode off
	bra.s	line_loop

in_eof
	move.l	da_inch(a6),a0		;close in- and output channels
	xjsr	gu_fclos
	move.l	da_ouch(a6),a0
	xjsr	gu_fclos
	moveq	#0,d0			;no errors

error
	xjsr	ut_appr


; scan a line
do_line
	addq.w	#2,a1			;skip length word

scn_lp1
	lea	da_cont(a6),a2
	moveq	#0,d2			;cell contents length

scn_lp
	move.b	(a1)+,d1		;get character
	cmpi.b	#13,d1			;_exp lines end in CR
	beq.s	scn_exit

	cmpi.b	#',',d1 		;end of item found?
	bne.s	scn_put

	bsr	do_item 		;process item
	addq.w	#1,da_cell+sfc_cnr+col(a6) ; next column
	bra.s	scn_lp1 		;try next item

scn_put
	move.b	d1,2(a2,d2.w)		;put character in contents buffer
	addq.w	#1,d2
	move.w	d2,(a2)

scn_lpe
	bra.s	scn_lp

scn_exit
	rts

do_item subr	a0-a3/d1-d2
	lea	da_cell(a6),a3
	bsr	no_quotes		; remove quotes from psion export

	move.w	#2,sfc_fwrd(a3) 	; format is number
	tst.w	(a2)			; any string at all?
	beq.s	nocell			; no...

	xjsr	st_isdcs		; is it a number?
	beq.s	number

	moveq	#0,d1			; insert " at beginning
	moveq	#'"',d2
	xjsr	st_insc
	move.w	#2048,sfc_fwrd(a3)	; format is string

number
	tst.w	d6			; are we in special columns mode?
	beq.s	nnum

	lea	da_cell+sfc_form(a6),a0
	lea	da_cell(a6),a1
	xjsr	ut_deciw
	move.w	(a1),d1
	move.l	da_ouch(a6),a0		; this is the output file
	xjsr	ut_prchr
	clr.l	(a1)
	bra.s	nocell

nnum
	moveq	#sfc_form,d0
	add.w	sfc_form(a3),d0 	; total bytes to write for this cell
	move.l	da_ouch(a6),a0		; this is the output file
	move.l	a3,a1			; buffer is a1
	xjsr	ut_prmul		; print multple bytes to channel

nocell
	subend


;
; remove quotes,... string is at a2
no_quotes	subr	a0/d1
	move.l	a2,a0			; a0 is the string
	subq.w	#1,(a0) 		; delete trailing "
	moveq	#1,d1
	xjsr	st_delc 		; delete first "
	subend

; returns with a1=da_buff(a6)
get_line				;read line from file into buffer
	subr	a0/d2
	move.l	#da.buff,d2
	lea	da_buff(a6),a1
	move.l	da_inch(a6),a0
	xjsr	ut_instr
	subend

make_header	subr	a0-a3/d1-d3
	bsr	read_str
	bne.s	hdr_exit

	lea	da_buff(a6),a1
	move.l	#sfh.init,sfh_init(a1)
	move.l	#sfh.id,sfh_id(a1)
	move.l	#sfh.vers,sfh_vers(a1)
	move.w	da_col(a6),sfh_cols(a1)
	move.w	da_row(a6),sfh_rows(a1)
	move.l	da_ouch(a6),a0
	moveq	#sfh.len,d0
	xjsr	ut_prmul

hdr_exit
	subend

read_str
	moveq	#-1,d1			; origin
	moveq	#0,d2			; white/green
	moveq	#20,d3			; 10 characters
	lea	met_psi(pc),a0		; title
	lea	met_nc(pc),a2		; number of columns
	lea	da_buff(a6),a3		; buffer
	move.l	#$00023230,(a3) 	; default 20
	xjsr	mu_reqst
	bne.s	read_exit

	lea	met_nr(pc),a2
	adda.w	#$20,a3
	move.l	#$00023230,(a3) 	; default 20
	xjsr	mu_reqst
	bne.s	read_exit

	lea	da_buff(a6),a0
	lea	da_buff+$40(a6),a1
	xjsr	ut_deciw
	bne	read_exit

	move.w	(a1),da_col(a6)
	adda.w	#$20,a0
	xjsr	ut_deciw
	bne	read_exit

	move.w	(a1),da_row(a6)

read_exit
	tst.l	d0
	rts


met_psi qstrg	{PsionImport}
met_nc	qstrg	{Number of columns}
met_nr	qstrg	{Number of rows}

	end
