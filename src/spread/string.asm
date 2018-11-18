* Spreadsheet					      21/01-92
*	 - string processing routines

	 section  prog

	 include  win1_keys_wman
	 include  win1_keys_wstatus
	 include  win1_keys_wwork
	 include  win1_keys_err
	 include  win1_spread_keys
	 include  win1_mac_oli

	 xdef	  prc_strg
	 xdef	  str_main
	 xdef	  cel_wdth

*+++
* process a string constant
* (smashes buffer)
*
*		  Entry 		     Exit
*	 a3	  ptr to formular	     preserved
*---
r_strg	 reg	  a0/a1/a3/d1/d2
prc_strg
	 movem.l  r_strg,-(sp)
	 move.l   a3,a1 		     ; copy formular into buffer
	 lea	  da_buff(a6),a0
	 xjsr	  ut_cpyst

	 moveq	  #1,d1 		     ; delete " (1st char)
	 xjsr	  st_delc
	 move.l   da_ccell(a6),d1

	 move.l   a0,a1 		     ; fill string to sheet
	 bsr.s	  str_main
	 bne.s	  strg_exit

	 move.l   a3,val_form(a0)	     ; preserve formular

strg_exit
	 movem.l  (sp)+,r_strg
	 moveq	  #0,d0
	 rts

*+++
* put string to cell
*
*		  Entry 		     Exit
*	 d1.l	  c|r of main cell	     preserved
*	 a0				     main value area address (or 0)
*	 a1	  ptr of string 	     preserved
*	 a3	  ptr to formular	     preserved
*
* error codes: err.itnf when a0=0
*---
str_main subr	  d1-d6/a1/a3
	 bsr	  main_fmt
	 moveq	  #0,d5 		     ; d5=main cell value area address
	 moveq	  #0,d4 		     ; d4=current position in string
	 move.w   (a1),d2		     ; d2=string length
	 beq.s	  main_emp

main_lp
	 cmp.w	  (a1),d4
	 bpl.s	  main_exit

	 bsr	  cel_wdth		     ; d3=cell length
	 cmp.w	  d2,d3
	 bmi.s	  main_lb1		     ; is string length > cell length

	 bsr	  str_setv		     ; string fits into cell
	 sub.w	  d3,d2
	 bra.s	  main_lb2

main_lb1
	 exg	  d2,d3
	 bsr	  str_setv		     ; fill string up to cell width
	 bset	  #fw..cont,val_fwrd+1(a0)   ; set continuation flag
	 exg	  d2,d3
	 sub.w	  d3,d2 		     ; new string length

main_lb2
	 tst.l	  d5			     ; main value area
	 bne.s	  main_lb3		     ; ..already exists

	 move.l   a0,d5

main_lb3
	 move.l   a3,val_form(a0)
	 or.w	  d6,val_fwrd(a0)
	 xjsr	  dta_entr		     ; make an entry
	 clr.l	  val_form(a0)
	 xjsr	  rdw_cchg
	 xjsr	  cel_nxtc
	 bmi.s	  main_exit

	 xjsr	  acc_tstf
	 bne.s	  main_lp

main_exit
	 bclr	  #fw..cont,val_fwrd+1(a0)   ; clear continuation flag
	 move.l   d5,a0 		     ; if all went right..
	 tst.l	  d5			     ; ..store string references
	 beq.s	  main_err

	 moveq	  #0,d0
	 move.l   a3,val_form(a0)
	 bra.s	  main_xx

main_err
	 move.l   da_ccell(a6),d1	     ; errors...
	 xjsr	  dta_rmvc		     ; ..clear current cell anyway
	 moveq	  #err.itnf,d0

main_xx
	 tst.l	  d0
	 subend

main_emp
	 move.l   a3,a0
	 xjsr	  dma_free		     ; clear formular
	 xjsr	  rdw_cchg
	 bra.s	  main_exit

main_fmt subr	  a1/d0
	 move.w   da_sword(a6),d6	     ; string format word
	 suba.l   a1,a1
	 xjsr	  acc_getf		     ; get format of cell
	 bmi.s	  mfmt_exit

	 swap	  d0
	 btst	  #fw..strg,d0
	 beq.s	  mfmt_exit

	 move.w   d0,d6 		     ; get previous format

mfmt_exit
	 subend

*+++
* setup value area for a string
*
*		  Entry 		     Exit
*	 d2.w	  current string length      preserved
*	 d4.w	  current string position    updated
*	 a0				     base of value area
*	 a1	  ptr to string 	     preserved
*---
r_setv	 reg	  d1/d2/a1
str_setv
	 movem.l  r_setv,-(sp)
	 moveq	  #val.len,d1		     ; reserve space for va + string
	 add.w	  d2,d1
	 xjsr	  dma_aloc
	 beq.s	  str_setv_ok

	 xjmp	  kill

str_setv_ok
	 move.l   #val.strg,val_real(a0)     ; string has no real value
	 move.w   #val.strg,val_real+4(a0)
	 move.w   da_sword(a6),val_fwrd(a0)  ; string format

	 move.l   a0,-(sp)		     ; copy string
	 adda.w   #val_strg,a0
	 adda.w   d4,a1
	 addq.w   #2,a1
	 move.w   d2,(a0)+
	 bra.s	  setv_end

setv_lp
	 move.b   (a1)+,(a0)+

setv_end
	 dbra	  d2,setv_lp
	 move.l   (sp)+,a0

setv_exit
	 movem.l  (sp)+,r_setv
	 add.w	  d2,d4 		     ; update position
	 rts


*+++
* get the width of one cell in characters
*
*		  Entry 		     Exit
*	 d1.l	  c|r of cell		     preserved
*	 d3.w				     width in characters
*
*---
r_wdth	 reg	  a3/a4
cel_wdth
	 movem.l  r_wdth,-(sp)
	 move.l   da_wwork(a6),a4
	 move.l   ww_pappl(a4),a3	     ; get x spacing list
	 move.l   (a3),a3
	 move.l   wwa_xspc(a3),a3
	 move.l   d1,d3
	 swap	  d3
	 mulu	  #wwm.slen,d3		     ; offset for current column
	 move.w   wwm_size(a3,d3.l),d3
	 subq.w   #2,d3
	 divu	  #qs.xchar,d3		     ; in characters
	 moveq	  #0,d0
	 movem.l  (sp)+,r_wdth
	 rts

	 end
