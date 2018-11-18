* Spreadsheet					      29/11-91
*	 - qdos job startup

	 include  win1_mac_oli
	 include  win1_spread_keys

	 section  init

	 xdef	  cltab
	 xref	  start
	 xref.l   qs_vers


	bra.l	start
	dc.w	0
	dc.w	$4afb
qd_name
	dc.w	7
	dc.b	'QSpread  1992-2003 Jochen Merz Software   V'
	ds.w	0
	dc.l	qs_vers
	dc.b	10,0


;	  qdosjob  {QSpread},start,36          ; standard SMS2 job
;	  dc.b	   10,10,'written and (c) by O.Fink, 1992-94',10,10
;	  dc.l	   'Vers','ion ',qs_vers
;	  dc.b	   10,10
;	  ds.w	   0
cltab	 clkey	  {f},0,da_fname,40
	 clkey	  {h},0,da_helpd,40
	 clkey	  {d},0,da_fltd,40
	 clkey	  {e},0,da_fextn,6
	 clkey

	 end
