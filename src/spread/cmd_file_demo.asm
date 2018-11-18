* Spreadsheet					03/03-92
*	- file command routines

	section prog

	include win1_keys_wman
	include win1_keys_wstatus
	include win1_keys_wwork
	include win1_keys_err
	include win1_keys_k
	include win1_keys_qdos_ioa
	include win1_keys_qdos_io
	include win1_mac_oli
	include win1_spread_keys

	xdef	fil_forg
	xdef	fil_xloa
	xdef	fil_ximp,fil_mpag
	xdef	fil_prtf
	xdef	forg_grd,fil_setf
	xdef	blk_stor,blk_rstr

	xref.l	mv_sznc,mv_sznr,mv_popp,mv_popf,mv_popw
	xref.l	wst_main,mv_poef,mv_popl,mv_poif

blk_stor
	move.l	da_cbx0(a6),da_anbuf(a6)
	move.l	da_cbx1(a6),da_anbuf+4(a6)
	rts

blk_rstr
	movem.l d1/d0,-(sp)
	move.l	da_anbuf(a6),d1
	xjsr	cel_topl
	move.l	da_anbuf+4(a6),d1
	xjsr	cel_botr
	movem.l (sp)+,d1/d0
*
* print at page
fil_prtp
	bsr.s	blk_stor
	bsr.s	fil_page
	bsr	fil_prtb
	bsr.s	blk_rstr
	tst.l	d0
	rts

fil_mpag
	bsr.s	fil_page
	tst.l	d0
	rts

fil_page
	subr	a0-a4/d1-d4
	move.l	da_cbx0(a6),d1		; current cell
	move.w	mv_popw(a6),d4		; paper width
	xjsr	cel_wdth
	sub.w	d3,d4
	ble.s	page_sc

page_clp
	add.l	#$00010000,d1		; next column
	xjsr	in_grid
	bne.s	page_cx

	xjsr	cel_wdth
	sub.w	d3,d4
	bge	page_clp

page_cx
	sub.l	#$00010000,d1

page_sc
	move.w	mv_popl(a6),d4
	subq.w	#1,d4
	ble.s	page_sr

page_rlp
	addq.w	#1,d1
	xjsr	in_grid
	bne.s	page_rx

	subq.w	#1,d4
	bgt	page_rlp

page_sr
	move.l	da_wwork(a6),a4
	xjsr	cel_clr
	move.l	d1,da_cbx1(a6)
	xjsr	cel_newb
	subend

page_rx subq.w	#1,d1
	bra.s	page_sr

*
* print formulae report
fil_prtf
	subr   a0-a5/d1-d4
	bsr	opn_prt
	bne.s	prtf_exit

	move.l	da_cbx0(a6),da_anbuf(a6)
	lea	prtf_act,a5
	xjsr	mul_blok

prtf_clos
	xjsr	gu_fclos		; close printer

prtf_exit
	subend


prtf_act
	subr   a0-a3/d1-d4
	move.l	d1,d2
	swap	d2
	cmp.w	da_anbuf(a6),d2
	beq.s	prtf_line

	xjsr	ut_prlf

prtf_line
	move.l	d1,da_anbuf(a6)
	lea	da_buff(a6),a1
	xjsr	acc_getf
	bmi.s	prtf_skip

	cmpi.b	#'"',2(a1)
	beq.s	prtf_skip

	bsr.s	prtf_ref
	bmi.s	prtf_skip

	xjsr	ut_prstr

prtf_skip
	xjsr	ut_prtab
	moveq	#0,d0
	subend

prtf_ref
	 subr	a0-a3/d1-d3
	 move.l a1,a0
	 lea	da_echs(a6),a1
	 lea	da_echl(a6),a2
	 xjsr	cel_fref		   ; find references
	 tst.l	(a2)
	 subend

*
* print a block
fil_prtb
	subr	a0-a4/d1-d4
	bsr.s	opn_prt 	; open printer
	bne.s	prtb_exit

	lea	mv_popf(a6),a1	; link filter job
	tst.w	(a1)
	beq.s	prtb_prt		; no filter, print normal

	xjsr	flt_expt
	bne.s	prtb_clos

	exg	a0,a1

prtb_prt
	xjsr	fil_prnt		; print block

prtb_clos
	xjsr	gu_fclos		; close printer

prtb_exit
	subend


opn_prt
	subr	d1-d3
prt_try
	moveq	#ioa.open,d0
	moveq	#myself,d1
	moveq	#ioa.kovr,d3
	lea	mv_popp(a6),a0
	trap	#do.ioa
	tst.l	d0
	beq.s	prt_exit

	bsr	fil_err
	tst.l	d0
	beq.s	prt_exit

	bra.s	prt_try

prt_exit
	subend

fil_xloa
	moveq	#0,d0
	bra.s	fil_loax

fil_ximp
	moveq	#-1,d0

*
* load a new file
r_forg	reg	a3
fil_loax
	subr	a0-a4/d1-d4/d7
	move.l	d0,d7
	bsr	conf_forg	; confirm forget
	beq.s	xloa_exit	; ... do not load!

xloa_edt
	bsr	gfn_load		; get filename for loading
	bgt.s	xloa_no

	moveq	#ioa.kshr,d3	; open key=shared

xloa_try
	lea	da_fname(a6),a0
	xjsr	gu_fopen	 ; open new file
	beq.s	xloa_ok

	bsr	fil_err 	; errors...
	beq.s	xloa_no 	; esc'aped, give up

	moveq	#ioa.kshr,d3
	subq.w	#1,d0
	beq.s	xloa_try		; retry

	bra.s	xloa_edt		; edit name

xloa_ok
	bsr.s	set_ifj 	; setup import filter
	bne.s	xloa_clo

	xjsr	fil_load		; load file contents
	bsr.s	fil_extn		; add extension for imported file

xloa_clo
	xjsr	gu_fclos		; close logic file
	bsr.s	clo_phys		; close physical file

xloa_exit
	tst.l	d0
	subend

;
; loading was unsuccessful
xloa_no
	move.w	#0,da_fname(a6)
	moveq	#0,d0
	bra.s	xloa_exit

;
; close physical file
clo_phys
	subr	a0/d0
	tst.l	d7
	beq.s	cphys_exit

	move.l	d7,a0
	xjsr	gu_fclos

cphys_exit
	subend

;
; add extension to filename
fil_extn
	subr	d0/a0/a1
	lea	da_fname(a6),a0
	lea	da_fextn(a6),a1
	xjsr	ut_fextn
	subend

;
; setup the import filter job
set_ifj
	subr	a1
	tst.b	d7
	beq.s	setifj_exit

	lea	mv_poif(a6),a1	; setup import filter
	tst.w	(a1)
	beq.s	setifj_exit

	moveq	#0,d7
	xjsr	flt_impt
	bne.s	setifj_exit

	move.l	a0,d7		; physical channel id
	move.l	a1,a0		; channel to read from
	moveq	#0,d0

setifj_exit
	subend


gfn_load
	subr	a0-a4/d0-d4
	moveq	#-1,d1		; window origin
;;;	   move.b  cols(a6),d2	  ; window colourways
;;;	   swap    d2
;;;	   move.b  colm(a6),d2
;;;	   andi.l  #$000F000F,d2
	moveq	#0,d2
	moveq	#0,d5		; max. number of lines
	xlea	met_load,a0	; menu header
	lea	da_fname(a6),a2 ; pointer to current filename
	move.l	a2,a4
	lea	da_fextn(a6),a3 ; default _tab extension
	move.l	a3,d4
	lea	da_datad(a6),a3 ; data default directory

	tst.b	d7		; was it load or import
	beq.s	gfnl_do

	moveq	#0,d4		; no extension for import
	xlea	met_imp,a0	; another menu name

gfnl_do
	xjsr	mu_fsel
	subend



fil_oldf
	subr	a0/a1
	lea	da_fname(a6),a1
	lea	da_oldf(a6),a0
	xjsr	ut_cpyst
	subend


fil_sold
	subr	a0/a1
	lea	da_fname(a6),a0
	lea	da_oldf(a6),a1
	xjsr	ut_cpyst
	subend

rdfn_exit
	tst.l	d0
	subend

rdfn_nc
	moveq	#err.nc,d0
	bra.s	rdfn_exit

fil_setf
	subr	a0-a3/d0-d3
	move.l	da_wmvec(a6),a2
	move.l	da_wwork(a6),a4
	xjsr	set_fnam
	moveq	#-5,d3		; redraw info window 2
	jsr	wm.idraw(a2)
	tst.l	d0
	bne	do_kill

	subend


;+++
; report a file error
;
;		Entry			Exit
;	d0	error code		-1 no file error
;					0  ESC
;					1  retry
;					2  overwrite
;					3  edit
;---
fil_err
	subr	d1-d3
	moveq	#-1,d1
;;;	   move.b  colm(a6),d2
	moveq	#0,d2
	moveq	#1,d3
	xjsr	mu_filer
	tst.l	d0
	bmi	do_kill

	subq.l	#1,d0
	beq.s	err_esc

	move.l	d3,d0

err_exit
	subend

err_esc
	moveq	#0,d0
	bra.s	err_exit


*
* confirmation to forget file
conf_forg
	subr  a3
	move.w	da_saved(a6),d0
	bne.s	conf_exit

	xlea	ask_forg,a3
	xjsr	ask_yn

conf_exit
	subend

*
* forget sheet and setup a new one
* r_forg	  reg	  a3	 ; already definied
fil_forg
	move.l	a3,-(sp)
	move.l	ww_wstat(a4),a1
	bsr.s	conf_forg	    ; confirmation to forget
	beq.s	forg_exit

forg_siz
	xjsr	siz_puld
	cmpi.b	#k.cancel,d4		; intercepted?
	beq.s	forg_exit

*				      check for window manager error!
	move.l	(a2),d0
	sub.l	#'1.45',d0
	bgt.s	fil_new

	move.w	mv_sznc(a6),d0
	mulu	mv_sznr(a6),d0
	cmp.l	#$7fff,d0
	bmi.s	fil_new

	movem.l r_forg,-(sp)
	xlea	ask_covr,a3
	xjsr	ask_yn
	movem.l (sp)+,r_forg
	beq	forg_siz
*

fil_new
	move.w	mv_sznc(a6),da_ncols(a6)	; set new grid size
	move.w	mv_sznr(a6),da_nrows(a6)
	move.w	#1,da_saved(a6)
	clr.w	da_fname(a6)
	bsr.s	forg_grd

forg_exit
	move.l	(sp)+,a3
	rts

do_kill
	xjmp	kill

;+++
; release all memory, set grid of new size and redraw window
; (gridsize is set in da_ncols/da_nrows)
;
;---
forg_grd
	subr	a0-a3/d1-d3
	xjsr	dma_quit		; release complete dma
	bne.s	grd_exit

	move.l	da_miobl(a6),a0 	; release menu object space
	xjsr	ut_rechp
	bne.s	grd_exit

	move.l	da_chan(a6),a0
	xjsr	setmol			; create new objects
	xjsr	dma_frst		; set first dma block
	xjsr	fnm_init		; format number initialisation
	xjsr	glb_unit		; set global units format
	xjsr	stt_init
	clr.w	da_dupdt(a6)		; allow for display update
	move.w	#1,da_saved(a6) 	; file is saved
	move.l	#0,da_cbx0(a6)		; first cell is selected
	move.l	#0,da_usedx(a6) 	; ..and the last currently used
	move.l	#-1,da_cbx1(a6)
	xlea	men_main,a3
	lea	wst_main(a6),a1
	move.l	da_wmvec(a6),a2
	move.l	da_winsz(a6),d1
	move.l	wsp_xorg(a1),d6
	move.l	wsp_xpos(a1),d5
	add.l	d5,d6
	xjsr	set_nset
	bne.s	grd_exit

	move.l	da_cbx0(a6),d1
	bsr	cel_topl
	moveq	#0,d0

grd_exit
	tst.l	d0
	subend

	end
