* Spreadsheet					      07/01-92
*	 - dma control and maintainance

	 include win1_spread_keys
	 include win1_keys_err
	 include win1_keys_qdos_sms
	 include win1_mac_oli


	 xdef	  dma_frst	    ; alloc. first dma block and link it
	 xdef	  dma_aloc	    ; request space in dma area
	 xdef	  dma_free	    ; relink memory to dma free space list
	 xdef	  dma_quit	    ; release complete dma area

	 section  prog

*+++
* release complete dma area
*
*		  Entry 		     Exit
*	 a6	  ptr to data area	     preserved
*
* error codes: always OK
*---
r_quit	 reg	  d1/a1
dma_quit
	 movem.l  r_quit,-(sp)
	 move.l   da_fblok(a6),a0	     ; get first block in dma

quit_lp
	 move.l   blk_next(a0),d3	     ; and the pointer to the next
	 xjsr	  ut_rechp
	 tst.l	  d3			     ; end of list pointer?
	 bmi.s	  quit_ok

	 move.l   d3,a0 		     ; ..no, release next block
	 bra.s	  quit_lp

quit_ok
	 move.l   #dma.eol,d0
	 move.l   d0,da_fblok(a6)
	 move.l   d0,da_lblok(a6)
	 move.l   d0,da_ffree(a6)
	 move.l   d0,da_lfree(a6)

quit_exit
	 movem.l  (sp)+,r_quit
	 moveq	  #0,d0
	 rts


*+++
* allocate space in dma
*
*		  Entry 		     Exit
*	 a0				     base of area alloacted
*	 a6	  address of data area	     preserved
*	 d1.l	  nr. of bytes requested     preserved
*
* error codes: err.imem 	    not enough system memory left
*	       err.orng 	    req. memory exceeds blocksize
* condtion codes set
*---
r_aloc	 reg	  a1/a2/d1-d3
dma_aloc
	 movem.l  r_aloc,-(sp)
	 moveq	  #err.orng,d0
	 addq.l   #2,d1 		     ; 2 more for overhead
	 bsr	  dma_nslt		     ; calculate number of slots
	 cmpi.w   #blk.slts-1,d1
	 bgt.s	  aloc_exit		     ; more slots than possible

	 moveq	  #0,d0
	 moveq	  #dma.eol,d3

aloc_ag
	 move.l   da_ffree(a6),a0	     ; get first free space

aloc_lp
	 cmpa.l   d3,a0 		     ; end of list?
	 bne.s	  aloc_lb1

	 bsr	  dma_expd		     ; try to expand area
	 bmi.s	  aloc_exit

	 bra.s	  aloc_ag		     ; try again

aloc_lb1
	 cmp.w	  slt_size(a0),d1
	 beq.s	  aloc_equ		     ; =req. size
	 bmi.s	  aloc_grt		     ; >req. size

	 move.l   slt_next(a0),a0	     ; try next slot
	 bra.s	  aloc_lp

aloc_grt
	 move.l   a0,a1 		     ; get address of new slot
	 move.l   d1,d2
	 mulu	  #slt.len,d2
	 adda.l   d2,a1

	 move.l   slt_next(a0),slt_next(a1)  ; link new slot into list
	 move.l   slt_prev(a0),slt_prev(a1)
	 move.w   slt_size(a0),d2
	 sub.w	  d1,d2
	 move.w   d2,slt_size(a1)

	 move.l   slt_next(a0),a2
	 cmp.l	  d3,a2
	 beq.s	  aloc_lbx

	 move.l   a1,slt_prev(a2)
	 bra.s	  aloc_prep

aloc_lbx
	 move.l   a1,da_lfree(a6)

aloc_prep
	 move.l   slt_prev(a0),a2
	 cmp.l	  d3,a2
	 beq.s	  aloc_lb2

	 move.l   a1,slt_next(a2)
	 bra.s	  aloc_lb3

aloc_lb2
	 move.l   a1,da_ffree(a6)

aloc_lb3
	 bsr	  dma_clrs		     ; clear slot for use
	 move.w   d1,(a0)+		     ; set area size

aloc_exit
	 movem.l  (sp)+,r_aloc
	 tst.l	  d0
	 rts

aloc_equ
	 move.l   da_ffree(a6),d2	     ; the one and only slot?
	 sub.l	  da_lfree(a6),d2
	 bne.s	  aloc_eq1

	 bsr.s	  dma_expd		     ; yes, then expand area
	 bmi.s	  aloc_exit		     ; no memory left

aloc_eq1
	 move.l   slt_next(a0),a1	     ; a1 is next slot
	 move.l   slt_prev(a0),a2	     ; a2 is previous slot
	 cmpa.l   d3,a1
	 beq.s	  aloc_eq2		     ; was it the last ?

	 cmpa.l   d3,a2
	 beq.s	  aloc_eq3		     ; was it the first ?

	 move.l   a1,slt_next(a2)
	 move.l   a2,slt_prev(a1)
	 bra.s	  aloc_prep

aloc_eq2
	 move.l   d3,slt_next(a2)	     ; previous is last now
	 move.l   a2,da_lfree(a6)
	 bra.s	  aloc_lb3

aloc_eq3
	 move.l   d3,slt_prev(a1)	     ; next is first
	 move.l   a1,da_ffree(a6)
	 bra.s	  aloc_lb3

*+++
* expand dma area by one block
*
*		  Entry 		     Exit
*	 none
*
* error codes: err.imem    not enough memory left
* condtion codes set
*---
r_expd	 reg	  a0
dma_expd
	 movem.l  r_expd,-(sp)
	 bsr	  dma_ablk		     ; allocate a new block
	 bmi.s	  expd_exit

	 bsr.s	  dma_lblk		     ; link new block

expd_exit
	 movem.l  (sp)+,r_expd
	 tst.l	  d0
	 rts


*+++
* relink memory to the free space of the dma
*
*		  Entry 		     Exit
*	 a0	  ptr of memory to be free'd preserved
*	 a6	  address of data area	     preserved
*
*---
r_free	 reg	  a1/d1
dma_free
	 movem.l  r_free,-(sp)
	 move.w   -(a0),d1		     ; how many slots?

	 move.l   da_ffree(a6),a1	     ; link it back
	 move.w   d1,slt_size(a0)	     ; set nr of slots
	 move.l   a1,slt_next(a0)	     ; set link to next slot
	 move.l   a0,slt_prev(a1)	     ; and link back
	 move.l   #dma.eol,slt_prev(a0)      ; first free slot
	 move.l   a0,da_ffree(a6)

	 movem.l  (sp)+,r_free
	 rts

*+++
* link a new allocated block into lists (block and free slot)
*
*		  Entry 		     Exit
*	 a0	  ptr to block		     preserved
*	 a6	  ptr to data area	     preserved
*---
r_lblk	 reg	  a0/a1
dma_lblk
	 movem.l  r_lblk,-(sp)

	 move.l   da_lblok(a6),a1	     ; link blocks
	 move.l   blk_next(a1),blk_next(a0)  ; shift end of list marker
	 move.l   a0,da_lblok(a6)	     ; new last block
	 move.l   a0,blk_next(a1)	     ; link new to last
	 move.l   a1,blk_prev(a0)	     ; and last to new

	 adda.w   #slt.len,a0		     ; link free slots
	 move.l   da_lfree(a6),a1	     ; last free slot
	 move.l   slt_next(a1),slt_next(a0)  ; shift end of list marker
	 move.l   a0,da_lfree(a6)	     ; new last free slot
	 move.l   a0,slt_next(a1)	     ; link new to last
	 move.l   a1,slt_prev(a0)	     ; and last to new

	 movem.l  (sp)+,r_lblk
	 rts


*+++
* allocate first memory block and set up runtime pointers
*
*		  Entry 		     Exit
*	 a6	  ptr to data area	     preserved
*
* error codes: err.imem    not enough memory for a new block
* condition codes set
*---
r_frst	 reg	  a0/d3
dma_frst
	 movem.l  r_frst,-(sp)
	 bsr.s	  dma_ablk		     ; allocate a block
	 bmi.s	  frst_exit

	 moveq	  #dma.eol,d3
	 move.l   a0,da_fblok(a6)	     ; set up block chain
	 move.l   a0,da_lblok(a6)
	 move.l   d3,blk_prev(a0)	     ; end of block list
	 move.l   d3,blk_next(a0)

	 adda.w   #slt.len,a0		     ; set free slots chain
	 move.l   a0,da_ffree(a6)
	 move.l   a0,da_lfree(a6)
	 move.l   d3,slt_prev(a0)	     ; end of free slots list
	 move.l   d3,slt_next(a0)

frst_exit
	 movem.l  (sp)+,r_frst
	 rts

*+++
* allocate memrory for one block, clear it and set its size
*
*		  Entry 		     Exit
*	 A0				     address of block
*
* error codes: err.imem    not enough memory for a new block
* condition codes set
*---
r_ablk	 reg	  d1
dma_ablk
	 movem.l  r_ablk,-(sp)
	 move.l   #blk.len,d1
	 xjsr	  ut_alcmy		     ; request one block
	 bmi.s	  ablk_exit

	 bsr.s	  ablk_mem		     ; check least free space
	 bmi.s	  ablk_exit

	 move.w   #blk.slts,d1		     ; clear all slots in block
	 bsr.s	  dma_clrs

	 move.w   #blk.slts-1,slt_size+slt.len(a0) ; set nr of slots for use

ablk_exit
	 movem.l  (sp)+,r_ablk
	 tst.l	  d0
	 rts

r_amem	 reg	  d1-d3/a0-a3
ablk_mem				     ; check that at least
	 movem.l  r_amem,-(sp)		     ; dma.xmem bytes are left
	 move.l   a0,-(sp)		     ; after alloaction
	 moveq	  #sms.frtp,d0
	 trap	  #do.sms2
	 move.l   (sp)+,a0

	 moveq	  #0,d0
	 sub.l	  #dma.xmem,d1
	 bmi.s	  ablk_mrr

ablk_mx
	 tst.l	  d0
	 movem.l  (sp)+,r_amem
	 rts

ablk_mrr
	 xjsr	  ut_rechp
	 movem.l  (sp)+,r_amem
	 moveq	  #err.imem,d0
	 move.l   da_chan(a6),a0
	 xjmp	  ut_erwin		  ; display message and then die

*+++
* clear slots for use
*
*		  Entry 		     Exit
*	 A0	  base of area		     preserved
*	 D1.w	  nr. of slots		     preserved
*---
r_clrs	 reg	  d1/a0
dma_clrs
	 movem.l  r_clrs,-(sp)
	 mulu	  #slt.len,d1		     ; nr of bytes to clear
	 lsr.l	  #1,d1 		     ; nr of words
	 bra.s	  clrs_end

clrs_lp
	 clr.w	  (a0)+

clrs_end
	 dbra	  d1,clrs_lp
	 movem.l  (sp)+,r_clrs
	 rts


*+++
* calculate number of slots
*
*		  Entry 		     Exit
*	 D1.l	  number of bytes	 .w  number of slots required
*---
r_nslt	 reg	  d0
dma_nslt
	 movem.l  r_nslt,-(sp)
	 divu	  #slt.len,d1	    ; calculate number of slots required
	 move.w   d1,d0 	    ; quotient
	 swap	  d1
	 tst.w	  d1		    ; test for any remainder
	 beq.s	  nslt_exit

	 addq.w   #1,d0 	    ; add one slot for remaining bits

nslt_exit
	 ext.l	  d0		    ; sign extend to long word
	 move.l   d0,d1
	 movem.l  (sp)+,r_nslt
	 rts

	 end
