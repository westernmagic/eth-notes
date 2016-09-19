\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wmcv}[2016/04/06]

\geometry{
	a4paper          ,
	top       = 35mm ,
	left      = 15mm ,
	right     = 15mm ,
	bottom    = 15mm ,
	headheight = 10mm ,
	headsep = 5mm ,
	footskip = 10mm
}
\savegeometry{cv}
\fancypagestyle{cv}{
	\fancyhf{}
	\fancyhf[HL]{}
	\fancyhf[HC]{}
	\fancyhf[HR]{\MyAuthor ~-~\MyTitle}
	\fancyhf[FL]{}
	\fancyhf[FC]{\thepage}
	\fancyhf[FR]{}
	}

\loadgeometry{cv}
\pagestyle{cv}

\setlength{\headheight}{30pt}
\setlength{\headwidth}{\textwidth}
%\usepackage{setspace}
%\setstretch{1.5}

\setlist{nosep}
\tabulinesep=4pt
\setmainfont{Roboto}

\title{CV}