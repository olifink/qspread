	section sprite
	xdef	mes_gotolab
	xref	mes_zero
mes_gotolab
	dc.w	$0100,$0000
	dc.w	20,16,0,0
	dc.l	mcs_gotolab-*
	dc.l	mes_zero-*
	dc.l	sp_gotolab-*
mcs_gotolab
	dc.w	$5900,$8808
	dc.w	$8080,$0000
	dc.w	$9200,$0D0D
	dc.w	$8080,$0000
	dc.w	$9B00,$0F0F
	dc.w	$8080,$0000
	dc.w	$9200,$8F0F
	dc.w	$8080,$0000
	dc.w	$5100,$0F0F
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
	dc.w	$0808,$9999
	dc.w	$A0A0,$0000
	dc.w	$0909,$5555
	dc.w	$2020,$0000
	dc.w	$0909,$5959
	dc.w	$A0A0,$0000
	dc.w	$0909,$D5D5
	dc.w	$2020,$0000
	dc.w	$0D0D,$5959
	dc.w	$B0B0,$0000
*
sp_gotolab
	incbin	'win1_util_icon_gotolab_spr'

	end
