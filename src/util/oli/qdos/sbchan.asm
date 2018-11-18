* SuperBASIC channel stuff                 July 1989  J.R.Oakley  QView
*                                         (mod. for SMS2 keys.. O.Fink)
        section utility
*
        include win1_keys_bv
        include win1_keys_chn
        include win1_keys_err
        include win1_keys_qdos_ioa
        include win1_keys_qlv

ch.lench equ    $28
ch.id    equ    $00
*
        xdef    sb_getch
        xdef    sb_numtoid
*+++
* Get a channel number and/or ID from first SuperBASIC parameter
* -> sb_getch
*
* Registers:
*       Entry                           Exit
* D0                                    +ve no channel, -ve error, 0 channel OK
* D1                                    n if #n coded, else -1
* A0                                    channel ID if \device, else -1
* A3    first parameter                 updated if channel present
*---
sb_getch
get_ch
        move.b  1(a6,a3.l),d0           ; hash?
        bmi.s   gc_chnum                ; yes, it's a number
        and.b   #$70,d0                 ; mask out separator
        cmp.b   #$30,d0                 ; backslash?
        beq.s   gc_devic                ; yes, it's a device
        moveq   #1,d0                   ; no, no channel
exit
        rts
chnumreg reg    a2/a5
gc_chnum
        movem.l chnumreg,-(sp)
        lea     8(a3),a5                ; get just one parameter
        move.w  sb.gtint,a2             ; it's an integer
        jsr     (a2)
        tst.l   d0
        bne.s   gcn_exit                ; ...oops
        move.l  a5,a3                   ; remove parameter
        move.l  bv_rip(a6),a2
        move.w  0(a6,a2.l),d1           ; this is channel number
        sub.l   a0,a0
        subq.l  #1,a0                   ; no channel ID
gcn_exit
        tst.l   d0
        movem.l (sp)+,chnumreg
        rts
*
* Come here if first parameter followed by backslash: one after that is
* string or name: open this and return channel ID
*
gc_devic
        addq.l  #8,a3                   ; skip first null parameter
        bsr.s   get_name                ; and get a name to RI stack
        bne.s   gcd_exit

        move.l  a1,a0                   ; it's here
        moveq   #-1,d1                  ; for me
        moveq   #ioa.knew,d3            ; new (exclusive) file
        moveq   #ioa.open,d0
        trap    #4                      ; A6-relative 
        trap    #2                      ; open it
        tst.l   d0
        bne.s   gcd_exit                ; ...oops
        moveq   #-1,d1
gcd_exit
        tst.l   d0
        rts
*
* Come here to get a string or name
*
gtnreg  reg     d1-d5/a0/a2/a5
get_name
        movem.l gtnreg,-(sp)
        move.b  1(a6,a3.l),d0           ; get type byte
        and.b   #$0F,d0                 ; just the type
        cmp.b   #$01,d0                 ; string?
        beq.s   gtn_gstr                ; yes, get it
        move.w  2(a6,a3.l),d0           ; no, get name pointer
        bmi.s   gtn_exbp                ; bad is just -1 really...
*
* Come here if it was a name without quotes
*
        ext.l   d0
        lsl.l   #3,d0                   ; index into name table
        add.l   bv_ntbas(a6),d0         ; which starts here
        move.w  2(a6,d0.l),d0           ; so name is here is name list
        ext.l   d0
        add.l   bv_nlbas(a6),d0         ; i.e. here!
        move.l  d0,a2                   ; keep it safe
        moveq   #0,d1
        move.b  (a6,a2.l),d1            ; name is this long
        move.w  d1,d4                   ; keep it safe

        addq.l  #3,d1                   
        bclr    #0,d1                   ; space for length
        move.w  d1,d5                   ; keep that too
        move.w  qa.resri,a1             ; ensure...
        jsr     (a1)                    ; ...there'll be space for it all
        move.l  bv_rip(a6),a1
        sub.w   d5,a1                   ; where string goes
        move.l  a1,a0                   ; smashable copy
        move.w  d4,0(a6,a1.l)           ; length to stack
        bra.s   gtn_cpne
gtn_cpnl
        move.b  1(a6,a2.l),2(a6,a0.l)   ; copy name characters
        addq.l  #1,a2
        addq.l  #1,a0
gtn_cpne
        dbra    d4,gtn_cpnl             ; until they're all done
gtn_exok
        addq.l  #8,a3                   ; knock parameter off list
        moveq   #0,d0
gtn_exit
        movem.l (sp)+,gtnreg
        rts
gtn_exbp
        moveq   #err.ipar,d0
        bra.s   gtn_exit
*
* Come here if the user put quotes on his device
*
gtn_gstr
        move.w  sb.gtstr,a1             ; get a string
        jsr     (a1)
        move.l  bv_rip(a6),a1           ; point to it
        bra.s   gtn_exit
*+++
* Convert SuperBASIC channel number into an ID
* -> sb_numtoid
*
*  Entry:                               Exit:
*  D0.w channel number                  A0 channel id
*---
sb_numtoid
numtoid
        mulu    #ch.lench,d0            ; SB channels are this big
        add.l   bv_chbas(a6),d0         ; and start here
        cmp.l   bv_chp(a6),d0           ; too high?
        bge.s   nti_exno                ; yes, not open
        move.l  ch.id(a6,d0.l),d0       ; get ID
        bmi.s   nti_exno
        move.l  d0,a0
        moveq   #0,d0
nti_exit
        rts
nti_exno
        moveq   #err.ichn,d0
        bra.s   nti_exit
*
        end
