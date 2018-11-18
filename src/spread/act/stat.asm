* Spreadsheet					      30/01-92
*	 - status menu pulldown routine
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

	 xdef	  stt_puld,pld_msym,stt_init,glb_unit
	 xdef	  mea_stco,mea_stun,mea_stms,mea_stjs
	 xdef	  mea_stes,mea_stok,mea_stac,mea_stdf
	 xdef	  mea_stez,mea_stbk,mea_stcr,mea_stsm
	 xdef	  mea_ok,mea_esc,mea_strd,mea_stdi
	 xdef	  mea_sttb,mea_stld,dir_help,dir_data,dir_tflt,dir_pflt
	xdef	mea_automov
	
	 xref	  cfg_ordr,cfg_aclc,cfg_emtz
	 xref	  cfg_dfmt,cfg_vjst,cfg_sabk,cfg_stcr
	 xref	  cfg_strd,cfg_emts,cfg_tool

	 xref.l   mv_fnwd,mv_fnfm,mv_stms,mv_stcr
	 xref.l   mv_strd,mv_strn,wwa.stat,wst_stat
	 xref.l   mli.strd,mli.strn,mli.sttb
	 xref.l   mlo.stac,mlo.stfn,mlo.stcr
	 xref.l   mlo.stez,mlo.strd,mlo.strn
	 xref.l   mlo.strd,mlo.strn,mlo.stsm,mlo.sttb

	 xref.s   mli.stco,mli.stun,mli.stms,mli.stjs
	 xref.s   mli.stes,mli.stok,mli.stbk,mli.stcr
	 xref.s   mli.stcmn,mli.stcmd,mli.stcmr
	

*
* status menu initialisation
r_init	 reg	  d1/a1
stt_init
	 movem.l  r_init,-(sp)
	 move.b   cfg_ordr,d1
	 bsr	  stt_ordr
	 lea	  wst_stat(a6),a1
	 moveq	  #0,d0
	 move.b   cfg_vjst,d0
	 move.w   d0,da_fjust(a6)
	 move.b   cfg_strd,d0
	 move.w   d0,da_round(a6)
	 move.w   #fw.strg,da_sword(a6)
	 move.b   cfg_aclc,ws_litem+mlo.stac(a1)
	 move.b   cfg_dfmt,ws_litem+mlo.stfn(a1)
	 move.b   cfg_emtz,ws_litem+mlo.stez(a1)
	 move.b   cfg_emts,ws_litem+mlo.stsm(a1)
	 move.b   cfg_tool,ws_litem+mlo.sttb(a1)
	 move.b   cfg_tool,da_toolb+1(a6)
	 move.b   mv_stcr+1(a6),ws_litem+mlo.stcr(a1)
	moveq	#wsi.avbl,d0
	move.b	d0,ws_litem+mli.stcmn(a1)
	move.b	d0,ws_litem+mli.stcmd(a1)
	move.b	d0,ws_litem+mli.stcmr(a1)
	move.b	v_automov(a6),d0
	move.b	#wsi.slct,ws_litem+mli.stcmn(a1,d0.w)
	 move.b   cfg_sabk,d0
	 ext.w	  d0
	 move.b   d0,ws_litem+mli.stbk(a1)
	 move.w   d0,da_backu(a6)
	 bsr	  set_round
	 bsr.s	  stt_data
	 movem.l  (sp)+,r_init
	 rts


*+++
* set main data area according to item statuses
*
*		  Entry 		     Exit
*	 a1	  status status area	     preserved
*---
stt_data
	 moveq	  #0,d0
	 move.b   ws_litem+mlo.stcr(a1),d0   ; confirmation request
	 move.w   d0,mv_stcr(a6)
	 move.b   ws_litem+mlo.stac(a1),d0   ; auto calculate
	 move.w   d0,da_autoc(a6)
	 move.b   ws_litem+mlo.stfn(a1),d0   ; format numeric values
	 move.w   d0,da_dofmt(a6)
	 move.b   ws_litem+mlo.stez(a1),d0   ; empty when zero
	 eori.b   #wsi.slct,d0
	 move.w   d0,da_emptz(a6)
	 move.b   ws_litem+mlo.stsm(a1),d0   ; empty if same as above
	 move.w   d0,da_esame(a6)
	 rts

*+++
* set item according to their state in the data area
*
*		  Entry 		     Exit
*	 a1	  status status area	     preserved
*---
stt_item
	 moveq	  #0,d0
	 move.w   da_autoc(a6),d0
	 move.b   d0,ws_litem+mlo.stac(a1)   ; auto calculate
	 move.w   da_dofmt(a6),d0
	 move.b   d0,ws_litem+mlo.stfn(a1)   ; format numeric values
	 move.w   da_emptz(a6),d0
	 eori.b   #wsi.slct,d0
	 move.b   d0,ws_litem+mlo.stez(a1)   ; empty when zero
	 move.w   da_esame(a6),d0
	 move.b   d0,ws_litem+mlo.stsm(a1)   ; empty when same as above
	 rts

*+++
* set calculation / entry order
*
*		  Entry 		     Exit
*	 d1.b	  0=col/1=row
*---
stt_ordr
	 tst.b	  d1
	 beq.s	  ordr_col

	 move.l   #$00010000,da_ordr(a6)
	 bra.s	  ordr_exit

ordr_col
	 move.l   #$1,da_ordr(a6)

ordr_exit
	 rts


*
* set loose item according to entry order
r_sord	 reg	  a1
stt_sord
	 movem.l  r_sord,-(sp)
	 tst.w	  da_ordr(a6)		     ; upper word=0
	 bne.s	  sord_row		     ; then order by row

	 xlea	  met_stcl,a1
	 bra.s	  sord_set

sord_row
	 xlea	  met_strw,a1

sord_set
	 moveq	  #mli.stco,d1
	 jsr	  wm.stlob(a2)		     ; change loose object
	 movem.l  (sp)+,r_sord
	 rts


*
* draw and access status pulldown window
r_puld	 reg	  a0-a5/d0-d3
stt_puld
	 movem.l  r_puld,-(sp)
	 move.l   #wwa.stat,d1
	 moveq	  #0,d2
	 move.l   wwl_xorg(a3),d4	     ; pointer position
	 add.l	  ww_xorg(a4),d4
	 lea	  wst_stat(a6),a1
	 xlea	  men_stat,a3
	 suba.l   a4,a4
	 lea	  puld_chg(pc),a4	     ; changes in wwork
	 suba.l   a5,a5 		     ; changes after draw
	 xjsr	  ut_pullf
	 movem.l  (sp)+,r_puld
	 cmpi.b   #k.cancel,d4
	 beq.s	  puld_exit

	 move.l   da_wwork(a6),a4
	 xjsr	  grd_calc

puld_exit
	 moveq	  #0,d0
	 moveq	  #0,d4
	 rts

*
* change wwork
puld_chg
	 movem.l  a1/d1/d0,-(sp)

;;;	    move.b   colm(a6),d0
;;;	    andi.l   #$F,d0
;;;	    xjsr     ut_ccwwd			; change main colourway
	 bsr	  stt_sord		     ; set order item
	 bsr	  stt_item		     ; set items according to state
	 bsr	  set_round
	 moveq	  #mli.strn,d1
	 lea	  mv_strn(a6),a1
	 jsr	  wm.stlob(a2)
	 bmi	  do_kill

	 movem.l  (sp)+,a1/d1/d0
	 rts

*
* OK/ESCape from units menu
mea_ok
mea_stok
	 bsr	  unselect
	 bset	  #pt..do,wsp_weve(a1)
	 moveq	  #pt..do,d4
	 moveq	  #0,d0
	 rts

mea_esc
mea_stes
	 bsr	  unselect
	 bset	  #pt..can,wsp_weve(a1)
	 moveq	  #pt..can,d4
	 moveq	  #0,d0
	 rts

mea_stco
	 bsr	  unselect
	 move.l   da_ordr(a6),d1	     ; reverse order
	 swap	  d1
	 move.l   d1,da_ordr(a6)
	 bsr	  stt_sord		     ; set loose item
	 moveq	  #mli.stco,d1
	 xjsr	  rdw_lchg		     ; redraw item
	 bra.s	  loos_ret

mea_stun
	 bsr.s	  unselect
	 move.w   da_fword(a6),mv_fnwd(a6)
	 xjsr	  fnm_puld
	 beq.s	  mea_stun_ok

	 xjmp	  kill

mea_stun_ok
	 bsr	  glb_unit
	 bra.s	  loos_ret


mea_stjs
	 bsr.s	  unselect
	 moveq	  #0,d1 		     ; global justification
	 xjsr	  jst_puld
	 bmi.s	  loos_ret

	 ext.w	  d1
	 move.w   d1,da_fjust(a6)
	 tst.w	  d1
	 bmi.s	  stjs_r

	 bset	  #fw..just,da_fword(a6)
	 bra.s	  loos_ret

stjs_r
	 bclr	  #fw..just,da_fword(a6)
	 bra.s	  loos_ret

mea_stcr
mea_stac
mea_stdf
mea_stez
mea_stsm
	 bsr	  stt_data

loos_ret
	 moveq	  #0,d0
	 moveq	  #0,d4
	 rts

mea_sttb
	 move.b   ws_litem+mli.sttb(a1),d0
	 andi.w   #$00fe,d0
	 ori.w	  #$ff00,d0		     ; signal change
	 move.w   d0,da_toolb(a6)
	 bra.s	  loos_ret

mea_stbk
	 move.b   ws_litem+mli.stbk(a1),d0
	 andi.w   #$00fe,d0
	 move.w   d0,da_backu(a6)
	 bra.s	  loos_ret

unselect
	 xjmp	   ut_rdwci

mea_stdi
	 bsr.s	  unselect
	 xjmp	  pld_digt


mea_stms
	 bsr.s	  pld_msym
	 bsr	  unselect
	 move.w   mv_stms(a6),d0
	 andi.w   #%111,d0
	 ror.w	  #4,d0
	 move.w   da_fword(a6),d4
	 andi.w   #%1000111111111111,d4
	 or.w	  d0,d4
	 move.w   d4,da_fword(a6)
	 bra	  loos_ret


r_msym	 reg	  a0/a2/a3/d1
pld_msym
	 movem.l  r_msym,-(sp)
	 moveq	  #4,d1 		     ; centred, select keys
	 xlea	  met_cmsy,a0		     ; window title
	 xlea	  arr_msym,a2		     ; item list
	 suba.l   a3,a3 		     ; current position
	 xjsr	  cmd_puld
	 tst.w	  d1
	 bmi.s	  msym_exit

	 move.w   d1,mv_stms(a6)

msym_exit
	 movem.l  (sp)+,r_msym
	 moveq	  #0,d0
	 rts

*
* set global units format
glb_unit
	 move.w   mv_fnwd(a6),da_fword(a6)
	 rts


*
* set items according to round
set_round subr	  a0-a4/d1-d3
	 move.w   da_round(a6),d0
	 beq.s	  round_no

	 bsr.s	  round_nr
	 move.b   #wsi.mksl,ws_litem+mlo.strd(a1)
	 move.b   #wsi.mkav,ws_litem+mlo.strn(a1)
	 bra.s	  round_set

round_no
	 move.b   #wsi.mkun,ws_litem+mlo.strn(a1)
	 move.b   #wsi.mkav,ws_litem+mlo.strd(a1)
	 clr.w	  mv_strn(a6)

round_set
	 subend

round_nr subr	  a0
	 lea	  mv_strn(a6),a0
	 xjsr	  con_wdec
	 subend


mea_strd
	 moveq	  #0,d3
	 move.b   ws_litem+mli.strd(a1),d0
	 bclr	  #0,d0
	 tst.b	  d0
	 beq.s	  strd_set

strd_again
	 moveq	  #mli.strn,d1	    ; loose item number
	 move.l   #$00070000,d2     ; max/min
	 lea	  mv_strn(a6),a3    ; string buffer
	 xjsr	  edt_unum	    ; edit unsigned number
	 beq.s	  strd_set	    ; all ok

	 move.w   da_round(a6),d3   ; ESC, so get old value

strd_set
	 move.w   d3,da_round(a6)
	 bsr	  set_round
	 moveq	  #mli.strn,d1
	 lea	  mv_strn(a6),a1
	 jsr	  wm.stlob(a2)
	 beq.s	  strd_ok

do_kill
	 xjmp	  kill

strd_ok
	 moveq	  #wm.drsel,d3
	 jsr	  wm.ldraw(a2)
	 bne.s	  do_kill

	 moveq	  #0,d0
	 moveq	  #0,d4
	 rts

mea_stld
	 bsr	  unselect
	 move.l   da_cway(a6),d1
	 xlea	  sub_ldir,a1
	 xjsr	  pld_smen
	 bra	  loos_ret


dir_help movem.l a0-a4/d1-d2,-(sp)
	 lea	  da_helpd(a6),a4
	 xlea	  met_dhlp,a0
	 bra.s	  dir_do

dir_tflt movem.l a0-a4/d1-d2,-(sp)
	 lea	  da_fltd(a6),a4
	 xlea	  met_dflt,a0
	 bra.s	  dir_do

dir_pflt movem.l a0-a4/d1-d2,-(sp)
	 lea	  da_prtd(a6),a4
	 xlea	  met_dprt,a0
	 bra.s	  dir_do

dir_data subr	  a0-a4/d1-d2
	 lea	  da_datad(a6),a4
	 xlea	  met_ddat,a0

dir_do
	 moveq	  #-1,d1
	 move.l   da_cway(a6),d2
	 xjsr	  mu_dsel
	 moveq	  #0,d0
	 moveq	  #0,d4
	 subend

mea_automov
	move.w	wwl_item(a3),d0
	move.w	d0,d3
	sub.w	#mli.stcmn,d0
	move.b	d0,v_automov(a6)
	lea	auto_list,a3
	xjsr	wu_radio
	moveq	#-1,d3
	jsr	wm.ldraw(a2)
	moveq	#0,d4
	rts

auto_list
	dc.w	mli.stcmn,mli.stcmd,mli.stcmr,-1

	 end
