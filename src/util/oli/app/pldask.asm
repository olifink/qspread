* Ask (yes/no) menu				      14/07-92
*						      O. Fink

	 section  utility

	 include  win1_mac_oli

	 xdef	  pld_ask

*+++
* ask yes or no menu
*
*		  Entry 		     Exit
*	 d0				     0=yes
*					     1=no
*					     <0 error
*	 d1.w	  mainconfig
*	 a3	  ask block		     preserved
*---
abi_head equ	  $00
abi_msg  equ	  $04
pld_ask  subr	  d1-d3/a0-a3
	 move.l   d1,d2
	 moveq	  #-1,d1		     ; position relative
	 moveq	  #0,d3
	 lea	  abi_head(a3),a0
	 add.l	  (a0),a0
	 lea	  abi_msg(a3),a2
	 add.l	  (a2),a2
	 xjsr	  mu_yesno
	 bne.s	  yn_exit
	 bchg	  #0,d3
	 move.b   d3,d0
yn_exit
	 subend
	 tst.w	  d0
	 rts

	 end
