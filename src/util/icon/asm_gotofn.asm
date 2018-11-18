	section sprite
	xdef	mes_gotofn
	xref	mes_zero
mes_gotofn
	dc.w	$0100,$0000
	dc.w	20,16,0,0
	dc.l	mcs_gotofn-*
	dc.l	mes_zero-*
	dc.l	sp_func-*
mcs_gotofn
	dc.w	$5B00,$8808
	dc.w	$8080,$0000
	dc.w	$9200,$8D0D
	dc.w	$8080,$0000
	dc.w	$9B00,$8F0F
	dc.w	$8080,$0000
	dc.w	$9200,$8F0F
	dc.w	$8080,$0000
	dc.w	$5300,$8F0F
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
	dc.w	$0E0E,$A9A9
	dc.w	$2020,$0000
	dc.w	$0808,$ADAD
	dc.w	$5050,$0000
	dc.w	$0C0C,$ABAB
	dc.w	$4040,$0000
	dc.w	$0808,$A9A9
	dc.w	$5050,$0000
	dc.w	$0808,$4949
	dc.w	$2020,$0000
*
sp_func
	incbin	'win1_util_icon_gotofn_spr'

	end
