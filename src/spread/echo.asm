* Spreadsheet					      08/06-92
*	 - echo function

	 include  win1_mac_oli
	 include  win1_spread_keys

	 section  prog

	 xdef	  act_echo,ech_cact

;+++
; echo action routine
;
;	 d5.l	  c|r of home cell
;---
act_echo subr	  d1-d5/a0-a3/a5
	 addq.w   #1,da_dupdt(a6)
	 lea	  ech_cact,a5
	 xjsr	  mul_blok		     ; execute cell echo function
	 subq.w   #1,da_dupdt(a6)
	 xjsr	  rdw_grid
	 moveq	  #0,d0
	 subend


* cell action routine
ech_cact subr	  d1/d2/d3
	 move.l   d1,d2 		     ; echo cell (new posn)
	 move.l   d5,d1
	 lea	  da_echf(a6),a1	     ; formula buffer
	 xjsr	  acc_getf
	 move.l   d0,d3
	 swap	  d3			     ; d3.w = format word
	 tst.w	  d0
	 bne.s	  cact_na		     ; no adjustment needed for strings

	 lea	  da_echf(a6),a0
	 lea	  da_echs(a6),a1
	 lea	  da_echl(a6),a2
	 xjsr	  cel_fref		     ; find references
	 bsr.s	  ech_refl		     ; adj. reference list
	 xjsr	  cel_rref		     ; resolve references

cact_na
	 lea	  da_echf(a6),a1	     ; put cell into grid
	 move.l   d2,d1
	 xjsr	  acc_putf
	 move.w   d3,d2
	 xjsr	  acc_fwrd		     ; set format word

cact_exit
	 moveq	  #0,d0
	 subend

;+++
; adjust reference list for echo
;
;		  Entry 		     Exit
;	 d1	  home cell (old posn)
;	 d2	  echo cell (new posn)
;	 a2	  ptr to ref. list (end -1.l)
;+++
ech_refl subr	  a2/d1-d4
	 move.l   d2,d4 		     ; d4=new posn.

refl_lp
	 move.l   (a2),d2		     ; get vicinity cell
	 bmi.s	  refl_exit

	 bsr.s	  cel_rpos		     ; get relative posn
	 exg	  d1,d4
	 bsr.s	  cel_apos		     ; make posn abs to new cell
	 exg	  d1,d4
	 move.l   d2,(a2)+		     ; store new posn
	 bra.s	  refl_lp

refl_exit
	 subend

;+++
; calculate relative position
;
;	 d1.l	  base cell			  preserved
;	 d2.l	  vicinity cell 	     d2.l offset from base cell
;---
cel_rpos subr	  d1
	 sub.w	  d1,d2
	 swap	  d1
	 swap	  d2
	 sub.w	  d1,d2
	 swap	  d2
	 subend

;+++
; calculate absolute position
;
;	 d1.l	  base cell			      preserved
;	 d2.l	  offset			      vicinity cell
;---
cel_apos subr	  d1
	 add.w	  d1,d2
	 swap	  d1
	 swap	  d2
	 add.w	  d1,d2
	 swap	  d2
	 subend

	 end
