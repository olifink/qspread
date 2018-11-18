* Sprite cl
*
*       Mode 4
*       +|-----------+
*       - gg g g    g-
*       |g   g g    g|
*       |g     g     |
*       |g     g     |
*       |g     g     |
*       |g     g     |
*       | gg   gggg  |
*       +|-----------+
*
        section sprite
        xdef    mes_cl
        xref    mes_zero
mes_cl
        dc.w    $0100,$0000
        dc.w    12,7,0,0
        dc.l    sc4_cl-*
        dc.l    mes_zero-*
        dc.l    0
sc4_cl
        dc.w    $6A00,$1000
        dc.w    $8A00,$1000
        dc.w    $8200,$0000
        dc.w    $8200,$0000
        dc.w    $8200,$0000
        dc.w    $8200,$0000
        dc.w    $6300,$C000
*
        end
