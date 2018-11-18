* propt Mon, 1992 Apr 06 19:58:12
*    - popt window

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
mxs	equ	356				; minimum x-size
mys	equ	91				;	  y-size
sxs	equ	4*cxs				; standard loose item size
fxp	equ	1*(sxs+4)+4			; flag x-position
fxs	equ	mxs-(2*(sxs+4)+8)		; flag x-size
nxs	equ	cxs*15+8			; flag name x-size
nxp	equ	fxp+(fxs-nxs)/2 		; flag name x-position
ixs	equ	mxs-8				; info border x-size
iyp	equ	14				; info border y-size
iys	equ	mys-iyp-2			; info border y-position
grnstp	equ	92

	xref.s	met.pott
	xref.s	meu.ok,meu.popw,meu.popl
	xref.s	meu.popp,meu.poif,meu.poef,meu.popt
	xref.s	meu.prpica,meu.prelit,meu.prcond,meu.prdraf,meu.prff

	section menu


;
; fixed part of window defintion

	window	popt				; menu popt
	 size	mxs,mys 			; window size
	 origin mxs-cxs,cxs			; initial pointer position
	 wattr	2				\ shadow width
		1,c.mbord			\ border width, border colour
		c.mback 			; paper colour

	 sprite 0

	 border 1,c.mhigh
	iattr	c.mpunav,c.miunav,0,0	; unavailable
	iattr	c.mpavbl,c.miavbl,0,0	; available
	iattr	c.mpslct,c.mislct,0,0	; selected

	help	0				; no help window defintion

; repeated part of window definion

	size_opt	a			; internal layout
	 size	mxs,mys,0,0			; size
	 info	popt
	 loos	popt
	 appn	0
	s_end


; information window defintion

	i_wlst	popt

	i_windw 				; the flag
	 size	fxs,14,0,0
	 origin fxp,0
	 wattr	0,0,0,c.mfill
	 olst	0

	i_windw 				; the flag name
	 size	met.pott+met.pott+4,11
	 origin mxs/2-met.pott-2,2
	 wattr	0,0,0,c.tback
	 olst	flag

	i_windw 				; info border
	 size	ixs,48,0,0
	 origin 4,iyp
	 wattr	0,1,c.ibord,c.iback
	 olst	poiw

	i_windw 				; info border
	 size	ixs,24,0,0
	 origin 4,65
	 wattr	0,1,c.ibord,c.iback
	 olst	poie

	i_end

; information object list

	i_olst	flag

	i_item
	 size	met.pott+met.pott,10
	 origin 2,1
	 type	text
	 ink	c.tink
	 csize	0,0
	 text	pott
	i_end

	i_olst	poiw			; printer information items

	i_item			; print to
	 size	60,10
	 origin 2,1
	 type	text-meu.popt
	 ink	c.iink
	 csize	0,0
	 text	popt
	i_item			; printer driver
	 size	120,10
	 origin 2,13
	 type	text-meu.popp
	 ink	c.iink
	 csize	0,0
	 text	popp
	i_item
	 size	140,10
	 origin 2,25
	 type	text-meu.popw
	 ink	c.iink
	 csize	0,0
	 text	popw
	i_item
	 size	140,10
	 origin (mxs-8)/2+6+6,25
	 type	text-meu.popl
	 ink	c.iink
	 csize	0,0
	 text	popl
	i_end

	i_olst	poie
	i_item
	 size	ixs-20,10
	 origin 2,1
	 type	text-meu.poif
	 ink	c.iink
	 csize	0,0
	 text	poif
	i_item
	 size	ixs-20,10
	 origin 2,13
	 type	text-meu.poef
	 ink	c.iink
	 csize	0,0
	 text	poef
	i_end


; loose item list

	l_ilst	popt

	l_item	  esc,0
	 size	  sxs,10
	 origin   4+(sxs+4)*0,2
	 justify  0,0
	 type	  text
	 selkey   esc
	 text	  esc
	 item	  mli.esc
	 action   poes

	l_item	  ok,1
	 size	  sxs,10
	 origin   mxs-(sxs+4)*1,2,0,0
	 justify  0,0
	 type	  text-meu.ok
	 selkey   ok
	 text	  ok
	 item	  mli.ok
	 action   pook

	l_item	  popw,2
	 size	  30,10
	 origin   (mxs-8)/2-26,39
	 justify  -1,0
	 type	  text
	 selkey   popw
	 text	  0
	 item	  mli.popw
	 action   popw

	l_item	  popl,3
	 size	  30,10
	 origin   mxs-5*cxs-8,39
	 justify  -1,0
	 type	  text
	 selkey   popl
	 text	  0
	 item	  mli.popl
	 action   popl

	l_item	  popp,4		; printer port
	 size	  cxs*16,10
	 origin   116,15
	 justify  1,0
	 type	  text
	 selkey   popt
	 text	  0
	 item	  mli.popp
	 action   popp

	l_item	  popf,5		; printer driver name
	 size	  39*6,10
	 origin   mxs-6-39*6,27
	 justify  1,0
	 type	  text
	 selkey   popp
	 text	  0
	 item	  mli.popf
	 action   popf

	l_item	  poif,6		; import filter driver
	 size	  cxs*39,10
	 origin   mxs-39*cxs-6,66
	 justify  1,0
	 type	  text
	 selkey   poif
	 text	  0
	 item	  mli.poif
	 action   poif

	l_item	  poef,7		; export filter driver
	 size	  cxs*39,10
	 origin   mxs-39*cxs-6,78
	 justify  1,0
	 type	  text
	 selkey   poef
	 text	  0
	 item	  mli.poef
	 action   poef

      l_item	prpica,8		    ; DO NOT CHANGE THE ORDER
	size	50,10			     ; OF THE FOLLOWING 4 ITEMS
	origin	6,51
	justify 1,0
	type	text-meu.prpica
	selkey	prpica
	text	prpica
	item	mli.prpica
	action	prpica
      l_item	prelit,9
	size	50,10
	origin	6+56,51
	justify 1,0
	type	text-meu.prelit
	selkey	prelit
	text	prelit
	item	mli.prelit
	action	prpica
      l_item	prcond,10
	size	82,10
	origin	6+56*2,51
	justify 0,0
	type	text-meu.prcond
	selkey	prcond
	text	prcond
	item	mli.prcond
	action	prpica

      l_item	prdraf,11
	size	60,10
	origin	6+66*3+16,51
	justify 0,0
	type	text-meu.prdraf
	selkey	prdraf
	text	prdraf
	item	mli.prdraf
	action	0
      l_item	prff,12
	size	60,10
	origin	mxs-66,51
	justify 0,0
	type	text-meu.prff
	selkey	prff
	text	prff
	item	mli.prff
	action	0

	l_end

; define symbols and work area size in COMMON

	alcstat popf,40 	    ; printer filter filename
	alcstat popp,22 	    ; printer port name
	alcstat popw,2+10	    ; paper width
	alcstat popl,2+10	    ; paper length
	alcstat poef,40 	    ; export filter filename
	alcstat poif,40 	    ; import filter filename

	setwrk

	end
