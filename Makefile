###############################################################################
TARGET=astropy
###############################################################################

MYPOSTER=myposter

SAVEDIRS=img
A0=$(TARGET)_a0.pdf
A1=$(TARGET)_a1.pdf
A2=$(TARGET)_a2.pdf
A4=$(TARGET)_a4.pdf
LETTER=$(TARGET)_letter.ps
TIFFA0=$(TARGET)_a0.tiff
TIFFA1=$(TARGET)_a1.tiff
CUST=$(TARGET)_cust.ps

all: a2 a4

a0: $(A0)

a1: $(A1)

a2: $(A2)

a4: $(A4)

letter: $(LETTER)

cust: $(CUST)

.PHONY: all clean tiff tiffa0 tiffa1 tgz a0 a1 a2 a4

$(TARGET).dvi: $(TARGET).tex $(MYPOSTER).tex
	latex $(TARGET).tex
	latex $(TARGET).tex

$(A2): $(TARGET).dvi
	dvipdf -sPAPERSIZE=a2 $(TARGET).dvi $(A2)

$(CUST): $(TARGET).dvi
	dvips $(TARGET).dvi -o $(CUST)

$(A4): $(TARGET).dvi
	dvipdf -sPAPERSIZE=a4 $(TARGET).dvi $(A4)

$(A0): $(TARGET).dvi
	dvipdf -sPAPERSIZE=a0 $(TARGET).dvi $(A0)

$(A1): $(TARGET).dvi
	dvipdf -sPAPERSIZE=a1 $(TARGET).dvi $(A1)

tiff: tiffa0

tiffa0: $(A0)
	gs -sDEVICE=tiff24nc -sOutputFile=$(TIFFA0) -g4966x7021 \
	-q -dBATCH -dNOPAUSE -sPAPERSIZE=a0 -r150 $(A0)

tiffa1: $(A1)
	gs -sDEVICE=tiff24nc -sOutputFile=$(TIFFA1) -g3511x4966 \
	-q -dBATCH -dNOPAUSE -sPAPERSIZE=a1 -r150 $(A1)

clean:
	rm -f $(TARGET).aux $(TARGET).log $(TARGET).toc $(TARGET).dvi *.ps *.pdf

tgz:
	tar cvzf $(TARGET).tgz $(TARGET)* $(SAVEDIRS) Makefile $(MYPOSTER).tex
