* Spreadsheet					      09/12-91
*	 -  conversion routines
*

	 section  prog

	 include  win1_keys_err
	 include  win1_keys_qlv
	 include  win1_mac_oli
	 include  win1_spread_keys

	 xdef	  con_wdec
	 xdef	  con_decw
	 xdef	  con_wasc
	 xdef	  con_cstr
	 xdef	  con_strc
	 xdef	  con_rnge
	 xdef	  con_ckor		     ; check cell block orientation
	 xdef	  con_r2mx		     ; convert range string to block matrix numbers
	 xdef	  in_grid
	 xdef	  in_used


*+++
* convert range string to top-left-cell and bottom-right-cell
*
*		  Entry 		     Exit
*	 a0	  ptr to characters	     preserved
*	 d1	  length of string	     top-left-cell (or -1)
*	 d2				     bottom-right-cell (or -1)
*
* error codes: err.ipar 	    wrong range string
* condition codes set
*---
f_r2mx	 equ	  $10
r_r2mx	 reg	  a0-a2/d3-d5
con_r2mx
	 movem.l  r_r2mx,-(sp)
	 suba.w   #f_r2mx,sp		     ; get string space on stack
	 move.l   sp,a1
	 move.l   a1,a2

	 moveq	  #-1,d4		     ; top-left-matrix number
	 moveq	  #-1,d5		     ; bottom-right-matrix number

	 move.w   d1,(a2)+		     ; maximum length
	 moveq	  #0,d3 		     ; top-left length count
	 bra.s	  r2mx_end

r2mx_lp
	 move.b   (a0)+,d0
	 cmpi.b   #':',d0
	 beq.s	  r2mx_1st

	 move.b   d0,(a2)+
	 addq.w   #1,d3

r2mx_end
	 dbra	  d1,r2mx_lp

r2mx_1st
	 move.w   d3,(a1)
	 move.w   d1,d3
	 bsr.s	  con_strc		     ; convert string
	 bne.s	  r2mx_exit

	 move.l   d1,d4
	 move.w   d3,d1
	 bmi.s	  r2mx_exit		     ; no more chars available

	 moveq	  #0,d3
	 move.l   a1,a2
	 move.w   d1,(a2)+
	 bra.s	  r2mx_en2

r2mx_lp2
	 move.b   (a0)+,(a2)+
	 addq.w   #1,d3

r2mx_en2
	 dbra	  d1,r2mx_lp2
	 move.w   d3,(a1)
	 bsr.s	  con_strc
	 bne.s	  r2mx_exit

	 move.l   d1,d5

r2mx_exit
	 move.l   d4,d1
	 move.l   d5,d2
*	  bsr	   con_ckor		      ; check orientation
	 adda.w   #f_r2mx,sp
	 movem.l  (sp)+,r_r2mx
	 moveq	  #0,d0
	 rts


*+++
* check orientation of range
*
*		  Entry 		     Exit
*	 d1	  start-of-block	     top-left-cell
*	 d2	  end-of-block		     bottom-right-cell
*---
con_ckor
	 move.l   d3,-(sp)
	 cmp.l	  d1,d2
	 beq.s	  ckor_one

	 tst.l	  d1
	 bmi.s	  ckor_exit

	 tst.l	  d2
	 bmi.s	  ckor_one

	 cmp.w	  d1,d2
	 bpl.s	  ckor_rok

	 move.w   d1,d3
	 move.w   d2,d1
	 move.w   d3,d2

ckor_rok
	 swap	  d1
	 swap	  d2
	 cmp.w	  d1,d2
	 bpl.s	  ckor_exit

	 move.w   d1,d3
	 move.w   d2,d1
	 move.w   d3,d2
	 swap	  d1
	 swap	  d2

ckor_exit
	 move.l   (sp)+,d3
	 rts

ckor_one
	 moveq	  #-1,d2
	 bra.s	  ckor_exit


*+++
* get cell matrix number from location string
*
*		  Entry 		     Exit
*
*	 d1.l				     matrix number
*	 a1	  ptr to string 	     preserved
*
* error codes: err.nc	   not a valid location
* condition codes set
*---
r_strc	 reg	  a1/d2-d5
con_strc
	 movem.l  r_strc,-(sp)
	 moveq	  #0,d4
	 tst.w	  (a1)
	 beq.s	  strc_error

	 bsr.s	  absx
	 moveq	  #0,d4 		     ; assume first cell

	 move.w   (a1)+,d3
	 beq.s	  strc_error		     ; no string was given

;;;	    moveq    #err.nc,d0
	 moveq	  #1,d5 		     ; d5=muliplicator

strc_n
	 move.b   -1(a1,d3.w),d1	     ; get last character
	 andi.w   #$FF,d1
	 xjsr	  st_isuic		     ; is it unsigned integer
	 bne.s	  strc_s

	 subi.b   #'0',d1

	 mulu	  d5,d1 		     ; get it's positional value
	 add.w	  d1,d4
	 mulu	  #10,d5		     ; next multiplicator
	 subq.w   #1,d3
	 beq.s	  strc_ok
;;;	    beq.s    strc_error     ; for string references!!!

	 bra.s	  strc_n

strc_s
	 swap	  d4
	 moveq	  #1,d5 		     ; alpha multiplicator

strc_ss
	 move.b   -1(a1,d3.w),d1
	 andi.w   #$ff,d1
	 bset	  #5,d1 		     ; make it lower case
	 xjsr	  st_isalc		     ; is it lower alpha character
	 bne.s	  strc_exit

	 subi.b   #'a'-1,d1
	 mulu	  d5,d1
	 add.w	  d1,d4
	 mulu	  #26,d5
	 subq.w   #1,d3
	 bne.s	  strc_ss

	 subq.w   #1,d4
	 swap	  d4

strc_ok
	 moveq	  #0,d0
	 subq.w   #1,d4
	 move.l   d4,d1
	 bsr.s	  chk_rnge

strc_exit
	 movem.l  (sp)+,r_strc
	 tst.l	  d0
	 rts

strc_error
	 moveq	  #err.nc,d0
	 bra.s	  strc_exit


absx	 subr	  a0/d0
	 move.l   a1,a0
	 lea	  da_var+2(a6),a1	     ; copy variable name
	 move.w   (a0)+,d1
	 bra.s	  var_lpe

var_lp
	 move.b   (a0)+,d0
	 cmpi.b   #91,d0		     ; skip absolute indicators
	 beq.s	  var_lpe

	 cmpi.b   #93,d0
	 beq.s	  var_lpe

	 move.b   d0,(a1)+

var_lpe
	 dbra	  d1,var_lp
	 lea	  da_var(a6),a0
	 move.l   a1,d0 		     ; calculate new string length
	 sub.l	  a0,d0
	 sub.w	  #2,d0
	 move.w   d0,(a0)
	 move.l   a0,a1
	 subend

;
; check id cell d1 is in grid
; (otherwise return err.orng)
in_grid
chk_rnge
	 move.l   d1,-(sp)
	 moveq	  #0,d0
	 tst.w	  d1
	 bmi.s	  schk_err

	 swap	  d1
	 tst.w	  d1
	 bmi.s	  schk_err

	 swap	  d1
	 add.l	  #$00010001,d1
	 sub.w	  da_nrows(a6),d1
	 bgt.s	  schk_err

	 swap	  d1
	 sub.w	  da_ncols(a6),d1
	 bgt.s	  schk_err

schk_exit
	 move.l   (sp)+,d1
	 tst.l	  d0
	 rts

in_used
	 move.l   d1,-(sp)
	 moveq	  #0,d0
	 tst.w	  d1
	 bmi.s	  schk_err

	 swap	  d1
	 tst.w	  d1
	 bmi.s	  schk_err

	 swap	  d1
;;;	    add.l    #$00010001,d1
	 sub.w	  da_usedy(a6),d1
	 bgt.s	  schk_err

	 swap	  d1
	 sub.w	  da_usedx(a6),d1
	 bgt.s	  schk_err

	 bra.s	  schk_exit

schk_err
	 moveq	  #err.orng,d0
	 bra.s	  schk_exit

*+++
* create cell range string
*
*		  Enrty 		     Exit
*	 A1	  ptr to string 	     preserved
*	 D1.l	  c|r of top left (or -1)    preserved
*	 D2.l	  c|r of bottom right (or -1)preserved
*---
f_rnge	 equ	  8			     ; stack frame
r_rnge	 reg	  d1-d2/a0-a2
con_rnge
	 movem.l  r_rnge,-(sp)
	 move.l   a1,a2 		     ; remember string adress
	 move.w   #0,(a1)		     ; clear string, in case
	 tst.l	  d1			     ; test if cell is marked
	 bmi.s	  rnge_exit		     ; oops, no block marked

	 bsr.s	  con_cstr		     ; convert to cell string
	 move.l   d2,d1 		     ; test for marked block
	 bmi.s	  rnge_exit		     ; no block marked, that's it

	 xlea	  met_sept,a0		     ; put range seperator..
	 bsr	  ut_catst		     ; ..behind first reference

	 suba.l   #f_rnge,sp		     ; get some space on stack
	 move.l   sp,a1 		     ; this is our string buffer
	 bsr.s	  con_cstr		     ; convert 2nd reference
	 move.l   a1,a0 		     ; concat. buffer..
	 move.l   a2,a1 		     ; ..to range string
	 bsr	  ut_catst
	 adda.l   #f_rnge,sp		     ; reframe stack pointer

rnge_exit
	 movem.l  (sp)+,r_rnge
	 rts

*+++
* cell number to string
*
*		  Entry 		     Exit
*	 D1.l	  c|r cell number	     preserved
*	 A1.l	  address of string	     preserved
*---
r_cstr	 reg	  d1/a0-a2
f_cstr	 equ	  20			     ; stack frame
con_cstr
	 movem.l  r_cstr,-(sp)
	 suba.l   #f_cstr,sp
	 move.l   sp,a0 		     ; our buffer
	 addi.l   #$00010001,d1 	     ; start counting at 1
	 move.l   d1,d0
	 swap	  d0			     ; cell number
	 bsr.s	  con_wasc		     ; convert to ascii string
	 bsr.s	  cstr_cpy		     ; copy string
	 move.w   d1,d0
	 bsr.s	  con_wdec		     ; convert to decimal
	 bsr	  ut_catst		     ; concat. both strings
	 adda.l   #f_cstr,sp		     ; reframe stack
	 movem.l  (sp)+,r_cstr
	 rts

cstr_cpy				     ; copy subroutine
	 movem.l  a0-a2,-(sp)
	 move.l   a0,a2 		     ; swap a0<->a1
	 move.l   a1,a0
	 move.l   a2,a1
	 xjsr	  ut_cpyst		     ; copy string
	 movem.l  (sp)+,a0-a2		     ; get old values back
	 rts

*+++
* integer word to decimal string
*
*		  Entry 		     Exit
*	 D0.w	  integer number	     preserved
*	 A0	  address of string	     preserved
*---
r_wdec	 reg	  d0/a1
f_wdec	 equ	  6
con_wdec
	 movem.l  r_wdec,-(sp)
	 suba.w   #f_wdec,sp		     ; room on the stack
	 move.l   sp,a1
	 move.w   d0,(a1)		     ; put value on stack
	 xjsr	  ut_iwdec		     ; conversion routine
	 adda.w   #f_wdec,sp		     ; reframe stack
	 movem.l  (sp)+,r_wdec
	 rts

*+++
* decimal string to integer word
*
*		  Entry 		     Exit
*	 D0.w				     integer number
*	 A0	  address of string	     preserved
*---
r_decw	 reg	  a1
f_decw	 equ	  6
con_decw
	 movem.l  r_decw,-(sp)
	 suba.w   #f_decw,sp
	 move.l   sp,a1
	 xjsr	  ut_deciw
	 bmi.s	  decw_err

	 move.w   (a1),d0

decw_exit
	 adda.w   #f_decw,sp
	 movem.l  (sp)+,r_decw
	 rts

decw_err
	 moveq	  #0,d0
	 bra.s	  decw_exit

*+++
* integer word to ascii column header
*
*		  Entry 		     Exit
*	 D0.w	  integer number	     preserved
*	 A0	  address of string	     preserved
*---
r_wasc	 reg	  d0/d1/a0
range	 equ	  'Z'-'A'+1
con_wasc
	 movem.l  r_wasc,-(sp)
	 moveq	  #0,d1 		     ; length count

wasc_lp
	 subi.w   #1,d0
	 andi.l   #$ffff,d0
	 divu	  #range,d0
	 swap	  d0			     ; get the remainder
	 move.w   d0,-(sp)		     ; place it on stack
	 addq.b   #1,d1 		     ; count it
	 swap	  d0
	 tst.w	  d0			     ; any quotient?
	 bne.s	  wasc_lp

	 move.w   d1,(a0)+		     ; put the string length
	 bra.s	  wasc_end2

wasc_lp2
	 move.w   (sp)+,d0		     ; get the number
	 addi.b   #'A',d0		     ; we want chars
	 move.b   d0,(a0)+

wasc_end2
	 dbra	  d1,wasc_lp2

	 movem.l  (sp)+,r_wasc
	 rts

r_catst reg	d0/d1/a0/a1
ut_catst
	movem.l r_catst,-(sp)
	move.w	(a1),d1 		; initial length
	move.w	(a0)+,d0
	add.w	d0,(a1)+		; total length
	adda.w	d1,a1			; next free location in a1
	bra.s	catst_end		; copy the rest

catst_lp
	move.b	(a0)+,(a1)+

catst_end
	dbra	d0,catst_lp
	movem.l (sp)+,r_catst
	rts



	 end
