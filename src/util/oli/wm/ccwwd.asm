; Convert Colourway in window definition	      O.Fink, 1991
;						      monochrome 17/07-92

	section utility

	include win1_keys_wwork
	include win1_keys_colour

	xdef	ut_ccwwd		     ; main window
	xdef	ut_cway 		     ; single colour
	xdef	ut_ccwiw		     ; one information window
	xdef	ut_ccwio		     ; all info objects in window
	xdef	ut_ccwap		     ; complete application window
	xdef	ut_ccwaw		     ; application window body
	xdef	ut_ccwai		     ; application menu items
	xdef	ut_ccwax		     ; application arrows/bar x-sect.
	xdef	ut_ccway		     ; application arrows/bar y-sect.
	xdef	ut_ccwix		     ; application index x-sect.
	xdef	ut_ccwiy		     ; application index y-sect.

white	equ	7
red	equ	2
green	equ	4
black	equ	0

;+++
; Convert colourway in window working defintion (main window only)
; assumes colours were defined in colourway 0
;
;		  Entry 		     Exit
;	 D0.b	  new colourway (0-3)
;	 A4	  ptr to working defn.
;---
wwreg	 reg	  d1/a0/a1/d2
ut_ccwwd
	 ext.w	  d0			     ; colourway 0?
	 beq.s	  exit			     ; the definition should be ready

	 movem.l  wwreg,-(sp)
	 lea	  ww_wattr(a4),a0	     ; main window attributes
	 bsr	  ut_cwattr
	 lea	  ww_lattr(a4),a0	     ; loose item attributes
	 bsr	  ut_cmattr

	 move.w   ww_ninfo(a4),d2	     ; number of info windows
	 beq.s	  exit			     ; none, great..

	 move.l   ww_pinfo(a4),a1	     ; pointer to info windows
nextiw
	 bsr	  ut_ccwiw		       ; convert information window
	 adda.l   #wwi.elen,a1
	 tst.w	  (a1)			     ; test for end of list
	 bpl	  nextiw		     ; nope, sorry

	 movem.l  (sp)+,wwreg
exit
	 rts


ut_ccwap
	bsr.s	ut_ccwaw		     ; application window body
	bsr.s	ut_ccwai		     ; application menu items
	bsr.s	ut_ccwax		     ; application arrows/bar x-sect.
	bsr.s	ut_ccway		     ; application arrows/bar y-sect.
	bsr	ut_ccwix		     ; application index x-sect.
	bsr	ut_ccwiy		     ; application index y-sect.
	rts

;+++
; Convert colourway in window working defintion for
; application sub window attributes only
; assumes colours were defined in colourway 0
;
;		  Entry 		     Exit
;	 D0.b	  new colourway (0-3)
;	 D1.w	  nr of appl. sub-window
;	 A4	  working definition
;---
ut_ccwaw
	 ext.w	  d0			     ; colourway 0?
	 beq.s	  aexit 		     ; the definition should be ready

	 movem.l  wwreg,-(sp)
	 lsl.w	  #2,d1 		     ; calculate offset in table
	 move.l   ww_pappl(a4),a1	     ; here is a list of ptrs
	 move.l   0(a1,d1.w),a1 	     ; this is the ptr we want
	 lea	  wwa_watt(a1),a0	     ; window attributes
	 bsr	  ut_cwattr
	 movem.l  (sp)+,wwreg

aexit
	 rts

;+++
; Convert colourway in window working defintion for
; menu sub window item attributes only
; assumes colours were defined in colourway 0
;
;		  Entry 		     Exit
;	 D0.b	  new colourway (0-3)
;	 D1.w	  nr of appl. sub-window
;	 A4	  working definition
;---
ut_ccwai
	 ext.w	  d0			     ; colourway 0?
	 beq.s	  bexit 		     ; the definition should be ready

	 movem.l  wwreg,-(sp)
	 lsl.w	  #2,d1 		     ; calculate offset in table
	 move.l   ww_pappl(a4),a1	     ; here is a list of ptrs
	 move.l   0(a1,d1.w),a1 	     ; this is the ptr we want
	 lea	  wwa_iatt(a1),a0	     ; item attributes
	 bsr	  ut_cmattr
	 movem.l  (sp)+,wwreg

bexit
	 rts


;+++
; Convert colourway in window working defintion for
; menu sub window arrow and bar attributes (section x/y) only
; assumes colours were defined in colourway 0
;
;		  Entry 		     Exit
;	 D0.b	  new colourway (0-3)
;	 D1.w	  nr of appl. sub-window
;	 A4	  working definition
;---
wwxyreg  reg	 d1/d2/a0/a1/d2
ut_ccwax
	 moveq	  #0,d2
	 bra.s	  ccwab
ut_ccway
	 moveq	  #wwa.clen,d2
ccwab
	 ext.w	  d0			     ; colourway 0
	 beq.s	  dexit 		     ; should already be defined

	 movem.l  wwxyreg,-(sp)
	 lsl.w	  #2,d1 		     ; calculate offset in table
	 move.l   ww_pappl(a4),a0	     ; here is a list of ptrs
	 move.l   0(a0,d1.w),a0 	     ; this is the ptr we want

	 move.w   wwa_psac(a0,d2.l),d1	     ; change pan/scroll-arrow colour
	 bsr	  ut_cway
	 move.w   d1,wwa_psac(a0,d2.l)

	 move.w   wwa_psbc(a0,d2.l),d1	     ; bar/section colour = 0.. no bar!
	 add.w	  wwa_pssc(a0,d2.l),d1
	 beq.s	  nobar
	 move.w   wwa_psbc(a0,d2.l),d1	     ; change pan/scroll-bar colour
	 bsr	  ut_cway
	 move.w   d1,wwa_psbc(a0,d2.l)

	 move.w   wwa_pssc(a0,d2.l),d1	     ; change pan/scroll-bar section colour
	 bsr	  ut_cway
	 move.w   d1,wwa_pssc(a0,d2.l)
nobar
	 movem.l  (sp)+,wwxyreg
dexit
	 rts

;+++
; Convert colourway in window working defintion for
; menu sub window index attributes (section x/y) only
; assumes colours were defined in colourway 0
;
;		  Entry 		     Exit
;	 D0.b	  new colourway (0-3)
;	 D1.w	  nr of appl. sub-window
;	 A4	  working definition
;---
wixyreg  reg	  d1/d2/a0/a1/d2
ut_ccwix
	 moveq	  #0,d2
	 bra.s	  ccwib
ut_ccwiy
	 moveq	  #wwa.clen,d2
ccwib
	 ext.w	  d0			     ; colourway 0
	 beq.s	  iexit 		     ; should already be defined

	 movem.l  wixyreg,-(sp)
	 lsl.w	  #2,d1 		     ; calculate offset in table
	 move.l   ww_pappl(a4),a0	     ; here is a list of ptrs
	 move.l   0(a0,d1.w),a0 	     ; this is the ptr we want

	 lea	  wwa_iiat(a0,d2.l),a1	     ; item attributes
	 bsr	  cmitem

	 movem.l  (sp)+,wixyreg
iexit
	 rts


;+++
; Convert information sub window
;
;		  Entry 		     Exit
;	 D0.b	  new colourway 	     preserved
;	 A1	  ptr to info subwindow      preserved
;---
cireg	 reg	  a0/a2/d1
ut_ccwiw
	 movem.l  cireg,-(sp)
	 lea	  wwi_watt(a1),a0	     ; get position of window attr
	 bsr.s	  ut_cwattr		     ; convert them
	 move.l   wwi_pobl(a1),d1	     ; get pointer to object list
	 beq.s	  ci_exit		     ; no objects,.. lalala
	 move.l   d1,a2
	 bsr.s	  ciwol
ci_exit
	 movem.l  (sp)+,cireg
	 rts

;+++
; Convert information object list
;
;		  Entry 		     Exit
;	 D0.b	  new colourway 	     preserved
;	 A2	  ptr to first object	     smashed
;---
ut_ccwio
ciwol
	 move.l   d1,-(sp)
nextio
	 tst.b	  wwo_type(a2)		     ; check for text items only
	 bgt.s	  skip			     ; wrong type
	 bsr.s	  cio			     ; convert info object
skip
	 adda.l   #wwo.elen,a2		     ; get possible end of list
	 tst.w	  (a2)			     ; check for real end
	 bpl	  nextio		     ; next info object
	 move.l   (sp)+,d1
	 rts
cio
	 move.w   wwo_ink(a2),d1
	 bsr.s	  ut_cway
	 move.w   d1,wwo_ink(a2)
	 rts

;+++
; Convert standard window attributes block
;
;		  Entry 		     Exit
;	 D0.b	  new colourway 	     preserved
;	 D1				     smashed
;	 A0	  ptr to wattr-block	     preserved
;---
ut_cwattr
	 move.w   wwa_borc(a0),d1	     ; get border colour
	 bsr.s	  ut_cway		     ; convert it
	 move.w   d1,wwa_borc(a0)	     ; put it back

	 move.w   wwa_papr(a0),d1	     ; the same for paper
	 bsr.s	  ut_cway		     ; convert it
	 move.w   d1,wwa_papr(a0)	     ; put it back

	 rts


;+++
; Convert standard menu item attributes
;
;		  Entry 		     Exit
;	 D0.b	  new colourway 	     preserved
;	 D1				     smashed
;	 A0	  ptr to menu attributes     preserved
;---
ut_cmattr
	 move.l   a1,-(sp)
	 move.w   wwa_curc(a0),d1	     ; current item border colour
	 bsr.s	  ut_cway
	 move.w   d1,wwa_curc(a0)
	 lea	  wwa_unav(a0),a1	     ; change unavailable item colour
	 bsr.s	  cmitem
	 lea	  wwa_aval(a0),a1	     ;	    ..available,..
	 bsr.s	  cmitem
	 lea	  wwa_selc(a0),a1	     ;	..and selected
	 bsr.s	  cmitem
	 bsr.s	  scitem		     ; senisitive colour..
	 move.l   (sp)+,a1
	 rts

; senisitive colours
scitem
	 move.w   wwa_back(a1),d1	     ; green background?
	 cmp.w	  #4,d1
	 bne.s	  sc_1
	 move.w   #0,wwa_ink(a1)	     ; then ink is black!
	 bra.s	  sc_x
sc_1
	 cmp.w	  #2,d1
	 bne.s	  sc_x
	 move.w   #7,wwa_ink(a1)
sc_x
	 rts

cmitem
	 move.w   wwa_back(a1),d1	     ; get backround colour
	 bsr.s	  ut_cway		     ; convert it
	 move.w   d1,wwa_back(a1)	     ; put it back
	 move.w   wwa_ink(a1),d1	     ; get ink colour
	 bsr.s	  ut_cway		     ; convert this, too
	 move.w   d1,wwa_ink(a1)	     ; write it back
	 rts


;+++
; Returns (stippled) colour changed according to colourway
;
;		  Entry 		     Exit
;	 D0.b	  colourway		     preserved
;	 D1.w	  normal colour (in way 0)   changed colour in given way
;
;---
screg	 reg	  d0/d2/d3/d4
ut_cway
	 movem.l  screg,-(sp)
	 move.b   d1,d2 		     ; prepare new colour
	 move.b   d1,d3
	 andi.b   #%11000000,d2 	     ; preserve colour stipple

	 andi.b   #%00000111,d1 	     ; for first colour code too
	 lsr.b	  #3,d3 		     ; get 2nd colour code
	 andi.b   #%00000111,d3 	     ; colour 0 to 7 only
	 eor.b	  d1,d3 		     ; 2nd colour is xor'ed
	 bsr.s	  cscol 		     ; convert first colour code
	 or.b	  d1,d2 		     ; store in new code
	 move.b   d1,d4

	 move.b   d3,d1
	 bsr.s	  cscol 		     ; convert 2nd colour
	 eor.b	  d4,d1 		     ; 2nd colour is xor'ed again
	 lsl.b	  #3,d1 		     ; get back to original position
	 or.b	  d1,d2 		     ; store in new code
	 move.b   d2,d1 		     ; return new code
	 movem.l  (sp)+,screg
	 rts

;+++
; convert single colour according to colourway
;
;		  Entry 		     Exit
;	 D0.b	  colourway		     preserved
;	 D1.w	  normal colour (0-7)	     new colour
;---
sreg	 reg	  d0/a0
cscol
	 movem.l  sreg,-(sp)
	 andi.w   #$ff,d1		     ; make sure there is one byte
	 lsl.b	  #2,d0 		     ; colourway * 4
	 lsr.b	  #1,d1 		     ; colour offset
	 add.b	  d1,d0 		     ; add total offset for table
	 lea	  cway,a0		     ; start of table
	 move.b   0(a0,d0.w),d1 	     ; get new colour
	 movem.l  (sp)+,sreg
	 rts

cway
	 ds.w	  0			     ; word alignment
	 dc.b	  black,red,green,white      ; colourway 0, green/white
	 dc.b	  white,green,red,black      ;		 1, black/red
	 dc.b	  black,green,red,white      ;		 2, white/red
	 dc.b	  white,red,green,black      ;		 3, black/green
	 dc.b	  black,black,white,white    ;		 4, monochrome

	 end
