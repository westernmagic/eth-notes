ECHO := echo
TR := tr

lower = $(ECHO) "$(1)" | $(TR) '[:upper:]' '[:lower:]'
upper = $(ECHO) "$(1)" | $(TR) '[:lower:]' '[:upper:]'

targets := Anal1 Anal2 CAnal DM PhysMed tmp
suffixes := pdf dvi xdv ps

all = \
	$(foreach \
		target, \
		$(targets) $(addsuffix _bw,$(targets)), \
		$(addprefix $(target).,$(suffixes)) \
	)

.PHONY : all colour bw clean $(targets) $(all)

single = \
	$(foreach \
		target, \
		$(targets), \
		$(MAKE) -C `$(call lower,$(target))` $(target)$(1) ; \
	)

general = \
	$(foreach \
		target, \
		$(targets), \
		$(MAKE) -C `$(call lower,$(target))` $(1) ; \
	)

all :
	@ $(call general,all)

colour :
	@ $(call single,_colour)

bw :
	@ $(call single,_bw)

clean :
	@ $(call general,clean)

$(targets) :
	@ $(MAKE) -C `$(call lower,$@)` all

$(addsuffix _clean,$(targets)) :
	@ $(MAKE) -C `$(call lower,$(subst _clean,,$@))` clean

$(all) :
	@ $(MAKE) -C `$(call lower,$(subst _bw,,$(notdir $(basename $@))))` $@
