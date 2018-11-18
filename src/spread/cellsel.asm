* Spreadsheet					      16/12-91
*	 - cell/block selection routines
*
	 include  win1_keys_wman
	 include  win1_keys_wwork
	 include  win1_keys_wstatus
	 include  win1_keys_qdos_pt
	 include  win1_mac_oli
	 include  win1_spread_keys

	 xdef	  cel_topl		     ; mark one (top left) cell
	 xdef	  cel_botr		     ; mark block to bottom right
	 xdef	  cel_info		     ; set range information
	 xdef	  cel_numb		     ; get cell number of matrix
	 xdef	  cel_mstat		     ; get menu status area
	 xdef	  cel_clr		     ; unmark selected block
	 xdef	  cel_clrc		     ; unmark current cell
	 xdef	  cel_just
	 xdef	  cel_newb
	 xdef	  cel_mark		     ; redraw maked block
	 xdef	  cel_redw
	 xdef	  cel_highl,cel_nohigh	     ; highlight (cell in block)

	 xref.l   mli.goto

	 xref.s   mcx_grid,mcy_grid

	 section  prog

*
* select top left hand of cell block (d1=single cell)
cel_topl subr	  a1
	 bsr	  cel_mstat		     ; find menu status block
	 bsr	  cel_clr		     ; clear current block
	 move.l   d1,da_cbx0(a6)	     ; set current top left hand
	 move.l   d1,da_ccell(a6)	     ; set current cell number
	 move.l   #-1,da_cbx1(a6)
	 bsr	  cel_selcs
	 bsr	  cel_redw
	 bsr.s	  cel_newb		     ; new block setup
	 subend

*
* select bottom right hand of cell block (multiple cells)
cel_botr subr	  a1/d1-d3
	 tst.l	  d1
	 bpl.s	  btest_ok

	 move.l   da_cbx0(a6),d1

btest_ok
	 bsr	  cel_mstat		     ; get addr of menu status block
	 bsr	  cel_clr		     ; clear any marked cells
	 move.l   da_cbx0(a6),d2	     ; top left of block
	 cmp.l	  d1,d2 		     ; both the same cell..
	 beq.s	  botr_no		     ; ..just one selected

	 cmp.w	  d1,d2 		     ; check for oritentation
	 blt.s	  botr_yok		     ; top < bottom... ok

	 move.w   d1,d3
	 move.w   d2,d1
	 move.w   d3,d2 		     ; swap.w d1<->d2

botr_yok
	 swap	  d1			     ; now the x values
	 swap	  d2
	 cmp.w	  d1,d2 		     ; check for oritentation
	 blt.s	  botr_xok		     ; top < bottom... ok

	 move.w   d1,d3
	 move.w   d2,d1
	 move.w   d3,d2 		     ; swap.w d1<->d2

botr_xok
	 swap	  d1			     ; change back again
	 swap	  d2
	 move.l   d1,da_cbx1(a6)	     ; bottom right
	 move.l   d2,da_cbx0(a6)	     ; top left

botr_upd
	 bsr.s	  cel_newb		     ; update new block
	 subend

botr_no
	 move.l   #-1,da_cbx1(a6)	     ; just one selected cell
	 bra.s	  botr_upd


*
* set new block information
cel_newb subr	  d1
	 bsr.s	  cel_info		     ; update cell info
	 bsr	  cel_mark		     ; mark new block
	 move.l   da_cbx0(a6),d1
	 xjsr	  dta_cell		     ; update formular string
	 subend

*
* set cell info string
cel_info subr	  d1/a1/a0
	 lea	  da_cinfo(a6),a1	     ; put range string in here
	 move.l   da_cbx0(a6),d1	     ; top left hand reference
	 move.l   da_cbx1(a6),d2	     ; bottom right hand reference
	 xjsr	  con_rnge		     ; calculate range string
	 moveq	  #8,d1 		     ; info/goto item number
	 jsr	  wm.stlob(a2)		     ; set loose item
	 bne	  do_kill

	 move.b   #wsi.mkav,ws_litem+mli.goto(a6)
	 xjsr	  rdw_lchg		     ; redraw item
	 bne	  do_kill

	 subend

cel_info1 subr	   d1/a1/a0
	 lea	  da_cinfo(a6),a1	     ; put range string in here
	 xjsr	  con_cstr		     ; calculate range string
	 moveq	  #8,d1 		     ; info/goto item number
	 jsr	  wm.stlob(a2)		     ; set loose item
	 bne	  do_kill

	 move.b   #wsi.mkav,ws_litem+mli.goto(a6)
	 xjsr	  rdw_lchg		     ; redraw item
	 bne	  do_kill

	 subend


*
* selective redraw of grid menu items
cel_redw subr	  d3/a3/a5/d5/d6
	 tst.w	  da_dupdt(a6)
	 bne.s	  redw_clr

	 moveq	  #wm.drsel,d3		     ; draw selective
	 move.l   ww_pappl(a4),a3	     ; pointer to appl. wind. list
	 move.l   (a3),a3		     ; first appl. window
	 jsr	  wm.mdraw(a2)		     ; redraw menu
	 bne.s	  do_kill

redw_clr
	 bsr	  cel_mstat
	 moveq	  #0,d0
	 lea	  redw_chg(pc),a5
	 xjsr	  mul_blok
	 move.l   da_cbx0(a6),d5
	 move.l   da_cbx1(a6),d6
	 move.l   da_anbox(a6),da_cbx0(a6)
	 move.l   da_anbox+4(a6),da_cbx1(a6)
	 xjsr	  mul_blok
	 move.l   d5,da_cbx0(a6)
	 move.l   d6,da_cbx1(a6)
	 subend

redw_chg subr	  a1/d1/d2
	 bsr	  cel_numb		     ; get number of cell
	 bclr	  #wsi..chg,0(a1,d1.l)	     ; change bit
	 subend

cel_rdwc subr	  a0-a3/d0-d3
	 moveq	  #wm.drsel,d3		     ; draw selective
	 move.l   ww_pappl(a4),a3	     ; pointer to appl. wind. list
	 move.l   (a3),a3		     ; first appl. window
	 jsr	  wm.mdraw(a2)		     ; redraw menu
	 bne.s	  do_kill

	 subend

do_kill
	xjmp	kill


*+++
* mark current block
*
*		  Entry 			      Exit
*---
r_mark	 reg	  a5/a1/d1/d2
cel_mark
	 movem.l  r_mark,-(sp)
	 bsr	  cel_mstat
	 lea	  cel_selc(pc),a5	     ; action routine
	 xjsr	  mul_blok		     ; ..over block
	 bsr	  cel_redw		     ; draw block
	 movem.l  (sp)+,r_mark
	 rts


*+++
* select one single cell
*
*		  Entry 			      Exit
*	 A1	  pointer to menu status block	      preserved
*	 D1	  c|r of cell to select 	      preserved
*---
cel_selc subr	  a1/d1
	 bsr.s	  cel_numb		     ; get number of cell
	 move.b   (a1,d1.l),d0
	 ori.b	  #wsi.slct,d0
	 bchg	  #wsi..chg,d0
	 move.b   d0,(a1,d1.l)
*	  move.b   #wsi.mksl,(a1,d1.l)	      ; set status
	 moveq	  #0,d0
	 subend

cel_selcs subr	   a1/d1/d2
	 bsr.s	  cel_numb		     ; get number of cell
	 move.b   #wsi.mksl,(a1,d1.l)	     ; set status
	 moveq	  #0,d0
	 subend

cel_highl subr	   a1/d0-d2
	 bsr	  cel_info1
	 bsr	  cel_mstat		     ; find menu status block
	 bsr.s	  cel_numb		     ; get number of cell
	 move.b   #wsi.mkun,(a1,d1.l)	     ; set status
	 bsr	  cel_rdwc
	 bclr	  #wsi..chg,(a1,d1.l)
	 subend

cel_nohigh subr     a1/d0-d2
	 bsr.s	  cel_mstat		     ; find menu status block
	 bsr.s	  cel_numb		     ; get number of cell
	 move.b   #wsi.mksl,(a1,d1.l)	     ; set status
	 bsr	  cel_rdwc
	 bclr	  #wsi..chg,(a1,d1.l)
	 subend


*+++
* calculate number of cell in matrix list
*
*		  Entry 			      Exit
*	 D1.l	  c|r of cell			      number in list
*---
cel_numb subr	  d2
	 move.w   d1,d2 		     ; row number to select
	 swap	  d1			     ; column number
	 mulu	  da_ncols(a6),d2	     ; calculate the cell number.. !!!
	 add.w	  d1,d2 		     ; ..of given matrix number
	 move.l   d2,d1
	 subend

*+++
* clear current block in status area
*
*		  Entry 			      Exit
*---
r_clr	 reg	  a5/a1/d1/d2
cel_clr
	 movem.l  r_clr,-(sp)
	 bsr.s	  cel_mstat
	 lea	  cel_clrc(pc),a5	     ; action routine
	 xjsr	  mul_blok		     ; ..over block
	 move.l   da_cbx0(a6),da_anbox(a6)
	 move.l   da_cbx1(a6),da_anbox+4(a6)
*	  bsr	   cel_redw
	 movem.l  (sp)+,r_clr
	 rts

r_clrc	 reg	  a1/d1/d2
cel_clrc
	 movem.l  r_clrc,-(sp)
	 bsr	  cel_numb		     ; get number of cell
	 move.b   (a1,d1.l),d0
	 andi.b   #wsi..chg,d0
	 bchg	  #wsi..chg,d0
	 move.b   d0,(a1,d1.l)
*	  move.b   #wsi.mkav,0(a1,d1.l)       ; set status
	 moveq	  #0,d0
	 movem.l  (sp)+,r_clrc
	 rts


*+++
* find address of menu status block
*
*		  Entry 		     Exit
*	 A1				     ptr to menu status block
*	 A4	  wwork 		     preserved
*---
cel_mstat
	 move.l   ww_pappl(a4),a1	     ; get list of sub windows
	 move.l   (a1),a1		     ; ptr first sub window
	 move.l   wwa_mstt(a1),a1	     ; ptr to menu status block
	 rts

*+++
* justfiy cell
*
*		  Entry 		     Exit
*	 d1	  c|r of cell		     preserved
*	 d2.b	  new justfication	     preserved
*---
cel_just subr	  d1-d3/a3
	 xjsr	  is_proct
	 beq.s	  just_exit

	 xjsr	  dta_vadr		     ; get value block
	 bne.s	  just_exit		     ; ..no value

	 move.w   val_fwrd(a3),d3
	 tst.b	  d2
	 bpl.s	  just_left

	 bclr	  #fw..just,d3

just_set
	 btst	  #fw..strg,d3
	 beq.s	  just_ok

	 bchg	  #fw..just,d3

just_ok
	 move.w   d3,val_fwrd(a3)
	 xjsr	  dta_madr
	 move.b   d2,wwm_xjst(a3)
	 xjsr	  rdw_cchg

just_exit
	 moveq	  #0,d0
	 subend

just_left
	 bset	  #fw..just,d3
	 bra.s	  just_set

	 end
