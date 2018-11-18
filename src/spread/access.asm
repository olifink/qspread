* Spreadsheet					      26/07-92
*	 - sheet access routines

	 section  prog

	 include  win1_keys_wman
	 include  win1_keys_wstatus
	 include  win1_keys_wwork
	 include  win1_keys_err
	 include  win1_mac_oli
	 include  win1_mac_xref
	 include  win1_spread_keys

	 xdef	calc_all
	 xdef	  acc_selr		     ; select one row
	 xdef	  acc_selc		     ; select one column
	 xdef	  acc_calc		     ; complete recalculation/redraw
	 xdef	  acc_clcn		     ; numeric calculation/redraw
	 xdef	  acc_tstf		     ; test for formula in sheet
	 xdef	  acc_putf		     ; put formula into sheet
	 xdef	  acc_getf		     ; get formula from sheet
	 xdef	  acc_fwrd		     ; set/change format word
	 xdef	  acc_clr		     ; clear a cell
	 xdef	  acc_goto		     ; goto cell d1
	 xdef	  acc_wdth		     ; set new column width
	 xdef	  acc_cont		     ; get cell contents

	 xref.l   mcx_grid,mcy_grid

;+++
; set new column width
;		Entry			Exit
;	d1.l	col|(row)		preserved
;	d2.w	width in chars (1-60)	preserved
;
; errors: orng
;---
acc_wdth subr d1/d2/a4
	move.l	da_wwork(a6),a4
	xjsr	in_grid 		; test if column is in grid
	bne.s	wdth_exit

	moveq	#err.orng,d0		; test for char width 1..60
	tst.w	d2
	beq.s	wdth_exit

	cmpi.w	#60,d2
	bgt.s	wdth_exit

	move.l	d1,d0			; column number
	swap	d0
	xjsr	cel_cwdt
	moveq	#0,d0

wdth_exit
	tst.l	d0
	subend

;+++
; goto cell d1
;
;		Entry			Exit
;	d1.l	col|row of cell 	preserved
;---
acc_goto
	 xjsr	  cel_topl		     ; mark top left cell
	 move.w   #1,mcx_grid+wss_nsec(a6)   ; one section..
	 move.w   #1,mcy_grid+wss_nsec(a6)   ; ..in each dimension

	 move.w   d1,mcy_grid+wss_sstt+2(a6) ; set first row cell
	 swap	  d1
	 move.w   d1,mcx_grid+wss_sstt+2(a6) ; set first column cell
	 xjsr	  rdw_grdr
	 rts

;+++
; select row of cell d1
;
;		  Entry 		     Exit
;	 d1.l	  col|row of cell	     preserved
; error : row not in grid
; condition codes: set
;---
acc_selr subr	  d1
	 xjsr	  in_grid
	 bne.s	  selr_exit

	 andi.l   #$ffff,d1
	 xjsr	  cel_topl
	 swap	  d1
	 move.w   da_ncols(a6),d1
	 subq.w   #1,d1
	 swap	  d1
	 xjsr	  cel_botr
	 moveq	  #0,d0

selr_exit
	 subend



;+++
; select column of cell d1
;
;		  Entry 		     Exit
;	 d1.l	  col|row of cell	     preserved
; error : column not in grid
; condition codes: set
;---
acc_selc subr	  d1
	 xjsr	  in_grid
	 bne.s	  selc_exit

	 clr.w	  d1
	 xjsr	  cel_topl
	 move.w   da_nrows(a6),d1
	 subq.w   #1,d1
	 xjsr	  cel_botr
	 moveq	  #0,d0

selc_exit
	 subend



;+++
; recalculate grid, redraw it completly (remove sections)
;
; error/condition codes set
;---
acc_calc
	 bsr.s	  calc_all	    ; calculate all
	 xjsr	  rdw_grdr		     ; redraw complete
	 rts

calc_all subr	  d1-d3/a0/a2/a5
	 addq.w   #1,da_dupdt(a6)	     ; do not update the display
	 xlea	  cel_clcs,a5		     ; calculate current cell (strings too)
	 xjsr	  mul_grid		     ; ..over the grid
	 subq.w   #1,da_dupdt(a6)	     ; display update allowed again
	 subend


;+++
; recalculate numeric values, redraw (preserve sections)
;
; error/condition codes set
;---
acc_clcn
	 bsr.s	  calc_do
	 xjsr	  rdw_grid
	 rts

calc_do  subr	  d1-d3/a0/a2/a5
	 addq.w   #1,da_dupdt(a6)	     ; do not update the display
	 xlea	  cel_clcs,a5		     ; calculate current (numeric) cell
	 xjsr	  mul_grid		     ; ..over the grid
	 subq.w   #1,da_dupdt(a6)	     ; display update allowed again
	 subend


;+++
; get formula from cell in sheet
;
;	 d0				     form.word|0=number/1=string
;	 d1.l	  c|r of cell to fetch
;	 a1	  ptr to string buffer (or 0)
;
; condition codes set according to d0.w
; or itnf
;---
acc_getf subr	  a0-a4/d1
	 move.l   a1,d0
	 beq.s	  gf_skip

	 clr.w	  (a1)			     ; no formula

gf_skip
	 xjsr	  in_grid
	 bne.s	  getf_exit

	 move.l   da_wwork(a6),a4
	 xjsr	  dta_vadr
	 bne.s	  getf_end

	 move.l   a1,a0 		     ; destination
	 move.l   val_form(a3),d0	     ; source
	 beq.s	  getf_exit

	 move.l   d0,a1
	 xjsr	  ut_cpyst
	 move.w   val_fwrd(a3),d0
	 swap	  d0
;	  move.w   val_fwrd(a3),d0
;	  btst	   #fw..strg,d0
	 cmpi.b   #'"',2(a1)
	 bne.s	  getf_exit

	 move.w   #1,d0 		     ; it was a string
	 bra.s	  getf_end

getf_exit
	 move.w   #0,d0

getf_end tst.w	  d0
	 subend

;+++
; get cell contents
;
;		Entry			Exit
;	d1.l	c|r of cell
;	d3.w				length of entry (a1=0)
;	a1	ptr to string buffer (or 0)
; errors itnf, orng
;---
acc_cont subr	  a0/a3/a4/d1
	 move.l   a1,a0 		; destination a0
	 xjsr	  in_grid		; test if cell is in grid
	 bne.s	  cont_end

	 move.l   da_wwork(a6),a4
	 xjsr	  dta_vadr
	 bne.s	  cont_end

	 moveq	  #err.itnf,d0		; return string only when there
	 tst.l	  val_form(a3)		; is a corresponding formula
	 beq.s	  cont_end

	 lea	  val_strg(a3),a1	; source
	 move.w   (a1),d3
	 xjsr	  ut_cpyst
	 move.w   val_fwrd(a3),d0
	 btst	  #fw..strg,d0		     ; was it a number
	 beq.s	  cont_exit

	 btst	  #fw..cont,d0		     ; continuating string?
	 beq.s	  cont_exit		     ; ..no

cont_lp
	 xjsr	  cel_nxtc
	 bne.s	  cont_exit

	 xjsr	  dta_vadr
	 bne.s	  cont_exit

	 move.w   val_fwrd(a3),d0
	 btst	  #fw..strg,d0		     ; was it a number
	 beq.s	  cont_exit

	 lea	  val_strg(a3),a1
	 move.l   a0,d0
	 beq.s	  cont_nap

	 xjsr	  st_appst

cont_nap
	 add.w	  (a1),d3
	 move.w   val_fwrd(a3),d0
	 btst	  #fw..cont,d0		     ; continuating string?
	 bne.s	  cont_lp

cont_exit
	 move.w   #0,d0

cont_end tst.w	  d0
	 subend

;+++
; test for formula in sheet
;
;	d1	col|row of cell
;
; condition codes: err.itnf	no value block connected
;		   err.orng	cell not in sheet
;---
acc_tstf subr	  a4/a3/d1
	 xjsr	  in_grid		; cell in sheet anyway?
	 bne.s	  tstf_exit

	 move.l   da_wwork(a6),a4
	 xjsr	  dta_vadr		; any value block
	 bne.s	  tstf_exit		; nope, so no formula

	 moveq	  #err.itnf,d0
	 tst.l	  val_form(a3)		; value, but no formula
	 beq.s	  tstf_exit

	 moveq	  #0,d0

tstf_exit
	 tst.l	  d0
	 subend

;+++
; put formula into sheet
;
;		  Entry 		     Exit
;	 d1.l : cell number		     preserved
;	 a1   : ptr to formula		     preserved
;
; error codes: err.iexp etc...
;---
acc_putf subr	  a0-a4/d1-d3
	 xjsr	  in_grid
	 bne.s	  putf_exit

	 tst.w	  (a1)
	 beq.s	  putf_clr		     ; clear cell when no formula

	 jsr	  acc_fdma		     ; store formula
	 move.l   d1,da_ccell(a6)
	 move.l   a0,a3
	 move.l   da_wwork(a6),a4

	 xjsr	  prc_data

putf_exit
	 subend

putf_clr
	 jsr	  acc_clr		     ; clear cell d1
	 bra.s	  putf_exit

;+++
; set/change format word of cell
;
;		  Entry 		     Exit
;	 d1.l	  col|row		     preserved
;	 d2	  format word		     preserved
;
; errors and condition codes set
;---
acc_fwrd subr	  a3
	 xjsr	  in_grid		     ; is cell in grid?
	 bne.s	  fwrd_exit

	 bsr	  dta_vadr
	 bne.s	  fwrd_exit

	 move.w   d2,val_fwrd(a3)

fwrd_exit
	 subend


;+++
; clear cell
;
;	 d1.l : cell number		     preserved
;
; error codes: err.orng if cell out of range
;---
acc_clr
	 xjsr	  in_grid
	 bne.s	  clr_exit

	 xjsr	  dta_rmvf		     ; remove cell and formula

clr_exit
	 rts

;+++
; put formula string into dma
;
;	 a0   : 			     address of string in dma
;	 a1   : ptr to string		     preserved
;
; error codes: always ok
;---
acc_fdma subr	  d1
	 moveq	  #0,d1
	 move.w   (a1),d1		     ; get length of string
	 beq.s	  fdma_exit

	 addq.w   #3,d1 		     ; !!! plus termination char
	 xjsr	  dma_aloc		     ; allocate space in dma
	 bmi.s	  do_kill

	 xjsr	  ut_cpyst		     ; copy string into dma

fdma_exit
	 moveq	  #0,d0
	 subend

do_kill
	 xjmp	kill

	 end
