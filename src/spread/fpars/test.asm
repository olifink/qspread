
	include win1_mac_oli

	section prog
	qdosjob {Parser Test}

	move.l	#1024,d1		; allocate one K
	xjsr	ut_alchp
	bne	exit

	move.l	a0,a5
	move.l	a0,a1
	add.l	#512,a1
	lea	form,a0
	suba.l	a2,a2
	suba.l	a3,a3
	moveq	#0,d1

	xjsr	prs_form

exit
	xjsr	ut_appr

form
	qstrg	{2*1-2*2-2*3}
	ds.w	5


	end
