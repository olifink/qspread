* Sprite justlf
*
*	Mode 4
*	+|-----------------+
*	-  g		   -
*	| gggggg	   |
*	|  g		   |
*	|		   |
*	|wwwwwwwwwwwwwwwwww|
*	|wrrrrrrrrrrrrrrrrw|
*	|wrwrrrrwrrrrrrrrrw|
*	|wrwrrrwrwrrrrrrrrw|
*	|wrwrrrwrwrrrrrrrrw|
*	|wrwrwrrwrrrrrrrrrw|
*	|wrrrrrrrrrrrrrrrrw|
*	|wwwwwwwwwwwwwwwwww|
*	+|-----------------+
*
	section sprite
	xdef	mes_justlf
	xref	mes_zero
mes_justlf
	dc.w	$0100,$0000
	dc.w	18,12,0,0
	dc.l	mcs_justlf-*
	dc.l	mes_zero-*
	dc.l	sp_justlf-*
mcs_justlf
	dc.w	$2000,$0000
	dc.w	$0000,$0000
	dc.w	$7E00,$0000
	dc.w	$0000,$0000
	dc.w	$2000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$0000,$0000
	dc.w	$FFFF,$FFFF
	dc.w	$C0C0,$0000
	dc.w	$80FF,$00FF
	dc.w	$40C0,$0000
	dc.w	$A1FF,$00FF
	dc.w	$40C0,$0000
	dc.w	$A2FF,$80FF
	dc.w	$40C0,$0000
	dc.w	$A2FF,$80FF
	dc.w	$40C0,$0000
	dc.w	$A9FF,$00FF
	dc.w	$40C0,$0000
	dc.w	$80FF,$00FF
	dc.w	$40C0,$0000
	dc.w	$FFFF,$FFFF
	dc.w	$C0C0,$0000

sp_justlf
	incbin 'win1_util_icon_asm_justlf_spr'
*
	end
