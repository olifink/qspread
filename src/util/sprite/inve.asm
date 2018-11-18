* Sprite inve
*
*       Mode 4
*       +|-----------------------------+
*       -                   aaaaaaaaaaa-
*       |             gg    aaaaaaaaaaa|
*       |  aaaa a     gag   aaa    a aa|
*       | a    aa      gag  aa aaaa  aa|
*       |a      a      rrag a aaaaaa aa|
*       |a      a    rraaaaga aaaaaa aa|
*       |a     aa  rraarrag a aaaaa  aa|
*       | a   a a raarrgag  aa aaa a aa|
*       |  aaa  aa rr gag   aaa   aa  a|
*       |             gg    aaaaaaaaaaa|
*       +|-----------------------------+
*
        section sprite

        xdef    mes_inve

mes_inve
        dc.w    $0100,$0000
        dc.w    30,10,0,0
        dc.l    mcs_inve-*
        dc.l    mms_inve-*
        dc.l    0
mcs_inve
        dc.w    $0000,$0000
        dc.w    $0000,$0000
        dc.w    $0000,$0600
        dc.w    $0000,$0000
        dc.w    $0000,$0500
        dc.w    $0000,$0000
        dc.w    $0000,$0200
        dc.w    $8000,$0000
        dc.w    $0000,$0003
        dc.w    $4000,$0000
        dc.w    $0000,$000C
        dc.w    $2000,$0000
        dc.w    $0000,$0033
        dc.w    $4000,$0000
        dc.w    $0000,$024C
        dc.w    $8000,$0000
        dc.w    $0000,$0530
        dc.w    $0000,$0000
        dc.w    $0000,$0600
        dc.w    $0000,$0000
mms_inve
        dc.w    $0000,$0000
        dc.w    $1F1F,$FCFC
        dc.w    $0000,$0606
        dc.w    $1F1F,$FCFC
        dc.w    $3D3D,$0707
        dc.w    $1C1C,$2C2C
        dc.w    $4343,$0303
        dc.w    $9B9B,$CCCC
        dc.w    $8181,$0303
        dc.w    $D7D7,$ECEC
        dc.w    $8181,$0F0F
        dc.w    $F7F7,$ECEC
        dc.w    $8383,$3F3F
        dc.w    $D7D7,$CCCC
        dc.w    $4545,$7F7F
        dc.w    $9B9B,$ACAC
        dc.w    $3939,$B7B7
        dc.w    $1C1C,$6464
        dc.w    $0000,$0606
        dc.w    $1F1F,$FCFC
*
        end
