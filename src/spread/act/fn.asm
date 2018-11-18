* Spreadsheet					      20/01-92
*	 - format number pulldown routine
*

	 section  prog

	 include  win1_keys_wwork
	 include  win1_keys_wstatus
	 include  win1_keys_wman
	 include  win1_keys_qdos_pt
	 include  win1_keys_err
	 include  win1_spread_keys
	 include win1_mac_oli


	 xdef	  fnm_puld,fnm_init,fnm_updt,edt_unum
	 xdef	  mea_fnes,mea_fndp,mea_fnbr
	 xdef	  mea_fnsn,mea_fnsp,mea_fnge,mea_fnok
	xdef	mea_fndp0

	 xref	  cfg_fndp,cfg_fnbr,cfg_sepr
	 xref	  cfg_fnsn,cfg_fnsp,cfg_fnge

	 xref.s   mli.fndp,mli.fnbr,mli.fnsn,mli.fnsp,mli.fnge,wst_fnum
	xref.s	mli.fndp0

	 xref.l   wwa.fnum,mv_fndp,mv_fnfm,mv_fnxx,mv_fnpv,mv_fnwd

*
* format number initialisation
r_init	 reg	  a0/a1
fnm_init
	 movem.l  r_init,-(sp)
	 lea	  wst_fnum(a6),a1
	 move.b   cfg_fnbr,ws_litem+mli.fnbr(a1)      ; set on/off values
	 move.b   cfg_fnsn,ws_litem+mli.fnsn(a1)
	 move.b   cfg_fnsp,ws_litem+mli.fnsp(a1)
	 move.b   cfg_fnge,ws_litem+mli.fnge(a1)
	 bsr	  fnm_sign		     ; countercheck sign selections
	 lea	  mv_fndp(a6),a0	     ; set decimal places
	 moveq	  #0,d0
	 move.b   cfg_fndp,d0
	 xjsr	  con_wdec
	 bsr.s	  fnm_word		     ; create format word
	 move.w   d0,mv_fnwd(a6)
	 move.w   #-1,mv_fnxx(a6)
	 bsr	  fnm_updt
	 movem.l  (sp)+,r_init
	 rts

*
* create format word from status area
r_word	 reg	  a0/a1
fnm_word
	 movem.l  r_word,-(sp)
	 lea	  mv_fndp(a6),a0	     ; decimal places
	 xjsr	  con_decw
	 andi.w   #$f,d0

	 lea	  wst_fnum(a6),a1
	 tst.b	  ws_litem+mli.fnge(a1)      ; german
	 beq.s	  word_lb1

	 bset	  #fw..germ,d0
word_lb1
	 tst.b	  ws_litem+mli.fnsn(a1)      ; sign always
	 beq.s	  word_lb2

	 bset	  #fw..sign,d0
word_lb2
	 tst.b	  ws_litem+mli.fnbr(a1)      ; brackets
	 beq.s	  word_lb3

	 bset	  #fw..brac,d0
word_lb3
	 tst.b	  ws_litem+mli.fnsp(a1)      ; seperators
	 beq.s	  word_lb4

	 bset	  #fw..sepr,d0
word_lb4
	 movem.l  (sp)+,r_word
	 rts

*
* draw and access format number pulldown window
r_puld	 reg	  a0-a5/d1-d3
fnm_puld
	 movem.l  r_puld,-(sp)
	 move.l   ww_wstat(a4),a1
	 move.l   #wwa.fnum,d1
	 moveq	  #0,d2
	 move.l   wsp_xpos(a1),d4
	 add.l	  ww_xorg(a4),d4
	 lea	  wst_fnum(a6),a1
	 xlea	  men_fnum,a3
	 lea	  puld_chg(pc),a4	     ; changes in wwork
	 lea	  fnm_prev(pc),a5		 ; changes after draw
	 xjsr	  ut_pullf
	 movem.l  (sp)+,r_puld
	 rts

*
* change wwork
puld_chg
	 movem.l  a1/d1/d0,-(sp)

;;;	    move.b   colm(a6),d0
;;;	    andi.l   #$F,d0
;;;	    xjsr     ut_ccwwd			; change main colourway

	 move.w   mv_fnwd(a6),d5
	 move.b   d5,d0
	 andi.w   #$f,d0
	 lea	  mv_fndp(a6),a0
	 xjsr	  con_wdec

	 move.l   ww_wstat(a4),a1	     ; select/deselect items
	 moveq	  #mli.fnge,d0
	 btst	  #fw..germ,d5
	 bsr.s	  chg_set
	 moveq	  #mli.fnsn,d0
	 btst	  #fw..sign,d5
	 bsr.s	  chg_set
	 moveq	  #mli.fnbr,d0
	 btst	  #fw..brac,d5
	 bsr.s	  chg_set
	 moveq	  #mli.fnsp,d0
	 btst	  #fw..sepr,d5
	 bsr.s	  chg_set

	 move.l   ww_chid(a4),a0
	 lea	  mv_fndp(a6),a1	     ; set decimal places
	 moveq	  #mli.fndp,d1
	 jsr	  wm.stlob(a2)
	 xbne	  kill

	 bsr	  fnm_updt		     ; update format string

	 movem.l  (sp)+,a1/d1/d0
	 rts

chg_set
	 beq.s	  chgs_av
	 move.b   #wsi.slct,ws_litem(a1,d0.w)
	 rts
chgs_av
	 move.b   #wsi.avbl,ws_litem(a1,d0.w)
	 rts

*
* OK/ESCape from units menu
mea_fnok
	 bsr	  unselect
	 bset	  #pt..do,wsp_weve(a1)
	 moveq	  #pt..do,d4
	 moveq	  #0,d0
	 rts

mea_fnes
	 bsr	  unselect
	 bset	  #pt..can,wsp_weve(a1)
	 moveq	  #pt..can,d4
	 moveq	  #0,d0
	 rts
*
* countercheck sign selections
fnm_sign
	 tst.b	  ws_litem+mli.fnsn(a1)      ; sign selected?
	 beq.s	  sign_nsn
	 move.b   #wsi.avbl,ws_litem+mli.fnbr(a1)     ; yes, deselect brackets
sign_nsn
	 tst.b	  ws_litem+mli.fnbr(a1)      ; brackets selected?
	 beq.s	  sign_exit
	 move.b   #wsi.avbl,ws_litem+mli.fnsn(a1)     ; yes, deselect sign
sign_exit
	 rts

mea_fnbr
	 move.b   #wsi.avbl,ws_litem+mli.fnsn(a1)     ; deselect sign
	 bra.s	  fnbr_rdw

mea_fnsn
	 move.b   #wsi.avbl,ws_litem+mli.fnbr(a1)     ; deselect brackets
fnbr_rdw
	 moveq	  #mli.fnbr,d1			      ; redraw backets
	 xjsr	  rdw_lchg
	 xbne	  kill

	 moveq	  #mli.fnsn,d1			      ; redraw sign
	 xjsr	  rdw_lchg
	 bra	  loos_ret


*
* preview number
r_prev	 reg	  a1/d1/d3
fnm_prev
	 movem.l  r_prev,-(sp)

	 movem.l  a0/a2,-(sp)
	 move.w   mv_fnwd(a6),d1	     ; format word
	 lsr.w	  #fw..germ,d1
	 andi.b   #1,d1
	 lea	  mv_fnfm(a6),a0	     ; format string
	 xlea	  met_fnnr,a1		     ; number string
	 lea	  mv_fnpv(a6),a2	     ; preview string
	 xjsr	  ut_fnumb
	 move.l   a2,a0
	 xjsr	  st_dllsp		     ; delete leading spaces
	 movem.l  (sp)+,a0/a2

	 move.l   #$00030001,d1 	     ; iwindow 3, iobject 1
	 lea	  mv_fnpv(a6),a1	     ; format string
	 jsr	  wm.stiob(a2)
	 moveq	  #-9,d3		     ; = iwindow 3
	 jsr	  wm.idraw(a2)		     ; redraw info window
	 movem.l  (sp)+,r_prev
	 rts

*
* update format string
r_updt	 reg	  a0-a2/a4/d0-d5
fnm_updt
	 movem.l  r_updt,-(sp)
	 move.w   mv_fnwd(a6),d0
	 andi.w   #%0000101111111111,d0
	 move.w   mv_fnxx(a6),d1
	 andi.w   #%0000101111111111,d1
	 sub.w	  d0,d1
	 beq.s	  updt_exit

	 move.w   d0,mv_fnwd(a6)
	 lea	  wst_fnum(a6),a4	     ; working area
	 lea	  mv_fnfm(a6),a1	     ; format string
	 move.w   #0,(a1)		     ; .. clear it

	 move.w   d0,d5 		     ; d5=current format
	 move.w   d5,d2 		     ; any decimal places
	 andi.b   #$f,d2
	 beq.s	  updt_lb1

	 moveq	  #'#',d1		     ; character
	 move.l   a1,a0
	 xjsr	  st_filst		     ; fill string
	 moveq	  #0,d1
	 moveq	  #'.',d2
	 xjsr	  st_insc		     ; insert decimal point

updt_lb1
	 moveq	  #14,d3		     ; 14 pre-decimal places
	 move.l   a1,a0
	 moveq	  #0,d1
	 move.b   #'#',d2
	 moveq	  #0,d4
	 bra.s	  updt_end

updt_lp
	 xjsr	  st_insc		     ; insert the #-char
	 addq.b   #1,d4 		     ; count the #'s
	 bsr.s	  updt_sep		     ; check seperators

updt_end
	 dbra	  d3,updt_lp

	 moveq	  #'-',d2		     ; insert negativ sign
	 xjsr	  st_insc

	 btst	  #fw..sign,d5		     ; signs selected
	 beq.s	  updt_lb3

	 move.b   #'+',2(a0)		     ; replace - by +

updt_lb3
	 btst	  #fw..brac,d5		     ; bracket selected
	 beq.s	  updt_lb4

	 move.b   #'(',2(a0)		     ; replace - by (
	 move.w   (a0),d1
	 moveq	  #')',d2		     ; insert closing )
	 xjsr	  st_insc

updt_lb4
updt_exit
	 move.w   mv_fnwd(a6),mv_fnxx(a6)
	 movem.l  (sp)+,r_updt
	 rts

updt_sep
	 btst	  #fw..sepr,d5		     ; seperators selected
	 beq.s	  sep_exit

	 cmpi.b   #3,d4 		     ; all three digits
	 bne.s	  sep_exit

	 move.l   d2,-(sp)
	 move.b   cfg_sepr,d2		     ; insert seperator
	 xjsr	  st_insc
	 move.l   (sp)+,d2
	 moveq	  #0,d4 		     ; reset counter

sep_exit
	 rts

mea_fnge
mea_fnsp
loos_ret
	 bsr	  fnm_word
	 move.w   d0,mv_fnwd(a6)
	 bsr	  fnm_updt	    ; update format string
	 bsr	  fnm_prev	    ; preview number
	 moveq	  #0,d0
	 moveq	  #0,d4
	 rts

unselect
	 xjmp	  ut_rdwci

mea_fndp
	 move.w   wwl_item(a3),d1
	 lea	  mv_fndp(a6),a3
fndp_lp
	 move.l   #$00080000,d2 	     ; range 0..8
	 bsr.s	  edt_unum
	 bmi.s	  fndp_lp

	 bra	  loos_ret

mea_fndp0
	move.w	wwl_item(a3),d2 		; get current item number
	add.w	#'0'-mli.fndp0,d2
	move.w	#1,mv_fndp(a6)
	move.b	d2,mv_fndp+2(a6)
	move.b	#wsi.mkav,ws_litem+wst_fnum+mli.fndp(a6)
	xjsr	ut_rdwci
	bra.s	loos_ret

*+++
* read unsigned integer number
*
*		  Entry 		     Edit
*	 d1	  loose item number	     preserved
*	 d2	  maxnum | minnum	     termination keystroke
*	 d3				     value of number
*	 a0	  channel		     preserved
*	 a2	  wman vector		     preserved
*	 a3	  string buffer 	     preserved
*
* error codes: err.nc	   string is no unsigned number
*	       err.orng    number is out of range
* condition codes set
*---
r_unum	 reg	  d1/d7/a0
edt_unum
	 movem.l  r_unum,-(sp)
	 xjsr	  mu_swrds	    ; edit string
	 move.w   d1,d7
	 move.l   a3,a0
	 xjsr	  st_isuis	    ; unsigned integer?
	 bmi.s	  unum_exit

	 xjsr	  con_decw	    ; check range
	 move.w   d0,d1
	 moveq	  #err.orng,d0
	 cmp.w	  d2,d1
	 bmi.s	  unum_exit

	 swap	  d2
	 cmp.w	  d1,d2
	 bmi.s	  unum_exit

	 moveq	  #0,d0

unum_exit
	 move.w   d1,d3
	 move.w   d7,d2 	    ; restore termination character
	 movem.l  (sp)+,r_unum
	 move.l   d0,-(sp)
	 xjsr	  rdw_lchg
	 move.l   (sp)+,d0
	 rts

	 end
