* Sprite move
*
*	Mode 4
*	+------|-----+
*	|aaaaaaaa    |
*	|aaggggaa    |
*	|aaggggaa    |
*	|aaggaaaaaaaa|
*	-aaaaaaaaggaa-
*	|    aaggggaa|
*	|    aaggggaa|
*	|    aaaaaaaa|
*	+------|-----+
*
	section sprite
	xdef	mes_move

	include 'dev8_keys_sysspr'

mes_move
	dc.b	0,sp.wmove

	end
