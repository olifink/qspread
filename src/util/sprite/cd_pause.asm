	section sprite

	xdef	mes_cd_pause

mes_cd_pause
sp_pause
	dc.w	$0240,$0000	24 bit mode
	dc.w	7,10,3,5	7*10 pixel sprite origin at 3,5
	dc.l	s24p_pause-*
	dc.l	s24m_pause-*
	dc.l	0
s24p_pause
	dc.l	$00000000,$00000000,$00000000,$00000000,$00000000,$00000000,$00000000
	dc.l	$00000000,$D3C7A700,$CFC19E00,$00000000,$00000000,$D3C7A700,$CFC19E00
	dc.l	$00000000,$D2C5A300,$CCBD9700,$00000000,$00000000,$D2C5A300,$CCBD9700
	dc.l	$00000000,$D0C29F00,$C9B99100,$00000000,$00000000,$D0C29F00,$C9B99100
	dc.l	$00000000,$CDBF9B00,$C5B58B00,$00000000,$00000000,$CDBF9B00,$C5B58B00
	dc.l	$00000000,$CABB9300,$B7A88200,$00000000,$00000000,$CABB9300,$B7A88200
	dc.l	$00000000,$C4B58B00,$AA9C7800,$00000000,$00000000,$C4B58B00,$AA9C7800
	dc.l	$00000000,$BAAB8300,$A2947200,$00000000,$00000000,$BAAB8300,$A2947200
	dc.l	$00000000,$AFA17C00,$9A8D6D00,$00000000,$00000000,$AFA17C00,$9A8D6D00
	dc.l	$00000000,$A2957300,$92866700,$00000000,$00000000,$A2957300,$92866700
s24m_pause
	dc.l	-1,-1,00,00,-1,-1,00
	dc.l	-1,-1,-1,00,-1,-1,-1
	dc.l	-1,-1,-1,00,-1,-1,-1
	dc.l	-1,-1,-1,00,-1,-1,-1
	dc.l	-1,-1,-1,00,-1,-1,-1
	dc.l	-1,-1,-1,00,-1,-1,-1
	dc.l	-1,-1,-1,00,-1,-1,-1
	dc.l	-1,-1,-1,00,-1,-1,-1
	dc.l	-1,-1,-1,00,-1,-1,-1
	dc.l	00,-1,-1,00,00,-1,-1



	end
