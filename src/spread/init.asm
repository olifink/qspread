* Spreadsheet					      29/11-91
*	 - main control
*
	 section  prog

	 include  win1_keys_qdos_sms
	 include  win1_keys_sys
	 include  win1_mac_oli
	 include  win1_keys_err
	 include  win1_spread_keys
	 include  win1_keys_wstatus

	 xdef	  kill,rep_error,jobstart

	 xref	  cfg_colmn,cfg_rows,cfg_cwdt
	 xref	  cfg_stcr,cfg_automov

	 xref.l   mv_fnge,mv_fnfm,mv_stcr,mv_poif,mv_poef
	 xref.l   mv_szco,mv_szro,mv_sznc,mv_sznr

jobstart
	 xjsr	  ut_clwsp		     ; clear all our workspace
	 adda.w   #da_end,a6		     ; a6 points to data area
	 xjsr	  ut_jbpar		     ; get job parameters
	 lea	  da_buff(a6),a0	     ; copy command line into buffer
	 xjsr	  ut_cpyst

*
* set current job priority, mode, sysbase etc.
	 moveq	  #qs.prior,d0		     ; job priority
	 xjsr	  ut_prior
	 bne	  kill

	 xjsr	  ut_himod		     ; set highest possible display
	 move.b   d1,da_mode(a6)

	 moveq	  #sms.info,d0		     ; request system info
	 trap	  #do.sms2
	 move.l   a0,da_sysv(a6)	     ; store base of sysvars

*
* check extended environment
	 move.l   #'1.69',d1		     ; minimum pointer i/f
	 move.l   #'1.55',d2		     ; minimum wman
	 move.l   #'7.65',d3		     ; minimum menu rext
	 xjsr	  ut_xver

	xjsr	mu_getdef
	bne.s	end_colour
	move.b	d4,cffui(a6)
	swap	d4
	move.b	d4,v_expldel(a6)	; icon explain delay
	move.b	d5,v_explcol(a6)	; explain colourway

end_colour
*
* open console and store results
	 xjsr	  ut_opcon
	 bne	  kill			     ; ptr_gen or wman not found

	 move.l   a0,da_chan(a6)	     ; store channel id
	 move.l   a2,da_wmvec(a6)	     ; store wman-vector

*
* get maximum screen size
	 xjsr	  ut_gwlma		     ; get window limit area
	 bne	  kill

	 move.l   d1,da_xlim(a6)	     ; store size d1=xsize|ysize

*
* set job defaults from config block in data area
	 move.w   #0,da_fname(a6)	     ; no actual filename
	 lea	  da_fextn(a6),a0	     ; filename extension
	 xlea	  cfg_extn,a1
	 xjsr	  ut_cpyst
	 lea	  mv_poif(a6),a0	     ; import filter

	 xlea	  cfg_flti,a1
	 xjsr	  ut_cpyst
	 lea	  mv_poef(a6),a0	     ; export filter
	 xlea	  cfg_flte,a1
	 xjsr	  ut_cpyst
	 lea	  da_helpd(a6),a0	     ; help directory
	 xlea	  cfg_helpf,a1
	 xjsr	  ut_cpyst
	 lea	  da_fltd(a6),a0	     ; filter directory
	 xlea	  cfg_fltd,a1
	 xjsr	  ut_cpyst
	 lea	  da_prtd(a6),a0	     ; printer directory
	 xlea	  cfg_prtd,a1
	 xjsr	  ut_cpyst
	 xlea	  cfg_locd,a1
	 lea	  da_datad(a6),a0	     ; put data directory in buffer
	 xjsr	  ut_cpyst
;	  xlea	   cfg_nxfn,a1
;	  lea	   da_extnf(a6),a0
;	  xjsr	   ut_cpyst
;	  xlea	   cfg_sxfn,a1
;	  lea	   da_extsf(a6),a0
;	  xjsr	   ut_cpyst
	 move.w   cfg_colmn,da_ncols(a6) ; set maximum number of columns
	 move.w   cfg_rows,da_nrows(a6)      ; ..the same for rows
	 move.w   cfg_cwdt,da_colwd(a6)      ; initial column width

	move.b	cfg_automov,v_automov(a6)

	 moveq	  #0,d0
;;;	    move.b   cols(a6),d0
;;;	    swap     d0
;;;	    move.b   colm(a6),d0
	 move.l   d0,da_cway(a6)

	 move.w   cfg_colmn,d0		; fill ASCII number of cols/rows in
	 move.w   d0,mv_sznc(a6)
	 lea	  mv_szco(a6),a0
	 xjsr	  con_wdec

	 move.w   cfg_rows,d0
	 move.w   d0,mv_sznr(a6)
	 lea	  mv_szro(a6),a0
	 bsr	  con_wdec

*
* parse command line
	 moveq	  #err.ipar,d0		     ; check channel redirection
	 tst.w	  (sp)			     ; not allowed
	 bne	  kill

	 lea	  da_buff(a6),a1	     ; a1 points to command line
	 xlea	  cltab,a2

	 xjsr	  ut_prscl		     ; parse command line
	 move.l   da_wmvec(a6),a2	     ; restore wman-vector
*
* now do all the setup things for menu subwindow / dma
	 moveq	  #0,d0 		     ; set confirmation status
	 move.b   cfg_stcr,d0
	 move.w   d0,mv_stcr(a6)
	 xjsr	  setmol		     ; setup all the menu items
	 xjsr	  dma_frst		     ; set first dma block
	 xjsr	  fnm_init		     ; format number initialisation
	 xjsr	  glb_unit		     ; set global units format
	 xjsr	  stt_init
	 xjsr	  ini_popt
	 xjsr	  ini_macr
	 xjsr	  ini_digt
	 xjsr	  ini_find
	 clr.w	  da_dupdt(a6)		     ; allow for display update
	 clr.l	  da_monid(a6)		     ; no monitor running
	 move.w   #1,da_saved(a6)	     ; file is saved

*
* now do all the window handling stuff (setting up, preparing cell block etc.)
	 xjsr	  set_fset
	 moveq	  #0,d1 		     ; first cell is A1
	 move.l   d1,da_cbx0(a6)
	 move.l   d1,da_usedx(a6)
	 xjsr	  cel_topl		     ; select one cell

*
* now that the window is drawn, a file can savely be loaded
	lea	da_fname(a6),a0 	     ; try to open file
	tst.w	(a0)
	beq.s	window

	moveq	#1,d3			     ; old shared file
	xjsr	gu_fopen
	bne.s	no_file

	xjsr	fil_load
	xjsr	gu_fclos
	bra.s	window

no_file
	clr.w	da_fname(a6)

*
* read the pointer etc.
window
	xjsr	 open_flash

	move.l	 da_chan(a6),a0
	xjsr	 fil_setf
	xjsr	 mod_norm		    ; normal selection mode
	xjsr	 do_window		    ; this only returns to kill itself

*
* get to here when somthing went wrong
kill
	 move.l   da_chan(a6),d1	     ; close channel
	 beq.s	  kill_x

	 move.l   d1,a0
	 xjsr	  gu_fclos

kill_x
	 xjmp	  ut_appr		     ; application error

*+++
* report error
*
*	 D0 = error code
*---
r_err	 reg	  a0/d0/d1/d2
rep_error
	 tst.l	  d0			; no error... no message, ok
	 bge.s	  no_error		; ignore ESC as well

	 movem.l  r_err,-(sp)
	 bmi.s	  qdos_err		; was it a simple qdos error

	 xlea	  arr_xerr,a0		; or one of my more complex errors
	 subi.l   #xer.base,d0
	 mulu	  8(a0),d0
	 addi.l   #$e,d0
	 add.l	  a0,d0
	 bset	  #31,d0

qdos_err
	moveq	#-1,d1
	moveq	#0,d2
	move.b	colm(a6),d2
	xjsr	mu_rperr
	movem.l (sp)+,r_err

no_error
	 rts


	 end
