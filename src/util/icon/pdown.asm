* Sprite pdown
*
*	Mode 4
*	+|-------------+
*	-    wwwwwwwwww-
*	|   ww	      w|
*	|  w w	      w|
*	| w  w www    w|
*	|wwwww wrw    w|
*	|w     wrw    w|
*	|w  wwwwrwwww w|
*	|w  wwrrrrrww w|
*	|w   wwrrrww  w|
*	|w    wwrww   w|
*	|w     www    w|
*	|w	w     w|
*	|w	      w|
*	|wwwwwwwwwwwwww|
*	+|-------------+
*
	section sprite
	xdef	mes_pdown
	xref	mes_zero
mes_pdown
	dc.w	$0100,$0000
	dc.w	14,14,0,0
	dc.l	mcs_pdown-*
	dc.l	mes_zero-*
	dc.l	sp_pdown-*
mcs_pdown
	dc.w	$0F0F,$FCFC
	dc.w	$1818,$0404
	dc.w	$2828,$0404
	dc.w	$4B4B,$8484
	dc.w	$FAFB,$8484
	dc.w	$8283,$8484
	dc.w	$9E9F,$F4F4
	dc.w	$989F,$34F4
	dc.w	$8C8F,$64E4
	dc.w	$8687,$C4C4
	dc.w	$8383,$8484
	dc.w	$8181,$0404
	dc.w	$8080,$0404
	dc.w	$FFFF,$FCFC
*
sp_pdown
	incbin	'win1_util_icon_pdown_spr'

	end
