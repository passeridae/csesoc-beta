#
# Greetings, adventurer, and welcome to the shambling mess that is the
# CSESoc βeta Build System, carefully mutilated into this condition by
# - Jashank Jeremy <z5017851@cse.unsw.edu.au>

# <help>
# Welcome to the CSESoc βeta βuild System.
#
# Targets:
# - issues/overview		list all issues
# - issues/overview/forthcoming	list all forthcoming issues
# - issues/overview/published	list all published issues
# - issues/ISSUE/clean		publish issue ISSUE
# - issues/ISSUE/update		update issue ISSUE contents
# - issues/ISSUE/build		render issue ISSUE
# - issues/ISSUE/publish		publish issue ISSUE
#
# </help>

include config.mk

ifdef VERBOSE
    Q :=
    E =
else
    Q := @
    E = @echo $(1)
endif

S := $(CFG_SRC_DIR)

# $(1) is the name of the doc <section> in Makefile.in
# pick everything between tags | remove first line | remove last line
# | remove extra (?) line | strip leading `#` from lines
SHOW_DOCS = $(Q)awk '/<$(1)>/,/<\/$(1)>/' $(S)/Makefile | sed '1d' | sed '$$d' | sed 's/^\# \?//'
MAKEFILE_DOCS = help

.PHONY: ${MAKEFILE_DOCS}
${MAKEFILE_DOCS}:
	$(call SHOW_DOCS,$@)

###
### Typesetting
###

%.a.tex: %.markdown
	$(call E, βeta: generating $@)
	$(Q)pandoc --from markdown $< --to latex --output $@

%.pdf %.dvi: %.tex
	$(call E, βeta: building $@)
	$(Q)(cd $(dir $@) && \
		${LATEX} $(notdir $<) && \
		${LATEX} $(notdir $<) && \
		${LATEX} $(notdir $<))

%.ps: %.pdf
	${PDFTOPS} $< $@

FORMAT		?= pdf
# or 'dvi' or 'ps'

ENGINE		?= lua
# or 'xe' or 'pdf'

SHELLESCAPE	?= no
PDFTOPS_ENG     ?= poppler
# (or gs)

ifeq (${ENGINE},lua)
    ifeq (${FORMAT},dvi)
        LATEX	= lualatex --output-format=dvi
    else
        LATEX	= lualatex
    endif
else ifeq (${ENGINE},xe)
    ifeq (${FORMAT},dvi)
        LATEX	= xelatex -no-pdf
    else
        LATEX	= xelatex
    endif
else ifeq (${ENGINE},pdf)
    ifeq (${FORMAT},dvi)
        LATEX	= latex
    else
        LATEX	= pdflatex
    endif
else
    $(error unrecognised engine '${ENGINE}' (known engines are: 'lua' 'xe' 'pdf'))
endif

ifeq (${SHELLESCAPE},yes)
    LATEX	+= -shell-escape
endif


ifeq (${PDFTOPS_ENG},poppler)
    PDFTOPS	= pdftops
else ifeq (${PDFTOPS_ENG},gs)
    PDFTOPS	= pdf2ps
else
    $(error unrecognised PDF->PS engine: '${PDFTOPS_ENG}' (known PDF->PS engines are 'poppler' 'gs'))
endif


###
### Issues
###
ISSUES_FORTHCOMING	:= $(notdir $(wildcard issues/forthcoming/*))
ISSUES_PUBLISHED	:= $(notdir $(wildcard issues/published/*))
ISSUES			:= ${ISSUES_FORTHCOMING} ${ISSUES_PUBLISHED}

define beta_issue
.PHONY: issues/$(1)/clean issues/$(1)/build issues/$(1)/update
issues/$(1)/clean:
	$(call E, βeta: cleaning issue $(1))
	-$(Q)(cd issues/*/$(1) && rm -f $(1).aux $(1).log $(1).out $(1).toc)

issues/$(1)/update: $(patsubst %.markdown,%.a.tex,$(wildcard issues/*/$(1)/*.markdown))
	$(call E, βeta: updating issue $(1))
	$(Q)(cd $(wildcard issues/*/$(1)) && \
		echo $(patsubst %.markdown,%.a.tex,$(notdir $(wildcard issues/*/$(1)/*.markdown))) | \
		tr ' ' '\n' | \
		sed -e 's/^/\\input{/; s/$$$$/}/g' > contents.tex)

issues/$(1)/build: issues/$(1)/update
	$(call E, βeta: building issue $(1))
	$(Q)mkdir -p out
	$(Q)make $(wildcard issues/*/$(1))/$(1).$(FORMAT)
	$(Q)cp $(wildcard issues/*/$(1))/$(1).$(FORMAT) out/$(1).$(FORMAT)

issues/$(1)/publish: issues/forthcoming/$(1)
	$(call E, βeta: publishing issue $(1))
	$(Q)mv -v issues/forthcoming/$(1) issues/published/$(1)
endef

.PHONY: issues/overview/forthcoming issues/overview/published issues/overview
issues/overview/forthcoming: 
	$(Q)echo "βeta: Forthcoming issues:"
	$(foreach i,$(ISSUES_FORTHCOMING),$(Q)echo "   " $(i))

issues/overview/published: 
	$(Q)echo "βeta: Published issues:"
	$(foreach i,$(ISSUES_PUBLISHED),$(Q)echo "   " $(i))

issues/overview: issues/overview/forthcoming issues/overview/published

$(foreach issue,${ISSUES},$(eval $(call beta_issue,$(issue))))

