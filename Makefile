#
# Greetings, adventurer, and welcome to the shambling mess that is the
# CSESoc βeta Build System, carefully mutilated into this condition by
# - Jashank Jeremy <z5017851@cse.unsw.edu.au>

# <help>
# Welcome to the CSESoc βeta βuild System.
#
# Targets:
# - issues/overview		list all issues
# - issues/forthcoming		list all forthcoming issues
# - issues/published		list all published issues
# - issues/ISSUE			generate a summary of ISSUE
# - issues/ISSUE/clean		clean up issue ISSUE (or 'forthcoming' or 'published')
# - issues/ISSUE/update		update issue ISSUE (or 'forthcoming' or 'published') contents
# - issues/ISSUE/build		render issue ISSUE (or 'forthcoming' or 'published')
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
Ee = @echo "   " $(1)

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

%.html: %.markdown
	$(call E, converting $(notdir $<) to HTML)
	$(Q)pandoc --from markdown $< --to html5 -S -s --output $@

%.a.tex: %.markdown
	$(call E, converting $(notdir $<) to TeX)
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

SHELLESCAPE	?= yes
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
	$(Q)echo "βeta: Forthcoming issues:" $(ISSUES_FORTHCOMING)

issues/published: 
	$(Q)echo "βeta: Published issues:" $(ISSUES_PUBLISHED)

issues/overview: issues/forthcoming issues/published

define issue_stub
issues/$(1)/$(2)::
	@true
endef

define issue_join
issues/$(1)/$(2):: $(3)
endef

define format_minify_cmd
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$(basename $(1)).min$(suffix $(1)) $(1)
endef

define format_greyify_cmd
	pdftops $(1) $(basename $(1)).ps && \
	gs -dNOPAUSE -dQUIET -dBATCH -sDEVICE=ps2write \
		-sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray \
		-dCompatibilityLevel=1.4 -sOutputFile=$(basename $(1)).grey.ps \
		$(basename $(1)).ps
endef

define beta_issue
.PHONY: issues/$(1) issues/$(1)/clean issues/$(1)/build issues/$(1)/update

issues/$(1):
	$(Q)(cd $(wildcard issues/*/$(1)) && \
		echo -n Issue $(1) ''; grep '^\\date' $(1).tex | sed -Ee 's/.*\{(.*)\}/(\1)/';\
		for f in $(notdir $(sort $(wildcard issues/*/$(1)/*.markdown))); do \
			echo -n $$$${f%.markdown}: '' ; \
			echo `grep "^title: " $$$${f} | cut -d' ' -f2-`; \
		done)

issues/$(1)/clean:
	$(call E, cleaning issue $(1))
	-$(Q)(cd issues/*/$(1) && \
		rm -f $(1).{aux,log,out,toc} \
			$(patsubst %.markdown,%.a.tex,$(sort $(notdir $(wildcard issues/*/$(1)/*.markdown)))))

issues/$(1)/tidy:
	$(call E, tidying issue $(1))
	-$(Q)(cd issues/*/$(1) && \
		rm -f $(1).{pdf,ps,dvi})

issues/$(1)/update: $(patsubst %.markdown,%.a.tex,$(sort $(wildcard issues/*/$(1)/*.markdown)))
	$(call E, updating issue $(1))
	$(Q)(cd $(wildcard issues/*/$(1)) && \
		echo -n $(patsubst %.markdown,%.a.tex,$(sort $(notdir $(wildcard issues/*/$(1)/*.markdown)))) | \
		tr ' ' '\n' | \
		sed -e 's/^/\\input{/; s/$$$$/}/g' > contents.tex)

$(wildcard issues/*/$(1))/$(1).$(FORMAT):: $(wildcard issues/*/$(1))/contents.tex
$(wildcard issues/*/$(1))/$(1).$(FORMAT):: $(patsubst %.markdown,%.a.tex,$(sort $(wildcard issues/*/$(1)/*.markdown)))

issues/$(1)/build: issues/$(1)/update
	$(call E, building issue $(1))
	$(Q)mkdir -p out
	$(Q)make $(wildcard issues/*/$(1))/$(1).$(FORMAT)
	$(Q)cp $(wildcard issues/*/$(1))/$(1).$(FORMAT) out/$(1).$(FORMAT)
	$(call E, generating minified issue $(1))
	$(Q)$(call format_minify_cmd,out/$(1).$(FORMAT))
	$(call E, generating print-ready greyified issue $(1))
	$(Q)$(call format_greyify_cmd,out/$(1).$(FORMAT))

issues/$(1)/publish: issues/forthcoming/$(1)
	$(call E, publishing issue $(1))
	$(Q)mv -v issues/forthcoming/$(1) issues/published/$(1)

$(foreach t,${ISSUE_TARGETS}, \
  $(eval $(call issue_join,$(notdir $(patsubst %/,%,$(dir $(wildcard issues/*/$(1))))),$(t),issues/$(1)/$(t))))
endef

$(foreach s,$(ISSUE_STATES), \
  $(eval $(foreach t,$(ISSUE_TARGETS), \
    $(eval $(call issue_stub,$(s),$(t))))))

$(foreach issue,${ISSUES},$(eval $(call beta_issue,$(issue))))

