* Spreadsheet					      30/01-92
*	 - status menu window definition
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

st_mxs	 equ	  402
st_mys	 equ	  88+2*12
st_fxs	 equ	  st_mxs-2*(8+4*6)+2
st_lxs	 equ	  192		    ; ((st_mxs)/2)-12
grnstp	 equ	  92


	 xref.s   met.sttt
	 xref.s   meu.stco,meu.stun,meu.stms
	 xref.s   meu.stac,meu.stez,meu.stfn
	 xref.s   meu.stcr,meu.strd,meu.stsm
	 xref.s   meu.stdi,meu.sttb,meu.stld
	 xref.s   meu.stjs,meu.stbk,meu.ok
	 xref.s   meu.stcmn,meu.stcmd,meu.stcmr

	 section  menu

	 window   stat			     ; status window defintion
	 size	  st_mxs,st_mys 	     ; window size
	 origin   st_mxs-6,6		     ; pointer position
	 wattr	  1			     \ shadow width
		  1,c.mbord		     \ border width and colour
		  c.mback		     ; paper colour

	 sprite   0

	 border   1,c.mhigh
	iattr	c.mpunav,c.miunav,0,0	; unavailable
	iattr	c.mpavbl,c.miavbl,0,0	; available
	iattr	c.mpslct,c.mislct,0,0	; selected

	 help	  0			     ; no help window defintion

	 size_opt a			     ; layout will be internal

	 size	  st_mxs,st_mys 	     ; default size, not scalable
	 info	  stat
	 loos	  stat
	 appn	  0

	 s_end

*
* information window defintion

	 i_wlst   stat

	 i_windw			     ; the flag
	  size	   st_fxs,14
	  origin   4*6+8,0
	  wattr    0,0,0,c.mfill
	  olst	   0

	 i_windw			     ; the flag name
	  size	   8*6,11
	  origin   4*6+8+(st_fxs-8*6)/2,2
	  wattr    0,0,0,c.tback
	  olst	   flag

	 i_windw			     ; some pretty border
	  size	   st_mxs-8,st_mys-16
	  origin   4,14
	  wattr    0,1,c.ibord,c.iback
	  olst	   ordr

	 i_windw
	   size    2,st_mys-16
	   origin  st_lxs+8,14
	   wattr   0,0,0,c.iback
	   olst    0

	 i_end

*
* information object lists

	 i_olst   flag

	 i_item
	  size	   met.sttt+met.sttt,10
	  origin   4*6-met.sttt,1
	  type	   text
	  ink	   c.tink
	  csize    0,0
	  text	   sttt
	 i_end

	 i_olst   ordr

	 i_item
	  size	  st_mxs-2*6,10
	  origin  3,1
	  type	  text-meu.stco
	  ink	  c.iink
	  csize   0,0
	  text	  stco
	 i_item
	  size	  st_mxs-2*6,10
	  origin  3,1+12*2
	  type	  text
	  ink	  c.iink
	  csize   0,0
	  text	  stcm
	 i_end


*
* loose item list

	 l_ilst   stat

	 l_item   stes,0		     ; ESC
	  size	  4*6,10
	  origin  4,2
	  justify 0,0
	  type	  text
	  selkey  esc
	  text	  esc
	  item	  mli.stes
	  action  stes

	 l_item   stok,1		     ; OK
	  size	  4*6,10
	  origin  st_mxs-4-4*6,2
	  justify 0,0
	  type	  text-meu.ok
	  selkey  ok
	  text	  ok
	  item	  mli.stok
	  action  stok

	 l_item   stco,2		     ; calculation order	*
	  size	  6*6+2,10
	  origin  st_mxs-8-7*6-st_lxs,3+12
	  justify 0,0
	  type	  text
	  selkey  stco
	  text	  0
	  item	  mli.stco
	  action  stco

	 l_item   stun,3		     ; 5=global units		*
	  size	  st_lxs,10
	  origin  12+st_lxs,3+1*12
	  justify 1,0
	  type	  text-meu.stun
	  selkey  stun
	  text	  stun
	  item	  mli.stun
	  action  stun

	 l_item   stms,4		     ; 6=global currency symbols *
	  size	  st_lxs,10
	  origin  12+st_lxs,3+2*12
	  justify 1,0
	  type	  text-meu.stms
	  selkey  stms
	  text	  stms
	  item	  mli.stms
	  action  stms

	 l_item   stjs,5		     ; 7=global justification	 *
	  size	  st_lxs,10
	  origin  12+st_lxs,3+3*12
	  justify 1,0
	  type	  text-meu.stjs
	  selkey  stjs
	  text	  stjs
	  item	  mli.stjs
	  action  stjs

	 l_item   stbk,6		     ; 9=backup file		*
	  size	  st_lxs,10
	  origin  6,3+5*12
	  justify 1,0
	  type	  text-meu.stbk
	  selkey  stbk
	  text	  stbk
	  item	  mli.stbk
	  action  stbk

	 l_item   stac,7		     ; 2=auto calculate 	*
	  size	  st_lxs,10
	  origin  6,3+2*12
	  justify 1,0
	  type	  text-meu.stac
	  selkey  stac
	  text	  stac
	  item	  mli.stac
	  action  stac

	 l_item   stez,8		     ; 3=empty if zero		*
	  size	  st_lxs,10
	  origin  12+st_lxs,3+6*12
	  justify 1,0
	  type	  text-meu.stez
	  selkey  stez
	  text	  stez
	  item	  mli.stez
	  action  stez

	 l_item   stfn,9		     ; 4=format numbers 	*
	  size	  st_lxs,10
	  origin  12+st_lxs,3+4*12
	  justify 1,0
	  type	  text-meu.stfn
	  selkey  stfn
	  text	  stfn
	  item	  mli.stfn
	  action  stdf

	 l_item   stcr,10		     ; 8=confirmation request	*
	  size	  st_lxs,10
	  origin  6,3+6*12
	  justify 1,0
	  type	  text-meu.stcr
	  selkey  stcr
	  text	  stcr
	  item	  mli.stcr
	  action  stcr

	 l_item   strd,11		     ; round decimal places	*
	  size	  st_lxs-10*6,10
	  origin  12+st_lxs,3+5*12
	  justify 1,0
	  type	  text-meu.strd
	  selkey  strd
	  text	  strd
	  item	  mli.strd
	  action  strd

	 l_item   strn,12		     ; number of place to round *
	  size	  6*6,10
	  origin  st_mxs-6*6-8,3+5*12
	  justify 1,0
	  type	  text
	  selkey  0
	  text	  0
	  item	  mli.strn
	  action  strd

	 l_item   stsm,13		     ; empty if same as above	*
	  size	  st_lxs,10
	  origin  12+st_lxs,3+7*12
	  justify 1,0
	  type	  text-meu.stsm
	  selkey  stsm
	  text	  stsm
	  item	  mli.stsm
	  action  stsm

	 l_item   stdi,14		     ; digit names
	  size	  st_lxs,10
	  origin  12+st_lxs,3+8*12
	  justify 1,0
	  type	  text-meu.stdi
	  selkey  stdi
	  text	  stdi
	  item	  mli.stdi
	  action  stdi

	 l_item   sttb,15		     ; toolbar
	  size	  st_lxs,10
	  origin  6,3+8*12
	  justify 1,0
	  type	  text-meu.sttb
	  selkey  sttb
	  text	  sttb
	  item	  mli.sttb
	  action  sttb

	 l_item   stld,16		     ; local directories
	  size	  st_lxs,10
	  origin  6,3+7*12
	  justify 1,0
	  type	  text-meu.stld
	  selkey  stld
	  text	  stld
	  item	  mli.stld
	  action  stld

       l_item	stcmn,17	; no auto-cursor move
	size	48,10
	origin	6,3+4*12
	justify 1,0
	type	text-meu.stcmn
	selkey	stcmn
	text	stcmn
	item	mli.stcmn
	action	automov

       l_item	stcmd,18	; cursor-move down
	size	48,10
	origin	6+52,3+4*12
	justify 1,0
	type	text-meu.stcmd
	selkey	stcmd
	text	stcmd
	item	mli.stcmd
	action	automov

       l_item	stcmr,19	; cursor-move right
	size	48,10
	origin	6+52*2,3+4*12
	justify 1,0
	type	text-meu.stcmr
	selkey	stcmr
	text	stcmr
	item	mli.stcmr
	action	automov

       l_end


*
* if we need some space in the status area, let's do it before setwrk
*
	 alcstat  stms,2
	 alcstat  stcr,2
	 alcstat  strd,2
	 alcstat  strn,20
	 setwrk
*
	 end
