* Check extended environment versions		      20/06-92 O.Fin
*

	 include  win1_keys_qdos_sms
	 include  win1_keys_qdos_ioa
	 include  win1_keys_qdos_io
	 include  win1_keys_err
	 include  win1_keys_wman
	 include  win1_mac_oli

	 section  utility

	 xdef	  ut_xver	    extended environment check

;+++
; check version numbers of
;	 - pointer interface
;	 - window manager
;	 - menu extensions
; if too old or not present, report an error and remove job
; if d2/d3 given as 0, the corresponding extension is not checked
;
;		  Entry 		     Exit
;	 d1.l	  min. ptr i/f version	     smashed
;	 d2.l	  min. wman version	     smashed
;	 d3.l	  min. menu rext version     smashed
;
; no errors
;---
v_ptrif  equ	  $00
v_wman	 equ	  $04
v_menu	 equ	  $08
f_stk	 equ	  $0c
ut_xver  subr	  a0-a3
	 suba.w   #f_stk,sp		     ; local data area
	 move.l   sp,a3
	 move.l   d1,v_ptrif(a3)	     ; store versions
	 move.l   d2,v_wman(a3)
	 move.l   d3,v_menu(a3)

	 lea	  con_name,a0		     ; open small console
	 moveq	  #ioa.kexc,d3
	 xjsr	  do_open
	 bne	  kill

	 moveq	  #iop.pinf,d0		     ; check ptr i/f
	 xjsr	  do_io
	 bne.s	  no_ptr		     ; ..ptr i/f not installed
	 move.l   v_ptrif(a3),d0
	 bsr	  cmp_vers
	 bne.s	  old_ptr		     ; ..ptr i/f too old

	 move.l   v_wman(a3),d0 	     ; check window manager
	 beq.s	  xver_exit
	 move.l   a1,d1
	 beq.s	  no_wman		     ; ..wman not installed
	 move.l   (a1),d1
	 bsr.s	  cmp_vers
	 bne.s	  old_wman		     ; ..wman too old

	 tst.l	  v_menu(a3)		     ; check menu extensions
	 beq.s	  xver_exit
	 move.l   #'FSEL',d2
	 xjsr	  ut_usmen
	 bne.s	  no_menu		     ; ..menus not installed
	 xjsr	  ut_frmen
	 move.l   v_menu(a3),d0
	 move.l   d3,d1
	 bsr.s	  cmp_vers
	 bne.s	  old_menu		     ; ..menus too old
xver_exit
	 xjsr	  do_close
	 adda.w   #f_stk,sp
	 moveq	  #0,d0
	 subend

no_ptr
	 lea	  m_noptr,a3
	 bra.s	  err_con
old_ptr
	 lea	  m_oldptr,a3
	 bra.s	  err_con
no_wman
	 lea	  m_nowm,a3
	 bra.s	  err_con
old_wman
	 lea	  m_oldwm,a3
	 bra.s	  err_con
no_menu
	 lea	  m_nomn,a3
	 bra.s	  err_con
old_menu
	 lea	  m_oldmn,a3
err_con
	 xjsr	  do_close
	 move.l   a3,d0
	 bset	  #31,d0
	 xjsr	  ut_appr
kill
	 xjsr	  ut_kill

cmp_vers
	 andi.l   #$ff00ffff,d0
	 andi.l   #$ff00ffff,d1
	 sub.l	  d0,d1
	 bmi.s	  vers_old
	 moveq	  #0,d0
	 rts
vers_old
	 moveq	  #err.nc,d0
	 rts

m_noptr  qstrg	  {Pointer Interface not present}
m_oldptr qstrg	  {Pointer Interface too old}
m_nowm	 qstrg	  {Window Manager not present}
m_oldwm  qstrg	  {Window Manager too old}
m_nomn	 qstrg	  {Menu Extensions not present}
m_oldmn  qstrg	  {Menu Extensions too old}
con_name qstrg	  {con_2x1a0x0}
err_blk  dc.w	  448,180,32,16

	 end
