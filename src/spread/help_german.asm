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

i0	msg	{Fenster verschieben}                                   ; 0
i1	msg	{Fenster vergr„œern\Maximale/Minimale Gr„œe}
i2	msg	{In Button Frame legen}
i3	msg	{Dateien-Men‡}
i4	msg	{Gitter-Men‡}
i5	msg	{Zellen-Men‡}
i6	msg	{Status-Men‡}
i7	msg	{Functionen & Makros}
i8	msg	{Goto Zelle}
i9	msg	{Formel/Text-Eingabe}
i11	msg	{Linie}
i12	msg	{Formel/Text auf gesamten Bereich anwenden}
i13	msg	{Summe des Bereichs}
i13a	msg	{Aktuelles Datum}
i15	msg	{Hilfe-Men‡\Info ‡ber QSpread}
i16	msg	{Lade Arbeitsblatt\Import aus Datei}
i17	msg	{Speichere mit aktuellem Dateinamen\Speichere mit neuem Dateinamen}
i18	msg	{Drucke Block\Drucke Seite}
i19	msg	{Suche}
i20	msg	{Wiederhole letzte Suche}
i21	msg	{Echo Zelle ‡ber Bereich}
i22	msg	{Kopiere Zelle oder Bereich}
i23	msg	{Verschiebe Zelle oder Bereich}
i24	msg	{L„sche Zelle oder Bereich}
i25	msg	{Sch‡tze Zelle oder Bereich\Entsch‡tze Zelle oder Bereich}
i26	msg	{§berschreibe Zwischenablage mit aktuellem Bereich}
i27	msg	{Zahlen-Darstellung}
i28	msg	{W€hrungs-Symbol}
i29	msg	{Zelle oder Bereich linksb‡ndig}
i30	msg	{Zelle oder Bereich rechtsb‡ndig}
i31	msg	{Spaltenbreite einstellen\Perfekte Spaltenbreite}
i32	msg	{Arbeitsblatt neu berechnen}

	end
