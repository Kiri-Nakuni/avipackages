# make test       the TeX tests (needs the dviavi repository: next to this
#                 one, or DVIAVI_DIR=...)
# make install    tex/* into TEXMFLOCAL/tex/latex/avipackages (as links to
#                 this repository) and mktexlsr; needs root:
#                   sudo env "PATH=$PATH" make install
DVIAVI_DIR ?= ../dviavi
TEXMFLOCAL ?= $(shell kpsewhich -var-value TEXMFLOCAL)
DEST = $(TEXMFLOCAL)/tex/latex/avipackages
FILES = avi.cls avianim.sty avivoice.sty

.PHONY: test install uninstall
test:
	python3 $(DVIAVI_DIR)/tests/tex/run.py --root .

install:
	test -n "$(TEXMFLOCAL)"
	mkdir -p $(DEST)
	for f in $(FILES); do ln -sfn $(CURDIR)/tex/$$f $(DEST)/$$f; done
	mktexlsr $(TEXMFLOCAL)

uninstall:
	for f in $(FILES); do $(RM) $(DEST)/$$f; done
	rmdir $(DEST)
	mktexlsr $(TEXMFLOCAL)
