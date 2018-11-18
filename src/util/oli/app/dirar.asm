; create a directory array

	include win1_mac_oli
	include win1_keys_hdr
	include win1_keys_qdos_io
	include win1_keys_qdos_ioa

	section utility

	xdef	ut_dirar

;+++
; create a directory array
;
;		Entry				Exit
;	d1.w	file types (bits)
;		bit 0 (1)   data
;		bit 1 (2)   exec
;		bit 2 (4)   reloc
;		bit 3 (8)   loader reloc
;		bit 7 (128) directory
;	d2.b	0 full names, 1 short
;	d3.b	0 no type info, 1 add info
;	a0	ptr to directory name		array descriptor
;	a1	ptr to subdir buffer (or 0)	preserved
;
; errors: ioss, imem
; cc set
;---
chid	equ	0		l directory channel id
subd	equ	4		w subdirectory name length
buff	equ	6		40 bytes string buffer
type	equ	46		w file types
name	equ	48		b name length
info	equ	49		b type info
hdr	equ	50		64 bytes header buffer
buff2	equ	114		more buffer

ut_dirar subr	a1-a3/d1-d4
	bsr	alloc			; allocate workspace
	bne.s	exit			; oops, imem...

	move.w	d1,type(a3)		; set type para
	move.b	d2,name(a3)
	move.b	d3,info(a3)

	bsr	opendir 		; open directory
	bne.s	bye			; problems..?
	move.l	a0,chid(a3)		; store channel id

	move.l	a1,d0
	bne.s	sdir_ok
	lea	subd(a3),a1
sdir_ok
	xjsr	ut_fname		; get real subdirectory name
	bne.s	xclos
	move.w	(a1),subd(a3)		; no subdir name found..
	beq.s	lenok			; length is ok
	move.w	(a1),d0
	cmpi.b	#'_',1(a1,d0.w)
	beq.s	lenok
	addq.w	#1,subd(a3)		; take care of underscore
lenok
	lea	scan,a1 		; count and copy routine
	moveq	#-1,d1			; nr of entries is unknown
	xjsr	ut_mk2sa		; make 2 dim strg array
xclos	bsr	close
bye	bsr	release 		; release workspace
exit	tst.l	d0
	subend

;
; count and copy routine
scan	subr	d1/d3/a0-a3
	tst.l	d0
	beq.s	copy
	bsr.s	entry
	bne.s	scan_exit
	move.w	buff(a3),d2
	addq.w	#2,d2
scan_exit
	subend

copy	tst.w	d1
	bne.s	copy_skip
	move.l	a0,-(sp)
	move.l	chid(a3),a0
	xjsr	ut_rewind
	move.l	(sp)+,a0
copy_skip
	bsr.s	entry
	bne.s	scan_exit
	lea	buff(a3),a1
	xjsr	ut_cpyst
	bra.s	scan_exit


entry	subr	a0-a3/d1-d3
	move.l	chid(a3),a0		; channel id
ent_lp	lea	hdr(a3),a1		; buffer
	moveq	#64,d2			; length
	xjsr	ut_inmul		; read 64 bytes from channel
	bne.s	ent_exit
	adda.w	#2,a1			; adjust buffer
	tst.l	hdr_flen(a1)		; was file deleted?
	beq.s	ent_lp			; read next entry
	move.b	hdr_type(a1),d1 	; get file type
	bsr.s	chk_type		; check if filetype is allowed
	bne.s	ent_lp			; no.. read next entry
	bsr.s	do_info
	bsr.s	do_name
	moveq	#0,d0
ent_exit
	subend

do_name subr	a0/a1/a2
	tst.b	name(a3)
	bne.s	short
	lea	hdr_name(a1),a1
nam_app lea	buff(a3),a0
	xjsr	st_appst
	subend
short	lea	hdr_name(a1),a0
	lea	buff2(a3),a2
	suba.l	a1,a1
	move.w	subd(a3),d1
	xjsr	st_splta
	move.l	a2,a1
	bra.s	nam_app

do_info clr.w	buff(a3)		; no string in buffer
	cmpi.b	#hdrt.dir,d1		; type dir
	beq.s	inf_dir 		; always mark directory

	tst.b	info(a3)		; info requested
	beq.s	inf_exit		; no...

	move.w	#2,buff(a3)		; 2 character strings
	mulu	#2,d1
	move.w	inf_tab(pc,d1.w),buff+2(a3)
inf_exit
	rts
inf_dir move.l	#$00023e20,buff(a3)	; directory marker
	rts
inf_tab dc.w	'  E r l '


chk_type subr	d1
	move.w	type(a3),d0
	cmpi.b	#hdrt.dir,d1		; was it a directory?
	beq.s	chk_dir
	btst	d1,d0			; test for filetype
	beq.s	chk_no			; bit not set.. not allowed
	bra.s	chk_ok

chk_dir btst	#7,d0			; directories allowed?
	beq.s	chk_no			; bit not set.. not allowed
chk_ok	moveq	#0,d0
	bra.s	chk_exit
chk_no	moveq	#-1,d0
chk_exit subend


opendir subr	d3
	moveq	#ioa.kdir,d3		; try to open directory
	xjsr	do_open
	subend

alloc	subr	d1/a0
	move.l	#512,d1
	xjsr	ut_alchp
	move.l	a0,a3
	tst.l	d0
	subend


release subr	a0
	move.l	a3,a0
	xjsr	ut_rechp
	subend

close	subr   a0
	move.l	chid(a3),a0
	xjsr	do_close
	subend

	end
