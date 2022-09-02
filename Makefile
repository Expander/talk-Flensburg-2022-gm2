all: talk.pdf

.PHONY: all clean distclean talk.pdf

clean:
	latexmk -C
	-rm -f *.nav *.snm *.run.xml

distclean: clean
	-rm -f talk.pdf

talk.pdf:
	latexmk -pdf talk.tex
