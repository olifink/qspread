* Sprite insg
*
*       Mode 4
*       +---|---+
*       |ggggggg|
*       |ggggggg|
*       |ggggggg|
*       |ggggggg|
*       |ggggggg|
*       -ggggggg-
*       |ggggggg|
*       |ggggggg|
*       |ggggggg|
*       |ggggggg|
*       +---|---+
*
        section sprite
        xdef    mes_insg
mes_insg
        dc.w    $0100,$0c00             ; on for 12 ticks
        dc.w    7,10,3,5
        dc.l    sc4_insg-*
        dc.l    sm4_insg-*
        dc.l    4
        dc.w    $0100,$1800             ; off for 12 ticks
        dc.w    1,10,3,5
        dc.l    so4_insg-*
        dc.l    sm4_insg-*
        dc.l    0

sc4_insg
        dc.w    $fe00,$0000
        dc.w    $fe00,$0000
        dc.w    $fe00,$0000
        dc.w    $fe00,$0000
        dc.w    $fe00,$0000
        dc.w    $fe00,$0000
        dc.w    $fe00,$0000
        dc.w    $fe00,$0000
        dc.w    $fe00,$0000
        dc.w    $fe00,$0000

so4_insg
        dc.w    $8000,$0000
        dc.w    $8000,$0000
        dc.w    $8000,$0000
        dc.w    $8000,$0000
        dc.w    $8000,$0000
        dc.w    $8000,$0000
        dc.w    $8000,$0000
        dc.w    $8000,$0000
        dc.w    $8000,$0000
        dc.w    $8000,$0000

sm4_insg
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
