; delete leading spaces from a string		      18/01-92 O.Fink

	 section  string

	 include  win1_keys_err

	 xdef	  st_dllsp		     ; delete leading spaces
	 xdef	  st_dllspt		     ; delete leading spaces and TAB's
	 xref	  st_delc

;+++
; delete leading spaces from a string
; "  abc" -> dllsp -> "abc"
;
;		  Entry 		     Exit
;	 a0	  ptr to string 	     preserved
;
; error codes:	  none
; condition codes: none
;---
r_dllsp   reg	   d0-d2
st_dllsp
	 movem.l  r_dllsp,-(sp)
	 moveq	  #1,d1 		     ; first character, if any
st_lp
	 move.w   (a0),d0		     ; length of string
	 beq.s	  st_exit
	 move.b   2(a0),d2
	 subi.b   #' ',d2
	 bne.s	  st_exit
	 bsr	  st_delc		     ; delete character
	 bra.s	  st_lp

st_exit
	 movem.l  (sp)+,r_dllsp
	 rts


st_dllspt
	 movem.l  r_dllsp,-(sp)
	 moveq	  #1,d1 		     ; first character, if any
st_lp1
	 move.w   (a0),d0		     ; length of string
	 beq.s	  st_exit1

	 move.b   2(a0),d2
	 subi.b   #' ',d2
	 bne.s	  tst_tab

	 bsr	  st_delc		     ; delete character
	 bra.s	  st_lp1

tst_tab
	 move.b   2(a0),d2
	 subi.b   #$09,d2
	 bne.s	  st_exit1

	 bsr	  st_delc		     ; delete character
	 bra.s	  st_lp1

st_exit1
	 movem.l  (sp)+,r_dllsp
	 rts

	 end
