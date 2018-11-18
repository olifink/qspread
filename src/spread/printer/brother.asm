; RTF to Brother HR filter                                 06/11/93 O.Fink
;

        include win1_spread_printer_mac

        section prog
        data    4096

         printer  Brother
rtf_cmds prtcmd   line
         prtcmd   page
         prtend

cde_line dc.w     1
         dc.b     10
cde_page dc.w     1
         dc.b     12

        nop
        end
