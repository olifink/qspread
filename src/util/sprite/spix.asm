* Sprite spix
*
*       Mode 4
*       +----|------+
*       |    r r    |
*       |    g g    |
*       |    r r    |
*       |    r r    |
*       |rgrra arrgr|
*       -           -
*       |rgrra arrgr|
*       |    r r    |
*       |    r r    |
*       |    g g    |
*       |    r r    |
*       +----|------+
*
        section sprite

        xdef    mes_spix

mes_spix
        dc.w    $0100,$0000
        dc.w    11,11,4,5
        dc.l    mcs_spix-*
        dc.l    mms_spix-*
        dc.l    0
mcs_spix
        dc.w    $000A,$0000
        dc.w    $0A00,$0000
        dc.w    $000A,$0000
        dc.w    $000A,$0000
        dc.w    $40B1,$40A0
        dc.w    $0000,$0000
        dc.w    $40B1,$40A0
        dc.w    $000A,$0000
        dc.w    $000A,$0000
        dc.w    $0A00,$0000
        dc.w    $000A,$0000
mms_spix
        dc.w    $0A0A,$0000
        dc.w    $0A0A,$0000
        dc.w    $0A0A,$0000
        dc.w    $0A0A,$0000
        dc.w    $FBFB,$E0E0
        dc.w    $0000,$0000
        dc.w    $FBFB,$E0E0
        dc.w    $0A0A,$0000
        dc.w    $0A0A,$0000
        dc.w    $0A0A,$0000
        dc.w    $0A0A,$0000
*
        end
