# QSpread - Spreadsheet for the QL Extended Environment

This is the very first code drop of QSpread. It was originally written by me in 1992 (I believe)
and distributed as commercial software by Jochen Merz Software (JMS), who also later together
with Bernd Reinhard nurtoured it up to version 4.04. Unfortunately the code for the original 
versions doesn't exist anymore, but it realtivly easy to spot the additions made by their (more professional) coding.

The software is now freely available as Public Domain and the sources are made available here 
under the MIT License.

A big thanks to [Marcel Kilgus](https://www.kilgus.net/) who took over the content from Jochen
and for helping to find the current sources and agreeing to open sourcing them.

The current version is 3.02 and you also find the binaries in the `disk` directory. There is 
also a 4.04 version but it appears to possibly have some problems. Also, we're still recovering
the source code for that version and I would like to verify that it can build the executables
correctley before creating a new version here.

Speaking of building - a word of warning: I have yet to try a complete clean build from what 
is now here on GitHub. It will probably fail because you need to have some include and key files
from [SMSQ/E](http://www.wlenerz.com/smsqe/). These were mixed freely into the original sources
and I decided to clean it all up while moving it here. So expect changes. The plan is to have
the application specific files available as `dev7_` while everything that are OS includes on
`dev8_`. I haven't done this yet - and actually I'm looking to find a low friction way to handle
git code drops from QPC. For the first drop I've using a ZIP, which is a good enough start and
also converted the file extensions from `_asm` to `.asm` - which makes more sense on GitHub, but
certainly screw up your native QL build if they are not also converted back.

So for now, take the sources might be of academic interest but not yet able to build the native
executable. It's a beginning of another journey - so expect changes to come...

enjoy. O