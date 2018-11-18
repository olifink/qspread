	section language

	xdef	tab_explanation

msg	macro	text
[.lab]	dc.w	[.len(text)]
	dc.b	'[text]'
	endm

tab_explanation
	dc.l	0
	dc.l	loose-*
	dc.l	0

loose
	dc.w	33
	dc.w	i0-*
	dc.w	i1-*
	dc.w	i2-*
	dc.w	i3-*
	dc.w	i4-*
	dc.w	i5-*
	dc.w	i6-*
	dc.w	i7-*
	dc.w	i8-*
	dc.w	i9-*
	dc.w	0
	dc.w	i11-*
	dc.w	i12-*
	dc.w	i13-*
	dc.w	i13a-*
	dc.w	0
	dc.w	i15-*
	dc.w	i16-*
	dc.w	i17-*
	dc.w	i18-*
	dc.w	i19-*
	dc.w	i20-*
	dc.w	i21-*
	dc.w	i22-*
	dc.w	i23-*
	dc.w	i24-*
	dc.w	i25-*
	dc.w	i26-*
	dc.w	i27-*
	dc.w	i28-*
	dc.w	i29-*
	dc.w	i30-*
	dc.w	i31-*
	dc.w	i32-*

i0	msg	{Move window}                                   ; 0
i1	msg	{Resize window\Maximum/minimum window}
i2	msg	{Sleep}
i3	msg	{Files menu}
i4	msg	{Grid menu}
i5	msg	{Cell menu}
i6	msg	{Status menu}
i7	msg	{Functions & macros}
i8	msg	{Goto cell}
i9	msg	{Formulae/text entry}
i11	msg	{Line}
i12	msg	{Apply formulae/text to range}
i13	msg	{Sum over range}
i13a	msg	{Current date}
i15	msg	{Help menu\Info about QSpread}
i16	msg	{Load sheet\Import from file}
i17	msg	{Save sheet under current filename\Save with new filename}
i18	msg	{Print block\Print page}
i19	msg	{Search}
i20	msg	{Repeat last search}
i21	msg	{Echo cell over range}
i22	msg	{Copy cell or range}
i23	msg	{Move cell or range}
i24	msg	{Delete cell or range}
i25	msg	{Protect cell or range\Unprotect cell or range}
i26	msg	{Overwrite scrap with current range}
i27	msg	{Number representation}
i28	msg	{Currency symbol}
i29	msg	{Left-justify cell or range}
i30	msg	{Right-justify cell or range}
i31	msg	{Change column width\Perfect column width}
i32	msg	{Recalculate sheet}


	end
