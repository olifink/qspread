100 OPEN_NEW #1,'con_'
110 PAPER 0
120 INK 4
130 BORDER 1,255
140 CLS
150 PRINT "Command line:";cmd$
160 adr=cmd$
170 PRINT "Top of stack:";PEEK_F(adr)
180 PRINT "New value: 1.234"
190 POKE_F adr,1.234
200 INPUT #1,a$
