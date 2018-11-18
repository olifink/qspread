	 section sprite

	 xdef	mes_usage
	 xref	mes_zero

mes_usage
mes_marker
	 dc.w  $0100,$0000	    ;form, time/adaption
	 dc.w	20,16		    ;x size, y size
;;;	    dc.w  $0011,$0011	       ;x size, y size
	 dc.w  $0000,$0000	    ;x origin, y origin
	 dc.l  cp_marker-*	    ;pointer to colour pattern
	 dc.l  mes_zero-*	    ;pointer to pattern mask
	 dc.l  sp_marker-*	    ;pointer to next definition

cp_marker
	 dc.w  $0000,$0606,$0000,$0000
	 dc.w  $0000,$0F0F,$0000,$0000
	 dc.w  $0000,$151D,$0000,$0000
	 dc.w  $0000,$2B3B,$0000,$0000
	 dc.w  $0000,$5777,$8080,$0000
	 dc.w  $0000,$ACEC,$8080,$0000
	 dc.w  $0101,$59D9,$8080,$0000
	 dc.w  $0303,$B3B3,$0000,$0000
	 dc.w  $0607,$E6E6,$0000,$0000
	 dc.w  $0C0F,$CCCC,$0000,$0000
	 dc.w  $191F,$9898,$0000,$0000
	 dc.w  $333F,$0000,$0000,$0000
	 dc.w  $667E,$0000,$0000,$0000
	 dc.w  $CCFC,$0000,$0000,$0000
	 dc.w  $98F8,$0000,$0000,$0000
	 dc.w  $B0F0,$0000,$0000,$0000
	 dc.w  $E060,$0000,$0000,$0000

*
sp_marker
	incbin	'win1_util_icon_asm_marker_spr'

	 end
