* Sprite left
*
*       Mode 4
*       +|---------------+
*       |      a         |
*       |    aa        aa|
*       |  aaaa      aa  |
*       -aaaaaaaaaaaa    -
*       |  aaaa      aa  |
*       |    aa        aa|
*       |      a         |
*       +|---------------+
*
        section sprite
        xdef    mes_left
mes_left
        dc.w    $0100,$0000
        dc.w    16,7,0,3
        dc.l    sc4_left-*
        dc.l    sm4_left-*
        dc.l    0
sc4_left
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0202,$0000
        dc.w    $0C0C,$0303
        dc.w    $3C3C,$0C0C
        dc.w    $FFFF,$F0F0
        dc.w    $3C3C,$0C0C
        dc.w    $0C0C,$0303
        dc.w    $0202,$0000
sm4_left
        dc.w    $0202,$0000
        dc.w    $0C0C,$0303
        dc.w    $3C3C,$0C0C
        dc.w    $FFFF,$F0F0
        dc.w    $3C3C,$0C0C
        dc.w    $0C0C,$0303
        dc.w    $0202,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
*
        end
