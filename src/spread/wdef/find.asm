* spread	Mon, 1993 Jun 14 17:57:05
*    - find window

	include win1_mac_menu_long
	include win1_keys_colour
	include win1_keys_wman
	include win1_keys_wwork
	include win1_keys_wstatus
	include win1_keys_wdef_long

white	equ	7
red	equ	2
green	equ	4
black	equ	0

cxs	equ	6				; character x-size
mxs	equ	300				; minimum x-size
mys	equ	54				;	  y-size
sxs	equ	3*cxs				; standard loose item size
fxp	equ	1*(sxs+4)+4			; flag x-position
fxs	equ	mxs-(2*(sxs+4)+8)		; flag x-size
nxs	equ	cxs*5+8 			; flag name x-size
nxp	equ	fxp+(fxs-nxs)/2 		; flag name x-position
ixs	equ	mxs-8				; info border x-size
iyp	equ	14				; info border y-size
iys	equ	mys-iyp-2			; info border y-position
grnstp	equ	92

	xref.s	met.cfnd
	xref.s	meu.ok,meu.fndt
	xref.s	meu.ffrm,meu.fupw,meu.fdwn

	xdef	lel_fdir

	section menu


;
; fixed part of window defintion

	window	find				; menu find
	 size	mxs,mys 			; window size
	 origin mxs-cxs,cxs			; initial pointer position
	 wattr	2				\ shadow width
		1,c.mbord			  \ border width, border colour
		c.mback 			  ; paper colour

	 sprite 0

	 border 1,c.mhigh
	iattr	c.mpunav,c.miunav,0,0	; unavailable
	iattr	c.mpavbl,c.miavbl,0,0	; available
	iattr	c.mpslct,c.mislct,0,0	; selected

	help	0				; no help window defintion

; repeated part of window definion

	size_opt	a			; internal layout
	 size	mxs,mys,0,0			; size
	 info	find
	 loos	find
	 appn	0
	s_end


; information window defintion

	i_wlst	find

	i_windw 				; the flag
	 size	fxs,14,0,0
	 origin fxp,0
	 wattr	0,0,0,c.mfill
	 olst	0

	i_windw 				; the flag name
	 size	nxs,11
	 origin nxp,2
	 wattr	0,0,0,c.tback
	 olst	flag

	i_windw 				; info border
	 size	ixs,iys,0,0
	 origin 4,iyp
	 wattr	0,1,c.ibord,c.iback
	 olst	fndt

	i_windw 				; divider
	 size	ixs,1,0,0
	 origin 4,iyp+24
	 wattr	0,0,0,c.iback
	 olst	0

	i_end

; information object list

	i_olst	flag

	i_item
	 size	met.cfnd+met.cfnd,10
	 origin nxs/2-met.cfnd,1
	 type	text
	 ink	c.tink
	 csize	0,0
	 text	cfnd
	i_end


	i_olst	fndt

	i_item
	 size	120,10
	 origin 2,0
	 type	text-meu.fndt
	 ink	c.iink
	 csize	0,0
	 text	fndt
	i_end

; loose item list

	l_ilst	find

	l_item	  fesc,0
	 size	  sxs,10
	 origin   4+(sxs+4)*0,2
	 justify  0,0
	 type	  text
	 selkey   esc
	 text	  esc
	 item	  mli.fesc
	 action   quit

	l_item	  fok,1
	 size	  sxs,10
	 origin   mxs-(sxs+4)*1,2,0,0
	 justify  0,0
	 type	  text-meu.ok
	 selkey   ok
	 text	  ok
	 item	  mli.fok
	 action   do

	l_item	  ftxt,2
	 size	  ixs-4,10
	 origin   6,iyp+12
	 justify  1,0
	 type	  text
	 selkey   fndt
	 text	  0
	 item	  mli.ftxt
	 action   read

	l_item	  ffrm,3
	 size	  (ixs-4)/3-4,10
	 origin   8,iyp+26
	 justify  0,0
	 type	  text-meu.ffrm
	 selkey   ffrm
	 text	  ffrm
	 item	  mli.ffrm
	 action   0

	l_item	  fupw,4
	 size	  (ixs-4)/3-4,10
	 origin   8+(ixs-4)/3,iyp+26
	 justify  0,0
	 type	  text-meu.fupw
	 selkey   fupw
	 text	  fupw
	 item	  mli.fupw
	 action   fdir

	l_item	  fdwn,5
	 size	  (ixs-4)/3-4,10
	 origin   8+(ixs-4)/3+(ixs-4)/3,iyp+26
	 justify  0,0
	 type	  text-meu.fdwn
	 selkey   fdwn
	 text	  fdwn
	 item	  mli.fdwn
	 action   fdir


	l_end

; define symbols and work area size in COMMON

	alcstat find,ixs/cxs+4

	setwrk

; exclusive item list
lel_fdir dc.w	 mli.fupw
	 dc.w	 mli.fdwn
	 dc.w	 -1

	end
