100 REMark Sample filter (printer driver)
110 REMark for QD
120 REMark All bytes come in via #0
130 REMark and should be sent to #1
140 :
150 REPeat loop
160  IF EOF(#0):STOP: REMark That's it
170  BGET#0,c       : REMark Fetch char
180  SELect ON c
190   =1:Control_code
200   REMark ... insert your translations
210   =REMAINDER :BPUT#1,c:REMark Write char
220  END SELect
230 END REPeat loop
240 :
250 DEFine PROCedure Control_code
260  BGET#0,o
270  SELect ON o
280   =CODE('+'):REMark Printer preamble-code
290    BPUT#1,27,64:REMark Reset printer
300   =CODE('-'):REMark Printer postamble-code
310    BPUT#1,27,64:REMark Reset printer
320   =CODE('P'):REMark Select Pica
330    BPUT#1,27,80
340   =CODE('E'):REMark Select Elite
350    BPUT#1,27,77
360   =CODE('C'):REMark Select Condensed
370    BPUT#1,27,80,15
380   =CODE('D'):REMark Draft on/off
390    BGET#0,d:BPUT#1,27,120,NOT d
410   =CODE('I'):REMark Italics on/off
420   =CODE('B'):REMark Bold on/off
430   =CODE('H'):REMark Highlight on/off
435   =CODE('U'):REMark Underline on/off
440   =CODE('f'):REMark Fetch filename
450  END SELect
460  REMark Now search for end of code
470  REPeat eoc
480   BGET#0,c
490   IF c=2:EXIT eoc
500  END REPeat
510 END DEFine
