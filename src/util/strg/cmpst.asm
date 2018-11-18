; compare to string (using QDOS ut.cstr)

	 section  string

	 include  win1_keys_err
	 include  win1_keys_qlv

	 xdef	  st_cmpst		    ; append a character

;+++
; compare two strings (see ut.cstr)
;
;		  Entry 		     Exit
;	d0.b	comparison type 	     -1,0 or +1 (0=same)
;		  0=file
;		  1=basic
;		  2=equivalence
;	a0	string 1
;	a1	string 2
;
; condition codes set
;---
r_cmpst reg	a2/a6/d2
st_cmpst
	movem.l r_cmpst,-(sp)
	moveq	#0,d2
	move.l	d2,a6
	move.w	ut.cstr,a2
	jsr	(a2)
	movem.l (sp)+,r_cmpst
	rts

	 end
