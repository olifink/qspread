; Do infinite I/O

        section utility

        xdef    do_io

        include win1_keys_qdos_io

;+++
; Do infinite i/O
;
;               Entry                           Exit
;       d0      I/O code                        smashed
;       a0      channel ID                      preserved
;
;       Error returns: all usual I/O returns
;       Condition codes set on return
;---
do_io
        move.l  d3,-(sp)
        moveq   #forever,d3
        trap    #do.io
        move.l  (sp)+,d3
        tst.l   d0
        rts

        end
