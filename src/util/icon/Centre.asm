* Sprite Centre
*
*       Mode 4
*       +|--------------+
*       -  aaaaaaaaaaaaa-
*       | a a          a|
*       |a  a          a|
*       |aaaa aaaaa    a|
*       |a             a|
*       |a  aaaaaaaaa  a|
*       |a             a|
*       |a    aaaaa    a|
*       |a             a|
*       |a  aaaaaaaaa  a|
*       |a             a|
*       |a    aaaaa    a|
*       |a             a|
*       |a             a|
*       |a             a|
*       |aaaaaaaaaaaaaaa|
*       +|--------------+
*
        section sprite
        xdef    mes_Centre
mes_Centre
        dc.w    $0100,$0000
        dc.w    15,16,0,0
        dc.l    mcs_Centre-*
        dc.l    mms_Centre-*
        dc.l    0
mcs_Centre
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
mms_Centre
        dc.w    $3F3F,$FEFE
        dc.w    $5050,$0202
        dc.w    $9090,$0202
        dc.w    $F7F7,$C2C2
        dc.w    $8080,$0202
        dc.w    $9F9F,$F2F2
        dc.w    $8080,$0202
        dc.w    $8787,$C2C2
        dc.w    $8080,$0202
        dc.w    $9F9F,$F2F2
        dc.w    $8080,$0202
        dc.w    $8787,$C2C2
        dc.w    $8080,$0202
        dc.w    $8080,$0202
        dc.w    $8080,$0202
        dc.w    $FFFF,$FEFE
*
        end
