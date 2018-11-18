* Formular Parser				      19/12-91
*	 - entry point

*
* Development History:
*
* v 1.00 - first version
* v 1.01 03/06-92
*	 - no parser info area required
*	 - works with "real" QDOS strings
* v 1.02 18/08-94
*	 - error with lists of calculations removed

	 include  win1_spread_fpars_keys
	 include  win1_mac_oli
	 include  win1_keys_err

	 xdef	  prs_form

	 section  pars

*+++
* Entry point to formular parser
*
*		  Entry 		    Exit
*	 A0	  ptr to formula	     preserved
*	 A1	  ptr to top of stack	     preserved
*	 A2	  ptr to external fn's       preserved
*	 A3	  ptr to var. evaluation     preserved
*	 D1	  parsing position start     updated
*
*	 D0 error code set
*---
f_form	 equ	  pd.len		     ; stack frame for working space
r_form	 reg	  a0-a6/d2-d6
prs_form
	 movem.l  r_form,-(sp)
	 suba.w   #f_form,sp		     ; frame stack for workspace
	 move.l   sp,a5 		     ; a5=parser data area
	 bsr.s	  prs_init
 bra.s form_nxt
	moveq	#0,d2		; bracket count
	move.l	pd_fstr(a5),a0
	move.w	(a0)+,d3	; length of formula
	beq.s	form_nxt	; definitely no brackets inside!
	subq.w	#1,d3
bracket_loop
	moveq	#'(',d4
	sub.b	(a0)+,d4	; open bracket?
	beq.s	open_bracket
	addq.b	#1,d4		; close bracket?
	beq.s	clos_bracket
	sub.b	#18,d4		; or special "IF" end marker ";"
	beq.s	clos_bracket
bracket_next
	dbra	d3,bracket_loop
	tst.w	d2		; all brackets matched?
	beq.s	form_nxt	; fine, carry on
bracket_err
	moveq	#err.iexp,d0	; treat as string
	bra.s	form_exit
open_bracket
	addq.w	#1,d2		; another open bracket
	bra.s	bracket_next
clos_bracket
	subq.w	#1,d2		; another close bracket
	bmi.s	bracket_err	; oops!
	bra.s	bracket_next

*	 xjsr	 pma_init		     ; !!! initialise monitor

form_nxt
	 move.l   pd_fstr(a5),a0	     ; formular string address
	 lea	  pd_buff(a5),a1	     ; item buffer
	 move.w   pd_ppos(a5),d1	     ; parsing position

	 xbsr	  prs_item		     ; try to get one item
	 bne.s	  form_exit		     ; error occurd during scanning

	 move.w   d1,pd_ppos(a5)	     ; update parsing position
*	 xjsr	 pma_item		     ; !!! monitor item
	 xbsr	  prs_actn		     ; do action
*	 xjsr	 pma_stak		     ; !!! monitor stack
*	 xjsr	 pma_ops		     ; !!! monitor operations
	 tst.l	  d0
	 bmi.s	    form_exit		       ; error during interpretation

	 beq.s	  form_nxt

	 moveq	  #0,d0

form_exit
*	 xjsr	 pma_clos		     ; !!! close monitor pipe
	 tst.l	  d0
	 adda.w   #f_form,sp		     ; reframe stack pointer
	 movem.l  (sp)+,r_form
	 rts

*--------------------------------------------------------------------------
* initialise parser info area
r_init	 reg	  d1/a0
prs_init
	 movem.l  r_init,-(sp)
	 move.l   a0,pd_fstr(a5)	     ; store call parameters
	 move.l   a1,pd_stak(a5)
	 move.l   a2,pd_pfn(a5)
	 move.l   a3,pd_var(a5)
	 move.w   d1,pd_ppos(a5)

	 move.w   (a0),d1		     ; place end code
	 move.b   #cc.end,2(a0,d1.w)

	 lea	  pd_popl(a5),a0	     ; pending operator list
	 move.l   a0,pd_ppop(a5)

	 lea	  pd_levl(a5),a0	     ; ptr to level ops counter list
	 move.l   a0,pd_plev(a5)
	 move.w   #0,pd_levc(a5)	     ; clear new level
	 clr.l	  lv_opcnt(a0)
	 clr.l	  lv_fn(a0)

	 movem.l  (sp)+,r_init
	 rts


	 end
