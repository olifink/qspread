* Spreadsheet					      28/12-91
*	 - formular action routine

	 section  prog

	 include  win1_keys_wman
	 include  win1_keys_wstatus
	 include  win1_keys_wwork
	 include  win1_keys_qdos_pt
	 include  win1_keys_err
	 include  win1_keys_k
	 include  win1_keys_qdos_io
	 include  win1_mac_oli
	 include  win1_spread_keys
	 include  win1_mac_assert

	 xdef	  mea_newd	    ; action routine for data entry
	 xdef	  mea_newddo	    ; action routine for "big" data entry
;	  xdef	   dta_edit	     ; go here after cell selection mode
	 xdef	  dta_cell	    ; update formular string
	 xdef	  dta_entr	    ; make an value entry
	 xdef	  dta_madr	    ; get ptr to cell menu item
	 xdef	  dta_vadr	    ; get adr of item value block
	 xdef	  dta_fbuf	    ; put formular into buffer
	 xdef	  dta_prcs	    ; process one cell
	 xdef	  dta_rmvf,dta_rmvc ; remove cell, remove cell+formular
	 xdef	  data_edt,do_edit  ; identification entry point

	 xref.s   mli.data,mli.call

	 xref.l   mlo.data,wwa.eddo,wst_eddo

	 assert  k.do+2,mact.doed

mea_newddo
	 moveq	  #k.do,d2	    ; DO it all the time
	 bra.s	skip_alt_tab

mea_newd
	tst.b	v_altbuff(a6)	; was ALT TAB pressed?
	beq.s	skip_alt_tab	; no
	clr.b	v_altbuff(a6)
	move.l	#$00180020,d1
	tst.w	da_toolb(a6)	; toolbar enabled?
	bne.s	alt_tab_set
	sub.w	#14,d1		 ; move a bit up
alt_tab_set
	moveq	#iop.sptr,d0
	moveq	#1,d2
	trap	#do.io		; reposition pointer
	xjmp	ut_rdwci

skip_alt_tab
	move.l	d7,-(sp)
	 move.w   d2,d7 	    ; keep selection keystroke
	 move.l   da_cbx0(a6),d1    ; first selected cell
	 bsr	  dta_cell
	 xjsr	  mod_norm
	 bsr	  unselect
	 moveq	  #0,d4 	    ; no event

	move.w	d7,d0
	move.l	(sp)+,d7
	addq.w	#mact.edit,d0

;;	   moveq    #mact.edit,d0     ; no error, but do the actual editing
;;	   add.w    d7,d0	      ; 2 for HIT, 4 for DO
;;	   move.l (sp)+,d7
	 rts

;
; outside edit routine...  a4:wwork
do_edit

	 move.w   d0,d4
	 move.l   da_ccell(a6),d1    ; first selected cell
	 xjsr	  is_proct
	 beq	  data_bye1

	 tst.w	  da_buff(a6)
	 bne.s	  data_edt

data_lp
	 bsr	  dta_fbuf	    ; no, put formular into buffer

data_edt
	 move.l   d1,da_ccell(a6)   ; is current cell
	 xjsr	  cel_highl	    ; highlight cell
	 bsr	  dta_edit	    ; edit data/formular string
	move.b	d2,d7		; preserve keystroke

	 xjsr	  cel_nohigh
	 tst.l	  d0
	 bne.s	  data_next	    ; string too long, take next one

	cmpi.b	#k.esc,d7	; check termination codes
	beq.s	data_exit	; ESCaped ?

	cmpi.b	#k.up,d7	; cell selection mode?
	bne.s	noterm

	 xjsr	  mod_selc
	 xjmp	  do_window

noterm
	 tst.b	  ws_litem+mli.call(a1)      ; all.. ?
	 beq.s	  data_act

	 addq.w   #1,da_dupdt(a6)   ; no display update
	 xjsr	  mon_strt	    ; invoke monitor

;
; action required for one cell
data_act
	 move.l   d1,da_ccell(a6)   ; set actual cell
	 move.l   d1,da_moncl(a6)   ; monitor cell
	 bsr.s	  dta_prcs	    ; process new/changed cell
	 bne.s	  data_exit

;
; now check if recalculation of grid is required
	 tst.b	  ws_litem+mli.call(a1) ; don't calc on all
	 bne.s	  data_next

	 tst.w	  da_autoc(a6)	    ; auto calculate on ?
	 beq.s	  data_next

	 xjsr	  grd_calc

;
; proceed to following cell
data_next
	 move.l   d1,d2 	    ; previous cell
	 xjsr	  cel_next	    ; get next cell in block
	 bmi.s	  data_exit	    ; ..end of block reached

;
; allow editing of the new cell..
	 tst.b	  ws_litem+mli.call(a1)  ; is all item selected
	 beq.s	  data_lp	    ; ..no, normal editing

;
; ..or if all, re-use last cell's formula
	 exg	  d1,d2
	 bsr	  dta_fbuf	    ; re-use last formular
	 exg	  d1,d2
	 bra.s	  data_act

;
; final end of editing
data_exit
	 clr.w	  da_dupdt(a6)		     ; allow display update

;
; if all was selected, remove monitor..
	 tst.b	  ws_litem+mli.call(a1)
	 beq.s	  data_bye

	 xjsr	  mon_stop

;
; ..and if auto calculation was requested, here is the final calc to do
	 tst.w	  da_autoc(a6)
	 xjsr	  grd_calc
;
; and bye now
data_bye
	cmpi.b	#k.esc,d7	; ESCaped?
	beq.s	data_bye1

	 tst.l	  da_cbx1(a6)	    ; test for one cell
	 bpl.s	  data_bye1
	 xjsr	  cel_nxtav	    ; go to next cell depending on status setting
	 xjsr	  cel_topl

data_bye1
	 bsr	  dta_cell	    ; update formular item
	 xjsr	  cel_info	    ; update cell info
	 xjmp	  do_window

*+++
* process a new/changed data / formular item
* formular has to be in buffer!
*
*		  Entry 		     Exit
*	 d1.l	  c|r of cell for item	     preserved
*---
dta_prcs subr	  a0/a3
	 clr.w	  da_saved(a6)
	 tst.w	  da_buff(a6)	    ; any formular in buffer?
	 beq.s	  prcs_nof	    ; ..no, clear cell

	 move.l   d1,da_ccell(a6)   ; set current cell number
	 bsr	  dta_bufd	    ; store new formular in dma
	 bmi.s	  prcs_exit

	 xjsr	  prc_data	    ; process data

prcs_exit
	 tst.l	  d0
	 subend

prcs_nof
	 bsr.s	  dta_rmvf	    ; clear cell and its formular
	 bra.s	  prcs_exit

*+++
* make an entry in the menu area
*
*		  Entry 		     Exit
*	 a0	  value block		     preserved
*	 a4	  wwork 		     preserved
*	 d1.l	  c|r of cell		     preserved
*
*---
r_entr	 reg	  d2/d1/a0/a3
dta_entr
	 movem.l  r_entr,-(sp)
	 bsr.s	  dta_used		     ; set new grid used values
	 bsr.s	  entr_rmv		     ; remove any cell contents
	 bsr	  dta_madr		     ; get address of cell
	 move.w   val_fwrd(a0),d1	     ; get format word
	 adda.l   #val_strg,a0
	 move.l   a0,wwm_pobj(a3)	     ; set pointer to object
	 moveq	  #1,d2 		     ; left justified
	 btst	  #fw..just,d1
	 bne.s	  entr_set

	 neg.b	  d2

entr_set
	 btst	  #fw..strg,d1
	 beq.s	  entr_ok

	 neg.b	  d2

entr_ok
	 move.b   d2,wwm_xjst(a3)	     ; justfiy object
	 moveq	  #0,d0
	 movem.l  (sp)+,r_entr
	 rts

entr_rmv
	 bsr	  dta_vadr		     ; value block
	 bmi.s	  entr_rx		     ; ..no value connected

	 move.l   val_form(a3),d0	     ; old formular = new formular
	 beq.s	  entr_kf		     ; ..value without formular

	 sub.l	  val_form(a0),d0
	 beq.s	  entr_kf

	 bsr.s	  dta_rmvf		     ; remove contents and formular

entr_rx
	 rts

entr_kf
	 bsr.s	  dta_rmvc
	 rts

*+++
* set new grid used values (is necessary)
*
*		  Entry 		     Exit
*	 d1.l	  c|r of new cell	     preserved
*---
r_used	 reg	  d2
dta_used
	 movem.l  r_used,-(sp)
	 move.l   da_usedx(a6),d2	     ; current used ranged
	 cmp.w	  d1,d2
	 bpl.s	  used_x

	 move.w   d1,d2

used_x
	 swap	  d1
	 swap	  d2
	 cmp.w	  d1,d2
	 bpl.s	  used_y

	 move.w   d1,d2

used_y
	 swap	  d1
	 swap	  d2
	 move.l   d2,da_usedx(a6)
	 movem.l  (sp)+,r_used
	 rts


*+++
* dta_rmvc: remove cell(s)
* dta_rmvf: remove cell(s) and their formulars
*
*		  Entry 		     Exit
*	 a4	  wwork 		     preserved
*	 d1.l	  c|r of cell		     preserved
*---
dta_rmvf
	 move.l   d2,-(sp)
	 moveq	  #0,d2

rmvf_do
	 xjsr	  is_proct
	 beq.s	  rmvf_x

	 bsr.s	  dta_rmvm

rmvf_x
	 move.l   (sp)+,d2
	 rts

dta_rmvc
	 move.l   d2,-(sp)
	 moveq	  #1,d2
	 bra.s	  rmvf_do


*+++
* remove cell(s), take care of strings
*
*		  Entry 		     Exit
*	 a4	  wwork 		     preserved
*	 d1.l	  c|r of cell		     preserved
*	 d2.b	  <>0, keep formular	     preserved
*
* error codes: none
*---
r_rmvm	 reg	  d1/d3
dta_rmvm
	 movem.l  r_rmvm,-(sp)

rmvm_lp
	 move.w   da_fword(a6),d3	     ; global format
	 bsr.s	  dta_rmvo		     ; remove one cell
	 bne.s	  rmvm_exit		     ; ..no cell connected

	 xjsr	  rdw_cchg

	 btst	  #fw..strg,d3		     ; was it a string?
	 beq.s	  rmvm_exit		     ; ..no, so don't check following

	 btst	  #fw..cont,d3		     ; is it longer than one cell?
	 beq.s	  rmvm_exit		     ; ..no

	 xjsr	  cel_nxtc		     ; next column cell
	 bne.s	  rmvm_exit

	 xjsr	  acc_tstf		     ; any formula in the next cell
	 bne.s	  rmvm_lp		     ; ..no, continue looping

rmvm_exit				     ; ..yes, so stop here
	 movem.l  (sp)+,r_rmvm
	 moveq	  #0,d0
	 rts

*+++
* remove one cell cell
*
*		  Entry 		     Exit
*	 a4	  wwork 		     preserved
*	 d1.l	  c|r of cell		     preserved
*	 d2.b	  <>0, keep formular	     preserved
*	 d3.w				     format word of formular
*
* error codes:	  err.itnf	    there was no item connected
*---
r_rmvo	 reg	  a0/a3
dta_rmvo
	 movem.l  r_rmvo,-(sp)

	 move.w   da_fword(a6),d3
	 moveq	  #err.itnf,d0
	 bsr.s	  dta_madr
	 move.l   wwm_pobj(a3),d0	     ; any object connected?
	 beq.s	  rmvo_exit		     ; ..no, work is done

	 clr.l	  wwm_pobj(a3)		     ; disconnect cell from object

	 sub.l	  #val_strg,d0		     ; base of value entry
	 move.l   d0,a3
	 tst.b	  d2			     ; keep formular?
	 bne.s	  rmvo_lb1		     ; ..yes, skip the following

	 move.l   val_form(a3),d0	     ; remove formular
	 beq.s	  rmvo_lb1		     ; no formular connected!

	 move.l   d0,a0
	 xjsr	  dma_free		     ; free formular area

rmvo_lb1
	 move.w   val_fwrd(a3),d3	     ; set format word

rmvo_lb2
	 move.l   a3,a0
	 xjsr	  dma_free		     ; free value block
	 moveq	  #0,d0

rmvo_exit
	 movem.l  (sp)+,r_rmvo
	 tst.l	  d0
	 rts

*+++
* get address of menu item
*
*		  Entry 		     Exit
*	 a3				     ptr to menu item
*	 a4	  wwork 		     preserved
*	 d1	  c|r of menu item	     preserved
*---
dta_madr subr	  d1
	 xjsr	  cel_numb		     ; convert c|r to number
	 mulu	  #wwm.olen,d1		     ; and now offset in list
	 move.l   da_miobl(a6),a3
	 adda.l   d1,a3 		     ; this is the object we want
	 subend

*+++
* get address of item value block
*
*		  Entry 		     Exit
*	 a3				     base of value block
*	 a4	  wwork 		     preserved
*	 d1	  c|r of menu item	     preserved
*
* error codes: err.itnf 	    no value block connected
*---
r_vadr	 reg	  d1
dta_vadr
	 movem.l  r_vadr,-(sp)
	 bsr	  dta_madr
	 moveq	  #err.itnf,d0
	 move.l   wwm_pobj(a3),d1
	 beq.s	  vadr_exit		     ; no object connected

	 sub.l	  #val_strg,d1
	 move.l   d1,a3
	 moveq	  #0,d0

vadr_exit
	 movem.l  (sp)+,r_vadr
	 tst.l	  d0
	 rts

*+++
* copy string from buffer area into data area
*
*		  Entry 		     Exit
*	 a3				     address of string in dma
*	 a4	  wwork 		     preserved
*
* error codes: err.imem 	    not enough memory left for entry
*	       err.orng 	    string is too long
*---
r_bufd	 reg	  d1/a0/a1
dta_bufd
	 movem.l  r_bufd,-(sp)
	 lea	  da_buff(a6),a1
	 move.w   (a1),d1		     ; get string length
	 beq.s	  bufd_nos		     ; zero, no space allocated

	 ext.l	  d1
	 addq.l   #3,d1 		     ; find total length and
	 bclr	  #0,d1 		     ; make it even
	 xjsr	  dma_aloc
	 bmi.s	  bufd_exit		     ; allocation went wrong!

	 xjsr	  ut_cpyst		     ; copy string to dma
	 move.l   a0,a3

bufd_exit
	 movem.l  (sp)+,r_bufd
	 tst.l	  d0
	 rts

bufd_nos
	 moveq	  #0,d0
	 suba.l   a3,a3
	 bra.s	  bufd_exit

*+++
* copy formular string of a cell into buffer area for editing
*
*		  Entry 		     Exit
*	 a4	  wwork 		     preserved
*	 d1.l	  c|r of cell		     preserved
*---
r_fbuf	 reg	  d1/a0/a1/a3
dta_fbuf
	 movem.l  r_fbuf,-(sp)
	 bsr	  dta_madr		     ; find address of menu item
	 move.l   wwm_pobj(a3),d1
	 beq.s	  fbuf_nos		     ; no item at all

	 subi.l   #val_strg,d1		     ; is there a formular?
	 move.l   d1,a1
	 move.l   val_form(a1),d1
	 beq.s	  fbuf_nos		     ; no formular

	 move.l   d1,a1 		     ; copy formular string into buffer
	 lea	  da_buff(a6),a0
	 xjsr	  ut_cpyst

fbuf_exit
	 movem.l  (sp)+,r_fbuf
	 rts

fbuf_nos
	 clr.w	  da_buff(a6)		     ; zero length string
	 bra.s	  fbuf_exit


*+++
* edit data string given in data area buffer
*
*		  Entry 		     Exit
*	 d2				     terminating character
*	 a4	  wwork 		     preserved
*	 a6	  data area		     preserved
*
*	 error codes : +1 = string too long to edit
*	 condition codes set
*---
r_edit	 reg	  a0/d1/d6-d7
dta_edit

	 movem.l  r_edit,-(sp)

	 move.l   ww_plitm(a4),a3   ; get down to loose item
	 moveq	  #mlo.data,d0
	 mulu	  #wwl.elen,d0
	 add.l	  d0,a3
	 move.w   wwl_xsiz(a3),d6   ; window size

	 moveq	  #0,d0
	 move.l   ww_chid(a4),a0
	 move.w   wwl_item(a3),d1   ; loose menu item number
	 move.w   wwl_xjst(a3),d7   ; store item justification
	 clr.w	  wwl_xjst(a3)	    ; because wman sets cursor!
	 move.l   a3,-(sp)
	 lea	  da_buff(a6),a3    ; string buffer area

	 ext.l	  d6		    ; window size into chars
	 divu	  #qs.xchar,d6	    ; size of loose item
	 sub.w	  (a3),d6	    ; minus string length
	 subq.w   #1,d6 	    ; minus cursor
	 bmi.s	  f_bigedit

	 sub.w	  #mact.doed,d4     ; big edit mode in separate window?
	 beq.s	  f_bigedit	    ; yes, please!

	tst.l	da_cbx1(a6)	; single entry or block entry?
	bmi.s	edit_single
	move.l	da_ccell(a6),d0
	sub.l	da_cbx0(a6),d0	; first cell? MAY contain something,
	beq.s	edit_single	; which we don't need to want overwritten
	xjsr	mu_swrds	; read string for block entry
	bra.s	f_cont
edit_single
	xjsr	mu_sweds	; edit string for single entry

f_cont
	 bmi	  kill
	 move.l   (sp)+,a3	    ; restore item address
	 move.w   d7,wwl_xjst(a3)   ; and restore justifiaction

	 move.l   d1,d2

edit_exit
	 movem.l  (sp)+,r_edit
	 tst.l	  d0
	 rts

f_bigedit
r_pld	reg	d7/a0-a4
	movem.l r_pld,-(sp)

	move.l	 ww_xorg(a4),d7 	 ; window origin

	move.l	#0,d4
	move.l	#wwa.eddo,d1
	lea	wst_eddo(a6),a1
	xlea	men_eddo,a3
	xjsr	ut_setup_l

	move.l	#$00200020,d1		; offset
	add.l	d7,d1			; plus main window origin
	jsr	wm.pulld(a2)
	bmi	kill

	jsr	wm.wdraw(a2)
	bmi	kill

	moveq	#1,d1
	moveq	#0,d2			; ink colour/no reset
	jsr	wm.swinf(a2)		; set window to inf. window

	moveq	#-1,d3			; timeout
	moveq	#iow.clra,d0		; ...and clear it
	trap	#do.io

	lea	da_buff(a6),a1		; string buffer area
	move.w	(a1)+,d2		; number of bytes
	moveq	#iob.smul,d0		; send a string of bytes
	trap	#do.io

	lea	da_buff(a6),a1		; string buffer area
	move.w	(a1)+,d1		; get len
	add.l	d1,a1			; end of line
	move.b	#' ',(a1)
	swap	d1			; in high word
	move.w	d2,d1			; number of chars
	move.w	#3*80,d2		; length of buffer
	moveq	#iob.elin,d0
	trap	#do.io

	moveq	#0,d2
	cmp.b	#$0a,-1(a1)		; test termination character
	beq.s	take_it

	move.b	#k.esc,d2		; default don't change it

take_it
	lea	da_buff(a6),a1		; string buffer area
	subq.w	#1,d1
	move.w	d1,(a1)

	move.w	d2,-(sp)		; save termination code
	xjsr	ut_unset
	xjsr	gu_fclos
	move.w	(sp)+,d1		; do it right register
	movem.l (sp)+,r_pld
	bra	f_cont

*+++
* set data item to cell formular string and redraw it
*
*		  Entry 		     Exit
*	 a4	  wwork 		     preserved
*	 d1.l	  c|r of cell		     preserved
*---
r_cell	 reg	  a0/a1/a3/d1
dta_cell
	 move.l   d1,da_ccell(a6)
	 tst.w	  da_dupdt(a6)		     ; display update allowed?
	 bne.s	  cell_exit

	 movem.l  r_cell,-(sp)
	 bsr	  dta_fbuf		     ; put formular into buffer
	 move.l   ww_chid(a4),a0
	 moveq	  #mli.data,d1
	 lea	  da_buff(a6),a1
	 jsr	  wm.stlob(a2)
	 bmi	  kill

	 xjsr	  rdw_lchg		     ; redraw item
	 movem.l  (sp)+,r_cell

cell_exit
	 rts

do_kill
	 xjmp	kill

*
* deselect current item and return from action routine
unselect
	 xjsr	    ut_rdwci
	 rts
	 end
