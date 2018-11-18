* Sprite insl
*
*       Mode 4
*       +---|---+
*       |rrrrrrr|
*       |rrrrrrr|
*       |rrrrrrr|
*       |rrrrrrr|
*       |rrrrrrr|
*       -rrrrrrr-
*       |rrrrrrr|
*       |rrrrrrr|
*       |rrrrrrr|
*       |rrrrrrr|
*       +---|---+
*
        section sprite
        xdef    mes_insl
mes_insl
        dc.w    $0100,$0c00             ; on for 12 ticks
        dc.w    7,10,3,5
        dc.l    sc4_insl-*
        dc.l    sm4_insl-*
        dc.l    4
        dc.w    $0100,$1800             ; off for 12 ticks
        dc.w    1,10,3,5
        dc.l    so4_insl-*
        dc.l    sm4_insl-*
        dc.l    0

sc4_insl
        dc.w    $00FE,$0000
        dc.w    $00FE,$0000
        dc.w    $00FE,$0000
        dc.w    $00FE,$0000
        dc.w    $00FE,$0000
        dc.w    $00FE,$0000
        dc.w    $00FE,$0000
        dc.w    $00FE,$0000
        dc.w    $00FE,$0000
        dc.w    $00FE,$0000

so4_insl
        dc.w    $0080,$0000
        dc.w    $0080,$0000
        dc.w    $0080,$0000
        dc.w    $0080,$0000
        dc.w    $0080,$0000
        dc.w    $0080,$0000
        dc.w    $0080,$0000
        dc.w    $0080,$0000
        dc.w    $0080,$0000
        dc.w    $0080,$0000

sm4_insl
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
