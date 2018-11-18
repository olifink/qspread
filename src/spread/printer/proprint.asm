; RTF to ProPrinter filter                                 06/11/93 O.Fink
;

        include win1_spread_printer_mac

        section prog
        data    4096

         printer  ProPrinter
rtf_cmds prtcmd   line
         prtcmd   page
         prtcmd   smal
         prtcmd   ql
         prtcmd   lett
         prtcmd   draf
         prtcmd   init
         prtend

cde_line dc.w     1
         dc.b     10
cde_page dc.w     1
         dc.b     12
cde_ql   dc.w     4
         dc.b     27,'a',0
cde_init dc.w     2
         dc.b     27,'@'
cde_smal dc.w     1
         dc.b     15
cde_lett dc.w     3
         dc.b     27,'x',1
cde_draf dc.w     3
         dc.b     27,'x',0

        nop

        end
