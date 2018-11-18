* Sprite celldel
*
*	Mode 4
*	+|-------------------+
*	-wwwwwwwwww www      -
*	|wrrrrrrrrw wawww    |
*	|wrrrrrrrrw wawrrwww |
*	|wrrrrrrrrw rrrrrrrrw|
*	|wrrrrrrrrw rrrrrwww |
*	|wrrrrrrrrw wwwwwrrw |
*	|wrrrrrrrrw rrrrrwrw |
*	|wwwwwwwwww rrrrrwrw |
*	|	   wrwrwrwrw |
*	|      wrwrwrwwwrwrw |
*	|      wrwrwrrrrrwrw |
*	|      wrwrwrrrrrwrw |
*	|      wrwrwrrrrrwrw |
*	|      wrrrwrrrrrrrw |
*	|	wwrrrrrrrww  |
*	|	  wwwwwww    |
*	+|-------------------+
*
	section sprite
	xdef	mes_celldel
	xref	mes_zero
mes_celldel
	dc.w	$0100,$0000
	dc.w	20,16,0,0
	dc.l	mcs_celldel-*
	dc.l	mes_zero-*
	dc.l	sp_celldel-*
mcs_celldel
	dc.w	$FFFF,$DCDC
	dc.w	$0000,$0000
	dc.w	$80FF,$57D7
	dc.w	$0000,$0000
	dc.w	$80FF,$54D7
	dc.w	$E0E0,$0000
	dc.w	$80FF,$40DF
	dc.w	$10F0,$0000
	dc.w	$80FF,$40DF
	dc.w	$E0E0,$0000
	dc.w	$80FF,$5FDF
	dc.w	$20E0,$0000
	dc.w	$80FF,$40DF
	dc.w	$A0E0,$0000
	dc.w	$FFFF,$C0DF
	dc.w	$A0E0,$0000
	dc.w	$0000,$2A3F
	dc.w	$A0E0,$0000
	dc.w	$0203,$AEFF
	dc.w	$A0E0,$0000
	dc.w	$0203,$A0FF
	dc.w	$A0E0,$0000
	dc.w	$0203,$A0FF
	dc.w	$A0E0,$0000
	dc.w	$0203,$A0FF
	dc.w	$A0E0,$0000
	dc.w	$0203,$20FF
	dc.w	$20E0,$0000
	dc.w	$0101,$80FF
	dc.w	$C0C0,$0000
	dc.w	$0000,$7F7F
	dc.w	$0000,$0000
*
sp_celldel
	incbin	'win1_util_icon_asm_celldel_spr'

	end
