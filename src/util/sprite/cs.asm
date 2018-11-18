* Sprite cs
*
*       Mode 4
*       +|-----------+
*       - gg g  gg  g-
*       |g   g g  g g|
*       |g     g     |
*       |g      gg   |
*       |g        g  |
*       |g     g  g  |
*       | gg    gg   |
*       +|-----------+
*
        section sprite
        xdef    mes_cs
        xref    mes_zero
mes_cs
        dc.w    $0100,$0000
        dc.w    12,7,0,0
        dc.l    sc4_cs-*
        dc.l    mes_zero-*
        dc.l    0
sc4_cs
        dc.w    $6900,$9000
        dc.w    $8A00,$5000
        dc.w    $8200,$0000
        dc.w    $8100,$8000
        dc.w    $8000,$4000
        dc.w    $8200,$4000
        dc.w    $6100,$8000
*
        end
