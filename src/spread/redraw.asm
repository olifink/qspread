* Spreadsheet					      24/02-92
*	 - window item redraw

	 section  prog

	 include  win1_keys_wman
	 include  win1_keys_wstatus
	 include  win1_keys_wwork
	 include  win1_keys_qdos_pt
	 include  win1_keys_qdos_io
	 include  win1_mac_oli
	 include  win1_spread_keys


	 xdef	  rdw_cchg	    ; redraw one gird cell cell
	 xdef	  rdw_lchg	    ; redraw one loose item
	 xdef	  rdw_mkav	    ; make loose item available
	 xdef	  rdw_selc	    ; selective redraw for loose items
	 xdef	  rdw_grid	    ; redraw complete grid
	 xdef	  rdw_grdr	    ; redraw grid, col/row dimensions


*+++
* redraw complete grid
*
*---
rdw_grid subr	  a0-a3/d1-d3
	 tst.w	  da_dupdt(a6)
	 bne.s	  grid_exit

	 move.l   da_wwork(a6),a4
	 move.l   da_wmvec(a6),a2
	 move.l   ww_chid(a4),a0
	 move.l   ww_pappl(a4),a3	     ; application window list
	 move.l   (a3),a3		     ; first appl. window
	 xjsr	  idx_ownx
	 xjsr	  idx_owny
	 moveq	  #wm.drall,d3
	 jsr	  wm.mdraw(a2)
	 tst.l	  d0

grid_exit
	 subend

*+++
* redraw complete grid
* and reset column/row dimensions
*---
rdw_grdr subr	  a1-a3/d1-d3
	 tst.w	  da_dupdt(a6)
	 bne.s	  grdr_exit

	 move.l   da_wwork(a6),a4
	 move.l   da_wmvec(a6),a2
	 move.l   ww_chid(a4),a0
	 move.l   ww_pappl(a4),a3	     ; application window list
	 move.l   (a3),a3		     ; first appl. window

	 moveq	  #0,d1 		; first appl. window
	 moveq	  #0,d2 		; only set area
	 jsr	  wm.swapp(a2)
	 moveq	  #iow.spap,d0
	 move.w   wwa_watt+wwa_papr(a3),d1 ; set paper colour
	jsr	wm.trap3(a2)
;;;	    move.l  d3,-(sp)
;;;	    moveq   #forever,d3
;;;	    trap    #do.io
;;;	    move.l  (sp)+,d3
	 moveq	  #iow.clra,d0
	jsr	wm.trap3(a2)
;;;	    move.l  d3,-(sp)
;;;	    moveq   #forever,d3
;;;	    trap    #do.io
;;;	    move.l  (sp)+,d3
	 moveq	  #wm.drall,d3
	 xjsr	  med_grid

grdr_exit
	 tst.l	  d0
	 subend

*+++
* selective redraw of loose items
*
* redraw all loose items with change bit set (WM.LDRAW)
*
*		  Entry 		     Exit
*	 A0	  channel ID		     preserved
*	 A4	  working defintion	     preserved
*
*	 error code: any IOSS errors
*	 condition code: set
*---
rdw_selc
	 movem.l  d3/a2,-(sp)
	 move.l   da_wmvec(a6),a2
	 moveq	  #wm.drsel,d3		     ; selective..
	 jsr	  wm.ldraw(a2)		     ; ..redraw of loose items
	 beq.s	  rdw_selc_ok

	 xjmp	  kill

rdw_selc_ok
	 movem.l  (sp)+,d3/a2
	 tst.l	  d0
	 rts

*+++
* change selective redraw of loose item
*
* set the change bit in for this loose item in status area, redraws
* it, and clears change bit again
*
*		  Entry 		     Exit
*	 A0	  channel ID		     preserved
*	 A4	  working defintion	     preserved
*	 D1.w	  loose item number	     preserved
*
*	 error code: any IOSS errors
*	 condition code: set
*---
r_lchg	 reg	  a1
rdw_lchg
	 movem.l  r_lchg,-(sp)
	 move.l   ww_wstat(a4),a1
	 bset	  #wsi..chg,ws_litem(a1,d1.w); set item change bit
	 bsr.s	  rdw_selc		     ; do a selective redraw
	 bclr	  #wsi..chg,ws_litem(a1,d1.w); clear change bit
	 movem.l  (sp)+,r_lchg
	 tst.l	  d0
	 rts

*+++
* make loose item available
*
*		  Entry 		     Exit
*	 A0	  channel ID		     preserved
*	 A4	  working defintion	     preserved
*	 D1.w	  loose item number	     preserved
*
*	 error code: any IOSS errors
*	 condition code: set
*---
r_mkav	 reg	  a1
rdw_mkav
	 movem.l  r_mkav,-(sp)
	 move.l   ww_wstat(a4),a1
	 move.b   #wsi.mkav,ws_litem(a1,d1.w); set item change bit
	 bsr.s	  rdw_selc		     ; do a selective redraw
	 bclr	  #wsi..chg,ws_litem(a1,d1.w); clear change bit
	 movem.l  (sp)+,r_mkav
	 tst.l	  d0
	 rts


*+++
* redraw one cell in gird
*
*		  Entry 	    Exit
*	 d1.l	  c|r of cell	    preserved
*	 a4	  wwork 	    preserved
*
* error codes: any IOSS errors
* condition codes set
*---
r_rdw	 reg	  a0-a3/d3/d1
rdw_cchg
	 tst.w	  da_dupdt(a6)	     ; update of display allowed
	 bne.s	  cchg_no

	 movem.l  r_rdw,-(sp)
	 move.l   da_wmvec(a6),a2
	 move.l   ww_chid(a4),a0
	 move.l   ww_pappl(a4),a3   ; application window list
	 move.l   (a3),a3	    ; first application window
	 move.l   wwa_mstt(a3),a1   ; status area
	 xjsr	  cel_numb	    ; get number of cell
	 bset	  #wsi..chg,0(a1,d1.l) ; change status for cell
	 moveq	  #wm.drsel,d3	    ; draw selective
	 jsr	  wm.mdraw(a2)
	 bclr	  #wsi..chg,0(a1,d1.l) ; reset change bit
	 movem.l  (sp)+,r_rdw
	 tst.l	  d0
	 rts

cchg_no
	 moveq	  #0,d0
	 rts


	 end
