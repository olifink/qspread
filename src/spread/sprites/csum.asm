;Sprite source code generated with EASYSOURCE  1990 Albin Hessler Software
;************************************************************************** 

;Sprite  ->  spread_s  <-    1992 Feb 18 13:42:10

	 section   sprite
	 xdef	   mes_csum
	 xref	   mes_zero

mes_csum
sp1
	 dc.w  $0100,$0000	    ;form, time/adaption
	 dc.w  $0006,$0009	    ;x size, y size 
	 dc.w  $0000,$0000	    ;x origin, y origin 
	 dc.l  cp1-*		    ;pointer to colour pattern
	 dc.l  mes_zero-*	    ;pointer to pattern mask
	 dc.l  sp_csum-*	    ;pointer to next definition
cp1
	 dc.w  $FCFC,$0000
	 dc.w  $8484,$0000
	 dc.w  $4040,$0000
	 dc.w  $2020,$0000
	 dc.w  $1010,$0000
	 dc.w  $2020,$0000
	 dc.w  $4040,$0000
	 dc.w  $8484,$0000
	 dc.w  $FCFC,$0000

sp_csum
	incbin 'win1_Spread_sprites_csum_spr'
;
	 end
