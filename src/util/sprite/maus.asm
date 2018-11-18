* Sprite maus
*
*       Mode 4
*       +|-------------------------------+
*       -            aaaaaa         w w  -
*       |           aagwgwgaa       ww   |
*       |          aggwgwgwgga      w w  |
*       |    aaaaa agwgwgwgwgga          |
*       |  aagwgwgaawgwgrrrrwga       aaa|
*       | awgwgwgwgaawrrgwwwra       aaaa|
*       |awgwgwgwgwgwrwgwaaaaraaa aaagaaa|
*       |agagwgwgwgwgwgwawwwaagwgagwgwga |
*       |awawgwgwgwgwgwgawwaaawgwgwgwga  |
*       |agagwgwgwgwgwgwgaaaawgwgwgwaa   |
*       |agawgwgwgwgagwgwgwgwgwgwgaa     |
*       | agawgwgwgwawgwrwgwgwgaaa       |
*       | agagggggwawgwgwrrrrrr          |
*       |  agaawgwawgwgwgwgwga   www wwww|
*       |    aaaaawgwgwgwaaaa    w    w  |
*       |         aggwgwa         ww  w  |
*       |         agggwa         www  w w|
*       +|-------------------------------+
*
        section sprite

        xdef    mes_maus

mes_maus
        dc.w    $0100,$0000
        dc.w    32,17,0,0
        dc.l    mcs_maus-*
        dc.l    mms_maus-*
        dc.l    0
mcs_maus
        dc.w    $0000,$0000
        dc.w    $0000,$1414
        dc.w    $0000,$0702
        dc.w    $C080,$1818
        dc.w    $0000,$1F05
        dc.w    $F040,$1414
        dc.w    $0000,$1F0A
        dc.w    $F8A0,$0000
        dc.w    $0F05,$9E15
        dc.w    $18F0,$0000
        dc.w    $3F2A,$C98E
        dc.w    $E0F0,$0000
        dc.w    $7F55,$F75D
        dc.w    $0008,$0800
        dc.w    $5F0A,$FEAA
        dc.w    $E7E2,$7C28
        dc.w    $5F55,$FE54
        dc.w    $C7C5,$F850
        dc.w    $5F0A,$FFAA
        dc.w    $0F0A,$E0A0
        dc.w    $5F15,$EF45
        dc.w    $FF55,$8000
        dc.w    $2F0A,$EEAB
        dc.w    $FCA8,$0000
        dc.w    $2F00,$DF55
        dc.w    $00FC,$0000
        dc.w    $1302,$BFAA
        dc.w    $F0A0,$EFEF
        dc.w    $0000,$7F55
        dc.w    $0000,$8484
        dc.w    $0000,$3E0A
        dc.w    $0000,$6464
        dc.w    $0000,$3C04
        dc.w    $0000,$E5E5
        dc.w    $0000,$0F0F
        dc.w    $C0C0,$1414
        dc.w    $0000,$1F1F
        dc.w    $F0F0,$1818
        dc.w    $0000,$3F3F
        dc.w    $F8F8,$1414
        dc.w    $0F0F,$BFBF
        dc.w    $FCFC,$0000
        dc.w    $3F3F,$FFFF
        dc.w    $FCFC,$0707
        dc.w    $7F7F,$FFFF
        dc.w    $F8F8,$0F0F
        dc.w    $FFFF,$FFFF
        dc.w    $FFFF,$7F7F
        dc.w    $FFFF,$FFFF
        dc.w    $FFFF,$FEFE
        dc.w    $FFFF,$FFFF
mms_maus
        dc.w    $0000,$0F0F
        dc.w    $C0C0,$1414
        dc.w    $0000,$1F1F
        dc.w    $F0F0,$1818
        dc.w    $0000,$3F3F
        dc.w    $F8F8,$1414
        dc.w    $0F0F,$BFBF
        dc.w    $FCFC,$0000
        dc.w    $3F3F,$FFFF
        dc.w    $FCFC,$0707
        dc.w    $7F7F,$FFFF
        dc.w    $F8F8,$0F0F
        dc.w    $FFFF,$FFFF
        dc.w    $FFFF,$7F7F
        dc.w    $FFFF,$FFFF
        dc.w    $FFFF,$FEFE
        dc.w    $FFFF,$FFFF
        dc.w    $FFFF,$FCFC
        dc.w    $FFFF,$FFFF
        dc.w    $FFFF,$F8F8
        dc.w    $FFFF,$FFFF
        dc.w    $FFFF,$E0E0
        dc.w    $7F7F,$FFFF
        dc.w    $FFFF,$8080
        dc.w    $7F7F,$FFFF
        dc.w    $FCFC,$0000
        dc.w    $3F3F,$FFFF
        dc.w    $F8F8,$EFEF
        dc.w    $0F0F,$FFFF
        dc.w    $F0F0,$8484
        dc.w    $0000,$7F7F
        dc.w    $0000,$6464
        dc.w    $0000,$7E7E
        dc.w    $0000,$E5E5
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
        dc.w    $0000,$0000
*
        end
