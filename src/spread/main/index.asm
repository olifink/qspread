* Spreadsheet					      05/12-91
*	 - index control
*
	 include  win1_keys_wman
	 include  win1_keys_wwork
	 include  win1_keys_wstatus
	 include  win1_keys_qdos_io
	 include  win1_keys_qdos_pt
	 include win1_keys_colour
	 include win1_mac_oli
	 include  win1_spread_keys

	 xdef	  idx_ownx,idx_owny
	 xdef	  idx_work

	 xref.s   mcx_grid,mcy_grid

	 section  prog

*
* change working defintion for index items
r_work	 reg	  a3/d0/d1/d2
idx_work
	 movem.l  r_work,-(sp)
	 move.l   ww_pappl(a4),a3	     ; ptr to appl. list
	 move.l   (a3),a3		     ; first appl. window
	 move.w   da_ixspx(a6),d0	     ; maximum index space
	 mulu	  #6,d0 		     ; in pixels
	 addq.w   #2,d0 		     ; looks more nice
	 moveq	  #11,d1		     ; y size

	 move.w   d1,wwa_insp(a3)	     ; x index spacing
	 move.w   d1,wwa_insz(a3)	     ; x index size

	 move.w   d0,wwa_insp+wwa.clen(a3)   ; y index spacing
	 move.w   d0,wwa_insz+wwa.clen(a3)   ; y index size

	 move.w   wwa_watt+wwa_borw(a3),d2   ; add border width to distance
	 add.w	  d2,d1 		     ; single for y
	 lsl.w	  #1,d2 		     ; double for..
	 add.w	  d2,d0 		     ; ..you guess, yeah x

	 sub.w	  d0,wwa_xsiz(a3)	     ; make window smaller
	 sub.w	  d1,wwa_ysiz(a3)
	 add.w	  d0,wwa_xorg(a3)	     ; move origin right down
	 add.w	  d1,wwa_yorg(a3)
	 movem.l  (sp)+,r_work
	 rts

*
* Draw myown index list for rows
r_idy	 reg	  d0/d4
idx_owny
	 movem.l  r_idy,-(sp)
	 bsr	  idx_wind		     ; set window for index
	 move.w   mcy_grid+wss_nsec(a6),d0   ; number of y sections
	 moveq	  #0,d4 		     ; section offset in status area

owny_lp
	 bsr.s	  idx_ydrw
	 addi.w   #wss.ssln,d4		     ; next section entry
	 subq.w   #1,d0 		     ; for all sections
	 bne.s	  owny_lp

	 movem.l  (sp)+,r_idy
	 rts


r_ydrw	 reg	  a1/a5/d0/d1/d2/d3
idx_ydrw
	 movem.l  r_ydrw,-(sp)
	 move.l   da_mridx(a6),a5	     ; row index objects
	 move.w   mcy_grid+wss_sstt+2(a6,d4.w),d1 ; start row number
	 mulu	  #wwm.olen,d1		     ; index list entry length
	 adda.l   d1,a5 		     ; address of first object

	 move.w   mcy_grid+wss_ssiz+2(a6,d4.w),d2 ; number of rows displayed
	 move.l   wwa_yspc(a3),d3	     ; y spacing
	 neg.w	  d3			     ; get actual value

	 moveq	  #1,d1 		     ; first pixel position
	 add.w	  mcy_grid+wss_spos+2(a6,d4.w),d1 ; section offset y
	 add.w	  wwa_yoff(a3),d1	     ; add y offset
	 add.w	  wwa_insp(a3),d1	     ; add index space of other list
	 bsr.s	  idx_yclr		     ; clear y(row) index

	 addq.w   #1,d1 		     ; current item border

ydrw_prt
	 bsr	  pxpos 		     ; position cursor
	 move.l   wwm_pobj(a5),a1	     ; object string
	 xjsr	  ut_prstr		     ; print it
	 add.w	  d3,d1 		     ; next y position
	 adda.l   #wwm.olen,a5		     ; next object
	 subq.w   #1,d2 		     ; count down the rows
	 bne.s	  ydrw_prt

	 movem.l  (sp)+,r_ydrw
	 rts

*
* clear row index
r_yclr	 reg	  d1/a1
idx_yclr
	 movem.l  r_yclr,-(sp)
	 suba.l   #8,sp 		     ; we need space for 4 words
	 move.l   sp,a1

	 move.w   wwa_insp+wwa.clen(a3),(a1) ; index space becomes block width
	 moveq	  #0,d0 		     ; and now the rows
	 move.w   wwa_ysiz(a3),d0	     ; window height
	 sub.w	  wwa_yoff(a3),d0	     ; less the offset
	 sub.w	  mcy_grid+wss_spos+2(a6),d0 ; less the section offset
	 subi.w   #2*1+ww.scarr,d0	     ; less the bottom scroll arrows
	 move.w   d0,2(a1)		     ; becomes height
	 move.l   d1,4(a1)		     ; x|y as defined
	 move.w   wwa_iiat+wwa_back+wwa.clen(a3),d1 ; colour
	 moveq	  #iow.blok,d0		     ; fill block
	jsr	wm.trap3(a2)
;;;	    move.l  d3,-(sp)
;;;	    moveq   #forever,d3
;;;	    trap    #do.io
;;;	    move.l  (sp)+,d3
	 adda.l   #8,sp 		     ; reframe stack
	 movem.l  (sp)+,r_yclr
	 rts

*
* clear column index
idx_xclr
	 movem.l  r_yclr,-(sp)
	 suba.l   #8,sp 		     ; we need space for 4 words
	 move.l   sp,a1

	 moveq	  #0,d0 		     ; and now the columns
	 move.w   wwa_xsiz(a3),d0	     ; window width
	 sub.w	  wwa_xoff(a3),d0	     ; less the offset
	 sub.w	  mcx_grid+wss_spos+2(a6),d0 ; less the section offset
	 subi.w   #2*2+ww.pnarr,d0	     ; less the right pan arrows

	 move.w   d0,(a1)		     ; becomes block width
	 move.w   wwa_insp(a3),2(a1)	     ; height is the index space
	 move.l   d1,4(a1)		     ; x|y as defined
	 move.w   wwa_iiat+wwa_back(a3),d1   ; colour
	 moveq	  #iow.blok,d0		     ; fill block
	jsr	wm.trap3(a2)
;;;	    move.l  d3,-(sp)
;;;	    moveq   #forever,d3
;;;	    trap    #do.io
;;;	    move.l  (sp)+,d3
	 adda.l   #8,sp 		     ; reframe stack
	 movem.l  (sp)+,r_yclr
	 rts

*
* Draw myown index list for columns
r_idx	 reg	  d0/d5
idx_ownx
	 movem.l  r_idx,-(sp)
	 bsr	  idx_wind		     ; set window for index
	 move.w   mcx_grid+wss_nsec(a6),d0   ; number for x sections
	 moveq	  #0,d5 		     ; section offset in status area

ownx_lp
	 bsr.s	  idx_xdrw		     ; draw index for current section
	 addi.w   #wss.ssln,d5		     ; next section entry
	 subq.w   #1,d0 		     ; for all sections
	 bne.s	  ownx_lp

	 movem.l  (sp)+,r_idx
	 rts

r_xdrw	 reg	  a1/a4/a5/d0-d5
idx_xdrw
	 movem.l  r_xdrw,-(sp)
	 move.l   da_mcidx(a6),a5	     ; column index objects
	 move.w   mcx_grid+wss_sstt+2(a6,d5.w),d1 ; start column number
	 move.w   d1,d2
	 mulu	  #wwm.olen,d1		     ; index list entry length
	 adda.l   d1,a5 		     ; address of first object

	 move.l   wwa_xspc(a3),a4	     ; column spacing list
	 mulu	  #wwm.slen,d2		     ; get offset for first entry
	 adda.l   d2,a4 		     ; first spacing entry

	 moveq	  #0,d1 		     ; first pixel position
	 add.w	  mcx_grid+wss_spos+2(a6,d5.w),d1 ; section offset x
	 add.w	  wwa_xoff(a3),d1	     ; add x offset
	 add.w	  wwa_insp+wwa.clen(a3),d1   ; add index space of other list

	 swap	  d1			     ; x is in high word
	 bsr	  idx_xclr		     ; clear y(column) index
	 move.w   #1,d1 		     ; y = 1 looks better

	 move.w   mcx_grid+wss_ssiz+2(a6,d5.w),d4 ; number of columns displayed

xdrw_prt
	 move.l   d1,d3 		     ; preserve old position
	 move.w   wwm_spce(a4),d0	     ; spacing of current column
	 move.l   wwm_pobj(a5),a1	     ; index string
	 move.w   (a1),d2		     ; length of string
	 mulu	  #6,d2 		     ; ..in pixels
	 sub.w	  d2,d0 		     ; get difference
	 bmi.s	  xdrw_nfit		     ; it wouldn't fit into it

	 lsr.w	  #1,d0 		     ; centre it
	 swap	  d0			     ; put it in upper word (x)
	 clr.w	  d0			     ; clear lower word
	 add.l	  d0,d1 		     ; new position
	 bsr.s	  pxpos 		     ; position cursor
	 xjsr	  ut_prstr		     ; write index string

xdrw_nfit
	 move.l   d3,d1 		     ; get old position
	 swap	  d1
	 add.w	  wwm_spce(a4),d1	     ; next column starting x posn
	 swap	  d1
	 adda.l   #wwm.olen,a5		     ; next object
	 adda.l   #wwm.slen,a4		     ; next spacing entry
	 subq.w   #1,d4 		     ; all columns displayed
	 bne.s	  xdrw_prt

	 movem.l  (sp)+,r_xdrw
	 rts



*+++
* pixel position cursor
*
*		  Entry 		     Exit
*	 A0	  channel ID		     preserved
*	 D1.l	  x|y position		     preserved
*---
pxpos
	 movem.l  d1-d3/a1,-(sp)
	 move.w   d1,d2 		     ; y position
	 swap	  d1			     ; x position
	 moveq	  #iow.spix,d0		     ; set cursor to pixel position
	 moveq	  #forever,d3
	 trap	  #do.io
	 tst.l	  d0
	 movem.l  (sp)+,d1-d3/a1
	 rts

*+++
* set window for index item drawing
*
*		  Entry 		     Exit
*	 A0	  channel ID		     preserved
*---
r_wind	 reg	  d1-d3
idx_wind
	 movem.l  r_wind,-(sp)
	 move.w   wwa_iiat+wwa_back+wwa.clen(a3),d1
	 moveq	  #iow.sstr,d0
;;;	    moveq   #forever,d3
	 jsr	wm.trap3(a2)
;;;	    trap    #do.io
	 move.w   wwa_iiat+wwa_ink+wwa.clen(a3),d1
	 moveq	  #iow.sink,d0
;;;	    moveq   #forever,d3
	 jsr	wm.trap3(a2)
;;;	    trap    #do.io
	 moveq	  #0,d1
	 moveq	  #iow.sova,d0
;;;	    moveq   #forever,d3
	 jsr	wm.trap3(a2)
;;;	    trap    #do.io
	 moveq	  #6,d1 		     ; info window #6
	 moveq	  #-1,d2		     ; only area set
	 jsr	  wm.swinf(a2)		     ; set area to cover info window

	 movem.l  (sp)+,r_wind
	 rts









	 end
