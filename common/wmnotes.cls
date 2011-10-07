\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wmnotes}[2011/10/07]

\ExecuteOptions{a4paper,12pt,onecolumn,oneside}
\LoadClassWithOptions{report}
\RequirePackage{wmnotes}

\OptionSwitch{titlepage}
\OptionSwitch{toc}
\OptionSwitch{index}
\OptionSwitch{todo}

\DeclareOption{eth}{}
\DeclareOption{uzh}{}

\ExecuteOptions{titlepage,toc,index,todo}
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
					\footnotesize{(Mitschrift)} \\
					\Large{\MyEditor} \\
					\ifthenelse{\expandafter\isempty\expandafter{\MyEditorEmail}}{}{
						\large{\href{mailto:\MyAuthorEmail}{\texttt{\MyEditorEmail}}} \\
					}
					\footnotesize{(Korrektur \& Ergänzung)}
				}
				\vskip 1.5em
				\vfil\null
				\normalsize{Geschrieben in} \\
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
	\AtEndDocument{
		\clearpage
		\phantomsection
		\addcontentsline{toc}{chapter}{Index}
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
	\fancyhf[FL]{\MyAuthor\\Stand: \today}
	\fancyhf[FC]{\thepage}
	\fancyhf[FR]{\ccbyncsaeu}
}
\pagestyle{plain}

\endinput