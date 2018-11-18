; RTF to Deskjet filter                                 06/11/93 O.Fink
;

        include win1_spread_printer_mac

        section prog
        data    4096

         printer  DeskJet
rtf_cmds prtcmd   line
         prtcmd   page
         prtcmd   smal
         prtcmd   norm
         prtcmd   lett
         prtcmd   draf
         prtcmd   side
         prtcmd   init
         prtend

cde_line dc.w     1
         dc.b     10
cde_page dc.w     1
         dc.b     12
cde_smal dc.w     6
         dc.b     27,'(s20H'
cde_norm dc.w     6
         dc.b     27,'(s10H'
cde_lett dc.w     5
         dc.b     27,'(s2Q'
cde_draf dc.w     5
         dc.b     27,'(s1Q'
cde_side dc.w     5
         dc.b     27,'&l1O'
cde_init dc.w     5
         dc.b     27,'&l0O'

        nop
        end
