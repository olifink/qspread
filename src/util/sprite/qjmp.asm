*
* Sprite qjump
*
*       Mode 4
*       +|-------------------------------+
*       -    aaa                         -
*       |  aaaaaaa                       |
*       | aaaa aaaa                      |
*       | aa     aa                      |
*       |aaa     aaa                     |
*       |aa       aa                     |
*       |aa       aa      a  a a   a     |
*       |aa       aa      a  a aa aa     |
*       |aa       aa    a a  a a a a aaa |
*       |aa       aa    a a  a a   a a  a|
*       |aa       aa    a a  a a   a a  a|
*       |aa       aa    a  aa  a   a aaa |
*       |aaa   aa aa a  a            a   |
*       | aa   aaaa   aa   aaaaaaaa  a   |
*       | aaaa  aaaaa    aaaaaaaaaaaa    |
*       |  aaaaaaaaaaaaaaaaa      aaaaaa |
*       |    aaa    aaaaaa          aaaa |
*       +|-------------------------------+
*
         section  sprite

        xdef    meb_qjmp

meb_qjmp
        dc.w    $0100,$0000
        dc.w    32,17,0,0
        dc.l    0
        dc.l    sm4_qjump-*
        dc.l    0
sm4_qjump
        dc.w    $0E0E,$0000
        dc.w    $0000,$0000
        dc.w    $3F3F,$8080
        dc.w    $0000,$0000
        dc.w    $7B7B,$C0C0
        dc.w    $0000,$0000
        dc.w    $6060,$C0C0
        dc.w    $0000,$0000
        dc.w    $E0E0,$E0E0
        dc.w    $0000,$0000
        dc.w    $C0C0,$6060
        dc.w    $0000,$0000
        dc.w    $C0C0,$6060
        dc.w    $4A4A,$2020
        dc.w    $C0C0,$6060
        dc.w    $4B4B,$6060
        dc.w    $C0C0,$6161
        dc.w    $4A4A,$AEAE
        dc.w    $C0C0,$6161
        dc.w    $4A4A,$2929
        dc.w    $C0C0,$6161
        dc.w    $4A4A,$2929
        dc.w    $C0C0,$6161
        dc.w    $3232,$2E2E
        dc.w    $E3E3,$6969
        dc.w    $0000,$0808
        dc.w    $6363,$C6C6
        dc.w    $3F3F,$C8C8
        dc.w    $7979,$F0F0
        dc.w    $FFFF,$F0F0
        dc.w    $3F3F,$FFFF
        dc.w    $E0E0,$7E7E
        dc.w    $0E0E,$1F1F
        dc.w    $8080,$1E1E
        dc.w    $3F3F,$FFFF
        dc.w    $E0E0,$7E7E
        dc.w    $0E0E,$1F1F
        dc.w    $8080,$1E1E
        dc.w    $3F3F,$FFFF
        dc.w    $E0E0,$7E7E
        dc.w    $0E0E,$1F1F
        dc.w    $8080,$1E1E
        dc.w    $0E0E,$1F1F
        dc.w    $8080,$1E1E
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0E0E,$1F1F
        dc.w    $8080,$1E1E
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
