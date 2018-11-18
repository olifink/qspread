* Sprite mainspr
*
*       Mode 4
*       +------|------+
*       |     www     |
*       |     waw     |
*       |     waw     |
*       |     waw     |
*       |wwwwwa awwwww|
*       -waaaa   aaaaw-
*       |wwwwwa awwwww|
*       |     waww    |
*       |     waw     |
*       |     waw     |
*       |     www     |
*       +------|------+
*
        section   sprite

        xdef    mes_main

mes_main
        dc.w    $0100,$0000
        dc.w    13,11,6,5
        dc.l    sc4_mainspr-*
        dc.l    sm4_mainspr-*
        dc.l    0
sc4_mainspr
        dc.w    $0707,$0000
        dc.w    $0505,$0000
        dc.w    $0505,$0000
        dc.w    $0505,$0000
        dc.w    $F8F8,$F8F8
        dc.w    $8080,$0808
        dc.w    $F8F8,$F8F8
        dc.w    $0505,$8080
        dc.w    $0505,$0000
        dc.w    $0505,$0000
        dc.w    $0707,$0000
sm4_mainspr
        dc.w    $0707,$0000
        dc.w    $0707,$0000
        dc.w    $0707,$0000
        dc.w    $0707,$0000
        dc.w    $FDFD,$F8F8
        dc.w    $F8F8,$F8F8
        dc.w    $FDFD,$F8F8
        dc.w    $0707,$8080
        dc.w    $0707,$0000
        dc.w    $0707,$0000
        dc.w    $0707,$0000
