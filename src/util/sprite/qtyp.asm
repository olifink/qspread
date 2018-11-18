* Sprite sqtyp
*
*       Mode 4
*       +-----------------|
*       | ggg             |
*       |g   g            |
*       |g   g            |
*       -g   g ggg g g gg -
*       |g   g  g  g g g g|
*       |g g g  g   g  gg |
*       |g  g   g   g  g  |
*       | gg g  g   g  g  |
*       +-----------------|
*
        section sprite
        xdef    mes_qtyp
mes_qtyp
        dc.w    $0100,$0000
        dc.w    17,8,17,3
        dc.l    sc4_sqtyp-*
        dc.l    sm4_sqtyp-*
        dc.l    0
sc4_sqtyp
        dc.w    $7000,$0000
        dc.w    $0000,$0000
        dc.w    $8800,$0000
        dc.w    $0000,$0000
        dc.w    $8800,$0000
        dc.w    $0000,$0000
        dc.w    $8B00,$AB00
        dc.w    $0000,$0000
        dc.w    $8900,$2A00
        dc.w    $8000,$0000
        dc.w    $A900,$1300
        dc.w    $0000,$0000
        dc.w    $9100,$1200
        dc.w    $0000,$0000
        dc.w    $6900,$1200
        dc.w    $0000,$0000
sm4_sqtyp
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
*
        end
