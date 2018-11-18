* Sprite penc
*
*       Mode 4
*       +-----------------|+
*       -               aag-
*       |              aggw|
*       |            aagggw|
*       |          aaagggw |
*       |         arrgagw  |
*       |        arrgrgaw  |
*       |       arrgrgga   |
*       |      arrgrggwa   |
*       |     arrgrggwa    |
*       |    arrgrggwa     |
*       |   arrgrggwa      |
*       |  aaaarggwa       |
*       | awwwwagwa        |
*       |awwaawwaa         |
*       |awwaawwa          |
*       | awwwwa           |
*       |  aaaa            |
*       +-----------------|+
*
        section sprite

        xdef    mes_penc

mes_penc
        dc.w    $0100,$0000
        dc.w    18,17,17,0
        dc.l    mcs_penc-*
        dc.l    mms_penc-*
        dc.l    0
mcs_penc
        dc.w    $0000,$0000
        dc.w    $4000,$0000
        dc.w    $0000,$0100
        dc.w    $C040,$0000
        dc.w    $0000,$0300
        dc.w    $C040,$0000
        dc.w    $0000,$0700
        dc.w    $8080,$0000
        dc.w    $0000,$0B31
        dc.w    $0000,$0000
        dc.w    $0000,$1569
        dc.w    $0000,$0000
        dc.w    $0000,$2CD0
        dc.w    $0000,$0000
        dc.w    $0001,$5CA4
        dc.w    $0000,$0000
        dc.w    $0003,$B848
        dc.w    $0000,$0000
        dc.w    $0106,$7090
        dc.w    $0000,$0000
        dc.w    $020D,$E020
        dc.w    $0000,$0000
        dc.w    $0102,$C040
        dc.w    $0000,$0000
        dc.w    $3D3C,$8080
        dc.w    $0000,$0000
        dc.w    $6666,$0000
        dc.w    $0000,$0000
        dc.w    $6666,$0000
        dc.w    $0000,$0000
        dc.w    $3C3C,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0000
mms_penc
        dc.w    $0000,$0101
        dc.w    $C0C0,$0000
        dc.w    $0000,$0303
        dc.w    $C0C0,$0000
        dc.w    $0000,$0F0F
        dc.w    $C0C0,$0000
        dc.w    $0000,$3F3F
        dc.w    $8080,$0000
        dc.w    $0000,$7F7F
        dc.w    $0000,$0000
        dc.w    $0000,$FFFF
        dc.w    $0000,$0000
        dc.w    $0101,$FEFE
        dc.w    $0000,$0000
        dc.w    $0303,$FEFE
        dc.w    $0000,$0000
        dc.w    $0707,$FCFC
        dc.w    $0000,$0000
        dc.w    $0F0F,$F8F8
        dc.w    $0000,$0000
        dc.w    $1F1F,$F0F0
        dc.w    $0000,$0000
        dc.w    $3F3F,$E0E0
        dc.w    $0000,$0000
        dc.w    $7F7F,$C0C0
        dc.w    $0000,$0000
        dc.w    $FFFF,$8080
        dc.w    $0000,$0000
        dc.w    $FFFF,$0000
        dc.w    $0000,$0000
        dc.w    $7E7E,$0000
        dc.w    $0000,$0000
        dc.w    $3C3C,$0000
        dc.w    $0000,$0000
*
        end
