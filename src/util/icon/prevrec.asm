* Sprite prevrec
*
*	Mode 4
*	+|-------------------+
*	-gg ggg 	     -
*	|g  g		rw   |
*	|gg gg www     rwr   |
*	|g    grrrw   rwr    |
*	|g  ggww  wwwrwrwwwww|
*	|   wrrrw   rwr     w|
*	|  www	wwwrwrwwwwr w|
*	| wrrrw   rwr	 w  w|
*	|ww   wwwrwrwwwr wr w|
*	|w	rwr   w  w  w|
*	|w r w rwr  r wr wwww|
*	|w   wrwr     w  w   |
*	|w r wwr  rrr wwww   |
*	|w   wwww     w      |
*	|w	      w      |
*	|wwwwwwwwwwwwww      |
*	+|-------------------+
*
	section sprite
	xdef	mes_prevrec
	xref	mes_zero
mes_prevrec
	dc.w	$0100,$0000
	dc.w	20,16,0,0
	dc.l	mcs_prevrec-*
	dc.l	mes_zero-*
	dc.l	0
mcs_prevrec
	dc.w	$DC00,$0000
	dc.w	$0000,$0000
	dc.w	$9000,$0001
	dc.w	$8080,$0000
	dc.w	$DB03,$8183
	dc.w	$0080,$0000
	dc.w	$8403,$42C7
	dc.w	$0000,$0000
	dc.w	$9E06,$757F
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
	dc.w	$89AB,$0496
	dc.w	$F0F0,$0000
	dc.w	$8A8F,$0404
	dc.w	$8080,$0000
	dc.w	$8CAE,$0777
	dc.w	$8080,$0000
	dc.w	$8F8F,$0404
	dc.w	$0000,$0000
	dc.w	$8080,$0404
	dc.w	$0000,$0000
	dc.w	$FFFF,$FCFC
	dc.w	$0000,$0000

	end

mms_prevrec
	dc.w	$DCDC,$0000
	dc.w	$0000,$0000
	dc.w	$9090,$0101
	dc.w	$8080,$0000
	dc.w	$DBDB,$8383
	dc.w	$8080,$0000
	dc.w	$8787,$C7C7
	dc.w	$0000,$0000
	dc.w	$9E9E,$7F7F
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
	dc.w	$ABAB,$9696
	dc.w	$F0F0,$0000
	dc.w	$8F8F,$0404
	dc.w	$8080,$0000
	dc.w	$AEAE,$7777
	dc.w	$8080,$0000
	dc.w	$8F8F,$0404
	dc.w	$0000,$0000
	dc.w	$8080,$0404
	dc.w	$0000,$0000
	dc.w	$FFFF,$FCFC
	dc.w	$0000,$0000
*
	end
