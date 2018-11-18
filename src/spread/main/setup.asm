* Spreadsheet					29/11-91
*	- main window setup routine

	section prog

	include win1_keys_wman
	include win1_keys_wstatus
	include win1_keys_wwork
	include win1_keys_wdef_long
	include win1_mac_oli
	include win1_spread_keys


	xdef	set_fset		; do first window setup
	xdef	set_nset		; do another (changed) setup
	xdef	set_size		; check window size
	xdef	set_wdrw		; position window and redraw
	xdef	set_fnam		; filename information
	xdef	set_ckey,set_nkey,is_ckey
	xdef	set_wwrk
	xdef	row_siz

	xref	cfg_helpf,cfg_size

	xref.s	wst_main,wwa.main,mli.csim,mli.csmc,mli.chlp

row_siz
	move.w	da_nrows(a6),d0 	; nr. of rows
	mulu	#qs.xchar+5,d0		; height of row
	add.w	#74,d0
	move.w	d0,d1
	bsr	set_ssiz			; make it fit on screen
	rts


*
* setup window working defintion of main window for the first time
set_fset
	move.l	da_chan(a6),a0		; channel id
	lea	wst_main(a6),a1 	; pointer to status area
	xlea	men_main,a3		; pointer to menu defintion
	move.l	cfg_size,d1		; default window size
	bsr	set_ssiz		; make it fit on screen
	bsr.s	row_siz
	move.l	d1,d2			; this is first setup size

	move.l	#wwa.main,d1		; memory size for this layout
	xjsr	ut_setups_l		; setup working defintion
	bne.s	do_kill

	move.l	d1,da_winsz(a6) 	; store current window size
	move.l	a4,da_wwork(a6) 	; store ptr to working definition
	bsr.s	set_wwrk		; change wwork

	moveq	#-1,d1			; position somewhere

set_wdrw
	xjsr	xwm_prdw
	bsr	set_updt		; update window information
	rts

*
* setup (changed) window
set_nset
	move.l	ww_wstat(a4),a1
	move.l	da_winsz(a6),d1 	; get current window size
	xjsr	qwm_rset		; re-setup of window
	bsr.s	set_wwrk		; change working definition
	bra.s	set_wdrw

do_kill
	xjmp	kill

*
* change main window working definition
set_wwrk	subr	d1
	bsr.s	set_tool			; set/unset toolbar
	bsr	set_cway			; change colourway
	bsr	set_help			; change help file item
	xjsr	idx_work			; change for indices
	bsr	set_fnam			; change filename
	bsr.s	set_ckey			; disable curor key movement
	subend

set_ckey	subr   a3
	bsr.s	adr_grid			; get grid adress
	bset	#0,wwa_watt+wwa_kflg(a3)	; disable mouse movement with
	subend					; cursor keys

set_nkey	subr	a3
	bsr.s	adr_grid
	bclr	#0,wwa_watt+wwa_kflg(a3)	; disable mouse movement with
	subend

is_ckey subr	a3
	bsr.s	adr_grid
	btst	#0,wwa_watt+wwa_kflg(a3)	; disable mouse movement with
	subend

adr_grid
	move.l	ww_pappl(a4),a3
	move.l	(a3),a3
	rts

set_tool	subr   a0-a3/d1-d3
	move.l	#$00160016,d1	; assume normal icon size
	tst.w	da_toolb(a6)	; toolbar enabled?
	bne.s	show_icons	; yes

	clr.l	d1		; icons have no size

show_icons
	lea	icon_table,a0	; all items needing treatment
	lea	v_toolitm(a6),a2 ; item's save area

show_icloop
	move.w	(a0)+,d2	; fetch item number
	bmi.s	show_icend	; end of table

	move.l	ww_plitm(a4),a1 ; pointer to loose menu item list
	mulu	#wwl.elen,d2	; get right item
	add.l	d2,a1		; ... which starts here
	move.l	d1,wwl_xsiz(a1) ; now enter desired size
	tst.w	da_toolb(a6)	; toolbar enabled?
	beq.s	show_icempt

	move.l	(a2)+,d3	; fetch item from save area
	beq.s	show_icloop

	move.l	d3,wwl_pobj(a1)
	bra.s	show_icloop

show_icempt
	move.l	wwl_pobj(a1),d3 ; item defined?
	bne.s	show_icsave	; yes, save it

	addq.l	#4,a2		; skip this entry
	bra.s	show_icloop

show_icsave
	move.l	d3,(a2)+	; save item
	clr.l	wwl_pobj(a1)	; clear real item
	bra.s	show_icloop

show_icend
	move.l	ww_pinfo(a4),a3 		; info window list
	adda.w	#wwi.elen*5,a3			; window #5
	move.w	#$34,wwi_yorg(a3)
	adda.w	#wwi.elen,a3			; window #6
	move.w	#$41,wwi_yorg(a3)
	adda.w	#wwi.elen,a3			; window #7
	move.w	#$12,wwi_ysiz(a3)
	move.w	#$1b,wwi_yorg(a3)
	adda.w	#wwi.elen,a3			; window #8
	move.w	#$12,wwi_ysiz(a3)
	move.w	#$1b,wwi_yorg(a3)
	adda.w	#wwi.elen,a3			; window #9
	move.w	#$12,wwi_ysiz(a3)
	move.w	#$1b,wwi_yorg(a3)

	move.l	ww_plitm(a4),a3 		; loose menu item list
	adda.w	#wwl.elen*9,a3			; item 9
	move.w	#$35,wwl_yorg(a3)
	adda.w	#wwl.elen,a3			; item 10
	move.w	#$35,wwl_yorg(a3)
	adda.w	#wwl.elen,a3			; item 11
	move.w	#$35,wwl_yorg(a3)
	adda.w	#wwl.elen*2,a3			; item 13
	move.w	#$35,wwl_yorg(a3)
	adda.w	#wwl.elen,a3			; item 14
	move.w	#$35,wwl_yorg(a3)

	move.l	ww_pappl(a4),a3 		; application sub window list
	move.w	#$42,wwa_yorg+8(a3)

	tst.w	da_toolb(a6)			; toolbar enabled
	bne	tool_x				; yes

	move.l	ww_pappl(a4),a3 		; application sub window list
	move.w	#$28,wwa_yorg+8(a3)
	add.w	#26,wwa_ysiz+8(a3)

	move.l	ww_pinfo(a4),a3 		; info window list
	adda.w	#wwi.elen*5,a3			; window #5
	move.w	#$1b,wwi_yorg(a3)
	adda.w	#wwi.elen,a3			; window #6
	move.w	#$28,wwi_yorg(a3)
	add.w	#25,wwi_ysiz(a3)
	adda.w	#wwi.elen,a3			; window #7
	move.w	#$a,wwi_ysiz(a3)
	move.w	#$1c,wwi_yorg(a3)
	adda.w	#wwi.elen,a3			; window #8
	move.w	#$a,wwi_ysiz(a3)
	move.w	#$1c,wwi_yorg(a3)
	adda.w	#wwi.elen,a3			; window #9
	move.w	#$a,wwi_ysiz(a3)
	move.w	#$1c,wwi_yorg(a3)

	move.l	ww_plitm(a4),a3 		; loose menu item list
	adda.w	#wwl.elen*9,a3			; item 9
	move.w	#$1c,wwl_yorg(a3)
	adda.w	#wwl.elen,a3			; item 10
	move.w	#$1c,wwl_yorg(a3)
	adda.w	#wwl.elen,a3			; item 11
	move.w	#$1c,wwl_yorg(a3)
	adda.w	#wwl.elen*2,a3			; item 13
	move.w	#$1c,wwl_yorg(a3)
	adda.w	#wwl.elen,a3			; item 14
	move.w	#$1c,wwl_yorg(a3)
	
tool_draw
	bsr	adr_grid

tool_x	subend

icon_table
	dc.w	16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33
	dc.w	-1
*
* set current filename info
r_fnam	reg	d1/a1
set_fnam
	movem.l r_fnam,-(sp)
	lea	da_fname(a6),a1 		; set filename info
	tst.w	(a1)
	bne.s	fnam_ok

	xlea	met_nona,a1			; no name info

fnam_ok
	move.l	#$00020000,d1			; window/obj
	jsr	wm.stiob(a2)
	tst.l	d0
	bne	do_kill

	bsr.s	set_jobn

fnam_exit
	movem.l (sp)+,r_fnam
	rts

set_jobn	subr	d1
	lea	da_anbuf(a6),a0
	xlea	met_flag,a1
	xjsr	ut_cpyst
	xjsr	st_appsp
	move.l	a0,a1
	lea	da_fname(a6),a0
	tst.w	(a0)
	beq.s	fjb_nof

	xjsr	ut_namfi

fjb_set
	lea	da_anbuf(a6),a0
	moveq	#-1,d1
	xjsr	ut_jobn
	subend

fjb_nof
	lea	da_anbuf(a6),a0
	xlea	met_nona,a1
	xjsr	st_appst
	bra.s	fjb_set

*
* update	window informations
r_updt	reg	d1
set_updt
	movem.l r_updt,-(sp)
	xjsr	cel_info			; update range information
	move.l	da_cbx0(a6),d1
	xjsr	dta_cell
	movem.l (sp)+,r_updt
	rts

*
* change colourways according to config block
set_cway
	rts   ;**********************!!!!!!!!!!!!!!!!!!!!!!

;;;	   movem.l d1,-(sp)
;;;	   move.b  colm(a6),d0			  ; set main window colourway
;;;	   xjsr    ut_ccwwd
;;;	   move.b  cols(a6),d0			   ; set grid colourway
;;;	   moveq   #0,d1			   ; for appl. subwindow 0
;;;	   bsr.s   cway_menu
;;;	   move.b  colm(a6),d0
;;;	   xjsr    ut_ccwix			   ; x index
;;;	   xjsr    ut_ccwiy			   ; y index
;;;	   cmpi.b  #2,da_mode(a6)
;;;	   bne.s   cway_exit

;;;	   moveq   #4,d0
;;;	   moveq   #0,d1
;;;	   xjsr    ut_ccwix			   ; x index
;;;	   xjsr    ut_ccwiy			   ; y index
;;;	   moveq   #4,d0			   ; monochrome
;;;	   bsr.s   cway_item

;;;cway_exit
;;;	   movem.l (sp)+,d1
;;;	   rts

;;;cway_menu
;;;	   xjsr    ut_ccwaw

;;;cway_item
;;;	   xjsr    ut_ccwai			   ; items
;;;	   xjsr    ut_ccwax			   ; pan bars
;;;	   xjsr    ut_ccway			   ; scroll bars
;;;	   rts

*
* set help item unavailable, if help filename was not given
set_help
	move.w	cfg_helpf,d0
	bne.s	help_exit

	move.b	#wsi.unav,ws_litem+mli.chlp(a1)

help_exit
	rts


*+++
* pre-setup window size check
*
*		Entry			Exit
*	d1.l	x|y size		new x|y size
*	a3	wdef			preserved
*---
r_size	reg	d0/d2
set_ssiz
	movem.l r_size,-(sp)
	move.b	wd_wattr+wda_shdd(a3),d0	; get shadow size for x
	bra.s	size_do

*+++
* check window size
*
*		Entry			Exit
*	d1.l	x|y size		new x|y size
*	a4	wwork			preserved
*---
set_size
	movem.l r_size,-(sp)

	move.b	ww_wattr+wwa_shdd(a4),d0	; get shadow size for x
size_do
	ext.w	d0
	move.w	d0,d2
	mulu	#ww.shadx,d2		; shadow x multiplier
	swap	d2
	mulu	#ww.shady,d0		; shadow y multiplier
	move.w	d0,d2
	add.l	#$00040002,d2
	neg.l	d2			; maximum screen size
	add.l	da_xlim(a6),d2		; less the shadows

	tst.l	d1			; d1=0 ?
	bne.s	size_nor
	move.l	#$7fff7fff,d1		; yes, .. maximum size

size_nor
	cmp.w	d1,d2			; compare y-sizes
	bge.s	size_yok
	move.w	d2,d1			; maximum window ysize
size_yok
	swap	d1			; now the xsizes
	swap	d2
	cmp.w	d1,d2			; compare window/screen xs
	bge.s	size_xok
	move.w	d2,d1			; maximum window ysize
size_xok
	swap	d1
	andi.l	#$fffcffff,d1		; x has to be multiple of 4

	movem.l (sp)+,r_size
	rts

	end
