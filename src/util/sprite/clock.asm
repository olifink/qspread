* Sprite clck
*
*       Mode 4
*       +|------------+
*       -      g      -
*       |    wwwww    |
*       |  wwaagaaww  |
*       | waaaagaaaaw |
*       |waaaaagaaaaaw|
*       |waaaaagggggaw|
*       | waaaaaaaaaw |
*       |  wwaaaaaww  |
*       | gg wwwww gg |
*       |gg         gg|
*       +|------------+
*
        section sprite
        xdef    mes_clck
mes_clck
        dc.w    $0100,$0000
        dc.w    13,10,0,0
        dc.l    sc4_clck-*
        dc.l    sm4_clck-*
        dc.l    0
sc4_clck
        dc.w    $0200,$0000
        dc.w    $0F0F,$8080
        dc.w    $3230,$6060
        dc.w    $4240,$1010
        dc.w    $8280,$0808
        dc.w    $8380,$E808
        dc.w    $4040,$1010
        dc.w    $3030,$6060
        dc.w    $6F0F,$B080
        dc.w    $C000,$1800
sm4_clck
        dc.w    $0202,$0000
        dc.w    $0F0F,$8080
        dc.w    $3F3F,$E0E0
        dc.w    $7F7F,$F0F0
        dc.w    $FFFF,$F8F8
        dc.w    $FFFF,$F8F8
        dc.w    $7F7F,$F0F0
        dc.w    $3F3F,$E0E0
        dc.w    $6F6F,$B0B0
        dc.w    $C0C0,$1818
*
        end
