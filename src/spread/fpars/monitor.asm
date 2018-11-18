* Parser Monitor
*

	include win1_mac_oli
	include win1_keys_qdos_ioa
	include win1_spread_fpars_keys

	section pars

	xdef	pma_init,pma_item
	xdef	pma_stak,pma_clos
	xdef	pma_ops

pmt_pipe qstrg	{pipe_monitor}
pmt_item qstrg	{found: }
pmt_stak qstrg	{  stack: }
pmt_ops  qstrg	{  ops: }

pma_init subr	a0-a3/d0-d3
	lea	pmt_pipe,a0	; open pipeline
	moveq	#ioa.kexc,d3
	xjsr	gu_fopen
	move.l	a0,pma_ch(a5)	; store channel ID
	subend

pma_clos subr	a0
	move.l	pma_ch(a5),a0
	xjsr	ut_prlf
	xjsr	gu_fclos
	subend

pma_item subr	a0-a4/d0-d3
	move.l	a1,a4		; save item address
	move.l	pma_ch(a5),a0	; channel id
	lea	pmt_item,a1
	xjsr	ut_prstr	; print item text
	move.l	a4,a1
	jsr	ut_prstr	; item item itself
	xjsr	ut_prspc
	move.l	d2,d1
	xjsr	ut_prchr	; print delimiter
	subend

pma_stak subr	a0-a4/d0-d3

	lea	pma_buff(a5),a0
	move.l	pd_stak(a5),a1
*	 subq.l  #6,a1
	xjsr	ut_fpdec
	move.l	a0,a1
	move.l	pma_ch(a5),a0
	lea	pmt_stak,a1
	xjsr	ut_prstr
	lea	pma_buff(a5),a1
	xjsr	ut_prstr
	subend

pma_ops subr	a0-a4/d0-d3

	move.l	pma_ch(a5),a0
	lea	pmt_ops,a1
	xjsr	ut_prstr
	move.l	pd_plev(a5),a1
	move.w	lv_opcnt(a1),d1
	xjsr	ut_priwd
	xjsr	ut_prlf
	subend

	end
