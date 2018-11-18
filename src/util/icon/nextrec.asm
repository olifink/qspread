* Sprite nextrec
*
*	Mode 4
*	+|-------------------+
*	-gg g g 	wwww -
*	|g  g g 	 rww |
*	|gg ggg 	rwrw |
*	|g    gwww     rwr w |
*	|g   wgrrrw   rwr    |
*	|    www  wwwrwrwwwww|
*	|   wrrrw   rwr     w|
*	|  www	wwwrwrwwwwr w|
*	| wrrrw   rwr	 w  w|
*	|ww   wwwrwrwwwr wr w|
*	|w	rwr   w  w  w|
*	|w rr  rwr rr wr wwww|
*	|w     wr     w  w   |
*	|w r rr   rrr wwww   |
*	|w	      w      |
*	|wwwwwwwwwwwwww      |
*	+|-------------------+
*
	section sprite
	xdef	mes_nextrec
	xref	mes_zero
mes_nextrec
	dc.w	$0100,$0000
	dc.w	20,16,0,0
	dc.l	mcs_nextrec-*
	dc.l	mes_zero-*
	dc.l	0
mcs_nextrec
	dc.w	$D400,$0101
	dc.w	$E0E0,$0000
	dc.w	$9400,$0000
	dc.w	$60E0,$0000
	dc.w	$DC00,$0001
	dc.w	$A0E0,$0000
	dc.w	$8703,$8183
	dc.w	$20A0,$0000
	dc.w	$8C0B,$42C7
	dc.w	$0000,$0000
	dc.w	$0E0E,$757F
	dc.w	$F0F0,$0000
	dc.w	$111F,$081C
	dc.w	$1010,$0000
	dc.w	$3939,$D7FF
	dc.w	$90D0,$0000
	dc.w	$447C,$2070
	dc.w	$9090,$0000
	dc.w	$C7C7,$5CFE
	dc.w	$90D0,$0000
	dc.w	$8081,$84C4
	dc.w	$9090,$0000
	dc.w	$81B3,$04B6
	dc.w	$F0F0,$0000
	dc.w	$8283,$0404
	dc.w	$8080,$0000
	dc.w	$80AC,$0777
	dc.w	$8080,$0000
	dc.w	$8080,$0404
	dc.w	$0000,$0000
	dc.w	$FFFF,$FCFC
	dc.w	$0000,$0000

	end
mms_nextrec
	dc.w	$D4D4,$0101
	dc.w	$E0E0,$0000
	dc.w	$9494,$0000
	dc.w	$E0E0,$0000
	dc.w	$DCDC,$0101
	dc.w	$E0E0,$0000
	dc.w	$8787,$8383
	dc.w	$A0A0,$0000
	dc.w	$8F8F,$C7C7
	dc.w	$0000,$0000
	dc.w	$0E0E,$7F7F
	dc.w	$F0F0,$0000
	dc.w	$1F1F,$1C1C
	dc.w	$1010,$0000
	dc.w	$3939,$FFFF
	dc.w	$D0D0,$0000
	dc.w	$7C7C,$7070
	dc.w	$9090,$0000
	dc.w	$C7C7,$FEFE
	dc.w	$D0D0,$0000
	dc.w	$8181,$C4C4
	dc.w	$9090,$0000
	dc.w	$B3B3,$B6B6
	dc.w	$F0F0,$0000
	dc.w	$8383,$0404
	dc.w	$8080,$0000
	dc.w	$ACAC,$7777
	dc.w	$8080,$0000
	dc.w	$8080,$0404
	dc.w	$0000,$0000
	dc.w	$FFFF,$FCFC
	dc.w	$0000,$0000
*
	end
