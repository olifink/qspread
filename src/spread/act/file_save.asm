* Spreadsheet					      11/03/92 O.Fink
*	 - file saving

	 include  win1_keys_wwork
	 include  win1_keys_qdos_io
	 include  win1_spread_keys
	 include  win1_mac_oli

	 section  prog

	 xdef	  fil_save

	 xref.l   mv_mcnr

*+++
* save current spreadsheet file
*
*		  Entry 			      Exit
*	 a0	  channel of save file		      preserved
*	 a4	  wwork 			      preserved
*
* error codes: ?
* condition codes set
*---
r_save	 reg	  d1-d3/a1/a3/a5
fil_save
	 movem.l  r_save,-(sp)

; ------------------------write header-----------------------------
	 lea	  da_buff(a6),a1	     ; buffer
	 move.l   a1,a2
	 move.w   #sfh.init,(a2)+	     ; initialisation code
	 move.l   #sfh.id,(a2)+ 	     ; id of application
	 move.l   #sfh.v104,(a2)+	     ; file format version
	 move.l   v_password(a6),(a2)+	     ; password
	 move.w   da_ncols(a6),(a2)+	     ; nr of columns
	 move.w   da_nrows(a6),(a2)+	     ; nr of rows
	 moveq	  #sfh.len,d2
	 bsr	  wrt_mulb		     ; write header to file
	 bne	  save_exit

;-------------------------write column information-----------------
	 move.w   da_ncols(a6),d4	     ; number of columns
	 move.l   ww_pappl(a4),a3
	 move.l   (a3),a3
	 move.l   wwa_xspc(a3),a3	     ; x spacing list
	 bra.s	  col_end

col_lp
	 move.w   wwm_size(a3),d1
	 subq.w   #2,d1
	 divu	  #qs.xchar,d1
	 bsr	  wrt_byte		     ; write column byte
	 bne.s	  save_exit

	 adda.w   #wwm.slen,a3

col_end
	 dbra	  d4,col_lp

;------------------------write cell formulars----------------------
	 moveq	  #0,d1 		     ; first cell
	 lea	  wrt_cell(PC),a5
	 xjsr	  mul_grid		     ; write cells
	 bne.s	  save_exit


;------------------------any more information----------------------

	 move.w   #sfe.nfmt,d0		     ; global numeric format
	 move.w   da_fword(a6),d2
	 bsr	  wrt_envr
	 bne.s	  save_exit

	 move.w   #sfe.fmtn,d0		     ; format numbers
	 move.w   da_dofmt(a6),d2
	 bsr	  wrt_envr
	 bne.s	  save_exit

	 move.w   #sfe.ordr,d0		      ; order
	 move.w   da_ordr(a6),d2
	 bsr.s	  wrt_envr
	 bne.s	  save_exit

	 move.w   #sfe.auto,d0		      ; auto calculation
	 move.w   da_autoc(a6),d2
	 bsr.s	  wrt_envr
	 bne.s	  save_exit

	 move.w   #sfe.zero,d0		      ; empty when zero
	 move.w   da_emptz(a6),d2
	 bsr.s	  wrt_envr
	 bne.s	  save_exit

	 move.w   #sfe.same,d0		      ; empty if same as above
	 move.w   da_esame(a6),d2
	 bsr.s	  wrt_envr
	 bne.s	  save_exit

	 moveq	  #0,d2 		     ; start with first macro

mcr_lp
	 bsr.s	  wrt_macr
	 bne.s	  save_exit

	 addq.w   #1,d2 		     ; get to the next
	 cmpi.w   #5,d2
	 bne.s	  mcr_lp

save_exit
	 movem.l  (sp)+,r_save
	 tst.l	  d0
	 rts



;====================================================================
;-------------------------write cell information---------------------
r_cell	 reg	  d1/a1/a3/d4
wrt_cell
	 movem.l  r_cell,-(sp)
	 xjsr	  dta_vadr		     ; get base of value block
	 bne.s	  cell_exit

	 move.l   val_form(a3),d4	     ; any formular ?
	 beq.s	  cell_exit		     ; no..

	 lea	  da_buff(a6),a1	     ; buffer area
	 move.l   d1,sfc_cnr(a1)	     ; cell number
	 move.w   val_fwrd(a3),sfc_fwrd(a1)  ; format word
	 move.l   val_real(a3),sfc_real(a1)
	 move.w   val_real+4(a3),sfc_real+2(a1)
	 moveq	  #6+6,d2
	 bsr.s	  wrt_mulb		     ; write 6+6 bytes
	 bne.s	  cell_exit


	 move.l   d4,a1 		     ; this is the formular
	 bsr.s	  wrt_strg

cell_exit
	 movem.l  (sp)+,r_cell
	 moveq	  #0,d0
	 rts

;---------------------------write environment information-----------------------------
;
;	 d0.w = environment_code
;	 d2.w = environment_value
wrt_envr
	subr	 a1/d2
	 lea	  da_buff(a6),a1
	 move.w   #sfe.id,sfe_id(a1)		      ; environment id
	 move.w   d0,sfe_code(a1)		      ; environment code
	 move.w   d2,sfe_val(a1)		      ; environment value
	 moveq	  #6,d2
	 bsr.s	  wrt_mulb
	 subend

;-----------------------------write macro------------------------------------
;
;	d2.w	= macro number (0 to 4)
;
wrt_macr
	subr	 a3/a1/d2
	 lea	  da_buff(a6),a1
	 move.w   #sfe.id,sfe_id(a1)	     ; environment code id
	 move.w   d2,d0
	 addq.w   #1,d0
	 neg.w	  d0
	 move.w   d0,sfe_code(a1)	     ; marker of macro
	 moveq	  #0,d0

	 mulu	  #80,d2		     ; find this macro
	 lea	  mv_mcnr(a6),a3
	 adda.l   d2,a3
	 tst.w	  (a3)			     ; is it defined?
	 beq.s	  macr_exit

	 moveq	  #4,d2 		     ; write macro header
	 bsr.s	  wrt_mulb
	 bne.s	  macr_exit

	 move.l   a3,a1 		     ; write the macro itself
	 bsr.s	  wrt_strg

macr_exit
	 tst.l	  d0
	 subend



; a0 = channel id
; a1 = ptr to string
wrt_strg
	 moveq	  #iob.smul,d0
	 move.w   (a1),d2
	 addq.w   #2,d2
	 move.l  d3,-(sp)
	 moveq	 #forever,d3
	 trap	 #do.io
	 move.l  (sp)+,d3
	 tst.l	 d0
	 rts

;+++
; write multiple bytes
;
; a0 = channel id
; a1 = buffer area
; d2 = number of bytes
;---
wrt_mulb
	 moveq	  #iob.smul,d0
	 move.l  d3,-(sp)
	 moveq	 #forever,d3
	 trap	 #do.io
	 move.l  (sp)+,d3
	 tst.l	 d0
	 rts

r_word	 reg	  d1/d2
wrt_word
	 movem.l  r_word,-(sp)
	 move.w   d1,d2
	 lsl.w	  #8,d1
	 bsr.s	  wrt_byte
	 bne.s	  word_exit

	 move.w   d2,d1
	 bsr.s	  wrt_byte

word_exit
	 movem.l  (sp)+,r_word
	 rts

r_byte	 reg	  d1/d3/a1
wrt_byte
	 movem.l  r_byte,-(sp)
	 moveq	  #iob.sbyt,d0
	 moveq	  #forever,d3
	 trap	  #do.io
	 movem.l  (sp)+,r_byte
	 tst.l	  d0
	 rts

	 end
