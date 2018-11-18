* Sprite ct
*
*       Mode 4
*       +|----------+
*       - gg g ggg g-
*       |g   g  g  g|
*       |g      g   |
*       |g      g   |
*       |g      g   |
*       |g      g   |
*       | gg    g   |
*       +|----------+
*
        section sprite
        xdef    mes_ct
        xref    mes_zero
mes_ct
        dc.w    $0100,$0000
        dc.w    11,7,0,0
        dc.l    sc4_ct-*
        dc.l    mes_zero-*
        dc.l    0
sc4_ct
        dc.w    $6B00,$A000
        dc.w    $8900,$2000
        dc.w    $8100,$0000
        dc.w    $8100,$0000
        dc.w    $8100,$0000
        dc.w    $8100,$0000
        dc.w    $6100,$0000
*
        end
