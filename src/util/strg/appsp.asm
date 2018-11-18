; append a space after a string 		    06/01-92 O.Fink

	 section  string

	 include  win1_mac_oli
	 include  win1_keys_err

	 xdef	  st_appsp		      ; append a space

;+++
; append a character after a string (there must be enough space!)
; 'abcdef' -> append space -> 'abcdef '
;
;		  Entry 		     Exit
;	 a0	  ptr to string 	     preserved
;
; error codes:	  none
; condition codes set
;---
st_appsp subr d1
	moveq	#' ',d1
	xbsr	st_appc
	subend

	end
