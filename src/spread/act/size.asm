* Spreadsheet					      02/03-92
*	 - size menu pulldown routine
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

	 xdef	  siz_puld,mea_szes,mea_szok,mea_szco,mea_szro

	 xref	  cfg_rows		;,cfg_colmn

	 xref.l   mv_szco,mv_szro,mv_sznc,mv_sznr,wwa.size,wst_size

	 xref.s   mli.szco,mli.szro,mli.szes,mli.szok

*
* draw and access width pulldown window
r_puld	 reg	  a0-a5/d0-d4
siz_puld
	 movem.l  r_puld,-(sp)
	 move.l   #wwa.size,d1
	 moveq	  #0,d4
	 move.l   wsp_xpos(a1),d4
	 add.l	  ww_xorg(a4),d4
	 lea	  wst_size(a6),a1
	 xlea	  men_size,a3
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
	 bsr.s	  siz_info
	 movem.l  (sp)+,d3/a1/d1/d0
	 rts

r_info	 reg	  a0/a1/d1
siz_info
	 movem.l  r_info,-(sp)
	 lea	  mv_szco(a6),a1
	 moveq	  #mli.szco,d1
	 jsr	  wm.stlob(a2)
	 lea	  mv_szro(a6),a1
	 moveq	  #mli.szro,d1
	 jsr	  wm.stlob(a2)
	 movem.l  (sp)+,r_info
	 rts
*
* OK/ESCape from menu
mea_szok
	 bsr.s	  unselect
	 bset	  #pt..do,wsp_weve(a1)
	 moveq	  #pt..do,d4
	 moveq	  #0,d0
	 rts
mea_szes
	 bsr.s	  unselect
	 bset	  #pt..can,wsp_weve(a1)
	 moveq	  #pt..can,d4
	 moveq	  #0,d0
	 rts

r_loos	 reg	  a0-a4/d1/d2/d4
mea_szco
	 movem.l  r_loos,-(sp)
	 bsr.s	  unselect
szco_cont
	 moveq	  #mli.szco,d1
	 lea	  mv_szco(a6),a3
szco_lp
	 move.l   #$7fff0001,d2
	 xjsr	  edt_unum
	 bmi.s	  szco_lp

	 move.w   d3,mv_sznc(a6)
	 cmp.b	  #k.nl,d2		; left with NEWLINE?
	 bne.s	  szro_cont		; no, carry on reading nr of rows
	 movem.l  (sp)+,r_loos
	 bra.s	  loos_ret

mea_szro
	 movem.l  r_loos,-(sp)
	 bsr.s	  unselect

szro_cont
	 moveq	  #mli.szro,d1
	 lea	  mv_szro(a6),a3
szro_lp
	 move.l   #$7fff0001,d2
	 xjsr	  edt_unum
	 bmi.s	  szro_lp

	 move.w   d3,mv_sznr(a6)
	 cmp.b	  #k.nl,d2		; left with NEWLINE?
	 bne.s	  szco_cont		; no, carryon reading nr of columns

	 movem.l  (sp)+,r_loos

loos_ret
	 moveq	  #0,d0
	 moveq	  #0,d4
	 rts

unselect
	 xjmp	   ut_rdwci

	 end
