; expand exponent in numeric string		      13/02-92 O.Fink


	 section  string

	 include win1_keys_err

	 xdef	  st_xpnde	    ; expand exponent string

	 xref	  st_findc
	 xref	  st_insc
	 xref	  st_delc

;+++
; expand exponent string (from xxxE-8 to xxxE8 )
; 1.234E5 -> 123400
;
;		  Entry 		     Exit
;	 a0	  ptr to string 	     preserved (enough space!)
;
; error codes: none	   (if exponent is not in range, no conversion will
;			    be done)
;---
r_xpnde  reg	  d0-d6
st_xpnde
	 movem.l  r_xpnde,-(sp)
	 move.w   (a0),d3		     ; length of string
	 beq.s	  xpnde_exit		     ; no string supplied

	 moveq	  #1,d1 		     ; scanning position
	 moveq	  #'E',d2		     ; look for E
	 bsr	  st_findc
	 bmi.s	  xpnde_exit
	 move.w   d1,d4 		     ; d4=position of E
	 beq.s	  xpnde_exit

	 sub.w	  d1,d3
	 beq.s	  xpnde_exit		     ; E is last character

	 cmpi.b   #'-',2(a0,d4.w)
	 bne.s	  xpnde_lb

	 subq.w   #2,d3
	 bne.s	  xpnde_exit
	 bsr.s	  xpnde_neg

	 bra.s	  xpnde_exit
xpnde_lb
	 subq.w   #1,d3
	 bne.s	  xpnde_exit
	 bsr.s	  xpnde_pos

xpnde_exit
	 movem.l  (sp)+,r_xpnde
	 rts

*--------------------------negative exponent-----------------------------------
xpnde_neg

	move.b	3(a0,d4.w),d5	; fetch exponent
	subi.b	#'0',d5
	beq.s	neg_bye 	; should not be zero!
	move.b	#'.',1(a0,d4.w) ; replace E by "."
	ext.w	d5		; into word format
	move.w	 d5,d3		; keep a copy
	move.w	 d4,d6		; keep a copy of the exponent position
	add.w	 d5,d6

;;; --- added again to match QSpread 3.02 (MK)
	subq.w	#1,d6
;;; ---
	moveq	#0,d1
	moveq	#0,d4
	cmpi.b	#'-',2(a0)	; negative mantissa?
	bne.s	neg_lb1 	; no, start at start
	moveq	#1,d4		; start after '-'
	moveq	#1,d1
neg_lb1
	moveq	#'0',d2 	; character to be inserted
	bra.s	neg_end
neg_lp
	bsr	st_insc 	; insert character into here
neg_end
	dbra	d3,neg_lp

	moveq	#1,d1
	moveq	#'.',d2 	; find pos of '.'
	bsr	st_findc
	bra.s	neg_end2
neg_lp2
	bsr.s	exg_chr 	; swap all chars
neg_end2
	subq.w	#1,d1
	dbra	d5,neg_lp2

	moveq	 #1,d1
	add.w	 d4,d1
;;; --- added again to match QSpread 3.02 (MK)
	bra.s	 neg_bye
;;; ---

neg_lb3 			; this should remove leading 0es
	 move.b   2(a0,d4.w),d0
	 cmpi.b   #'0',d0
	 bne.s	  neg_bye
	 bsr	  st_delc
	 bra.s	  neg_lb3

neg_bye
;;; --- removed again to match QSpread 3.02 (MK)
;;;	    cmpi.w   #3,d6
;;;	    ble.s    neg_xx
;;;	    subq.w   #1,d6
;;; ---
	 cmpi.w   #8,d6
	 ble.s	  neg_xx
	 moveq	  #8,d6
neg_xx
	 move.w   d6,(a0)
	 rts


*--------------------------positive exponent-----------------------------------
xpnde_pos
	 move.b   2(a0,d4.w),d5
	 subi.b   #'0',d5
	 cmp.b	  #8,d5
	 bge.s	  pos_bye
	 ext.w	  d5
	 move.w   d5,d1
	 move.w   d5,d6 		     ; d6=string length

	 move.w   d4,d3
	 subq.w   #1,d3
	 bra.s	  pos_end
pos_lp
	 move.b   #'0',1(a0,d4.w)	     ; append 0's at the E
	 addq.w   #1,d4
pos_end
	 dbra	  d1,pos_lp

	 moveq	  #1,d1
	 moveq	  #'.',d2
	 bsr	  st_findc
	 bne.s	  pos_nop
	 add.w	  d1,d6
posx_lp
	 bsr.s	  exg_chr
	 addq.w   #1,d1
	 subq.w   #1,d5
	 bne.s	  posx_lp

	 subq.w   #1,d6
pos_exit
	 move.w   d6,(a0)
pos_bye
	 rts

pos_nop
	 add.w	  d3,d6
	 bra.s	  pos_exit

exg_chr
	 move.b   1(a0,d1.w),d0
	 move.b   2(a0,d1.w),1(a0,d1.w)
	 move.b   d0,2(a0,d1.w)
	 rts



	 end
