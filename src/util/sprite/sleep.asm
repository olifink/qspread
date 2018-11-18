* Sprite ssleep
*
*	Mode 4
*	+------|-------+
*	|aaaaaa        |
*	|   aa	       |
*	|  aa  aaaa    |
*	- aa	 a     -
*	|aaaaaa a   aaa|
*	|      aaaa  a |
*	|	    aaa|
*	+------|-------+
*
	section sprite
	xdef	mes_slep

	include 'dev8_keys_sysspr'

mes_slep
	dc.b	0,sp.sleep

	end
