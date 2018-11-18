* Sprite undo
*
*	Mode 4
*	+|-----------------+
*	|    ww 	   |
*	-   wrw 	   -
*	|  wrrwwwwwwww	   |
*	| wrrarrrrrrrrww   |
*	|wrraararrarrarrw  |
*	| wrrarrrrrrrrrarw |
*	|  wrrwwwwwwwwrrrrw|
*	|   wrw       wwrrw|
*	|    ww 	ww |
*	|	      wwrrw|
*	|	wwwwwwrrrrw|
*	|	wrrrrrrarw |
*	|	wrararrrw  |
*	|	wrrrrrww   |
*	|	wwwwww	   |
*	+|-----------------+
*
	section sprite
	xdef	mes_undo
	xref	mes_zero
mes_undo
	dc.w	$0100,$0000
	dc.w	18,15,0,1
	dc.l	mcs_undo-*
	dc.l	mes_zero-*
	dc.l	0
mcs_undo
	dc.w	$0C0C,$0000
	dc.w	$0000,$0000
	dc.w	$141C,$0000
	dc.w	$0000,$0000
	dc.w	$273F,$F8F8
	dc.w	$0000,$0000
	dc.w	$4077,$06FE
	dc.w	$0000,$0000
	dc.w	$80E5,$01B7
	dc.w	$0000,$0000
	dc.w	$4077,$00FD
	dc.w	$8080,$0000
	dc.w	$273F,$F8FF
	dc.w	$40C0,$0000
	dc.w	$141C,$0607
	dc.w	$40C0,$0000
	dc.w	$0C0C,$0101
	dc.w	$8080,$0000
	dc.w	$0000,$0607
	dc.w	$40C0,$0000
	dc.w	$0101,$F8FF
	dc.w	$40C0,$0000
	dc.w	$0101,$00FD
	dc.w	$8080,$0000
	dc.w	$0101,$01AF
	dc.w	$0000,$0000
	dc.w	$0101,$06FE
	dc.w	$0000,$0000
	dc.w	$0101,$F8F8
	dc.w	$0000,$0000
*
	end
