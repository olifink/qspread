; select one of a list of exclusive items

	include win1_mac_oli
	include win1_keys_wman
	include win1_keys_wwork
	include win1_keys_wstatus

	section utility

	xdef	xwm_exsll		; exclusive select of a loose item

;+++
; select one of a list of exclusive items
;
;		Entry				Exit
;	d1	selected loose item number
;	a0	channel id
;	a3	exclusive loose item list
;	a4	working definition
;
; error and condition codes set
;---
xwm_exsll	subr	d2
loop	move.w	(a3)+,d0		; get next exclusive item
	bmi.s	done			; -1 end of list
	cmp.b	d0,d1			; is it the current item
	beq.s	do_sel			; ..yes, well select it!

	move.b	ws_litem(a1,d0.w),d2	; ..no, get status
	andi.b	#%11111110,d2		; is it (due to) be clear(ed)
	beq.s	loop			; ..yes, then skip this one

	cmpi.b	#wsi.unav,d2		; is it unavailable
	beq.s	loop			; ..yes, forget this one

	moveq	#wsi.mkav,d2		; ..no, well, make it available
do_stat move.b	d2,ws_litem(a1,d0.w)
	bra.s	loop

do_sel	moveq	#wsi.mksl,d2
	bra.s	do_stat

done
	xjsr	xwm_ldrwc		; draw changed items
	subend

	end
