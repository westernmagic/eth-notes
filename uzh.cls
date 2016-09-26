\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uzh}[2016/04/06]
\LoadClassWithOptions{wmnotes}

\geometry{
	a4paper              ,
	top          = 38mm  ,
	left         = 20mm  ,
	right        = 20mm  ,
	bottom       = 24mm  ,
	headsep      = 26mm  ,
	footskip     = 15mm  ,
	columnsep    =  5mm  ,
	marginpar    = 15mm  ,
	marginparsep = 2.5mm
}
\savegeometry{uzh}

\lohead*{\ifthenelse{\expandafter\isempty\expandafter{\MyLecture}}{}{\MyLecture\\}\leftmark\\\rightmark}
\cohead*{}
\rohead*{}
\lofoot*{\ifthenelse{\expandafter\isempty\expandafter{\MyAuthor}}{}{\MyAuthor\\}\translate{Status}: \today}
\cofoot*{\thepage}
\rofoot*{}

\loadgeometry{uzh}

\ifthenelse{\boolean{xetex} \OR \boolean{luatex}}{
	\setmainfont{Palatino}
}{}

\pagestyle{uzh}
