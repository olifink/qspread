* spread	Tue, 1993 May 25 20:04:49
*    - digit window

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
mys	equ	80				;	  y-size
sxs	equ	3*cxs				; standard loose item size
dxs	equ	20*cxs				; digit name item size
fxp	equ	1*(sxs+4)+4			; flag x-position
fxs	equ	mxs-(2*(sxs+4)+8)		; flag x-size
nxs	equ	cxs*11+8			; flag name x-size
nxp	equ	fxp+(fxs-nxs)/2 		; flag name x-position
ixs	equ	mxs-8				; info border x-size
iyp	equ	14				; info border y-size
iys	equ	mys-iyp-2			; info border y-position
grnstp	equ	92

	xref.s	met.ditt
	xref.s	meu.ok
	xref.s	meu.mcn0,meu.mcn1,meu.mcn2,meu.mcn3,meu.mcn4
	xref.s	meu.mcn5,meu.mcn6,meu.mcn7,meu.mcn8,meu.mcn9
			    

	section menu


;
; fixed part of window defintion

	window	digt				; menu digit
	 size	mxs,mys 			; window size
	 origin mxs-cxs,cxs			; initial pointer position
	 wattr	2				\ shadow width
		1,c.mbord,c.mback      ; border width, border colour; paper colour

	 sprite 0

	 border 1,c.mhigh
	iattr	c.mpunav,c.miunav,0,0	; unavailable
	iattr	c.mpavbl,c.miavbl,0,0	; available
	iattr	c.mpslct,c.mislct,0,0	; selected

	help	0				; no help window defintion

; repeated part of window definion

	size_opt	a			; internal layout
	 size	mxs,mys,0,0			; size
	 info	digt
	 loos	digt
	 appn	0
	s_end


; information window defintion

	i_wlst	digt

	i_windw 				; the flag
	 size	fxs,14,0,0
	 origin fxp,0
	 wattr	0,0,0,c.mfill
	 olst	0

	i_windw 				; the flag name
	 size	nxs,11
	 origin nxp,2
	 wattr	0,0,0,c.iback
	 olst	flag

	i_windw 				; info border
	 size	ixs,iys,0,0
	 origin 4,iyp
	 wattr	0,1,c.ibord,c.iback
	 olst	digt

	i_end

; information object list

	i_olst	flag

	i_item
	 size	met.ditt+met.ditt,10
	 origin nxs/2-met.ditt,1
	 type	text
	 ink	c.tink
	 csize	0,0
	 text	ditt
	i_end

	i_olst	digt

	i_item
	 size	cxs,10
	 origin 2,2
	 type	text-meu.mcn0
	 ink	c.ilow
	 csize	0,0
	 text	mcn0
	i_item
	 size	cxs,10
	 origin 2,12*1+2
	 type	text-meu.mcn1
	 ink	c.ilow
	 csize	0,0
	 text	mcn1
	i_item
	 size	cxs,10
	 origin 2,12*2+2
	 type	text-meu.mcn2
	 ink	c.ilow
	 csize	0,0
	 text	mcn2
	i_item
	 size	cxs,10
	 origin 2,12*3+2
	 type	text-meu.mcn3
	 ink	c.ilow
	 csize	0,0
	 text	mcn3
	i_item
	 size	cxs,10
	 origin 2,12*4+2
	 type	text-meu.mcn4
	 ink	c.ilow
	 csize	0,0
	 text	mcn4
	i_item
	 size	cxs,10
	 origin 2+cxs+ixs/2,12*0+2
	 type	text-meu.mcn5
	 ink	c.ilow
	 csize	0,0
	 text	mcn5
	i_item
	 size	cxs,10
	 origin 2+cxs+ixs/2,12*1+2
	 type	text-meu.mcn6
	 ink	c.ilow
	 csize	0,0
	 text	mcn6
	i_item
	 size	cxs,10
	 origin 2+cxs+ixs/2,12*2+2
	 type	text-meu.mcn7
	 ink	c.ilow
	 csize	0,0
	 text	mcn7
	i_item
	 size	cxs,10
	 origin 2+cxs+ixs/2,12*3+2
	 type	text-meu.mcn8
	 ink	c.ilow
	 csize	0,0
	 text	mcn8
	i_item
	 size	cxs,10
	 origin 2+cxs+ixs/2,12*4+2
	 type	text-meu.mcn9
	 ink	c.ilow
	 csize	0,0
	 text	mcn9

	i_end


; loose item list

	l_ilst	digt

	l_item	  dies,0
	 size	  sxs,10
	 origin   4+(sxs+4)*0,2
	 justify  0,0
	 type	  text
	 selkey   esc
	 text	  esc
	 item	  mli.dies
	 action   quit

	l_item	  diok,1
	 size	  sxs,10
	 origin   mxs-(sxs+4)*1,2,0,0
	 justify  0,0
	 type	  text-meu.ok
	 selkey   ok
	 text	  ok
	 item	  mli.diok
	 action   do

	l_item	  dig0,2
	 size	  dxs,10
	 origin   16,iyp+2
	 justify  1,0
	 type	  text
	 selkey   mcn0
	 text	  0
	 item	  mli.dig0
	 action   digt

	l_item	  dig1,3
	 size	  dxs,10
	 origin   16,iyp+2+12*1
	 justify  1,0
	 type	  text
	 selkey   mcn1
	 text	  0
	 item	  mli.dig1
	 action   digt

	l_item	  dig2,4
	 size	  dxs,10
	 origin   16,iyp+2+12*2
	 justify  1,0
	 type	  text
	 selkey   mcn2
	 text	  0
	 item	  mli.dig2
	 action   digt

	l_item	  dig3,5
	 size	  dxs,10
	 origin   16,iyp+2+12*3
	 justify  1,0
	 type	  text
	 selkey   mcn3
	 text	  0
	 item	  mli.dig3
	 action   digt

	l_item	  dig4,6
	 size	  dxs,10
	 origin   16,iyp+2+12*4
	 justify  1,0
	 type	  text
	 selkey   mcn4
	 text	  0
	 item	  mli.dig4
	 action   digt

	l_item	  dig5,7
	 size	  dxs,10
	 origin   22+ixs/2,iyp+2+12*0
	 justify  1,0
	 type	  text
	 selkey   mcn5
	 text	  0
	 item	  mli.dig5
	 action   digt

	l_item	  dig6,8
	 size	  dxs,10
	 origin   22+ixs/2,iyp+2+12*1
	 justify  1,0
	 type	  text
	 selkey   mcn6
	 text	  0
	 item	  mli.dig6
	 action   digt

	l_item	  dig7,9
	 size	  dxs,10
	 origin   22+ixs/2,iyp+2+12*2
	 justify  1,0
	 type	  text
	 selkey   mcn7
	 text	  0
	 item	  mli.dig7
	 action   digt

	l_item	  dig8,10
	 size	  dxs,10
	 origin   22+ixs/2,iyp+2+12*3
	 justify  1,0
	 type	  text
	 selkey   mcn8
	 text	  0
	 item	  mli.dig8
	 action   digt

	l_item	  dig9,11
	 size	  dxs,10
	 origin   22+ixs/2,iyp+2+12*4
	 justify  1,0
	 type	  text
	 selkey   mcn9
	 text	  0
	 item	  mli.dig9
	 action   digt


	l_end

; define symbols and work area size in COMMON

	alcstat digt,30*10
	setwrk

	end
