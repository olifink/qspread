	section sprite

	xdef	mes_cd_eject

mes_cd_eject
	dc.w	$0220,4,0,0,0,0
	dc.l	0,0,0,0
	dc.l	sp_ex-*
sp_ex	dc.l	sp_btn-*
	dc.l	sp_btn_cur-*
	dc.l	0,0,0

sp_btn
	incbin	'win1_util_sprite_cd_eject_spr'

sp_btn_cur
	incbin	'win1_util_sprite_cd_eject2_spr'

	end
