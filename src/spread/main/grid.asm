* Spreadsheet					      05/12-91
*	 - grid application window control
*
	 include  win1_keys_wman
	 include  win1_keys_wwork
	 include  win1_keys_wstatus
	 include  win1_keys_qdos_pt
	 include  win1_keys_err
	 include  win1_keys_k
	 include  win1_mac_oli
	 include  win1_spread_keys

	 xdef	  med_grid
	 xdef	  mec_grid
	 xdef	  mem_grid
	 xdef	  mea_grid
	 xdef	  mea_cell
	 xdef	  rowcol

	 xref	  mod_delc,mod_delr,grd_wdth,mod_insc,mod_insr,grd_calc
	 xref	  grd_selc,grd_selr,mod_copy,mod_move,cls_eras,cls_unit
	 xref	  cls_msym,cls_just,mod_echo,grd_pwdt,fil_xloa,fil_xsas
	 xref	  cfg_cgap,fil_prtp,pld_find,fil_xsav,grd_quit

	 xref.s   mcx_grid,mcy_grid

	 section  prog

*
* application window hit routine
mea_grid
	 tst.b	  d2
	 beq.s	  agrd_wm	; skip the following, if no keystroke

	cmp.b	#k.lalt,d2	; leading ALT?
	bne.s	alt_not_pressed
	st	v_altbuff(a6)	; flag ALT was just pressed
	moveq	#0,d0
	rts

alt_not_pressed

	 bsr	  key_text	; automatic entry?
	 bne.s	  agrd_x

	 bsr.s	  key_shrt	; short-cut key
	 beq.s	  agrd_x

agrd_wm
	 jmp	  wm.mhit(a2)

agrd_x
	 rts

key_shrt subr	  a0-a5/d1-d4

	 moveq	  #-1,d0
	 tst.w	  da_amode(a6)
	 bne.s	  shrt_exit

	 lea	  key_tab,a5
shrt_lp
	 move.w   (a5)+,d0
	 bmi.s	  shrt_exit

	 cmp.b	  d0,d2
	 beq.s	  shrt_fnd

	 addq.w   #2,a5
	 bra.s	  shrt_lp

shrt_fnd
	 adda.w   (a5),a5	; get routine adress
	 jsr	  (a5)		; return to here AND after the next line
	 moveq	  #0,d0 	; dangerous bits!!!! do not remove!!!
shrt_exit
	 tst.w	  d0
	 subend

key_tab  dc.w	  'K'-'@'
	 dc.w	  mod_insc-*
	 dc.w	  'L'-'@'
	 dc.w	  fil_xloa-*
	 dc.w	  'N'-'@'
	 dc.w	  fil_xsas-*
	 dc.w	  'O'-'@'
	 dc.w	  mod_delr-*
	 dc.w	  'P'-'@'
	 dc.w	  fil_prtp-*
	 dc.w	  'R'-'@'
	 dc.w	  grd_calc-*
	 dc.w	  'S'-'@'
	 dc.w	  pld_find-*
	 dc.w	  'T'-'@'
	 dc.w	  cls_just-*
	 dc.w	  'U'-'@'
	 dc.w	  mod_move-*
	 dc.w	  'V'-'@'
	 dc.w	  fil_xsav-*
	 dc.w	  'W'-'@'
	 dc.w	  mod_insr-*
	 dc.w	  'X'-'@'
	 dc.w	  grd_quit-*
	 dc.w	  'Y'-'@'
	 dc.w	  mod_copy-*
	 dc.w	  'Z'-'@'
	 dc.w	  mod_echo-*
	 dc.w	  'ê'&255	 ; ^0
	 dc.w	  grd_pwdt-*

	 dc.w	  k.bspce&255
	 dc.w	  cls_eras-*
	 dc.w	  202			; Entf
	 dc.w	  cls_eras-*
	 dc.w	  k.left&255+$4000
	 dc.w	  key_left-*
	 dc.w	  k.right&255
	 dc.w	  key_right-*
	 dc.w	  k.up&255
	 dc.w	  key_up-*
	 dc.w	  k.down&255
	 dc.w	  key_down-*
	 dc.w	  k.do&255
	 dc.w	  key_wdown-*

	 dc.w	  k.slf&255
	 dc.w	  key_sleft-*
	 dc.w	  k.srt&255
	 dc.w	  key_sright-*
	 dc.w	  k.sup&255
	 dc.w	  key_sup-*
	 dc.w	  k.sdn&255
	 dc.w	  key_sdown-*

	 dc.w	  -1

*
* keyboard text/formulae routines (a1=status area!)
key_text subr	  a0/d2
	 moveq	  #0,d0
	 tst.w	  da_amode(a6)
	 bne.s	  ktx_exit

	 move.b   wsp_kstr(a1),d2
	 andi.b   #255,d2
	 xlea	  lst_keys,a0
	 move.b   (a0,d2.w),d0
	 beq.s	  ktx_exit

	 move.w   #1,da_buff(a6)
	 move.b   d2,da_buff+2(a6)
	 move.l   da_cbx0(a6),da_ccell(a6)

ktx_exit
	 tst.l	  d0
	 subend


*
* keyboard block control routines
key_left
	 bsr.s	  key_blk
	 sub.l	  #$00010000,d1
	 bra.s	  key_do

key_right
	 bsr.s	  key_blk
	 add.l	  #$00010000,d1
	 bra.s	  key_do

key_up
	 bsr.s	  key_blk
	 sub.w	  #1,d1
	 bra.s	  key_do

key_exit_nf
	addq.l	#2,(sp) 	; return on next instruction
	rts			; and carry on

key_wdown
	 cmp.b	  #10,wsp_kstr(a1)
	 bne.s	  key_exit_nf
	 bsr.s	  key_blk
	 xjsr	  cel_nxta
	 bra.s	  key_do

key_down
	 bsr.s	  key_blk
	 add.w	  #1,d1

key_do
	 xjsr	  is_ckey	    ; cursor keys allowed?
	 beq.s	  key_exit

	 xjsr	  in_grid
	 bne.s	  key_exit

	 xjsr	  cel_topl

key_exit
	 rts

key_sblk
	 move.l   da_cbx1(a6),d1
	 bpl.s	  blk_exit

key_blk
	 move.l   da_cbx0(a6),d1

blk_exit
	 rts

key_sleft
	 bsr.s	  key_sblk
	 sub.l	  #$00010000,d1
	 bra.s	  key_sdo

key_sright
	 bsr.s	  key_sblk
	 add.l	  #$00010000,d1
	 bra.s	  key_sdo

key_sup
	 bsr.s	  key_sblk
	 sub.w	  #1,d1
	 bra.s	  key_sdo

key_sdown
	 bsr.s	  key_sblk
	 add.w	  #1,d1

key_sdo
	 xjsr	  is_ckey	    ; cursor keys allowed?
	 beq.s	  key_sexit

	 xjsr	  in_grid
	 bne.s	  key_sexit

	 xjsr	  cel_botr

key_sexit
	 rts

*
* special draw routine
med_grid
	 bsr	  rowcol		     ; set number of row/col for display
	 xjsr	  idx_ownx		     ; draw my own index list for x
	 xjsr	  idx_owny		     ; and the one for y
	 jsr	  wm.index(a2)		     ; arrows and bars
	 jsr	  wm.mdraw(a2)		     ; the menu itself
	 rts

*
* control routine
mec_grid
	 bsr.s	  grd_chck
	 bmi.s	  psexit

	 move.b   d4,d5 		     ; preserve event
	 jsr	  wm.pansc(a2)		     ; do a standard pan or scroll
	 cmp.b	  #pt..pan,d5		     ; was it a pan?
	 beq.s	  psidx 		     ;	  no,.. it was scroll then

	 xjsr	  idx_owny		     ; .. redraw my row index
	 bra.s	  psexit

psidx
	 xjsr	  idx_ownx		     ; it was panned, redraw column idx

psexit
	 moveq	  #0,d0
	 rts

*
* check if splitted section would be large enough to display largest column
r_chck	 reg	  d1/d2
grd_chck
	movem.l r_chck,-(sp)
	cmpi.w	#$7e00,d2		; vertical split?
	bne.s	chck_ret_ok		; no, standard handling

	move.l	d3,d1			; x-position | section size
	swap	d1
	tst.w	d1			; x-position
	bmi.s	chck_ret_ok		; can this happen???

	moveq	#err.orng,d0		; assume failure
	bsr.s	chck_lcm		; find largest column incl. border
	cmp.w	d1,d2			; will split fit?
	bgt.s	chck_ret		; no!

	swap	d1			; total length must be at least ...
	add.w	d2,d2			; ... twice the maximum column size
	cmp.w	d1,d2			; still possible?
	bgt.s	chck_ret		; bad news!

chck_ret_ok
	moveq	#0,d0			; all is fine
chck_ret
	movem.l (sp)+,r_chck
	tst.l	d0
	rts


r_clm	reg	a3/d0/d1		; find largest column space
chck_lcm
	movem.l r_clm,-(sp)
	moveq	#0,d2			; reset max. column size
	move.w	wwa_ncol(a3),d0 	; number of columns to check
	move.l	wwa_xspc(a3),a3 	; spacing list
	bra.s	lcm_end

lcm_lp
	move.w	wwm_spce(a3),d1 	; get entry from spacing list
	cmp.w	d1,d2			; larger??
	bge.s	lcm_next		; no, check next
	move.w	d1,d2			; .. otherwise make this largest
lcm_next
	addq.w	#wwm.slen,a3		; next entry in spacing list
lcm_end
	dbra	d0,lcm_lp		; do all
	add.w	#(6+2+2)*2,d2		; don't forget the pan arrows + border
	movem.l (sp)+,r_clm
	rts

*
* setup routine
mem_grid subr	  a0/a1
	 xjsr	  ut_wm_smenu
	 beq.s	  grid_ok1

	 xjmp	  kill

grid_ok1
	 move.l   a4,a1 		     ; application window end
	 suba.l   #wwa.blen+2*wwa.clen+wwa.mlen,a1

	 move.l   da_mstat(a6),wwa_mstt(a1)  ; the new status area
	 move.w   da_ncols(a6),wwa_ncol(a1)  ; actual number of columns
	 move.w   da_nrows(a6),wwa_nrow(a1)  ; actual number of rows
	 move.l   da_mspcl(a6),wwa_xspc(a1)  ; column spacing
	 move.l   #$fff6fff5,wwa_yspc(a1)    ; row spacing constant
	 bsr.s	  gap_chg
	 move.l   da_mrowl(a6),wwa_rowl(a1)  ; the row list, at last
	 bsr	  nosect
	 move.w   #0,mcx_grid+wss_sstt+2(a6) ; start with first column
	 move.w   #0,mcy_grid+wss_sstt+2(a6)
	 moveq	  #0,d0
	 subend

gap_chg
	 move.b   cfg_cgap,d0
	 bne.s	  gap_exit

	 move.l   #$fff6fff6,wwa_yspc(a1)    ; row spacing constant
	 clr.w	  wwa_iatt+wwa_curw(a1)      ; no current item border

gap_exit
	 rts

*
* cell action routine
mea_cell
	tst.w	da_amode(a6)		; right mode?
	bmi	cell_mi 		; .. negative is macro expansion

	beq.s	cell_eq

	xjmp	act_other		; .. positive is another mode

cell_eq
	cmp.w	#pt..do,d4		; was it a DO ?
	beq.s	mark_context		; pop up context menu

	xjsr	ut_key_acs		; check for ALT CTRL SHIFT
	btst	#0,d0			; SHIFT pressed?
	bne.s	mark_block		; yes, mark end of block

	bsr	cel_topl		; mark cell top left only
	bra.s	exit_c

unmark
	tst.w	da_cbx1(a6)		; do we have a block marked?
	blt.s	unmark_nobl		; no, so unmark cell
	move.l	d1,d0			; check if current cell inside block
	swap	d0
	sub.w	da_cbx0(a6),d0
	blt.s	unmark_nobl
	move.l	d1,d0
	swap	d0
	sub.w	da_cbx1(a6),d0
	bgt.s	unmark_nobl
	move.l	d1,d0
	sub.w	da_cby0(a6),d0
	blt.s	unmark_nobl
	move.l	d1,d0
	sub.w	da_cby1(a6),d0
	bgt.s	unmark_nobl
	bra.s	exit_c			; yes, so don't clear cell!

unmark_nobl
	xjsr	cel_mstat		; get status area

	xjsr	cel_numb		; get number of cell
	move.b	(a1,d1.l),d0
	andi.b	#wsi..chg,d0
	bchg	#wsi..chg,d0
	move.b	d0,(a1,d1.l)		; clear to redraw

	xjsr	cel_redw		; and redraw item
	bclr	#wsi..chg,(a1,d1.l)	; get rid of change bit

	xjsr	cel_mark		; redraw current block too

	bra.s	exit_c

mark_context
	xjsr	do_context		; call context menu
	cmp.w	#1,d0			; block end selected? (item 1)
	beq.s	mark_block
	cmp.w	#-1,d0
	beq.s	unmark
	bra.s	exit_c

mark_block
	bsr	cel_botr		; mark all to bottom right

exit_c
	moveq	#0,d0
	moveq	#0,d4			   ; no event set
	rts

cell_mi
	 xjmp	 act_macro

*
* set no sections
nosect
	 move.w   #1,mcx_grid+wss_nsec(a6)   ; setup section defintions
	 move.w   #0,mcx_grid+wss_spos+2(a6) ; set x-start pixel position
	 move.w   #1,mcy_grid+wss_nsec(a6)
	 move.w   #0,mcy_grid+wss_spos+2(a6) ;set y-start pixel position
	 rts

*
* Calculate current number of columns/rows to display
rowcol	 subr	  a1/d1/d2
	 bsr	  nosect
	 moveq	  #0,d0 		     ; the columns first
	 move.w   wwa_xsiz(a3),d0	     ; window size
	 sub.w	  wwa_xoff(a3),d0	     ; less the offset we have
	 sub.w	  mcx_grid+wss_spos+2(a6),d0 ; less the section offset
	 subi.w   #2*2+ww.pnarr,d0	     ; less the pan arrow on the right

	 move.l   wwa_xspc(a3),a1	     ; x spacing list
	 move.w   wwa_ncol(a3),d2	     ; total number of columns
	 move.w   mcx_grid+wss_sstt+2(a6),d1 ; section start column
	 sub.w	  d1,d2 		     ; remaining number of columns
	 mulu	  #wwm.slen,d1		     ; ..is where we start counting
	 adda.l   d1,a1 		     ; ..in the spacing list
	 moveq	  #0,d1 		     ; d1 is counter

try_colmn
	 tst.w	  d2			     ; any columns remaining?
	 beq.s	  full			     ; no..

	 sub.w	  wwm_spce(a1),d0	     ; any space left..
	 bmi.s	  full			     ; ..in the window?

	 addq.w   #1,d1 		     ; yes, add this column
	 subq.w   #1,d2 		     ; remaining number decreases
	 adda.l   #wwm.slen,a1		     ; ..and try the next one
	 bra.s	  try_colmn

full
	 move.w   d1,mcx_grid+wss_ssiz+2(a6) ; we can display all these

	 moveq	  #0,d0 		     ; and now the rows
	 move.w   wwa_ysiz(a3),d0	     ; window height
	 sub.w	  wwa_yoff(a3),d0	     ; less the offset
	 sub.w	  mcy_grid+wss_spos+2(a6),d0 ; less the section offset
	 subi.w   #2*1+ww.scarr,d0	     ; less the bottom scroll arrows

	 move.w   wwa_nrow(a3),d2	     ; total number of rows
	 sub.w	  mcy_grid+wss_sstt+2(a6),d2 ; remaining number of rows
	 move.l   wwa_yspc(a3),d1	     ; this should be constant spacing
	 neg.w	  d1			     ; get the positive spacing value
	 divu	  d1,d0 		     ; now divide size by spacing
	 cmp.w	  d0,d2 		     ; do you want more than there are
	 bgt.s	  row_ok

	 move.w   d2,d0 		     ; only the ones that are left

row_ok
	 move.w   d0,mcy_grid+wss_ssiz+2(a6) ; and you get the number of rows
	 subend 			     ; easy, isn't it?

	 end
