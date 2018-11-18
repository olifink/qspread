* Sprite usage
*
*	Mode 4
*	+|-------------------+
*	- g gg g  g  w wwww  -
*	|g  g  g g g	     |
*	|g  gg g g g  ww www |
*	|g  g  g g g	     |
*	| g g  g  g  ww ww   |
*	|		     |
*	|ggwwwwgwwgwwwwgwwwgg|
*	|gggggggggggggggggggg|
*	|  ww wwww w wwww    |
*	|		     |
*	|  wwww www www www  |
*	|		     |
*	|ggwwgwwwwgwwwgwwgggg|
*	|gggggggggggggggggggg|
*	|  wwww w www wwww ww|
*	|		     |
*	+|-------------------+
*
	section sprite
	xdef	mes_usage
	xref	mes_zero
mes_marker
mes_usage
	dc.w	$0100,$0000
	dc.w	20,16,0,0
	dc.l	mcs_usage-*
	dc.l	mes_zero-*
	dc.l	sp_marker-*
mcs_usage
	dc.w	$5A00,$4B0B
	dc.w	$C0C0,$0000
	dc.w	$9200,$A000
	dc.w	$0000,$0000
	dc.w	$9A00,$A606
	dc.w	$E0E0,$0000
	dc.w	$9200,$A000
	dc.w	$0000,$0000
	dc.w	$5200,$4D0D
	dc.w	$8080,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$FF3D,$FFBD
	dc.w	$F0C0,$0000
	dc.w	$FF00,$FF00
	dc.w	$F000,$0000
	dc.w	$3737,$AFAF
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$3D3D,$DDDD
	dc.w	$C0C0,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$FF37,$FFBB
	dc.w	$F000,$0000
	dc.w	$FF00,$FF00
	dc.w	$F000,$0000
	dc.w	$3D3D,$7777
	dc.w	$B0B0,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
*
sp_marker
	incbin	'win1_util_icon_asm_marker_spr'

	end
