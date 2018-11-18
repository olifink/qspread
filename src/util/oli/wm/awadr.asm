; get applcation subwindow address from menu number

	section utility

	include win1_mac_oli
	include win1_keys_wwork
	include win1_keys_err

	xdef	xwm_awadr

;+++
; get applcation subwindow address from menu number
;
;		Entry			Exit
;	d0.l	menu subwindow nr	???
;	a3				subwindow wwork
;	a4	wwork			preserved
;---
xwm_awadr
	move.l	ww_pappl(a4),a3 	; list of appl. subwindows..
	lsl.l	#2,d0			; ..is a list of long pointers..
	move.l	(a3,d0.l),a3		; ..to the subwindow wwork
	rts

	END
