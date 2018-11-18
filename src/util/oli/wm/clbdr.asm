* QMail Sun, 1992 Jul 12
*    - Extended window manager functions

        include win1_keys_wman
        include win1_keys_wstatus
        include win1_mac_oli

        section utility

        xdef    xwm_clbdr                ; clear current item border

*+++
* Clear current item border
*
*       a1 : wstat
*       a2 : wmvec
*---
xwm_clbdr subr a1-a3/d1-d5
        bset    #15,ws_citem(a1)
        tst.l   ws_ciact(a1)
        beq.s   normal
        jsr     ws_ciact(a1)
        clr.l   ws_ciact(a2)
        bra.s   clbdr_exit
normal
        jsr     wm.drbdr(a2)
clbdr_exit
        tst.l   d0
        subend

        end
