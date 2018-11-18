* Sprite keybd
*
*	Mode 4
*	+|-------------------+
*	-aawrrrrrwwararaaawaw-
*	|aaawrrrwaawararaawwa|
*	|aarrwrwaaaawararaaaa|
*	|arrrrwaawaaawararaar|
*	|rrrrwaawaaaaawararrr|
*	|rrrwaawawaaaaawarrrr|
*	|rrrwaaaaawaaaaawrrrr|
*	|rrwaraaaaawaaaarwrrw|
*	|rwararaaaaawaarrrwwa|
*	|wawararaaaaaarrrrwaa|
*	|aaawararaaaarrrrwrra|
*	|waaawararaarrrwwrarr|
*	|awaaawararrrrwawarar|
*	|waaaaawarrrrwaaawara|
*	|aaawaarrwrwaaawaaawa|
*	|aaaaarrrrwaaawaaaaaw|
*	+|-------------------+
*
	section sprite
	xdef	mes_keybd
	xref	mes_zero
mes_keybd
	dc.w	$0100,$0000
	dc.w	20,16,0,0
	dc.l	mcs_keybd-*
	dc.l	mes_zero-*
	dc.l	0
mcs_keybd
	dc.w	$203F,$C0D4
	dc.w	$5050,$0000
	dc.w	$111F,$202A
	dc.w	$6060,$0000
	dc.w	$0A3E,$1015
	dc.w	$0000,$0000
	dc.w	$047C,$888A
	dc.w	$0090,$0000
	dc.w	$09F9,$0405
	dc.w	$0070,$0000
	dc.w	$12F2,$8282
	dc.w	$00F0,$0000
	dc.w	$10F0,$4141
	dc.w	$00F0,$0000
	dc.w	$20E8,$2021
	dc.w	$90F0,$0000
	dc.w	$40D4,$1013
	dc.w	$60E0,$0000
	dc.w	$A0AA,$0007
	dc.w	$40C0,$0000
	dc.w	$1015,$000F
	dc.w	$80E0,$0000
	dc.w	$888A,$039F
	dc.w	$00B0,$0000
	dc.w	$4445,$057D
	dc.w	$0050,$0000
	dc.w	$8282,$08F8
	dc.w	$80A0,$0000
	dc.w	$1013,$A2E2
	dc.w	$2020,$0000
	dc.w	$0007,$44C4
	dc.w	$1010,$0000
*
	end
