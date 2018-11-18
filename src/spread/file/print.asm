* Spreadsheet					      12/05-92 O.Fink
*	 - print page

	 include  win1_keys_wwork
	 include  win1_keys_wstatus
	 include  win1_keys_qdos_io
	 include  win1_keys_err
	 include  win1_spread_keys
	 include  win1_mac_oli

	 section  prog

	 xdef	  fil_prnt

	 xref.l   mv_poic
;+++
; print marked block
;
;		  Entry 		     Exit
;	 a0	  channel id		     preserved
;---
fil_prnt subr	  a0-a5/d1-d3
	 suba.w   #8,sp
	 move.l   sp,a3
	 move.l   da_ordr(a6),4(a3)	     ; store old order

	 lea	  mv_poic(a6),a1	     ; send initialisation
	 bsr	  prt_linf
	 bne.s	  prnt_exit

	 lea	  rtf_left,a1		     ; left justification
	 bsr	  prt_linf
	 bne.s	  prnt_exit

	 move.l   da_ordr(a6),4(a3)	     ; store old order
	 move.l   #$00010000,da_ordr(a6)     ; by one column now!
	 move.l   da_cbx0(a6),(a3)
	 move.l   da_wwork(a6),a4
	 lea	  prnt_cel,a5		     ; print cell action
	 xjsr	  mon_strt
	 xjsr	  mul_blok
	 xjsr	  mon_stop
	 tst.l	  d0
	 bne.s	  prnt_exit

	 lea	  rtf_page,a1		     ; form feed
	 bsr	  prt_linf

prnt_exit
	 move.l   4(a3),da_ordr(a6)	     ; restore old order
	 adda.w   #8,sp
	 tst.l	  d0
	 subend

prnt_cel subr	  d1-d3/a1/a3
	 move.l   d1,da_moncl(a6)
	 move.w   d1,d0
	 sub.w	  2(a3),d0
	 beq.s	  no_lf

	 lea	  rtf_line,a1		     ; line feed
	 bsr	  prt_linf
	 bne.s	  cel_exit
no_lf
	 move.l   d1,(a3)		     ; spaces in wdth(col())
	 lea	  da_buff(a6),a1
	 xjsr	  cel_wdth
	 bne.s	  cel_exit
	 move.w   d3,d2
	 moveq	  #' ',d1
	 exg	  a0,a1
	 xjsr	  st_filst
	 exg	  a0,a1

	 move.l   (a3),d1
	 xjsr	  dta_madr
	 move.b   wwm_xjst(a3),d1
	 ext.w	  d1
	 move.l   wwm_pobj(a3),d0
	 beq.s	  cel_prnt

	 move.l   d0,a3 		     ; put text into "space"
	 moveq	  #0,d2
	 tst.b	  d1
	 bpl.s	  cel_cpy

	 move.w   (a1),d2
	 sub.w	  (a3),d2
cel_cpy
	 move.w   (a3)+,d0
	 bra.s	  cp_lpe
cp_lp
	 move.b   (a3)+,2(a1,d2.w)
	 addq.w   #1,d2
cp_lpe
	 dbra	  d0,cp_lp

cel_prnt
	 bsr.s	  prt_text
cel_exit
	 tst.l	  d0
	 subend

; print a line of text
; a0 channel id
; a1 text
prt_line subr	  a0/a1/d1-d3
	 moveq	  #iob.smul,d0		     ; send multiple
	 move.w   (a1)+,d2
	 moveq	  #forever,d3
	 trap	  #do.io
	 tst.l	  d0
	 subend

; send a linefeed
prt_lf	 subr	  d1/d3
	 moveq	  #10,d1
	 bsr.s	  prt_chr
	 subend

; send a character
prt_chr  subr	  d1/d3
	 moveq	  #iob.sbyt,d0
	 moveq	  #forever,d3
	 trap	  #do.io
	 tst.l	  d0
	 subend

; send text with linefeed
prt_linf
	 bsr	  prt_line
	 bne.s	  linf_exit
	 bsr	  prt_lf
linf_exit
	 rts

; send text as RTF
prt_text  subr	   a1/d4
	 move.w   (a1)+,d4
	 bra.s	  text_lpe
text_lp
	 move.b   (a1)+,d1
	 cmpi.b   #' ',d1
	 beq.s	  text_rtf
	 cmpi.b   #$80,d1
	 bpl.s	  text_rtf
	 bsr	  prt_chr
text_lpe
	 dbra	  d4,text_lp
	 moveq	  #0,d0
text_exit
	 tst.l	  d0
	 subend

text_rtf
	 bsr.s	  prt_rtf
	 beq	  text_lpe
	 bra	  text_exit

; send char (d1.w) in RTF code sequence
prt_rtf  subr	  a1/a3/d1-d3
	 suba.w   #4,sp
	 move.l   sp,a1
	 lea	  tab_hex,a3
	 move.w   #$5c27,(a1)	    ; RTF code sequence \'
	 move.b   d1,d0
	 lsr.b	  #4,d0
	 andi.w   #$F,d0
	 move.b   (a3,d0.w),2(a1)
	 move.b   d1,d0
	 andi.w   #$F,d0
	 move.b   (a3,d0.w),3(a1)
	 moveq	  #iob.smul,d0
	 moveq	  #4,d2
	 moveq	  #forever,d3
	 trap	  #do.io
	 tst.l	  d0
	 adda.w   #4,sp
	 subend
tab_hex  dc.b	  '0123456789ABCDEF'

*
* very small RTF code definitions
rtf_left qstrg	  {\ql }
rtf_line qstrg	  {\line }
rtf_page qstrg	  {\page }

	 end
