	section sprite
	xdef	mes_padlock

	xref	mes_zero
mes_padlock
	dc.w	$0100,$0000
	dc.w	11,9,2,0
	dc.l	mcs_padlock-*
	dc.l	mes_zero-*
	dc.l	0
mcs_padlock
	dc.w	$3F3F,$8080
	dc.w	$6060,$C0C0
	dc.w	$4040,$4040
	dc.w	$FFFF,$E0E0
	dc.w	$FBFB,$E0E0
	dc.w	$F1F1,$E0E0
	dc.w	$FBFB,$E0E0
	dc.w	$7B7B,$C0C0
	dc.w	$3F3F,$8080

*
	end
