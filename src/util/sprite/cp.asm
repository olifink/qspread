* Sprite cp
*
*       Mode 4
*       +|-----------+
*       - gg g ggg  g-
*       |g   g g  g g|
*       |g     g  g  |
*       |g     ggg   |
*       |g     g     |
*       |g     g     |
*       | gg   g     |
*       +|-----------+
*
        section sprite
        xdef    mes_cp
        xref    mes_zero
mes_cp
        dc.w    $0100,$0000
        dc.w    12,7,0,0
        dc.l    sc4_cp-*
        dc.l    mes_zero-*
        dc.l    0
sc4_cp
        dc.w    $6B00,$9000
        dc.w    $8A00,$5000
        dc.w    $8200,$4000
        dc.w    $8300,$8000
        dc.w    $8200,$0000
        dc.w    $8200,$0000
        dc.w    $6200,$0000
*
        end
