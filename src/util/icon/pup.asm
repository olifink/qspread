* Sprite pup
*
*	Mode 4
*	+|-------------+
*	-    wwwwwwwwww-
*	|   ww	      w|
*	|  w w	      w|
*	| w  w	w     w|
*	|wwwww www    w|
*	|w    wwrww   w|
*	|w   wwrrrww  w|
*	|w  wwrrrrrww w|
*	|w  wwwwrwwww w|
*	|w     wrw    w|
*	|w     wrw    w|
*	|w     www    w|
*	|w	      w|
*	|wwwwwwwwwwwwww|
*	+|-------------+
*
	section sprite
	xdef	mes_pup
	xref	mes_zero
mes_pup
	dc.w	$0100,$0000
	dc.w	14,14,0,0
	dc.l	mcs_pup-*
	dc.l	mes_zero-*
	dc.l	sp_pup-*
mcs_pup
	dc.w	$0F0F,$FCFC
	dc.w	$1818,$0404
	dc.w	$2828,$0404
	dc.w	$4949,$0404
	dc.w	$FBFB,$8484
	dc.w	$8687,$C4C4
	dc.w	$8C8F,$64E4
	dc.w	$989F,$34F4
	dc.w	$9E9F,$F4F4
	dc.w	$8283,$8484
	dc.w	$8283,$8484
	dc.w	$8383,$8484
	dc.w	$8080,$0404
	dc.w	$FFFF,$FCFC
*
sp_pup
	incbin	'win1_util_icon_pup_spr'

	end
