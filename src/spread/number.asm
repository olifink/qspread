* Spreadsheet					      13/01-92
*	 - data processing routines

	 section  prog

	 include  win1_keys_wman
	 include  win1_keys_wstatus
	 include  win1_keys_wwork
	 include  win1_keys_err
	 include  win1_mac_oli
	 include  win1_spread_keys
	 include  win1_spread_fparser_keys

	 xdef	  prc_data,prc_fpar
	 xdef	  cel_calc,cel_clcs

	 xref.l   mv_fnwd,mv_fnfm

*+++
* recalculate one numeric cell
*
*		  Entry 		     Exit
*	 a4	  wwork 		     preserved
*	 d1.l	  c|r of cell		     preserved
*---
r_calc	 reg	  a3
cel_calc
	 movem.l  r_calc,-(sp)
	 xjsr	  in_grid
	 bne.s	  calc_bye
	 xjsr	  dta_madr		     ; get address of cell
	 move.l   wwm_pobj(a3),d0	     ; get connected object
	 beq.s	  calc_exit		     ; ..cell is empty, fine
	 sub.l	  #val_strg,d0
	 move.l   d0,a3
	 move.l   val_form(a3),d0	     ; get pointer to formular
	 beq.s	  calc_exit		     ; ..no formular, fine
	 btst	  #fw..strg,val_fwrd(a3)     ; is it string?
	 bne.s	  calc_exit		     ; ..yes, nothing to calc
	 move.l   d0,a3
	 move.l   d1,da_ccell(a6)
	 bsr.s	  prc_data
calc_exit
	 movem.l  (sp)+,r_calc
	 rts
calc_bye moveq	  #0,d0
	 bra.s	  calc_exit

*+++
* recalculate one cell (strings too!)
*
*		  Entry 		     Exit
*	 a4	  wwork 		     preserved
*	 d1.l	  c|r of cell		     preserved
*---
r_clcs	 reg	  a3
cel_clcs
	 movem.l  r_clcs,-(sp)
	 xjsr	  dta_madr		     ; get address of cell
	 move.l   wwm_pobj(a3),d0	     ; get connected object
	 beq.s	  calc_exit		     ; ..cell is empty, fine
	 sub.l	  #val_strg,d0
	 move.l   d0,a3
	 move.l   val_form(a3),d0	     ; get pointer to formular
	 beq.s	  calc_exit		     ; ..no formular, fine
	 move.l   d0,a3
	 move.l   d1,da_ccell(a6)
	 bsr.s	  prc_data
clcs_exit
	 movem.l  (sp)+,r_clcs
	 rts

*+++
* process cell formular (da_ccell must have been set!)
*
*		  Entry 		     Exit
*	 a3	  address of formular string preserved
*	 a4	  wwork 		     preserved
*
* error codes:
* condition codes set
*---
r_data	 reg	  d1/d2/a3/a4
prc_data
	 move.l   da_ccell(a6),d1	     ; set current cell
	 cmpi.b   #'"',2(a3)		     ; is it a string constant
	 beq.s	  pd_isst

;;;	    bsr      dta_sref			;XX reference to string?
;;;	    beq.s    pd_exit			;XX
skip
	 xjsr	  dta_stfn		     ; is it a string function
	 bne.s	  pd_nosf
	 jsr	  (a2)			     ; execute string code
	 move.l   da_wmvec(a6),a2
	 beq.s	  pd_exit
pd_nosf
	 bsr.s	  data_num		     ; try to process numeric formula
	 beq.s	  pd_exit
pd_mkst
	 movem.l  a0/d1/d2,-(sp)	     ; numeric error??
	 move.l   a3,a0 		     ; assume text string
	 moveq	  #0,d1
	 moveq	  #'"',d2
	 xjsr	  st_insc
	 movem.l  (sp)+,a0/d1/d2
pd_isst
	 xjsr	  prc_strg
pd_exit
	 moveq	  #0,d0
	 rts

;
; reference to string function?
dta_sref subr	  a0-a4/d1-d4

	 move.l   a3,a1
	 xjsr	  con_strc		     ; try to get location
	 bne.s	  sref_exit		     ; ..failed
	 xjsr	  in_grid		     ; inside the grid
	 bne.s	  sref_exit
	 lea	  da_buff(a6),a1	     ; I don't need the formula
	 xjsr	  acc_getf		     ; just wanna know the type
	 beq.s	  sref_num		     ; .. nope, wrong (number)
	 move.l   da_ccell(a6),d1
	 xjsr	  acc_putf
	 moveq	  #0,d0
sref_exit tst.l   d0
	subend
sref_num moveq	  #-1,d0
	 bra.s	  sref_exit

;
; process a numeric formula
data_num
	 movem.l  r_data,-(sp)
	 bsr.s	  prc_form		     ; process standard formular
	 bmi.s	  data_exit
	 xjsr	  dta_entr		     ; connect with cell
	 xjsr	  rdw_cchg		     ; redraw cell
data_exit
	 movem.l  (sp)+,r_data
	 tst.l	  d0
	 rts

*+++
* process standard formular
*
*		  Entry 		     Exit
*	 a0				     ptr to value block
*	 a3	  ptr to formular	     preserved
*
* error codes: err.imem / err.orng / err.iexp
* condition codes set
*---
r_form	 reg	  d1/a2/a1
prc_form
	 movem.l  r_form,-(sp)

	 bsr	  prc_fpar		     ; call formular parser
	 cmpi.l   #err.ovfl,d0
	 beq.s	  form_ovfl

	 tst.l	d0			     ; we must test again
	 bmi.s	  form_exit

	 bsr	  prc_round		     ; round number on the stack
	 bmi.s	  form_exit

	 bsr.s	  prc_lfmt		     ; set last cell format
	 bsr	  prc_fmtn		     ; format number
	 bmi.s	  form_exit
form_set
	 move.w   (a1),d1		     ; get space for value block
	 add.w	  #val.len,d1
	 ext.l	  d1
	 xjsr	  dma_aloc
	 bmi.s	  form_exit

	 move.l   da_buff+da.buff-6(a6),val_real(a0)  ; set real value
	 move.w   da_buff+da.buff-2(a6),val_real+4(a0)
	 move.l   a3,val_form(a0)	     ; set ptr to formular
	 move.w   da_lform(a6),val_fwrd(a0)  ; set format word

	 move.l   a0,a2 		     ; set contents string
	 lea	  val_strg(a2),a0
	 xjsr	  ut_cpyst
	 move.l   a2,a0

form_exit
	 movem.l  (sp)+,r_form
	 tst.l	  d0
	 rts


form_ovfl
	 clr.l	  da_buff+da.buff-6(a6)
	 clr.w	  da_buff+da.buff-2(a6)
	 xlea	  met_ovfl,a1
	 bra.s	  form_set


*
* set format according to current cell contents
r_lfmt	 reg	  d0-d2/a3
prc_lfmt
	 movem.l  r_lfmt,-(sp)
	 move.l   da_ccell(a6),d1
	 move.w   da_fword(a6),d2	     ; global format
	 xjsr	  dta_vadr
	 bmi.s	  lfmt_set		     ; no current value
	 move.w   val_fwrd(a3),d0
	 btst	  #fw..strg,d0		     ; string.. no use
	 bne.s	  lfmt_set
	 move.w   d0,d2 		     ; reuse old format
lfmt_set
	 move.w   d2,da_lform(a6)
	 movem.l  (sp)+,r_lfmt
	 rts



*+++
* invoke formular parser
*
*		  Entry 		     Exit
*	 a3	  ptr to formular	     preserved
*
* error codes: err.iexp    some parsing errors
* condition codes: preserved
*---
prc_fpar subr	  a0-a4/d1-d3
	 move.l   a3,a0 		     ; ptr to formula
	 lea	  da_buff(a6),a1	     ; (buffer area)
	 add.w	  #da.buff,a1		     ; top of stack
	 xlea	  tab_fn,a2		     ; external function table
	 xlea	  var_eval,a3		     ; variable evaluation
	 moveq	  #0,d1 		     ; parsing position
	 xjsr	  prs_form		     ; invoke parser
	 tst.l	  d0
	 subend

*+++
* round number on the stack
*
*---
prc_round subr	  a1
	 move.w   da_round(a6),d0
	 beq.s	  round_exit

	 lea	  da_buff+da.buff-6,a1
	 xjsr	  ut_round
round_exit
	 tst.l	  d0
	 subend


*+++
* format the number held on top of the stack
*
*		  Entry 		     Exit
*	 a1				     ptr to formatted number
*
* condition codes set
*---
r_fmtn	 reg	  a0/a2/d1/d2
prc_fmtn
	 movem.l  r_fmtn,-(sp)
	 lea	  da_buff+da.buff-6(a6),a1   ; top of stack
	 lea	  da_buff(a6),a0	     ; buffer space

	 bsr.s	  fmtn_ez		     ; empty when zero ?
	 beq.s	  fmtn_ok

	 bsr	  fmtn_es		     ; empty when same as above?
	 beq.s	  fmtn_ok
	 moveq	  #0,d0

	 xjsr	  ut_fpdec
	 bmi.s	  fmtn_exit
	 trap #$e
	 xjsr	  st_xpnde		     ; expand exponetial form

	 moveq	  #1,d1 		     ; still exponential form?
	 moveq	  #'E',d2
	 xjsr	  st_findc
	 beq.s	  fmtn_ok		     ; no further formatting

	 moveq	  #0,d0
	 tst.w	  da_dofmt(a6)		     ; format number anyway?
	 beq.s	  fmtn_ok

	 move.l   a0,a1 		     ; a1=decimal number
	 move.w   (a1),d0
	 addq.w   #1,d0
	 bclr	  #0,d0
	 lea	  2(a1,d0.w),a2 	     ; a2=buffer space

	 move.w   da_lform(a6),mv_fnwd(a6)
	 xjsr	  fnm_updt		     ; update format
	 move.w   mv_fnwd(a6),d1	     ; local german format
	 lsr.w	  #fw..germ,d1
	 andi.w   #1,d1
	 lea	  mv_fnfm(a6),a0	     ; a0=local format string
fmtn_fmt

	 xjsr	  ut_fnumb		     ; format the number
	 moveq	  #0,d0
	 move.l   a2,a0
	 xjsr	  st_dllsp		     ; delete leading spaces
fmtn_ok
	 bsr.s	  fmtn_msy		     ; insert monetary symbol
	 move.l   a0,a1
	 bsr	  prc_nwdt		     ; test length of number
fmtn_exit
	 movem.l  (sp)+,r_fmtn
	 tst.l	  d0
	 rts

fmtn_ez
	 move.l   (a1),d0
	 add.w	  4(a1),d0
	 add.w	  da_emptz(a6),d0
	 bne.s	  ez_exit
	 move.w   d0,(a0)
ez_exit
	 tst.l	  d0
	 rts
;
; empty cell, if it has the same value, as the cell above
fmtn_es
	 tst.w	  da_esame(a6)		     ; empty is same selected?
	 beq.s	  es_no

	 move.l   da_ccell(a6),d1	     ; get cell number of prev. cell
	 subq.w   #1,d1
	 xjsr	  in_grid
	 bne.s	  es_no
	 xjsr	  var_isv		     ; has it a value?
	 bne.s	  es_no

	 xjsr	  var_val		     ; now get it's value
	 addq.w   #6,a1

	 move.l   (a1),d0		     ; test if it is the same
	 sub.l	  -6(a1),d0
	 bne.s	  es_no
	 move.w   4(a1),d0
	 sub.w	  -2(a1),d0
	 bne.s	  es_no

	 move.w   d0,(a0)		     ; make it a null string
	 bra.s	  es_exit
es_no
	 moveq	  #-1,d0		     ; it's not the same!
es_exit
	 rts


r_msy	 reg	  d0-d2/a1-a3
fmtn_msy
	 movem.l  r_msy,-(sp)
	 move.w   da_lform(a6),d0	     ; current format
	 rol.w	  #4,d0
	 andi.w   #%111,d0		     ; symbol 0 ... nothing
	 beq.s	  msy_exit

	 xlea	  arr_msym,a1		     ; here is the array
	 mulu	  8(a1),d0		     ; entry offset
	 add.l	  (a1),a1		     ; get absolute address
	 add.w	  d0,a1 		     ; finally the string
	 tst.w	  (a0)
	 beq.s	  msy_exit

	 move.l   a0,-(sp)
	 move.w   (a0),d0		     ; copy monetary sybol
	 addq.w   #3,d0
	 bclr	  #0,d0
	 add.w	  d0,a0
	 xjsr	  ut_cpyst

	 move.w   (a0),d1		     ; insert space
	 moveq	  #' ',d2
	 jsr	  st_insc

	 move.l   (sp)+,a1
	 xjsr	  st_appst		     ; append the number

msy_exit
	 movem.l  (sp)+,r_msy
	 rts

*+++
* test if number fits into current cell
*
*		  Entry 		     Exit
*	 a1	  ptr to string 	     preserved
*---
r_nwdt	 reg	  a0/d1/d2/d3
prc_nwdt
	 movem.l  r_nwdt,-(sp)
	 move.l   da_ccell(a6),d1	     ; get cell position
	 xjsr	  cel_wdth
	 cmp.w	  (a1),d3
	 bge.s	  nwdt_exit		     ; it would fit
	 move.l   a1,a0
	 moveq	  #'*',d1
	 move.w   d3,d2
	 xjsr	  st_filst		     ; fill it with stars
nwdt_exit
	 movem.l  (sp)+,r_nwdt
	 rts



	 end
