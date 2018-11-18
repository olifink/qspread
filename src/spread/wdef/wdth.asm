* Spreadsheet					      07/02-92
*	 - width menu window definition
*
	 include  win1_mac_menu_long
	 include  win1_keys_colour
	 include  win1_keys_wman
	 include  win1_keys_wwork
	 include  win1_keys_wstatus
	 include  win1_keys_wdef_long

white	equ	7
red	equ	2
green	equ	4
black	equ	0


wd_mxs	 equ	  132
wd_mys	 equ	  53
wd_fxs	 equ	  wd_mxs-2*(8+4*6)+2
wd_lxs	 equ	  wd_mxs-12
grnstp	 equ	  92


	 xref.s   met.wdtt,met.wdcc
	 xref.s   meu.wdfr,meu.wdto,meu.wdnw,meu.ok,meu.esc

	 section  menu

	 window   wdth			     ; width window defintion
	 size	  wd_mxs,wd_mys 	     ; window size
	 origin   wd_mxs-6,6		     ; pointer position
	 wattr	  2			     \ shadow width
		  1,c.mbord		     \ border width and colour
		  c.mback		     ; paper colour

	 sprite   0

	 border   1,c.mhigh
	iattr	c.mpunav,c.miunav,0,0	; unavailable
	iattr	c.mpavbl,c.miavbl,0,0	; available
	iattr	c.mpslct,c.mislct,0,0	; selected

	 help	  0			     ; no help window defintion

	 size_opt a			     ; layout will be internal

	 size	  wd_mxs,wd_mys 	     ; default size, not scalable
	 info	  wdth
	 loos	  wdth
	 appn	  0

	 s_end

*
* information window defintion

	 i_wlst   wdth

	 i_windw			     ; the flag
	  size	   wd_fxs,14
	  origin   4*6+8,0
	  wattr    0,0,0,c.mfill
	  olst	   0

	 i_windw			     ; the flag name
	  size	   6*6,11
	  origin   4*6+8+(wd_fxs-6*6)/2,2
	  wattr    0,0,0,c.tback
	  olst	   flag

	 i_windw			     ; some pretty border
	  size	   wd_mxs-8,wd_mys-16
	  origin   4,14
	  wattr    0,1,c.ibord,c.iback
	  olst	   chco

	 i_end

*
* information object lists

	 i_olst   flag

	 i_item
	  size	   met.wdtt+met.wdtt,10
	  origin   3*6-met.wdtt,1
	  type	   text
	  ink	   c.tink
	  csize    0,0
	  text	   wdtt
	 i_end

	 i_olst   chco

	 i_item
	  size	  wd_mxs-8,10
	  origin  2,2
	  type	  text
	  ink	  c.iink
	  csize   0,0
	  text	  wdcc
	 i_item
	  size	  4*6,10
	  origin  2,14
	  type	  text-meu.wdfr
	  ink	  c.iink
	  csize   0,0
	  text	  wdfr
	 i_item
	  size	  3*6,10
	  origin  12*6,14
	  type	  text-meu.wdto
	  ink	  c.iink
	  csize   0,0
	  text	  wdto
	 i_item
	  size	  12*6,10
	  origin  2,26
	  type	  text-meu.wdnw
	  ink	  c.iink
	  csize   0,0
	  text	  wdnw
	 i_end

*
* loose item list

	l_ilst	 wdth

	l_item	 wdes,0 	      ; ESC
	 size	 4*6,10
	 origin  4,2
	 justify 0,0
	 type	 text
	 selkey  esc
	 text	 esc
	 item	 mli.wdes
	 action  wdes

	l_item	 wdok,1 	      ; OK
	 size	 4*6,10
	 origin  wd_mxs-4-4*6,2
	 justify 0,0
	 type	 text-meu.ok
	 selkey  ok
	 text	 ok
	 item	 mli.wdok
	 action  wdok

	l_item	 wdfr,2 	      ; from <column>
	 size	 4*6,10
	 origin  6*6,28
	 justify 1,0
	 type	 text
	 selkey  wdfr
	 text	 0
	 item	 mli.wdfr
	 action  wdfr

	l_item	 wdto,3 	      ; to column
	 size	 4*6,10
	 origin  17*6,28
	 justify 1,0
	 type	 text
	 selkey  wdto
	 text	 0
	 item	 mli.wdto
	 action  wdto

	l_item	 wdnw,4 	      ; new width
	 size	 4*6,10
	 origin  17*6,40
	 justify 1,0
	 type	 text
	 selkey  wdnw
	 text	 0
	 item	 mli.wdnw
	 action  wdnw

	l_end

*
* if we need some space in the status area, let's do it before setwrk
*
	 alcstat  wdfr,6
	 alcstat  wdto,6
	 alcstat  wdnw,6
	 alcstat  wdrg,6

	 setwrk
*
	 end
