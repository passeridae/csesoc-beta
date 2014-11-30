#
# Greetings, adventurer, and welcome to the shambling mess that is the
# CSESoc βeta Build System, carefully mutilated into this condition by
# - Jashank Jeremy <z5017851@cse.unsw.edu.au>

# <help>
# Welcome to the CSESoc βeta βuild System.
#
# Targets:
# - issues/overview		list all issues
# - issues/ISSUE/clean		publish issue ISSUE
# - issues/ISSUE/update		update issue ISSUE contents
# - issues/ISSUE/build		render issue ISSUE
# - issues/forthcoming		list all forthcoming issues
# - issues/published		list all published issues
# - issues/ISSUE/publish		publish issue ISSUE
#
# </help>

include config.mk

ifdef VERBOSE
    Q :=
else
    Q := @
endif

E = @echo βeta[$(MAKELEVEL)]: $(1)

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
	$(call E, converting $(notdir $<))
	$(Q)pandoc --from markdown $< --to latex --output $@

%.pdf %.dvi: %.tex
	$(call E, building $@)
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
ISSUE_STATES		= forthcoming published
ISSUE_TARGETS		= clean update build
ISSUES_FORTHCOMING	:= $(notdir $(wildcard issues/forthcoming/*))
ISSUES_PUBLISHED	:= $(notdir $(wildcard issues/published/*))
ISSUES			:= ${ISSUES_FORTHCOMING} ${ISSUES_PUBLISHED}


.PHONY: issues/forthcoming issues/published issues/overview
issues/forthcoming: 
	$(Q)echo "βeta: Forthcoming issues:"
	$(foreach i,$(ISSUES_FORTHCOMING),$(Q)echo "   " $(i))

issues/published: 
	$(Q)echo "βeta: Published issues:"
	$(foreach i,$(ISSUES_PUBLISHED),$(Q)echo "   " $(i))

issues/overview: issues/forthcoming issues/published

define issue_stub
issues/$(1)/$(2)::
	@true
endef

define issue_join
issues/$(1)/$(2):: $(3)
endef

define beta_issue
.PHONY: issues/$(1)/clean issues/$(1)/build issues/$(1)/update
issues/$(1)/clean:
	-$(Q)(cd issues/*/$(1) && rm -f $(1).aux $(1).log $(1).out $(1).toc)

issues/$(1)/update: $(patsubst %.markdown,%.a.tex,$(wildcard issues/*/$(1)/*.markdown))
	$(call E, βeta: updating issue $(1))
	$(call E, cleaning issue $(1))
	$(call E, updating issue $(1))
	$(Q)(cd $(wildcard issues/*/$(1)) && \
		echo $(patsubst %.markdown,%.a.tex,$(notdir $(wildcard issues/*/$(1)/*.markdown))) | \
		tr ' ' '\n' | \
		sed -e 's/^/\\input{/; s/$$$$/}/g' > contents.tex)

$(wildcard issues/*/$(1))/$(1).$(FORMAT):: $(wildcard issues/*/$(1))/contents.tex
$(wildcard issues/*/$(1))/$(1).$(FORMAT):: $(patsubst %.markdown,%.a.tex,$(sort $(wildcard issues/*/$(1)/*.markdown)))

issues/$(1)/build: issues/$(1)/update
	$(call E, building issue $(1))
	$(Q)mkdir -p out
	$(Q)make $(wildcard issues/*/$(1))/$(1).$(FORMAT)
	$(Q)cp $(wildcard issues/*/$(1))/$(1).$(FORMAT) out/$(1).$(FORMAT)

issues/$(1)/publish: issues/forthcoming/$(1)
	$(call E, publishing issue $(1))
	$(Q)mv -v issues/forthcoming/$(1) issues/published/$(1)
endef


$(foreach t,${ISSUE_TARGETS}, \
  $(eval $(call issue_join,$(notdir $(patsubst %/,%,$(dir $(wildcard issues/*/$(1))))),$(t),issues/$(1)/$(t))))
endef

$(foreach s,$(ISSUE_STATES), \
  $(eval $(foreach t,$(ISSUE_TARGETS), \
    $(eval $(call issue_stub,$(s),$(t))))))

$(foreach issue,${ISSUES},$(eval $(call beta_issue,$(issue))))

