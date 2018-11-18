; change a loose item to a sleep item

        include win1_mac_oli
        include win1_keys_wwork
        include win1_keys_k

        section utility

        xdef    xwm_chgslp

;+++
; change a loose item to a sleep item
;
;               Entry                           Exit
;       d1.l    loose item number
; no errors
;---
xwm_chgslp subr a1/a3
        xjsr    xwm_liadr
        move.b  #2,wwl_type(a3)
        xlea    mes_slep,a1
        move.l  a1,wwl_pobj(a3)
        xlea    mea_slep,a1
        move.l  a1,wwl_pact(a3)
        move.b  #k.cancel,wwl_skey(a3)
        subend

        end
