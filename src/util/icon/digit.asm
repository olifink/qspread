* Sprite digit
*
*       Mode 4
*       +|-------------------+
*       -w     w  wwwww     w-
*       |ww   ww   www w   ww|
*       |ww   ww      ww   ww|
*       |ww   ww      ww   ww|
*       |ww   ww      ww   ww|
*       |w www w      ww   ww|
*       | wwwww   wwww w   w |
*       |     ww w wwww     w|
*       |     ww ww        ww|
*       |     ww ww        ww|
*       |     ww ww        ww|
*       |     ww ww        ww|
*       |     ww w www  ww ww|
*       |     w   wwwww ww w |
*       +|-------------------+
*
        section sprite
        xdef    mes_digit
mes_digit
        dc.w    $0100,$0000
        dc.w    20,14,0,0
        dc.l    mcs_digit-*
        dc.l    mms_digit-*
        dc.l    0
mcs_digit
        dc.w    $8282,$7C7C
        dc.w    $1010,$0000
        dc.w    $C6C6,$3A3A
        dc.w    $3030,$0000
        dc.w    $C6C6,$0606
        dc.w    $3030,$0000
        dc.w    $C6C6,$0606
        dc.w    $3030,$0000
        dc.w    $C6C6,$0606
        dc.w    $3030,$0000
        dc.w    $BABA,$0606
        dc.w    $3030,$0000
        dc.w    $7C7C,$7A7A
        dc.w    $2020,$0000
        dc.w    $0606,$BCBC
        dc.w    $1010,$0000
        dc.w    $0606,$C0C0
        dc.w    $3030,$0000
        dc.w    $0606,$C0C0
        dc.w    $3030,$0000
        dc.w    $0606,$C0C0
        dc.w    $3030,$0000
        dc.w    $0606,$C0C0
        dc.w    $3030,$0000
        dc.w    $0606,$B9B9
        dc.w    $B0B0,$0000
        dc.w    $0404,$7D7D
        dc.w    $A0A0,$0000
mms_digit
        dc.w    $8282,$7C7C
        dc.w    $1010,$0000
        dc.w    $C6C6,$3A3A
        dc.w    $3030,$0000
        dc.w    $C6C6,$0606
        dc.w    $3030,$0000
        dc.w    $C6C6,$0606
        dc.w    $3030,$0000
        dc.w    $C6C6,$0606
        dc.w    $3030,$0000
        dc.w    $BABA,$0606
        dc.w    $3030,$0000
        dc.w    $7C7C,$7A7A
        dc.w    $2020,$0000
        dc.w    $0606,$BCBC
        dc.w    $1010,$0000
        dc.w    $0606,$C0C0
        dc.w    $3030,$0000
        dc.w    $0606,$C0C0
        dc.w    $3030,$0000
        dc.w    $0606,$C0C0
        dc.w    $3030,$0000
        dc.w    $0606,$C0C0
        dc.w    $3030,$0000
        dc.w    $0606,$B9B9
        dc.w    $B0B0,$0000
        dc.w    $0404,$7D7D
        dc.w    $A0A0,$0000
*
        end
