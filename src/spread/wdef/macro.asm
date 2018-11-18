* spread	Thu, 1992 Apr 30 15:47:09
*    - macro window

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
mxs	equ	400				; minimum x-size
mys	equ	78				;	  y-size
sxs	equ	3*cxs				; standard loose item size
fxp	equ	1*(sxs+4)+4			; flag x-position
fxs	equ	mxs-(2*(sxs+4)+8)		; flag x-size
nxs	equ	cxs*14+8			; flag name x-size
nxp	equ	fxp+(fxs-nxs)/2 		; flag name x-position
ixs	equ	mxs-8				; info border x-size
iyp	equ	14				; info border y-size
iys	equ	mys-iyp-2			; info border y-position
grnstp	equ	92

	xref.s	met.mctt
	xref.s	meu.mcn1,meu.mcn2,meu.mcn3,meu.mcn4,meu.mcn5
	xref.s	meu.ok

	section menu


;
; fixed part of window defintion

	window	macr				; menu macro
	 size	mxs,mys 			; window size
	 origin mxs-cxs,cxs			; initial pointer position
	 wattr	2				\ shadow width
		1,c.mbord			\ border width, border colour
		c.mback 			 ; paper colour

	 sprite 0

	 border 1,c.mhigh
	iattr	c.mpunav,c.miunav,0,0	; unavailable
	iattr	c.mpavbl,c.miavbl,0,0	; available
	iattr	c.mpslct,c.mislct,0,0	; selected
	  
	help	0				; no help window defintion

; repeated part of window definion

	size_opt	a			; internal layout
	 size	mxs,mys,0,0			; size
	 info	macr
	 loos	macr
	 appn	0
	s_end


; information window defintion

	i_wlst	macr

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
	 olst	mcnr

	i_end

; information object list

	i_olst	flag

	i_item
	 size	met.mctt+met.mctt,10
	 origin nxs/2-met.mctt,1
	 type	text
	 ink	c.tink
	 csize	0,0
	 text	mctt
	i_end

	i_olst	mcnr

	i_item
	 size	10,10
	 origin 2,2
	 type	text-meu.mcn1
	 ink	c.ilow
	 csize	0,0
	 text	mcn1
	i_item
	 size	10,10
	 origin 2,14
	 type	text-meu.mcn2
	 ink	c.ilow
	 csize	0,0
	 text	mcn2
	i_item
	 size	10,10
	 origin 2,26
	 type	text-meu.mcn3
	 ink	c.ilow
	 csize	0,0
	 text	mcn3
	i_item
	 size	10,10
	 origin 2,38
	 type	text-meu.mcn4
	 ink	c.ilow
	 csize	0,0
	 text	mcn4
	i_item
	 size	10,10
	 origin 2,50
	 type	text-meu.mcn5
	 ink	c.ilow
	 csize	0,0
	 text	mcn5

	i_end


; loose item list

	l_ilst	macr

	l_item	  mces,0
	 size	  sxs,10
	 origin   4+(sxs+4)*0,2
	 justify  0,0
	 type	  text
	 selkey   esc
	 text	  esc
	 item	  mli.mces
	 action   esc

	l_item	  mcok,1
	 size	  sxs,10
	 origin   mxs-(sxs+4)*1,2,0,0
	 justify  0,0
	 type	  text-meu.ok
	 selkey   ok
	 text	  ok
	 item	  mli.mcok
	 action   ok

	l_item	  mcn1,2
	 size	  ixs-14,10
	 origin   16,iyp+2
	 justify  1,0
	 type	  text
	 selkey   mcn1
	 text	  0
	 item	  mli.mcn1
	 action   mcnr

	l_item	  mcn2,3
	 size	  ixs-14,10
	 origin   16,iyp+2+12
	 justify  1,0
	 type	  text
	 selkey   mcn2
	 text	  0
	 item	  mli.mcn2
	 action   mcnr

	l_item	  mcn3,4
	 size	  ixs-14,10
	 origin   16,iyp+2+24
	 justify  1,0
	 type	  text
	 selkey   mcn3
	 text	  0
	 item	  mli.mcn3
	 action   mcnr

	l_item	  mcn4,5
	 size	  ixs-14,10
	 origin   16,iyp+2+36
	 justify  1,0
	 type	  text
	 selkey   mcn4
	 text	  0
	 item	  mli.mcn4
	 action   mcnr

	l_item	  mcn5,6
	 size	  ixs-14,10
	 origin   16,iyp+2+48
	 justify  1,0
	 type	  text
	 selkey   mcn5
	 text	  0
	 item	  mli.mcn5
	 action   mcnr
	l_end

; define symbols and work area size in COMMON
	 alcstat  mcnr,80*5
	 alcstat  mcmd,2
	setwrk

	end
