* Spreadsheet					      29/11-91
*
	 section  config

	 include win1_mac_oli
	 include  win1_keys_wstatus


	 xdef	  pp_msy1,pp_msy2,pp_msy3,pp_msy4,pp_msy5,pp_msy6

;----------------------------------------------------------------------------

pp_msy1  subr	  a0/a1
	 xlea	  cfg_msy1,a1
	 xlea	  msy_usr1,a0
	 xjsr	  ut_cpyst
	 moveq	  #0,d0
	 moveq	  #0,d1
	 subend

pp_msy2  subr	  a0/a1
	 xlea	  cfg_msy2,a1
	 xlea	  msy_usr2,a0
	 xjsr	  ut_cpyst
	 moveq	  #0,d0
	 moveq	  #0,d1
	 subend

pp_msy3  subr	  a0/a1
	 xlea	  cfg_msy3,a1
	 xlea	  msy_usr3,a0
	 xjsr	  ut_cpyst
	 moveq	  #0,d0
	 moveq	  #0,d1
	 subend

pp_msy4  subr	  a0/a1
	 xlea	  cfg_msy4,a1
	 xlea	  msy_usr4,a0
	 xjsr	  ut_cpyst
	 moveq	  #0,d0
	 moveq	  #0,d1
	 subend

pp_msy5  subr	  a0/a1
	 xlea	  cfg_msy5,a1
	 xlea	  msy_usr5,a0
	 xjsr	  ut_cpyst
	 moveq	  #0,d0
	 moveq	  #0,d1
	 subend

pp_msy6  subr	  a0/a1
	 xlea	  cfg_msy6,a1
	 xlea	  msy_usr6,a0
	 xjsr	  ut_cpyst
	 moveq	  #0,d0
	 moveq	  #0,d1
	 subend

	 end
