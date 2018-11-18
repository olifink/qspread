* Spreadsheet					      12/05-92 O.Fink
*	 - scrap handling

	 include  win1_keys_wwork
	 include  win1_keys_wstatus
	 include  win1_keys_qdos_io
	 include  win1_keys_err
	 include  win1_spread_keys
	 include  win1_mac_oli

	 section  prog

	 xdef	  fil_scrp

;+++
; put marked block into scrap
;
; error codes: err.nf or so for scrap not found
;---
fil_scrp subr	  a0-a5/d1-d3
	 suba.w   #8,sp
	 move.l   sp,a3
	 move.l   da_ordr(a6),4(a3)	     ; store old order

	 xjsr	  sc_clr		     ; clear scrap
	 tst.l	  d0
	 bne.s	  scrp_exit

	 move.l   da_ordr(a6),4(a3)	     ; store old order
	 move.l   #$00010000,da_ordr(a6)     ; by one column now!
	 move.l   da_cbx0(a6),(a3)
	 move.l   da_wwork(a6),a4
	 lea	  scrp_cel,a5		     ; cell action
	 xjsr	  mon_strt
	 xjsr	  mul_blok
	 xjsr	  mon_stop

scrp_exit
	 move.l   4(a3),da_ordr(a6)	     ; restore old order
	 tst.l	  d0
	 adda.w   #8,sp
	 subend

;
; scrap cell action routine
scrp_cel subr	  d1-d3/a1/a3
	 move.l   d1,da_moncl(a6)
	 move.w   d1,d0
	 sub.w	  2(a3),d0
	 beq.s	  no_lf

	 lea	  scp_line,a1		     ; line feed
	 bsr.s	  cel_put
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
	 beq.s	  cel_scrp

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

cel_scrp
	 bsr.s	  cel_put
cel_exit
	 tst.l	  d0
	 subend

cel_put  subr	  a0-a2/d1-d3
	 moveq	  #0,d1 	    ; add text to scrap
	 moveq	  #1,d2 	    ; append text
	 move.l   a1,a0 	    ; text is at a0
	 suba.l   a2,a2 	    ; no user copy code
	 xjsr	  sc_put
	 subend

scp_line dc.w	  1
	 dc.b	  10,0

	 end
