* Spreadsheet					      11/03/92 O.Fink
*	 - file loading

	 include  win1_keys_wwork
	 include  win1_keys_wstatus
	 include  win1_keys_qdos_io
	 include  win1_keys_err
	 include  win1_spread_file_format_keys
	 include  win1_spread_keys
	 include  win1_mac_oli

	 section  prog

	 xdef	  fil_load

	 xref	  dma_quit,dma_frst
	 xref	  ut_rechp
	 xref	  setmol
	 xref	  set_nset
	 xref	  cel_topl
	 xref	  dta_prcs
	 xref	  men_main
	 xref.l   wst_main,mv_mcnr
	 xref	  dta_vadr,mul_grid
	 xref	  cfg_cgap

*+++
* load a new spreadsheet file
*
*		  Entry 			      Exit
*	 a0	  channel of save file		      preserved
*	 a4	  wwork 			      preserved
*
* error codes: err.eof or others
* condition codes set
*---
fil_load subr	  a0-a3/d1-d4

; ------------------------load header-----------------------------
	 add.w	  #1,da_dupdt(a6)	     ; disable display
	 clr.w	  da_saved(a6)
	 lea	  da_buff(a6),a1	     ; buffer
	 moveq	  #10,d2		     ; fetch init words
	 bsr	  get_mulb
	 bne	  load_exit

	 moveq	  #xer_wgff,d0		     ; check file format
	 move.w   sfh_init(a1),d2	     ; init word
	 sub.w	  #sfh.init,d2
	 bne	  load_exit

	 move.l   sfh_id(a1),d2 	     ; application id
	 sub.l	  #sfh.id,d2
	 bne	  load_exit

	moveq	#xer_icfv,d0
	move.l	sfh_vers(a1),d2 	; file format version
	move.b	d2,d4			; keep version 2 or 3 here!
	cmp.l	#sfh.v102,d2		; format 2 - ignore password
	beq	ver_102
	cmp.l	#sfh.v103,d2		; format 3 - password check first
	bne	load_exit
ver_103 				; check password
	lea	da_buff+sfh_pasw(a6),a1
	moveq	#4,d2			; fetch password
	bsr	get_mulb
	bne	load_exit
ver_102 				; we skip the password
	lea	da_buff+sfh_cols(a6),a1 ; so load remaining header
	moveq	#4,d2			; only two words left
	bsr	get_mulb
	bne	load_exit
	 moveq	  #xer_wgff,d0
	 move.w   sfh_cols(a1),d2
	 beq.s	  loa_crsz		     ; current size of sheet

	 move.w   sfh_cols(a1),da_ncols(a6)  ; set new grid size
	 move.w   sfh_rows(a1),da_nrows(a6)
	 xjsr	  forg_grd
	 bne.s	  load_exit
	 move.w   #1,da_saved(a6)
loa_crsz
	 addq.w   #1,da_dupdt(a6)

; ---------------  load column widths ----------------------------------
	 move.w   sfh_cols(a1),d2
	 beq.s	  loa_nocl		     ; no column size information

	 bsr	  get_mulb		     ; load column size info
	 bne.s	  load_exit
	 bsr	  loa_setcs		     ; set column sizes
loa_nocl

;---------------  load cell informations ------------------------------
	 move.l   a3,-(sp)
	 xjsr	  mon_strt
loa_clp
	 moveq	  #6,d2 	    ; load one long word/one word
	 bsr	  get_mulb
	 bne.s	  loa_clx	    ; end of file reached

	 move.l   (a1),d1
	 bpl.s	  loa_cll
	 bsr.s	  loa_env	    ; environment code
	 bra.s	  loa_clp
loa_cll
	 move.l   d1,da_moncl(a6)
	 adda.w   #6,a1

	 bsr.s	  skip_value

	 bsr	  get_strg	    ; get formular
	 bne.s	  loa_clx
	 suba.w   #6,a1

	 bsr	  loa_form	    ; install formular
	 bne.s	  loa_clx
	 bra	  loa_clp
loa_clx
	 xjsr	  mon_stop
	 move.l   (sp)+,a3
; ---------------  redraw window ---------------------------------------
	 xjsr	  acc_calc		     ; recalculate
	 clr.w	  da_dupdt(a6)
	 xjsr	  rdw_grdr
	 xjsr	  rdw_grdr

	 moveq	  #0,d0
load_exit
	 tst.l	  d0
	 subend


skip_value subr a1/d2
	cmp.b	#'2',d4
	blt.s	skip_exit
	moveq	#6,d2
	bsr	get_mulb
skip_exit subend



; environment codes
loa_env  subr	  a1/a5
	 move.w   sfe_code(a1),d2	     ; get environment code
	 bge.s	  env_env
	 bsr.s	  loa_macro
	 bra.s	  env_exit
env_env
	 lea	  env_tab,a5
	 add.w	  -2(a5,d2.w),a5	     ; get routine address
	 jsr	  (a5)			     ; do it
env_exit
	 subend

loa_macro
	 move.w   d2,d0
	 neg.w	  d0
	 subq.w   #1,d0
	 mulu	  #80,d0

	 move.w   sfm_macr(a1),d2	     ; get macro length
	 lea	  mv_mcnr(a6),a1
	 adda.l   d0,a1
	 move.w   d2,(a1)+		     ; set macro length
	 bsr	  get_mulb		     ; read macro
	 rts

env_tab  dc.w	  env_nfmt-env_tab	     ; number format
	 dc.w	  env_err-env_tab	     ; (string format)
	 dc.w	  env_fmtn-env_tab	     ; format numbers on/off
	 dc.w	  env_ordr-env_tab	     ; entry order
	 dc.w	  env_auto-env_tab	     ; auto calc on/off
	 dc.w	  env_zero-env_tab	     ; empty when zero
	 dc.w	  env_same-env_tab	     ; empty if same as above

env_err
	 moveq	  #err.nimp,d0
	 rts

env_nfmt
	 move.w   sfe_val(a1),da_fword(a6)   ; number format
	 moveq	  #0,d0
	 rts

env_fmtn
	 move.w   sfe_val(a1),da_dofmt(a6)   ; format numbers on/off
	 moveq	  #0,d0
	 rts

env_ordr
	 move.w   sfe_val(a1),d0	     ; calculation/input order
	 swap	  d0
	 move.w   sfe_val(a1),d0
	 bchg	  #0,d0
	 move.l   d0,da_ordr(a6)
	 moveq	  #0,d0
	 rts

env_auto
	 move.w   sfe_val(a1),da_autoc(a6)   ; auto calculation on/off
	 moveq	  #0,d0
	 rts

env_zero
	 move.w   sfe_val(a1),da_emptz(a6)   ; empty when zero
	 moveq	  #0,d0
	 rts

env_same
	 move.w   sfe_val(a1),da_esame(a6)   ; empty if same as above
	 moveq	  #0,d0
	 rts


; install a new formular
; a1:	 cell nr     (.l)
;	 format word (.w)
;	 formular    (strg)
;
loa_form subr	  a0-a4/d1-d3

	 move.l   (a1)+,d1
	 move.w   (a1)+,d2
	 xjsr	  acc_putf
	 xjsr	  acc_fwrd
	 moveq	  #0,d0
	 subend


; set column sizes
loa_setcs subr	  a1/a3/d0/d1/d2
	 move.l   da_mspcl(a6),a3	     ; column spacing list
	 bra.s	  sz_lpe
sz_lp
	 move.b   (a1)+,d1		     ; column width in chars
	 ext.w	  d1
	 mulu	  #qs.xchar,d1		     ; in pixels
	 addq.w   #2,d1
	 move.w   d1,wwm_size(a3)	     ; set hit size
	 move.b   cfg_cgap,d0
	 beq.s	  no_gap
	 addq.w   #2,d1
no_gap	 move.w   d1,wwm_spce(a3)	     ; set space to the next
	 adda.w   #wwm.slen,a3		     ; next column
sz_lpe
	 dbra	  d2,sz_lp
	 subend



; a0 = channel id
; a1 = ptr to string
get_strg subr	  a1/d2
	 moveq	  #2,d2
	 bsr.s	  get_mulb
	 bne.s	  strg_exit
	 move.w   (a1)+,d2
	 bsr.s	  get_mulb
strg_exit
	 subend


;+++
; fetch multiple bytes
;
; a0 = channel id
; a1 = buffer area
; d2 = number of bytes
;---
get_mulb subr	  a1/d1
	 moveq	  #iob.fmul,d0
	 move.l  d3,-(sp)
	 moveq	 #forever,d3
	 trap	 #do.io
	 move.l  (sp)+,d3
	 tst.l	 d0
	 subend

	 end
