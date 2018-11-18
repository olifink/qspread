* Sprite cm
*
*       Mode 4
*       +|------------+
*       - gg g g   g g-
*       |g   g gg gg g|
*       |g     g g g  |
*       |g     g g g  |
*       |g     g   g  |
*       |g     g   g  |
*       | gg   g   g  |
*       +|------------+
*
        section sprite
        xdef    mes_cm
        xref    mes_zero
mes_cm
        dc.w    $0100,$0000
        dc.w    13,7,0,0
        dc.l    sc4_cm-*
        dc.l    mes_zero-*
        dc.l    0
sc4_cm
        dc.w    $6A00,$2800
        dc.w    $8B00,$6800
        dc.w    $8200,$A000
        dc.w    $8200,$A000
        dc.w    $8200,$2000
        dc.w    $8200,$2000
        dc.w    $6200,$2000
*
        end
