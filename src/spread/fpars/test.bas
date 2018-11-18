100 DEFine PROCedure init
110   base=ALCHP(40*1024)
120   form=base+2048
130   tos=form+2048
135   pos=0
140   LBYTES 'win1_spread_fpars_test_bin',base
150   formula$="2*1-2*2-2*3"
160   POKE_$ form,form$
165   PRINT HEX$(base,32)
170 END DEFine
180 :
190 DEFine PROCedure test
200   CALL base,pos,0,0,0,0,0,0,form,tos,0,0,0,0
210 END DEFine
