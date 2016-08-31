\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wmppt}[2011/10/07]

\ExecuteOptions{a4paper,12pt,onecolumn,oneside,utf8x,professionalfont,titleage,toc}
\PassOptionsToPackage{aux}{rerunfilecheck}
\PassOptionsToPackage{english,german}{translator}
\PassOptionsToPackage{fleqn,sumlimits,intlimits,namelimits}{amsmath}
\PassOptionsToPackage{usenames,dvipsnames}{xcolor}

\LoadClassWithOptions{beamer}
\RequirePackage{wmnotes}

\OptionSwitch{titlepage}
\OptionSwitch{toc}

\OptionSwitch{eth}
\OptionSwitch{uzh}

\makecommand{\ETHLogo}{\inlcudegraphics{ETHLogo}}

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

\ExecuteOptions{titlepage,toc,index,glossary,todo,german}
\ProcessOptions\relax

\ifthenelse{\boolean{titlepage}}{
	\AtBeginDocument{
        \begin{frame}
            \titlepage
        \end{frame}
	}
}{}

\ifthenelse{\boolean{toc}}{
	\AtBeginDocument{
        \begin{frame}
    		\tableofcontents
        \end{frame}
	}
}{}

\newboolean{pasttitletoc}
\setboolean{pasttitletoc}{false}

\ifthenelse{\boolean{titlepage} \OR \boolean{toc}}{
    \AtBeginDocument{
        \setboolean{pasttitletoc}{true}
    }
}{}

\ifthenelse{\boolean{eth}}{
	\ifthenelse{\boolean{xetex} \OR \boolean{luatex}}{
		\setmainfont{ETH Light}
        \setsansfont{ETH Light}
	}{
		\renewcommand{\familydefault}{let}
		\renewcommand{\sfdefault}{let}
		\DeclareFixedFont{\x}{T1}{let}{m}{n}{10}
		\DeclareFixedFont{\xb}{T1}{let}{b}{n}{10}
		\newfont{\xiiiv}{letr8t at 8.5pt}
		\newfont{\xiiivb}{letb8t at 8.5pt}
	}
}{
	\ifthenelse{\boolean{uzh}}{
		\ifthenelse{\boolean{xetex} \OR \boolean{luatex}}{
			\setmainfont{Palatino}
            \setseriffont{Palatino}
		}{
		
		}
	}{}
}

\usecolortheme{seagull}
\useinnertheme{default}
\useoutertheme[footline=authortitle,subsection=false]{miniframes}
\useoutertheme[subsection=false]{smoothbars}
\usefonttheme{professionalfonts}
\usefonttheme[onlymath]{serif}
\setmainfont{Helvetica}
\setsansfont{Helvetica}
\setcounter{tocdepth}{1}

\setbeamertemplate{title page}{
    \begin{center}
        \null\vfil
        \Huge{\inserttitle} \\
        \ifthenelse{\expandafter\isempty\expandafter{\insertsubtitle}}{}{
            \normalsize{\insertsubtitle} \\
        }
        \Large{\insertauthor} \\
        \ifthenelse{\expandafter\isempty\expandafter{\MyAuthorEmail}}{}{
            \large{\href{mailto:\MyAuthorEmail}{\texttt{\MyAuthorEmail}}} \\
        }
        \vskip 1.5em
        \vfil\null
        \normalsize{\translate{Written in}} \\
        \normalsize{\LaTeX} \\
        \normalsize{\translate{Compiled with}} \\
        \normalsize{\CompilerLogo}
    \end{center}
}

\setbeamertemplate{footline}{
    \begin{beamercolorbox}[colsep=1.5pt]{upper separation line foot}
    \end{beamercolorbox}
    \begin{beamercolorbox}[leftskip=.3cm,rightskip=.3cm plus1fil]{title in head/foot}
        \leavevmode
        \rlap{\usebeamerfont{title in head/foot}\insertshortsubtitle}
        \hspace*{\fill}
        \ifthenelse{\boolean{pasttitletoc}}{
            \thepage
            \hspace*{\fill}
        }{}
        \llap{\usebeamerfont{author in head/foot}\usebeamercolor[fg]{author in head/foot}\insertshortauthor} \par
        \leavevmode
        \rlap{\usebeamerfont{title in head/foot}\insertdate}
        \hspace*{\fill}
        \ifthenelse{\boolean{pasttitletoc}}{
            \insertdocumentendpage
            \hspace*{\fill}
        }{}
        \llap{\usebeamerfont{author in head/foot}\usebeamercolor[fg]{author in head/foot}\MyAuthorEmail}
    \end{beamercolorbox}
    \begin{beamercolorbox}[colsep=1.5pt]{lower separation line foot}
    \end{beamercolorbox}
    
}

\setbeamertemplate{section/subsection in toc}[sections numbered]
\setbeamertemplate{itemize items}[default]

\endinput