;Sprite source code generated with EASYSOURCE  1990 Albin Hessler Software
;************************************************************************** 

;Sprite  ->  spread_s  <-    1992 Feb 27 15:02:15

	 section   sprite
	 xdef	   mes_tims
	 xref	   mes_zero
mes_tims
sp1
	 dc.w  $0100,$0000	    ;form, time/adaption
	 dc.w  $0007,$0007	    ;x size, y size 
	 dc.w  $0003,$0003	    ;x origin, y origin 
	 dc.l  cp1-*		    ;pointer to colour pattern
	 dc.l  mes_zero-*		 ;pointer to pattern mask
	 dc.l  0		    ;pointer to next definition 
cp1
	 dc.w  $8282,$0000
	 dc.w  $4444,$0000
	 dc.w  $2828,$0000
	 dc.w  $1010,$0000
	 dc.w  $2828,$0000
	 dc.w  $4444,$0000
	 dc.w  $8282,$0000
;
	 end
