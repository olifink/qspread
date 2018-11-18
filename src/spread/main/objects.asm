* Spreadsheet					      29/11-91
*	 -  menu item initialisation
*

	 section  prog

	 include  win1_keys_wman
	 include  win1_keys_wwork
	 include  win1_keys_wstatus
	 include  win1_keys_qdos_sms
	 include win1_mac_oli
	 include  win1_spread_keys

	 xdef	  setmol

	 xref	  kill
	 xref	  con_wdec
	 xref	  con_wasc
	 xref	  cfg_cgap

	 xref.s   mek.cell

sml	 reg	  d1-d3/a0
setmol
	 movem.l  sml,-(sp)
*
* allocate memory area
	 move.w   da_ncols(a6),d2	     ; calculate absolute number
	 mulu	  da_nrows(a6),d2	     ; of objects
	 move.l   d2,da_ncell(a6)	     ; set number of cells
	 mulu	  #wwm.olen+wwm.slen,d2      ; mem for spaceinglist/mobjects

	 move.w   da_nrows(a6),d1	     ; number of rows
	 mulu	  #wwm.rlen,d1		     ; mem for row list
	 add.l	  d2,d1 		     ; memory required by now

	 move.w   da_ncols(a6),d2	     ; for index columns
	 add.w	  da_nrows(a6),d2	     ; and index rows
	 mulu	  #wwm.olen+idx.slen,d2      ; for index object and string length
	 add.l	  d2,d1 		     ; more memory required

	 move.l   da_ncell(a6),d2	     ; status area for menu window
	 addq.w   #1,d2
	 bclr	  #0,d2 		     ; make it even (in case 1/1)
	 add.l	  d2,d1 		     ; add this to the memory request

	 addi.l   #255,d1		     ; !!!chicken factor for testing
	 xjsr	  ut_alcmy		     ; allocate memory for myself
	 bne	  kill			     ; (possibly error reporting)

*
* set menu item object list
	 move.l   a0,da_miobl(a6)	     ; save this address
	 xlea	  mea_cell,a1		     ; action routine
	 move.l   a1,d2
	 moveq	  #0,d0 		     ; item number count
	 move.l   da_ncell(a6),d1	     ; loop counter

setobj
	 move.b   #0,wwm_xjst(a0)	     ; x justification rule
	 move.b   #0,wwm_yjst(a0)	     ; y justification rule
	 move.b   #text,wwm_type(a0)	     ; object type is text
	 move.b   #mek.cell,wwm_skey(a0)     ; no selection key
	 move.l   #0,wwm_pobj(a0)	     ; pointer to object
	 move.w   d0,wwm_item(a0)	     ; set item number
	 move.l   d2,wwm_pact(a0)	     ; pointer to action routine

	 adda.l   #wwm.olen,a0		     ; address to new object
	 addq.w   #1,d0
	 subq.l   #1,d1
	 bne.s	  setobj		     ; for all objects

*
* set column spacing list
	 move.l   a0,da_mspcl(a6)	     ; here starts the spacing list
	 move.w   da_colwd(a6),d2	     ; column width in characters
	 mulu	  #qs.xchar,d2		     ; hit size in pixels
	 addq.l   #2,d2
	 move.w   d2,d3
	 move.b   cfg_cgap,d0
	 beq.s	  nogap
	 addq.w   #2,d3 		     ; spacing in pixels
nogap	 move.w   da_ncols(a6),d0
	 bra.s	  spcloop
setspc
	 move.w   d2,wwm_size(a0)	     ; set hit size for column
	 move.w   d3,wwm_spce(a0)	     ; set spacing for object
	 addq.l   #wwm.slen,a0		     ; address of next entry
spcloop
	 dbra	  d0,setspc		     ; for all columns

*
* set connecting row list
	 move.l   a0,da_mrowl(a6)	     ; the start of the row list
	 move.l   da_miobl(a6),d1	     ; this is the first object
	 move.w   da_ncols(a6),d2	     ; number of columns
	 move.w   da_nrows(a6),d0
	 mulu	  #wwm.olen,d2		     ; relative to the next
	 bra.s	  rowloop

setrow
	 move.l   d1,wwm_rows(a0)	     ; start
	 add.l	  d2,d1
	 move.l   d1,wwm_rowe(a0)	     ; end
	 addq.l   #wwm.rlen,a0
rowloop
	 dbra	  d0,setrow		     ; for all columns

*
* create index object entries
	 move.l   a0,da_ixstr(a6)	     ; here are all index entries
	 move.w   da_nrows(a6),d1	     ; number of rows
	 subq.w   #1,d1
	 moveq	  #1,d0 		     ; we start with the first
rwidx
	 bsr	  con_wdec		     ; convert integer word to string
	 addq.l   #idx.slen,a0		     ; address of next index item
	 addq.w   #1,d0 		     ; next number
	 dbra	  d1,rwidx		     ; do next row index
	 move.w   -idx.slen(a0),da_ixspx(a6) ; maximum string length

	 move.w   da_ncols(a6),d1	     ; number of columns
	 subq.w   #1,d1
	 moveq	  #1,d0 		     ; again the first column
clidx
	 bsr	  con_wasc		     ; convert to ascii column header
	 addq.l   #idx.slen,a0		     ; address of next index item
	 addq.w   #1,d0 		     ; next number
	 dbra	  d1,clidx		     ; do the next one

*
* set row index item objects

	 move.l   a0,da_mridx(a6)	     ; pointer to row index objects
	 move.w   da_nrows(a6),d2	     ; number of rows
	 move.l   da_ixstr(a6),d1	     ; address of index strings

idxrw
	 move.b   #-1,wwm_xjst(a0)	     ; right justification
	 move.b   #0,wwm_yjst(a0)	     ; vertically centred
	 move.b   #text,wwm_type(a0)	     ; text type
	 move.b   #0,wwm_skey(a0)	     ; no selection key
	 move.l   d1,wwm_pobj(a0)	     ; pointer to object
	 move.w   #-1,wwm_item(a0)	     ; item number is negative for idx
	 clr.l	  wwm_pact(a0)		     ; and no action routine

	 addi.l   #idx.slen,d1		     ; address of next index string
	 adda.l   #wwm.olen,a0		     ; next object adress
	 subq.w   #1,d2 		     ; last row index item?
	 bne.s	  idxrw
*
* set column index item objects
	 move.l   a0,da_mcidx(a6)	     ; pointer to column index objects
	 move.w   da_ncols(a6),d2	     ; number of columns
idxcl
	 move.b   #0,wwm_xjst(a0)	     ; horizontally centred
	 move.b   #0,wwm_yjst(a0)	     ; vertically centred
	 move.b   #text,wwm_type(a0)	     ; text type
	 move.b   #0,wwm_skey(a0)	     ; no selection key
	 move.l   d1,wwm_pobj(a0)	     ; pointer to object
	 move.w   #-1,wwm_item(a0)	     ; item number is negative for idx
	 clr.l	  wwm_pact(a0)		     ; and no action routine

	 addi.l   #idx.slen,d1		     ; address of next index string
	 adda.l   #wwm.olen,a0		     ; next object adress
	 subq.w   #1,d2 		     ; last column index item?
	 bne.s	  idxcl
*

	 move.l   a0,da_mstat(a6)	     ; store status area address
	 move.l   da_ncell(a6),d0	     ; even number of cells
	 addq.w   #1,d0
	 lsr.w	  #1,d0 		     ; in words
	 bra.s	  clrlpe		     ; clear the status area, in case
clrlp
	 clr.w	  (a0)+
clrlpe
	 dbra	  d0,clrlp

*
	 movem.l  (sp)+,sml
	 rts

	 end
