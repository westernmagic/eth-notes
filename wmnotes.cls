\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wmnotes}[2016/04/06]

\ExecuteOptions{a4paper,12pt,onecolumn,oneside}
\LoadClassWithOptions{report}
\RequirePackage{wmnotes}

\OptionSwitch{titlepage}
\OptionSwitch{toc}
\OptionSwitch{index}
\OptionSwitch{todo}
\OptionSwitch{glossary}
\OptionSwitch{impressum}

\OptionSwitch{eth}
\OptionSwitch{uzh}

\OptionSwitch{cv}

\DeclareOption{nothing}{
	\ExecuteOptions{no-titlepage,no-toc,no-index,no-todo,no-glossary,no-eth,no-uzh,no-cv}
}

\makecommand{\ETHLogo}{\inlcudegraphics{ETHLogo}}

\DeclareOption{english}{
	\@ifpackageloaded{babel}{
		\selectlanguage{english}
	}{}
	\@ifpackageloaded{polyglossia}{
		\setdefaultlanguage[variant = british]{english}
		\setotherlanguage[variant = swiss , spelling = new , latesthyphen = true]{german}
		\setotherlanguage{german}
	}{}
	\setquotestyle{double}
	\makecommand{\UZHLogo}{\includegraphics{uzh_logo_e_pos}}
}

\DeclareOption{german}{
	\@ifpackageloaded{babel}{
		\selectlanguage{ngerman}
	}{}
	\@ifpackageloaded{polyglossia}{
		\setdefaultlanguage[variant = swiss , spelling = new , latesthyphen = true]{german}
		\setdefaultlanguage{german}
		\setotherlanguage[variant=british]{english}
	}{}
	\setquotestyle{double}
	\makecommand{\UZHLogo}{\includegraphics{uzh_logo_d_pos}}
}

\DeclareOption{ngerman}{\ExecuteOptions{german}}

\ExecuteOptions{titlepage,toc,index,glossary,todo,german}
\ProcessOptions\relax

\ifthenelse{\boolean{titlepage}}{
	\AtBeginDocument{
		\begin{titlepage}
			\begin{center}
				\null\vfil
				\ifthenelse{\expandafter\isempty\expandafter{\MyLecture}}{}{
					\Huge{\MyLecture} \\
				}
				\ifthenelse{\expandafter\isempty\expandafter{\MySubtitle}}{}{
					\normalsize{\MySubtitle} \\
				}
				\ifthenelse{\expandafter\isempty\expandafter{\MyProfessor}}{}{
					\Large{\MyProfessor} \\
				}
				\ifthenelse{\expandafter\isempty\expandafter{\MyProfessorEmail}}{}{
					\large{\href{mailto:\MyProfessorEmail}{\texttt{\MyProfessorEmail}}} \\
				}
				\large{\MySemester}
				\vskip 3em
				\ifthenelse{\expandafter\isempty\expandafter{\MyAuthor}}{}{
					\Large{\MyAuthor} \\
				}
				\ifthenelse{\expandafter\isempty\expandafter{\MyAuthorEmail}}{}{
					\large{\href{mailto:\MyAuthorEmail}{\texttt{\MyAuthorEmail}}} \\
				}
				\ifthenelse{\expandafter\isempty\expandafter{\MyEditor}}{}{
					\footnotesize{(\translate{Notekeeping})} \\
					\Large{\MyEditor} \\
					\ifthenelse{\expandafter\isempty\expandafter{\MyEditorEmail}}{}{
						\large{\href{mailto:\MyAuthorEmail}{\texttt{\MyEditorEmail}}} \\
					}
					\footnotesize{(\translate{Corrections} \& \translate{Completions})}
				}
				\vskip 1.5em
				\vfil\null
				\normalsize{\translate{Written in}} \\
				\normalsize{\CompilerLogo}
			\end{center}
		\end{titlepage}
		\clearpage
	}
}{}

\ifthenelse{\boolean{toc}}{
	\AtBeginDocument{
		\tableofcontents
		\clearpage
	}
}{}

\ifthenelse{\boolean{glossary}}{
	\makeglossaries
	\AtEndDocument{
		\clearpage
		\printglossaries
		\clearpage
	}
}{}

\ifthenelse{\boolean{index}}{
	\makeindex
	\AtEndDocument{
		\clearpage
		\printindex
		\clearpage
	}
}{}

\ifthenelse{\boolean{todo}}{
	\AtEndDocument{
		\clearpage
		\phantomsection
		\addcontentsline{toc}{chapter}{ToDo}
		\listoftodos
		\clearpage
	}
}{}

\ifthenelse{\boolean{impressum}}{
	\AtEndDocument{
		\clearpage
		\thispagestyle{empty}
		\begin{flushright}
			\translate{Compiled with} \CompilerLogo
		\end{flushright}
		\clearpage
	}
}{}

\savegeometry{wmnotes}
\fancypagestyle{wmnotes}{
	\setlength{\headheight}{53pt}
	\fancyhf{}
	\fancyhf[HL]{\leftmark\vspace{25pt}}
	\fancyhf[HR]{\rightmark}
	\fancyhf[FL]{\ifthenelse{\expandafter\isempty\expandafter{\MyAuthor}}{}{\MyAuthor\\}\translate{Status}: \today}
	\fancyhf[FC]{\thepage}
	\fancyhf[FR]{\ccbyncsaeu}
}

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

\geometry{
	a4paper         ,
	top       = 38mm ,
	left      = 20mm ,
	right     = 20mm ,
	bottom    = 24mm ,
	headsep   = 26mm ,
	footskip  = 15mm ,
	columnsep =  5mm ,
	marginpar = 15mm ,
	marginparsep = 2.5mm
}
\savegeometry{uzh}
%\loadgeometry{wmnotes}
\fancypagestyle{uzh}{
	\fancyhf{}
	\fancyhf[HL]{\ifthenelse{\expandafter\isempty\expandafter{\MyLecture}}{}{\MyLecture\\}\leftmark\\\rightmark}
	%\fancyhf[HR]{\UZHLogo}
	\fancyhf[FL]{\ifthenelse{\expandafter\isempty\expandafter{\MyAuthor}}{}{\MyAuthor\\}\translate{Status}: \today}
	\fancyhf[FC]{\thepage}
	%\fancyhf[FR]{\ccbyncsaeu}
}

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

\loadgeometry{wmnotes}
\pagestyle{wmnotes}

\ifthenelse{\boolean{eth}}{
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
}{
	\ifthenelse{\boolean{uzh}}{
		\loadgeometry{uzh}
		
		\ifthenelse{\boolean{xetex} \OR \boolean{luatex}}{
			\setmainfont{Palatino}
		}{}
		
		\pagestyle{uzh}
	}{
		\ifthenelse{\boolean{cv}}{
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
		}{
				%\loadgeometry{wmnotes}
				\pagestyle{wmnotes}
			}
	}
}

\abovedisplayshortskip=1ex
\belowdisplayshortskip=1ex
\abovedisplayskip=1ex
\belowdisplayskip=1ex
\setlength{\parindent}{0cm}
\setlength{\hangindent}{0cm}
\setlength{\mathindent}{0.5cm}
\frenchspacing
%\sloppy

% used to solve many problems with h- and vboxes, which are over- and underfull
\setlength\parskip{.5\baselineskip plus .4\baselineskip minus .4\baselineskip}

\newcommand{\authoremail}[1]{\makecommand{\MyAuthorEmail}{#1}}
\newcommand{\editoremail}[1]{\makecommand{\MyEditorEmail}{#1}}
\newcommand{\professoremail}[1]{\makecommand{\MyProfessorEmail}{#1}}
\newcommand{\editor}[1]{\makecommand{\MyEditor}{#1}}
\makecommand{\lecture}[1]{\makecommand{\MyLecture}{#1}}
\makecommand{\subtitle}[1]{\makecommand{\MySubtitle}{#1}}
\newcommand{\professor}[1]{\makecommand{\MyProfessor}{#1}}
\newcommand{\semester}[1]{\makecommand{\MySemester}{#1}}
\author{}
\authoremail{}
\editor{}
\editoremail{}
\lecture{}
\subtitle{}
\professor{}
\professoremail{}
\semester{}

\AtEndPreamble{
	\ifthenelse{\expandafter\isempty\expandafter{\MyAuthor}}{
		\ifthenelse{\expandafter\isempty\expandafter{\MyAuthorEmail}}{}{
			\hypersetup{pdfauthor = \MyAuthorEmail}
		}
	}{
		\ifthenelse{\expandafter\isempty\expandafter{\MyAuthorEmail}}{
			\hypersetup{pdfauthor = \MyAuthor}
		}{
			\hypersetup{pdfauthor = {\MyAuthor\ <\MyAuthorEmail>}}
		}
	}
	\ifthenelse{\expandafter\isempty\expandafter{\MyProfessor}}{
		\ifthenelse{\expandafter\isempty\expandafter{\MyProfessorEmail}}{}{
			\hypersetup{pdfproducer = \MyProfessorEmail}
		}
	}{
		\ifthenelse{\expandafter\isempty\expandafter{\MyProfessorEmail}}{
			\hypersetup{pdfproducer = \MyProfessor}
		}{
			\hypersetup{pdfproducer = {\MyProfessor\ <\MyProfessorEmail>}}
		}
	}
	\ifthenelse{\expandafter\isempty\expandafter{\MyLecture}}{}{
		\ifthenelse{\expandafter\isempty\expandafter{\MySubtitle}}{
			\hypersetup{pdftitle = \MyLecture}
		}{
			\hypersetup{pdftitle = {\MyLecture\ - \MySubtitle}}
		}
	}
}

\endinput