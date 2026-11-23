# The tests need the dviavi repository (its dviavi.tex, the program and the
# test runner): next to this one, or DVIAVI_DIR=...
DVIAVI_DIR ?= ../dviavi

.PHONY: test
test:
	python3 $(DVIAVI_DIR)/tests/tex/run.py --root .
