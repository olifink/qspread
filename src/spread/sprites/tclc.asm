;Sprite source code generated with EASYSOURCE V3.02
; 1991/92  Albin Hessler Software
;************************************************

;   ->	 tclc  <-    1993 Jul 03 00:13:39

	 section   sprite
	 xdef	   mes_tclc
	 xref	   mes_zero


mes_tclc
sp1_tclc
	 dc.w  $0100,$0000	    ;form, time/adaption
	 dc.w  $000F,$0015	    ;x size, y size 
	 dc.w  $0007,$000A	    ;x origin, y origin 
	 dc.l  cp1_tclc-*	    ;pointer to colour pattern
	 dc.l  mes_zero-*	    ;pointer to pattern mask
	 dc.l  0		    ;pointer to next definition 
cp1_tclc
	 dc.w  $7F7F,$FCFC
	 dc.w  $80FF,$02FE
	 dc.w  $BFFF,$FAFE
	 dc.w  $BFFF,$FAFE
	 dc.w  $80FF,$02FE
	 dc.w  $B6FF,$DAFE
	 dc.w  $B6FF,$DAFE
	 dc.w  $80FF,$02FE
	 dc.w  $B6FF,$DAFE
	 dc.w  $B6FF,$DAFE
	 dc.w  $80FF,$02FE
	 dc.w  $B6FF,$DAFE
	 dc.w  $B6FF,$DAFE
	 dc.w  $80FF,$02FE
	 dc.w  $B6FF,$DAFE
	 dc.w  $B6FF,$DAFE
	 dc.w  $80FF,$1AFE
	 dc.w  $B6FF,$DAFE
	 dc.w  $B6FF,$DAFE
	 dc.w  $80FF,$02FE
	 dc.w  $7F7F,$FCFC

;
	 end
