* Spreadsheet					      28/12-91
*	 - cell order calculations

	 section  prog

	 include  win1_keys_wman
	 include  win1_keys_wstatus
	 include  win1_keys_wwork
	 include  win1_keys_err
	 include  win1_mac_oli
	 include  win1_spread_keys

	 xdef	  cel_next		     ; get next cell in block
	 xdef	  cel_nxtg		     ; get next cell in used grid
	xdef	cel_nxtav		; get next cell depending on status
	 xdef	  cel_nxta		     ; get next cell in whole sheet
	 xdef	  cel_nxtc		     ; get cell in next column
	 xdef	  cel_prev		     ; previous cell in block
	 xdef	  cel_prvg		     ; previous cell in grid

	 xdef	  mul_grid		     ; multiple action on grid
	 xdef	  mul_blok		     ; multiple action on block
	 xdef	  mul_rblk		     ; reverse multiple action block
	 xdef	  mul_rgrd		     ; reverse multiple action grid


*+++
* multiple action on block with reverse order
*
*		  Entry 		     Exit
*	 a5	  ptr to routine	     preserved
*
* any routine dependant errors, or 0
*
* >>the routine is called with cell number in d1.l<<
*---
r_rblk	  reg	   d1
mul_rblk
	 movem.l  r_rblk,-(sp)
	 move.l   da_cbx1(a6),d1	     ; get first cell in block

rblk_lp
	 jsr	  (a5)			     ; process routine
*	  tst.l    d0			      ; ..any errors?
*	  bne.s    rblk_exit
	 bsr	  cel_prev
	 beq.s	  rblk_lp

	 moveq	  #0,d0

rblk_exit
	 movem.l  (sp)+,r_rblk
	 rts



*+++
* multiple action on block
*
*		  Entry 		     Exit
*	 a5	  ptr to routine	     preserved
*
* any routine dependant errors, or 0
*
* >>the routine is called with cell number in d1.l<<
*---
r_blk	 reg	  d1
mul_blok
	 movem.l  r_blk,-(sp)
	 move.l   da_cbx0(a6),d1	     ; get first cell in block

blok_lp
	 jsr	  (a5)			     ; process routine
*	  tst.l    d0			      ; ..any errors?
*	  bne.s    blok_exit
	 bsr	  cel_next		     ; get to next cell
	 beq.s	  blok_lp

	 moveq	  #0,d0

blok_exit
	 movem.l  (sp)+,r_blk
	 rts

*+++
* multiple action on complete (used) grid
*
*		  Entry 		     Exit
*	 a5	  ptr to routine	     preserved
*
* any routine dependant errors, or 0
*
* >>the routine is call with cell number in d1.l<<
*---
r_grd	 reg	  d1
mul_grid
	 movem.l  r_grd,-(sp)
	 xjsr	  mon_strt		     ; start cell monitor
	 moveq	  #0,d1 		     ; get first cell

grid_lp
	 move.l   d1,da_moncl(a6)
	 jsr	  (a5)			     ; process routine
*	  tst.l    d0			      ; ..any errors?
*	  bne.s    grid_exit
	 bsr	  cel_nxtg		     ; get to next cell
	 beq.s	  grid_lp

	 moveq	  #0,d0

grid_exit
	 xjsr	  mon_stop		     ; stop monitoring
	 tst.l	  d0
	 movem.l  (sp)+,r_grd
	 rts

*+++
* reverse multiple action on complete (used) grid
*
*		  Entry 		     Exit
*	 a5	  ptr to routine	     preserved
*
* any routine dependant errors, or 0
*
* >>the routine is call with cell number in d1.l<<
*---
r_rgrd	 reg	  d1
mul_rgrd
	 movem.l  r_rgrd,-(sp)
	 xjsr	  mon_strt		     ; start cell monitor
	 move.w   da_ncols(a6),d1
	 swap	  d1
	 move.w   da_nrows(a6),d1
	 sub.l	  #$00010001,d1 	     ; get last cell

rgrd_lp
	 move.l   d1,da_moncl(a6)
	 jsr	  (a5)			     ; process routine
*	  tst.l    d0			      ; ..any errors?
*	  bne.s    tgrd_exit
	 bsr	  cel_prvg		     ; get to previous cell in grid
	 beq.s	  rgrd_lp

	 moveq	  #0,d0

rgrd_exit
	 xjsr	  mon_stop		     ; stop monitoring
	 tst.l	  d0
	 movem.l  (sp)+,r_rgrd
	 rts

*+++
* get to next column position
*
*		  Entry 		     Exit
*	 d1.l	  current c|r		     next c|r
*
* error codes: err.orng    next column would be out of sheet
* condition codes set
*---
r_nxtc	 reg	  d2
cel_nxtc
	 movem.l  r_nxtc,-(sp)
	 moveq	  #err.orng,d0
	 move.w   da_ncols(a6),d2	     ; number of columns
	 subq.w   #1,d2 		     ; last column number
	 swap	  d1
	 cmp.w	  d1,d2 		     ; is it the last?
	 beq.s	  nxtc_exit

	 addq.w   #1,d1
	 moveq	  #0,d0

nxtc_exit
	 swap	  d1
	 movem.l  (sp)+,r_nxtc
	 tst.l	  d0
	 rts

*+++
* get number of next cell in block
*
*		  Entry 		     Exit
*	 d1.l	  c|r of cell (in block!)    c|r of next cell
*
* error codes: err.orng  next cell would not be in range
* condition codes set
*---
r_next	 reg	  d2
cel_next
	 movem.l  r_next,-(sp)
	 moveq	  #err.orng,d0
	 move.l   da_cbx1(a6),d2
	 bmi.s	  next_exit		     ; one cell.. no next possible

	 cmp.l	  d1,d2
	 beq.s	  next_exit		     ; current is last one

	 moveq	  #0,d0
	 add.l	  da_ordr(a6),d1
	 cmp.w	  d1,d2
	 bmi.s	  next_rov		     ; row overflow

next_c
	 swap	  d1
	 swap	  d2
	 cmp.w	  d1,d2
	 bmi.s	  next_cov		     ; column overflow

next_ok
	 swap	  d1
	 swap	  d2

next_exit
	 movem.l  (sp)+,r_next
	 tst.l	  d0
	 rts

next_rov
	 move.w   da_cby0(a6),d1	     ; first row in block
	 add.l	  #$00010000,d1 	     ; next column
	 bra.s	  next_c

next_cov
	 move.w   da_cbx0(a6),d1	     ; first column in block
	 add.l	  #$00010000,d1 	     ; next row
	 bra.s	  next_ok

*+++
* get number of prev cell in block
*
*		  Entry 		     Exit
*	 d1.l	  c|r of cell (in block!)    c|r of prev cell
*
* error codes: err.orng  prev cell would not be in range
* condition codes set
*---
r_prev	 reg	  d2
cel_prev
	 movem.l  r_prev,-(sp)
	 moveq	  #err.orng,d0
	 tst.l	  da_cbx1(a6)
	 bmi.s	  prev_exit		     ; one cell.. no prev possible

	 move.l   da_cbx0(a6),d2
	 cmp.l	  d1,d2
	 beq.s	  prev_exit		     ; current is first one

	 moveq	  #0,d0
	 subq.w   #1,d1
	 cmp.w	  d2,d1
	 bmi.s	  prev_rov		     ; row overflow

prev_c
	 swap	  d1
	 swap	  d2
	 cmp.w	  d2,d1
	 bmi.s	  prev_cov		     ; column overflow

prev_ok
	 swap	  d1
	 swap	  d2

prev_exit
	 movem.l  (sp)+,r_prev
	 tst.l	  d0
	 rts

prev_rov
	 move.w   da_cbx1+2(a6),d1	      ; first row in block
	 sub.l	  #$00010000,d1 	     ; prev column
	 bra.s	  prev_c

prev_cov
	 move.w   da_cbx1(a6),d1	     ; first column in block
	 sub.l	  #$00010000,d1 	     ; prev row
	 bra.s	  prev_ok


*+++
* get number of next cell in (used) grid
*
*		  Entry 		     Exit
*	 d0	  direction (1=down,2=right)
*	 d1.l	  c|r of cell		     c|r of next cell
*
* error codes: err.orng  next cell would not be in range
* condition codes set
*---
r_nxtg	 reg	  d2
cel_nxtav
	movem.l r_nxtg,-(sp)
	move.b	v_automov(a6),d0	; direction
	beq.s	nxtg_exit		; do not move
	subq.b	#1,d0			; down?
	beq.s	cel_nxta2
	move.l	d1,d0
	swap	d0
	addq.w	#1,d0
	cmp.w	da_ncols(a6),d0
	bge.s	nxtg_exit
	add.l	#$00010000,d1
	bra.s	nxtg_exit
cel_nxta
	 movem.l  r_nxtg,-(sp)
cel_nxta2
	 moveq	  #err.orng,d0
	 move.w   da_ncols(a6),d2
	 swap	  d2
	 move.w   da_nrows(a6),d2
	 sub.l	  #$00010001,d2
	 bra.s	  nxtg_hi

cel_nxtg
	 movem.l  r_nxtg,-(sp)
	 moveq	  #err.orng,d0
	 move.l   da_usedx(a6),d2

nxtg_hi
	 bmi.s	  nxtg_exit		     ; one cell.. no nxtg possible
	 cmp.l	  d1,d2
	 beq.s	  nxtg_exit		     ; current is last one

	 moveq	  #0,d0
	 add.l	  da_ordr(a6),d1
	 cmp.w	  d1,d2
	 bmi.s	  nxtg_rov		     ; row overflow

nxtg_c
	 swap	  d1
	 swap	  d2
	 cmp.w	  d1,d2
	 bmi.s	  nxtg_cov		     ; column overflow

nxtg_ok
	 swap	  d1
	 swap	  d2

nxtg_exit
	 movem.l  (sp)+,r_nxtg
	 tst.l	  d0
	 rts

nxtg_rov
	 move.w   #0,d1 		     ; first row
	 add.l	  #$00010000,d1 	     ; nxtg column
	 bra.s	  nxtg_c

nxtg_cov
	 move.w   #0,d1 		     ; first column
	 add.l	  #$00010000,d1 	     ; nxtg row
	 bra.s	  nxtg_ok


*+++
* get number of previous cell in grid
*
*		  Entry 		     Exit
*	 d1.l	  c|r of cell		     c|r of prev cell
*
* error codes: err.orng  next cell would not be in range
* condition codes set
*---
cel_prvg
	 moveq	  #err.orng,d0
	 tst.l	  d1
	 beq.s	  prvg_exit		     ; current is last (=first) one

	 moveq	  #0,d0
	 sub.w	  da_ordr(a6),d1
	 swap	  d1
	 sub.w	  da_ordr+2(a6),d1
	 swap	  d1
	 tst.w	  d1
	 bmi.s	  prvg_rov		     ; row overflow

prvg_c
	 swap	  d1
	 tst.w	  d1
	 bmi.s	  prvg_cov		     ; column overflow

prvg_ok
	 swap	  d1

prvg_exit
	 tst.l	  d0
	 rts

prvg_rov
	 move.w   da_nrows(a6),d1	     ; last row
;;;	    sub.l    #$00010000,d1		; previous column
	 sub.l	  #$00010001,d1 	     ; previous column
	 bra.s	  prvg_c

prvg_cov
	 move.w   da_ncols(a6),d1	     ; first column
	 sub.l	  #$00010000,d1 	     ; prvg row
	 bra.s	  prvg_ok

	 end
