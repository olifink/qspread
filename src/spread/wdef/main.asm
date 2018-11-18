* Spreadsheet					      29/11-91
*	 - main window layout
*
	 include  win1_mac_menu_long
	 include  win1_keys_colour
	 include  win1_keys_wman
	 include  win1_keys_wwork
	 include  win1_keys_wstatus
	 include  win1_keys_wdef_long
	 include  win1_spread_keys

	xref.s	met.flag

white	equ	7
red	equ	2
green	equ	4
black	equ	0

ico.xsiz equ	23
ico.ysiz equ	23	;16


	 section  menu

	 window   main			     ; main window defintion
	 size	  mw_mxs,mw_mys 	     ; window size
	 origin   66,78 		     ; pointer position
	 wattr	  3			     \ shadow width
		  1,c.mbord		     \ border width and colour
		  c.mback		     ; paper colour

	 sprite   0

	 border   1,c.mhigh
	 iattr	 c.mpunav,c.miunav,0,0	     ; unavailable
	 iattr	 c.mpavbl,c.miavbl,0,0	     ; available
	 iattr	 c.mpslct,c.mislct,0,0	     ; selected

	 help	  0			     ; no help window defintion

	 size_opt a			     ; layout now internal

	 size	  mw_mxs,mw_mys,4,4	     ; minimum size, scalable
	 info	  main
	 loos	  main
	 appn	  mawl

	 s_end

*
* information window list

	 i_wlst   main			     ; start of info window list

*	 information window #0	    flag background
	 i_windw			     ; Job flag window
	 size	  130,14,4,0		     ; x-scalable
	 origin   mw_fxp,0		     ; at fixed position
	 wattr	  0,0,0 		     \ no border
		  c.mfill
	 olst	  0			     ; no objects

*	 information window #1	    flag name
	 i_windw			     ; Job flag name window
	 size	  met.flag+met.flag+4,11
	 origin   mw_fxp+130/2-met.flag,2,2,0 ; this is rel. to flag background
	 wattr	  0,0,0 		     \ no border
		  c.tback
	 olst	  flag

*	 information window #2	    filename
	 i_windw			     ; filename window
	 size	  41*6+2,10
	 origin   200,2,4,0
	 wattr	  0,0,0 		     \ no border
		  c.iback
	 olst	  file

*	 information window #3	    Zzz divider
	 i_windw
	 size	  2,14
	 origin   mw_mxs-6-(mw_lxs+4),1,4,0  ; just left of the Zzz
	 wattr	  0,0,0 		     \ no border
		  c.iback
	 olst	  0

*	 information window #4	    border for command items
	 i_windw
	 size	  mw_mxs-8,12,4,0
	 origin   4,14
	 wattr	  0			     \ no shadow
		  1,c.ibord		     \ border
		  c.iback
	 olst	  fkey

*	 information window #5	    border for data entry items
* please don't change the number !!   (main_setup_asm)
	 i_windw
	 size	  mw_mxs-8,12,4,0
	 origin   4,46
	 wattr	  0			     \ no shadow
		  1,c.ibord		     \ border
		  c.iback
	 olst	  data

*	 information window #6	    window for indices
* please don't change the number !!   (main_setup_asm)
	 i_windw
	 size	  mw_mxs-8,mw_mys-69,4,4     ;-62 completely scalable
	 origin   4,66	;59
	 wattr	  0			     \ no shadow
		  1,c.ibord		     \ border
		  c.mipap		     ; we need white paper
	 olst	  0

*	 information window #7	    window after again
* please don't change the number !!   (main_setup_asm)
	 i_windw
	 size	  2,18,0,0		     ; not scalable
	 origin   6*24+4,27
	 wattr	  0			     \ no shadow
		  0,c.ibord		     \ border
		  c.iback		     ; paper
	 olst	  0

*	 information window #8	    window after scrap
* please don't change the number !!   (main_setup_asm)
	 i_windw
	 size	  2,18,0,0		     ; not scalable
	 origin   12*24+8,27
	 wattr	  0			     \ no shadow
		  0,c.ibord		     \ border
		  c.iback		     ; paper
	 olst	  0

*	 information window #9	    window after optimal Column with
* please don't change the number !!   (main_setup_asm)
	 i_windw
	 size	  2,18,0,0		     ; not scalable
	 origin   17*24+12,27
	 wattr	  0			     \ no shadow
		  0,c.ibord		     \ border
		  c.iback		     ; paper
	 olst	  0

	 i_end				     ; end of info window list

*
* information object list

*	 for information window #1 (flag)
	 i_olst   flag

	 i_item
	 size	  met.flag+met.flag,10
	 origin   1,1
	 type	  text
	 ink	  c.tink
	 csize	  0,0
	 text	  flag

	 i_end

*	 for information window #2 (filename)
	 i_olst   file

	 i_item
	 size	  41*6+2,10
	 origin   0,0
	 type	  text
	 ink	  c.iink
	 csize	  0,0
	 text	  nona			     ; no name for a start

	 i_end

*	 for border around command items and fkeys
	i_olst	 fkey

	i_item
	 size	  12,10
	 origin   2,2
	 type	  sprite
	 spare
	 spare
	 spare
	 spare
	 dc.w	0
	 sprite   f2

	i_item
	 size	  12,10
	 origin   2+(mw_cxs+16),2
	 type	  sprite
	 spare
	 spare
	 spare
	 spare
	 dc.w	0
	 sprite   f3

	i_item
	 size	  12,10
	 origin   2+2*(mw_cxs+16),2
	 type	  sprite
	 spare
	 spare
	 spare
	 spare
	 dc.w	0
	 sprite   f4


	i_item
	 size	  12,10
	 origin   2+3*(mw_cxs+16),2
	 type	  sprite
	 spare
	 spare
	 spare
	 spare
	 dc.w	0
	 sprite   f5

	i_item
	 size	  12,10
	 origin   2+4*(mw_cxs+16)+4,2
	 type	  sprite
	 spare
	 spare
	 spare
	 spare
	 dc.w	0
	 sprite   f6

	i_item
	 size	  12,10
	 origin   5*(mw_cxs+16)-4,2
	 type	  sprite
	 spare
	 spare
	 spare
	 spare
	 dc.w	0
	 sprite   f8

	i_item
	 size	  14,10
	 origin   mw_mxs-24-12*6,2,4,0
	 type	  sprite
	 spare
	 spare
	 spare
	 spare
	 dc.w	0
	 sprite   f10

	 i_end

*	 for border around data entry item
	i_olst	 data

	i_item
	 size	  26,10
	 origin   2,2
	 type	  sprite
	 spare
	 spare
	 spare
	 spare
	 dc.w	0
	 sprite   tab

	i_end
*
* loose item list

	l_ilst	 main			     ; start of loose items

	l_item	  move,0		     ; window move item
	 size	  mw_lxs,mw_lys 	     ; standard size
	 origin   4,2			     ; top left hand corner
	 justify  0,0			     ; centred both directions
	 type	  sprite
	 selkey   move
	 sprite   move
	 item	  mli.move
	 action   move
					     ;------------------------------
	l_item	  size,1		     ; window resize item
	 size	  mw_lxs,mw_lys
	 origin   4+(mw_lxs+4),2	     ; just right of move
	 justify  0,0
	 type	  sprite
	 selkey   size
	 sprite   size
	 item	  mli.size
	 action   size
					     ;------------------------------
	l_item	  slep,2		     ; sleep job item
	 size	  mw_lxs,mw_lys
	 origin   mw_mxs-4-mw_lxs,2,4,0      ; top right hand side
	 justify  0,0
	 type	  sprite
	 selkey   slep
	 sprite   slep
	 item	  mli.slep
	 action   slep
					     ;------------------------------
	l_item	  cfil,3		     ; F2 = File
	 size	  mw_cxs,mw_lys
	 origin   16,15
	 justify  1,0			     ; left centred
	 type	  text
	 selkey   cfil
	 text	  cfil
	 item	  mli.cfil
	 action   cfil
					     ;------------------------------
	l_item	  cgrd,4		     ; F3 = Grid
	 size	  mw_cxs+2,mw_lys
	 origin   16+1*(mw_cxs+16),15
	 justify  1,0			     ; left centred
	 type	  text
	 selkey   cgrd
	 text	  cgrd
	 item	  mli.cgrd
	 action   cgrd
					     ;------------------------------
	l_item	  ccel,5		     ; F4 = Cell
	 size	  mw_cxs,mw_lys
	 origin   16+2*(mw_cxs+16),15
	 justify  1,0			     ; left centred
	 type	  text
	 selkey   ccel
	 text	  ccel
	 item	  mli.ccel
	 action   ccel
					     ;------------------------------
	l_item	  cstt,6		     ; F5 = Status
	 size	  mw_cxs+4,mw_lys	     ; it's a bit bigger
	 origin   16+3*(mw_cxs+16),15
	 justify  1,0			     ; left centred
	 type	  text
	 selkey   cstt
	 text	  cstt
	 item	  mli.cstt
	 action   cstt

	l_item	  csmc,7		     ; F6 = Macros
	 size	  mw_cxs-10,mw_lys	     ;
	 origin   16+4*(mw_cxs+16)+4,15
	 justify  1,0			     ; left centred
	 type	  text
	 selkey   csmc
	 text	  csmc
	 item	  mli.csmc
	 action   csmc
					     ;------------------------------
* please don't change the number !!   (main_setup_asm)
	l_item	  goto,8		     ; F10 = Goto Cell/Select section
	 size	  12*6,10
	 origin   mw_mxs-6-12*6,15,4,0
	 justify  -1,0
	 type	  text
	 selkey   goto
	 text	  0
	 item	  mli.goto
	 action   goto

					    ;------------------------------
* please don't change the number !!   (main_setup_asm)
	l_item	  data,9		    ; TAB = data/formular entry
	 size	  mw_mxs-26-50,10,4,0	 ; please don't change the number !!
	 origin   24,53 	;47
	 justify  1,0
	 type	  text
	 selkey   data
	 text	  0
	 item	  mli.data
	 action   newd

* please don't change the number !!   (main_setup_asm)
	l_item			   ; SHIFT TAB = DO on data/formula entry
	 size	  mw_mxs-26-50,10,4,0	 ; please don't change the number !!
	 origin   24,47
	 justify  1,0
	 type	  text
	 selkey   datado
	 text	  0
	 item	  mli.data
	 action   newddo
					     ;------------------------------
* please don't change the number !!   (main_setup_asm)
	l_item	  csim,11		     ; # = immediate mode
	 size	  12,10
	 origin   mw_mxs-18,47,4,0
	 justify  0,0
	 type	  text
	 selkey   csim
	 text	  csim
	 item	  mli.csim
	 action   csim

	l_item	  call,12		     ; F8=all cells
	 size	  4*6,10
	 origin   4+5*(mw_cxs+16)+6,15
	 justify  0,0
	 type	  text
	 selkey   call
	 text	  call
	 item	  mli.call
	 action   0

* please don't change the number !!   (main_setup_asm)
	l_item	  csum,13		     ; + = summarise mode
	 size	  12,10
	 origin   mw_mxs-32,47,4,0
	 justify  0,0
	 type	  sprite
	 selkey   csum
	 sprite   csum
	 item	  mli.csum
	 action   csum

* please don't change the number !!   (main_setup_asm)
	l_item	  date,14		     ; Date
	 size	  16,10
	 origin   mw_mxs-50,47,4,0
	 justify  0,0
	 type	  sprite
	 selkey   0
	 sprite   date
	 item	  mli.date
	 action   csdt

	l_item	  quit,15
	 size	  2,1
	 origin   0,0
	 justify  0,0
	 type	  text
	 selkey   norm
	 text	  0
	 item	  mli.quit
	 action   quit

      l_item	chlp,16
	size	ico.xsiz,ico.ysiz	; Jochen's  HELP
	origin	0*25+4,28
	justify 0,0
	type	sprite
	selkey	chlp
	sprite	help
	item	mli.chlp
	action	toolhelp

      l_item	toolload,17
	size	ico.xsiz,ico.ysiz	; Jochen's  LOAD
	origin	1*25+4,28
	justify 0,0
	type	sprite
	selkey	ctll
	sprite	load
	item	mli.toolload
	action	toolload

      l_item	toolsave,18
	size	ico.xsiz,ico.ysiz	; Jochen's  SAVE
	origin	2*25+4,28
	justify 0,0
	type	sprite
	selkey	ctlv
	sprite	save
	item	mli.toolsave
	action	toolsave

      l_item	toolprin,19
	size	ico.xsiz,ico.ysiz	; Jochen's  PRINT
	origin	3*25+4,28
	justify 0,0
	type	sprite
	selkey	ctlp
	sprite	print
	item	mli.toolprin
	action	toolprint

      l_item	toolfind,20
	size	ico.xsiz,ico.ysiz	; Jochen's  FIND
	origin	4*25+4,28
	justify 0,0
	type	sprite
	selkey	ctls
	sprite	find
	item	mli.toolfind
	action	find

      l_item	caga,21
	size	ico.xsiz,ico.ysiz	; Jochen's  AGAIN
	origin	5*25+4,28
	justify 0,0
	type	sprite
	selkey	0
	sprite	cfind
	item	mli.caga
	action	caga

      l_item	toolcellecho,22
	size	ico.xsiz,ico.ysiz	; Jochen's  CellEcho
	origin	6*25+4,28
	justify 0,0
	type	sprite
	selkey	ctlz
	sprite	cellecho
	item	mli.toolcellecho
	action	toolcellecho

      l_item	toolcellcopy,23
	size	ico.xsiz,ico.ysiz	; Jochen's  CellCopy
	origin	7*25+4,28
	justify 0,0
	type	sprite
	selkey	ctly
	sprite	cellcopy
	item	mli.toolcellcopy
	action	toolcellcopy

      l_item	toolcellmove,24
	size	ico.xsiz,ico.ysiz	; Jochen's  CellMove
	origin	8*25+4,28
	justify 0,0
	type	sprite
	selkey	0
	sprite	cellmove
	item	mli.toolcellmove
	action	toolcellmove

      l_item	toolcelldel,25
	size	ico.xsiz,ico.ysiz	; Jochen's  CellDelete
	origin	9*25+4,28
	justify 0,0
	type	sprite
	selkey	0
	sprite	celldel
	item	mli.toolcelldel
	action	toolcelldel

      l_item	toolcellprot,26
	size	ico.xsiz,ico.ysiz	; Jochen's  CellProtect
	origin	10*25+4,28
	justify 0,0
	type	sprite
	selkey	0
	sprite	cellprot
	item	mli.toolcellprot
	action	toolcellprot

      l_item	toolscrap,27
	size	ico.xsiz,ico.ysiz	; Jochen's  Scrap
	origin	11*25+4,28
	justify 0,0
	type	sprite
	selkey	0
	sprite	scrap
	item	mli.toolscrap
	action	toolscrap

      l_item	tooldigit,28
	size	ico.xsiz,ico.ysiz	; Jochen's  Digit
	origin	12*25+4,28
	justify 0,0
	type	sprite
	selkey	0
	sprite	digit
	item	mli.tooldigit
	action	digit

      l_item	toolmoney,29
	size	ico.xsiz,ico.ysiz	; Jochen's  Money
	origin	13*25+4,28
	justify 0,0
	type	sprite
	selkey	0
	sprite	money
	item	mli.toolmoney
	action	money

      l_item	tooljustlf,30
	size	ico.xsiz,ico.ysiz	; Jochen's  Justify Left
	origin	14*25+4,28
	justify 0,1
	type	sprite
	selkey	0
	sprite	justlf
	item	mli.tooljustlf
	action	tooljustlf

      l_item	tooljustrg,31
	size	ico.xsiz,ico.ysiz	; Jochen's  Justify Right
	origin	15*25+4,28
	justify 0,1
	type	sprite
	selkey	0
	sprite	justrg
	item	mli.tooljustrg
	action	tooljustrg

      l_item	tooloptcol,32
	size	ico.xsiz,ico.ysiz	; Jochen's  Optimal Column with
	origin	16*25+4,28
	justify 0,1
	type	sprite
	selkey	0
	sprite	optcol
	item	mli.tooloptcol
	action	gwith

      l_item	toolcalc,33
	size	ico.xsiz,ico.ysiz	; Jochen's  Recalculation
	origin	mw_mxs-4-23,28,4,0	; right hand side
	justify 0,0
	type	sprite
	selkey	ctlr
	sprite	calc
	item	mli.toolcalc
	action	toolcalc

      l_item	password,34
	size	mw_lxs,mw_lys		   ; standard size
	origin	180,2,4,0
	justify 0,0
	type	sprite
	selkey	0
	sprite	padlock
	item	mli.password
	action	password

	l_end				    ; end of loose item list

*
* Application sub-window list

	 a_wlst   mawl
	 a_windw  grid			     ; just one subwindowl
	 a_end

* Application sub-window defintion for grid window

	a_wdef	 grid			     ; grid application sub-window
	 size	  mw_mxs-8-ww.scbar-2	     \ less the index offsets
		  mw_mys-69-ww.pnbar-1	     \
		  4,4			     ; completely scalable
	 origin   4,66
	 wattr	  0			     \ no shadow
		  1,c.wbord		     \
		  c.wback
	 sprite   0
	 setr	  grid			     ; setup routine
	 draw	  grid			     ; no draw routine
	 action   grid			     ; no action routine at the moment
	 ctrl	  grid			     ; control routine
	 ctrlmax  3,3			     ; x,y sections
	 selkey   grid
	 spare

	a_ctrl	  x			     ; setup control block
	 ibar	  0,0			     ; spacing setup during runtime
	 border   0,0
	 iattr	  c.mipap		     \ index background
		  c.miink,0,0		     ; ..and ink
	 arrow	  c.wrrow
	 bar	  c.wbarb,c.wbars

	a_ctrl	  y			     ; setup control block
	 ibar	  0,0			     ; spacing setup during runtime
	 border   0,0
	 iattr	  c.mipap		     \ index background
		  c.miink,0,0		     ; ..and ink
	 arrow	  c.wrrow
	 bar	  c.wbarb,c.wbars

	a_menu
	 border   1,c.whigh
	iattr	c.wpunav,c.wiunav,0,0	; unavailable
	iattr	c.wpavbl,c.wiavbl,0,0	; available
	iattr	c.wpslct,c.wislct,0,0	; selected

	 mensiz   0,0
	 soffset  2*2+ww.pnarr,2+ww.scarr
	 slst	  0,0
	 ilst	  0
	 ilst	  0
	 rlst	  0

       a_obje	  last

*
* Define symbols and work area size in COMMON

	 setwrk   c


	 end
