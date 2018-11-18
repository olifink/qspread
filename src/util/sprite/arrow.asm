* Sprite arro
*
*	Mode 4
*	+-|--------+
*	|aa	   |
*	-awa	   -
*	|awwa	   |
*	|awwwa	   |
*	|awwwwa    |
*	|awwwwwa   |
*	|awwwwwwa  |
*	|awwwwwwwa |
*	|awwwwwwwwa|
*	|awwwwwwaa |
*	|awwaawwa  |
*	| aa  awwa |
*	|     awwa |
*	|      aa  |
*	+-|--------+
*
	section sprite
	xdef	mes_arro
mes_arro
	dc.w	$0100,$0000
	dc.w	10,14,1,1
	dc.l	sc4_arro-*
	dc.l	sm4_arro-*
	dc.l	0
sc4_arro
	dc.w	$0000,$0000
	dc.w	$4040,$0000
	dc.w	$6060,$0000
	dc.w	$7070,$0000
	dc.w	$7878,$0000
	dc.w	$7C7C,$0000
	dc.w	$7E7E,$0000
	dc.w	$7F7F,$0000
	dc.w	$7F7F,$8080
	dc.w	$7E7E,$0000
	dc.w	$6666,$0000
	dc.w	$0303,$0000
	dc.w	$0303,$0000
	dc.w	$0000,$0000
sm4_arro
	dc.w	$C0C0,$0000
	dc.w	$E0E0,$0000
	dc.w	$F0F0,$0000
	dc.w	$F8F8,$0000
	dc.w	$FCFC,$0000
	dc.w	$FEFE,$0000
	dc.w	$FFFF,$0000
	dc.w	$FFFF,$8080
	dc.w	$FFFF,$C0C0
	dc.w	$FFFF,$8080
	dc.w	$FFFF,$0000
	dc.w	$6767,$8080
	dc.w	$0707,$8080
	dc.w	$0303,$0000
*
	end
