	section sprite
	xdef	mes_gotoproc
	xref	mes_zero
mes_gotoproc
	dc.w	$0100,$0000
	dc.w	20,16,0,0
	dc.l	mcs_gotoproc-*
	dc.l	mes_zero-*
	dc.l	sp_proc-*
mcs_gotoproc
	dc.w	$5B00,$8808
	dc.w	$8080,$0000
	dc.w	$9000,$8D0D
	dc.w	$8080,$0000
	dc.w	$9900,$0F0F
	dc.w	$8080,$0000
	dc.w	$9200,$0F0F
	dc.w	$8080,$0000
	dc.w	$5200,$0F0F
	dc.w	$8080,$0000
	dc.w	$0000,$3F3F
	dc.w	$E0E0,$0000
	dc.w	$0000,$1F1F
	dc.w	$C0C0,$0000
	dc.w	$0000,$0F0F
	dc.w	$8080,$0000
	dc.w	$0000,$0707
	dc.w	$0000,$0000
	dc.w	$0000,$0202
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0606,$6262
	dc.w	$2020,$0000
	dc.w	$0505,$5555
	dc.w	$5050,$0000
	dc.w	$0606,$6565
	dc.w	$4040,$0000
	dc.w	$0404,$5555
	dc.w	$5050,$0000
	dc.w	$0404,$5252
	dc.w	$2020,$0000
*
sp_proc
	incbin	'win1_util_icon_gotoproc_spr'

	end
