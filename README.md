# eth-notes
A 'bundle' of miscellaneous packages that I have developped—first for taking lecture notes at [ETH](http://www.ethz.ch), then for other means such as typesetting student organization bylaws and meeting minutes.
 - `Makefile` and the accompanying `Variables.ini` are up-to-date versions from my version of [`latex-makefile`](https://github.com/westernmagic/latex-makefile)
 - `wmnotes.sty` is the master file, that over the years has accumulated a lot of different packages, with a loading order that works miraculously—it's held by duct tape, really...
 - `wmnotes.cls` is the accompanying class file that should be split in at least 3 files...
 - `wmpatch.sty` contains an amalgamation of patches for the packages we load
 - `wmref.sty` is a handy referencing scheme
 - `wmtext.sty` implements text decorations
 - `wmversions.sty` handles changes in documents—usefull for typesetting a version of the bylaws with all changes since their conception
 - `wmtheorem.sty` makes fancy page-breaking boxes for theorems, lemmata and examples in the lecture notes
 - `wmptt.cls` is our beamer class
 - `wml3.sty` are useful LaTeX3 functions we created
 - `vsuzh.cls` and `kosta.cls` are style files for their respective organizations
 - `fontconvert.sh` is a handy [FontForge](https://fontforge.github.io/) script for—you guessed it—converting fonts between formats
