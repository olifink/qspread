*
* Sprite musspr
*
*       Mode 4
*       +--|----+
*       |    a  |
*       |    aa |
*       |    a a|
*       |    a a|
*       |    a  |
*       |    a  |
*       |    a  |
*       | aaaa  |
*       -aaaaa  -
*       | aaa   |
*       +--|----+
*
        section   sprite

        xdef    mes_mus

mes_mus
        dc.w    $0100,$0000
        dc.w    7,10,2,8
        dc.l    sc4_musspr-*
        dc.l    sm4_musspr-*
        dc.l    0
sc4_musspr
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
sm4_musspr
        dc.w    $0808,$0000
        dc.w    $0C0C,$0000
        dc.w    $0A0A,$0000
        dc.w    $0A0A,$0000
        dc.w    $0808,$0000
        dc.w    $0808,$0000
        dc.w    $0808,$0000
        dc.w    $7878,$0000
        dc.w    $F8F8,$0000
        dc.w    $7070,$0000
