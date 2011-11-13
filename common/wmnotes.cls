\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wmnotes}[2011/10/07]

\ExecuteOptions{a4paper,12pt,onecolumn,oneside}
\LoadClassWithOptions{report}
\RequirePackage{wmnotes}

\OptionSwitch{titlepage}
\OptionSwitch{toc}
\OptionSwitch{index}
\OptionSwitch{todo}

\OptionSwitch{eth}
\OptionSwitch{uzh}

\DeclareOption{english}{
	\@ifpackageloaded{babel}{
		\selectlanguage{english}
	}{}
	\@ifpackageloaded{polyglossia}{
		\setdefaultlanguage[variant=british]{english}
		\setotherlanguage[spelling = new , latesthyphen = true , babelshorthands = false]{german}
	}{}
}

\DeclareOption{german}{
	\@ifpackageloaded{babel}{
		\selectlanguage{ngerman}
	}{}
	\@ifpackageloaded{polyglossia}{
		\setdefaultlanguage[spelling = new , latesthyphen = true]{german}
		\setotherlanguage[variant=british]{english}
	}{}
}

\DeclareOption{ngerman}{\ExecuteOptions{german}}

\ExecuteOptions{titlepage,toc,index,todo,german}
\ProcessOptions\relax

\ifthenelse{\boolean{titlepage}}{
	\AtBeginDocument{
		\begin{titlepage}
			\begin{center}
				\null\vfil
				\Huge{\MyLecture} \\
				\ifthenelse{\expandafter\isempty\expandafter{\MySubtitle}}{}{
					\normalsize{\MySubtitle} \\
				}
				\Large{\MyProfessor} \\
				\large{\MySemester}
				\vskip 3em
				\Large{\MyAuthor} \\
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
				\normalsize{\XeLaTeX}
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
		\phantomsection
		\addcontentsline{toc}{chapter}{ToDo}
		\listoftodos
	}
}{}

\abovedisplayshortskip=1ex
\belowdisplayshortskip=1ex
\abovedisplayskip=1ex
\belowdisplayskip=1ex
\setlength{\parindent}{0cm}
\setlength{\hangindent}{0cm}
\setlength{\mathindent}{0.5cm}
\frenchspacing
\sloppy

\fancypagestyle{plain}{
	\setlength{\headheight}{46pt}
	\fancyhf{}
	\fancyhf[HL]{\leftmark\vspace{25pt}}
	\fancyhf[HC]{}
	\fancyhf[HR]{\rightmark}
	\fancyhf[FL]{\MyAuthor\\\translate{Status}: \today}
	\fancyhf[FC]{\thepage}
	\fancyhf[FR]{\ccbyncsaeu}
}
\pagestyle{plain}

\endinput