* Formular Parser				      19/12-91
*	 - action routines

	 include win1_mac_oli
	 include  win1_keys_err
	 include  win1_keys_qlv
	 include  win1_spread_fpars_keys

	 xdef	  prs_actn
	 xdef	  prs_doqa

	 section  pars


r_allv	 reg	  a0/a2-a5/d1-d7
r_allf	 reg	  a1-a5/d1-d7
*+++
* Formular translation action routine
*
*		  Entry 		    Exit
*	 A1   item buffer		    preserved
*	 A5   ptr to parser data area	    preserved
*	 D2.b delimiter code		    preserved
*
*	 D0 < 0 error code set
*	    = 0 no error, scanning continues
*	    > 0 end of parsing
*---

*
* possible parameter comibinations
*
*	 item		   delimiter		      action
* ------------------+--------------------+---------------------------
*	 xxxx		   +,-,^	     place item on stack
*					     put delimiter in list
*					     set immediate special op
*
*	 xxxx		   *,/		     place item on stack
*					     put delimiter in list
*					     set immediate op. pending
*
*	 xxxx/0 	   (		     call function routine
*					     introduce new calc level
*
*	 xxxx		   ),end	     place item on stack
*					     perform current level of calcs
*					     reduce level
*
*	 0		   -		     set immediate special op
*

r_actn	 reg	  a0-a6/d1-d6
prs_actn

	 movem.l  r_actn,-(sp)
	 move.l   a1,a0 		     ; a0=item buffer
	 move.l   pd_ppop(a5),a4	     ; a4=ptr to pending operations
	 move.l   pd_stak(a5),a1	     ; a1=ptr to value stack
	 move.l   pd_plev(a5),a3	     ; a3=ptr to level info list

	 bsr.s	  prs_neg		     ; set negate flag, if needed
	 beq.s	  actn_exit

	 bsr.s	  prs_opbr		     ; introduce new level
	 beq.s	  actn_exit

	 bsr	  prs_pval		     ; put value on stack
	 bne.s	  actn_exit

	 bsr.s	  prs_vneg		     ; negate value, if required
	 bne.s	  actn_exit

	 bsr	  prs_perc		     ; calculate a percentage
	 bmi.s	  actn_exit

	 bsr	  prs_immd		     ; process any immediate ops
	 bne.s	  actn_exit

	 bsr	  prs_clos		     ; special operation close brackets
	 beq.s	  actn_exit

	 bsr.s	  prs_esc		     ; special operation end
	 bne.s	  actn_exit

	 bsr	  prs_optn		     ; process operation code

actn_exit
	 move.l   a4,pd_ppop(a5)	     ; update ptr to pending ops
	 move.l   a1,pd_stak(a5)	     ; update stack ptr
	 move.l   a3,pd_plev(a5)	     ; update level ptr
	 movem.l  (sp)+,r_actn
	 tst.l	  d0
	 rts

*-------------------------------------------------------------------------
* opening braces, introduce new level
prs_opbr
	 moveq	  #1,d0
	 cmpi.b   #cc.open,d2		     ; opening bracket ?
	 bne.s	  opbr_exit

	 bsr	  prs_fn
	 bmi.s	  opbr_exit

	 move.b   #1,lv_oppnd(a3)
	 tst.l	  d0
	 beq.s	  opbr_nlv

	 moveq	  #0,d0
	 rts

opbr_nlv
	 bsr	  prs_nlev		     ; new calc level

opbr_exit
	 rts

*-------------------------------------------------------------------------
* set negate flag, if requried
prs_neg
	 cmpi.b   #op.sub,d2		     ; negative sign ?
	 bne.s	  neg_no

	 tst.w	  (a0)			     ; no item ?
	 bne.s	  neg_no

	 move.b   #1,lv_opneg(a3)

	 tst.b	  lv_oppnd(a3)		     ; prev.op closing bracket?
	 beq.s	  neg_exit

	 move.b   #qa.add,(a4)+ 	     ; place op-code into list
	 addq.w   #1,lv_opcnt(a3)	     ; incr. op-counter
	 clr.b	  lv_oppnd(a3)

neg_exit
	 moveq	  #0,d0 		     ; thats all, folks
	 rts

neg_no
	 moveq	  #1,d0 		     ; nothing happened
	 rts


*-------------------------------------------------------------------------
* negate value, if required
prs_vneg
	 moveq	  #0,d0
	 tst.b	  lv_opneg(a3)
	 beq.s	  vneg_exit

	 clr.b	  lv_opneg(a3)		     ; clear negation flag
	 moveq	  #qa.neg,d0		     ; negate opcode
	 bsr	  prs_doqa		     ; execute it

vneg_exit
	 tst.l	  d0
	 rts


*-------------------------------------------------------------------------
* process special operaction codes (cc.end/cc.clos)

* process cc.end
prs_esc
	 moveq	  #0,d0
	 cmpi.b   #cc.end,d2
	 beq.s	  esc_do

	 cmpi.b   #cc.end1,d2
	 beq.s	  esc_do

	 cmpi.b   #cc.end2,d2
	 bne.s	  esc_exit

esc_do
	 moveq	  #err.iexp,d0		     ; any levels not closed?
	 tst.w	  pd_levc(a5)
	 bne.s	  esc_exit

	 bsr.s	  prs_remn		     ; process remaining operations
	 bne.s	  esc_exit

	 moveq	  #cc.end,d0

esc_exit
	 tst.l	  d0
	 rts

* process all remaining operations
prs_remn
	 moveq	  #0,d0
	 move.w   lv_opcnt(a3),d5
	 bra.s	  remn_end

remn_lp
	 move.b   -(a4),d0		     ; get operation
	 bsr	  prs_doqa
	 bmi.s	  remn_exit		     ; error occured

remn_end
	 dbra	  d5,remn_lp
	 clr.w	  lv_opcnt(a3)

remn_exit
	 tst.l	  d0
	 rts

* cc.clos
prs_clos
	 moveq	  #1,d0
	 cmpi.b   #cc.clos,d2
	 bne.s	  clo_exit

	 moveq	  #err.iexp,d0		     ; any level opened ?
	 tst.w	  pd_levc(a5)
	 beq.s	  clo_exit

	 bsr	  prs_remn		     ; process remaining operations
	 bne.s	  clo_exit

	 subq.w   #1,pd_levc(a5)	     ; back to previous level
	 suba.w   #lv.len,a3
	 bsr.s	  clo_fn		     ; evalute function, if required

clo_exit
	 tst.l	  d0
	 rts

clo_fn
	 moveq	  #0,d0
	 tst.l	  lv_fn(a3)
	 beq.s	  clof_exit

	 bmi.s	  clof_int		     ; internal function

	 movem.l  r_allv,-(sp)
	 move.l   lv_fn(a3),a0		     ; execute external code
	 jsr	  (a0)
	 movem.l  (sp)+,r_allv

clof_exit
	 tst.l	  d0
	 rts

clof_int
	 move.l   lv_fn(a3),d0		     ; get operation code
	 bsr	  prs_doqa		     ; do operation
	 bra.s	  clof_exit


*-----------------------------------------------------------------------
* process operation code
prs_optn
	 cmpi.b   #op.perc,d2
	 beq.s	  no_optn
	 bsr.s	  prs_gtqa		     ; get arithmetic code
	 bmi.s	  optn_exit

	 move.b   d0,(a4)+		     ; place op-code into list
	 addq.w   #1,lv_opcnt(a3)	     ; incr. op-counter

no_optn
	 moveq	  #0,d0

optn_exit
	 rts


*
* get arithmetic code for operator
prs_gtqa subr	  a0/d1
	 moveq	  #0,d0
	 lea	  qalist,a0

gtqa_lp
	 move.b   (a0)+,d0		     ; code
	 move.b   (a0)+,d1		     ; operator
	 beq.s	  gtqa_err

	 cmp.b	  d1,d2
	 bne.s	  gtqa_lp

gtqa_x	 subend

gtqa_err
	 moveq	  #err.nimp,d0
	 bra.s	  gtqa_x


qalist	 dc.b	  qa.add,op.add
	 dc.b	  qa.sub,op.sub
	 dc.b	  qa.mul,op.mul
	 dc.b	  qa.div,op.div
	 dc.b	  qa.pwrf,op.pow
	 dc.b	  qa.and,cp.and
	 dc.b	  qa.or,cp.or
;	  dc.b	   qa.not,cp.not
	 dc.b	  qa.eq,cp.eq
	 dc.b	  qa.gt,cp.gt
	 dc.b	  qa.lt,cp.lt
	 dc.b	  qa.ne,cpc.ne
	 dc.b	  qa.ge,cpc.ge
	 dc.b	  qa.le,cpc.le
	 dc.b	  err.nimp,0

*-----------------------------------------------------------------------
* put item value onto stack
prs_pval
	 moveq	  #0,d0
	 tst.w	  (a0)			     ; any item?
	 beq.s	  pval_exit

	 xbsr	  st_isdcs		     ; is item a decimal number?
	 bne.s	  pval_var

	 subq.w   #6,a1 		     ; get space for value
	 xbsr	  ut_decfp		     ; convert it onto stack
	 beq.s	  pval_exit

	 addq.w   #6,a1 		     ; errors, restore stack

pval_exit
	 tst.l	  d0
	 rts

r_var	 reg	  a2/d1
pval_var
	 movem.l  r_var,-(sp)
	 moveq	  #err.nimp,d0
	 move.l   pd_var(a5),d1 	     ; ptr to variable evaluation
	 beq.s	  var_exit		     ; no external evaluation supplied

	 move.l   d1,a2
	 movem.l  r_allv,-(sp)
	 jsr	  (a2)			     ; execute it
	 movem.l  (sp)+,r_allv

var_exit
	 movem.l  (sp)+,r_var
	 bra.s	  pval_exit

*-----------------------------------------------------------------------
* execute an immediate operation, if pending
r_immd	 reg	  d1
prs_immd movem.l  r_immd,-(sp)

immd_lp
	 moveq	  #0,d0
	 tst.w	  lv_opcnt(a3)		     ; any ops pending?
	 beq.s	  immd_exit

	 cmpi.b   #op.add,d2
	 beq.s	  immd_do

	 cmpi.b   #op.sub,d2
	 beq.s	  immd_do

	 move.b   -1(a4),d1		     ; previous operation
	 cmpi.b   #qa.div,d1
	 beq.s	  immd_do

	 cmpi.b   #qa.mul,d1
	 beq.s	  immd_do

	 cmpi.b   #qa.pwrf,d1
	 beq.s	  immd_do

	 bra.s	  immd_exit

immd_do
	 move.b   -(a4),d0		     ; get current operation
	 bsr.s	  prs_doqa		     ; do arithmetic operation
	 subq.w   #1,lv_opcnt(a3)
	 bra.s	  immd_lp

immd_exit
	 movem.l  (sp)+,r_immd
	 tst.l	  d0
	 rts

; do percentage
prs_perc
	 cmpi.b   #op.perc,d2		     ; percentage symbol?
	 beq.s	  do_perc

	 moveq	  #0,d0
	 rts

do_perc
	 subq.w   #6,a1
	 move.l   12(a1),(a1)
	 move.w   26(a1),4(a1)
	 move.l   #$64000000,-(a1)	     ; put 100 onto stack
	 move.w   #$0807,-(a1)
	 moveq	  #qa.div,d0
	 bsr.s	  prs_doqa
	 bmi.s	  perc_exit

	 moveq	  #qa.mul,d0
	 bsr.s	  prs_doqa

perc_exit
	 rts

*+++
* execute one arithmetic operation
*
*		  Entry 		     Exit
*	 d0.b	  operation		     error code
*	 a1	  stack 		     updated
*
* error codes: err.ovfl, itnf
* condition codes set
*---
r_doqa	 reg	  d1/d2/a2/a6/d7
prs_doqa
	 movem.l  r_doqa,-(sp)
	 moveq	  #0,d7
	 ext.w	  d0
	 bmi.s	  my_doqa

	 move.w   qa.op,a2
	 suba.l   a6,a6
	 exg	  a6,a1
	 jsr	  (a2)
	 adda.l   a6,a1

doqa_x
	 movem.l  (sp)+,r_doqa
	 tst.l	  d0
	 rts

my_doqa  lea	  myqa_tab,a6

my_lp
	 move.w   (a6)+,d1
	 move.w   (a6)+,d2
	 beq.s	  my_nf

	 cmp.b	  d1,d0
	 bne.s	  my_lp

	 adda.w   d2,a6
	 jsr	  (a6)
	 bra.s	  doqa_x

my_nf
	 moveq	  #err.itnf,d0
	 bra.s	  doqa_x

myqa_tab dc.w	  qa.and,my_and-*-4
	 dc.w	  qa.or,my_or-*-4
	 dc.w	  qa.not,my_not-*-4
	 dc.w	  qa.eq,my_eq-*-4
	 dc.w	  qa.gt,my_gt-*-4
	 dc.w	  qa.lt,my_lt-*-4
	 dc.w	  qa.ne,my_ne-*-4
	 dc.w	  qa.ge,my_ge-*-4
	 dc.w	  qa.le,my_le-*-4
	 dc.w	  err.itnf,0

my_and
	 bsr	  tst_ri1
	 beq.s	  and_0

	 bsr	  tst_ri2
	 beq.s	  and_0

and_1
	 adda.w   #12,a1
	 bsr	  push_1
	 bra	  my_x

and_0
	 adda.w   #12,a1
	 bsr	  push_0
	 bra	  my_x

my_or
	 bsr	  tst_ri1
	 bne.s	  and_1

	 bsr	  tst_ri2
	 bne.s	  and_1

	 bra.s	  and_0

my_eq
	 bsr	  do_sub
	 bmi.s	  my_err

	 bsr	  tst_ri1
	 adda.w   #6,a1
	 beq.s	  push_1

	 bra.s	  push_0

my_ne
	 bsr	  do_sub
	 bmi.s	  my_err

	 bsr.s	  tst_ri1
	 adda.w   #6,a1
	 beq.s	  push_0

	 bra.s	  push_1

my_gt
	 bsr	  do_sub
	 bmi.s	  my_err

	 bsr.s	  tst_ri1	    ; not 0!
	 adda.w   #6,a1
	 beq.s	  push_0

	 btst	  #31,-4(a1)
	 bne.s	  push_0

	 bra.s	  push_1

my_lt
	 bsr.s	  do_sub
	 bmi.s	  my_err

	 bsr.s	  tst_ri1	    ; not 0!
	 adda.w   #6,a1
	 beq.s	  push_0

	 btst	  #31,-4(a1)
	 beq.s	  push_0

	 bra.s	  push_1

my_ge
	 bsr.s	  do_sub
	 bmi.s	  my_err

	 bsr.s	  tst_ri1	    ; 0 is ok
	 adda.w   #6,a1
	 beq.s	  push_1

	 btst	  #31,-4(a1)
	 bne.s	  push_0

	 bra.s	  push_1

my_le
	 bsr.s	  do_sub
	 bmi.s	  my_err

	 bsr.s	  tst_ri1	    ; 0 is ok
	 adda.w   #6,a1
	 beq.s	  push_1

	 btst	  #31,-4(a1)
	 beq.s	  push_0

	 bra.s	  push_1

my_not
my_x
	 moveq	  #0,d0

my_err
	 rts

push_1
	 clr.w	  -(a1)
	 move.l   #$08014000,-(a1)
	 rts

push_0
	 clr.w	  -(a1)
	 clr.l	  -(a1)
	 rts

tst_ri1
	 tst.l	  (a1)
	 bne.s	  tri1_x

	 tst.w	  4(a1)

tri1_x
	 rts

tst_ri2
	 tst.l	  6(a1)
	 bne.s	  tri2_x

	 tst.w	  10(a1)

tri2_x
	 rts

do_sub
	 moveq	  #qa.sub,d0
	 bra	  prs_doqa


*+++
* introduce a new parsing level
*
*		  Entry 		     Exit
*	 a3	  level info ptr	     preserved
*
* error codes: err.orng 	    no new level possible
* condition codes set
*---
prs_nlev
	 move.w   pd_levc(a5),d0    ; current level
	 addq.w   #1,d0 	    ; next level
	 cmpi.w   #pd.nlev,d0
	 bhi.s	  nlev_err	    ; no new level possible

	 adda.w   #8,a3 	    ; get to next level
	 clr.w	  lv_opcnt(a3)	    ; no operations
	 clr.w	  lv_oppnd(a3)	    ; no pending/neg ops
	 clr.l	  lv_fn(a3)	    ; no function pointer

	 move.w   d0,pd_levc(a5)    ; next level counter
	 moveq	  #0,d0

nlev_exit
	 tst.l	  d0
	 rts

nlev_err
	 moveq	  #err.orng,d0	    ; level counter out of range
	 bra.s	  nlev_exit

*--------------------------------------------------------------------------------------
* function finding

r_fn	 reg	  a0/a2/a3/d5
prs_fn
	 tst.w	  (a0)		    ; any name supplied
	 beq.s	  fn_nof

	 movem.l  r_fn,-(sp)
	 move.l   a1,d5
	 lea	  fn_tab,a1

fn_lp
	 tst.w	  (a1)		    ; end of table ?
	 bmi.s	  fn_extn	    ; ..try external

	 bsr	  fn_comp	    ; compare string
	 beq.s	  fn_ok

	 addq.l   #ift.len,a1	    ; next entry
	 bra.s	  fn_lp

fn_ok
	 move.w   #-1,lv_fn(a3) 	     ; make level info entry
	 move.w   ift_qaop(a1),lv_fn+2(a3)
	 moveq	  #0,d0

fn_exit
	 move.l   d5,a1
	 movem.l  (sp)+,r_fn
	 tst.l	  d0
	 rts

fn_nof
	 clr.l	  lv_fn(a3)	    ; no function
	 moveq	  #0,d0
	 rts

;-------------- external function lookup ----------------------------
fn_extn
	 moveq	  #err.nimp,d0	    ; external function
	 move.l   pd_pfn(a5),d1
	 beq.s	  fn_exit	    ; no external table supllied

	 move.l   d1,a1 	    ; function table

xfn_lp
	 tst.w	  (a1)
	 bmi.s	  fn_exit

	 bsr	  fn_comp
	 beq.s	  xfn_ok

	 adda.w   #xft.len,a1	    ; next entry
	 bra.s	  xfn_lp

xfn_ok
	 move.l   xft_fn(a1),d3     ; rel. ptr to function code
	 add.l	  a1,d3 	    ; make it absolute..
	 add.l	  #xft_fn,d3	    ; ..to its position

	 move.w   xft_args(a1),d1
	 beq.s	  xfn_strg	    ; no arguments.. call directly

	 subq.w   #1,d1
	 bne.s	  fn_exit	    ; more than one.. error!

	 move.l   xft_fn(a1),d3     ; rel. ptr to function code
	 add.l	  a1,d3 	    ; make it absolute..
	 add.l	  #xft_fn,d3	    ; ..to its position
	 move.l   d3,lv_fn(a3)
	 moveq	  #0,d0
	 bra.s	  fn_exit

xfn_strg
	 bsr.s	  xfn_newp
	 bmi	  fn_exit

	 move.l   d5,a1 	    ; top of stack
	 move.l   d3,a2 	    ; address of routine
	 movem.l  r_allv,-(sp)
	 jsr	  (a2)
	 movem.l  (sp)+,r_allv
	 tst.l	  d0
	 bmi	  fn_exit

	 move.l   a1,d5
	 moveq	  #1,d0
	 bra	  fn_exit


xfn_newp
	 moveq	  #1,d0
	 move.w   pd_ppos(a5),d1    ; current parsing position
	 move.l   pd_fstr(a5),a0    ; in formular

np_lp
	 addq.w   #1,d1
	 move.b   1(a0,d1.w),d2
	 cmpi.b   #cc.end,d2
	 beq.s	  np_e

	 cmpi.b   #cc.open,d2
	 bne.s	  np_no

	 addq.w   #1,d0

np_no
	 cmpi.b   #cc.clos,d2
	 bne.s	  np_lp

	 subq.w   #1,d0
	 bne.s	  np_lp

np_e
	 move.w   pd_ppos(a5),d2    : position of user string
	 move.w   d1,pd_ppos(a5)    ; this is the new parsing position
	 sub.w	  d2,d1 	    ; now it's the user string length
	 subq.w   #1,d1

newp_exit
	 rts


fn_tab
	 dc.w	  3,'abs ',qa.abs
	 dc.w	  3,'cos ',qa.cos
	 dc.w	  3,'sin ',qa.sin
	 dc.w	  3,'tan ',qa.tan
	 dc.w	  3,'cot ',qa.cot
	 dc.w	  4,'asin',qa.asin
	 dc.w	  4,'acos',qa.acos
	 dc.w	  4,'atan',qa.atan
	 dc.w	  4,'acot',qa.acot
	 dc.w	  4,'sqrt',qa.sqrt
	 dc.w	  2,'ln  ',qa.ln
	 dc.w	  3,'log ',qa.log10
	 dc.w	  3,'exp ',qa.exp
	 dc.w	  ift.end

r_comp	 reg	  a2/a6/d2
fn_comp
	 movem.l  r_comp,-(sp)
	 suba.l   a6,a6
	 moveq	  #1,d0 	    ; case independent compare
	 moveq	  #0,d2
	 move.w   ut.cstr,a2
	 jsr	  (a2)
	 movem.l  (sp)+,r_comp
	 rts


	 end
