RM := rm -rf
LN := ln -s
CP := cp -f
SED := sed
CAT := cat
LS := ls
FIND := find
GREP := grep

export TEXINPUTS := ../common:$(TEXINPUTS)
export XINDY_SEARCHPATH := ../common:$(XINDY_SEARCHPATH)
LATEXFLAGS := -file-line-error -interaction=nonstopmode -shell-escape -synctex=1
XELATEX := xelatex
PDFLATEX := pdflatex
LATEX := latex
PDF := $(if $(shell if command -v $(XELATEX) &> /dev/null ; then echo "XeLaTeX"; fi),$(XELATEX),$(PDFLATEX)) $(LATEXFLAGS)
DVI := $(LATEX) -output-format=dvi $(LATEXFLAGS)
XDV := $(XELATEX) -no-pdf $(LATEXFLAGS)
DVIPS := dvips
INDEXFLAGS = -M indexstyle.xdy -t
INDEX := xindy
BIBTEX := bibtex
KPSEWHICH := kpsewhich -all 

PIPEALL := 2>&1 |
LOGFILTER := $(GREP) -E "^\./"

#CMDIR := /usr/local/texlive/texmf-local/circuit_macros/
#CM := m4 $(CMDIR)pgf.m4 $(CMDIR)libcct.m4 $(CMDIR)liblog.m4 $(CMDIR)libgen.m4
#DPIC := dpic -g

NULL := /dev/null

VPATH =  ../common

get-deps-tex = \
	$(shell \
		$(CAT) $(1) | \
		$(SED) -n -e 's/\[.*\]//g' -e 's/^[^%]*\\include{.*}/&/p' | \
		$(SED) -e 's/.*\\include{//g' -e 's/}.*/\.tex/g' \
	)

get-deps-pdf = \
	$(shell \
		$(CAT) $(1) | \
		$(SED) -n -e 's/\[.*\]//g' -e 's/^[^%]*\\includepdf{.*}/&/p' | \
		$(SED) -e 's/.*\\includepdf{//g' -e 's/}.*/\.pdf/g' \
	)

get-deps-pic = \
	$(foreach \
		file, \
		$(shell \
			$(CAT) $(1) | \
			$(SED) -n -e 's/\[.*\]//g' -e 's/^[^%]*\\includegraphics{.*}/&/p' | \
			$(SED) -e 's/.*\\includegraphics{//g' -e 's/}.*/\.\*/g' \
		), \
		$(shell $(LS) $(file)) \
	)

get-deps-sty = \
	$(foreach \
		package, \
		$(1), \
		$(call get-deps-sty, \
			$(shell \
				$(CAT) $(package) | \
				$(SED) -n -e 's/\[.*\]//g' -e 's/^[^%]*\\usepackage{.*}/&/p' -e 's/^[^%]*\\RequirePackage{.*}/&/p' | \
				$(SED) -e 's/.*\\usepackage{//g' -e 's/.*\\RequirePackage{//g' -e 's/}.*/\.sty/g' \
			) \
		) \
	)

get-deps = \
	$(1) \
	$(call get-deps-tex,$(1)) \
	$(foreach file,$(1) $(call get-deps-tex,$(1)),$(call get-deps-pdf,$(file))) \
	$(foreach file,$(1) $(call get-deps-tex,$(1)),$(call get-deps-pic,$(file)))

rerun = \
	$(1) $(2) <<< s &> $(NULL) ; \
	while ! ( \
		( $(LS) | $(GREP) $(2).log  &> $(NULL) ) && \
		( ! $(GREP) -E "(Rerun to get (cross-references|the bars) right)" $(2).log &> $(NULL) ) \
	) ; do \
		$(1) $(2) <<< s &> $(NULL) \
	; done


suff = $(addprefix $(1),.pdf .dvi .xdv .ps)
all = $(call suff,$(1)) $(call suff,$(1)_bw)

$(foreach \
	main, \
	$(foreach \
		candidate, \
		$(shell $(FIND) . -type f -name '*.tex' ), \
		$(shell $(GREP) -E -l '^[^%]*\\begin\{document\}' $(candidate) ) \
	), \
	$(eval $(call all,$(basename $(main))) : $(call get-deps,$(main)) ) \
)

.PHONY: cleanhelp

cleanhelp :
	$(info Cleaning auxillary files...)
	@ $(RM) *_bw.tex *.aux *.bbl *.blg *.fls *.idx *.ilg *.ind *.log *.mp *.out *.tdo *.thm *.tmp *.toc *.tui *.tuo *\(busy\)

%_clean :
	$(info Cleaning outputs...)
	@ $(RM) $*_bw.pdf $*.pdf *.ps *.dvi *.synctex.gz *.xdv

%_colour : $(call suff,%) ;
%_bw : $(call suff,%_bw) ;
%_all : %_colour %_bw ;


%_bw.tex : %.tex
	$(SED) -e '/\\usepackage.*{wmnotes}/ i\
	\\PassOptionsToPackage{bw}{wmnotes}' $*.tex > $*_bw.tex

%_bw.pdf : %_bw.tex
	$(info Making $*_bw.pdf...)
	@- $(call rerun,$(PDF),$*_bw)
	@- $(BIBTEX) $*_bw &> $(NULL)
	@- $(INDEX) $(INDEXFLAGS) $*_bw.ilg $*_bw.idx &> $(NULL)
	@- $(call rerun,$(PDF),$*_bw)
	@- $(LOGFILTER) $*_bw.log

%.pdf :
	$(info Making $*.pdf...)
	@- $(call rerun,$(PDF),$*)
	@- $(BIBTEX) $* &> $(NULL)
	@- $(INDEX) $(INDEXFLAGS) $*.ilg $*.idx &> $(NULL)
	@- $(call rerun,$(PDF),$*)
	@- $(LOGFILTER) $*.log

%_bw.dvi : %_bw.tex
	$(info Making $*_bw.dvi...)
	@- $(call rerun,$(DVI),$*_bw)
	@- $(BIBTEX) $*_bw &> $(NULL)
	@- $(INDEX) $(INDEXFLAGS) $*_bw.ilg $*_bw.idx &> $(NULL)
	@- $(call rerun,$(DVI),$*_bw)
	@- $(LOGFILTER) $*_bw.log

%.dvi :
	$(info Making $*.dvi...)
	@- $(call rerun,$(DVI),$*)
	@- $(BIBTEX) $* &> $(NULL)
	@- $(INDEX) $(INDEXFLAGS) $*.ilg $*.idx &> $(NULL)
	@- $(call rerun,$(DVI),$*)
	@- $(LOGFILTER) $*.log

%_bw.xdv : %_bw.tex
	$(info Making $*_bw.xdv...)
	@- $(call rerun,$(XDV),$*_bw)
	@- $(BIBTEX) $*_bw &> $(NULL)
	@- $(INDEX) $(INDEXFLAGS) $*_bw.ilg $*_bw.idx &> $(NULL)
	@- $(call rerun,$(XDV),$*_bw)
	@- $(LOGFILTER) $*_bw.log

%.xdv :
	$(info Making $*.xdv...)
	@- $(call rerun,$(XDV),$*)
	@- $(BIBTEX) $* &> $(NULL)
	@- $(INDEX) $(INDEXFLAGS) $*.ilg $*.idx &> $(NULL)
	@- $(call rerun,$(XDV),$*)
	@- $(LOGFILTER) $*.log

%.ps: %.dvi
	$(info Making $*.ps...)
	@- $(DVIPS) $* &> $(NULL)

#%.tex:
#	@echo "Making $*.tex ..."
#	$(CM) $*.m4 | $(DPIC) >> $*.tex
