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


sz_mxs	 equ	  160
sz_mys	 equ	  46
sz_fxs	 equ	  sz_mxs-2*(8+4*6)+2
sz_lxs	 equ	  sz_mxs-12
grnstp	 equ	  92


	 xref.s   met.sztt
	 xref.s   meu.szro,meu.szco,meu.ok,meu.esc

	 section  menu

	 window   size			     ; width window defintion
	 size	  sz_mxs,sz_mys 	     ; window size
	 origin   sz_mxs-6,6		     ; pointer position
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

	 size	  sz_mxs,sz_mys 	     ; default size, not scalable
	 info	  size
	 loos	  size
	 appn	  0

	 s_end

*
* information window defintion

	 i_wlst   size

	 i_windw			     ; the flag
	  size	   sz_fxs,14
	  origin   4*6+8,0
	  wattr    0,0,0,c.mfill
	  olst	   0

	 i_windw			     ; the flag name
	  size	   10*6,11
	  origin   4*6+8+(sz_fxs-10*6)/2,2
	  wattr    0,0,0,c.tback
	  olst	   flag

	 i_windw			     ; some pretty border
	  size	   sz_mxs-8,sz_mys-16
	  origin   4,14
	  wattr    0,1,c.ibord,c.iback
	  olst	   coro

	 i_end

*
* information object lists

	 i_olst   flag

	 i_item
	  size	   met.sztt+met.sztt,10
	  origin   5*6-met.sztt,1
	  type	   text
	  ink	   c.tink
	  csize    0,0
	  text	   sztt
	 i_end

	 i_olst   coro

	 i_item
	  size	  8*6,10
	  origin  2,2
	  type	  text-meu.szco
	  ink	  c.iink
	  csize   0,0
	  text	  szco
	 i_item
	  size	  8*6,10
	  origin  2+16*6,2
	  type	  text-meu.szro
	  ink	  c.iink
	  csize   0,0
	  text	  szro
	 i_item
	  size	  10,10
	  origin  2+12*6,23
	  type	  sprite
	  spare
	  spare
	  spare
	  spare
	  dc.w	0
	  sprite  tims
	 i_end

*
* loose item list

	 l_ilst   size

	 l_item   szes,0		     ; ESC
	  size	  4*6,10
	  origin  4,2
	  justify 0,0
	  type	  text
	  selkey  esc
	  text	  esc
	  item	  mli.szes
	  action  szes

	 l_item   szok,1		     ; OK
	  size	  4*6,10
	  origin  sz_mxs-4-4*6,2
	  justify 0,0
	  type	  text-meu.ok
	  selkey  ok
	  text	  ok
	  item	  mli.szok
	  action  szok

	 l_item   szco,2		     ; nr of columns
	  size	  6*6,10
	  origin  2*6,32
	  justify 1,0
	  type	  text
	  selkey  szco
	  text	  0
	  item	  mli.szco
	  action  szco

	 l_item   szro,3		     ; nr of rows
	  size	  6*6,10
	  origin  17*6,32
	  justify 1,0
	  type	  text
	  selkey  szro
	  text	  0
	  item	  mli.szro
	  action  szro

	 l_end

*
* if we need some space in the status area, let's do it before setwrk
*
	 alcstat  szco,8
	 alcstat  szro,8
	 alcstat  sznc,2
	 alcstat  sznr,2
	 setwrk
*
	 end
