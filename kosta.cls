\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{kosta}[2016/09/08]

\ExecuteOptions{a4paper,12pt,onecolumn,oneside}
\LoadClassWithOptions{scrartcl}
\RequirePackage{wmnotes}
\RequirePackage{scrlayer-scrpage}
\RequirePackage{zref-titleref}

\OptionSwitch{toc}
\OptionSwitch{todo}
\OptionSwitch{impressum}
\OptionSwitch{decisions}

\AtBeginDocument{
	\phantomsection
	\label{begin}
}

\DeclareOption{minutes}{
	\ExecuteOptions{toc,no-todo,no-impressum,decisions}

	\makeindex
	\newlistof{beschluss}{beschl}{Beschlussübersicht}
	\DeclareDocumentCommand\printbeschluesse{}{
		\clearpage
		\phantomsection
		\addsectiontocentry{}{Beschlussübersicht}
		\listofbeschluss
	}

	\addto\captionsngerman{
		\renewcommand{\contentsname}{Traktandenliste}
	}
}

\DeclareOption{nothing}{
	\ExecuteOptions{no-toc,no-todo,no-impressum,no-decisions}
}

\makecommand{\VSUZHLogo}[1][]{\includegraphics[#1]{Logo_VSUZH_positiv}}
\makecommand{\ETHLogo}{\includegraphics{ETHLogo}}
\makecommand{\KostaLogo}[1][]{\includegraphics[#1]{kosta}}

\definecolor{KostaDarkBlue}{HTML}{2394d8}
\definecolor{KostaLightBlue}{HTML}{abd9e5}

\setabbreviationstyle[acronym]{short-sc-nolong}
\glssetcategoryattribute{acronym}{headuc}{true}
\newacronym{eth}{ETH}{Eidgenössiche Technische Hochschule}
\newacronym{ethz}{ETHZ}{\glstext{eth} Zürich}
\newacronym{vseth}{VSETH}{Verband der Studierenden an der \glstext{ethz}}
\newacronym{uzh}{UZH}{Universität Zürich}
\newacronym{vsuzh}{VSUZH}{Verband der Studierenden der \glsfirst{uzh}}
\newacronym{kosta}{Kosta}{Stiftung KOSTA}
\newacronym{sola}{SOLA}{SOLA Stafette}
\newacronym{asvz}{ASVZ}{Akademischer Sportverband Zürich}


\DeclareOption{english}{
	\@ifpackageloaded{babel}{
		\selectlanguage{english}
	}{}
	\@ifpackageloaded{polyglossia}{
		\setdefaultlanguage[variant=british]{english}
		\setotherlanguage[spelling = new , latesthyphen = true , babelshorthands = false]{german}
	}{}
	\setquotestyle{double}
	\makecommand{\UZHLogo}{\includegraphics{uzh_logo_e_pos}}
}

\DeclareOption{german}{
	\@ifpackageloaded{babel}{
		\selectlanguage{ngerman}
	}{}
	\@ifpackageloaded{polyglossia}{
		\setdefaultlanguage[spelling = new , latesthyphen = true]{german}
		\setotherlanguage[variant=british]{english}
	}{}
	\setquotestyle{double}
	\makecommand{\UZHLogo}{\includegraphics{uzh_logo_d_pos}}
}

\DeclareOption{ngerman}{\ExecuteOptions{german}}

\ExecuteOptions{german}
\ProcessOptions\relax

\setlength\headheight{35pt}

\newlength{\logoheight}
\newlength{\wm@temp}
\setlength{\logoheight}{\baselinestretch\baselineskip}
\AtBeginDocument{
	\settoheight{\wm@temp}{\@title}
	\addtolength{\logoheight}{\wm@temp}
	\settoheight{\wm@temp}{\@date, \MyPlace}
	\addtolength{\logoheight}{\wm@temp}
}

\ifthenelse{\boolean{toc}}{
	\AtBeginDocument{
		\tableofcontents
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

\ifthenelse{\boolean{xetex} \OR \boolean{luatex}}{
	\setmainfont{SwissBT}[
		Extension          = .otf,
		UprightFont        = *LigCon,
		ItalicFont         = *LigConIta,
		BoldFont           = *BlaCon,
		BoldItalicFont     = *BlaConIta,
		UprightFeatures    = {SmallCapsFont = *RomCon},
		ItalicFeatures     = {SmallCapsFont = *ItaCon},
		BoldFeatures       = {SmallCapsFont = *BlaCon},
		BoldItalicFeatures = {SmallCapsFont = *BlaConIta},
		SmallCapsFeatures  = {Scale         = 0.75}
	]
}{}

\KOMAoptions{
	parskip   = full,
	footnotes = multiple
}

\setkomafont{disposition}{\normalfont\bfseries}
\setkomafont{descriptionlabel}{\normalfont\bfseries}

\includepdfset{pages=-}


\lohead*{\@title\\\@date\ifthenelse{\equal{\MyPlace}{}}{}{, \MyPlace}}
\rohead*{\KostaLogo[keepaspectratio, height=\logoheight]}
\cofoot*{\thepage}
\setkomafont{pageheadfoot}{\normalcolor}

\pagestyle{scrheadings}

\DeclareDocumentCommand\person{m m o}{%
	#1 #2\IfNoValueF{#3}{ (#3)}\index{#2!#1}%
}

\DeclareDocumentCommand\beschluss{s m}{%
	\textul{Beschluss: #2}\IfBooleanF{#1}{\phantomsection\addcontentsline{beschl}{subsection}{#2}}%
}

%TODO: ponder and implement
\DeclareDocumentCommand\pendenz{m m o}{%
	\textbf{#1}%
	\marginpar{\Square #2 \IfBooleanT{Deadline: #3}}%
}

%%TODO
\DeclareDocumentCommand\traktandum{s t+ t- m o}{%
	\IfBooleanTF{#1}{%
		\section*{\IfBooleanTF{#3}{\trakt-{#4}}{\trakt{#4}}\IfNoValueF{#5}{ (#5)}}%
	}{%
		\IfBooleanTF{#2}{%
			\subsection*{\IfBooleanTF{#3}{\trakt-{#4}}{\trakt{#4}}\IfNoValueF{#5}{ (#5)}}%
			\addcontentsline{toc}{subsection}{\IfBooleanTF{#3}{\trakt*-{#4}}{\trakt*{#4}}}%
		}{
			\section[#4]{#4\IfNoValueF{#5}{ (#5)}}%
			\zref@label{trakt:\arabic{section}}%
			\label{trakt:\arabic{section}}%
		}%
	}%
}

\DeclareDocumentCommand\subtraktandum{s m o}{%
	\IfBooleanTF{#1}{%
		\subsection*{\trakt{#2}\IfNoValueF{#3}{ (#3)}}%
	}{%
		\subsection[#2]{#2\IfNoValueF{#3}{ (#3)}}%
		\zref@label{trakt:\arabic{section}.\arabic{subsection}}%
		\label{trakt:\arabic{section}.\arabic{subsection}}%
	}%
}

\DeclareDocumentCommand\subsubtraktandum{s m o}{%
	\IfBooleanTF{#1}{%
		\subsubsection*{\trakt{#2}\IfNoValueF{#3}{ (#3)}}%
	}{%
		\subsubsection[#2]{#2\IfNoValueF{#3}{ (#3)}}%
		\zref@label{trakt:\arabic{section}.\arabic{subsection}.\arabic{subsubsection}}%
		\label{trakt:\arabic{section}.\arabic{subsection}.\arabic{subsubsection}}%
	}%
}

\DeclareDocumentCommand\trakt{s t- m}{%
	\IfBooleanTF{#1}{%
		\IfBooleanF{#2}{#3 }\ztitleref{trakt:#3}%
	}{%
		\hyperref[trakt:#3]{\IfBooleanF{#2}{\ref*{trakt:#3} }\ztitleref{trakt:#3}}%
	}%
	\unskip%
}

\DeclareDocumentCommand\add{o +m}{%
	\textbf{#2}%
}

\DeclareDocumentCommand\delete{o +m}{%
	\IfNoValueTF{#1}{%
		\textst{#2}%
	}{%
		\textsf[#1]{#2}%
	}%
}

\newcommand{\place}[1]{\makecommand{\MyPlace}{#1}}
\place{}
%TODO
\SetEnumitemKey{killskip}{topsep=0pt,before*=\vspace{\dimexpr -\baselinestretch\baselineskip-\parskip-1.5pt\relax}}

\setlist{noitemsep,topsep=0pt}

\newlist{personen}{itemize*}{1}
\setlist[personen]{itemjoin={, {}}, label={}, afterlabel={}}
\newlist{personen*}{itemize*}{1}
\setlist[personen*]{itemjoin={, {}}, itemjoin*={{} und {}}, label={}, afterlabel={}}

\let\olditem\item
\DeclareDocumentCommand\itemtitle{o}{
	\IfNoValueTF{#1}{
		\olditem
	}{
		{\bfseries
			\olditem #1 \par\nobreak
		}
	}
}

\newlist{articles}{enumerate}{1}
\setlist[articles]{label={\protect\label{§\arabic*}§ \arabic*.}, ref={§ \arabic*}, resume, before* = {\let\item\itemtitle}}
\newlist{paragraphs}{enumerate}{1}
\setlist[paragraphs]{label={\protect\label{§\arabic{articlesi}.\arabic*}\textsuperscript{\arabic*}}, ref={Abs. \arabic*}, before* = {\let\item\itemtitle}}
\newlist{letters}{enumerate}{1}
\setlist[letters]{label={\protect\label{§\arabic{articlesi}.\arabic{paragraphsi}.\alph*}\alph*.}, ref={lit. \alph*.}, before* = {\let\item\itemtitle}}

\setdeletedmarkup{\delete{#1}}
\setauthormarkuptext{name}
\setauthormarkup{\footnote{#1}}

\externaldocument[St]{Stiftungsurkunde}
\externaldocument[VR]{Verwaltungsreglement}


% #1 : skip first ref
% #2 : skip second ref
% #3 : Reglement-Kürzel
% #4 : Text
% #5 : §
% #6 : Abs. ggf. lit.
% #7 : lit.
\DeclareDocumentCommand\artref{t- t- o o m o o}{%
	\hyperref[\IfNoValueF{#3}{#3}§#5\IfNoValueF{#6}{.#6\IfNoValueF{#7}{.#7}}]{%
		\IfNoValueTF{#4}{%
			\IfBooleanF{#1}{\ref*{\IfNoValueF{#3}{#3}§#5}}\IfBooleanF{#2}{%
					\IfNoValueF{#6}{\IfBooleanF{#1}{ }\ref*{\IfNoValueF{#3}{#3}§#5.#6}}%
				}\IfNoValueF{#7}{ \ref*{\IfNoValueF{#3}{#3}§#5.#6.#7}}%
		}{#4}%
	}%
}

\noindexprenote

\endinput
