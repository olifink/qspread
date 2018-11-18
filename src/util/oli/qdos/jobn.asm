; set a new jobname                                            O. Fink

        include win1_mac_oli
        include win1_keys_jcb

        section utility

        xdef    ut_jobn                 ; set a new jobname

;+++
; set a new jobname
;
;               Entry                   Exit
;       d1.l    job id (or -1)
;       a0      ptr to string
;
; error and cc set
;---
ut_jobn subr    a0/a1
        xjsr    ut_gtjn                 ; get job name
        bne.s   exit
        exg     a0,a1
        xjsr    ut_cpyst
exit    subend

        end
