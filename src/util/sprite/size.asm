* Sprite size
*
*	Mode 4
*	+------|-----+
*	|aaaaaaaaaaaa|
*	|aaggggggggaa|
*	|aaggggggggaa|
*	-aaggaaaaaaaa-
*	|aaggaaggggaa|
*	|aaggaaggggaa|
*	|aaaaaaaaaaaa|
*	+------|-----+
*
	section sprite
	xdef	mes_size

	include 'dev8_keys_sysspr'
mes_size
	dc.b	0,sp.wsize

	end
