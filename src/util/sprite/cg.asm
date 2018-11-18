* Sprite cg
*
*       Mode 4
*       +|-----------+
*       - gg g  ggg g-
*       |g   g g    g|
*       |g     g     |
*       |g     g gg  |
*       |g     g  g  |
*       |g     g  g  |
*       | gg    ggg  |
*       +|-----------+
*
        section sprite
        xdef    mes_cg
        xref    mes_zero
mes_cg
        dc.w    $0100,$0000
        dc.w    12,7,0,0
        dc.l    sc4_cg-*
        dc.l    mes_zero-*
        dc.l    0
sc4_cg
        dc.w    $6900,$D000
        dc.w    $8A00,$1000
        dc.w    $8200,$0000
        dc.w    $8200,$C000
        dc.w    $8200,$4000
        dc.w    $8200,$4000
        dc.w    $6100,$C000
*
        end
