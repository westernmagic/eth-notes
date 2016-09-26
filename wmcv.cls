\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wmcv}[2016/04/06]
\LoadClassWithOptions{wmnotes}

\geometry{
	a4paper           ,
	top        = 35mm ,
	left       = 15mm ,
	right      = 15mm ,
	bottom     = 15mm ,
	headheight = 10mm ,
	headsep    = 5mm  ,
	footskip   = 10mm
}
\savegeometry{cv}

\lohead*{}
\cohead*{}
\rohead*{\MyAuthor~-~\MyTitle}
\lofoot*{}
\cofoot*{\thepage}
\rofoot*{}

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
