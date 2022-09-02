all: talk.pdf

.PHONY: all clean distclean talk.pdf

clean:
	latexmk -C
	-rm -f *.nav *.snm

distclean: clean
	-rm -f talk.pdf

talk.pdf:
	latexmk -pdf talk.tex
