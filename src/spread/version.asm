	section text

	xdef	qs_vers
	xdef	qs_date1,qs_date2,qs_date3
	xdef	met_vers


qs_date1 equ	 ' |30'
qs_date2 equ	 '.01.'
qs_date3 equ	 '03| '

qs_vers  equ	  '3.02'
met_vers dc.w	  4
	 dc.l	  qs_vers

;	... idea for 3.03: GOTO after load.
;	rounding probs. because fix in 3.01

; 3.02	First high-colour version.
; 3.01	290.5/7000 produced something like 0.0415.000 - fixed.
;	 Changed in st_expnd.

; 3.00	New File format 1.04:
;	Password introduced
;	Print icon prints block/page
;	Context menu: End of block, units, justif., column width,
;	   ins rows, del rows, ins cols, del cols.
;	   If DOne inside a block, it will apply to the block, otherwise for
;	   the current cell.
;	SHIFT while left click will mark end of block.
;	String input requests appear near cursor and do not pull cursor away.
;	Parameter string filename can be up to 41 chars.
;	Export suggests filename.
;	Import does not clear suggested filename anymore.
;	Compatibility check for file version finally implemented.
;	New import filters (extension _imf, Export filter extension _exf).
;	Units menu has pre-defined 0,1,2,3 digits

; 2.12	Partially released with intermediate file format 1.03.
; 2.11	- (minus) bug fixed: single minus or minus at end of formula.
;
; 2.10	New status word introduced.
;	Fourth config menu with more print options.
; 2.08	ESC in grid with special mode enables just clears special mode.
;	Save with new filename now suggests current name.
; 2.07	Boolean two-character comparisons fixed.
; 2.06	Print options / Print icon changed.
; 2.05	IF works again (call parser again with ')' replaced by end marker.
;	Help texts corrected in English and German version.
; 2.04	0.0x is shown as 0.0x and not as 0.00.
; 2.03	First cell of block-entry is treated specially.
; 2.02	Double-brackets now treated correctly.
; 2.01	CTRL W now inserts rows.
;	Colours for F2/F3/F4 fixed.
; 2.00	First release version.

; 2œ10	Selection keystrokes in Grid menu corrected.
; 2œ09	Change printer/filter options menu completely redone.
;	Pica/Elite/Condensed, Draft and FF added to the print menu.
;	Configuration block texts improved.
; 2œ08	Date icon cleared when TAB field selected.
;	New print filter partially implemented.
; 2œ07	Parsing much safer: missing brackets etc. do not create crashes.
; 2œ06	DATE icon now inserts current date.
;	Default date format and separator configurable.
; 2œ04	DATE icon introduced next to SUM icon - inserts DATE$(DATE())
;	Major change in formula parser: | (and others) treated as string.
; 2œ03	Quit when not saved will always request confirmation
; 2œ02	Right mouse button marks end of block again.
; 2œ01	CTRL X works
;	CTRL N does not draw junk on screen.
;	A4 bug in save does not crash on TT anymore.
;	Initial pointer position always inside grid.
;	Save/Save icon does not ask for overwrite if confirmation is off.
; 2.00	Window can be resized after putting QSpread to sleep.
;	Year 2k bug fixed in DATE$
;	First cell TAB problem fixed.
;	English and German texts tidied up, EURO introduced.
;	cntnum(r1:r2) implemented. Counts number of numerical fields in range.
;	Multiple characters (e.g. --- or ===== are treated as text.
;	F2/F3/F4 menu redone. All shortcuts new assigned!
;	Lots of icons introduced - toolbar at top.
;	Double "." bug in small numbers fixed.
;	SHIFT TAB is 3-line edit.
;	ESC puts job to sleep.
;	Auto-cursor-move: none, down, right (not in block entry mode).
;	Six currency symbols configurable.
;	ALT TAB from inside grid moves pointer outside grid.

; 1.45	Save with new filename and export use full file-select menu.
;	ESC from file-select menu does not report error anymore.
; 1.44	Cell entry bug fixed (SMSQ only) - thanks to Tony.
; 1.43	-.xxx becomes -0.xxxx
;	Column entry without block mark does not stop at column 27 ($1b) ESC!
; 1.42	Re-release of 1.40 with minor bug fix.
; 1.41	Never existed. 1.39 was released as 1.41.
; 1.40	(20/05/97)
;	Default colourway from Menu-rext implemented.
; 1.39	(21/04/97)
;	.00x, .000x etc. displayed corrected
; 1.38	(07/04/97)
;	If mu_xbtn returns <> Hit, Do or ESC => Do.
;	Fixed problem with backup-file.
; 1.37	(06/04/97)
;	Fixed problems with channel zero.
;	Keys rearranged.
;	Find on last cell in row or column works.
; 1.36	(17/03/97)
;	Fixed problem with round.
;	Fixed problems inserted in V1.35.
;	QSpread needs WMAN V1.52 and Menu-Rext V7.00. (wm.rprt and mu_xbtn)
; 1.35	(08/03/97)
;	Number of re-calculations can be configured.
;	String references don't work anymore, not possible yet!
;	Block cell entry reads, single cell entry edits.
;	Try to suppress too narrow sections - WMAN changes required.
;	Find backwards works(nearly see V1.37)).
;	DATE$ accepts format parameter.
; 1.34	(25/11/96)
;	Reloc.
;	New selection keystrokes in status-menu (german version).
; 1.33	(18/11/96)
;	\f in parameter string works again.
; 1.32	(04/11/96)
;	perfect column width works
;	new selection keystroke for Cell/Monetary symbol
; 1.31	(27/09/96)
;	print page results in a endless loop.
; 1.30	(22/08/96)
;	PI bug corrected
;	serious stack crawl problem in main loop removed
;	TAB puts cursor at end of text
;	SHIFT SPACE (INS) acts as DO on TAB
;	DO on TAB brings up large formula edit window
;	UP and DOWN in Size Col/row window brings you from row to col or vv.
;	Size Col/row menu remembers last settings
;	Text references are copied now, but reference not kept!
;	Out of memory treated correctly during start-up
;	SGN(x) function added.
; 1.29	(??/??/??)
; 1.28	(19/01/95)
;	printing bug removed
;	recalculate twice after loading a sheet
; 1.27	(30/9/94)
;	error in formula parser removed
;	backspace and del (Entf) erase cells
;	no confirmation request when one cell is erased
;	enter always goes to next cell in grid
;	perfect width included (^0, DO on tool)
;	DO on find tool repeats search
;	cell protection included
;	window size limited when using tabs smaller than screen
; 1.26	(28/4/94)
;	confirmation request on quit corrected
; 1.25	(19/2/94)
;	index colours for monochrome changed
;	forulae report function included
;	date in jobheader intorduced
; 1.24	(4/1/94)
;	cell values created during loading
;	!err reported if arithmetic overflow to preserve formula
;	old block restored after print page
; 1.23	Filter names now in Printer Options menu
;	filename not altered when importing
;	specific infos for load/save/import/export given (filename edit)
;	local directories for help/data/filter/printer in Status
;	zero size file doesn't delete current sheet
;	Export fileformat changed
;	Jobname problem solved (works as thing and Hotkey)
; 1.22	window size parameters in config block corrected
;	local directory introduced
;	no search if start cell is outside used area
;	comparisons/logical function introduced in parser
;	copy (recalc) error corrected
;	new (uti_oli_wm) resize routine used
;	xfn(x) and xfn$(x) introduced
;	error with deleting continued strings removed
;	date(), date$() and time$() introduced
;	correct cell processed after selection mode
;	if() introduced
; 1.21	correction made, no access to $0.w (runs on 030 again now)
; 1.20	Toolbox introduced
;	status window for Toolbox adjusted
; 1.19	(internal)
;	file name is also put into jobname
;	justification for strings introduced!
;	no monetary symbol when cell is empty
; 1.18	column width function corrected (from 1.17 curr. item border)
;	find works correct now
;	digit$() current (problems with more than 7 digits)
; 1.17	current item border in grid can be de-configured
;	find window added
;	F8 is now all, F9 is search agagin
;	GO TO action defaults to the TLH cell of the block
;	util_strg_lib changed back in xpnde (down to E8)
; 1.16	util_strg_lib changed in xpnde (up to E9)
;	set digits window introduced
;	digit$ function included
;	continue with EDIT after cell ID mode
;	splitted config block introduced
; 1.15	data entry mainly done via READ instead of EDIT
;	strings do not overflow into already used cells
;	goto top/bottom in F10 item introduced
;	cell adjustment for all formula (strings too)
;	insert first column problem cured
; 1.14	file error for row-order files removed
;	some changes in information texts
;	confirmation request only when required
;	ctrl-M was wrong in text, should have been ctrl-V
;	zero decimal places can be configured now
;	copy/move cells now takes care of the format as well
;	multiple column insert with reference adjustment
;	multiple row insert with reference adjustment
;	recalculation routines changed a bit
;	string storage in internal data area corrected
;	\h,\d,\e command line switches added
;	nr. col/row limited from 2 to 9999 in config block
;	multiple column delete with reference adjustment
;	multiple row delete with reference adjustment
;	no shortcut keys allowed in special modes
;	current cell highlighted during entry
; 1.13	(skipped for superstitious reasons)
; 1.12	new uti_lib used (problems etc. cured, I hope!)
;	About.. QSpread window introduced
;	Filter directory path is kept
;	extended help functions
;	units window pulled down at correct position
; 1.11	intelligent entry detection (recognizes text automatically)
;	direct entry of text/formulae/data from grid winodw
;	empty if same as above introduced (and taken over in 1.01 filefmt)
;	filter job selection (no longer file name entry)
;	extended error system introduced (esp. file format recogn.)
;	macros now saved in file format 1.01
;	active pipe end owned by filter job for error detection
;	block marking smoothed (cosmetic change)
; 1.10	first version to allow movement of block with cursor keys
;	inserted column was 2 pixels to small, that was confusing
;	  to the save file command (introduced in 1.09)
; 1.09	int(x) added
;	name of file is used in button
;	maximum window size reduced for top line to button frame
;	window setup error removed (introduced in 1.08)
;	column delete/insert adjust column widths now
; 1.08	preset file with command line \f filename
;	percentage (%) operator in formula parser
;	error in reference removed (introduced in 1.07)
;	export file doesn't get extension appended
;	filenamelength in editing expanded to 40 chars
;	cell identification mode during editing introduced
; 1.07	references to multi-letter columns (e.g. AA5) corrected
;	spelling mistakes in german config corrected
;	PI constant added in variable evaluation
;	new version of formula parsers linked
;	rint(x) added
;	round on decimal places (in status menu) added
; 1.06	save filename entry mode more convenient
;	ESC resets normal mode (only Zzz puts job to sleep now!)
; 1.05	goto cell (F10) introduced
; 1.04	absolute cell references introduced (square backets)
;	echo cell over range function introduced
;	block alloaction increased to 10k per block
;	rel. references maintained during copy/move block
; 1.03	monochrome mode display introduced
;	current block redrawn after special mode execution
;	2nd macro function correct configurable
;	confirmation request added
; 1.02	correct nr of columns set after loading
;	default nr of cols/rows used with forget instead of current sheet size
;	malicious load file bug fixed (slot allocation)
;	cells outside sheet ignored
;	slot size doubled ($20) to streamline memory allocations
;	units works correct with no decimal places etc.
;	seperator (on/off) and its symbol (,Ÿ) configurable now
;	configured monetary symbol is now used too
; 1.01	check for extended environemnt included
;	application error reporting changed
; 1.00	first release









	 end
