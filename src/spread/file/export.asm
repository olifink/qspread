* Spreadsheet					      12/05-92 O.Fink
*	 - export block

	 include  win1_keys_wwork
	 include  win1_keys_wstatus
	 include  win1_keys_qdos_io
	 include  win1_keys_err
	 include  win1_spread_keys
	 include  win1_mac_oli

	 section  prog

	 xdef	  fil_expo

	 xref.l   mv_poic
;+++
; export marked block
;
;		  Entry 		     Exit
;	 a0	  channel id		     preserved
;---
fil_expo subr	  a0-a5/d1-d5
	 suba.w   #8,sp
	 move.l   sp,a3
	 move.l   da_ordr(a6),4(a3)	     ; store old order
	 move.l   #$00010000,da_ordr(a6)     ; by one column now!
	 move.l   da_cbx0(a6),(a3)
	 move.l   da_wwork(a6),a4
	 xjsr	  mon_strt

	 move.l   da_cbx1(a6),d5
	 move.w   da_cbx0+2(a6),da_cbx1+2(a6)
	 lea	  expo_wdt,a5		     ; export cell widths
	 xjsr	  mul_blok
	 move.l   d5,da_cbx1(a6)

	 lea	  expo_cel,a5		     ; print cell action
	 xjsr	  mul_blok

	 xjsr	  mon_stop
	 bne.s	  expo_exit
	 xjsr	  ut_prlf
expo_exit
	 move.l   4(a3),da_ordr(a6)	     ; restore old order
	 adda.w   #8,sp
	 tst.l	  d0
	 subend

expo_cel subr	  d1-d3/a1/a3
	 move.l   d1,da_moncl(a6)
	 move.l   d1,d0
	 swap	  d0
	 cmp.w	  (a3),d0
	 bne.s	  no_lf

	 moveq	  #10,d1		     ; use 10 for end of line
	 bra.s	  no_tab
no_lf	 moveq	  #9,d1 		     ; use tab for seperation
no_tab
	xjsr	 ut_prchr

	 move.l   da_moncl(a6),d1
	 xjsr	  dta_madr
	 move.l   wwm_pobj(a3),d0
	 beq.s	  cel_expo
	 move.l   d0,a1
cel_expo
	 xjsr	  ut_prstr
	 subend


expo_wdt subr	  d1-d3/a0-a3
	 xjsr	  cel_wdth		     ; d3=column width
	 move.l   d3,d1
	 xjsr	  ut_priwd		     ; print integer word as dec
	 bne.s	  wdt_exit
	 xjsr	  ut_prtab
wdt_exit
	 subend

	 end
