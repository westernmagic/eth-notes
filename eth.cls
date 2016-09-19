\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eth}[2016/04/06]

\geometry{
	a4paper              ,
	textwidth  =  16.6cm ,
	textheight =  23.5cm ,
	voffset    = -0.49cm ,
	top        =     0cm ,
	headheight =     0cm ,
	headsep    =  1.45cm ,
	inner      =    -3mm ,
	outer      =    -3mm ,
	hoffset    =     0cm ,
	footskip   =    15mm 
}
\savegeometry{eth}
%\loadgeometry{wmnotes}
\fancypagestyle{eth}{
	\fancyhf{}
	%\fancyhf[HL]{\ETHLogo}
	\fancyhf[FL]{\translate{Page} \thepage / \pageref{LastPage}}
}

\loadgeometry{eth}
	
\ifthenelse{\boolean{xetex} \OR \boolean{luatex}}{
	\setmainfont{ETH Light}
}{
	\renewcommand{\familydefault}{let}
	\renewcommand{\sfdefault}{let}
	\DeclareFixedFont{\x}{T1}{let}{m}{n}{10}
	\DeclareFixedFont{\xb}{T1}{let}{b}{n}{10}
	\newfont{\xiiiv}{letr8t at 8.5pt}
	\newfont{\xiiivb}{letb8t at 8.5pt}
}

\pagestyle{eth}