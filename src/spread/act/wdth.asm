* Spreadsheet					      07/02-92
*	 - width menu pulldown routine
*

	 section  prog

	 include  win1_keys_wwork
	 include  win1_keys_wstatus
	 include  win1_keys_wman
	 include  win1_keys_qdos_pt
	 include  win1_keys_err
	 include  win1_keys_k
	 include  win1_mac_oli
	 include  win1_spread_keys

	 xdef	  wdt_puld,mea_wdfr,mea_wdto,mea_wdnw,mea_wdes,mea_wdok

	 xref.l   mv_wdfr,mv_wdto,mv_wdnw,mv_wdrg,wwa.wdth,wst_wdth
	 xref.s   mli.wdfr,mli.wdto,mli.wdnw,mli.wdes,mli.wdok

*
* draw and access width pulldown window
r_puld	 reg	  a0-a5/d0-d4
wdt_puld
	 movem.l  r_puld,-(sp)
	 move.l   ww_wstat(a4),a1
	 move.l   wsp_xpos(a1),d4
	 add.l	  ww_xorg(a4),d4
	 move.l   #wwa.wdth,d1
	 moveq	  #0,d2
	 lea	  wst_wdth(a6),a1
	 xlea	  men_wdth,a3
	 suba.l   a4,a4
	 lea	  puld_chg(pc),a4	     ; changes in wwork
	 suba.l   a5,a5 		     ; changes after draw
	 xjsr	  ut_pullf
	 movem.l  (sp)+,r_puld
	 moveq	  #0,d0
	 rts

*
* change wwork
puld_chg
	 movem.l  d3/a1/d1/d0,-(sp)
;;;	    move.b   colm(a6),d0
;;;	    andi.l   #$F,d0
;;;	    xjsr     ut_ccwwd			; change main colourway

	 move.w   da_cbx0(a6),d0	     ; set column information
	 bpl.s	  set_1

	 moveq	  #0,d0

set_1
	 move.w   d0,mv_wdrg(a6)	     ; according to block marked
	 move.w   da_cbx1(a6),d0
	 bpl.s	  set_2

	 move.w   mv_wdrg(a6),d0

set_2
	 move.w   d0,mv_wdrg+2(a6)
	 move.l   da_cbx0(a6),d1
	 xjsr	  cel_wdth
	 move.w   d3,mv_wdrg+4(a6)

	 bsr.s	  set_col1
	 bsr.s	  set_col2
	 bsr.s	  set_wdth

	 movem.l  (sp)+,a1/d1/d0/d3
	 rts

r_cols	 reg	  a0/a1/d0/d1
set_col1
	 movem.l  r_cols,-(sp)
	 move.w   mv_wdrg(a6),d0	     ; set from column in alpha
	 addq.w   #1,d0
	 lea	  mv_wdfr(a6),a0
	 xjsr	  con_wasc
	 move.l   a0,a1
	 moveq	  #mli.wdfr,d1
	 jsr	  wm.stlob(a2)
	 bne	  do_kill

col_exit
	 movem.l  (sp)+,r_cols
	 rts

set_col2
	 movem.l  r_cols,-(sp)		     ; set to column in alpha
	 move.w   mv_wdrg+2(a6),d0
	 addq.w   #1,d0
	 lea	  mv_wdto(a6),a0
	 xjsr	  con_wasc
	 move.l   a0,a1
	 moveq	  #mli.wdto,d1
	 jsr	  wm.stlob(a2)
	 bne.s	  do_kill

	 bra.s	  col_exit

r_wdth	 reg	  a0/a1/d0/d1
set_wdth
	 movem.l  r_wdth,-(sp)
	 move.w   mv_wdrg+4(a6),d0
	 lea	  mv_wdnw(a6),a0
	 xjsr	  con_wdec
	 move.l   a0,a1
	 moveq	  #mli.wdnw,d1
	 jsr	  wm.stlob(a2)
	 bne.s	  do_kill

	 movem.l  (sp)+,r_wdth
	 rts
*
* OK/ESCape from units menu
mea_wdok
	 bsr.s	  unselect
	 bset	  #pt..do,wsp_weve(a1)
	 moveq	  #pt..do,d4
	 moveq	  #0,d0
	 rts
mea_wdes
	 bsr.s	  unselect
	 bset	  #pt..can,wsp_weve(a1)
	 moveq	  #pt..can,d4
	 moveq	  #0,d0
	 rts

mea_wdfr
mea_wdto
	 bsr.s	  unselect
r_loos	 reg	  a0-a4/d1/d2/d4
loos_ret
	 moveq	  #0,d0
	 moveq	  #0,d4
	 rts

mea_wdnw
	 movem.l  r_loos,-(sp)
	 move.w   wwl_item(a3),d1
	 lea	  mv_wdnw(a6),a3
	 move.l   #$003c0001,d2 	     ; from 1 to 60
wdnw_try
	 xjsr	   edt_unum
	 bmi.s	  wdnw_try

	 move.w   d3,mv_wdrg+4(a6)
	 bsr	  set_wdth
	 movem.l  (sp)+,r_loos
	 bsr.s	  unselect
	 bra.s	  loos_ret

unselect
	 xjmp	   ut_rdwci

do_kill
	xjmp	kill

	 end
