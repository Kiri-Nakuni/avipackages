# Daisy Bell: make (needs uplatex, and the dviavi repository next to this one,
# or DVIAVI_DIR=...)
DVIAVI_DIR ?= ../../../dviavi
DVIAVI ?= $(DVIAVI_DIR)/target/release/dviavi
export TEXINPUTS := ../../tex//:$(DVIAVI_DIR)/tex//:

daisy.avi: daisy.dvi daisy.mix
	$(DVIAVI) daisy.dvi

daisy.dvi: daisy.tex ../../tex/avivoice.sty
	uplatex -interaction=nonstopmode -halt-on-error daisy.tex

.PHONY: clean
clean:
	$(RM) daisy.aux daisy.log daisy.dvi daisy.avi
