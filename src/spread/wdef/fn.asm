* Spreadsheet					      20/12-92
*	 - format number window definition
*
	 include  win1_mac_menu_long
	 include  win1_keys_colour
	 include  win1_keys_wman
	 include  win1_keys_wwork
	 include  win1_keys_wstatus
	 include  win1_keys_wdef_long

	 xref.s   met.fntt
	 xref.s   meu.fndp,meu.fnbr,meu.fnsn
	 xref.s   meu.fnsp,meu.fnge,meu.esc,meu.ok

white	equ	7
red	equ	2
green	equ	4
black	equ	0


fn_mxs	 equ	  156
fn_mys	 equ	  103+13
fn_fxs	 equ	  fn_mxs-2*(8+4*6)+2
fn_lxs	 equ	  fn_mxs-12
grnstp	 equ	  92

	 section  menu

	 window   fnum			     ; format number window defintion
	 size	  fn_mxs,fn_mys 	     ; window size
	 origin   fn_mxs-6,6		     ; pointer position
	 wattr	  2			     \ shadow width
		  1,c.mbord		     \ border width and colour
		  c.mback		      ; paper colour

	 sprite   0

	 border   1,c.mhigh
	iattr	c.mpunav,c.miunav,0,0	; unavailable
	iattr	c.mpavbl,c.miavbl,0,0	; available
	iattr	c.mpslct,c.mislct,0,0	; selected

	 help	  0			     ; no help window defintion

	 size_opt a			     ; layout will be internal

	 size	  fn_mxs,fn_mys 	     ; default size, not scalable
	 info	  fnum
	 loos	  fnum
	 appn	  0

	 s_end

*
* information window defintion

	 i_wlst   fnum

	 i_windw			     ; the flag
	  size	   fn_fxs,14
	  origin   4*6+8,0
	  wattr    0,0,0,c.mfill
	  olst	   0

	 i_windw			     ; the flag name
	  size	   8*6,11
	  origin   4*6+8+(fn_fxs-8*6)/2,2
	  wattr    0,0,0,c.tback
	  olst	   flag

	 i_windw			     ; some pretty border
	  size	   fn_mxs-8,6*12+4
	  origin   4,14
	  wattr    0,1,c.ibord,c.iback
	  olst	   decp

	 i_windw			     ; the preview window
	  size	   fn_mxs-8,24
	  origin   4,6*12+4+14
	  wattr    0,1,c.ibord,c.iback
	  olst	   prev

	 i_end

*
* information object lists

	 i_olst   flag

	 i_item
	  size	   met.fntt+met.fntt,10
	  origin   4*6-met.fntt,1
	  type	   text
	  ink	   c.tink
	  csize    0,0
	  text	   fntt
	 i_end

	 i_olst   decp

	 i_item
	  size	  fn_mxs-8*6,10
	  origin  2,2
	  type	  text-meu.fndp
	  ink	  c.iink
	  csize   0,0
	  text	  fndp
	 i_end

	 i_olst   prev

	 i_item
	  size	  fn_mxs-8,10
	  origin  2,2
	  type	  text
	  ink	  c.iink
	  csize   0,0
	  text	  fnpv
	 i_item
	  size	  fn_mxs-8,10
	  origin  2,12
	  type	  text
	  ink	  c.iink
	  csize   0,0
	  text	  0
	 i_end

*
* loose item list

	 l_ilst   fnum

	 l_item   fnes,0		     ; ESC
	  size	  4*6,10
	  origin  4,2
	  justify 0,0
	  type	  text-meu.esc
	  selkey  esc
	  text	  esc
	  item	  mli.fnes
	  action  fnes

	 l_item   fndp,1		     ; decimal places
	  size	  4*6,10
	  origin  fn_mxs-4*6-6,16
	  justify -1,0
	  type	  text
	  selkey  fndp
	  text	  0
	  item	  mli.fndp
	  action  fndp

	 l_item   fnbr,3		     ; backets when -ve
	  size	  fn_lxs,10
	  origin  6,28+14
	  justify 1,0
	  type	  text-meu.fnbr
	  selkey  fnbr
	  text	  fnbr
	  item	  mli.fnbr
	  action  fnbr

	 l_item   fnsn,4		     ; sign number
	  size	  fn_lxs,10
	  origin  6,40+14
	  justify 1,0
	  type	  text-meu.fnsn
	  selkey  fnsn
	  text	  fnsn
	  item	  mli.fnsn
	  action  fnsn

	 l_item   fnsp,5		     ; insert seperators
	  size	  fn_lxs,10
	  origin  6,52+14
	  justify 1,0
	  type	  text-meu.fnsp
	  selkey  fnsp
	  text	  fnsp
	  item	  mli.fnsp
	  action  fnsp

	 l_item   fnge,6		     ; german representation
	  size	  fn_lxs,10
	  origin  6,64+14
	  justify 1,0
	  type	  text-meu.fnge
	  selkey  fnge
	  text	  fnge
	  item	  mli.fnge
	  action  fnge

	 l_item   fnok,7		     ; OK
	  size	  4*6,10
	  origin  fn_mxs-4-4*6,2
	  justify 0,0
	  type	  text-meu.ok
	  selkey  ok
	  text	  ok
	  item	  mli.fnok
	  action  fnok

	 l_item   fndp0,8		      ; decimal places
	  size	  18,10
	  origin  10,16+13
	  justify 0,0
	  type	  text-1
	  selkey  mcn0
	  text	  mcn0
	  item	  mli.fndp0
	  action  fndp0

	 l_item   fndp1,9		      ; decimal places
	  size	  18,10
	  origin  30,16+13
	  justify 0,0
	  type	  text-1
	  selkey  mcn1
	  text	  mcn1
	  item	  mli.fndp1
	  action  fndp0

	 l_item   fndp2,10		      ; decimal places
	  size	  18,10
	  origin  50,16+13
	  justify 0,0
	  type	  text-1
	  selkey  mcn2
	  text	  mcn2
	  item	  mli.fndp2
	  action  fndp0

	 l_item   fndp3,11		      ; decimal places
	  size	  18,10
	  origin  70,16+13
	  justify 0,0
	  type	  text-1
	  selkey  mcn3
	  text	  mcn3
	  item	  mli.fndp3
	  action  fndp0

	 l_end

*
* if we need some space in the status area, let's do it before setwrk
*

	 alcstat  fnge,2		     ; german representation
	 alcstat  fndp,8		     ; space for decimal places string
	 alcstat  fnpv,38		     ; preview string
	 alcstat  fnwd,2		     ; requested format word
	 alcstat  fnxx,2		     ; most recent format word
	 alcstat  fnfm,38		     ; format string compose buffer
	 setwrk
*
	 end
