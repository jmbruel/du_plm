#-----------------------------------------------------
MAIN=main
ICONSDIR=images/icons
IMAGESDIR=images
#STYLE=/Users/bruel/Dropbox/Public/dev/asciidoc/stylesheets/golo-jmb.css
#STYLE=/Users/bruel/dev/asciidoctor/asciidoctor-stylesheet-factory/stylesheets/jmb.css
#ASCIIDOC=asciidoc -a icons -a iconsdir=$(ICONSDIR) -a stylesheet=$(STYLE) -a imagesdir=$(IMAGESDIR) -a data-uri
#HIGHLIGHT=coderay
#HIGHLIGHT=highlightjs
#HIGHLIGHT=prettify
HIGHLIGHT=pygments
DOCTOR=asciidoctor -a data-uri -a icons=font -a images=$(IMAGESDIR) -a source-highlighter=$(HIGHLIGHT)
BACKENDS=/Users/bruel/localdev/asciidoctor-backends
DECKJS=$(BACKENDS)/haml/deckjs/
#DECKJS=$(BACKENDS)/haml/
#DECK=web-2.0
DECK=swiss
#DECK=neon
#DECK=beamer
EXT=asc
PANDOC=pandoc
OUTPUT=.
DEP=definitions.txt glossaire.txt refs.txt
SOURCEFILES = ./src/java/CodingDojo/src/*.java
DOC = doc
#-----------------------------------------------------

all: main.html

%.html: %.$(EXT) $(DEP)
	@echo '==> Compiling asciidoc files with Asciidoctor to generate HTML'
	$(DOCTOR) -a toc2 -b html5 -a numbered -a eleve -a linkcss! $<

%.deckjs.html: %.$(EXT)  $(DEP)
	@echo '==> Compiling asciidoc files to generate Deckjs'
	$(DOCTOR) -T $(DECKJS) -a slides -a linkcss! \
	-a data-uri -a deckjs_theme=$(DECK) \
	-a icons=font \
	-a images=$(IMAGESDIR) -a prof -o $@ $<

deploy:
	cp main.html index.html
	git commit -am "maj du cours au fur et à mesure"
	git co gh-pages
	git co master index.html
	git push
