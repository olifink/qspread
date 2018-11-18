* Sprite sprite_wake
*
*	Mode 4
*	+------|-------+
*	|	      a|
*	|	     a |
*	|      a   aa  |
*	|     aa aaa   |
*	-    aaaaaa    -
*	|   aaa aa     |
*	|  aa	a      |
*	| a	       |
*	|a	       |
*	+------|-------+
*
	section sprite
	xdef	mes_wake

	include 'dev8_keys_sysspr'

mes_wake
	dc.b	0,sp.wake

	end
